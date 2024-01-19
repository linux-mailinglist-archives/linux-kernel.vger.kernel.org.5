Return-Path: <linux-kernel+bounces-31531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B5D832F96
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98D8DB21E09
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 20:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CBD56744;
	Fri, 19 Jan 2024 20:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ppBZbPhV"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2055.outbound.protection.outlook.com [40.107.249.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0239C41C98;
	Fri, 19 Jan 2024 20:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705695058; cv=fail; b=OeulATe56hG/zDKCjl/8v8XO/HEPAbafVJ0uGdDnIvMdqIJNIczrsrASIyIZGNrpmknCXJUiGVcjTAVAsXUYEtUp+NrMmEkf7XYc/jefqQobF1Fcfum99DTP2mVvtkUITl8pYR4WaG4p0OuVQ8avlGT1USLa51zs/HPUpCkXmLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705695058; c=relaxed/simple;
	bh=nuBkDoMxUA7F0pGcgAtylf78h7kFNYLl9/b3SDbLgOw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=knJpFaW7UgPVUK8mCNKDzVjJP4VXbcM66MrvGBCmeiGNP73MDRYjpNqdQasXbxMd+nXdsLu7z7cwoa+NR/yNQEER/mP31Kg9N1y2VSHExSqtvr6rcO+mJOqXiwjcJXPzHpg3yNiVZpqNuDLGCNvc2W0VkEDOv3U5xcZ99bvujfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ppBZbPhV; arc=fail smtp.client-ip=40.107.249.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESbHGWJNhR+tWXpB73K3qhc8HvqnS09Ya8tFdmr0AX7hXEEcBkBz3nKKi4MG3vw+Kldh9XA1VYmy6p7RlNdEEwjuKcx6kHsG4jE8KcDH/JUf4GmLm71YKcEoKQuU4MhKSoGepJcIix/l4KaI57Jc12dVShQNrqzHBK+ZvMnixasFldZaFhQbtnqDv+hzmxvmeMx0BeB/kfzKptjaCjasNbE+qU7HdGcLDtaQlSPeS1t9UXd0sAZXpmGqeYGunWz4NI0aYfOdO/UARHS8l/6gin60Xdg72PkNz6gTC7TyYFKLFYZAqCD+KZyZNKtaYLGJ/4lv9wvK57fg0lqmt+wMqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWXv1kU2wuP5sXrYoeH80lqv3leFMMK9DfkfsKeaPWc=;
 b=dKOzNxMzSpvEg4nCWs5vXzZqR2S+w9VRHRZl3xUc2zHc9piSd/Afg5tqcuTgUBX/KAnZYRdTlEX53H1i1vhLUo0kSEEmumnT2ldhs7hS2UWx10QDXQccWkuzBGiT+IsBsXQdj4CtynQInXGUlY498eruR7VB2UUiIp405R+uuOgIJebVrHmu2E0HOPsB6g1XVT+0Etj3H+qSr2QJ83ptxrro3j7CBh7rNhFPjsAR/qOzUZu5d+hmA7vo6eAaIocCA7lGWi7SCM/RijcqMd/2euaIU7fuQXJBUZt+9F9G1NvWQoco+BbLLebqd7yrTJEWGQF4iWt4K94HraFYP6l4Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWXv1kU2wuP5sXrYoeH80lqv3leFMMK9DfkfsKeaPWc=;
 b=ppBZbPhVg/hd5eDKnB8E53Hei9l6BeFEDby5l614a69LHxrG5+MAnsBdTDp6GzLkIkaPiMdqh5IhHDBBQ4Ba1xnPYjdVeNVmzk6s7R+bDikzO5YtYXA9V+YkKQQAJyF6lYl1u86Aqz1KSghEdMCIkV2UjMxoH0lcF5t8XxwtpsQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8565.eurprd04.prod.outlook.com (2603:10a6:10:2d4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 20:10:54 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9%4]) with mapi id 15.20.7202.027; Fri, 19 Jan 2024
 20:10:53 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Li Yang <leoyang.li@nxp.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/4] arm64: dts: ls1012a: correct the size of dcfg block
