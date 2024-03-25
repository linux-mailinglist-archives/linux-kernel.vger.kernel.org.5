Return-Path: <linux-kernel+bounces-117266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A162F88A96C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A19B1F6388F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9477E144300;
	Mon, 25 Mar 2024 14:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="r6Hadb3M"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7484317B;
	Mon, 25 Mar 2024 14:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711377355; cv=none; b=MZ/Z3+9VyiXxmRmNUcgXrKU+8VxTA9liEsu2SPiGfU5H3rbo/sim3mWwuWSDB6YxIa7aalT0TyUj9N49HqNsKqwb+baUBLWQ86U3T11hqOXMHhYhVVPJqSsC5G4O2MK9kvlf8APSniAjKUQufAxOy8Y3+7Mpr8DTsnkcKO/WBRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711377355; c=relaxed/simple;
	bh=an7bqbwd3dY5kDiijgoOPRJOOMJxM2nrHUHfTXZHSt8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qys6w/D49gRH+IwVK58UCqIHl943u5FL7/lZNlaTtqictSAXoBpLcHLbpICgh/3Teg/99IgeGmpnRK8nDrXksOqSNq3vJUuzCnYp9S14Og4V14lBLslXSFSvoF3OO63M7pJJRdQQ1DkWG7cjNCqd4boWyMd1TqkEusxqj1XKcT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=r6Hadb3M; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42PEZHj4096694;
	Mon, 25 Mar 2024 09:35:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711377318;
	bh=7VEN6CcVqpXAQcxkPxLacRLhJ2Mwhs7ycVWHGNp2PWc=;
	h=From:To:CC:Subject:Date;
	b=r6Hadb3Mzd9RT7DjjHyHu87dy1VsmLa829oiL2IZjr4Z6GD37k4Idfho3+wcSYnIT
	 Mkz4nce/E1S4QFxxOxT0hdVG7hTLrWqdSD/umeoeHPfhwIeyXu+CbFvg85w+AE25di
	 aTWH12SA2j/I3tfIKBaRjvfdvCfN/mEehrYQhuWA=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42PEZHtG011013
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Mar 2024 09:35:17 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Mar 2024 09:35:17 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Mar 2024 09:35:17 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42PEZHLf123147;
	Mon, 25 Mar 2024 09:35:17 -0500
From: Nishanth Menon <nm@ti.com>
To: Tero Kristo <kristo@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>
CC: Robert Nelson <robertcnelson@gmail.com>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Shengyu Qu <wiagn233@outlook.com>,
        Sukrut Bellary <sukrut.bellary@linux.com>,
        Javier Martinez Canillas
	<javierm@redhat.com>,
        Bill Mills <bill.mills@linaro.org>
Subject: [PATCH V2] arm64: dts: ti: k3-am625-beagleplay: Use mmc-pwrseq for wl18xx enable
Date: Mon, 25 Mar 2024 09:35:10 -0500
Message-ID: <20240325143511.2144768-1-nm@ti.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Texas Instruments, Inc.
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Sukrut Bellary <sukrut.bellary@linux.com>

BeaglePlay SBC[1] has Texas Instrument's WL18xx WiFi chipset[2].

Currently, WLAN_EN is configured as regulator and regulator-always-on.
However, the timing and wlan_en sequencing is not correctly modelled.

This causes the sdio access to fail during runtime-pm power operations
saving or during system suspend/resume/hibernation/freeze operations.
This is because the WLAN_EN line is not deasserted to low '0' to power
down the WiFi. So during restore, the WiFi driver tries to load the FW
without following correct power sequence. WLAN_EN => '1'/assert (high)
to power-up the chipset.

Use mmc-pwrseq-simple to drive TI's WiFi (WL18xx) chipset enable
'WLAN_EN'. mmc-pwrseq-simple provides power sequence flexibility with
support for post power-on and power-off delays.

Typical log signature that indicates this bug is:
wl1271_sdio mmc2:0001:2: sdio write failed (-110)

Followed by possibly a kernel warning (depending on firmware present):
WARNING: CPU: 1 PID: 45 at drivers/net/wireless/ti/wlcore/sdio.c:123 wl12xx_sdio_raw_write+0xe4/0x168 [wlcore_sdio]

[1] https://www.beagleboard.org/boards/beagleplay
[2] https://www.ti.com/lit/ds/symlink/wl1807mod.pdf

Fixes: f5a731f0787f ("arm64: dts: ti: Add k3-am625-beagleplay")
Suggested-by: Shengyu Qu <wiagn233@outlook.com>
Signed-off-by: Sukrut Bellary <sukrut.bellary@linux.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Picking this patch up since Sukrut was not able to refresh the patch in
the list and it does'nt make much sense to hold off this critical fixup.

Boot log:
https://gist.github.com/nmenon/a34abd03a6aaf84a39ffa569df248285
(includes defconfig change to make iwd work)

Changes Since v1:
* Update the power-on-time to 10ms (same as used in:
	arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
	arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
  )
* Add in-code documentation pointing at timing diagram for the values
  used.
* Fixup fail log and commit message and make it generic to indicate
  various other usecases of failure.
* Re-test on v6.9-rc1

V1: https://lore.kernel.org/all/20231213213219.566369-1-sukrut.bellary@linux.com/

 .../arm64/boot/dts/ti/k3-am625-beagleplay.dts | 27 +++++++++----------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
index a34e0df2ab86..ffc613543968 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
@@ -82,6 +82,17 @@ wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@9db00000 {
 		};
 	};
 
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_en_pins_default>;
+		/* Interal power on time(Figure 8-3) * 2 */
+		post-power-on-delay-ms = <10>;
+		/* Re-enable time(Figure 8-2) + 20uS */
+		power-off-delay-us = <80>;
+		reset-gpios = <&main_gpio0 38 GPIO_ACTIVE_LOW>;
+	};
+
 	vsys_5v0: regulator-1 {
 		bootph-all;
 		compatible = "regulator-fixed";
@@ -104,20 +115,6 @@ vdd_3v3: regulator-2 {
 		regulator-boot-on;
 	};
 
-	wlan_en: regulator-3 {
-		/* OUTPUT of SN74AVC2T244DQMR */
-		compatible = "regulator-fixed";
-		regulator-name = "wlan_en";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		enable-active-high;
-		regulator-always-on;
-		vin-supply = <&vdd_3v3>;
-		gpio = <&main_gpio0 38 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&wifi_en_pins_default>;
-	};
-
 	vdd_3v3_sd: regulator-4 {
 		/* output of TPS22918DBVR-U21 */
 		bootph-all;
@@ -839,13 +836,13 @@ &sdhci1 {
 };
 
 &sdhci2 {
-	vmmc-supply = <&wlan_en>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&wifi_pins_default>, <&wifi_32k_clk>;
 	non-removable;
 	ti,fails-without-test-cd;
 	cap-power-off-card;
 	keep-power-in-suspend;
+	mmc-pwrseq = <&sdio_pwrseq>;
 	assigned-clocks = <&k3_clks 157 158>;
 	assigned-clock-parents = <&k3_clks 157 160>;
 	#address-cells = <1>;

base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
2.43.0


