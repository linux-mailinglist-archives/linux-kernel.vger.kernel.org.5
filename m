Return-Path: <linux-kernel+bounces-99882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D1E878EBB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE6C21C227C6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 06:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5860F58100;
	Tue, 12 Mar 2024 06:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="KmIvgnp5"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11012008.outbound.protection.outlook.com [52.101.128.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84C05F579;
	Tue, 12 Mar 2024 06:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710224231; cv=fail; b=KCQrb+BOsvb2M/Ud1kB+d87Qd1UJ5FZwZeFiTaEOWDWTQzm5JSbnmP9uVvpVllHuuko09NdAm+XYeOsWPjvDcPBSi75BB3OqOC6EhBOhlMLIKGneUaxW2uuRA1XhfaALF+pKVMTgQns94fcsXp26IqhXDglIYA/wJ1+c1bLD00c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710224231; c=relaxed/simple;
	bh=BuYdXNCUHdToEvz/7/A6OAAzTTIGcRxLjEko8R75eEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=besitZ1/pjCXHIu+hOzMBj1j2PMjjTiRRGaw5KOwhzIMPdJt6XI7LBYeL7b3x4zxwXsixvqlMsszwzBijwGCHf0TvUjT/uQb5FhUKOg/Q1Wwq9inCvEmlAZ+O+f50c4bViHx5SKAJsnRzm4N/D5qOlhqdkn0nW0FHgBvzeI/2gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=KmIvgnp5; arc=fail smtp.client-ip=52.101.128.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PUE5cUy4BOGqK8auo5EeYUbXW9yA1GJW86jgJdJrD0IinCf0TQAAA+ZJsgrLqbMo1UB6bl0gmU6Mx7nDdffUQeUcFc+fm6MXp+/m+KMnjodARi6YV/aSVqpXq+OzGRZtSJFcNUnq6FV5vJhs1qgmKmxsct8Ct0yk8TpytEKZspMe+YzAKH0bSdoDxbFz/5u7MCrZ0JcQlqZbjMpl+1pLlQt9G9zL9NouL15Je8uCrRewvquc9C47lF14NUDRVyT2m5DwKg4onCeXjbFOgJ/ayfw19HJq1U8AM2vcgSp167BWebbJG+iZJwClXG0KK/u0NXYT5DgwhwD72SwSx0Gk8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZ1ITGzsLBsbsx/6Wb+lUCJdSYKrzhoPrVv7DVKNP6g=;
 b=SR6coH8qhStCkR5/cUgdaxOlEXNYRtGtFoMDJC/3FEjVr4ZPq9w7mmKeMFBqCiMAgmuXHlt3I5XmAaue71J8JWECVlhwF60EWJJdClKTtxP0UAWKJ3AupByCZ0Ky72ytTnqJigTA45hZoJN6ByEaNXgtxfmnxlqFa1KzNzyYd5ETsnsqRh9bO1vgqkOjBGTygm3Pku7JN0DNMZFt1ezF2aEbGOJM3V8gbD5DVmxHt+aWOLxtwulIDgcV7XCxnwuENB+M5zi+t4Ko9l+iXiJT8T+TBPEziHazYZPoBubqVT3R6Yav3X4fIbjgZU+Js4pMEZcGjurNCV7+O4ItIt65Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZ1ITGzsLBsbsx/6Wb+lUCJdSYKrzhoPrVv7DVKNP6g=;
 b=KmIvgnp5Og+09TqVscRcNvJlerXjQgEEwl+X1TQKnkZeJGo08/W4T8cEoEL1+07eL0QgTa6ZeYLYBYu4wEyoyZmCOU32zcKFVjj4YiLSItGdhlNCUJRvVRQQXE+xjiMB9Zr2hrtYL01cn2u2aXtDcU0wCCCTO7wcFxDsKGpS0kCO4js+hpCyULWbaXUc1EqQR8DRV3s5aF1/9Keg/Iku6iJ1ME+993+0YjVkvAF+Ephali9BZPaqZdHDdnO+khXI0QCSJHZYi+3l/uTOnpd68Q456BTMBeq2t9zsjnCCbTxPPNV2efkPmzV4n2+HODXVHnubkjZl87uNqa4uTe2VSw==
Received: from PS1PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:300:75::29) by TYSPR04MB7005.apcprd04.prod.outlook.com
 (2603:1096:400:475::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 06:17:04 +0000
Received: from HK3PEPF00000220.apcprd03.prod.outlook.com
 (2603:1096:300:75:cafe::cb) by PS1PR01CA0017.outlook.office365.com
 (2603:1096:300:75::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Tue, 12 Mar 2024 06:17:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000220.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server id 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 06:17:04
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
Subject: [PATCH v6 19/22] ARM: dts: aspeed: yosemite4: support mux to cpld
Date: Tue, 12 Mar 2024 14:15:51 +0800
Message-Id: <20240312061556.496605-20-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF00000220:EE_|TYSPR04MB7005:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 822f5ad0-691e-46cd-da99-08dc425c0981
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iP8x521w7U35biu8zTeOTbgRZTKnKrVPyMsIcKFrmIbPypcBDMHLe9pdxzC2gKKaRdS0HQi5sa1DHPPg3Qn/g1gZWLhwzbOsiUav/o9oy7jwnx/E3CIYYMls7s6f08BNWuzhTL3/DN7VymRqqkt/4KyZUNBgnd5Ds4tXcThr0J/oPIHhdhviqJVEf0DRyWsjM/QhTOhZ5q11Hd5CtfsAzIGfG9yZWJIW7i8Z6PPYyCu/3+AE6F7OQDlufxdPe4UO84ZUipfQYrHqKGVk2KtZqW1cOTAaBjCglV2hCBKU6FMUIMXXMov1D/tqweHDgkOFcB4tRwTLCSs5fJYzxqDHJELIVcho7V+IotjaTg8x/4PxBJIzCTHMpn8YDsdwCj00zkvTUuG0iQfQUMpMmHh9FVP4N3sduNJrtIuImqOZCAnA8jufFdzlQIzlWx/I0uIuEsFDlXkDsqxAZCdNDTkSDTAO9n7V6wxKghKEkBYHf09j+O1MDjHpMBuLVg+emvYmJs6dUc7pwdL2pcDNrr7pUYMV7nOnqbhWc2VDa230G7koU7bY75DS4KyQORvkPjI99DhRwEDSPeQt1ki+6+rmwK41f3dylNCDYdqKx3Ntx7dhYZ5MKYyEtR94wPS224rc5e980uFL7cNXi9dG1RkxUN7qudZ+1OkrqeXZou4/o9SxyERpvtPiRDl0WW5F2klu2IFUTW4AJpN4mtMOehGOtfdBPDNk4GKUshiG1GkCmSHg0+5scjXJoXH8U37rseh5
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(7416005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 06:17:04.1509
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 822f5ad0-691e-46cd-da99-08dc425c0981
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000220.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7005

Mux pca9544 to cpld was added on EVT HW schematic design,
so add dts setting for devices behind mux pca9544 to cpld

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 64 ++++++++++++++-----
 1 file changed, 49 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 06f22562b381..d85c29cbb286 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -36,6 +36,10 @@ aliases {
 		i2c31 = &imux31;
 		i2c32 = &imux32;
 		i2c33 = &imux33;
+		i2c34 = &imux34;
+		i2c35 = &imux35;
+		i2c36 = &imux36;
+		i2c37 = &imux37;
 	};
 
 	chosen {
@@ -951,24 +955,54 @@ &i2c12 {
 	status = "okay";
 	bus-frequency = <400000>;
 
-	temperature-sensor@48 {
-		compatible = "ti,tmp75";
-		reg = <0x48>;
-	};
+	i2c-mux@70 {
+		compatible = "nxp,pca9544";
+		i2c-mux-idle-disconnect;
+		reg = <0x70>;
 
-	eeprom@50 {
-		compatible = "atmel,24c128";
-		reg = <0x50>;
-	};
+		imux34: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
 
-	eeprom@54 {
-		compatible = "atmel,24c64";
-		reg = <0x54>;
-	};
+			temperature-sensor@48 {
+				compatible = "ti,tmp75";
+				reg = <0x48>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
 
-	rtc@6f {
-		compatible = "nuvoton,nct3018y";
-		reg = <0x6f>;
+			eeprom@54 {
+				compatible = "atmel,24c64";
+				reg = <0x54>;
+			};
+
+			rtc@6f {
+				compatible = "nuvoton,nct3018y";
+				reg = <0x6f>;
+			};
+		};
+
+		imux35: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		imux36: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		imux37: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
 	};
 };
 
-- 
2.25.1


