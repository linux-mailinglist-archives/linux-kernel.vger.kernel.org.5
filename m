Return-Path: <linux-kernel+bounces-94888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D32EB874658
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BE221F24199
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35C31BF2F;
	Thu,  7 Mar 2024 02:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cyw5IXcn"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2058.outbound.protection.outlook.com [40.107.7.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A421BDF4;
	Thu,  7 Mar 2024 02:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709779720; cv=fail; b=KVo6hK29VLK0jU6cAaSWAkiyMKyIidJIUZn9UGR1bGc0x30dRCDZT8GelVLFCn5rV2rYBrjXi99dAXMtan858ATbXD9qztKpH3aDSdDLSjfAYfPEoWwXaQErIxaojrPKx11Zrlu7rzQhbHUhFIjjMLFZ0PEi69LOdBXf18Worxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709779720; c=relaxed/simple;
	bh=WvqiiiORTTzYwjNlz9fmB7grL5ENdEx5oz9tZVhasx8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LO3LjlC9U7vCWykD0sSYKxpWfVFwww60aJtvXTY2Qh5tnz6jSDu+R4pGCH3LrEW6o5GC1deqsA7b+bGhh656BXwtuqTsZo4dQR2Yd3itYVp8OG6OoxoBF6+jic1IymO+/qVe9ZZedC0qtC0DmwylLtM7piyAibYK0cJNXey0IQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Cyw5IXcn; arc=fail smtp.client-ip=40.107.7.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHxvCLlwcxiun+Wn+FHPWZhaibjpZ2jzXxV3z6HwBfzf8+TQSKCawyF3o5LFUwuvjlHNbBho4zzdyhJrNWiDU5cI2saVWo2zAusERNue3SKSv0/uTB3EunFM1DY+prJ3vutSTsdOC24crrNSVwhDSKoHLvGt2lrF8gztDdIgXjnFZQ2GouPlP2Dmiloi7HwlpZDx598IvlDhI00ILOmSFVfZi+DWKLA5q0F0djrEnwFv6lw0HfeeElWujL/ORIZDVmfRkTl9WYZs3/yvSx2CTTcMNknFMgO+X+6ay6I53PEb07L+Q7bm1Zx3x8Jls37ANawKpgkeW790wg+6fRy4lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7M79/0HHkY19uCUfaVW/Jw9qmF8Jv/I+pmHhBdAOois=;
 b=K7a3tjGTySGeAKvS3ySZzd4CS/JBJD31xZ4VC9CZqdWfXNsDt91M+91KnnrCGWdYTk42HqqeiNnskWS8ut09m9xzf5ipnAFrSlhFV9Mp0Gchn3ze1MGMXKT2yWs/kWpzQ2X284oUgQwOL2wnxnkFQNhkiH6aiXnA/eMwqNqyIoeEbNLEnm3oTUeq0WwNmBgeiVZiVqP2AQLcoBrvNRpOkz5oWHtM0axIXQn3mmXZXMVXPZk3HX1IpxXab+F4PHHjZjKX0tr8gyIREwFLYfICjWGNEZKemRlMzSZ/MQB8AsD5nbs5vNWLnjOe7egNt1SFTf+zSGprDaDVTLhH7e6E0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7M79/0HHkY19uCUfaVW/Jw9qmF8Jv/I+pmHhBdAOois=;
 b=Cyw5IXcnrGYWc+131u/GXswfUQmy9bQUklJ29gOj6T6cxshjC/5+2y3sOsyQo+QQJAIMZtXWv8AeUDnwaATdx2LHI+1d6iVLGKkDoCfYT3Hwn6i0EfBAaCpWXBLUasrLnq39jKJESeMg/DwWTFcUk3Qq8VDaq7ruKA7TC2T+qvE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB8022.eurprd04.prod.outlook.com (2603:10a6:20b:28a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Thu, 7 Mar
 2024 02:48:35 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7339.035; Thu, 7 Mar 2024
 02:48:35 +0000
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
Subject: [PATCH v5 6/7] perf: imx_perf: limit counter ID from user space and optimize counter usage
Date: Thu,  7 Mar 2024 10:47:53 +0800
Message-Id: <20240307024754.3469810-6-xu.yang_2@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 853ae16e-5bf8-405b-a1be-08dc3e511583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wuUfUVGe/orPlHN5D132NA4VBZu/CtIGtbG6U2gl7VOQ+ZmVpUJh841INLm/GCui/Ypb5Cf5tK4oOKVP0/7V9TPoMfodcFh/xrB4devtt3OUUXROrpG8NvHLzwx8YWbrKn68woCjl1r4dlRnpnnmFJmb18U0qgv3n99FHYQaa1gGY2SIIKcSM03fI4LFw+rVtVWVcXeCkEnTdjdeKKqzg1MM2oYGipDm/d7RO9wq1wasGOUHVVH9nLYiVTkMdc1aLIhcx1gRDqdRC6NXj6DvQnu0cx35wItcHKi7yK4+5/O4NomzKxA5PgrKefHWLdlutT3c7rkVKxoO2W3XVSe3wj7LErFBL2z2rSY5v9Ot9h4v4i1Mp68oUHrq6Bu4loMJPkJ2S1J6rh6KTIeebMsoHfqbqhHEQQy3GYAN/ddJaBKgYd/gupRNdvI/McPn+JUtJaOZSI7jf/iHEnAK6A8E30KiwYQUAP2CUwi2PNpPNDAwU8tV4DuRz3yJW16XBhIg+QSiFl8VAjIEsUa1+c3eU8knNNjph1pk1RC+tgVk93KXtrcVkM9jVa3dcQyxL2Z0PxAp3whWJTYkFLWkfSUyRDnEmtzEvWSgfgn4UgvazAolyHEzsN633LXUg0Sop8WxSLhSd3C/pJ9WqQrwvSCbHnZflCO/XcYfcy95y0vwF2hrnSyLvgo6I/LlRK5IIVA2IyvFulIwEFVQreOa2xw4Xtk2u78lreU9n+T4LKKe9CY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SR1aj2xQk6XOJg/YWKpGnBIJpTO4qiBRi6Ubg7S9G+uff2yOvrdvoigoRKFf?=
 =?us-ascii?Q?nEqEEpB9B9QrE6I811G+QmNUqOrWXI3lWqI/Hi0Fkxj7LvY6Ft5lYS/u8Ovy?=
 =?us-ascii?Q?1zD5ipQSRf3JgDKue3UdJv3CUIbJPWCuYSYzaJh+ZbEBrBz7I8rvr/7hLXDd?=
 =?us-ascii?Q?vV/3kUyB4+ZXsAslZHmjZUjT1tY/et9jzuwOhmv8KEk7Onh9XGXfgnj+a5Q+?=
 =?us-ascii?Q?rIXAIjEDrzLVu1B+bUAOAMCsCGWYCfL/q5+ANSaWjKpWjRIrYb9wEmvqx/0s?=
 =?us-ascii?Q?FAAgb+fDR8p/m9JI5/8cf+oLuoTdJsswMgrLwfAFsfR2SdqqD4klzFVkcqHL?=
 =?us-ascii?Q?YQRUnn+y41vpdb+FDPjX6vuzCRYp34wxD4VHKUXuENdhu02wFNKu6wzRo3nd?=
 =?us-ascii?Q?hO/k12Rl1bFIEDphRlLXj+RXx87Bu3L+WoQ1Z1OjDMvMms6TyUnlCrD2gmdL?=
 =?us-ascii?Q?3TPFsUnBmYwn0uYdmhU/8NEmlX/CfqoMThhoEmDzP6fu/e4cp/Gl26HYla7n?=
 =?us-ascii?Q?GcqSl5kTt0hErGLD68agvQw79wePBKa09ClQWmpoKNGsT62xKmX26O9uYbO6?=
 =?us-ascii?Q?zAYZiGeM/73gqhIW3Lr6yu7ci3b19trUVZFuGYK/cJwgZQezx3O6N5hpTJV5?=
 =?us-ascii?Q?vVahptqsUzlusPZLLrNKIwgZaNYu5jENdmuAHowfRBd7FnoaaKZRRyEHA7iW?=
 =?us-ascii?Q?4vv8jGi/hIi4p1voZi4zz1YK+3uDySQcRwsXEWoIxii6vPMg8wV3k6jgWuXD?=
 =?us-ascii?Q?MosCEUpuqvlhlb9/x2oVuSnI3C4RNEOAMqKfbmLZpNHt9kxrc0koRxlUbdSh?=
 =?us-ascii?Q?73xZTi/OXSUnVfEAZ9L6Z0Ngfss9VZh3Cd+VuS4Txti+mx50R1vU/opuuE2b?=
 =?us-ascii?Q?QJI+JFAmTiZN90JqHVFHSu+zxWL9ZHN+fI5Hxjjp9zynG17/bk4WIrB8fgPM?=
 =?us-ascii?Q?VMBDikNGzMrg1IVAr5Mgi644K8DYngj/5p2BL8pTV2AWioRl1nsNrebr6pOF?=
 =?us-ascii?Q?6RnJEKHqB+D+uAfuJ7DuiPSI4NRKrLexDnJQdqCC/lKriiYq/WOx1LDh90tf?=
 =?us-ascii?Q?5mSQyyU76jFEOnG0Wqv+scaRfd9ZforOR/ggdizQUfuKGgcPAdz/h6//60rp?=
 =?us-ascii?Q?QiKHkPvMjNRGQJXkWFu8AIRmXhNpLfssPxOla0nHG0KAF1OyspFyB/cKb7F9?=
 =?us-ascii?Q?3IlVwN3/RypftvtIYCIRglJTwb/qAUWMdIBf2sDJgZaNBEKOiklNAp6RDl1R?=
 =?us-ascii?Q?dpp5ByfWwLJeiIvOuZh+9eTb57tiIsOgTrSVw3UZ+O2ygEu11SkYqipK//Zw?=
 =?us-ascii?Q?K0tOMkbEKmYtEbMXiYag4KH8zgIVF/+TF7B+/akjTtZ6GVw718vAo+gllNrZ?=
 =?us-ascii?Q?s5JQu+JfSQk37fFMuDcH/A5ALnSJ2QAcxyF4fRW8+DNZaysjPPh5nFQo6+kF?=
 =?us-ascii?Q?QWuUVBWDYP7hNOY//eJ1JFxKhWCxmYrTUef73QixBV7J4cfIjDevBXRRF1o3?=
 =?us-ascii?Q?r7HO2y4TnMNsJSGzK+sd0NYnF5FNaaCy55DzDSwZr+5MfMPVnt8zBsXbgkIY?=
 =?us-ascii?Q?JbVebUjIghMthT+6PCIA58F3owOoWPPQAZzqInVe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 853ae16e-5bf8-405b-a1be-08dc3e511583
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 02:48:35.5993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ino6kFf8ig9qMaa7yYumW/VNaMFDGZrbSXXZ21jPX8brMGxFbQ4K8sEMerjU/irzayxIMOZhoZc/itmjTJWE+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8022

The user can pass any counter ID to perf app. However, current pmu driver
doesn't judge the validity of the counter ID. This will add necessary
check for counter ID from user space. Besides, this pmu has 10 counters
except cycle counter which can be used to count reference events and
counter specific evnets. This will also add supports to auto allocate
counter if the user doesn't pass it the perf. Then, the usage of counter
will be optimized.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - limit counter ID from user to 0-10
 - combine dynamic and static allocation of counter
Changes in v3:
 - no changes
Changes in v4:
 - rename ddr_perf_is_specific_event()
 - use macro definitions to parse config attr
Changes in v5:
 - improve ddr_perf_is_counter_specific_event()
---
 drivers/perf/fsl_imx9_ddr_perf.c | 69 +++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index f25f55126004..0ac680ee2505 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -51,6 +51,7 @@
 
 #define NUM_COUNTERS		11
 #define CYCLES_COUNTER		0
+#define CYCLES_EVENT_ID		0
 
 #define CONFIG_EVENT_MASK	0x00FF
 #define CONFIG_EVENT_OFFSET	0
@@ -271,6 +272,16 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	NULL,
 };
 
