Return-Path: <linux-kernel+bounces-141007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F898A1A77
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4BB9B27982
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DB21C2FE5;
	Thu, 11 Apr 2024 15:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="3NnQ0aWO"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6813B1C42EC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849895; cv=none; b=K44UOPnKLM5GHo4A5Zc1pucCz3O7Iy2bhuz+zM4JDzlxn8NiVX353iR/Rqhjke7CSEzUQF9wFc9Z5c2TUgcl/LfQkRa6AEzimjZ4I7+nT7SbmFl0v8PUM5ZtbmJFGUeXfNjd3kRnBJ9By5qzZWDwpMCf+VLksY69A0jsItwAy9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849895; c=relaxed/simple;
	bh=cqP6/eNNDYGKZNeUngaOLUPMxWLy3k/FtRZC7c9+8g4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PfofKZ4OEqn/6JYbfd+oeoGhXN1fn/rAj0DvzZvQs75vSVR/i5In3beXe/ivJX5lxj2bMf1GfMGphKetEButGb7wVtxIBAq4g20R3xHUdDo3fqnQHtMY7EbhelP0gMGOobjaD6cZ8Py0bYV/97GF+y0y96JYkmdkuSFPagAU3U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=3NnQ0aWO; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58123839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849893; x=1713454693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhAbVJ2K5jbbaJhnUs+1XH0nElLiKOnDW3DkM0X7Oes=;
        b=3NnQ0aWOlNQ1tJ6so8YQQAoyaLgsOdRcRa8mgENURixlg+zHUzvxP9QPBhVvsWIjA4
         32kXpuF8SuW5E43qxfS/rLYPgQgL3v5c3F6WW90pQii+RELpFDiPxHhLlYo8MeuIzuKi
         o2IwwQn3bu4YiMFZ3U0nEno4WJ0NRZBkrKOkZW1TPvjvA1WV0KrNpFX7Pl96Cf/TJtSE
         HuzKixLsrP1ARttQulGfszilpjhKQxW2kMgtrRtsKgJk1XyXaR1nH76p8JakWysZ2MLh
         ehFK8t8yzDAacDR8t+C1OwY9erDGDodxkiwfSFW18T/svLX1YSMfbP9qkYcJjomOlPSZ
         blgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849893; x=1713454693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PhAbVJ2K5jbbaJhnUs+1XH0nElLiKOnDW3DkM0X7Oes=;
        b=YSEGG0fSF0RbwJHcyuAITbj5rp3wIAe1u5DlHbw/L587P9WVeVPtJRYPJnIgUW8Diu
         ozmzQGEEQvAMzTIEPVQijt1CNca73yUxui+868DeUjpBEz2Gbi/VNbtAM2Iyxwv1B+HB
         rCTbsbdmBUu0TIlafrxslfgZWli0GUc6R8q3xvn/YBMgfhh/dZBd4nyxn3xK1kcyHWWg
         97JF93MuFAMHXkRdzVgbm7KZqTffOdcdnw7AccjnEKwxPS3sgxARsjyvxsCh36Ts/mac
         fuAtU/wMipF141GAB7R25c5K9gBNG3KHrendfQOiu5VGHSuZiaoWDpVD5SJn19qUXHyH
         WA6w==
X-Gm-Message-State: AOJu0YwaNoVirrHbp5S7OR2wXJLMdKHo2oZGa7ZIk0IdZFjQeloxFdCZ
	0ecUW52v4DpCtO0dwjbbD0DM+Vx2Vdqc7+qMd7xJL0rdJIpegAyBICM3ZEZmFZW/4I3wl4gO+SQ
	6
X-Google-Smtp-Source: AGHT+IEmVqndftm9s+1W6nV93kdj13j2PFB3OLU+/xhDG2PSZIulIz81ewUJuSmSsBd0BL+yB+NB3g==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr191262iov.2.1712849893064;
        Thu, 11 Apr 2024 08:38:13 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:38:12 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 235/437] watchdog: alim1535_wdt: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:15 -0600
Message-ID: <20240411153126.16201-236-axboe@kernel.dk>
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
 drivers/watchdog/alim1535_wdt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/alim1535_wdt.c b/drivers/watchdog/alim1535_wdt.c
index bfb9a91ca1df..9a12706d9cdf 100644
--- a/drivers/watchdog/alim1535_wdt.c
+++ b/drivers/watchdog/alim1535_wdt.c
@@ -134,9 +134,9 @@ static int ali_settimer(int t)
  *	the next close to turn off the watchdog.
  */
 
-static ssize_t ali_write(struct file *file, const char __user *data,
-						size_t len, loff_t *ppos)
+static ssize_t ali_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t len = iov_iter_count(from);
 	/* See if we got the magic character 'V' and reload the timer */
 	if (len) {
 		if (!nowayout) {
@@ -150,7 +150,7 @@ static ssize_t ali_write(struct file *file, const char __user *data,
 			   the magic character */
 			for (i = 0; i != len; i++) {
 				char c;
-				if (get_user(c, data + i))
+				if (get_iter(c, from))
 					return -EFAULT;
 				if (c == 'V')
 					ali_expect_release = 42;
@@ -360,7 +360,7 @@ static int __init ali_find_watchdog(void)
 static const struct file_operations ali_fops = {
 	.owner		=	THIS_MODULE,
 	.llseek		=	no_llseek,
-	.write		=	ali_write,
+	.write_iter	=	ali_write,
 	.unlocked_ioctl =	ali_ioctl,
 	.compat_ioctl	= 	compat_ptr_ioctl,
 	.open		=	ali_open,
-- 
2.43.0


