Return-Path: <linux-kernel+bounces-111005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF498866DF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1348E2862AB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F58A10A3F;
	Fri, 22 Mar 2024 06:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="drh+9JBe"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2044.outbound.protection.outlook.com [40.107.7.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F56168D9;
	Fri, 22 Mar 2024 06:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711089592; cv=fail; b=NlK45SXoVpOn5+yKpF0Z1G/4aLAbwSpO9K4aACXDlA1LxzYhRTkyLkXgzO+FxjYJjy0gBDbYMQvnlq06wf83pnWWlj7gvK+hjpVF2gz2jnBwwFQjSJrc1og7Ue8PaCCJl7g7MU/fDIkzqWSwpNNjQd3DRfwDwdWsOIxPJRzfEgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711089592; c=relaxed/simple;
	bh=NDO6BKRaIOTA9Q2ZKBVmG79hu1vB6wRVFIil+d0xALs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uBQOh2FSHVrUsnMrhdFkDP8MlSOIMPXC3YxcdBHPpazee0ImbpouWO0wK4K73kCN/KcMxB86bVDahGxfCbJM7NCTXAwVCa3qj6G+JnfUusIKqhWlISQb79GjO2/gyTFJs8UgiNRMf2SXQvg24eUJyic78aZW6NtpRdgMUIYE4OQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=drh+9JBe; arc=fail smtp.client-ip=40.107.7.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJ7+56VeP6LPx04yT2fKhUyroCj9pp7buarnmzJEWdHdmZPHaFRHymlL3PtcrTbNW4yca/3U1xNA7hdSCNIUQO1nQyOqyUOURCthaAWeuFPZb7KWoixJNWFbyNkn3QxeZd+7pwFPhEhGibrle3SgAXPqLsgVfJ3cn5m6rOIXfuZ/i5MOct/lQCv/YRFTD4IDxkbrnFT9yr+weptcEbbg17Qofj3W1ZamJ3I/Q57Va8DKHXBvjJ/Eru9q+IYwYPuzFdGHUAifUBiSTzGUTPP4UrV07+HeFcp8ieaRkcQ8FJalRZ/L5iq8FR80uAyfrjBSWvUhbmd3iujDl1b/NjNfTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uz5lGhO/mHkDKzAXhAzF2sJwJsMO2dtrOSaEh3WFBn0=;
 b=Znd+qlPO4LhFTnjk3C9YbyjZAjCOgeyGWoPjr+ZcyG2ieCCkBwb0hWazovL9s9KRk4HDf22LjBitdoyx8ZxFRIuo+1MOIV8PDtzj7GNirST/fG+9GXsTAc6sT6+hyKVX5htEF444A0EhUIkSoJUL/FP2a8DDvMd5Ok9d2OMocDzRmY600/2RGEbe75SG2f1NWWSUZrohRTNdE4yWkQw22RPaQJfhE2ZBlJjbnDjDNNDtoz6cBirwU5Q6gP4+5FmU6p6NWDSIGWv9W34rC6BoG4CPhEdfttvdsaWCPmAsfZYSG3Hcdhgle+8gWmdcJaPlq7eYaniq12yeJk3+dwXYqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uz5lGhO/mHkDKzAXhAzF2sJwJsMO2dtrOSaEh3WFBn0=;
 b=drh+9JBe6EQdAHvQTmwQUNnadwKHSuIvM4JOSPitf3jXb56AufUWK44NpppG7mBBtjXmqXSjM9bJMuGCiOi0DBGvGxqy91xSo6XRRzhkrfYpppsRxNV3ecVS1NHWHcLtpSK5/207lQCmSqKqFQMZZ/oId1gODfR2tO9PWJyRoYQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com (2603:10a6:102:20c::17)
 by PAXPR04MB8928.eurprd04.prod.outlook.com (2603:10a6:102:20f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 06:39:47 +0000
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::1b13:505:8d50:f4e3]) by PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::1b13:505:8d50:f4e3%4]) with mapi id 15.20.7386.023; Fri, 22 Mar 2024
 06:39:47 +0000
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
Subject: [PATCH v8 6/8] perf: imx_perf: add support for i.MX95 platform
Date: Fri, 22 Mar 2024 14:39:28 +0800
Message-Id: <20240322063930.749126-6-xu.yang_2@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8829:EE_|PAXPR04MB8928:EE_
X-MS-Office365-Filtering-Correlation-Id: 9114a1a5-2252-41ad-0a1f-08dc4a3ade21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KNNFGyyC6/cyNBgogkdjRU3oe/WVa6nxKwiOTENsGhzvkO1DN4TEtJdi/hwurIw8OIFUrQAF4QSdyO5/gkWv05lPmN/PkRFtI33wKpFR3ZalkNnehyYRsqZ53ELiYgSFjHjfE2yw6zc8ZRDA6LlE4p6HazIhoi+L2wqDvuJfxyBgwzm1qj0cVkUTCituk8jVJu2uiTUOwjFdtJvfiZMr9NI2p4hfiKLx+0M/pA+bjlgBxASDLklFF7zfdA8ZYQZxhd+HwoVpT3plDySlFSjoe9F54LT7jnnCjy8+SKmvYQRwJIleSwCV3qQtU25QWbHWuwK1PL/gnT1RIdBfM1G6jw0ETTNp71b4c6PAMY+mCJQSM4ZoVf9LSIC3BdtZflSrk/pdKq8OE4JI2ol8gSscLEn28os69B61MgutTD1qOj2byeLtdIG3yP4gU/xtSAHMc428y6gvttUIRpRh+cvcyo33o255wbdBJZ9d7NnlPpvJWQHYDLJgvThC7AykXgtwNWyohtiFklIafLt1v1KKfqrQXaAtVCN6zwWkpcCt3C0TbdHUaCsjT+N+0997JoK2meqpxXqbvmm67Z4x/NIvJY05chCUhO/70vuuJasSd/llLPqGLTun2OaPEPMuh5AADJy2+Y+AQquzKzczWAVEFEbVN2tz+ZtMHlC5wzJ3X6l2sGLWT4CRLEpldEK85Az6US1SNjUzDnG14APfuYXwBjSPKgwG0yqM6m4/7iRLvrs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8829.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(1800799015)(366007)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HctdzsEJdXdYZq7nrHLS6XX0km+u5nQz82lGYlBv4+LnAdowWeIbju+Bmy6G?=
 =?us-ascii?Q?nv81YUtSwcUSzqxQwTgg5qNfAzPvf8CXGKiFIcFcOAcaNnKkbHk+bT7EgqCC?=
 =?us-ascii?Q?/b8yUvQtAhg/6+DAkgC4rF9B3asdTqKxzbqRgKw5nkgnsI1UDXAWDXRF3g43?=
 =?us-ascii?Q?jX9wPOeSRbsrgzsWLn4RJjmSKK3F7vsAFcbhu0cPDn/y6FGCG/4WuJ3kqXV+?=
 =?us-ascii?Q?qYvePlVmZYOUOrS9/41ma0C0bqDS7Bt12zBTVjXuV8zpHMSBK1b3TTu/j/8E?=
 =?us-ascii?Q?e6nDx3hSxsEJ12ZxVzeY9tzA8VxGZNDpKBDVGHAWVbkoojDVVjVASyVYoyW0?=
 =?us-ascii?Q?EVPjC+SbcH5bIlIZ7ixpifO90oxcthZQUmuqk1H+IScPIc0m8svy6gf77TqV?=
 =?us-ascii?Q?m/fXUReT3GCShEyodfJ3MDqLr8Amn7t3wzAgCsYYhyQICFd7p3hh8zaVWatg?=
 =?us-ascii?Q?TUhDllOYM6zECpbJ16HOVduBjWgvZCwMuCX69lr4wbWtu6Kh0y1RzDEzAwZX?=
 =?us-ascii?Q?05ClFnq8VBrpilIeghuxpXMh2H4GLoLAxrbk61bcBjkdqoEhcQpIGlceBipW?=
 =?us-ascii?Q?r+q817lL/LzcS5lWJJVNHOKLXfTwDha8LbvL0sb0taoG168ZtUlzWDuw80qn?=
 =?us-ascii?Q?QDhFW+ErK+nWJh7thx631a1PnPGeCHS3YGCDhAihQ8O8CFg8u0RyeZA3oaJG?=
 =?us-ascii?Q?SR3t0IbKSilX9otTBkwI2jVpu7ZWEZY5HRYx8hBtyF05QLMXIziqf9ubSiP8?=
 =?us-ascii?Q?iXujRGVPUVG/cROL3/HEjk7I0G8c3f+kbajpCNyJZZIfphGPr9pheIgZD3/j?=
 =?us-ascii?Q?6388wurFIbJikHq+uJP6wf0x0qKYGRBiqbdo7y1QYSE96OiavoSCPHGvNcya?=
 =?us-ascii?Q?aJ3lJktnsFvxtM1eVq3I6svwJM7gifidZ7aDVxwJlJK5rXPdJruwskKaoKn1?=
 =?us-ascii?Q?7qaCiCHsUzHBWosZ8KOR39izZ9JYi8df+4FrmX2NDx0KL9IREPUz/Kmzty/p?=
 =?us-ascii?Q?IygjAFvUuwZQMct9LxMRDzhRjfXuRVeFkmu/JfzUwNN4Lr9pqBAMVCOtNEIl?=
 =?us-ascii?Q?uOE+p+Ph65QsllWYwOZQAFcvF0OszfkALzPcTHCHzK1Qj95LQGW75WGvIKnF?=
 =?us-ascii?Q?UY528N9fAF+HbJzElT3r2qNVM03LSpHSqLXwippSlOaWLSGomHmnkN0m4wgV?=
 =?us-ascii?Q?iq4cxApUEYjuRKJUF1a9h5lHxx7+VOZJdQM3nvCZuoNJAAEdXhiHXn2a1IYF?=
 =?us-ascii?Q?n9ih3TA8k1y08rYZei5oCCLwU1FPyfe9+33c7508DS8dpYlZb4rVPuXr4TKV?=
 =?us-ascii?Q?g73QMP+1LOpaMWuuofbEF8CuQhwBFfCCxkcSm8Y/FkrJ47qcHz3bqZ+yAKLN?=
 =?us-ascii?Q?CMMKek8tHH4NCD9FhEb2gMMXBpJyTKJGOjEYCJmH8TWVwHoYcdlExprtteEw?=
 =?us-ascii?Q?HKGivxYiomChqWmMPsmrp0LOkOqWmLnUpBHWMpE7d5SQhlrk+efeYJWBYeHc?=
 =?us-ascii?Q?1jakMe9fGU4sXx8uChHXB1pigkaE73mMk8Lww6eIaVGlC1Y7ZzdDyPYINrY0?=
 =?us-ascii?Q?ofSjZ/Ab/r9H2Mc2BDKjSOoO7m2UZ5sWZbteBzhe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9114a1a5-2252-41ad-0a1f-08dc4a3ade21
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8829.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 06:39:47.7034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SjfJe8e7+Vz+xTe6FhK+cAzJdJuAxgAfy0koqH56+0dCyVorshG6w29xqHle7fmqpICZDvuLHZACst8Lh2ruZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8928

