Return-Path: <linux-kernel+bounces-140855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 371088A1937
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1A5F1F219EA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853821384A9;
	Thu, 11 Apr 2024 15:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="M8lEnro2"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCEA137C56
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849663; cv=none; b=uMHlGr35fhMquAZ5SPF+52e3YxlBG9HR6Zxtthu+h6aC0cx/4HtXvgzY0cCFNQWeW9d3RlpS5gYXboizH5tt93fiMEPul+zSSm46tKJTM9LU5L7+Fwu4O5PoMyVlRUo74JR0KkOvk1XTbeSEPncgOQrUWjT+sDGBwJzaycVMgFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849663; c=relaxed/simple;
	bh=aY/MgJ8uxwheX0ipdCgKAXzopjZ3k/+prshcqHIYGmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ucm2d26t2XAetWNOMDI9bmiVCSKFATk5rPhKqcHiVklnCwEb20cO4goYx3OSUWK9K85vJTH1c3H/yjoohAOswHjmLmkjFUAqdRurzgAOHxIgQ8jKWGwF5+czOU/wGBrcxZLvfYsvlODM+DBLyb1NRo4TkJmcqcTsgkmijxNy17Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=M8lEnro2; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-36a34b68277so107945ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849660; x=1713454460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ac4jRR7YHnNbowsoWKJhsqnDyURss0PYYjAycMHVXE=;
        b=M8lEnro21ERYjR9r0ggY452Xm7lSj44uuvVso3//gKxr/oIv1LI90QefhcalsrUNed
         sPu4OrxCB5jSarsE0kbio+OsAf0BTuCwLFtCP4jpXsyvTQKyviHcM2/7tXWsTsjGGmaQ
         ZF+OfA5E1NDD79KpR1kuMnqzpSKLoFuUaA2MLwxBuc7XK8dYmF7RrQRcFuMinTaDi8Of
         EP17Yx3zIjeiz9FYzkMRkH1QZOeOV0YRNE5MR80C6ZzoUGT6mj+TeHh2xRKCDkJ//XGh
         2SO8Re9AxcTOrYBNh6xWTaikKqcITUnlOy9lpXARC5nipxQ4o74EtSJAKnLpBe37flzG
         OZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849660; x=1713454460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ac4jRR7YHnNbowsoWKJhsqnDyURss0PYYjAycMHVXE=;
        b=iYFsBBRUc1ndIuMHOFT2UKwqevxrJkHXQyVl54pr0NQqEBsk1+i6l0vzOrcnA44CW1
         +cA67FE2yRkiWwdAXuHazDzLSKZtqBQChOKfkBxDxjsjReQxYHdwmyJR983Oxo/FOI+d
         CDw2ssu2CHio1YiuRDpu++q+NNZWBhYOG6AAY6GRKt7aUoHIRyxpQnuV3V5KhuZPiPhC
         J44qShhDu6sdwoerTqewI0CyIny89RaX1AzMh+M6AIKPN5/QoENt95wtt01sJ9SROvYL
         Njo8ZIpHZAvAc+8vxJDsPhvmB4DsOfZ/IEmZIPc/SszZc2IV7oi8vm814R1/CrxWw0u2
         w19g==
X-Gm-Message-State: AOJu0Ywo0Ec0wNZbGK3YFmdnhU7B34U4+L5KDdEpucshCkU28xgJwthW
	YuIjM559Hx0EJUCb+prkyt0tyR+4sJu7mL093LBdE2EGASecyI8muDt/LBWpgazXlvhQmSZuCey
	C
X-Google-Smtp-Source: AGHT+IFwyKC5LeWDTF3gnvyhhH+rUx8qz0S3fVglmXssRjddSjaR9iV4I3yZ8eKswscmlku3f55rGg==
X-Received: by 2002:a05:6e02:1d99:b0:36a:38bf:5fb2 with SMTP id h25-20020a056e021d9900b0036a38bf5fb2mr7471831ila.2.1712849660591;
        Thu, 11 Apr 2024 08:34:20 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:34:19 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 093/437] integrity: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:53 -0600
Message-ID: <20240411153126.16201-94-axboe@kernel.dk>
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
 security/integrity/evm/evm_secfs.c | 60 +++++++++++++-----------------
 security/integrity/ima/ima_fs.c    | 41 ++++++++++----------
 2 files changed, 44 insertions(+), 57 deletions(-)

diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
index 9b907c2fee60..2ff3b5d04eae 100644
--- a/security/integrity/evm/evm_secfs.c
+++ b/security/integrity/evm/evm_secfs.c
@@ -29,50 +29,45 @@ static int evm_xattrs_locked;
 /**
  * evm_read_key - read() for <securityfs>/evm
  *
- * @filp: file pointer, not actually used
- * @buf: where to put the result
- * @count: maximum to send along
- * @ppos: where to start
+ * @iocb: metadata for IO
+ * @to: where to put the result
  *
  * Returns number of bytes read or error code, as appropriate
  */
