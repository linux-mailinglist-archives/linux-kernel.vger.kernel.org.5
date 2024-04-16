Return-Path: <linux-kernel+bounces-147116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A67F8A6FA8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D6871C20915
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5132E135A67;
	Tue, 16 Apr 2024 15:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PWJP5Dvj"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2080.outbound.protection.outlook.com [40.107.6.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F681353F5;
	Tue, 16 Apr 2024 15:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280777; cv=fail; b=FoVEVBEbhLGtNdIMTPolaAJBg9IGiamVM+DUeQOPK5h/VyuRRE9zS8IomPBMxABIXTsEQ6ULKB6KT48t8klGl/8O3dDEJjaSyU2lUA2C/J+fpI9dJWbAAE8MEaKlPJRz6YFQgEBUjpUOJKEHLbPuOSCvJ2YwXvp0eOXXmBqXigQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280777; c=relaxed/simple;
	bh=zrNJwRWKudONbk7rDjH/jDpbC8QXJK75zL6EcM9EWPY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=MFkvde5r0mv9+y3hS9DUx6dizJw0oQIqgDEMZ3MwvQJzgH1agwU5fkdg3ikWqjvB/MAwk+Sz+IR8bb0ahAbsGKQtsAZ3fGA5BjI/hk1mJA3W2QCBEddiAyP3lUQatsgkJEPpPXX/pQufXmlHf7ODfCP0B/GmsD9VuP7GqcmSLiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=PWJP5Dvj; arc=fail smtp.client-ip=40.107.6.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGHLlDRQIVbfjwalk48A0shTkUY0nxEoGbSBdSdUMa4PjTcdyNKWAfGDh+ZF3Muxp6pkFm0e1dU86tmC1QEiwWfC5iOtGe+kRMi/AR/ZVQd5WTYK7QG7n42TkeD4A3oEEw6XemDa7XnU0C3HAFCKOENK5AMCXiGbVmVgGjeeUBoUUuag5rF1uByccFI9RBCvY+nso5ydp9saMxqXHMtHwOdFuJ4ekTzzBuVn+q0byuDVGIMbcGCXXgZuouYsoyo/UTSAI9j5nXK97KIhEsosHj8XOZ5WmbbSaePwaPtYeg+DNSI7U+OQg5g6SAh8tFKZoxx2pcmvhKpeMy80lSLPDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IT32LSHMcIuQzL0CIpSXsBuJt+5bRTSEl6OAOqsLuRk=;
 b=hDWbYo2s3l6lGtDcSa3eHggBzQ0aOHpOfFLB6Z01cP1Qy5dXF/U3NjtbDzArAxfoPPAKKyH4B/4ayr3OizTsE8+PAVdYo/zQebQusb7RSrU8Q71AVAFrhy7Evwls69KyhC4eLckilMWRWjB6hbtVKuvQjvs4HDMpsW+jcNQIO7wUUl7rLx7YdXZrvBdei0ye7u34lBGFx+gQWCnsPwnXDHv35DyB+hD9tn+oBFZ23gkj01FJYWR2xrJXTzxvTF5QAgNaMHFKLRlWs7hv17QHvRiTYx0Zl43Xbyn4d8MyptkRNr3T5zSYdnc9PSW0vNOCzLnrhVTfCwYr5gCb20BU4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IT32LSHMcIuQzL0CIpSXsBuJt+5bRTSEl6OAOqsLuRk=;
 b=PWJP5Dvj/VRjZYHfR38X7IQRNmeOOEgfuC0zVMB4a6G6gpN2ZWuE/1x4ze++qML+oF49jK7k/CdqALqo7aRhSkl0Fe4EeJ1lMJbpTMlL0gOm12nQpNiqhoy9gJTdw7rXmsYccJWJ5/b6PKKs0goDhlp7IukVITzbbgSoaiZtNEI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB9194.eurprd04.prod.outlook.com (2603:10a6:10:2f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 15:19:32 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 15:19:32 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 16 Apr 2024 23:26:46 +0800
Subject: [PATCH 10/11] arm64: dts: imx93-11x11-evk: add reset gpios for
 ethernet PHYs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-imx93-dts-4-13-v1-10-da8ac02e8413@nxp.com>
References: <20240416-imx93-dts-4-13-v1-0-da8ac02e8413@nxp.com>
In-Reply-To: <20240416-imx93-dts-4-13-v1-0-da8ac02e8413@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>, Wei Fang <wei.fang@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713281224; l=1135;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=zt/COlkMbz43z8ZmWUtFhg4O3YRr9hO66cApIQ48y4I=;
 b=mdy0uimYpYMItC/CNeZyXk/UeNVPMONEBj8AiQ0nJjtDHdW9hm8piXxTOOHblXVij/G09Jfvv
 19BhKwLANOdCzJpQCzfd8dOxD9R/r+Qk8E5KvNB2SKO1X+VqnRNmQsa
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB9194:EE_
X-MS-Office365-Filtering-Correlation-Id: 5287b02c-6ce4-4feb-8dc9-08dc5e289e2b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	D/+djYZA+uOcYoVgw5IOy7DXPc9rzIsbPq4Ot+OU7KXJNzVBHxXnQGQBpf5lndOGwu/yyNV4xME5hBMVxdl3vzZPKvzfdT9I3rzCxKfvJHFqiZMnYrtUlnGtkxVnCdhMHLN7sfiH/DMFGEFaY+RVeyl/b5q5v+memJOtLIoBzL/tZhYlvBEUKPeqro4C5VdaIoqEgynWPvKyVMOX/UomlyGLxeIlwI0FFURPTU7KZQJAegVF51tQhOIJE5FxNrrXTHyW0RXIFzAinyqhNzzGQRfsos1QP0J+FwaNULEb000UWTf7maBLhk7u8IpDt1CqxZx5EbFkfJrHU+NEDlMn0oTZtCsB+8GcGfCTeJg3muKAhZsuodcw6OeM8YqAhPIkdJhuDdgN7jDwzJ2oeJsfWnTY4Y3HSLEeCyE5shvakP14+f3xwXElmiAvHGbTQIUAOP6iJOU4C+OXaDBsPRd9mlx9xL08axdxmPO/MPR2fAKpEofH45LGsHGN+e/4zC/mAtppKw2mSmX4J/qNT9EyL029ie1V2Gh6WzFaQ/GFUNfLSWj39xVYzuNbq7WU490aMo8AU9wFw1SznfwZhr5gFfXIhpurLxfOG8/kjsogSkD8LMJuPI4oD4KyA4JSbEIxSeh5mB/dCPEnFA1Zt4qopI0Qejrb9v4BAl9ymcQyjhZKNidv3B3dfxVeUj0+j1BGNi2E/tZKyqHU8YW9Okb/wli+RsZ9rlgUk4pI/R5XsqM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlRSanJuOGdlQnNVSFBQdXZrdS9rb1hXcXd6cnlTQWo1TkZwTk1IYUM5Y3hD?=
 =?utf-8?B?RU5BazI2KzcyL3RvRDlZSEFxTFBSSy93RXAzaTN2VnB5T2g4aDFCMC9vaXNF?=
 =?utf-8?B?NjY5YytZT3Y1YmNNN3hrVlB6ZXVFQ2F2UGZneXFSckNoZDRFVnhDWDE4ZDBt?=
 =?utf-8?B?cUNudHhPYXJUOTBnM2UxU2JoZnJBcDNDLzMvbTkvd1lOWEdmWW9iTEpWZVNR?=
 =?utf-8?B?SXhFajdDYVY0THh2MllYMkJ1SDZPdHkzSUZzbG4xaDZ1NWhZaDlHb1UreDgz?=
 =?utf-8?B?OVRHTzBOWnB2eTU2eDhqMS9aV25XaGg5L1F1SmJ0cjV3cTdUV2tKMEMyUTNL?=
 =?utf-8?B?NFB4NGpDN1NIeFpERE1NNmoyUGNKVnZ3T0NtN1EwY1hRUHIrT1lja2FxVUJ5?=
 =?utf-8?B?czBoeW1jT05pVWlzby9CUlRrV290RzJ6K09KR3FwRXBsQ0ZpaGZWSE5GWUNI?=
 =?utf-8?B?am4xcTN0WjEyTzVyUFdhd1hqYk5jWVRGcDhkZ1ZhaFBIdnRmOUhmYmhSQXg5?=
 =?utf-8?B?d2FDaFh0clJqTTFTMndzaExwUXJicUgxSWwzWmxaZjN0TEhZUGh0UXVpc2xL?=
 =?utf-8?B?SkRRUWtsL3ZEa2hjeHArWGJ3MW5hdGo0Z3RaTHBSaWhybC8zZ2RBR2wxYTVo?=
 =?utf-8?B?TFVaZWpiOUt6TzJseXowM0FPT1g0TmFPemlsTW94TWN0ci9EdS9SRm1ISW9k?=
 =?utf-8?B?L3Jza3lIZHd2TmozSFBMNExxOVlIZzVSbFdBME5wV0t3NzIvc216b2E0T0lJ?=
 =?utf-8?B?cGx4QXZKZmszN3kzM2VMZmVQS0FXZ2hOMlZLYkpkSC9tTmY5S04xOEkxaWRQ?=
 =?utf-8?B?QzFXQ2FpMlhGeFg3WHk3Wlhscm55NTNpRjFBMjg4cDYvZGt1QU4zS1RQSmVp?=
 =?utf-8?B?bW04NTYzUk5URXdDZmZtb2ZoaHNVR1l4bWJsRUk4VlFyOEJyWTJMRFVPM2tG?=
 =?utf-8?B?cWFFSk9sSG40T3ZFUi9Ga1RndGdJQk1JV2pqMUhKUHhMQW1QRW5LMHJvUVpW?=
 =?utf-8?B?MzVPeUtZSldNVTgxS1NQS05rUG1aQ2lqdDdncWpKaTFwTE45R3B5R1B4cXdG?=
 =?utf-8?B?aHllMHJod2taaExWOEhpc3ViU3ZpY2h1UmVZZENDekNXMGpRV1FVaTFRV0pr?=
 =?utf-8?B?YkxWVUUrZHN3Y25LZENGQjBXcmlXbndSeHVmUGl1bVFPUFI1eU5CQ1FTN2hV?=
 =?utf-8?B?ZHlvalcrQnNYa3BjOXRTdlpXSThIM1BuVUphSXpXZHVxMzJMY25HaHg0aGpt?=
 =?utf-8?B?YzdtbEFQVmxJRVZhYW5sVGlHWVp0aE5zaW5LQVkvNCtoVExBbDNtdVF0NHJv?=
 =?utf-8?B?R2J6SHhVcUU3bkF2bUhlYkJXdW9VdDNXcGhaaXVYaVBEZW52UTRHWW5NUDhH?=
 =?utf-8?B?eno3NHdqS0dBNUVQVEUrZ2NZd3J0blg5OExSOXZqaTVUMm80Z09tKy9Lb1px?=
 =?utf-8?B?dzRFbTNsMVhOeUdmb0YzZUp6Z045NmlIdm03K1FzWktMTlBDWXB5TnVPK24y?=
 =?utf-8?B?QjB3ZndRSGFEUlZnVmI0WUJYd1MrcmxQcFErd1BxaEM1R3I3TU9OZVdEWXVD?=
 =?utf-8?B?OE5LSU5DSkN6Si8yaXBNanZrTXAxS251cUd4Y3l5NGltb1lCM0RLbnVNeFRt?=
 =?utf-8?B?bk5JTHZBUmUwRnprZGVoR09ualE4VjlXZW9oQjJiUzVuemF2WWZsaEh0SURK?=
 =?utf-8?B?TG9vbDY4RU9uRGdXSFpKUHlyM3hvSXdGMGsyRzcyWDgrRVd2L2JmaUhkM2cy?=
 =?utf-8?B?SjlkcGhVS01EdFBacmtjbzJwTlB2ZXAxUk1XWUJYMmRpOFc2Zk85RWl5WS8y?=
 =?utf-8?B?cjMzV2czT2FLUCtNZTREd283LzhRZVBoOGJzNVFkYVJtWkFZN1JCNi9PVEZy?=
 =?utf-8?B?WHZpQmMwZTBwQ2V5cUpsZkNqeGhqb0J2a0pnMElyVExJc2dHOHU5dGNCOE1U?=
 =?utf-8?B?OUVXQ0tEMDZhNktNRDRscWRqTGhXalcwbDVpUlhuaitXNzRuT2JWT294SUZr?=
 =?utf-8?B?T3ZTUmdjaHJST09tTTgwMkszcmdNTkhIcWpOd2JISFlhM3lQYzFVZmlrcHRY?=
 =?utf-8?B?QnQ2SVBvV3dvektVZVFtNGNNVWpOclRsOS9YN0R2R3ZteWZ2TndJc3Q5QnJv?=
 =?utf-8?Q?14oBu32Dal6ZiRqibbGZgmCab?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5287b02c-6ce4-4feb-8dc9-08dc5e289e2b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 15:19:32.6260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VLVPGY+UbZuBUr1y2w/GgiefZjwx2w3GtUZCvkdEztrB4BnzMdw2eqGxy0KE/5pBJSFJNdjCbE2j7sFJTgwdUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9194

From: Wei Fang <wei.fang@nxp.com>

Both the PHYs of the EQOS interface and the FEC interface are supported
to be reset by I2C GPIO Expender. So add the support to reset PHYs.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index b29d470d2492..44ae985945ad 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -121,6 +121,9 @@ mdio {
 		ethphy1: ethernet-phy@1 {
 			reg = <1>;
 			eee-broken-1000t;
+			reset-gpios = <&pcal6524 15 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
+			reset-deassert-us = <80000>;
 		};
 	};
 };
@@ -142,6 +145,9 @@ mdio {
 		ethphy2: ethernet-phy@2 {
 			reg = <2>;
 			eee-broken-1000t;
+			reset-gpios = <&pcal6524 16 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
+			reset-deassert-us = <80000>;
 		};
 	};
 };

-- 
2.37.1


