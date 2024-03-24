Return-Path: <linux-kernel+bounces-114154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7398888BC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 046EB1F2A749
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A92F154C05;
	Sun, 24 Mar 2024 23:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DARfLaLQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965D52046DC;
	Sun, 24 Mar 2024 23:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321468; cv=none; b=nkDlbxtuOQwbV/HNiFx4ci9UiF1SL8oa+nNsmtrfpr1RxYQSqM86q8CMfAs83ryFY9EjGPqmVKhjYk3h7JV5WP29lKm5KpbV1r618tvQcjbLKxRTmsjNghOufaeEANlv36Sjnp7DKoR3P5qJzy+VS7rBH1+Qutk4pBj9RM2wR38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321468; c=relaxed/simple;
	bh=6hCrKi98dMVDgFgeCygjagN6sTUVvKnVanZ0V+Mizj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o2+uONPoMd4F84HzWHAMn7HbAx1zMiOEskZQggHpLWIDLv6e4SE9d3IKnajSvLBuYsVdY6kzjDizEUhl3DXMLdm83pxg/n91bxcjsLaSR+7cqqDxgoEAgttHqmEWN3Y3RIZfxM4ZpLpVSGVnO16DTaLwc+RQfa3icIvw6WHJYYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DARfLaLQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE158C433C7;
	Sun, 24 Mar 2024 23:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321467;
	bh=6hCrKi98dMVDgFgeCygjagN6sTUVvKnVanZ0V+Mizj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DARfLaLQ22oUGHahDyRQRxruanNdsGaGaXTLbxUv0TdJzWtN146V8PJzqoh2nZsc6
	 VL9Zm+BxguusSwMcaHIaGD2FYj1GVgd4TTbcT5pIR+wlk8WpRdoO4z57uJbCwzqZLs
	 wfFrCbCdFjaXI1KY3dddd63jXQSVOrVap+BRbj7Y7n/jQP133BQh0JBUmFu0wl2utg
	 AdfoTWBfjoyDV8GNHNRjSrbRef/Xu+QuttcWhC6othvn31pItWpMXYumvHG1ZoV9ax
	 v4nA1vs7I0u1chIxTop0LWBaSSoImdoUzcaLvV1oflmrZilYAWL2mGKpIz0JsAisRr
	 OkKK/+I9/ee7Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 192/638] pwm: sti: Fix capture for st,pwm-num-chan < st,capture-num-chan
Date: Sun, 24 Mar 2024 18:53:49 -0400
Message-ID: <20240324230116.1348576-193-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 5f623835584f1c8d1030666796f40c47a448ce0b ]

The driver only used the number of pwm channels to set the pwm_chip's
npwm member. The result is that if there are more capture channels than
PWM channels specified in the device tree, only a part of the capture
channel is usable. Fix that by passing the bigger channel count to the
pwm framework. This makes it possible that the .apply() callback is
called with .hwpwm >= pwm_num_devs, catch that case and return an error
code.

Fixes: c97267ae831d ("pwm: sti: Add PWM capture callback")
Link: https://lore.kernel.org/r/20240204212043.2951852-2-u.kleine-koenig@pengutronix.de
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-sti.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index c8800f84b917f..c782378dff5e5 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -395,8 +395,17 @@ static int sti_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 static int sti_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			 const struct pwm_state *state)
 {
+	struct sti_pwm_chip *pc = to_sti_pwmchip(chip);
+	struct sti_pwm_compat_data *cdata = pc->cdata;
+	struct device *dev = pc->dev;
 	int err;
 
+	if (pwm->hwpwm >= cdata->pwm_num_devs) {
+		dev_err(dev, "device %u is not valid for pwm mode\n",
+			pwm->hwpwm);
+		return -EINVAL;
+	}
+
 	if (state->polarity != PWM_POLARITY_NORMAL)
 		return -EINVAL;
 
@@ -647,7 +656,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
 
 	pc->chip.dev = dev;
 	pc->chip.ops = &sti_pwm_ops;
-	pc->chip.npwm = pc->cdata->pwm_num_devs;
+	pc->chip.npwm = max(cdata->pwm_num_devs, cdata->cpt_num_devs);
 
 	for (i = 0; i < cdata->cpt_num_devs; i++) {
 		struct sti_cpt_ddata *ddata = &cdata->ddata[i];
-- 
2.43.0


