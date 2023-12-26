Return-Path: <linux-kernel+bounces-11255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1A981E3BA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BF69B22635
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 00:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190AD59B5E;
	Tue, 26 Dec 2023 00:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNZrKYys"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6495059B46;
	Tue, 26 Dec 2023 00:23:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 214A9C433C8;
	Tue, 26 Dec 2023 00:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550237;
	bh=Bmr2KJSHLE3jYu92u4jB4H3npK88ZS0ZQcmhtihwVRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hNZrKYysIqTrKfxIFBdrP08yHASZFfdmSr71CQMztQWZmqZkKyIw+ou1b8KOWhGr0
	 npsQO9Znf5nKoUybvXzNBUXRyYZydM6IwkYTdXoxKBk9L2V8rz8szxdey3uEdKGnlu
	 fEGLHStk+fqqSaNcA+tsIu0I16S4axhVuR9McgMyC1RoDDqMStIKBEkIES2Hxr7Fka
	 lwHORjiXhadwVrpseOTff8LsKi70S4dPbN1vQ7PaJq7c1gvIBnllXE4ANqjMEq8mY9
	 r7PCD552fPl2ReBM68wb1wllw4G71b/XACmkhpJoVw6jRRjxcpZcodB5kKQzUjHUG/
	 zjsqt/VuX9i1Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 23/24] pinctrl: cy8c95x0: Fix get_pincfg
Date: Mon, 25 Dec 2023 19:22:16 -0500
Message-ID: <20231226002255.5730-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231226002255.5730-1-sashal@kernel.org>
References: <20231226002255.5730-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.69
Content-Transfer-Encoding: 8bit

From: Patrick Rudolph <patrick.rudolph@9elements.com>

[ Upstream commit 94c71705cc49092cef60ece13a28680809096fd4 ]

Invert the register value for PIN_CONFIG_OUTPUT_ENABLE to return
the opposite of PIN_CONFIG_INPUT_ENABLE.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Link: https://lore.kernel.org/r/20231219125120.4028862-3-patrick.rudolph@9elements.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-cy8c95x0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index 501b7c181df00..2a6158a052a31 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -752,6 +752,8 @@ static int cy8c95x0_gpio_get_pincfg(struct cy8c95x0_pinctrl *chip,
 	ret = regmap_read(chip->regmap, reg, &reg_val);
 	if (reg_val & bit)
 		arg = 1;
+	if (param == PIN_CONFIG_OUTPUT_ENABLE)
+		arg = !arg;
 
 	*config = pinconf_to_config_packed(param, (u16)arg);
 out:
-- 
2.43.0


