Return-Path: <linux-kernel+bounces-111002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E13F8866D9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D10A228610F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0336ADDB2;
	Fri, 22 Mar 2024 06:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="I9X+V/M1"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2061.outbound.protection.outlook.com [40.107.6.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A822125C4;
	Fri, 22 Mar 2024 06:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711089571; cv=fail; b=suJA1qYNgyBNPgzE5AZFlA+w3wEMq/twbYUE78M9bc2CRdorPChHMP1d7EFDOxkM6xDjZ/hStGDmkEjYFFoWXDTvPJUB7St/tukbbVI9jiaSGaHDndYwdYI7x0bACKu9+8GgeD3kXq1Po63PQNdqTiNoaRKIJKZKLlK0tQYF5p4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711089571; c=relaxed/simple;
	bh=AX7N4YnwVF1rEsqvvfhIikg57wp9x9lADxygpLgdN00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A6Ah+m/mBJJPhYQCCoDhT0/PUxGnWONuF+4dYp4901XnYV+oyBoEivpZ+o0Znk9S1yXAX+ajODES+LoDlWKkTA8WPoj+i13rQxoFliQQ6Hkkzr6Lt2B/5NKSispS0K0gyO0zSBB6lKOWdQJwHXV55lynd6TXrXK6U8049UbaC5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=I9X+V/M1; arc=fail smtp.client-ip=40.107.6.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxFmCuTXN7FSDYc8VJT7BBZD+2KUqk79R1PkbbCuxbj3tf2hPYmEZRCYcaSsIp++c4ivnnyawWC+DfB3otPaABVD8/5zrsTiImXDZURhELG90EycHFPR9uimrR9bUm3M6ReQT8BYfefFuhKNHFrOQS9BdNEFR5lKaXpWiXwtg+doJpSdXl0liwx7ujH3iTZSPmZCrDN4tbg/JgwZe9tuzwOJ6mAkNi8y+ZyOM/L/O7/I8ATeWWzvUiKzHkITXmv1qQJ2w3qupIoYBWX+WIgS1gWfopgMsp7BoPOLPvQFbvBfFCcDdJSGUuj0RDlWsJ/ium2UK17M6GGg/JyFvj0X5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwmTZIdNCReqPwuOYBcXgXOhGAsE6Ons0vS3d+lwqO4=;
 b=DLua1pZxDaAnyueZg7rA9USR15wyRMpDL1BUuOpuXd8GN/UDax+7CSCrazQMUJXbyf/5By54jFw0F4w+9/Bwp0vZ/eQeTxAOMmnguX6fSIw2HjpYi/EVEPX2q6cEBHuSWunk5PTWLn4LrpiGKVlLNRTllTk9yiT7Dty4lNoktqk/PM5vfctQpFUrqyQCVu9oeTCCNY102XF+2aYcfBjzfkQImeRht7Yprl6Rr7MqrD+TWZHcuHh+kHv7udO0jyvAlYpBvdeJ30W6p7fre1jYruj82b9v6rsst+DLNSrGpVDJtymsHAqMQ8AyXX0c0sBR12IRYfdyetQ4/EU+JxeZkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwmTZIdNCReqPwuOYBcXgXOhGAsE6Ons0vS3d+lwqO4=;
 b=I9X+V/M1kZn/OZO60xb+ymmRT7/knQKUrrjknnSfBEfoxLuBdzMiSxT0p9pgVo9gFYxZnR4R6jslsUs4XiOlrUiO7IwATwUPxIhB1PgycFa+6mBucZgziWlJC17U5PWxDc88EuxW2Ty5j49+IHpvmD4f3MT51Kgza3raVILoymo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com (2603:10a6:102:20c::17)
 by DB9PR04MB8091.eurprd04.prod.outlook.com (2603:10a6:10:245::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.15; Fri, 22 Mar
 2024 06:39:26 +0000
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::1b13:505:8d50:f4e3]) by PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::1b13:505:8d50:f4e3%4]) with mapi id 15.20.7386.023; Fri, 22 Mar 2024
 06:39:26 +0000
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
Subject: [PATCH v8 3/8] perf: imx_perf: let the driver manage the counter usage rather the user
Date: Fri, 22 Mar 2024 14:39:25 +0800
Message-Id: <20240322063930.749126-3-xu.yang_2@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: d4f79836-a4b8-49fb-7d18-08dc4a3ad1a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	phONhfUPwJONU1jJj+5Np6pu+GeZNA7EH/Uj9ANs9hhoh+X1G5Y1Zj2Nwsje9Ur0fk90BjumOV92zMYV2pVIWLHGrOli38BgfA+1ZLFzsofhCMfhdDg6RpCZcDLanp8DE/xiobcoGx9ZIVx7ZN1oCNglwV1mq33o2RZAvXG31QtbveH/Y8GU5965SMpvqSggRfIQLsxayJAHSCyFGalNJeAns4PqFI/AnsFROSwS73cDL7dakRtD0BlrE3CePd92I0kbZ8nFvFJ9G9PgaOjhkmQLEyjRR/34i3gztNNooggjvFEIKUTXb8wuaAEGt7glq/UHnmUtj835s8p3p+qJpNH2fctFNveWsvTDvMKHGPwTIo6tRMwx0vgd8vYHYIY6i8L3jXO85pdx2QvEHMPsJFFZ4N5gLRmkz0yZD+Y8/7Q3p2OCfQxVmNKVQd6qLs1JZHgqLbi/Y8IefyJskiK3K6J9bfAbKGqxHutSqPHqYqmbEV4Eu2O8FOPKVbqibTedog1CTYq588ycBoc5J5YIpfnVIygxPlSNa8aBbhRfq2MSxMd9nvHy/WuriK7/6HYLXLirfSwhecF2T+L0Ld60g+MGWSPwJ7lTJ0tWkxeRRzzwn1SlzrzH+gkhGEgTaGR5Zjjp3aq+bOLQqKFsgF3U4nwt4dlwShcdCmGdBB1qbFHC+sHo07CKM/jwoxMRHCfS8jUkI0pUgkEVagELobG0M/JHOBvgYr6SiZnNjcVMe/s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8829.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(52116005)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mx1bxSCrJ+A916AEfy4iV6U2isZ+rqg0N3/mwAmj+SgRE/gSgz07XeKeO2pi?=
 =?us-ascii?Q?01PUnUA1uUrIfNSbpMHLOVMhpizLzY0IJbl+UWnhJ1Unw7ANLxWHjNE5lVlJ?=
 =?us-ascii?Q?65SoZ47BkzXVExIoDlvef3loFFp232sBzJVEE8QgQCV/MjRXQJztFMBk09qr?=
 =?us-ascii?Q?fXkdjBM09clQPYFAXX+wv+rPVTTkwPavyF4vL3mrp/YoMPmIh9eET+W/utF8?=
 =?us-ascii?Q?BPHb8DX3XAJikDxV+WMP8SHgKsoIv8DT3S607L1J74XZyj5sSPzXn258aXHb?=
 =?us-ascii?Q?ar4LgXat22r62961VR5KrQ2GmcsW6lwZz8F0WQFm/jzL+XkOsLWMfeL6kobu?=
 =?us-ascii?Q?3vMloMwFzgosashf/yaveZjVPvv5+AAkdNX/FMYveQpc66fiw7wnCErET5TI?=
 =?us-ascii?Q?6f7XGG6avnbAHV7O5jvMqodMdKR5+j0xSCj8pnfBNXq4L1aNJGumjNN9eBtt?=
 =?us-ascii?Q?vR0SUA+1VYJfZFYK2p4tmIe9jEK540491DAY7OuKgu30z6BLxGXMozbaN9cC?=
 =?us-ascii?Q?ucAlV00/mZ4LROem4fCpSxnKET8firS6jbmQedxH9mFaox5tuDQeGIWwaCwf?=
 =?us-ascii?Q?EKNg6h74n4zv4eKI9AGodq2nzheo0fmpwiIIWzYdBMGZGps8h48yKf556Xp6?=
 =?us-ascii?Q?1Ll345qFgQCN8xn77bvrMGJdiaURm/igT5E+qsHlrmwxayxB/zzYHImFX8H2?=
 =?us-ascii?Q?SCSHkKzjgMoDf9EBLkwdZzXcCxKtgXxVkRva3fWP4JhjwXeQthuA1LCzKPkp?=
 =?us-ascii?Q?2gBy3QBOIimaoE4iRtHtVv6U7aK/6Rh13Qz/+c/8X/oQb+ecbppeHjVugn0v?=
 =?us-ascii?Q?jPv54LNxFgN9UegUK2uSBawhN0V/vmZT4H3wJbvvzhlXi9f0UzKqiESJl9V7?=
 =?us-ascii?Q?tdVfGrbZ3ZzQwX4Ht6zpMZHckraLPtLZRt0G+8oFdmxqOdi5Wr5bdVtBN5lC?=
 =?us-ascii?Q?6dsUZNYXS+lD4IvW5HrXEwV5od4m2Op1EnUj3f7bAxT3ZypIE+4U/sdf7bAi?=
 =?us-ascii?Q?MluRb7xkWH8OE2uwyEGeYGs0tBf+Y/ABwVfON/C9+A/08+d0ztxWUBT+J8rB?=
 =?us-ascii?Q?M9oCyMN7y3LrmlmOViIqWm2Ox2pDVpGKGuozORMKPl2kTvgZdS7mLfdo+Qrp?=
 =?us-ascii?Q?kzjGrNH7dzYu0lCBZyxOL8f4GtkX2ZwjnOHikhDzSvi/FuVkPaRDcWXtgZ4p?=
 =?us-ascii?Q?2ssnci1LzyFpmYMIaJMfn/Z6ZTS+QBSnoHMy+n3J2N6+E6otdiIR0b6c5TPy?=
 =?us-ascii?Q?ja7fM+z/fv3BzOFsrsEGywRBB8T04TbbQIALmchMxv+YkNz9NOBxwU4I7O9s?=
 =?us-ascii?Q?o28D/vHx524uimYz42ZJqu4AUK86Jm/hGSToCuRR1LqbzQnutp9vArnxyUyX?=
 =?us-ascii?Q?PbXptKvCBjabMJW+2p3RWNN7wFoBvhRnRi+lYeW3Uwf2/WcDWKOw4cfQtoOq?=
 =?us-ascii?Q?Nm5pJ2uZhx321B4duT+3dRPjIXBSz9tV36hA5UNZDcnSpuo0lfQtZ+CCE3kU?=
 =?us-ascii?Q?JYcL3POoegLO2A8/d75OYIFslBALv83RLKKqPKovVQkIVsPQhEjkS8v+utUC?=
 =?us-ascii?Q?m07MCFvqO9Bvpt4LI+2es3i9qefxn8KbAB+EhbgT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f79836-a4b8-49fb-7d18-08dc4a3ad1a8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8829.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 06:39:26.7721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eI1lNqz02p1GK1sB37FqJndD5RWhaK4RWDeZbSGo7UHsqqLd1nZFgwKBLxchmncyEqZwWwEe+9CiAQMaRJRIZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8091

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
---
 drivers/perf/fsl_imx9_ddr_perf.c | 168 ++++++++++++++++++-------------
 1 file changed, 99 insertions(+), 69 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 0017f2c9ef91..b728719b494c 100644
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
 
