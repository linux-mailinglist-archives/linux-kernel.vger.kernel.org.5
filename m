Return-Path: <linux-kernel+bounces-115514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6C088940F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BA441F2BCEC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED5D23B46B;
	Mon, 25 Mar 2024 02:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsMEYLzI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B5B12B159;
	Sun, 24 Mar 2024 22:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320962; cv=none; b=SyKe7uctL/ZZkPfDSRmKmAw4axPoJSdoftomX/piwnHvWtFCD30RuVOtsEP6CEt9m7z7he5ZmSk+KoV4udXLqoHMfzrYPtimKfSzsPu5EUddo/wsaBWIEBZ9wznLMwZzoD038msU/wUdTY9N/5gqmjq2gRNhXSYmErKLyfryFlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320962; c=relaxed/simple;
	bh=h1N7vHTMKPSHyWL4ms1StcDbFShuW2Hz5zNXog4pYzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AOmEyr2OBeQ7n7A6BKXa+vYHF8uVgp7jKgpvC9SgAREy5v6Z8UsTiKZEnvG5SyuXD+yrZ80lR8VtHaPTUVb1RdfObBp7GR0xSRUXmcwt0ZfBW2u9KTZd8zIRg5stz5VFyDRL3btzjkbG8REcb/D8VYfDHB+T4HVgqYTOqqIX9xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsMEYLzI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98A0C43394;
	Sun, 24 Mar 2024 22:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320962;
	bh=h1N7vHTMKPSHyWL4ms1StcDbFShuW2Hz5zNXog4pYzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hsMEYLzINKpR2aOlEAI15oz6htainGeEQ4E60RNFWADxXQmhmzorKeCX7mob+RaPX
	 u32A6uWawE5apciIZUcHZCrVRPv3XykX6iV/LsaVo1siVVJXkfzxrJwrXqjihuJY/K
	 uvJm1wjN/xIMbKQELttvtJzfWOr8rD73V2heUYa7smrMbbpnuYkjP1ARUdBl0bXVkS
	 IEgcKqFS6YH4MIO51Kt068VW1IYLv6sPlL7V+0+YCIqSkBU3nFZHpd2fzgeyhyPITN
	 Xbzfdq0FdlqiSaj5XouuUR+UN3JWvRq4frP6kMrsxsgZgjQi+LHOibJTlDA2hkuRwq
	 EoWFL2JOLk3gg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 525/713] gpio: nomadik: fix offset bug in nmk_pmx_set()
Date: Sun, 24 Mar 2024 18:44:11 -0400
Message-ID: <20240324224720.1345309-526-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 863732287b1e5..445c61a4a7e55 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -1575,8 +1575,10 @@ static int nmk_pmx_set(struct pinctrl_dev *pctldev, unsigned function,
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


