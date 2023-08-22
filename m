Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7ECC78402E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235529AbjHVLzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235511AbjHVLzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:55:32 -0400
Received: from forwardcorp1c.mail.yandex.net (forwardcorp1c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:df01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E97E7E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 04:55:07 -0700 (PDT)
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:6284:0:640:e19:0])
        by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 2FD7F6025B;
        Tue, 22 Aug 2023 14:55:05 +0300 (MSK)
Received: from valesini-ubuntu.yandex.net (unknown [2a02:6b8:82:604:f7ab:b25b:2f4e:2225])
        by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id usHYCO1OfGk0-8KlOOY66;
        Tue, 22 Aug 2023 14:55:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1692705304; bh=Vi48MveDdAJaRZh1oBp7hBFV9uDod6uoeDC5f274xnU=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=PHBPZdmPYI7OV58JdJfrdlUnP1kvnC42+eWaoLePWOVPiFTkfMzMK193CXW7V+mG3
         FqpIqrXIHspJxvyqa8byLoImEJRVaXUuZpskO6iSZCtXeXlvkBO4/vg0AA/tu5AVLR
         rUhoNI4n0EPPdDFul9qx7FaPxmc2R6PFI3u2o7aA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From:   Valentine Sinitsyn <valesini@yandex-team.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] PCI: Implement custom llseek for sysfs resource entries
Date:   Tue, 22 Aug 2023 16:54:55 +0500
Message-Id: <20230822115455.310222-2-valesini@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822075107.224512-2-valesini@yandex-team.ru>
References: <20230822075107.224512-2-valesini@yandex-team.ru>
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
 drivers/pci/pci-sysfs.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index ab32a91f287b..2b9d93f11dd1 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -836,6 +836,12 @@ static const struct attribute_group pci_dev_config_attr_group = {
 };
 
 #ifdef HAVE_PCI_LEGACY
+
+static loff_t pci_llseek_resource(struct file *filep,
+				  struct kobject *kobj,
+				  struct bin_attribute *attr,
+				  loff_t offset, int whence);
+
 /**
  * pci_read_legacy_io - read byte(s) from legacy I/O port space
  * @filp: open sysfs file
@@ -967,6 +973,8 @@ void pci_create_legacy_files(struct pci_bus *b)
 	b->legacy_io->attr.mode = 0600;
 	b->legacy_io->read = pci_read_legacy_io;
 	b->legacy_io->write = pci_write_legacy_io;
+	/* See pci_create_attr() for motivation */
+	b->legacy_io->llseek = pci_llseek_resource;
 	b->legacy_io->mmap = pci_mmap_legacy_io;
 	b->legacy_io->f_mapping = iomem_get_mapping;
 	pci_adjust_legacy_attr(b, pci_mmap_io);
@@ -981,6 +989,8 @@ void pci_create_legacy_files(struct pci_bus *b)
 	b->legacy_mem->size = 1024*1024;
 	b->legacy_mem->attr.mode = 0600;
 	b->legacy_mem->mmap = pci_mmap_legacy_mem;
+	/* See pci_create_attr() for motivation */
+	b->legacy_io->llseek = pci_llseek_resource;
 	b->legacy_mem->f_mapping = iomem_get_mapping;
 	pci_adjust_legacy_attr(b, pci_mmap_mem);
 	error = device_create_bin_file(&b->dev, b->legacy_mem);
@@ -1138,6 +1148,14 @@ static ssize_t pci_write_resource_io(struct file *filp, struct kobject *kobj,
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
@@ -1195,8 +1213,15 @@ static int pci_create_attr(struct pci_dev *pdev, int num, int write_combine)
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
-- 
2.34.1

