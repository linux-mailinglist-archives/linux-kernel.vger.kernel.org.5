Return-Path: <linux-kernel+bounces-45787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D9F84363F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8933E1C25A88
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8C13EA9E;
	Wed, 31 Jan 2024 05:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XsLxGdHL"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D433EA93;
	Wed, 31 Jan 2024 05:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706680332; cv=fail; b=F3eDHRQp8IGut1C2jQBUl03SYjlqWwJuakSfQS8cVttiiwJpgrnV7r7FbnsAjgTDqHwuMqO5Ha3BOmrX7FenEq0Q1EtOucMsPsS0iRLgvvQ7O7pUVFzeBmn2BJec9GkSO9m2bkL70zFWPXh5pjZXUqvD9hRenfoVDaC5/Ou2bm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706680332; c=relaxed/simple;
	bh=fIo0CMs8IQI7AsbSt7Y0byBIJ1+dRBv3854WDWnocpY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fybjySkyxMTiVv321js8r7hguOTpVt3LxuFo83wX3tH/93oAuQHX+waNEi1cu1MpvfWyaJ1CDLiCVS/zJ6FTbBvUEpG7TCsjwdYznjDEimkZsxFUuHomdjc1HxXjmU2poStZ6a+uoDGOkXQq5TK7cVOF2vWhQaXstow96QVbFdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=XsLxGdHL; arc=fail smtp.client-ip=40.107.20.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4BMgG71iQSu3MhcaXwXlDoRaXYCRz55Qk4PgGG0yFfSqHnIR9qDViUypEQXysD2/3Dy7rxntfAwR+m56aN9CSm1NxpaUj3kPppAgPMxHno2kV8kth46x2xyRofWOpfz3eNaCaHw2g7RjqmoeX2NHO0FaFNt0kQnCLcvjxnP3RzvdFKGhldO+XOSgMsGtg8Gu3wJUbz/BYtFEBwi48A2ZuVV7hWisc364IyGgfeMtEkSk+uRS+DpQaSQQu3kvEw2xh2qIz1Ydx7oxy6iHfJuoipaUi1mS4LUhuOGxDC65++U7DFFFLU7SpXizU5fc/ew1Cvy3BARBvmlfr2rJr/aHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBI4ftkU98M4nX6JrbpHLdsrSZs1U0vy0GlcdQ7ytjA=;
 b=MFbaBIzFEGMtrOKzqsNAGZ4cVwTkcRcj5BVn71LItd6ZPfctW9K+lzr079misApfNupqAWz25hS6PyMxupeafP7FijLo/WKfemWwiVMi2TlC5c+aqvAuwE7qqSXw04TaYFa5DQWH46RzXfjFNAJNMaLX0c3xqxgQk0tIGbaLEw8Y2SoFF6x9jdzIH2AxV34vuI44dN7agS2TxZB8ifZKIddEglFFdYnlFInT11kzEC+MceGLAg79rEkBTWMzuRFo0ybaUh+nvGP6k4NL9LisdtjX6CueN0IkfZO8TB0VeO0BZdpghUsWoBvS4tlqTEG4KfGqCqz2HS05mLWZ/SjZ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBI4ftkU98M4nX6JrbpHLdsrSZs1U0vy0GlcdQ7ytjA=;
 b=XsLxGdHLHopqrkaVajMFEdmHeE3cazOp2IuB1487+JuANOoOeRp4hxibAKpJT5jz5eWeces2x0sekRzxYHi2H9i91bTUK0mBa4Z40Gn5Cyp7TmTRJoTxQzWYSBtw5AuMObThUHNNAAhGkJ9LhdsmO6d+wamAXo9S7mPltTtvqoM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DU2PR04MB8917.eurprd04.prod.outlook.com (2603:10a6:10:2e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 05:52:08 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 05:52:08 +0000
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
Subject: [PATCH v4 4/6] perf: imx_perf: add macro definitions for parsing config attr
Date: Wed, 31 Jan 2024 13:58:09 +0800
Message-Id: <20240131055811.3035741-4-xu.yang_2@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3dad1156-7f86-427d-23c7-08dc2220c290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0NoOkPgllhWs5D337/GVXeLMsxQozXPuFYBLejEvxJ150rxEjCO/UMKLDUjjR+QTOG58IdpnGjefvF4R0k3wjcpJndus6u2zRbVUciM2Fkbiov0/+owc+EdmHQ8W9de2neGUAXn7sHPfWkU5EExwIPuNRO2JArBbzmQjZbUwB6ZbvHJOXvPmPVD7HLrrSPaoLQ/+aw6yQgk2QeT14KPkltOgk2VHTZDfumzQno6LVLRqwp/vinCboYj8RswOSLCSL/MVNwrWH17IsgR/5MW1p3aawQJsrkst2Z/Eo8Xk4A0EH9YESJfmtPidyLw6pghVSTMjK0kqvO5/jQetpI6O/+LRW10M+exvug3/YunnOOxwNuUsLk17OzUWbWhINI5f8JW9NKuzdyoqIe26Tof8gA+wGX5slsJgoADdbJVOJJnMsbwAgOVprRHL6gb3Vs7NQhqcPt3yIJuYui3RdbXByBLviLj41iZ6eg+oLkIRNtn6lrYKPS82APfQb+nOUs2L45aIGEgwhWhyIRa+o556S0lj+Rco6iQfHzywabQDL3mDOaqd7gz4TD42l3Jm85tZE9q+9LmFuLazhTjuXuJO1asQY76an0jrTxOUTCvOiHhNvzVzkc87QY+wy1IcZPJ10gULnLPeuXzQRJGxCjL3cg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(366004)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(38350700005)(2906002)(36756003)(41300700001)(921011)(66946007)(66556008)(66476007)(316002)(86362001)(2616005)(1076003)(6512007)(52116002)(6506007)(26005)(478600001)(83380400001)(6486002)(5660300002)(38100700002)(8936002)(8676002)(7416002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gm4ECq5KKgCSNHlXc9e21zuKAnBiamcuTTzHU46pDSWRtEdsRJMKltuKrxVz?=
 =?us-ascii?Q?hdzchwvsSHIbilj4nvOUq/HTz2lsEWzvdnbJdLO/iZ6M7nJAhR49ZDdgYotI?=
 =?us-ascii?Q?NjUlqXjHnqKZ/WyVvkd7XMXoU3A6p3XdoXQzwOPr7ZoMBKINTJoazXQjqifB?=
 =?us-ascii?Q?p2G51cdzX88jXe5tyHZzbpGCCyGYDCe2SIMQ5aZhlAnN/HfpRG4FqaXSAme9?=
 =?us-ascii?Q?zVKEQ3LTYNAiHb+zfeIBiSiB5wwKu2unXmyT0nm1MT1p1Ilz1BRP1VRkg8xS?=
 =?us-ascii?Q?Gc9Kq/PKFuEbbUj5ZnithhXshYWSzcaXxf2VMI5zPsbMgzAALlQhz47of0jD?=
 =?us-ascii?Q?MTm0Xuzq+vNtci8ZF8bk/V7t7ZwCwSdp5waQPdtU2NG+T4eMNOkTexc9gYNh?=
 =?us-ascii?Q?q84vUummCe0m/FpF5KjRqYFYyKPsbIYlfYvBroqq/lsTuapeP1OTZ7P5P+a0?=
 =?us-ascii?Q?D6m1IAKIBnuv/YixVUEQE3/P+WhOQI4MpNTSKZ1Q8ZJBqLobPEYmmNkUfPPQ?=
 =?us-ascii?Q?ERNPp5D2O0rM30nytYMWRXu8lEVwbby3ufWXnd9dw9P+rjjG+3/ci3qmQXcK?=
 =?us-ascii?Q?em2tGjwXqUEg0XfUJfVx92HoDstJm/CWQRzWEaom3tCZgrkv/SWbgR6mnnjF?=
 =?us-ascii?Q?XCPCGpA0yALLR49zhJs8ovizdwcaYpaXGqJUG3RjO5l6//MYGtXnOW4WpnPQ?=
 =?us-ascii?Q?aZuotOpunY7ZQoip4PEB8HiAQjNy+dtrb8mR+xploDctj8b/AVUCJORTCy41?=
 =?us-ascii?Q?OJtU2awmDb3W+2dsDyX4788w6GwUkaxCue7a61AqmtaH58Os8lnw7/OllBKq?=
 =?us-ascii?Q?PiFgY9tdhSHH9ZMaU58YeoLijOop1d+TJ1OtjdYQWi0+tNru7T90Qtf5jAI8?=
 =?us-ascii?Q?FHQWSFn35EQZhbqPUzlwuDrMV1Dhcdx6t+Y9XoxZ42fhGORLgVh/UGqvG75d?=
 =?us-ascii?Q?nkjKqLYl81OZfMEGFdD76dxbW8tGTpqGb8dmQ5PgWSYeC6Ef5JF6fL+h37lW?=
 =?us-ascii?Q?7bhuxVOE6DSx7mLTL99W8Jak8Ddk/HaOGvg/wnumLNzB+pxzPuJuTjseN8t/?=
 =?us-ascii?Q?ESW6djjbnVPHW6fnHEU7iATufRgF5vu8mGLMGuZDdKcBtlzfAZOjiP2yOVrr?=
 =?us-ascii?Q?CucVjfC3VAdiuKn3IG7UrzWvcBJRz5N6nz3K/Dw/Qtp2VPEtrws0lO+67FVW?=
 =?us-ascii?Q?SYqD5WC702gTE/XMBirUFEeIF3az8ZQKBq2hHpSbaHwLMW7x559sxC15JYiC?=
 =?us-ascii?Q?PJUy71uhi9bkForMhE5DNrFrykL1NPK5zusAJzNJSYCtbzga2wDubGLVjLro?=
 =?us-ascii?Q?sb+yLGBt2SI/uwNevrNI4lyT0832F2gDYjO+c6y9JpSLahUY7NTBSxSZ1k5F?=
 =?us-ascii?Q?y/I7Y/lr9cfTdN/P7iS2XPtpX5EdM0mrnUClM4UMcNSTfIf7qSZ2W1RVdbvI?=
 =?us-ascii?Q?BVm5kNS98fWPyZe0axtTPLhWvt/I+FJPM8pIqguYWtCPCG/ypmawjXNpTlOa?=
 =?us-ascii?Q?jt+zDSiDXxmNKBx3AT2Gj2d1Ao7peFVGpMf+BBf3vlfFohwbSMmeY1I8auAH?=
 =?us-ascii?Q?/urxX3BgHqOYJh7Sh4t7V/0ex9EiLm058cZ45/Ff?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dad1156-7f86-427d-23c7-08dc2220c290
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 05:52:08.1204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nCcWPYYfaEKNV2+U6AVmIzfcNGHGXqybIuy2DquXhwHrTpOMeg55OZin/MzvV7vxyiuXPIhjQCqjG4VesDRa9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8917

The user can set event and counter in cmdline and the driver need to parse
it using 'config' attr value. This will add macro definitions to avoid
hard-code in driver.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v4:
 - new patch
---
 drivers/perf/fsl_imx9_ddr_perf.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 85aaaef7212f..94041f06c152 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -52,6 +52,11 @@
 #define NUM_COUNTERS		11
 #define CYCLES_COUNTER		0
 
+#define CONFIG_EVENT_MASK	0x00FF
+#define CONFIG_EVENT_OFFSET	0
+#define CONFIG_COUNTER_MASK	0xFF00
+#define CONFIG_COUNTER_OFFSET	8
+
 #define to_ddr_pmu(p)		container_of(p, struct ddr_pmu, pmu)
 
 #define DDR_PERF_DEV_NAME	"imx9_ddr"
@@ -381,8 +386,10 @@ static void ddr_perf_counter_local_config(struct ddr_pmu *pmu, int config,
 				    int counter, bool enable)
 {
 	u32 ctrl_a;
+	int event;
 
 	ctrl_a = readl_relaxed(pmu->base + PMLCA(counter));
+	event = (config & CONFIG_EVENT_MASK) >> CONFIG_EVENT_OFFSET;
 
 	if (enable) {
 		ctrl_a |= PMLCA_FC;
@@ -394,7 +401,7 @@ static void ddr_perf_counter_local_config(struct ddr_pmu *pmu, int config,
 		ctrl_a &= ~PMLCA_FC;
 		ctrl_a |= PMLCA_CE;
 		ctrl_a &= ~FIELD_PREP(PMLCA_EVENT, 0x7F);
-		ctrl_a |= FIELD_PREP(PMLCA_EVENT, (config & 0x000000FF));
+		ctrl_a |= FIELD_PREP(PMLCA_EVENT, event);
 		writel(ctrl_a, pmu->base + PMLCA(counter));
 	} else {
 		/* Freeze counter. */
@@ -408,8 +415,8 @@ static void imx93_ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1
 	u32 pmcfg1, pmcfg2;
 	int event, counter;
 
-	event = cfg & 0x000000FF;
-	counter = (cfg & 0x0000FF00) >> 8;
+	event = (cfg & CONFIG_EVENT_MASK) >> CONFIG_EVENT_OFFSET;
+	counter = (cfg & CONFIG_COUNTER_MASK) >> CONFIG_COUNTER_OFFSET;
 
 	pmcfg1 = readl_relaxed(pmu->base + PMCFG1);
 
@@ -443,8 +450,8 @@ static void imx95_ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1
 	u32 pmcfg1, pmcfg, offset = 0;
 	int event, counter;
 
-	event = cfg & 0x000000FF;
-	counter = (cfg & 0x0000FF00) >> 8;
+	event = (cfg & CONFIG_EVENT_MASK) >> CONFIG_EVENT_OFFSET;
+	counter = (cfg & CONFIG_COUNTER_MASK) >> CONFIG_COUNTER_OFFSET;
 
 	pmcfg1 = readl_relaxed(pmu->base + PMCFG1);
 
@@ -561,7 +568,7 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
 	int cfg2 = event->attr.config2;
 	int counter;
 
-	counter = (cfg & 0x0000FF00) >> 8;
+	counter = (cfg & CONFIG_COUNTER_MASK) >> CONFIG_COUNTER_OFFSET;
 
 	pmu->events[counter] = event;
 	pmu->active_events++;
-- 
2.34.1


