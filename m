Return-Path: <linux-kernel+bounces-140941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B086A8A19BB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE8EB1C22D42
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901D919DF42;
	Thu, 11 Apr 2024 15:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="U2k3S9j3"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D7620010A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849792; cv=none; b=TS3Sz8n0/1jJiGvYrACiBjl1pwy6rMu8Krngjld+ns8KkC30kUnztd/+tOs2f36EWgJxqdVyVlV+EgheED61JvdqDDwAKWnLRrK2y91ETiMHLDxRSuzhHbG3nj61EdkM2dNoCQHJg1qZl9mf71l1ZT4M+Qzzy09s1f6rviaupLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849792; c=relaxed/simple;
	bh=cUN4vPgeh8WHEDDgOp1Um0NiSnS/1lT8hVPX847W66g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kxeyk5tSaI9UtwgZb7QdJtAWQ3bW/countGNm9A8UTS4E6Sx1Yxdr9o6V6TbkmYqxOf5NxMxJWK5sR+BibZrjPX0nzLjMboRfHGe+M85D2hGL6Wa0Y6zRmW72JSKhp1VYjV+Zo57wdDn3aYAvIFYlACEZePVIZyt+LZeUM1qDao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=U2k3S9j3; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58081739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849790; x=1713454590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1n7x/bP1FzpoPd9w3gudZwD48yNX49oAPai9XETXG0=;
        b=U2k3S9j3bweM4ON/sC3k+4Zy+nn3ITAQMLXm8XfvANt0JIa6q2Q2GH2mRx/eSV2uEi
         cfgzpnGzfQA5AFRZZXpNS0wOcN77cM0xu9GKwrpJ97YcuUZa2rN6eINp0gcHxDAhyRuS
         W0odti0kYvk4D3OSu/TSXu1kAqpspxfQzWRRhCU3UzOOX82jjmo4/rOZPttXI0lRnYiq
         RHt6MVsXWGG6YaymYlVYmZZKCMKEexGPtrkBBd54ncSwV9iX35JmeyBeEDDSrhcDRrmB
         SULdr0eSggX1ITH7P75OKXC93pVsL5lGjVmcq9re8PBmVrMWR5lH8AI57MALtNOzl9Xu
         KvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849790; x=1713454590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1n7x/bP1FzpoPd9w3gudZwD48yNX49oAPai9XETXG0=;
        b=aBBYoqmlXmMs9dOuWF1boqKL9gG3JW64ReGPYiA+uaCjdedaFC0pncnGdHA+u1ne2P
         ZORYCDU1jKZOQszQz/GsJ+s24J+7odC9uYvnJuOwNvKmYi8IakRJf/yvvV+NflQ1qfL5
         TZ6RikCjGwueinO3XhgPsQZsoKGgmN+cxZ7sNBaPfHQZ0BrFiGGWNxeShPDUKbXZ4qus
         D2p16TFr40M+w8zKP/N0kf40Bb27boIj7D6PnuTmRWBRTswMUK1G/9/qhUbZm8t/gtx8
         5X7TTN5d8Am0kC8IDiSMy77UEdJGWO79cl/k3oLNI5FaKfggIESGLq2KsWKC2oqJz3jB
         A02w==
X-Gm-Message-State: AOJu0YzRsmCIdzeGIyFtC3QkfbxuLWSFiyFXbgilSqkFQtlg0NpW0Rc3
	uACjroKcvXfsA3XE0owB5mDwtbMNoqBJ1JGh6vEoAI6JzKkFy830fwCEjFS2EpXMKWXjuWcuanN
	J
X-Google-Smtp-Source: AGHT+IE2+eglmMAHovhJa7gAQn430CIIcXkKY1JhjgiSSTztp1OyAEdYdNkCgTv1MnfihD1SdZtFGw==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr185709iov.2.1712849790450;
        Thu, 11 Apr 2024 08:36:30 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:36:29 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 172/437] usb: skeleton: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:12 -0600
Message-ID: <20240411153126.16201-173-axboe@kernel.dk>
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
 drivers/usb/usb-skeleton.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/usb-skeleton.c b/drivers/usb/usb-skeleton.c
index 900a64ad25e4..f039a13382c1 100644
--- a/drivers/usb/usb-skeleton.c
+++ b/drivers/usb/usb-skeleton.c
@@ -221,14 +221,14 @@ static int skel_do_read_io(struct usb_skel *dev, size_t count)
 	return rv;
 }
 
-static ssize_t skel_read(struct file *file, char *buffer, size_t count,
-			 loff_t *ppos)
+static ssize_t skel_read(struct kiocb *iocb, struct iov_iter *to)
 {
+	size_t count = iov_iter_count(to);
 	struct usb_skel *dev;
 	int rv;
 	bool ongoing_io;
 
-	dev = file->private_data;
+	dev = iocb->ki_filp->private_data;
 
 	if (!count)
 		return 0;
@@ -251,7 +251,7 @@ static ssize_t skel_read(struct file *file, char *buffer, size_t count,
 
 	if (ongoing_io) {
 		/* nonblocking IO shall not wait */
-		if (file->f_flags & O_NONBLOCK) {
+		if (iocb->ki_filp->f_flags & O_NONBLOCK) {
 			rv = -EAGAIN;
 			goto exit;
 		}
@@ -301,9 +301,9 @@ static ssize_t skel_read(struct file *file, char *buffer, size_t count,
 		 * chunk tells us how much shall be copied
 		 */
 
-		if (copy_to_user(buffer,
+		if (!copy_to_iter_full(
 				 dev->bulk_in_buffer + dev->bulk_in_copied,
-				 chunk))
+				 chunk, to))
 			rv = -EFAULT;
 		else
 			rv = chunk;
@@ -356,16 +356,16 @@ static void skel_write_bulk_callback(struct urb *urb)
 	up(&dev->limit_sem);
 }
 
-static ssize_t skel_write(struct file *file, const char *user_buffer,
-			  size_t count, loff_t *ppos)
+static ssize_t skel_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	struct usb_skel *dev;
 	int retval = 0;
 	struct urb *urb = NULL;
 	char *buf = NULL;
 	size_t writesize = min_t(size_t, count, MAX_TRANSFER);
 
-	dev = file->private_data;
+	dev = iocb->ki_filp->private_data;
 
 	/* verify that we actually have some data to write */
 	if (count == 0)
@@ -375,7 +375,7 @@ static ssize_t skel_write(struct file *file, const char *user_buffer,
 	 * limit the number of URBs in flight to stop a user from using up all
 	 * RAM
 	 */
-	if (!(file->f_flags & O_NONBLOCK)) {
+	if (!(iocb->ki_filp->f_flags & O_NONBLOCK)) {
 		if (down_interruptible(&dev->limit_sem)) {
 			retval = -ERESTARTSYS;
 			goto exit;
@@ -413,7 +413,7 @@ static ssize_t skel_write(struct file *file, const char *user_buffer,
 		goto error;
 	}
 
-	if (copy_from_user(buf, user_buffer, writesize)) {
+	if (!copy_from_iter_full(buf, writesize, from)) {
 		retval = -EFAULT;
 		goto error;
 	}
@@ -467,8 +467,8 @@ static ssize_t skel_write(struct file *file, const char *user_buffer,
 
 static const struct file_operations skel_fops = {
 	.owner =	THIS_MODULE,
-	.read =		skel_read,
-	.write =	skel_write,
+	.read_iter =	skel_read,
+	.write_iter =	skel_write,
 	.open =		skel_open,
 	.release =	skel_release,
 	.flush =	skel_flush,
-- 
2.43.0


