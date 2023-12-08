Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E458F809E8E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 09:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573333AbjLHIs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 03:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbjLHIs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 03:48:26 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA720171E;
        Fri,  8 Dec 2023 00:48:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZ82xm1gA4kcRLV3e3hWGT0rUVHBcWG1IDcthId0BjKAtnv1vedzIELPiWOfAE1VUq3cW5xiuQjF0t91T8oPYW/qImrTAnFlFFdONotWG7A/Yf5DLlatZCKDCKDatDnaaAuEo0jghsvtyly6adkocBW412NYgqy5iLIT2fao7Itx0CZ8Yps4UX4sSwKlzMBXhD66NKwtYv0faVObUOTIAfCdC7oiX7KeFMO5c16wrGgwNteXC3pmrDQ7VuG5j10pt3Zi+fpBV73ViGEJHHdhJcIXRiH3ZkdpgQuOAMvNK0b477UJzTUFIUIhKNX3/h7t4fC5raixKPlidDEdrJMzww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHcmHeyMjYg0gTj8oOhlrIyvTgwuA+8mXICPBrZZCJU=;
 b=FFiXvd0igwsMuhf3RAOiCBofj9o6QKqHaHL69hZOZ0tQPvnSqA3U6wLi1qHnJb81gGzDclsMWJNh/xvA61di0MzeA3NXrHgHuHSR8GgmaQqWePT6TmAdQBcm30fGCOBYmLmeKQvqtCaolsi1htjWxbkkoMjDppBuKqH7CEW6cC+7sFEd6q1hJfGfIZw2aE28Z0KLgp7brUrV+VfPZXoOOebLHpFjRRwK8Al4bLR3HYGiscloG3bQjJDCggq/FIB9SuDmk6BpizD8Qjnv4Qs58hVPgg+IcsXxPwLcIqea0h+HxY2iQkDwE4p0xCbJKgCVMf2uegareNJLY/RStohCPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHcmHeyMjYg0gTj8oOhlrIyvTgwuA+8mXICPBrZZCJU=;
 b=OTO0NJPDniSqB7/9fkA/PA9aYd6G51tvydzPQ0GxbhqAInjaneWXapbsuVHswHV2nUtstCTorcq7UBe8Ki1co7csV9n4ToWPFBBNoGUoaHiUqXaS+e6sRoYHyVyoZF2FN+vxEHZqU4wntCUdEd4cOAYbCtImj0MCJgFO2BqYrSs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB5146.eurprd04.prod.outlook.com (2603:10a6:10:23::16)
 by DBBPR04MB7594.eurprd04.prod.outlook.com (2603:10a6:10:203::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 08:48:27 +0000
Received: from DB7PR04MB5146.eurprd04.prod.outlook.com
 ([fe80::709e:6876:7df0:fc30]) by DB7PR04MB5146.eurprd04.prod.outlook.com
 ([fe80::709e:6876:7df0:fc30%7]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 08:48:27 +0000
From:   Xu Yang <xu.yang_2@nxp.com>
To:     Frank.li@nxp.com, will@kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, john.g.garry@oracle.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com
Cc:     linux-imx@nxp.com, mike.leach@linaro.org, leo.yan@linaro.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        xu.yang_2@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH v2 2/4] perf: imx_perf: add support for i.MX95 platform
Date:   Fri,  8 Dec 2023 16:54:00 +0800
Message-Id: <20231208085402.2106904-2-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208085402.2106904-1-xu.yang_2@nxp.com>
References: <20231208085402.2106904-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To DB7PR04MB5146.eurprd04.prod.outlook.com
 (2603:10a6:10:23::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB5146:EE_|DBBPR04MB7594:EE_
X-MS-Office365-Filtering-Correlation-Id: 89872e1f-e52b-4b6c-6bef-08dbf7ca7243
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tNlsYBwoJGzW4e56y4ZoAJQQhk/pKypnRTabpyvSHN76oDlL7zJFdTfmy/G61hPqMRlOajTm1KMmVr3TP2l1W+WCVr4KD4e0TzN/Om/frST9fc45C8wsygSIUa+EWpdky7sO/Axg+oeH6fZEW4bQitfTxErjmqGqt5L59G6GetgmpjtLkWBc4I0wK0K8pg4bRrREr2fulZWBX03rE7UTaKox6xOqEU2kRWs1TRDDx3uWphWow2tjUES+aUBUj/jpyeUJL0lfPKFzDkWPGjPw6hb3lq5G/A3C8qmIE4wzWYd6r1uvPG+UwNVIkJkCQvy9kF408nkOVNNcQFPTH2Vo5qO1LrvRAhExGxsz3fatLtypGTRQPIEwmpSDSLAQqthn/FnZo4KFONsViHG+fsb7HAy3K/gP7vDIFWLdV0PAiuK8qokLpe1Y3Kr+U9fCDvscpHQanLi+nkL8Qagah4gXBwf1IblDGkf4II/wTNo8Spt9OPq6YRdfSR66x1hclWKYcQHQfKwg4Mv7HFG1/JWL2aXeuJvyR+PXy/3H/WijWFAs5waNPxhxSPHB4IW4IKf3PJNHO55BvNjiijCDfAbtXhZZXbh+y5xYX9Mo/uAWef4wq4gP+ICzOTl1aR3gBjcIUVVfJIH5ufGzNzLJKo8jzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5146.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(396003)(366004)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(478600001)(316002)(8676002)(8936002)(4326008)(86362001)(6486002)(66946007)(66556008)(66476007)(36756003)(38350700005)(30864003)(921008)(5660300002)(2906002)(7416002)(41300700001)(38100700002)(2616005)(26005)(6512007)(1076003)(83380400001)(6506007)(6666004)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8JOIbfFocYBEqox5B9e2OW1wsPLfnEoqTmV7MIdM/0z/TW7WGz9UOOJzpzxt?=
 =?us-ascii?Q?ZOBPH1es4HwMTn9SKPWG3CnmBCfx0Yth4hs6KuBeF7Q9ONSlLV6l7ekUzs0Y?=
 =?us-ascii?Q?1kLTVOkSD/WeaDO9S6+ZkpFovG35Ch/wpGvvd2y3HKzRFsK9dY0z/ScRd4LM?=
 =?us-ascii?Q?/i82qqMjt4mqGEuLRhA4oweRvuUWCiGxh6u7t/ztKb9CP2pf+QHJW0iXol/p?=
 =?us-ascii?Q?9rY+1gwF3cjsP5TexS3SkI6uvQazcVXpq1UpL4gKgRTNS5u90mN4dReQaHzq?=
 =?us-ascii?Q?GSe4ZpoOXNYTJWaPyeQX5bsMrZEHgN9Wq8bF87/UNArvJM3SD3VwCfRrtoIb?=
 =?us-ascii?Q?dvL9ZBaIYanaA3FDSjo373meOiglxgRye6R0JocIvxxKHCqTuBNrS+EBmq3d?=
 =?us-ascii?Q?nOiHmckVmdZrs/cOCOTC0+Vyi27T9TYNb01GmbqApMp0stS2VnWJwHb+rLwZ?=
 =?us-ascii?Q?VjiQAmSA1XAzWojx9otUa3zaXF1EvZ95PgcVKuwlUcwmYIhlJGXhXnpqN44o?=
 =?us-ascii?Q?suGClCYHZEF2ETUJG/nJIExQNwSHUeypgFf4YNfk4Eptk5fymZfkBq6jjtga?=
 =?us-ascii?Q?PKYvT5tu+80rDf2018h2qSQgeX9HsR7flPpWoIct58f8/jh2Y0vE1oZd3Igi?=
 =?us-ascii?Q?r6yudUNegG1l3X8qXcOCGEoMwGiGJ2+DGCb8DFaUaH8SyExFeFL+q0uF4XcQ?=
 =?us-ascii?Q?u9XEQOHwmKCej+Q26Lt2aZidCPTOorUbWTua46QrNKseGDrw0G3NZc9sKStR?=
 =?us-ascii?Q?LTenb6RnhjJPXdFxQ2fwyliL9FR2R5Cn//Q2G5FuGZL9TLOOEtKQDVuYh7l1?=
 =?us-ascii?Q?bMCzzcLsiGawv/UK9qJe8fBZAJAXxR+9racG8rAuaJ0yg2iZQP58GhzExfLO?=
 =?us-ascii?Q?pWG/H+jajkNiGmCEX2u7JZ3sY3iBk0XV80yA7SMeyayh/v+BJcZnvJ6QPFcR?=
 =?us-ascii?Q?aedNIHMWpHbeMi0klY4iPVLWUlRBF0S5hLjLwGrIwWUKI6VERnvQBnX/s60k?=
 =?us-ascii?Q?B0kE+hDKie+8bApF2vQkWQZbLKAzwxDzITAMDBjLhL7e9wR9ABIcZ6A53FaU?=
 =?us-ascii?Q?tCp1Q5pTalS1DStmhsGAHxuRcd3ckCVpg1WSc+UkIgS8g5q6OPYkrbAf9vLo?=
 =?us-ascii?Q?7QOS18Vc1n2kpzJb7IcGPfZvWv7MuF/+g2joKmqnY5K6lCkq/+YGZSh4EuKO?=
 =?us-ascii?Q?kcM907YJaBO2zd/CPCKsQ8GOcenwmNEd7swasmdF87hCyBsgWI6CuGRrC3Be?=
 =?us-ascii?Q?6tjHEpPyCLFUoOjBkjdivZSa7O02dorOO5ng/mVvIuw3rQim2IGjKI4debm0?=
 =?us-ascii?Q?QHHOuZxn9Kd/+du8iaRIMK9N6wKplSCCTxXAoWSVjfZEg2G56CmpgYISR6LK?=
 =?us-ascii?Q?/sc7iqi8+l+wcAI3qS+qR74brzZKlkFcmh7wZQDO6wdCBlqEDCByiCc0w+yg?=
 =?us-ascii?Q?8xfwXU3LYyahuecJ0hsZ9zPVIup4h9SSrBfWvUgtBqzujhLlhCnxAZm0yhLk?=
 =?us-ascii?Q?d6NP+kpjjLFVaXm+KnHC4EbZruKqDmLis+FnLecBbwXXJ2jTALOVLfi6spjb?=
 =?us-ascii?Q?nisNQz4BxW7ip5wCN8QkDGPYKjnyDp48pLOGP8T/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89872e1f-e52b-4b6c-6bef-08dbf7ca7243
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5146.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 08:48:27.8187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +lzvAF4mH4W+rKgHzQnhhJAj7H7577WGOu9zgjvJltWHxYDiGB0N3LOuub+F9f1DklzY8TqpdpXlYkTyTa8fjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7594
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX95 has a DDR PMU which is almostly same as i.MX93, it now supports
read beat and write beat filter capabilities. This will add support for
i.MX95 and enhance the driver to support specific filter handling for it.

Usage:

For read beat:
~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt2,counter=3,axi_mask=ID_MASK,axi_id=ID/
~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt1,counter=4,axi_mask=ID_MASK,axi_id=ID/
~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt0,counter=5,axi_mask=ID_MASK,axi_id=ID/
eg: For edma2: perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt0,counter=5,axi_mask=0x00f,axi_id=0x00c/

For write beat:
~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_wr_beat_filt,counter=2,axi_mask=ID_MASK,axi_id=ID/
eg: For edma2: perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_wr_beat_filt,counter=2,axi_mask=0x00f,axi_id=0x00c/

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - put soc spefific axi filter events to drvdata according
   to franks suggestions.
 - adjust pmcfg axi_id and axi_mask config
---
 drivers/perf/fsl_imx9_ddr_perf.c | 203 +++++++++++++++++++++++++------
 1 file changed, 169 insertions(+), 34 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 5cf770a1bc31..261fa7d85753 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -11,14 +11,24 @@
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
+#define MX95_PMCFG1_WR_BEAT_FILT_EN	BIT(31)
+#define MX95_PMCFG1_RD_BEAT_FILT_EN	BIT(30)
+
+#define PMCFG2				0x04
+#define MX93_PMCFG2_ID			GENMASK(17, 0)
+
+#define PMCFG3				0x08
+#define PMCFG4				0x0C
+#define PMCFG5				0x10
+#define PMCFG6				0x14
+#define MX95_PMCFG_ID_MASK		GENMASK(9, 0)
+#define MX95_PMCFG_ID			GENMASK(25, 16)
 
 /* Global control register affects all counters and takes priority over local control registers */
 #define PMGC0		0x40
@@ -51,6 +61,7 @@ static DEFINE_IDA(ddr_ida);
 
 struct imx_ddr_devtype_data {
 	const char *identifier;		/* system PMU identifier for userspace */
+	struct attribute **attrs;	/* AXI filter attributes */
 };
 
 struct ddr_pmu {
@@ -67,16 +78,6 @@ struct ddr_pmu {
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
@@ -178,7 +179,6 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_6, 70),
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_7, 71),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_empty, 72),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, 73),
 
 	/* counter3 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_0, 64),
@@ -190,7 +190,6 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_6, 70),
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_7, 71),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_full, 72),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, 73),
 
 	/* counter4 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_0, 64),
@@ -202,7 +201,6 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_6, 70),
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_7, 71),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2_rmw, 72),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, 73),
 
 	/* counter5 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_0, 64),
@@ -242,6 +240,28 @@ static const struct attribute_group ddr_perf_events_attr_group = {
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
+static struct attribute *imx95_ddr_perf_events_attrs[] = {
+	/* counter2 specific events */
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_beat_filt, 73),
+	/* counter3 specific events */
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt2, 73),
+	/* counter4 specific events */
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt1, 73),
+	/* counter5 specific events */
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt0, 73),
+	NULL,
+};
+
 PMU_FORMAT_ATTR(event, "config:0-7");
 PMU_FORMAT_ATTR(counter, "config:8-15");
 PMU_FORMAT_ATTR(axi_id, "config1:0-17");
