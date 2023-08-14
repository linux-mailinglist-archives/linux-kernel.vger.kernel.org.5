Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6780E77C06A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 21:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjHNTKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 15:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjHNTKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:10:46 -0400
X-Greylist: delayed 90 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Aug 2023 12:10:44 PDT
Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [178.154.239.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA4F110
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:10:44 -0700 (PDT)
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:6284:0:640:e19:0])
        by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 5EED260BB4;
        Mon, 14 Aug 2023 22:09:02 +0300 (MSK)
Received: from valesini-ubuntu.yandex-team.ru (unknown [2a02:6b8:b081:6424::1:1c])
        by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id p8khZn1Oj8c0-x4t7Ckt5;
        Mon, 14 Aug 2023 22:09:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1692040141; bh=ZyPCXqX2lykhT+7mqHlYrDnf3I7xwz8nDZ44w4vuYQ0=;
        h=Message-Id:Date:Cc:Subject:To:From;
        b=hcVIy71J07WF/Nh5oM6kNbgOSuhOEQqtyxxoFA7fX8eideFZXShOTVMvwAcjFmMhy
         KZu7hVouFQHw+VMiSRg1BGCvWoIb7VcOzzXBdKHOpLFb6FHexsairI+qYxN9Ee86yM
         abrq5U7Gl7CcU0dRaSn+Vfag/EXmy0WLG3HWmBGc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From:   Valentine Sinitsyn <valesini@yandex-team.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kernfs: implement custom llseek method to fix userspace regression
Date:   Tue, 15 Aug 2023 00:08:50 +0500
Message-Id: <20230814190850.948032-1-valesini@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 636b21b50152 ("PCI: Revoke mappings like devmem"),
mmapable sysfs binary attributes have started receiving their
f_mapping from the iomem pseudo filesystem, so that
CONFIG_IO_STRICT_DEVMEM is honored in sysfs (and procfs) as well
as in /dev/[k]mem.

This resulted in a userspace-visible regression: lseek(fd, 0, SEEK_END)
now returns zero regardless the real sysfs attribute size which stat()
reports. The reason is that kernfs files use generic_file_llseek()
implementation, which relies on f_mapping->host inode to get the file
size. As f_mapping is now redefined, f_mapping->host points to an
anonymous zero-sized iomem inode which has nothing to do with sysfs
attribute or kernfs file representing it. This being said, f_inode
remains valid, so stat() which uses it works correctly.

Fixes the regression by implementing a custom llseek fop for kernfs,
which uses an attribute's file inode to get the file size,
just as stat() does.

Fixes: 636b21b50152 ("PCI: Revoke mappings like devmem")
Cc: stable@vger.kernel.org
Signed-off-by: Valentine Sinitsyn <valesini@yandex-team.ru>
---
 fs/kernfs/file.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 180906c36f51..6d81e0c981f3 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -903,6 +903,21 @@ static __poll_t kernfs_fop_poll(struct file *filp, poll_table *wait)
 	return ret;
 }
 
+static loff_t kernfs_fop_llseek(struct file *file, loff_t offset, int whence)
+{
+	/*
+	 * This is almost identical to generic_file_llseek() except it uses
+	 * cached inode value instead of f_mapping->host.
+	 * The reason is that, for PCI resources in sysfs the latter points to
+	 * iomem_inode whose size has nothing to do with the attribute's size.
+	 */
+	struct inode *inode = file_inode(file);
+
+	return generic_file_llseek_size(file, offset, whence,
+					inode->i_sb->s_maxbytes,
+					i_size_read(inode));
+}
+
 static void kernfs_notify_workfn(struct work_struct *work)
 {
 	struct kernfs_node *kn;
@@ -1005,7 +1020,7 @@ EXPORT_SYMBOL_GPL(kernfs_notify);
 const struct file_operations kernfs_file_fops = {
 	.read_iter	= kernfs_fop_read_iter,
 	.write_iter	= kernfs_fop_write_iter,
-	.llseek		= generic_file_llseek,
+	.llseek		= kernfs_fop_llseek,
 	.mmap		= kernfs_fop_mmap,
 	.open		= kernfs_fop_open,
 	.release	= kernfs_fop_release,
-- 
2.34.1

