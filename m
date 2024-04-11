Return-Path: <linux-kernel+bounces-141005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD928A1A12
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2980282A24
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3881C42DB;
	Thu, 11 Apr 2024 15:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="PYrXGQJd"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF111C2FE5
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849892; cv=none; b=FIMhZkz12RGmLFD44sPdGaook1eY6HwtlcdQ3t8xPe3ThNXA4vpyeV9vDZjuJsPax/TfYaOdcdZTAZd/NgMtPa/Wc0Cb+kLZsD5AfgoI172v3Ax+0UTql5NEIryleGaHoIqU2ER7MFKnMWi1+/sULchDwM1W7h542Iw7AUfNKo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849892; c=relaxed/simple;
	bh=I008nlz7hMIwHwSINpFNSBgOki5AL1aXDldRxzQYz70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lBzC59Yrm+s9pr/MtkEJqkXLxFlRgf5vn6UzyLTL2xugO04Uj2d1hKqirzrjKKzZRobKVzKvYTVq9+3E2teldP8ZWgLVuCAE4UwwPgvVvPoDu50S0IbmKoTvP/iBCIjxcP0ncXrBXSlt1NdDOTlVmOBxmuQoqQ2Uwt1gHHtCYRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=PYrXGQJd; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58122039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849889; x=1713454689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lLImXXFpvamki8Dp2j4GmpSOc49UTRYWPsz9Jb4zBA=;
        b=PYrXGQJdgrOoRVuTwoAQ/lBvmnxSAK+f8fE/QI9CN+T1pDSCofaIXEBSRbVEqeGL6N
         dzo9g8n3ylxr4rDWvIT56SYVHNrBiNIOp9FygZFxfDJocrLmgly8N5KMzcRDmLSqEZ6F
         1m7MXWq9oAu6ZooAge9d7HqCWfjZ/NKlLMwpCrqt3CVzoc/shDZ3r8EEwv3ZfY4lsYVa
         wHjnrNRQol+I1DEYluSVdjQ4lPrP+hAjo8CO7TPFclypODGrXJTgU3CyR8skozO2zcXZ
         2SPIJVIhbqadTfJGgs6WrqpIOLeG7kfCUX0CxeeHLv3wwdqsrTKc1fInkLEibtXG/lcr
         ymBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849889; x=1713454689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9lLImXXFpvamki8Dp2j4GmpSOc49UTRYWPsz9Jb4zBA=;
        b=oqDy6TYH5d+RrVTPOIyWeRSSHdV6ocWl0Aw+eSNTo/M73o1P87b4P5ET99uJ7FPgWq
         uvWt2VTD0FiNSkKQCpJr5BG/Uvxz7BYMa9xx8H2pB0t6xDAcmdu1iQ8V/op2TzBPHUJP
         BM9MNumh4WhdGAV09+HtNMzI6jBVgKieI4k3w4f7GTqYrsCs0HRxaUXITwei9yIQ8SYe
         1v31xlHsNqGyEWNIc6d4EdtIwMGBjKDfN3cFMktQC7oallK43bM7mp+p702rwMciI6yO
         jdAlRZEqJJUV2X1jdHvxqlmmibVUlH+JOrtwWCnOepKq7Dn1k+SplNjrMsI//NvBQO2W
         F6GQ==
X-Gm-Message-State: AOJu0YyPXKaKgBGFJ//kKZoKXQQMZ1XkhaDGoLkKuThTZqsnrYKAkwI/
	ycijUUof3oe3QqsW+d/Nup47WJv9muwfH4/EROG08ZI6gD1jjEsjoCA/4UPx5EJe5fRWGqhzNuQ
	h
X-Google-Smtp-Source: AGHT+IFb0BrpOrAko9/+CF8RMEsOfyF47lvXP0onZh9YPbf0Gcw1a2F20SLH4zq+2rGd9jHsAwA+pg==
X-Received: by 2002:a6b:cd08:0:b0:7d5:fe3e:90ff with SMTP id d8-20020a6bcd08000000b007d5fe3e90ffmr207124iog.0.1712849889399;
        Thu, 11 Apr 2024 08:38:09 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:38:07 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 233/437] watchdog: acquirewdt: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:13 -0600
Message-ID: <20240411153126.16201-234-axboe@kernel.dk>
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
 drivers/watchdog/acquirewdt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/acquirewdt.c b/drivers/watchdog/acquirewdt.c
index 53b04abd55b0..cdc27fc68f4a 100644
--- a/drivers/watchdog/acquirewdt.c
+++ b/drivers/watchdog/acquirewdt.c
@@ -114,9 +114,9 @@ static void acq_stop(void)
  *	/dev/watchdog handling
  */
 
-static ssize_t acq_write(struct file *file, const char __user *buf,
-						size_t count, loff_t *ppos)
+static ssize_t acq_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	/* See if we got the magic character 'V' and reload the timer */
 	if (count) {
 		if (!nowayout) {
@@ -128,7 +128,7 @@ static ssize_t acq_write(struct file *file, const char __user *buf,
 			   magic character */
 			for (i = 0; i != count; i++) {
 				char c;
-				if (get_user(c, buf + i))
+				if (get_iter(c, from))
 					return -EFAULT;
 				if (c == 'V')
 					expect_close = 42;
@@ -219,7 +219,7 @@ static int acq_close(struct inode *inode, struct file *file)
 static const struct file_operations acq_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
-	.write		= acq_write,
+	.write_iter	= acq_write,
 	.unlocked_ioctl	= acq_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= acq_open,
-- 
2.43.0


