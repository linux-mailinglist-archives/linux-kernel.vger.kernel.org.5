Return-Path: <linux-kernel+bounces-57283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4437684D61F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00CAE2888FB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BF56A8D5;
	Wed,  7 Feb 2024 22:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="p4a1smpo"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAB520317;
	Wed,  7 Feb 2024 22:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707346540; cv=none; b=ZePSG1zOxevwIFpSrinGHP/5+kmWsPVerb+r3rFy8nPJLIIXm3wD/W+CgXlQ/AVb7jnxF1glRLXmIaeprOoumoVgVwasoESXgrLy1PPcKHlYy+BlMNyxbcI1ojGaFCiLohPw6BMpS8fGFSw16fW/BRbvQJOSefUkTMoMqq9W2zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707346540; c=relaxed/simple;
	bh=jENiGHyDBDfkXFMRZi02MBN1t2DVNvmbrSh3CPhenDI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p1TMIO1xz5O9u0tX/dmt4KlMYHi2hPzNdurj50KMLFef2IRmipUM1Nn4w5UQDycvTWepZJI2yuHksHz/na76Z9jyRR6OsGDgcEvvi9HyZ+kvto7MMpRaLNnjW1VfkJSgNH6u2WPfkcyXcSQdAT3sPaL2P4xP8LQFxeWi+UA2ztA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=p4a1smpo; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 417MtRwH014820;
	Wed, 7 Feb 2024 16:55:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707346527;
	bh=gjIQkQk0XyLlWC62YyfoYsqGsstVP1Jl1mRAtlNrcmg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=p4a1smpoP9gmWWDxtGmB15O42LccNAV2w3dW03TsjMNeNSGdGo3aNrCkpbLE8lm8K
	 FKfhgxilu8b3Bq8iQtqNgqbePxXhi4fqimxjz6csL1YplX42OEaDR7utNFrPn7398F
	 78XSQNsKfsbkS+QDaFxV1hFG7fmBRwwxNbxrVwA0=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 417MtRRE082339
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Feb 2024 16:55:27 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Feb 2024 16:55:27 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Feb 2024 16:55:27 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 417MtQmW014027;
	Wed, 7 Feb 2024 16:55:27 -0600
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 3/9] arm64: dts: ti: k3-am62a7-sk: Enable eMMC support
Date: Wed, 7 Feb 2024 16:55:20 -0600
Message-ID: <20240207225526.3953230-4-jm@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207225526.3953230-1-jm@ti.com>
References: <20240207225526.3953230-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Nitin Yadav <n-yadav@ti.com>

Add support for 32GB eMMC card on AM62A7 SK. Includes adding mmc0
pins settings. Add mmc0 alias for sdhci0 in k3-am62a7-sk.dts.

Signed-off-by: Nitin Yadav <n-yadav@ti.com>
Signed-off-by: Judith Mendez <jm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 26 +++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index f5ae91bf1bdb..c99b2e90f76d 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -20,6 +20,7 @@ aliases {
 		serial0 = &wkup_uart0;
 		serial2 = &main_uart0;
 		serial3 = &main_uart1;
+		mmc0 = &sdhci0;
 		mmc1 = &sdhci1;
 	};
 
@@ -263,6 +264,22 @@ AM62AX_IOPAD(0x0b4, PIN_INPUT_PULLUP, 1) /* (K24) GPMC0_CSn3.I2C2_SDA */
 		>;
 	};
 
+	main_mmc0_pins_default: main-mmc0-default-pins {
+		pinctrl-single,pins = <
+			AM62AX_IOPAD(0x220, PIN_INPUT, 0) /* (Y3) MMC0_CMD */
+			AM62AX_IOPAD(0x218, PIN_INPUT, 0) /* (AB1) MMC0_CLKLB */
+			AM62AX_IOPAD(0x21c, PIN_INPUT, 0) /* (AB1) MMC0_CLK */
+			AM62AX_IOPAD(0x214, PIN_INPUT, 0) /* (AA2) MMC0_DAT0 */
+			AM62AX_IOPAD(0x210, PIN_INPUT_PULLUP, 0) /* (AA1) MMC0_DAT1 */
+			AM62AX_IOPAD(0x20c, PIN_INPUT_PULLUP, 0) /* (AA3) MMC0_DAT2 */
+			AM62AX_IOPAD(0x208, PIN_INPUT_PULLUP, 0) /* (Y4) MMC0_DAT3 */
+			AM62AX_IOPAD(0x204, PIN_INPUT_PULLUP, 0) /* (AB2) MMC0_DAT4 */
+			AM62AX_IOPAD(0x200, PIN_INPUT_PULLUP, 0) /* (AC1) MMC0_DAT5 */
+			AM62AX_IOPAD(0x1fc, PIN_INPUT_PULLUP, 0) /* (AD2) MMC0_DAT6 */
+			AM62AX_IOPAD(0x1f8, PIN_INPUT_PULLUP, 0) /* (AC2) MMC0_DAT7 */
+		>;
+	};
+
 	main_mmc1_pins_default: main-mmc1-default-pins {
 		pinctrl-single,pins = <
 			AM62AX_IOPAD(0x23c, PIN_INPUT, 0) /* (A21) MMC1_CMD */
@@ -550,6 +567,15 @@ &main_i2c2 {
 	clock-frequency = <400000>;
 };
 
+&sdhci0 {
+	/* eMMC */
+	status = "okay";
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mmc0_pins_default>;
+	disable-wp;
+};
+
 &sdhci1 {
 	/* SD/MMC */
 	status = "okay";
-- 
2.43.0


