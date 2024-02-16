Return-Path: <linux-kernel+bounces-69438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 632688588FA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 952281C23F09
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3714214F9C5;
	Fri, 16 Feb 2024 22:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RP9JWmfM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E3814AD3E;
	Fri, 16 Feb 2024 22:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708123023; cv=none; b=ayPNsXV+PGtnLTpCJVcqkIihkLlnhMmJrQtcLKXEiojPV40Tk9h8VKbfjKfVcu6CNArrp9RKwPVM5/H6MazVr/D7Qc8egSa6lJ8OSuaW8wKasVkogQ4ap+9Wx+z/Ur8fKX+2y/XLOiM67yG2DdUjscEC0jyq1HrN06Bivy+cpkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708123023; c=relaxed/simple;
	bh=nsdECdtc+oGmOuZ7VxRJHeIcnfIbJIkf1IiNPAlLR+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hGD5NuETm+p/cYkrfoo+kGJvSCtNId6B9+ihe5FArvrW3TL2q6noPm3w3oTNf2DnQ2rbJpD0XU84lNDLgnv9X/twaLR0iVTUlkylGefgUBzte6fIKSp4y48KFYm8W1KLI1VLltuRfiOIME39NYkC5C699+NiN5/MTYmndlXW2Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RP9JWmfM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE86C32783;
	Fri, 16 Feb 2024 22:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708123022;
	bh=nsdECdtc+oGmOuZ7VxRJHeIcnfIbJIkf1IiNPAlLR+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RP9JWmfMv7coTeNzJqvrPOWqfG/KLXfSEekSZze3d9iNflrpISs/HYoXr9HQo0bGv
	 86qKdTjsdxNN2hoiT9KIOjhp8wBdUr5lMGq6ULkJniwN9SGpw7sLnqPZvcoQ6+FKST
	 Ab5CsIznz4Ige9LFNLNENtVJk9g2dSHmoJXm6iz8PU99ms5t8deVpB5hsKh4TXoVgL
	 X0jWOQaIbIJip4HffC7GxVoLG7xlWo9PGJ8cbFrQRCVpDv9MdXfrbeQ2n7XKMR3voy
	 sIDlG3fGELmtKmU8lOK2mIcyd2YCzLCt4OSyuiQYDkrA4SMK0l+fBjsqGCWmStglpT
	 X+EJ596FF2DfQ==
Received: by mercury (Postfix, from userid 1000)
	id C715D10633DA; Fri, 16 Feb 2024 23:36:56 +0100 (CET)
From: Sebastian Reichel <sre@kernel.org>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/16] ARM: dts: nxp: imx6ul: xnur-gpio -> xnur-gpios
Date: Fri, 16 Feb 2024 23:34:30 +0100
Message-ID: <20240216223654.1312880-12-sre@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216223654.1312880-1-sre@kernel.org>
References: <20240216223654.1312880-1-sre@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace all "xnur-gpio" with "xnur-gpios" in the i.MX6UL(L) Touchscreen
node, since the -gpio suffix is deprecated. All known implementations of
this binding can handle -gpio and -gpios since day 1, so this should be
fully backwards compatible.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dtsi          | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts                | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-opos6uldev.dtsi | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-som.dtsi         | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dtsi
index 2ac40d69425b..f10f0525490b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dtsi
@@ -321,7 +321,7 @@ &snvs_pwrkey {
 &tsc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_tsc>;
-	xnur-gpio = <&gpio1 3 GPIO_ACTIVE_LOW>;
+	xnur-gpios = <&gpio1 3 GPIO_ACTIVE_LOW>;
 	measure-delay-time = <0xffff>;
 	pre-charge-time = <0xfff>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts
index 875ae699c5cb..2ca18f3dad0a 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts
@@ -203,7 +203,7 @@ &pwm8 {
 &tsc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_tsc>;
-	xnur-gpio = <&gpio1 3 GPIO_ACTIVE_LOW>;
+	xnur-gpios = <&gpio1 3 GPIO_ACTIVE_LOW>;
 };
 
 &sai2 {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-opos6uldev.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-opos6uldev.dtsi
index 18cac19aa9b0..af337f18a266 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-opos6uldev.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-opos6uldev.dtsi
@@ -156,7 +156,7 @@ &snvs_pwrkey {
 &tsc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_tsc>;
-	xnur-gpio = <&gpio1 3 GPIO_ACTIVE_LOW>;
+	xnur-gpios = <&gpio1 3 GPIO_ACTIVE_LOW>;
 	measure-delay-time = <0xffff>;
 	pre-charge-time = <0xffff>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-som.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-som.dtsi
index 830b5a5064f2..6d2163250b5d 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-som.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-som.dtsi
@@ -273,7 +273,7 @@ &tsc {
 	pinctrl-names = "default";
 	pre-charge-time = <0xfff>;
 	touchscreen-average-samples = <32>;
-	xnur-gpio = <&gpio1 3 GPIO_ACTIVE_LOW>;
+	xnur-gpios = <&gpio1 3 GPIO_ACTIVE_LOW>;
 };
 
 /* DHCOM UART1 */
-- 
2.43.0


