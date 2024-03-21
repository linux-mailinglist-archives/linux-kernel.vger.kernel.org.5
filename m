Return-Path: <linux-kernel+bounces-109580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 785CE881B17
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA848B22450
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACCBB64A;
	Thu, 21 Mar 2024 02:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="TXPWueQK"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2088.outbound.protection.outlook.com [40.107.255.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D477D5812D;
	Thu, 21 Mar 2024 02:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710987213; cv=fail; b=YOOghzZhBb8iQCJEwFbklPeA+hqYk4g6m4Yd1URSQnMG/jFA/oMnD9riRfcJnDYf7td98fjDyxH8gCAdzjctYhOOtBKGJBvBIbgKciRrI2mwF2Wf7Lp8B01UGKjCVQAOJi0foqDIvfKmQFDeQKmLKv1IzzPorOSSwiCTU0Mhdfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710987213; c=relaxed/simple;
	bh=Oz3T+533yog2vslJ7gH03prXIPfdikkN1mFHlYNuSgs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kgoo8ip76mXJSlpUZcQThWVi/eXF+8xIhCzgdbevV4FyixPER8kmBhCQNaF8ebm4yZ+6D2hdayDgySmrzpuEQ41jt2I1X+anCRuVU7QgB2UomwbAvOYf7ELtOzCHRumzcbXaZz0byTI6RYNthUidkcwXJTH+J5cbO71pOk6Eo+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=TXPWueQK; arc=fail smtp.client-ip=40.107.255.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fU/YwsF95BlUvUK+UxlxzOtyB1G9ZB0gIInHpnJBm6V5IjYLoA5kohe2f8+sEES0x/318qbkA+lHLdaKJFUw+k9yfo4lyABOkpq7rygaT6wb8gFUKqrlnpdrNKS+TL3h4p7rNv3rdGCcSX4vX1+QATf9KBZyiJHr159LNLwCtWEnXI7Vtdg8rSiJTYJUlxJdL6TzECKFqCQVhFxL38L83JzD9+YiBJzD3kfzxRKFKACnR+ASSYAk5FQkeOVwkQMJzwhRt6zU/oUbaBRZu1OCvZVBTeoA2O1Rh0xveyha5xAmqFEq5XrBIOPGR0BTwT5lPdjdy11K0uS4qIYI5nzbeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQNIOGoZxCoWO/rzmnGdhVVHZr6/aZn2oL+uWXdoKus=;
 b=XOukqOgy/FTUioj29IMg2j6ulzXyTvGahK/kSD9DNLi3c44pAdXdkfZeo4YLVv2RDreH13ZBnx29Zs3NfMYPtcvdWq9GmNWg8PT0Q6/59FZ3WJGp/dxjsLvnx7wpKHqqvmdxlHPWnl/0w64gjruURFekY9LXG74EEqU4+oE2RVCDODat03uJ2LEM685qVF589Hk2hj7fVX7ZQpfJmbGMbXv06fQ+GP4t/t3yaAkNG2usimWB1psqosRLT09SS57gmwUOEYGhWGGginJgFv4kk0PF1umxRTD0AJMK0l7wy3BalWGBrZELQOuE7yyJeK4ETyqGN5O0aiYsRLnbeRtYaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQNIOGoZxCoWO/rzmnGdhVVHZr6/aZn2oL+uWXdoKus=;
 b=TXPWueQKMvSK+aI1hl8SsLYBUd8/v2ubUTHbOPLxkrzjluFdG+VdLh2u9MrQ/+UyieCmzoJFeH6xjTd2N0sUPhWhxmM67UJbBfwIUthLngxiD3UgtrIcpLz4OTXSAMkMT61vVTJbPpq4Y+5E1O1LZkbSVrjHB7Bz9guf2YtjvazAJ8gLkIJYPodsdhfffr4h491ItJ89jatY2e2fBXhH7paO134BdYhTSwB1jBxWiqVkzlom0OSTI3LjhUhR8zDykNMTh9WpNzgT/1r/kwN8CacfkhRcm54qYA/Xz+FPGvoX2kHVjhV+XqJ57/d/jPLviuOUDtojc53VLzPjTwMZ0w==
Received: from PU1PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:803:15::21) by KL1PR0401MB6441.apcprd04.prod.outlook.com
 (2603:1096:820:bd::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.15; Thu, 21 Mar
 2024 02:13:27 +0000
Received: from HK3PEPF0000021F.apcprd03.prod.outlook.com
 (2603:1096:803:15:cafe::68) by PU1PR01CA0009.outlook.office365.com
 (2603:1096:803:15::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Thu, 21 Mar 2024 02:13:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021F.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server id 15.20.7409.10 via Frontend Transport; Thu, 21 Mar 2024 02:13:27
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
Subject: [PATCH v7 16/22] ARM: dts: aspeed: yosemite4: Initialize bmc gpio state
Date: Thu, 21 Mar 2024 10:12:28 +0800
Message-Id: <20240321021236.1823693-17-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240321021236.1823693-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240321021236.1823693-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021F:EE_|KL1PR0401MB6441:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d5368340-b615-4eb2-aa01-08dc494c7ecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Z8ts9Cj16R17CNzYu7wLvZ0I4WaGO0ZXdCnScwSHZpCWRuP2xhuEZRQjUpxgnGG+a2gYnuL5wxmx2xhCbAUUeUBWAtaYpviksfSJCKFu5WAbhzU6oC69J9nOSTEBEwbuogfgoHma6aUWfvzUgVpUR+ql1WahPQtpF4eqKIxDDwf06otNUK0LpcSufFgGNJihuAd2kMA0EPgCS4Pvms6pPVSk5sOkZwcAQd7TNyJ1Q3rB3FmnpvW+jqligHnle5hxLY4C6G8VI2PsCLWvBAywbPvUR7ByVH8qDWES7kUHak9mKgY4KZnvDDx6knvqH9U7wvcVxW9c3NGYJQP9T++ts7S9HniMIKFFp2vv25YM8CeIKrTxQ8qRoYnrM57hH6eZjiaPzUWV0yp2M/KNVbSmTNeyTpeet/PDaFmlyi+nMPRPKKznz23OqWXzanT8bA9uVpKCNEs2ZopT9Dle4X/2rxszHbqU+ok7+r19cDwl9DL+B5JgvV+inu51WPNuSEMvzK3M2zOKOAmN2ttunRUqn3Vmu/M/fuPYGxqSGAT6CkBld2d81gcp68I6fDAY8wE0jM6XCxyfaR8gIsu1kKTiU8VTywuaXHzvIhzmvIwLCKzzpT+oEyV762Fxoxu/M5we+wAsMGCCvGhSqN2GTD7gWGbn9rj9D6hrrONTKoLVfQoydlFlsgzZ5ZMXludV+Spemf1Nim+buPhB9bMAvBYrct0IS87bV8cOUqvTdtJkhuiNS+9peC1g4hIR/AWJe4ON
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 02:13:27.1199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5368340-b615-4eb2-aa01-08dc494c7ecb
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021F.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB6441

Initialize bmc gpio state

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 235 ++++++++++++++++++
 1 file changed, 235 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 79e3c956bc00..d59542a9ef75 100644
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


