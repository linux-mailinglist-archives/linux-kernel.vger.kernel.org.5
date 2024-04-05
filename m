Return-Path: <linux-kernel+bounces-133620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F3D89A68F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20BCE1C21832
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B4E17AF9C;
	Fri,  5 Apr 2024 21:47:18 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C3C176FD1
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 21:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353631; cv=none; b=GtQgPFKQQmH9S52bFE51dBar3OONqk2wzaIV5GkH2WasNqvX5wzxaskwXiI05yLy5w+FmGMIB704A/iPQ8/15Qt2VqtpA0DUWb4sRnGITKP1SgiNhQhmEA6E1aKgs8KXdu5Qn0L27ctzvkHxKU0LjEml/mTsbnkVEHTxggY3Kr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353631; c=relaxed/simple;
	bh=JhTSmh4zzQ5wEHoLiy4/dCfRWQEsg0BhNPg7zLHCge8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BP1nNADa8SAcTd1xevw3pXs8OhkoCsaKqJXQrJTb22HmdRAzwcbqTsz16pye/HtCDnaP2pQkfXIWJi8QiLScMcRDjICtUGsMxO3Ur0zOrP9PITFD2MlgfX+okJ+7AUv0jDy4x5BcyEr5+7SKWhbEdMsiajtwGX0DI+rpFEo/ANM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOZ-0003Ap-69; Fri, 05 Apr 2024 23:46:47 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOY-00Ad4C-HO; Fri, 05 Apr 2024 23:46:46 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOY-00FZpK-1T;
	Fri, 05 Apr 2024 23:46:46 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [PATCH v1 14/49] ARM: dts: imx6qdl-emcon: Use #pwm-cells = <3> for imx27-pwm device
Date: Fri,  5 Apr 2024 23:42:01 +0200
Message-ID:  <d267613675279703e87deac33d772a9688d6e048.1712352665.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1712352665.git.u.kleine-koenig@pengutronix.de>
References: <cover.1712352665.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2612; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=JhTSmh4zzQ5wEHoLiy4/dCfRWQEsg0BhNPg7zLHCge8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmEHBA+NQOEd7Cr1WSGTHtaZpF+dKCEJ5yze7/Q FvsRHH3JXWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZhBwQAAKCRCPgPtYfRL+ Tr6TB/4sJjl+Lk8BTneTVI0m+hnyO2Ui+576DvYFm9IGZbsVyGLih49XgLsQew+FB5D/9E0xFuv qab27BGIMNQNAzhDMXiMbqBoYdQlezELrMZE1ofbFVTN6izTbexHlKY0+suiq7WFiT26zMJ96+t +a6x+aS1ZcmLpPuFI0Xlchkp4Ly1GgO9fhu8W049zmdJNDmZQpx5EEAzYqSEIDhVKcpV2+R3xvs KjSkebGih7MqLrChgCNTH67iyaRSlEVubW1ZDfmXJNyUzA8Gce36CjBXZ2K15Timkazkz/V6Qcu IS3sfXxz2WiNSomV7d4vDp1Jwzz85FG8YhQNSdhYZx0mRdl0
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The binding dictates using 3 pwm-cells. Adhere to that.

This fixes the following dtbs_check warnings:

	arch/arm/boot/dts/nxp/imx/imx6dl-emcon-avari.dtb: pwm@2080000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#
	arch/arm/boot/dts/nxp/imx/imx6dl-emcon-avari.dtb: pwm@2088000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#
	arch/arm/boot/dts/nxp/imx/imx6dl-emcon-avari.dtb: pwm@208c000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#
	arch/arm/boot/dts/nxp/imx/imx6q-emcon-avari.dtb: pwm@2080000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#
	arch/arm/boot/dts/nxp/imx/imx6q-emcon-avari.dtb: pwm@2088000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#
	arch/arm/boot/dts/nxp/imx/imx6q-emcon-avari.dtb: pwm@208c000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-emcon.dtsi | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-emcon.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-emcon.dtsi
index 42b2ba23aefc..a308a3584b62 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-emcon.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-emcon.dtsi
@@ -66,7 +66,7 @@ lvds_backlight: lvds-backlight {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_lvds_bl>;
 		enable-gpios = <&gpio6 9 GPIO_ACTIVE_HIGH>;
-		pwms = <&pwm1 0 50000>;
+		pwms = <&pwm1 0 50000 0>;
 		brightness-levels = <
 			0 4 8 16 32 64 80 96 112
 			128 144 160 176 250
@@ -78,7 +78,7 @@ lvds_backlight: lvds-backlight {
 	pwm_fan: pwm-fan {
 		compatible = "pwm-fan";
 		#cooling-cells = <2>;
-		pwms = <&pwm4 0 50000>;
+		pwms = <&pwm4 0 50000 0>;
 		cooling-levels = <0 64 127 191 255>;
 		status = "disabled";
 	};
@@ -145,7 +145,7 @@ rgb_backlight: rgb-backlight {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_rgb_bl>;
 		enable-gpios = <&gpio6 8 GPIO_ACTIVE_HIGH>;
-		pwms = <&pwm3 0 5000000>;
+		pwms = <&pwm3 0 5000000 0>;
 		brightness-levels = <
 			250 176 160 144 128 112
 			96 80 64 48 32 16 8 1
@@ -736,17 +736,14 @@ &pcie {
 };
 
 &pwm1 {
-	#pwm-cells = <2>;
 	status = "okay";
 };
 
 &pwm3 {
-	#pwm-cells = <2>;
 	status = "okay";
 };
 
 &pwm4 {
-	#pwm-cells = <2>;
 	status = "okay";
 };
 
-- 
2.43.0


