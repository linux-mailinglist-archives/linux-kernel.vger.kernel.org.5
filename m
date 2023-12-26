Return-Path: <linux-kernel+bounces-11416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B032981E5F9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 09:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2C891C21D0D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 08:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897304CB5F;
	Tue, 26 Dec 2023 08:40:22 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out28-81.mail.aliyun.com (out28-81.mail.aliyun.com [115.124.28.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ADF25778;
	Tue, 26 Dec 2023 08:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sjterm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sjterm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.502714|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0655499-0.0022427-0.932207;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=fuyao@sjterm.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.VtBiFDR_1703580005;
Received: from localhost(mailfrom:fuyao@sjterm.com fp:SMTPD_---.VtBiFDR_1703580005)
          by smtp.aliyun-inc.com;
          Tue, 26 Dec 2023 16:40:06 +0800
Date: Tue, 26 Dec 2023 16:40:05 +0800
From: Fuyao Kashizuku <fuyao@sjterm.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Wei Xu <xuwei5@hisilicon.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: =?utf-8?B?6bqm5YGl5bu6?= <maijianzhang@allwinnertech.com>
Subject: [PATCH v2] ARM: dts: sun8i: Open FETA40i-C regulator aldo1
Message-ID: <ZYqRZev1g_mztff2@debian.cyg>
Mail-Followup-To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Wei Xu <xuwei5@hisilicon.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	=?utf-8?B?6bqm5YGl5bu6?= <maijianzhang@allwinnertech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: work_work_work

The USB PHY in the Allwinner R40 SoC seems to rely on voltage on the
VCC-TVIN/OUT supply pins for proper operation, on top of its own supply
voltage on VCC-USB. Without a 3.3V voltage supplied to VCC-TV*, USB
operation becomes unstable and can result in disconnects.

The Forlinx FETA40i-C SoM connects both the VCC-TVOUT and VCC-TVIN pins
to the ALDO1 rail of the PMIC, so we need to enable that rail for USB
operation. Since there is no supply property in the DT bindings for
the USB core, we need to always enable the regulator.

This fixes unstable USB operation on boards using the Forlinx FETA40i-C
module.

Signed-off-by: Fuyao Kashizuku <fuyao@sjterm.com>
---
Changes in v2:
 - Subject include board name.
 - regulator name changed to vcc-3v3-tv-usb.
 - explain why we need to enable the regulator.
 - use full name of the commiter
 - Link to v1: https://lore.kernel.org/lkml/ZYKjYypuAx7gNuam@debian.cyg/

 arch/arm/boot/dts/allwinner/sun8i-r40-feta40i.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/allwinner/sun8i-r40-feta40i.dtsi b/arch/arm/boot/dts/allwinner/sun8i-r40-feta40i.dtsi
index 9f39b5a2bb35..c12361d0317f 100644
--- a/arch/arm/boot/dts/allwinner/sun8i-r40-feta40i.dtsi
+++ b/arch/arm/boot/dts/allwinner/sun8i-r40-feta40i.dtsi
@@ -42,6 +42,13 @@ &pio {
 	vcc-pg-supply = <&reg_dldo1>;
 };
 
+&reg_aldo1 {
+	regulator-always-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-3v3-tv-usb";
+};
+
 &reg_aldo2 {
 	regulator-always-on;
 	regulator-min-microvolt = <1800000>;
-- 
2.39.2

