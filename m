Return-Path: <linux-kernel+bounces-42515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7279784026E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28F05282127
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E993756473;
	Mon, 29 Jan 2024 10:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hj22wng3"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2082.outbound.protection.outlook.com [40.107.104.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC4858210;
	Mon, 29 Jan 2024 10:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706522913; cv=fail; b=pRqzJsRN5+vm8F5l9J92DZlNrX8W8LU1uir3Wmcyw2h3zZj29wGSODNgPSszJisJ7RYeRkyoyoyOYQOOk2vW1W6Vs4v+RNw+5Wi+j64ZIhFL2G7d330U9Gcy8DobfA23rSzPeDoX79/jIoGDlq3yur5ooh4/2Wf8mi3rPcw3Lpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706522913; c=relaxed/simple;
	bh=/ySdjZWqp9XtDff6/7dkVvL9kRRAm4O2ClHn9NIBMHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qAZtF/msE0J0l+/LrPTQHcADPvgtPyustmJRFLRN7wtcEhsxpbhla2iu242l5rIlXB27WAD8gIjpFxMGcw1BLncLSzlvRt1BHHDMxBBpL/ItxK/n77GRMai+QwJW7ZhMUAgfbFAGEuG8GG6Ut647IXIswlEl7M4U6LFFLzG74ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=hj22wng3; arc=fail smtp.client-ip=40.107.104.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiS79LuoyeM5KD//OMm8Qehqp669XgBSe7x/Vgmx6VqNs/7EGA2EkIUEy0++O4syQDB2akgI41Jfcr1MDGaP0/Y2ivWDPgJWToU8Hb4IvOL8YAtuiE5uO0duqAq4kDnTrZTVLKVifykzYI/neCo88aRkflA0gquk/kw3E81QlgNLQHnKJ18/PEY7sawzEmuY4gVV8IWE2vbGbp6g5RbxRcV23xcV4XCsWyPSu5iU7pvc2+rXQIh7J8iOOqcOW0xtIbDdPeJLAzmYwMarSuTTnGQ3c6c16d1sZuX68ZY2YSmEzOqszjMfo0sB0nCIYv1WVauey/t8eGV+K2iYoJEMGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VH67vWVZGYo7EPhV0ikqhQmb1QIY5MJM1dtpcRQKPNc=;
 b=A39Loj/jPw/0p8Ka80BFxUiz+XQerk5N1w4tf84SC/kQxu2f2lGZ4hjv510Uw0vCHapHwyqbeM9KJ5bVzRjOGR8uGKwlTpGlBcNhYbj1tMvzUMwYc13S/CB4Fy2pBhvoX2G3J+y0gHvNg9RaRGhJK6pBRzji3R6LzUwsmGa7USbV8S0+TDoMFCxO2AjdB4m+4TGX26yfEfKcrwoD79lbkf27JYG991UVkHvW+pBhi+YVQRFbzFRXrPUJ/xM4mnLGq6GspkY43UnoodRjZTw8d2MnwoSNBjnhmwpmPl2gjTV/0KAOXnfv7c+9XJCpfvvh5d/JhysSRNcMNiga4nIvMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VH67vWVZGYo7EPhV0ikqhQmb1QIY5MJM1dtpcRQKPNc=;
 b=hj22wng3DsqFbhJXUGZi9FZRvdnwwRXMFrc69WSyBLxbYjd6lKoSJak/h/4sYAERUn6NojGfRe7/iT4gwB5+SyVFJG6nJtw7nwQIsVVDI09ZL9ZvwjUOZeahWwhuaLfiHwv62eWVoAT7Ei5rKm373tDMsCJjQJOSTVGph4bnbAQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by GV1PR04MB9516.eurprd04.prod.outlook.com (2603:10a6:150:29::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 10:08:22 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 10:08:22 +0000
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
Cc: linux-imx@nxp.com,
	mike.leach@linaro.org,
	leo.yan@linaro.org,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	alexander.shishkin@linux.intel.com,
	adrian.hunter@intel.com,
	xu.yang_2@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v3 3/4] perf: imx_perf: limit counter ID from user space and optimize counter usage
