Return-Path: <linux-kernel+bounces-144469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AB28A46BB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 04:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CB5EB22CC3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 02:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537A617758;
	Mon, 15 Apr 2024 02:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fHkI4PAb"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2053.outbound.protection.outlook.com [40.107.105.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3881D12E78;
	Mon, 15 Apr 2024 02:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713146626; cv=fail; b=bZqIg+h3gAqlymVJE6CYAlJS/7xUQGne5dHT55d/M2kPM31VvYUZPMkpn0hVie3HhJV64rFm3DfqRwJGaWzYiQLueG/iY6GECUUg5vFeyVhPP1ND3wMCcDfRfcd3buci5BdaWFPaQbGQ5bobIntLl9pzf2xeu1HFmmjm4Mp65XQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713146626; c=relaxed/simple;
	bh=XDSLsiTuutkSXXljBgZMC2/MZGfjEE0Nm68e84TMOdc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K2ctat/MSyaNkxvQJTUfTvjYUPwM2RC+5pSjaj3QQQ9voPsZytL3gooDvRuKfRWGl6k4mU8/SCmpQsDXgp2VlgEk9ef3d7kr4OCHiHJJo11NZIW6lnYhTdqSlKwcCPuMyHdyEtO/C4sTZJWG3Iru4Hfgf8y2Sq+6fhp7m5rQE0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=fHkI4PAb; arc=fail smtp.client-ip=40.107.105.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TF0NyOfxO99pb7DQOqzMzjz1GuKYH+am2R7Nw/rXoCHKPjLtkNzdIH/nUK1x6Lf5dpLkkSfhJq4Fr6Rpy8u607RM4Pgpo4EvkTtKS3xrtikGOdG1fgu4NNgWacZifdR6BCmDQ3C01BA4hplsFPQFTSzetbpa+eB8j97qMtpFlZA6zj8KItg8bdWMI+XMwOM8ymp6CMSyooOrxeNAKJX2ie2ON5mgOtTiBfZBTgYNui8KxbP95sVhgqDAQ4nVstS9ZA63iSVXt/9ZXzwaR6nm70VpZ/sT+UVWIc7sZD5f1XktHdKKAvnGXlgHVv352ZeP2L0My/A3mYOY9lyD7KBfOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/NHYrDINE92LRHObyGmapaMgeDoYSdBb6S/87mxgi4=;
 b=gtAfH2xMUbGTe7jPnAYGt7C9Fceuv2udTYE6UTMJwkUAYHwX1iwgdWcMrIm9K3pdbHKfdk17MHDaKifXotmALbJXjQeL3+iQ6xpg1Veb1ozdQANvMam3woY2BcsE3H7dymToYpH1Xax4G+iI5O8h1KX4hjU4TeSc7ZZVrLzaEwamTbgnT8LIlrUXL5sjyQbRBv8ccHFn64XOCFBqT7OnAwBQf7t8d0GumfrViN19giJ5pmSAB3C8sGMHsughIUVgyjCUIV0HRArh5HuDleQEuHdLDxi0hTrQ+feqvhRfMDk28JSlVlyvyjx8krvUN91rPuObBPa5DUH6bY8kKZrcHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/NHYrDINE92LRHObyGmapaMgeDoYSdBb6S/87mxgi4=;
 b=fHkI4PAbJhzDUQzxOvSr7dlkudZCxHhPoYjpK6ffLFgrnMhxdTAi0g/9xgkQL7kXKkQQ2+X8HSDAPLSCBq1c2weclgCLAgsU+33KQ62hXxRBJWA4KKItEkO9LX1haCgzoQ4ejqy9DR+zjTwDWVKuGfr/JhgZIclGTYp1SLy1mRM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DB9PR04MB9233.eurprd04.prod.outlook.com (2603:10a6:10:361::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 15 Apr
 2024 02:03:41 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f%6]) with mapi id 15.20.7452.046; Mon, 15 Apr 2024
 02:03:41 +0000
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
Subject: [PATCH v9 4/8] perf: imx_perf: refactor driver for imx93
Date: Mon, 15 Apr 2024 10:03:49 +0800
Message-Id: <20240415020353.3833367-4-xu.yang_2@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: d5c07a66-4823-4f39-998d-08dc5cf045b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	50Pejdqk00p39TKLw9Bld95Qc0WDnSD7Fx9C2chJlV8XBT1nqIH1ke6eus7P4npA6iS71Ahi2FHHBO3DwJyvI0hhLZbB+0NtWJVDK5dPAXQzICYgxcjuxrXQAdFJ3TwZ+YfbruWZ/AURGg7WeBioXw6Oc8SeVRaZCpZtBF+mmOvm49j3vAo6yk5F5nOFKkL6Z1OO7fRAQyTHuN8hy++p1smELhjKXck4NBBNU0E5vzv0uJNtZc/e8jRRap27nGMqzBjs8pGlJlUTGBfYiELL9nlrcJf2UXKEQcUUrZARbpgTNgTM9iMQzXRDqGcgerY/jr2SlsfnkXfeLWUhKbPzNi4r0YGK9BtjSigWBhTIaK5Sm4M4mdsPpwBybcGP7xQofBIIYkAmc5c4h0+v8LPmJ4nZwgiAkmqiOyYDu7+s2TpPSD5zQttaBSNf/72LaKqca6lLDvWmEIxooStE1C/RRiiH2d2POefRttsxREv3uAld0tisKl0dBVGnQq3ndzCTkcDwVz6DUse7n8opef64feSjDd2k+tF1Whz+peHVmfz6PABDGGNbPHQeeybtjSJwDr/w4UQzA+CRUEau3g260JxaQ6bJDdzwVXmPOawip3UnSy7+z0iQf6sjGX7wLOCmcAertX+/DweidOmlwhJan3OKHRjyPBMsw6fMF82Re4bTKdZVF5jMSIeMjZLDvpd8KoCxoi7ebKLHWBzK4PpQHVxfm+rlrwE9Wu5hUQ/Z7Is=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(7416005)(366007)(376005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8qBJROH0GLGaGtNn4LWbCrLcZ6djyfFJJPkfE4IdGdCl73z1VInT3RLrqLfh?=
 =?us-ascii?Q?Uaqft0uRTnEjIjkzi2slVJQXtFGn0m65YwQXpkTd/Brr7WC4DcahszRjSIh0?=
 =?us-ascii?Q?KbVNXcepYjxAsAhyWTFZM9lcGjxktfnBAzdRAga06dcO0ptZktP6R3oog+Xr?=
 =?us-ascii?Q?+Hb0nZJbsnUdW/5JL9gFwsSp92XsFWv+PhUrXXdCUAioAQEvl/7jTY9aWK1Z?=
 =?us-ascii?Q?eONaBN8UfY3g6FhK7fGB4qjnM8IDbsqgNok1pxOn8UKbqMh8jLvPp4cUT91V?=
 =?us-ascii?Q?H61rt3TvocMPvnE+JYnQ33ymzOpzG7Lo3S0O1xg5vxNAqy5n8VWt26u3K0Hx?=
 =?us-ascii?Q?UbxM+1ZAXnvlMIvuTF0mNIyhPlU/ZnSzglnfz0hsjRk/v1AxPdEHpAF8AC5S?=
 =?us-ascii?Q?/ODI5ozZsU3VU387Q6H1WUbBVCWeHQadp+cLsomY2OLLNmltuoArZg5XweR/?=
 =?us-ascii?Q?PzqzKnuK5AYfoAw/ZseGMPZ0s5H0zV1+EmYSNk2F3Hyiya5xjnvCWRqAstad?=
 =?us-ascii?Q?LIVpKha5sQLOHwz1PTc81pMPcDrLA4jntDTvKxJKDvUJa2zcihxaqQWQH6bT?=
 =?us-ascii?Q?vNlMkby1buUxqw9pwWDd6axOdViviC/eb48204k0FNqc1ZB8G/rr16sX7yBv?=
 =?us-ascii?Q?Eeyngq36ffoDg8a/9shzu9WS7zNVJdpXi9hgPRwfSR4un0EAmlhLrN76WM9g?=
 =?us-ascii?Q?BdLe5nwtnZGyxU+xPbx8JNvVj5ekfGPdEaTqvv3Cx3EpBns/ksA2n2GRXiEo?=
 =?us-ascii?Q?Z8EjyqxoN08wZvsFnW8hi9VOqnatgsdi+w6pWU4+ZRbnFzr1+3kVLmBFrxfj?=
 =?us-ascii?Q?4mWSCgDDWjXSV73ygghleYdCwaVnv/p5zAwx98BInHGT8HH/8uEgr9CpS61q?=
 =?us-ascii?Q?uusnMIZy5HqjSC9xNaL1x4wQsMcPGza9J0YJSlHQwl/gxB6Roo8CIcnE6stp?=
 =?us-ascii?Q?bdxorLv1o1e+QDLcO7hqH+xLcDcOtk7+/794Gca1Jm8CJrb3N/wtpZUyOpu/?=
 =?us-ascii?Q?VLUo/5H7B+8LmV32ML9+qv1oX86sA331TD8MyVt1CcFNNT/L4FGutEsDm3Cw?=
 =?us-ascii?Q?opv9iEHlOjvEkfKoy2TlTDKdMh5ArWujlm4DhbaxVh0yu7wDz4TPvSBHdKad?=
 =?us-ascii?Q?lKxOAG58o+o+D5hOOMH1ADTRzD6nVZzgRazQaNkv1BR0yKpDcK3003Z8d5Wr?=
 =?us-ascii?Q?iVKzrWwlliJ9NxjmG6W1Pqx27cw2AZRZxkGfwe79nHcLarmC6xrmBSw77Dxm?=
 =?us-ascii?Q?k5gO9/dqnN/iirtU+Ku0iOapmRJFRpCFusts6R58M7IRTJLQW6vMsuThRpK4?=
 =?us-ascii?Q?/pUXfpmYyoHMWA3O5/6ZBYR4BN1xP5yxWKg1nZbnAMQvbA/hD+9hTyUf/+YT?=
 =?us-ascii?Q?3g4MirUqYxxui3A+5l9SSuSmamTPcjUtGLPvNPDpbUDAB1U7CNBYvxgn0Idl?=
 =?us-ascii?Q?5D+dbkZazCjLUGpspOc8xrqKNSKZa47RtSP7Ab6EzYqy/2SLgXL2oFCH/nwV?=
 =?us-ascii?Q?lKs7fpIq0XBSFFeMRC91u4EduUGvQ+dUTBi/WjogWIYGmoz7oG59v+8gQhoT?=
 =?us-ascii?Q?08vKonlkijzhDIilBg4E7MXaYJ72epC49s6wySOU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c07a66-4823-4f39-998d-08dc5cf045b8
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 02:03:41.3343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4svo7IUJFd6wQy8W0VZ3NGXUT433fVJUoloLcLMuu4SxkZ8hn74sDG1c28MGmwRJ8S2A+871nLbHedU3rZon2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9233

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
---
 drivers/perf/fsl_imx9_ddr_perf.c | 106 ++++++++++++++++++++-----------
 1 file changed, 68 insertions(+), 38 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index b00cbd920c0d..1510502862fe 100644
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
 
 PMU_FORMAT_ATTR(event, "config:0-7");
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