-static ssize_t evm_read_key(struct file *filp, char __user *buf,
-			    size_t count, loff_t *ppos)
+static ssize_t evm_read_key(struct kiocb *iocb, struct iov_iter *to)
 {
 	char temp[80];
 	ssize_t rc;
 
-	if (*ppos != 0)
+	if (iocb->ki_pos != 0)
 		return 0;
 
 	sprintf(temp, "%d", (evm_initialized & ~EVM_SETUP_COMPLETE));
-	rc = simple_read_from_buffer(buf, count, ppos, temp, strlen(temp));
+	rc = simple_copy_to_iter(temp, &iocb->ki_pos, strlen(temp), to);
 
 	return rc;
 }
 
 /**
  * evm_write_key - write() for <securityfs>/evm
- * @file: file pointer, not actually used
- * @buf: where to get the data from
- * @count: bytes sent
- * @ppos: where to start
+ * @iocb: metadata for IO
+ * @from: where to get the data from
  *
  * Used to signal that key is on the kernel key ring.
  * - get the integrity hmac key from the kernel key ring
  * - create list of hmac protected extended attributes
  * Returns number of bytes written or error code, as appropriate
  */
-static ssize_t evm_write_key(struct file *file, const char __user *buf,
-			     size_t count, loff_t *ppos)
+static ssize_t evm_write_key(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	unsigned int i;
 	int ret;
 
 	if (!capable(CAP_SYS_ADMIN) || (evm_initialized & EVM_SETUP_COMPLETE))
 		return -EPERM;
 
-	ret = kstrtouint_from_user(buf, count, 0, &i);
+	ret = kstrtouint_from_iter(from, count, 0, &i);
 
 	if (ret)
 		return ret;
@@ -109,30 +104,27 @@ static ssize_t evm_write_key(struct file *file, const char __user *buf,
 }
 
 static const struct file_operations evm_key_ops = {
-	.read		= evm_read_key,
-	.write		= evm_write_key,
+	.read_iter	= evm_read_key,
+	.write_iter	= evm_write_key,
 };
 
 #ifdef CONFIG_EVM_ADD_XATTRS
 /**
  * evm_read_xattrs - read() for <securityfs>/evm_xattrs
  *
- * @filp: file pointer, not actually used
- * @buf: where to put the result
- * @count: maximum to send along
- * @ppos: where to start
+ * @iocb: metadata for IO
+ * @to: where to put the result
  *
  * Returns number of bytes read or error code, as appropriate
  */
-static ssize_t evm_read_xattrs(struct file *filp, char __user *buf,
-			       size_t count, loff_t *ppos)
+static ssize_t evm_read_xattrs(struct kiocb *iocb, struct iov_iter *to)
 {
 	char *temp;
 	int offset = 0;
 	ssize_t rc, size = 0;
 	struct xattr_list *xattr;
 
-	if (*ppos != 0)
+	if (iocb->ki_pos != 0)
 		return 0;
 
 	rc = mutex_lock_interruptible(&xattr_list_mutex);
@@ -161,7 +153,7 @@ static ssize_t evm_read_xattrs(struct file *filp, char __user *buf,
 	}
 
 	mutex_unlock(&xattr_list_mutex);
-	rc = simple_read_from_buffer(buf, count, ppos, temp, strlen(temp));
+	rc = simple_copy_to_iter(temp, &iocb->ki_pos, strlen(temp), to);
 
 	kfree(temp);
 
@@ -170,26 +162,24 @@ static ssize_t evm_read_xattrs(struct file *filp, char __user *buf,
 
 /**
  * evm_write_xattrs - write() for <securityfs>/evm_xattrs
- * @file: file pointer, not actually used
- * @buf: where to get the data from
- * @count: bytes sent
- * @ppos: where to start
+ * @iocb: metadata for IO
+ * @from: where to get the data from
  *
  * Returns number of bytes written or error code, as appropriate
  */
-static ssize_t evm_write_xattrs(struct file *file, const char __user *buf,
-				size_t count, loff_t *ppos)
+static ssize_t evm_write_xattrs(struct kiocb *iocb, struct iov_iter *from)
 {
 	int len, err;
 	struct xattr_list *xattr, *tmp;
 	struct audit_buffer *ab;
 	struct iattr newattrs;
 	struct inode *inode;
+	size_t count = iov_iter_count(from);
 
 	if (!capable(CAP_SYS_ADMIN) || evm_xattrs_locked)
 		return -EPERM;
 
-	if (*ppos != 0)
+	if (iocb->ki_pos != 0)
 		return -EINVAL;
 
 	if (count > XATTR_NAME_MAX)
@@ -207,7 +197,7 @@ static ssize_t evm_write_xattrs(struct file *file, const char __user *buf,
 	}
 
 	xattr->enabled = true;
-	xattr->name = memdup_user_nul(buf, count);
+	xattr->name = iterdup_nul(from, count);
 	if (IS_ERR(xattr->name)) {
 		err = PTR_ERR(xattr->name);
 		xattr->name = NULL;
@@ -278,8 +268,8 @@ static ssize_t evm_write_xattrs(struct file *file, const char __user *buf,
 }
 
 static const struct file_operations evm_xattr_ops = {
-	.read		= evm_read_xattrs,
-	.write		= evm_write_xattrs,
+	.read_iter	= evm_read_xattrs,
+	.write_iter	= evm_write_xattrs,
 };
 
 static int evm_init_xattrs(void)
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index cd1683dad3bf..e33896afec46 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -38,38 +38,35 @@ __setup("ima_canonical_fmt", default_canonical_fmt_setup);
 
 static int valid_policy = 1;
 
-static ssize_t ima_show_htable_value(char __user *buf, size_t count,
-				     loff_t *ppos, atomic_long_t *val)
+static ssize_t ima_show_htable_value(struct kiocb *iocb, struct iov_iter *to,
+				     atomic_long_t *val)
 {
 	char tmpbuf[32];	/* greater than largest 'long' string value */
 	ssize_t len;
 
 	len = scnprintf(tmpbuf, sizeof(tmpbuf), "%li\n", atomic_long_read(val));
-	return simple_read_from_buffer(buf, count, ppos, tmpbuf, len);
+	return simple_copy_to_iter(tmpbuf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t ima_show_htable_violations(struct file *filp,
-					  char __user *buf,
-					  size_t count, loff_t *ppos)
+static ssize_t ima_show_htable_violations(struct kiocb *iocb,
+					  struct iov_iter *to)
 {
-	return ima_show_htable_value(buf, count, ppos, &ima_htable.violations);
+	return ima_show_htable_value(iocb, to, &ima_htable.violations);
 }
 
 static const struct file_operations ima_htable_violations_ops = {
-	.read = ima_show_htable_violations,
+	.read_iter = ima_show_htable_violations,
 	.llseek = generic_file_llseek,
 };
 
-static ssize_t ima_show_measurements_count(struct file *filp,
-					   char __user *buf,
-					   size_t count, loff_t *ppos)
+static ssize_t ima_show_measurements_count(struct kiocb *iocb,
+					   struct iov_iter *to)
 {
-	return ima_show_htable_value(buf, count, ppos, &ima_htable.len);
-
+	return ima_show_htable_value(iocb, to, &ima_htable.len);
 }
 
 static const struct file_operations ima_measurements_count_ops = {
-	.read = ima_show_measurements_count,
+	.read_iter = ima_show_measurements_count,
 	.llseek = generic_file_llseek,
 };
 
@@ -200,7 +197,7 @@ static int ima_measurements_open(struct inode *inode, struct file *file)
 
 static const struct file_operations ima_measurements_ops = {
 	.open = ima_measurements_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = seq_release,
 };
@@ -266,7 +263,7 @@ static int ima_ascii_measurements_open(struct inode *inode, struct file *file)
 
 static const struct file_operations ima_ascii_measurements_ops = {
 	.open = ima_ascii_measurements_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = seq_release,
 };
@@ -311,9 +308,9 @@ static ssize_t ima_read_policy(char *path)
 		return pathlen;
 }
 
-static ssize_t ima_write_policy(struct file *file, const char __user *buf,
-				size_t datalen, loff_t *ppos)
+static ssize_t ima_write_policy(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t datalen = iov_iter_count(from);
 	char *data;
 	ssize_t result;
 
@@ -322,10 +319,10 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 
 	/* No partial writes. */
 	result = -EINVAL;
-	if (*ppos != 0)
+	if (iocb->ki_pos != 0)
 		goto out;
 
-	data = memdup_user_nul(buf, datalen);
+	data = iterdup_nul(from, datalen);
 	if (IS_ERR(data)) {
 		result = PTR_ERR(data);
 		goto out;
@@ -444,8 +441,8 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 
 static const struct file_operations ima_measure_policy_ops = {
 	.open = ima_open_policy,
-	.write = ima_write_policy,
-	.read = seq_read,
+	.write_iter = ima_write_policy,
+	.read_iter = seq_read_iter,
 	.release = ima_release_policy,
 	.llseek = generic_file_llseek,
 };
-- 
2.43.0


