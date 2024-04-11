Return-Path: <linux-kernel+bounces-140850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CD18A1932
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48CBC1F20626
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DE813775C;
	Thu, 11 Apr 2024 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="X5Vmv4QQ"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15C7136E26
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849654; cv=none; b=KVmVpXjtcai8+wlEwoiSFSPPT4gL6Xql/K5QMTpYnJ0x3gg2RE5A8bmzN8NOPIbPWa8RJLVJoCITuYXdvZPxtgcLz55w46sqceQ1cPuDXoWXMTRVx9zZqv2nIo5qDX5WnKsSPLzsfIpuUfpgNez6ptwqWTFL9yJWtKUZQedO9K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849654; c=relaxed/simple;
	bh=vvNPZK46dPG3arCNrGaSaksCGa8uZwyvXvzl36kVL48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IA0lz3P/bJkW6E6vTNozU6HHwGjqTKlTw3ucKAcPs4CvKMkt/w7Hm4AWhzncpZZhSW5KEro70DRLUy525K0MbQyzlQj9dv3KisbFdUR7+pBbvZJ7GmtPTXhp8llw+CVEST0cVPUF8FH8AFbTgB7DJClfPFUPa7KDcmAXk3Xuof8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=X5Vmv4QQ; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-36a34b68277so107685ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849651; x=1713454451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kPGdldjnOfDItHLYfoj66Arsy00RDPfU6udk+a+5L8M=;
        b=X5Vmv4QQS3VSyugUl4V3NjbQwDIOV22adzbj/X8SAF4Qznv3PctBRfQI3TA+f5jdUy
         Mr/ZlT7CYmv4P8jXSargxFHroHaV3YwI7iPrEC05ykP0XPQ9peu+tYmrzEVmEuE309zc
         9Dbz8yK/7Z6FsnZHhJTVNE1VQqYimKEc1Ua0hadWiMVqMmQh9ni6jqyjzNflDPNxK24b
         OnTQowFpVG4uG4hazZL3FWppFr0TCIP0tD3cwdNiabao4YVHMQzd3AxyUXW5tE9UtNid
         EqaTZyLnQmbgGPG9vE5bPSmMoy8c00JNR+xaFC0IXotR/GdmDFOGkZA4Ebdu8FKeiRx9
         i6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849651; x=1713454451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kPGdldjnOfDItHLYfoj66Arsy00RDPfU6udk+a+5L8M=;
        b=GE8busRUtLkaXBfIT6kK1WaKQ2Oj+mVvYpmvL2qU1CRVizdT0U5qtt1LKfKRrzaBO4
         JBsXr900qRzwvxjED+FzM/E4GjPTEImELjdjfSIiWvxK+VxVa9lUS5LrC0vNn9Ih4t3l
         LHKjQdGZNgkh0jQyhkfRDFqx76u4OVt9gzm+JnVPkrYEd8Lz1/WTpCR9U0kR0Wjs30EI
         ffYEe0EmrNKWF0+leCHc/JT4cdCCnXB9mXde3FPJEZNJb4zxzBjg/BjE3O8qJ1ympyLE
         NznhEKVIkZqoHwF6B+4sN0JyQ7355hPG7oLAZREdXwZje4OgDeoAodu/cMsqgoqscgXt
         vhYg==
X-Gm-Message-State: AOJu0Yyy0eELQqImObq9eP/3AkjHl2MY7MeNLTFvC4Fg9T4tpn76bLZK
	ATrnU3I0ysoz21CzjL/N9Cu5g8NKJB8QDtXlwkJ1n+xS8+oaV5AakABksjtuVx4UWYgSIURRlE/
	Z
X-Google-Smtp-Source: AGHT+IHnw22fVDCz0geeFrJRH0/3KzVh9R8GxaYKYHzIXgaRg0WSm6Qybh7bz1az6DaObJfeXCdDjw==
X-Received: by 2002:a05:6602:4ed7:b0:7d5:ddc8:504d with SMTP id gk23-20020a0566024ed700b007d5ddc8504dmr183655iob.0.1712849651281;
        Thu, 11 Apr 2024 08:34:11 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:34:09 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 088/437] smack: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:48 -0600
