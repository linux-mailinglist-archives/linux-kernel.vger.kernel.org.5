Return-Path: <linux-kernel+bounces-20468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B22827F68
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEF821F26996
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10A437144;
	Tue,  9 Jan 2024 07:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="QnG1bbWR"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2046.outbound.protection.outlook.com [40.107.215.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49658374C1;
	Tue,  9 Jan 2024 07:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CeTRDI6mR4pv8HHwpt+H8ANBH74nS9uKbQRWJFlNLGbGXgCOQgIqfnc6wCAf+JnlTXo2Ztnqd7ZPQ3hzah+Uj8NhckvlEQK/CrG9Vc5wz1LJEkJjO9fwOqN/wrZLoUzTg459L1VfYTzwvA5JflZr1K+xMO0WYixiDQteveqo+OB98Rdk6lZwmV5peCBY5CCCrVHsdj/lRXMJB0ngOYfzSwLTuTAPD9V4BrDjkfgfIGY+AblWCS77BfyLLZgpVAL4mUzNDwCEftYRxtX2k4dXKB4P4nDOBfIOHgr+KxlPSTJQrAzIMnP3MDDDfwXg/S75C1sR6WDwrOj63f2JHZTZxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/XQg6kpljPfLQXpbCmupwZO3URw+vKzREh2KKtjR28=;
 b=X59jYvmlvx1oPHNgA68DdcnjpN3NzGee91QvYP3ivmlpj0MLLnfSRVKAxg+AH5lWzaKpkb7bjB2xUgumFvvZnSqD4MrZR5bxRvjxefU4PsK/WTJgvAq805u1AjR+GTk4j+iEnsrzubBkYZN9LMlgvmbkXKcz1ZQ0rfieuuOymwQSSTHQ2ovNsRvQtC5UI3VwC0kyyZXHxkS9Qb8AO+JNnlsE2skX/PjhnhbBwcXUSydP5yW2DynKO2AmopH7n5tg3lpaAzk6aM+N4se0EC4Z2wKJRq6cdvluh18w9aIk+nB61qESnRxGqTrZ3oE4Xp8RKWUQCxGfFpWGdhdXepu81w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/XQg6kpljPfLQXpbCmupwZO3URw+vKzREh2KKtjR28=;
 b=QnG1bbWR45Lk4qhIguRsoca1nBJCM04+MBRaE2Dg5BtzKd57KHCuoNuhE2V9Sh0eaxQnJqVcutwmHLPRy8sqr7nLNq0QBMVLNQ8yHTne3JaGupbs0JxDRfKUHYejkW48vXCTX4WBofl845j5T7x3ZHpdvy2GSdBd2Icm8psbjD5thdEGVjc2W/UT8uK2CVUnRgQWwX8q21JhBqUy3jB8D5u+vSnvAdjF17CvrmZqvf47Xw5bmnbcEQJpTBC8+RCKbgz7FfbybHvy9jtKlDhZdFBFh2ZZlYhXhIJrkwqlvfO61f9ey0uXH9sqpLwc72PixYO+D0P48odIH3831pjpgw==
Received: from PUZP153CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096:301:c2::7) by
 TYZPR04MB5902.apcprd04.prod.outlook.com (2603:1096:400:1f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 07:21:44 +0000
Received: from HK3PEPF0000021E.apcprd03.prod.outlook.com
 (2603:1096:301:c2:cafe::ed) by PUZP153CA0011.outlook.office365.com
 (2603:1096:301:c2::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.7 via Frontend
 Transport; Tue, 9 Jan 2024 07:21:44 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021E.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server id 15.20.7181.13 via Frontend Transport; Tue, 9 Jan 2024 07:21:43
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
Subject: [PATCH v4 18/19] ARM: dts: aspeed: yosemite4: add mctp config for NIC
Date: Tue,  9 Jan 2024 15:20:50 +0800
Message-Id: <20240109072053.3980855-19-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021E:EE_|TYZPR04MB5902:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8f2dbbaf-89c9-4e20-8685-08dc10e3a1f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xSi/5h2Z+vysVR3cNewWLKKDPrbvhgoK77GBP0dSUuULOjwe05BGX1m6lB0880fPcdyOXgvFJQGlrT3tcOoA1Yc70oaBGBp7uULGL3MY/z5uZFYxNqwq3SgE8QtU4Vnb90p5ZZomALLwODEqgGyPAZEG+ni66fo8Ykr5YKzW8mI5Y+rCYLa/YeSbsHv1L1p42lUqjmWqCaeaeR8cmjyQ/z5FbfrDq1UED0VFQ1sJIRfD07po46dvf5gQcg87RWrdhKqSe0UImIEihlCUFTBUSDpb9iQideZwo1DBFk2Q0DVhL7TskjOiHcYlIY8PWIg59b0oY4rF1KsMtc9hWKrZn1H0tIbHZ8hjb425a6x+5denbcIMcBCCwksezRH2H/EVJsWZtT3FP2tC9b4wOEt1dYjLDb3rttCBo6cvIWj522eNNTNTbRAyE1GHtNw4hmOgD3wVn0HqK03Qa0agiTCdqPJjBBykHGNnh8AR1gBh7+4YMBHCK/4WCtfRJN7AsOSqjVuui+6/s4qYlpnkbb15NTIbEgZH8Y5bhzwj7sY09PYM1m/K8f5q+xWS37EN9hP8x9lzRDfRUZDL4ygpriyX9+N+w1iPu6aH/z17qZcg4d6CMDtrDlKAzk7IyEpAKF8UmBSSoDG7rU5Y3LVyCMY3cQHn0FDqm0uRk+O+6AZPTEV1eAX1lbsCEv4tCkD2Guv24aCGR9kyfWrC9LtNe7movA==
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(376002)(396003)(136003)(39850400004)(346002)(230922051799003)(451199024)(64100799003)(1800799012)(82310400011)(186009)(36840700001)(46966006)(82740400003)(356005)(36736006)(9316004)(8936002)(81166007)(70206006)(110136005)(8676002)(70586007)(6486002)(316002)(7416002)(41300700001)(86362001)(2906002)(36756003)(5660300002)(4326008)(47076005)(40480700001)(26005)(956004)(2616005)(1076003)(6512007)(6506007)(336012)(36860700001)(6666004)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 07:21:43.8514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2dbbaf-89c9-4e20-8685-08dc10e3a1f4
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021E.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB5902

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
index ea36d61423a6..8589f7d31ffb 100644
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


