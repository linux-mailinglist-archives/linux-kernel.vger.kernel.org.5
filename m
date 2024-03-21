Return-Path: <linux-kernel+bounces-109565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2713A881AE1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5156C1C20BEA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797DE8BF3;
	Thu, 21 Mar 2024 02:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="EEQwKNbf"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2070.outbound.protection.outlook.com [40.107.215.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279DC79C2;
	Thu, 21 Mar 2024 02:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710987172; cv=fail; b=k1SZ8OAcNmIkCQt5KwtF3OgRUM1hH+PK00JPGnjIl3zVykk7VGVC7GIxBlRHNOO2RvASkBC9KWlw2rxcz7B/+PNJKG6dC76dNKNgHuk+B+h1jalWezaq3GXLddhj0eG4jpRpWGXDWsA7mNQuesk044hrpzxGc+G0VTmHbeSjBPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710987172; c=relaxed/simple;
	bh=RbEp8iWyRNW1ouNoom+lkaMMUChP085aF1AKhPNS890=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cluh5hHIFpoqldSqaC7jrVlHdSWojIgBTqXIAJGE5uj+3sVdPxExOuQH5+95QlhHOCW+iKSvWWScisz8Ys9iiVCp3zPQU0E59STi4UWJHxn2SCNgJ3bpgkAipyEZ1q7pyqHO//OgLxnvbsIeKbOGjeYW7is+/h6asetsdVrrj88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=EEQwKNbf; arc=fail smtp.client-ip=40.107.215.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAJNzHsbr7UikhjeDAt2afVk5lKxH4bKpLdLtHeSHp9W36PBzczaNWCuJNlMalh1TMo5PqZ1ZAPCrpr4QteFMH9w77uVAohyJAO2iPq5GB5PV4VpvhwIhw1HcFXjRTww/ltKj075Efjokmvb9vlp6CprIpNB9R5OGjrdYTU1VnA06WZppi3H2i6y/3+mxse9J17WWyzls0J08kDKeD22aJR3o058NFKXB8gc5sLK6R4I3tI9XKU5u8dLxIepMwSorgHOxky1MaBfzAS2cdfzZ3rp93SW5nMmasqSo9b4yhiUHRZNjJOMuOPBTML+c8MJ8xo4Vl6YSOmeHbw/jPQkWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmSKcEEWKURPlkS19SqAb+0saPQht4EwjxaRbHrRzNY=;
 b=bczbug26xgqEU46/TyH971sVtgQsIp6mjbbwLoy1vGPKuNltu1Nu++Nx+TlAph/7sNmLDlNZSaIYF5ueE4qnmj4Gy/wr2ArEGU9HH/j8KdySGl8LUWic1jIjFQvYN2P47Ioo0SYzkz+rjqtkaUSUaCXDqeaoTwZIa7epwBXptEp7MEh7rImj58MtXjt72ypRdweLIedO2EdQLe44Pi4eBhtlCMiX3o+FvwWhVUzVhls3My6EPz01AM0lO4XczDggHPIwuG23ZXTNMhDDKecQgSNRkgqDqNdpmxTjL6D54ZP7ordAH7kFbPtVL0S6zSFuDKRNYwunE0FortG5UuePCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com;
 dmarc=temperror action=none header.from=wiwynn.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmSKcEEWKURPlkS19SqAb+0saPQht4EwjxaRbHrRzNY=;
 b=EEQwKNbfajoCTWeomR2LSx1vvIUatGZIm2s2AxDhtbk4IAM4soW3ShWVnN4Ci5gK3Gs2NYTi569GNV4QKrHwhIA0jLaKuB8UJFCMLr8gN/ws6Otov4oDBs7kTMO6/VZ0qRf5ice1i6Y2shOqYOS+IDc9Irqf+Nv8AmuSuBUT3P0P30gn8CWw46vSPo1K9BuLnoaqr7l5n7/iyYCt91b3Pss7dHIm7uU33GNvtabBi+mAQ4TC6+acfBoreJztpbxZeHe46/9ps4G50dduPEc1aK5VWiTxDWwwvhqUdN49dVwxnBPhOxoP9vatB9ptZvGsaw5I4O1Miup2cCR1eNvgyw==
Received: from PU1PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:803:15::26) by KL1PR04MB6949.apcprd04.prod.outlook.com
 (2603:1096:820:df::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Thu, 21 Mar
 2024 02:12:44 +0000
Received: from HK3PEPF0000021F.apcprd03.prod.outlook.com
 (2603:1096:803:15:cafe::78) by PU1PR01CA0014.outlook.office365.com
 (2603:1096:803:15::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Thu, 21 Mar 2024 02:12:43 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=wiwynn.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of wiwynn.com: DNS Timeout)
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021F.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server id 15.20.7409.10 via Frontend Transport; Thu, 21 Mar 2024 02:12:42
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
Subject: [PATCH v7 01/22] ARM: dts: aspeed: yosemite4: Revise i2c-mux devices
Date: Thu, 21 Mar 2024 10:12:13 +0800
Message-Id: <20240321021236.1823693-2-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021F:EE_|KL1PR04MB6949:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c9367d85-dbcb-436a-b545-08dc494c6402
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UiW9RIIDfRGLl9g8ZEgxlCd+6b/0KCUvasbYAeMQKEPdxqOJQ83DmFEyblpp6QdaNTM8lvm6P3XzcxEtv/no2/4AiW+EN7gvqwaBsb5jn3wlb3BexzlA0IE5q6GeGgvPjRBONSMY9TwyAiGycPjPZ5TMNaJheLbPl96Rvg0Z4My1OX19cJ0MOv4OBH9BP7eBZORRs1KOjF3u2ObhnKMHqBmg+iwgKpOdPgSjo7T2VKGGZ2KaDsLI/9vebW2PxSb/Gw9dfQZUVFv+EDeZ7vFy5bEVLwahZcPB8NfZw1Xj/VdinqzIGVErWFAwhjeVdXVqrpJtcsSFz0paX6AXXDSETyeMgxkHI1IZ8NEtxxRRmXP2P6dZwH8K4NL1ErtB+dh+NCD3bfAWzoxpeTQbEZeM0eKg+gxhTymZ9ouFWtTdrq1Y0H1oJSShBbB00gNV8oW8Tk2lS//2xKtdrFlqku4b/jf6Nf9pgVu7XT3pfLhTkTwGtE5zoMq8JXG+zx/WKzYgjvVRM5f4yNA/VRfp88sDnr8DkKohmoVXGp9iK9tzjH+4wlvj+JnFQV3WP2KWWPw1Q3KKYO9Mf7gMA6faNd5HbntZxNrjoHuaBLW5jJOM60nCS4lSIwqLxTWtesLR177Ry91b8ukD+/CZLMCkJ1U+lZL1cf0t5GM976JdfBZceDKPmVtlBm0clxhkPYTgMotWirRqmad4V6gdipNd0SaV2/vg10U8yP/8QR5OVKg99HPYsdcWqp3SVrcWYeX8O3oD
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 02:12:42.1040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9367d85-dbcb-436a-b545-08dc494c6402
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021F.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB6949

Revise Yosemite 4 devicetree for devices behind i2c-mux
- Add gpio and eeprom behind i2c-mux
- Remove redundant idle-state setting for i2c-mux

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 381 ++++++++++++++++--
 1 file changed, 347 insertions(+), 34 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 64075cc41d92..dac58d3ea63c 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -17,6 +17,25 @@ aliases {
 		serial6 = &uart7;
 		serial7 = &uart8;
 		serial8 = &uart9;
+
+		i2c16 = &imux16;
+		i2c17 = &imux17;
+		i2c18 = &imux18;
+		i2c19 = &imux19;
+		i2c20 = &imux20;
+		i2c21 = &imux21;
+		i2c22 = &imux22;
+		i2c23 = &imux23;
+		i2c24 = &imux24;
+		i2c25 = &imux25;
+		i2c26 = &imux26;
+		i2c27 = &imux27;
+		i2c28 = &imux28;
+		i2c29 = &imux29;
+		i2c30 = &imux30;
+		i2c31 = &imux31;
+		i2c32 = &imux32;
+		i2c33 = &imux33;
 	};
 
 	chosen {
@@ -259,9 +278,109 @@ &i2c8 {
 	bus-frequency = <400000>;
 	i2c-mux@70 {
 		compatible = "nxp,pca9544";
-		idle-state = <0>;
 		i2c-mux-idle-disconnect;
 		reg = <0x70>;
+
+		imux16: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom@51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
+
+		imux17: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom@51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
+
+		imux18: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom@51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
+
+		imux19: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom@51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
 	};
 };
 
@@ -270,15 +389,174 @@ &i2c9 {
 	bus-frequency = <400000>;
 	i2c-mux@71 {
 		compatible = "nxp,pca9544";
-		idle-state = <0>;
 		i2c-mux-idle-disconnect;
 		reg = <0x71>;
+
+		imux20: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom@51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
+
+		imux21: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom@51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
+
+		imux22: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom@51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
+
+		imux23: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom@51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
 	};
 };
 
 &i2c10 {
 	status = "okay";
 	bus-frequency = <400000>;
+	i2c-mux@74 {
+		compatible = "nxp,pca9544";
+		i2c-mux-idle-disconnect;
+		reg = <0x74>;
+
+		imux28: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			gpio@20 {
+				compatible = "nxp,pca9506";
+				reg = <0x20>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio@21 {
+				compatible = "nxp,pca9506";
+				reg = <0x21>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio@22 {
+				compatible = "nxp,pca9506";
+				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio@23 {
+				compatible = "nxp,pca9506";
+				reg = <0x23>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio@24 {
+				compatible = "nxp,pca9506";
+				reg = <0x24>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-line-names =
+				"","","","",
+				"NIC0-MAIN-PWR-EN","NIC1-MAIN-PWR-EN",
+				"NIC2-MAIN-PWR-EN","NIC3-MAIN-PWR-EN",
+				"","","","","","","","",
+				"","","","","","","","",
+				"","","","","","","","";
+			};
+		};
+
+		imux29: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+	};
 };
 
 &i2c11 {
@@ -433,16 +711,14 @@ eeprom@51 {
 		reg = <0x51>;
 	};
 
-	i2c-mux@71 {
-		compatible = "nxp,pca9846";
+	i2c-mux@74 {
+		compatible = "nxp,pca9546";
 		#address-cells = <1>;
 		#size-cells = <0>;
-
-		idle-state = <0>;
 		i2c-mux-idle-disconnect;
-		reg = <0x71>;
+		reg = <0x74>;
 
-		i2c@0 {
+		imux30: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
@@ -450,26 +726,26 @@ i2c@0 {
 			adc@1f {
 				compatible = "ti,adc128d818";
 				reg = <0x1f>;
-				ti,mode = /bits/ 8 <2>;
+				ti,mode = /bits/ 8 <1>;
 			};
 
 			pwm@20{
-				compatible = "max31790";
+				compatible = "maxim,max31790";
+				pwm-as-tach = <4 5>;
 				reg = <0x20>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 			};
 
 			gpio@22{
 				compatible = "ti,tca6424";
 				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
 			};
 
-			pwm@23{
-				compatible = "max31790";
-				reg = <0x23>;
-				#address-cells = <1>;
-				#size-cells = <0>;
+			pwm@2f{
+				compatible = "maxim,max31790";
+				pwm-as-tach = <4 5>;
+				reg = <0x2f>;
 			};
 
 			adc@33 {
@@ -492,34 +768,34 @@ gpio@61 {
 			};
 		};
 
-		i2c@1 {
+		imux31: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			reg = <0>;
+			reg = <1>;
 
 			adc@1f {
 				compatible = "ti,adc128d818";
 				reg = <0x1f>;
-				ti,mode = /bits/ 8 <2>;
+				ti,mode = /bits/ 8 <1>;
 			};
 
 			pwm@20{
-				compatible = "max31790";
+				compatible = "maxim,max31790";
+				pwm-as-tach = <4 5>;
 				reg = <0x20>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 			};
 
 			gpio@22{
 				compatible = "ti,tca6424";
 				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
 			};
 
-			pwm@23{
-				compatible = "max31790";
-				reg = <0x23>;
-				#address-cells = <1>;
-				#size-cells = <0>;
+			pwm@2f{
+				compatible = "maxim,max31790";
+				pwm-as-tach = <4 5>;
+				reg = <0x2f>;
 			};
 
 			adc@33 {
@@ -547,12 +823,10 @@ i2c-mux@73 {
 		compatible = "nxp,pca9544";
 		#address-cells = <1>;
 		#size-cells = <0>;
-
-		idle-state = <0>;
 		i2c-mux-idle-disconnect;
 		reg = <0x73>;
 
-		i2c@0 {
+		imux32: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
@@ -563,10 +837,10 @@ adc@35 {
 			};
 		};
 
-		i2c@1 {
+		imux33: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			reg = <0>;
+			reg = <1>;
 
 			adc@35 {
 				compatible = "maxim,max11617";
@@ -589,9 +863,48 @@ mctp@10 {
 
 	i2c-mux@72 {
 		compatible = "nxp,pca9544";
-		idle-state = <0>;
 		i2c-mux-idle-disconnect;
 		reg = <0x72>;
+
+		imux24: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
+		};
+
+		imux25: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
+		};
+
+		imux26: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
+		};
+
+		imux27: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
+		};
 	};
 };
 
-- 
2.25.1


