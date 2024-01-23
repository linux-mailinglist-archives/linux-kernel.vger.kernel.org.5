Return-Path: <linux-kernel+bounces-34764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A0F838742
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA78F1F24807
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B21753E0C;
	Tue, 23 Jan 2024 06:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Jh0u21DP"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481C9524A3
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 06:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705990684; cv=none; b=mw15vGPs9kbbOjmFNCKjaMq/M6VU6GN/DXIyUFkg9f02INxHKYjnnpeFNndvhGCNyZf+cvHVzXhpkym1Jd1ZQb/vMWj6MBi6Oxz8P+LTIvbgW7wbb6rOk5szHL4wocYRQo54BSjNZdVHapZbJtAmSUq2yWtvqewvfpREv32zOr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705990684; c=relaxed/simple;
	bh=d06KhWfzzNhEwLATG5EAKVuMF8lG+Vj1y10Kz7W9+ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJlgN/KV8W0VbFjyI574VBe8CviNmOYA60oEZYsiYhRsA42tJzvtnVc3GK1UMHft2U67dQIXSPFCqJZtxMca6ucFYtErQiHeO3/87N3A8Ib9nyVPb1jj+YixoBQTh7lmS9rd3Tlfcfar4Vw/OX1X85AJ+ASnEuNEsfo7nHYVKxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Jh0u21DP; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6dbb26ec1deso4084243b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 22:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1705990682; x=1706595482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvJrbymRDVqsWiIagFJrDLqKjAGvymGFfMj4nY9d7Jo=;
        b=Jh0u21DPLVeCt7bQ7t/gweGDNXqOIZ5NRYS6eqCkWL5cT7gUmUT+5y0UATXHigJZ5+
         iFqRl/liZyKbF4+/xmK7B3n9yIxiYXXYmFFt2xytr+I59FUluy3OgfH8bfv0awAEVWnr
         ymMGgyF2MFzbvJA7/hXosVGu33yJmwz8hqV5mlQ03ZTrg17xSsI8zi2iSGZWyMH/IitL
         9VRD5rdlus9AjhzZ3eKdA6k9QQUbblYltd+Q0zRB0oXx0wqRU35A8XKmBjloa3D58RAd
         pJ3u9eysWacsiIt3mYVXcr9gfCq5IR49Ig9ycFpZJn7dTYVZtqN6IIivlMu8zp3Ampby
         hrwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705990682; x=1706595482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cvJrbymRDVqsWiIagFJrDLqKjAGvymGFfMj4nY9d7Jo=;
        b=MD+syt3xuNDSWy8fzsdZ9f2/LveWf+cyAisZJMcyq4Yq71c7ZlpcU3g2Dl40ivHJ0h
         PWz4iPPGky9Xb5yCDdXVXARjKw5sGlhuTvA5ErMAkjWIa5jCze8eqK1cupfPca0YYBLW
         /9ltHWyOdeHGzpNr/sLFXtQgmSrxGJRzA0l9FKBlxYCtyiOFH08Z0fzskPwpLSfnU2RS
         zxbpPPzx9LOlNkRbJMpv0+5RrwUWOPdRjWfa4DP+MBTbZvc5OMCR9OB7bbCXh0yQB/J+
         Tfwsbb8L+UEhYhBF13/BmkjfqfzuCw6oXDVe6GE3bAVg8ZQEqsw+wRWIk72sgx+LroKj
         41ug==
X-Gm-Message-State: AOJu0YwYkhZO00FCTISbT+zy/1zKIsaRP4vzNaqcA9bF0WmUrLQauDW8
	YEa30ynvH5zN91TZUYxXaZTUy1z8qmr5aICeE1OEzjYN8O3JQf8tWndxlI0EtM13iWuCRI9jBF0
	r
X-Google-Smtp-Source: AGHT+IEOZE+FU/vU9PCxfaGkCTPgaFa/4ycXAtuyVM2ziXvmuqSrHD4wV/6kejsabMmCEqh/hFuYzQ==
X-Received: by 2002:a05:6a20:3d96:b0:19a:da41:9da with SMTP id s22-20020a056a203d9600b0019ada4109damr6938288pzi.13.1705990682643;
        Mon, 22 Jan 2024 22:18:02 -0800 (PST)
Received: from hsinchu15.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902b08700b001d733c88646sm4425376plr.216.2024.01.22.22.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 22:18:02 -0800 (PST)
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
	zong.li@sifve.com,
	nylon.chen@sifive.com,
	nylon7717@gmail.com
Subject: [PATCH v7 2/3] pwm: sifive: change the PWM controlled LED algorithm
Date: Tue, 23 Jan 2024 14:17:47 +0800
Message-ID: <20240123061748.8844-3-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240123061748.8844-1-nylon.chen@sifive.com>
References: <20240123061748.8844-1-nylon.chen@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `frac` variable represents the pulse inactive time, and the result
of this algorithm is the pulse active time. Therefore, we must reverse the result.

The reference is SiFive FU740-C000 Manual[0]

Link: https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86ed8b16acba_fu740-c000-manual-v1p6.pdf [0]

Co-developed-by: Zong Li <zong.li@sifve.com>
Signed-off-by: Zong Li <zong.li@sifve.com>
Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
---
 drivers/pwm/pwm-sifive.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index eabddb7c7820..b07c8598bb21 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -113,6 +113,7 @@ static int pwm_sifive_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	u32 duty, val;
 
 	duty = readl(ddata->regs + PWM_SIFIVE_PWMCMP(pwm->hwpwm));
+	duty = (1U << PWM_SIFIVE_CMPWIDTH) - 1 - duty;
 
 	state->enabled = duty > 0;
 
@@ -123,11 +124,10 @@ static int pwm_sifive_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	state->period = ddata->real_period;
 	state->duty_cycle =
 		(u64)duty * ddata->real_period >> PWM_SIFIVE_CMPWIDTH;
-	state->polarity = PWM_POLARITY_INVERSED;
+	state->polarity = PWM_POLARITY_NORMAL;
 
 	return 0;
 }
-
 static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			    const struct pwm_state *state)
 {
@@ -139,7 +139,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	int ret = 0;
 	u32 frac;
 
-	if (state->polarity != PWM_POLARITY_INVERSED)
+	if (state->polarity != PWM_POLARITY_NORMAL)
 		return -EINVAL;
 
 	cur_state = pwm->state;
@@ -159,6 +159,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	frac = DIV64_U64_ROUND_CLOSEST(num, state->period);
 	/* The hardware cannot generate a 100% duty cycle */
 	frac = min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
+	frac = (1U << PWM_SIFIVE_CMPWIDTH) - 1 - frac;
 
 	mutex_lock(&ddata->lock);
 	if (state->period != ddata->approx_period) {
-- 
2.42.0


