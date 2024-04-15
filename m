Return-Path: <linux-kernel+bounces-144467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3E78A46B7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 04:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D32B8282E38
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 02:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E1DEEDD;
	Mon, 15 Apr 2024 02:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="i1TeOHaN"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2080.outbound.protection.outlook.com [40.107.105.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CE519479;
	Mon, 15 Apr 2024 02:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713146611; cv=fail; b=jPrmao1SKT0HdvkB+X7wHZCu3JcorzZCmXvVmJWR1IUT65UX3qNeuP0DEw4Cb2y4gJEeKtnuepNdqObuWVeeoviALj7Df5Si9BosbuZZp2KwTBByqyMq3xk1LBF1jAeFFlwOXreRq72na4JFIRUXD6AJe+WOoP0vQbWtToHtv0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713146611; c=relaxed/simple;
	bh=HvzLtPTBlMbNr4dThJLRjEZptBX6ZEqMSH0DVDnMl9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gPvMhYW8mLGjpR6N4anGqIq6kJZ+JJBHnU5TWq+2AB1VJCK0pNBYiKaTZ0B9Ux99IP+2kOON1Q5Wof2ZnrEObq5Rjp7Ep9qrdp3p4gJr3IIfHVz0R18B2y+FAiFSdtNjqbW1BxH9X5SzCBdbJPXv6PBaoGk8DViAmKlZkp7kExs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=i1TeOHaN; arc=fail smtp.client-ip=40.107.105.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KwFMKcgUdBXJU3mNYnSmKZmZbOWSfYtSyQaDIejug0EhAgUmQLMGyu66j8B68iWB+ytf9nWi1OGnGHWgvoEIO3rpHpkezLcd+fUUyFbM0w22qOOLGdReNYLPCSu31A2qMntm+g9gRDt50qMpF2hWu4Imx2Hnz7hsq3WW3XOwJfnIp+D40abVHvradGgTkv9meCrFiXHR2bB9jD3su5KAyGviLdhIBWK+M1Wajm5TZzhNmDjmU9CtWM33/RMlk0CmnITmEZP8zq6crcifBwLzbfJhIJ6NsxdZbVitrvFBCoGoljKfLqrWTINt0vhMLb94xo4bmEpE4tEa7ORtCU+rAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvDjqHs60Uql4uWa1FwthIEeXtJnSLRhqLXAGL7n/io=;
 b=gDPIwC+cRaTQYy76tylVfNqDuCmhvf/a3ywQlCUp9ronXFd7bEmhUhk/cW4rrlqTZx8p9T6LAeQRjgUB8ClxIvUWCNueR1zGHjjhZHQdh/zQWCzvCKtai2tGhAtCwOhsv4ummqQ9P0H7CFMyGZIleitTSlZBq1zuq6NXB3N+L+9d6p3/P981jr87AtFkXaAs3f9c+OX6U812pSQiZUz4qmFZeNPLlbrfvLz9ZoWn6Emk8OYthEXy/xsZUEeshyoOICiFixBZnFXH4t0lkNEmkbX/aEABnVbe/gtNjHhbopeBTKf9xvGIj89JF9SbiS14BP7Y052kyBWQ+y/h2h1d9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvDjqHs60Uql4uWa1FwthIEeXtJnSLRhqLXAGL7n/io=;
 b=i1TeOHaNhs132SYivWtQtOtU+K1wyoLDwyH9FsLisJshV4LusOzsak1jH5fPeJcX5N0aFcH+euyj6sF+d94Pwd0Erix7sHVA+TWFz91j6AGXiKTOeb2RAz8WVdR3jkxrpPa/TZJE7nKWJzhMS9muN4RbhgJXyj2VB5DdMyGUHfs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DB9PR04MB9233.eurprd04.prod.outlook.com (2603:10a6:10:361::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 15 Apr
 2024 02:03:27 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f%6]) with mapi id 15.20.7452.046; Mon, 15 Apr 2024
 02:03:27 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: frank.li@nxp.com,
	will@kernel.org,
	mark.rutland@arm.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	john.g.garry@oracle.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	irogers@google.com
Cc: mike.leach@linaro.org,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	alexander.shishkin@linux.intel.com,
	adrian.hunter@intel.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v9 2/8] perf: imx_perf: add macro definitions for parsing config attr
