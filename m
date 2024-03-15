Return-Path: <linux-kernel+bounces-104223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E96487CAE6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC87A1F22B0A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71E3182A0;
	Fri, 15 Mar 2024 09:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AiraP94u"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2042.outbound.protection.outlook.com [40.107.21.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF39117C7B;
	Fri, 15 Mar 2024 09:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710496553; cv=fail; b=AxSRvN5z9a893G/4k6tAupPN5d6tTAy3tJ/5K2/voKfB8rbTVy0Bx0bYc30foqrXTuHzgOaokCaFiXob/TL1YCcSbbS3XCiKvDoidpdVHTJVyhmrE0ltUBE5+4tJmKmsfwS49VKJ2qSj6ML8B3Z8YrtinWxXjQ4ihLzHnqXZ5hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710496553; c=relaxed/simple;
	bh=ORjX2g8XBW/2RFUP1gqMgChiEzjaTc7a3k2uCiehxIY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FCPdISmmcsHxWdlYfZDmexRrxA+HCMWQvaNbYmmMdpHjX0xjDZjyn7Xz5s2Uxvty9U2uI7XwTKQMfI/S1GETjMnfjb4TMoBjCdQeput9b0o6uWkB3QUFN5iFnUoqt14XbHwtcPzcZo00u8q/mLKbMyuYv2czEe42VCdqENIafrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=AiraP94u; arc=fail smtp.client-ip=40.107.21.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMXWdP2xWON1q/KdZDU6mMrV+fmHGlUk5AtsRKwi4Gcec+HDrlp+IG9HesoQ7j+XbzAbBwcc4zav9THh33/ccyfju5Elaxwou73L8U/jqi1Qwp0jEiT6HfaKUNqiqpSqGIcWkoPhJOCUc6/OdmtBx8qzNQvKdUU+SMgNUS0X4xcSiAGg2DaKASrj/c5IGp3GTiFYesNqjrJ+K4fWAIkiWfqEMgUOU4iDsWbIt8EsJOFW5PPe3jVYPLtFKTbjD3vDvTQG6WmITx2bVzzyf/Soa2ki7IvHz+lyFdwOXsxEYoZK2076X60ahWkYUUxvytg9yPCRellxvCFdev186H0mGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3xAxYC+/aeGs5NJwA07UrLuN8aKHuBTbTuCS4th7bM=;
 b=dRB4bw4gS8A/KzQ/eDg6TaJ3SEK9skNuk+dfAJWkbhpjqQsrDDEOeqeBk+HID5/zgVUbdFuo9LpCNHr1VnB45uGMvrHj5tr5We2+BG/4sDbZ8lI26YP9jiYbMuUBoaDPDxYdDiJwO8deZMO8PVEpgXeo4CYsGq7xc1zj9r86tXb4emtyaso2i1whOIs6WQDt/FUxLlOUp4MhdXO2SMEUeSgVVMLkZ723LYXCsot0Fp+zY+H1a27NDKQ+wunHtLAc/SFysl/Xh43IQsKahPDgkb4T70KCU0ZZ78IW1cfVLdMgqPd7hKJ2p5fvPc9Y6mQzuLFITVmjUkp4mAIQ9kgP6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3xAxYC+/aeGs5NJwA07UrLuN8aKHuBTbTuCS4th7bM=;
 b=AiraP94uPTGrC5Ms89xCq6qulMwJ6ko3iNP6mdnTns40KICp37dhu6fVkx8CTTKnS4dHIb/aOfcFtPJIJQOAasQJvCn5I+ow64HIoWxb4g6VqgzBltCuA7PHKUvGMIRnvyGh70lYudahBJNo0mW0JpdNSUQBJFwJMhCBJuRJZpk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AM8PR04MB7444.eurprd04.prod.outlook.com (2603:10a6:20b:1de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Fri, 15 Mar
 2024 09:55:49 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7386.021; Fri, 15 Mar 2024
 09:55:49 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: Frank.li@nxp.com,
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
Subject: [PATCH v7 2/8] perf: imx_perf: add macro definitions for parsing config attr
Date: Fri, 15 Mar 2024 17:55:49 +0800
Message-Id: <20240315095555.2628684-2-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240315095555.2628684-1-xu.yang_2@nxp.com>
References: <20240315095555.2628684-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AM8PR04MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: 50b38113-092d-495f-81b0-08dc44d61804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	n7mHdb1U+0C2j71aqWByc/2az1dQgKMoWIi+wPsjnBEbqn/xWe/5rdtSus2+M8rk1EbKsBFXm5HBAnlO/imq+fRJpX7h8h0tK451JVuSOBRg5mFpCKCPpWnKGOCfmCmqVz2OaBImygirPL0kuvbmRR/ONWJRYZorBoQh3iqaGfGULQUADwADpalHjejYXvMZ/9YHmRG/yunPjPdVjsLhxwhmJvB5PyURtzCEfLUEW7wNaD5JvKS0c33j7RDnUF9xD6NxgYtvXutC8i5UeGJXSC43YIIsg6WLamC/6cK+j2x4lZw1bfFis4oRjUhy0ilKdLhESrcHgKG8tUNmeDPUxDvMxURe1FWIyhnkHdJbRqVqUgjKY4orQthDxkC8IKOTOSeRf2Sl7G6Uz2c8NY5b2AJda/gL52lTffsXpBt6Q/hCKGF7v8V6pGjnXxYvTJD8GKfPGPDoQ9nolNjR2AqG5I3TeGiqd4qJoFVOLRhmHeSJDSGIt7ayr7UbRzsVMkEFf/5SToc+iDJoH3fEIZTLcJxWaz1hmKiDN+n3Cmv6oGfy7LhKdmbRXJMv13nnenN2ButXFUYghe+0UdbKvJyM712t+agvF2CaQNzRIER8UYUVREzNbt5bu1S0r9Z/SKOYuaegxHluueUnqMWKsX8/q51CNhSiYvZ5T0AFBX6Cz7qppAVUgCu2OydiWH6Fk6g27KnFwK1KqUw4+c/RVZrHCry3jM2W+yn6wf4L6bgy078=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(52116005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sd1n1wBIRsOyzoaHSOMU0+iZ1bRWrRxfUhzD9KApY2wBzhEG32Q7U8jVFmsN?=
 =?us-ascii?Q?+IMi9v88xgMTRTmtKr89axHSpN7/XjzprvLvtbwRRV+KRtyolP1Pk73/F46d?=
 =?us-ascii?Q?P+3yYCxvsgK3eeWM4sRNUfHRWdMQ/sdnMerqGj9mckibSVxdsKG19DpiyyXd?=
 =?us-ascii?Q?gPrgIMTH8BuG8yk02O9gb/idS6O+BOu4H8klZS6g7TDF78sjamnaITnrj2Wb?=
 =?us-ascii?Q?G3jzN3F0PK4sww4SU9KA7g7X8od5KytWqiuuRCRLTliYwpQKhqRCpKNg38qe?=
 =?us-ascii?Q?9IjYFBxqwqMly8qHiaqVR48FXSZURNFx/N7z9JRmgXmaqtBCPHuZGd0iS91/?=
 =?us-ascii?Q?fhn11vsBxPGkZheUOvCRH9zsdged4yVtWlb1fw5SiIQmHVsI+hNe+uh60X6J?=
 =?us-ascii?Q?l6UvU//FMa5IePEDMNC9yX9s/Fd9jVcOZor2IsUiPpZx1CFKkqH51rVuIKCq?=
 =?us-ascii?Q?MbpLyUUuI6inuVQ/4MPPX6eQ5fGUcrZ6BuGwEwQsMtAfwv1EHLcfDTs3IrfW?=
 =?us-ascii?Q?9fKOrbEJhwLX8AGboa9m1rd7jzULiPgt2E0WDQuBB+aiNpJh1dHbDUjBTFVE?=
 =?us-ascii?Q?IobaRm9xcuaUrYofuKjJ3RGHfYc6H+BVE/fNY8B3UA1xv3emyqS9VO8/fBuS?=
 =?us-ascii?Q?h4qjy+I3fi2diz+Ox4aUdU+xpN+kMIoACB2VmCdaaYwiSy4AhzQ/au16eyRA?=
 =?us-ascii?Q?AHP9ht0qU3b6r6k7ub9kVy3BphYqjRl2yBZeFJHFZpNPkznBPa3z26s+c9DJ?=
 =?us-ascii?Q?BzAaAq7pR3YTUUnHLHNXw1hLoO87az69IqsJS7gknUcuOVvTRrPsOKLkKDmK?=
 =?us-ascii?Q?xpmImkY7k4f9Kk/HOyqT+tuPS0KQMCjm/POYmr3CZ78yhDN76GiRjp8BL0gR?=
 =?us-ascii?Q?FG1UDoSqNWIgXsDgdy34u7VEdpdp6hZRpWucZ6Ad0xcK7J25BfWNJrU8zFZC?=
 =?us-ascii?Q?AwDa1u11OVHAse6moIjOVSSsIqzdE9XwwE3K9FF79tC+CYK6+f3VQ6nxQzCT?=
 =?us-ascii?Q?EkrvRa1xL1sD20I1FLf9AwpayzdttX8coK4weSN/ozz3lDJAZJ5p1lwrZnY0?=
 =?us-ascii?Q?073SYNryKS9bQf+nM+N+bWXXzefKpC1KtiFlsYEfzI8fP7IyZlbQ5LEv5hjH?=
 =?us-ascii?Q?TEsN9x/5PZVAUCMSn+mQeicddMTLlg4WORawvzC80IaXq8MbVIGYd+7uuYFM?=
 =?us-ascii?Q?f3E5YxcJB7BBQtU7Lma5VtWekj4xGCjUAmWPy1QWU+Q2RU3gf7IC4C7RNRip?=
 =?us-ascii?Q?nOOhDV2YK4oRDKQ2YSm8yhLqQEYvURmmMNcyCcwjrLjbB/2C0eTiQff/9nq0?=
 =?us-ascii?Q?jsIquHtBRkGEDey/93d6/h//olBqZGmuK2pDhA1CvmVCmzzq4Y0EFsGhV8XA?=
 =?us-ascii?Q?7QvO0reSp9SekwuDbMFdO3KEmYV0TRUS0RymNmvK0ryipNhJq3rx2xoL2mcp?=
 =?us-ascii?Q?RnpmqKQg4DJekmBVbps9GFLR78R+mDLCmj8USS8GwlTZaIwtD4bsPspr6ArV?=
 =?us-ascii?Q?8a4a3IE976TIMw4JTbpgQFfdQjEJ/NJZlkWyXqpOxTg499LQSwAGuGQmOZv8?=
 =?us-ascii?Q?dOHB4rx18nRSDY7ghDhQBqgw60JqvTElaCEVJS8x?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b38113-092d-495f-81b0-08dc44d61804
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 09:55:49.8222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f8+c5RGySY6UaoLoe7L9VbI7Vzok9gWyODTcqV7ZGfEMppJxvxGz/p6kpmxfQk0CC+dfHcbe092PvURsyAnqLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7444

The user can set event and counter in cmdline and the driver need to parse
it using 'config' attr value. This will add macro definitions to avoid
hard-code in driver.

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
---
 drivers/perf/fsl_imx9_ddr_perf.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 9685645bfe04..4ec70775d1f0 100644
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