i.MX95 has a DDR PMU which is almostly same as i.MX93, it now supports
read beat and write beat filter capabilities. This will add support for
i.MX95 and enhance the driver to support specific filter handling for it.

Usage:

For read beat:
~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt2,axi_mask=ID_MASK,axi_id=ID/
~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt1,axi_mask=ID_MASK,axi_id=ID/
~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt0,axi_mask=ID_MASK,axi_id=ID/
eg: For edma2: perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt0,axi_mask=0x00f,axi_id=0x00c/

For write beat:
~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_wr_beat_filt,axi_mask=ID_MASK,axi_id=ID/
eg: For edma2: perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_wr_beat_filt,axi_mask=0x00f,axi_id=0x00c/

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - put soc spefific axi filter events to drvdata according
   to franks suggestions.
 - adjust pmcfg axi_id and axi_mask config
Changes in v3:
 - no changes
Changes in v4:
 - only contain imx95 parts
Changes in v5:
 - improve imx95_ddr_perf_monitor_config()
 - use write_relaxed to pair read_relaxed
Changes in v6:
 - no changes
Changes in v7:
 - no changes
Changes in v8:
 - add definition IMX95_DDR_PMU_EVENT_ATTR
---
 drivers/perf/fsl_imx9_ddr_perf.c | 89 ++++++++++++++++++++++++++++++--
 1 file changed, 86 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index fab6596d3e28..9dcab4192d6e 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -17,9 +17,19 @@
 #define MX93_PMCFG1_RD_BT_FILT_EN	BIT(29)
 #define MX93_PMCFG1_ID_MASK		GENMASK(17, 0)
 
