Return-Path: <linux-kernel+bounces-81433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C39B88675EA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25F76B2EDF8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F2883CC4;
	Mon, 26 Feb 2024 13:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PrO5fav1"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2082.outbound.protection.outlook.com [40.107.6.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6418061F;
	Mon, 26 Feb 2024 13:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708952423; cv=fail; b=WkIIIL8EVgDQStFvt+YO6UEZFr4N9vwpnb7kn+mc3iVbvj/45v5i7cPhoZqyflQeM0g4WGZmF8xQLgyqspvvFaQDaI6FnbUGAAQpjFop2WSxxWm+UoO+X+O4/rf2UQ7DyRZKMsWS3HZhCJUh6zeDV/wtexb0PzIjCrQAeLKVm3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708952423; c=relaxed/simple;
	bh=d/qhgfKEnOukIAAk1Rdl7eDSR7fFWMb20BNgyMFdx2s=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rS8v9OtFlA2NiHFwM9iy5VZrBWnTu2b8AK4NAuvWT2cC/VVkwa5bSf2GKgfJBmuyoHWsqTpetTsN65bz643ftM1hIeipw2eNWNo36LCpOHWqDGO6AcK+PmfwLLLBu6wYMoqdEaRXvierrbhWJo+1JESroWKLGnR5F85Az2VJ2fU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=PrO5fav1; arc=fail smtp.client-ip=40.107.6.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AeEc9Qz+JXda4bFySS4Xm98QD+ed6m93qyUYGLJ0RFodjopPt5kO9isjzs1MJIJ6Sylhw+H/kWxQC1Eqopti0v06x6rA64wV10LlMPHgHHpP9hXviCB/VrC+Lzk9JYi5MaswooOdhqCt5GrkqEXQzjBvuvZuilcCQrAz17pg+wZ0JjmPXB8OR5eAg1jX0tugONxU5DbBAO8/8qkdGEWQv12X7nYV8vnYLJCuMiRZFhI7zD9FTk+3LonoY5ZISKm5AYfmWF2G/8VY8oSEI5IMu4diOPc0nj4VMz+hwBr2jlVzhZ2+fGH3MXJnZVJ8l50taAclr+MUUWW8U8N51ahVOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMtaqPl5NE0nJJiK50KKnQdEJ9v5gg67WpsV3q+IP/k=;
 b=nkww9B293BR0qUcw0npIDDonOeBTX8dn38bNuJ0ix6BNtCQHUqgsiuOPKLKSgfMTGgvXgPhRhrjdOJ/R0K7+LcfCsYzPH1kBamx4m6OrZeY4HIiRcKDPeQmim4Ze9Zriv2+o0QVml77zboc/IllA9QeF6gvTcEjGXH6X9Grc7U5EnITikzh/s8iu4YSfrDDXzOzxpvBa1aPTIHNaTY7exWPaluSh185uKH4sHf5FKxCtv3D6y+ykyF8hwTTMocxetMuMQlmV9Zs7bxta2ypa45QLAXBdkhMCJuY8NJwWRCU/j5pvhyT4fsaTi5GISZf1eCouM1Xpvnpm9sVbjplUgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMtaqPl5NE0nJJiK50KKnQdEJ9v5gg67WpsV3q+IP/k=;
 b=PrO5fav1ezIEomm0jXwE5+qXvBwCnuHg/IeSxQgb2MYNrnIx4rEOmatRXHOM5QizH/9GvXNSm43Wwu2OvkSWf9XxrvHtpHh+emII8FsGIxV7lP8i26cUt6SJ8QUjxqp2df785n7As4SayoD+/XkLhGqfcC5HDaSqE4++AMjZSNQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6865.eurprd04.prod.outlook.com (2603:10a6:208:181::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 13:00:18 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd%4]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 13:00:17 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: haibo.chen@nxp.com,
	jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de
Cc: festevam@gmail.com,
	linux-imx@nxp.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] dt-bindings: iio: adc: imx93: drop the 4th interrupt
