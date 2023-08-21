Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EEC782477
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 09:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbjHUHaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 03:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbjHUHaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 03:30:14 -0400
Received: from forwardcorp1c.mail.yandex.net (forwardcorp1c.mail.yandex.net [178.154.239.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792B6B6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 00:30:11 -0700 (PDT)
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:5429:0:640:6285:0])
        by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 6D26E5E6BE;
        Mon, 21 Aug 2023 10:30:05 +0300 (MSK)
Received: from valesini-ubuntu.yandex-team.ru (unknown [2a02:6b8:b081:7312::1:31])
        by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id uTCwF71Of8c0-976LX69U;
        Mon, 21 Aug 2023 10:30:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1692603004; bh=DJaH3A5t5e+Bk6YUQHv45kuwi51htfBi86y/OHxvLlY=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=bj9/ez/mnVk1YNyP37NHkkwPTAXBw0yvBSbCk6peGGrtIOsrex7c9kdJx/p5/bp/P
         po2sAVkiMxz693Gr9nlnomEMoWsgPxjIIG+C5KNa14eoV0nSGBEFwy9Zn9za3MKg0z
         eXwBaiKdOMWKBd6shuufTE+fKG1jInool2po9Utc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From:   Valentine Sinitsyn <valesini@yandex-team.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2 1/2] kernfs: sysfs: support custom llseek method for sysfs entries
Date:   Mon, 21 Aug 2023 12:29:55 +0500
Message-Id: <20230821072956.114193-1-valesini@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <8d48c4aa-1bf7-3b25-99fa-3dd76cec070e@yandex-team.ru>
References: <8d48c4aa-1bf7-3b25-99fa-3dd76cec070e@yandex-team.ru>
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

As of now, seeking in sysfs files is handled by generic_file_llseek().
There are situations where one may want to customize seeking logic:

- Many sysfs entries are fixed files while generic_file_llseek() accepts
  past-the-end positions. Not only being useless by itself, this
  also means a bug in userspace code will trigger not at lseek(), but at
  some later point making debugging harder.
- generic_file_llseek() relies on f_mapping->host to get the file size
  which might not be correct for all sysfs entries.
  See commit 636b21b50152 ("PCI: Revoke mappings like devmem") as an example.

Implement llseek method to override this behavior at sysfs attribute
level. The method is optional, and if it is absent,
generic_file_llseek() is called to preserve backwards compatibility.

Cc: stable@vger.kernel.org
Signed-off-by: Valentine Sinitsyn <valesini@yandex-team.ru>
---
Looks like the patch didn't get to lkml, resending

 fs/kernfs/file.c       | 14 +++++++++++++-
 fs/sysfs/file.c        | 13 +++++++++++++
 include/linux/kernfs.h |  1 +
 include/linux/sysfs.h  |  2 ++
 4 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 180906c36f51..6166bf74d5b8 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -903,6 +903,18 @@ static __poll_t kernfs_fop_poll(struct file *filp, poll_table *wait)
 	return ret;
 }

+static loff_t kernfs_fop_llseek(struct file *file, loff_t offset, int whence)
+{
+	struct kernfs_open_file *of = kernfs_of(file);
+	const struct kernfs_ops *ops;
+
+	ops = kernfs_ops(of->kn);
+	if (ops->llseek)
+		return ops->llseek(of, offset, whence);
+	else
+		return generic_file_llseek(file, offset, whence);
+}
+
 static void kernfs_notify_workfn(struct work_struct *work)
 {
 	struct kernfs_node *kn;
@@ -1005,7 +1017,7 @@ EXPORT_SYMBOL_GPL(kernfs_notify);
 const struct file_operations kernfs_file_fops = {
 	.read_iter	= kernfs_fop_read_iter,
 	.write_iter	= kernfs_fop_write_iter,
-	.llseek		= generic_file_llseek,
+	.llseek		= kernfs_fop_llseek,
 	.mmap		= kernfs_fop_mmap,
 	.open		= kernfs_fop_open,
 	.release	= kernfs_fop_release,
diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index a12ac0356c69..6b7652fb8050 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -167,6 +167,18 @@ static int sysfs_kf_bin_mmap(struct kernfs_open_file *of,
 	return battr->mmap(of->file, kobj, battr, vma);
 }
 
+static loff_t sysfs_kf_bin_llseek(struct kernfs_open_file *of, loff_t offset,
+				  int whence)
+{
+	struct bin_attribute *battr = of->kn->priv;
+	struct kobject *kobj = of->kn->parent->priv;
+
+	if (battr->llseek)
+		return battr->llseek(of->file, kobj, battr, offset, whence);
+	else
+		return generic_file_llseek(of->file, offset, whence);
+}
+
 static int sysfs_kf_bin_open(struct kernfs_open_file *of)
 {
 	struct bin_attribute *battr = of->kn->priv;
@@ -249,6 +261,7 @@ static const struct kernfs_ops sysfs_bin_kfops_mmap = {
 	.write		= sysfs_kf_bin_write,
 	.mmap		= sysfs_kf_bin_mmap,
 	.open		= sysfs_kf_bin_open,
+	.llseek		= sysfs_kf_bin_llseek,
 };
 
 int sysfs_add_file_mode_ns(struct kernfs_node *parent,
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 73f5c120def8..9ed535930259 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -316,6 +316,7 @@ struct kernfs_ops {
 			 struct poll_table_struct *pt);
 
 	int (*mmap)(struct kernfs_open_file *of, struct vm_area_struct *vma);
+	loff_t (*llseek)(struct kernfs_open_file *of, loff_t offset, int whence);
 };
 
 /*
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index fd3fe5c8c17f..b717a70219f6 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -181,6 +181,8 @@ struct bin_attribute {
 			char *, loff_t, size_t);
 	ssize_t (*write)(struct file *, struct kobject *, struct bin_attribute *,
 			 char *, loff_t, size_t);
+	loff_t (*llseek)(struct file *, struct kobject *, struct bin_attribute *,
+			 loff_t, int);
 	int (*mmap)(struct file *, struct kobject *, struct bin_attribute *attr,
 		    struct vm_area_struct *vma);
 };
-- 
2.34.1

