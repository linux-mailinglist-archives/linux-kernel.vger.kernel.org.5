Return-Path: <linux-kernel+bounces-46053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE958439C6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E881228E277
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F8558137;
	Wed, 31 Jan 2024 08:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="d88AaHms"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2073.outbound.protection.outlook.com [40.107.117.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EFF12AADF;
	Wed, 31 Jan 2024 08:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706690587; cv=fail; b=u3NAWT6vqycdiNgtE1ErNcKF+Gq3XUUHhkDQxZ2sKfLYzFimjUZu8BxW0yjyb4sGL8gJhhkif+oGBaBpoNgioH8gY04ZLV4TZxNq9bkC/FemWC5ihIst0W8q3ipwcVadXOG+8p8yf20qNp+zSUuy4ckyQEASUrFu2r3HSq/6ahk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706690587; c=relaxed/simple;
	bh=S68BIgregXDVLIWh7dcwJQG3LlrJ6KvJvircEdGG4KU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rwKttTVwqC0HQDXsTDN44OMO52BgV7sln9QNu2pN8P6aIQ5sjt4eyeTvG2JjxvZhlAXxNr+MuE5D6cx3WfGLr1K6NpbNJhmkcglHPivfwg+tbbOZCs2lZgkh5MwX7/02biO+xHzqFNxGdaj8hU56AZItqOY/G3PsLDnoGTFQsuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=d88AaHms; arc=fail smtp.client-ip=40.107.117.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwkYBNbQrWitQ64UljwW7osx7bqx6pciIhXHZORF8p8f1ou6UlfQkoGyLdLpZmz4phENGdLcch1MlW0Zt/JMDUpusKOeGIoZovHRlHpchXogme4jqVw1PdDI2868Dmoo6xRX0rjXOSK71K5Ey5q/cvUsmkuuF/dZOdGFf363hSBFcgSAZuXQXfCLHdDx83IlXfOPp+UVDN2j52WaRiP3KMpmdtDDjIja0PmWU6ZgQ1Aq4bXcJJQM1C4DSQ8SYSdi9PDH4WDU60KbpLM+fnL8dfskCMf2YyKbjLmytc2G5D4E6isPQ2bfm1FcM6XU4itZ5CcbN0lFspQqAqPkKN+P8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nJU9mybu7P9cQzpemlijUjqr6vFMnsHbmyjQscZmf0=;
 b=TAZkhfW6UNf4wA9JIKFL2haP5Q1nNmeo6mQ8XMPo4+tj2NBUJHBFyGXT5ucZeajBzSRqT2mD2ViTHQvjUw5os0NunbX5UtjV1O1UoHo0FuKHq0ENXaZFYA+sZqmqLTIFotQdZSXbvJs4zwnHdlAWLO2VS8IWNLoxca2DjW8WPvtCOBtuKRCKVFYwMFUsKf0wmAeWd2rdfUmnjqW3tB3ScnzvAKO6kREUFMXWxOMP8DTbWTn31csYEnjfr8sNAaGLeS/0HCJ3YBUfth1PfCaCJQLRrKks3SdchP+sD6eBdMRET+EFlnVWoBCpDTM3yApNMTtlc7VBz44TwjOE4UyPpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nJU9mybu7P9cQzpemlijUjqr6vFMnsHbmyjQscZmf0=;
 b=d88AaHmsEeroE0O7JrNctOWYz62+hSF5gucxfa6WZn21hPIlrVApl0r28mnay2XlQKzQdZOsBw9JysdJVFfecgeRfOnYxyXTbeznBUoHVhS4Woyx1gC2uMlbZey7GlD7WgKkqB+/uKu97CrMOuczHEkmvskQOidp/2zWJ5kQfecaNZAd4z8zJeJitP30NgP/nK6kkuUDtNpm1k2v2bXHoNxchHq2Roow0sLm1Hx93cPOgP8oIzdLbzGC0Cqc8+0/2QqcgwqhSeByQm9lzID8YS+pcbQNXD0cgO6jFSi3MyAcc2sAmn/ppPX8iHIEIZl/bwmyWkYVeRwhaeDBAG4Zyw==
Received: from SG2P153CA0026.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::13) by
 TYSPR04MB8003.apcprd04.prod.outlook.com (2603:1096:405:92::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.34; Wed, 31 Jan 2024 08:43:03 +0000
Received: from HK2PEPF00006FB2.apcprd02.prod.outlook.com
 (2603:1096:4:c7:cafe::f0) by SG2P153CA0026.outlook.office365.com
 (2603:1096:4:c7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.6 via Frontend
 Transport; Wed, 31 Jan 2024 08:43:02 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB2.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server id 15.20.7228.16 via Frontend Transport; Wed, 31 Jan 2024 08:43:01
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
Subject: [PATCH v5 21/21] ARM: dts: aspeed: yosemite4: support NIC eeprom
Date: Wed, 31 Jan 2024 16:41:32 +0800
Message-Id: <20240131084134.328307-22-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB2:EE_|TYSPR04MB8003:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 15866355-27c3-4d6d-4a2c-08dc2238a2f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4QL34a4FuFinqY7Fzt74ISKy0F7wttaQN6i1ZszqqzeHXP5SkkjCaAAArqDmtLM1HUjl6P0wjLKNoWPYWuJXbqNwAeD0pL/T479kgXc0AM8zK/AusJyX5SpCU51QD03meuviyu2giphQMu+em84IT767wiQEP7Ynx6x+mnsgFVNm6vF9uK6SC4NMoJgcxSh438LUavONLLbas0d85F/f03uvQFtEd7+QvGLpEUIYPp5gDvO7EGoAQSplCnYMzGo9uyCOB1gTKzwo7PIspkAIcGAPUYf1O5O8I78M6LZ8Zmhzwgis2EZSftfcbFYL3fARPYbmPbvhYfT5RzzbDOrZT3bF14UbSQio8Dyg0pKZRVfy02SuP0iDO6KoO8AkuwCVIMoSdVY1/e7wA9GuFr0C2qhwEq7AeEbjJVK5yz2VTccIxC5qrFk8xVBeSu0ix/+RKNt+z4O1eQjySzlA/WBMewnTKcMGphZ92tTPSEYdy9OMGyXaHv2fc0+qU8pUL4IAUdK9Uxo+vyDqPMpUHds6TTTYdho+VuH9NOYZKdoV1i+xzb6FD3/u2nCYMRu04xyL8ucVVz+pagCu7kc7esuBMyFalg3WL6x3cMU8xkPIjQ8X0wtWXduriL3qF0lZz38UoxgPLHppBxJRCnECD+a40NtcnKqz+h6NB1ldWxMvWPMvAp1vJry9RVxxcWsArdD+OPyvcH2gMHxQ2IcNTfc8DQ==
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799012)(36840700001)(46966006)(41300700001)(9316004)(26005)(6512007)(2616005)(1076003)(47076005)(336012)(110136005)(81166007)(36860700001)(82740400003)(8936002)(8676002)(4326008)(5660300002)(7416002)(6486002)(316002)(6506007)(478600001)(70586007)(2906002)(70206006)(6666004)(36736006)(956004)(356005)(86362001)(36756003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 08:43:01.7239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15866355-27c3-4d6d-4a2c-08dc2238a2f7
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB8003

Add NIC eeprom devicetree config

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index bb0dc203eafa..8adefa4ec04f 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1330,6 +1330,11 @@ temperature-sensor@3c {
 				compatible = "smsc,emc1403";
 				reg = <0x3c>;
 			};
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
 		};
 
 		imux25: i2c@1 {
@@ -1346,6 +1351,11 @@ temperature-sensor@3c {
 				compatible = "smsc,emc1403";
 				reg = <0x3c>;
 			};
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
 		};
 
 		imux26: i2c@2 {
@@ -1362,6 +1372,11 @@ temperature-sensor@3c {
 				compatible = "smsc,emc1403";
 				reg = <0x3c>;
 			};
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
 		};
 
 		imux27: i2c@3 {
@@ -1378,6 +1393,11 @@ temperature-sensor@3c {
 				compatible = "smsc,emc1403";
 				reg = <0x3c>;
 			};
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
 		};
 	};
 };
-- 
2.25.1


