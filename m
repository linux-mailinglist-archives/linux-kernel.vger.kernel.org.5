Return-Path: <linux-kernel+bounces-76071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D9385F294
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6770F28325E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45001B273;
	Thu, 22 Feb 2024 08:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JOtT518B"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657D3219FF
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708589587; cv=none; b=m+xnjwLPeyGLbsAEmYVOnAIvq3Vsgm0hZi5TeNOobyyNLxjKy1d6yXpes8lKEUBW0+unK+xTd1AEjGfq1JhrWObhZkIc83xPPyUOAZ0lB2rvwOUaQT+ZOzZReLoM80DXSF/uNpVmxbEaPL/V7Ayag3JFditmCLlRUXVNH/VDlkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708589587; c=relaxed/simple;
	bh=Z1dTn0Gkiacy9ygCtMQgZsRONznaH3pmxeR3C8lF2Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qYXiwNSMKF4A1lIko/J6bDsA3fCT/v5aTY3F9RzIEtbUy17nP873t31foNTznka1dJ8fnovOHz9xtzJHuSkqaScU6F8PwRaWDe6q5RNfT8Natt+PPCskS8kv2JMQatr3iBs0cvEHwcG/q6aVx/OjjGtL7mNVprmNVMZ3jw8aOzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=JOtT518B; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dbae7b8ff2so35684515ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 00:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1708589570; x=1709194370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Thj6USXv+zFZqbn9GMP05XSRBqohJA11glRlwlO2t8E=;
        b=JOtT518Bilsath7/0BagXPuprmaG9kHXt/1L33oBtkRmq5zZyHjb8dsnzjC1iHV92U
         v+Z5yKj2F73lp/tpnJkoDI6boSbOSvsGgHqEAzysIbg4sK/dSzLxAzEg0W0z0zQ/kF17
         V9h9Hx57ZjAZF+D5RIwEpvUj5wRzGx2+VTOhggh6AWof3GC5VnppDyWMiRxpCLng0O3I
         Os2vyMSddVWPfYwb7wzelELhIFXz1KHPMXvmd8MREuImXIBAfJegm4qCo0IUT70Z/xvE
         3KNYS2+pDl9LrAwyAsRJGoELaIRUy78HEwXUq9i34ZRvPOa5kD+kyko/XOFoY1HNHGaR
         0GYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708589570; x=1709194370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Thj6USXv+zFZqbn9GMP05XSRBqohJA11glRlwlO2t8E=;
        b=W/qfOJ2GUhgWfuniK/Y/Qe6tDXQK37JKybhyMVpyBsFdZZNUDIYgPwXkZWTZaM8tJq
         gNj2iVjnxLH2hrTFeoMuXm8YlPV9MGgnkaZ+nw5KONUGRmFVZ4nvRINb2pMo1UMNDIMS
         xlQXXzK5AGUvi+LWgMdZGqnXqV6KzYcmC+glAm3bv+JGwI0EF2z6SSvPVUGwkw1oln6V
         fKF9is1Adwq5zcvX7oW5/bP5d/iMNZqa7vySM0UJ4WYnfTZKbtjU+4BcOduh4IpHfNAG
         K7fmzTK3TB0LD9TxWpYmNe1OtWtTp93y8452vADkjz6OlyVamK5uRaeg7V2SrAMvoyBz
         Jcfg==
X-Forwarded-Encrypted: i=1; AJvYcCXMyMGSfJanpWKoAXTxSX4vUlv9b2wbhYkHWBGdXksuRTDPCV1HI5XP+rCd1jjykTClLVVDJSQIKIJorS0qaEQgAtATNnl5wBoT6EXX
X-Gm-Message-State: AOJu0Yxk3YDH1ZRYLZZrNjPPBMZgktd7KBGvd4I27VWwnLKiKf360Xsp
	Xi/6tZLQFA3s1EMLd4U5fnHP6N+xPeRHKq+JU3j4XoL6R2FgR5BNC5IwzCc9Av0=
X-Google-Smtp-Source: AGHT+IGQEH1Pckgyx97VaV3qo9MCG5UniieyW2RPfQREJEuRYUX82wG9nTv/Om2GeygIf4u8y9Tjhw==
X-Received: by 2002:a17:902:e751:b0:1dc:1e4f:9b3f with SMTP id p17-20020a170902e75100b001dc1e4f9b3fmr7654206plf.24.1708589570167;
        Thu, 22 Feb 2024 00:12:50 -0800 (PST)
Received: from hsinchu15.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id lf8-20020a170902fb4800b001db5ea825b2sm9412796plb.123.2024.02.22.00.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 00:12:49 -0800 (PST)
From: Nylon Chen <nylon.chen@sifive.com>
To: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	conor@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	aou@eecs.berkeley.edu,
	thierry.reding@gmail.com,
	u.kleine-koenig@pengutronix.de
Cc: vincent.chen@sifive.com,
	zong.li@sifive.com,
	nylon.chen@sifive.com,
	nylon7717@gmail.com
Subject: [PATCH v9 2/3] pwm: sifive: change the PWM algorithm
Date: Thu, 22 Feb 2024 16:12:30 +0800
Message-ID: <20240222081231.213406-3-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222081231.213406-1-nylon.chen@sifive.com>
References: <20240222081231.213406-1-nylon.chen@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `frac` variable represents the pulse inactive time, and the result
of this algorithm is the pulse active time.
Therefore, we must reverse the result.

The reference is SiFive FU740-C000 Manual[0]

Link: https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86ed8b16acba_fu740-c000-manual-v1p6.pdf [0]

Co-developed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Zong Li <zong.li@sifive.com>
Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
---
 drivers/pwm/pwm-sifive.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index eabddb7c7820..a586cfe4191b 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -110,9 +110,10 @@ static int pwm_sifive_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 				struct pwm_state *state)
 {
 	struct pwm_sifive_ddata *ddata = pwm_sifive_chip_to_ddata(chip);
-	u32 duty, val;
+	u32 duty, val, inactive;
 
-	duty = readl(ddata->regs + PWM_SIFIVE_PWMCMP(pwm->hwpwm));
+	inactive = readl(ddata->regs + PWM_SIFIVE_PWMCMP(pwm->hwpwm));
+	duty = (1U << PWM_SIFIVE_CMPWIDTH) - 1 - inactive;
 
 	state->enabled = duty > 0;
 
@@ -123,7 +124,7 @@ static int pwm_sifive_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	state->period = ddata->real_period;
 	state->duty_cycle =
 		(u64)duty * ddata->real_period >> PWM_SIFIVE_CMPWIDTH;
-	state->polarity = PWM_POLARITY_INVERSED;
+	state->polarity = PWM_POLARITY_NORMAL;
 
 	return 0;
 }
@@ -139,7 +140,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	int ret = 0;
 	u32 frac;
 
-	if (state->polarity != PWM_POLARITY_INVERSED)
+	if (state->polarity != PWM_POLARITY_NORMAL)
 		return -EINVAL;
 
 	cur_state = pwm->state;
@@ -159,6 +160,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	frac = DIV64_U64_ROUND_CLOSEST(num, state->period);
 	/* The hardware cannot generate a 100% duty cycle */
 	frac = min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
+	frac = (1U << PWM_SIFIVE_CMPWIDTH) - 1 - frac;
 
 	mutex_lock(&ddata->lock);
 	if (state->period != ddata->approx_period) {
-- 
2.43.0


