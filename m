Return-Path: <linux-kernel+bounces-32032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED1D835585
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 12:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21DF2820C2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 11:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDB336AF3;
	Sun, 21 Jan 2024 11:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KkyUjTSy"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2053.outbound.protection.outlook.com [40.107.20.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCDB101FA;
	Sun, 21 Jan 2024 11:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705837337; cv=fail; b=poSSJe1OOeJiS1s4mm/kN64AbMrWtj4h0Kxs6+XwHwiQKh05OCVEFU38j3US6ZU/2TjK5D34iisz83zBQ6JlbcIL/PkIE7NQzhvQbrazVpClB4f9W3Axk1r9giSJeGAVl0YcdQg6GeikJaCPgGJDr+/gEGlRSQvI6t4r1ZS/oF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705837337; c=relaxed/simple;
	bh=xBMVqWH87uNRd64jKLUKsQqMfTwiSuZJuzRU0a3JoTw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=duCrzJiSaYi+AwIjcQ90y1moFcwm93kiURvm3gw2H4nJr9fj+ldURWzaHhD638KPnEmFuFR7mL9+sfzQ2w45v/hqHev4yZaBUwVRCp/PozI6keyAb+tZQ7cIyCgXY9fsQG+PSOvT87Qlq81H0OWRsVDNhq5QPriWBz9vXaM1/qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=KkyUjTSy; arc=fail smtp.client-ip=40.107.20.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLGHAqmIHsYPmF7Z8YyTp+y9y4mX7i5okssqf5qq7GWPAZrYTSI9QuLb5t88FzAEwqzFwYVO7PSOJE5nvDEPXHEmajEgdxCIcZr84SIyhebzABIoUd1yedTquvmsUXEPOGfP2nMzcV+mYt2+Lj32vHUdk6SqPjWavcBbnGnEqVDGAW6MHVDNzyaww69x9BW2F8CdEJAW2Jh/tK2YGOJCZvzOsX90BVzENKGdkq87VYMnMZqT15dlF511dqJHSFQdIrrEp1c/dzw21LTwHSEjsYnoDpbG8UbxqL7v9FAIVWeeFfkjh1v+oODm2xYxLD230Hanje/USS108dneMSQQ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4VUcz5uidyb2460oxVqz2vEpXtj9BoNrHH0IMezyXRA=;
 b=DZt16MNKhWtStVZi7XhRfMRXQEr0rzB86uKlrWgZYbE92HxjptxmUwQKb+5NkZ/Lpl+XSpI/j+KjNh7iIGTM2ARKgZ5NkYraQTSWPQlwVQaO2alAE92QRo3fGCuUla9bkaHRMmfOawqf2pbRlTYy3QFEa/FNW9qtscdqrkF13zqxUJXV240R462+Ed1AYghWP7/RZqtcKSFa1kSvWChWll7C4qE8ySVDlUc4fMHbT5yfsFVqpH7KPLJVpZI+heG0RlX1Bjf3V88h7jtj1JqNfyLBAGn4QNLS12yiFRtbfffcpndEZ5cMyOb+lQehTVEaC/RsAcNpt3E9S/JqzAcJQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VUcz5uidyb2460oxVqz2vEpXtj9BoNrHH0IMezyXRA=;
 b=KkyUjTSyrUcbbrguVZFhsmOHXBeBBP0dKCtXzls8edmNYTdJOLvj234bAgYPr4P0HBN0EQTsLClLgZS3faFI7GMX5LbkdzVweSOHoFhqlinE5fDRqnLrqzXWJttUYFGC1hoCBxfErG6djwRX3kMBM77nAEpZU8niJjiGbxYE6kE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8117.eurprd04.prod.outlook.com (2603:10a6:20b:3fc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.30; Sun, 21 Jan
 2024 11:42:09 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7202.028; Sun, 21 Jan 2024
 11:42:09 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	abelvesa@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: devicetree@vger.kernel.org,
	linux-imx@nxp.com,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] dt-bindings: clock: support NXP i.MX95
