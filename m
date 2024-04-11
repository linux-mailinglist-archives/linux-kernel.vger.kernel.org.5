Return-Path: <linux-kernel+bounces-140791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB48B8A18FD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 231D91C20CBD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629F555E6A;
	Thu, 11 Apr 2024 15:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dl/DRyKl"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7032B54BEA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849546; cv=none; b=twxQB/20Ml2KgQFtELErkhqbasS62Hh8WvaW/x9+cgEjiphKGTcf+GSFwydyrnZIgG5pwKGh9awqc8k2qSTYgIRpgtaftf3ze+RoZySEfqlaY2+j+10alfpF1Ip3eZMCz/BqtB/aGOtpE3kJHOjfM7AqY0vwUfEPi9ucJP2KakY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849546; c=relaxed/simple;
	bh=liT1eUpL2MlEL1+9bRrSoHods4uKtTdnUAiPlKhovrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgFjXIUYiHt3yn/DwalLJDC4290MXCtw/HgWcfD62LAW+bTL4mk/7b42klT0hKTZ4cdARPlSWKnWvFpB1thYLwPrEsCLGrOUMUD5sVxptX5XTONFKXUDnnwDkqf6tZcZqOS2VowdzvvYGeWmr37yqvYryOhUIOQs27UOK/PkkTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dl/DRyKl; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9703639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849544; x=1713454344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxSmJ6hiv3t1dpSGMjJO238X9nPHDffsz34suMyanvM=;
        b=dl/DRyKlOGmrcSBV+JnGVByOOipHI12uKb87VX81DX29kKg+SFqFqY3Qu7Wdb+QuHi
         JYEtcfTwo/68s0GW5BPSgs+FXRXskIfOAfQjz0L2iMV3ujqU2uYbSSVs7jgml4EbrJnr
         5JPhAQJJDOvzpz4z0YjQhWXJ9nkx+Jzf682MZ8ND1849kFXq7UdReDkefuDa8HdPQxiP
         oZYjGjXBEb+f5oLDawA5/9o76+2vIDDm/qfvS4AlMwVZVQWXwvpEA6gn2HtzHoMlYHc/
         oMFNE5MoPAU05neXyBPvUt9PcxqGHzBiasGjJ/AHVQZSYUbaED9aeridt3tGRdCL6jA8
         0ZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849544; x=1713454344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gxSmJ6hiv3t1dpSGMjJO238X9nPHDffsz34suMyanvM=;
        b=V0Lr3XwtsVkUjm+p9vL3KRZdN6B+6PJAIVONRBwepIKMCXSh8lvGVLav9X8ijwWIC7
         BYakYpdQUpgpwNP/AsCEGsKATUO3vScTCoyo69GZk3w0vwxaPvIR1ana5rohirnNj6gd
         chEN+GjKRJ7TR2/Pi0VR8GSQ8GRLt+n8CdcI9Z+xsbE3hHIxOfzJtz6mpuWsTi54/zD5
         TE/yiW05ERgKS46cjCgA+RK0veZt46yNz85gPegXCymC/Tq6Q0zMMkKxxLewfo56MuQS
         Vv06Qk57u9tXyjD4IBrTQh/+tmbodJDh+cPPDrAn8MxyIER58P4ilAKchGN0HOFI78k7
         gD6Q==
X-Gm-Message-State: AOJu0YyU0QKZFTvLT+CtFbd8EF3tF3xrL0ECBlK9cplClSPavKGNhgb1
	h/Wv9S5CdujvRsCExYBm+27OFelao07243VsPj8Xjv+ulpIUwRdxA7V7ndh/v6HkqyuOsXT05kt
	w
X-Google-Smtp-Source: AGHT+IGmdEyTlBMBZusHhYtmaW2jfRbodkjKpC+DBBWfvwEoywVgNm66gXIT0HuO3aZXmUkbrIWiTQ==
X-Received: by 2002:a6b:c34e:0:b0:7d6:7b7c:8257 with SMTP id t75-20020a6bc34e000000b007d67b7c8257mr203503iof.0.1712849544333;
        Thu, 11 Apr 2024 08:32:24 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:32:22 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 033/437] char/scx200_gpio: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:12:53 -0600
Message-ID: <20240411153126.16201-34-axboe@kernel.dk>
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
 drivers/char/scx200_gpio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/scx200_gpio.c b/drivers/char/scx200_gpio.c
index 9f701dcba95c..e6369766f7e3 100644
--- a/drivers/char/scx200_gpio.c
+++ b/drivers/char/scx200_gpio.c
@@ -64,8 +64,8 @@ static int scx200_gpio_release(struct inode *inode, struct file *file)
 
 static const struct file_operations scx200_gpio_fileops = {
 	.owner   = THIS_MODULE,
-	.write   = nsc_gpio_write,
-	.read    = nsc_gpio_read,
+	.write_iter   = nsc_gpio_write_iter,
+	.read_iter    = nsc_gpio_read_iter,
 	.open    = scx200_gpio_open,
 	.release = scx200_gpio_release,
 	.llseek  = no_llseek,
-- 
2.43.0


