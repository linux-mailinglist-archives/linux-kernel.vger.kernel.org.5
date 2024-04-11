Return-Path: <linux-kernel+bounces-141008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7AF8A1A14
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 390D81C20F53
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC581C4C46;
	Thu, 11 Apr 2024 15:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="y4UAPSXg"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9481C2FD1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849897; cv=none; b=S3lLyLghJ9tVnsPR+17y3DPFBG6X7rEAdPfvPRBC8DIBtxKy82n6kkuEUMm6k8zFaYlBRDSmLHV99R5gk7z+CitkEm/eVEFbhJaQgpQHN7MZGG9Jef2ccU9ipGg+pywm2ok3gM2ZdjXtRrwulAIvfR6AMU1nJsq2BSAC5lZgOJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849897; c=relaxed/simple;
	bh=CG+fd5YwGcC31BmCXrMGBAeAKLv09/NOtaC12bBDtbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AcPxJmWlNbKHxSrgUd7pwbeBqg9VB6tSk4bv6ZuiS8eneq42r61/YeqZ/jpSs4D3948qVtFzHPPOvdw2XefHmJvsIkceThBamDC+mqsFGua9GLUHYuIWqK+r5c8kZlWSGNREQnrgit+8HQNTFJ1G6EBYnknj8JS0gcaRlMLG+C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=y4UAPSXg; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69617339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849895; x=1713454695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNT64WxlYKBuIztLWlaKGIAGqxpzer/IPML++IxexrU=;
        b=y4UAPSXg8I3hNZ9M3zvFBKvdPuSQTHl1ajIFclz6+JitpW/IMm1PFYMjlJvvvtu6qZ
         oFS/LNuO7uxjUU0Vi5fVoCYun5orqNmcR0u9+MVyuw28B890obXJd6MPN95vqGlqRHGA
         ZeYPoaF+XoKhRPTAqBvOGW1dNSaydqT2uhjYK0lWtyh35qrGpkgpad5oQKbK0l6mAcpV
         JxVXzywnNijLAnwhb3Gw951QEcIkLba15MGrn4y2e4wfBxToQntgmdXgEmVgZhZGkyVf
         8gJW0O3C789qULa0F71oF6G6vTUTt3CrCs5s0FFPZ2IFsgfksBMMWEETmPbG4nJ3yr6m
         CpRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849895; x=1713454695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dNT64WxlYKBuIztLWlaKGIAGqxpzer/IPML++IxexrU=;
        b=KtdP+NVcpxyhJq37hrjIfoTxujmLrSNGM9Y4bd/Xfdp6WKLpXE4eTu3tOu5+DTPcZj
         kLk+Th5HRUret6RMfgahpxhjk4wL1xn+shJRGorFwlGSYQbRbFhOj17PXVJ4HzC1zWss
         qvdOkSYK3wswgPO80z8yOrf3eWGT4cgp6jVk8CM10ndVCPU6PHC9UKzr4i7YhcCSeuzo
         dH9RQwcJgKqyZwm53wORuzKe6kN6NZVQhWrg9S5/E4mxFzpQnqDnw+l5JnyNe4pIRkUt
         Ll8wEsOHc5mKQ1ugYTdNOGAIatzERnvtgJ3Iiw9WpjGRrYPc7h8lY+zznEZjbsRocYVZ
         BPbw==
X-Gm-Message-State: AOJu0Yx1BhLNwKyU99tNEvDX8AEXHaTg55BXfgpr0w6b8fp5BjLtVTjP
	0DtRUXv+hgb0RZPI2nRcQL/udaHiTtGZhBYbtL1GaJhFEfnNRg5nh2RP5FLqb3/+xr49yauligR
	x
X-Google-Smtp-Source: AGHT+IFAeoOifF/OpoDvfzQMl3mIrl4iWDmasa5z7XH62rNh074ViiRIYsS1O/nTPpsFbWWHderVxg==
X-Received: by 2002:a05:6602:84:b0:7d6:9d75:6de2 with SMTP id h4-20020a056602008400b007d69d756de2mr46624iob.2.1712849894771;
        Thu, 11 Apr 2024 08:38:14 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:38:13 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 236/437] watchdog: alim7101_wdt: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:16 -0600
Message-ID: <20240411153126.16201-237-axboe@kernel.dk>
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
 drivers/watchdog/alim7101_wdt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/alim7101_wdt.c b/drivers/watchdog/alim7101_wdt.c
index 4ff7f5afb7aa..5a85f53542d9 100644
--- a/drivers/watchdog/alim7101_wdt.c
+++ b/drivers/watchdog/alim7101_wdt.c
@@ -181,9 +181,9 @@ static void wdt_keepalive(void)
  * /dev/watchdog handling
  */
 
-static ssize_t fop_write(struct file *file, const char __user *buf,
-						size_t count, loff_t *ppos)
+static ssize_t fop_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	/* See if we got the magic character 'V' and reload the timer */
 	if (count) {
 		if (!nowayout) {
@@ -196,7 +196,7 @@ static ssize_t fop_write(struct file *file, const char __user *buf,
 			/* now scan */
 			for (ofs = 0; ofs != count; ofs++) {
 				char c;
-				if (get_user(c, buf + ofs))
+				if (get_iter(c, from))
 					return -EFAULT;
 				if (c == 'V')
 					wdt_expect_close = 42;
@@ -290,7 +290,7 @@ static long fop_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 static const struct file_operations wdt_fops = {
 	.owner		=	THIS_MODULE,
 	.llseek		=	no_llseek,
-	.write		=	fop_write,
+	.write_iter	=	fop_write,
 	.open		=	fop_open,
 	.release	=	fop_close,
 	.unlocked_ioctl	=	fop_ioctl,
-- 
2.43.0


