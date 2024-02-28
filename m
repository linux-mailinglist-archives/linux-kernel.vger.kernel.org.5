Return-Path: <linux-kernel+bounces-85099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D5786B06A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B7E01F2869D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182371534E3;
	Wed, 28 Feb 2024 13:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mj32giKO"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7149814C58C;
	Wed, 28 Feb 2024 13:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709127180; cv=none; b=q+fzY7VLHGx4hvIc7pbQwB+SyLe6MHg99+ZlXv33TkOo/f9X2DGjNes5NfZiENRSnMiPK3RFr7RgCW6Sn8iprCp95utBSMzZkI6nCFtopRYnX/cIbOnH7tSq+3u4glGhksVr5YTAcebm+iqEay1rQwFgbrIiMMx0+VnP1X1dW1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709127180; c=relaxed/simple;
	bh=7IIXC1qsD1MFpjVOqYYi+BOf0Ko89zjnAhsRvckXXLA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BTuR7OcJslOQ7x55Hx04BEGFbyScwK5wIQQaTC8/5wUuf7Dt/vRSXOfqfxXWX+j8oZ5oft8Xb5n80clVstUnJt0AvqBdBvOvaf2kirEAbm88p6zDZ1TsDC2o/D/Qx9eCGIIBrzGYf8Q6QL0dYECAdG60lYIG89qDyh64ttXglIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mj32giKO; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so6978101a12.0;
        Wed, 28 Feb 2024 05:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709127177; x=1709731977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPr5OT0hjAf7wDQpFiXt+umkADr7mP/nXjReYVXPj5M=;
        b=mj32giKOlivVtkqrMS5OBEssUKko98m64EaFlhXQ445ynCpOWjmuG2gomATey9br9V
         QzpBUz1BK7a16BSI+EEmMvqt6DgeAQwpGk78ZbbFqOcRGLUnHbmVKBzMYEGf5Wa4VupF
         YmiF6H3pLEiILs0FxYN29D51CEL/Gx1/miXLMZ+QkEbx7NpeDOHLAhaQptWe31PklUjj
         DjDjxStGEfSA/jgrjUMIlOQJQu04Ju3qpgb9+89SN/feBQfDatq6jpadxWFDNM5vQCiF
         0h7seBcbi8b+o0z1ujLtuloWnQB2jFQvtHXXp9cp1saVyIevy2nMIMraMMaKH+l7oipO
         8YCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709127177; x=1709731977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPr5OT0hjAf7wDQpFiXt+umkADr7mP/nXjReYVXPj5M=;
        b=GiJNitNFXJuunGD/ENqTcLJkUFgwbcdaEheCPkHexM0XvorSdHgBWh9NBFSSQCrHM/
         zojqYdL4rxqtC2E89RDgts61iqv5x03veYvgvi/rIF2IZv5nIp06SIUVsK8zJ2qu2h0u
         8UYlnp4KwOSTLSFDxG0UN7MqJ/8w/3id0AfAg/bZvGhbvX+wO6KkPruquAIORMHo6JPB
         vlXk218DQtNqqd7bmuTzEeJumyQJT6dyJltCnqmP9G2+fZZhAeidGfJCQWdU00aMHhAa
         EWJmVbGNTZS8h0tkANKYoV+Y4UbdaP88rYW7rA7SVoU+4dUKDnRK/b4qrhpmV1RtebLZ
         Cz3A==
X-Forwarded-Encrypted: i=1; AJvYcCUZ7bv7T5G9poZiEiREtARqyPd3kWenNZoII5fnLtGSPNswhA3LIxOmDhBOuM3L4NWB7smXu7mjpcWxJjU9v+VSSGU0NeEortKAkMQgLc46ibNazH0HwGs8wbjJ88/dCGWfSpoptzVI
X-Gm-Message-State: AOJu0YwsGAdgnjJEVAkknvDEAm2lRl3uUO0423L6c9rH2DYxnX79hME6
	VhazNtZ1Ve6FLWQwhgEnqejaQmm8GS/8qjPIFEr4WljXT8psGfsL
X-Google-Smtp-Source: AGHT+IGKXE9lfXX9DxovkPhxOiHRke5PiL6tBfUVMEyI2CN8x3HQkC4HBz58InRj4yxj29oYT98jnA==
X-Received: by 2002:a17:906:488c:b0:a44:fd7:3850 with SMTP id v12-20020a170906488c00b00a440fd73850mr808781ejq.66.1709127176741;
        Wed, 28 Feb 2024 05:32:56 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id vx5-20020a170907a78500b00a3f20a8d2f6sm1856952ejc.112.2024.02.28.05.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 05:32:56 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: [PATCH 3/3] pwm: mc33xs2410: add support for direct inputs
