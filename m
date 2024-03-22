Return-Path: <linux-kernel+bounces-111003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CD98866DB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 784351C236D1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA449134DE;
	Fri, 22 Mar 2024 06:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HwW4gxpZ"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2041.outbound.protection.outlook.com [40.107.8.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BA7DDB6;
	Fri, 22 Mar 2024 06:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711089578; cv=fail; b=PrmdRWQ5ugHrZK9TPRRlH0ozRSOrrRefdafn5FoafAN+wJ1w61frwcIdHY34XJjCMmj/bp5iHX0hIEC/565BnvZiZ0xIcGb8oUtc/b0X+2WaPjKWPXBwmNMmyXKHd3SiCp7PeeYYTBxqNFcyhmcg/72IEmj77ttriKhmKWX6i/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711089578; c=relaxed/simple;
	bh=AeqoW6ts92fW6i4sLdKqJ0Ahbl8AGHnwsdWYScVk+xs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o8FfHC9cBBymroB3Qb9XBrbtYQ1IUyby7rHc7HZfza/3MEq+D8wtqUl6l0L1ZV1tL0sBf8rw8Ujc6g+ixKfVGsceKlwxbiAfNeJwpum0+hH9r+mFuHLwZy/3YW0tL0iYhWJznC9mGpzzElltNvcAzkYv2AWolPKT+KcPJEt6T2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=HwW4gxpZ; arc=fail smtp.client-ip=40.107.8.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIbrVMDV9HWJl3iVo8wz8qZx187QioRwAycSmoQ9Qldah7CX+tPazvTOCHPk6RsjLQGFOokyKKQ3b8P2fLdsiOaqaCDzLLf0sCLM64IjPtUIr0JpYl/jbWHDeYhGV1JE7IvFLphxcbwml1xI7rTRLUT052qaPAl46z8/emhMOJj0hm+ukIgLHOStlUsDqIXzpJ/MwZQ7EFLQKlidn+Ixv9jxvXS+vm5mkfwo5MVbGTKCeoEm97DnyrPY8CIzjYkO643Pt0ku8y0e/kBJGPMPkpiktX9E/ShpEDK6Dsh0gW4mV2TZh6OYQJcjyygh9TVydzNNIgvAU3+de02O3Qw0Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOB3WSf1SaW835T279z4dsncCLvkZYCvdyIrwZomBg0=;
 b=IC0ahRKyYLtkxK6QmomBUHctXpY+dERlWW517xYuGquLszyPoa+5XvPUG9+I2H9bJKkR/KqMkLNNl3ipLWtRNQetrBDiFPLSj/O4fJH6m+rbggpuBg6Q9mtxRipu3z6sg57lXb2pav8LiTTNvofKqFUsft0UpJAWPqoBSRP+OZPr9gWz19ZSH0C3aiOGCNuc7PNJo/bE2OTXzWAY8y6obdVwNLsOF7IA/dP5Ct26oKpEKzYUxvAqhSfeUn/KYrt3tSiMn2X6AhvwaImMMtdtnGnSOR4LUlN4pq+vSeToy1DN1CiTUkVBD4pbUuJI9LUOXTsy56FDpIwJgFNoAMVDfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOB3WSf1SaW835T279z4dsncCLvkZYCvdyIrwZomBg0=;
 b=HwW4gxpZQSf7LoyhTLMQizkCtHbPj4aNtaQ1ONMADwDo21V3ipICmIjLQdRV9Ieu5TnSV+XDYCsiOM0nQxeylaYuBKeVb5XvFXmaaIBvddtqzg88Na0q2vpu/P/AGxZvRGGQiZmp/ujlO4i8kcwv/T7rhNKwXbYmiAVSCu6kXto=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com (2603:10a6:102:20c::17)
 by DB9PR04MB8091.eurprd04.prod.outlook.com (2603:10a6:10:245::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.15; Fri, 22 Mar
 2024 06:39:33 +0000
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::1b13:505:8d50:f4e3]) by PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::1b13:505:8d50:f4e3%4]) with mapi id 15.20.7386.023; Fri, 22 Mar 2024
 06:39:33 +0000
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
Subject: [PATCH v8 4/8] perf: imx_perf: refactor driver for imx93
Date: Fri, 22 Mar 2024 14:39:26 +0800
Message-Id: <20240322063930.749126-4-xu.yang_2@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c2930008-e8ac-4c75-2316-08dc4a3ad5a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EBsZj71dF3rB5kXN8j2XT2XAyH1+b0nFK93SBI1faVvo2uFfk5SH4TXL9zC6ocozYGbC0h4Q77w7Yq30GCPI+BiYq643eaKCdLSxfaNsFPE553LPpUVcTkHQ0avHaHsd9fy9auLAXnO4w1bz8gnNkPbbmp9k0lHmgLPrb+qQP4sO7KAoEE5wep0tep8dtt+dwmNjElxitowEgiN5Pc2oyYK6nZU73g7a4/6bZ0pVIyQbA4T1mpRWIn1QvsBAM97MaztIPZFwVEqykrnmgjuRvYT0tvU18nYE+QjFC2OGXvXXo/VU7XzYxmvYwCp6Hav0s+eqgz/PtygoAcVSbdJKtscIej3VTeDllCkTzhXtMnIuLtftJaZmQU9w0mcZbEcn798G7Rh/09st94KP3sImc1W8nnHvV2XNRPP9vofNCjxBNkSe/d38/YMCWVjrnUcjJgjLOUwxPq6Y6cegixUDArde3+0u46ntMFzniA+hScB6qH7cX4KvSEJBc8276sYGcYUw0tCRLgTZPHeZ2BMvDch1HxmmwLG3gUopO49l0noOjF64rJTSaPdSexd0rW3FJSMMmNUl5e97QM1w6wxAhB5eMANnF9AbMHDwwyNar1LaeXA7jjO90x1Te1a4YO54vVNaoQixEhmdT7pc5nS8XvY4MSJCkwHFbX6RZu93Q115y832fZdc6K0FaPl5hFXmVD9UYgZcJWjKoLvQfAzOnwTHbEqhWNEHI4ALruGJ77Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8829.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(52116005)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?khccwRnSFC6mEsG0/yHzUf82JLKN+gBHXWS8IyBId1N9+RjpCLmdXDUIbkW7?=
 =?us-ascii?Q?Porht0AVJWHYmRQzIlb4cr4LZdenpXV1PwdtdeJU0c6RUVwd35SzUQ6KLY3p?=
 =?us-ascii?Q?92Vns5lBtbyy5uW/yEko9Q/iuRYDkMc1rzhCYIiujMwnJbzolLHNjomwED5q?=
 =?us-ascii?Q?dvHsmeOWV+Azl5fP4cQ+1o3Nch4BdPsLkcfkTFqzqgnb+sisQMvDe7GF49n4?=
 =?us-ascii?Q?8H1Zbj3pLQKwKrUKDzk7zP8ArW+kwtiR+yr8/QxhshXnom/7O5C5rYiNuHk2?=
 =?us-ascii?Q?aFqAqTSz3GrUnqis/kwN9dOiGjNuvTY2HwscfuN22xXqGCd7GAgHbaa7v41g?=
 =?us-ascii?Q?GG6NPC4axrexvKSj3t+P+aRLRXn79Iu/EeeiK94LX+sPIEkNamI/5tRJ9pbd?=
 =?us-ascii?Q?PIYSfcqNpxCqhFjJP+70NACoRhavkTL06yJThyxeb55WaMLq76oTJURXmhEE?=
 =?us-ascii?Q?U1xM53YOUr0lrnfi5FEF4gxw6weXVtyAujpLW5eRmVvbvK26Q5Xw8r4plQVL?=
 =?us-ascii?Q?9zLi5RrNKO+qXy2hNxUyU1Q6t7dyrI1GQTcTv1QRYUbi0xoWT/PBxqg7sBSI?=
 =?us-ascii?Q?zFftMryHkpXvJxMrScrlLKnPaVYRE+kZlcarF+hViMKlcCXBcgDTO33GeDqm?=
 =?us-ascii?Q?vQl4sSTTZ/Mkr8Zvcc4virwb1xzbTPD3LGrgOsclCkNAUx85zfzjGj+PRmIN?=
 =?us-ascii?Q?ZdBZ7m0Mq058wAuw9RTnrU+4fSHm78QmzuldERlWea1JjS01Ij6rKieXDgrt?=
 =?us-ascii?Q?6omuWtQ/7oIYVkQGn8lkSBbVUabBOVGrTVrfvfNEc/xRd4bwF34UrAkjmdZt?=
 =?us-ascii?Q?jr77vpQ9FO7qBASL0SCj053QzBFC02+K+wYZLub7EzmsexeqcaSS3HlTtGo5?=
 =?us-ascii?Q?faZCBHfCcorD/N083v1MAkD6gD/gDspRuIweRNdaMN/hhadQtMqqQ4guOghc?=
 =?us-ascii?Q?8p3udUDieYwerS60tds+w/T8E2YcIot15yvfOSdKjEcgZq81LQ7P9ANXjxlR?=
 =?us-ascii?Q?8HPepewtmsR7FfFt0gT1S9tBDXOXyLh+KD59EDwa22zsDId8xYyomEpzs0yh?=
 =?us-ascii?Q?Aquu3hLMUrxQMMkzLThhxFYuJ8yY5oPwMQmgy3P2LTCYASNISVPV3TaWMc4e?=
 =?us-ascii?Q?FH5EmQxd1wlIvx/mioN+bk2GhPVvR35sDEqEbG8Dn5/OaXq2puOzlJKtFA5d?=
 =?us-ascii?Q?w17K74osUqJ8rbLaipwzxG0Q7BzUDiglx0tZ0rD882cnlCtyeqzatQHD2P2f?=
 =?us-ascii?Q?lBIrEkuQkIbBL0M5VVcBp+N/GqSm/tfbpawTaOuGvxMotORBUFByEbE4Qft+?=
 =?us-ascii?Q?n+LCwcL470Ri4vQYUaqQxZ3jUXc1fnglKRgd9U0ivYEx0e2MTauQut0JSwJ6?=
 =?us-ascii?Q?J9gClnW1S/kNAZ0GFJUj62klS44459qC1sgVJ9jggrSUwwaNY/jTWuoJCrbl?=
 =?us-ascii?Q?qOcknpnIE1HINuceGtdlnvmB7hJ+77KfMLz7YqGt0yExq2xLLbqnHyrUGIv0?=
 =?us-ascii?Q?Sqiprr4L+MExGK7slPun0DF/KCJ/UW9G0gXxyt1HKqkgfS/BEGt0pvd0mewY?=
 =?us-ascii?Q?TSPJKXQofOBncN6iVZvkhVJsCpdc8FgX7Nzdqwks?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2930008-e8ac-4c75-2316-08dc4a3ad5a4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8829.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 06:39:33.4863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jokPAFejIoso0TdPWaVwYzsnBLkI8+koQX+HIaHIVE0LX1A50FthlI7AyWedJdoZSbu5SeTTkCZERuz+pv6HIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8091

