Return-Path: <linux-kernel+bounces-144567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3DC8A47D6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89C361F221EA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975F31BF53;
	Mon, 15 Apr 2024 06:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HZEqL4rd"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2042.outbound.protection.outlook.com [40.107.7.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF29C14A84;
	Mon, 15 Apr 2024 06:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713161576; cv=fail; b=H3MAT+Y9OjgIJZCFjv07VhfAeRK+6j++lEaNelqoqjGsqBi99L+n3cpFtgzB590Q/oxilbjVyLs9RGP/8V1yvCgkoLM/2UBjrGgDHP0vS+R7sAp2J/6TL+w1d7WlvBMieg4m7aivJaKgbrgZOkMpt6K2Q9WggOrVzF1zkdqbVUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713161576; c=relaxed/simple;
	bh=onDsI+fqx/HrS2qaDF+etO8lFHjSae0iy8BoQIPqWgo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t564UPDjrQ1D1cD1eoWDtHAfqd6wjfyTvSWIFiL1oXbS6mQfLB+CoZLG5g2AJ14W3kDeuPj1XXygNQC6pV5UMba122aQUX9alSbtVxFV3AG7efKvF6JIHV9I5t0d+CocSF3sZpJqoUilMDEkJfG9p6JX+9Ob8SZjtH4EnouyLXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=HZEqL4rd; arc=fail smtp.client-ip=40.107.7.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZHrocj1mZBSMidngHDT6W6Q8kgXUbYqfXdd5q/vwZTQ4ag80aFgvvQAbq6VukHjiiLgwikrKE2v/iUU6/D1vviB39kDBCVFZHlBYcLaUrgUAKXiKSdEmVzpTi7Vl0Znd1++vxclUK4tGTksVyrnLGQENDx99IBUSXfkiuKQ8X2X0Mm++9M8ss4nxTWWoxj0+T5J4BSorfJ9WsiUIdElHfbXqBPI6FRz6Bf3w5Acb6cz82Dy16yV+1Wrvy9mGPGGNEy7UipO2TfE/CUlBNDjRSqISIieUdIMaLKzoOuFm352lrfDhf8sA/sEQ8XC2oQZKCyTMXhD/KGfXVo9zHBZnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0sQMBBuEKcx/Sd309ts8fBYek5hfFfQdxYIqFsmDtE=;
 b=C4v0nrjNt6Ze0kHYJY6N/4xpLnJ8sAM5onKli3iJz1DtqF59oPslcX3UUILPXxGXGeBD8HgzCzJ/zKUuYMriUB4RFtQ6UhDFEvEAi1FCzHvnxaqUTYH47KOHFKIHoyLvb2wOn6PMyhsMkm5SiH5ExkwFUYs8bUQiV+Dn3I6p35dasS3Wjj/ERLQqvNmcMrNDUaNuamkH8JCau3cwhju45Stl0KMprreVV4oqWR//xjGVpu0ZSUlrSEfMAmyFxlQu9DjdXg3SJLP34wCmciYa4z20h1Ix8Dg4ePMLdthvSE6TLQS5isHexeDdqVafUXaOmJF59MbHnni5f/cYhYcGfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0sQMBBuEKcx/Sd309ts8fBYek5hfFfQdxYIqFsmDtE=;
 b=HZEqL4rdvIB5sUaSlLevr7Tp7L+GqWNTQqv8Goa1OraM64xgbqHnJ25rUuf6oEsfJLuPdbca7lgUUdGp+eUuJZLG7I6mKnnohdyrVD21aipsA2H7JrF62A1UIKieI0PApan9KoJfzvz4TFjROesu6fEaZSH0kTb5RIjyQIwzG80=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by PA1PR04MB10117.eurprd04.prod.outlook.com (2603:10a6:102:454::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.43; Mon, 15 Apr
 2024 06:12:52 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f%6]) with mapi id 15.20.7452.046; Mon, 15 Apr 2024
 06:12:52 +0000
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
Subject: [PATCH v10 2/8] perf: imx_perf: add macro definitions for parsing config attr
Date: Mon, 15 Apr 2024 14:13:14 +0800
Message-Id: <20240415061320.3948707-2-xu.yang_2@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e7171888-a8ea-44a8-4fb7-08dc5d131517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OC7c622b+lL8gWo0ozVqRVFFrO0l5Q1GdKe4hCJAYQoEFYzU1BKPPCGbIYlwRw8qaXhzKImGKtskHRVSrVVMe50MwJUqj6UbC8wwo6KCz62krYCQXEwjJuXo2DYhza4avZTD9Unyci2enSgBnYtSthnAszsHwVE0y4drtsCMDZ2gP75wAE0DbUZv0uKXpPWSIrIbR6mXuMehv9f7W50VFNUUx6imc6F4DQud/1Fls2VqsfvJiy6HkMxAIhgtrbmJoe1cbP/sOEYYkggqArMqNP+nQpcpLqilNBwjv4UP5hIAYUcLZDFp8y6/WYtNrztVwnyziF4T72QQkm6fZS81Ktw6QMiEzO3+uGw4d8DM6LyAh/jdK35Ovq+7hSVREP6AotumxtcZ6Ai7E3OEpTB+nOpSXtGYVOV1KRoZzF0+1jx4kP8n5OIIInpy1ODj+d3Lm3mRyWb/f53UV0ufJXz9niU8EQ20g4rJwP9EyCogEm0HgxN1oWLGhj8zmarkFYb1TAWpJkji9KVi/+koEloLm63rSSAe2hLhY6GSv7sBPsItsCbxFSkIsV0MW6Rs98iwSAOypxq89VypHQXPUjAUKyE7CdPHMBVCGeriohiVlOQCEwX4XSxWCYurhNulx9mknRf5jlkvnTiXnTO/6kE261/+b3ULrXVf6r5PIzri2UJfghHRvfDtu/bslOsXThIUDG4QxZvye4BYKqmPOtHH90HtPz5H1se9mLPpm37v2lY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(7416005)(1800799015)(366007)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fsIP6F84A7H9ylWITCzHLn6m5zV28GO3PWUlbvqw9a6sh6n9ozmwvmwBilB/?=
 =?us-ascii?Q?KkqBZbKnnSYRclcwlv8mfmUSsT6wPVnW5aFzGzoXoaJ7L8gPuYktwT2jem62?=
 =?us-ascii?Q?o80tw9vI631uIGV7bqljoZgCNOV0X5U5eEhaH9gPPEGYgCFOE7McJm9wQjph?=
 =?us-ascii?Q?ZX0pRUChGZh/kLWIJS0Cu4REkFWpjzpvPhnVMnPmR03/AQbypVllAxfL86Bq?=
 =?us-ascii?Q?TLm5JaWvzBDrn2tO8jiH1lHnyCr9iFjXGerqpAaeV/EHtEhSeItJt7wi/ckR?=
 =?us-ascii?Q?26+jO3EWDsPYunhotb/2zO0acivTmW03pBWD4P7Jvt885CLSQlXI8gYTe5We?=
 =?us-ascii?Q?pRhhodaPc9sfCM/D//IgRWj/Kp+6xiwOwzsRKqLLaH1eTNI7ljcImK5x9cZ1?=
 =?us-ascii?Q?YezV2q3UySvMDqSrzaWGRtEl0r2ICd+/6L72uX6GHgnWPbGWN1CbUAbnAFkf?=
 =?us-ascii?Q?vq4HFKi0rMWZqEryiuCmgJGji+Ayiool4DC3+ghe1LugERIOb9Z7uqEnUhar?=
 =?us-ascii?Q?5kYCQ59srmEu5ks2W/gWQYO2JlouZorWHuwxRf1eEABNiM2BTEyYg4xxwzEn?=
 =?us-ascii?Q?4GzYYCV8ISdwJjAnJCcl5udk7uisAXGhyhxEB20qc74TfnNYNaFMk0jG5Ybu?=
 =?us-ascii?Q?GevCPRY23fh9iarLW6M/WYACtKBOKr5UThlBYK+Ss16/Tl0tCWz/VQH5Ut9T?=
 =?us-ascii?Q?AH7k51GHf44C02ifSdaYhIyPwtCOIieJBPHgldJknIKTRSsEu0WuP+gNVpAO?=
 =?us-ascii?Q?o4XsYWZMyZRbpT3PvdPg8fueU3gMENGxppDwShTKxLPK3a1ko/Qs2IdWPz38?=
 =?us-ascii?Q?y3zCl8SjpqMeGDfJtH1KVVtFvKiOp38TFgeQUpfa7AI00NrFO2nybDVwc0eG?=
 =?us-ascii?Q?Z8/NIKCWjHoOr5oqwShO/dkwIgpl6GQW6BYvhMVc59ybKnEtRIMHMYmhOwAF?=
 =?us-ascii?Q?OcOB5Z+B3HLw83Ma9AcVKi+FSXYVE0EfpOeQ9JxYoHuPS7bCQGC8+R2sqXcF?=
 =?us-ascii?Q?Qq4rRbsT+1AuYnUOOAb7gQhXwyQCd9dQuT9q+iQb/++GlqzGWZNSi0PQw8b2?=
 =?us-ascii?Q?yhMdCrw2/kUsu6tqelp3zcp2JUFLcABJVZZ/KpsoOuFtpgcci/wjAmkxWeR4?=
 =?us-ascii?Q?iC/yNmg1SAzT/zrEhOZqC2GR1Pfi19MFRvaOrcNpmCdjM++bvlJruUvP0lg5?=
 =?us-ascii?Q?zsEmtLqfHxOvlOm4k5Qo+BngyKuRp7zi4TrkwpgtB3nriZztD27WYK/yA6a4?=
 =?us-ascii?Q?fgeEymFuBMOxF9AQf4O5BBeqBn2PVINiQ/bkjEOruQllqyswt2pv4Q0BFltY?=
 =?us-ascii?Q?TGp4O6OQ7irrTwrWYmaLtEgQT/p0FSuVaqoCPjXip2ULum7oehn0xY9mwzeX?=
 =?us-ascii?Q?9abxK07IPdwWXN8RYQhwZXmoxASt2/+EzXSafUrrTZ3oJDzzXTP8R3Xqc/LE?=
 =?us-ascii?Q?dJY9NpHQAVql8Aw41XjOxmflxr2SF+nc3MjBC9u7GiqqVtvYHEgjcHKZwv+1?=
 =?us-ascii?Q?KSIk194NNFRURNiaGhCNKiOxxActdFNQMgzABRq1hmMiNIzv8KbQoTmypTmj?=
 =?us-ascii?Q?dWlh/Hikr/rIjZHwaPKgXxXHSgYuvEg1XZBsN53Q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7171888-a8ea-44a8-4fb7-08dc5d131517
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 06:12:52.1420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l372IqxOrdMejBN7y3BrLbOyB7xS2Jwuo6kGNEtClp36v9R0V4SgCRntvxaXBoOnc+RL/yvXFnm6RDj7yvB7rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10117

