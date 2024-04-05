Return-Path: <linux-kernel+bounces-133633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12ECC89A698
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCB931F26030
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0D7174ECB;
	Fri,  5 Apr 2024 21:47:23 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1E1178CFF
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 21:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353634; cv=none; b=MfdLxWZjteVMBj9nKb1p7ZWcKyyCxG9kSQxUJQp8PF7H5RBjTvH15dcvFNjdB1QS6JER1N1ZAqmvzmccC3NeEaoSi3aGJ1zGMLr9gzIYKRdZZnmyu+z2IWSPrMqZHlw1aEpnrvAZ1cBRuUEMyPyBf/GGLYnPqVabWPdsiy94Uw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353634; c=relaxed/simple;
	bh=GZvUtXzU2tewU6FPGPjsH3vEMVSncLLSweZKUQW1vBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sJYHL/YEZktg0M2u2vMrSUAYwgh6zBSEVv4gLOi7uFVCDd6IXFkCpaUHcu9N2kTS34TNXhgUdDjxjpcBFIMJR98MaxhhT/TIL/2vD1Tq3WVPt4r+li6baCZhLwNVatOX2lCDpJ/90QzsfId72Y/ssgzETEBVvBVMpLsQuyzlfqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOZ-0003Br-Bl; Fri, 05 Apr 2024 23:46:47 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOY-00Ad4F-Mu; Fri, 05 Apr 2024 23:46:46 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOY-00FZpO-20;
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
Subject: [PATCH v1 15/49] ARM: dts: imx6qdl-gw52xx: Use #pwm-cells = <3> for imx27-pwm device
Date: Fri,  5 Apr 2024 23:42:02 +0200
Message-ID:  <381ec16b4616ffae0d7adcf36a251f1107d7ca1f.1712352665.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1252; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=GZvUtXzU2tewU6FPGPjsH3vEMVSncLLSweZKUQW1vBc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmEHBHo/ltKKZ8cuQAt8zSBcAeTlnCDPdrZv4wX MRihcn1/ZOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZhBwRwAKCRCPgPtYfRL+ TjF6B/0fVBuclEskRuOavL7hhhwMMK6jyb20ttZxlSGZ0qvvjoQ7Jm+Hu15guD8GIlhs3R4FAcR 5EdZx0hMhkRuJyS9apNDyOc/CDZrpyVQ47zV2NigGs/zgcUiIyczbBHtKIn8YDAfKniD5jpGeIq LFyQt+XOoWlYjnwlBqqDWXwoCLEpklEnurTJ6radcuo8qGDhP/MIT9teG5wwOOVGZ7ha1xuPGfG PUfwCL5AsFBZ7GV7ujQGALsK4CddL7K9TAVFCfLEW04q9NPB0E8eq8DqFlTuAkp7bKMqgfeDA1e rg2HdjP1Wcb9iJer4YjyexB6w7BOijnXD1Tn85UpC6OrtPhR
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The binding dictates using 3 pwm-cells. Adhere to that.

This fixes the following dtbs_check warnings:

	arch/arm/boot/dts/nxp/imx/imx6dl-gw52xx.dtb: pwm@208c000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#
	arch/arm/boot/dts/nxp/imx/imx6q-gw52xx.dtb: pwm@208c000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw52xx.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw52xx.dtsi
index 535679c27d6f..48ffb3ee01bd 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw52xx.dtsi
@@ -25,7 +25,7 @@ chosen {
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm4 0 5000000>;
+		pwms = <&pwm4 0 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <7>;
 	};
@@ -520,7 +520,6 @@ &pwm3 {
 };
 
 &pwm4 {
-	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm4>;
 	status = "okay";
-- 
2.43.0


