Return-Path: <linux-kernel+bounces-140882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306028A195B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EDE71C223D0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6455F15442F;
	Thu, 11 Apr 2024 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="IiC894g+"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293E4153BE5
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849702; cv=none; b=YejOV1Tam6T7n5ON+5kJncs1EOJZ82avZDakfrihLIa+sbECPjcIW4E2CvW6toGkpc8yjlwb8YtnvIApXAUINoyBdOFDC/kdjniX6pM8udMUnuQLEhxxoUmDuxA4UhpUZkhZU6UcIGbwPNdpQMu2PJhEwSuY60meh32uSl6cNKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849702; c=relaxed/simple;
	bh=lZdXYkmzS+JjeSPuAD9NxOl8ZnjicQ+5Fbw78ORsT10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecDrkqwlOgmdutsbWFwOggaPlgq40lDAOcwSxSQ6KDiJOls6shPX2CzdlxdZ+9ZyuE8cwDRcoB4hOdmIteGryR5np8oEQMAgxyLsvKN6wpLmwo04cd1zWIxLbI2h4JYyWSCvLMLKEEjBAiIt6CcHhz5jnyO//4YP+HHgokSFAxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=IiC894g+; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170489939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849700; x=1713454500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGVTOHLVy23YeA/ug2q4h0/nzZcrwmXiwnc4UssmodY=;
        b=IiC894g+UqKP9tBIebZGoB1XSYhubtdZzx9x40m13dTV7nQF3P4oQ3V8SOEfwhudbI
         S5QkuuLD2kiDh3mvveEPygIqfVQg+mSFi9Fboa7u4kKlkWcjtQ4pN7ixGQg9TSHvPkwO
         pNxHqKLs2IAeT2QcImVi+ABTofJlI1yNmc0OR1Zn92dAyT8e1TSmXF4Dd6SVsolzx8jm
         bcvZHFvN5iK94UIHKOybOaaDmJCNmnQZKJ6dsveb/Fx9JqRCHi0LLk9D854GiAMOc4HP
         OjE348/h8eCaZ5gK2qxGMv4AMAxbObbUrOrL5ctqjzAlDpob3HHtybEnm4iJZLo3xUfy
         5k6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849700; x=1713454500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FGVTOHLVy23YeA/ug2q4h0/nzZcrwmXiwnc4UssmodY=;
        b=TjUMLuFixUWo64a0O2Dh2z8Bw+uVnqiBZustnHwdyIMhxzUJqFbpx65Rwzc+/oply4
         u/Aih62I9wT45BEd2u6972RVwYY6gTBn39/DJDrld8eoSG75UF46s+2YbYkj3Uabv47Y
         3I/no9KdYKF1+Pu69K+ZNRAa3yMukCPaTRt/cBvYLVCyzxrjBVbXTESmQNjaR3ZFjGaL
         lOMUUtNmnbG8u9Be+3SZmtHBK52lkA1cEyiDM12PFX12K/smUBQrW0Sz+9+CJ++746FN
         Xew8L47laB8nRA2M7lAi+wMyr34ky3DO7faSXNJyvYswOQwY2SBCguCY2L+RvzE3vIsM
         zcyg==
X-Gm-Message-State: AOJu0Yx0CXxWNx/Ve0F6ImsP7GP2NzEeA+HxNnbRO8V6c5Fkyaqz+7Ob
	csC9OFwNeqIyGSTsMtWEpuVLxEq4Lamr28/wHmhDvqVUiLwgEiZELGh1r7blmLiuqkcaofrQxt7
	h
X-Google-Smtp-Source: AGHT+IHjkLoNE7fdAfLSYY1PYHDqyxp1H9DeY2+iwIpdTeTpsCy+o7NsLjI1GopbCoNwzllDQjxOtw==
X-Received: by 2002:a05:6602:21d7:b0:7d6:9ddf:5095 with SMTP id c23-20020a05660221d700b007d69ddf5095mr11721ioc.1.1712849699852;
        Thu, 11 Apr 2024 08:34:59 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:34:59 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 118/437] drivers/tty: convert to ->read_iter and ->write_iter
Date: Thu, 11 Apr 2024 09:14:18 -0600
Message-ID: <20240411153126.16201-119-axboe@kernel.dk>
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
 drivers/tty/serial/pch_uart.c |  9 ++++-----
 drivers/tty/vt/vc_screen.c    | 32 +++++++++++++++-----------------
 2 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 89257cddf540..a61410eb67b1 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -290,10 +290,9 @@ static const int trigger_level_1[4] = { 1, 1, 1, 1 };
 #define PCH_REGS_BUFSIZE	1024
 
 