Date: Mon, 26 Feb 2024 21:08:25 +0800
Message-Id: <20240226130826.3824251-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0113.apcprd03.prod.outlook.com
 (2603:1096:4:91::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM0PR04MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: 95ad121d-1f0f-449b-b0a1-08dc36cae19e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dXZf/BnE/SWMCSdTBjj/pXnW/kjvm7aMsQ6Ipukv2bHc+yzTjzKFldb1rnEFseuBAOVNiX8/yhtQ1xkG01r8IbTVpeX/IS0Um48SnO7s8g3PXLwcxTbjt7zjYNk0JoxWlIPE/OIrcqLtNH92kuwSrzlZiNF5H0TM7vsgPA9Oh2Gd627bugLbvKHpq3yi8kGFk9SSV6RLCVuu/6w3Iwi6aMPVu7ByLL8pi1NCKtGDalAQsphVFBJuroteCG+NeC+l4cklgVD1+iSUlWMRNU4nFSziRfON+6pNtoLLHojslZrQA1P4uQKmBW5Ef5w2fnxdTjI/DkvV1xqDxXu46YvF5nQY5HKG/5w95yfOHYVbqxNa0k67Q1WzT6Zi9cVu2I/nPjSmHtoJkHSs7nrPvDlgoT4M5C6BfWdZGXQGK2UmYWGpxC1llYzL6K1F2AD+USotF4ARKzi6cfYJpyAZIFjDyO8Dz2EHBBhYqbowC+otwVJzuqcniJTM78ZLBdBtnGNnO2RLhrApwI0stgrd9kLVamAFk6NhsgLqdnLEfMTCtgEZuD6MIe25s9DI+Rwq7LcEVDuXNgE4/TMWA5+/w7Dk1vf3Cz7oIVePD6QVjgUHtKDEQBWSxdI+GUY+UMF7M70+56BHS17a4XWsO6+uIaS+lkCIXavZ2qjn188898PWzC/RNSy0J/0AbY7tWgXuZ9dOw1zQum1rjM+fZ8gXLz5EIFwm+e0eA/PI5bqOFBiPhho=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9ajrw+lRcgBzDuh2NJ2LMD0tBroSpR+unrTfL7itkA+3TorkT0hClXYRAC/k?=
 =?us-ascii?Q?8UasCvQemnkRjJ2/xTK6INuLbZILmjtc0okc7VUV/+L2nSXEh+QTi868AN8H?=
 =?us-ascii?Q?swNwrH87/SJFTtDa33ejwRHAvNbvCq9UrQ4MWXiPmjxnB1EzqXSbNmMhhYjb?=
 =?us-ascii?Q?lZ0Cewr77Cia0CRufmrvpdo4IDvGCFWZbwH76h/Vmj3buopmHSxTejXUoWXv?=
 =?us-ascii?Q?dZm2sA35QqLKmuWUnnQ5k6i9RxSxX3QgvUoYa5oKx3324t3tBnGAdGEv5UTS?=
 =?us-ascii?Q?KMrO7EweAIoj0r567DpgsD/0teZKo5jtYLn2PawyKl9LOxY6yaotfv6CBzBu?=
 =?us-ascii?Q?HjuJR9M0Xach+5F/rxz0/NKbSjnNtZ2l8Fed7PI/B8mn+Osoh3BUplqU/3We?=
 =?us-ascii?Q?K5PUv+UUrQHzwtmxqlTy0L/fQqM5vhonENBQc2nY8ypAjw55NbGIeYbsFcgj?=
 =?us-ascii?Q?N86S/y4ldZqeUmlXIKvbEygmtykDtANZ0aF/803d5Lj0Mppx6v1eUCBttoBq?=
 =?us-ascii?Q?F6oqy3HHpgXPbN0IcHOgAOd4AmNZVmW9BHlf9oTPAE1uidMLBRhxQ7g1ngvb?=
 =?us-ascii?Q?5ae4rWsgY9Qpbp2NVVfIZvCOD0KdIpQmF8JJeF7r0bCAzZ4LzwtpU420dU/V?=
 =?us-ascii?Q?qdTEKR/VrOP/8iG17y7LzRx4tSCynqrwxMq9E8hRxuTTHuxSJPgkeSRLhoOv?=
 =?us-ascii?Q?+Os9ooJAybzedCuaTi00RxgB8qSIqBXtEcn4InBDkbCwkt6oL46vdxM4rc1Q?=
 =?us-ascii?Q?0a/3I2Ey0lRJXmC4ssbWGDSJh96zBwH7o8ymxaWHWGsfVCm6tfqqVuZXUbY2?=
 =?us-ascii?Q?W8IQJqYSU0/ML7bHOBzPU6hgov79UvQFq47APKVKuVTVpQt49pgAcjQq/hj9?=
 =?us-ascii?Q?3QwDz7GdnSNw5aSS0ZGQJ9C8kPSG//mNRl1b3Neb6myrl8WNg1u4BGgz0FMZ?=
 =?us-ascii?Q?57jU1V6eROl0+eFkdgruQYM8IW4JEsUU7akm1OqwNMpqQUfZkdmthb5w8Jy6?=
 =?us-ascii?Q?tPs7ENzLthhxz7ALvoU1/Avax/fAdxQuQB+N+FTPLOlm2ctrTtRfY16+qt4b?=
 =?us-ascii?Q?S35Hk8oKB/ld9W/ZprFjdJLJnLbXuRM3g+AGSVb/k2R8nqd26vKumdIpqRhX?=
 =?us-ascii?Q?ho038kdsdR6Vdrx/Fj8zPXPt7rldwsrrk+Cwwx93kvTTqiuGPx4zacCmxIjv?=
 =?us-ascii?Q?3DAuAFlLB7OwlTiRrbYcMIrjRK6BezroOlvdVv3FXHwPUY1TAh1k9Vk1wqIz?=
 =?us-ascii?Q?1LCS+ZO4drFJbfrqGLLsZy40SBLEeyJSgsLZZGGSDuONOb76oyZVYOpyg+hb?=
 =?us-ascii?Q?uSFb/DwCXaLh3kcuHXVCr1hS882oXGfaOffNZDr4pSHAEKKnrFrZH7NbqJe4?=
 =?us-ascii?Q?MObcd2bWqBzUuC2iup8Iwd93/WyBNHFfPLALHz3WGHvrliGNWq5udxFVnNoU?=
 =?us-ascii?Q?vvzMOmyTscJDOk1YiFslkv3bYK6RrIsfM5RxpbV1BA2QEVtDOwAADIQ6HHcw?=
 =?us-ascii?Q?9PN/vJAKFw9U20b2jmRvcW7dktzWfzcKFoo0jQvEU+aUk/kxk5lzkO9RCN6H?=
 =?us-ascii?Q?bzRX7rap5MrFG/CgRvVxvW17xQxUgFPPGbfE87Zi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ad121d-1f0f-449b-b0a1-08dc36cae19e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 13:00:17.8576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TVtK3FItH5qwBPazjIz3yYIGbUNbE27MAPokOQ4XVSVd1wXStyZMkocrFZgrzbxMvuQdI83koWdg/ZP975EQXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6865

From: Peng Fan <peng.fan@nxp.com>

Per i.MX93 Reference Mannual Rev.4, 12/2013, there is no interrupt 268,
so drop it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
index dacc526dc695..dfc3f512918f 100644
--- a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
@@ -31,7 +31,6 @@ properties:
       - description: normal conversion, include EOC (End of Conversion),
           ECH (End of Chain), JEOC (End of Injected Conversion) and
           JECH (End of injected Chain).
-      - description: Self-testing Interrupts.
 
   clocks:
     maxItems: 1
@@ -70,8 +69,7 @@ examples:
             reg = <0x44530000 0x10000>;
             interrupts = <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
+                         <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>;
             clocks = <&clk IMX93_CLK_ADC1_GATE>;
             clock-names = "ipg";
             vref-supply = <&reg_vref_1v8>;
-- 
2.37.1


