Return-Path: <linux-kernel+bounces-144468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC528A46B9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 04:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33785B22A47
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 02:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9ACEEC5;
	Mon, 15 Apr 2024 02:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dk4s9DmG"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2071.outbound.protection.outlook.com [40.107.105.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6533B1DDF6;
	Mon, 15 Apr 2024 02:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713146619; cv=fail; b=pIMKWM5118pht5JVVMFzVXBK+mLeoz5ZjXDOFS9bIdsIgY0xJt5pijdMGiD9qkaCV3FzThXWUsYv450FeliLucdgQ7XZksbJGjda8sKTTCvwd92eKt3I9r58rdgb+sG26ak3FS8y1VsxIj5aupRaOYI2UoTItszaH9BDR4zIS0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713146619; c=relaxed/simple;
	bh=J3NAgQ/1EDqC1xY5/S0sP3XrxSIIMqNpioNe+08Aj7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oEQnaOsuUZ6rI/W5A7GiZRUXtF/7LZ12wgT3fHKLruWse2qiZ73VE8QpHCy3289NgpsVFxsCWhpT7IP2QanEiKYgtC8fp46nlmSjSzAi0M2XK37XdewKqd0kHVNH+KKmRX28ETR9+C5V+NT5Y4puONgrAl0uJFmlDsvJ9akqXFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=dk4s9DmG; arc=fail smtp.client-ip=40.107.105.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6csl8WbSSkxpa/WD5i2GFbo9HI0fALLdmlcJXkEhMXE3SdChtqn999axtPrtBZaf/aLb4QA0K2Hw/JjZR8iQ7oX7v+7AIZuWZkbHksanQbqqEagXQmQTM1S0QxJTcGkWF6krMBy6ksmy/JjjNGT/iSv+Zr73el90q+HCrrGmL+zsLmMzOxwwx2OLEBYAZ4IcNCcErKnCjqvKzN1ovhuWjmvtA6UQJBy3PpxyKe453JSsj54tngWXHk5JCS8jEI/ntaOV+Cvgcn/a9HIRhIzHf/Duy5UMIbmDmyVBlCeQ/1N+4539SY8IyNWmo3iGiuUXiAEVOdIeQPH0m/dCAecGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWveXjTGiSAZQYTWZh8/htfvtYLQXYzpgbdrGQpMwPo=;
 b=AfcPLNk/KUsHpvKiwm7F+0EMdO4ukXElbQ1Dwx8cjiswSsEhMEYg9HzPo2hfLqXNyh+qCGLR+pizPXBQ1D4aDUmHB4LKkVSBnc2ZdQz0LCEesJDVRuScoT1ZchoVDLznOiYRrFP0wb6K3Z4uaD8Bdcabx3iTQX+9G6KPi+pbw4liZvg5Dpo2tS3Wu9nf9Q+ZPjk8vegRBRB/jdIwDvQrZmPZmtIpQvfZq3gEECu3Z7HFvVO6zW0GQrki8PLlChQcNJMxqOa/T1VBG4a+49IiNY8EkYH2rRBWsMDFNVapjAABxobTKRB3Dm4WrYPTv3HQKGWqH88evddydW+Xie/hiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWveXjTGiSAZQYTWZh8/htfvtYLQXYzpgbdrGQpMwPo=;
 b=dk4s9DmG7TSmGFRXWEX0+VUvkjrJ+WF8Cey1eNCP6w4Uo1Id6gFr1IT4tP3rijkk6Y+ehP01jv1oeiMsU+V3pzeuIe8SNMWLBM/rXv5vPxOhXZg6wfQU8eNxlDyH6H4wA17gr90nab7dholqwPshW7kAwcyF+xokq2yCwwEjeLM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DB9PR04MB9233.eurprd04.prod.outlook.com (2603:10a6:10:361::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 15 Apr
 2024 02:03:34 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f%6]) with mapi id 15.20.7452.046; Mon, 15 Apr 2024
 02:03:34 +0000
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
Subject: [PATCH v9 3/8] perf: imx_perf: let the driver manage the counter usage rather the user
Date: Mon, 15 Apr 2024 10:03:48 +0800
Message-Id: <20240415020353.3833367-3-xu.yang_2@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0bf97d51-c22f-4419-4981-08dc5cf0418a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZQ44tF63LrEVP5lKAkbfQEVcEkGPzE1aBvfSYVoufAjhkCaywMMa6pF32MUSyhHdjQ5TBdh5uC5pmPqgaN0Uyo6IBFjwT+t8wvr6X3+vq993cCeqmxWaAsiyXrklOMHAGt6J4vC3teUhWqCtaLdw/gNtzB2EclTa1AYj00YxZOm2MRz1sHHzjGNjTDVQrV+9vtUXuux6bjm7PaTk7xqedC3bgK3u34nSPsL/O9KHubsCCm2jTJVsTsF4BMEwLeEur/ExZWAyfXqsMjJ7nkpyeq2LQEVSMk8cM36YgdlIaUDfyXIu5h8tatcbJm6JkUTtCGNBA81RfjJIqEkTo667gK5YJjwvQk/SH+inrjPaoMrwEnYJyt/utu9XcAMVbuz+i4R3mzGiw4FdsPIQWLlVFVChal338804e3uSN7J6PRzq9OnQOj5Wkx60PtvorGWxzUQaGiWccI0IcfI0kEwIvW2gujvp/q92Ylc0gdaxS6fC3XZZHzgX6rfyLheHrepkG4u37s1hXqHuRkgVlGMZ/aXTDRmLdWmFrTt1BKe2wqQQW7ctyiMNmcSrqOmG4Ck+0k5srbrGOzc6X7vQwV73Rmzt37rYyQU82SfbegPnb+7lu2mgsgSosisi0x0E55eZtYGAjtyQSi4pYF6/M4WmAuiyuocXWO9sNz1n79h9EHN0bUA0KGVr1J4+qPsU+T6dXU27dOBMu/xoN9+ThRCEClekwl9KfH8qXSkqcHJbZhM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(7416005)(366007)(376005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LqpK2s2NsEH8cvEawGXIgxq9bkL+atlNey02+dH/JFyLxqtA49dNsPeR293+?=
 =?us-ascii?Q?aGCV9h7hBJjIZaoeubJGNL7yj0rolkEf/BBVFvyURWwsudJY0d7kpnzkuhBM?=
 =?us-ascii?Q?DAPAAozCe9ETchntEcd02uzPJ7NccrcmOCcuY/vzt5TlKh0zrXrtvlJDseR8?=
 =?us-ascii?Q?B3thXAjO/SY3gs4J56te4ZNvv9uOvs/nh90cGbntZn59LVBmgXaJ0KQwJltl?=
 =?us-ascii?Q?aeU0DGXIODazg7GveIlRHcNQQU5iU9dPGb3pGOszbSO/COuOJWMKkcmASa5x?=
 =?us-ascii?Q?6KBonA2Y3QUDmCLnlNimCxx7BeGj1XKLOQ4RHwoCVIEU4UfLkLazbmIc5v4B?=
 =?us-ascii?Q?1hH77PR3UslWcpt+chHd1RW4cp/Ii5V6StbH3iDTZAp0/nagCidn5slrL3oe?=
 =?us-ascii?Q?TBGNAaiOgYtpcHx2ftUJI0mF50S/8aE7kMRH4ffV8vYvYEHTzILIckHivOkw?=
 =?us-ascii?Q?nIdxN9NlZYfocHbcW03wgTZ6HvCahkCIv8+K4AOB/0NWuWu9gWNd53hOnfTg?=
 =?us-ascii?Q?KzkHT4hDg+HJVADDSLuAT0T8DXyD1RZIpxGpRc6Kw37nL95IfAXj1S+IpuZz?=
 =?us-ascii?Q?8VTaQomA1VLdgzzB/sURf3Snxx7uTlyg2YH/U1Nd0p+7xqPFDd55euTQiec0?=
 =?us-ascii?Q?IiME/h8hw3jQY5ChfH51+WRKWDaAexALrS/nrEpC8aOC4evrnX333z2g/tVA?=
 =?us-ascii?Q?plAg4LT/bfyHuuqkq5EaDbghV6Q/Pb8lNpxCBzXZNticfwQrblGtRrPryWS4?=
 =?us-ascii?Q?979pjVfTVCN1cKuTOu9LsqT2DO2h4O0cJ8y630iCCkTH6SU1O2J+kOyajIq8?=
 =?us-ascii?Q?MUtbQM1VGYUTNVoXbOcnGVgS/i7cEdzWjzPTvROKud5Ef7oamotVIEErAB7R?=
 =?us-ascii?Q?jVJQ4SE7p3Sc3oXCwQiT+yeMBOvzPaKcrGKbljIW+yWx2xiw7Z/3GkaAWKt0?=
 =?us-ascii?Q?fAfvteTFcEsfEiwmAeEWGY5q47q7JlCZhw+t9mvOG64PpVMdgiX5xUlUJ8Cn?=
 =?us-ascii?Q?ub//Y5jTKZBNg2ZDcPxSkRjR5DI1y9QyHtaHtXKfhYopT5ICUz5oYBdyeKqT?=
 =?us-ascii?Q?NvbLYxGV7VmOJmBlS6Do0JlTBPk0jxemFqwd5ZN6F57ZUl/gUue9j8U3ShUR?=
 =?us-ascii?Q?RtqQh1EgsqxEdd++qArcten61xH78vrBYXSOCniKg0KTbvx9WTdLBMzK5sCe?=
 =?us-ascii?Q?XqNeQbUfEGyRbcUdBg8sUHjDaY9sxR9KeTf/34RBy2yeAXeT8Cqt4Pahvxx0?=
 =?us-ascii?Q?10TTIAZmjkggIJRyQW6sYGubiH9qTWqzH2y7PiNROqZetT65Z759PtE2HC1n?=
 =?us-ascii?Q?BMjM044ODzZhLrubWvGrlxdmgdnrq360YCiyP6jFQ2vLgnIvNCOhWhT74+aw?=
 =?us-ascii?Q?pI09GKiCivp+nsfs/2Yv/5oGAw9RE20wr8K+H0zK3MSvUfYJMGYfvdcKA4LP?=
 =?us-ascii?Q?13v5CyeURkFyFJ3Bdxiy3aRWvrZyT35al7wOWXvjZxu+sKvhlGSMD3KVAjqF?=
 =?us-ascii?Q?bJyF413FaixuU+bxUE5q5LDn1msPrKww+7tnBMIuQOxt8Mt1hR/b9m1e6L6q?=
 =?us-ascii?Q?Q5AfoSbyusE1OY0UnOSyKlC1mDSFnY0WujwzJ+yG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf97d51-c22f-4419-4981-08dc5cf0418a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 02:03:34.3159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7zK/BEsQfP4BOJYLyn7S05vS/RMEd81NKsqXtqT1hbOLUvdiqBp01m1lfHnIeQp5PmPFT80AmplMNwF4CXUV6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9233

In current design, the user of perf app needs to input counter ID to count
events. However, this is not user-friendly since the user needs to lookup
the map table to find the counter. Instead of letting the user to input
the counter, let this driver to manage the counters in this patch.

This will be implemented by:
 1. allocate counter 0 for cycle event.
 2. find unused counter from 1-10 for reference events.
 3. allocate specific counter for counter-specific events.

In this patch, counter attribute is removed too. To mark counter-specific
events, counter ID will be encoded into perf_pmu_events_attr.id.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v6:
 - new patch
Changes in v7:
 - no changes
Changes in v8:
 - add Rb tag
Changes in v9:
 - keep 'counter' attr
---
 drivers/perf/fsl_imx9_ddr_perf.c | 164 ++++++++++++++++++-------------
 1 file changed, 98 insertions(+), 66 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 0017f2c9ef91..b00cbd920c0d 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -41,9 +41,11 @@
 
 #define NUM_COUNTERS		11
 #define CYCLES_COUNTER		0
+#define CYCLES_EVENT_ID		0
 
 #define CONFIG_EVENT		GENMASK(7, 0)
 #define CONFIG_COUNTER		GENMASK(15, 8)
+#define CONFIG_COUNTER_OFFSET	8
 
 #define to_ddr_pmu(p)		container_of(p, struct ddr_pmu, pmu)
 
@@ -130,6 +132,8 @@ static ssize_t ddr_pmu_event_show(struct device *dev,
 	return sysfs_emit(page, "event=0x%02llx\n", pmu_attr->id);
 }
 
+#define ID(counter, id) ((counter << CONFIG_COUNTER_OFFSET) | id)
+
 #define IMX9_DDR_PMU_EVENT_ATTR(_name, _id)				\
 	(&((struct perf_pmu_events_attr[]) {				\
 		{ .attr = __ATTR(_name, 0444, ddr_pmu_event_show, NULL),\
@@ -162,81 +166,81 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_pm_29, 63),
 
 	/* counter1 specific events */
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_0, 64),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_1, 65),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_2, 66),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_3, 67),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_4, 68),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_5, 69),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_6, 70),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_7, 71),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_0, ID(1, 64)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_1, ID(1, 65)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_2, ID(1, 66)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_3, ID(1, 67)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_4, ID(1, 68)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_5, ID(1, 69)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_6, ID(1, 70)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_7, ID(1, 71)),
 
 	/* counter2 specific events */
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_0, 64),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_1, 65),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_2, 66),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_3, 67),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_4, 68),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_5, 69),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_6, 70),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_7, 71),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_empty, 72),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, 73),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_0, ID(2, 64)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_1, ID(2, 65)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_2, ID(2, 66)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_3, ID(2, 67)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_4, ID(2, 68)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_5, ID(2, 69)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_6, ID(2, 70)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_7, ID(2, 71)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_empty, ID(2, 72)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, ID(2, 73)),
 
 	/* counter3 specific events */
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_0, 64),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_1, 65),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_2, 66),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_3, 67),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_4, 68),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_5, 69),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_6, 70),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_7, 71),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_full, 72),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, 73),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_0, ID(3, 64)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_1, ID(3, 65)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_2, ID(3, 66)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_3, ID(3, 67)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_4, ID(3, 68)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_5, ID(3, 69)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_6, ID(3, 70)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_7, ID(3, 71)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_full, ID(3, 72)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, ID(3, 73)),
 
 	/* counter4 specific events */
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_0, 64),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_1, 65),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_2, 66),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_3, 67),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_4, 68),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_5, 69),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_6, 70),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_7, 71),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2_rmw, 72),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, 73),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_0, ID(4, 64)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_1, ID(4, 65)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_2, ID(4, 66)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_3, ID(4, 67)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_4, ID(4, 68)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_5, ID(4, 69)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_6, ID(4, 70)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_7, ID(4, 71)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2_rmw, ID(4, 72)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, ID(4, 73)),
 
 	/* counter5 specific events */
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_0, 64),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_1, 65),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_2, 66),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_3, 67),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_4, 68),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_5, 69),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_6, 70),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_7, 71),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq1, 72),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_0, ID(5, 64)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_1, ID(5, 65)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_2, ID(5, 66)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_3, ID(5, 67)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_4, ID(5, 68)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_5, ID(5, 69)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_6, ID(5, 70)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_7, ID(5, 71)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq1, ID(5, 72)),
 
 	/* counter6 specific events */
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_end_0, 64),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2, 72),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_end_0, ID(6, 64)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2, ID(6, 72)),
 
 	/* counter7 specific events */
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_1_2_full, 64),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_wrq0, 65),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_1_2_full, ID(7, 64)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_wrq0, ID(7, 65)),
 
 	/* counter8 specific events */
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_bias_switched, 64),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_1_4_full, 65),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_bias_switched, ID(8, 64)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_1_4_full, ID(8, 65)),
 
 	/* counter9 specific events */
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_wrq1, 65),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_3_4_full, 66),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_wrq1, ID(9, 65)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_3_4_full, ID(9, 66)),
 
 	/* counter10 specific events */
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_misc_mrk, 65),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq0, 66),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_misc_mrk, ID(10, 65)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq0, ID(10, 66)),
 	NULL,
 };
 
