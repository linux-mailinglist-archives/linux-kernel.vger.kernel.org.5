Return-Path: <linux-kernel+bounces-141083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9EE8A1A64
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96400284FD1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03E81D9FFE;
	Thu, 11 Apr 2024 15:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="f2pQgJzL"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5006E1D9FF0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850013; cv=none; b=uvHGf7qvPgBU22v2Ovlxrqcb+IG3dnd6V0cQ0KOD3vCyzqrcqs1do6jbRHJ+kfzC0Sq6AHEjjclaUS9mLKyYPF7uo+cEQpm9bM1A90NO0iTs17M/8Zhg5QLvZYv0Xt20NzxRBfOVbhN0HvgqAaLY50Any0joQkFlEBfxiaVD80k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850013; c=relaxed/simple;
	bh=xaPo/E+IHrGYl158KTEbt+Rq4YIWcoKYrAt5fO6c1fM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aE28s5swn/f1i5dIVvQ1XeDv/unqO9DwEox5NVDr6ztN5GAKyxP7QfWcq5+T28x3/6jZb6j3C9D62Lep3b25lGE7+f5E1/OBo4a2LOJCMP3xAIFnkYuWEJBjh8IHkjnduaVhjEsTvX2maFzhpYPxi1ozdSXi48iyI1kXWqaWA1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=f2pQgJzL; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58190039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850009; x=1713454809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2bDHnSOqzvj8tuTT6HXHmHeyHcGyehDT+1ibrSmR/0=;
        b=f2pQgJzLB7Wgluzo8SGfOzzWm1ajfeorjVEAYqmjg+JYI59l260MweCEjV35y8WVV2
         hUPMPXhg8k7/9L+iTgyoUzZZnRi2E6JQylZtNgAEdV42cv2ARkbIPu0VgTfKimmjfw4k
         jmnuQAsZWa5lVs+p+fEhK1J1Ou3jl9TsNCJ7o8HJ8ySeTY5l33pi21jkohUXpDVENDTX
         weNPkAzEHbTEcJ/BH2e62qKsCebpNB7UkuYMb6dCvhV0BjCs3OQwZ5j4tqSOgFNwNDEg
         o1wSaOeJXNwo3wG6BO6PcC4y35Cknt1sbLsENc96Yqp9DhXVM6vz0T4Vx7MaR3mcEFI2
         0KIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850009; x=1713454809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2bDHnSOqzvj8tuTT6HXHmHeyHcGyehDT+1ibrSmR/0=;
        b=hdBB9rHOI2EfSE2msOeCdjd690Ly+BesE3zG1ZMHs4J3O7AIvADjQo1yjnAe1xRqJG
         pF10leYRzl99MoGz/lg/hP9n+stNfJzSlUZpZ8eM81da7fsrOVMWHRKA3FMjTGYBJs8a
         9gRRVOOD3AKfOjRxyy2Bwa8QG34vHjZDW6O5wK4XNZrHIbYThcBD2FhVIW9GcSYc95Wk
         Exks7fH8ndt0B/uDVfJvgH2jrP6cz94tdfkBg7PKwIzYe3XEUQkqr02TzGth7Ou/Jsno
         zzAVxSTRCeXLKjzRGTnA+PLoG7DMT8Jn5UC1Ck9QXcyAjP/UHXHbCT/L9t0p/WGjKpBJ
         eoXg==
X-Gm-Message-State: AOJu0Yzevv7gUPZR4l7bf9AJaSmPZzgjQP0y0g4wHd7FMUlH7QP1AVby
	d/oWPulPyJLVQQFQIeLXPzD+60aMTSzKuDrEhgeDEQgVJ+0vRResl24v0lU3wYE59JL748Xrdjv
	s
X-Google-Smtp-Source: AGHT+IF5K/+DOq4hDjIJXrRGHOjlo6cqi5YkglAMElzRIjm+hByFQ7GLfwfllWTPuG4GBfjZiiUxhw==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr172179ioh.1.1712850009465;
        Thu, 11 Apr 2024 08:40:09 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:40:09 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 307/437] drivers/net/wireless/ralink: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:27 -0600
Message-ID: <20240411153126.16201-308-axboe@kernel.dk>
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
 .../net/wireless/ralink/rt2x00/rt2x00debug.c  | 122 ++++++++----------
 1 file changed, 55 insertions(+), 67 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00debug.c b/drivers/net/wireless/ralink/rt2x00/rt2x00debug.c
