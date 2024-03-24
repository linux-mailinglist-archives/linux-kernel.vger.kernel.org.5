Return-Path: <linux-kernel+bounces-115826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0113E8894C0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 326611C2D7A2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04669145B0B;
	Mon, 25 Mar 2024 03:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LK4AuACZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFAD145FF5;
	Sun, 24 Mar 2024 23:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322059; cv=none; b=Onr6ES1Z0ICAPvXSPOtumO0Q9WA4s4si6aiK6oFioMNDU4v7Ijiield9ECbKWSsnVnDS9Mj5daBb9QOBbwp8DQGE/pFYd33JntbCKs/4iem4V0Hf9FD1oXLqIsW/YMNFP3lcZ7JxqfE5qJm6W/qIcqK8X0ZSCF+Yrd+xuSTIEy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322059; c=relaxed/simple;
	bh=tuaO+TMyNegk7atL+7siquVjQWrQBQOb9fB6/Uozhyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TEzbPYhli9bFtZtzKB1jfPiEwyM63zF7K70wcyyrGajqat5r/C5ICbUW4mMbuku6ihODSXkn3/uC0Yu9P8H9NHwNwTjjlygKZaB3H1GuoGL/b3xEXW6m+aOX2MRR4SKCxuGFeR7S2EmBJr3gxkv7a+G4K7Owe6D2N4PuCtrTJd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LK4AuACZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB9DC433C7;
	Sun, 24 Mar 2024 23:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322059;
	bh=tuaO+TMyNegk7atL+7siquVjQWrQBQOb9fB6/Uozhyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LK4AuACZP4B9zEPgoUoen4y9dDXRWqGYkCXOknYzxtqc5CjW7CIjkQG8hnQltZUKZ
	 w+AnfUTZAZQIazdN6mEX0KjZ8AzGM+jyDf1MnNaVBw8ABP7Xtxo6z/viom4080E+AK
	 hKmggEedLJPOHbtDqBO5EcAiR7Ol2aEpsLcoj7zfCa7dHLUH8h7R4rsajkgJ6ZQkXA
	 oM20Gh88WV7E8Eojl2oc1j1BGyG4HVTl8LUsBSvcB3ay/jvdVI/NJDpoCZT8WnuWrY
	 X6gmIzBH2UoaWJyaiNsfnVZuibQRvOZtDoyuR9mo8l1dZ5jxbU0HWSU0dqcNvxuUIw
	 1mo2TkYnQyhhg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 132/451] pwm: sti: Fix capture for st,pwm-num-chan < st,capture-num-chan
Date: Sun, 24 Mar 2024 19:06:48 -0400
Message-ID: <20240324231207.1351418-133-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 652fdb8dc7bfa..0a7920cbd4949 100644
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


