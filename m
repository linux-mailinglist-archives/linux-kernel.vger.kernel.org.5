Return-Path: <linux-kernel+bounces-141019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF47E8A1A1C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B956281772
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DEA1C78A8;
	Thu, 11 Apr 2024 15:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WffN6EoQ"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9A31C78A3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849913; cv=none; b=R3Qfqt1NEpCv/9HeQrbKPnCoS4cDhXVRdL7LnnmhAvcDoVx/auZGVk0UYgZQov7u38STSLolvYJ0WNKSp/RGy7KR+K9WK6R2Cy3EncM15r9pLxuWlZ0DUoFo/BZTzuOxll4oD035V1u+/+uacKObkuzX7yKrgs+CwJ6N+KugEXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849913; c=relaxed/simple;
	bh=BasxfhQEod1bJbCsdbb2lOU/at88LePhdvuBSWPDt+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ul7CME5s3/manVRHZkkhJlT1/Zt9tWdpfU7oF0c4wRj8WGC5qPPCIgrOiU9uoedIhWF2rUQBjmOh5nJMRhpG2fhKz/lC6oXaV4RE7/Qec/4SCuARQeeoLhP9ukrVWzRrke1AyNYUjVeDruQFsLH14wgFgRFLisZEHTBwOb3Hbpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WffN6EoQ; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so8995639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849910; x=1713454710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wyltxKqyWDKiScpm9eN+uoTYMnZ87KTKt8KHo7rP74=;
        b=WffN6EoQNThbn27nDgh3ZhwR9HzUyCr7FBcnuEHijBqFoZYeTSADnlieE8ifYfWXvC
         k6AyuYku4yttTRiWQwzxH+6WDiw+4dcQWTSFur6UdcSIt/k6hggAkIf16dKBGa1CvAnk
         db8Eeq5SFI2cLjUd3yg5D73T3DUrt3qrAlc8GWj1wZCuqr73KCVgaiqDi7KUJTqpcWfD
         K2Bs3BV2H5FFw1TxUcaxJ64Wkcnj12vzjQIKuTj/VAPBzP+DkldjA8+cdzvESPDTlGiG
         QlQXnazOqMW9yC/UsbV4bISp2zGdgJhT/Fcw+ISekjAUE0aOySZlKqyVYupaqMAX4I9G
         fBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849910; x=1713454710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5wyltxKqyWDKiScpm9eN+uoTYMnZ87KTKt8KHo7rP74=;
        b=J+2nL1UQJ0ZWjvWLXOHLp7wAWD8FsEcgvKcE23NM3bvy4EFgQOiFOxRb54Hat35Tz4
         ieuSkx3BB+HcMWC276VMU8pB8oWPQd8i+eAMIfIAthqtLLr/2xPUePrarRsgY01WT9pK
         j4P92LAnEVtAMzh/PA/a1eykxWpYzkluTWnbWRS2pRhXbTHD/p1i1FPWxx/POwLpQF8S
         t7eKu6o6fgnZ+tiI+Ixc7SG9fHtE8UbaXjP1Byk+W9LqVc8mH4ke7oAinWBEp1+tvFnJ
         vUACzd6nh0OBs+sHH+vUTjfkoYLMFkaQtELTIzImGXIhgqo3g5kHihxfjl+21qiBqou2
         tZHw==
X-Gm-Message-State: AOJu0Yxx0vsCl2vKbm73o7cnqwtUf4JknYZr0fxH8jn6uTQqrE9RVUhA
	26uISbgv5y3teV2SZYLaOarTuSyzD99Um3D1J/b7iLZgo8uk6C4ZRejr9XdkSl7pURfOxkOMOjC
	M
X-Google-Smtp-Source: AGHT+IHgbydv83su+kgFyC6+IcuI6zRw/TO/axqCwmPZRj/J1EA/dAJi7AAFXUYX3xeR5zxVdpX4rQ==
X-Received: by 2002:a5e:9907:0:b0:7d6:751f:192 with SMTP id t7-20020a5e9907000000b007d6751f0192mr187141ioj.2.1712849910038;
        Thu, 11 Apr 2024 08:38:30 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:38:28 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 246/437] watchdog: nv_tco: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:26 -0600
Message-ID: <20240411153126.16201-247-axboe@kernel.dk>
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
 drivers/watchdog/nv_tco.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/nv_tco.c b/drivers/watchdog/nv_tco.c
index ac4a9c16341d..e9535ba7eba7 100644
--- a/drivers/watchdog/nv_tco.c
+++ b/drivers/watchdog/nv_tco.c
@@ -174,9 +174,9 @@ static int nv_tco_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t nv_tco_write(struct file *file, const char __user *data,
-			    size_t len, loff_t *ppos)
+static ssize_t nv_tco_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t len = iov_iter_count(from);
 	/* See if we got the magic character 'V' and reload the timer */
 	if (len) {
 		if (!nowayout) {
@@ -194,7 +194,7 @@ static ssize_t nv_tco_write(struct file *file, const char __user *data,
 			 */
 			for (i = 0; i != len; i++) {
 				char c;
-				if (get_user(c, data + i))
+				if (get_iter(c, from))
 					return -EFAULT;
 				if (c == 'V')
 					tco_expect_close = 42;
@@ -265,7 +265,7 @@ static long nv_tco_ioctl(struct file *file, unsigned int cmd,
 static const struct file_operations nv_tco_fops = {
 	.owner =		THIS_MODULE,
 	.llseek =		no_llseek,
-	.write =		nv_tco_write,
+	.write_iter =		nv_tco_write,
 	.unlocked_ioctl =	nv_tco_ioctl,
 	.compat_ioctl =		compat_ptr_ioctl,
 	.open =			nv_tco_open,
-- 
2.43.0


