Return-Path: <linux-kernel+bounces-140854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B528A1936
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B3201F22058
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF46136E26;
	Thu, 11 Apr 2024 15:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="tGk40WNh"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3FD13793D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849661; cv=none; b=d+PTW1EVSyGaSPQkoZAVmGQo+WZxX70qDNBFygZFVksH0IhKhNFhN2sELcQ4gbENt5grABEtQn6va65KkwU9zJFaAzBOHT3TUdN+fy7u4bD/tgrD3GgJIvQLDVweI7a+cMs64jX9/t2UNpBffr8ZDuLuGuH2AoCYwrkechcdfFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849661; c=relaxed/simple;
	bh=r1/EmfadIXBPtF/PbthOkhVSG2zjLkQozSjjQYm+N74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hg3Rs6m+TGSw1LnBc6J+AgbhUIMbDzUkR5H06R8gJpPgP1VMSLdw7CNqDbxKq9aeNTPraaE4ibhS1rTKdZKLHNEq/2uS12XDX//SuVT9afOR87UHWUsMvl/e/C1k/1oaT2QRpJNNvDim/5Le2IwwNlT8VMQWUIRVedDpdRODzQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=tGk40WNh; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170476539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849659; x=1713454459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=344vDvRj1E3f29ijyUwPcE9cn5GRABlXopO92FUIh1g=;
        b=tGk40WNhd6Wh1xVLl5635F36ZyeMpU7eqvxgzCYTF+txt4HMVOzZe/JOb0j9Jr2V0t
         6Izntzy31wRo+hNKytRLJAILswJ/nhbRsU2TpviBA95wB1CUx1IBGAIEvZqnHJqWmG4Y
         jKD5dqAaWVKQ6xNcO/HImz2Gw5FASShGoonTaYk0WxWyBzGYqTaXAmsNz8TA4738vKDo
         uxfVTb0I+p/PTqDCKhc7D7DfLwPmyYDvYto5X2TwR7OHEUtCQxXXVQi2/hKAB+tPIctW
         8LgeVT98CdSytTBiNZbhfZcsheXMAUxEwsBm6sD4UIEVb0poyrXqD4RnkGUHv/b8bpjq
         tv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849659; x=1713454459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=344vDvRj1E3f29ijyUwPcE9cn5GRABlXopO92FUIh1g=;
        b=MlWs5WDXjF1Eo2p5yjfCYWKpShcHMJqHAJvImRuLPY8hLZc0xsEA8WbiRcBPwOq+1b
         fZVM0qRxYiLy9ZailvqA6LUTq3xcxA6Gx8VUAzjTot5ryl7Pdp8M4MDHbKxdMRIIl9G+
         h2rvnL+771nYAL4y4fun+6Gv9Esfo5hQ189qqdHgo12B67YJ+tCRSXGgnmm0qSdggpS+
         Flp055Ql94k22Qj5BEXjUzSYo2Wu95812e8gtlLYlFpwtCBuQrFhZxQYZgFSmfAhe5gn
         RsLBt9ri9TLx2J4aIDRrtklovPXgZcqNhM8E9cvkcbhUofsBR3XT0lo0cuqv+p5j2mK6
         KUQA==
X-Gm-Message-State: AOJu0Yy6+07dE+t07LrsmqCsinWrT6I1+TsO3CqXwjPkFPGCDZ3hx8MP
	kNSzik86tgW5P6R8W4PWgBvcunrAbW9nxgh+ee83NBoQ5+/QMB+38yix0DbC/WCTNhZKLkyt2Uc
	u
X-Google-Smtp-Source: AGHT+IGckC3SHf4+1g0lt0Gxm3biABp2+KWcPBTnB3Xc222s2O+pAPfzyaxA/KZ7LYzfHt8Dyd5lGA==
X-Received: by 2002:a05:6602:21d7:b0:7d6:9ddf:5095 with SMTP id c23-20020a05660221d700b007d69ddf5095mr9786ioc.1.1712849658757;
        Thu, 11 Apr 2024 08:34:18 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:34:17 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 092/437] selinux: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:52 -0600
