Return-Path: <linux-kernel+bounces-111001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBE08866D7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A508E2861C9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487A010A25;
	Fri, 22 Mar 2024 06:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NnZhO5eN"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2080.outbound.protection.outlook.com [40.107.20.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FAB10A13;
	Fri, 22 Mar 2024 06:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711089564; cv=fail; b=KehnfCooY/rQKv3UT54CcTbzDZ6x8/LsYavFdOjCDdsDHaR42ufmqx05TRQyo4QGpakXUDcFLoa+4nzH1/2FutPVEQYwa+a92EQH9JzCgEfr5NMJxD1gL7s9x4ihyo1rmHSHd5VwsgNxW7gKllxviALXg28/zv6bdctqmu3YjT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711089564; c=relaxed/simple;
	bh=zo2Jt1vz073eexaX5mA/e0MhHsAFjoMq+xefP9LyxIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aIYWsYWX53cZBPYVDlxV6oOl1nXOZEaaR84PgFXh1sOfy4oCHOkCH8U5jNSuMkOumR7Pao13Kcx023zyjbBq9d/qLMM1QTjvXhCy+LRt5bhPiLefezR8V1QVzKzwAZ3GjjUfmQcZlFiStw8Cc87O4W1WsWl4VxuW/TRK0axbhcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NnZhO5eN; arc=fail smtp.client-ip=40.107.20.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f9NbG0XVRgVi8aoQHqjj9l/0VtcIWH7jiMHaarvHzgdQXC8hJGTVaRa3QFwsER9bE75DRHvmcYBI6K6LIeD0fNw6piybj2Ba/OldIYskut0i4Gxo1Dd9A4AfIq/7JDhcxcJyAXMcuu3VaYRJWeVTegm3PHT9iEd+OnZuLfp9S+0xuwSilwjMFpUwcWyjqrhsBMRnpb6PdQYIxRjcIarMWXMc/zIQBpPgJUOa7VBPsMdeSYNoZAm0A8aSOVqr+FltTKRPR9GtY/dvITkQEZzZrdeUwxK0mb9+bUXw53423w3dVEfFgoj9GC45BfLa4gQJcSG/NBhRSLIyqIyDDfhbHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eh/24dzJXeksENJfGrTAVYplEbCO/6KdVTixG12Zko8=;
 b=i5bTzS7Uv8B6OdcrOriKG250LUGV4bXUae8pagjX8sVS4jxaXJjOSLqU86SLctESJKbrF8LzeOWTs+q97lxYdBmmw1YL/j7dgPMdEDjElkslPf577uNduw4T6bJOqLZpQKQdqIpONc8TsmkNv+FVUpViXPmzLY7/7F5YPx9jgYc9xVllukZHxFWHeFQPANYWfQT7zPU/BR84ObnP0uP5zFFaVVencFRz0GKXBD3M1QWRQt0YqziTiBLR2KSQqar5m+e/MDM7Dck6v9chBvPA30X2otQjJdKcbHprE2Ok1Lv+QmnIZBK7tn1saRkUTEO5JyDJcVZMPlNvPgKK9I8RHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eh/24dzJXeksENJfGrTAVYplEbCO/6KdVTixG12Zko8=;
 b=NnZhO5eN95ogikvzrG3mSb8tAkydQZZLyN2xe4umDw4Q9udb82czKFiSs7IQy1x6EtjybkFhtehp0S9+gHm9pWvrUBixgWEPnXxms2o1yOctIK7mbwtEetQNaLWY/OxW2mqtGqVa1YhRlDq9gRE3gpzdpPbt8f+6JL/OysDDOl8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com (2603:10a6:102:20c::17)
 by DB9PR04MB8091.eurprd04.prod.outlook.com (2603:10a6:10:245::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.15; Fri, 22 Mar
 2024 06:39:20 +0000
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::1b13:505:8d50:f4e3]) by PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::1b13:505:8d50:f4e3%4]) with mapi id 15.20.7386.023; Fri, 22 Mar 2024
 06:39:20 +0000
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
Subject: [PATCH v8 2/8] perf: imx_perf: add macro definitions for parsing config attr
Date: Fri, 22 Mar 2024 14:39:24 +0800
Message-Id: <20240322063930.749126-2-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240322063930.749126-1-xu.yang_2@nxp.com>
References: <20240322063930.749126-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0121.apcprd02.prod.outlook.com
 (2603:1096:4:188::21) To PAXPR04MB8829.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8829:EE_|DB9PR04MB8091:EE_
