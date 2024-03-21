Return-Path: <linux-kernel+bounces-109582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 671E1881B1D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8685283BBA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C0477F1F;
	Thu, 21 Mar 2024 02:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="nIrkWBfj"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2045.outbound.protection.outlook.com [40.107.255.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9342BA22;
	Thu, 21 Mar 2024 02:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710987221; cv=fail; b=QVuta/fQ+G52hGyb+1WiVPEno9DU1CxglUOQDlm3M8WPiTZMUdYrERda6bKSzJGz13KxepPnJGjXRhGAG72iKUrMexGzINfu+ao+vwoJk4jhyrvwpVX6/cygAtQYBJt56c7F/kSUUrvfV2YbyqfaM50k20cXoauE6W9MHijTA2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710987221; c=relaxed/simple;
	bh=s/0PkrGXIWip/iia6UQ1WkNGvCDdo3DITUJul4nr5LY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VLuFZYFuRdwC0ERiFwtOipUjqWtBEmKtSFGUlwdnns/uh6Qexxu7U+9GL5XmiaQFMGwUuaqUmdKTy39BNyp4mAmDuAwGxsbG2Pu9rtna7rTO40tOSJaMQw+DRab06OXgk70T79yWHh4kAlFN8r41hE/pu1FTIHoXeQDnCgH5HPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=nIrkWBfj; arc=fail smtp.client-ip=40.107.255.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+d/L/ST/iiLre6+75l3nMktsq2BcRuJp7pLJTN5icLvhOUQACbZ9DANitTaVu1Lc2iLYr9BMsF/EagZ75VNEw+4QIvg2njJ86WRMVzhD455Z5tTp+HcPvfJKOdr+sY0Ou7lYAjeoUSEYgeojSButP083Ay71IwW2aAq2+rcbbHReS2jXHg3lkMpPG+T6b7T+cc2/BZ1+Zpo9DYlhKIgHdgtr9WpzXYDCZ5PDJ4Y8heAHQiIL5tvlewAp1njnTEJerxzRbkws33rgIsIrnEODFv1sZqcJI1kwyNGSvd45eKyNnAcJrJcOZj3qqg11W4qya68oDAl61lfEvP7KPitLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HE4AiR2ftxMOG59ugCbzYP6XtBmBun9n35GE/zOsliI=;
 b=IzXc6bQOODXV+fOuM+JJYWHw2uGRCKWR7BxCUZUKNXcBiPi+BPAGkRd7oQluZFnMSCUVj34GPptC10XErlkkPskpQC7cImHSmPOJrscRJJ+NIWUeaIWu5zx1pP54tOevR/Uia0A6BfMFK6lhJDbX4zZxb+PGqnBZnfpHQED0DtZjTtNFAi9mPz5bz74Mqit4Qdje6vj+BBf8Xa0MkKZ7X8CPz8QP3QNYkYjfk3ZAEgaAH1iTYOfU+Lf1fcYNeZwSmsBLZv3jU+KAunt3ZxJTbntjEXqr3bhQ4h+2SSW6l7YXbiSm7NfxvHm7YIw091tHnAwO3nmZtS5pKlQEezc0GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HE4AiR2ftxMOG59ugCbzYP6XtBmBun9n35GE/zOsliI=;
 b=nIrkWBfj+mh3lpTrY/xBB5Va0UP0KH/Rwr2AQfAHAta1ASM23wwI9hy2P2uyNi3zJsjucdCB9uXhGFlRNmBmu+VNCslsM6X7nI1qK+6gzOoW/Tv1gSL0GY+CoP2ImZ9zzyw0KYOFr/qrWb2afW9nFw+ONLftJOns0Vmd6C9O2fb1xu38GXf/xYPdTP0BgWEWrSf0huxLFqeUiVUfj6RwYrk1ZzMIMGl+i1LOryO+iOXeMyxFMO+kUSFeSc53ivfhu+9shS8oGhIpls8bRFRH8+j0dZDoeA8zT/HLr0bttH1OEblyIGPXESdUTP8QdZPPNTlFEeJawbDIP7MKX2yJsQ==
Received: from PU1PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:803:15::15) by KL1PR04MB7770.apcprd04.prod.outlook.com
 (2603:1096:820:12c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Thu, 21 Mar
 2024 02:13:36 +0000
Received: from HK3PEPF0000021F.apcprd03.prod.outlook.com
 (2603:1096:803:15:cafe::c3) by PU1PR01CA0003.outlook.office365.com
 (2603:1096:803:15::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Thu, 21 Mar 2024 02:13:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021F.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server id 15.20.7409.10 via Frontend Transport; Thu, 21 Mar 2024 02:13:35
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
Subject: [PATCH v7 19/22] ARM: dts: aspeed: yosemite4: support mux to cpld
Date: Thu, 21 Mar 2024 10:12:31 +0800
Message-Id: <20240321021236.1823693-20-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021F:EE_|KL1PR04MB7770:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 042efbb6-6677-41f5-3493-08dc494c83e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NJm4v1Ic8ivic+VOGkXtW9TLFHzZvp3Os1HbW0MwXUk2Z0L34aFkMAuENDCi+v0Isw4mgXhwD03d/pprjiDr5O2P7TNhYRgkWhKRICC3drI5MAnl5zFyT0nuKNnMgheKlNHwrhTCXDefMI+KFIFjVlgXZsyIqq3qv+d0C2FnvnsICIIdVA93aptGRtLmjwkdx6NhouxskzXeVGAFR3lKIQL8U68mOs6265OPCKpLcA9fUSh+vBHucsubXwrm3LU3iR8sYtoGqMX+SqBpQTLgHFe4dUS+h44wH5jHVDBh9hzpf1COp8gTBsnZ5osnkqiPyia3CZnUWAYYHqdFifn8+CtMZMe7JIWbxt8fC1j5BLZpqgsQShu5QUy4NNTWnDDjiK3bDh4/GlcwmBUhk9sP+Hh0q1rGVxco3AF0CDnJuOmHUTxoMo514mEFMWlpsMYZWLbd01BISPL71PSbjpmi2HtdTaLWZK/S4NClb6c6Xj+LIy8dDbvJNfdESibQ+ChkkNm0Q4QZ8pTVeKFO0nMz2ih8F7cP6gwCuaOa0Ya9rv8mb3YgcKbhbgxtpXf4/ACKBHQs8yQ0Kl1b09wDwe7LuQXKaMHcOw0mGkYdj5FI+2XdVH9ndOIs7nYXL26BgenOSm09eHrmJAJmJrW+7GcMN2rFjpZdlBOTuKTn7m2ATxauIfWwJrPTGE+6aoeoVDX12tCAKSkbLYssIM5NySu+f5EOi0dv9d7ZiOCaH+8TlfqqTNq4PTxKwCKfglICxjMj
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(82310400014)(376005)(7416005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 02:13:35.6824
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 042efbb6-6677-41f5-3493-08dc494c83e6
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021F.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7770

Mux pca9544 to cpld was added on EVT HW schematic design,
so add dts setting for devices behind mux pca9544 to cpld

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 64 ++++++++++++++-----
 1 file changed, 49 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 0d2f0c589944..373eacd3186e 100644
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