index f2395309ec00..80f84dc700be 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00debug.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00debug.c
@@ -238,17 +238,16 @@ static int rt2x00debug_release_queue_dump(struct inode *inode, struct file *file
 	return rt2x00debug_file_release(inode, file);
 }
 
-static ssize_t rt2x00debug_read_queue_dump(struct file *file,
-					   char __user *buf,
-					   size_t length,
-					   loff_t *offset)
+static ssize_t rt2x00debug_read_queue_dump(struct kiocb *iocb,
+					   struct iov_iter *to)
 {
-	struct rt2x00debug_intf *intf = file->private_data;
+	struct rt2x00debug_intf *intf = iocb->ki_filp->private_data;
+	size_t length = iov_iter_count(to);
 	struct sk_buff *skb;
 	size_t status;
 	int retval;
 
-	if (file->f_flags & O_NONBLOCK)
+	if (iocb->ki_filp->f_flags & O_NONBLOCK)
 		return -EAGAIN;
 
 	retval =
@@ -259,12 +258,12 @@ static ssize_t rt2x00debug_read_queue_dump(struct file *file,
 		return retval;
 
 	status = min_t(size_t, skb->len, length);
-	if (copy_to_user(buf, skb->data, status)) {
+	if (!copy_to_iter_full(skb->data, status, to)) {
 		status = -EFAULT;
 		goto exit;
 	}
 
-	*offset += status;
+	iocb->ki_pos += status;
 
 exit:
 	kfree_skb(skb);
@@ -287,27 +286,26 @@ static __poll_t rt2x00debug_poll_queue_dump(struct file *file,
 
 static const struct file_operations rt2x00debug_fop_queue_dump = {
 	.owner		= THIS_MODULE,
-	.read		= rt2x00debug_read_queue_dump,
+	.read_iter	= rt2x00debug_read_queue_dump,
 	.poll		= rt2x00debug_poll_queue_dump,
 	.open		= rt2x00debug_open_queue_dump,
 	.release	= rt2x00debug_release_queue_dump,
 	.llseek		= default_llseek,
 };
 
-static ssize_t rt2x00debug_read_queue_stats(struct file *file,
-					    char __user *buf,
-					    size_t length,
-					    loff_t *offset)
+static ssize_t rt2x00debug_read_queue_stats(struct kiocb *iocb,
+					    struct iov_iter *to)
 {
-	struct rt2x00debug_intf *intf = file->private_data;
+	struct rt2x00debug_intf *intf = iocb->ki_filp->private_data;
 	struct data_queue *queue;
 	unsigned long irqflags;
 	unsigned int lines = 1 + intf->rt2x00dev->data_queues;
+	size_t length = iov_iter_count(to);
 	size_t size;
 	char *data;
 	char *temp;
 
-	if (*offset)
+	if (iocb->ki_pos)
 		return 0;
 
 	data = kcalloc(lines, MAX_LINE_LENGTH, GFP_KERNEL);
@@ -333,39 +331,38 @@ static ssize_t rt2x00debug_read_queue_stats(struct file *file,
 	size = strlen(data);
 	size = min(size, length);
 
-	if (copy_to_user(buf, data, size)) {
+	if (!copy_to_iter_full(data, size, to)) {
 		kfree(data);
 		return -EFAULT;
 	}
 
 	kfree(data);
 
-	*offset += size;
+	iocb->ki_pos += size;
 	return size;
 }
 
 static const struct file_operations rt2x00debug_fop_queue_stats = {
 	.owner		= THIS_MODULE,
-	.read		= rt2x00debug_read_queue_stats,
+	.read_iter	= rt2x00debug_read_queue_stats,
 	.open		= rt2x00debug_file_open,
 	.release	= rt2x00debug_file_release,
 	.llseek		= default_llseek,
 };
 
 #ifdef CONFIG_RT2X00_LIB_CRYPTO
-static ssize_t rt2x00debug_read_crypto_stats(struct file *file,
-					     char __user *buf,
-					     size_t length,
-					     loff_t *offset)
+static ssize_t rt2x00debug_read_crypto_stats(struct kiocb *iocb,
+					     struct iov_iter *to)
 {
-	struct rt2x00debug_intf *intf = file->private_data;
+	struct rt2x00debug_intf *intf = iocb->ki_filp->private_data;
 	static const char * const name[] = { "WEP64", "WEP128", "TKIP", "AES" };
+	size_t length = iov_iter_count(to);
 	char *data;
 	char *temp;
 	size_t size;
 	unsigned int i;
 
-	if (*offset)
+	if (iocb->ki_pos)
 		return 0;
 
 	data = kcalloc(1 + CIPHER_MAX, MAX_LINE_LENGTH, GFP_KERNEL);
@@ -386,20 +383,20 @@ static ssize_t rt2x00debug_read_crypto_stats(struct file *file,
 	size = strlen(data);
 	size = min(size, length);
 
-	if (copy_to_user(buf, data, size)) {
+	if (!copy_to_iter_full(data, size, to)) {
 		kfree(data);
 		return -EFAULT;
 	}
 
 	kfree(data);
 
-	*offset += size;
+	iocb->ki_pos += size;
 	return size;
 }
 
 static const struct file_operations rt2x00debug_fop_crypto_stats = {
 	.owner		= THIS_MODULE,
-	.read		= rt2x00debug_read_crypto_stats,
+	.read_iter	= rt2x00debug_read_crypto_stats,
 	.open		= rt2x00debug_file_open,
 	.release	= rt2x00debug_file_release,
 	.llseek		= default_llseek,
@@ -407,19 +404,17 @@ static const struct file_operations rt2x00debug_fop_crypto_stats = {
 #endif
 
 #define RT2X00DEBUGFS_OPS_READ(__name, __format, __type)	\
-static ssize_t rt2x00debug_read_##__name(struct file *file,	\
-					 char __user *buf,	\
-					 size_t length,		\
-					 loff_t *offset)	\
+static ssize_t rt2x00debug_read_##__name(struct kiocb *iocb,	\
+					 struct iov_iter *to)	\
 {								\
-	struct rt2x00debug_intf *intf = file->private_data;	\
+	struct rt2x00debug_intf *intf = iocb->ki_filp->private_data;	\
 	const struct rt2x00debug *debug = intf->debug;		\
 	char line[16];						\
 	size_t size;						\
 	unsigned int index = intf->offset_##__name;		\
 	__type value;						\
 								\
-	if (*offset)						\
+	if (iocb->ki_pos)					\
 		return 0;					\
 								\
 	if (index >= debug->__name.word_count)			\
@@ -435,23 +430,22 @@ static ssize_t rt2x00debug_read_##__name(struct file *file,	\
 								\
 	size = sprintf(line, __format, value);			\
 								\
-	return simple_read_from_buffer(buf, length, offset, line, size); \
+	return simple_copy_to_iter(line, &iocb->ki_pos, size, to); \
 }
 
 #define RT2X00DEBUGFS_OPS_WRITE(__name, __type)			\
-static ssize_t rt2x00debug_write_##__name(struct file *file,	\
-					  const char __user *buf,\
-					  size_t length,	\
-					  loff_t *offset)	\
+static ssize_t rt2x00debug_write_##__name(struct kiocb *iocb,	\
+					  struct iov_iter *from)\
 {								\
-	struct rt2x00debug_intf *intf = file->private_data;	\
+	struct rt2x00debug_intf *intf = iocb->ki_filp->private_data;	\
 	const struct rt2x00debug *debug = intf->debug;		\
+	size_t length = iov_iter_count(from);			\
 	char line[17];						\
 	size_t size;						\
 	unsigned int index = intf->offset_##__name;		\
 	__type value;						\
 								\
-	if (*offset)						\
+	if (iocb->ki_pos)					\
 		return 0;					\
 								\
 	if (index >= debug->__name.word_count)			\
@@ -460,7 +454,7 @@ static ssize_t rt2x00debug_write_##__name(struct file *file,	\
 	if (length > sizeof(line))				\
 		return -EINVAL;					\
 								\
-	if (copy_from_user(line, buf, length))			\
+	if (!copy_from_iter_full(line, length, from))		\
 		return -EFAULT;					\
 	line[16] = 0;						\
 						\
@@ -475,7 +469,7 @@ static ssize_t rt2x00debug_write_##__name(struct file *file,	\
 								\
 	debug->__name.write(intf->rt2x00dev, index, value);	\
 								\
-	*offset += size;					\
+	iocb->ki_pos += size;					\
 	return size;						\
 }
 
@@ -485,8 +479,8 @@ RT2X00DEBUGFS_OPS_WRITE(__name, __type);			\
 								\
 static const struct file_operations rt2x00debug_fop_##__name = {\
 	.owner		= THIS_MODULE,				\
-	.read		= rt2x00debug_read_##__name,		\
-	.write		= rt2x00debug_write_##__name,		\
+	.read_iter	= rt2x00debug_read_##__name,		\
+	.write_iter	= rt2x00debug_write_##__name,		\
 	.open		= rt2x00debug_file_open,		\
 	.release	= rt2x00debug_file_release,		\
 	.llseek		= generic_file_llseek,			\
@@ -498,62 +492,56 @@ RT2X00DEBUGFS_OPS(bbp, "0x%.2x\n", u8);
 RT2X00DEBUGFS_OPS(rf, "0x%.8x\n", u32);
 RT2X00DEBUGFS_OPS(rfcsr, "0x%.2x\n", u8);
 
-static ssize_t rt2x00debug_read_dev_flags(struct file *file,
-					  char __user *buf,
-					  size_t length,
-					  loff_t *offset)
+static ssize_t rt2x00debug_read_dev_flags(struct kiocb *iocb,
+					  struct iov_iter *to)
 {
-	struct rt2x00debug_intf *intf =	file->private_data;
+	struct rt2x00debug_intf *intf =	iocb->ki_filp->private_data;
 	char line[16];
 	size_t size;
 
-	if (*offset)
+	if (iocb->ki_pos)
 		return 0;
 
 	size = sprintf(line, "0x%.8x\n", (unsigned int)intf->rt2x00dev->flags);
 
-	return simple_read_from_buffer(buf, length, offset, line, size);
+	return simple_copy_to_iter(line, &iocb->ki_pos, size, to);
 }
 
 static const struct file_operations rt2x00debug_fop_dev_flags = {
 	.owner		= THIS_MODULE,
-	.read		= rt2x00debug_read_dev_flags,
+	.read_iter	= rt2x00debug_read_dev_flags,
 	.open		= rt2x00debug_file_open,
 	.release	= rt2x00debug_file_release,
 	.llseek		= default_llseek,
 };
 
-static ssize_t rt2x00debug_read_cap_flags(struct file *file,
-					  char __user *buf,
-					  size_t length,
-					  loff_t *offset)
+static ssize_t rt2x00debug_read_cap_flags(struct kiocb *iocb,
+					  struct iov_iter *to)
 {
-	struct rt2x00debug_intf *intf =	file->private_data;
+	struct rt2x00debug_intf *intf =	iocb->ki_filp->private_data;
 	char line[16];
 	size_t size;
 
-	if (*offset)
+	if (iocb->ki_pos)
 		return 0;
 
 	size = sprintf(line, "0x%.8x\n", (unsigned int)intf->rt2x00dev->cap_flags);
 
-	return simple_read_from_buffer(buf, length, offset, line, size);
+	return simple_copy_to_iter(line, &iocb->ki_pos, size, to);
 }
 
 static const struct file_operations rt2x00debug_fop_cap_flags = {
 	.owner		= THIS_MODULE,
-	.read		= rt2x00debug_read_cap_flags,
+	.read_iter	= rt2x00debug_read_cap_flags,
 	.open		= rt2x00debug_file_open,
 	.release	= rt2x00debug_file_release,
 	.llseek		= default_llseek,
 };
 
-static ssize_t rt2x00debug_write_restart_hw(struct file *file,
-					    const char __user *buf,
-					    size_t length,
-					    loff_t *offset)
+static ssize_t rt2x00debug_write_restart_hw(struct kiocb *iocb,
+					    struct iov_iter *from)
 {
-	struct rt2x00debug_intf *intf =	file->private_data;
+	struct rt2x00debug_intf *intf =	iocb->ki_filp->private_data;
 	struct rt2x00_dev *rt2x00dev = intf->rt2x00dev;
 	static unsigned long last_reset = INITIAL_JIFFIES;
 
@@ -566,12 +554,12 @@ static ssize_t rt2x00debug_write_restart_hw(struct file *file,
 	last_reset = jiffies;
 
 	ieee80211_restart_hw(rt2x00dev->hw);
-	return length;
+	return iov_iter_count(from);
 }
 
 static const struct file_operations rt2x00debug_restart_hw = {
 	.owner = THIS_MODULE,
-	.write = rt2x00debug_write_restart_hw,
+	.write_iter = rt2x00debug_write_restart_hw,
 	.open = simple_open,
 	.llseek = generic_file_llseek,
 };
-- 
2.43.0


