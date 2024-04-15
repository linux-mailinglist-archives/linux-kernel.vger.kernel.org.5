Return-Path: <linux-kernel+bounces-144569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDFF8A47DA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A0BF1C220B5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE7B1EB3F;
	Mon, 15 Apr 2024 06:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QPhqDMuR"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2053.outbound.protection.outlook.com [40.107.7.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B6C1EB5E;
	Mon, 15 Apr 2024 06:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713161591; cv=fail; b=Xt+TWOmqnKuuX9ko/QzWuwB8VmAsqbK9ruiWbHw3sFH6dLfUq+Ei4a0nsvLCbsk4K8Rtlar6Upqp+DE1yhPIhnHCUWcW7DnI0J56j4MnXwvjWbdqhzz5NFef5cdmLUY69syvFCXTBUwVFJq4z9D+BR7XHj3IOk/Ih8ok2onDsFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713161591; c=relaxed/simple;
	bh=lm/iNfAT8Exa+FvLcuXAO6QwAV2VgfuwUv5whIj7yYA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gVp3dr1JrMoBYhzVaEJKhqsvoMnOsFNu/X8zMTGzReSF8NqnsLMnsdQhpAmX96Qgt820QaYdTjaMVgs7GjQOAZfR4v4moLZbgh8RFszqCXfrcXL6ypzOcUjK1gS6aYZNhtc9VbkoZqJDw6rlGrnuJFQtZ7a3E+/0ujDPMV3doDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=QPhqDMuR; arc=fail smtp.client-ip=40.107.7.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9aEtQ8e5oDRFLWqLHZjca3F9BYtSxep8X5W05AUehsb4ueBedXeA2zq3asi0Bo8NHi2uWhAO3rhOyU9P4bUJ6aGUU80cUz3+kbI2qHXF9t7q98m/j0g2mWT5vFIz28/A5J2qn6gYnJFIg2tLGskxH38tVmOQNuZYhxbUSapJblEwliq8tI7RQxfzdjQ69/soIubPXIcNJUp6clSyoMm9auK6g6JZrWBpv0712GIiYVtsU0vE2YImF60pdNDimU6L6x6RXnY5BGTuSxPQ+b+51sVS4WNrtwEopWxkjpUvzsG9ernGzGRAeCwSTdnKARZiKf5WfJXqlrvqqnovciSvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzuh7egtsYe15xOxiyjZGFDCZAv120F2ZFvgrgM0YDE=;
 b=T34gtNbQudmvsW9WvavpyszYKzof4mAymvq8hg5/ZUrk7gwcuIuopmK3o1oBz5cix6Q/6oWJMNam/m+5gxBDml5a+eLEBYFwJY0iUHCSzZzUpBPI3oWGAxGlykR7DhwZoguwntilq1kkyEVspyfD9QtVCdwhbDZKkMvEsAU+t/630l7NfPYtsmOL1qcq62ROOaktEMys1hp4/1vuHEv3UCuBvqhDiHFwEw5WKKA4+GKkMbzrCmYi9Aa/on0peaD6odxXzUSnbkZ9E/ipzQJARq28HZ/ai9/5r+gxZW5nbmVBSv6Ms1HWD8Xu/WplfH020FNoCDTvZ/BivBLsis+5Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzuh7egtsYe15xOxiyjZGFDCZAv120F2ZFvgrgM0YDE=;
 b=QPhqDMuRSJ3AsRzpCrbSIeFJej5lIPlGrfNe1WFnouj9HH4DrBNXmOhcqrQ1gOvr7h1bza26yajC8xF9SPugcy1NCEgJm8OwAzrqMCsgMes1YRQGey0E2SU8y4DUnjJgwrzCHOC6ua6+c+B5oPBq5jLQR2bYv44vOXwHN0sm9dY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by PA1PR04MB10117.eurprd04.prod.outlook.com (2603:10a6:102:454::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.43; Mon, 15 Apr
 2024 06:13:06 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f%6]) with mapi id 15.20.7452.046; Mon, 15 Apr 2024
 06:13:06 +0000
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
Subject: [PATCH v10 4/8] perf: imx_perf: refactor driver for imx93
Date: Mon, 15 Apr 2024 14:13:16 +0800
Message-Id: <20240415061320.3948707-4-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415061320.3948707-1-xu.yang_2@nxp.com>
References: <20240415061320.3948707-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:3:18::22) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|PA1PR04MB10117:EE_
X-MS-Office365-Filtering-Correlation-Id: 64e3f308-1ad3-4997-f63c-08dc5d131dd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	U5nXtm5BNzvXznQZQJfVx313w0WU06BoVyKdeRdK3uzQLYVz6J9houlJprrv1NQLZzv87miicjX0ejSlv5s14RbBe5uINo9Hjj/DsQOLd5S+iPilCSSJoc8Efx4aKBmWWU5+cL7bTOHrXgjn6x723y0qr86CsRmtZYVBF+kS1KJPbUaSiux37XrRRjazPPFLN/ptfsKWaXyJ4uURFFYy6xi7e8D3RzXAR7FtNKTap5Cokl7lZl4eIw62M5V25qMWHMuFfu/fJWpZqoHooIQ5hkmHOX3ek9SzmCSiYeucoomKB4GCbCDkm5s34+3L7v/5Y/aWkpKKAoIk32/1ArmEhVKfyAABOlaQrrdQ/1wKRBrbSOX+ozhUvkuM1YOq4+afVGDLKe5z/kkqcb2bDN2MGDVd/SP98KRif0GRmKs4lOkVYOjs0LW3mo5tMP5Cdm6tTkORPp4xUllmiZjNX8q36uLnEFmoAloxHZvPTLrV6rnVnbql6lF06USuVuqySvi79AbtjqPZMYB7Ma/wlzlbRleWtlbI8a0G/7T8CosdXeZ2WUV2NgVTl82ND47FkEUqFqRSC+TdZZYG4Z1iBTpcDsjX11WuFU9IOXt6bxn6hj3DWy+M/M5G2/voyTkwABKvFPkfubarDoUA0FTR1ICmnrC+2c2R/CGsuvkBzeF6Cgzjy9Pt51xML4OgMcAUNwcNaaEU0mOzewzqtsb7Z1hanPQvMn1qmD+dkDISK1NtYJ4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(7416005)(1800799015)(366007)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m8bd/sGjtn6lui9p3A9LOfMWGP4llWt5wuU6mdOhVsKAuNR+pRZI3MErHAcG?=
 =?us-ascii?Q?UHCNcGnILGAjOMHrOry6npxxTldHfKVxlMFrMJc4CuP2b2uVEs4mBTFUizaw?=
 =?us-ascii?Q?BR9K3wUdZY6Ad5ySlOqA8ob39GleVrptxDb8BMyzhCiNOprr8r0VYzs859c6?=
 =?us-ascii?Q?dzyzf1EzNKBhxoiZzW1L1BMAJG7tukiRgN8JleHo+iLDr1zVx+kvnSE8p+uU?=
 =?us-ascii?Q?Ct0HCrbwU3C5afUT0PtBwLXIR3mY7M1SHK360kIBuChHh/J5F8KNEjiVhaeW?=
 =?us-ascii?Q?BCjC/l07aNTBI/o5xQxVnd/1LaTDQjN945TVMzRaQuMj/VWNtyrp8Lu0ONfn?=
 =?us-ascii?Q?RyHn1KZIQ7tudyH7ghQV/2pQ2dKbyhyhHmhuLnCeIqZiafCeTY+5+U5bKyrk?=
 =?us-ascii?Q?VQ4i5yTemnM0wJZzcHGqYgTlyLD6rvdgYRUd1hQMRsLgBJM8HFQHSMwE7Bv7?=
 =?us-ascii?Q?ZkVGBY1RzcuBXggA1xl227AdCzt4zTLThAcs8i1xJ9wU9vWABboRBugiLoLV?=
 =?us-ascii?Q?tqXF/tSGignP8bUJwtPqUihnzY0UnjFFH/7oOIUfHJs3yvSiqpO8gfLtAWSE?=
 =?us-ascii?Q?DHPQgqCXLowA6sGYDFJNSGiJn3goiJo0HtFGGIt9BJgQdO+Y5Teh2Syl0W16?=
 =?us-ascii?Q?ZhDgi5BhfvYXJhuMQ7ADpsinxaUFNGUjTyqcctkAhiDi4vX/a3uc3ZDROkP3?=
 =?us-ascii?Q?/cTBHHLP/MYGY7x4+heHMSbR9/hAxLGiEPYzxiethV2qa5oUW9UaTIVYCNW6?=
 =?us-ascii?Q?pkarihnKHnkpSBq0/yCq1ePiD5xo5f658HqO4Sip1IB94XHsSZypA5ynXbRu?=
 =?us-ascii?Q?bFk+0JejKyesbF2Lq+qCXy2qqP3EoyTxJ5i3co6WEDGgGzmRHiiCyu7zYviT?=
 =?us-ascii?Q?ncplx/D8QXAjPdoG1sLpg6NMRkjZQwU/8M0PvpEpl9UsTVfsfRNHeuPv2JGQ?=
 =?us-ascii?Q?zWleY9Q1xCQRebpd8rLTapwymrjKRz162pQHJ3AF9S6+VC0PxiA7q/xLrdMf?=
 =?us-ascii?Q?uGlPBVvYXT/mkDmYpAqQSYTF/+JyEWWraiISzuBNOuyIWT7E6ySrUIff/NZC?=
 =?us-ascii?Q?Byz+Vbc81wCJaqUDd9XlwMFtQ8IkBXjdEMnRlLXFDwtqeSyXJbX6Lj5l+p0V?=
 =?us-ascii?Q?vP5Gfnrw7nZune/D7Y/+OtN62eNqjiYl6KBGNIVOy2SNqPNuRJzzX9KXSVfw?=
 =?us-ascii?Q?o40VGDOGUr21BbM7fwdvspWB8YmGklwccuD2X6FgjMzp0cvEtFZElunQNLGs?=
 =?us-ascii?Q?Wh3pi4K6opuAmoER3WxyvpG5ua3k+mUIAgYIO8749gHHhtdB/FOJBIBIYGB+?=
 =?us-ascii?Q?oiygtGBuag+rhJgYkmeuzuTW10NwijJdGaCHpMybxW4WzSkN1txPaMk5IbS+?=
 =?us-ascii?Q?NN2iTQ5MdUGK+Tq/OL5higyTvkPwYoRROxQWzTHHuDM+08veyDMPEvYIMoGC?=
 =?us-ascii?Q?mPW1xRyfjMfVtTqwaDLyZlQpI+g9wEEwG/wrvxEn4FAOSJxw163zkJ555iwU?=
 =?us-ascii?Q?uhQ5aMH0UEJGMJk9us63Yq4jYPJi1QtUJF0szYOr2C4PxUway9/4Z1xunPZ9?=
 =?us-ascii?Q?CXDiJbUmSL/c3UYpA9oqnU0XPXFzf6xDT5HWJ6c8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e3f308-1ad3-4997-f63c-08dc5d131dd2
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 06:13:06.7923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xqGtycyAT8vU94WCfvndopEnvke4XIzzYdXhIhQdeDdO6gDnoJwM8nz8umvUJ8ANwoGxeycST9xJKHygHT//Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10117

This driver is initinally used to support imx93 Soc and now it's time to
add support for imx95 Soc. However, some macro definitions and events are
different on these two Socs. For preparing imx95 supports, this will
refactor driver for imx93.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
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
Changes in v9:
 - add Rb tag
Changes in v10:
 - no changes
---
 drivers/perf/fsl_imx9_ddr_perf.c | 106 ++++++++++++++++++++-----------
 1 file changed, 68 insertions(+), 38 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 3bf054614b49..dffe7c1e4809 100644
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
@@ -370,36 +408,28 @@ static void ddr_perf_counter_local_config(struct ddr_pmu *pmu, int config,
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
@@ -515,7 +545,7 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
 		ddr_perf_event_start(event, flags);
 
 	/* read trans, write trans, read beat */
-	ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
+	imx93_ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
 
 	return 0;
 }
-- 
2.34.1


