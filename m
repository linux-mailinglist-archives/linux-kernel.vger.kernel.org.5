Return-Path: <linux-kernel+bounces-141060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 515258A1A45
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCEBB1F22D4B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D32D1D29EB;
	Thu, 11 Apr 2024 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KT8+WxK/"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14DB1D214F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849976; cv=none; b=VMJYwctq8944LJUwaBBGdDzydF1oXk3+hz2gTFFWudyZFlmjyYTbBLHhYmqdqW7Ef4JCZYtvEOyaE5RRxkl5S6/ZUFRWHcQK1NohYyW50psXB4GNl44liJ5PmB4ADwq0taSk8Ae2cb3nOJQXxAESk3CX3R3lbTjsSJQ0Cyk5X6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849976; c=relaxed/simple;
	bh=bSyPTnaqBqw4Xs8QnICt+Ts5wtEFukOjwG63LhUNraA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tAxtvq0PUYM7Ttw2rSfK7YOUWanYImykniq/yqDG2Su/xeIM7+NQvEGYdAHpLwW9h4po/0adEYlQZkNzFm6dPjzN6bdAM/Iny7MA6GOdCFUmR5ge+uwVqqKE1F5osptK+If3hDLTeqLgbcspmdFMfxK3xqpj48T295u46xe2Cdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KT8+WxK/; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58164339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849974; x=1713454774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08PAtrhbE+R6iK58OUJxn9BiTqf8PwssoESggNQBtJA=;
        b=KT8+WxK/lV217baW2oBNVcPCkbn+Yj2nWrsTsSqqmXGvjsP0KjK3yxISz9FG6mJGd1
         /bX1qg5+UUin/1QsYxBZkWufG+S4hTV4dasdEu1DUfKMFoF9fyQ6/JyrdDjxp6m2YASh
         14eAlZSivMwwr1oU8m+Mj+jOV8sdA6BnmnZ0FXEOq4wJ9YJRxj7Kfj8GByh9mYTACITY
         1EKxsSCK5vZ9BK59KXv4OnvNrrOLgQq6W4JSrBeWKhQIbGCvOup7ISNBkU24eUBmsKSk
         3px1Gl5rthsRc8iVOBeW6IdHtGJ9TISWUtaHSd/RfAMH9jVarF02SDzafzn5UMFaooNu
         1x3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849974; x=1713454774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=08PAtrhbE+R6iK58OUJxn9BiTqf8PwssoESggNQBtJA=;
        b=pWe7aS0t3BwfuPLNTlXLjbHKLclzCX+jjFte8DGXeW3ufhdo6GGxCM5Hbbs6lJTNlY
         Sd4Xq1vlmnSRdBaCRxcT3YuQdZWMAgBCln0iXAna+R7UaTEXxXBddPDoNDaDhFGinG9B
         JDtx9bfbiNNG4kgHjWUGpbYd9TJhIAjalBgvJwqH07YeUt//08GXpM8qtLERYrq0aQ+z
         jnywhKixn5yQ92Yh7ZgcUY1sY49tA36Q+p4TXrhrX+sB1I+ku0bHsHYTSTXt6+HUKOt7
         0xgmGZSj/iiAADVq6zwWQ6gidqYvj9B8s9xK/wnnEFdj9U7l5589N9xyWPXhYDHSW/ku
         lGPw==
X-Gm-Message-State: AOJu0YwcUFp+v5PZduBuhs0WaRDf/dJallNg7RksqLPwWfADwgELc3rx
	90DtLqq8zzBsT5YOWAfAojFYRuApAP+7x5zKsEKxiUITVFi9IXkjMpL+52ehBkN50g0G44yErLX
	m
X-Google-Smtp-Source: AGHT+IE2C1+VxSUMyChMtYz/iB/fEb/18L0FB9m2Venps3jy90x+a0TUyubgTvbaJWYr7oSwn1WmwQ==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr195838iov.2.1712849973657;
        Thu, 11 Apr 2024 08:39:33 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:39:31 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 286/437] ubifs: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:06 -0600
Message-ID: <20240411153126.16201-287-axboe@kernel.dk>
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
 fs/ubifs/debug.c | 59 ++++++++++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 32 deletions(-)

diff --git a/fs/ubifs/debug.c b/fs/ubifs/debug.c
index 2d63f57aca6f..52f93ea1ac7f 100644
--- a/fs/ubifs/debug.c
+++ b/fs/ubifs/debug.c
@@ -2677,17 +2677,15 @@ static int dfs_file_open(struct inode *inode, struct file *file)
 /**
  * provide_user_output - provide output to the user reading a debugfs file.
  * @val: boolean value for the answer
- * @u: the buffer to store the answer at
- * @count: size of the buffer
- * @ppos: position in the @u output buffer
+ * @iocb: metadata for IO
+ * @to: the buffer to store the answer at
  *
  * This is a simple helper function which stores @val boolean value in the user
  * buffer when the user reads one of UBIFS debugfs files. Returns amount of
  * bytes written to @u in case of success and a negative error code in case of
  * failure.
  */
