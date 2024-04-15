Return-Path: <linux-kernel+bounces-144573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FCB8A47E2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CE89283BF1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6822224DC;
	Mon, 15 Apr 2024 06:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Yl4de1Kf"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2075.outbound.protection.outlook.com [40.107.15.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1771EA80;
	Mon, 15 Apr 2024 06:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713161619; cv=fail; b=SVoO0XqF3CnjOoS4uhmy3Q3lPxHI7384fzc1neHOpe2oLOyQQ8WUOhkpZNFn2VQl9lNSYl0xWvZTRmL0hoJzujcjBKkKCI/Ye9n+SIjDNXSYinFn0H4n4oyWrSFx06952yzsqZRCruUxhLxgT+3kdSEvu8rnz3EyoAfqHMpI/Bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713161619; c=relaxed/simple;
	bh=JmsTp8SsOs/lkHztfd4JuYdGtitO3rj0j88lG0m1Hz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H6LUR0QEpsYgK62rbZuF1hr1rtRnnOoJscGahdU0UqWFpCf9gp8GJvVtRy7OiA/CbhmOqAo22HSuCYN3vZdEnKWEbvhg8UkTafQYrxLH0MGM8TsodqfXWQHwFN/wYlFC3DNwLrmF9TjEjvqJtA4jY27676KfFkpCYTSa4svOv50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Yl4de1Kf; arc=fail smtp.client-ip=40.107.15.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkOpoeskJ6X7VrhetWH9+OSJSdKoBtSnYax0zp4pbMtN25Xf6NjxsvtVxaltv5uCybPSdxlaLDHJ5dqY8nnaoKUPiyMDYlFeBhYFVKO/RThkuJwyvlkWAimdH5CU0cPo7iYxDouXJVKzeBLGN8cQ4fBogqSE164YIu86IsSm0huqU4CAaWT+BwCf+zJvDC6xVqR2J7OsqSFq7wzUepzOq5r8RpBp6pb9bVo5opy+moL90xkrZaMes5zxzrN8dGesjgr5FcGSqMKtVpFXs5NW2pW9dLSN3kiZUslCTIhDMKXEIQ5Np7fOUs61pAaTWl47Q1s3sTxSsb3qhtLky9iGAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBUyQjIrMYdgiJ+kX+6NtTB/cwMwzx64deIcsYIdVYU=;
 b=K0f4aDHl06rXjkv2goIFaI0lzvt8nFZipm2UBqkIwz/kuP3km2cWB1Ylk2AMIB0fnW5YF9LMHNkzD8dAkwjqXh8BjsJ8QnAx8H3K6WmJth50F0fK4Ci8C11YKyMNbx8YVF36/gRkNCPh+tgY/t2ZnuKchGZEd5D6jXGSGpZwzytwoaK1DWR8Qn9moIG8zVgaBL+tIlZGVNz3BN4mM43Z2lDjPQKTun1Lr6Cww9T0vArXyftc+CtYVoemIW1wdODQeEcw1V9y/f4p+VgUL+5W5rtoG8XT136+h8GPpruxcJtwItJPCYzAxclb0vCpoqQeATheA5b4YHaUNf32URw95A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBUyQjIrMYdgiJ+kX+6NtTB/cwMwzx64deIcsYIdVYU=;
 b=Yl4de1KfNlsy5V0C03W0hng172n6tfc5bMTNSvAN44kqJanMYuGLG54JukAo1t86E2rCcGfYcIDKQw0aK2ov5B5m318HiveDJ+wAFQvXRG4jUiaiHv3pPu2CFU+JAjPV7thEXsVfqlM9xWN7tnw+Jxlp0B5ZMNfE0GMUffGndPI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by PA1PR04MB10117.eurprd04.prod.outlook.com (2603:10a6:102:454::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.43; Mon, 15 Apr
 2024 06:13:36 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f%6]) with mapi id 15.20.7452.046; Mon, 15 Apr 2024
 06:13:36 +0000
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
Subject: [PATCH v10 8/8] perf vendor events arm64:: Add i.MX93 DDR Performance Monitor metrics
Date: Mon, 15 Apr 2024 14:13:20 +0800
Message-Id: <20240415061320.3948707-8-xu.yang_2@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6d74ba00-050c-4798-0b0e-08dc5d132f34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	18BNEh352gPMNWF3Arp3GuczjkiTikGYdy9Vt0V2xr9Nj1ZgvdqlJZysRTICVWU76IN8FdTOdkGnphImbJM46RWP+D2tA3nqKTS1AErTjH3uqoIz+JSChZ1baNjQM12/N6uL81SaooMc3JuOgLFKvL2MaXE7Od0nw4QTA2szjXLdcep8G3CLwpbowl4I5uyhvjcIUj4a97v0z4W2w701CZF9X5TpWtVA9W1zSByLu7ZfJOK7KltsM9b/CMhMPFrX47Fz0TGPC64DtrhdFSwBaSZOfv1G0VhNID/S7qU0j3CnPINWf+mP0b0rOJI5+ORz3Ssy5pqKS/OPAWXfzLhUUN0GjptciGZSTE+pLpfO5W6/DbjIMzEAMPTxWocYETlo+X9PBl4CIgw1CyJ7QEOGMVZAjqsmcaz+5BoM4Bl2uLSyOKw6DimnGQyKALAjDgeVEiCZik0mKTLwKh4zLSwW8e+E4v3kAmJt2ntOWKySkmMXbN6vloKaRWbEX/24yWHCn24V9wZwLaUme2xFGKo0+p7I7Ze8qTL8Deafm5UN/prlxnMKasU8DQzjT7wb6UxZwLajhXleE6HW8KltzZSZ8ISbuxPtSYP0ZFQNA1euOIqu8MQ0H/Vz+lBELMBlLJTQhLTS2WXJBlud3+2yjsqN8QZ18DDK5Gsjqntcm29V18FVJOriMb1pOG83FZizCuRzLjCWnbP+agtovZr38lrLtYWTFX0jA7xifqb3j0DkV2A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(7416005)(1800799015)(366007)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fDu312fYh7hltzGlFwtoxjDWEPhEP6ssc/SHdhGW9wHNI6Aw/Id4vGyHu8Rg?=
 =?us-ascii?Q?A4+P3x6TEaIUvAnQ0byFRwIqTXetyqM+12bcohNeNljKn5dNfLAvHCX5RUU+?=
 =?us-ascii?Q?uq777W2Kr8YkAV06Mdh0jO2W2+ZtBxZwhHl30xMlBrVzZ45MeTRbMpVg8lZS?=
 =?us-ascii?Q?09x+xrLogo7RRYE52mZ58OUDzh1ra/Nc2MJ4notb3O8FBmI0fIWY3Djv6s9d?=
 =?us-ascii?Q?koXv5zVs0zAfrURnwjWRtW7BQ6iewY0Ylnrl+fyhM7C+l14bk4CtAizqFJ/g?=
 =?us-ascii?Q?V6jFLERPIoeUr3O7Wj/8EN2x35q0R7k+RGcgXr5XnefARyFqlc0+s05B7IpT?=
 =?us-ascii?Q?eYI0uKUHTwOypL8hWv6qYIAkwNQxejZP6VSTtAyzpsWTT7G5vaw62oUEjTeZ?=
 =?us-ascii?Q?GfI1l7it3Cc1zUmzmZ2q3Xiqxba67KBqg6ggQoWmz2o4crIcWfm0nZ0Zou4u?=
 =?us-ascii?Q?v8sDrytRGIA3vTErpgi8dDJS76BLHFI32jnuMotoGq0Pk/fHSHe+kS7n76e1?=
 =?us-ascii?Q?NhSM5P758IXPgIDXDEtzgsOJcqWbSzxe1PEx5Hh1J+TgsEyEjgGaiUci3QyF?=
 =?us-ascii?Q?b26negOHQaxBrdw4KECKWzOfmYjpIkRAdgVsRqKshy3ddVM3o9O2/FsUXhu+?=
 =?us-ascii?Q?acDKzLYgLmzhIr2TiOBMsqO2jpMR9hUiPXzjr8t/JvYAKuXz3ULfEc0VBfGP?=
 =?us-ascii?Q?ACFAE54knfQW1zPxowPUCdT1cFjBD9w6Hu+kCyu9a2CsXSTcfJjsdGFrSzyO?=
 =?us-ascii?Q?q/jgveTW12dfUnHlaE87aQpCrTqJ1iVyXCEooQMYJFHxcywKo7pXZPjOySl3?=
 =?us-ascii?Q?RmxIc6XcSbnhsUcdDGwW+eh2mjVaqfl+Og3eQLxkeu6pn+AFhz/l9tdqGUvQ?=
 =?us-ascii?Q?UCxQ3H1el6GjDPvTK8hR8akStoRBRkz4C4M8tfl6bYDD4yIOuPZif1R9SUwd?=
 =?us-ascii?Q?G6j591uHJiw6+zArCl68tHmd6esKr/HXeRNpirHkNpAH5liY84A5BWsiyUGd?=
 =?us-ascii?Q?W0NnQCGOqq4rUrsQHG7/HVWZF3kuMhJk6tvmn19neC3wZRNrJ0Nbw+WU0NbJ?=
 =?us-ascii?Q?D7i8Qezup4HgZDSs0IMDOOZf3PQuEsGvlDPaeJSjiyb1iZ/yrH5m6BUbHCgV?=
 =?us-ascii?Q?tJdr3ZsXmveHx1s3MMuRYBNFV9NHoOf1R5luAG6TKIijIEg4dcnB4kBIozzP?=
 =?us-ascii?Q?OlA/epbYhj98ExeH+bajenzb7sNNtyoui29eFjoxd2EjTgy75d21roDfJcX2?=
 =?us-ascii?Q?50m0UbGV2Y3fZtnVpjpJvfIe0ArCEc+KeCQLS5jJFw2rGBZCLrQI94A6jbzD?=
 =?us-ascii?Q?tVJmmndYuR6g5lt5BEAn/fgIRBvy55vHVTG3rAFCkMLUisGp5Jy4GwYZTHlx?=
 =?us-ascii?Q?m3jn61uwEIYDDdBWu8eg/qIkCechHfoR2ERWi2LPZrBCLfrchBoiuToTa1eC?=
 =?us-ascii?Q?2vPoBHzGwUBFMCN1vl1f1mSnplqF5ge8aViJoOGV1lhcJ7ZVK3W2uEqfilA0?=
 =?us-ascii?Q?k/YfLLk8BkKhfVyiORVyXC+K0g3/phgYL/9PzqnkNf4TBAv8NX/RWZxbPHgV?=
 =?us-ascii?Q?KUyCcQ/iUQimNMPjnBSnAyCvjjGe675KkHgBt1Va?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d74ba00-050c-4798-0b0e-08dc5d132f34
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 06:13:35.9439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQM8OxwUAK8I9IPgJ60dkbhHyDzWFM1VrGgSI5vvTR3ltTnaS5Rl63o5zCcEMh/3bSprewcxrBczIXicL1sZLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10117