@@ -245,14 +249,12 @@ static const struct attribute_group ddr_perf_events_attr_group = {
 	.attrs = ddr_perf_events_attrs,
 };
 
-PMU_FORMAT_ATTR(event, "config:0-7");
-PMU_FORMAT_ATTR(counter, "config:8-15");
+PMU_FORMAT_ATTR(event, "config:0-15");
 PMU_FORMAT_ATTR(axi_id, "config1:0-17");
 PMU_FORMAT_ATTR(axi_mask, "config2:0-17");
 
 static struct attribute *ddr_perf_format_attrs[] = {
 	&format_attr_event.attr,
-	&format_attr_counter.attr,
 	&format_attr_axi_id.attr,
 	&format_attr_axi_mask.attr,
 	NULL,
@@ -366,13 +368,10 @@ static void ddr_perf_counter_local_config(struct ddr_pmu *pmu, int config,
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
 
@@ -392,12 +391,12 @@ static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1, int
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
 
@@ -465,6 +464,28 @@ static void ddr_perf_event_start(struct perf_event *event, int flags)
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
@@ -472,10 +493,17 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
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
@@ -485,7 +513,7 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
 		ddr_perf_event_start(event, flags);
 
 	/* read trans, write trans, read beat */
-	ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
+	ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
 
 	return 0;
 }
@@ -506,9 +534,11 @@ static void ddr_perf_event_del(struct perf_event *event, int flags)
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


