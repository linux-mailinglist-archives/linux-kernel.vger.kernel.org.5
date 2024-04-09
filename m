Return-Path: <linux-kernel+bounces-137414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FAF89E1B6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4405C1C22FCE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9952156965;
	Tue,  9 Apr 2024 17:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uw7ykD65"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FC1156861
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 17:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712684493; cv=none; b=s2W7upsG2ecczgBvmVZ/Gu56vYr+qQlKGojFyfHXPuN3ZEqKTB2K/H+sqCp1SslcVjNQvNxAsmVUZHuzEvYYQYu9vcXNZ14jnDwONqOQwyug96O6179KUoyTlWf25ldYrBagcZAEyQuYBmebFshuqQoNc+7kfcE+190oOSijhFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712684493; c=relaxed/simple;
	bh=pltzjY/SPUhMX4spyKWf2ZWvQOAge8NQZlZokE7FSN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Imons2EplYdGgqZQBrK9shZ0xLmG8JnPyhJ7q2lJngUC6qh6oNmkOjpAx7VSdZIK4+VOS6NnVH2NL2n8Z+FSpIDtUtELfEtzeyv35Hh5Aotis0TRf/hkq9HWs+WJTUWSkRQTcQHccGf6W0OqOiUvFkhxTsjlGdWuVoKv7/o4J3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uw7ykD65; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-69b236a942dso15190936d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 10:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712684490; x=1713289290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7B5Hn9bc69gFGO1dadSBP8b08rYQ+WcE+9Sk3xNJNU=;
        b=uw7ykD65xgD6HzJrGRzdXmJE3PmUYQaGTZccsUpLVcBlG09eJN7B9flw8BGBdlbxiP
         gs1XQdDoYt6gddwnapy3nE8ZAB+XCZUZ2CGMgAyiNASU3m9tX+2WQBc0BRhZA4uIiKQy
         m9OEsKO/KuuCOJBZzAIvAsMc8fIJdf5IMkZ28A69J29XfzNhoR1UjfHf4MZ3Y0IxR/+6
         cchroH4u66sj83hUbBX0NcTHkFLADlyUz1cBWw7JBSSQydBGh8eDZGOxvZC/1h2lj29O
         d6degUNO8gPI8/zt4B1P0xtrWb32qKe1zil+Ez/4araX5+bq9Etm7OL93F0lsMSS3EWn
         YbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712684490; x=1713289290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7B5Hn9bc69gFGO1dadSBP8b08rYQ+WcE+9Sk3xNJNU=;
        b=nJcM0phIpNUzTB7mgOBlmavsl4kA4Ir7Mt6BAw+RgqsXdfamrrkfTil0K8hJOSIK5p
         NkLTYEItyl2vTdCY/bVUMoL4nRm6xV1oT6/LCa95weVLkALVCRc2gG3OU2FOTbA0+0rb
         1hSMKI3A9/TRZznrHZHucbI6bOcSiIwu291nEUQk4BeXv60WkKlimSFmzcXXvv74ywC+
         y3wPBpZnij+y4PMFAix4h3ofTfFrnLqKan2cYRc8dVVgEK+mPgksTUEkZKTVvZMCbVBl
         E20zBnVxAi4oqH5217FzFvENfoD7GpTEt2dwtvVGuvF90foiiTFhNoX99J4ucCRFAruc
         UOew==
X-Gm-Message-State: AOJu0YyAOSVDc/9oCmuzBG5ufrzP1sOgft9UBlUlAao8Fuye78DlOs66
	V3XqVnS3qrsVJXftAVZjr5vy8ltx+R6Ha7lJdjB8kXLl8dr/oxHpRUOqFzqZ5I4=
X-Google-Smtp-Source: AGHT+IFZkYMJyE7vWB2fzdW96Mk6tRNkz5BTdSBeNLiPos0PZIyjmZdGftcIJLVfsA4qvWq2OrJABA==
X-Received: by 2002:a05:6214:29e2:b0:699:29e0:10b4 with SMTP id jv2-20020a05621429e200b0069929e010b4mr528941qvb.13.1712684490052;
        Tue, 09 Apr 2024 10:41:30 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id o11-20020a0ce40b000000b00699437d4dfbsm3828996qvl.72.2024.04.09.10.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 10:41:29 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	u.kleine-koenig@pengutronix.de,
	michael.hennerich@analog.com,
	nuno.sa@analog.com,
	tgamblin@baylibre.com,
	dlechner@baylibre.com
Subject: [PATCH 2/2 v2] pwm: axi-pwmgen: add duty offset support
Date: Tue,  9 Apr 2024 13:41:26 -0400
Message-ID: <20240409174126.1296318-3-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409174126.1296318-1-tgamblin@baylibre.com>
References: <20240409174126.1296318-1-tgamblin@baylibre.com>
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
v2 changes:
* Address feedback for driver in v1:
  * Remove line setting supports_offset flag in pwm_chip, since that has
    been removed from the struct in core.c.

---
 drivers/pwm/pwm-axi-pwmgen.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
index 539625c404ac..25a083003432 100644
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
-- 
2.44.0