Date: Mon, 15 Apr 2024 10:03:47 +0800
Message-Id: <20240415020353.3833367-2-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415020353.3833367-1-xu.yang_2@nxp.com>
References: <20240415020353.3833367-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DB9PR04MB9233:EE_
X-MS-Office365-Filtering-Correlation-Id: 570624e1-a3de-410d-1e22-08dc5cf03d51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CYnfNkgE4meR5U7piW27SdEuVIlQOvYWo05bJT5PWvoqMa67CAazAf4RgHknyUkdPKZR+r+YVLNRPOC++OBWX+NEc5waeqff2JeyCKX5xzuyqzXtIp0/SvfzM42PdZIp8oCHcoOlrxwRXrUYtLstA5rWpLKvOrvTevq0GPmp+C9ZP1hxejBHOH15IYQIiqSi3+6negjYSJjQNdMlOQAD36YxKBQaOkMWg5LCI/nEQtvFFjYMh39haB7VC7v2RjTp+hActbo4ovl5f1U/AqLaED3An+PIp2s57QtHxlwCkpsc1AGrFSY4bFn5McT5qtW84pMYwyOcJVAFnRcDezv3hFSNtOCOeApafauWqnjn2Au4RNm7bhzSHBNKqhGO9TYrZSNP++iFvNkuETuy/HDY1Dl3okbeTDlw9L07oETabxtXg6S4gnXRfwI+k3mQw4dEjZtL3LA4pHoY4pmn/nC5nA3i0FTebDT6dIK9RQUbJI1MxeCRgWf8R9Sxsv+v1ihdlO9wO0j3JYj2w+lFtKafM/cuJmLY//yo2fp454F+HgsKMEoUi/fVqUHMAdcPw3zzREhWV5MfJ4KFxKGeXfcqQB4adiTNQP5OmyGzFEG1jYjD8eefkhlD1jgrAMTdEI7Ab9O3Dol2zJsD0NYwmkiiGHsB3ph50oKxM88rIGip4tsBUpc+hTx4AODYGGk8EBwq9tNTiUHraD4E/JDXitze03ilbGJ49jsUgZBwPJbLtDQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(7416005)(366007)(376005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jn3rVldFyrWBMeNOTDnLCnelrAm8gtsa5ig9b5JcjdgZyOk4cv5eRMkhre1a?=
 =?us-ascii?Q?pIPSgOcBSvD/8HXBZ2LhGqSL49uO5he2Lc3GkkLbmyN0EoJd4LQo2+rpDguV?=
 =?us-ascii?Q?uW6PR2oFBEKA+7mowSCSVK3YRc0kCipmBgt0qTd27ChjpLQNthLqseQdVU7g?=
 =?us-ascii?Q?JNC5Vtdyw3el6AItcucyVPsiKaAiG5AMM6i3PzomsuLmOzAK364JyMPQ/hX6?=
 =?us-ascii?Q?+9CHXY04hprCkSzAiI8Ye0+Pk5VvZEWWrsY68mxJe0c8mhJSzSAc31hyymUg?=
 =?us-ascii?Q?oF4vUqSdgCU0zj5SGeXSslG7SXxnt6IiT5wz0LNAS9YU8BTFp277gQRAd2gx?=
 =?us-ascii?Q?GxLroegRj40h34WNGzPS6nnIf5Tas9V79O/jjgDTiMGheeZEp/EvluH1PgaX?=
 =?us-ascii?Q?Rn9DnzMqhZQxsM8WJJXmJ9ENzgkEluAjLA8TYYD1jE/w2QxY3tLPVjPAJXfP?=
 =?us-ascii?Q?M5RTGFf1xntWy4drzCLBUa+2MatpV2JGt/S/alNOqo5kqwnpfBWTa7weD2f+?=
 =?us-ascii?Q?7qyceszfC/NjT3M4pdb6M1gaICOOuCBT2Bdyz4j+vTVp4Ful3Ma0b14eqmO5?=
 =?us-ascii?Q?Lmd5KlcjuxSkMVkqZXn1r9hB3MOV71i8V7V1E63h9YS3riL9MhyKPDj0gbN1?=
 =?us-ascii?Q?3HpYSpHF8d0xulnoQdKdRqa/EWlltHph4BXYLUe8HxneEga9vEDSRoKr+SwZ?=
 =?us-ascii?Q?cTGi6rnlcbEl5gFdNZ9U1P+rwcmly8mozui2T0aTn8EAEq90wPb1NccdgOt2?=
 =?us-ascii?Q?yBWwZjr2+ujDNEBnLZluwzVfVx26SmvlMs3Cv6GfkEjZ+adinuDcv+hMIRd7?=
 =?us-ascii?Q?JiXiqJpZ/RZ2bCVPvvINVY2FRCE3r4db+65kH0dSjFZqEv8it2+7JV/TOE+7?=
 =?us-ascii?Q?g5RTfQG634bc7ZaVxHlZvd8QRXSHtmYeR7GJY+Iw4Vr9Ul5XR9Jn5HG4THlD?=
 =?us-ascii?Q?LKWkDbFMbbAWuoHge9Qx2nW2nJT8Qk3EXLgThHUiOD7U4yZQcMq8WDW5OzyX?=
 =?us-ascii?Q?Vyk/ZYoncMx5p/Apig08icQFcU9YlQ1R4y9H+u6dlKRMLQfepiwMRQk5Hz9i?=
 =?us-ascii?Q?pDFs8Ejvipl1rqbpBo6trGebCfQxKNJHpU5SS48rQbU363vWSV/GIm4eMypH?=
 =?us-ascii?Q?u/qR/D2cpXya+0gH3OgZtBgVZOlIH0Qq6gKGJj/tuSzn4wQroqIAkxcGdnW4?=
 =?us-ascii?Q?UCNuRgppNow9Hc8H1DskecToSP53rqXhmqG0iTGQKsWDrcIv17JNppPBAbmv?=
 =?us-ascii?Q?mbBBpPgI2OMwxXTSEW/fm3P/kJcBkASFzNpUcXC2oeVRY8PWKClSmFzAzasY?=
 =?us-ascii?Q?kLxrYrhhYmQVwHyXrUWhLMYIsqjk9FwnskJOuDdVyS9oyIxd2umv9sHGnCqZ?=
 =?us-ascii?Q?AChuiQv39ODXH3HM5+ckTGFIWPLRPVGS6KBoc3aWo0pQ9ZnNVvM5Lqy9pdDf?=
 =?us-ascii?Q?EjxgeSobvskCNRbSB8s9mGWRbNPhzRB5fFF59GJO7G/+vo/qQWzIJpmpqHoz?=
 =?us-ascii?Q?bRv3iNxo4P0i2WmNKzmok+69Tiz2NghEPXCuTr6BUIoi6czOQfkdJY+a5MR/?=
 =?us-ascii?Q?joW06fPa+ITZ3c5gi1rsYnhZTggaMY7xXNybZeRi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 570624e1-a3de-410d-1e22-08dc5cf03d51
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 02:03:27.2948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2jE1t4mjtrrKDS41v8LVIJ19JwrygUZUdu4qlzsX8tOUMKUIm9l6mTLiv9F5BQPqXmXi7oLDE+IIqRT8wYOtRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9233

