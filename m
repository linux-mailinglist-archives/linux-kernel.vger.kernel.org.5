Return-Path: <linux-kernel+bounces-141166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E05748A1ACC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F6EF288138
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A461F4FD2;
	Thu, 11 Apr 2024 15:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zPHKt0pg"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313001F4FAF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850150; cv=none; b=CaXBDmjFhUzasP5715rOvslYhHYhc8Eyh6pTU4M7c0h/GdRjVANelu+JQWDq0qNXjDVoq4X48c4tLjDqLKZHuS85z1VOuFmZ9R/ZXvc1k30b6kHHPqWyjRs3vgpVfCuqKcAu2n2h++uublOv7tQgjP/vjWH3JThOVujhsOTDrYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850150; c=relaxed/simple;
	bh=mJAw9t0NrgR3ha0gcKYHqXmy3EWAXDE7YP/6L6BdfCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tm+hruw1uJHMQ8A2mCO0FbFEXvuLEWPoC6wkRqW0/hGP2jY4s9eohveGJz8f8kNozhx/T2tbMxPd6juQFdE2PqOnbRI2kPbXlgNYkBokwcBuQt1ZVMgvCFvflVGwapBc5AadR+MbPRcrrnRc28v3Va4DTV0wGaBE2d40vBgNQHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zPHKt0pg; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-36a224d7414so196955ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850147; x=1713454947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsB8zH87dmI7er9oXHLg2/9heWL8uz59DS+bw6PT870=;
        b=zPHKt0pgfkSfg57x9JRNav5d+DwIenMCuihuuedYYQ7bRmrJjP5qALFQm8NOIoavPd
         9ig9ixkm4odt1DSaVvC7hiBgmzj1ZHJ+LhHWjf6a5p4HGN8FYp7+aWL8bs2vm83l4LXp
         44ibQRjbz1q7wpXAUXGH06XxqABHzKFenpyp6Upj76PEKdDTp5BJDtY3HoUVDKELy0zo
         BkeFUBKy4q+s6ZZYJIvHbvPSyd/QJaAwEIQZs0f8inxMoF6TTwbyGEVklHTkf4o2NzTB
         T8c6lqYNjsLUYne5s8yicQL1uu0E3Nhb6gzCIXnIdg95S8aNhbEMp8MJFGjFbeRySEH3
         AEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850147; x=1713454947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VsB8zH87dmI7er9oXHLg2/9heWL8uz59DS+bw6PT870=;
        b=pXM9jszBauAUC6et52As68Xol6W8Kx2O/aQlNhLEdcc5CX/La9ub5FrrlBjjl09RMI
         tYYdYP2Ia3ZptCkTuYYg63JGpbg2BDU6ht2t2gyXSmcvvCSaPAcaAK5gvdWNks0dTff3
         tSGee9vZbC4zhakrgNSo95GWwkUJvVS7C2XfD55VkrGdGJ0Qsds0Mhss8FtgbHgL7aVv
         xfRScaE+Qet31T/f86eeJIRHUUinWldhGBXDhU8ydKj7Dp4XvC+71Iw34cGxT4WkyW6B
         ZyCd++XnpFuWTO6SRO8G3d1PJO37foohkGdPXD3K0QJ4Phv+YBZ9VUx/RI9Oh0T8oUHk
         CgaA==
X-Gm-Message-State: AOJu0Yw1ytQ93YWGkZh3aBv93w/VrN/58GBVQ83LO2YQzxZAJwNDlBwh
	Esh9UyJMLhDjxe9xt+0r+D+jGjhx8cvIS0rhaFGf86EmQi96mH63A3bLKXAb475HWF90J4+82Qn
	O
X-Google-Smtp-Source: AGHT+IFZ3PMZ517pG9kXwDFMQxA4gKUOWYSRQC23SdQZrsX8jZJMPWx7toeljT1gIoz6ReuJbQyRCA==
X-Received: by 2002:a6b:6605:0:b0:7d4:1dae:da1a with SMTP id a5-20020a6b6605000000b007d41daeda1amr163740ioc.2.1712850147609;
        Thu, 11 Apr 2024 08:42:27 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:42:27 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 385/437] speakup: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:45 -0600
Message-ID: <20240411153126.16201-386-axboe@kernel.dk>
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
 drivers/accessibility/speakup/devsynth.c     | 27 +++++-------
 drivers/accessibility/speakup/speakup_soft.c | 46 +++++++++-----------
 2 files changed, 31 insertions(+), 42 deletions(-)

