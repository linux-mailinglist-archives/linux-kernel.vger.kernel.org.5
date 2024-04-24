Return-Path: <linux-kernel+bounces-156727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EAA8B075C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B7928667F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328351598EF;
	Wed, 24 Apr 2024 10:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMbrlT3q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B7415921D;
	Wed, 24 Apr 2024 10:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713954525; cv=none; b=hfM6LR+zGq5z5wM7H9g08Oz/SJOEr2BgoS15/uk02OBLl32RWeh5M4205rPpevpsdGB5tHn03FQd+is+UXo5fPCmdlCvQ0nI3kWB0HrzbCoZti/I/IlRnBeUGAtEEsw+m8H9v7dUwVuE1UlSLZTa1eeSEyyTvQlMBrSZFmhJecU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713954525; c=relaxed/simple;
	bh=8ajJMJwApKqgCf9f89bVvjuzXAt5v7XkRoPUav8YUV4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hc2EQfj0Zi9fLzLVvAn1VO4zqwRa5z2YpWVP5LbP9X3eQX2STrnMJ7zngc6+ndBPJIbjBBRKC2yeXrIYZGvbX62t5/SAflkpirxABJ62PsiHHEMK07L1l8NFlujpdHf4SUg2UO5HV9P52/rQV0snyTkGtKriTC31rPiNcTa49+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMbrlT3q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10352C32781;
	Wed, 24 Apr 2024 10:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713954525;
	bh=8ajJMJwApKqgCf9f89bVvjuzXAt5v7XkRoPUav8YUV4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YMbrlT3q971srEC/EdzXQzYg9th7O/dE3TBkPX+5C9rd86TwGXVoGLBlzixIqn32q
	 gqOFkCj/BOHOUaIWbP5Bpb4Wb6Wc9C4iJyztdGYGbigDAqNU63SzWRH/IMdfVcrlcd
	 p4fdK0b2XnSJEmO5V5Eg9FKu+OLwbhJiFolk3SfNlTlylYcVcsn68USIYn3mqgzRvv
	 VSotiIsqhReg5aL8SgoZoetk+PRnQWcaYSmaHVr4mjqXssEe6cUuR/A2YeQH3k35F/
	 jcoHjcduJZlSNl4FAPAYSwpUjJdSqn+u6Tl2BS0B77ZVJlwsO4n7KYujFAQfzf2nx/
	 VUza5eFYjAORw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DE9C10F15;
	Wed, 24 Apr 2024 10:28:44 +0000 (UTC)
From: Kelvin Zhang via B4 Relay <devnull+kelvin.zhang.amlogic.com@kernel.org>
Date: Wed, 24 Apr 2024 18:28:34 +0800
Subject: [PATCH v4 1/2] pwm: meson: Add support for Amlogic S4 PWM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-s4-pwm-v4-1-ee22effd40d0@amlogic.com>
References: <20240424-s4-pwm-v4-0-ee22effd40d0@amlogic.com>
In-Reply-To: <20240424-s4-pwm-v4-0-ee22effd40d0@amlogic.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Kelvin Zhang <kelvin.zhang@amlogic.com>, 
 Junyi Zhao <junyi.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713954523; l=2139;
 i=kelvin.zhang@amlogic.com; s=20240329; h=from:subject:message-id;
 bh=gtMEBe84ZprBZCQ2WIxZzSC+jfy6SdQC7eTQHo6OrP0=;
 b=2QReknnu4j0rhx43sc1H5ezdFAmc2B0Conf7r5ceTUUiA7AhpLj1EGHL8ako++gaojevQyKMp
 /bUmR33rPpQBpTp6b3G0VADO0q5tb3bJ3U47m/++XxFOOnLyRO0dKc6
X-Developer-Key: i=kelvin.zhang@amlogic.com; a=ed25519;
 pk=pgnle7HTNvnNTcOoGejvtTC7BJT30HUNXfMHRRXSylI=
X-Endpoint-Received: by B4 Relay for kelvin.zhang@amlogic.com/20240329 with
 auth_id=148
X-Original-From: Kelvin Zhang <kelvin.zhang@amlogic.com>
Reply-To: kelvin.zhang@amlogic.com

From: Junyi Zhao <junyi.zhao@amlogic.com>

This patch adds support for Amlogic S4 PWM.

Signed-off-by: Junyi Zhao <junyi.zhao@amlogic.com>
Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
---
 drivers/pwm/pwm-meson.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index ea96c5973488..6abc823745e4 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -462,6 +462,35 @@ static int meson_pwm_init_channels_meson8b_v2(struct pwm_chip *chip)
 	return meson_pwm_init_clocks_meson8b(chip, mux_parent_data);
 }
 
+static int meson_pwm_init_channels_meson_s4(struct pwm_chip *chip)
+{
+	int i, ret;
+	struct device *dev = pwmchip_parent(chip);
+	struct device_node *np = dev->of_node;
+	struct meson_pwm *meson = to_meson_pwm(chip);
+	struct meson_pwm_channel *channel;
+
+	for (i = 0; i < MESON_NUM_PWMS; i++) {
+		channel = &meson->channels[i];
+		channel->clk = of_clk_get(np, i);
+		if (IS_ERR(channel->clk)) {
+			ret = PTR_ERR(channel->clk);
+			dev_err_probe(dev, ret, "Failed to get clk\n");
+			goto err;
+		}
+	}
+
+	return 0;
+
+err:
+	while (--i >= 0) {
+		channel = &meson->channels[i];
+		clk_put(channel->clk);
+	}
+
+	return ret;
+}
+
 static const struct meson_pwm_data pwm_meson8b_data = {
 	.parent_names = { "xtal", NULL, "fclk_div4", "fclk_div3" },
 	.channels_init = meson_pwm_init_channels_meson8b_legacy,
@@ -500,6 +529,10 @@ static const struct meson_pwm_data pwm_meson8_v2_data = {
 	.channels_init = meson_pwm_init_channels_meson8b_v2,
 };
 
+static const struct meson_pwm_data pwm_meson_s4_data = {
+	.channels_init = meson_pwm_init_channels_meson_s4,
+};
+
 static const struct of_device_id meson_pwm_matches[] = {
 	{
 		.compatible = "amlogic,meson8-pwm-v2",
@@ -538,6 +571,10 @@ static const struct of_device_id meson_pwm_matches[] = {
 		.compatible = "amlogic,meson-g12a-ao-pwm-cd",
 		.data = &pwm_g12a_ao_cd_data
 	},
+	{
+		.compatible = "amlogic,meson-s4-pwm",
+		.data = &pwm_meson_s4_data
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, meson_pwm_matches);

-- 
2.37.1



