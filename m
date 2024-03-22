Return-Path: <linux-kernel+bounces-111006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 332C18866E4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A94901F24B63
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E6D171C7;
	Fri, 22 Mar 2024 06:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xs41l1Ez"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2045.outbound.protection.outlook.com [40.107.13.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D90B1757D;
	Fri, 22 Mar 2024 06:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711089601; cv=fail; b=kMxx2Y1VbPRBuXaMVqup26r2mQ8emyio1BXr4EY8tGXiGLR9Fu3HmAWI2f+GKqxOmyF0wyZN3nHbNNgFJOYjgezQ+SG2A2fyl66svtx+OpwGqWrngTV0Rm+/Qtgx4H6VgjfzHFYvEY36GrAOtNjmILO9TQtKBAN2nqGDVCvLV38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711089601; c=relaxed/simple;
	bh=4cjYJm/Kkib9oCd/3EO8zMdmpLevDVUWoVdAz8QEOW8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BEhCXiff+1aowAMupy+5A4dy3EFqH9FrYL+GzPULhGMPdT4mjfj4zdnTH69+4vQICGGWfnyb9/fADbsMy6Ni8eeypzkQiBpdy4eq8hcdhzlIMiZfUKOXgfM40QSlJbDNy+T9FNAs90DgFFxobqa+xD0KjssRtbejt12Sv1G8aLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Xs41l1Ez; arc=fail smtp.client-ip=40.107.13.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjkRegp7innnq5hhJSywoGh9UNWatcL2ikJjHX3PCU5KQOpGQnoYXVZBRaBgRXt4+LSHwvtbfHZ6Ppx2u59CtDujuqmWF9SLE0uLOMnXeGJonjBPKwyHPSehA4lb/P/KA+yudKGdnS1bcZzQsdN8zc9Mr4cFsd0nv2SH1Riuh3AL4GxGv90gPDYO8er1U2Nu5U/6GdT+hL/agsAz9Sa1UQ9fMrtU/E3Kg4Nz7R5S+eHP3SC1Th8dAFjguBSC12iN0waMp6kK2JjM1ZC3sQICmFbtTWRYigMSpOjA2l8NOzbFKKuX3sjjLcTTXMKyVGdBjpJD42EX5zF7Ck/Cq+StCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtIt0Pycf9x6p7bmMiMYAP0vEogY3dj6FW+xcu3ltrw=;
 b=RapO7Vv+lFoUlOUgafBDiZztTddyOinpnR6sIMbmvx4whveRFNy4hwrXgNljRXBM4CuAXQM9LaL6EGLoXQ4Vx7scbYirKIp4Asl7jUqbcziP3Dz6Lirau2SP5+MIz48iIPG4uL1awGkDehSioiQVkfvbdckiDnCPw4Ht3iXlHFgHYudmZWLVZBWTy94b831tzvAyMMiHO3PvzPv6AMuWeUfje2S0hbSzcE10+IOn59TyoN6p3IQksLM9whLgv1LFk1y8ky25d2Broam+zobNI+OraeD35blDoJx2/qA6qOMS6bxYqoz2aihf/1qy800DdrBBVasMkkcxx+lbah8r+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtIt0Pycf9x6p7bmMiMYAP0vEogY3dj6FW+xcu3ltrw=;
 b=Xs41l1EzMlr9TdAEf6qX49H2Og1G0JTkSW7gY96A+DJi6H1S+Y0FA1A/i7uIgmjeFMuUX1M2CPAvLH23TlC/RGYRkJR4kvXN88uZgePAjJswVon8mGF+GngXQ/AhZClgB+qmA0nUnhfwi1bESe+1c0eUYDygOrATKmRYBTeopPc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com (2603:10a6:102:20c::17)
 by PAXPR04MB8928.eurprd04.prod.outlook.com (2603:10a6:102:20f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 06:39:54 +0000
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::1b13:505:8d50:f4e3]) by PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::1b13:505:8d50:f4e3%4]) with mapi id 15.20.7386.023; Fri, 22 Mar 2024
 06:39:54 +0000
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
Subject: [PATCH v8 7/8] perf vendor events arm64:: Add i.MX95 DDR Performance Monitor metrics
Date: Fri, 22 Mar 2024 14:39:29 +0800
Message-Id: <20240322063930.749126-7-xu.yang_2@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c2f45a86-789d-491a-c7d1-08dc4a3ae22c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mjoMChgclMdAoKi2sKRKeOVttajM3Hn5h3FsuBsjHoc+gJmXIeBry2DzW7oCJnXYV9jnOF00/WlrSjgT2t0FUtFyHgLqKHcwIEpooHa1gFJiqey7NvYYL9GuajvB6bfeVU9UdgNaCJ2zIlRnPTVAB4/ojeerAPTIkaMWSMq3V1tx9r5fUYGstKjIY0I6FlQ3GOoq0Z4nsoKiOOA4hhpbtbsVvbDru1JAd3pVcYbbRhZ2vk721gwGdE7ql/ND2ZE6Yh0h3Ot5MzWKoydx2fugSt/KaHCFLM6O3TK/pO/VJkU7wb5mxPCDknJBK3WuSa2mPhKFKMLevcapqAFswXbaBKVpK3hheS74wYkeRVFP/QY1QCh9Grs6l+4Akt6kezx+NmwsRkvd2U8ElqbvHdS9Xgt8UhXj+ZX6scuG4+U4LaMfQJfI5GXLOFMcLgewP0ILaaTkjS0yPX2725c1+QDfejY+5pxzQAhjjxd40oBGMADVHmkTaV92HMvhljjTtPgwHXR5UTDKPkIKWh/omsrWRuVREJDHJtIuBgDL+JjUOOeDkEjrV7i8e1AqDwdY/RrMxR5NOg3V511ZHtsUpFzBidNKrlF9rBrw1kg1p/E13w8kESaFypXvYREC1XPSrCv371Lw+fmm9YtUEJIqgT38mWWoK1/qJhEKFSoPzvk04eT97EydrN+oMPmqBnOztV6CRU+aUqnj3ysvJbDHF7gTo8K2Kq+9+1qqsJ9iZPT+Ji0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8829.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(1800799015)(366007)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P0CN8V3irj7U4s9shTbmDeFWw6sfJpNBczquGf8PHq4dAbdocc/1u7mOWs6r?=
 =?us-ascii?Q?Q2znTAve7OHbXHSdtqkF6MyLKHDQSxnDp9h5JUvEY8cnCnmLL7B6tebTKZWI?=
 =?us-ascii?Q?kTYgS0qz3q2zMZD8vC5bdRT7XhUCLyDQmZuyCkPDZcpmoTluKxsYK8kX7YQT?=
 =?us-ascii?Q?Yp5uFgRd32F0WHVwuib7kf/D2p7hmj7o0G0iYEJlJR1OlQS08yoRWJefExj0?=
 =?us-ascii?Q?ONsJdYPYZjS07MTQdv/IUSzW7hxxY03XqRxdcEQsKAfmZo6ke0M5BZhGYJs+?=
 =?us-ascii?Q?vdtu/2PXKUaIA1MDcJwhiKSgBQj9Vy4SZ+au0mbd7NVLEIqXxhGI+vXibjze?=
 =?us-ascii?Q?LPoa9k5E+jFc1ZRRHUotvhTna4C+r89nAmpUxyolxArkZxj9gNR4Sbmxcnw8?=
 =?us-ascii?Q?L22kf8tkhBxs3plrNNmLsgNj94jH1Eeu5LKU6naGv23Esm9EEPMxuKM0Ojmy?=
 =?us-ascii?Q?br+05OGhp/hzBQrnkSCAwapZYygAmvhdRXIpIn2dUdN9lkCU26iTdU0zH9WI?=
 =?us-ascii?Q?RCVjaxaK+wP0XwSSeAUojCmj8m35gFvdMkEp1lbcISxmkQgIyJ239+Z/J00H?=
 =?us-ascii?Q?2QmqccskIe3F5WVAXNgAhX+8FQhvh1yZszH+uJKLin5d1VlrvN3F6qCv+KJE?=
 =?us-ascii?Q?9MfcJM5IUGEfNRBwt1619FGKAAFMFQ92FiDRC5NsazE7+Bnk0h25VpboYGwK?=
 =?us-ascii?Q?m5KEHjMIfJBMd/husho1lJQhra9Y4FbE5LAPRVH+WtPpenCzx/jFQtxWSvwm?=
 =?us-ascii?Q?c6+joBmyzYg10zrGIvCvliCqXze1zoyuE4ch2D4zEsHFV4x+nSfALLQ55qSz?=
 =?us-ascii?Q?gq/FWYeubEqQMZ432nrKvAhXbmhO8NyJG+DcYhSrDAdho7OZ8hlTNvQyojRE?=
 =?us-ascii?Q?GC5AXrc8A7ymS9UrWnTtT+/EGtas7e/YWnlzQ9IiRZgEf4BiUrb/mSF65sqG?=
 =?us-ascii?Q?Gu3awuRD31rDhFAzZc8HxOmPAQ1EMbn3bz8pYkbG3Dw67TKZqPnjQx4yYDi+?=
 =?us-ascii?Q?wdtuVlHBJVMVTAwkuIH3CrZjPo+03GIY9lC1L2vWKDkRCLE6LsabPUUMfplx?=
 =?us-ascii?Q?Gw6WKwO9oLQkYltZfrRfNReHF3zdWNsOmeRJKFm5Y8xSezd570KkpuMIlJ37?=
 =?us-ascii?Q?Sp6J/Nkn24m1MO20ZcaGvkiE7Zpd9HCZXLpHDN3D0WBBvlrodXdVAOQofjPa?=
 =?us-ascii?Q?i5qCqHrK0HuBaAUhiesr05JTJ1YBrmZ8Nyv3tH662024RCGngtZ02YbJFwav?=
 =?us-ascii?Q?IIdI5C6YiIuUS7wkDKK79RPxEmki1hLchtuJKb2gKvNmtCq2pj9IodujcTg4?=
 =?us-ascii?Q?8j8aXt70xgH4t4shJb4ehpYotyQ537H/J7NwPpCxxbaynoktWfvkY62rBkgS?=
 =?us-ascii?Q?F5+9iMhHIxcjtEUbhWc35LwyXAoCnQ/JgAMJZb6UY0fGNq30zR+jqkIQfrdR?=
 =?us-ascii?Q?bW7YOpRGH/D0mklsNIAiw/nXUD7zN6jpGGT1nh5pauUxGCqmlRkJcFR1d1wW?=
 =?us-ascii?Q?w7BLqH1bN30lR+VsmAgyntTfh19S2woX2EY80zNHGS6e0PArPBJP86vnkgAX?=
 =?us-ascii?Q?J/HO8FVoFEbW7pXDimBvbuBfezEHZtjQTAoqIxW6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f45a86-789d-491a-c7d1-08dc4a3ae22c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8829.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 06:39:54.7482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gqU5q2vp9cbYb9hNbopEwvVM+bH4GWusla9XNPtJrdY08eh3f6gJjqMZF1XLa80FS6mQnIGFoDFpBwpb/gODAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8928