@@ -366,13 +370,10 @@ static void ddr_perf_counter_local_config(struct ddr_pmu *pmu, int config,
 	}
 }
 
-static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1, int cfg2)
+static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int event,
+				    int counter, int axi_id, int axi_mask)
 {
 	u32 pmcfg1, pmcfg2;
-	int event, counter;
-
-	event = FIELD_GET(CONFIG_EVENT, cfg);
-	counter = FIELD_GET(CONFIG_COUNTER, cfg);
 
 	pmcfg1 = readl_relaxed(pmu->base + PMCFG1);
 
@@ -392,12 +393,12 @@ static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1, int
 		pmcfg1 &= ~PMCFG1_RD_BT_FILT_EN;
 
 	pmcfg1 &= ~FIELD_PREP(PMCFG1_ID_MASK, 0x3FFFF);
-	pmcfg1 |= FIELD_PREP(PMCFG1_ID_MASK, cfg2);
+	pmcfg1 |= FIELD_PREP(PMCFG1_ID_MASK, axi_mask);
 	writel(pmcfg1, pmu->base + PMCFG1);
 
 	pmcfg2 = readl_relaxed(pmu->base + PMCFG2);
 	pmcfg2 &= ~FIELD_PREP(PMCFG2_ID, 0x3FFFF);
-	pmcfg2 |= FIELD_PREP(PMCFG2_ID, cfg1);
+	pmcfg2 |= FIELD_PREP(PMCFG2_ID, axi_id);
 	writel(pmcfg2, pmu->base + PMCFG2);
 }
 
