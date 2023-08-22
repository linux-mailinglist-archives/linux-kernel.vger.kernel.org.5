Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57637783B26
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbjHVHvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbjHVHv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:51:27 -0400
Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [178.154.239.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D14193
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 00:51:23 -0700 (PDT)
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:5429:0:640:6285:0])
        by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 8135E614D7;
        Tue, 22 Aug 2023 10:51:17 +0300 (MSK)
Received: from valesini-ubuntu.yandex.net (unknown [2a02:6b8:82:604:8dca:a63b:d2a:5bd0])
        by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 7pD3pL1Ol4Y0-YI44VZ8Z;
        Tue, 22 Aug 2023 10:51:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1692690676; bh=FT8y30aTzpKmPQpUtUnXMiLpp2fBD0nxSgtx6IGpHN4=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=kpPm8DwQnSPK2XUHRp29mescqOhzX1aHOk1y0UrKh05qGRETrCQZ1Bbu9ui31Q1kX
         nN+QPsZv9R7woY299HAmZGz0lcnIkztArS5ypDGE6rhjVU90EXy+UtV4TELw+SPsqg
         rfpx9+X82ELTg7UNtsPtMn4lkTonr62KliDUbIaE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From:   Valentine Sinitsyn <valesini@yandex-team.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] PCI: Implement custom llseek for sysfs resource entries
Date:   Tue, 22 Aug 2023 12:51:07 +0500
Message-Id: <20230822075107.224512-2-valesini@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821195501.GA367249@bhelgaas>
References: <20230821195501.GA367249@bhelgaas>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 636b21b50152 ("PCI: Revoke mappings like devmem"), mmappable
sysfs entries have started to receive their f_mapping from the iomem
pseudo filesystem, so that CONFIG_IO_STRICT_DEVMEM is honored in sysfs
(and procfs) as well as in /dev/[k]mem.

This resulted in a userspace-visible regression:

1. Open a sysfs PCI resource file (eg. /sys/bus/pci/devices/*/resource0)
2. Use lseek(fd, 0, SEEK_END) to determine its size

Expected result: a PCI region size is returned.
Actual result: 0 is returned.

The reason is that PCI resource files residing in sysfs use
generic_file_llseek(), which relies on f_mapping->host inode to get the
file size. As f_mapping is now redefined, f_mapping->host points to an
anonymous zero-sized iomem_inode which has nothing to do with sysfs file
in question.

Implement a custom llseek method for sysfs PCI resources, which is
almost the same as proc_bus_pci_lseek() used for procfs entries.

This makes sysfs and procfs entries consistent with regards to seeking,
but also introduces userspace-visible changes to seeking PCI resources
in sysfs:

- SEEK_DATA and SEEK_HOLE are no longer supported;
- Seeking past the end of the file is prohibited while previously
  offsets up to MAX_NON_LFS were accepted (reading from these offsets
  was always invalid).

Fixes: 636b21b50152 ("PCI: Revoke mappings like devmem")
Cc: stable@vger.kernel.org
Signed-off-by: Valentine Sinitsyn <valesini@yandex-team.ru>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci-sysfs.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index ab32a91f287b..42eaeb8d4a4f 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -967,6 +967,8 @@ void pci_create_legacy_files(struct pci_bus *b)
 	b->legacy_io->attr.mode = 0600;
 	b->legacy_io->read = pci_read_legacy_io;
 	b->legacy_io->write = pci_write_legacy_io;
+	/* See pci_create_attr() for motivation */
+	b->legacy_io->llseek = pci_llseek_resource;
 	b->legacy_io->mmap = pci_mmap_legacy_io;
 	b->legacy_io->f_mapping = iomem_get_mapping;
 	pci_adjust_legacy_attr(b, pci_mmap_io);
@@ -981,6 +983,8 @@ void pci_create_legacy_files(struct pci_bus *b)
 	b->legacy_mem->size = 1024*1024;
 	b->legacy_mem->attr.mode = 0600;
 	b->legacy_mem->mmap = pci_mmap_legacy_mem;
+	/* See pci_create_attr() for motivation */
+	b->legacy_io->llseek = pci_llseek_resource;
 	b->legacy_mem->f_mapping = iomem_get_mapping;
 	pci_adjust_legacy_attr(b, pci_mmap_mem);
 	error = device_create_bin_file(&b->dev, b->legacy_mem);
@@ -1138,6 +1142,14 @@ static ssize_t pci_write_resource_io(struct file *filp, struct kobject *kobj,
 	return pci_resource_io(filp, kobj, attr, buf, off, count, true);
 }
 
+static loff_t pci_llseek_resource(struct file *filep,
+				  struct kobject *kobj __always_unused,
+				  struct bin_attribute *attr,
+				  loff_t offset, int whence)
+{
+	return fixed_size_llseek(filep, offset, whence, attr->size);
+}
+
 /**
  * pci_remove_resource_files - cleanup resource files
  * @pdev: dev to cleanup
@@ -1195,8 +1207,15 @@ static int pci_create_attr(struct pci_dev *pdev, int num, int write_combine)
 			res_attr->mmap = pci_mmap_resource_uc;
 		}
 	}
-	if (res_attr->mmap)
+	if (res_attr->mmap) {
 		res_attr->f_mapping = iomem_get_mapping;
+		/*
+		 * generic_file_llseek() consults f_mapping->host to determine
+		 * the file size. As iomem_inode knows nothing about the
+		 * attribute, it's not going to work, so override it as well.
+		 */
+		res_attr->llseek = pci_llseek_resource;
+	}
 	res_attr->attr.name = res_attr_name;
 	res_attr->attr.mode = 0600;
 	res_attr->size = pci_resource_len(pdev, num);

prerequisite-patch-id: 955ac8520d17a30dc71166fa7f1d25c09cbab46e
-- 
2.34.1