+#define MX95_PMCFG1_WR_BEAT_FILT_EN	BIT(31)
+#define MX95_PMCFG1_RD_BEAT_FILT_EN	BIT(30)
+
 #define PMCFG2				0x04
 #define MX93_PMCFG2_ID			GENMASK(17, 0)
 
+#define PMCFG3				0x08
+#define PMCFG4				0x0C
+#define PMCFG5				0x10
+#define PMCFG6				0x14
+#define MX95_PMCFG_ID_MASK		GENMASK(9, 0)
+#define MX95_PMCFG_ID			GENMASK(25, 16)
+
 /* Global control register affects all counters and takes priority over local control registers */
 #define PMGC0		0x40
 /* Global control register bits */
@@ -76,13 +86,23 @@ static const struct imx_ddr_devtype_data imx93_devtype_data = {
 	.identifier = "imx93",
 };
 
+static const struct imx_ddr_devtype_data imx95_devtype_data = {
+	.identifier = "imx95",
+};
+
 static inline bool is_imx93(struct ddr_pmu *pmu)
 {
 	return pmu->devtype_data == &imx93_devtype_data;
 }
 
+static inline bool is_imx95(struct ddr_pmu *pmu)
+{
+	return pmu->devtype_data == &imx95_devtype_data;
+}
+
 static const struct of_device_id imx_ddr_pmu_dt_ids[] = {
-	{.compatible = "fsl,imx93-ddr-pmu", .data = &imx93_devtype_data},
+	{ .compatible = "fsl,imx93-ddr-pmu", .data = &imx93_devtype_data },
+	{ .compatible = "fsl,imx95-ddr-pmu", .data = &imx95_devtype_data },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, imx_ddr_pmu_dt_ids);
@@ -158,6 +178,9 @@ static ssize_t ddr_pmu_event_show(struct device *dev,
 #define IMX93_DDR_PMU_EVENT_ATTR(_name, _id)				\
 	DDR_PMU_EVENT_ATTR_COMM(_name, _id, &imx93_devtype_data)
 
+#define IMX95_DDR_PMU_EVENT_ATTR(_name, _id)				\
+	DDR_PMU_EVENT_ATTR_COMM(_name, _id, &imx95_devtype_data)
+
 static struct attribute *ddr_perf_events_attrs[] = {
 	/* counter0 cycles event */
 	IMX9_DDR_PMU_EVENT_ATTR(cycles, 0),
@@ -204,6 +227,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_7, ID(2, 71)),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_empty, ID(2, 72)),
 	IMX93_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, ID(2, 73)),	/* imx93 specific*/