+/*
+ * An event is either reference evnet or counter specific event.
+ * For counter specific event, the event count will only be incremented
+ * on the corresponding counter.
+ */
+static bool ddr_perf_is_counter_specific_event(int event)
+{
+	return event >= 64 && event <= 73;
+}
+
 static umode_t
 ddr_perf_events_attrs_is_visible(struct kobject *kobj,
 				       struct attribute *attr, int unused)
@@ -529,6 +540,7 @@ static int ddr_perf_event_init(struct perf_event *event)
 	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
 	struct perf_event *sibling;
+	int event_id, counter;
 
 	if (event->attr.type != event->pmu->type)
 		return -ENOENT;
@@ -541,6 +553,18 @@ static int ddr_perf_event_init(struct perf_event *event)
 		return -EOPNOTSUPP;
 	}
 
+	counter = (event->attr.config & CONFIG_COUNTER_MASK) >> CONFIG_COUNTER_OFFSET;
+	if (counter > NUM_COUNTERS) {
+		dev_warn(pmu->dev, "Only counter 0-10 is supported!\n");
+		return -EINVAL;
+	}
+
+	event_id = (event->attr.config & CONFIG_EVENT_MASK) >> CONFIG_EVENT_OFFSET;
+	if (ddr_perf_is_counter_specific_event(event_id) && counter == 0) {
+		dev_err(pmu->dev, "Need specify counter for counter specific events!\n");
+		return -EINVAL;
+	}
+
 	/*
 	 * We must NOT create groups containing mixed PMUs, although software
 	 * events are acceptable (for example to create a CCN group
@@ -574,6 +598,39 @@ static void ddr_perf_event_start(struct perf_event *event, int flags)
 	hwc->state = 0;
 }
 
+static int ddr_perf_alloc_counter(struct ddr_pmu *pmu, int event, int counter)
+{
+	int i;
+
+	if (event == CYCLES_EVENT_ID) {
+		/*
+		 * Always map cycle event to counter 0.
+		 * Cycles counter is dedicated for cycle event
+		 * can't used for the other counters.
+		 */
+		if (pmu->events[CYCLES_COUNTER] == NULL)
+			return CYCLES_COUNTER;
+	} else if (counter != 0) {
+		/*
+		 * 1. ddr_perf_event_init() will make sure counter
+		 *    is not 0 for counter specific events.
+		 * 2. Allow specify counter for referene event too.
+		 */
+		if (pmu->events[counter] == NULL)
+			return counter;
+	} else {
+		/*
+		 * Counter may be 0 if user doesn't specify it.
+		 * Auto allocate counter for referene event.
+		 */
+		for (i = 1; i < NUM_COUNTERS; i++)
+			if (pmu->events[i] == NULL)
+				return i;
+	}
+
+	return -ENOENT;
+}
+
 static int ddr_perf_event_add(struct perf_event *event, int flags)
 {
 	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
@@ -581,10 +638,18 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
 	int cfg = event->attr.config;
 	int cfg1 = event->attr.config1;
 	int cfg2 = event->attr.config2;
-	int counter;
+	int event_id, counter;
 
+	event_id = (cfg & CONFIG_EVENT_MASK) >> CONFIG_EVENT_OFFSET;
 	counter = (cfg & CONFIG_COUNTER_MASK) >> CONFIG_COUNTER_OFFSET;
 
+	/* check if counter is available or needs to allocate one */
+	counter = ddr_perf_alloc_counter(pmu, event_id, counter);
+	if (counter < 0) {
+		dev_dbg(pmu->dev, "There are not enough counters\n");
+		return -EOPNOTSUPP;
+	}
+
 	pmu->events[counter] = event;
 	pmu->active_events++;
 	hwc->idx = counter;
@@ -620,9 +685,11 @@ static void ddr_perf_event_del(struct perf_event *event, int flags)
 {
 	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
+	int counter = hwc->idx;
 
 	ddr_perf_event_stop(event, PERF_EF_UPDATE);
 
+	pmu->events[counter] = NULL;
 	pmu->active_events--;
 	hwc->idx = -1;
 }
-- 
2.34.1


