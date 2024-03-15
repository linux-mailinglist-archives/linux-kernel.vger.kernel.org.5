Return-Path: <linux-kernel+bounces-104230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 557F887CAF5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790DA1C20F5E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C68A1B7E7;
	Fri, 15 Mar 2024 09:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MVACsic4"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2043.outbound.protection.outlook.com [40.107.21.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366631863E;
	Fri, 15 Mar 2024 09:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710496599; cv=fail; b=MIawAnds/79B9VnN/LgROleTDNGmI1XgRahq9Iqtn7FTy8oumTEO6iyG4QTz5qU9eW8BKB2JASe+IWYbEcqmAvCtVAeVFhbUg43oE9lJxMJTGrgwTS5yhOa2Sodjj4s2xjU3NFXnptP2D3Ey28L/kMTu4deJxNx9KGr3KuNZDUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710496599; c=relaxed/simple;
	bh=rwYqhNYoHdtUwYDATizhZoLEgdMlNqIGfle6Tw2boG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mJbb0xzF/c7VDI5SNh87Ic7Gv5DTvjwN38JaolM0PNib7EbHlz4DOm3U5DD+EPRebWjheMcMaf1YWD1I3XPtSC7HIOXLrHoojtjV1+dz3ClJ24W2D9Nw5gr/trSvDN6bNVIC/LyiC1+YS5qBaZ5Lp5GhNCgvhWS1WzsZqjcZgMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=MVACsic4; arc=fail smtp.client-ip=40.107.21.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krJ6yUw7ewUF8vixYHbLe0o/8bA/3IvarojQ4iS7OB0ot9CHYhjWZHntEFWPaCPw+m1Ed9sFqhV/bOm/FuOxWN9/dDy2P70U2KckdWkiecN7/VqCgB/X9hRBZjwWJQhe9ujL6M0OLcZZPQcn/w3eBeQUs+KO8njVtAfu0fUCLZQKaVA2S+K6esw8AQsyaVnIr04fNM1WCeA5HHbPAfsMu920GlQiyS80W120oeamBOq6mL3ndJ4MF3rvqxslqgvrOov07Tnq3R60JtUh9NFq5LektKef9pcLNStlZKtc8icjAuHZ1AuV3e5SvITiji6U/7GYBNCYTwNpDaR6SOX4mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vyDbuMctvpMPqycrjJSM65sHwairLUE/u4gLzHL5zA=;
 b=DSRR3xDhc8mXGR3GG5fb8EdbPLkgHP5aiOcIy3jI87iqh3YWhOyZnzxQ+Beg/JP5hUxIduvas1NE6mFJMhKMy65ahszzE6UN8u6tJsivZqjipiePtoo1uc5wIVle7ovIWzdqKamnblDmP5y8AyrmCnQk48sYDiV1pl8Ae7Rw7z1YEqVzC8ch8OP//jwZBBMMb9GEef3gX1wfpDowEfWxZguvPa0bhd48lUMcfy4aO5eusGaactOfs5Mmm5Km+K8B5ZwZ49pT4m9inujNp455hSEjhd+nZg86Ru7/t3lrbZvlP2qHHwWQh3PVvw22gHISlK53f+uRy5eg2+V/wbYiUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vyDbuMctvpMPqycrjJSM65sHwairLUE/u4gLzHL5zA=;
 b=MVACsic42jNrMy3UsjhoCxOUhzPX0tFFzBSAJRKH2mgQyyh5hHQR8cQ2uyglOhrzf51OAu3CjFEkb6AsTKkx1kFQ2rH/GlyPTQpAwZ3rBllD3RjouTofMZU+2PBoEd8y1zsoI8LGSRId/R2kbHs0EYTDK1v5WlGUVGDlDDdWjdQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AM8PR04MB7444.eurprd04.prod.outlook.com (2603:10a6:20b:1de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Fri, 15 Mar
 2024 09:56:34 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7386.021; Fri, 15 Mar 2024
 09:56:34 +0000
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
Subject: [PATCH v7 8/8] perf vendor events arm64:: Add i.MX93 DDR Performance Monitor metrics
Date: Fri, 15 Mar 2024 17:55:55 +0800
Message-Id: <20240315095555.2628684-8-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240315095555.2628684-1-xu.yang_2@nxp.com>
References: <20240315095555.2628684-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AM8PR04MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e990d4e-185b-4481-0d4f-08dc44d632b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Jw08Qn/k8MTTF4JCIMIWwzkOhXQcwUacpcZ5v3tnWoTlIJU0AwjLTMFvu4dIkpwSQMLa6pxYCxTa3zvPAcqJ9CaCc7hCzWmzmWJn8FdfjZPm68GVjf06PjnRaqAgulINfeAK3XGSYIbtvghez1g9wDCx8/yZPLNkapMDaK/x460OgN5L1VDoxlphCnUPg/9FTLDgfisTUnxc3fuhHSB7T5ePmDhQ8IOQhB8IKCfZ8bUnD8L0Jg721VypZRiclTGJaUi7C9ZkpnzP9p95V+lFHyti8bx4VqqaBWlC4zfUlj7PtlBxHRZa3jXybXMpTseNbT16N8il7W8jt5F5dU7zBktVQJnw4STf6q8pQQ+GAQKiUH8o3M7ukDyjO1Bl49+Y22zgKr2ns5S+K/cIMHG8wFgZX0CT7/Rs05m1xzFQYz8UGLRNG1d7R+xtywI1X4XqfQb5Z6ZdtdQQwa+elNC4O0YjISbgfmIOAOp1rnUDO9VwfBx1U41jjcOFavMY443Rcl5/CxIMLyQh8PXC6Tq5rUgnRMgpxVsBxrEv6BlU6w7Ykb0X6geKsyK1uYAfpauKS7GdKE7+ldHasbSyfcIxQR1j6s4J11TWS/xr2aR28Em411FwOiPsEdb9tuUIWjqUheRxcZ/WP8g/I/QozogtYuhC9+PoTXbh/EGHEI3pv6ufOPd/3ooOUrRI/4zrxQeTWj4Q6txqt0lxTUZE4tjaSY/UTUe3TxzSdu9+g+SSXuw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(52116005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g43Q+tXVw4Ybt/ZXMquurnvNwnRHUhIU2c2Ee4UlZpaKXkc2bjz9LMZ+164a?=
 =?us-ascii?Q?OOq7iewUDJDgu3VlTVU7U6GY7SLL0qUPVLY9QLycsxEaGMIO5woXqC1VWJzf?=
 =?us-ascii?Q?6pV7poKq1F91VwztoI7fSg6nC/zwFwXk1nLlCefZF58g6XD6AmVMPAyyyeLP?=
 =?us-ascii?Q?KJu8o4L8QzJn4JjYBnsRu+PRiE/Jo+PDc9tpWxsivq4Pn9lYgbR8TEBpEHes?=
 =?us-ascii?Q?uvkOFLivvrcDPGT3QQjC+sxfok3IF5SbJlM6Iv0RSqtJLdJAHjnHdzvBepN1?=
 =?us-ascii?Q?w1H38a1z+axpuSQosevIVOhM7/UpzId61Eo+ElX9d21/fQFnqjlW5qCSJMvu?=
 =?us-ascii?Q?Ofg+4JRlND1j+Z88bFkZVUfRC6ui0qLrY+WefQzEOnzsNowm/g1p50f8seDN?=
 =?us-ascii?Q?XFcM7kmg9Jbe3R3dJULv2xLLVUa+uNRU9H03X8PQD0s07Gpz5A4ZK8ogngUX?=
 =?us-ascii?Q?/ZvHN3IyPpGHDV1Iv5eLzMZDOYLPrpF1EqWMAWyM6vGMWARY6zoBJpx3MRLQ?=
 =?us-ascii?Q?RIbmeljS1W9z5x7AIy19UbLRMFVqv6DhM+4YRLqSncZvGiwMpyhU8/d8LKn2?=
 =?us-ascii?Q?zT8mF+rGjL9lqsI5+29UqLT/hPG/0X79oiZ9mZy9ECX2O13rEdJ6n0Fxt5XT?=
 =?us-ascii?Q?DnX5rxcDmZEKkWU/sDLS972jsoxJ3/uxQE5YWRxjHniVB66dnWy5eVP2xqpv?=
 =?us-ascii?Q?dguUVmCfNdT1lghuESCxvif5jqNchjCwpnMZukLfPQz9GVqCHw0wY+VjRGHw?=
 =?us-ascii?Q?qZwQzYcObgn0odMxFrxL1mLVrejRxSAhha4TcmqMFY5KqAsZ+EYeM6Ar+ziH?=
 =?us-ascii?Q?pcpfA+bi/Rhy5aosqxUDz2JMgxkwVI6mn9Hm8MTBRuxCLyhj63rUTyurgTeR?=
 =?us-ascii?Q?N29bsZS0qKXOHkeHom28ITLDypwPVCSQzQvyZ4jjF3fE3LhdP44ksneUJ3sf?=
 =?us-ascii?Q?sRfL6lZ7f2pBa+STNKko06u4nTZtYmNE1pfL0cxhJ8Yc+1/fsGtA0kmdlibu?=
 =?us-ascii?Q?R9Vddq6jptpqvrff+MNjON6Y7oBwQA69ZxAfnHYDUioIxH/IYdgSBEFSfeE5?=
 =?us-ascii?Q?bZPApuruxi5y3LoYd6x2Tb6PXgBuA/JGEr+9Cz+Ukn9KjMY/BbgV8VrAlUJ+?=
 =?us-ascii?Q?rDAQcdolSk6wv/T55gUJfN28Yp/MYyjb1gAF1uB4h3jcFpKgup631E76YxaM?=
 =?us-ascii?Q?wapcxMQUnyYZsA9LnPRBLwJvZ0rMnhEb285AKX9OBgoL4igFvUN+Lv0bkiWM?=
 =?us-ascii?Q?/qiRGKOHH5Qmr3HoqaLHM0DDeZpNPNO/DbopCeSuOvwUltzKKO9Y+IC5/L5D?=
 =?us-ascii?Q?sItfxzdsWBgv/LWzwfRab6Ae0yynmYa7XV3cbZZx0hQupEsXEJRtRTlEN1/H?=
 =?us-ascii?Q?NyLBRSwiggxhkZyXGv3PWMwjdXG4ILuW1hOxsv9ZCZvvAOG0D/1UTsmf7VtE?=
 =?us-ascii?Q?8hfEFBht0x2H4n12HKNuXqrF5aEjoW57zMFo3Itv2l850Qy/XDw5QLdUfnC0?=
 =?us-ascii?Q?Zm5guSeDnPLCuXM5MHNO39O4idvL9UpoR2JR+sJB+If05IQaS+0rsqV5d9z4?=
 =?us-ascii?Q?JOe4sqty3825iczbIHWQ9ZXZlybUScHqRYk1rSay?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e990d4e-185b-4481-0d4f-08dc44d632b2
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 09:56:34.6433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1TlgGlF6lFNdluvBtxYiFMLaRdiZJO4Dd4qh5JIKsCrhsEjlGWlre2aPN5GBYt0SvP+kZct948fcR2fttS1PWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7444

Add JSON metrics for i.MX93 DDR Performance Monitor.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v7:
 - new patch
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


