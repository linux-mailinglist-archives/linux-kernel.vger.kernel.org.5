Return-Path: <linux-kernel+bounces-140780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D29DA8A18ED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86818286851
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0854C601;
	Thu, 11 Apr 2024 15:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="tqi6z58i"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F86F482F6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849530; cv=none; b=Z2fRzsXXnm+tfjzsV2zyEzzk3V8zpJISB5s+isRyiG827ZpWLCHCqgc47Iic8s8hazkwUDSpU3mUm5Oului6u5XCcuAxYnSCKiRmyY6fqPYBpFwadJQVRR8KJNpaBveXyu+jrlGljc2IE60hG2Q70hIIM2+UwoNJ2/DdP/p9Sxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849530; c=relaxed/simple;
	bh=xICqHCjzfHBwb/QiGFJqKkISN2X0IlBXhm1832PuaTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MI8oank/JMJcykGaBdC3QH1DZP2hwzwlETbhER7wIw4InMQX1HYA2ta74XOX82O9uQV6vYBl1xUP0ubjFaEMf60sdTR1xnAZxPzhAX5eXzOsa99w22+cXqrtIrr4nAlsYnxwZ1DO7zMbZRtwcRTQSg1O+t0ljJSh9+8f/xoAm18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=tqi6z58i; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170419339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849527; x=1713454327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PN6bUVPnEm3H8TD658GyI4+no5MCoynBBxVbj0/z+Lw=;
        b=tqi6z58iyX3U3g3bztoS3j52sq4XbTOj+HjnHx1DVpGVN61ajLExtfmUkfwbOa942O
         zVqtH3Cbk4GPvjo7E+PzzALFFm7+bwO4HXuJaRa3nBA9rN+Xpf6a4Rt9Pd2aAY9dmHFj
         D/nbrgojZD7si39+USBX8CZj41hnhx1/MuQ9n+DcKAQv0OGcSxpKt7qFBCowKMPZiH65
         j9UGvZCq+hbr75TeGiWeeZEZObSbIADBVRMe7/qGm+ZrdZiRWVgOF7fH8FYdWXStXusc
         K4P4V9QECpGyN+rWbeYYKCngUx3G2QmKJ2rqRjb+0WCmK29KYR2XXy3gw/aGV3cj4ijN
         C7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849527; x=1713454327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PN6bUVPnEm3H8TD658GyI4+no5MCoynBBxVbj0/z+Lw=;
        b=OsrAlX5QQNBU6mwDPop8UcQR95D2jYzolcg7AltPLHHXtNHrGRrRvHQhCOl+jDm9t4
         ytBXGNcltGjsT4/RZif78sB1p/Tur/n6tn033hrHCdhM1bOHZGPZ+NOBdQ4Z/2Mt3dVa
         5rIZNMiDHlXHQHmQbmBdZFJKO/abUMANRV3kisWcrq77cQzfB6RW/ubbZ2VVmMuqqgqC
         5XF8uUCI9SjQ8LjOJzlQ/oPdIor77mccNPs5S5ib0Rgf6fUdm/NAZUrRpRo0W9+a7b5Q
         qllsRUzAlOZxH8XDqHv1NyQkiHStXCzVhTekVjdRP3R1f/RsojYnM3BDqwMb6HUKstHM
         HTQQ==
X-Gm-Message-State: AOJu0Yx/tiRYB817gruHJr5wo9ugs08FKrALCzC0QLyCpI4X53TC7QSj
	CEpsdEM0sXUarZtEXl1rRXCeJUaMKCLtoULflyplVCXQOfgKqRpiiRuJfhvCYAnbRo7Rs3MAq3L
	A
X-Google-Smtp-Source: AGHT+IG1/PHUsIscy9t8ZYoBv89xMqRlTYqYbk2ueSZom6t6azDKdu4UDxh2WWJeccAFPBGqsQthSQ==
X-Received: by 2002:a6b:5b10:0:b0:7d0:bd2b:43ba with SMTP id v16-20020a6b5b10000000b007d0bd2b43bamr210552ioh.0.1712849527347;
        Thu, 11 Apr 2024 08:32:07 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:32:06 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 023/437] char/lp: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:12:43 -0600
