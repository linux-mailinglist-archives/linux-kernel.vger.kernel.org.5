Return-Path: <linux-kernel+bounces-79874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3688627D7
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 22:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA7BB1F22384
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 21:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58EC54F95;
	Sat, 24 Feb 2024 21:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNTeXz1+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702474F8A2;
	Sat, 24 Feb 2024 21:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708810396; cv=none; b=JQ06uZOIi/unCxqCt9nor3bssQRGwn3bKDObDIGUzthWI3w0yoQZtp6OPeNY3G7o7DLM4filw1IjR+EYPKA6fjA2cNNUeW01LwFA5mfhaQUuqEoatY8feUCkIlWWaO0tWAaxIWC8ya4vMGQ9TRswpYXtF81DOK4lJbKP2Z+TVkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708810396; c=relaxed/simple;
	bh=bcNrHCs+XtlQKvFbrrcQck8fBVrNGGG/DApCkyizqTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uYmuh6hHh6qYTKLVpUd6zlwAoScO1v5fapC0cQxzwfeZ8f/qx499dJaTbeAS/IIMVBSZh7yEEZjPOSA21r9yhoNs4tpTEweM84gp1PpDCml2cluQdpOGHp3CdmQCb97E0PiKg4AkLyyYwTY3jntzwEDRlMvKL6Ci+ThtpR/ZC6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNTeXz1+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E255C433F1;
	Sat, 24 Feb 2024 21:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708810396;
	bh=bcNrHCs+XtlQKvFbrrcQck8fBVrNGGG/DApCkyizqTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MNTeXz1++vNGxPu0EtncbVDZLEfkG+xF08te7wLpbTIceU8Yoc1Smc61P6H6QE7rf
	 uj5bktZBApzk6Mr/nCR9N1r+p/yC+h/BG036mzDwnYXUnl2vKkfzln3CmyNPD4UK5c
	 kwwzFe2qRRwgQHjKEdwjRp09zqhbY3At0q3vmOZS7ccJ4LNGRTgDKQ60VEX7p73wD2
	 yQmtXQCs0s+B66hc4I4cY7Dg4c5lJfCU3dyygCPhYHT1YcgStT+bKrSULmWG/e60WP
	 wdGuWBkKoAE4/ytK+z4GTJYKMzxzC5AHMKXOmFslFRLcOLbtw00lLUW5h6E0S59GLQ
	 DtoPrGFsQYCaQ==
Received: by mercury (Postfix, from userid 1000)
	id 2D0261060EFA; Sat, 24 Feb 2024 22:33:10 +0100 (CET)
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
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 11/16] ARM: dts: nxp: imx6ul: xnur-gpio -> xnur-gpios
Date: Sat, 24 Feb 2024 22:29:43 +0100
Message-ID: <20240224213240.1854709-12-sre@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240224213240.1854709-1-sre@kernel.org>
References: <20240224213240.1854709-1-sre@kernel.org>
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

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


