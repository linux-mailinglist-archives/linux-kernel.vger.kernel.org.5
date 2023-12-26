Return-Path: <linux-kernel+bounces-11229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA4F81E370
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F6E5287772
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 00:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410E255C0F;
	Tue, 26 Dec 2023 00:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvjVox1v"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDE25579A;
	Tue, 26 Dec 2023 00:21:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E73C43397;
	Tue, 26 Dec 2023 00:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550117;
	bh=NfI2b0tEUWad3V/jyE1LkwsWUmkyinBQ9zJHV3CyqFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MvjVox1v/qEMlsiqcwi6jFbR4yqerTvRZF90DGG8Xhbm3XuRpA1tSs/fWpesmTsKR
	 qs1queGBuW4sT569ZCeqOL7lLIde8L0dnOqOf53B56hFclOLy4yVXRn9hdo6KCrPpT
	 po9W2vXXpTifD+e8FRxxwDGyKd0WgMSeHxlViwSOZqsBtblYvKfvJTDtC6+7YTCYxX
	 +HPmdiiQsXJcWMs7/7N+DeJnTJHCdLab/RZLUhOQW1BysINAGrQZTeUWJqQBoSCyCX
	 C8TRd9PbwulpSsN+mHFP2/DsQ7HYS6JyKjEPi3JKePj8LcA8eTXMAhO5A5aBUQqJap
	 2Nmfexj6V6jvg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 36/39] pinctrl: cy8c95x0: Fix regression
Date: Mon, 25 Dec 2023 19:19:26 -0500
Message-ID: <20231226002021.4776-36-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231226002021.4776-1-sashal@kernel.org>
References: <20231226002021.4776-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.8
Content-Transfer-Encoding: 8bit

From: Patrick Rudolph <patrick.rudolph@9elements.com>

[ Upstream commit 04dfca968cf7349773126340991b68a83378aca2 ]

Commit 1fa3df901f2c ("pinctrl: cy8c95x0: Remove custom ->set_config()")
removed support for PIN_CONFIG_INPUT_ENABLE and
PIN_CONFIG_OUTPUT.

Add the following options to restore functionality:
- PIN_CONFIG_INPUT_ENABLE
- PIN_CONFIG_OUTPUT_ENABLE

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Link: https://lore.kernel.org/r/20231219125120.4028862-2-patrick.rudolph@9elements.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-cy8c95x0.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index 993b30ebc6841..280d7ebd50b71 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -307,6 +307,9 @@ static const char * const cy8c95x0_groups[] = {
 	"gp77",
 };
 
+static int cy8c95x0_pinmux_direction(struct cy8c95x0_pinctrl *chip,
+				     unsigned int pin, bool input);
+
 static inline u8 cypress_get_port(struct cy8c95x0_pinctrl *chip, unsigned int pin)
 {
 	/* Account for GPORT2 which only has 4 bits */
@@ -726,6 +729,7 @@ static int cy8c95x0_gpio_set_pincfg(struct cy8c95x0_pinctrl *chip,
 	u8 port = cypress_get_port(chip, off);
 	u8 bit = cypress_get_pin_mask(chip, off);
 	unsigned long param = pinconf_to_config_param(config);
+	unsigned long arg = pinconf_to_config_argument(config);
 	unsigned int reg;
 	int ret;
 
@@ -764,6 +768,12 @@ static int cy8c95x0_gpio_set_pincfg(struct cy8c95x0_pinctrl *chip,
 	case PIN_CONFIG_MODE_PWM:
 		reg = CY8C95X0_PWMSEL;
 		break;
+	case PIN_CONFIG_OUTPUT_ENABLE:
+		ret = cy8c95x0_pinmux_direction(chip, off, !arg);
+		goto out;
+	case PIN_CONFIG_INPUT_ENABLE:
+		ret = cy8c95x0_pinmux_direction(chip, off, arg);
+		goto out;
 	default:
 		ret = -ENOTSUPP;
 		goto out;
-- 
2.43.0


