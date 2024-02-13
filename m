Return-Path: <linux-kernel+bounces-62845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F928526C7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D48AA1C25034
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C509E6E2A2;
	Tue, 13 Feb 2024 01:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKcPJtL8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3876669D01;
	Tue, 13 Feb 2024 01:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707786236; cv=none; b=dQXcjkMRdRBRe0KuATzofb7hL/iCrFJrtseYHqe86sqjSKKGwajlYxwEXJikyBKfpXgoGs1luMNPuLhn0bO4MwRRUJGYXNYoy5UkxK3Ai6rZhh8+nJN4CkQPV1YqOvyavDwt3NRgIdHlSekAgLq2WIXyxy3FpfnZtSiEqghB9Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707786236; c=relaxed/simple;
	bh=Oc6mVzGyq/BN1P7mRTpRHKgFXcuCun6rDvCNqAaPnEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FSdACDzJvKRfzdt8MYnjtOzNq94QeuOL4eGxGRIc0L0WS+3HQja/KIUmsUdFzHwOjHCYpnTBpOHVtPwuRg3z08fpDOv61Jpskw4YbQXOQbOOpFjA3Zrf6zA4JYcOWoqO4R6ogjH5QFSzH4/xFvsPnRmBplW0U8lDs3vEN2mfzwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKcPJtL8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BEAAC433B2;
	Tue, 13 Feb 2024 01:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707786235;
	bh=Oc6mVzGyq/BN1P7mRTpRHKgFXcuCun6rDvCNqAaPnEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mKcPJtL8ZkvRX3ihoSlK23ml3tIypYeKNljH2z7Oucl2NjD+S1FL+ic/RyU7ujITs
	 XPd8RO0yiOPR/nqyELodeZusPJg+mRIXq6j8LV7EVzq9a5JDygrxON9TLt1SQBNcp4
	 xRAEi/dD6CI/lS/K4LYGDDeXpjwJJKjGKs6qYQEiOEwEILW22BeuaiT/EcQyPThTTf
	 r+vSq8+jC66aIoxF9KUfPWqdyDs2CEgUv/uTg9Yi6vfFbgahhAGFWo0TaA+Q5dqDuo
	 2BA61YyPdn77oxBIu5nf5Vt0pbPuuZw9M2AaiHY9SKr7Pab8NcuRx5mXG+AeP6VlbR
	 bOIdqYdVLms1Q==
Received: by mercury (Postfix, from userid 1000)
	id 63782106D63A; Tue, 13 Feb 2024 02:03:49 +0100 (CET)
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
Subject: [PATCH v2 12/17] ARM: dts: nxp: imx6ul: xnur-gpio -> xnur-gpios
Date: Tue, 13 Feb 2024 02:01:01 +0100
Message-ID: <20240213010347.1075251-13-sre@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213010347.1075251-1-sre@kernel.org>
References: <20240213010347.1075251-1-sre@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace all "xnur-gpio" with "xnur-gpios" in the
i.MX6UL(L) Touchscreen node.

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


