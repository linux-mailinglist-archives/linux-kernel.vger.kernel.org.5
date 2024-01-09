Return-Path: <linux-kernel+bounces-20464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B53827F5F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6977B24760
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9194BE50;
	Tue,  9 Jan 2024 07:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="iVHjrfYj"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2087.outbound.protection.outlook.com [40.107.255.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D978364DA;
	Tue,  9 Jan 2024 07:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXrcLHjSxsG6F0wVumYtt3piMWelZXjPeZFPJi3UKo/aDBDbYOKD8Opop+dFVTZNIjIJOjdLK6AvhcRhcJF8v+HDTODpQysQhyIgScC8yTdzwZF4H5o5dU2Moy6rx5sY8zgZnfZa7r8+nWzaAP5+hCG4UiJC/anl+9+tdUXcXOCzb0XMI1LdrtfwSfcyHGkeQz+6I7KxbSQZGaumZGzLEp8ch8yCfxxJFNJo88IMbY0nXqsqq35xqzb/CPlZt+QPCRunm4UzwcZIyOGwjcO6Cnx0jM2/lZz93BguIf/8XS8I8G26SoW0usidYnkkm7H+jT+IyLtjVJ5vM7hlfLy98w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypdE8E+Og4B9hXjKCzAhuUhw4Chp9PyEaASS1wZf8LY=;
 b=E44EE8mjA03cL+KbbJWcfm894yai5aolbSnHnnDe0EepnkMT7zH3TxbUQAhxDBdxFMyXR/q452svvcEnPcsxHOsYXpx+W4+BfVPRvgMZPMU3mhc7OHMGy8A4OSINh7dCS6VA0QYVrarwKtKRdxfLMf4TVjRdhh+OuJgwKUayRk/CU9t79o4ep4FhjmVI1yxEli0cEuP1L9PsKoFwVPbcrL86hlLyvU4GPLBGFm3Gf+eHEsBGlZ14I/2of8HGFmjGLl/WPZ715Of8ew4XeFPg5dV4veFeSqx8oz2IyIEA6ozOAqhL77ElJedN/Etlf1ynTzADEvOAq8KI/nCFoEpMKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypdE8E+Og4B9hXjKCzAhuUhw4Chp9PyEaASS1wZf8LY=;
 b=iVHjrfYj4/ZTksMVjZbCmG+4U1ZCCIib8kxlLTIME5jk/Qbps1xMHasrItmtC4E0Ork1UVdwpNMJDo47XKHigZbPNBFsJ8MRC4nxI6Mf8VflTwFW9o2wM9G2b1NU4PduYhAwgBL089yQowUIoe72b5zlzGW73D7m5DaQt3u6niVXEwPe4tSlzIcnzT6esN2HCDnkjibr3VV7YGdCjcfmEbFoTUq4yhMRL7gRVm+HXLQQ1WqpLTsB91VNQ/dJptJcHotnJy2MTIrelWC6ypRxiTMrcJGA2q/ZofYQSSwl9a0YkQAyeWXbmX6w/uCDWZmU4rgMjuFbxjMKpLrBHJKUpA==
Received: from PUZP153CA0016.APCP153.PROD.OUTLOOK.COM (2603:1096:301:c2::18)
 by KL1PR04MB8191.apcprd04.prod.outlook.com (2603:1096:820:148::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 07:21:33 +0000
Received: from HK3PEPF0000021E.apcprd03.prod.outlook.com
 (2603:1096:301:c2:cafe::a4) by PUZP153CA0016.outlook.office365.com
 (2603:1096:301:c2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.6 via Frontend
 Transport; Tue, 9 Jan 2024 07:21:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021E.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server id 15.20.7181.13 via Frontend Transport; Tue, 9 Jan 2024 07:21:32
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
Subject: [PATCH v4 14/19] ARM: dts: aspeed: yosemite4: Revise ina233 config for yosemite4 schematic change
Date: Tue,  9 Jan 2024 15:20:46 +0800
Message-Id: <20240109072053.3980855-15-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240109072053.3980855-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240109072053.3980855-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021E:EE_|KL1PR04MB8191:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 813747ae-99dc-495e-bc46-08dc10e39b38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c4RdqgZVwPvHII4omk/5kj8Gh3YbucUH7RvxBfa/H1oXiDJm7XPqMHtJ+nWah2PhugR+cmdZS2hcuY59Uy41EADYCTCDAS7D9m1r27sOsLe2Qco+pkzBHJojZLk7E6XrfjHPu8i/HYCaiCq7wkTKfJ8jTJokSyp/sbAErqTeDHMzo9ev4PX3MvsI0Pq+JDdlO3hKeDqL70RUCcEo4rkFReZBTkhFikmZHTALcGWRG/NMORALQt+3wrRLu3h62zZIHcqnFsCYb+c3Pw9K1kVX/wpYYTRWJiXmec04vUecEZg18e4GTO+EmytSOBxGMWSejBdAEIiaIFdcrms9/U9MagLhojNbFtvGWd0gMj6U7tMoXVThYq7XQzlzVLLk/DlkmVAuRTigWhLfxNRw6JBUxbRzqVdOn4YE8+B5bP5dHg0oMkp8DG28MrlLiv2zvNM5UpKqdFNYZcf1jv0Yv3yvlPO+AsoSn2KwvwxOPvsGc/ZfgYTAf/Sj8ZX00/5H3uIhmpBfhBgPNSadQehTlHMVAXSG49RXKW50NodIHFOGMkBsS6av2rUrPi1c8lvUO9cvLZJcvx586ivMQ1heE+aTiN6wmtONBjI3j2JCys8AmxCYbDjuVzCEoSQu7C2S5PxQ5gYNXV3cScyDWZpFzsiifFybmiQ3s1Mp5jDzWxqbKWENo/3BG8sUkqe6qVw94cyImk5VhhpaBZWRFvfdVDdoWg==
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(186009)(82310400011)(1800799012)(64100799003)(451199024)(36840700001)(46966006)(2906002)(36860700001)(41300700001)(7416002)(83380400001)(47076005)(82740400003)(81166007)(356005)(478600001)(6486002)(70206006)(70586007)(36736006)(110136005)(6506007)(6512007)(1076003)(956004)(336012)(2616005)(26005)(6666004)(5660300002)(4326008)(36756003)(316002)(86362001)(8676002)(8936002)(40480700001)(9316004);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 07:21:32.5387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 813747ae-99dc-495e-bc46-08dc10e39b38
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021E.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB8191

Revise ina233 config for yosemite4 schematic change

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 20 ++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 904c0ac0d8d2..c61b46a0a262 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1026,28 +1026,38 @@ adc@37 {
 	};
 
 	power-sensor@40 {
-		compatible = "ti,ina230";
+		compatible = "ti,ina233";
 		reg = <0x40>;
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@41 {
-		compatible = "ti,ina230";
+		compatible = "ti,ina233";
 		reg = <0x41>;
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@42 {
-		compatible = "ti,ina230";
+		compatible = "ti,ina233";
 		reg = <0x42>;
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@43 {
-		compatible = "ti,ina230";
+		compatible = "ti,ina233";
 		reg = <0x43>;
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@44 {
-		compatible = "ti,ina230";
+		compatible = "ti,ina233";
 		reg = <0x44>;
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	temperature-sensor@4e {
-- 
2.25.1