Date: Wed, 28 Feb 2024 14:32:35 +0100
Message-Id: <20240228133236.748225-4-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240228133236.748225-1-dima.fedrau@gmail.com>
References: <20240228133236.748225-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for direct inputs, which are used to directly turn-on or
turn-off the outputs. Direct inputs have the advantage over the SPI
controlled outputs that they aren't limited to the frequency steps.
Frequency resolution depends on the input signal, range is still
from 0.5Hz to 2.048kHz.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/pwm/pwm-mc33xs2410.c | 116 +++++++++++++++++++++++++++++++----
 1 file changed, 105 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-mc33xs2410.c b/drivers/pwm/pwm-mc33xs2410.c
index 35753039da6b..828a67227185 100644
--- a/drivers/pwm/pwm-mc33xs2410.c
+++ b/drivers/pwm/pwm-mc33xs2410.c
@@ -18,7 +18,10 @@
 #define MC33XS2410_GLB_CTRL_MODE_MASK	GENMASK(7, 6)
 #define MC33XS2410_GLB_CTRL_NORMAL_MODE	BIT(6)
 #define MC33XS2410_GLB_CTRL_SAFE_MODE	BIT(7)
+#define MC33XS2410_GLB_CTRL_CMOS_LEVEL	BIT(0)
 #define MC33XS2410_OUT1_4_CTRL		0x02
+#define MC33XS2410_IN_CTRL1		0x03
+#define MC33XS2410_IN_CTRL1_IN_EN(x)	BIT(x)
 #define MC33XS2410_PWM_CTRL1		0x05
 #define MC33XS2410_PWM_CTRL1_POL_INV(x)	BIT(x)
 #define MC33XS2410_PWM_CTRL3		0x07
@@ -45,6 +48,7 @@
 struct mc33xs2410_pwm {
 	struct pwm_chip chip;
 	struct spi_device *spi;
+	struct pwm_device *di[4];
 	struct mutex lock;
 };
 
@@ -154,20 +158,15 @@ static u8 mc33xs2410_pwm_get_freq(const struct pwm_state *state)
 	return (ret | FIELD_PREP(MC33XS2410_PWM_FREQ_STEP_MASK, step));
 }
 
-static int mc33xs2410_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-				const struct pwm_state *state)
+static int mc33xs2410_pwm_apply_spi(struct pwm_chip *chip,
+				    struct pwm_device *pwm,
+				    const struct pwm_state *state)
 {
 	struct mc33xs2410_pwm *mc33xs2410 = mc33xs2410_pwm_from_chip(chip);
 	struct spi_device *spi = mc33xs2410->spi;
 	u8 mask, val;
 	int ret;
 
-	if (state->period > mc33xs2410_period[STEP_05HZ][MC33XS2410_PERIOD_MAX])
-		return -EINVAL;
-
-	if (state->period < mc33xs2410_period[STEP_32HZ][MC33XS2410_PERIOD_MIN])
-		return -EINVAL;
-
 	guard(mutex)(&mc33xs2410->lock);
 	mask = MC33XS2410_PWM_CTRL1_POL_INV(pwm->hwpwm);
 	val = (state->polarity == PWM_POLARITY_INVERSED) ? mask : 0;
@@ -190,9 +189,38 @@ static int mc33xs2410_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	return mc33xs2410_modify_reg(spi, MC33XS2410_PWM_CTRL3, mask, val);
 }
 
