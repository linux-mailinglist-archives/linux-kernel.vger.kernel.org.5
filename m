Return-Path: <linux-kernel+bounces-46038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C5484399D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0685B27EF4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AB07F7F4;
	Wed, 31 Jan 2024 08:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="zHl9vKPy"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2054.outbound.protection.outlook.com [40.107.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CFB7D3E6;
	Wed, 31 Jan 2024 08:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706690531; cv=fail; b=RPDl+la2fKuysDzifnt0ciIzdjhR3AbsL4olq/5UQ9ZmvHlJYYxUyv/afW97Ta6iD9u2FtugseMSU5nWA7p5kbwdSLHYoyZJUPbkumM8NZmFMI9K+ZjVqMwN6IX+WFeQYzSBmdeJqjxsScApwAHxn1mLPYdlGEMv/TJdvTazXtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706690531; c=relaxed/simple;
	bh=gW5Gb44NUsFmP68ZRCRypcAn5rwOVQLI0hNvdIAwIIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pLO8CJhGbgfU2bAUiqjWHIn8d1Z6QoHV0+VG0kM3UJfeRCkMofHaF6qnMg/ZUe3dCIRPyTgrd6URVOFCAYGLoGP+daAMwrDU/udztxYL/3frPNmKkjwic68Qrg+r/MPA4nNAgC4dZpmckKJ8x8CtWM+cn+Wt8EcQ03GesNsRU7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=zHl9vKPy; arc=fail smtp.client-ip=40.107.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwdPKAebLM7duUZKsUtzTzknRuGNxyjinnGRRwSMJQ7s1KzJ/eNp8LgGDRHFvS3ZHrQYr0yhmRg/16CYwT7xz1eeMfTui5O+gQdm6FrK1TDhA559EsdnnuC4NSlrjj6SzYGxtZ4ui3nB6iD9PTmAHDwWD+1V3xgHTFfth4k8F0Q1yOW158Jxb9hEYulHGHI7KUQ9rt5d2aviejUVDjzedcNh5+RBQQnnrmdXcUD21UvBYQ1cRYzUP9nndhxkkrS+nze6moNMmI3gKMnSC+JhaXogTtgYllT0z0KuyTbdETJ1P3h66SPc7eC/BZt7B+GaRCdQJT3gxiogTPm/4Y4giQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyfzsiMTiBll4ouoSSuk92xJoh4krtds9VMlLuTcNyM=;
 b=AIe9Iu81vG7OnGa7bPEVFPxWIQmlysQMyG8oZwYvrPHHNRwLZSmnZbvMDuoETRrXBpRkD+KXONKGazD0BCe02doqKnypbIDrqvbexzpUZ9IUbuMEuke3Y0x6K+hGk/I31xPJrpF/KSWQOaqTVhWTBZr5dfnDCPAVx1VIPqQZUlAPkDj5nPVc8yJGAB6ScXaG9AYZ2q8LLcUUPp0f4ah+qAyRAEd5DyOiherG3Ht6GM334xXV2aoINL3R3ssxTSzGpVdE3qtHgQo+kxYAaRC7tEmm5F5SI2seMXHN/jbPh13k82C3brUsaYYwST6tOtIEplxDLWwEbVHXEuMidtm6sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyfzsiMTiBll4ouoSSuk92xJoh4krtds9VMlLuTcNyM=;
 b=zHl9vKPy5jVdVaxlCRhKGlKqN/GV/ceG/V1xuuE/32iZtseZfWjOlS4sTpxumdH/w+X8ExG8/5+EnYDcyF5DaI38nOUNGWyxF0IdCGykyFnQZEAG+xC4E84iXKD41FCh9vLbl9ImdH8OZwyow35CFtyTFO0wTq/6kRhCjD6LPuc+Pn9bukqIklWMa/azMAWI5rIha4CxZJVKgbSEiK4dfkfJztJHDYM/lVQP1X4wsGiX5EVu0DjcRqImPgNvQ+LOhb0RYPQrxqVq5iVj6OA405Oqk2KUAiY70rAU09cXR4/gaN7swpALRMZlmxkEHStlWgKebE/dHAmOkS0k68G2gQ==
Received: from SG2P153CA0033.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::20) by
 SEZPR04MB7902.apcprd04.prod.outlook.com (2603:1096:101:231::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.34; Wed, 31 Jan 2024 08:42:03 +0000
Received: from HK2PEPF00006FB2.apcprd02.prod.outlook.com
 (2603:1096:4:c7:cafe::2d) by SG2P153CA0033.outlook.office365.com
 (2603:1096:4:c7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.8 via Frontend
 Transport; Wed, 31 Jan 2024 08:42:03 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB2.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server id 15.20.7228.16 via Frontend Transport; Wed, 31 Jan 2024 08:42:02
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
Subject: [PATCH v5 06/21] ARM: dts: aspeed: yosemite4: Revise power sensor adm1281 for schematic change
Date: Wed, 31 Jan 2024 16:41:17 +0800
Message-Id: <20240131084134.328307-7-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB2:EE_|SEZPR04MB7902:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 21bf23fa-341f-4642-3218-08dc22387f80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fXn+JZ8wM618REvsqTguTKDdgqIb6SZpcoargpXWQ8gBEKMSNsC1xzsRl7c2QPAHaLFa78Xk25t7Y0EwZUNpSvVbucUaYEGJTrhCBq22XF/KbYhMsslvnk9LfJ5GeqypM0oMFYph7Rpp5ko25AM2wLZ36VhLXP5G6BKg90fVd2KN40HIq9J6kWLR25UtsHdM5m05V6Z+6iX4VvF+fJ1Zw/8l23K4q5S8O+lronNZAzs7P7DQ6UTP4jW5lv/Wy8IIGIawpfLrvBYx9VXAEj0pe8ABmI/+VMK4Yllq4GF4qwED4+SXElB/eja8rc++1YQKtKsv63ybyTOK/Adv3SDbI26ziII3ke9qjLEf0P+OUoOK7u03+LuTM/dgMzGJrWZINRlfdn3dnQEXrKKPpw7cr62P2sTaWT1jJ329eZtQcN1tfJXIobgVNBahxOmrQidmc6v4VQO/uHyKlCe7ZCDTIzwP/k05h3miP+UcO4knhfeqaeUCdN4/tBZQxV2JODv1Yjv+YQsa0KlADO+NwHVltaNggQ1eVeCOjSmO9lfbPandlHq2KB1FAUT9VOy3JoRSwUtzOYav4Mw8mveTbaelJw/03OOTZktfW7Xpfh/SYzaFeahP57zNN4W4qpp04YAJLx4K0KDprQ/Z3FprADlIOw3qo1A0OBnWq47srbqZhc0C0MKbldwvhLdf7vHCd0gvm6vfcpfH3YCH3E5gBmW9pw==
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(186009)(64100799003)(82310400011)(451199024)(1800799012)(46966006)(36840700001)(9316004)(5660300002)(36756003)(4326008)(82740400003)(2906002)(70586007)(70206006)(7416002)(36736006)(8676002)(110136005)(8936002)(86362001)(316002)(6506007)(36860700001)(6486002)(47076005)(81166007)(6666004)(83380400001)(356005)(6512007)(478600001)(956004)(336012)(41300700001)(2616005)(26005)(1076003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 08:42:02.1451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21bf23fa-341f-4642-3218-08dc22387f80
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB7902

Revise power sensor adm1281 for yosemite4 schematic change

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 24 ++++++++++++-------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 23006dca5f26..af9f7067c57c 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -176,8 +176,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -193,8 +194,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -210,8 +212,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -227,8 +230,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -244,8 +248,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -261,8 +266,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -278,8 +284,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -295,8 +302,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
-- 
2.25.1


