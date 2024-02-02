Return-Path: <linux-kernel+bounces-50388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE1E847864
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66B14B2D039
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA63813249D;
	Fri,  2 Feb 2024 18:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+C+aGCr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43951369A2;
	Fri,  2 Feb 2024 18:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899248; cv=none; b=TTiXVZrSZ9gpg8b0MBNpwpG3ncMJXAL6BO9/cS0W0OTzr1KofphER1+mdjgHPFX59QzzplkfkXmh8ZIw0hit/tW/sW3WA6rUzLTtX7T3pxath4Nj6W33Wi1706ahqpip8Negh58uqQfU/sHKhwPz6LEBKxd4u4q67wMAeLysJuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899248; c=relaxed/simple;
	bh=XDGChs3C5gdoEueI7oNpmXwNAkZhxRdlIIfIwPywzJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LipE7YbRyH6sxItnYQk4d7qDzoWLxjOqEp4d/tS/PT5PJRdvPXcAzlhCn1Tly//2IXphxQqxih3iHtqk6Ui4F7CGolyK8+iA8FR1OqCBtCte0+s7xSu3WLaH3WT/VN/flCf3lA/G/xeq76gqdSicK92m2c0aXCcOczsJQ/8rltQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+C+aGCr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F07C433B1;
	Fri,  2 Feb 2024 18:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899248;
	bh=XDGChs3C5gdoEueI7oNpmXwNAkZhxRdlIIfIwPywzJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s+C+aGCrVGjp0yP+0eBsWgPUoa9PrpWUo1fF69o2Dicr8OoJ+s/7DqR77fZ2DXpzH
	 5K5Hkl3lAU5hP1FpZxy3YpVuIznssWVl8k3TTAhHYdvl/UxN/n5EU3hYXsqA96T8il
	 MtCuNWLruyq0Q8vpQYxagUmtO0h3mOgtZv1B6CpXnTOcU4299vYSpT9CJpq+RsBkDk
	 vN6Co7Loac9Re1+VVUqpxDNQ/5kjMh3FVbbat6zLbGfGxneC7FXwMnIzAOI7Mu46Uk
	 6IiB9ZCESH1y5okeK2sn4JyD1fYWsWJzxtNZ+CDWyGPU/uEzcYxbKguE9QrpoyUXWs
	 Pq5D/0ijqTh8A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>,
	Patrick Williams <patrick@stwcx.xyz>,
	Tao Ren <rentao.bupt@gmail.com>,
	Bruno Thomsen <bruno.thomsen@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	shawnguo@kernel.org,
	bcousson@baylibre.com,
	tony@atomide.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-omap@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 19/21] ARM: dts: Fix TPM schema violations
Date: Fri,  2 Feb 2024 13:40:06 -0500
Message-ID: <20240202184015.540966-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184015.540966-1-sashal@kernel.org>
References: <20240202184015.540966-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.15
Content-Transfer-Encoding: 8bit

From: Lukas Wunner <lukas@wunner.de>

[ Upstream commit 8412c47d68436b9f9a260039a4a773daa6824925 ]

