Return-Path: <linux-kernel+bounces-99879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEA1878EB5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0881C2222D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 06:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E495F47D;
	Tue, 12 Mar 2024 06:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="WUuNjFG2"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11012009.outbound.protection.outlook.com [52.101.128.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B745EE99;
	Tue, 12 Mar 2024 06:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710224222; cv=fail; b=P2HjQkx3MAJEQzTpiuzCo351lFAQLDQa1jD2Z8SOfq2fh3qXfXRrfmRHW+9Rn2STkBwtaVbZaFQ3k5dzFT/5j48hQk6YYCF4OZfuVAiFgO46B7HKWT1wm8vCuM4QT26yIl6SFWJTxISxGrIbDFjI0Jh4Kf+xudBeq+lOoad2m7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710224222; c=relaxed/simple;
	bh=NZDMznV+tiaO6svKBaDh+gbIlFXCgVkdrcaNGBE3QpI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bP3pttZ7nvgrBVLD4stRxcqJvwyGV1QZnyk1DkEr1l+rJIkY1beNpNhiq7D6Mc3seVd8BE81vgx+cDLNioMd87/DxnE7reGjIYu7P6zeg5Lx+qcFTTr6QN543HgAw9Gi9ACksQ9wcLCK/81hZRM9vQpWlACh8JNmfQIb4eHb7oQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=WUuNjFG2; arc=fail smtp.client-ip=52.101.128.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5+YMJF/sfLa4zqi5Nxd8Ef/F5RGy6y35f0f4gJV8xBdpUTs19T2zR4FUkclIkCS8wNlAf2K+A3RkUUsP+mAo2dTQn11TxiCggnNWlfW4D6UZTll/eKNYYA9iqj7oKI2ZvvNvdJGVmOZMwWn5H1JVaVkOt0YmpybdhW8hJHi968yGxHf4g2q91LXatFmQOYw9Zwy5Xu3HJ9f6yoiIt8j0IUPmPXLi4yu7eE9kDvuWrqJyTLnjip5NBOaOdDKKghrgRuxF7euGX2HdLMf5y8SrWy7GY8BsrQ6mttJmOb1h5LIPGrGMKxSi62gRV9atHo+Z+tZvTH4iVxJgmdzJ6t+qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MHH2Jz+W4orJ5EBt4dkQqpH0oa10SOQc4zscRBPuPI=;
 b=eBW0AsEo+OdE93Lg/QBzEZ6jYzYrZJeJyWtxmZWeCEUygy3yZl9lvUfciQP7kvzj30sfyVE//eNFQKYPkPQq0ZGbaR8YTOEYOWmY/0apWFCo7BK1jdKLW42/njnaS1htwY2ZixnXanB0LcM3/ycrUy4ZfaOyguYxCx4Y/Ena8tTYCsd/XsBKMHieFoljOTgnn980XK8awPdkesvU00LOS9hUEPjvOEDGr+KLRVPrPBkWpjE8KQVKe42ptiktN9hKmdXdDfTu8qYXoKgYW1Su92tWfAU9vc1sGg4UDakcilVrCzgmVwMwd7PFwmNC5fcz9lotKZvkEz0wmp11nwIgdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MHH2Jz+W4orJ5EBt4dkQqpH0oa10SOQc4zscRBPuPI=;
 b=WUuNjFG2vd1lmz9dZpiv+2xU+2C8sAvEGXr+qvxI+i/QsNKZloBbg2W2X3Cz+x0XxDzTPjv1zDdWOwEIxsJq1+UMfryPaN1Mdqee4nS6OB+bGKCnf09NWxD3Z7h3j172p4DUZlCrBAky8C2hKAHtBNiIK23he8No2XBAsyfOSBJ4CjKyRVO+jevLnwP15zkpxCW+UQAj5mVEpVx9vt6mbmgL8/2X8CJe/0BLRo5xYmDbFQ6N43awG6/6V/tqMIHDmQFOTFBu4SiCPboH6kTdSqeMNjSkB+Aps8C4V4iT+PBpo1nJhotTuNFNNq+93C1oA3YT4FtW3GpCO28MgzyN/A==
Received: from PS1PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:300:75::19) by TYZPR04MB5607.apcprd04.prod.outlook.com
 (2603:1096:400:1cd::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Tue, 12 Mar
 2024 06:16:55 +0000
Received: from HK3PEPF00000220.apcprd03.prod.outlook.com
 (2603:1096:300:75:cafe::ad) by PS1PR01CA0007.outlook.office365.com
 (2603:1096:300:75::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Tue, 12 Mar 2024 06:16:54 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000220.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server id 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 06:16:54
 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 16/22] ARM: dts: aspeed: yosemite4: Initialize bmc gpio state
Date: Tue, 12 Mar 2024 14:15:48 +0800
Message-Id: <20240312061556.496605-17-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240312061556.496605-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240312061556.496605-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000220:EE_|TYZPR04MB5607:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2b0d159d-8724-4093-08e7-08dc425c03be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aUL4w9iDsy5wP5ZSgb4y7pWaNuyrHUcYj0bjb4kn0aLsSQGJmPS5+AodnfEsN0u/Nzmf9M/HwpkpKNK9QadLP+MC0BPj4+8eRO7QBTXb/leb4rtdI2abBxVn+DxAAfRHWr27DEoq9Q6UxipL8pcEKPnavLbHT9082fiIE2QG9rSjbGe0kOVzSAk2QOJjLFQj8ln4GfIq0UJq2pnYJq4ZsNO8Oarbbec1kzHcRbDKwQRkXY+fj2qwXX58fAT21D5i5B5DYoi8jQv0BH4ja0RpLnlNz1cEUQ5rN6n6212dKd/w/LTiElU/Kp7TucjtukH2cAhuHuB80sGw1vurBVOD9bQd3Kai6NQrvqY0Gdkk86lKnrx0WRoPno5bjCvT2D1ZTUgTMfmGcycoBYKvb5DcFA6Q5toszQ5hUS+Q5XFfwA+RI6zNtpMr+EfLTSM+hOsQRAnH/ZJFzoK3tOeC5b8K7d3wDyJkxMPtFWVUBShNmmeQPnS6EesxWySBtXYaU38RERU4Ayb/d1fjCa1ibmBj/0JUaofVlG4o9sonyW3pJybOBHu+l88z+PCDupgfVL7HPs8V3ynejEQhVj4caM0skq4b+uaxd+QAZtFRlhzf97mD3n3cyui6GFz5sMtOMy9dShBJCKcEpsiJfQXU+3/PExuZLASZN/GaDMXzsCJqJdZbHCJVz9pzlPblZ5ko1SAKRx/60NF9l4EFoPthfPoKtoOkd8ckbJtj8fAz0S27bzw6VJDOPd3QMmwbduufOPVU
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 06:16:54.4790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b0d159d-8724-4093-08e7-08dc425c03be
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000220.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB5607

Initialize bmc gpio state

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
Changelog:
  - v4
    - Rename gpio-line-names
  - v3
    - Add patch for revising gpio name
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 235 ++++++++++++++++++
 1 file changed, 235 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 6d5710e5753c..1b91821b019d 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1271,6 +1271,7 @@ temperature-sensor@1f {
 	};
 };
 
