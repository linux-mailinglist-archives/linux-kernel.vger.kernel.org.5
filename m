Return-Path: <linux-kernel+bounces-114599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 556A3888B3C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86A211C2856E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFB829EA43;
	Sun, 24 Mar 2024 23:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N35zQ2lK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984FD2319DC;
	Sun, 24 Mar 2024 23:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322247; cv=none; b=FUOkvw4wLUsqYL74A7Y8bwHMs5aNlsHsYyxBn4OstMksVshsIwg5GtZYzF9HJHIu4q+YHaoRzrAeoFjJauzHXh6b8827Jfz/w3xy6FPNg1x3c/lBTJ0Je76AIdVJDnAlOkgwSfj9eCeFUq64TmD+sPSZuNXxJvI9CPcSvKgKXmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322247; c=relaxed/simple;
	bh=2LvAAb9spo9KlMrw2CMrVb72PvUDlCbqwU4aWrU3+cI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BvnlJHMMGruw1RPh+nDUdE7yh4IxtoVkF8did9HswcGeTgJ0Tcdhhvxq2uf61rLlDYSJTOKbrpSSsoymdMT1e80iJm6NYd6sMHoxqkGZeBPoQ6x6RqdtmjJ0ooWZDG0HPLmBWM01lDoU54Atod8Lw1fGyhjNyeULYq5d+eHmx3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N35zQ2lK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D132DC43390;
	Sun, 24 Mar 2024 23:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322247;
	bh=2LvAAb9spo9KlMrw2CMrVb72PvUDlCbqwU4aWrU3+cI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N35zQ2lKcZ7SQhLlmdzdrRUgBrEw9jVr8cxcmntSR6jTpQXq9hE5DTv6XzcWSeUBQ
	 KtEE5f4mQAu7VFgpE6g/NfGsLgzpf9qEqQnB3BA0OsWl2xTxhablc74K3/OQbxoI7Q
	 kGeJdPtb+MWM0CQV72wa8GQcua5rN3oHXwV7zEAosS4rc3jpCjsiigQF+liMaQm9sc
	 dGicOsCtb6jLqWK9tWVr4vcMLnuzqm9Ot9YqUQO+bejWucYw5WJjlreUHOPlheTphn
	 AreMs901lgQId5FBYMAccKISry7grKh/QO16yy8YBXOXiDV2DxmUZZMPo43jl0XKvu
	 HNJXn/0OHvgxQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 329/451] gpio: nomadik: fix offset bug in nmk_pmx_set()
Date: Sun, 24 Mar 2024 19:10:05 -0400
Message-ID: <20240324231207.1351418-330-sashal@kernel.org>
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
index f7d02513d8cc1..e79037dc85796 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -1571,8 +1571,10 @@ static int nmk_pmx_set(struct pinctrl_dev *pctldev, unsigned function,
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


