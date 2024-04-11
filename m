Return-Path: <linux-kernel+bounces-141040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7898A1A2E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02E4D282E83
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E3D1CE153;
	Thu, 11 Apr 2024 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="iknL07PA"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54851CCEFC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849946; cv=none; b=BuKbgvgxmuFMkX7JpnyIO48EjGFsR7qzDPW9/8npyYT7gpEDLGzF+4c3Ft4pYk6tVCL0fWIpsb8Iy9+TXD2LnFrB/hWmF4EM2zuPtkz5bV+TqVERLGAQwbHhicNtn17uMw73AVnxzcbygx+2mVB3f7FxUO+1Cz509TtqWPGhZ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849946; c=relaxed/simple;
	bh=C/kcR+2TmhsL/54XIKPsKZnfpufS58ky2N3uJgGsAY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNb5ZOxHBwTbbnpAD7L/2V+EBaAXybINZyV8ke95/ypqxVDPpx+i46qmpYy3HDJKVtMX0yj6pniqjyAk9H44OEmq0PDPrSQ/N5fog452Zi1r2BujwFb3G0JdyMJi7Al/vdcrdjFOaNupud6BfSN77iYxlGMAHI3/dK2H2umTlr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=iknL07PA; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-36a34b68277so115215ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849944; x=1713454744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mW1Ga2j4WmUcn8NPaIMNg4g8DxrNk3iZBbEGDGb7W/Q=;
        b=iknL07PAvG01EuSYcPWoBI1pRoT+UbwbUXqCvb8TjLrYKccE8y7iUTxExmr3oLYE7S
         75BECi5ugyphTfElrL/JG96u1sMo2mmz3TJC3QfL9yEQz8eQa5zBDXBHYTUK5D2Ba+2U
         FzHUooyZkZ00dpOBk2SyyxBEei1XS1nMzNvWJkznTTGktNCZOma0ywvcj6Qw3f3QC7C2
         xul4qr5vzznFdAekcXrWZlQX/OmSOqBE4iqEhD+cj6fJk4YTzhMTkmV6Ebh32E2JD713
         HS5geBF7MRP7IA7dL0R7tNsDacuQr0J2NXA9/mRrlVZ1aN/NlxW2+lliMiwSJIcr8uvq
         dpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849944; x=1713454744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mW1Ga2j4WmUcn8NPaIMNg4g8DxrNk3iZBbEGDGb7W/Q=;
        b=lLz5xQ9OirADkPtyBC+7cusrumcGPTyBAqQmOA9aCGH8f2Smcwjkzec0LJLRlz7v2K
         SclephmKLyeDTZSmyO3HVQyoCdxXXMwtAVs8hN28CAfCxxBbYdQuHBReMuoVywXn0Flb
         vjjOSO/fg3TlSx5ss0Ea2HkAOpNyBVuD+dP8/hMupPcnJnKz+12mL09t/qyO62R2JYEg
         05q7JdYlNMMHjOLacrC8TIqBCweF/fOff/3z3w25S2YITvigSTKlcuYkPDEMfNfGuaGO
         zCouG3WGD0BtyRBMPKvj3+8YhefCA/DZdy1y+WSSmlIEIWCAHzygwYDSWhjkNUS4U+8M
         gDPA==
X-Gm-Message-State: AOJu0YwmjAE1pMeelE3wmblMamJPT4kve4o5c0Ijqoo6yps95Yja5k21
	f+EMA4OKuTgGjxLPFTcbpWHDk0BQvtrWl9d6q1gozEQegSLRGWpaNA96KvfnsE/stMjcPh/SHoE
	k
X-Google-Smtp-Source: AGHT+IFxCFU+fwD3VfcXuRxpCy4cNHfQ6+sBajCToN/4moqVePjcMdzp/LG6DzYv7mNM8gKaA9LeDw==
X-Received: by 2002:a6b:6605:0:b0:7d4:1dae:da1a with SMTP id a5-20020a6b6605000000b007d41daeda1amr155858ioc.2.1712849943753;
        Thu, 11 Apr 2024 08:39:03 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:39:02 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 266/437] watchdog: gef_wdt: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:46 -0600
Message-ID: <20240411153126.16201-267-axboe@kernel.dk>
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
 drivers/watchdog/gef_wdt.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/gef_wdt.c b/drivers/watchdog/gef_wdt.c
index 6a1db1c783fa..c946fd169966 100644
--- a/drivers/watchdog/gef_wdt.c
+++ b/drivers/watchdog/gef_wdt.c
@@ -132,9 +132,10 @@ static void gef_wdt_set_timeout(unsigned int timeout)
 }
 
 
-static ssize_t gef_wdt_write(struct file *file, const char __user *data,
-				 size_t len, loff_t *ppos)
+static ssize_t gef_wdt_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t len = iov_iter_count(from);
+
 	if (len) {
 		if (!nowayout) {
 			size_t i;
@@ -143,7 +144,7 @@ static ssize_t gef_wdt_write(struct file *file, const char __user *data,
 
 			for (i = 0; i != len; i++) {
 				char c;
-				if (get_user(c, data + i))
+				if (get_iter(c, from))
 					return -EFAULT;
 				if (c == 'V')
 					expect_close = 42;
@@ -246,7 +247,7 @@ static int gef_wdt_release(struct inode *inode, struct file *file)
 static const struct file_operations gef_wdt_fops = {
 	.owner = THIS_MODULE,
 	.llseek = no_llseek,
-	.write = gef_wdt_write,
+	.write_iter = gef_wdt_write,
 	.unlocked_ioctl = gef_wdt_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.open = gef_wdt_open,
-- 
2.43.0