Since commit 26c9d152ebf3 ("dt-bindings: tpm: Consolidate TCG TIS
bindings"), several issues are reported by "make dtbs_check" for ARM
devicetrees:

The nodename needs to be "tpm@0" rather than "tpmdev@0" and the
compatible property needs to contain the chip's name in addition to the
generic "tcg,tpm_tis-spi" or "tcg,tpm-tis-i2c":

  tpmdev@0: $nodename:0: 'tpmdev@0' does not match '^tpm(@[0-9a-f]+)?$'
        from schema $id: http://devicetree.org/schemas/tpm/tcg,tpm_tis-spi.yaml#

  tpm@2e: compatible: 'oneOf' conditional failed, one must be fixed:
        ['tcg,tpm-tis-i2c'] is too short
        from schema $id: http://devicetree.org/schemas/tpm/tcg,tpm-tis-i2c.yaml#

Fix these schema violations.

Aspeed Facebook BMCs use an Infineon SLB9670:
https://lore.kernel.org/all/ZZSmMJ%2F%2Fl972Qbxu@fedora/
https://lore.kernel.org/all/ZZT4%2Fw2eVzMhtsPx@fedora/
https://lore.kernel.org/all/ZZTS0p1hdAchIbKp@heinlein.vulture-banana.ts.net/

Aspeed Tacoma uses a Nuvoton NPCT75X per commit 39d8a73c53a2 ("ARM: dts:
aspeed: tacoma: Add TPM").

phyGATE-Tauri uses an Infineon SLB9670:
https://lore.kernel.org/all/ab45c82485fa272f74adf560cbb58ee60cc42689.camel@phytec.de/

A single schema violation remains in am335x-moxa-uc-2100-common.dtsi
because it is unknown which chip is used on the board.  The devicetree's
author has been asked for clarification but has not responded so far:
https://lore.kernel.org/all/20231220090910.GA32182@wunner.de/

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Patrick Williams <patrick@stwcx.xyz>
Reviewed-by: Tao Ren <rentao.bupt@gmail.com>
Reviewed-by: Bruno Thomsen <bruno.thomsen@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts   | 4 ++--
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts    | 4 ++--
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts           | 2 +-
 arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi | 4 ++--
 arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri.dtsi          | 2 +-
 arch/arm/boot/dts/nxp/imx/imx7d-flex-concentrator.dts        | 2 +-
 arch/arm/boot/dts/ti/omap/am335x-moxa-uc-2100-common.dtsi    | 2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
index e899de681f47..5be0e8fd2633 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
@@ -45,8 +45,8 @@ spi1_gpio: spi1-gpio {
 		num-chipselects = <1>;
 		cs-gpios = <&gpio0 ASPEED_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
 
-		tpmdev@0 {
-			compatible = "tcg,tpm_tis-spi";
+		tpm@0 {
+			compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
 			spi-max-frequency = <33000000>;
 			reg = <0>;
 		};
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
index a677c827e758..5a8169bbda87 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
@@ -80,8 +80,8 @@ spi_gpio: spi {
 		gpio-miso = <&gpio ASPEED_GPIO(R, 5) GPIO_ACTIVE_HIGH>;
 		num-chipselects = <1>;
 
-		tpmdev@0 {
-			compatible = "tcg,tpm_tis-spi";
+		tpm@0 {
+			compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
 			spi-max-frequency = <33000000>;
 			reg = <0>;
 		};
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts
index 3f6010ef2b86..213023bc5aec 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts
@@ -456,7 +456,7 @@ &i2c1 {
 	status = "okay";
 
 	tpm: tpm@2e {
-		compatible = "tcg,tpm-tis-i2c";
+		compatible = "nuvoton,npct75x", "tcg,tpm-tis-i2c";
 		reg = <0x2e>;
 	};
 };
diff --git a/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi b/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
index 31590d3186a2..00e5887c926f 100644
--- a/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
+++ b/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
@@ -35,8 +35,8 @@ spi_gpio: spi {
 		gpio-mosi = <&gpio0 ASPEED_GPIO(X, 4) GPIO_ACTIVE_HIGH>;
 		gpio-miso = <&gpio0 ASPEED_GPIO(X, 5) GPIO_ACTIVE_HIGH>;
 
-		tpmdev@0 {
-			compatible = "tcg,tpm_tis-spi";
+		tpm@0 {
+			compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
 			spi-max-frequency = <33000000>;
 			reg = <0>;
 		};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri.dtsi
index ea627638e40c..7dd1fe5a2fb7 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri.dtsi
@@ -121,7 +121,7 @@ &ecspi1 {
 	tpm_tis: tpm@1 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_tpm>;
-		compatible = "tcg,tpm_tis-spi";
+		compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
 		reg = <1>;
 		spi-max-frequency = <20000000>;
 		interrupt-parent = <&gpio5>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx7d-flex-concentrator.dts b/arch/arm/boot/dts/nxp/imx/imx7d-flex-concentrator.dts
index 3a723843d562..9984b343cdf0 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7d-flex-concentrator.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx7d-flex-concentrator.dts
@@ -130,7 +130,7 @@ &ecspi4 {
 	 * TCG specification - Section 6.4.1 Clocking:
 	 * TPM shall support a SPI clock frequency range of 10-24 MHz.
 	 */
-	st33htph: tpm-tis@0 {
+	st33htph: tpm@0 {
 		compatible = "st,st33htpm-spi", "tcg,tpm_tis-spi";
 		reg = <0>;
 		spi-max-frequency = <24000000>;
diff --git a/arch/arm/boot/dts/ti/omap/am335x-moxa-uc-2100-common.dtsi b/arch/arm/boot/dts/ti/omap/am335x-moxa-uc-2100-common.dtsi
index b8730aa52ce6..a59331aa58e5 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-moxa-uc-2100-common.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am335x-moxa-uc-2100-common.dtsi
@@ -217,7 +217,7 @@ &spi1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi1_pins>;
 
-	tpm_spi_tis@0 {
+	tpm@0 {
 		compatible = "tcg,tpm_tis-spi";
 		reg = <0>;
 		spi-max-frequency = <500000>;
-- 
2.43.0


