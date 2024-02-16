Return-Path: <linux-kernel+bounces-69439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CED78588FB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 313281C24676
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373D714F9CA;
	Fri, 16 Feb 2024 22:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wlk1/bAX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B8114AD33;
	Fri, 16 Feb 2024 22:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708123023; cv=none; b=pxiSCR4xn4JfVrLmvhfBEbMut0daA4OksYCpM16Azyl+OT7ZLz/D+ZJZfMkSB6sMn3ssIVVB1DSWUbIUBm0uPpavodjzXSf+h8EC2BqUypFxLPEUKadGDQIqya7dc+XYQHm1D2raTrmF3OvnEMmfunmcJweM36QkZyX7bNty8VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708123023; c=relaxed/simple;
	bh=SAdPuLjhilobCNPcWWFQ6UbKmsBElzGTcLLtPhYgvDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RqT/hJhz00UbuEQW7X1ovVlHHQQ19Eu7+pEGTswKQzaXDn7VXNbY63wyoecDRSHXtuH3cZW43FE8/SKqGkL4KWRB4sEPeOBD1TwFCQSOe9TP6vZGDU91mm43YtaszluIx80b3xeyo+kB1sN9iKJ8t5pdpTcv7d7CZZRCus/BwEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wlk1/bAX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76808C43330;
	Fri, 16 Feb 2024 22:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708123022;
	bh=SAdPuLjhilobCNPcWWFQ6UbKmsBElzGTcLLtPhYgvDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wlk1/bAXpFbe/BP4FrctXle6GHcBWa8dalqwsVEZohWx4qXCfdHMm2cgVsdYzSbRr
	 h6sDz6F3yrrL1QM2qqqQsdJwkCZWZg/BLQrb5t7vMq2xu3pp4+7EJDBqY2y9wBN0kE
	 9C2JNtlc10CPiTt70XBgiEcjMynVcVbsj1ObYB9rYrfjnmopPaN4T8+hS6zWsvpW9+
	 d/OnfYz6lQqvvH6hG4BOuE07EnP/DN7xGYlLJi90l4iDShKuURFPctLgBlZODLVumc
	 QDvQtSDItAlsOFTG0GTO53ckh3uieu/jbKcSoiaahMmODbChf6UEG22puU7A6POHBD
	 cjeL7na3NZqHA==
Received: by mercury (Postfix, from userid 1000)
	id D22DE10633F2; Fri, 16 Feb 2024 23:36:56 +0100 (CET)
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
Subject: [PATCH v3 13/16] ARM: dts: nxp: imx: fix weim node name
Date: Fri, 16 Feb 2024 23:34:32 +0100
Message-ID: <20240216223654.1312880-14-sre@kernel.org>
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

DT node names should be generic, so replace "weim" node name with
"memory-controller" in all i.MX SoC DT files.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/imx1.dtsi    | 2 +-
 arch/arm/boot/dts/nxp/imx/imx27.dtsi   | 2 +-
 arch/arm/boot/dts/nxp/imx/imx31.dtsi   | 2 +-
 arch/arm/boot/dts/nxp/imx/imx35.dtsi   | 2 +-
 arch/arm/boot/dts/nxp/imx/imx51.dtsi   | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6sl.dtsi  | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6sx.dtsi  | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6ul.dtsi  | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx1.dtsi b/arch/arm/boot/dts/nxp/imx/imx1.dtsi
index 1ac10965fdfd..389ecb1ebf8f 100644
--- a/arch/arm/boot/dts/nxp/imx/imx1.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx1.dtsi
@@ -251,7 +251,7 @@ gpio4: gpio@21c300 {
 			};
 		};
 
