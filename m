Return-Path: <linux-kernel+bounces-45785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F67D84363B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E38F2283159
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8693DBB8;
	Wed, 31 Jan 2024 05:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="plI84fsv"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2063.outbound.protection.outlook.com [40.107.20.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EE13E481;
	Wed, 31 Jan 2024 05:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706680317; cv=fail; b=NU2N8Md2VJj4QeI6X6d/yjUIG13hmgjPL/UyY2XKFeIa7iK77IYIE8z4JaZ7k/aritXaBmGU8rGECm8V7RvG1rtfocqdj2YUPY1xPnuVKpWZe3HfBjXzR9/Nkgrrjiw+gQDgmDuL7mhYcbkfYmueXbWSLsqjW8ocKzDqNTXqNxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706680317; c=relaxed/simple;
	bh=e1+Gr6O5Rq5dDxl2J4FxwaG/SQZgkYxWEys7XxggBRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bVZltho2yOoh6bkkK0yB1SH6tw/nI46AHCkKWDqpUD+Z8GhWj1ay++xLXY1mHxREGa7xA0np/ACn97yMCwXyrsTrRtc/t2Gpc7ergxuzrtsQqCAoCmTwJfIc5ZY+0JBTU5QlQOMXWZrenbaFbZp3gHKRsgrcNstiEW5ZQF6OHQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=plI84fsv; arc=fail smtp.client-ip=40.107.20.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZpRAzMzS3mnam0hEL/VsgvJEpa4F5xO4tYWBiAqmQbZ0eoqORmvCh2B5xZqnNvx6bCKnswT9gyfaoKq1JHlZF7NMQR0yLvr/mzXJCayqm7s8fZ/qL2U9Fy3Gion+x/B6SGKUefW/KHjX4zxKb14zMbXNFJuVORkKpW+GB0BrT/BluYwZywQR/1dk3I0kYdtLGYsgmU28ZG8+6sNT0ZTfhHnlch2Ou+0pZBNZDL13pwlFxS75iuU6ykukcrcmn20VK1dB/SUYtCPjlh663Lbc4zWxnWeoJjrwAEpMaU4NscQ729FTAELf7FBazjr/19RQwowVVyfplOzGjUxiyaG//w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UPtYkEoPdypkuvdXdJNYM7uRMKl+NJ/DGucqE5TkSk=;
 b=RptRjWx4eMmQSyNhivIfZtUkIQb4nMcq4timNvEWgqFv1vaLTWxHLaz4PxAxD0djwc5sP9D2tTMFuQN5eJ8FUaXHtydHAZ+rvH4izLfuHIfmVybFeKwlfbR0t9TrceOPPbN4UeucZcuEscl7849JCsSUxAQkNHuRf6wzIymSivPjotYruJwEO9bmGUtu/tn23A15U/Q8QzXkw3HJditYbc1T7j6VqJ9dWL7sKQfOedSxkjUzdno5esrUldp1vzXSYjireZ+KRr9BUfGsxL+/4tK+4v/h2fgOMEmsXSYN6CEJpV1aQhtxliK2pMth+0p5VBSV2JFr/L18ZSLut61Vvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UPtYkEoPdypkuvdXdJNYM7uRMKl+NJ/DGucqE5TkSk=;
 b=plI84fsvQdZCIor28qBhJhybrZOCubuzNVqmVGVgsuBrOOK4jWCms72LkGtYDkEUDCdrsa8RWxFswDFUy7wqjBefetTyj6rZKb5TC0cDGWs5lPWDw3QVze+JX9cnedFRaNxQwpuniNtiLtu0T33Y3D03NeuvovXIAvG0Ptwktlg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DU2PR04MB8917.eurprd04.prod.outlook.com (2603:10a6:10:2e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 05:51:52 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 05:51:52 +0000
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
	linux-perf-users@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v4 2/6] perf: imx_perf: refactor driver for imx93
Date: Wed, 31 Jan 2024 13:58:07 +0800
Message-Id: <20240131055811.3035741-2-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131055811.3035741-1-xu.yang_2@nxp.com>
References: <20240131055811.3035741-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:196::20) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DU2PR04MB8917:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ee530a6-e1c3-41ff-7f2c-08dc2220b94e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XxuA95nfhVvrirhpYVjxnlKyJUa9B3ArFgpIFGD+foX+x6+za5AI8s0l7gOES8Kvzt26dCONxisX2RasxB3TGmOQWit1fr18iK3qid1+hxRlsfgkizTKR6b2Ccm1QYecGWqN/cWsuNWrKxPRXdlT3YjHcz0GmnVDyzdL88BwX+wZB1mJkxZfbozJYoK4Fi7JBYbmEOtg/KfaytMUZAQ3kUMHcZTrFCZ5CAsonH0r8VaLd195dD4iNZ9sm3aTmQRTHkQzy77DLK1P2RRrLq4jh1fVulDCOSnTgL3D2UbVyN3dGi/JsH4S+d3CXomobXpeWJD8rstylu6KZpy9qcE3rLVAfp+iU27Bdk5cy3o6CLRQh9nCOQJxwboYDdPcLQ+GOF8ju6VAtuYJtWJj9qBY5MOqNcW8fkkfQW/bq8AXqKe2ukaAzj2zNQIqGkuC3rmCw/MldrNgxKx1UsVeK3dNDClf3tGjkMCi3UOdB5vyPIKWQhTsxD+AsRX6j2tbPcDvM2+CjnyTYgsU6R6+tmlO7XHLPPM7B7OAus0ev/ByGaG7TozLc1run7BFXdwCOP8vGdAchI0sautMNSBkEXZmAeqUyhQFK1YSBbJom2TapHzcc76Fdx2m/Y6/1ZZFFTLiB4VMJKt4fZX6zyGEAuLA7w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(366004)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(38350700005)(2906002)(36756003)(41300700001)(921011)(66946007)(66556008)(66476007)(316002)(86362001)(6666004)(2616005)(1076003)(6512007)(52116002)(6506007)(26005)(478600001)(83380400001)(6486002)(5660300002)(38100700002)(8936002)(8676002)(7416002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jWIQS6Avhtp+FvKqVao79wNzY3thIcFxv9Ey4AfLbei2/Zk1P8gvZmd1cnaJ?=
 =?us-ascii?Q?jAi3fd1Y7jf3aC1yBnIK7BoO9syRYar85k20ZKkEuJyxECQK6uNhd5Z+afAn?=
 =?us-ascii?Q?wkmOTItzYq0CypRbRtRjdAHjZyVzTDDfWqTU4KRqKcrACIOx6G6j0U/ky4Yo?=
 =?us-ascii?Q?BTZo+2hf61j3oBFnDu6Ojwn6/NiU0k+X/mz4tJl2wLCRhUtDa87FgBLSi9iu?=
 =?us-ascii?Q?hKoC3/NQpnuRn7sXt5NsYyKImdA4/bzfzt0vpUN+O0+y5dPgMacIxrTpkd3u?=
 =?us-ascii?Q?VWui2YKSxOcqfXz+8x/P87lmyrL6D6E8pBsRsHjJj0R6UGUm5TzjfF9QuyKq?=
 =?us-ascii?Q?/Uyyqw0V5gOcIyPBKduaex/PZZNAO68ydHPuStPoCpb0ZInS6LOGz8lJZwWW?=
 =?us-ascii?Q?oz40fQgwd8FiuTuhlzBm+N1uzDN0k8urzlihAu20YHAAd3n2PKuikbu9W2Bj?=
 =?us-ascii?Q?+ko+I82SgHu8P9rd545Zt6+wRS4iD9w30k9EM8/WBFFtZQN01rr0g7j4ZrrQ?=
 =?us-ascii?Q?uYBrHWfFxt1NsiCqA9D92fOnWtLr1+5r7Bs2fEqegPlkPUv/QPaFW22F6ONN?=
 =?us-ascii?Q?Vygc7CvcLLbuKUGfDOJXO4+K9RdNNJHFO7AlAmrEBx7hR4UvYhVUVKE9OjW+?=
 =?us-ascii?Q?it1ouQNxkOtJgOs1yt2tnm1gBIdrRYSP+wOEvMHspBtxyzAnyYSWFEQL0rHP?=
 =?us-ascii?Q?qSqQM4AVuOo2Lyh9W1sKB954aR6G6ZbhbulgySjlIA/LbcRRfXRezrHpE23k?=
 =?us-ascii?Q?TGy68mDIkMYwj1fLqgbMetCvr6CuYTICKCT7SqLiqCCJqbDLLbsOewLIujoz?=
 =?us-ascii?Q?XW0jFWKqyqqRXGBcUNE0b8Otse5KTFHKIZDqkHxvtclbsdE+nVPfdax+HkL6?=
 =?us-ascii?Q?VEK2EFeIdrTcfxe1JCXHfe8NdB63a9XOdPyYOe5u9Sd5wOT+U7CBroTJ1/1j?=
 =?us-ascii?Q?wqD04QwgCNBv4QeOcwJcMDl5LdeYQTx3Ju6cR97FxWEc558LJTXLaCCT6dsI?=
 =?us-ascii?Q?N/+BycVq2vgJxs8Jw2lUWyZ9eg20VMACNmbz95dZmnlaK7Rq/8yRF/owe0Ft?=
 =?us-ascii?Q?skSH3O+X7qwqYbhjc8aziJn8rEhAaFnCUY5SrOQmLEzECqionLI+UJng4wKV?=
 =?us-ascii?Q?GshHIueFIBl8NQ0WrJUmPXUomuHRAC1eE63jte+RT1tcyJ8ApCNdSZeM1rU7?=
 =?us-ascii?Q?mbqqmvFtrAgauugeRZBj4kvDY8UlOs0nh6mx52ntH+2HGY/l4eKnGHwsiR7l?=
 =?us-ascii?Q?WJXwan5WNSApfelD3gkGy9B5HVFGHgl2tVKYx0c1w/Jsuty7aLopV9jCciVB?=
 =?us-ascii?Q?7DcEYwpybJ/jII5R8/pTUA46R4iicOu/QTVWuZIEEHWaPa/73Pr68y+24ZRA?=
 =?us-ascii?Q?pBgESBganU4WSno7GgqxJnOC0oRC6DyT0d4P/wzBqU6Wff3eJ6QNdJ2masBj?=
 =?us-ascii?Q?ViGWKIDTRVEh6ejgoPleyhXUuNP5oGaSWpUIOPUUQ/nsaen8dlJ47B3yRtGE?=
 =?us-ascii?Q?IHQwYAeYOxrdB4EZ096WWDOS65V+LAD+IwhhEj9FWiBlyf3fIwnhgm7iaTLT?=
 =?us-ascii?Q?kcxd6cyvN+UnSsg18aFs7hCvOPfsWt16aNxD858c?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee530a6-e1c3-41ff-7f2c-08dc2220b94e
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 05:51:52.5006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5fOqndz6yS7Wa5MNlCw7/7z+MX+Qb38bG/Icv6ghvFESOPE5JnWmRON0HXQMktRuxZw9cltOCG6Uluaix0wCMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8917

This driver is initinally used to support imx93 Soc and now it's time to
add support for imx95 Soc. However, some macro definitions and events are
different on these two Socs. For preparing imx95 supports, this will
refactor driver for imx93.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v4:
 - new patch
---
 drivers/perf/fsl_imx9_ddr_perf.c | 121 ++++++++++++++++++++++---------
 1 file changed, 87 insertions(+), 34 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 9685645bfe04..b1a58e9e1617 100644
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
@@ -51,6 +51,7 @@ static DEFINE_IDA(ddr_ida);
 
 struct imx_ddr_devtype_data {
 	const char *identifier;		/* system PMU identifier for userspace */
+	struct attribute **attrs;	/* AXI filter attributes */
 };
 
 struct ddr_pmu {
@@ -67,16 +68,6 @@ struct ddr_pmu {
 	int id;
 };
 
-static const struct imx_ddr_devtype_data imx93_devtype_data = {
-	.identifier = "imx93",
-};
-
-static const struct of_device_id imx_ddr_pmu_dt_ids[] = {
-	{.compatible = "fsl,imx93-ddr-pmu", .data = &imx93_devtype_data},
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(of, imx_ddr_pmu_dt_ids);
-
 static ssize_t ddr_perf_identifier_show(struct device *dev,
 					struct device_attribute *attr,
 					char *page)
@@ -178,7 +169,6 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_6, 70),
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_7, 71),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_empty, 72),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, 73),
 
 	/* counter3 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_0, 64),
@@ -190,7 +180,6 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_6, 70),
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_7, 71),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_full, 72),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, 73),
 
 	/* counter4 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_0, 64),
@@ -202,7 +191,6 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_6, 70),
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_7, 71),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2_rmw, 72),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, 73),
 
 	/* counter5 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_0, 64),
@@ -242,6 +230,16 @@ static const struct attribute_group ddr_perf_events_attr_group = {
 	.attrs = ddr_perf_events_attrs,
 };
 
+static struct attribute *imx93_ddr_perf_events_attrs[] = {
+	/* counter2 specific events */
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, 73),
+	/* counter3 specific events */
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, 73),
+	/* counter4 specific events */
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, 73),
+	NULL,
+};
+
 PMU_FORMAT_ATTR(event, "config:0-7");
 PMU_FORMAT_ATTR(counter, "config:8-15");
 PMU_FORMAT_ATTR(axi_id, "config1:0-17");