Add JSON metrics for i.MX93 DDR Performance Monitor.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v7:
 - new patch
Changes in v8:
 - no changes
Changes in v9:
 - add Rb tag
Changes in v10:
 - no changes
---
 .../arch/arm64/freescale/imx93/sys/ddrc.json  |  9 +++++++
 .../arm64/freescale/imx93/sys/metrics.json    | 26 +++++++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/metrics.json

diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/ddrc.json b/tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/ddrc.json
new file mode 100644
index 000000000000..eeeae4d49fce
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/ddrc.json
@@ -0,0 +1,9 @@
+[
+   {
+           "BriefDescription": "ddr cycles event",
+           "EventCode": "0x00",
+           "EventName": "imx93_ddr.cycles",
+           "Unit": "imx9_ddr",
+           "Compat": "imx93"
+   }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/metrics.json
new file mode 100644
index 000000000000..4d2454ca1259
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/metrics.json
@@ -0,0 +1,26 @@
+[
+   {
+	    "BriefDescription": "bandwidth usage for lpddr4x evk board",
+	    "MetricName": "imx93_bandwidth_usage.lpddr4x",
+	    "MetricExpr": "(((( imx9_ddr0@ddrc_pm_0@ ) * 2 * 8 ) + (( imx9_ddr0@ddrc_pm_3@ + imx9_ddr0@ddrc_pm_5@ + imx9_ddr0@ddrc_pm_7@ + imx9_ddr0@ddrc_pm_9@ - imx9_ddr0@ddrc_pm_2@ - imx9_ddr0@ddrc_pm_4@ - imx9_ddr0@ddrc_pm_6@ - imx9_ddr0@ddrc_pm_8@ ) * 32 )) / duration_time) / (3733 * 1000000 * 2)",
+	    "ScaleUnit": "1e2%",
+	    "Unit": "imx9_ddr",
+	    "Compat": "imx93"
+   },
+   {
+	    "BriefDescription": "bytes all masters read from ddr",
+	    "MetricName": "imx93_ddr_read.all",
+	    "MetricExpr": "( imx9_ddr0@ddrc_pm_0@ ) * 2 * 8",
+	    "ScaleUnit": "9.765625e-4KB",
+	    "Unit": "imx9_ddr",
+	    "Compat": "imx93"
+   },
+   {
+	    "BriefDescription": "bytes all masters write to ddr",
+	    "MetricName": "imx93_ddr_write.all",
+	    "MetricExpr": "( imx9_ddr0@ddrc_pm_3@ + imx9_ddr0@ddrc_pm_5@ + imx9_ddr0@ddrc_pm_7@ + imx9_ddr0@ddrc_pm_9@ - imx9_ddr0@ddrc_pm_2@ - imx9_ddr0@ddrc_pm_4@ - imx9_ddr0@ddrc_pm_6@ - imx9_ddr0@ddrc_pm_8@ ) * 32",
+	    "ScaleUnit": "9.765625e-4KB",
+	    "Unit": "imx9_ddr",
+	    "Compat": "imx93"
+   }
+]
-- 
2.34.1


