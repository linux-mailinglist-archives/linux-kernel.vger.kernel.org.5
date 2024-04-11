Return-Path: <linux-kernel+bounces-141022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 483968A1A1D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 044CE2828A3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2361C8236;
	Thu, 11 Apr 2024 15:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gtP14Zat"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524651C78B5
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849917; cv=none; b=AkkJ9K1BY94GGBTdxWHJCNp9h7BMLqSAEP0cp+u8ztUtIaSB0Rehe0uGTocEzSTTH/Ljv2XNoBE6tZ+rObqNKh3TI8lSOdrR1Z4SdxWPi6oyNJv8EDWnBFWJ5jSb7miZLVPmBsdoRMYsrh+PBR0/87q25W/fiU0tMFoWDgtewv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849917; c=relaxed/simple;
	bh=JyrSgEWmnB0+i/PGcTcMfPot7iUEdAjZpBOz2oR4uRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZSM7KcSuELclfZrYZWaSybw9+h3ghyP4HnfsdRnNYtTZE81eutl+Lc8ALYvLHg7ztbIAKr5WgvkTYHb766BDtgqmUhfDDsqTWo+XOi5AdjVcSpFF+trUSHwoSaj/4EbCBGcGLplPVGcmkddV/kiMuP1AP8SH43M0hd7LZ0jXmnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gtP14Zat; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7cb9dd46babso81847039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849912; x=1713454712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NlOUr1EzAS7CVoLA5em7+gghkhMr/unbCXEUYj4vSEc=;
        b=gtP14Zat11c7wFb25K2uBlhuTM3HKWEtDGklZO3ch7IY0h89XLIo3H7Sk0tPax8Po3
         uUCAIUZjUe+FUbaPdInUQHMB46v6SLFwbY4DqPR7c7Cb7lzeKcQBcYSLLcFYTDoraCEP
         Skx/SqbijLZI14FeFLlgmSPZG2b4ranJdkwj4IN6ZMmt74yW32d4XsF5XhMxjufyZl/N
         M8p/s54ZU75qSfWwoPIShXLCTNFF3vDkdmsIDx3YJvqNLGmm40qbd//JkdWtGguiTLm9
         vmmdYMi8w3lRuTe4NkGxE1ySwilP/kD3vbOQGE3leua+aZQNHfolJXWHj7oa6B7+tBXl
         PgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849912; x=1713454712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NlOUr1EzAS7CVoLA5em7+gghkhMr/unbCXEUYj4vSEc=;
        b=bDjC1w9ocb141uwLExmzq2xeMoU9ubPDX8RgQGjRZlVOJypHmI93ZbOmDzrCnb/4oH
         yYebcbI2SdxcKY4xWXfbwZ/3LEq23cL59Rat0rc6wXbej3mmUjNRkjXOw619wv+Z9HoA
         5ZU+TI28ZgXqLgZ0a10oEA1HBGX8+mU4VquZmopd7Dz8APgopd9MDuJJ6mwGEfBneLYe
         PyzK0q0fYYJcS0DaTj1sz8y/f3S31tJm3nlijxQ6v0DugsxZPBOsc+qvd2cLBYyXrBya
         ZpEk+ahO3nOrotqLYErbnsQO3Q0MHGIhE1zUsoEkHOllMP2NNgQAcWdn5g/2xf7dfDRo
         YWFA==
X-Gm-Message-State: AOJu0YxuaoiPQ15U6L/V9Gta3ZUrscYJaJ4WctdX8AibI9vhUGuVMuT2
	NNC6sseazH0OwsuSiulqJqggGTD+4dy2vIOPYCynIyGuK1QWVsWnrmKM7gyuLQVI76D5vL5mHaq
	M
X-Google-Smtp-Source: AGHT+IE5oxf9h5bS0OTGuK4vRoNwOZASV5KV8VWxoBsjKvWu95XsX5N63LpGOtavGk89BgBXsKURZw==
X-Received: by 2002:a05:6602:4ed7:b0:7d5:ddc8:504d with SMTP id gk23-20020a0566024ed700b007d5ddc8504dmr193781iob.0.1712849911673;
        Thu, 11 Apr 2024 08:38:31 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:38:30 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 247/437] watchdog: pc87413_wdt: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:27 -0600
Message-ID: <20240411153126.16201-248-axboe@kernel.dk>
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
 drivers/watchdog/pc87413_wdt.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/pc87413_wdt.c b/drivers/watchdog/pc87413_wdt.c
index c7f745caf203..7ccc5aa4bd25 100644
--- a/drivers/watchdog/pc87413_wdt.c
+++ b/drivers/watchdog/pc87413_wdt.c
@@ -327,18 +327,16 @@ static int pc87413_status(void)
 
 /**
  *	pc87413_write:
- *	@file: file handle to the watchdog
- *	@data: data buffer to write
- *	@len: length in bytes
- *	@ppos: pointer to the position to write. No seeks allowed
+ *	@iocb: metadata for IO
+ *	@from: data buffer to write
  *
  *	A write to a watchdog device is defined as a keepalive signal. Any
  *	write of data will do, as we we don't define content meaning.
  */
 
-static ssize_t pc87413_write(struct file *file, const char __user *data,
-			     size_t len, loff_t *ppos)
+static ssize_t pc87413_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t len = iov_iter_count(from);
 	/* See if we got the magic character 'V' and reload the timer */
 	if (len) {
 		if (!nowayout) {
@@ -351,7 +349,7 @@ static ssize_t pc87413_write(struct file *file, const char __user *data,
 			   magic character */
 			for (i = 0; i != len; i++) {
 				char c;
-				if (get_user(c, data + i))
+				if (get_iter(c, from))
 					return -EFAULT;
 				if (c == 'V')
 					expect_close = 42;
@@ -471,7 +469,7 @@ static int pc87413_notify_sys(struct notifier_block *this,
 static const struct file_operations pc87413_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
-	.write		= pc87413_write,
+	.write_iter	= pc87413_write,
 	.unlocked_ioctl	= pc87413_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= pc87413_open,
-- 
2.43.0