-static int mc33xs2410_pwm_get_state(struct pwm_chip *chip,
-				    struct pwm_device *pwm,
-				    struct pwm_state *state)
+static int mc33xs2410_pwm_apply_direct_inputs(struct pwm_chip *chip,
+					      struct pwm_device *pwm,
+					      const struct pwm_state *state)
+{
+	struct mc33xs2410_pwm *mc33xs2410 = mc33xs2410_pwm_from_chip(chip);
+	struct pwm_device *di = mc33xs2410->di[pwm->hwpwm];
+
+	guard(mutex)(&mc33xs2410->lock);
+
+	return pwm_apply_state(di, state);
+}
+
+static int mc33xs2410_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+				const struct pwm_state *state)
+{
+	struct mc33xs2410_pwm *mc33xs2410 = mc33xs2410_pwm_from_chip(chip);
+
+	if (state->period > mc33xs2410_period[STEP_05HZ][MC33XS2410_PERIOD_MAX])
+		return -EINVAL;
+
+	if (state->period < mc33xs2410_period[STEP_32HZ][MC33XS2410_PERIOD_MIN])
+		return -EINVAL;
+
+	if (mc33xs2410->di[pwm->hwpwm])
+		return mc33xs2410_pwm_apply_direct_inputs(chip, pwm, state);
+	else
+		return mc33xs2410_pwm_apply_spi(chip, pwm, state);
+}
+
+static int mc33xs2410_pwm_get_state_spi(struct pwm_chip *chip,
+					struct pwm_device *pwm,
+					struct pwm_state *state)
 {
 	struct mc33xs2410_pwm *mc33xs2410 = mc33xs2410_pwm_from_chip(chip);
 	struct spi_device *spi = mc33xs2410->spi;
@@ -236,6 +264,28 @@ static int mc33xs2410_pwm_get_state(struct pwm_chip *chip,
 	return 0;
 }
 
+static int mc33xs2410_pwm_get_state_direct_inputs(struct pwm_chip *chip,
+						  struct pwm_device *pwm,
+						  struct pwm_state *state)
+{
+	struct mc33xs2410_pwm *mc33xs2410 = mc33xs2410_pwm_from_chip(chip);
+
+	pwm_get_state(mc33xs2410->di[pwm->hwpwm], state);
+	return 0;
+}
+
+static int mc33xs2410_pwm_get_state(struct pwm_chip *chip,
+				    struct pwm_device *pwm,
+				    struct pwm_state *state)
+{
+	struct mc33xs2410_pwm *mc33xs2410 = mc33xs2410_pwm_from_chip(chip);
+
+	if (mc33xs2410->di[pwm->hwpwm])
+		return mc33xs2410_pwm_get_state_direct_inputs(chip, pwm, state);
+	else
+		return mc33xs2410_pwm_get_state_spi(chip, pwm, state);
+}
+
 static const struct pwm_ops mc33xs2410_pwm_ops = {
 	.apply = mc33xs2410_pwm_apply,
 	.get_state = mc33xs2410_pwm_get_state,
@@ -257,6 +307,45 @@ static int mc33xs2410_reset(struct device *dev)
 	return 0;
 }
 
+static int mc33xs2410_direct_inputs_probe(struct mc33xs2410_pwm *mc33xs2410)
+{
+	struct device *dev = &mc33xs2410->spi->dev;
+	u16 di_en = 0;
+	char buf[4];
+	int ret, ch;
+
+	for (ch = 0; ch < 4; ch++) {
+		sprintf(buf, "di%d", ch);
+		mc33xs2410->di[ch] = devm_pwm_get(dev, buf);
+		ret = PTR_ERR_OR_ZERO(mc33xs2410->di[ch]);
+		switch (ret) {
+		case 0:
+			di_en |= MC33XS2410_IN_CTRL1_IN_EN(ch);
+			break;
+		case -ENODATA:
+			mc33xs2410->di[ch] = NULL;
+			break;
+		case -EPROBE_DEFER:
+			return ret;
+		default:
+			dev_err(dev, "Failed to request %s: %d\n", buf, ret);
+			return ret;
+		}
+	}
+
+	if (!di_en)
+		return 0;
+
+	/* CMOS input logic level */
+	ret = mc33xs2410_modify_reg(mc33xs2410->spi, MC33XS2410_GLB_CTRL,
+				    MC33XS2410_GLB_CTRL_CMOS_LEVEL,
+				    MC33XS2410_GLB_CTRL_CMOS_LEVEL);
+	if (ret < 0)
+		return ret;
+
+	return mc33xs2410_write_reg(mc33xs2410->spi, MC33XS2410_IN_CTRL1, di_en);
+}
+
 static int mc33xs2410_probe(struct spi_device *spi)
 {
 	struct mc33xs2410_pwm *mc33xs2410;
@@ -290,6 +379,11 @@ static int mc33xs2410_probe(struct spi_device *spi)
 		return dev_err_probe(dev, ret,
 				     "Failed to transition to normal mode\n");
 
+	/* Enable direct inputs */
+	ret = mc33xs2410_direct_inputs_probe(mc33xs2410);
+	if (ret)
+		return ret;
+
 	ret = devm_pwmchip_add(dev, &mc33xs2410->chip);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to add pwm chip\n");
-- 
2.39.2


