Return-Path: <linux-kernel+bounces-11254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C9B81E3B7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1AC21F21379
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 00:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7767835F0D;
	Tue, 26 Dec 2023 00:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erQugn+T"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BF35916C;
	Tue, 26 Dec 2023 00:23:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A0DC433B6;
	Tue, 26 Dec 2023 00:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550236;
	bh=S3WABjvm4trviiu3emPkc/9hxdtUAqhIyZWTzOX8BH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=erQugn+TT6M/UKb4mDsUbV7FLlRl7Lo21KrsLYV2WLgen6Um9oXnXf95FYAbCE3p/
	 PfWpf+ycCGLR8xIYsbFFXgvIi8aCNyKzw/pgp2vcgEg/Pb0uutsGVdAqGIpquGsK4t
	 YmPn4OiqsppUzKqd0QUk7a8dtCn6yahO2GR1Gb3UWn64xg+svE4vjOZe/uBEweZnjq
	 6hFbXMxpvYE6dS77u8fQQUuEp7/QYSiW7P3Cl9G40FiSVayVORCZ1p/S48bdIqGqEi
	 KnkXGCw9WMQTR6al9lZ2msFKT0IacVzkECJtHlYC/adeFjyfSdAQ2qtYgKYNjn1HQY
	 7x0gXxAqwujeA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 22/24] pinctrl: cy8c95x0: Fix regression
Date: Mon, 25 Dec 2023 19:22:15 -0500
Message-ID: <20231226002255.5730-22-sashal@kernel.org>
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
index 99c3fe4ca518e..501b7c181df00 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -304,6 +304,9 @@ static const char * const cy8c95x0_groups[] = {
 	"gp77",
 };
 
+static int cy8c95x0_pinmux_direction(struct cy8c95x0_pinctrl *chip,
+				     unsigned int pin, bool input);
+
 static inline u8 cypress_get_port(struct cy8c95x0_pinctrl *chip, unsigned int pin)
 {
 	/* Account for GPORT2 which only has 4 bits */
@@ -764,6 +767,7 @@ static int cy8c95x0_gpio_set_pincfg(struct cy8c95x0_pinctrl *chip,
 	u8 port = cypress_get_port(chip, off);
 	u8 bit = cypress_get_pin_mask(chip, off);
 	unsigned long param = pinconf_to_config_param(config);
+	unsigned long arg = pinconf_to_config_argument(config);
 	unsigned int reg;
 	int ret;
 
@@ -802,6 +806,12 @@ static int cy8c95x0_gpio_set_pincfg(struct cy8c95x0_pinctrl *chip,
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


