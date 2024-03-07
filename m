Return-Path: <linux-kernel+bounces-94886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8003874653
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5668A283ABD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017E0E554;
	Thu,  7 Mar 2024 02:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QbJ363xc"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2050.outbound.protection.outlook.com [40.107.22.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C10B17BB3;
	Thu,  7 Mar 2024 02:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709779706; cv=fail; b=f2am9YTcPHOI8MfgKGE4R4TNS8DJQD3MM9CwOdseDe8/W0hPpk5ws5ji5VoRBkU3UvKJdgbcQOLJegsg6x0/9CHXGgoMNHhxHtS8+eMcUe/CaYU6qfG6c/2YWRYSbJyPKarIacwhC8NGE+KQ5nD8oiuz0Jw/XrzEQauiUDXcwFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709779706; c=relaxed/simple;
	bh=FWsyJIMHpEsl/hq69TdrUo/C6TPq6V2Q6RgH+3u5R4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gmrGAyk+Vncefxqm29P+vgbknmjYDR6Lw8tuO6WybSFAFjfhoPJqfh0Yr00X/FtLhsn3/ClllUNpEpI59IFwO15T39nKiS4i/SV7w+UR+S/GEYOh5WuVteXuD/fvhMGfHKvNbncvEosMWyDh0lCz1pWxMVUr2e7wmiCvvt4sabk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=QbJ363xc; arc=fail smtp.client-ip=40.107.22.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPMpXHNrF9OO+jkWmt0ZroBfnr8q19adrL9YGuDRClh0mj+gBqdCNalfz5sDXouiFRe1WPy+ZSGjBTckFLom9jItIHVdpM7mW7JERL7cm+eGLz6HYQPKfkx28O//QsxKBWyJR7vI9TwU0asU2J2UV2bV9AWZgLALMuO8g+Yol2ilTjEzmRUPgPkkhOxBacWOvnFVgF1dEwYYLwpqbn0827kGEhu0R9oux4X138o50xWL2swT0H19joevJyv70zGOi/CTbgwJmtJNOQZLJWgVW5ZleM8JQfQW15CuRWr8P0KVDEUtxIHpc1izkdD8LDgij9HiWM1eeUHh+3GC1hjI4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txgi/SKif4pZzkn1YRbgXWmvam50+iuqmwjxPf4LUUo=;
 b=jRpCL8vpjzYXG3UjwoJjCTyuQ/A2SXD3RuJfu+llbleZ4Vd8J2+x3JLGE2YW/Jg6N2eQGlTCG0OYivIV6+1T0d0FE3p6g/fV1lY4Savk4NeDjaX8JT0WK419Wy514H5HtyyCx2KUnTXMDebbn/yGvzUi5xl8xHIQbTGcVthKYY+QwyOIUEj2UyuDEH59EtrjwMB2PevYuWFFVlS4DnUJd+eAzVtKg+qjFZAjaO2Wj2ocec3YcOZ3EOjTeaMsCZT3U+yYHz/on1fdSAP0WGQ2ocVcSU7afBukovBjDev4R4R4cnE3Kc2IiQIkFyba5SYxjfQLu/iyWV2OAd72OkeYkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txgi/SKif4pZzkn1YRbgXWmvam50+iuqmwjxPf4LUUo=;
 b=QbJ363xc1zKSb90C36aRQIzXjGob3bSkGzFGj9uHJvUBzgZ32FGVbl/VOn8P4HCPSlqzqNtVabyF609kClRhyCevtib7mMjpp3epTYrxK9XlluPvirUSCdO8ruGV6mBnc11QLas+2piucLjQjzXQ2bEhNe90e4hqvkOMfFgw44w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB8022.eurprd04.prod.outlook.com (2603:10a6:20b:28a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Thu, 7 Mar
 2024 02:48:21 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7339.035; Thu, 7 Mar 2024
 02:48:21 +0000
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
Subject: [PATCH v5 4/7] perf: imx_perf: add macro definitions for parsing config attr
Date: Thu,  7 Mar 2024 10:47:51 +0800
Message-Id: <20240307024754.3469810-4-xu.yang_2@nxp.com>
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
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS8PR04MB8022:EE_
X-MS-Office365-Filtering-Correlation-Id: 91765e0e-5db4-41e6-6210-08dc3e510d4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uO/+d7HP3zHt/r4cuvLJSVEBmcDk03FlodA/m5e6XKYwna8iTcFBZZKhYlEKhMdlilHopa8WURUY2fUClyuDsFAFV5/W16S9AkGS6g5MvgNbXdOvJ6YKM6k1IbGkdH26AFEax9JgJWfab2bj0zC2gKqm4+mwM3yCtkdlYGZepDT4AZay6hedRnjSzGkdZXScgII/ef0GG6j7vV09Z9MrieUquCEB++5EjJHXLCbFs8PwUqWMDEXQU219LSKVKosTfAZfArSOF7qmnScSAXt8toOm3njeGZjZt+GrXND4O82WjJx9EcYoS+3fdhC1yZK7p9GLRQDdRuSqxjTzqlcMy7OiMmR26ZwzJLXaBrWCl/Tc0XOns5dLHuEq0+QJugs4Sr6bPSC8AFN4F/5fyY/nCS92Quv5e+yLcneg6UoFzVQpK42H5kJpdwaFUAQqWhfD2m3Pk6uuV+WKODgHLwgfWCn78a6Q9TvCCRS3OyskCjVbBYQZb8oIIdA+l3lVfVhMq59oy/rR2kHQimx2DNiOLw/d5xDkd75y+hVXc2CwTd3hap9mELzpArnL1CUnqgF8zwkmiRahKeCFzbNiYWcGsURLOjOqbTXIBsw4minFelH/J+i76hWdM5JwbGcIcWCtDY9Uyxs8b3/wU9bMyZr691jmDvAkKk1EE/u7eC+WFE4oEmcAgX+RoFjOB/yporFHYVRg0+d+x6CVcjaqk0z16HRyKV2uPahJfFJltRf/Rfg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PeUQMOf7FCvU1vslfYQvsXfYFH80ART8AUt5jgfSzsQk+ANQb9ZijB+lerph?=
 =?us-ascii?Q?rKIEU9QpDqky/s15pgZOtxMi0PDLGfDeQJAenUM9+9wxhG7JjPz7THH3cZVV?=
 =?us-ascii?Q?c9A13ZW//0Hh8/pJu/e2Ae5+YHkMcyH8zFWrE0iPV5/9vDb9O9G0KjlZxMKi?=
 =?us-ascii?Q?mxeYB6fYlTBPlCmvmD15GdlTki7mW7cy1k1wz2GZ+Qu0Wdx3kqV5F3h7WDt7?=
 =?us-ascii?Q?c1TW9bqvuVxXCN+hr3YePqt4xohtEmwI4Eqi64s906TjW+I6cei23Y6F//lL?=
 =?us-ascii?Q?rzqbo3KBqAGpyzHeJG2l0jnv5K3lvt7x3adZ7EnIdUeqdR+jqUDUnqW2ESPp?=
 =?us-ascii?Q?MipCQN9FueGY2g72TbstXmrXaDGEbrV4MvJupWq8JAm4bIxzx2buBg7Qzfy7?=
 =?us-ascii?Q?w97wVzKoRvQRt76Rx7AhoIIm36RuB8Kd60AvPgJg5k254Ao/U6S7jCGr7DsF?=
 =?us-ascii?Q?TLbS1Wkn/09MHBnsuAVCFNKd60qKm1+Nmkkz1odoGICTTnhlpJ6YsSY7BvgZ?=
 =?us-ascii?Q?jMV/e9HtNXteQwIShDXkE0A4j32u7XEsjmDsTnnVhGTOkB110+RWrDlMIch4?=
 =?us-ascii?Q?c0p4wkY5tFFIkb87v0w6Unu6+iTJaGWsY6GL9myqAAtZ5iVmZ+QOY8aRWEOb?=
 =?us-ascii?Q?2k7h3NWvN3FCqT/9r7CpUUyVjxz4XIoQIxJEWyf/7+Bdb+kWnqL/lCx2S6cf?=
 =?us-ascii?Q?teGJYaSKMKw3hh5D+d2469Z4Cmm4wfowMjdZyw8frcj9RqVD/XCc47CT18sa?=
 =?us-ascii?Q?yiDzzDPyVlDfF/+ogwZ7XoipBnQ7CP5dXVYpBCOM0uxc0DzxDqqDjPbl1WpD?=
 =?us-ascii?Q?tXJ7q0gS+hDkM/oDwKoR9Nt8zFvusZFot673+laChP2Zn/KvEPw5VvOhRaZn?=
 =?us-ascii?Q?gQdl2GlpH1c5P+ebXfwBTNCpZ7H2S2MhBVfF94vovM6qgp86h9YSTcwoMkm4?=
 =?us-ascii?Q?6RgfQsSkl8uJJDyggwfa6Wv20fDVdsXv4SJm56fPbE1CJnNualDQQE2zzcTz?=
 =?us-ascii?Q?02HdeOsyZxNHLkrb1rgq2O0cq0w1Ziq2/4JkXjhBT0XvcNp5K1XuXAUavZDP?=
 =?us-ascii?Q?qO0GvNzrMM7K3/EqH11uR7KJ+UePk9v7WEbm8+vDoXRlEYffcLC70g1m0lbX?=
 =?us-ascii?Q?aKzc6YVl2bzqiRSBohm2mtcMxcwduChkB4BrJp6mOeGfHX4eU/44YvCuunZX?=
 =?us-ascii?Q?XIFAX5N3O2PYQlW54KIj6bfzHkg8R1EMxMflROOGi93eRsh1y01sKa7QRH30?=
 =?us-ascii?Q?WnLuYIDzeYWLx1YLUdZyMw1Zm1mxWNSLxQjmsn8oe13otDlQ5hqhWe5keYKu?=
 =?us-ascii?Q?PQyDAt6eey0GWp1/PTArSl6BFnxAqVcX7SqHX31H+UUf7E+/OakQi2cSRnx7?=
 =?us-ascii?Q?hfLBGyR0IgEstxQ14Upml3DVLwZ30nGSGJctt7ba6GdeGWkdHvk//d/CLE5A?=
 =?us-ascii?Q?XVblBG+H9ijRslZzYbuADjQb3US1MFuaGXwyhVemWL7wF/YlZE+sGlJNfiNh?=
 =?us-ascii?Q?jjCflk+enHFMZzWMQFoZ+MLo8S6+ECel/vxfRgAV2oSzOHqlv5gGMCTdfQGE?=
 =?us-ascii?Q?tUfQa7nQzLs3uChfvARc1jRhDmRKAHXUgCjnBWlE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91765e0e-5db4-41e6-6210-08dc3e510d4e
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 02:48:21.7912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dz2L0gi2kRbIpCJqmF/vED9x3D56+lsbSvqcjv9DfVGMNNc8ArQsYZAhq0IwdG7SA7puw8ApxiKPRqHdHT81qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8022

The user can set event and counter in cmdline and the driver need to parse
it using 'config' attr value. This will add macro definitions to avoid
hard-code in driver.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v4:
 - new patch
Changes in v5:
 - move this patch earlier
---
 drivers/perf/fsl_imx9_ddr_perf.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 2cd5bcf1d3d1..35e422083948 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -42,6 +42,11 @@
 #define NUM_COUNTERS		11
 #define CYCLES_COUNTER		0
 
+#define CONFIG_EVENT_MASK	0x00FF
+#define CONFIG_EVENT_OFFSET	0
+#define CONFIG_COUNTER_MASK	0xFF00
+#define CONFIG_COUNTER_OFFSET	8
+
 #define to_ddr_pmu(p)		container_of(p, struct ddr_pmu, pmu)
 
 #define DDR_PERF_DEV_NAME	"imx9_ddr"
@@ -361,8 +366,10 @@ static void ddr_perf_counter_local_config(struct ddr_pmu *pmu, int config,
 				    int counter, bool enable)
 {
 	u32 ctrl_a;
+	int event;
 
 	ctrl_a = readl_relaxed(pmu->base + PMLCA(counter));
+	event = (config & CONFIG_EVENT_MASK) >> CONFIG_EVENT_OFFSET;
 
 	if (enable) {
 		ctrl_a |= PMLCA_FC;
@@ -374,7 +381,7 @@ static void ddr_perf_counter_local_config(struct ddr_pmu *pmu, int config,
 		ctrl_a &= ~PMLCA_FC;
 		ctrl_a |= PMLCA_CE;
 		ctrl_a &= ~FIELD_PREP(PMLCA_EVENT, 0x7F);
-		ctrl_a |= FIELD_PREP(PMLCA_EVENT, (config & 0x000000FF));
+		ctrl_a |= FIELD_PREP(PMLCA_EVENT, event);
 		writel(ctrl_a, pmu->base + PMLCA(counter));
 	} else {
 		/* Freeze counter. */
@@ -388,8 +395,8 @@ static void imx93_ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1
 	u32 pmcfg1, pmcfg2;
 	int event, counter;
 
-	event = cfg & 0x000000FF;
-	counter = (cfg & 0x0000FF00) >> 8;
+	event = (cfg & CONFIG_EVENT_MASK) >> CONFIG_EVENT_OFFSET;
+	counter = (cfg & CONFIG_COUNTER_MASK) >> CONFIG_COUNTER_OFFSET;
 
 	pmcfg1 = readl_relaxed(pmu->base + PMCFG1);
 
@@ -491,7 +498,7 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
 	int cfg2 = event->attr.config2;
 	int counter;
 
-	counter = (cfg & 0x0000FF00) >> 8;
+	counter = (cfg & CONFIG_COUNTER_MASK) >> CONFIG_COUNTER_OFFSET;
 
 	pmu->events[counter] = event;
 	pmu->active_events++;
-- 
2.34.1


