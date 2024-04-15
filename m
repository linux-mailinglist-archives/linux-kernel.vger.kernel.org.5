Return-Path: <linux-kernel+bounces-144571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C950C8A47DE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B6431F22775
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5206A1EB3E;
	Mon, 15 Apr 2024 06:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jkr3xotB"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2058.outbound.protection.outlook.com [40.107.7.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248FBDF5B;
	Mon, 15 Apr 2024 06:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713161606; cv=fail; b=OkzEe7YpjOrynZaZ0ilj8dx70qJqwKerHEZuMlLf582qSOvCMcUcFab8uqlnjBPVtsVdcBLW94P7aViBDPJyimvzDXRBo1/Q+sjoqN8g0dfSj5nTsRqU7JP6dE3Nhb51rX2f1DrBjodyyNav1g1EKjKSi3/+odL4wJA8p2PLDJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713161606; c=relaxed/simple;
	bh=zcaRkLyhLc9auvrfA9HP/9Id29O3G/wy7HDajBgy724=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r4+nWxLBt4Wo/rYzi2M7r5SMghBpQ1uTpLwmFbZ0AyHSifgB2vYV7lVpWwIlPBbgi3GFfRY6KvVtq3lqapfqgsDK+KXQQzTZCGjE/heCfw6V1p4kyTbFXXQvdTUzrivZqfvJBnAczhraxoOhMMhNkxG5kIuS4PIAaOrjeuivVwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Jkr3xotB; arc=fail smtp.client-ip=40.107.7.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUFn7sMDO9RwVot94u/YFqkDlsLfUl/sAPfn+ZC33AeZNaST7Z1znc1tTjeXOVMMNbIKiUS+sTp4UryK7vNmx7kNWMb502jDxprGYIMyh/QQOv0+ulerjcHRkR6m4APyBbmFtgw+RWszZfBjMeNmD0x3712vuHm6XVNFEAV/QUBbX7ovST4G38FZX0B8mI1UGcwNCzSp/zTA9+2Pcbk15kFXzD3JvMXc0rswtqssNqubPIy/Sj8C+fKJpTo5RwQR+kNZZC82y1qPgtTNenP7PvT5M694qPyKUFuZSQpu9mOVEpHL3TV7YSuHIqOob7piX0wNXiXVmg2s0DqOf0YlYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dew3/NayzFR8KnIidVroghb9ImW1Btyh3d0++4mXQSM=;
 b=hVMRaL3y01erz5Psm2L3WZ3HA0ObhECpiN95MGyYZ5LfWUZ3mSmokbEA3yyExBEh7igGYHyS7fYHOJbntu3oA+mDAyKZhKDWV97E6igtTmsanLzAGRWEj2N8AmKTNJNUinPbz0BSfx3Rv7ew5cm7tztbI0TGDKGYqBuUVAH8EvBhMlxtlqDtmkjkc1xbz/GoyyDcUe10UeZJrPD9ZzIyQbN3jA4kfkJ/SvSFAiK8BgH7lyDzvpdVklHrvwyeA1MIh0CvHNFcu6yfqiiholi4550laz0HOv3IfBImS9V4+M6pjpzVJKiBl/CbShvRfTi1LhCBSgCeJ9wqaA932hvo2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dew3/NayzFR8KnIidVroghb9ImW1Btyh3d0++4mXQSM=;
 b=Jkr3xotBgFJ1f8ElL1CQjKwXlaATv3kD4w+6Ju56I2Czu/HHbCkANpP5UcG9BVP8Ju4mAXm3W1UaTU+phXsQ/mnqrHmsXvOt94rfgT4KNEzSDngnkhn2obCrrsyDF5WQRcCvVSVm2fk8FLK71+KKl2nZIq5nv7we16sHVezgcUY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by PA1PR04MB10117.eurprd04.prod.outlook.com (2603:10a6:102:454::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.43; Mon, 15 Apr
 2024 06:13:21 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f%6]) with mapi id 15.20.7452.046; Mon, 15 Apr 2024
 06:13:21 +0000
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
Subject: [PATCH v10 6/8] perf: imx_perf: add support for i.MX95 platform
Date: Mon, 15 Apr 2024 14:13:18 +0800
Message-Id: <20240415061320.3948707-6-xu.yang_2@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 12e93536-426d-470b-6689-08dc5d132689
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2XBp05TaRLA+dMDmMRefwY9h6NDS9ahTC24Ud0/0KrHEPg2VR5CbXERjU8CagQHGya8STD30XG2khmHYAJKPJNL4xkBm1/Avcgskw+8JKwbRME1rMfEHdZd5eBskz5sGaoQauKsbFQQULoHBmnEOycUsnvcp7ipfiHU18hnGsYPXYG+IQemZvnLIlIPdVy9MpwUc418yRErrhnyoFLi930G49AfiWWKN19Hj55hC+/O3uhWKdzuLQOxclAK6x4yDmSVwzVALjWgHQeTBRBcTFe9SU2h8yuNgYmued1uuj42rNWcTxG9KiHTwimaLFUcyvT2ZRBdSayChquPIJ7fQLNK8bTzwzBjPcBf0dg5T7VkfZq/AHM+lC/FCuAmLAdduA76AOW8utok7E6uhmhOZJo0M/hrkZnnEwtaTwECrU+sTz4OuAp1gLFH1YWyC5lmkcieHhz/2YeN4l9wAyN5IclE6clpaLmmeMNTAcFmMqrE85ROIk/ud1BiiA6X+xwTUYeuMOHtV/j1Zhvg5JtmjtONLZVfrTw+k19i3KboaTuLHAxTr6cuZPsunjajx4Te9s6NYYVRSpSHMOVC5FoOkdF/dufVcBDT716QwxixSH+wF9LKdzwv/sB0ThJD0OP9bbhAKsFk3A2+DYvFNzv9FA0OruYXGvdXXn4N3+uOxFVcVj7+lpVSHEPZ6X7OReibOrf39BfxB4ztxP9TzFbKCzFk0xDF9DOINtOtuuymM9Yw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(7416005)(1800799015)(366007)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Of+Xlb3i1o92wisqAoI1LCzOwWmiEdtvVQUMZsZQZqLlOZbfWsx1lRF7uk3j?=
 =?us-ascii?Q?gdVha8jxY4xLFjxSH/6C9qk9nkv13VNH9T5IzYTM3AnEGJ9RXUtYswZQOqr2?=
 =?us-ascii?Q?MyYTe+OAXIoF8WBZw796fM2DJDDKXyhPjqkmTAromFfWr/dyJvMT6s+SjBTM?=
 =?us-ascii?Q?s9ggdHbiq1vfPSsksJFrVHbSnnWT6CUIfMQpJ7WvJ4jn6jzfqGg4/nH0VJ2+?=
 =?us-ascii?Q?y+PoGKPK5eg/wGbxjk+j9JqVVG5k3n6OKuSpNWgGQMh3O/XWjNAacIShDL9T?=
 =?us-ascii?Q?qLY14ttAr59K+lckG6GiEEbh6uKmtR1jnxegmjzAe44BCtjXZx5GSDWGH1SY?=
 =?us-ascii?Q?AgFgEn6OL5KypvpHuF6tXaPf/VQNgHYEtff3Pj6y247azWe/NA9DG7LpvYOI?=
 =?us-ascii?Q?uuQLvo6MawVht5sVRLap0qIPo6pBBqnaR76Yj/1JfirZFeuwoAHf7eribAPA?=
 =?us-ascii?Q?B8UNlAiD8oXAokt99y0tYUAji2EDnSX9nfepH+LIcaX4KT72iuGSbXzCSMH4?=
 =?us-ascii?Q?8ZlR6XwUQ0iBs7a/F042wEIS8sqaQcprM9KZWzMp/nijB1hYDiFOD9o+Dj87?=
 =?us-ascii?Q?jupDFZEDabxBhPwc3gT+5OI/jDd840q0zSlBF9Ltik+n9lNXbSw2Mri2NPe3?=
 =?us-ascii?Q?WLNze9eyF2SwCtFj/sXaoOO6WVL6FzQ67OksJrxHXaZSqvYlDRbzIi+GZJyK?=
 =?us-ascii?Q?HeN92AxX9JJgxl7omYtKGvVkSsRKb0x+o3qKZDeaFN6k64Xn+iQ9fBSdWe2d?=
 =?us-ascii?Q?asbFmQeeteTPnf7c5nBZJgZoyLCAEvqdbVV77hiC+q5ytBm3gbpZNBb/ln7a?=
 =?us-ascii?Q?eN5TBdrxUK16GCU3OrcZbBGep+gDF9bMQ/bc+LYW3pUVYbW66KRA3zZc4W8F?=
 =?us-ascii?Q?nqtp5rIx3CoacpmIEJiHD1dr17IxlrXbCMSfFDDXV05p/Eg437F0oadc+1Uw?=
 =?us-ascii?Q?4YLSgqxJMNZVxbOzr43rweQXx0Uyr6tbmiGl4xF1b0c5W78FTZbvcxl28+me?=
 =?us-ascii?Q?dg22uJgTcKYFXolID+fGuJJiIX0sQiNguJpnK1oodahwYhVM0fWmiQJ3h1Ax?=
 =?us-ascii?Q?D/Q9TTx0MOuc8aQ2OQ4Zz/WGxHGT7hTRsjT/2ANOt+RF+kzepKaud9z2ny0y?=
 =?us-ascii?Q?dCxRK4hu7th8hVUucVdn2CFVart8n15mMSl0dZe6Y2vcK++UFadRXl++YrVr?=
 =?us-ascii?Q?XJ4s7dqVQgZd2ufxJ5Cg0Nv9LEnqMxgiy4+qKAM0SvTdvPbTekXt9O1ZI9jE?=
 =?us-ascii?Q?BMpE8RyYEYgNXdLtY19dMYBpnIC+1lQNAWJr2g6Fc1HkbIx4hseLV1SyQYag?=
 =?us-ascii?Q?vqr+OCfl5lYamZhG14m9Jk5QWbwUXorSG1ei4BitzLBdC8bMx0EqKKZyPTVj?=
 =?us-ascii?Q?4tXeJ8/q+VfNKqqDAO4L3QZm8ymEwqw9yZzxNMYndORJd90x2t0uqcM+UsYa?=
 =?us-ascii?Q?hMob6R67M8Nh2WXnaWayolec1GqTQu8ESZzho1ean15GdTZw4vNUh3Gd43U3?=
 =?us-ascii?Q?FCxsxfgVEmvFPyaP8a51uB7aAO21coMWzOkeKiqd/aB+MD+IVDicvTNJekDa?=
 =?us-ascii?Q?HIE4Rgp22t12OgKJwuSDzhOdB8KSgSya51eWvyQJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e93536-426d-470b-6689-08dc5d132689
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 06:13:21.4507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rEGNQPhjz+tyHpLlwahDwRziXIzQf3jbYRAEMKwj/+vlz1YZBwhJvc5dJO+kA5iM5RKAd755K5EhfUgEtcIy+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10117

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

Reviewed-by: Frank Li <Frank.Li@nxp.com>
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
Changes in v9:
 - add Rb tag
Changes in v10:
 - no changes
---
 drivers/perf/fsl_imx9_ddr_perf.c | 89 ++++++++++++++++++++++++++++++--
 1 file changed, 86 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 53cb2842956d..d55845c19278 100644
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
@@ -432,6 +459,57 @@ static void imx93_ddr_perf_monitor_config(struct ddr_pmu *pmu, int event,
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
@@ -541,8 +619,13 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
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