Add JSON metrics for i.MX95 DDR Performance Monitor.

Reviewed-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - fix wrong AXI_MASK setting
 - remove unnecessary metrics
 - add bandwidth_usage, camera_all, disp_all metrics
Changes in v3:
 - no changes
Changes in v4:
 - add Reviewed-by tag
Changes in v5:
 - fix typo
Changes in v6:
 - remove "counter=X" from each metric
Changes in v7:
 - add RB tag
Changes in v8:
 - no changes
---
 .../arch/arm64/freescale/imx95/sys/ddrc.json  |   9 +
 .../arm64/freescale/imx95/sys/metrics.json    | 778 ++++++++++++++++++
 tools/perf/pmu-events/jevents.py              |   1 +
 3 files changed, 788 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/metrics.json

diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/ddrc.json b/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/ddrc.json
new file mode 100644
index 000000000000..4dc9d2968bdc
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/ddrc.json
@@ -0,0 +1,9 @@
+[
+   {
+           "BriefDescription": "ddr cycles event",
+           "EventCode": "0x00",
+           "EventName": "imx95_ddr.cycles",
+           "Unit": "imx9_ddr",
+           "Compat": "imx95"
+   }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/metrics.json
new file mode 100644
index 000000000000..a3ae787d448c
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/metrics.json
@@ -0,0 +1,778 @@
+[
+	{
+		"BriefDescription": "bandwidth usage for lpddr5 evk board",
+		"MetricName": "imx95_bandwidth_usage.lpddr5",
+		"MetricExpr": "(( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x000\\,axi_id\\=0x000@ + imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x000\\,axi_id\\=0x000@ ) * 32 / duration_time) / (6400 * 1000000 * 4)",
+		"ScaleUnit": "1e2%",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all masters read from ddr",
+		"MetricName": "imx95_ddr_read.all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x000\\,axi_id\\=0x000@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all masters write to ddr",
+		"MetricName": "imx95_ddr_write.all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x000\\,axi_id\\=0x000@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all a55 read from ddr",
+		"MetricName": "imx95_ddr_read.a55_all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3fc\\,axi_id\\=0x000@ + imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3fe\\,axi_id\\=0x004@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all a55 write to ddr (part1)",
+		"MetricName": "imx95_ddr_write.a55_all_1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3fc\\,axi_id\\=0x000@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all a55 write to ddr (part2)",
+		"MetricName": "imx95_ddr_write.a55_all_2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3fe\\,axi_id\\=0x004@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 0 read from ddr",
+		"MetricName": "imx95_ddr_read.a55_0",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3ff\\,axi_id\\=0x000@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 0 write to ddr",
+		"MetricName": "imx95_ddr_write.a55_0",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3ff\\,axi_id\\=0x000@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 1 read from ddr",
+		"MetricName": "imx95_ddr_read.a55_1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x00f\\,axi_id\\=0x001@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 1 write to ddr",
+		"MetricName": "imx95_ddr_write.a55_1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x001@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 2 read from ddr",
+		"MetricName": "imx95_ddr_read.a55_2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x00f\\,axi_id\\=0x002@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 2 write to ddr",
+		"MetricName": "imx95_ddr_write.a55_2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x002@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 3 read from ddr",
+		"MetricName": "imx95_ddr_read.a55_3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x00f\\,axi_id\\=0x003@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 3 write to ddr",
+		"MetricName": "imx95_ddr_write.a55_3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x003@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 4 read from ddr",
+		"MetricName": "imx95_ddr_read.a55_4",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x00f\\,axi_id\\=0x004@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 4 write to ddr",
+		"MetricName": "imx95_ddr_write.a55_4",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x004@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 5 read from ddr",
+		"MetricName": "imx95_ddr_read.a55_5",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x00f\\,axi_id\\=0x005@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 5 write to ddr",
+		"MetricName": "imx95_ddr_write.a55_5",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x005@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of Cortex-A DSU L3 evicted/ACP transactions read from ddr",
+		"MetricName": "imx95_ddr_read.cortexa_dsu_l3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x00f\\,axi_id\\=0x007@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of Cortex-A DSU L3 evicted/ACP transactions write to ddr",
+		"MetricName": "imx95_ddr_write.cortexa_dsu_l3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x007@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of m33 read from ddr",
+		"MetricName": "imx95_ddr_read.m33",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x00f\\,axi_id\\=0x008@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of m33 write to ddr",
+		"MetricName": "imx95_ddr_write.m33",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x008@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of m7 read from ddr",
+		"MetricName": "imx95_ddr_read.m7",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x00f\\,axi_id\\=0x009@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of m7 write to ddr",
+		"MetricName": "imx95_ddr_write.m7",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x009@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of sentinel read from ddr",
+		"MetricName": "imx95_ddr_read.sentinel",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x00f\\,axi_id\\=0x00a@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of sentinel write to ddr",
+		"MetricName": "imx95_ddr_write.sentinel",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x00a@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of edma1 read from ddr",
+		"MetricName": "imx95_ddr_read.edma1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x00f\\,axi_id\\=0x00b@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of edma1 write to ddr",
+		"MetricName": "imx95_ddr_write.edma1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x00b@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of edma2 read from ddr",
+		"MetricName": "imx95_ddr_read.edma2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x00f\\,axi_id\\=0x00c@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of edma2 write to ddr",
+		"MetricName": "imx95_ddr_write.edma2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x00c@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of netc read from ddr",
+		"MetricName": "imx95_ddr_read.netc",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x00f\\,axi_id\\=0x00d@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of netc write to ddr",
+		"MetricName": "imx95_ddr_write.netc",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x00d@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of npu read from ddr",
+		"MetricName": "imx95_ddr_read.npu",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x010@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of npu write to ddr",
+		"MetricName": "imx95_ddr_write.npu",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x010@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of gpu read from ddr",
+		"MetricName": "imx95_ddr_read.gpu",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x020@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of gpu write to ddr",
+		"MetricName": "imx95_ddr_write.gpu",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x020@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usdhc1 read from ddr",
+		"MetricName": "imx95_ddr_read.usdhc1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x0b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usdhc1 write to ddr",
+		"MetricName": "imx95_ddr_write.usdhc1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x0b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usdhc2 read from ddr",
+		"MetricName": "imx95_ddr_read.usdhc2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x0c0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usdhc2 write to ddr",
+		"MetricName": "imx95_ddr_write.usdhc2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x0c0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usdhc3 read from ddr",
+		"MetricName": "imx95_ddr_read.usdhc3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x0d0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usdhc3 write to ddr",
+		"MetricName": "imx95_ddr_write.usdhc3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x0d0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of xspi read from ddr",
+		"MetricName": "imx95_ddr_read.xspi",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x0f0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of xspi write to ddr",
+		"MetricName": "imx95_ddr_write.xspi",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x0f0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie1 read from ddr",
+		"MetricName": "imx95_ddr_read.pcie1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x100@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie1 write to ddr",
+		"MetricName": "imx95_ddr_write.pcie1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x100@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie2 read from ddr",
+		"MetricName": "imx95_ddr_read.pcie2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x00f\\,axi_id\\=0x006@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie2 write to ddr",
+		"MetricName": "imx95_ddr_write.pcie2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x006@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie3 read from ddr",
+		"MetricName": "imx95_ddr_read.pcie3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x120@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie3 write to ddr",
+		"MetricName": "imx95_ddr_write.pcie3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x120@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie4 read from ddr",
+		"MetricName": "imx95_ddr_read.pcie4",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x130@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie4 write to ddr",
+		"MetricName": "imx95_ddr_write.pcie4",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x130@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usb1 read from ddr",
+		"MetricName": "imx95_ddr_read.usb1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x140@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usb1 write to ddr",
+		"MetricName": "imx95_ddr_write.usb1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x140@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usb2 read from ddr",
+		"MetricName": "imx95_ddr_read.usb2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x150@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usb2 write to ddr",
+		"MetricName": "imx95_ddr_write.usb2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x150@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of vpu codec primary bus read from ddr",
+		"MetricName": "imx95_ddr_read.vpu_primy",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x180@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of vpu codec primary bus write to ddr",
+		"MetricName": "imx95_ddr_write.vpu_primy",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x180@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of vpu codec secondary bus read from ddr",
+		"MetricName": "imx95_ddr_read.vpu_secndy",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x190@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of vpu codec secondary bus write to ddr",
+		"MetricName": "imx95_ddr_write.vpu_secndy",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x190@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of jpeg decoder read from ddr",
+		"MetricName": "imx95_ddr_read.jpeg_dec",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x1a0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of jpeg decoder write to ddr",
+		"MetricName": "imx95_ddr_write.jpeg_dec",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x1a0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of jpeg encoder read from ddr",
+		"MetricName": "imx95_ddr_read.jpeg_dec",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x1b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of jpeg encoder write to ddr",
+		"MetricName": "imx95_ddr_write.jpeg_enc",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x1b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all vpu submodules read from ddr",
+		"MetricName": "imx95_ddr_read.vpu_all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x380\\,axi_id\\=0x180@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all vpu submodules write to ddr",
+		"MetricName": "imx95_ddr_write.vpu_all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x380\\,axi_id\\=0x180@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of cortex m0+ read from ddr",
+		"MetricName": "imx95_ddr_read.m0",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x200@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of cortex m0+ write to ddr",
+		"MetricName": "imx95_ddr_write.m0",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x200@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of camera edma read from ddr",
+		"MetricName": "imx95_ddr_read.camera_edma",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x210@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of camera edma write to ddr",
+		"MetricName": "imx95_ddr_write.camera_edma",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x210@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi rd read from ddr",
+		"MetricName": "imx95_ddr_read.isi_rd",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x220@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi rd write to ddr",
+		"MetricName": "imx95_ddr_write.isi_rd",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x220@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi wr y read from ddr",
+		"MetricName": "imx95_ddr_read.isi_wr_y",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x230@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi wr y write to ddr",
+		"MetricName": "imx95_ddr_write.isi_wr_y",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x230@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi wr u read from ddr",
+		"MetricName": "imx95_ddr_read.isi_wr_u",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x240@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi wr u write to ddr",
+		"MetricName": "imx95_ddr_write.isi_wr_u",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x240@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi wr v read from ddr",
+		"MetricName": "imx95_ddr_read.isi_wr_v",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x250@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi wr v write to ddr",
+		"MetricName": "imx95_ddr_write.isi_wr_v",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x250@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp input dma1 read from ddr",
+		"MetricName": "imx95_ddr_read.isp_in_dma1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x260@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp input dma1 write to ddr",
+		"MetricName": "imx95_ddr_write.isp_in_dma1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x260@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp input dma2 read from ddr",
+		"MetricName": "imx95_ddr_read.isp_in_dma2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x270@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp input dma2 write to ddr",
+		"MetricName": "imx95_ddr_write.isp_in_dma2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x270@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp output dma1 read from ddr",
+		"MetricName": "imx95_ddr_read.isp_out_dma1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x280@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp output dma1 write to ddr",
+		"MetricName": "imx95_ddr_write.isp_out_dma1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x280@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp output dma2 read from ddr",
+		"MetricName": "imx95_ddr_read.isp_out_dma2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x290@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp output dma2 write to ddr",
+		"MetricName": "imx95_ddr_write.isp_out_dma2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x290@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all camera submodules read from ddr",
+		"MetricName": "imx95_ddr_read.camera_all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x380\\,axi_id\\=0x200@ + imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x280@ + imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x290@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all camera submodules write to ddr (part1)",
+		"MetricName": "imx95_ddr_write.camera_all_1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x380\\,axi_id\\=0x200@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all camera submodules write to ddr (part2)",
+		"MetricName": "imx95_ddr_write.camera_all_2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x280@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all camera submodules write to ddr (part3)",
+		"MetricName": "imx95_ddr_write.camera_all_3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x290@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of display blitter store read from ddr",
+		"MetricName": "imx95_ddr_read.disp_blit",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x2a0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of display blitter write to ddr",
+		"MetricName": "imx95_ddr_write.disp_blit",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x2a0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of display command sequencer read from ddr",
+		"MetricName": "imx95_ddr_read.disp_cmd",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x2b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of display command sequencer write to ddr",
+		"MetricName": "imx95_ddr_write.disp_cmd",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x2b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all display submodules read from ddr",
+		"MetricName": "imx95_ddr_read.disp_all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x300\\,axi_id\\=0x300@ + imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3a0\\,axi_id\\=0x2a0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all display submodules write to ddr (part1)",
+		"MetricName": "imx95_ddr_write.disp_all_1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x300\\,axi_id\\=0x300@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all display submodules write to ddr (part2)",
+		"MetricName": "imx95_ddr_write.disp_all_2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3a0\\,axi_id\\=0x2a0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	}
+]
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index e42efc16723e..ac9b7ca41856 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -284,6 +284,7 @@ class JsonEvent:
           'hisi_sccl,hha': 'hisi_sccl,hha',
           'hisi_sccl,l3c': 'hisi_sccl,l3c',
           'imx8_ddr': 'imx8_ddr',
+          'imx9_ddr': 'imx9_ddr',
           'L3PMC': 'amd_l3',
           'DFPMC': 'amd_df',
           'UMCPMC': 'amd_umc',
-- 
2.34.1


