Return-Path: <linux-kernel+bounces-113053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D195A888117
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EDE11C2148F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6741448F7;
	Sun, 24 Mar 2024 22:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHY00jqq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572801448D9;
	Sun, 24 Mar 2024 22:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319862; cv=none; b=XQ3MWu0nm7fXtt/wY8PzfNWPovkjvoU9/eMDIqBSgzQjjixYRe4nWWpsB1q+Oq+Ku5EWSaLHXXQdqe2OH4pbq2hbia+/YtH/j2rXFbXVrQgdY/waKmB/mi42swwCL6IePmk2lZUzT2MBZD1uXkpBjhnH2dIlFv3PGMTUjgkldo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319862; c=relaxed/simple;
	bh=U7UUfpnSunlKz2k+7C0ZDRf/QE5Hl7pDxKb9sSrtVZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rXxexc/75e7BE5R1kxhNaM0NM3nrZlr++l/l9bl6ghu1bs96r+yIwJBuwhGSG0aXi/8YR5+eBypuC+kzVh+IcrMsDsA0R23s8pY1YCWB2HZ1dPg8iVUSp9Ns0QktMSl3H8JYFmUrTUk9BLKQ5tMOAuLyV4DNNCFl81oapQ7gayY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHY00jqq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7397BC43390;
	Sun, 24 Mar 2024 22:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319862;
	bh=U7UUfpnSunlKz2k+7C0ZDRf/QE5Hl7pDxKb9sSrtVZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MHY00jqqh2+xD9zV5lhTnLrd62JqMOLBc10EdCADxHLV9oplNPyf7J0Y7+TP6tdK2
	 YR8R2AC1f3tCL/Xhzn+BSzHQ1WWl9EmQ+olGP8wpiSXirjt2WumIhdh/bGizQ6PR/X
	 zoltIKYA1rK7XiPGWT6z0dRZ5itHHg3yWJL7JC/+0zcJEsv3P9lmOFWav05Mrs/1kp
	 GfLcvQEr7oUGUCLDEy7iv9N1rwJwgGVOhPHXZ2uLMwBreuV1cULwN+M6ZqDn8vmEA8
	 asbBuMtKLD46t10N4OHqsGA+w4djQH/lLMfN8Eexi2sRjI0F7GK1dTWwbuk0DPgyDx
	 /JymRIKvUI6yg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 166/715] pwm: sti: Fix capture for st,pwm-num-chan < st,capture-num-chan
Date: Sun, 24 Mar 2024 18:25:45 -0400
Message-ID: <20240324223455.1342824-167-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 6cf55cf34d39f..69b1113c6b821 100644
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
 
@@ -646,7 +655,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
 
 	pc->chip.dev = dev;
 	pc->chip.ops = &sti_pwm_ops;
-	pc->chip.npwm = pc->cdata->pwm_num_devs;
+	pc->chip.npwm = max(cdata->pwm_num_devs, cdata->cpt_num_devs);
 
 	for (i = 0; i < cdata->cpt_num_devs; i++) {
 		struct sti_cpt_ddata *ddata = &cdata->ddata[i];
-- 
2.43.0