diff --git a/drivers/accessibility/speakup/devsynth.c b/drivers/accessibility/speakup/devsynth.c
index cb7e1114e8eb..dd65b3882344 100644
--- a/drivers/accessibility/speakup/devsynth.c
+++ b/drivers/accessibility/speakup/devsynth.c
@@ -11,11 +11,10 @@ static int synth_registered, synthu_registered;
 static int dev_opened;
 
 /* Latin1 version */
-static ssize_t speakup_file_write(struct file *fp, const char __user *buffer,
-				  size_t nbytes, loff_t *ppos)
+static ssize_t speakup_file_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t nbytes = iov_iter_count(from);
 	size_t count = nbytes;
-	const char __user *ptr = buffer;
 	size_t bytes;
 	unsigned long flags;
 	u_char buf[256];
@@ -24,10 +23,9 @@ static ssize_t speakup_file_write(struct file *fp, const char __user *buffer,
 		return -ENODEV;
 	while (count > 0) {
 		bytes = min(count, sizeof(buf));
-		if (copy_from_user(buf, ptr, bytes))
+		if (!copy_from_iter_full(buf, bytes, from))
 			return -EFAULT;
 		count -= bytes;
-		ptr += bytes;
 		spin_lock_irqsave(&speakup_info.spinlock, flags);
 		synth_write(buf, bytes);
 		spin_unlock_irqrestore(&speakup_info.spinlock, flags);
@@ -36,11 +34,10 @@ static ssize_t speakup_file_write(struct file *fp, const char __user *buffer,
 }
 
 /* UTF-8 version */
-static ssize_t speakup_file_writeu(struct file *fp, const char __user *buffer,
-				   size_t nbytes, loff_t *ppos)
+static ssize_t speakup_file_writeu(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t nbytes = iov_iter_count(from);
 	size_t count = nbytes, want;
-	const char __user *ptr = buffer;
 	size_t bytes;
 	unsigned long flags;
 	unsigned char buf[256];
@@ -54,7 +51,7 @@ static ssize_t speakup_file_writeu(struct file *fp, const char __user *buffer,
 	while (count >= want) {
 		/* Copy some UTF-8 piece from userland */
 		bytes = min(count, sizeof(buf));
-		if (copy_from_user(buf, ptr, bytes))
+		if (!copy_from_iter_full(buf, bytes, from))
 			return -EFAULT;
 
 		/* Convert to u16 */
@@ -112,7 +109,6 @@ static ssize_t speakup_file_writeu(struct file *fp, const char __user *buffer,
 		}
 
 		count -= bytes;
-		ptr += bytes;
 
 		/* And speak this up */
 		if (out) {
@@ -127,8 +123,7 @@ static ssize_t speakup_file_writeu(struct file *fp, const char __user *buffer,
 	return (ssize_t)(nbytes - count);
 }
 
-static ssize_t speakup_file_read(struct file *fp, char __user *buf,
-				 size_t nbytes, loff_t *ppos)
+static ssize_t speakup_file_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	return 0;
 }
@@ -149,15 +144,15 @@ static int speakup_file_release(struct inode *ip, struct file *fp)
 }
 
 static const struct file_operations synth_fops = {
-	.read = speakup_file_read,
-	.write = speakup_file_write,
+	.read_iter = speakup_file_read,
+	.write_iter = speakup_file_write,
 	.open = speakup_file_open,
 	.release = speakup_file_release,
 };
 
 static const struct file_operations synthu_fops = {
-	.read = speakup_file_read,
-	.write = speakup_file_writeu,
+	.read_iter = speakup_file_read,
+	.write_iter = speakup_file_writeu,
 	.open = speakup_file_open,
 	.release = speakup_file_release,
 };
diff --git a/drivers/accessibility/speakup/speakup_soft.c b/drivers/accessibility/speakup/speakup_soft.c
index 6d446824677b..bc88e7e25910 100644
--- a/drivers/accessibility/speakup/speakup_soft.c
+++ b/drivers/accessibility/speakup/speakup_soft.c
@@ -215,17 +215,17 @@ static int softsynth_close(struct inode *inode, struct file *fp)
 	return 0;
 }
 
-static ssize_t softsynthx_read(struct file *fp, char __user *buf, size_t count,
-			       loff_t *pos, int unicode)
+static ssize_t softsynthx_read(struct kiocb *iocb, struct iov_iter *to,
+			       int unicode)
 {
 	int chars_sent = 0;
-	char __user *cp;
 	char *init;
 	size_t bytes_per_ch = unicode ? 3 : 1;
 	u16 ch;
 	int empty;
 	unsigned long flags;
 	DEFINE_WAIT(wait);
+	size_t count = iov_iter_count(to);
 
 	if (count < bytes_per_ch)
 		return -EINVAL;
@@ -241,7 +241,7 @@ static ssize_t softsynthx_read(struct file *fp, char __user *buf, size_t count,
 				break;
 		}
 		spin_unlock_irqrestore(&speakup_info.spinlock, flags);
-		if (fp->f_flags & O_NONBLOCK) {
+		if (iocb->ki_filp->f_flags & O_NONBLOCK) {
 			finish_wait(&speakup_event, &wait);
 			return -EAGAIN;
 		}
@@ -254,7 +254,6 @@ static ssize_t softsynthx_read(struct file *fp, char __user *buf, size_t count,
 	}
 	finish_wait(&speakup_event, &wait);
 
-	cp = buf;
 	init = get_initstring();
 
 	/* Keep 3 bytes available for a 16bit UTF-8-encoded character */
@@ -278,22 +277,20 @@ static ssize_t softsynthx_read(struct file *fp, char __user *buf, size_t count,
 		if ((!unicode && ch < 0x100) || (unicode && ch < 0x80)) {
 			u_char c = ch;
 
-			if (copy_to_user(cp, &c, 1))
+			if (!copy_to_iter_full(&c, 1, to))
 				return -EFAULT;
 
 			chars_sent++;
-			cp++;
 		} else if (unicode && ch < 0x800) {
 			u_char s[2] = {
 				0xc0 | (ch >> 6),
 				0x80 | (ch & 0x3f)
 			};
 
-			if (copy_to_user(cp, s, sizeof(s)))
+			if (!copy_to_iter_full(s, sizeof(s), to))
 				return -EFAULT;
 
 			chars_sent += sizeof(s);
-			cp += sizeof(s);
 		} else if (unicode) {
 			u_char s[3] = {
 				0xe0 | (ch >> 12),
@@ -301,46 +298,43 @@ static ssize_t softsynthx_read(struct file *fp, char __user *buf, size_t count,
 				0x80 | (ch & 0x3f)
 			};
 
-			if (copy_to_user(cp, s, sizeof(s)))
+			if (!copy_to_iter_full(s, sizeof(s), to))
 				return -EFAULT;
 
 			chars_sent += sizeof(s);
-			cp += sizeof(s);
 		}
 
 		spin_lock_irqsave(&speakup_info.spinlock, flags);
 	}
-	*pos += chars_sent;
+	iocb->ki_pos += chars_sent;
 	empty = synth_buffer_empty();
 	spin_unlock_irqrestore(&speakup_info.spinlock, flags);
 	if (empty) {
 		speakup_start_ttys();
-		*pos = 0;
+		iocb->ki_pos = 0;
 	}
 	return chars_sent;
 }
 
-static ssize_t softsynth_read(struct file *fp, char __user *buf, size_t count,
-			      loff_t *pos)
+static ssize_t softsynth_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	return softsynthx_read(fp, buf, count, pos, 0);
+	return softsynthx_read(iocb, to, 0);
 }
 
-static ssize_t softsynthu_read(struct file *fp, char __user *buf, size_t count,
-			       loff_t *pos)
+static ssize_t softsynthu_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	return softsynthx_read(fp, buf, count, pos, 1);
+	return softsynthx_read(iocb, to, 1);
 }
 
 static int last_index;
 
-static ssize_t softsynth_write(struct file *fp, const char __user *buf,
-			       size_t count, loff_t *pos)
+static ssize_t softsynth_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	unsigned long supplied_index = 0;
+	size_t count = iov_iter_count(from);
 	int converted;
 
-	converted = kstrtoul_from_user(buf, count, 0, &supplied_index);
+	converted = kstrtoul_from_iter(from, count, 0, &supplied_index);
 
 	if (converted < 0)
 		return converted;
@@ -376,8 +370,8 @@ static unsigned char get_index(struct spk_synth *synth)
 static const struct file_operations softsynth_fops = {
 	.owner = THIS_MODULE,
 	.poll = softsynth_poll,
-	.read = softsynth_read,
-	.write = softsynth_write,
+	.read_iter = softsynth_read,
+	.write_iter = softsynth_write,
 	.open = softsynth_open,
 	.release = softsynth_close,
 };
@@ -385,8 +379,8 @@ static const struct file_operations softsynth_fops = {
 static const struct file_operations softsynthu_fops = {
 	.owner = THIS_MODULE,
 	.poll = softsynth_poll,
-	.read = softsynthu_read,
-	.write = softsynth_write,
+	.read_iter = softsynthu_read,
+	.write_iter = softsynth_write,
 	.open = softsynth_open,
 	.release = softsynth_close,
 };
-- 
2.43.0