Message-ID: <20240411153126.16201-24-axboe@kernel.dk>
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
 drivers/char/lp.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/char/lp.c b/drivers/char/lp.c
index 2f171d14b9b5..3967115f6c75 100644
--- a/drivers/char/lp.c
+++ b/drivers/char/lp.c
@@ -298,10 +298,11 @@ static int lp_wait_ready(int minor, int nonblock)
 	return error;
 }
 
-static ssize_t lp_write(struct file *file, const char __user *buf,
-			size_t count, loff_t *ppos)
+static ssize_t lp_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	struct file *file = iocb->ki_filp;
 	unsigned int minor = iminor(file_inode(file));
+	size_t count = iov_iter_count(from);
 	struct parport *port = lp_table[minor].dev->port;
 	char *kbuf = lp_table[minor].lp_buffer;
 	ssize_t retv = 0;
@@ -324,7 +325,7 @@ static ssize_t lp_write(struct file *file, const char __user *buf,
 	if (mutex_lock_interruptible(&lp_table[minor].port_mutex))
 		return -EINTR;
 
-	if (copy_from_user(kbuf, buf, copy_size)) {
+	if (!copy_from_iter_full(kbuf, copy_size, from)) {
 		retv = -EFAULT;
 		goto out_unlock;
 	}
@@ -347,7 +348,6 @@ static ssize_t lp_write(struct file *file, const char __user *buf,
 		if (written > 0) {
 			copy_size -= written;
 			count -= written;
-			buf  += written;
 			retv += written;
 		}
 
@@ -391,7 +391,7 @@ static ssize_t lp_write(struct file *file, const char __user *buf,
 			if (copy_size > LP_BUFFER_SIZE)
 				copy_size = LP_BUFFER_SIZE;
 
-			if (copy_from_user(kbuf, buf, copy_size)) {
+			if (!copy_from_iter_full(kbuf, copy_size, from)) {
 				if (retv == 0)
 					retv = -EFAULT;
 				break;
@@ -416,9 +416,10 @@ static ssize_t lp_write(struct file *file, const char __user *buf,
 #ifdef CONFIG_PARPORT_1284
 
 /* Status readback conforming to ieee1284 */
-static ssize_t lp_read(struct file *file, char __user *buf,
-		       size_t count, loff_t *ppos)
+static ssize_t lp_read(struct kiocb *iocb, struct iov_iter *to)
 {
+	struct file *file = iocb->ki_filp;
+	size_t count = iov_iter_count(to);
 	DEFINE_WAIT(wait);
 	unsigned int minor=iminor(file_inode(file));
 	struct parport *port = lp_table[minor].dev->port;
@@ -485,7 +486,7 @@ static ssize_t lp_read(struct file *file, char __user *buf,
  out:
 	lp_release_parport(&lp_table[minor]);
 
-	if (retval > 0 && copy_to_user(buf, kbuf, retval))
+	if (retval > 0 && !copy_to_iter_full(kbuf, retval, to))
 		retval = -EFAULT;
 
 	mutex_unlock(&lp_table[minor].port_mutex);
@@ -785,7 +786,7 @@ static long lp_compat_ioctl(struct file *file, unsigned int cmd,
 
 static const struct file_operations lp_fops = {
 	.owner		= THIS_MODULE,
-	.write		= lp_write,
+	.write_iter	= lp_write,
 	.unlocked_ioctl	= lp_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	= lp_compat_ioctl,
@@ -793,7 +794,7 @@ static const struct file_operations lp_fops = {
 	.open		= lp_open,
 	.release	= lp_release,
 #ifdef CONFIG_PARPORT_1284
-	.read		= lp_read,
+	.read_iter	= lp_read,
 #endif
 	.llseek		= noop_llseek,
 };
-- 
2.43.0