Date: Fri, 19 Jan 2024 15:10:32 -0500
Message-Id: <20240119201035.3124007-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0380.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8565:EE_
X-MS-Office365-Filtering-Correlation-Id: af57fbad-bb0f-4559-6698-08dc192abcc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	x5S3L0TggaOuIcPsalKzdIcKDZNHP/Rh5iPzBaDetsy12GR7pmE0HNCzYtfgJjQyjHfT0sS45HN7ustrTJbTIyDBAfOA+MpWZ0Nl9P1ViZKPtDq5dhlMeXfEppbudQ+LHBKhj598DVIF+AP87ZXwUiU8lUwyk2ojiXz33Yt9nkY7cfnjNvxTydO5t0SgqRImsOxutIsZKjJZn9K7PKk2KnaviN5JMq+n5H66jqECbTNIxi3DVGNbqLy0/GykSp0uIIv0BGlsA3X9LtsHAK9iMMDWGFXt2d3VwyyPEeStcr6we/dOV+NlDkuJFkB8UZJobeYlRTW9S6DVJ6qHHLZCHxqSDN1zzZh64nUk6vekQAAE+NrXu2JrYe7eiZIdsCtwpJk/rSg8xTiaV+iE9EEyJcmQeZUrSstKHZImnCG2RNMMcDx2GJx5b3Dr72WIR2D0w3hZXehXI8FFxHw7FAWEfTQhntajJHZK7pPkp90QHTMqnAaHz3BcvwQeBJQBYpiZDD1GLb/AHI4j0yCE+9oFjTSfX8pZu8y1ZCMQriyjz0PLe72sVEP97qU3CRm1Y/rjKTX0CjhYk0WkB1109CFxnKIn3lOHdun85K9PaAlWdaHscSZgrqXDIbWyQO3pDPvK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(346002)(376002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(8936002)(6666004)(8676002)(52116002)(6506007)(1076003)(41300700001)(26005)(38350700005)(5660300002)(36756003)(2616005)(2906002)(4326008)(38100700002)(86362001)(83380400001)(4744005)(6512007)(316002)(6486002)(66556008)(66946007)(110136005)(478600001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CR9mq9xw10WeKd5163p7DIWW4GCEi3BDWQcdCTCUUkvu3URoPxdJ7ZSbSTTJ?=
 =?us-ascii?Q?bjX3vaVQatghGM8jEMb7HaBayrhBgPJ2DgAaMjKh467pAmVJ2//fmGujGOKj?=
 =?us-ascii?Q?4tprPxww8vxTn01bJy2qjvE+Ze7F/qadGTwuG6uN3qILydslZp32zYo6atTf?=
 =?us-ascii?Q?q162R0MtMeYWdHAKUgoKr7+r/wyr2l2Qew7MbGKMhVMOz+EKiUqU+RNqfmvU?=
 =?us-ascii?Q?F0EzLwz8F9nhj7fXhM+FnXAgudfsV0peTX6dFg1kcBG/ZHk8r9zbnlRXezCz?=
 =?us-ascii?Q?tQIU3yEUG6RN48UI3mgkJFyNO9nW5EJihBQc2ZSiRxyGHvHsv4QKOogFO5op?=
 =?us-ascii?Q?7uM+NmlkHM4ratsLNxorK9M4ObgtuPlTZW75YAyxN6cp+cu8GOreZQLV5yrV?=
 =?us-ascii?Q?+PFy7EHHRv7kvg6MtXS3V0STNr8FF3IRNO0WoLKKnqeDL7k/sS4iYMekdD90?=
 =?us-ascii?Q?oGI5pF9Fut2mRdxp3ZrvF1b/Ix7v3mqvacOPstCcEafn7drEv7Njg0QCoZX4?=
 =?us-ascii?Q?5LX+qleRWbkk/oizZYfboryXfTl2GLGIIDhFFzs8+yUeGO8NvVUm7rLKFem/?=
 =?us-ascii?Q?hA78fGJeQX3fmsn7fJaN1GifksUhdHTLA7h/V+DGHlouwV/ExV5Gsf3NrKYY?=
 =?us-ascii?Q?VUvPHIKV3cAcrl3qsM3n5vl5cf4LprijnJdpTY8SKRPsAfX4tTcLx9VT9GNL?=
 =?us-ascii?Q?v1E7jVKzBbRMAU0iR9+9zkooDrez6SrYh1+Eo1dlGj+kGLmMYxx+MZguJ4xQ?=
 =?us-ascii?Q?V4Ekdv2aVH6hg02a+4oR7cL3KgRqzHs+3lp6lbTDnmwdzrQX0xDSuxisEq47?=
 =?us-ascii?Q?CLadRRTvK4w6BhR5nDnHYUAERt7wrvSGW+nf0oQv51sGlMFV36idF2EVZkTH?=
 =?us-ascii?Q?ADix6XfOi31mwnw3Ch2H7q8Nn6M6nE+L+6OUw9j2hgKHRPOymjPlxqNYj2f4?=
 =?us-ascii?Q?tTN3uFj6YZzuAHz4j+72NWKecQmqKSkzolf0v5JcRcIZI5eFqZFweb2wgMar?=
 =?us-ascii?Q?h3QriIQAxBKwT/4x2BPj9TBr14ikb7GuQyvUWQXADElgwau9qIKgeQhcEh1n?=
 =?us-ascii?Q?vu1wvAxpY7H4mZcudsEe0mCGRe3bkldI6KMPu3s2V6ieRgBhDQuZ7nm9Yw/z?=
 =?us-ascii?Q?9APryXcK2rzmzxrZghlDRAz6bgmljTSsgEgeKpes4OkkSOFO7vP+jqEGx9vB?=
 =?us-ascii?Q?Q/mkZvr8vvOHWOfhGN1+qahcDLpH/noM4kI87peFxy6ZBe5f8b5S2bmAuWD+?=
 =?us-ascii?Q?2XL/vjWnaLfEfXhTSe8y7U/SghnxBOLA1ZDaYezSjBfgNkWjc1DjHLh9y0BF?=
 =?us-ascii?Q?k1lSHsDHnBt3+2b2Zbk6MQUa20yeq0dscLcYb1CBXALoDJYUuHtsT9eLq3MX?=
 =?us-ascii?Q?m9fHuwubbmvnc9twqUyjS6idTD+vgEmbsRNEHXRRcsnZ3336iCD3RDKuZKyZ?=
 =?us-ascii?Q?+QEXVBYA4f1tCVviQDz9tfZN9L+III8l6itaAw3G96wj+ZF5UQJ0HhT2Qs7b?=
 =?us-ascii?Q?wVnUtELF7+K3IByvm6mA8Wg+7qBvFiZt4oSEb7z0J/K63WsrTRe6T6OVc1b/?=
 =?us-ascii?Q?q2J7MkdpHl9t5kDL5NqNVMMz8X7tBT3kQH9X0Tiv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af57fbad-bb0f-4559-6698-08dc192abcc6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 20:10:53.0095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GKmvBrEYNkc2Bm5iJlz65/IAVunys48hHmLGEl/V1NuGjJuS8x6rq6kfrljYi3vKqrVjfk70nk9msCijpjf+rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8565

From: Li Yang <leoyang.li@nxp.com>

Correct the size of dcfg block to 4k.

Signed-off-by: Zhang Ying-22455 <ying.zhang22455@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 1e3fe3897b52c..2ae0daaa1a04f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -290,7 +290,7 @@ sec_mon: sec_mon@1e90000 {
 		dcfg: dcfg@1ee0000 {
 			compatible = "fsl,ls1012a-dcfg",
 				     "syscon";
-			reg = <0x0 0x1ee0000 0x0 0x10000>;
+			reg = <0x0 0x1ee0000 0x0 0x1000>;
 			big-endian;
 		};
 
-- 
2.34.1


