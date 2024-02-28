Return-Path: <linux-kernel+bounces-84649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BD386A97C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 256FC282BB7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B4D286AC;
	Wed, 28 Feb 2024 08:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="A8IHZZyJ"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149F725579;
	Wed, 28 Feb 2024 08:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709107555; cv=fail; b=s8hFro3EriQGlA6tW5xkUaWm2TmsvsypPFyj8n6V0gxHJs7w4q8BMUpPFt2I0xCrYsFBLG1IKvUPFCCP82QAmAqwuSl0cVvhYl9yWTUZE5bDNbNQJYOt29vB6R35edQvb0PZ/JInCHesQabScyjPGeHq3+53+hBicxpZaPmFjVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709107555; c=relaxed/simple;
	bh=/o/lGq/0e0uOrgG3hv1/0rL3zP+7S4nChSla3N8WPKg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=udkfsNBvWCSDhpR5yb1nISfUwsBjA+7FNB0IuxLqMehEz/d3GvVb1wVcVvEWngajuSsWwMErL6ACLkiX0VaYfSLhqmkwCWqS8GucL7IppXsvUXmafBPrVouRQhQ76Yi8HLqKinbTemWQgxZ/i8f0q5KANO3cp4tncFVsrIuZh9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=A8IHZZyJ; arc=fail smtp.client-ip=40.107.22.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cok3V6/GdTNupLHlHC5zEj8CZc9q1nUuc6U4vPq4k2i8+4AQZlzZjgEy1NwhrsqCOmR66wIt1YjrSJts0ifzXxlPp+bSprahUdcZVz0H8BwRWvQ5r4hTqItCDU2w8rpgNEvbt+LN4GRx4hIDrJhAbdG6hhicX4LtAYCqBRSEFbG12JodjpH/9G3g3uY9jlDFPb7w9NoEfVOwmiGTlebzxJY03SW824vcz+BWk+S/Z+GDfLuI36dHMvAQ3XWbDK91m1NrvBSTq3G5Hg/VUiiqR5Y/5fJ4D90hv8E9cWLRoTGY8XpPD/vskYgdChn+89A9Hc01vtSf2+p17gCmBR3SAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smbhCM6dJo9/JfL09XP2lIsB2ozJYMzrllG3ik2rgRE=;
 b=hS2pocJGXdgd32CZ9SVOvtjBJKwluhQ21tkxy5MEzIFhljHQxxidwqfkd0mgz7Mz48d61gaELjQ/HebAiHdqz9I5z7mfhj4Bo7ybgDin1N5c4tBj/GvG6zEfOP1lrhTEGufmTwftMt7t7ClBG29Ey1GIlygmtWtASf0tT2nSYELIK5vIv6sPpiLpshLKuhgqLZkXtiU/8rYnTuTafu6hY56G/h+b+4BTbZEp5VWlVX5TC/KepCqUQxj7DVvy6KBUVk736+dExC/9kX6HkwP9Zq0NY3TzGyNUB+sHrYRI7KOdOGkBX/mtzBVG2ncTKSQPXVHlZEPZVOEGFXFj047fZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smbhCM6dJo9/JfL09XP2lIsB2ozJYMzrllG3ik2rgRE=;
 b=A8IHZZyJZZgJdhVEAN1eJmszGmfXkAehYfQaK7nY3HpKGOeh1DajahbFK78own/e4PRiCZumJM8s6Y6masQJTIGtr9NrWNKEo0sw4wFg17WpgA4oJz1scr0IhacuqKEcIUJ4mOdg+9LNIR5NOrVfD4OPWcAllUsKTgjkW1KGcLM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB9858.eurprd04.prod.outlook.com (2603:10a6:800:1d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 08:05:48 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd%4]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 08:05:48 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: srinivas.kandagatla@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Cc: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] dt-bindings: nvmem: imx-ocotp: support i.MX95