The user can set event and counter in cmdline and the driver need to parse
it using 'config' attr value. This will add macro definitions to avoid
hard-code in driver.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v4:
 - new patch
Changes in v5:
 - move this patch earlier
Changes in v6:
 - no changes
Changes in v7:
 - use FIELD_*
Changes in v8:
 - add Rb tag
Changes in v9:
 - add Rb tag
---
 drivers/perf/fsl_imx9_ddr_perf.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 72c2d3074cde..0017f2c9ef91 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -42,6 +42,9 @@
 #define NUM_COUNTERS		11
 #define CYCLES_COUNTER		0
 
+#define CONFIG_EVENT		GENMASK(7, 0)
+#define CONFIG_COUNTER		GENMASK(15, 8)
+
 #define to_ddr_pmu(p)		container_of(p, struct ddr_pmu, pmu)
 
 #define DDR_PERF_DEV_NAME	"imx9_ddr"
@@ -339,8 +342,10 @@ static void ddr_perf_counter_local_config(struct ddr_pmu *pmu, int config,
 				    int counter, bool enable)
 {
 	u32 ctrl_a;
+	int event;
 
 	ctrl_a = readl_relaxed(pmu->base + PMLCA(counter));
+	event = FIELD_GET(CONFIG_EVENT, config);
 
 	if (enable) {
 		ctrl_a |= PMLCA_FC;
@@ -352,7 +357,7 @@ static void ddr_perf_counter_local_config(struct ddr_pmu *pmu, int config,
 		ctrl_a &= ~PMLCA_FC;
 		ctrl_a |= PMLCA_CE;
 		ctrl_a &= ~FIELD_PREP(PMLCA_EVENT, 0x7F);
-		ctrl_a |= FIELD_PREP(PMLCA_EVENT, (config & 0x000000FF));
+		ctrl_a |= FIELD_PREP(PMLCA_EVENT, event);
 		writel(ctrl_a, pmu->base + PMLCA(counter));
 	} else {
 		/* Freeze counter. */
@@ -366,8 +371,8 @@ static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1, int
 	u32 pmcfg1, pmcfg2;
 	int event, counter;
 
-	event = cfg & 0x000000FF;
-	counter = (cfg & 0x0000FF00) >> 8;
+	event = FIELD_GET(CONFIG_EVENT, cfg);
+	counter = FIELD_GET(CONFIG_COUNTER, cfg);
 
 	pmcfg1 = readl_relaxed(pmu->base + PMCFG1);
 
@@ -469,7 +474,7 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
 	int cfg2 = event->attr.config2;
 	int counter;
 
-	counter = (cfg & 0x0000FF00) >> 8;
+	counter = FIELD_GET(CONFIG_COUNTER, cfg);
 
 	pmu->events[counter] = event;
 	pmu->active_events++;
-- 
2.34.1


