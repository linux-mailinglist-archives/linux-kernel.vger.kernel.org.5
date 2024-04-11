Return-Path: <linux-kernel+bounces-141038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AC78A1A2C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44377282B50
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A3A4503F;
	Thu, 11 Apr 2024 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ToS5Fnlq"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60261CD791
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849944; cv=none; b=Ccqz7gCvkNzj/MnGNN5tBUrHsczQxFz65cUCqbjweM0l6Kc6KGPRjDP7KHH9f8rTLKjgyudgOQs84tSg59dAEWt2a2U+JKzbMPIBNDmvwT7D/MiWBw9hN2azMPm/2IT6y1J6xMABRifSIzESxd93a4v1gybGIn7/oyuJwa2gnMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849944; c=relaxed/simple;
	bh=tEBrsDAZS3Ny8CrlOon0agqSfFrbHui1S0+OBOmhGy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XchoziRvH0JpXZGrJLXRTP9Uqgjc7aAJgjhZ1lunUe5rjN+f5mAkCChZjwdB62s2crqBu+nfxYt7bwBGKDKMbNTr/gTIW9NTK60QIrB/gEMSuhRkFr+n19kd2o/jHN9tS4hK02W9+4z/t0EomA7WZBlWY3IoZ0Og4Ao2lPSsM8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ToS5Fnlq; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so9007339f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849941; x=1713454741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcBnsvHagPaDeZjkv6Pf7/fUmIrYE3dMaGaCiiCnZlk=;
        b=ToS5FnlqXj0ppSnuPNRMoNO5dha6d0b/NLR475rsIsg1FdNusOQiWXblQNWAWFBJjx
         LCyT62qnBRFzSLcj7T5i7Z3Z+/EK+lEo1/cQzn4NmcP3/Y2nBx62NJaHk94KnfbiZaqD
         sLaGFwMp5u2Kd99v+bGU9Uy7Hm29pZ507o82FglYUOOIgAMd6j/zCFOaZneQ/+OJ1LoM
         RlKjqtj9UbptfQX3o455ZjoAW819G2UeDGj40gG1dxNN+DYtHZ5fwdfcJc2q37dYyLk4
         MIBx0H22/IiP6wwm3Eua5fc1WUCNtAm4yIZMtc1EerRbelonwcQBDbVc1SA1+NLliL0l
         vWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849941; x=1713454741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HcBnsvHagPaDeZjkv6Pf7/fUmIrYE3dMaGaCiiCnZlk=;
        b=E48Mtrb+smhjbRwHVMW1z5hq1St26qkCVtdRyJnFKn9W7qkmP02abcKRL5rNnVLqix
         KHCJDz9qBVG0SSMRouEPFJXTmrSUbitoTYEgQrv3jMhIJGHeLlNKXcHD6IaW6F2/IruN
         q4b8Th9AibKcEwQPtSE9cwUE1W1ckK7HoGZK5jGrjo5Nfm6uQx5qX+5yudJtZpD1QVRT
         n+QiAEg1Kek/lTYyVxD2JWWWpB5ct8fJWatgQKqKiD8tyj6AbYTjQC3kig56r3SFWCor
         5XWcVvffm1tiM1DACDMDbcHcZ1LAWw5HVMlZUCBLnK8gGhuFKd2FMkjHGt3ciiC8msmR
         9vCA==
X-Gm-Message-State: AOJu0YxEa4odNPXRaBadc9CCbxv5qBGf9T8sZLlczTm8HLy4LrrY0ZcS
	M6uvN7d/LN7MoD/+OR/HyyRFFH9lS2KxHvvUFcacbLfQyiNiZD6tExjSTu7tvX6hNwDPOahnk6b
	H
X-Google-Smtp-Source: AGHT+IGoRLxw9fldMFTa1V/UIUupj9pXp8w3CdLrfncJy+MvVt0Iq2zQaMv9t+BJzgG44m6TU9yQhQ==
X-Received: by 2002:a5e:9907:0:b0:7d6:751f:192 with SMTP id t7-20020a5e9907000000b007d6751f0192mr188616ioj.2.1712849941227;
        Thu, 11 Apr 2024 08:39:01 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:38:59 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 264/437] watchdog: ath79_wdt: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:44 -0600
Message-ID: <20240411153126.16201-265-axboe@kernel.dk>
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
 drivers/watchdog/ath79_wdt.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/ath79_wdt.c b/drivers/watchdog/ath79_wdt.c
index e5cc30622b12..33320f83c190 100644
--- a/drivers/watchdog/ath79_wdt.c
+++ b/drivers/watchdog/ath79_wdt.c
@@ -146,9 +146,10 @@ static int ath79_wdt_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t ath79_wdt_write(struct file *file, const char *data,
-				size_t len, loff_t *ppos)
+static ssize_t ath79_wdt_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t len = iov_iter_count(from);
+
 	if (len) {
 		if (!nowayout) {
 			size_t i;
@@ -158,7 +159,7 @@ static ssize_t ath79_wdt_write(struct file *file, const char *data,
 			for (i = 0; i != len; i++) {
 				char c;
 
-				if (get_user(c, data + i))
+				if (get_iter(c, from))
 					return -EFAULT;
 
 				if (c == 'V')
@@ -232,7 +233,7 @@ static long ath79_wdt_ioctl(struct file *file, unsigned int cmd,
 static const struct file_operations ath79_wdt_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
-	.write		= ath79_wdt_write,
+	.write_iter	= ath79_wdt_write,
 	.unlocked_ioctl	= ath79_wdt_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= ath79_wdt_open,
-- 
2.43.0