Date: Wed, 28 Feb 2024 16:13:54 +0800
Message-Id: <20240228081355.1627744-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::19)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VI1PR04MB9858:EE_
X-MS-Office365-Filtering-Correlation-Id: ee616869-fa92-4b7b-7dd0-08dc383412be
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	J1JR0FRsNN6RJ4o0g/Vh5sIla5iZ0+ww3Lma8rz/yvXhRMUqpnXaom0NwWaqRYlDq1FHoYv6yyRfEIeUBdwvz9yjylPn1lmCw/PUQxj0TwcHLUgCsgdD7bHbbOe2R05WwrcLX3czUxdEDD3yvtuUGh7xB61SK8eWzGk5FWgjv7q8e1c+taQdWwK3VGZUI4hduInRbv+zj8iAZK0uub3JHlYI7HyzrD3hYXOjNGnG0y6JpVuZTDtqvJ+2szznMv/Q0eGWFWI4CJPgeL1rI04YMinCQKfWKI2XV2rcDPBY0wczXRoxY3Y2CP+cvIU0HCBnmDFu0f9Nv8Q9WOl4vTjBzq/MPAt21tqT/Y8+xPTwE8EDlO1sq+43tm7QZhvgOJGWOuYbtosYPyzuNKAilhc//pVtdFgV/mIZTFDFjFGRbd3OJA06iFkfphksXAz2txnk9oOU0mhqnwfKHVbqTqnNEk+WKU7EBqXdF3AFPLiR+GfKegy6nWjAe58sXReVtab/jggyQMtPgyg/R+4BYYzprb7HAR9kG/6FiI8pp5QbFwat8rYu3bmv6IAAAE2WJjTmUG5z8s9noCumPhO8+f8C7W7whjcEqrn/mfbNP24yvUxECUyTxIVyLjr2EZ88ZiMyZCGVvNF532WtuD72SBaz2/AHZ5TUvUDEvs1CC1oxyS8MgCZool7Ky1lJXhTOLlTeJIQawq7NRgmolmkDZteaRAkyBkTpG44itN6k5WaFgDM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kzbSE2SD2RAUN+NUzmtXkeFNghrxxard1rKmdHQbmL1OoQ+/rlmL/0kuAOGc?=
 =?us-ascii?Q?/GwLf3folPHrGygUac/h311Vg7YaSEQid6n9WPS+vE0bcYcDzWgWLng6eQls?=
 =?us-ascii?Q?htp1OszAfSW+IiqdSknC82JIsE7g/hJSBvZYd/7FIbBfPiNC72d4gnLe/3XS?=
 =?us-ascii?Q?uA0mpFiHRYTPafYXB1xgc4M6hgLHDIN+vlbYaTXb/O/sSGkspZYP/IYZSP3l?=
 =?us-ascii?Q?O+JJtKrPbdfB0lvjIRoZkvKk6H65d7cNNXA1i8m2hZZuCLxb6QBGO+lVhG5F?=
 =?us-ascii?Q?cLPWc203lDutlH/VKuhGoDMtZqysSwY82d2dGeypZBnT75zjCLtcXyqi+TMK?=
 =?us-ascii?Q?HJtCPfwvr/l3tYtDiihHGbFfA8PaKPXtgWgJyLc4eQToaQM2lB+MO2RvbaHg?=
 =?us-ascii?Q?92weli0YdsfR0/wmCXBrYO0qcWxRasyWt2fdOa7jFITXBVMZ4vI/PSq08Ouh?=
 =?us-ascii?Q?c+jMOp5YREcrZ49Ga1yUmwXTUkdo7nUla3GCIdKlD9acR1sncbuMQsQtI49L?=
 =?us-ascii?Q?dFn09TiNWszdWhOmsb0bi+0x2jb564MImNpgEB/nr6KOgMQHgJKWRgGlI4kk?=
 =?us-ascii?Q?bU/aFHowKwJeaQj52KgK8RGj5d1F1/zVT/lyz8N+n2NowGRB6ZaOkrjf3ef1?=
 =?us-ascii?Q?tsDE/DEP/AkXGLeIERqE8JYcc92tXjYc0OaoEMD769RZkEfES9mf/wdIdbX5?=
 =?us-ascii?Q?82BZU2Oo+Dr0o6dwq+9QcB3UrcrNRHlo9S17rPuBrf/UzTcYQ0qqjaaxVpQL?=
 =?us-ascii?Q?I/4Nb/bVsFakhYIe8z9g7JUTBb4BEFfze6ECGfWTjRFEZclX4yv9/8rbUfBa?=
 =?us-ascii?Q?Cyb/lrcwdt2GgQzzuds7t//S1/eylNhDU9uhloZWF08ybh6Pd+N0FU/HfJUZ?=
 =?us-ascii?Q?8rTp7HMEmedoG8A4NIfCD3DmMZAcFnUKr8+tiY2QrIPJtiutxlC0MUobNVHf?=
 =?us-ascii?Q?MwnF2MkypyMZ6Siq7bMDaS1A9zbl/oLOGd5vscqG1TcQuSALjskOVgYpy4Hl?=
 =?us-ascii?Q?vCtF4hdobDhzTtXR85HcfkMl0EMOLKsf3EwSx/iTSv4q9PaxPu/rpXhGtvKM?=
 =?us-ascii?Q?IG3EYVZJEcv0ksyUn9aHX5ouyvhr1Fsu2XOJ5fOIJrdAog9W2hcl3DEgUjBB?=
 =?us-ascii?Q?7RCODm+3GT0VwEkkzHfH/+dojD15GJCYNPf3P1Zn9KrSolSzUaL6+EM7kph5?=
 =?us-ascii?Q?ELR3OCLJwxCaKzq3yjZxP+9aIP0mGX3L9OtEPHm2HAj22WL3xi01lsSHAhwJ?=
 =?us-ascii?Q?/5QEALbr2iM7YoFzNUE7ZUWmWR67Vf/lWNVpcPo/UH6bDksOTV+EADciDa+u?=
 =?us-ascii?Q?+hdlUBXLhfMu6OCTU8JkEBiqLNxMnFcXSVTCsVEIgLCiBOvp3ss3GSTOySbn?=
 =?us-ascii?Q?e8hYoVbP6HDpF44nMZ6pQgIftmVLqMvEvKZ6do/WC51b9YbgputqBMDw/Yix?=
 =?us-ascii?Q?zb9UvlnD6pgS+8297z9oV76J1mdDFdzFJ1ml262F8siatK+maBTuZ0+p2+NO?=
 =?us-ascii?Q?7DRIKPpVAQXQyNwpPKc4taJWAuALMX6AlR3GBSoJSLKrBkFPAEWpFj8c6IJo?=
 =?us-ascii?Q?UwNvDrVrkXJUdEK6Kw3bDqG/JQ5K1dscJ2eCBHCi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee616869-fa92-4b7b-7dd0-08dc383412be
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 08:05:48.7456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QbNu272aMk3MEJwYiufSGoTx23CGc36ev12et/sp9zTA6KSW23FFMiigcGz0O2f8RFM6Pv1FtaJk4XCZtUvckQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9858

From: Peng Fan <peng.fan@nxp.com>

Add i.MX95 ocotp compatible string

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
index be1314454bec..e16f16c14505 100644
--- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
@@ -12,7 +12,7 @@ maintainers:
 description: |
   This binding represents the on-chip eFuse OTP controller found on
   i.MX6Q/D, i.MX6DL/S, i.MX6SL, i.MX6SX, i.MX6UL, i.MX6ULL/ULZ, i.MX6SLL,
-  i.MX7D/S, i.MX7ULP, i.MX8MQ, i.MX8MM, i.MX8MN i.MX8MP and i.MX93 SoCs.
+  i.MX7D/S, i.MX7ULP, i.MX8MQ, i.MX8MM, i.MX8MN i.MX8MP and i.MX93/5 SoCs.
 
 allOf:
   - $ref: nvmem.yaml#
@@ -34,6 +34,7 @@ properties:
               - fsl,imx8mq-ocotp
               - fsl,imx8mm-ocotp
               - fsl,imx93-ocotp
+              - fsl,imx95-ocotp
           - const: syscon
       - items:
           - enum:
-- 
2.37.1