This driver is initinally used to support imx93 Soc and now it's time to
add support for imx95 Soc. However, some macro definitions and events are
different on these two Socs. For preparing imx95 supports, this will
refactor driver for imx93.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v4:
 - new patch
Changes in v5:
 - use is_visible to hide unwanted attributes as suggested by Will
Changes in v6:
 - improve imx93_ddr_perf_monitor_config()
Changes in v7:
 - improve imx93_ddr_perf_monitor_config() as suggested by Frank
Changes in v8:
 - adjust is_visable() as suggested by Frank
---
 drivers/perf/fsl_imx9_ddr_perf.c | 106 ++++++++++++++++++++-----------
 1 file changed, 68 insertions(+), 38 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index b728719b494c..011377c01dea 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -11,14 +11,14 @@
 #include <linux/perf_event.h>
 
 /* Performance monitor configuration */
-#define PMCFG1  			0x00
-#define PMCFG1_RD_TRANS_FILT_EN 	BIT(31)
-#define PMCFG1_WR_TRANS_FILT_EN 	BIT(30)
-#define PMCFG1_RD_BT_FILT_EN 		BIT(29)
-#define PMCFG1_ID_MASK  		GENMASK(17, 0)
+#define PMCFG1				0x00
+#define MX93_PMCFG1_RD_TRANS_FILT_EN	BIT(31)
+#define MX93_PMCFG1_WR_TRANS_FILT_EN	BIT(30)
+#define MX93_PMCFG1_RD_BT_FILT_EN	BIT(29)
+#define MX93_PMCFG1_ID_MASK		GENMASK(17, 0)
 
