Return-Path: <linux-kernel+bounces-140921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E9D8A199F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0608B1F22264
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3382319DF5D;
	Thu, 11 Apr 2024 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="roVGWfkc"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24754199EBF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849763; cv=none; b=Wz7LRuL3Zt4LtgLVj/cNBXFHx8jaC4huGRICsUDAYCkatByuWGHBjIk1aRtfSTdAWHwJqnVXZs0ZaMFVDzkmi8/LpfVvaS3MALS4aC2OJKcQwGQtgvC/Ak1aFE5tbRQvZuG0b9A5QrywBVIRCV6kS+flrKX18Sp+7IvVl8RmZvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849763; c=relaxed/simple;
	bh=a4TEIQTuQWFkcw6pA1NWC0rqKJ0PG83hksmnYR8rtaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSHCfTPny3uPgrVxDKTWqR4ULcGNhvQZ1mcDTeW17NkQDyutSaF2fk8FniMVxBsRb9JxQd3cX6Fnbob8fa1s8cyVnsX8C6x4hw7BVe3FiPvoLGYsmdBE0ppCuXpMlCw6fHaSiZ5F11OW/I3h8+w3cY5JA+pl7DbgmFeWNsHOjl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=roVGWfkc; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69564339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849761; x=1713454561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EuLUXClpT72M8hfQh2VGidcAIqmjsaMeBif3YhVOe5g=;
        b=roVGWfkcgKjfnDpOu2WBodKWhNMI5lVh0gGAvqNTFCW6h5yF0QTcBiplmH1fhXGcqF
         YKe47Uho04F7Cerws7O14J0VeSoM6ZwgWR2+orZYiX8h8nI3U5PVIzbadAVWAAuuPA4l
         /ekGCnjp61+lHhVn8BZn6/hWcNjSuQw5BKlWCS/VlvSh+40rmlFhJEoscw6iufL5fpWq
         Mk/6Y86Zzo+SqdU6LazCvFogSkqjJnjoJDwqtf0MnVS3e6WBxgFV1xRbt+SNPAW+7YG5
         /QLIMIzc+Bl8aGt/zLYDoNwcy9Vis19/g4Ucp0HihOX4GvGqQA/DsnUDI0Eq9GLaYTzv
         e0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849761; x=1713454561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EuLUXClpT72M8hfQh2VGidcAIqmjsaMeBif3YhVOe5g=;
        b=BWsJQFsBgHC39zZyE9nZaVmL56rppq08PCW3abQcnpCogK6/xi+4qXY11yVz0S0BvM
         MIADQGD4vfvY8IX3qqIdr54WY/h5k+1xdBfSo5x+jWYk/8hXb4E9e+B+/j8bO/uPR6ca
         tEOzXgRJHpVtultrCtRhQAcomMteQmC0L1PZIIF57dOKUMmGafV3upa5883SiUu7pOLE
         LXIOIbL4OG3fwHL0IU0bKRAJCw8l9T6KBOzdiFNggR0gXQ1YTyqsIsMh6uGkGAUX2Y4z
         bShL2mXNApLDHvt4BSXHngQvFQHUMD3N2WCkMLgJg1Fn0h4El8909wsjgriIRB2xf2Xp
         hQyA==
X-Gm-Message-State: AOJu0YzLNDTNUBhBaB8xSVE9lheT2m6DY23gY/ryatydM3UV2rKr2hO0
	whlxi93wnlwid3kkZ94AWd3fl3gNPIGxACEbohKiS4/1cYExUJ29skKxPdeqKKOKHdykvlUh+HQ
	L
X-Google-Smtp-Source: AGHT+IHMoN//d5n+dYVZkBHVUXPCZfUakGLAlDeQ1Kprkb1py5eGlbGGHAZB6g0lsGBhZce0AEseow==
X-Received: by 2002:a92:de01:0:b0:36a:cf8:3fe6 with SMTP id x1-20020a92de01000000b0036a0cf83fe6mr5771996ilm.1.1712849760966;
        Thu, 11 Apr 2024 08:36:00 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:35:59 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 154/437] fs/debugfs: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:54 -0600
Message-ID: <20240411153126.16201-155-axboe@kernel.dk>
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
 fs/debugfs/file.c | 54 +++++++++++++++++------------------------------
 1 file changed, 19 insertions(+), 35 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 31749d8c35f8..6463b4a274d4 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -318,15 +318,13 @@ FULL_PROXY_FUNC(llseek, loff_t, filp,
 		PROTO(struct file *filp, loff_t offset, int whence),
 		ARGS(filp, offset, whence));
 
