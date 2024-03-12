Return-Path: <linux-kernel+bounces-99881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2A5878EB9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30FA61C2262F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 06:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DEC6026D;
	Tue, 12 Mar 2024 06:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="i092d4no"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2087.outbound.protection.outlook.com [40.107.215.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445BD5F575;
	Tue, 12 Mar 2024 06:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710224227; cv=fail; b=m+ttaRbGy2/qkfalcnuxQUi6LbJYHVj73bV9D3XrjTQesMQ0p/l7aVTrcVz/8h45wllsBvOjF2M640BGy+L+bCAGUbOB6mS2JLfEMrqikxKlo8PwaHvotKRZUpv/l37/mzGqA6+yyYa6aP5hPovYE2gGxjp3PWiLvfoTdJXGYI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710224227; c=relaxed/simple;
	bh=Z7hIaCfLv9x/l0gWEynRBVcxvuIjQb6UbSJoEZ0R+HU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M9uxldePpRRG2ml2Svxeuqb3aQ72znYbSbNGtzAgw3U6ZvVQkLGg91HIfAQuCKWOsVV4BpJPZXTC9UUbTbf12virfm5vUn69bEiNOVFIQGk2RIvC34KMcP7KpeJAT1a0Y2c66lXc6K/eOjfXibc0FCZqmQm3UKp/nwKcOTJZ22c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=i092d4no; arc=fail smtp.client-ip=40.107.215.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1rCtQIuLz7qmHBXVwwZQZIOa/D6hcnQpJHgvE2hzQDebsimpG2Uo1WcK5Nt7Q3I+Wm9jBXAeTaF5kARSa75nImRXSaWKzyqkPmIip4QyFFx3xZtCUF92r7IPCaJE5wXdogjfJxZgdjvABJWP9oLuKpFqmNaynme7Ff902PMmNMj/GCrtwKaPQZHG872GhmGBwrk6BJcupfhb7y+A+APe+NYZkv5BTyfXoFvEYUFqq/f/EvhCleDIbDuDSHDjQoe/AF/Apklw9AGaJMIOdnojvpcjD0wy4gJ1z2Ll0M0xj182aROfvnSI0DOeHDL3aBcpsay4/1FttSQrvMZoaIavw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4BEb0VNkebzyX9KOOyt4sO2RQFyCihySzIUwiU7dv8c=;
 b=E2fjEs54L6RGs9e1uUTKbGSiOiOBnHWyf5u5BA7Mzw+34gUVclIL7Hl2VCXAmG0k20va+3r+nk+6gY0XqjdJVwDLLOf9PWU/Vdv9HjkVCUCKVMTKLM9+WFSGHqPCQnIRbq57YeIe5PjYuuWU1R3zvpuvlebqznPDGlN3P5bhq2Ycc2yWBlgx/4OUfykLK1w1v5fk/0QwjxmtLmtqozbhkmGbTnUcUKoxLsFqZF98vNDP9o5hrjPAap2kjKzQWIVDhkQ8CIF0VVg65OUBPuUWYkmjc89jNSE9tjG+7IbXgxbnZd7p5ywUhrp05+AHRlSEC+iR0+BCVOqFgPlJkDObhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BEb0VNkebzyX9KOOyt4sO2RQFyCihySzIUwiU7dv8c=;
 b=i092d4nojSAPx+HZ7+/WZ+zmIsrZ2ZLqZKk18ixxIqGM7j122zbCH5iuPrompGty7VApV2GxUL1WHgYSMFVeMp5m0QebFF0SDbgfc6UTDAKiJTO9Ug29e2XMMUA3a3AhMmRCoZBbhb334Yhx4tJl3c2Itm+7fP0zgwjxVtslS9tovjsX9586iaHB0b8MwV6JAZYXPTI8/z7ZwHkHewKL+ttnYcsQWiOJzUnH7F+DGTo2y/B9MgK/ZCdqnaqVD3x+syJb+5R6QVQTN0tsBG2fdRSTyE/3ChPYZu4usBF14qdC2Cjtn47mIK9kEdb+xPcJLUlLjNB8OFXL2oPXLFGzHQ==
Received: from PS1PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:300:75::34) by JH0PR04MB7087.apcprd04.prod.outlook.com
 (2603:1096:990:32::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 06:17:01 +0000
Received: from HK3PEPF00000220.apcprd03.prod.outlook.com
 (2603:1096:300:75:cafe::18) by PS1PR01CA0022.outlook.office365.com
 (2603:1096:300:75::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Tue, 12 Mar 2024 06:17:01 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000220.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server id 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 06:17:01
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
Subject: [PATCH v6 18/22] ARM: dts: aspeed: yosemite4: add mctp config for NIC
Date: Tue, 12 Mar 2024 14:15:50 +0800
Message-Id: <20240312061556.496605-19-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF00000220:EE_|JH0PR04MB7087:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a2985b23-a947-473c-9fe5-08dc425c07c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7hKuFwm9HDvEeyX6HTCaf/IsTgP4k+rSIdTcgnXzjDDmreKJkjnYRBtTiy5GdURMmTK1YxF9/FqBxcQbuhGXqhdsM2GJpDtYLiSfCspi6Ogdt/iEtT5a1G8aAlj19A6P94gEdHf9uIlcIO5qsMZtUwG3JIy41rcBwZgbr36+nYhe1wJU9f3e6g4CZxyZ3g3XprFvZo9LtweHhShIsEGDIn/lbaXuRk7Qkw2LN0F4PHANUndQJDMVXkggiqWCk2agx0y+pRUyfVg8iX7TvNbRSpoIo6B97t2uWvIjTajTZMqx3OR/l9GDpBCFi95WC5gCFtwKdpcXNNWJKocLckVhyqcGnSdBXu0kLJ5FUauxxVPSNBp6dpGrOiNfOfXXybKNR1xq4PrOo/HHHxAkP2xw0AhZeJV9dxYCnVks5CtmiCq6AmHU/DpumEeyz8KebdXoVEM66hQHHGTqpAMim4jleD8ZxyVNeWDf6bN3SFdjzCfKqX1nY7q/Eu/n8Cwt200kWXmpMAAwtpYcm62LTqo+rFZkzpoG1KsUYPt3u6kTLBtnHB4O8Fc97hd2GVAKvtsLcpsaGm8TApdhF5zvI+MVRxCps/v1S65eAfeGOVIFzFiDVnTH2+xjfGS2ADumuOXTLKyGRYE4KkMAan2B9PFopDfwuM4erAY87tOAxCbiIt3N8rouuN2vAwezDrQc3VwU2zGK33BAnOxuSSx11UFKLS12uFcL+qMmACzFNcDhnuZZCBlGjO40Xh/QQ7Hy12qV
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 06:17:01.2134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2985b23-a947-473c-9fe5-08dc425c07c1
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000220.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB7087

add mctp config for NIC

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
Changelog:
  - v4
    - Revise device node name
  - v2
    - Add patch for NIC mctp config
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index ba7db2693277..06f22562b381 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1273,40 +1273,64 @@ imux24: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+			mctp-controller;
 			temperature-sensor@1f {
 				compatible = "ti,tmp421";
 				reg = <0x1f>;
 			};
+
+			temperature-sensor@3c {
+				compatible = "smsc,emc1403";
+				reg = <0x3c>;
+			};
 		};
 
 		imux25: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
+			mctp-controller;
 			temperature-sensor@1f {
 				compatible = "ti,tmp421";
 				reg = <0x1f>;
 			};
+
+			temperature-sensor@3c {
+				compatible = "smsc,emc1403";
+				reg = <0x3c>;
+			};
 		};
 
 		imux26: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
+			mctp-controller;
 			temperature-sensor@1f {
 				compatible = "ti,tmp421";
 				reg = <0x1f>;
 			};
+
+			temperature-sensor@3c {
+				compatible = "smsc,emc1403";
+				reg = <0x3c>;
+			};
 		};
 
 		imux27: i2c@3 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <3>;
+			mctp-controller;
 			temperature-sensor@1f {
 				compatible = "ti,tmp421";
 				reg = <0x1f>;
 			};
+
+			temperature-sensor@3c {
+				compatible = "smsc,emc1403";
+				reg = <0x3c>;
+			};
 		};
 	};
 };
-- 
2.25.1