Date: Mon, 29 Jan 2024 18:14:32 +0800
Message-Id: <20240129101433.2429536-3-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129101433.2429536-1-xu.yang_2@nxp.com>
References: <20240129101433.2429536-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|GV1PR04MB9516:EE_
X-MS-Office365-Filtering-Correlation-Id: aed0ed31-f840-4015-c7c1-08dc20b23980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wauBvAhKPj70Ep0KaE9xTUkBxiWVINP/Ut+lgfmUmumCNctrVi5J8o3X58Y8npFKP75iL/6jjC+qqkMQ6fvNCK/PcZJh1x3P0g3FoVlvrq+4TFvw1QDwfQnu9JPkISh684CK4NDeu+boB5+FwgkiwUXidkQzPS6A/ztbn4RAxRpUdR5jLHs1u603ueUCa6SIlLESwND68j/KW0Z1q7THwK47vjU9tf4t4Dh9do1BfExdLIOARO7NZiCbRP14jJIjClgQFXIBqf3nuJZVIE0OB5LK7gwbk2r5Gjt15H/PhMmkfLO6W6h93pLD19NNQmTq2IFS2a9y7+Rzc4ksPkCRBFAt4n8lUGp6XJ8qTw9ekwtGA31beeJdwxpm75CqiFRht9PMU7BaZJ2BUtsE1A/RaG7R4UR8QErKLxsuwgk2/EklkKngonIjqUryF3G+xp7ovoXjdWJn/SWXYHmZltIdof6VEFynaiIWfZbXq/wJ2Denv+mpSxh7jEOe80IuHHLzhZ0Rb9LvIHf2kPGoAH+L9C/cbchG2zltQ3/B3lR3QblzV2XxHVW6QUBCychbcKVKDKeh9fr0W6w54rPT19lXMlUXOf5Y1R9/Wnn8N7aHOGZp6SkIdNMeQMswtqfpQiqi2HpCihmM+2sgKsoAILWtig==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(39860400002)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(66556008)(8936002)(8676002)(4326008)(2906002)(7416002)(5660300002)(86362001)(66946007)(66476007)(316002)(38350700005)(36756003)(38100700002)(52116002)(6506007)(6512007)(478600001)(83380400001)(6486002)(6666004)(2616005)(1076003)(26005)(41300700001)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cliFCptmqn0O2rXVUYsLj5Yr17a1jJRC/IR4dTEKU3nEcLBghLp9dbk5AQ94?=
 =?us-ascii?Q?QN7/S4BOc16BGZKyyaH49IG7j/G15m40Oqc4Z6aqBnjwYGnFnqL6YCsOO1vH?=
 =?us-ascii?Q?YPudhQyIIDoRmMgpqF4BOD95YsHqzo9uwdZhR4iWtwzWSGIyiDifV/A9N93k?=
 =?us-ascii?Q?BeIYH33Q9NN547K8j+qktxwteP0fWwwrAihMWmgQvrcPqM0EErJgGQPDXttP?=
 =?us-ascii?Q?l5Whv39n6Pl4b4jR3SDZEGQqd4+iZ3t3hAtTgXYPrlEincy8Gbypa/PO3OTr?=
 =?us-ascii?Q?SQZTxhuXwuzbaLI/XRIKSy34qNTTunarngILeTnJ8eBdZcZIYoa4QtCKVEO8?=
 =?us-ascii?Q?81slsJe2fbpsyhQ3o8B0nDmnF5vEib/uGsOq/JOPDrtF2ro5rTuchCBKgjlg?=
 =?us-ascii?Q?RWvXZJm6a1yHm6sdrQqH9uXQqlkXg024lWFdZFzT1U3DWS9DrcW9r6ht6Hsf?=
 =?us-ascii?Q?bkZomqDiTu5MCZ13dVVFnL9Qch+B+DgvUWL4A4wJQbq2ZTgsfJ5TdQokUiFi?=
 =?us-ascii?Q?C/Xzd5PiZ7L5q5JUcjknqdAckLRvqW53TTzeyuWAGb8Gs0Bzma0UXkzRm4i1?=
 =?us-ascii?Q?ShIypqvAgHyOQAbrfpAGPmAG+SmWP2KIAfDLHTg14/LUjf1RytF9tw1geIyh?=
 =?us-ascii?Q?fNvTKlIMLY8S13wAUbZ7QN/9DBIby41vin/suK7m1AHXrxunyWvNAZ3Hc5GU?=
 =?us-ascii?Q?j3XEXbGMWdBeqmAUs41ArgTVGbOoiwjEIdM2eiGroBZC+wr5h++NKGgw0JAL?=
 =?us-ascii?Q?72t+SIcdEKjPezZqC5Msmkl8af0DRj64U8oDeGxDHCMQZgI9jYec13efE6G3?=
 =?us-ascii?Q?iWBeZriPGsPAhieiSUJne7ieoyO5pe9Jlau6hq4sOBC6+702Jw9AMlE13wy0?=
 =?us-ascii?Q?0Vp8YIKKXkynwmxriogXT4ygXlMvTwVf7aVtpkBuQ5ipS+96mQzTE1FKGwMZ?=
 =?us-ascii?Q?0LJB4UJThWeZdzb9Ie89Dmsjc70Wdqsu96+cfXdrEqcc6TPDR+bNDOkJpo7z?=
 =?us-ascii?Q?kbjrVAaO2WUgkA75jvVTSvNYGkzVf6jruImvAZPeMcgGEec2gYDus9ax8Evm?=
 =?us-ascii?Q?kP/yujejhy/IfS1uy03T1VemXA6Hyw1CWFDQTUexs1qRdfVC8tRrW3mxGnYl?=
 =?us-ascii?Q?HwCtCmnfz/pQnmyPwFG1gMPHpU44uutR5soELozk0eO+jcF0hNpPrJP5HeZ8?=
 =?us-ascii?Q?+BS4SBnMDJc24pXrNc79nUOI3+X4mrULA5fmABLs1pVYkBSy3SC4NOvYNvjv?=
 =?us-ascii?Q?GBVjunQXYC1KYiBvuknSCJVEBBdTu4XY3YLbPeS9HUWwx2CPTyBfSxWhaTki?=
 =?us-ascii?Q?CEdGJGsGXJIgcqmc2GrjrYdNzOaJrHDPZ+2BQ/zhLQ60cwHGYTvgpa2xdYJR?=
 =?us-ascii?Q?6kyAe93pZh6ev5UO3J3VNigJRJNfd9/G/88BRpqvQE3/o9IWlIkqn7HE8JN2?=
 =?us-ascii?Q?poDTXNG29pMPrNKnidU4L7UxFakzG8apfSXgCzvCYCNvwSlUO0QvymNuXsUa?=
 =?us-ascii?Q?ByjYWBtgPsdlC+nJ13jMisKWMMW1VsnYNN+n3FTcprMquatFK+Fty0TA+0ne?=
 =?us-ascii?Q?1JONWt2v5Kclz/Kvm86kUePiwy/EOO87xTC9zL7u?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aed0ed31-f840-4015-c7c1-08dc20b23980
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 10:08:22.3447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XC5LGdI0D/Q+xqJkkkgz7PxJb9XCrSpUyfrR6pTtb0BdvJzazylm1MJbnKFzTf3H8c5Vv1p722r6KWLSAzbq8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9516

