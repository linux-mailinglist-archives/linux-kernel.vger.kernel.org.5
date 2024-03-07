Return-Path: <linux-kernel+bounces-94884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A0687464D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D812283937
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5025DEAE5;
	Thu,  7 Mar 2024 02:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cXTQzEyq"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2089.outbound.protection.outlook.com [40.107.247.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030C2EAF1;
	Thu,  7 Mar 2024 02:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709779691; cv=fail; b=HHE6rOWWP/DnEHnK0CAYyLLNK+/8Gq79Kdb+JTbuhNsKT/LtfcdZ+PTYRriVDb8DjOXl763KhjmCOEgDIKSvdBZw/1zED8DCR/DHvvzhsZ9ll7pk0M/OLmRysTixMBilckOyInvwrbyTVkOHo8dNXkGomuN41vqY42fwIuk9/WU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709779691; c=relaxed/simple;
	bh=XpdttwGG902rOdRuL8RwTW7e1HVGm7iouKUlYgASs0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=icl7eMpet7oyM/XVuuJF5pDj5/cmrfOwAFPpd7thK+lnfHCmky+erOUx4Any/ldSFRF/+FzN9x8pusdLcxWsr2ngO1UbMvcy/Tl1Ve8utZ7ZxrPdwaJHwJZ82XvTKVWKOIQsPk++Qq4caoDaHObIQzy/3W3odQrKaEHQ/k62OYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cXTQzEyq; arc=fail smtp.client-ip=40.107.247.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hoDSMvwI+dP0iWDmgDO1IYjpRPJ3wvTeWdNDZfFlAyn3Zyv7tnSHcNqgKdvwHz1RRGEI7tSrhzuwFXjf0sfkbn+fvMzJ6E7qr8Az8QHXWlaz36rd+3lOd10ceKDQXc/9Ib7HMQB9G3hbKN9Um4nh3L9m+4cbYRngLBd4/14lYWsRIwLKbaSPzb0fQRf87Llupv+6pSZVSFMM1EFMc8btj9GzKsd/GKnj6WYd/k49fAHqe1KgkdXTnJNL/Wku9rflIHTU/6Yz0ZA8aObljSpWGwnKEo419MRHoM/TtBKXEEdyrg1e8xjPXyc2+iN7HNYDTZcjoyqobtdIBRDOdG80LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5yzhS0OEXfsRQkqgy578gHVZSOeF3kdls5HSX4c0xM=;
 b=JqEQcJka8BYB9KZQwyKlXgV4WpWOvzxuw7t2iMgzblUtbPiSuxW/DFSvBtJINcj1mhrSOp3Nn5XVNKhaJKjo1StO3E95p/UMD6+eymHU2lAbJwP5TseH3GrjBopyLAxLWXYyBRztnewNSkubpJBEZZa6mlcxUkSnQBLu2mVY83lu4Tvk077zzOiWmu1kMmM7mGDyL06cVauEog7PbM/A/86aUpJ/LtSGoRPcx4l9FMTgomUtDlv90h4oX/qwuzSPxaUVl2DfaV0m5l3rAFzkbQUMB726/u8uRtuZ/BtYTToxTYEtsVX8xYF5U33sRaxx3J1PaNI7OV51q4LVDE9GHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5yzhS0OEXfsRQkqgy578gHVZSOeF3kdls5HSX4c0xM=;
 b=cXTQzEyqH0m1wi2lcG/yVOIqfb6ZmkwAJ7S1CXUvaK/yhH6FY+Y9EClhP3c/5ZcGTCZPkZ/praCMzEtjVg/w9KkuZTtDn6sYT03LKFVoKowL84mJoYSBaMItJEFH724clFK/6fkAYP3m7ZMl3qW/wxk2bGKBYuNWfwP2MdWohR4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Thu, 7 Mar
 2024 02:48:05 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7339.035; Thu, 7 Mar 2024
 02:48:05 +0000
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
Subject: [PATCH v5 2/7] perf: imx_perf: refactor driver for imx93
Date: Thu,  7 Mar 2024 10:47:49 +0800
Message-Id: <20240307024754.3469810-2-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240307024754.3469810-1-xu.yang_2@nxp.com>
References: <20240307024754.3469810-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS4PR04MB9338:EE_
X-MS-Office365-Filtering-Correlation-Id: a822dd32-e456-49f1-a4fb-08dc3e510390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZQ2JYIGrMDkPhVM3voS+LaIDlaFovCt6bc+WYnqVVlsTD4rJT/vBFs74AjJZvt3RwF35gahhQZyALy7shREAx48/3XLrV90Lc85C3jtD8wBky4wZBbNBFmQu2OOt9TicsWf+yjp+dqsBI/ife9e0FWlRZ33OJn2xMe8rRDBDQ+sdPthBEAp371QACNV+R/ykY21ApHRe7lscZY8i73DIreGI10wz1D4hpe06EvrQ6JYG9Xc/sNlUrpGQpGbQJGk0WqmHej03MeSKCwVvMReVu2q9xLV//E/P51iYkQEgmjME8D/1/gtjWnwCBFd4T5fWhuCG+FXlaC9F8000IQD6YCubfJuhBmQGVXAj0W4U4Nw5aFpYoqJNiE/wEBRJeSOWh46X+Y32qOIg6CSLV/nOAdeXl12mjmhW0vfbjLAWxaviAKl1SDK7D/td2RHx7ttYNHoxrYs9DGmsz6Y44NDnLlSzAaUwVLTEEQSMZiikIC02AkLqf8FQ0jDqhgV4AjIS69STJmv/Cfn61/iRy+Y+ouiBwkNrq1rNioF581IKEgSz0QtW8Uq72NsuQ21CY2zqRpIOfKYXtpWTltd4fp53xCTUWsyYzgrSsUhdkyIM5OMacKhJejvqPYLIdq/WMrcJqCwnGO+YMQ7nla42iyXWbrcW2AMaRqHi88Of2UYSvLhBNTxykl/4gSnKgO7oG6AxS/AzcwGmgzCqjMzU+DS7YKlezNS45wvkVSRtMeWqZYE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KXv7a53pZU4jubmfHjz7C+0xpQ6q4unm2cQcLWmtmnlXsJ0jp2ohmMTl4yHh?=
 =?us-ascii?Q?HA6tIKsSX+rRRdt/NCHqsdE8L2sQpSBbWXgyH7XAAgFfK+1wuBD4mpD8X+zM?=
 =?us-ascii?Q?8aL6fb1CLqA0Vo/n4OxogEWWzKYQ/zJ8ne/7uqmuCJEKH4dHp+ItNOIXNuZR?=
 =?us-ascii?Q?VL7iHvHOLqBV+v/bUn8ofrts/iHJmk9QU5EvOwGRJIdQYuUuULC4ZUJ4D2OP?=
 =?us-ascii?Q?B/g4Gb6OLZEO8ww0C0NmshyNNHXgmmK6cAddPk+PCT2HA0uH+WzjF/mGq00r?=
 =?us-ascii?Q?qr40LA+2kF1M+CYs0yDALA9V3Hj/4ZGSkYbfVwhscYUn2lkwfrkosr6I4rxn?=
 =?us-ascii?Q?gphVShlagcBf2mQ/mgduM9v+9uXCB7liUpQ9XTcnceFWMvokggWUuh1iW9UQ?=
 =?us-ascii?Q?bBvlFwp6emmgpeI18z4IHxmo710H9mfpJltrsuids9sWDJMQ4BLnkiw7jpvU?=
 =?us-ascii?Q?ucFQcYxc+Kj59V8hkh+JECNnK7DjjyoppflwQrKXXmYcp7JSsBHwADhTV63Q?=
 =?us-ascii?Q?ENr9X0iJU6orhoKSgsMSBBaR4GyGZSESAmsCDpRkqI0Hk1YgSavHLTaWuGhx?=
 =?us-ascii?Q?CwGl2JeaYgnSaikUplsH4R1EyxhL/rJFOKU16wdPpF/LXlrYc0QHfZzzUn8D?=
 =?us-ascii?Q?UAAiqqMXTvs4TwRCCjuy5N1H8amXGVlXlw02tzrxaGeXqBqqNrQ6GB4PdfrI?=
 =?us-ascii?Q?G2W58Bsb+Rto8G28CiSq1dg02ikrpmtRpwyoO6IGaGweIJ9V2wQyk6mChKau?=
 =?us-ascii?Q?9oXub3oCMUuOdP/tzPcYD5+hQRNAyerbkk2ekmUNiQ23plVNP3dIu8YnDUqH?=
 =?us-ascii?Q?RlMLGmZM+ZghbftEr42ifiAL9oO4chd5P8BjWY/j2quEdf2zRk/xCAJ07258?=
 =?us-ascii?Q?bZm5lW0iB0HfO7MwmflFtbL+v4o1/vliRvkyyWn5JhneandUsZ8QjRlAyx/F?=
 =?us-ascii?Q?iDaKkcYOmSj4M1Su7dsxr5CbAWApwgfgK3GfWQz18oPb5c+FqmGfyc2qETP8?=
 =?us-ascii?Q?LxI43It4pLJAkYfFEVEcaooLGS4JZrc6Ys/SaI8nfmqwdLHm/ab2FVc+G9R5?=
 =?us-ascii?Q?1LpzIVmiftc3brX2JfGV8d7Bp58j+85P4E7n4o4x4lqS7M26Ac+X7nd4mf0k?=
 =?us-ascii?Q?ocF3XWGJ1PljZcl17wu2OV8cC0yhAd9hh5LsIgIcm6mTTJ43aU4pZxKMTHFm?=
 =?us-ascii?Q?ayV+D0texYlHK6lqKF7luLECUIFOj2KvdOsNMhmDFEXoVgzC8ov3q125up+K?=
 =?us-ascii?Q?WUnMsQovcqa8q7/csgt2H1HSwxwXG9Im0FcA//g7a5ouM0SKuCQ1k3cn6tgC?=
 =?us-ascii?Q?LVoYUo8fO/yw87vI9KAOiKeHQ54V7IvajI++8H4pycqmfVoSlr9qNnoGLrHn?=
 =?us-ascii?Q?3gjQeEuragCtzflcGCEUr3TSq8WIb4DG2Kxm77EOZ7LNjloU/9L15odbKMkg?=
 =?us-ascii?Q?iT2+MK5BvCh1DusuoTbPkDbIY4L2JCFxmwKj8QLuaAZpEgAwPgG4GebfL+Yn?=
 =?us-ascii?Q?jlxNACdrUTIkAi8IgIbcUKt/rOmMUbOD7Zlupbg56CaY4Kgm7O+6thyHDd2L?=
 =?us-ascii?Q?dzBmSZCUBAZnhh6PROrZmPr1K63Y4iGe9EXM9dH0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a822dd32-e456-49f1-a4fb-08dc3e510390
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 02:48:05.4554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /46YiFY/HKHBOYC34+bnXk5W8B9G1WwPNIkKy4z/nh91oP+HR9a0vI5sa0mG3ZljgrDoH9OUjMaR5wVUnNldnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9338

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
---
 drivers/perf/fsl_imx9_ddr_perf.c | 66 +++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 22 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 9685645bfe04..f4dca813b174 100644
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
@@ -71,6 +71,11 @@ static const struct imx_ddr_devtype_data imx93_devtype_data = {
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
@@ -178,7 +183,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_6, 70),
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_7, 71),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_empty, 72),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, 73),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, 73),	/* imx93 specific*/
 
 	/* counter3 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_0, 64),
@@ -190,7 +195,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_6, 70),
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_7, 71),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_full, 72),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, 73),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, 73),	/* imx93 specific*/
 
 	/* counter4 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_0, 64),
@@ -202,7 +207,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_6, 70),
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_7, 71),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2_rmw, 72),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, 73),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, 73),	/* imx93 specific*/
 
 	/* counter5 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_0, 64),
@@ -237,9 +242,26 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	NULL,
 };
 
+static umode_t
+ddr_perf_events_attrs_is_visible(struct kobject *kobj,
+				       struct attribute *attr, int unused)
+{
+	struct pmu *pmu = dev_get_drvdata(kobj_to_dev(kobj));
+	struct ddr_pmu *ddr_pmu = to_ddr_pmu(pmu);
+
+	if ((!strcmp(attr->name, "eddrtq_pm_rd_trans_filt") ||
+		!strcmp(attr->name, "eddrtq_pm_wr_trans_filt") ||
+		!strcmp(attr->name, "eddrtq_pm_rd_beat_filt")) &&
+		!is_imx93(ddr_pmu))
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
 
 PMU_FORMAT_ATTR(event, "config:0-7");
@@ -361,7 +383,7 @@ static void ddr_perf_counter_local_config(struct ddr_pmu *pmu, int config,
 	}
 }
 
-static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1, int cfg2)
+static void imx93_ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1, int cfg2)
 {
 	u32 pmcfg1, pmcfg2;
 	int event, counter;
@@ -372,27 +394,27 @@ static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1, int
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
 
@@ -480,7 +502,7 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
 		ddr_perf_event_start(event, flags);
 
 	/* read trans, write trans, read beat */
-	ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
+	imx93_ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
 
 	return 0;
 }
-- 
2.34.1


