Return-Path: <linux-kernel+bounces-140892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6398A196E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AF07285F8F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2F215B54D;
	Thu, 11 Apr 2024 15:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SE5dmby6"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFB815B121
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849720; cv=none; b=VvlXHUqhOKnuqMVG0sJl1aeldcimLL91/hqo7vQmyJvY957XfutPiET24t3yMiGwubUkqTFNeixhJOEbeWVsbxIBz3D8Lj7wqFoIBp63JR1oF8otJC7mUd0qNNUHHM2vtg1FiErNirCmBCaFt0ql6yXWvwGeCga0s0f1YjFdiEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849720; c=relaxed/simple;
	bh=P0NNmVvFozABePjRY+cBG5x7/KqBzLJ3jca23b6AlIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLuIBHdEBcbFcYuVNr4Zn6mI4BfwWhgtTYTL9Ls2TId9MsuNDMNjjWdGBUUjR6k8Pm/ydLAdVVmxKLxxI65mRRTykoWktRTktIf61wwCleyco2CHYB98ln41Avta7Xp0iA2+ikp9vS6q844JehWoclITfvlbXW9LDs+L3/3LQNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=SE5dmby6; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7d5ed700c2dso16144339f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849717; x=1713454517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4kHybulFFZFm/7MW260ESVK0sJApfJJm6OZp93RPlg=;
        b=SE5dmby6+87g6l6ORchio3jmHMHaJGEj+URZh27YLExfbTQMVRwzZiP5QtK3VEr6Vz
         V6FwwKsboeyniKyZEcU6GyICcP2sS0TBlKabip7vq29bVnN4xF0poyQCeCa5anCQgYl/
         s0IvrG0E0hO1Q6PAmEVG47EEre9p5qI0BmiTz4VuxCfWBxQgEdeLZtWiacbKSCJIiy3R
         LR86v9k4lg2iScaK9e533Y5zwipIxq9iGfYMoO30tf/VhuNEVzta6ymU1+BIDpXg3wcf
         GoFOdmmwjZfU7u6U4srKdN0xvuETsbjak4JADOzo3Qkk2ZxqSEVjf65SiAIJPkS8qngi
         CN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849717; x=1713454517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4kHybulFFZFm/7MW260ESVK0sJApfJJm6OZp93RPlg=;
        b=EaEuYs7RwY9uxukVtYNcIAtbu8yuBmiGO4R4r2cyVSQSFN3sLXs1p1vJ1EYCKx1tKi
         9pGVB5Glpvq6mkxHm626XM3L5jX198oX9x2el9tpZOQm+UtXeDE0MGFb/uboVd7Tl3X8
         rTwUd4sPyyXCH9C+oKQFpNj4lbQBqJYRdiUdBZ5soqQ5L09nKmJT7dd/VL6WCt9bWFqu
         cB4b4jeF7VVjryfR5PFvo8HDRcjGXZXmllGlv7hUZ3zDGgVoGG2+rqbUcZHO6SOssXC4
         phJQDoYvYFTvcxvLdJJu+5Z8mVcrWz4vXiqmMQ7WQLwd3/dZTAPlFrFLOKrQV//YFGPP
         g0tQ==
X-Gm-Message-State: AOJu0YyuknFLxxefWCkOrnATbk0G/uhkf8kLl7zB/29z3phWyrpKt453
	A1BKZIF/4moMy1Y37XwYcSL9N+nmsQZNUHgHL0dfuUxjYvVwjkQj+kSdgBaOUxuSZjR79797kZb
	J
X-Google-Smtp-Source: AGHT+IGYKWFNm2M5s9UXmAJ4x8vSN/4jPwmUd1quk2CEx6w9hQGQ1aulJw+D3EaZILGgKzKexY2jMg==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr158954ioh.1.1712849717585;
        Thu, 11 Apr 2024 08:35:17 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:35:16 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 128/437] firmware: turris-mox-rwtm: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:28 -0600
Message-ID: <20240411153126.16201-129-axboe@kernel.dk>
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
 drivers/firmware/turris-mox-rwtm.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/firmware/turris-mox-rwtm.c b/drivers/firmware/turris-mox-rwtm.c
index 31d962cdd6eb..c7733f4b9bd4 100644
--- a/drivers/firmware/turris-mox-rwtm.c
+++ b/drivers/firmware/turris-mox-rwtm.c
@@ -330,14 +330,14 @@ static int rwtm_debug_open(struct inode *inode, struct file *file)
 	return nonseekable_open(inode, file);
 }
 
-static ssize_t do_sign_read(struct file *file, char __user *buf, size_t len,
-			    loff_t *ppos)
+static ssize_t do_sign_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct mox_rwtm *rwtm = file->private_data;
+	struct mox_rwtm *rwtm = iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(to);
 	ssize_t ret;
 
 	/* only allow one read, of 136 bytes, from position 0 */
-	if (*ppos != 0)
+	if (iocb->ki_pos != 0)
 		return 0;
 
 	if (len < 136)
@@ -347,18 +347,18 @@ static ssize_t do_sign_read(struct file *file, char __user *buf, size_t len,
 		return -ENODATA;
 
 	/* 2 arrays of 17 32-bit words are 136 bytes */
-	ret = simple_read_from_buffer(buf, len, ppos, rwtm->last_sig, 136);
+	ret = simple_copy_to_iter(rwtm->last_sig, &iocb->ki_pos, 136, to);
 	rwtm->last_sig_done = 0;
 
 	return ret;
 }
 
-static ssize_t do_sign_write(struct file *file, const char __user *buf,
-			     size_t len, loff_t *ppos)
+static ssize_t do_sign_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct mox_rwtm *rwtm = file->private_data;
+	struct mox_rwtm *rwtm = iocb->ki_filp->private_data;
 	struct armada_37xx_rwtm_rx_msg *reply = &rwtm->reply;
 	struct armada_37xx_rwtm_tx_msg msg;
+	size_t len = iov_iter_count(from);
 	loff_t dummy = 0;
 	ssize_t ret;
 
@@ -385,7 +385,7 @@ static ssize_t do_sign_write(struct file *file, const char __user *buf,
 	 *      stored by the rWTM firmware.
 	 */
 	memset(rwtm->buf, 0, 4);
-	ret = simple_write_to_buffer(rwtm->buf + 4, 64, &dummy, buf, len);
+	ret = simple_copy_from_iter(rwtm->buf + 4, &dummy, 64, from);
 	if (ret < 0)
 		goto unlock_mutex;
 	be32_to_cpu_array(rwtm->buf, rwtm->buf, 17);
@@ -426,8 +426,8 @@ static ssize_t do_sign_write(struct file *file, const char __user *buf,
 static const struct file_operations do_sign_fops = {
 	.owner	= THIS_MODULE,
 	.open	= rwtm_debug_open,
-	.read	= do_sign_read,
-	.write	= do_sign_write,
+	.read_iter	= do_sign_read,
+	.write_iter	= do_sign_write,
 	.llseek	= no_llseek,
 };
 
-- 
2.43.0