The user can pass any counter ID to perf app. However, current pmu driver
doesn't judge the validity of the counter ID. This will add necessary
check for counter ID from user space. Besides, this pmu has 10 counters
except cycle counter which can be used to count reference events and
counter specific evnets. This will also add supports to auto allocate
counter if the user doesn't pass it the perf. Then, the usage of counter
will be optimized.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - limit counter ID from user to 0-10
 - combine dynamic and static allocation of counter
Changes in v3:
 - no changes
---
 drivers/perf/fsl_imx9_ddr_perf.c | 69 +++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index fd118773508d..4bb80050920c 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -51,6 +51,7 @@
 
 #define NUM_COUNTERS		11
 #define CYCLES_COUNTER		0
+#define CYCLES_EVENT_ID		0
 
 #define to_ddr_pmu(p)		container_of(p, struct ddr_pmu, pmu)
 
@@ -235,6 +236,14 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	NULL,
 };
 
+static bool ddr_perf_is_specific_event(int event)
+{
+	if (event >= 64 && event <= 73)
+		return true;
+	else
+		return false;
+}
+
 static const struct attribute_group ddr_perf_events_attr_group = {
 	.name = "events",
 	.attrs = ddr_perf_events_attrs,
@@ -507,6 +516,7 @@ static int ddr_perf_event_init(struct perf_event *event)
 	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
 	struct perf_event *sibling;
+	int event_id, counter;
 
 	if (event->attr.type != event->pmu->type)
 		return -ENOENT;
@@ -519,6 +529,18 @@ static int ddr_perf_event_init(struct perf_event *event)
 		return -EOPNOTSUPP;
 	}
 