-static int provide_user_output(int val, char __user *u, size_t count,
-			       loff_t *ppos)
+static int provide_user_output(int val, struct kiocb *iocb, struct iov_iter *to)
 {
 	char buf[3];
 
@@ -2698,14 +2696,13 @@ static int provide_user_output(int val, char __user *u, size_t count,
 	buf[1] = '\n';
 	buf[2] = 0x00;
 
-	return simple_read_from_buffer(u, count, ppos, buf, 2);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, 2, to);
 }
 
-static ssize_t dfs_file_read(struct file *file, char __user *u, size_t count,
-			     loff_t *ppos)
+static ssize_t dfs_file_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct dentry *dent = file->f_path.dentry;
-	struct ubifs_info *c = file->private_data;
+	struct dentry *dent = iocb->ki_filp->f_path.dentry;
+	struct ubifs_info *c = iocb->ki_filp->private_data;
 	struct ubifs_debug_info *d = c->dbg;
 	int val;
 
@@ -2726,26 +2723,25 @@ static ssize_t dfs_file_read(struct file *file, char __user *u, size_t count,
 	else
 		return -EINVAL;
 
-	return provide_user_output(val, u, count, ppos);
+	return provide_user_output(val, iocb, to);
 }
-FOPS_READ_ITER_HELPER(dfs_file_read);
 
 /**
  * interpret_user_input - interpret user debugfs file input.
- * @u: user-provided buffer with the input
- * @count: buffer size
+ * @from: user-provided buffer with the input
  *
  * This is a helper function which interpret user input to a boolean UBIFS
  * debugfs file. Returns %0 or %1 in case of success and a negative error code
  * in case of failure.
  */
-static int interpret_user_input(const char __user *u, size_t count)
+static int interpret_user_input(struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	size_t buf_size;
 	char buf[8];
 
 	buf_size = min_t(size_t, count, (sizeof(buf) - 1));
-	if (copy_from_user(buf, u, buf_size))
+	if (!copy_from_iter_full(buf, buf_size, from))
 		return -EFAULT;
 
 	if (buf[0] == '1')
@@ -2756,12 +2752,13 @@ static int interpret_user_input(const char __user *u, size_t count)
 	return -EINVAL;
 }
 
-static ssize_t dfs_file_write(struct file *file, const char __user *u,
-			      size_t count, loff_t *ppos)
+static ssize_t dfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	struct file *file = iocb->ki_filp;
 	struct ubifs_info *c = file->private_data;
 	struct ubifs_debug_info *d = c->dbg;
 	struct dentry *dent = file->f_path.dentry;
+	size_t count = iov_iter_count(from);
 	int val;
 
 	if (file->f_path.dentry == d->dfs_dump_lprops) {
@@ -2779,7 +2776,7 @@ static ssize_t dfs_file_write(struct file *file, const char __user *u,
 		return count;
 	}
 
-	val = interpret_user_input(u, count);
+	val = interpret_user_input(from);
 	if (val < 0)
 		return val;
 
@@ -2802,12 +2799,11 @@ static ssize_t dfs_file_write(struct file *file, const char __user *u,
 
 	return count;
 }
-FOPS_WRITE_ITER_HELPER(dfs_file_write);
 
 static const struct file_operations dfs_fops = {
 	.open = dfs_file_open,
-	.read_iter = dfs_file_read_iter,
-	.write_iter = dfs_file_write_iter,
+	.read_iter = dfs_file_read,
+	.write_iter = dfs_file_write,
 	.owner = THIS_MODULE,
 	.llseek = no_llseek,
 };
@@ -2898,10 +2894,9 @@ static struct dentry *dfs_chk_lprops;
 static struct dentry *dfs_chk_fs;
 static struct dentry *dfs_tst_rcvry;
 
-static ssize_t dfs_global_file_read(struct file *file, char __user *u,
-				    size_t count, loff_t *ppos)
+static ssize_t dfs_global_file_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct dentry *dent = file->f_path.dentry;
+	struct dentry *dent = iocb->ki_filp->f_path.dentry;
 	int val;
 
 	if (dent == dfs_chk_gen)
@@ -2919,16 +2914,16 @@ static ssize_t dfs_global_file_read(struct file *file, char __user *u,
 	else
 		return -EINVAL;
 
-	return provide_user_output(val, u, count, ppos);
+	return provide_user_output(val, iocb, to);
 }
 
-static ssize_t dfs_global_file_write(struct file *file, const char __user *u,
-				     size_t count, loff_t *ppos)
+static ssize_t dfs_global_file_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct dentry *dent = file->f_path.dentry;
+	struct dentry *dent = iocb->ki_filp->f_path.dentry;
+	size_t count = iov_iter_count(from);
 	int val;
 
-	val = interpret_user_input(u, count);
+	val = interpret_user_input(from);
 	if (val < 0)
 		return val;
 
@@ -2951,8 +2946,8 @@ static ssize_t dfs_global_file_write(struct file *file, const char __user *u,
 }
 
 static const struct file_operations dfs_global_fops = {
-	.read = dfs_global_file_read,
-	.write = dfs_global_file_write,
+	.read_iter = dfs_global_file_read,
+	.write_iter = dfs_global_file_write,
 	.owner = THIS_MODULE,
 	.llseek = no_llseek,
 };
-- 
2.43.0


