Return-Path: <linux-kernel+bounces-114354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A28D688911D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45757B31D93
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA6C17264D;
	Sun, 24 Mar 2024 23:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBv4GbeF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B0413B7A6;
	Sun, 24 Mar 2024 23:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321743; cv=none; b=ugPksYx+mj1DEp6of7XD0IsjVWosiI63L4B3dcTUXrNghNYBhjcgTdaVDxj1Q+QNTsMkUlfdmknpQK+IRV6a0D82FuVOERsI5jee12zuYSsI+ffC5JMmldkfIFuwFYKlVhN9hPJO7dd22ueafWiGSdDZqALD6Bxu7Ak3wFRde1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321743; c=relaxed/simple;
	bh=Rr7Pi00i2BKkcC7gbeC5htge01QJINLxEHJpcIxDxnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L2xJ2anjV1YcGq1mTDWrTeC21FMKVarKcBQEVsuO9A6GxdW+jWFY8g8W6NRL18dyvmD5SSjRygKR2MFJb/LVltRKDszeE+/gst5f5t/x/GCZ8SJC2eDNBBGADPzMPVb2g5m6qgS3rrkmUNCqHjcu0PpwwNEVbmN0Djs9Vli0GDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBv4GbeF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CFCC433C7;
	Sun, 24 Mar 2024 23:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321742;
	bh=Rr7Pi00i2BKkcC7gbeC5htge01QJINLxEHJpcIxDxnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PBv4GbeFa9+GPDShsB56sdLEJ6vnY2au2PDjqNILTQQBW7op8YU1iwxzFOD5eqPTX
	 LzXtLS3ZPpRVrRHu/nM7xIwiYvlv/TSOJjtxZPO/bfZUXIdxJzZ0Nut2KU6ahIQRe1
	 BQa5OsoN0kbjkWlnJWpIppCEPC3SWKEmTtPb673ajTRyYxA7chcf4XPTx4tct9aVwA
	 6n/xVefAOY6Si0ddCnfnyu+RMypou5gqLQsli4z1Ic76d4OSBVm7EhS27dxPTIMSco
	 0/1Z73T4mnahNLZDfvB44p26vfzZR9zQilCFtlS1Qttz2UKKFpL65tETfQA9NaKaAM
	 aXyoBYhR+1gUw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 470/638] gpio: nomadik: fix offset bug in nmk_pmx_set()
Date: Sun, 24 Mar 2024 18:58:27 -0400
Message-ID: <20240324230116.1348576-471-sashal@kernel.org>
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
index 86a638077a697..e7d33093994b2 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -1573,8 +1573,10 @@ static int nmk_pmx_set(struct pinctrl_dev *pctldev, unsigned function,
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