@@ -268,6 +288,28 @@ static const struct attribute_group *attr_groups[] = {
 	NULL,
 };
 
+static const struct imx_ddr_devtype_data imx93_devtype_data = {
+	.identifier = "imx93",
+	.attrs = imx93_ddr_perf_events_attrs,
+};
+
+static const struct imx_ddr_devtype_data imx95_devtype_data = {
+	.identifier = "imx95",
+	.attrs = imx95_ddr_perf_events_attrs,
+};
+
+static const struct of_device_id imx_ddr_pmu_dt_ids[] = {
+	{ .compatible = "fsl,imx93-ddr-pmu", .data = &imx93_devtype_data },
+	{ .compatible = "fsl,imx95-ddr-pmu", .data = &imx95_devtype_data },
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
@@ -361,7 +403,7 @@ static void ddr_perf_counter_local_config(struct ddr_pmu *pmu, int config,
 	}
 }
 
-static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1, int cfg2)
+static void imx93_ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1, int cfg2)
 {
 	u32 pmcfg1, pmcfg2;
 	int event, counter;
@@ -372,30 +414,80 @@ static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1, int
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
 
+static void imx95_ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1, int cfg2)
+{
+	u32 pmcfg1, pmcfg, offset = 0;
+	int event, counter;
+
+	event = cfg & 0x000000FF;
+	counter = (cfg & 0x0000FF00) >> 8;
+
+	pmcfg1 = readl_relaxed(pmu->base + PMCFG1);
+
+	if (counter == 2 && event == 73) {
+		pmcfg1 |= MX95_PMCFG1_WR_BEAT_FILT_EN;
+		offset = PMCFG3;
+	} else if (counter == 2 && event != 73) {
+		pmcfg1 &= ~MX95_PMCFG1_WR_BEAT_FILT_EN;
+	}
+
+	if (counter == 3 && event == 73) {
+		pmcfg1 |= MX95_PMCFG1_RD_BEAT_FILT_EN;
+		offset = PMCFG4;
+	} else if (counter == 3 && event != 73) {
+		pmcfg1 &= ~MX95_PMCFG1_RD_BEAT_FILT_EN;
+	}
+
+	if (counter == 4 && event == 73) {
+		pmcfg1 |= MX95_PMCFG1_RD_BEAT_FILT_EN;
+		offset = PMCFG5;
+	} else if (counter == 4 && event != 73) {
+		pmcfg1 &= ~MX95_PMCFG1_RD_BEAT_FILT_EN;
+	}
+
+	if (counter == 5 && event == 73) {
+		pmcfg1 |= MX95_PMCFG1_RD_BEAT_FILT_EN;
+		offset = PMCFG6;
+	} else if (counter == 5 && event != 73) {
+		pmcfg1 &= ~MX95_PMCFG1_RD_BEAT_FILT_EN;
+	}
+
+	writel(pmcfg1, pmu->base + PMCFG1);
+
+	if (offset) {
+		pmcfg = readl_relaxed(pmu->base + offset);
+		pmcfg &= ~(FIELD_PREP(MX95_PMCFG_ID_MASK, 0x3FF) |
+				FIELD_PREP(MX95_PMCFG_ID, 0x3FF));
+		pmcfg |= (FIELD_PREP(MX95_PMCFG_ID_MASK, cfg2) |
+				FIELD_PREP(MX95_PMCFG_ID, cfg1));
+		writel(pmcfg, pmu->base + offset);
+	}
+}
+
 static void ddr_perf_event_update(struct perf_event *event)
 {
 	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
@@ -476,12 +568,16 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
 	hwc->idx = counter;
 	hwc->state |= PERF_HES_STOPPED;
 
+	if (is_imx93(pmu))
+		/* read trans, write trans, read beat */
+		imx93_ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
+	else
+		/* write beat, read beat2, read beat1, read beat */
+		imx95_ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
+
 	if (flags & PERF_EF_START)
 		ddr_perf_event_start(event, flags);
 
-	/* read trans, write trans, read beat */
-	ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
-
 	return 0;
 }
 
@@ -596,6 +692,39 @@ static int ddr_perf_offline_cpu(unsigned int cpu, struct hlist_node *node)
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
@@ -666,6 +795,10 @@ static int ddr_perf_probe(struct platform_device *pdev)
 	if (ret)
 		goto ddr_perf_err;
 
+	ret = ddr_perf_add_events(pmu);
+	if (ret)
+		dev_warn(&pdev->dev, "i.MX9 DDR Perf filter events are missing\n");
+
 	return 0;
 
 ddr_perf_err:
@@ -683,6 +816,8 @@ static int ddr_perf_remove(struct platform_device *pdev)
 {
 	struct ddr_pmu *pmu = platform_get_drvdata(pdev);
 
+	ddr_perf_remove_events(pmu);
+
 	cpuhp_state_remove_instance_nocalls(pmu->cpuhp_state, &pmu->node);
 	cpuhp_remove_multi_state(pmu->cpuhp_state);
 
-- 
2.34.1