Message-ID: <20240411153126.16201-93-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411153126.16201-1-axboe@kernel.dk>
References: <20240411153126.16201-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 security/selinux/selinuxfs.c | 168 +++++++++++++++++------------------
 1 file changed, 82 insertions(+), 86 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 074d6c2714eb..9ac5bcf5edc4 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -120,15 +120,14 @@ static void selinux_fs_info_free(struct super_block *sb)
 #define POLICYCAP_DIR_NAME "policy_capabilities"
 
 #define TMPBUFLEN	12
-static ssize_t sel_read_enforce(struct file *filp, char __user *buf,
-				size_t count, loff_t *ppos)
+static ssize_t sel_read_enforce(struct kiocb *iocb, struct iov_iter *to)
 {
 	char tmpbuf[TMPBUFLEN];
 	ssize_t length;
 
 	length = scnprintf(tmpbuf, TMPBUFLEN, "%d",
 			   enforcing_enabled());
-	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
+	return simple_copy_to_iter(tmpbuf, &iocb->ki_pos, length, to);
 }
 
 #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
@@ -186,32 +185,32 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
 	kfree(page);
 	return length;
 }
+FOPS_WRITE_ITER_HELPER(sel_write_enforce);
 #else
-#define sel_write_enforce NULL
+#define sel_write_enforce_iter NULL
 #endif
 
 static const struct file_operations sel_enforce_ops = {
-	.read		= sel_read_enforce,
-	.write		= sel_write_enforce,
+	.read_iter	= sel_read_enforce,
+	.write_iter	= sel_write_enforce_iter,
 	.llseek		= generic_file_llseek,
 };
 
-static ssize_t sel_read_handle_unknown(struct file *filp, char __user *buf,
-					size_t count, loff_t *ppos)
+static ssize_t sel_read_handle_unknown(struct kiocb *iocb, struct iov_iter *to)
 {
 	char tmpbuf[TMPBUFLEN];
 	ssize_t length;
-	ino_t ino = file_inode(filp)->i_ino;
+	ino_t ino = file_inode(iocb->ki_filp)->i_ino;
 	int handle_unknown = (ino == SEL_REJECT_UNKNOWN) ?
 		security_get_reject_unknown() :
 		!security_get_allow_unknown();
 
 	length = scnprintf(tmpbuf, TMPBUFLEN, "%d", handle_unknown);
-	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
+	return simple_copy_to_iter(tmpbuf, &iocb->ki_pos, length, to);
 }
 
 static const struct file_operations sel_handle_unknown_ops = {
-	.read		= sel_read_handle_unknown,
+	.read_iter	= sel_read_handle_unknown,
 	.llseek		= generic_file_llseek,
 };
 