Message-ID: <20240411153126.16201-89-axboe@kernel.dk>
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
 security/smack/smackfs.c | 281 ++++++++++++++++++---------------------
 1 file changed, 132 insertions(+), 149 deletions(-)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index e22aad7604e8..49a380e45eb1 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -669,12 +669,13 @@ static ssize_t smk_write_load(struct file *file, const char __user *buf,
 	return smk_write_rules_list(file, buf, count, ppos, NULL, NULL,
 				    SMK_FIXED24_FMT);
 }
+FOPS_WRITE_ITER_HELPER(smk_write_load);
 
 static const struct file_operations smk_load_ops = {
 	.open           = smk_open_load,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek         = seq_lseek,
-	.write		= smk_write_load,
+	.write_iter	= smk_write_load_iter,
 	.release        = seq_release,
 };
 
@@ -964,12 +965,13 @@ static ssize_t smk_write_cipso(struct file *file, const char __user *buf,
 {
 	return smk_set_cipso(file, buf, count, ppos, SMK_FIXED24_FMT);
 }
+FOPS_WRITE_ITER_HELPER(smk_write_cipso);
 
 static const struct file_operations smk_cipso_ops = {
 	.open           = smk_open_cipso,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek         = seq_lseek,
-	.write		= smk_write_cipso,
+	.write_iter	= smk_write_cipso_iter,
 	.release        = seq_release,
 };
 
@@ -1038,12 +1040,13 @@ static ssize_t smk_write_cipso2(struct file *file, const char __user *buf,
 {
 	return smk_set_cipso(file, buf, count, ppos, SMK_LONG_FMT);
 }
+FOPS_WRITE_ITER_HELPER(smk_write_cipso2);
 
 static const struct file_operations smk_cipso2_ops = {
 	.open           = smk_open_cipso2,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek         = seq_lseek,
-	.write		= smk_write_cipso2,
+	.write_iter	= smk_write_cipso2_iter,
 	.release        = seq_release,
 };
 
@@ -1302,12 +1305,13 @@ static ssize_t smk_write_net4addr(struct file *file, const char __user *buf,
 
 	return rc;
 }
+FOPS_WRITE_ITER_HELPER(smk_write_net4addr);
 
 static const struct file_operations smk_net4addr_ops = {
 	.open           = smk_open_net4addr,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek         = seq_lseek,
-	.write		= smk_write_net4addr,
+	.write_iter	= smk_write_net4addr_iter,
 	.release        = seq_release,
 };
 
@@ -1559,52 +1563,48 @@ static ssize_t smk_write_net6addr(struct file *file, const char __user *buf,
 
 	return rc;
 }
+FOPS_WRITE_ITER_HELPER(smk_write_net6addr);
 
 static const struct file_operations smk_net6addr_ops = {
 	.open           = smk_open_net6addr,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek         = seq_lseek,
-	.write		= smk_write_net6addr,
+	.write_iter	= smk_write_net6addr_iter,
 	.release        = seq_release,
 };
 #endif /* CONFIG_IPV6 */
 
 /**
  * smk_read_doi - read() for /smack/doi
- * @filp: file pointer, not actually used
- * @buf: where to put the result
- * @count: maximum to send along
- * @ppos: where to start
+ * @iocb: metadata for IO
+ * @to: where to put the result
  *
  * Returns number of bytes read or error code, as appropriate
  */
-static ssize_t smk_read_doi(struct file *filp, char __user *buf,
-			    size_t count, loff_t *ppos)
+static ssize_t smk_read_doi(struct kiocb *iocb, struct iov_iter *to)
 {
 	char temp[80];
 	ssize_t rc;
 
-	if (*ppos != 0)
+	if (iocb->ki_pos != 0)
 		return 0;
 
 	sprintf(temp, "%d", smk_cipso_doi_value);
-	rc = simple_read_from_buffer(buf, count, ppos, temp, strlen(temp));
+	rc = simple_copy_to_iter(temp, &iocb->ki_pos, strlen(temp), to);
 
 	return rc;
 }
 
 /**
  * smk_write_doi - write() for /smack/doi
- * @file: file pointer, not actually used
- * @buf: where to get the data from
- * @count: bytes sent
- * @ppos: where to start
+ * @iocb: metadata for IO
+ * @from: where to get the data from
  *
  * Returns number of bytes written or error code, as appropriate
  */
-static ssize_t smk_write_doi(struct file *file, const char __user *buf,
-			     size_t count, loff_t *ppos)
+static ssize_t smk_write_doi(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	char temp[80];
 	int i;
 
@@ -1614,7 +1614,7 @@ static ssize_t smk_write_doi(struct file *file, const char __user *buf,
 	if (count >= sizeof(temp) || count == 0)
 		return -EINVAL;
 
-	if (copy_from_user(temp, buf, count) != 0)
+	if (!copy_from_iter(temp, count, from))
 		return -EFAULT;
 
 	temp[count] = '\0';
@@ -1630,47 +1630,42 @@ static ssize_t smk_write_doi(struct file *file, const char __user *buf,
 }
 
 static const struct file_operations smk_doi_ops = {
-	.read		= smk_read_doi,
-	.write		= smk_write_doi,
+	.read_iter	= smk_read_doi,
+	.write_iter	= smk_write_doi,
 	.llseek		= default_llseek,
 };
 
 /**
  * smk_read_direct - read() for /smack/direct
- * @filp: file pointer, not actually used
- * @buf: where to put the result
- * @count: maximum to send along
- * @ppos: where to start
+ * @iocb: metadata for IO
+ * @to: where to put the result
  *
  * Returns number of bytes read or error code, as appropriate
  */
-static ssize_t smk_read_direct(struct file *filp, char __user *buf,
-			       size_t count, loff_t *ppos)
+static ssize_t smk_read_direct(struct kiocb *iocb, struct iov_iter *to)
 {
 	char temp[80];
 	ssize_t rc;
 
-	if (*ppos != 0)
+	if (iocb->ki_pos != 0)
 		return 0;
 
 	sprintf(temp, "%d", smack_cipso_direct);
-	rc = simple_read_from_buffer(buf, count, ppos, temp, strlen(temp));
+	rc = simple_copy_to_iter(temp, &iocb->ki_pos, strlen(temp), to);
 
 	return rc;
 }
 
 /**
  * smk_write_direct - write() for /smack/direct
- * @file: file pointer, not actually used
- * @buf: where to get the data from
- * @count: bytes sent
- * @ppos: where to start
+ * @iocb: metadata for IO
+ * @from: where to get the data from
  *
  * Returns number of bytes written or error code, as appropriate
  */
-static ssize_t smk_write_direct(struct file *file, const char __user *buf,
-				size_t count, loff_t *ppos)
+static ssize_t smk_write_direct(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	struct smack_known *skp;
 	char temp[80];
 	int i;
@@ -1681,7 +1676,7 @@ static ssize_t smk_write_direct(struct file *file, const char __user *buf,
 	if (count >= sizeof(temp) || count == 0)
 		return -EINVAL;
 
-	if (copy_from_user(temp, buf, count) != 0)
+	if (!copy_from_iter(temp, count, from))
 		return -EFAULT;
 
 	temp[count] = '\0';
@@ -1708,47 +1703,42 @@ static ssize_t smk_write_direct(struct file *file, const char __user *buf,
 }
 
 static const struct file_operations smk_direct_ops = {
-	.read		= smk_read_direct,
-	.write		= smk_write_direct,
+	.read_iter	= smk_read_direct,
+	.write_iter	= smk_write_direct,
 	.llseek		= default_llseek,
 };
 
 /**
  * smk_read_mapped - read() for /smack/mapped
- * @filp: file pointer, not actually used
- * @buf: where to put the result
- * @count: maximum to send along
- * @ppos: where to start
+ * @iocb: metadata for IO
+ * @to: where to put the result
  *
  * Returns number of bytes read or error code, as appropriate
  */
-static ssize_t smk_read_mapped(struct file *filp, char __user *buf,
-			       size_t count, loff_t *ppos)
+static ssize_t smk_read_mapped(struct kiocb *iocb, struct iov_iter *to)
 {
 	char temp[80];
 	ssize_t rc;
 
-	if (*ppos != 0)
+	if (iocb->ki_pos != 0)
 		return 0;
 
 	sprintf(temp, "%d", smack_cipso_mapped);
-	rc = simple_read_from_buffer(buf, count, ppos, temp, strlen(temp));
+	rc = simple_copy_to_iter(temp, &iocb->ki_pos, strlen(temp), to);
 
 	return rc;
 }
 
 /**
  * smk_write_mapped - write() for /smack/mapped
- * @file: file pointer, not actually used
- * @buf: where to get the data from
- * @count: bytes sent
- * @ppos: where to start
+ * @iocb: metadata for IO
+ * @from: where to get the data from
  *
  * Returns number of bytes written or error code, as appropriate
  */
-static ssize_t smk_write_mapped(struct file *file, const char __user *buf,
-				size_t count, loff_t *ppos)
+static ssize_t smk_write_mapped(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	struct smack_known *skp;
 	char temp[80];
 	int i;
@@ -1759,7 +1749,7 @@ static ssize_t smk_write_mapped(struct file *file, const char __user *buf,
 	if (count >= sizeof(temp) || count == 0)
 		return -EINVAL;
 
-	if (copy_from_user(temp, buf, count) != 0)
+	if (!copy_from_iter(temp, count, from))
 		return -EFAULT;
 
 	temp[count] = '\0';
@@ -1786,27 +1776,25 @@ static ssize_t smk_write_mapped(struct file *file, const char __user *buf,
 }
 
 static const struct file_operations smk_mapped_ops = {
-	.read		= smk_read_mapped,
-	.write		= smk_write_mapped,
+	.read_iter	= smk_read_mapped,
+	.write_iter	= smk_write_mapped,
 	.llseek		= default_llseek,
 };
 
 /**
  * smk_read_ambient - read() for /smack/ambient
- * @filp: file pointer, not actually used
- * @buf: where to put the result
- * @cn: maximum to send along
- * @ppos: where to start
+ * @iocb: metadata for IO
+ * @to: where to put the result
  *
  * Returns number of bytes read or error code, as appropriate
  */
-static ssize_t smk_read_ambient(struct file *filp, char __user *buf,
-				size_t cn, loff_t *ppos)
+static ssize_t smk_read_ambient(struct kiocb *iocb, struct iov_iter *to)
 {
+	size_t cn = iov_iter_count(to);
 	ssize_t rc;
 	int asize;
 
-	if (*ppos != 0)
+	if (iocb->ki_pos != 0)
 		return 0;
 	/*
 	 * Being careful to avoid a problem in the case where
@@ -1817,9 +1805,8 @@ static ssize_t smk_read_ambient(struct file *filp, char __user *buf,
 	asize = strlen(smack_net_ambient->smk_known) + 1;
 
 	if (cn >= asize)
-		rc = simple_read_from_buffer(buf, cn, ppos,
-					     smack_net_ambient->smk_known,
-					     asize);
+		rc = simple_copy_to_iter(smack_net_ambient->smk_known,
+					 &iocb->ki_pos, asize, to);
 	else
 		rc = -EINVAL;
 
@@ -1874,10 +1861,11 @@ static ssize_t smk_write_ambient(struct file *file, const char __user *buf,
 	kfree(data);
 	return rc;
 }
+FOPS_WRITE_ITER_HELPER(smk_write_ambient);
 
 static const struct file_operations smk_ambient_ops = {
-	.read		= smk_read_ambient,
-	.write		= smk_write_ambient,
+	.read_iter	= smk_read_ambient,
+	.write_iter	= smk_write_ambient_iter,
 	.llseek		= default_llseek,
 };
 
@@ -2054,11 +2042,12 @@ static ssize_t smk_write_onlycap(struct file *file, const char __user *buf,
 
 	return rc;
 }
+FOPS_WRITE_ITER_HELPER(smk_write_onlycap);
 
 static const struct file_operations smk_onlycap_ops = {
 	.open		= smk_open_onlycap,
-	.read		= seq_read,
-	.write		= smk_write_onlycap,
+	.read_iter	= seq_read_iter,
+	.write_iter	= smk_write_onlycap_iter,
 	.llseek		= seq_lseek,
 	.release	= seq_release,
 };
@@ -2066,21 +2055,19 @@ static const struct file_operations smk_onlycap_ops = {
 #ifdef CONFIG_SECURITY_SMACK_BRINGUP
 /**
  * smk_read_unconfined - read() for smackfs/unconfined
- * @filp: file pointer, not actually used
- * @buf: where to put the result
- * @cn: maximum to send along
- * @ppos: where to start
+ * @iocb: metadata for IO
+ * @to: where to put the result
  *
  * Returns number of bytes read or error code, as appropriate
  */
-static ssize_t smk_read_unconfined(struct file *filp, char __user *buf,
-					size_t cn, loff_t *ppos)
+static ssize_t smk_read_unconfined(struct kiocb *iocb, struct iov_iter *to)
 {
+	size_t cn = iov_iter_count(to);
 	char *smack = "";
 	ssize_t rc = -EINVAL;
 	int asize;
 
-	if (*ppos != 0)
+	if (iocb->ki_pos != 0)
 		return 0;
 
 	if (smack_unconfined != NULL)
@@ -2089,7 +2076,7 @@ static ssize_t smk_read_unconfined(struct file *filp, char __user *buf,
 	asize = strlen(smack) + 1;
 
 	if (cn >= asize)
-		rc = simple_read_from_buffer(buf, cn, ppos, smack, asize);
+		rc = simple_copy_to_iter(smack, &iocb->ki_pos, asize, to);
 
 	return rc;
 }
@@ -2143,49 +2130,45 @@ static ssize_t smk_write_unconfined(struct file *file, const char __user *buf,
 	kfree(data);
 	return rc;
 }
+FOPS_WRITE_ITER_HELPER(smk_write_unconfined);
 
 static const struct file_operations smk_unconfined_ops = {
-	.read		= smk_read_unconfined,
-	.write		= smk_write_unconfined,
+	.read_iter	= smk_read_unconfined,
+	.write_iter	= smk_write_unconfined_iter,
 	.llseek		= default_llseek,
 };
 #endif /* CONFIG_SECURITY_SMACK_BRINGUP */
 
 /**
  * smk_read_logging - read() for /smack/logging
- * @filp: file pointer, not actually used
- * @buf: where to put the result
- * @count: maximum to send along
- * @ppos: where to start
+ * @iocb: metadata for IO
+ * @to: where to put the result
  *
  * Returns number of bytes read or error code, as appropriate
  */
-static ssize_t smk_read_logging(struct file *filp, char __user *buf,
-				size_t count, loff_t *ppos)
+static ssize_t smk_read_logging(struct kiocb *iocb, struct iov_iter *to)
 {
 	char temp[32];
 	ssize_t rc;
 
-	if (*ppos != 0)
+	if (iocb->ki_pos != 0)
 		return 0;
 
 	sprintf(temp, "%d\n", log_policy);
-	rc = simple_read_from_buffer(buf, count, ppos, temp, strlen(temp));
+	rc = simple_copy_to_iter(temp, &iocb->ki_pos, strlen(temp), to);
 	return rc;
 }
 
 /**
  * smk_write_logging - write() for /smack/logging
- * @file: file pointer, not actually used
- * @buf: where to get the data from
- * @count: bytes sent
- * @ppos: where to start
+ * @iocb: metadata for IO
+ * @from: where to get the data from
  *
  * Returns number of bytes written or error code, as appropriate
  */
-static ssize_t smk_write_logging(struct file *file, const char __user *buf,
-				size_t count, loff_t *ppos)
+static ssize_t smk_write_logging(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	char temp[32];
 	int i;
 
@@ -2195,7 +2178,7 @@ static ssize_t smk_write_logging(struct file *file, const char __user *buf,
 	if (count >= sizeof(temp) || count == 0)
 		return -EINVAL;
 
-	if (copy_from_user(temp, buf, count) != 0)
+	if (!copy_from_iter(temp, count, from))
 		return -EFAULT;
 
 	temp[count] = '\0';
@@ -2208,11 +2191,9 @@ static ssize_t smk_write_logging(struct file *file, const char __user *buf,
 	return count;
 }
 
-
-
 static const struct file_operations smk_logging_ops = {
-	.read		= smk_read_logging,
-	.write		= smk_write_logging,
+	.read_iter	= smk_read_logging,
+	.write_iter	= smk_write_logging,
 	.llseek		= default_llseek,
 };
 
@@ -2281,12 +2262,13 @@ static ssize_t smk_write_load_self(struct file *file, const char __user *buf,
 	return smk_write_rules_list(file, buf, count, ppos, &tsp->smk_rules,
 				    &tsp->smk_rules_lock, SMK_FIXED24_FMT);
 }
+FOPS_WRITE_ITER_HELPER(smk_write_load_self);
 
 static const struct file_operations smk_load_self_ops = {
 	.open           = smk_open_load_self,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek         = seq_lseek,
-	.write		= smk_write_load_self,
+	.write_iter	= smk_write_load_self_iter,
 	.release        = seq_release,
 };
 
@@ -2351,10 +2333,11 @@ static ssize_t smk_write_access(struct file *file, const char __user *buf,
 {
 	return smk_user_access(file, buf, count, ppos, SMK_FIXED24_FMT);
 }
+FOPS_WRITE_ITER_HELPER(smk_write_access);
 
 static const struct file_operations smk_access_ops = {
-	.write		= smk_write_access,
-	.read		= simple_transaction_read,
+	.write_iter	= smk_write_access_iter,
+	.read_iter	= simple_transaction_read_iter,
 	.release	= simple_transaction_release,
 	.llseek		= generic_file_llseek,
 };
@@ -2416,12 +2399,13 @@ static ssize_t smk_write_load2(struct file *file, const char __user *buf,
 	return smk_write_rules_list(file, buf, count, ppos, NULL, NULL,
 				    SMK_LONG_FMT);
 }
+FOPS_WRITE_ITER_HELPER(smk_write_load2);
 
 static const struct file_operations smk_load2_ops = {
 	.open           = smk_open_load2,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek         = seq_lseek,
-	.write		= smk_write_load2,
+	.write_iter	= smk_write_load2_iter,
 	.release        = seq_release,
 };
 
@@ -2489,12 +2473,13 @@ static ssize_t smk_write_load_self2(struct file *file, const char __user *buf,
 	return smk_write_rules_list(file, buf, count, ppos, &tsp->smk_rules,
 				    &tsp->smk_rules_lock, SMK_LONG_FMT);
 }
+FOPS_WRITE_ITER_HELPER(smk_write_load_self2);
 
 static const struct file_operations smk_load_self2_ops = {
 	.open           = smk_open_load_self2,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek         = seq_lseek,
-	.write		= smk_write_load_self2,
+	.write_iter	= smk_write_load_self2_iter,
 	.release        = seq_release,
 };
 
@@ -2510,10 +2495,11 @@ static ssize_t smk_write_access2(struct file *file, const char __user *buf,
 {
 	return smk_user_access(file, buf, count, ppos, SMK_LONG_FMT);
 }
+FOPS_WRITE_ITER_HELPER(smk_write_access2);
 
 static const struct file_operations smk_access2_ops = {
-	.write		= smk_write_access2,
-	.read		= simple_transaction_read,
+	.write_iter	= smk_write_access2_iter,
+	.read_iter	= simple_transaction_read_iter,
 	.release	= simple_transaction_release,
 	.llseek		= generic_file_llseek,
 };
@@ -2576,10 +2562,11 @@ static ssize_t smk_write_revoke_subj(struct file *file, const char __user *buf,
 
 	return rc;
 }
+FOPS_WRITE_ITER_HELPER(smk_write_revoke_subj);
 
 static const struct file_operations smk_revoke_subj_ops = {
-	.write		= smk_write_revoke_subj,
-	.read		= simple_transaction_read,
+	.write_iter	= smk_write_revoke_subj_iter,
+	.read_iter	= simple_transaction_read_iter,
 	.release	= simple_transaction_release,
 	.llseek		= generic_file_llseek,
 };
@@ -2612,31 +2599,30 @@ static ssize_t smk_write_change_rule(struct file *file, const char __user *buf,
 	return smk_write_rules_list(file, buf, count, ppos, NULL, NULL,
 				    SMK_CHANGE_FMT);
 }
+FOPS_WRITE_ITER_HELPER(smk_write_change_rule);
 
 static const struct file_operations smk_change_rule_ops = {
-	.write		= smk_write_change_rule,
-	.read		= simple_transaction_read,
+	.write_iter	= smk_write_change_rule_iter,
+	.read_iter	= simple_transaction_read_iter,
 	.release	= simple_transaction_release,
 	.llseek		= generic_file_llseek,
 };
 
 /**
  * smk_read_syslog - read() for smackfs/syslog
- * @filp: file pointer, not actually used
- * @buf: where to put the result
- * @cn: maximum to send along
- * @ppos: where to start
+ * @iocb: metadata for IO
+ * @to: where to put the result
  *
  * Returns number of bytes read or error code, as appropriate
  */
-static ssize_t smk_read_syslog(struct file *filp, char __user *buf,
-				size_t cn, loff_t *ppos)
+static ssize_t smk_read_syslog(struct kiocb *iocb, struct iov_iter *to)
 {
+	size_t cn = iov_iter_count(to);
 	struct smack_known *skp;
 	ssize_t rc = -EINVAL;
 	int asize;
 
-	if (*ppos != 0)
+	if (iocb->ki_pos != 0)
 		return 0;
 
 	if (smack_syslog_label == NULL)
@@ -2647,8 +2633,8 @@ static ssize_t smk_read_syslog(struct file *filp, char __user *buf,
 	asize = strlen(skp->smk_known) + 1;
 
 	if (cn >= asize)
-		rc = simple_read_from_buffer(buf, cn, ppos, skp->smk_known,
-						asize);
+		rc = simple_copy_to_iter(skp->smk_known, &iocb->ki_pos, asize,
+					 to);
 
 	return rc;
 }
@@ -2689,10 +2675,11 @@ static ssize_t smk_write_syslog(struct file *file, const char __user *buf,
 	kfree(data);
 	return rc;
 }
+FOPS_WRITE_ITER_HELPER(smk_write_syslog);
 
 static const struct file_operations smk_syslog_ops = {
-	.read		= smk_read_syslog,
-	.write		= smk_write_syslog,
+	.read_iter	= smk_read_syslog,
+	.write_iter	= smk_write_syslog_iter,
 	.llseek		= default_llseek,
 };
 
@@ -2802,58 +2789,54 @@ static ssize_t smk_write_relabel_self(struct file *file, const char __user *buf,
 	smk_destroy_label_list(&list_tmp);
 	return rc;
 }
+FOPS_WRITE_ITER_HELPER(smk_write_relabel_self);
 
 static const struct file_operations smk_relabel_self_ops = {
 	.open		= smk_open_relabel_self,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
-	.write		= smk_write_relabel_self,
+	.write_iter	= smk_write_relabel_self_iter,
 	.release	= seq_release,
 };
 
 /**
  * smk_read_ptrace - read() for /smack/ptrace
- * @filp: file pointer, not actually used
- * @buf: where to put the result
- * @count: maximum to send along
- * @ppos: where to start
+ * @iocb: metadata for IO
+ * @to: where to put the result
  *
  * Returns number of bytes read or error code, as appropriate
  */
-static ssize_t smk_read_ptrace(struct file *filp, char __user *buf,
-			       size_t count, loff_t *ppos)
+static ssize_t smk_read_ptrace(struct kiocb *iocb, struct iov_iter *to)
 {
 	char temp[32];
 	ssize_t rc;
 
-	if (*ppos != 0)
+	if (iocb->ki_pos != 0)
 		return 0;
 
 	sprintf(temp, "%d\n", smack_ptrace_rule);
-	rc = simple_read_from_buffer(buf, count, ppos, temp, strlen(temp));
+	rc = simple_copy_to_iter(temp, &iocb->ki_pos, strlen(temp), to);
 	return rc;
 }
 
 /**
  * smk_write_ptrace - write() for /smack/ptrace
- * @file: file pointer
- * @buf: data from user space
- * @count: bytes sent
- * @ppos: where to start - must be 0
+ * @iocb: metadata for IO
+ * @to: data from user space
  */
-static ssize_t smk_write_ptrace(struct file *file, const char __user *buf,
-				size_t count, loff_t *ppos)
+static ssize_t smk_write_ptrace(struct kiocb *iocb, struct iov_iter *to)
 {
+	size_t count = iov_iter_count(to);
 	char temp[32];
 	int i;
 
 	if (!smack_privileged(CAP_MAC_ADMIN))
 		return -EPERM;
 
-	if (*ppos != 0 || count >= sizeof(temp) || count == 0)
+	if (iocb->ki_pos != 0 || count >= sizeof(temp) || count == 0)
 		return -EINVAL;
 
-	if (copy_from_user(temp, buf, count) != 0)
+	if (!copy_from_iter(temp, count, to))
 		return -EFAULT;
 
 	temp[count] = '\0';
@@ -2868,8 +2851,8 @@ static ssize_t smk_write_ptrace(struct file *file, const char __user *buf,
 }
 
 static const struct file_operations smk_ptrace_ops = {
-	.write		= smk_write_ptrace,
-	.read		= smk_read_ptrace,
+	.write_iter	= smk_write_ptrace,
+	.read_iter	= smk_read_ptrace,
 	.llseek		= default_llseek,
 };
 
-- 
2.43.0