Date: Sun, 21 Jan 2024 19:46:23 +0800
Message-Id: <20240121114623.1418597-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8117:EE_
X-MS-Office365-Filtering-Correlation-Id: 97749098-abfd-4f9a-5b8b-08dc1a75ffeb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3NxRAyl3lFzBVF9zjyAKlb1paiLrMyK4QNrtCGJEqEQ9PQEz7ddn6LLy/havRxVe8mBgr6+nyDKFZaTp9QPL0xgcg3NA1I+BzyjkD83Tp91LjgPfv2U5pSeUM9E57Eb9RAufXhtgNt5y2baQ448arhPEbPMY1FFt8ljo3lUoNN8iZ67frgmTN1ETJ9UsjsiSXDRfTAV4ScUxly1g9KxCK7467ABL71JXFkrdBteW1M/kcC+K25JmPmIC5MQWb8xLUCAozsCBWWya8mxGs4wn+mlPjaqcXIgur/vArmJZn404JTGq6Y8zVqSrO6aF4SNFVT7SIHnqDJ4gAXSShEffn68/4a+Llt/x3GWES13finOfeLslbbImBJN09L/U7e4zV6Q+I5mxgqndXvoT8lIfkO7KnLjAH0cmPHNP6X0YeCabu0wEam0jrhAXTn5xpkgiN5lVlbiyM243TWLM41oQIMugzxjBAwYwjmztdGzEmSAaiiqBdr2XXpowHJTK4snIdjv4kNItUJaplsK5cN3X/DD5LNpY0Ow1xvUVAisQNHOF75eDUDaQkLfp/wSjWEAAepS439anX/a0Pb2q711VuHh8Q7KBOhhp6JBN0S1PtMmsBGz5MvFehgLaasTqGHWE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39850400004)(136003)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(921011)(38350700005)(5660300002)(52116002)(7416002)(66556008)(66476007)(66946007)(2906002)(26005)(6486002)(8676002)(6666004)(6506007)(478600001)(316002)(4326008)(8936002)(1076003)(2616005)(6512007)(38100700002)(83380400001)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L2p0Jm6/dzcdDbL0PU9zYWd1oKi9vYS5JJVwZRd46WtTjV4Fo5jUy23ZaruE?=
 =?us-ascii?Q?YwCPRJplaACObelu3/+G667NNPESe8fyW8lMwTrLQntE/kIaw4YzRntZCISc?=
 =?us-ascii?Q?GTVKVbVcSgNFaM8sQgOR3hI+MEVCAQybeagO9itN08GQvw9eXCfDV24uFegD?=
 =?us-ascii?Q?ErQ8bVwTMAqbmGnHX75R1QDjlTyktH1WCVZWcZFn5dUIjFvK1946cLSIXFim?=
 =?us-ascii?Q?Wj2PuB/DymVEVwhJTuQZwhx59EPA/V65DLmU9odS37bk9wcfL3YyWkco8nKM?=
 =?us-ascii?Q?qygUKrR/Em8KfJDXC8FsrfvLz3vTcoZKaVu1hMwTKWBDJ/gPYnSRPmJIwP7l?=
 =?us-ascii?Q?GHCOj+ANyoUalvGSpJcb4n8NRssN/UCh+HEfhjORTILkGIa7+n3Px3SedGBT?=
 =?us-ascii?Q?mcSUSue+HFZj5osn0aQFTEYBe5FszyRxbX58XjTYz5klhyR0ge8+rLT7HfFM?=
 =?us-ascii?Q?rd8EFvAjHEttHLijNH6bWVXD7qx/rPsUoOV9RINAqmO6furiY8B1gcccXhSx?=
 =?us-ascii?Q?7F+s97xa+b+UOODKmk2m6/G4913r8+FGp0H9lpfTo2AoWK7pP753yIsLd2+u?=
 =?us-ascii?Q?8+/gnIVu9eE1mNhGSZCMaV8EFZXcQw+4myjFmJdaVHy1tsDTyR6+BeHkR06i?=
 =?us-ascii?Q?MutoQAI3tATyLXs5y9c5xox2/iWeWr67eySL8AEbCgrl7SlC1YZxUh1YS1gO?=
 =?us-ascii?Q?B8cRhzMPMc8x2Hr5ywtEfxzg7quWFXD7bg2OOt4Ah/iHJAC2UfDPePCGgk41?=
 =?us-ascii?Q?KPziJXbgck58Dvz6I5CjDYxoN4lrH7CubGenY0mSjQRl6Ae9X3oRULbOSVT6?=
 =?us-ascii?Q?kYJucYO7ZlNQ+SfSFmIvOuKF1qGHQ5Aig0gibh2DCx8a6Hky2aEcinzDVik9?=
 =?us-ascii?Q?n0aAArGlwvwunDDhY5tGrWseS7aIbA/St0fniCHCXcDJuvkFprIywMUlqrqg?=
 =?us-ascii?Q?k1I8UNukls9n3ebur9bujjF8Qo0i9z/6HI1ijQfSxbQ7+ogPWiuWObhd8fsQ?=
 =?us-ascii?Q?TbKrXcC8jLoZyGNOxdRdsEWfVOBOzvaO95oZ07qT9uSjZw1saecy3IMC90HV?=
 =?us-ascii?Q?GmaqsAbfINuNPAgFkZzCHkjOLxm+vGSjLqH4XlQUeKT3CiNPIDbU1ILHtGDm?=
 =?us-ascii?Q?hcAwwt32ZCLHsAi4xErgJuYp0CJJKeIGNQ+TZra8InaceH9LtQPAtLGRMB+L?=
 =?us-ascii?Q?jQObXWFUXiPRRiGnsWKMoqGoekNDNsKK7bEjwxkpbzbk9+EeVbo5El35WtoJ?=
 =?us-ascii?Q?ulbnAx4c+R9zesMlSWLleGuSgVmJI27fE8VCQWT4DEMg+vqUkgwb9tRmuXZF?=
 =?us-ascii?Q?fDKpopMFOp9NisIYCrWQMqYYBSEvahZrG+LIdYtVC04t2g3h+nVIpuPoEJqI?=
 =?us-ascii?Q?LmItwTaxgkfJhvDUCvp35mithjki8TULQtENBoSYpbJR+Iro+oK1qxWzCooL?=
 =?us-ascii?Q?AUe/IHTkdEkXyMSgZfXRAiYDGFYdljM3sXcrH3q/trbd5mAYNd1QpHqKtw5g?=
 =?us-ascii?Q?Xmku3i2okzdNN3S1RoZjDu4JmRBB9BVNv3CMW13myPm1OqMFrLSZKMMhr3Cz?=
 =?us-ascii?Q?jbty1TrET6y6o8RkaZqC0iuACWMYszVo2F2E+xX/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97749098-abfd-4f9a-5b8b-08dc1a75ffeb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2024 11:42:08.9947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p45+LTNKZ+FVV6rttTr4gkKZ/RGXDAL+ry2wruPv0+VxKdj0ZLHR7pSebIPyR1h9bk+SPiWAKO9wsTMvIK9Txw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8117

