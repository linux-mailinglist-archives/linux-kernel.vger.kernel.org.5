Return-Path: <linux-kernel+bounces-109585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94180881B23
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E5611F23B77
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDCC78670;
	Thu, 21 Mar 2024 02:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="0VRPZXN8"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2045.outbound.protection.outlook.com [40.107.255.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F7378298;
	Thu, 21 Mar 2024 02:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710987228; cv=fail; b=dbIXuq9NTDdL13XpyPSVXpyF5LhmUhyjroeugAwmhvpZ94xFT/MBlcxq6e1X1Ocy+qO8pN+0WHhf84hyFLbIDnmUd6DfzBvPqT/jiml4rYp6561RQ0Sk/CwZwNQPZexYp2C30hFON4ZWVdtJlPNe9d8s3M1oAjkLSbg6dC62iqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710987228; c=relaxed/simple;
	bh=ObAQFO3QuLRccdkdAJg/gfAHcjqdXIeUXAeGBIcJhpU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m28+uE2Gah6wwMyrUNWhPnHhsDzQ3zsQRc7U7XY/aV9cA868RoMFt/XUh1Rn4HMRqhm1ZnufpKDbNeYYJSgU1WbHHIotnzdnjEBZ5N/AA640NYbylDYoEdGFozFdrn1fIXIeol4fXuFtm62KnSRtt6TDkqLpHWZJ9gyGaw/Ka2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=0VRPZXN8; arc=fail smtp.client-ip=40.107.255.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCjwuB/K8JUtvs4xvHODN17ysU9mz6CepCvF+xQLwV2f08eRUeysCP8aK3QV1k8gPTVeNf18/iphmC0EQS2qp25yRipW0ywecIC0siFQXcdwVfuNoLsnShz/l8T9+xchsyEWnFIZbVB09zUzI4sU7No9hxdzbh6Yfm3Hfk7az1UFQ2VGRKY/yparMBBDfQkwHGDG7hCEF7svxEcndErkGwjMd+7NpPb9n8nWm/y9XBxRJtNVIm1B9sBRag9bV1vpmV47wtXss2FpLqpXYLBWywDhlIa7jF7Fo5KZSDvO+vXm6/5ucjE/XUzsKYsHbzpHLzVewm2VOWQd+hCYsCnRxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6nf06x5xWOlcO2bdyMJICgWSfEMSlRC7fbpMNNkPn0=;
 b=A/Xzzl1cuCMc45T5NYPj8HvOwqL+UcH1lD5BLDBdncvKvuCOHMY4df2rWwSxNTYR3WTXb4AQHbJZCpaJiuJNdD5740HLi9Zn6HbIWCFEAx/bgc0DMYC9uJRhslsg4HOuYr8bncKKLD1x6f7yMwaFvYKiyVm5qb9s+blrrIxa0c7a21yQ8b5BZjHzR1esYvMVAveGWAc28IMiulQpEiMossp7001Lu3sQjifDNvSsXax+0VKKzv75wc6Ihpq72SNwMGdHLrf/rlETxyOVabsDDVO31iTB46LXP6coETf0h0ykM/1c9lZ9042fJq42EmytsjdEarYTKEP6LNWxJMtdZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6nf06x5xWOlcO2bdyMJICgWSfEMSlRC7fbpMNNkPn0=;
 b=0VRPZXN8kV/lnuBaAOE2Slt8/EVJj+tYOhSnbSY4wxY2zP2gMHfxO2q6R1JqJSYU61lN5d5+PJsgicTebBDgL+kizSu+y1Iol0ee11YUx+jDkM6zW0vepvT4BzLmBXhZ1yINeSgKwR5CABY2MuP71AoicPqKpLayhOuOKwd8al6wQx1sOD8DXtSugJnP7WnsCq53uCMDSOPdbkzfJdwNnmc6TbtBt2jlnTx7MevIMOYo+PLZ9krYGdDyaKcsKx086ECy983AO8KbZS7XuNjbW37zrvDkcTw4/UaWHyyuE2BISjFCrl8fAMzAn+X1+xmCRYHgrU6DxdKMFVy79gT9lw==
Received: from PU1PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:803:15::20) by TYUPR04MB6672.apcprd04.prod.outlook.com
 (2603:1096:400:35d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Thu, 21 Mar
 2024 02:13:42 +0000
Received: from HK3PEPF0000021F.apcprd03.prod.outlook.com
 (2603:1096:803:15:cafe::b2) by PU1PR01CA0008.outlook.office365.com
 (2603:1096:803:15::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Thu, 21 Mar 2024 02:13:41 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021F.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server id 15.20.7409.10 via Frontend Transport; Thu, 21 Mar 2024 02:13:41
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
Subject: [PATCH v7 21/22] ARM: dts: aspeed: yosemite4: support NIC eeprom
Date: Thu, 21 Mar 2024 10:12:33 +0800
Message-Id: <20240321021236.1823693-22-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021F:EE_|TYUPR04MB6672:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a7f94e1b-c64f-445c-47ef-08dc494c8764
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5FCCJxuD6rGiky76xUc4vDTpLAB5Jh1z4KAi3OOzqI0Bt5UcHGoDdUq9S9KHPsyDB/p5eWO3T6zGViC2Mhju1qKXg5f/ioqfK4khr+XJafrE9IxpkOrCYmdbodHLjw84PvkfOpICgkdWom8dRrcMkarkNLzECaCxZp1dKt1Ggmq79TkkUN7aPhsWbf6UD5TVJpo5bkQNNrT6DuUH/8+MFzUfrOtGwisn9Mz2gSoft7Xi/FejPwWTFX39W+c7XNMXHqQFEagzNT+9FXxGpm3YqkV2t9VIAHHGl2WJCHk+dOqSp0fDG64YuzhmzF7sFX3o3FXjaM7nmB82Wy8YHnnJx5Jx4kd7ot7bY18etyhn47QAcPsUekKHA5XuEIPETo+NQbzcNafjwD+jW6BAwld7xiZoA4PsbQXIPYRVVV5CaJZ1QjrrdSq6X2NHFbqzzgL1C4oeQRqU6Fluo+yZi/ONYQNdOzUmjFfhkOFAAvTpIOHF4QGV4DW+uK2mbyR0P6GhGh3zvz41G/ojaypooJaLINqmqpgYZigdfT5HtCOM5UdZaDzQdG38+jm+aVxC79O1G//yST0GBY4dSYRh7V0VscOB3nvftAFlAswL7la5hEeDHNoguFkfVCmR56O8V6qTy+VnGvDMijnV2DY1W7Y3RsVIhi4YpEy+8qohu8YY/8knQ4CDs/F9TizYH+5egQIA7H3LHrNkkjARGUVV8RGUSIIHCwaul+nJjkceGkuiee9L/RAFu9dar3C2bE9AsDLG
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 02:13:41.5574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f94e1b-c64f-445c-47ef-08dc494c8764
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021F.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR04MB6672

Add NIC eeprom devicetree config

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index d2ad6c8ea165..c7bba7d68ce1 100644
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


