Return-Path: <linux-kernel+bounces-113388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7167A8883EE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1133EB24C19
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91731A1A75;
	Sun, 24 Mar 2024 22:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="synHpz9L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AD31A1A57;
	Sun, 24 Mar 2024 22:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320190; cv=none; b=KpthKOgcZTlUneDhXbiEMVxG0+pmsN7l2lnbqmjXzuy+bScUi5mPOLlLDnhm5tlrFCNsHVvEoFp4J7CuPNEgWMZT7t7Ufiqlbgf6uw7Qf8f73YigbXc0JV2Us0Pp3h/S0GKXyvmLNS96UUjaWoMqfXFBOcEpkhKaJVjkVBT+SOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320190; c=relaxed/simple;
	bh=+kgG5wR2vWX1ugL8uoAaasLM9ns/TbiPiJjlxwefhyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oNMGm2WXoRGrCU5xCOCcoXn4SHdwm9jiz5wkDuTvaMqWEeweldtHRaYyg4GQ5Y3/dH0aP92ZqiXQgDsTdP+aujJ/y70eIIN9G/+HqJTVgFwZBg6Jp/8NU5iiFeS4vNuqmTsYY7hEF4Hl/GP03glk6xGMDV0L1OW31tV+M7mHeD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=synHpz9L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35221C43390;
	Sun, 24 Mar 2024 22:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320189;
	bh=+kgG5wR2vWX1ugL8uoAaasLM9ns/TbiPiJjlxwefhyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=synHpz9LBFLiI2e48HTWg+yX0B+ebJdfyxyZO83yo8PMX/uj16jy3y6CiVVjvh3Ys
	 Wz7EYEil56tYC3MTWIhhCqr+a95UbZeIqScZDvbfMxC4R/YlhskB/amjY6arSHqE13
	 wQxvZFALB8bOuH0yCmP+ulkmrmlPcYFXdPzXQeE30l3P2bEmX780BD89r4CR2txWmy
	 /RQJ4oBCQrc1hQvfaVPhi8Uxtp54huwneQ1fNPn73whWNOlD2Sm6888J5+4zk9Of5F
	 M0Xw/U4sE39dh7lwEAAYuiG2CxnsF+SYBCstabmWw3t7qr6H0U594cbCeU/L+MBmLJ
	 lRMk9G4FO2zKA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 497/715] gpio: nomadik: fix offset bug in nmk_pmx_set()
Date: Sun, 24 Mar 2024 18:31:16 -0400
Message-ID: <20240324223455.1342824-498-sashal@kernel.org>
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

From: Théo Lebrun <theo.lebrun@bootlin.com>

[ Upstream commit 53cf6b72e074864b94ade97dcb6f30b5ac1a82dc ]

Previously, the statement looked like:

    slpm[x] &= ~BIT(g->grp.pins[i]);

Where:
 - slpm is a unsigned int pointer;
 - g->grp.pins[i] is a pin number. It can grow to more than 32.

The expected shift amount is a pin bank offset.

This bug does not occur on every group or pin: the altsetting must be
NMK_GPIO_ALT_C and the pin must be 32 or above. It might have occured.
For example, in pinctrl-nomadik-db8500.c, pin group i2c3_c_2 has the
right altsetting and pins 229 and 230.

Fixes: dbfe8ca259e1 ("pinctrl/nomadik: implement pin multiplexing")
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
Link: https://lore.kernel.org/r/20240228-mbly-gpio-v2-5-3ba757474006@bootlin.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/nomadik/pinctrl-nomadik.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index 7911353ac97d5..4f7c4af4f93cb 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -1579,8 +1579,10 @@ static int nmk_pmx_set(struct pinctrl_dev *pctldev, unsigned function,
 		 * Then mask the pins that need to be sleeping now when we're
 		 * switching to the ALT C function.
 		 */
-		for (i = 0; i < g->grp.npins; i++)
-			slpm[g->grp.pins[i] / NMK_GPIO_PER_CHIP] &= ~BIT(g->grp.pins[i]);
+		for (i = 0; i < g->grp.npins; i++) {
+			unsigned int bit = g->grp.pins[i] % NMK_GPIO_PER_CHIP;
+			slpm[g->grp.pins[i] / NMK_GPIO_PER_CHIP] &= ~BIT(bit);
+		}
 		nmk_gpio_glitch_slpm_init(slpm);
 	}
 
-- 
2.43.0


