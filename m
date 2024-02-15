Return-Path: <linux-kernel+bounces-66424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 293C8855C89
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 595321C21D24
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32ECC14014;
	Thu, 15 Feb 2024 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="19GM6JXQ"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB97D13AE3
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 08:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707986021; cv=none; b=qZqsJYY6DSXXAykZH79p7AryOmSwwAGvI8SEE13RSDCH3Tb7V+3CO6P3mF20dCsb6cGkFmjFGo56Q9uifwjyjAdlZhK20Eymu3SEn9qU8PCG9BQM0HC77mOLPArc5FWpgETpKle/DdoSHNInUhSktGaQnimd6coJL7H7/XbI3So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707986021; c=relaxed/simple;
	bh=YT4/POV3M8MtyVT6SG3s3/ohDW0RzcPxhzts0DGQ55I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M8b3RrYYHc4VrdzCa2vtjSyDoJggS8lAdRh1/8CuVgeac8JhNpagu4VG/UaKKZXcJUa1fUKiThnlZ1c25x56H9QImwZyhzd+L1ASFdPx12Ir4QOWenx37l+2cD+r3sFasOs+49ZkkjXiziMSFoRYCsO9SMgkNgSIRdrI+ynq8mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=19GM6JXQ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-411f895c8b6so5114195e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 00:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707986018; x=1708590818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tuZqG0oYu5QXy6Hacy/4Gf0XYdpRrgU60aNFFSE8Nik=;
        b=19GM6JXQ7uXWi6QM1U6cEtDcSaD2fmUUDiwJ4QT6G9r8Y1G0LL4kbE0UsOZ/EaDNez
         ERP04bSBpbvIm/JceU405ry/8ic5rhBk+Pilmd5pFAmF5puNaUNyzg+z+iHRoz1R9Fm5
         erC88b3UjcEbVI7nMWA9as3G2Q4mRZ8DNtaQY2pxPgFQypxzzX/x+Om2iMJhCxeMdnVK
         BicY9U3186pfCqd8ezGwl68U0FKAQ8SxUMi/Y/6lY+ihOg2resPRL6iaddTLrFllKSNs
         eBSW1DhDm3wyPrYGDDRC8HfSr4i4XPRdR7yiRCnIbN3HU8IJPYL2RE0GgCTw9ECX86RV
         gXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707986018; x=1708590818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tuZqG0oYu5QXy6Hacy/4Gf0XYdpRrgU60aNFFSE8Nik=;
        b=d0YIhz12eMhj22fjwEPFft3xHuuBwxl79n+PrcZzxOn77UYV/I7/MOt+mVVrO2OfZC
         kQn+ZxW/OjQ6+WBHn5604q5l4v7bwAW27DPPYuxPO2gjtMh7w/OqBqcjF3ggpYkkGd3t
         uTxaFGHiB25Fz1QINtcJzVGm3XdopG7T3IPDEKBE3QN8sBWY4kTii4wotAyccEjuXGp5
         wMy+lIzQRtBIE22Qm8lyHyiigZfsmVVY/RH66hFCRcUbvRUaOsQBMU8m6C+XtrtCxSCh
         uQTP9BsjY+VBWH5oMG1foqYaQXpgnHmcYBy54fo+E8k7n+Pm32PhhTuk+H6iMET990Ad
         IxAQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7+STN9FldXidiY50QTDJto8yYWb16GEFLOJ0izwyjcIrHfgf19xMcuF0AaB7c9d/q8JEsnZw6VhiyMbLVRlwqJHve/wASRd388jnz
X-Gm-Message-State: AOJu0YydbVsukfVeeesS9ovQN9SFj3Lqk9LdgiXbHlH4jxsvmyl1BjWA
	PvUkExNCi3N03FyY7gSMMB2prNRl8UAmiVOQpAa165mQNlQOF7ySFN1VB1esBaU=
X-Google-Smtp-Source: AGHT+IFTAcUrqBtlmisv2yuIw/iHEpKckPDhY5yHQ/h9rk+RRjXEGabSjPJGHca/XBvqOCxefHaWzA==
X-Received: by 2002:a05:600c:1384:b0:410:c128:2bed with SMTP id u4-20020a05600c138400b00410c1282bedmr762104wmf.20.1707986017955;
        Thu, 15 Feb 2024 00:33:37 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:20b3:d902:bf8e:897])
        by smtp.gmail.com with ESMTPSA id u22-20020a05600c211600b0040fddaf9ff4sm4286906wml.40.2024.02.15.00.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 00:33:37 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 2/2] gpio: sim: use for_each_gpio()
Date: Thu, 15 Feb 2024 09:33:28 +0100
Message-Id: <20240215083328.11464-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240215083328.11464-1-brgl@bgdev.pl>
References: <20240215083328.11464-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Display debugfs information about all simulated GPIOs, not only the
requested ones.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-sim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index c4106e37e6db..1ebd6961ffba 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -234,10 +234,10 @@ static void gpio_sim_dbg_show(struct seq_file *seq, struct gpio_chip *gc)
 
 	guard(mutex)(&chip->lock);
 
-	for_each_requested_gpio(gc, i, label)
+	for_each_gpio(gc, i, label)
 		seq_printf(seq, " gpio-%-3d (%s) %s,%s\n",
 			   gc->base + i,
-			   label,
+			   label ?: "<unused>",
 			   test_bit(i, chip->direction_map) ? "input" :
 				test_bit(i, chip->value_map) ? "output-high" :
 							       "output-low",
-- 
2.40.1