+	IMX95_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_beat_filt, ID(2, 73)),	/* imx95 specific*/
 
 	/* counter3 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_0, ID(3, 64)),
@@ -216,6 +240,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_7, ID(3, 71)),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_full, ID(3, 72)),
 	IMX93_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, ID(3, 73)),	/* imx93 specific*/
+	IMX95_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt2, ID(3, 73)),	/* imx95 specific*/
 
 	/* counter4 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_0, ID(4, 64)),
@@ -228,6 +253,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_7, ID(4, 71)),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2_rmw, ID(4, 72)),
 	IMX93_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, ID(4, 73)),	/* imx93 specific*/
+	IMX95_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt1, ID(4, 73)),	/* imx95 specific*/
 
 	/* counter5 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_0, ID(5, 64)),
@@ -239,6 +265,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_6, ID(5, 70)),
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_7, ID(5, 71)),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq1, ID(5, 72)),
+	IMX95_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt0, ID(5, 73)),	/* imx95 specific*/
 
 	/* counter6 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_end_0, ID(6, 64)),
@@ -430,6 +457,57 @@ static void imx93_ddr_perf_monitor_config(struct ddr_pmu *pmu, int event,
 	writel_relaxed(pmcfg2, pmu->base + PMCFG2);
 }
 
+static void imx95_ddr_perf_monitor_config(struct ddr_pmu *pmu, int event,
+					  int counter, int axi_id, int axi_mask)
+{
+	u32 pmcfg1, pmcfg, offset = 0;
+
+	pmcfg1 = readl_relaxed(pmu->base + PMCFG1);
+
+	if (event == 73) {
+		switch (counter) {
+		case 2:
+			pmcfg1 |= MX95_PMCFG1_WR_BEAT_FILT_EN;
+			offset = PMCFG3;
+			break;
+		case 3:
+			pmcfg1 |= MX95_PMCFG1_RD_BEAT_FILT_EN;
+			offset = PMCFG4;
+			break;
+		case 4:
+			pmcfg1 |= MX95_PMCFG1_RD_BEAT_FILT_EN;
+			offset = PMCFG5;
+			break;
+		case 5:
+			pmcfg1 |= MX95_PMCFG1_RD_BEAT_FILT_EN;
+			offset = PMCFG6;
+			break;
+		}
+	} else {
+		switch (counter) {
+		case 2:
+			pmcfg1 &= ~MX95_PMCFG1_WR_BEAT_FILT_EN;
+			break;
+		case 3:
+		case 4:
+		case 5:
+			pmcfg1 &= ~MX95_PMCFG1_RD_BEAT_FILT_EN;
+			break;
+		}
+	}
+
+	writel_relaxed(pmcfg1, pmu->base + PMCFG1);
+
+	if (offset) {
+		pmcfg = readl_relaxed(pmu->base + offset);
+		pmcfg &= ~(FIELD_PREP(MX95_PMCFG_ID_MASK, 0x3FF) |
+			   FIELD_PREP(MX95_PMCFG_ID, 0x3FF));
+		pmcfg |= (FIELD_PREP(MX95_PMCFG_ID_MASK, axi_mask) |
+			  FIELD_PREP(MX95_PMCFG_ID, axi_id));
+		writel_relaxed(pmcfg, pmu->base + offset);
+	}
+}
+
 static void ddr_perf_event_update(struct perf_event *event)
 {
 	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
@@ -539,8 +617,13 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
 	hwc->idx = counter;
 	hwc->state |= PERF_HES_STOPPED;
 
-	/* read trans, write trans, read beat */
-	imx93_ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
+	if (is_imx93(pmu))
+		/* read trans, write trans, read beat */
+		imx93_ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
+
+	if (is_imx95(pmu))
+		/* write beat, read beat2, read beat1, read beat */
+		imx95_ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
 
 	if (flags & PERF_EF_START)
 		ddr_perf_event_start(event, flags);
-- 
2.34.1