@@ -268,6 +266,22 @@ static const struct attribute_group *attr_groups[] = {
 	NULL,
 };
 
+static const struct imx_ddr_devtype_data imx93_devtype_data = {
+	.identifier = "imx93",
+	.attrs = imx93_ddr_perf_events_attrs,
+};
+
+static const struct of_device_id imx_ddr_pmu_dt_ids[] = {
+	{ .compatible = "fsl,imx93-ddr-pmu", .data = &imx93_devtype_data },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, imx_ddr_pmu_dt_ids);
+
+static inline bool is_imx93(struct ddr_pmu *pmu)
+{
+	return pmu->devtype_data == &imx93_devtype_data;
+}
+
 static void ddr_perf_clear_counter(struct ddr_pmu *pmu, int counter)
 {
 	if (counter == CYCLES_COUNTER) {
@@ -361,7 +375,7 @@ static void ddr_perf_counter_local_config(struct ddr_pmu *pmu, int config,
 	}
 }
 
-static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1, int cfg2)
+static void imx93_ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1, int cfg2)
 {
 	u32 pmcfg1, pmcfg2;
 	int event, counter;
@@ -372,27 +386,27 @@ static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1, int
 	pmcfg1 = readl_relaxed(pmu->base + PMCFG1);
 
 	if (counter == 2 && event == 73)
-		pmcfg1 |= PMCFG1_RD_TRANS_FILT_EN;
+		pmcfg1 |= MX93_PMCFG1_RD_TRANS_FILT_EN;
 	else if (counter == 2 && event != 73)
-		pmcfg1 &= ~PMCFG1_RD_TRANS_FILT_EN;
+		pmcfg1 &= ~MX93_PMCFG1_RD_TRANS_FILT_EN;
 
 	if (counter == 3 && event == 73)
-		pmcfg1 |= PMCFG1_WR_TRANS_FILT_EN;
+		pmcfg1 |= MX93_PMCFG1_WR_TRANS_FILT_EN;
 	else if (counter == 3 && event != 73)
-		pmcfg1 &= ~PMCFG1_WR_TRANS_FILT_EN;
+		pmcfg1 &= ~MX93_PMCFG1_WR_TRANS_FILT_EN;
 
 	if (counter == 4 && event == 73)
-		pmcfg1 |= PMCFG1_RD_BT_FILT_EN;
+		pmcfg1 |= MX93_PMCFG1_RD_BT_FILT_EN;
 	else if (counter == 4 && event != 73)
-		pmcfg1 &= ~PMCFG1_RD_BT_FILT_EN;
+		pmcfg1 &= ~MX93_PMCFG1_RD_BT_FILT_EN;
 
-	pmcfg1 &= ~FIELD_PREP(PMCFG1_ID_MASK, 0x3FFFF);
-	pmcfg1 |= FIELD_PREP(PMCFG1_ID_MASK, cfg2);
+	pmcfg1 &= ~FIELD_PREP(MX93_PMCFG1_ID_MASK, 0x3FFFF);
+	pmcfg1 |= FIELD_PREP(MX93_PMCFG1_ID_MASK, cfg2);
 	writel(pmcfg1, pmu->base + PMCFG1);
 
 	pmcfg2 = readl_relaxed(pmu->base + PMCFG2);
-	pmcfg2 &= ~FIELD_PREP(PMCFG2_ID, 0x3FFFF);
-	pmcfg2 |= FIELD_PREP(PMCFG2_ID, cfg1);
+	pmcfg2 &= ~FIELD_PREP(MX93_PMCFG2_ID, 0x3FFFF);
+	pmcfg2 |= FIELD_PREP(MX93_PMCFG2_ID, cfg1);
 	writel(pmcfg2, pmu->base + PMCFG2);
 }
 
