Return-Path: <linux-kernel+bounces-31949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E6B83541E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 02:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02DF41C2112C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 01:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270CF35891;
	Sun, 21 Jan 2024 01:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="go2unihH"
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE0035292;
	Sun, 21 Jan 2024 01:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705801600; cv=none; b=PLhNikp2n+s4i3bxBoh8636mDV7FeL9C023JBLU4g1z/AFbwEWiZ0HiOmUuRknX8sOuuqOP43+DvY2ETeMJP7LVfxUcQmTSCiw0VJ2cUafqeuzZmhsDzlFULSv7GqLZRRuc7u4f/bJ9eDbq+yGOh8zkLwpKdkAO/SOi8Sau6HnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705801600; c=relaxed/simple;
	bh=0Qorkd0LmlFqn728SoPqMwhcM8AsRBxN+sCmP8incD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mlfblFpd5wERXzRTnX4IV/0lE610A5IS4Z/p9WqI7UUtfFwL/iNUSNSxjoBypYYjI4jfRonaHuYHrfYMj170qaSvB1hJoHFMEgPzbrsflaqOwL5LxpZPDForlSKv6esxKId1Ko9RsL/N857Tq6OtF4EFWzUJNA0LTZY2PYosqJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=go2unihH; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 43C8843C8C;
	Sun, 21 Jan 2024 01:46:37 +0000 (UTC)
From: Aren Moynihan <aren@peacevolution.org>
To: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
	Aren Moynihan <aren@peacevolution.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Quentin Schulz <quentin.schulz@bootlin.com>,
	Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 3/3] power: supply: axp20x_usb_power: set input current limit in probe
Date: Sat, 20 Jan 2024 20:40:04 -0500
Message-ID: <20240121014057.1042466-7-aren@peacevolution.org>
In-Reply-To: <20240121014057.1042466-1-aren@peacevolution.org>
References: <20240121014057.1042466-1-aren@peacevolution.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1705801597;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:in-reply-to:references;
	bh=vMyg+vwFP4scpXStIE0uQ3xwlw79VXW+sqgg112o19M=;
	b=go2unihHUCDvGf2rxNqpJZFRHUG8yq9g6DqT05V4XXvHkiOAeC62icrSsw5zD6zKqgEu9p
	rW1cfQ9sfWZI5h2wyuFI0DSHVYyAExSRlOEJo8fP8bgHxWH+xeTIcWMsB2JqnnXdqAUZbd
	oX+HI1vYliv8Z4UQisDZfm487TbMvak=

axp803 sets the current limit to 3A by default if it doesn't detect a
battery. The datasheet says that reg 0x2D bit 6 is used to indicate
first power on status. According to it, if that bit is 0 and the
battery is not detected, it will set the input current limit to 3A,
however setting that bit to 1 doesn't to prevent the pmic from setting
the current limit to 3A.

Fixes: c279adafe6ab ("power: supply: axp20x_usb_power: add support for AXP813")

Signed-off-by: Aren Moynihan <aren@peacevolution.org>
---
I'm not sure if the pmic simply ignores the first power on field, or if
it needs to be set in a specific way / at a specific time. I tried
setting it in arm-trusted-firmware, and the pmic still set the input
current limit to 3A.

The datasheet for axp813 says it has the same first power on bit, but I
don't have hardware to test if it behaves the same way. This driver uses
the same platform data for axp803 and axp813.

 drivers/power/supply/axp20x_usb_power.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 5656f6e57d54..95b136ee20f2 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -52,6 +52,7 @@ struct axp_data {
 	const int			*curr_lim_table;
 	int				input_curr_lim_table_size;
 	const int			*input_curr_lim_table;
+	int				force_input_curr_lim;
 	struct reg_field		curr_lim_fld;
 	struct reg_field		input_curr_lim_fld;
 	struct reg_field		vbus_valid_bit;
@@ -599,6 +600,7 @@ static const struct axp_data axp813_data = {
 	.input_curr_lim_table_size = ARRAY_SIZE(axp_813_usb_input_curr_lim_table),
 	.input_curr_lim_table = axp_813_usb_input_curr_lim_table,
 	.input_curr_lim_fld = REG_FIELD(AXP22X_CHRG_CTRL3, 4, 7),
+	.force_input_curr_lim = 500000,
 	.usb_bc_en_bit	= REG_FIELD(AXP288_BC_GLOBAL, 0, 0),
 	.usb_bc_det_fld = REG_FIELD(AXP288_BC_DET_STAT, 5, 7),
 	.vbus_disable_bit = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 7, 7),
@@ -786,6 +788,17 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 			return ret;
 	}
 
+	if (power->axp_data->force_input_curr_lim) {
+		/*
+		 * Certain chips set the input current limit to 3A when there is
+		 * no battery connected. Normally the default is 500mA.
+		 */
+		ret = axp20x_usb_power_set_input_current_limit(power,
+				power->axp_data->force_input_curr_lim);
+		if (ret)
+			return ret;
+	}
+
 	if (power->usb_bc_en_bit) {
 		/* Enable USB Battery Charging specification detection */
 		ret = regmap_field_write(power->usb_bc_en_bit, 1);
-- 
2.43.0