+	counter = (event->attr.config & 0xFF00) >> 8;
+	if (counter > NUM_COUNTERS) {
+		dev_warn(pmu->dev, "Only counter 0-10 is supported!\n");
+		return -EINVAL;
+	}
+
+	event_id = event->attr.config & 0x00FF;
+	if (ddr_perf_is_specific_event(event_id) && counter == 0) {
+		dev_err(pmu->dev, "Need specify counter for counter specific events!\n");
+		return -EINVAL;
+	}
+
 	/*
 	 * We must NOT create groups containing mixed PMUs, although software
 	 * events are acceptable (for example to create a CCN group
@@ -552,6 +574,39 @@ static void ddr_perf_event_start(struct perf_event *event, int flags)
 	hwc->state = 0;
 }
 
+static int ddr_perf_alloc_counter(struct ddr_pmu *pmu, int event, int counter)
+{
+	int i;
+
+	if (event == CYCLES_EVENT_ID) {
+		/*
+		 * Always map cycle event to counter 0.
+		 * Cycles counter is dedicated for cycle event
+		 * can't used for the other events.
+		 */
+		if (pmu->events[CYCLES_COUNTER] == NULL)
+			return CYCLES_COUNTER;
+	} else if (counter != 0) {
+		/*
+		 * 1. ddr_perf_event_init() will make sure counter
+		 *    is not 0 for counter specific events.
+		 * 2. Allow specify counter for referene event too.
+		 */
+		if (pmu->events[counter] == NULL)
+			return counter;
+	} else {
+		/*
+		 * Counter may be 0 if user doesn't specify it.
+		 * Auto allocate counter for referene event.
+		 */
+		for (i = 1; i < NUM_COUNTERS; i++)
+			if (pmu->events[i] == NULL)
+				return i;
+	}
+
+	return -ENOENT;
+}
+
 static int ddr_perf_event_add(struct perf_event *event, int flags)
 {
 	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
@@ -559,9 +614,17 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
 	int cfg = event->attr.config;
 	int cfg1 = event->attr.config1;
 	int cfg2 = event->attr.config2;
-	int counter;
+	int event_id, counter;
 
-	counter = (cfg & 0x0000FF00) >> 8;
+	event_id = cfg & 0x00FF;
+	counter = (cfg & 0xFF00) >> 8;
+
+	/* check if counter is available */
+	counter = ddr_perf_alloc_counter(pmu, event_id, counter);
+	if (counter < 0) {
+		dev_dbg(pmu->dev, "There are not enough counters\n");
+		return -EOPNOTSUPP;
+	}
 
 	pmu->events[counter] = event;
 	pmu->active_events++;
@@ -597,9 +660,11 @@ static void ddr_perf_event_del(struct perf_event *event, int flags)
 {
 	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
+	int counter = hwc->idx;
 
 	ddr_perf_event_stop(event, PERF_EF_UPDATE);
 
+	pmu->events[counter] = NULL;
 	pmu->active_events--;
 	hwc->idx = -1;
 }
-- 
2.34.1