@@ -476,12 +490,12 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
 	hwc->idx = counter;
 	hwc->state |= PERF_HES_STOPPED;
 
+	/* read trans, write trans, read beat */
+	imx93_ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
+
 	if (flags & PERF_EF_START)
 		ddr_perf_event_start(event, flags);
 
-	/* read trans, write trans, read beat */
-	ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
-
 	return 0;
 }
 
@@ -596,6 +610,39 @@ static int ddr_perf_offline_cpu(unsigned int cpu, struct hlist_node *node)
 	return 0;
 }
 
+static int ddr_perf_add_events(struct ddr_pmu *pmu)
+{
+	int i, ret;
+	struct attribute **attrs = pmu->devtype_data->attrs;
+	struct device *pmu_dev = pmu->pmu.dev;
+
+	if (!attrs)
+		return 0;
+
+	for (i = 0; attrs[i]; i++) {
+		ret = sysfs_add_file_to_group(&pmu_dev->kobj, attrs[i], "events");
+		if (ret) {
+			dev_warn(pmu->dev, "i.MX9 DDR Perf add events failed (%d)\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static void ddr_perf_remove_events(struct ddr_pmu *pmu)
+{
+	int i;
+	struct attribute **attrs = pmu->devtype_data->attrs;
+	struct device *pmu_dev = pmu->pmu.dev;
+
+	if (!attrs)
+		return;
+
+	for (i = 0; attrs[i]; i++)
+		sysfs_remove_file_from_group(&pmu_dev->kobj, attrs[i], "events");
+}
+
 static int ddr_perf_probe(struct platform_device *pdev)
 {
 	struct ddr_pmu *pmu;
@@ -666,6 +713,10 @@ static int ddr_perf_probe(struct platform_device *pdev)
 	if (ret)
 		goto ddr_perf_err;
 
+	ret = ddr_perf_add_events(pmu);
+	if (ret)
+		dev_warn(&pdev->dev, "i.MX9 DDR Perf filter events are missing\n");
+
 	return 0;
 
 ddr_perf_err:
@@ -683,6 +734,8 @@ static int ddr_perf_remove(struct platform_device *pdev)
 {
 	struct ddr_pmu *pmu = platform_get_drvdata(pdev);
 
+	ddr_perf_remove_events(pmu);
+
 	cpuhp_state_remove_instance_nocalls(pmu->cpuhp_state, &pmu->node);
 	cpuhp_remove_multi_state(pmu->cpuhp_state);
 
-- 
2.34.1