-#define PMCFG2  			0x04
-#define PMCFG2_ID			GENMASK(17, 0)
+#define PMCFG2				0x04
+#define MX93_PMCFG2_ID			GENMASK(17, 0)
 
 /* Global control register affects all counters and takes priority over local control registers */
 #define PMGC0		0x40
@@ -76,6 +76,11 @@ static const struct imx_ddr_devtype_data imx93_devtype_data = {
 	.identifier = "imx93",
 };
 
+static inline bool is_imx93(struct ddr_pmu *pmu)
+{
+	return pmu->devtype_data == &imx93_devtype_data;
+}
+
 static const struct of_device_id imx_ddr_pmu_dt_ids[] = {
 	{.compatible = "fsl,imx93-ddr-pmu", .data = &imx93_devtype_data},
 	{ /* sentinel */ }
@@ -123,23 +128,36 @@ static const struct attribute_group ddr_perf_cpumask_attr_group = {
 	.attrs = ddr_perf_cpumask_attrs,
 };
 
+struct imx9_pmu_events_attr {
+	struct device_attribute attr;
+	u64 id;
+	const void *devtype_data;
+};
+
 static ssize_t ddr_pmu_event_show(struct device *dev,
 				  struct device_attribute *attr, char *page)
 {
-	struct perf_pmu_events_attr *pmu_attr;
+	struct imx9_pmu_events_attr *pmu_attr;
 
-	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
+	pmu_attr = container_of(attr, struct imx9_pmu_events_attr, attr);
 	return sysfs_emit(page, "event=0x%02llx\n", pmu_attr->id);
 }
 
 #define ID(counter, id) ((counter << CONFIG_COUNTER_OFFSET) | id)
 
-#define IMX9_DDR_PMU_EVENT_ATTR(_name, _id)				\
-	(&((struct perf_pmu_events_attr[]) {				\
+#define DDR_PMU_EVENT_ATTR_COMM(_name, _id, _data)			\
+	(&((struct imx9_pmu_events_attr[]) {				\
 		{ .attr = __ATTR(_name, 0444, ddr_pmu_event_show, NULL),\
-		  .id = _id, }						\
+		  .id = _id,						\
+		  .devtype_data = _data, }				\
 	})[0].attr.attr)
 
+#define IMX9_DDR_PMU_EVENT_ATTR(_name, _id)				\
+	DDR_PMU_EVENT_ATTR_COMM(_name, _id, NULL)
+
+#define IMX93_DDR_PMU_EVENT_ATTR(_name, _id)				\
+	DDR_PMU_EVENT_ATTR_COMM(_name, _id, &imx93_devtype_data)
+
 static struct attribute *ddr_perf_events_attrs[] = {
 	/* counter0 cycles event */
 	IMX9_DDR_PMU_EVENT_ATTR(cycles, 0),
@@ -185,7 +203,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_6, ID(2, 70)),
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_7, ID(2, 71)),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_empty, ID(2, 72)),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, ID(2, 73)),
+	IMX93_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, ID(2, 73)),	/* imx93 specific*/
 
 	/* counter3 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_0, ID(3, 64)),
@@ -197,7 +215,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_6, ID(3, 70)),
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_7, ID(3, 71)),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_full, ID(3, 72)),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, ID(3, 73)),
+	IMX93_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, ID(3, 73)),	/* imx93 specific*/
 
 	/* counter4 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_0, ID(4, 64)),
@@ -209,7 +227,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_6, ID(4, 70)),
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_7, ID(4, 71)),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2_rmw, ID(4, 72)),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, ID(4, 73)),
+	IMX93_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, ID(4, 73)),	/* imx93 specific*/
 
 	/* counter5 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_0, ID(5, 64)),
@@ -244,9 +262,29 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	NULL,
 };
 
+static umode_t
+ddr_perf_events_attrs_is_visible(struct kobject *kobj,
+				       struct attribute *attr, int unused)
+{
+	struct pmu *pmu = dev_get_drvdata(kobj_to_dev(kobj));
+	struct ddr_pmu *ddr_pmu = to_ddr_pmu(pmu);
+	struct imx9_pmu_events_attr *eattr;
+
+	eattr = container_of(attr, typeof(*eattr), attr.attr);
+
+	if (!eattr->devtype_data)
+		return attr->mode;
+
+	if (eattr->devtype_data != ddr_pmu->devtype_data)
+		return 0;
+
+	return attr->mode;
+}
+
 static const struct attribute_group ddr_perf_events_attr_group = {
 	.name = "events",
 	.attrs = ddr_perf_events_attrs,
+	.is_visible = ddr_perf_events_attrs_is_visible,
 };
 
 PMU_FORMAT_ATTR(event, "config:0-15");
@@ -368,36 +406,28 @@ static void ddr_perf_counter_local_config(struct ddr_pmu *pmu, int config,
 	}
 }
 
-static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int event,
-				    int counter, int axi_id, int axi_mask)
+static void imx93_ddr_perf_monitor_config(struct ddr_pmu *pmu, int event,
+					  int counter, int axi_id, int axi_mask)
 {
 	u32 pmcfg1, pmcfg2;
+	u32 mask[] = {  MX93_PMCFG1_RD_TRANS_FILT_EN,
+			MX93_PMCFG1_WR_TRANS_FILT_EN,
+			MX93_PMCFG1_RD_BT_FILT_EN };
 
 	pmcfg1 = readl_relaxed(pmu->base + PMCFG1);
 
-	if (counter == 2 && event == 73)
-		pmcfg1 |= PMCFG1_RD_TRANS_FILT_EN;
-	else if (counter == 2 && event != 73)
-		pmcfg1 &= ~PMCFG1_RD_TRANS_FILT_EN;
-
-	if (counter == 3 && event == 73)
-		pmcfg1 |= PMCFG1_WR_TRANS_FILT_EN;
-	else if (counter == 3 && event != 73)
-		pmcfg1 &= ~PMCFG1_WR_TRANS_FILT_EN;
-
-	if (counter == 4 && event == 73)
-		pmcfg1 |= PMCFG1_RD_BT_FILT_EN;
-	else if (counter == 4 && event != 73)
-		pmcfg1 &= ~PMCFG1_RD_BT_FILT_EN;
+	if (counter >= 2 && counter <= 4)
+		pmcfg1 = event == 73 ? pmcfg1 | mask[counter - 2] :
+				pmcfg1 & ~mask[counter - 2];
 
-	pmcfg1 &= ~FIELD_PREP(PMCFG1_ID_MASK, 0x3FFFF);
-	pmcfg1 |= FIELD_PREP(PMCFG1_ID_MASK, axi_mask);
-	writel(pmcfg1, pmu->base + PMCFG1);
+	pmcfg1 &= ~FIELD_PREP(MX93_PMCFG1_ID_MASK, 0x3FFFF);
+	pmcfg1 |= FIELD_PREP(MX93_PMCFG1_ID_MASK, axi_mask);
+	writel_relaxed(pmcfg1, pmu->base + PMCFG1);
 
 	pmcfg2 = readl_relaxed(pmu->base + PMCFG2);
-	pmcfg2 &= ~FIELD_PREP(PMCFG2_ID, 0x3FFFF);
-	pmcfg2 |= FIELD_PREP(PMCFG2_ID, axi_id);
-	writel(pmcfg2, pmu->base + PMCFG2);
+	pmcfg2 &= ~FIELD_PREP(MX93_PMCFG2_ID, 0x3FFFF);
+	pmcfg2 |= FIELD_PREP(MX93_PMCFG2_ID, axi_id);
+	writel_relaxed(pmcfg2, pmu->base + PMCFG2);
 }
 
 static void ddr_perf_event_update(struct perf_event *event)
@@ -513,7 +543,7 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
 		ddr_perf_event_start(event, flags);
 
 	/* read trans, write trans, read beat */
-	ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
+	imx93_ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
 
 	return 0;
 }
-- 
2.34.1


