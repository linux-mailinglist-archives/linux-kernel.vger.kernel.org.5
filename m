Return-Path: <linux-kernel+bounces-32612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB9E835DF1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 734BF281CAA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BBA39AC0;
	Mon, 22 Jan 2024 09:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BZDUjrov"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2085.outbound.protection.outlook.com [40.107.7.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8928239850;
	Mon, 22 Jan 2024 09:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705915097; cv=fail; b=doFdpv+I/Xhd+gttNVzWvc88/GFnaDJal4PYNe+Xo9xc0gmmnLyFdORmTrj/P5KMU31SWV0qxM0MYQe63Z9NWplAX7xHQVnJ4qExTzTrPrLnYyjETjmLSDmyxX84JIyTeLf51Hq8IL8z7xbfH5bmJm0tR/GMHPQ4HvWBYco+BV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705915097; c=relaxed/simple;
	bh=er1pnb/jxFPuHy8C/iVpmvju+DUaJGVgHLGohqTRVTg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KBHptuF8sOZmI2vtPdhhnol6h7LQviE7pwsT6NbaxjGr6SbDBSLIMeaCwzkpsG29fGrhv4C3GXpxk1m72v/pXxRToF6r0QG5lZPxojmFo1yBQ/yVLMLRSRIwuxtr0GvCRVnIDfcMsgHtLkHq3ZT0HsLdNP6qwTlgmFMjfdw/RD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=BZDUjrov; arc=fail smtp.client-ip=40.107.7.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljMVIQA+H9fqijSDssmgSXnEmM/dZqQGjrpO1erLyGcGTuaDXblVHZ2SvsrqO4ZqA5m0gSxEmlIo7XUWjnGv89PkrH9xcDTc3TJjHCLBH3YuEe3X160c35be4DTjlnQno2jMIxNor/cUiL4jg2fiHTrx435YA+I6GhcDHcoGCBrn3qEBo1jMLaYKqxhRjT9wiuxt5xYJgt3nt03Kjh7+DfsjySDx6z6D9eIo81bXKfJdbWALBuinw2d3XF3C3JkBc56kg9Zkhz7aqwGZfZCk3vqdZeq41HRkB8tBvXRnRYuLQEAv5+zgMQBNDbmpFewLa3YUWk8+Gnaakufwkm6BRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OclLp80potVNA1kidXUupD+Jd4ujxcsFMhtQ5bjrwk4=;
 b=J5jAfBJfUzCmH6yrm9euGDCNdzo0rBS7UyKXeI3ok0oNicjJrBsIlQWQ3ZkuCONOPgzZTP+2AflTE/4tqgKKrFJn3QPzxSCk2NCS+FDfkRB1TbXs5/UuBBkRTfKOEa165DQ328Kg4gV9q3Xh705f/w7qxDVAwvqXupuEHwxRo1EtoLaMgto2Rb7yTzLP/oOweagqdp4cImgmbAm7o0zg9a4nZV3ljHvhh2LmJR8YSZvVCzNVwDgSQjrm/kXy5NCeGbXY96StwZ1Oh6aCRNU5vspcEPXbby0KYiuv58YVk6DoaMnpyJmu+0vvgXQUBwOYgXU0mEWPFyzMWJhGHdmyeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OclLp80potVNA1kidXUupD+Jd4ujxcsFMhtQ5bjrwk4=;
 b=BZDUjrov2Pl9oE4Ohh2OdMS2D1fAL7T0bHSprb7zBqb43HkrvSusDRjCWRG5TNoKG2j88RXMfy/LpSyWiRyIWIFqEaQmRZfV/0gW0KSr39Ol3Cp4ghVeq9GAp5d21/UBezONqXa9cUPJ+YbAebtI3kInxKihb17V+nhsdrqAy/I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7394.eurprd04.prod.outlook.com (2603:10a6:20b:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 09:18:09 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 09:18:08 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	linux-imx@nxp.com
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] dt-bindings: timer: nxp,sysctr-timer: support i.MX95
Date: Mon, 22 Jan 2024 17:22:24 +0800
Message-Id: <20240122092225.2083191-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::23)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM8PR04MB7394:EE_
X-MS-Office365-Filtering-Correlation-Id: a56ce8b4-b267-446b-5147-08dc1b2b0c61
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mUiI3iILfyw0wq1qpMd74r5AcMWHjNKs8o3iHY8I0KBmns7QZvpQwEWYdwpAdTgVL38vIU7BZ5A34RQhkHCLPyyPmPetGOLjx9uoH4NFNz3wFB4Hs9BWpvB3ai0ES4uhYRb/7akVw5zClYp7UV78E+XZ4rsaM0k5wyX9+tgVsfD2N0JpJEBUF0ZeqAwOSJF0/5U3NEVPdo691RTry8Ib86QM5EJa7v8682UVlDsQl3kq96ldC2vISssTDegc2ydWWJQFYgO7bvRFflZStaMn6p/8zaNcOMcr7XSkAfQSNUoT1dZIXD5OiJf2JN+r+9kP+diZ/eakG4BGkOiG9gNXH42Rgof1BlkBFU3gwULUfY/k9moLc0oQ0pciF4kiVPu1aXKuCGDEygEKTMLz53+6FRzt2l9my40H2zi/9F5qUH4zWuJngokiznyKRajx/drsl/iGKvSzIyjaScWkeblDqYqJy8zp8s2L0H3vUTz48cTP/enm7eYfdUH77/YqUENNK4W7reLnjO7NBgblXy1jrfPa8IYo5Rc7rINy0q1/ktuGwfLNxr0j9wIxfsi939KDq33mU1oJ0iawDKSZvR+SiWAoNr8xn+0kK9+Su8gVmL2P/+zK49rTyC6zG8c3XNgA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(346002)(366004)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(6506007)(26005)(1076003)(2616005)(6666004)(6512007)(52116002)(83380400001)(7416002)(5660300002)(4744005)(2906002)(41300700001)(66556008)(6486002)(66476007)(8936002)(8676002)(478600001)(316002)(66946007)(4326008)(86362001)(38100700002)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aG0ygP/IllgVyst6RxFLh2hxLrk/29nwimYC+1Bn+vd7xsbzRWrKoYk+zHkV?=
 =?us-ascii?Q?UMIHC8UVluK0nx/sd+Dhhet8DD+R9HMA4hxK/e1zezuTiBIZmR8htyuLOnnw?=
 =?us-ascii?Q?FnP8H55PuEU7M/VtL7Yso4HFv0N6zovqjpt1FK/c3EP3287q1HY7Cda8ElhV?=
 =?us-ascii?Q?GQraLa2FsJEzGiVSvYa2ALAQh/3CG8TJHsdCI8cwsz+v8cyV0umlS7nP3xOa?=
 =?us-ascii?Q?hGSjWf53ABTgMQY8iZnl1O/2FH0yZrTQYM1D9GES/dvcUzA2lgIaF9asNOTu?=
 =?us-ascii?Q?FrnAH6WTBLC8wnVjOwT+weozpz/8FrgYTLQW/MovNOEAC1aPebC5u+8pDw2w?=
 =?us-ascii?Q?Ni+gk1lGvYEeZq5N48Wt5tcnn37WlEWd1KZL5WhS/n4sEtLwyNRgpos8GulV?=
 =?us-ascii?Q?KP3ZpblAXl86kHljQGvjBGUPuQ8RgGtsW+4pH63Zz5R/CFgzPoFFIt135nZk?=
 =?us-ascii?Q?Mi5ivi9em1cKaieWA3TqoCIOUcPbcRBHCzZ/OSE6lg/TEypK7OFSKkEm/F27?=
 =?us-ascii?Q?mOeA2V+l9DwVD3wISkZ7rbONjQOGmx+z89TM9o1/wWD1hwoBZ/bJkGHpCRYC?=
 =?us-ascii?Q?qb9QdCJX5XyXpYoJSy5+qtM5AYKZH2hX7r2zcKwQDggWOjn4EJ4MMf4Edbfz?=
 =?us-ascii?Q?yeGEg6PcyxNDyukhtL9aYXVhpJxqlJeO48/FyBwGERZhIrN5f8kOXEQzJF51?=
 =?us-ascii?Q?7M9HCeFk0MjKzekoEhhRLOXQf5yBuVsCgitq2Sa5sFMhX/6/L3f+81xa+Zdf?=
 =?us-ascii?Q?OXhVhMj3x4SLMAnqogVLSts4RjvT1YfxTsV3RLnoqH6jc9XREfIL84kkwz7j?=
 =?us-ascii?Q?4Z4GfxqrqkS5gqPonB0LuDWEEdbPav1Hct1a3FIpB+P41/Zvg5Sz3kLZ7ruE?=
 =?us-ascii?Q?vcIGf4RShRfeswUNx93Wbkwq5AkrMlb54UtxsBZFm1eyHoEiA/BZ9QpLvdlS?=
 =?us-ascii?Q?shtTE/yyGAVrZKZJ8Ki+zXrAxmExn16VhcTXbuwtpKJncO5vyeDPG6tPBhG1?=
 =?us-ascii?Q?O1N5Whbgtyd2OlNZyk6XRPPyeaPjs8dDp+jNSQFDQyozpsEISUwGPWDwLPvw?=
 =?us-ascii?Q?0/fGVo4yiwbYDcbnQ9ZR62Id5JuJ6EZF/MO4FE0JHHEF29wgAdae5m/I3zV4?=
 =?us-ascii?Q?2tdqnwf4oRCNSrqy4C0olMYJ42tB/2ldDnhZYcBWPdUQCmYaiQjTyhjBV1Og?=
 =?us-ascii?Q?HZhGd48iq+NLGyVZH0A8OanriqQqEin/xS1Cz1bzudAsgflMwGtBEvucq/Vs?=
 =?us-ascii?Q?jsJX1iQipBFhry1zAh+JTFwCTcphueleb6DGLZJ64Xp7KfU86pSuoSPPB+VY?=
 =?us-ascii?Q?aC6+EhapLI7wE8MmBmOidtCQIHiE4hlr9DQk/lo9m7dLGteGjGHJxJ9/k2y9?=
 =?us-ascii?Q?+nSEKLOA9fvntD+pDG/v31xUCH69scglr+on2JJCyXxF0uwjC49wtBI+xuXY?=
 =?us-ascii?Q?M6wGB5nf4W7sTmQONxyJKvmu3cksMSpTPQQKA2Irgy2bSJr/+oCzMm63VGjR?=
 =?us-ascii?Q?dNUrS15QpkKNMitEgLwSEyAEbRKcMDQ1Oqq1OtKEprLvXs3CSpkxDaCzO7LB?=
 =?us-ascii?Q?zL2rTaOCMLcmsqcUPoIJru6YqYmJkPsQdcxHQAt8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a56ce8b4-b267-446b-5147-08dc1b2b0c61
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 09:18:08.8320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u9e75lvjYn1N3KVzWqtiA7xCTRG4MgdnAkuBSoqbTnoupysVHMu9JX+bNLeh1tPlM4Ofu7pt6/UbFLICNF+EuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7394

From: Peng Fan <peng.fan@nxp.com>

i.MX95 System counter module has similar design as i.MX93, so add
fallback compatible with nxp,sysctr-timer

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/timer/nxp,sysctr-timer.yaml         | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml b/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml
index 2b9653dafab8..4f0b660d5ce3 100644
--- a/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml
@@ -18,7 +18,11 @@ description: |
 
 properties:
   compatible:
-    const: nxp,sysctr-timer
+    oneOf:
+      - const: nxp,sysctr-timer
+      - items:
+          - const: nxp,imx95-sysctr-timer
+          - const: nxp,sysctr-timer
 
   reg:
     maxItems: 1
-- 
2.37.1