-		weim: weim@220000 {
+		weim: memory-controller@220000 {
 			#address-cells = <2>;
 			#size-cells = <1>;
 			compatible = "fsl,imx1-weim";
diff --git a/arch/arm/boot/dts/nxp/imx/imx27.dtsi b/arch/arm/boot/dts/nxp/imx/imx27.dtsi
index ec472695c71e..ec3ccc8f4095 100644
--- a/arch/arm/boot/dts/nxp/imx/imx27.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx27.dtsi
@@ -568,7 +568,7 @@ nfc: nand-controller@d8000000 {
 			status = "disabled";
 		};
 
-		weim: weim@d8002000 {
+		weim: memory-controller@d8002000 {
 			#address-cells = <2>;
 			#size-cells = <1>;
 			compatible = "fsl,imx27-weim";
diff --git a/arch/arm/boot/dts/nxp/imx/imx31.dtsi b/arch/arm/boot/dts/nxp/imx/imx31.dtsi
index e1ae7c175f7d..00006c90d9a7 100644
--- a/arch/arm/boot/dts/nxp/imx/imx31.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx31.dtsi
@@ -352,7 +352,7 @@ nfc: nand@b8000000 {
 				status = "disabled";
 			};
 
-			weim: weim@b8002000 {
+			weim: memory-controller@b8002000 {
 				compatible = "fsl,imx31-weim", "fsl,imx27-weim";
 				reg = <0xb8002000 0x1000>;
 				clocks = <&clks 56>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx35.dtsi b/arch/arm/boot/dts/nxp/imx/imx35.dtsi
index 2d20e5541acc..442dc15677b8 100644
--- a/arch/arm/boot/dts/nxp/imx/imx35.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx35.dtsi
@@ -374,7 +374,7 @@ nfc: nand@bb000000 {
 				status = "disabled";
 			};
 
-			weim: weim@b8002000 {
+			weim: memory-controller@b8002000 {
 				#address-cells = <2>;
 				#size-cells = <1>;
 				clocks = <&clks 0>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx51.dtsi b/arch/arm/boot/dts/nxp/imx/imx51.dtsi
index c96d6311dfa7..4efce49022e4 100644
--- a/arch/arm/boot/dts/nxp/imx/imx51.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx51.dtsi
@@ -578,7 +578,7 @@ m4if: m4if@83fd8000 {
 				reg = <0x83fd8000 0x1000>;
 			};
 
-			weim: weim@83fda000 {
+			weim: memory-controller@83fda000 {
 				#address-cells = <2>;
 				#size-cells = <1>;
 				compatible = "fsl,imx51-weim";
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
index 81142c523fa8..8431b8a994f4 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
@@ -1158,7 +1158,7 @@ mmdc1: memory-controller@21b4000 { /* MMDC1 */
 				status = "disabled";
 			};
 
-			weim: weim@21b8000 {
+			weim: memory-controller@21b8000 {
 				#address-cells = <2>;
 				#size-cells = <1>;
 				compatible = "fsl,imx6q-weim";
diff --git a/arch/arm/boot/dts/nxp/imx/imx6sl.dtsi b/arch/arm/boot/dts/nxp/imx/imx6sl.dtsi
index 28111efb19a6..6aa61235e39e 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sl.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6sl.dtsi
@@ -949,7 +949,7 @@ rngb: rngb@21b4000 {
 				clocks = <&clks IMX6SL_CLK_DUMMY>;
 			};
 
-			weim: weim@21b8000 {
+			weim: memory-controller@21b8000 {
 				#address-cells = <2>;
 				#size-cells = <1>;
 				reg = <0x021b8000 0x4000>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi b/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
index df3a375f0a3e..0de359d62a47 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
@@ -1107,7 +1107,7 @@ fec2: ethernet@21b4000 {
 				status = "disabled";
 			};
 
-			weim: weim@21b8000 {
+			weim: memory-controller@21b8000 {
 				#address-cells = <2>;
 				#size-cells = <1>;
 				compatible = "fsl,imx6sx-weim", "fsl,imx6q-weim";
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
index 8aa365f837ca..aeb7e07fd309 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
@@ -975,7 +975,7 @@ memory-controller@21b0000 {
 				clocks = <&clks IMX6UL_CLK_MMDC_P0_IPG>;
 			};
 
-			weim: weim@21b8000 {
+			weim: memory-controller@21b8000 {
 				#address-cells = <2>;
 				#size-cells = <1>;
 				compatible = "fsl,imx6ul-weim", "fsl,imx6q-weim";
-- 
2.43.0