The user can set event and counter in cmdline and the driver need to parse
it using 'config' attr value. This will add macro definitions to avoid
hard-code in driver.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v4:
 - new patch
Changes in v5:
 - move this patch earlier
Changes in v6:
 - no changes
Changes in v7:
 - use FIELD_*
Changes in v8:
 - add Rb tag
Changes in v9:
 - add Rb tag
Changes in v10:
 - no changes
---
 drivers/perf/fsl_imx9_ddr_perf.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 72c2d3074cde..0017f2c9ef91 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -42,6 +42,9 @@
 #define NUM_COUNTERS		11
 #define CYCLES_COUNTER		0
 
+#define CONFIG_EVENT		GENMASK(7, 0)
+#define CONFIG_COUNTER		GENMASK(15, 8)
+
 #define to_ddr_pmu(p)		container_of(p, struct ddr_pmu, pmu)
 
 #define DDR_PERF_DEV_NAME	"imx9_ddr"
@@ -339,8 +342,10 @@ static void ddr_perf_counter_local_config(struct ddr_pmu *pmu, int config,
 				    int counter, bool enable)
 {
 	u32 ctrl_a;
+	int event;
 
 	ctrl_a = readl_relaxed(pmu->base + PMLCA(counter));
+	event = FIELD_GET(CONFIG_EVENT, config);
 
 	if (enable) {
 		ctrl_a |= PMLCA_FC;
@@ -352,7 +357,7 @@ static void ddr_perf_counter_local_config(struct ddr_pmu *pmu, int config,
 		ctrl_a &= ~PMLCA_FC;
 		ctrl_a |= PMLCA_CE;
 		ctrl_a &= ~FIELD_PREP(PMLCA_EVENT, 0x7F);
-		ctrl_a |= FIELD_PREP(PMLCA_EVENT, (config & 0x000000FF));
+		ctrl_a |= FIELD_PREP(PMLCA_EVENT, event);
 		writel(ctrl_a, pmu->base + PMLCA(counter));
 	} else {
 		/* Freeze counter. */
@@ -366,8 +371,8 @@ static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1, int
 	u32 pmcfg1, pmcfg2;
 	int event, counter;
 
-	event = cfg & 0x000000FF;
-	counter = (cfg & 0x0000FF00) >> 8;
+	event = FIELD_GET(CONFIG_EVENT, cfg);
+	counter = FIELD_GET(CONFIG_COUNTER, cfg);
 
 	pmcfg1 = readl_relaxed(pmu->base + PMCFG1);
 
@@ -469,7 +474,7 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
 	int cfg2 = event->attr.config2;
 	int counter;
 
-	counter = (cfg & 0x0000FF00) >> 8;
+	counter = FIELD_GET(CONFIG_COUNTER, cfg);
 
 	pmu->events[counter] = event;
 	pmu->active_events++;
-- 
2.34.1