-FULL_PROXY_FUNC(read, ssize_t, filp,
-		PROTO(struct file *filp, char __user *buf, size_t size,
-			loff_t *ppos),
-		ARGS(filp, buf, size, ppos));
+FULL_PROXY_FUNC(read_iter, ssize_t, iocb->ki_filp,
+		PROTO(struct kiocb *iocb, struct iov_iter *to),
+		ARGS(iocb, to));
 
-FULL_PROXY_FUNC(write, ssize_t, filp,
-		PROTO(struct file *filp, const char __user *buf, size_t size,
-			loff_t *ppos),
-		ARGS(filp, buf, size, ppos));
+FULL_PROXY_FUNC(write_iter, ssize_t, iocb->ki_filp,
+		PROTO(struct kiocb *iocb, struct iov_iter *from),
+		ARGS(iocb, from));
 
 FULL_PROXY_FUNC(unlocked_ioctl, long, filp,
 		PROTO(struct file *filp, unsigned int cmd, unsigned long arg),
@@ -376,10 +374,10 @@ static void __full_proxy_fops_init(struct file_operations *proxy_fops,
 	proxy_fops->release = full_proxy_release;
 	if (real_fops->llseek)
 		proxy_fops->llseek = full_proxy_llseek;
-	if (real_fops->read)
-		proxy_fops->read = full_proxy_read;
-	if (real_fops->write)
-		proxy_fops->write = full_proxy_write;
+	if (real_fops->read_iter)
+		proxy_fops->read_iter = full_proxy_read_iter;
+	if (real_fops->write_iter)
+		proxy_fops->write_iter = full_proxy_write_iter;
 	if (real_fops->poll)
 		proxy_fops->poll = full_proxy_poll;
 	if (real_fops->unlocked_ioctl)
@@ -914,19 +912,17 @@ void debugfs_create_atomic_t(const char *name, umode_t mode,
 }
 EXPORT_SYMBOL_GPL(debugfs_create_atomic_t);
 
-static ssize_t __debugfs_read_file_bool(struct file *file,
-					char __user *user_buf, size_t count,
-					loff_t *ppos)
+ssize_t debugfs_read_file_bool(struct kiocb *iocb, struct iov_iter *to)
 {
 	char buf[2];
 	bool val;
 	int r;
-	struct dentry *dentry = F_DENTRY(file);
+	struct dentry *dentry = F_DENTRY(iocb->ki_filp);
 
 	r = debugfs_file_get(dentry);
 	if (unlikely(r))
 		return r;
-	val = *(bool *)file->private_data;
+	val = *(bool *)iocb->ki_filp->private_data;
 	debugfs_file_put(dentry);
 
 	if (val)
@@ -934,25 +930,19 @@ static ssize_t __debugfs_read_file_bool(struct file *file,
 	else
 		buf[0] = 'N';
 	buf[1] = '\n';
-	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
-}
-
-ssize_t debugfs_read_file_bool(struct kiocb *iocb, struct iov_iter *to)
-{
-	return vfs_read_iter(iocb, to, __debugfs_read_file_bool);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, 2, to);
 }
 EXPORT_SYMBOL_GPL(debugfs_read_file_bool);
 
-static ssize_t __debugfs_write_file_bool(struct file *file,
-					 const char __user *user_buf,
-					 size_t count, loff_t *ppos)
+ssize_t debugfs_write_file_bool(struct kiocb *iocb, struct iov_iter *from)
 {
 	bool bv;
 	int r;
-	bool *val = file->private_data;
-	struct dentry *dentry = F_DENTRY(file);
+	bool *val = iocb->ki_filp->private_data;
+	struct dentry *dentry = F_DENTRY(iocb->ki_filp);
+	size_t count = iov_iter_count(from);
 
-	r = kstrtobool_from_user(user_buf, count, &bv);
+	r = kstrtobool_from_iter(from, count, &bv);
 	if (!r) {
 		r = debugfs_file_get(dentry);
 		if (unlikely(r))
@@ -964,12 +954,6 @@ static ssize_t __debugfs_write_file_bool(struct file *file,
 	return count;
 }
 
-ssize_t debugfs_write_file_bool(struct kiocb *iocb, struct iov_iter *from)
-{
-	return vfs_write_iter(iocb, from, __debugfs_write_file_bool);
-}
-EXPORT_SYMBOL_GPL(debugfs_write_file_bool);
-
 static const struct file_operations fops_bool = {
 	.read_iter =	debugfs_read_file_bool,
 	.write_iter =	debugfs_write_file_bool,
-- 
2.43.0


