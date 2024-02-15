Return-Path: <linux-kernel+bounces-66458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D58C8855D00
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FD352912DE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910B118029;
	Thu, 15 Feb 2024 08:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nLukmeL/"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141F5175B1;
	Thu, 15 Feb 2024 08:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707987347; cv=none; b=R5pLgHqK25JoZAm98i0QDso0kNfzNWmY0oB+MMO/c3iYEUNhTU5K5OOsa9IxSRiLvTzGhicH+RDoxN0GNP9qQ5H3aux7mBwviI4nv+HeccC1MwDE/YUTa4GRGcAP83ThJpPaq/X9FjjU2twpTeuM7iPvU8LKOHN+tz8J5ucYtqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707987347; c=relaxed/simple;
	bh=4htfbBS51jnreuB8iFhcsTcQXTRQPWShEDKrBb5JIzk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PFBiDH7dbyuqAtoGJ7pU1dB8Ft6Zb4DcwPiAsXHWaL1mHde92jcyFR+2afkKG7lOFVsmTJUfM+j0FNHS2Qcq8/E6nJVreHh+vKdWLH52WUClGqEnNvE7ZyK4i5oM1Qg2BEgsUyFKT2q0jn7ubaK9tTQsidpMWkWS12/7q0amUxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nLukmeL/; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41F8tSin090471;
	Thu, 15 Feb 2024 02:55:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707987328;
	bh=KDgekC80YFSLo7k3ZuMZRvrm6iESaFQD1d3E5cj0jHI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=nLukmeL/01MsyXQUMtm2KYjL1i6Pv2DSOyRRnUDW8Q3m3yageYtvRf4KFaTtYTdot
	 v9TjH0ZC3OqbyHEKI3e0xsjgjFzSsCc+sP4kcHHvLg/O7/McxRQIKvBUIFiQ8GWFGC
	 qswtx1SY7HYuPxggsDaTmyD5CmjSBH6JKF++xjYs=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41F8tSXF069376
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Feb 2024 02:55:28 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Feb 2024 02:55:27 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Feb 2024 02:55:27 -0600
Received: from uda0490681.. ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41F8tJ7k008333;
	Thu, 15 Feb 2024 02:55:24 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <vigneshr@ti.com>, <nm@ti.com>, <conor+dt@kernel.org>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>
CC: <j-luthra@ti.com>, <devicetree@vger.kernel.org>, <j-choudhary@ti.com>,
        <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <vaishnav.a@ti.com>,
        <afd@ti.com>
Subject: [PATCH v4 1/9] arm64: dts: ti: k3-j721s2-common-proc-board: Enable camera peripherals
Date: Thu, 15 Feb 2024 14:25:10 +0530
Message-ID: <20240215085518.552692-2-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215085518.552692-1-vaishnav.a@ti.com>
References: <20240215085518.552692-1-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

CSI cameras are controlled using I2C. On J721S2 Common Processor Board,
this is routed to I2C-5, so enable the instance and the TCA6408
GPIO expander on the bus.

Common Processor Board schematics: https://www.ti.com/lit/zip/sprr411
J721S2 SoM schematics: https://www.ti.com/lit/zip/sprr439

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
Reviewed-by: Jai Luthra <j-luthra@ti.com>
---

V1->V2: Update commit message with schematics.

 .../dts/ti/k3-j721s2-common-proc-board.dts    | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
index 361365bb5523..5631735c9b7a 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
@@ -147,6 +147,13 @@ J721S2_IOPAD(0x060, PIN_INPUT_PULLUP, 13) /* (AC27) MCASP2_AXR1.I2C3_SDA */
 		>;
 	};
 
+	main_i2c5_pins_default: main-i2c5-default-pins {
+		pinctrl-single,pins = <
+			J721S2_IOPAD(0x01c, PIN_INPUT, 8) /* (Y24) MCAN15_TX.I2C5_SCL */
+			J721S2_IOPAD(0x018, PIN_INPUT, 8) /* (W23) MCAN14_RX.I2C5_SDA */
+		>;
+	};
+
 	main_mmc1_pins_default: main-mmc1-default-pins {
 		pinctrl-single,pins = <
 			J721S2_IOPAD(0x104, PIN_INPUT, 0) /* (P23) MMC1_CLK */
@@ -356,6 +363,24 @@ exp2: gpio@22 {
 	};
 };
 
+&main_i2c5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c5_pins_default>;
+	clock-frequency = <400000>;
+	status = "okay";
+
+	exp5: gpio@20 {
+		compatible = "ti,tca6408";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "CSI2_EXP_RSTZ", "CSI2_EXP_A_GPIO0",
+				  "CSI2_EXP_A_GPIO1", "CSI2_EXP_A_GPIO2",
+				  "CSI2_EXP_B_GPIO1", "CSI2_EXP_B_GPIO2",
+				  "CSI2_EXP_B_GPIO3", "CSI2_EXP_B_GPIO4";
+	};
+};
+
 &main_sdhci0 {
 	/* eMMC */
 	status = "okay";
-- 
2.34.1