X-MS-Office365-Filtering-Correlation-Id: d1b1523b-065e-4dc2-02d8-08dc4a3acdb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2e657mhBG6kClTCzA2yCIr1A+ef53k96pIb0b9ds/5kDQm5yl1cXfcsaKiR0n5P5iISh0WSRoPVrlqqYIuASRjYyTxQtVMwJsPXoMNd6RcX3nwhvbIKHB7fdfwRJsnq6OR1VUwlI63UHWjNIEWFW4fB1QNuIwURKThuFq6vQPZeVz2LR0Es47v/YDdG4JsNrqSn7NEarQHwiWCaUjur5/oc1kci46sXQ/fV9PuGsspHC8HjTbylafNDOLNsDGOE4St3IXv/aHwPyTwZZw4NTDU06FeuKgiPKfPy/DJaM3XMU2ZEoJQENm79xmjWWouC2QmG2xd92UtGn2S/U2e6kCC/gFcCOGVtNpjegsPfr+RyDiSN3tEsg8trtW3moHA2FGR1S3r0LV78wxexy2akuw3Prv48AEOEj5l0Rap38NwvNIi3grf6WyVNgbtR1EJDLiYD9QvMu+fu0tYwrIiMk9g1F/onG2QQ6F1aScDQa4Arwsg4r4nJQyXyq3ghRkzs4QF40IJuh3X4As2j96h7sHrs6tYMf/ACM27AZRBWhbMEf8oxIUQPYgZxEsRb9p7Apz8E+qsPZIQUjY0l3C6Cj/SIB7Bt3s1gKwglGorJowJTScOOLG7/P1qTyJY4wNSa7Y6sMmrWjGGnu7OqTlBIgc6fl8ckbULzGl3TzdMch5EQicZ4u7evM+dDUdyIIa6p6CqNkafxBzjPC9YplK4S7r7aydwnBTxqmRkM8eDE0slQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8829.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(52116005)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TYOHe1uXIqkosnjq0qduxw+dF1Gi+RiO78W6S0P4ntQvK7Cfkk8hDrh2kyU3?=
 =?us-ascii?Q?dPJpjhko5O0jT0EpZ0S8CuuJW1QQlMBXUkQqpXW/mhESdi5c34YUpmcJ75Y4?=
 =?us-ascii?Q?7i7p/eneWVLfw1TK2yIlvUGrb2w0jwUhKY9rd+fWjsbTb1lZwewStzkpTxSk?=
 =?us-ascii?Q?oIq09pcs21mt/tLq1rFFZOgeUTctZ30KbgYh8iCtLD1w7al+3ndEIE4rxF3y?=
 =?us-ascii?Q?XsgoRRYmVt20x6smVTRQVZZjmtzzqaq4i2rKFoQwFUWjY11bm4dl19iZLU/u?=
 =?us-ascii?Q?UTQas1SFeAQcKZBsacX+nUPdZjmiUH+zzjjgZt+yQgcTuij7Vw+BsbY1Igvz?=
 =?us-ascii?Q?vZTZfgDdZffZ6bLxXqkQlmt/R+q0ZYS6IJ8flFAoRula3mIDKFN2831Qlv2p?=
 =?us-ascii?Q?nXS5THJShYjHKyWeG8htOvL3tEzRcOgYrForXDYpiwqc2VEgO34G2hi6tY0C?=
 =?us-ascii?Q?KyLnP9FSBoaeYDzfPc7eSH1mkAz0VK/UsdAxobftDyhgkGewo8u5yEoicnwg?=
 =?us-ascii?Q?YaRTNSj2DP1gJoNet94gIDTCZOIcWSqxZ+sHfhgD/lSWbk8LNKtADlMUJO74?=
 =?us-ascii?Q?mNSf221mYcxmOkpU61gp0aYHu3DQEwomlp4pQ66g45ZdSuan5uo5CebPN8GM?=
 =?us-ascii?Q?yAUea4zizb3PJlaohsAa3doSGE5XOfqzewvlvFhKMd1yIbHpYhy8aUl18Dc/?=
 =?us-ascii?Q?kAP1ryz+rfVSrV9u8yMJlHOzJ0ZmDEvjjwDu90Pe11FWI7XzJT/I2DKBMudG?=
 =?us-ascii?Q?SpWogh1DuNTAu6XoHhdLGQLixZFqmKsu2ZtgGUB6Mipwf2ilThTLvvlNnPVg?=
 =?us-ascii?Q?A+3IjY3fjefy/FmTp9pQAmsuRR7lXFnFQhMLwvNjy9NGOOGarScG9SeNHeds?=
 =?us-ascii?Q?QaN69s8iUX79ixIWpfQtzNwmFSFjv9NAOqGD16YdDZ3VnUMYa7CLeJSi50ZF?=
 =?us-ascii?Q?uSmi8N89StCweH1kGta9iVEHmUOUzol+GwfY7Da7i4z6DeiswFJN2y0t/AQQ?=
 =?us-ascii?Q?NPfSEhPhYo/OuwGsUH+XWhq38U0Fm4LcHNcSZZE517G09O9ma8UpHycdI4SS?=
 =?us-ascii?Q?7VlgoPQvlQo7y/FnEUUMQFfXbwmg/6EXS59aUE09UQmpw2llJpUhxdQL0m+7?=
 =?us-ascii?Q?8pX1LZRTrcrszmzzVYcGXDojMaL8MWw4/Y6mudvaDpw0UY6YSRvWdDXaCmxF?=
 =?us-ascii?Q?ld6snu7jynZpYMfYR3R61vB6c/azko5jKRXNcgPCxbrkR1qnKYI0iQ4E1zVL?=
 =?us-ascii?Q?mC9mGc4gHrmD8nbktEvd8ySRW7KpXhJ/kRJpvaMsZlJFoGhcVECrpuCBZRxT?=
 =?us-ascii?Q?AE5fkrXa8htW9GTGqljFp+VC/IXaUsKPF+xNvreoJDZXMqqMMRxkufnrOMb2?=
 =?us-ascii?Q?qICG87Mx1kQTKXfp568937NR+BMVw9/f9x77URKxTbCWeRW9GdqaowYCrk4u?=
 =?us-ascii?Q?zn7Qc8zB4JtFL7ltFA3hDXVJVt5OJBT3TK+cTJ71Y1Xv2NGKG0GU1Zv3tfWE?=
 =?us-ascii?Q?zNmWu8+4ER7XZCgYYpxn1XrE1EHYQBGESZQ7vb+Dso9JAagLk15XUDrV5ka3?=
 =?us-ascii?Q?ssrhj4Ydv9GmJEiWPKe4DO6anAlt+HEXc+t9caD+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b1523b-065e-4dc2-02d8-08dc4a3acdb9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8829.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 06:39:20.1660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 010S2OVnLjJR032Zgc61Ojld3m1EFj6yYgOMLHNGS2Bqt/A9XXfIJ0Xm1+E7JWWQo9V6yF/9CN8BZRTgnwkODA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8091

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