@@ -465,6 +466,28 @@ static void ddr_perf_event_start(struct perf_event *event, int flags)
 	hwc->state = 0;
 }
 
+static int ddr_perf_alloc_counter(struct ddr_pmu *pmu, int event, int counter)
+{
+	int i;
+
+	if (event == CYCLES_EVENT_ID) {
+		// Cycles counter is dedicated for cycle event.
+		if (pmu->events[CYCLES_COUNTER] == NULL)
+			return CYCLES_COUNTER;
+	} else if (counter != 0) {
+		// Counter specific event use specific counter.
+		if (pmu->events[counter] == NULL)
+			return counter;
+	} else {
+		// Auto allocate counter for referene event.
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
@@ -472,10 +495,17 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
 	int cfg = event->attr.config;
 	int cfg1 = event->attr.config1;
 	int cfg2 = event->attr.config2;
-	int counter;
+	int event_id, counter;
 
+	event_id = FIELD_GET(CONFIG_EVENT, cfg);
 	counter = FIELD_GET(CONFIG_COUNTER, cfg);
 
+	counter = ddr_perf_alloc_counter(pmu, event_id, counter);
+	if (counter < 0) {
+		dev_dbg(pmu->dev, "There are not enough counters\n");
+		return -EOPNOTSUPP;
+	}
+
 	pmu->events[counter] = event;
 	pmu->active_events++;
 	hwc->idx = counter;
@@ -485,7 +515,7 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
 		ddr_perf_event_start(event, flags);
 
 	/* read trans, write trans, read beat */
-	ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
+	ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
 
 	return 0;
 }
@@ -506,9 +536,11 @@ static void ddr_perf_event_del(struct perf_event *event, int flags)
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


