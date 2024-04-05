Return-Path: <linux-kernel+bounces-132294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A58F489929F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 02:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39E431F22ECF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A888814;
	Fri,  5 Apr 2024 00:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Fa2NAhNg"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AD8160
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 00:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712277033; cv=none; b=RDpyDhTBlq4a7RneEdumMkxIO6TI7i7aD/rK98X5DucrApZs5j3JYfP4DFkS9RO4kzwT7FKXmEHRUcqSAepzJbgga8HaGfOmO3t4zuYlnhmXqpyErTOnfNyaQkyjfPCzzyGx8DFYT/QVxNChnl2+5ARYEMzdjRzfDe+h8q8Rq/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712277033; c=relaxed/simple;
	bh=xo/5zy7BKD5MQNwqWrK5Y7aZc4xuWO41L1gezsqpgM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z5t9rDIb/Ng8QwyeWIhkfwG9CvJMzh8ekT6ef9497kYQGbHHam9DRtC9mlMoueHwLxwczXBJDivl+15SlXVcJa7I5x1SbLht27GHO3J6fWDIPrLaPTLWY2qeKKPznZez7P/qVIeWe9UvZCmq79uRKB4d1HArImlQdsD32/H9Wck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Fa2NAhNg; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e0f43074edso1018571a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 17:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712277030; x=1712881830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mflIGl0JabM93wYA4asHh3PZJ7LJW93To1t++JIDmfs=;
        b=Fa2NAhNg6kkwFytftj+oDsjgnaUUd4/KoFeFjaBOunkuROV4mwqUgrHD3XNk7cUAHd
         BZgbN8ii6I/k5M3YWqybW1oX77rErtpeW1VsbleWWN063hiNPrgpgfosDn6kGqDriIbP
         IODvwdG6GxsTZ5sL47UVuljKcaz2tzBip3ALnBq1u2NC4SqdxK6FgVgXWWIsg6n08c7X
         gMU9HWa5f41fBFcBs3OHjHb5ogCXnri1CONgSLzvxDyW0XJnmAOmycRjrjGewBk0qu73
         N5AtaU57m9freAkvmr7eOBKnacx+n3NAIxOdiO863GzzGIqwRc3ALPeEp29zvluiF/PG
         e1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712277030; x=1712881830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mflIGl0JabM93wYA4asHh3PZJ7LJW93To1t++JIDmfs=;
        b=QoAU/WTx9RWpEdbbRC2W30hjCaKghFhA4jvqCTM9EONtjDWjvViR9IBLZ4QcDYVM88
         6Uh3oovlOTqhqe4Vikb2DCTwa/XTRecEItTNGzTqKZuiQRAAsdbZGyvHjh86y4dy/uHn
         I+9e5sPe2lNF5nzkgkttvdYQusJU9ERnI32Hw41VSnc5BT47yYr3ikFFwj75JwNedbw3
         6RA3iFAStZZjopnsM0nEQOiPsf+0v7ACCv5Ab0xWSYRsWznpbo1D9zfmsasO0ZapuYIl
         MO+VYSMVrh+eB8tM6dHouQZNpe37zGuD2lpIw+B/1WkT2ufZA6ehyM1zVdshA2EbeFM3
         /k2Q==
X-Gm-Message-State: AOJu0Yxv5vwqWziOt/5Hkzzj770uIovCTm+HoCstUWLKi8RBSzklMCL1
	ESCuIkbUIdszj/qtRJ0JHCL2x1bFsQSYXc7R/DKiBzRZ5XbMerDW2eJIELy6+I0=
X-Google-Smtp-Source: AGHT+IGeFIba7Fjoy+Lh5imxQMFJ60kylklXD567TEN4HDRnVJ4VBUmRGP0suOKAmd/UdpjTU1+F8w==
X-Received: by 2002:a9d:7a57:0:b0:6e9:df99:77c6 with SMTP id z23-20020a9d7a57000000b006e9df9977c6mr29202otm.27.1712277030414;
        Thu, 04 Apr 2024 17:30:30 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id o4-20020ac86d04000000b00432feda5986sm232728qtt.35.2024.04.04.17.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 17:30:29 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	u.kleine-koenig@pengutronix.de,
	michael.hennerich@analog.com,
	nuno.sa@analog.com,
	tgamblin@baylibre.com,
	dlechner@baylibre.com
Subject: [RFC PATCH 2/3] pwm: axi-pwmgen: add duty offset support
Date: Thu,  4 Apr 2024 20:30:24 -0400
Message-ID: <20240405003025.739603-3-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405003025.739603-1-tgamblin@baylibre.com>
References: <20240405003025.739603-1-tgamblin@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable duty_offset feature now that it is supported in the pwm
subsystem. Related macros and struct fields related to duty_offset are
renamed to be consistent.

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 drivers/pwm/pwm-axi-pwmgen.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
index 539625c404ac..84ecb12e1e21 100644
--- a/drivers/pwm/pwm-axi-pwmgen.c
+++ b/drivers/pwm/pwm-axi-pwmgen.c
@@ -6,9 +6,9 @@
  * Copyright 2024 Baylibre SAS
  *
  * Limitations:
- * - The writes to registers for period and duty are shadowed until
- *   LOAD_CONFIG is written to AXI_PWMGEN_REG_CONFIG at the end of the
- *   current period.
+ * - The writes to registers for period, duty, and duty_offset are
+ *   shadowed until LOAD_CONFIG is written to AXI_PWMGEN_REG_CONFIG at
+ *   the end of the current period.
  * - Writing LOAD_CONFIG also has the effect of re-synchronizing all
  *   enabled channels, which could cause glitching on other channels. It
  *   is therefore expected that channels are assigned harmonic periods
@@ -34,7 +34,7 @@
 #define AXI_PWMGEN_REG_NPWM		0x14
 #define AXI_PWMGEN_CHX_PERIOD(v, ch)	((v)->period_base + (v)->ch_step * (ch))
 #define AXI_PWMGEN_CHX_DUTY(v, ch)	((v)->duty_base + (v)->ch_step * (ch))
-#define AXI_PWMGEN_CHX_OFFSET(v, ch)	((v)->offset_base + (v)->ch_step * (ch))
+#define AXI_PWMGEN_CHX_DUTY_OFFSET(v, ch)	((v)->duty_offset_base + (v)->ch_step * (ch))
 #define AXI_PWMGEN_REG_CORE_MAGIC_VAL	0x601A3471 /* Identification number to test during setup */
 #define AXI_PWMGEN_LOAD_CONFIG		BIT(1)
 #define AXI_PWMGEN_RESET		BIT(0)
@@ -42,7 +42,7 @@
 struct axi_pwm_variant {
 	u8 period_base;
 	u8 duty_base;
-	u8 offset_base;
+	u8 duty_offset_base;
 	u8 major_version;
 	u8 ch_step;
 };
@@ -62,7 +62,7 @@ static const struct regmap_config axi_pwmgen_regmap_config = {
 static const struct axi_pwm_variant pwmgen_1_00_variant = {
 	.period_base = 0x40,
 	.duty_base = 0x44,
-	.offset_base = 0x48,
+	.duty_offset_base = 0x48,
 	.major_version = 1,
 	.ch_step = 12,
 };
@@ -70,7 +70,7 @@ static const struct axi_pwm_variant pwmgen_1_00_variant = {
 static const struct axi_pwm_variant pwmgen_2_00_variant = {
 	.period_base = 0x40,
 	.duty_base = 0x80,
-	.offset_base = 0xC0,
+	.duty_offset_base = 0xC0,
 	.major_version = 2,
 	.ch_step = 4,
 };
@@ -83,7 +83,7 @@ static int axi_pwmgen_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	unsigned int ch = pwm->hwpwm;
 	struct regmap *regmap = ddata->regmap;
 	const struct axi_pwm_variant *variant = ddata->variant;
-	u64 period_cnt, duty_cnt;
+	u64 period_cnt, duty_cnt, duty_offset_cnt;
 	int ret;
 
 	if (state->polarity != PWM_POLARITY_NORMAL)
@@ -108,6 +108,14 @@ static int axi_pwmgen_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		ret = regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(variant, ch), duty_cnt);
 		if (ret)
 			return ret;
+
+		duty_offset_cnt = mul_u64_u64_div_u64(state->duty_offset, ddata->clk_rate_hz, NSEC_PER_SEC);
+		if (duty_offset_cnt > UINT_MAX)
+			duty_offset_cnt = UINT_MAX;
+
+		ret = regmap_write(regmap, AXI_PWMGEN_CHX_DUTY_OFFSET(variant, ch), duty_offset_cnt);
+		if (ret)
+			return ret;
 	} else {
 		ret = regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(variant, ch), 0);
 		if (ret)
@@ -116,6 +124,10 @@ static int axi_pwmgen_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		ret = regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(variant, ch), 0);
 		if (ret)
 			return ret;
+
+		ret = regmap_write(regmap, AXI_PWMGEN_CHX_DUTY_OFFSET(variant, ch), 0);
+		if (ret)
+			return ret;
 	}
 
 	return regmap_write(regmap, AXI_PWMGEN_REG_CONFIG, AXI_PWMGEN_LOAD_CONFIG);
@@ -145,6 +157,12 @@ static int axi_pwmgen_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	state->duty_cycle = DIV_ROUND_UP_ULL((u64)cnt * NSEC_PER_SEC, ddata->clk_rate_hz);
 
+	ret = regmap_read(regmap, AXI_PWMGEN_CHX_DUTY_OFFSET(variant, ch), &cnt);
+	if (ret)
+		return ret;
+
+	state->duty_offset = DIV_ROUND_UP_ULL((u64)cnt * NSEC_PER_SEC, ddata->clk_rate_hz);
+
 	state->polarity = PWM_POLARITY_NORMAL;
 
 	return 0;
@@ -254,6 +272,7 @@ static int axi_pwmgen_probe(struct platform_device *pdev)
 
 	chip->ops = &axi_pwmgen_pwm_ops;
 	chip->atomic = true;
+	chip->supports_offset = true;
 
 	return devm_pwmchip_add(dev, chip);
 }
-- 
2.44.0