From: Peng Fan <peng.fan@nxp.com>

Add i.MX95 clock dt-binding header file

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 include/dt-bindings/clock/nxp,imx95-clock.h | 187 ++++++++++++++++++++
 1 file changed, 187 insertions(+)
 create mode 100644 include/dt-bindings/clock/nxp,imx95-clock.h

diff --git a/include/dt-bindings/clock/nxp,imx95-clock.h b/include/dt-bindings/clock/nxp,imx95-clock.h
new file mode 100644
index 000000000000..939655f0414e
--- /dev/null
+++ b/include/dt-bindings/clock/nxp,imx95-clock.h
@@ -0,0 +1,187 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
+/*
+ * Copyright 2024 NXP
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_IMX95_H
+#define __DT_BINDINGS_CLOCK_IMX95_H
+
+/* The index should match i.MX95 SCMI Firmware */
+#define IMX95_CLK_32K                       1
+#define IMX95_CLK_24M                       2
+#define IMX95_CLK_FRO                       3
+#define IMX95_CLK_SYSPLL1_VCO               4
+#define IMX95_CLK_SYSPLL1_PFD0_UNGATED      5
+#define IMX95_CLK_SYSPLL1_PFD0              6
+#define IMX95_CLK_SYSPLL1_PFD0_DIV2         7
+#define IMX95_CLK_SYSPLL1_PFD1_UNGATED      8
+#define IMX95_CLK_SYSPLL1_PFD1              9
+#define IMX95_CLK_SYSPLL1_PFD1_DIV2         10
+#define IMX95_CLK_SYSPLL1_PFD2_UNGATED      11
+#define IMX95_CLK_SYSPLL1_PFD2              12
+#define IMX95_CLK_SYSPLL1_PFD2_DIV2         13
+#define IMX95_CLK_AUDIOPLL1_VCO             14
+#define IMX95_CLK_AUDIOPLL1                 15
+#define IMX95_CLK_AUDIOPLL2_VCO             16
+#define IMX95_CLK_AUDIOPLL2                 17
+#define IMX95_CLK_VIDEOPLL1_VCO             18
+#define IMX95_CLK_VIDEOPLL1                 19
+#define IMX95_CLK_RESERVED20                20
+#define IMX95_CLK_RESERVED21                21
+#define IMX95_CLK_RESERVED22                22
+#define IMX95_CLK_RESERVED23                23
+#define IMX95_CLK_ARMPLL_VCO                24
+#define IMX95_CLK_ARMPLL_PFD0_UNGATED       25
+#define IMX95_CLK_ARMPLL_PFD0               26
+#define IMX95_CLK_ARMPLL_PFD1_UNGATED       27
+#define IMX95_CLK_ARMPLL_PFD1               28
+#define IMX95_CLK_ARMPLL_PFD2_UNGATED       29
+#define IMX95_CLK_ARMPLL_PFD2               30
+#define IMX95_CLK_ARMPLL_PFD3_UNGATED       31
+#define IMX95_CLK_ARMPLL_PFD3               32
+#define IMX95_CLK_DRAMPLL_VCO               33
+#define IMX95_CLK_DRAMPLL                   34
+#define IMX95_CLK_HSIOPLL_VCO               35
+#define IMX95_CLK_HSIOPLL                   36
+#define IMX95_CLK_LDBPLL_VCO                37
+#define IMX95_CLK_LDBPLL                    38
+#define IMX95_CLK_EXT1                      39
+#define IMX95_CLK_EXT2                      40
+
+#define IMX95_CCM_NUM_CLK_SRC               41
+
+#define IMX95_CLK_ADC                      (IMX95_CCM_NUM_CLK_SRC + 0)
+#define IMX95_CLK_TMU                      (IMX95_CCM_NUM_CLK_SRC + 1)
+#define IMX95_CLK_BUSAON                   (IMX95_CCM_NUM_CLK_SRC + 2)
+#define IMX95_CLK_CAN1                     (IMX95_CCM_NUM_CLK_SRC + 3)
+#define IMX95_CLK_I3C1                     (IMX95_CCM_NUM_CLK_SRC + 4)
+#define IMX95_CLK_I3C1SLOW                 (IMX95_CCM_NUM_CLK_SRC + 5)
+#define IMX95_CLK_LPI2C1                   (IMX95_CCM_NUM_CLK_SRC + 6)
+#define IMX95_CLK_LPI2C2                   (IMX95_CCM_NUM_CLK_SRC + 7)
+#define IMX95_CLK_LPSPI1                   (IMX95_CCM_NUM_CLK_SRC + 8)
+#define IMX95_CLK_LPSPI2                   (IMX95_CCM_NUM_CLK_SRC + 9)
+#define IMX95_CLK_LPTMR1                   (IMX95_CCM_NUM_CLK_SRC + 10)
+#define IMX95_CLK_LPUART1                  (IMX95_CCM_NUM_CLK_SRC + 11)
+#define IMX95_CLK_LPUART2                  (IMX95_CCM_NUM_CLK_SRC + 12)
+#define IMX95_CLK_M33                      (IMX95_CCM_NUM_CLK_SRC + 13)
+#define IMX95_CLK_M33SYSTICK               (IMX95_CCM_NUM_CLK_SRC + 14)
+#define IMX95_CLK_MQS1                     (IMX95_CCM_NUM_CLK_SRC + 15)
+#define IMX95_CLK_PDM                      (IMX95_CCM_NUM_CLK_SRC + 16)
+#define IMX95_CLK_SAI1                     (IMX95_CCM_NUM_CLK_SRC + 17)
+#define IMX95_CLK_SENTINEL                 (IMX95_CCM_NUM_CLK_SRC + 18)
+#define IMX95_CLK_TPM2                     (IMX95_CCM_NUM_CLK_SRC + 19)
+#define IMX95_CLK_TSTMR1                   (IMX95_CCM_NUM_CLK_SRC + 20)
+#define IMX95_CLK_CAMAPB                   (IMX95_CCM_NUM_CLK_SRC + 21)
+#define IMX95_CLK_CAMAXI                   (IMX95_CCM_NUM_CLK_SRC + 22)
+#define IMX95_CLK_CAMCM0                   (IMX95_CCM_NUM_CLK_SRC + 23)
+#define IMX95_CLK_CAMISI                   (IMX95_CCM_NUM_CLK_SRC + 24)
+#define IMX95_CLK_MIPIPHYCFG               (IMX95_CCM_NUM_CLK_SRC + 25)
+#define IMX95_CLK_MIPIPHYPLLBYPASS         (IMX95_CCM_NUM_CLK_SRC + 26)
+#define IMX95_CLK_MIPIPHYPLLREF            (IMX95_CCM_NUM_CLK_SRC + 27)
+#define IMX95_CLK_MIPITESTBYTE             (IMX95_CCM_NUM_CLK_SRC + 28)
+#define IMX95_CLK_A55                      (IMX95_CCM_NUM_CLK_SRC + 29)
+#define IMX95_CLK_A55MTRBUS                (IMX95_CCM_NUM_CLK_SRC + 30)
+#define IMX95_CLK_A55PERIPH                (IMX95_CCM_NUM_CLK_SRC + 31)
+#define IMX95_CLK_DRAMALT                  (IMX95_CCM_NUM_CLK_SRC + 32)
+#define IMX95_CLK_DRAMAPB                  (IMX95_CCM_NUM_CLK_SRC + 33)
+#define IMX95_CLK_DISPAPB                  (IMX95_CCM_NUM_CLK_SRC + 34)
+#define IMX95_CLK_DISPAXI                  (IMX95_CCM_NUM_CLK_SRC + 35)
+#define IMX95_CLK_DISPDP                   (IMX95_CCM_NUM_CLK_SRC + 36)
+#define IMX95_CLK_DISPOCRAM                (IMX95_CCM_NUM_CLK_SRC + 37)
+#define IMX95_CLK_DISPUSB31                (IMX95_CCM_NUM_CLK_SRC + 38)
+#define IMX95_CLK_DISP1PIX                 (IMX95_CCM_NUM_CLK_SRC + 39)
+#define IMX95_CLK_DISP2PIX                 (IMX95_CCM_NUM_CLK_SRC + 40)
+#define IMX95_CLK_DISP3PIX                 (IMX95_CCM_NUM_CLK_SRC + 41)
+#define IMX95_CLK_GPUAPB                   (IMX95_CCM_NUM_CLK_SRC + 42)
+#define IMX95_CLK_GPU                      (IMX95_CCM_NUM_CLK_SRC + 43)
+#define IMX95_CLK_HSIOACSCAN480M           (IMX95_CCM_NUM_CLK_SRC + 44)
+#define IMX95_CLK_HSIOACSCAN80M            (IMX95_CCM_NUM_CLK_SRC + 45)
+#define IMX95_CLK_HSIO                     (IMX95_CCM_NUM_CLK_SRC + 46)
+#define IMX95_CLK_HSIOPCIEAUX              (IMX95_CCM_NUM_CLK_SRC + 47)
+#define IMX95_CLK_HSIOPCIETEST160M         (IMX95_CCM_NUM_CLK_SRC + 48)
+#define IMX95_CLK_HSIOPCIETEST400M         (IMX95_CCM_NUM_CLK_SRC + 49)
+#define IMX95_CLK_HSIOPCIETEST500M         (IMX95_CCM_NUM_CLK_SRC + 50)
+#define IMX95_CLK_HSIOUSBTEST50M           (IMX95_CCM_NUM_CLK_SRC + 51)
+#define IMX95_CLK_HSIOUSBTEST60M           (IMX95_CCM_NUM_CLK_SRC + 52)
+#define IMX95_CLK_BUSM7                    (IMX95_CCM_NUM_CLK_SRC + 53)
+#define IMX95_CLK_M7                       (IMX95_CCM_NUM_CLK_SRC + 54)
+#define IMX95_CLK_M7SYSTICK                (IMX95_CCM_NUM_CLK_SRC + 55)
+#define IMX95_CLK_BUSNETCMIX               (IMX95_CCM_NUM_CLK_SRC + 56)
+#define IMX95_CLK_ENET                     (IMX95_CCM_NUM_CLK_SRC + 57)
+#define IMX95_CLK_ENETPHYTEST200M          (IMX95_CCM_NUM_CLK_SRC + 58)
+#define IMX95_CLK_ENETPHYTEST500M          (IMX95_CCM_NUM_CLK_SRC + 59)
+#define IMX95_CLK_ENETPHYTEST667M          (IMX95_CCM_NUM_CLK_SRC + 60)
+#define IMX95_CLK_ENETREF                  (IMX95_CCM_NUM_CLK_SRC + 61)
+#define IMX95_CLK_ENETTIMER1               (IMX95_CCM_NUM_CLK_SRC + 62)
+#define IMX95_CLK_MQS2                     (IMX95_CCM_NUM_CLK_SRC + 63)
+#define IMX95_CLK_SAI2                     (IMX95_CCM_NUM_CLK_SRC + 64)
+#define IMX95_CLK_NOCAPB                   (IMX95_CCM_NUM_CLK_SRC + 65)
+#define IMX95_CLK_NOC                      (IMX95_CCM_NUM_CLK_SRC + 66)
+#define IMX95_CLK_NPUAPB                   (IMX95_CCM_NUM_CLK_SRC + 67)
+#define IMX95_CLK_NPU                      (IMX95_CCM_NUM_CLK_SRC + 68)
+#define IMX95_CLK_CCMCKO1                  (IMX95_CCM_NUM_CLK_SRC + 69)
+#define IMX95_CLK_CCMCKO2                  (IMX95_CCM_NUM_CLK_SRC + 70)
+#define IMX95_CLK_CCMCKO3                  (IMX95_CCM_NUM_CLK_SRC + 71)
+#define IMX95_CLK_CCMCKO4                  (IMX95_CCM_NUM_CLK_SRC + 72)
+#define IMX95_CLK_VPUAPB                   (IMX95_CCM_NUM_CLK_SRC + 73)
+#define IMX95_CLK_VPU                      (IMX95_CCM_NUM_CLK_SRC + 74)
+#define IMX95_CLK_VPUDSP                   (IMX95_CCM_NUM_CLK_SRC + 75)
+#define IMX95_CLK_VPUJPEG                  (IMX95_CCM_NUM_CLK_SRC + 76)
+#define IMX95_CLK_AUDIOXCVR                (IMX95_CCM_NUM_CLK_SRC + 77)
+#define IMX95_CLK_BUSWAKEUP                (IMX95_CCM_NUM_CLK_SRC + 78)
+#define IMX95_CLK_CAN2                     (IMX95_CCM_NUM_CLK_SRC + 79)
+#define IMX95_CLK_CAN3                     (IMX95_CCM_NUM_CLK_SRC + 80)
+#define IMX95_CLK_CAN4                     (IMX95_CCM_NUM_CLK_SRC + 81)
+#define IMX95_CLK_CAN5                     (IMX95_CCM_NUM_CLK_SRC + 82)
+#define IMX95_CLK_FLEXIO1                  (IMX95_CCM_NUM_CLK_SRC + 83)
+#define IMX95_CLK_FLEXIO2                  (IMX95_CCM_NUM_CLK_SRC + 84)
+#define IMX95_CLK_FLEXSPI1                 (IMX95_CCM_NUM_CLK_SRC + 85)
+#define IMX95_CLK_I3C2                     (IMX95_CCM_NUM_CLK_SRC + 86)
+#define IMX95_CLK_I3C2SLOW                 (IMX95_CCM_NUM_CLK_SRC + 87)
+#define IMX95_CLK_LPI2C3                   (IMX95_CCM_NUM_CLK_SRC + 88)
+#define IMX95_CLK_LPI2C4                   (IMX95_CCM_NUM_CLK_SRC + 89)
+#define IMX95_CLK_LPI2C5                   (IMX95_CCM_NUM_CLK_SRC + 90)
+#define IMX95_CLK_LPI2C6                   (IMX95_CCM_NUM_CLK_SRC + 91)
+#define IMX95_CLK_LPI2C7                   (IMX95_CCM_NUM_CLK_SRC + 92)
+#define IMX95_CLK_LPI2C8                   (IMX95_CCM_NUM_CLK_SRC + 93)
+#define IMX95_CLK_LPSPI3                   (IMX95_CCM_NUM_CLK_SRC + 94)
+#define IMX95_CLK_LPSPI4                   (IMX95_CCM_NUM_CLK_SRC + 95)
+#define IMX95_CLK_LPSPI5                   (IMX95_CCM_NUM_CLK_SRC + 96)
+#define IMX95_CLK_LPSPI6                   (IMX95_CCM_NUM_CLK_SRC + 97)
+#define IMX95_CLK_LPSPI7                   (IMX95_CCM_NUM_CLK_SRC + 98)
+#define IMX95_CLK_LPSPI8                   (IMX95_CCM_NUM_CLK_SRC + 99)
+#define IMX95_CLK_LPTMR2                   (IMX95_CCM_NUM_CLK_SRC + 100)
+#define IMX95_CLK_LPUART3                  (IMX95_CCM_NUM_CLK_SRC + 101)
+#define IMX95_CLK_LPUART4                  (IMX95_CCM_NUM_CLK_SRC + 102)
+#define IMX95_CLK_LPUART5                  (IMX95_CCM_NUM_CLK_SRC + 103)
+#define IMX95_CLK_LPUART6                  (IMX95_CCM_NUM_CLK_SRC + 104)
+#define IMX95_CLK_LPUART7                  (IMX95_CCM_NUM_CLK_SRC + 105)
+#define IMX95_CLK_LPUART8                  (IMX95_CCM_NUM_CLK_SRC + 106)
+#define IMX95_CLK_SAI3                     (IMX95_CCM_NUM_CLK_SRC + 107)
+#define IMX95_CLK_SAI4                     (IMX95_CCM_NUM_CLK_SRC + 108)
+#define IMX95_CLK_SAI5                     (IMX95_CCM_NUM_CLK_SRC + 109)
+#define IMX95_CLK_SPDIF                    (IMX95_CCM_NUM_CLK_SRC + 110)
+#define IMX95_CLK_SWOTRACE                 (IMX95_CCM_NUM_CLK_SRC + 111)
+#define IMX95_CLK_TPM4                     (IMX95_CCM_NUM_CLK_SRC + 112)
+#define IMX95_CLK_TPM5                     (IMX95_CCM_NUM_CLK_SRC + 113)
+#define IMX95_CLK_TPM6                     (IMX95_CCM_NUM_CLK_SRC + 114)
+#define IMX95_CLK_TSTMR2                   (IMX95_CCM_NUM_CLK_SRC + 115)
+#define IMX95_CLK_USBPHYBURUNIN            (IMX95_CCM_NUM_CLK_SRC + 116)
+#define IMX95_CLK_USDHC1                   (IMX95_CCM_NUM_CLK_SRC + 117)
+#define IMX95_CLK_USDHC2                   (IMX95_CCM_NUM_CLK_SRC + 118)
+#define IMX95_CLK_USDHC3                   (IMX95_CCM_NUM_CLK_SRC + 119)
+#define IMX95_CLK_V2XPK                    (IMX95_CCM_NUM_CLK_SRC + 120)
+#define IMX95_CLK_WAKEUPAXI                (IMX95_CCM_NUM_CLK_SRC + 121)
+#define IMX95_CLK_XSPISLVROOT              (IMX95_CCM_NUM_CLK_SRC + 122)
+#define IMX95_CLK_SEL_EXT                  (IMX95_CCM_NUM_CLK_SRC + 123 + 0)
+#define IMX95_CLK_SEL_A55C0                (IMX95_CCM_NUM_CLK_SRC + 123 + 1)
+#define IMX95_CLK_SEL_A55C1                (IMX95_CCM_NUM_CLK_SRC + 123 + 2)
+#define IMX95_CLK_SEL_A55C2                (IMX95_CCM_NUM_CLK_SRC + 123 + 3)
+#define IMX95_CLK_SEL_A55C3                (IMX95_CCM_NUM_CLK_SRC + 123 + 4)
+#define IMX95_CLK_SEL_A55C4                (IMX95_CCM_NUM_CLK_SRC + 123 + 5)
+#define IMX95_CLK_SEL_A55C5                (IMX95_CCM_NUM_CLK_SRC + 123 + 6)
+#define IMX95_CLK_SEL_A55P                 (IMX95_CCM_NUM_CLK_SRC + 123 + 7)
+#define IMX95_CLK_SEL_DRAM                 (IMX95_CCM_NUM_CLK_SRC + 123 + 8)
+#define IMX95_CLK_SEL_TEMPSENSE            (IMX95_CCM_NUM_CLK_SRC + 123 + 9)
+
+#endif	/* __DT_BINDINGS_CLOCK_IMX95_H */
-- 
2.37.1