+
 &adc0 {
 	ref_voltage = <2500>;
 	status = "okay";
@@ -1298,3 +1299,237 @@ &ehci1 {
 &uhci {
 	status = "okay";
 };
+
+&sgpiom0 {
+	status = "okay";
+	ngpios = <128>;
+	bus-frequency = <48000>;
+};
+
+&pinctrl {
+	pinctrl_gpio0_unbiased: gpio0_unbiased {
+		/* GPIOB0, GPIOB1 */
+		pins = "J26", "K23";
+		bias-disable;
+	};
+	pinctrl_gpio2_unbiased: gpio2_unbiased {
+		/* GPIOI5, GPIOI6, GPIOI7,
+		   GPIOL6 */
+		pins = "E16", "B16", "A15", "B14";
+		bias-disable;
+	};
+	pinctrl_gpio3_unbiased: gpio3_unbiased {
+		/* GPIOM2, GPIOM3, GPIOM4, GPIOM5,
+		   GPION0, GPION1, GPION2, GPION3, GPION5,
+		   GPIOO0, GPIOO1, GPIOO2, GPIOO3,
+		   GPIOP0, GPIOP1, GPIOP2, GPIOP3, GPIOP4, GPIOP5, GPIOP6 */
+		pins = "A12", "E14", "B12", "C12", "P25", "N23", "N25", "N24", "M23", "AD26", "AD22", "AD23", "AD24", "AB22", "W24", "AA23", "AA24", "W23", "AB23", "AB24";
+		bias-disable;
+	};
+	pinctrl_gpio4_unbiased: gpio4_unbiased {
+		/* GPIOR0, GPIOR1, GPIOR2, GPIOR3, GPIOR4, GPIOR5, GPIOR6, GPIOR7
+		   GPIOS0, GPIOS1, GPIOS2, GPIOS3, GPIOS5, GPIOS6, GPIOS7 */
+		pins = "V25", "U24", "V24", "V26", "U25", "T23", "W26", "U26", "R23", "T25", "T26", "R24", "P24", "P23", "T24";
+		bias-disable;
+	};
+	pinctrl_gpio5_unbiased: gpio5_unbiased {
+		/* GPIOV0, GPIOV1, GPIOV2, GPIOV3, GPIOV4, GPIOV5, GPIOV6, GPIOV7
+		   GPIOX1, GPIOX2 */
+		pins = "AB15", "AF14", "AD14", "AC15", "AE15", "AE14", "AD15", "AF15", "AA9", "AC9";
+		bias-disable;
+	};
+	pinctrl_gpio6_unbiased: gpio6_unbiased {
+		/* GPIOY2, GPIOY5, GPIOY6
+		   GPIOZ0, GPIOZ1, GPIOZ3, GPIOZ4 */
+		pins = "AE11", "AF12", "AC12", "AC10", "AD10", "AB11", "AC11";
+		bias-disable;
+	};
+};
+
+&gpio0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpiu2_default &pinctrl_gpiu3_default
+		     &pinctrl_gpiu4_default &pinctrl_gpiu6_default
+		     &pinctrl_gpio0_unbiased &pinctrl_gpio2_unbiased
+		     &pinctrl_gpio3_unbiased &pinctrl_gpio4_unbiased
+		     &pinctrl_gpio5_unbiased &pinctrl_gpio6_unbiased>;
+	gpio-line-names =
+	/*A0-A7*/       "","","","","","","","",
+	/*B0-B7*/       "FLT-HSC-SERVER-SLOT8-N","AC-ON-OFF-BTN-CPLD-SLOT5-N",
+			"PWRGD-SLOT1-STBY","PWRGD-SLOT2-STBY",
+			"PWRGD-SLOT3-STBY","PWRGD-SLOT4-STBY","","",
+	/*C0-C7*/       "","","","","FM-NIC0-WAKE-N",
+			"FM-NIC1-WAKE-N","","RST-PCIE-SLOT2-N",
+	/*D0-D7*/       "","","","","","","","",
+	/*E0-E7*/       "PRSNT-NIC1-N","PRSNT-NIC2-N","","RST-PCIE-SLOT1-N",
+			"","","","",
+	/*F0-F7*/       "FM-RESBTN-SLOT1-BMC-N","FM-RESBTN-SLOT2-BMC-N",
+			"FM-RESBTN-SLOT3-BMC-N","FM-RESBTN-SLOT4-BMC-N",
+			"PRSNT-SB-SLOT1-N","PRSNT-SB-SLOT2-N",
+			"PRSNT-SB-SLOT3-N","PRSNT-SB-SLOT4-N",
+	/*G0-G7*/       "","","","","","","","",
+	/*H0-H7*/       "","","","","","","","",
+	/*I0-I7*/       "","","","","","ALT-MEDUSA-ADC-N",
+			"ALT-SMB-BMC-CPLD2-N",
+			"INT-SPIDER-ADC-R-N",
+	/*J0-J7*/       "","","","","","","","",
+	/*K0-K7*/       "","","","","","","","",
+	/*L0-L7*/       "","","","","","","ALT-MEDUSA-P12V-EFUSE-N","",
+	/*M0-M7*/       "EN-NIC0-POWER-BMC-R","EN-NIC1-POWER-BMC-R",
+			"INT-MEDUSA-IOEXP-TEMP-N","PRSNT-NIC3-N",
+			"INT-SMB-BMC-SLOT1-4-BMC-N",
+			"AC-ON-OFF-BTN-CPLD-SLOT6-N","","",
+	/*N0-N7*/       "FLT-HSC-SERVER-SLOT1-N","FLT-HSC-SERVER-SLOT2-N",
+			"FLT-HSC-SERVER-SLOT3-N","FLT-HSC-SERVER-SLOT4-N",
+			"FM-BMC-READY-R2","RST-SMB-NIC0-R-N","","",
+	/*O0-O7*/       "AC-ON-OFF-BTN-CPLD-SLOT8-N","RST-SMB-NIC1-R-N",
+			"RST-SMB-NIC2-R-N","RST-SMB-NIC3-R-N",
+			"","","","",
+	/*P0-P7*/       "ALT-SMB-BMC-CPLD1-N","'BTN-BMC-R2-N",
+			"EN-P3V-BAT-SCALED-R","PWRGD-P5V-USB-BMC",
+			"FM-BMC-RTCRST-R","RST-USB-HUB-R-N",
+			"FLAG-P5V-USB-BMC-N","",
+	/*Q0-Q7*/       "AC-ON-OFF-BTN-CPLD-SLOT1-N","AC-ON-OFF-BTN-CPLD-SLOT2-N",
+			"AC-ON-OFF-BTN-CPLD-SLOT3-N","AC-ON-OFF-BTN-CPLD-SLOT4-N",
+			"PRSNT-SB-SLOT5-N","PRSNT-SB-SLOT6-N",
+			"PRSNT-SB-SLOT7-N","PRSNT-SB-SLOT8-N",
+	/*R0-R7*/       "AC-ON-OFF-BTN-CPLD-SLOT7-N","INT-SMB-BMC-SLOT5-8-BMC-N",
+			"FM-PWRBRK-NIC-BMC-R2","RST-PCIE-SLOT4-N",
+			"RST-PCIE-SLOT5-N","RST-PCIE-SLOT6-N",
+			"RST-PCIE-SLOT7-N","RST-PCIE-SLOT8-N",
+	/*S0-S7*/       "FM-NIC2-WAKE-N","FM-NIC3-WAKE-N",
+			"EN-NIC3-POWER-BMC-R","SEL-BMC-JTAG-MUX-R",
+			"","ALT-P12V-AUX-N","FAST-PROCHOT-N",
+			"SPI-WP-DISABLE-STATUS-R-N",
+	/*T0-T7*/       "","","","","","","","",
+	/*U0-U7*/       "","","RST-PCIE-SLOT3-N","",
+			"","PRSNT-NIC0-N","","",
+	/*V0-V7*/       "FM-RESBTN-SLOT5-BMC-N","FM-RESBTN-SLOT6-BMC-N",
+			"FM-RESBTN-SLOT7-BMC-N","FM-RESBTN-SLOT8-BMC-N",
+			"","","","",
+	/*W0-W7*/       "PRSNT-TPM-BMC-N","PRSNT-OCP-DEBUG-BMC-N","ALT-TEMP-BMC-N","ALT-RTC-BMC-N",
+			"","","","",
+	/*X0-X7*/       "","LT-HSC-SERVER-SLOT6-N","FLT-HSC-SERVER-SLOT7-N","","","",
+			"PWRGD-SLOT5-STBY","PWRGD-SLOT6-STBY",
+	/*Y0-Y7*/       "","","SPI-LOCK-REQ-BMC-N","PWRGD-SLOT7-STBY",
+			"","","EN-NIC2-POWER-BMC-R","",
+	/*Z0-Z7*/       "EN-P5V-USB-CPLD-R","'FLT-HSC-SERVER-SLOT5-N",
+			"PWRGD-SLOT8-STBY","","","","","";
+
+	pin_gpio_b4 {
+		gpios = <ASPEED_GPIO(B, 4) GPIO_ACTIVE_HIGH>;
+		input;
+	};
+	pin_gpio_b5 {
+		gpios = <ASPEED_GPIO(B, 5) GPIO_ACTIVE_HIGH>;
+		input;
+	};
+	pin_gpio_f0 {
+		gpios = <ASPEED_GPIO(F, 0) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_f1 {
+		gpios = <ASPEED_GPIO(F, 1) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_f2 {
+		gpios = <ASPEED_GPIO(F, 2) GPIO_ACTIVE_LOW>;
+		input;
+		};
+	pin_gpio_f3 {
+		gpios = <ASPEED_GPIO(F, 3) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_f4 {
+		gpios = <ASPEED_GPIO(F, 4) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_f5 {
+		gpios = <ASPEED_GPIO(F, 5) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_f6 {
+		gpios = <ASPEED_GPIO(F, 6) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_f7 {
+		gpios = <ASPEED_GPIO(F, 7) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_l6 {
+		gpios = <ASPEED_GPIO(L, 6) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_l7 {
+		gpios = <ASPEED_GPIO(L, 7) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_s0 {
+		gpios = <ASPEED_GPIO(S, 0) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_s1 {
+		gpios = <ASPEED_GPIO(S, 1) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_v0 {
+		gpios = <ASPEED_GPIO(V, 0) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_v1 {
+		gpios = <ASPEED_GPIO(V, 1) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_v2 {
+		gpios = <ASPEED_GPIO(V, 2) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_v3 {
+		gpios = <ASPEED_GPIO(V, 3) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_w0 {
+		gpios = <ASPEED_GPIO(W, 0) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_w1 {
+		gpios = <ASPEED_GPIO(W, 1) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_w2 {
+		gpios = <ASPEED_GPIO(W, 2) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_w3 {
+		gpios = <ASPEED_GPIO(W, 3) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_w4 {
+		gpios = <ASPEED_GPIO(W, 4) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_w5 {
+		gpios = <ASPEED_GPIO(W, 5) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_w6 {
+		gpios = <ASPEED_GPIO(W, 6) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_w7 {
+		gpios = <ASPEED_GPIO(W, 7) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_z3 {
+		gpios = <ASPEED_GPIO(Z, 3) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_z4 {
+		gpios = <ASPEED_GPIO(Z, 4) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_z5 {
+		gpios = <ASPEED_GPIO(Z, 5) GPIO_ACTIVE_LOW>;
+		input;
+	};
+};
-- 
2.25.1


