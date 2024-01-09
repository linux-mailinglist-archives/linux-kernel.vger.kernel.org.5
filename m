Return-Path: <linux-kernel+bounces-20469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CD0827F6A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EA4E1C254F0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22C8381AC;
	Tue,  9 Jan 2024 07:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="iOV11NqV"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2088.outbound.protection.outlook.com [40.107.215.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D57374F7;
	Tue,  9 Jan 2024 07:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=We2NS9XzFnHv2vnbmDVuG0fUW131HRf1SmR/miOVwClpmDSsOI0aObe6Q5Gwmu1WUS6JhkAe7ls/gzuyi+m9FSRMrMN6JyaxVIaqZywrkPnwkYG3heICfjRaVgrqOQRJQILhf1ryJOXlhq+Jot6l/96+Ofv/VGNc3erejL4pyuedtlBPYnH8RMvpcn0H+SFKl4+H/uNLUf9N9ChhQAoO4ewfZqMnGcwk8X+dMyTH4h+j/e4P8sZY6y5WFDQJccj8a9v/cZEkU2bsI3N8K7FccWz1UUuOXDONzwh7XGCcK0bcblKd0Fgku9DCmO0zcld1kS9ikTlxZyr22+N8N9tMHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYpFg9mdH6XKuJD9Pi7Zr2ZT/6fjyL6fFPQPXh/DZEk=;
 b=DdGgt989oPXXrrLXwMEs12PjF2rUZ83eqIpftGQ0xBNBLX/QqK7CxEnd+vIfGHmA1epdMX6a+lxnIdiCcFv+1N1olrQAEEa4Esqu/RBHOq74U54tElSXUKu4fRK+KayUaUPbf9T+byBUAZdZAr5SkiJHafPgUsSO+FfR+rEkSCnGKXtkxPu079seASAjCLUZ86X9QECLS7MNj/1mRGSSxXlWG793mDrlqsQt5Tha9F5KTY2epH/DXmTRR2gBTYLNFrSaPaG6Wry4Rz7ZkJckkudqByMf8DRlu2XxgKpObRIM5EcyrXeoDKsR7j81Zu4c/TUh6h+hQIMhgFrI7SMrIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYpFg9mdH6XKuJD9Pi7Zr2ZT/6fjyL6fFPQPXh/DZEk=;
 b=iOV11NqVn3rBm5vMIL03G0518i5A++l8lq9/p8rRjdJr8xlY8xRxLOSVcBWC6z6/4ICkqznMnf9DXxfg2a3l2P2mTvJNUxLxQ/dZoNJob9UOTQSfyGU7N0Fhtj9O9l2KWvZPQG2ATBNbJ3snO277YcRdEOltAEyMKCRkm2F17278ssysjgs3dRiMqA+3Y8mQrBbtL1QmYu4G5QdJkkA+z2V1hIqhB9LkBjCZwLL7Ajv1P+Zke6nKp5r4Lj/khQhxZrLRSTVwUuoeavPx2P/yJbmXOaqlyXS22qh4af4QRDrlQe6QrkHHNPmqDFYT82tBOc5XiATkSxqhDD4+I+b7FQ==
Received: from PUZP153CA0016.APCP153.PROD.OUTLOOK.COM (2603:1096:301:c2::18)
 by SEZPR04MB6623.apcprd04.prod.outlook.com (2603:1096:101:92::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 07:21:46 +0000
Received: from HK3PEPF0000021E.apcprd03.prod.outlook.com
 (2603:1096:301:c2:cafe::37) by PUZP153CA0016.outlook.office365.com
 (2603:1096:301:c2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.6 via Frontend
 Transport; Tue, 9 Jan 2024 07:21:46 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021E.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server id 15.20.7181.13 via Frontend Transport; Tue, 9 Jan 2024 07:21:46
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
Subject: [PATCH v4 19/19] ARM: dts: aspeed: yosemite4: support mux to cpld
Date: Tue,  9 Jan 2024 15:20:51 +0800
Message-Id: <20240109072053.3980855-20-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021E:EE_|SEZPR04MB6623:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2ac978e3-ff02-491b-62d8-08dc10e3a374
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	D4kT2DSyzOB0T5L5G4vBqQ8dFtymdIzAiB5hv7yzKFznJbquQNcENLTKojcEzvDY22FckAh2XJ+bDiLGR2+ErZyhw9d0DL8i/JQL7fAAPM156Sd3Uk3hYfwnKK70StmsRmGz+WKgUKhVYqfGer40tXoJTX7jjZJmtlds47ooqRS5MFQXck9FLUpO1VE99gkog/rSsQ+ufZHq8Zi4Qijoe+gwAk7nBmFnH+sXT88BSVu3LIYd/gxuhEx8ky4xsFvaFFPncgIRtAPzX0CQL5d8HFuP6r52qenQCvBKgDeBs7UVdyBPw1bQ2WvRQ0ahA4e9bGGVh829YAE5MRHy1nHV5d2BHi2qYQFmfmTJhJJ+ffxLc1h8WsTLVXyhovX4GTAEtxJd3Vj1HpwJThvmfBYUyX7CRu6Cn7auKAC2Jb2CdvehcatRPLyIewtDy61l8odUpxjAsc/9txeKAKV9Rh+L6DwIoEykSugaX4q+0g/6Kw2pksaWyQlYUi+Y/G62XmgLpkTZ2kcKjS/vmjDf3g4WsCFZ3LPTDPZXtrQzpT5jEA5EanNfekq764s0gN2lHLnmU7Q8Aet7OpSJK+PJJ40OYPjFX/swCMDLFSkqttIChUnU9MjXK0VEFZ0o/4dOO46JGiGcqCa8E0KvJSw5EJTtjhTVvJDAJ4Wgk7F9m5OX+L5oLS5MgjxwE0zEQ3eaBKUiXsNPxCfHR+x3TLQyoiic/g==
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(186009)(82310400011)(451199024)(64100799003)(1800799012)(46966006)(36840700001)(81166007)(70206006)(70586007)(356005)(6512007)(36756003)(9316004)(6486002)(6666004)(6506007)(478600001)(5660300002)(86362001)(7416002)(2906002)(8676002)(8936002)(110136005)(36736006)(316002)(4326008)(41300700001)(40480700001)(47076005)(336012)(82740400003)(83380400001)(2616005)(956004)(26005)(1076003)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 07:21:46.3670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac978e3-ff02-491b-62d8-08dc10e3a374
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021E.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6623

Mux pca9544 to cpld was added on EVT HW schematic design,
so add dts setting for devices behind mux pca9544 to cpld

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 64 ++++++++++++++-----
 1 file changed, 49 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 8589f7d31ffb..440f735ef059 100644
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