-static ssize_t port_show_regs(struct file *file, char __user *user_buf,
-				size_t count, loff_t *ppos)
+static ssize_t port_show_regs(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct eg20t_port *priv = file->private_data;
+	struct eg20t_port *priv = iocb->ki_filp->private_data;
 	char *buf;
 	u32 len = 0;
 	ssize_t ret;
@@ -335,7 +334,7 @@ static ssize_t port_show_regs(struct file *file, char __user *user_buf,
 	if (len > PCH_REGS_BUFSIZE)
 		len = PCH_REGS_BUFSIZE;
 
-	ret =  simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	ret =  simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 	kfree(buf);
 	return ret;
 }
@@ -343,7 +342,7 @@ static ssize_t port_show_regs(struct file *file, char __user *user_buf,
 static const struct file_operations port_regs_ops = {
 	.owner		= THIS_MODULE,
 	.open		= simple_open,
-	.read		= port_show_regs,
+	.read_iter	= port_show_regs,
 	.llseek		= default_llseek,
 };
 
diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 67e2cb7c96ee..56daaa568866 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -361,10 +361,10 @@ static unsigned int vcs_read_buf(const struct vc_data *vc, char *con_buf,
 	return filled;
 }
 
-static ssize_t
-vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
+static ssize_t vcs_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct inode *inode = file_inode(file);
+	struct inode *inode = file_inode(iocb->ki_filp);
+	size_t count = iov_iter_count(to);
 	struct vc_data *vc;
 	struct vcs_poll_data *poll;
 	unsigned int read;
@@ -377,7 +377,7 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	if (!con_buf)
 		return -ENOMEM;
 
-	pos = *ppos;
+	pos = iocb->ki_pos;
 
 	/* Select the proper current console and verify
 	 * sanity of the situation under the console lock.
@@ -394,7 +394,7 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	if (uni_mode && (pos | count) & 3)
 		goto unlock_out;
 
-	poll = file->private_data;
+	poll = iocb->ki_filp->private_data;
 	if (count && poll)
 		poll->event = 0;
 	read = 0;
@@ -453,7 +453,7 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		 */
 
 		console_unlock();
-		ret = copy_to_user(buf, con_buf + skip, this_round);
+		ret = !copy_to_iter_full(con_buf + skip, this_round, to);
 		console_lock();
 
 		if (ret) {
@@ -461,12 +461,11 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 			ret = -EFAULT;
 			break;
 		}
-		buf += this_round;
 		pos += this_round;
 		read += this_round;
 		count -= this_round;
 	}
-	*ppos += read;
+	iocb->ki_pos += read;
 	if (read)
 		ret = read;
 unlock_out:
@@ -586,10 +585,10 @@ static u16 *vcs_write_buf(struct vc_data *vc, const char *con_buf,
 	return org;
 }
 
-static ssize_t
-vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
+static ssize_t vcs_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct inode *inode = file_inode(file);
+	struct inode *inode = file_inode(iocb->ki_filp);
+	size_t count = iov_iter_count(from);
 	struct vc_data *vc;
 	char *con_buf;
 	u16 *org0, *org;
@@ -606,7 +605,7 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 	if (!con_buf)
 		return -ENOMEM;
 
-	pos = *ppos;
+	pos = iocb->ki_pos;
 
 	/* Select the proper current console and verify
 	 * sanity of the situation under the console lock.
@@ -640,7 +639,7 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 		 * in the write data from userspace safely.
 		 */
 		console_unlock();
-		ret = copy_from_user(con_buf, buf, this_round);
+		ret = !copy_from_iter_full(con_buf, this_round, from);
 		console_lock();
 
 		if (ret) {
@@ -692,12 +691,11 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 
 		count -= this_round;
 		written += this_round;
-		buf += this_round;
 		pos += this_round;
 		if (org)
 			update_region(vc, (unsigned long)(org0), org - org0);
 	}
-	*ppos += written;
+	iocb->ki_pos += written;
 	ret = written;
 	if (written)
 		vcs_scr_updated(vc);
@@ -778,8 +776,8 @@ static int vcs_release(struct inode *inode, struct file *file)
 
 static const struct file_operations vcs_fops = {
 	.llseek		= vcs_lseek,
-	.read		= vcs_read,
-	.write		= vcs_write,
+	.read_iter	= vcs_read,
+	.write_iter	= vcs_write,
 	.poll		= vcs_poll,
 	.fasync		= vcs_fasync,
 	.open		= vcs_open,
-- 
2.43.0