@@ -227,16 +226,14 @@ static int sel_open_handle_status(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-static ssize_t sel_read_handle_status(struct file *filp, char __user *buf,
-				      size_t count, loff_t *ppos)
+static ssize_t sel_read_handle_status(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct page    *status = filp->private_data;
+	struct page    *status = iocb->ki_filp->private_data;
 
 	BUG_ON(!status);
 
-	return simple_read_from_buffer(buf, count, ppos,
-				       page_address(status),
-				       sizeof(struct selinux_kernel_status));
+	return simple_copy_to_iter(page_address(status), &iocb->ki_pos,
+				       sizeof(struct selinux_kernel_status), to);
 }
 
 static int sel_mmap_handle_status(struct file *filp,
@@ -263,7 +260,7 @@ static int sel_mmap_handle_status(struct file *filp,
 
 static const struct file_operations sel_handle_status_ops = {
 	.open		= sel_open_handle_status,
-	.read		= sel_read_handle_status,
+	.read_iter	= sel_read_handle_status,
 	.mmap		= sel_mmap_handle_status,
 	.llseek		= generic_file_llseek,
 };
@@ -302,24 +299,24 @@ static ssize_t sel_write_disable(struct file *file, const char __user *buf,
 	kfree(page);
 	return length;
 }
+FOPS_WRITE_ITER_HELPER(sel_write_disable);
 
 static const struct file_operations sel_disable_ops = {
-	.write		= sel_write_disable,
+	.write_iter	= sel_write_disable_iter,
 	.llseek		= generic_file_llseek,
 };
 
-static ssize_t sel_read_policyvers(struct file *filp, char __user *buf,
-				   size_t count, loff_t *ppos)
+static ssize_t sel_read_policyvers(struct kiocb *iocb, struct iov_iter *to)
 {
 	char tmpbuf[TMPBUFLEN];
 	ssize_t length;
 
 	length = scnprintf(tmpbuf, TMPBUFLEN, "%u", POLICYDB_VERSION_MAX);
-	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
+	return simple_copy_to_iter(tmpbuf, &iocb->ki_pos, length, to);
 }
 
 static const struct file_operations sel_policyvers_ops = {
-	.read		= sel_read_policyvers,
+	.read_iter	= sel_read_policyvers,
 	.llseek		= generic_file_llseek,
 };
 
@@ -339,19 +336,18 @@ static struct dentry *sel_make_dir(struct dentry *dir, const char *name,
 static struct dentry *sel_make_swapover_dir(struct super_block *sb,
 						unsigned long *ino);
 
-static ssize_t sel_read_mls(struct file *filp, char __user *buf,
-				size_t count, loff_t *ppos)
+static ssize_t sel_read_mls(struct kiocb *iocb, struct iov_iter *to)
 {
 	char tmpbuf[TMPBUFLEN];
 	ssize_t length;
 
 	length = scnprintf(tmpbuf, TMPBUFLEN, "%d",
 			   security_mls_enabled());
-	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
+	return simple_copy_to_iter(tmpbuf, &iocb->ki_pos, length, to);
 }
 
 static const struct file_operations sel_mls_ops = {
-	.read		= sel_read_mls,
+	.read_iter	= sel_read_mls,
 	.llseek		= generic_file_llseek,
 };
 
@@ -425,10 +421,9 @@ static int sel_release_policy(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-static ssize_t sel_read_policy(struct file *filp, char __user *buf,
-			       size_t count, loff_t *ppos)
+static ssize_t sel_read_policy(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct policy_load_memory *plm = filp->private_data;
+	struct policy_load_memory *plm = iocb->ki_filp->private_data;
 	int ret;
 
 	ret = avc_has_perm(current_sid(), SECINITSID_SECURITY,
@@ -436,7 +431,7 @@ static ssize_t sel_read_policy(struct file *filp, char __user *buf,
 	if (ret)
 		return ret;
 
-	return simple_read_from_buffer(buf, count, ppos, plm->data, plm->len);
+	return simple_copy_to_iter(plm->data, &iocb->ki_pos, plm->len, to);
 }
 
 static vm_fault_t sel_mmap_policy_fault(struct vm_fault *vmf)
@@ -483,7 +478,7 @@ static int sel_mmap_policy(struct file *filp, struct vm_area_struct *vma)
 
 static const struct file_operations sel_policy_ops = {
 	.open		= sel_open_policy,
-	.read		= sel_read_policy,
+	.read_iter	= sel_read_policy,
 	.mmap		= sel_mmap_policy,
 	.release	= sel_release_policy,
 	.llseek		= generic_file_llseek,
@@ -567,12 +562,13 @@ static int sel_make_policy_nodes(struct selinux_fs_info *fsi,
 	return ret;
 }
 
-static ssize_t sel_write_load(struct file *file, const char __user *buf,
-			      size_t count, loff_t *ppos)
+static ssize_t sel_write_load(struct kiocb *iocb, struct iov_iter *from)
 
 {
+	struct file *file = iocb->ki_filp;
 	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
 	struct selinux_load_state load_state;
+	size_t count = iov_iter_count(from);
 	ssize_t length;
 	void *data = NULL;
 
@@ -585,7 +581,7 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 
 	/* No partial writes. */
 	length = -EINVAL;
-	if (*ppos != 0)
+	if (iocb->ki_pos != 0)
 		goto out;
 
 	length = -ENOMEM;
@@ -594,7 +590,7 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 		goto out;
 
 	length = -EFAULT;
-	if (copy_from_user(data, buf, count) != 0)
+	if (!copy_from_iter_full(data, count, from))
 		goto out;
 
 	length = security_load_policy(data, count, &load_state);
@@ -625,7 +621,7 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 }
 
 static const struct file_operations sel_load_ops = {
-	.write		= sel_write_load,
+	.write_iter	= sel_write_load,
 	.llseek		= generic_file_llseek,
 };
 
@@ -662,15 +658,14 @@ static ssize_t sel_write_context(struct file *file, char *buf, size_t size)
 	return length;
 }
 
-static ssize_t sel_read_checkreqprot(struct file *filp, char __user *buf,
-				     size_t count, loff_t *ppos)
+static ssize_t sel_read_checkreqprot(struct kiocb *iocb, struct iov_iter *to)
 {
 	char tmpbuf[TMPBUFLEN];
 	ssize_t length;
 
 	length = scnprintf(tmpbuf, TMPBUFLEN, "%u",
 			   checkreqprot_get());
-	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
+	return simple_copy_to_iter(tmpbuf, &iocb->ki_pos, length, to);
 }
 
 static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
@@ -717,9 +712,11 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
 	kfree(page);
 	return length;
 }
+FOPS_WRITE_ITER_HELPER(sel_write_checkreqprot);
+
 static const struct file_operations sel_checkreqprot_ops = {
-	.read		= sel_read_checkreqprot,
-	.write		= sel_write_checkreqprot,
+	.read_iter	= sel_read_checkreqprot,
+	.write_iter	= sel_write_checkreqprot_iter,
 	.llseek		= generic_file_llseek,
 };
 
@@ -793,9 +790,10 @@ static ssize_t sel_write_validatetrans(struct file *file,
 	kfree(taskcon);
 	return rc;
 }
+FOPS_WRITE_ITER_HELPER(sel_write_validatetrans);
 
 static const struct file_operations sel_transition_ops = {
-	.write		= sel_write_validatetrans,
+	.write_iter	= sel_write_validatetrans_iter,
 	.llseek		= generic_file_llseek,
 };
 
@@ -837,10 +835,11 @@ static ssize_t selinux_transaction_write(struct file *file, const char __user *b
 	}
 	return rv;
 }
+FOPS_WRITE_ITER_HELPER(selinux_transaction_write);
 
 static const struct file_operations transaction_ops = {
-	.write		= selinux_transaction_write,
-	.read		= simple_transaction_read,
+	.write_iter	= selinux_transaction_write_iter,
+	.read_iter	= simple_transaction_read_iter,
 	.release	= simple_transaction_release,
 	.llseek		= generic_file_llseek,
 };
@@ -1192,9 +1191,9 @@ static struct inode *sel_make_inode(struct super_block *sb, umode_t mode)
 	return ret;
 }
 
-static ssize_t sel_read_bool(struct file *filep, char __user *buf,
-			     size_t count, loff_t *ppos)
+static ssize_t sel_read_bool(struct kiocb *iocb, struct iov_iter *to)
 {
+	struct file *filep = iocb->ki_filp;
 	struct selinux_fs_info *fsi = file_inode(filep)->i_sb->s_fs_info;
 	char *page = NULL;
 	ssize_t length;
@@ -1223,7 +1222,7 @@ static ssize_t sel_read_bool(struct file *filep, char __user *buf,
 	length = scnprintf(page, PAGE_SIZE, "%d %d", cur_enforcing,
 			  fsi->bool_pending_values[index]);
 	mutex_unlock(&selinux_state.policy_mutex);
-	ret = simple_read_from_buffer(buf, count, ppos, page, length);
+	ret = simple_copy_to_iter(page, &iocb->ki_pos, length, to);
 out_free:
 	free_page((unsigned long)page);
 	return ret;
@@ -1282,10 +1281,11 @@ static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
 	kfree(page);
 	return length;
 }
+FOPS_WRITE_ITER_HELPER(sel_write_bool);
 
 static const struct file_operations sel_bool_ops = {
-	.read		= sel_read_bool,
-	.write		= sel_write_bool,
+	.read_iter	= sel_read_bool,
+	.write_iter	= sel_write_bool_iter,
 	.llseek		= generic_file_llseek,
 };
 
@@ -1334,9 +1334,10 @@ static ssize_t sel_commit_bools_write(struct file *filep,
 	kfree(page);
 	return length;
 }
+FOPS_WRITE_ITER_HELPER(sel_commit_bools_write);
 
 static const struct file_operations sel_commit_bools_ops = {
-	.write		= sel_commit_bools_write,
+	.write_iter	= sel_commit_bools_write_iter,
 	.llseek		= generic_file_llseek,
 };
 
@@ -1404,15 +1405,15 @@ static int sel_make_bools(struct selinux_policy *newpolicy, struct dentry *bool_
 	return ret;
 }
 
-static ssize_t sel_read_avc_cache_threshold(struct file *filp, char __user *buf,
-					    size_t count, loff_t *ppos)
+static ssize_t sel_read_avc_cache_threshold(struct kiocb *iocb,
+					    struct iov_iter *to)
 {
 	char tmpbuf[TMPBUFLEN];
 	ssize_t length;
 
 	length = scnprintf(tmpbuf, TMPBUFLEN, "%u",
 			   avc_get_cache_threshold());
-	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
+	return simple_copy_to_iter(tmpbuf, &iocb->ki_pos, length, to);
 }
 
 static ssize_t sel_write_avc_cache_threshold(struct file *file,
@@ -1452,9 +1453,9 @@ static ssize_t sel_write_avc_cache_threshold(struct file *file,
 	kfree(page);
 	return ret;
 }
+FOPS_WRITE_ITER_HELPER(sel_write_avc_cache_threshold);
 
-static ssize_t sel_read_avc_hash_stats(struct file *filp, char __user *buf,
-				       size_t count, loff_t *ppos)
+static ssize_t sel_read_avc_hash_stats(struct kiocb *iocb, struct iov_iter *to)
 {
 	char *page;
 	ssize_t length;
@@ -1465,14 +1466,14 @@ static ssize_t sel_read_avc_hash_stats(struct file *filp, char __user *buf,
 
 	length = avc_get_hash_stats(page);
 	if (length >= 0)
-		length = simple_read_from_buffer(buf, count, ppos, page, length);
+		length = simple_copy_to_iter(page, &iocb->ki_pos, length, to);
 	free_page((unsigned long)page);
 
 	return length;
 }
 
-static ssize_t sel_read_sidtab_hash_stats(struct file *filp, char __user *buf,
-					size_t count, loff_t *ppos)
+static ssize_t sel_read_sidtab_hash_stats(struct kiocb *iocb,
+					  struct iov_iter *to)
 {
 	char *page;
 	ssize_t length;
@@ -1483,26 +1484,25 @@ static ssize_t sel_read_sidtab_hash_stats(struct file *filp, char __user *buf,
 
 	length = security_sidtab_hash_stats(page);
 	if (length >= 0)
-		length = simple_read_from_buffer(buf, count, ppos, page,
-						length);
+		length = simple_copy_to_iter(page, &iocb->ki_pos, length, to);
 	free_page((unsigned long)page);
 
 	return length;
 }
 
 static const struct file_operations sel_sidtab_hash_stats_ops = {
-	.read		= sel_read_sidtab_hash_stats,
+	.read_iter	= sel_read_sidtab_hash_stats,
 	.llseek		= generic_file_llseek,
 };
 
 static const struct file_operations sel_avc_cache_threshold_ops = {
-	.read		= sel_read_avc_cache_threshold,
-	.write		= sel_write_avc_cache_threshold,
+	.read_iter	= sel_read_avc_cache_threshold,
+	.write_iter	= sel_write_avc_cache_threshold_iter,
 	.llseek		= generic_file_llseek,
 };
 
 static const struct file_operations sel_avc_hash_stats_ops = {
-	.read		= sel_read_avc_hash_stats,
+	.read_iter	= sel_read_avc_hash_stats,
 	.llseek		= generic_file_llseek,
 };
 
@@ -1571,7 +1571,7 @@ static int sel_open_avc_cache_stats(struct inode *inode, struct file *file)
 
 static const struct file_operations sel_avc_cache_stats_ops = {
 	.open		= sel_open_avc_cache_stats,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= seq_release,
 };
@@ -1644,25 +1644,24 @@ static int sel_make_ss_files(struct dentry *dir)
 	return 0;
 }
 
-static ssize_t sel_read_initcon(struct file *file, char __user *buf,
-				size_t count, loff_t *ppos)
+static ssize_t sel_read_initcon(struct kiocb *iocb, struct iov_iter *to)
 {
 	char *con;
 	u32 sid, len;
 	ssize_t ret;
 
-	sid = file_inode(file)->i_ino&SEL_INO_MASK;
+	sid = file_inode(iocb->ki_filp)->i_ino&SEL_INO_MASK;
 	ret = security_sid_to_context(sid, &con, &len);
 	if (ret)
 		return ret;
 
-	ret = simple_read_from_buffer(buf, count, ppos, con, len);
+	ret = simple_copy_to_iter(con, &iocb->ki_pos, len, to);
 	kfree(con);
 	return ret;
 }
 
 static const struct file_operations sel_initcon_ops = {
-	.read		= sel_read_initcon,
+	.read_iter	= sel_read_initcon,
 	.llseek		= generic_file_llseek,
 };
 
@@ -1715,50 +1714,47 @@ static inline u32 sel_ino_to_perm(unsigned long ino)
 	return (ino & SEL_INO_MASK) % (SEL_VEC_MAX + 1);
 }
 
-static ssize_t sel_read_class(struct file *file, char __user *buf,
-				size_t count, loff_t *ppos)
+static ssize_t sel_read_class(struct kiocb *iocb, struct iov_iter *to)
 {
-	unsigned long ino = file_inode(file)->i_ino;
+	unsigned long ino = file_inode(iocb->ki_filp)->i_ino;
 	char res[TMPBUFLEN];
 	ssize_t len = scnprintf(res, sizeof(res), "%d", sel_ino_to_class(ino));
-	return simple_read_from_buffer(buf, count, ppos, res, len);
+	return simple_copy_to_iter(res, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations sel_class_ops = {
-	.read		= sel_read_class,
+	.read_iter	= sel_read_class,
 	.llseek		= generic_file_llseek,
 };
 
-static ssize_t sel_read_perm(struct file *file, char __user *buf,
-				size_t count, loff_t *ppos)
+static ssize_t sel_read_perm(struct kiocb *iocb, struct iov_iter *to)
 {
-	unsigned long ino = file_inode(file)->i_ino;
+	unsigned long ino = file_inode(iocb->ki_filp)->i_ino;
 	char res[TMPBUFLEN];
 	ssize_t len = scnprintf(res, sizeof(res), "%d", sel_ino_to_perm(ino));
-	return simple_read_from_buffer(buf, count, ppos, res, len);
+	return simple_copy_to_iter(res, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations sel_perm_ops = {
-	.read		= sel_read_perm,
+	.read_iter	= sel_read_perm,
 	.llseek		= generic_file_llseek,
 };
 
-static ssize_t sel_read_policycap(struct file *file, char __user *buf,
-				  size_t count, loff_t *ppos)
+static ssize_t sel_read_policycap(struct kiocb *iocb, struct iov_iter *to)
 {
 	int value;
 	char tmpbuf[TMPBUFLEN];
 	ssize_t length;
-	unsigned long i_ino = file_inode(file)->i_ino;
+	unsigned long i_ino = file_inode(iocb->ki_filp)->i_ino;
 
 	value = security_policycap_supported(i_ino & SEL_INO_MASK);
 	length = scnprintf(tmpbuf, TMPBUFLEN, "%d", value);
 
-	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
+	return simple_copy_to_iter(tmpbuf, &iocb->ki_pos, length, to);
 }
 
 static const struct file_operations sel_policycap_ops = {
-	.read		= sel_read_policycap,
+	.read_iter	= sel_read_policycap,
 	.llseek		= generic_file_llseek,
 };
 
-- 
2.43.0


