Return-Path: <linux-kernel+bounces-45786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 119AB84363D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6034288D41
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CAB3EA83;
	Wed, 31 Jan 2024 05:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Sx732rWH"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2053.outbound.protection.outlook.com [40.107.20.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A508B3EA76;
	Wed, 31 Jan 2024 05:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706680324; cv=fail; b=jA8B+khHpve+XHJ0ewTvHpUiTrjjv0F1CGfS3WOVfqOMOnl4lJyaVTiTD9gg86CyYWy177/EwPPdmi7TKMpmXv4fpbzipWwRMhyv6c/sQwvmrSWRHavM8ow8VrWtjHoTh5L4tlnQmoAcEBghwz2HNHxq0VFttVgbJtD2KtpzX0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706680324; c=relaxed/simple;
	bh=KNhmptDkCM7YBwd4mq/S09xULaZM58QqaTYnPL2kbcc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qMskxKxWAt7SMoBywjzgqMEJjtGHYK6zoMXyi2wD5+PjsKnKKroLCWgTw/VGT3hUKShm/ZAxUNoVdmZd2C6QjNnRcR8hNn8J/36BWcmgfpEeiB/0rQdAKX2CVNa70ETOMZFkQbyz6gHav3Cmh+5gKCgsZoIx9kM/1w8OYR4hvDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Sx732rWH; arc=fail smtp.client-ip=40.107.20.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5QoRbgEOeAV8QdDWdfm/rcB9wq88HZLoaDyg4SvIZn1vhnfnR2xe4dMCtsJj0HzCaW0xUO/A5ucJK+SrMXP/ZYoK8udMWUp/jtPG5ev10RG2jBC0J0dbAqN0mIFhDYQmBgHhRxmAcodI/q1qIIYDK7c3rt7EF5C7ho1e6adWi58fLps90AfTUEvg/pHROUILK4HuhDK1DsCIcSIrjovBcUcAGfxWUytip5DvZmFm5MTcc+q/iEVjBoVM5uxNkW5n7a3vg48Id2zApaV3tDIZ3F4Q5UZvAYxm+xr6bkZhN4Q5yZqOnFSkefl7I/E2Js2LOsGOR2QDyze7IcbaL51ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6Ss69IAFApk/iIN3SDUVO4qAB+QehpT+RfXON/d2qw=;
 b=A3QwLjyG9U0UTYX5/GvFvwqP4//rifhg//yMEI8xChF8h3Hb1uwNd+5Fbl2hIAAAmFPAjSdZOQtTSdOu3UCd2bjfODy+wWGUOhIcScBTG0HPtgYT4Wx3d4lW2Q0Un9xhLSzrnmRJeBh2ToTIFgAJWaljOZHwQKewIIKihXVjjpeTsOhULh0+i8GJYLEnC6AQp8/79JIdrshlsJDbSKH7cUUnQX9FHIyxtrgF+5lBBIift1nEd76nM5FCMO0Y2Q51njw/PmzkmKfSWkd6h/BBDpU1bbuz7dV+3ZeHU0lhfzbwuFE2LOwXg4wZe9pTUHMw/xjTy9M8+76PhG91fSPwRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6Ss69IAFApk/iIN3SDUVO4qAB+QehpT+RfXON/d2qw=;
 b=Sx732rWH77kWBbpP1/0o4ybWYk6ymuwhtJkC+P+YHth25nFyeZckuBaWuCTR2urzRoovzGf2KLtc+X5PSCFEcxeNIHsOt2CisjSFNmWsPEdZOPckYYyeJ/3GpZaE3/cAaSFPGihfoE5BwpMwM9Wl2mmw4tb8VPNVaqxOaoxX6ro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DU2PR04MB8917.eurprd04.prod.outlook.com (2603:10a6:10:2e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 05:52:00 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 05:52:00 +0000
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
Subject: [PATCH v4 3/6] perf: imx_perf: add support for i.MX95 platform
Date: Wed, 31 Jan 2024 13:58:08 +0800
Message-Id: <20240131055811.3035741-3-xu.yang_2@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6f998e44-7f3b-4e37-3973-08dc2220bde4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FRewQDjndR8J4iaaKzDOYcfHRkl9FQkigfBUcWBfI+KNo2MT1zVek40qNLT3zJR5cfQeQ9c51uI6dlSKTb63L6s2+my1K6X2heRHjpqL8KnFtoqzqskGEgkXJHngs9GHF3cszrj6sRwcRAkFWD4BOeA+KpmbUAwaPQJdjxBIjTNLFSP6zeaK5ALcPisL9e9M8S9y+9+mVT6YGRMj1THEbg2HxItda2yChInMSddbZrpkc7/VV6LM5iclalacau+DgcBJe1mRrIJjpj0+T8KRzv1P6ck7x19QmqMRobuSsGmNER8Apgp7q1Ss5yqUiLP4NCWSZUM5SxZBJhPAfMF6A2xBwMIJ3B1X+sYutEXpCLmUpIy75uNhZvF6Cp+O2AsNf15OBRi0EARGEJ5X8FOLUtH4ISYUgMVBaYldSe522IpKtTcyO6jxA7jI9l3bwL+1cWRCn0GL+1ZyryFHpDl0ikfBOrmoapGB05A/Lk+OgwX4thZ5mM/py/4bh3AudIGtxqDuIC/XT3rQtaWdxcNloR1U4zQxBt4uCd2UVlbD3AgjJHk4q7wc5PLE8/uf3h/Zc9p4CDo5jdlG0SRmS8wcMRJwpw5N07Bz5G9+3IJvshIOaBAuNTOpzfKuZcDLNEGX9ucWMLCsXZPy4kVHoFu13A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(366004)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(38350700005)(2906002)(36756003)(41300700001)(921011)(66946007)(66556008)(66476007)(316002)(86362001)(2616005)(1076003)(6512007)(52116002)(6506007)(26005)(478600001)(83380400001)(6486002)(5660300002)(38100700002)(8936002)(8676002)(7416002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lTUgT47pPXFCPTjmZoh4OFJ6AjsFiWLbpnqVDOopiSJcQIxOivLvNRxeY3xo?=
 =?us-ascii?Q?OuZ/sr1NsdiPsK0tccxKf4T7dpyLuHmhVNSAiHGGxWSfTbuGqd2OXFm1EF8Z?=
 =?us-ascii?Q?byMPlxFWJTJKnpmb1G/nDtMGXCFGOakCF+TgRmMpoNERWZ4LIl7qcxbuGB1K?=
 =?us-ascii?Q?4QvGR8WB1HUCoC2iwG0FgcPhEnYakva2+L8DOxrOY5y+zvpw6nkzZk6hu5E5?=
 =?us-ascii?Q?zjhCfHIG7kNWyuiNX+H2+a+EzwynlbnrqgoM02uYQ+Y53HSTHXqZCVBMeJNv?=
 =?us-ascii?Q?LG6J9pwZhGQwrGqyqN5txvw0lIvA5VBH22bXRcYUP5/W60f2SkycmJBJRlNj?=
 =?us-ascii?Q?Lqsehu4hwecm1fKe5zyOzSQW/LI5Lpm3vGtYghY41SwqIzRM449uuSuQKexY?=
 =?us-ascii?Q?V132F2bihtKVA6JFKXcFZFChhDXMip3Jtw69Va1buLXc37htpxUTY5rDpOQA?=
 =?us-ascii?Q?bEZd8fAn0MW+zUOFtDVyolBpqaZPVhLQH/Pd34mCTUgpqYfqdHnvnep5Nn+z?=
 =?us-ascii?Q?wmaxCXKfWasf9R/n1iKkcTScRc9OVnYH6s8wyAUXqIxvNSoRAObQffLZ4C43?=
 =?us-ascii?Q?UaguaOAYVSFKC1uvYFLeEtI0xFrgXLanunmuFLjfnQd1s0hEk1hntC+VEk4K?=
 =?us-ascii?Q?hF/S9WUZKAWx4Rmm1Eqj1fRZCDHte+3U4IC7xzKgB3TZMMGLzysZ+tKJoVuR?=
 =?us-ascii?Q?i6RdP3M1cJR6D5BOPFizipUxxtJqW3BecOVBKz5xTO35QpInXtAg8fJRwA6k?=
 =?us-ascii?Q?6faLHuRcoJOo9RdckMgOtp6G4NJboTqNIdVws3du32NrsK4eD+J1gjSDTsQv?=
 =?us-ascii?Q?uBNIxTdxQjE2UBjb4eHBcohEB+m+QE5jwr5ehjzAhHsE+LVx56CX9mWlyHyt?=
 =?us-ascii?Q?xbS831Dd8sbVQS2wL7ynR1cuYwrmkbmt9LobjnY8r9TIVuzU1yAmcG7OWo8F?=
 =?us-ascii?Q?4dAuhDp5mvpHm1m2jJ+D9+mNNJNX0eA1VrQJdW+V7ijs1U2+UiBuajtQ+ddJ?=
 =?us-ascii?Q?x42XWYcYS//cdmqFfBMD6U8w3zw6ZSqHAgS5H0rbVx3fEIOhSWzaDw2iyxHi?=
 =?us-ascii?Q?X5S9q2RpAB6C16ccFkn7zKoQI4VgjnWcGy4zOk/NGV++X4TG2tOlfVjJeN3O?=
 =?us-ascii?Q?1hjyziCFqHNjtsBRUrfgOL43/JnDqukV8SU2SYIvzetj4j7AeMQ1Mnk/4yY5?=
 =?us-ascii?Q?whlmLYOn2S+yy1giIvEYu+EgIn3Hc3f6pOgskDE3j9yZzKBKKxdy8Tb/WILA?=
 =?us-ascii?Q?143W+w12vhYj0V4PW0Q0H0woA+oNnmpkWRmN9XuoPxMeCFsYx11PCj/rCbsj?=
 =?us-ascii?Q?sj2OY27qQvW0DodwNF4SNOkN1TP7MTs1eXL4y1LoUQqv5+N5Al5NWGj1qdeD?=
 =?us-ascii?Q?3yTejBFoQKPxHR8BzhqtpY/ojNt3imqHeqAiwABNz0+72MFX2JzEznmlCrG5?=
 =?us-ascii?Q?DLSEkPf7uHnopkKa5WHNOgARIBBoIRU9wZehionFxjvofukwETvYz5jBuh6p?=
 =?us-ascii?Q?7tYYiUPcJQTTI/a1B+SkgaBqcA/qtCTtC3Ti4jmCJRiEtWCANw5I6BsYcNm6?=
 =?us-ascii?Q?4t4i+lwHScBsrcH5b+j/T03hEkv82zaJTwote7L5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f998e44-7f3b-4e37-3973-08dc2220bde4
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 05:52:00.1605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2PnqUM+qgqYHitNOUSipQwoibOnDqrRyk2SxJSyonZRiIqNjUir0/jMH1O0Weenbf+PUtT33/Hygr4+Xrb7X9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8917

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
Changes in v3:
 - no changes
Changes in v4:
 - only contain imx95 parts
---
 drivers/perf/fsl_imx9_ddr_perf.c | 86 +++++++++++++++++++++++++++++++-
 1 file changed, 84 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index b1a58e9e1617..85aaaef7212f 100644
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
@@ -240,6 +250,18 @@ static struct attribute *imx93_ddr_perf_events_attrs[] = {
 	NULL,
 };
 
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
@@ -271,8 +293,14 @@ static const struct imx_ddr_devtype_data imx93_devtype_data = {
 	.attrs = imx93_ddr_perf_events_attrs,
 };
 
+static const struct imx_ddr_devtype_data imx95_devtype_data = {
+	.identifier = "imx95",
+	.attrs = imx95_ddr_perf_events_attrs,
+};
+
 static const struct of_device_id imx_ddr_pmu_dt_ids[] = {
 	{ .compatible = "fsl,imx93-ddr-pmu", .data = &imx93_devtype_data },
+	{ .compatible = "fsl,imx95-ddr-pmu", .data = &imx95_devtype_data },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, imx_ddr_pmu_dt_ids);
@@ -410,6 +438,56 @@ static void imx93_ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1
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
+			   FIELD_PREP(MX95_PMCFG_ID, 0x3FF));
+		pmcfg |= (FIELD_PREP(MX95_PMCFG_ID_MASK, cfg2) |
+			  FIELD_PREP(MX95_PMCFG_ID, cfg1));
+		writel(pmcfg, pmu->base + offset);
+	}
+}
+
 static void ddr_perf_event_update(struct perf_event *event)
 {
 	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
@@ -490,8 +568,12 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
 	hwc->idx = counter;
 	hwc->state |= PERF_HES_STOPPED;
 
-	/* read trans, write trans, read beat */
-	imx93_ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
+	if (is_imx93(pmu))
+		/* read trans, write trans, read beat */
+		imx93_ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
+	else
+		/* write beat, read beat2, read beat1, read beat */
+		imx95_ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
 
 	if (flags & PERF_EF_START)
 		ddr_perf_event_start(event, flags);
-- 
2.34.1


