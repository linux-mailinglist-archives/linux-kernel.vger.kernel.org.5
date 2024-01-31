Return-Path: <linux-kernel+bounces-46048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16D88439B6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E65F5B28E04
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516B686ADC;
	Wed, 31 Jan 2024 08:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="yRjrGjaT"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2082.outbound.protection.outlook.com [40.107.255.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACF484A50;
	Wed, 31 Jan 2024 08:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706690570; cv=fail; b=iiv0HziiEvDPQxZyljOkphP2VfUM/aUxTyZ++V6CbUIRf/80B0J8cAabrmvC/MxikC4NRDL2Gcow6sH7huYWxS/5J0YYqCOkOqo31en+EMMMp90vfo78ZyA36q2WDIJQJFIMLaIQuCkDrd72RLy9pY3JIHAUrh8Afz2+ga3luDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706690570; c=relaxed/simple;
	bh=Ly28CfV3UMEr07sD1EFL8GYyPPm1U7bHvtY6WpBwtME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=daGQt4yPruN2cRZUSOcRNfjY6LTaMxEXxYsz31FCEmCicuilCaAcx6wf7EyAnywC80xm8E2xPIxrzjEiHrSotEvqqqp/FlhWRyLzJHmMDJBKjbc8fuoylqoFDwlVZ/Mp9JSLhN3B/vH6wPSeuFAQBgC2rGzdXJOnPlZJ6oF0vBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=yRjrGjaT; arc=fail smtp.client-ip=40.107.255.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lp5UktXftTc3gdCkkvw3uDLIrxARoM+ypT1s6aosjn62djzkHAwPU1i4yY2KsI4cJ7OBWEgoYPQWI7dn6qTH8eVT9CAfWn8560GWERFP942giYUAa2W5weaJR444HjCSNg4ARMWigVDfv16TMlp8XLJ4KTitff3trl2jdaiHNKevFG4V53tR/yXzr6XPZOA7WA1MUlRghH3zVSSzMC5XN5X3W5FXXJ3iOhtIteyz4Q4V1yK0qwJroTEQBYh59MF5qD37sOYEMpF9L8taQVAjo2ks5Brbrhcp3lbSCDVZTYBcWverTh2rvvoCR/8L2FegbwtVCMrsgeq9MGDHkci0IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOMueDJJIgwj38qzOiLlcwloqWFXMc1YNGi3D52Uzdk=;
 b=CveFgOvrub8LzXHgT08y0Pagn11B6upgrhj17kwv4ckRDRn75leJTXISqy5ylFHRdXOdzAJBjWJSSMCpng6N+TGoH1hc/4c2F231xLdeWvkIBfojfMK+grcP9ZqK2UmzGMyJt0yYaRUGkPDwUAidK75YAFgFq6tFPJYD1CJFlstaSeSXZpZ2daG4pnop0Gm93WqD4ZcQ2PfJkvfoqu/qDZh6Db48gt+2Zql3DsOGQxOhfNIh2FDaRnl36ANPgiwTmGY9Jbhp8YgoR/EzZJVGblCe8cwVJYa58A2tlOpjWDqTl2OZ+aDTpMXY97pkmg+LRB76EPus0jjwKmJqcpWl1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOMueDJJIgwj38qzOiLlcwloqWFXMc1YNGi3D52Uzdk=;
 b=yRjrGjaT1+KnjqCy1PbQqkxvcr4K7TSQTuyVRjKDmlzVcBDmbmsAOVDthSox2rM8jDl7Snf/fvCPMXyP6WP9jguC9UOGBuK/tTUN0aJRqvUnWzauAYCy2fpPxEr2ip/AyFQVtEJZmRQYUV7gy0ukmt22uyN0/qlwlG8LmW7FDbaUsVcFHfPo20vFWIU3RkXaUWSMI6wRmEkR31g6jZ2JF6+DZbq7UsgdQnifOzMBJ9bYa+GNGnqxqQNy9fM/puLcCPHamKXbmhAcp5aP/eXF4E1yraEMpjQaxwMpgE/h1lccyRvdXBgHUrebrF3otxPqPl0BYQ+F+2EoezYPdLpaqw==
Received: from SG2P153CA0020.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::7) by
 JH0PR04MB7962.apcprd04.prod.outlook.com (2603:1096:990:97::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.34; Wed, 31 Jan 2024 08:42:45 +0000
Received: from HK2PEPF00006FB2.apcprd02.prod.outlook.com
 (2603:1096:4:c7:cafe::4b) by SG2P153CA0020.outlook.office365.com
 (2603:1096:4:c7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.8 via Frontend
 Transport; Wed, 31 Jan 2024 08:42:45 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB2.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server id 15.20.7228.16 via Frontend Transport; Wed, 31 Jan 2024 08:42:44
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
Subject: [PATCH v5 16/21] ARM: dts: aspeed: yosemite4: Initialize bmc gpio state
Date: Wed, 31 Jan 2024 16:41:27 +0800
Message-Id: <20240131084134.328307-17-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240131084134.328307-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240131084134.328307-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB2:EE_|JH0PR04MB7962:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7dbcb019-92ad-4c91-4641-08dc22389897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+h0DFgJdBUrhfqdJvnqS9ujbYkxWMCKeVlU6mUjTKe/0mswSQhHAFxOFkMGtud8JL3aV+vx+UDP/rQySV/LOHvRAxfoDls1dgI72lBLTS6SXmkZBL4CP7tvPJKpRbU8U/hoOOKNzrov3/aO47jsoENW2bhoqZ1xIVghR6LeWBCQ6qoloyOndQU1Mz1JdAMGJxhSuuFkHyYJX1n0gs5XSQKGjpFHwX6TdJS2fO3eByEXQ2davZwzdH4Fse95cClFUly3+VEXPTpG2+kQluoGNADuSDONjIRlWCWm5bmUUcixkOosyDTsaDbBic8+zw+KqjDoygEAQJXDcnBMVTxcAUpESutOhspXi3vtxLc3E4tKfdIQLeP5LYANXXiIrrNJtNqI/K4mFBdYz/S/52fDS6/CL67GKKDSL73Am+Ng3lHzN2409cNwgT2pxkk1Gb5WiXWaJF+EiX745/zIzNZfiG2bL5s+eUWnlxgyCj4SCDRduyaq6CBF4+cOtR81otLH3+3vwaANxf5AjHoJb2Iku/pE6+I/ARSN+cI6ys7P+tvN97oPWL8+RwgcKg+QXM0sagql1bXJbpKkxvvxD0mUteV1WDS5UXRTtEEC36m1JR3bjzrJYHdIynzr0+tcf5oNSgkrrS/it4AGSAn9jLgnvZnZmn5aca/Fv+HFAAK916eVYaPjQePJ5LPiMKW8mnc/E0Zhel5BiSTiJGhPP/9Cp1A==
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(451199024)(186009)(64100799003)(82310400011)(1800799012)(36840700001)(46966006)(9316004)(316002)(4326008)(8676002)(86362001)(5660300002)(2906002)(7416002)(8936002)(110136005)(36736006)(70586007)(70206006)(36756003)(83380400001)(6486002)(82740400003)(6506007)(36860700001)(47076005)(356005)(81166007)(6666004)(6512007)(478600001)(956004)(1076003)(2616005)(26005)(336012)(41300700001)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 08:42:44.2237
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dbcb019-92ad-4c91-4641-08dc22389897
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB7962

Initialize bmc gpio state

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
Changelog:
  - v4
    - Rename gpio-line-names
  - v3
    - Add patch for revising gpio name
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 192 ++++++++++++++++++
 1 file changed, 192 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 6d5710e5753c..bce739f2a081 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1271,6 +1271,7 @@ temperature-sensor@1f {
 	};
 };
 
+
 &adc0 {
 	ref_voltage = <2500>;
 	status = "okay";
@@ -1298,3 +1299,194 @@ &ehci1 {
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
+&gpio0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpiu2_default &pinctrl_gpiu3_default
+		     &pinctrl_gpiu4_default &pinctrl_gpiu6_default>;
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


