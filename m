Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E14809E92
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 09:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbjLHIsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 03:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235792AbjLHIsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 03:48:35 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2056.outbound.protection.outlook.com [40.107.22.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B621729;
        Fri,  8 Dec 2023 00:48:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCvtCnLCjbCQ1laN/2eBRWXptPMdXdT4iJiyiQUdMn4LKAEqHFIla4fGiLg+9DnLIAKqW+25FP9rdpxYTZllbw7lgcsh4aCK7mBh2AdiINI0xu4n3vA5nkSbwMXOL7CLpqTC9XxAxKw388aSaMI7BYiT3Tw2vUXvQT9vnB3QbIwbQifatdErG/N/wjXBkfqio6j5hEiZkWiHqa4yX9ji89q81fopmPWE4HWA1xnKX0Obrd5+9L9fK3/jVAjVLeaFWGAgLd/bJrxTHzTfmJZei4jY+37hBhDycKEjxCtBuFcHR32zZvbTxIFQt3E4rfoK7VMrNJKEVPD0xufnKDCWwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFBZHsab9jbLWpB5XbV3fvEvBgPEcCvWq+mjz8QO5Go=;
 b=ign/kwJP/WMrebqeBevkzZxyhLhij19khh6rRB8cCF9d+ywQ0SKebaqAteaVUaZyuMxO7btyI+pt6TeyVURlY+7uRAt4fNqVaBGqHrjT6BKww588pqXr+hKVS3eNAX5ZrpYNvIStj9XU4T05skpVGAkC5iazKCy6cViDQ3TpmwOyVKfQE394aj4aeg1EPCWxxdvlwWsro/GnVLOwsTeZadOnNkebsqBy7Oh1CldEH5zP0LgGQMExWPly4Yg+uahxdWCuvS1XXLlo/vmbNwxd2vjGkfgBGFjgiIOfrnIG2OW3VJTI41KjcbTFu8A08WKjfSIs51rBRKXeiWFUq6h3QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFBZHsab9jbLWpB5XbV3fvEvBgPEcCvWq+mjz8QO5Go=;
 b=bC7+/kymUF58kfyDOEOsygDAljJqpVv7PJ93nqB/Q/efpp+Sul/N1NjJiKX+08etzPJJNABBIXm5WupUcRNgoU1TNi8mIwWiRZMRGcjcfy5/E2UB4iAAx6fdhrK7HPB98eS4PeZ2ZEM7q5RKlEzbdeo6D95/rr7NTKgwCA2SNgU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB5146.eurprd04.prod.outlook.com (2603:10a6:10:23::16)
 by VI1PR04MB9978.eurprd04.prod.outlook.com (2603:10a6:800:1d7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 08:48:36 +0000
Received: from DB7PR04MB5146.eurprd04.prod.outlook.com
 ([fe80::709e:6876:7df0:fc30]) by DB7PR04MB5146.eurprd04.prod.outlook.com
 ([fe80::709e:6876:7df0:fc30%7]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 08:48:35 +0000
From:   Xu Yang <xu.yang_2@nxp.com>
To:     Frank.li@nxp.com, will@kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, john.g.garry@oracle.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com
Cc:     linux-imx@nxp.com, mike.leach@linaro.org, leo.yan@linaro.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        xu.yang_2@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH v2 3/4] perf: imx_perf: limit counter ID from user space and optimize counter usage
Date:   Fri,  8 Dec 2023 16:54:01 +0800
Message-Id: <20231208085402.2106904-3-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208085402.2106904-1-xu.yang_2@nxp.com>
References: <20231208085402.2106904-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To DB7PR04MB5146.eurprd04.prod.outlook.com
 (2603:10a6:10:23::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB5146:EE_|VI1PR04MB9978:EE_
X-MS-Office365-Filtering-Correlation-Id: 88d624ef-c103-4ace-955e-08dbf7ca76fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4DUyGOQRMnTmWFFhluIeDNyZXEE/5lEs8fbBR8zzLuE+T0WeOkYbtAB1eLNPwXGcZK3gqvclice6mNDou0JXlkvQKL/ipLliTdhSko2Ol0GkBaJwz09+vxD/ahnKI0ldgApoB0ePU0AaifWeju3cryrDQpBedoqDUIMqiZiJMjP6LCVvOJmUtWJqHMZCIpkfDmO/2MouxID8sxR158LFjeSqaB8yk3VXRXwK7mcicQFVnDrTipQm3BsRISWXW2AxYpQENwGhByzoNTBu+RodofEU8Be932mhX9VzQHplNnNI0MtIM+KVHJfr3hM1bGvP9XptKNAEr69LZ88vaGG4TsI7S33wtiQnnT6OVMvPq4XZ/SXzt8Q0Cw2oRNM+50GuQJiofOK/3YJns1M4Qw5ZQKjR5xHcaOjKHCHjbDMUVRWNhe5zY7QoGnqG1pPDhffe+yMoIdE/cYyHdU1+6tsmVlefYn6sjgjquDdXQnQeCchl2EvmZTZVFaR1+VnK4VxTignEhfAOwqgrHFyaxl/R25hPFKI0F09zsLoMDJRD9IwIzs1UynWzVC34kAtyqdQ/z/YWWwDO7kryx5RdNZwNwxDwB0BZTerXrV9nFBA2xGJ9NdbMT+lGdF3v2i8qNqcKBsIy1f1LQw8ivMh5eYWtOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5146.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(2616005)(6512007)(6506007)(1076003)(83380400001)(26005)(8676002)(5660300002)(4326008)(2906002)(41300700001)(7416002)(36756003)(8936002)(66946007)(66476007)(316002)(86362001)(66556008)(38350700005)(6666004)(921008)(52116002)(6486002)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FH4Pn6NTjskZ6yh3MNckAJVya35rpRyjgjJW1osbOTHyndBnXy0+SkUY743r?=
 =?us-ascii?Q?5bxh30ysR9xFcJDN6P+1BzxwxkPmV7D0u8Aodm2LW8ESxQSvYC0BGPTct1P7?=
 =?us-ascii?Q?NflVwHf0K4DoEkmZnX2i9CKqCjNbMkqwtc3tfxV7aoVbcIFsMma3ZQm0g4rl?=
 =?us-ascii?Q?IunX8YI7zvdqRgJrXKRbfRumWfADxm/Z0MR390wIKCv9/f6f1rJSLr59sshR?=
 =?us-ascii?Q?NpkMT8q3vhoDbeTg0el4EYZlBNvk6lkI0AWLZJQrTmi7dikQcZK6/g/uCeU2?=
 =?us-ascii?Q?PsgkQu8XR/tNBUuh/ZzjXqkAXlc/NG2VMHVzvpM///zc7eMm6Tx0mYvYgx8Z?=
 =?us-ascii?Q?DiSRlSW/2M6c3JzyaOlLMv4seUahEMkMw8O/605V0PS/KO/WZGuVGhnT11qJ?=
 =?us-ascii?Q?BleVJkIPWGXK96yh2tkdeDZPCM3iZy34nSY2LdzjHpKiQngMC73fbpname4J?=
 =?us-ascii?Q?3J85uUbRs7trYXlmLffH+n2A5pG1v1E3kDvxtSL8m9qQtJZwQbBYKmImotQd?=
 =?us-ascii?Q?+b1parRWMso44GsfH64pU3opVe/L1G/cV4wB+7l1nk55ECGtfMzXP0rZJlKX?=
 =?us-ascii?Q?NaBzYHOqGUVloZpZ7LHbiAVdUvQaw1xTYtbeXXgKqw4x2QswizjncL63uD5k?=
 =?us-ascii?Q?Nn/PahIOSvhEyBA2P7DmYql2TDpNDHvlGZ9F1e6Wngn3IGOAblw3KPjd2f2o?=
 =?us-ascii?Q?K9wJkI05Bbwm/rHzVd4pFHco+YMWVf+Z5AHKAOXgQpD6uGMltWV08RlUftjt?=
 =?us-ascii?Q?jHXUd/YXgRv2yPvUJ8cnrSbBzoCwYrCcSYM7z1EyxKvIB+rxKCZyc4EQd7cM?=
 =?us-ascii?Q?wL6ZOrDURKmi825Ckl5MjPR/VZUM4MscnHI8IOOzAuSKTHWDucI8YVOgsaoN?=
 =?us-ascii?Q?AtnSf8eKwR0TLLK0Y2mhGraioxIIILihJyQgRZDh92IB3Px7OtHQ8pmWROf0?=
 =?us-ascii?Q?doB2PoPAPCEPgwZ0KBlZ9BJHeypknZ7S1udpPxyyKVSxMKHAuEohUB8vgOy4?=
 =?us-ascii?Q?CeTKg426viITJIuYATMTpY8ZQucda9Ku3JlSF4R0X8gpnLbhevufbDEqCZL5?=
 =?us-ascii?Q?peyMY2ZOycldW3HbEj2A0mcNKbo9nh6sihQI/UMFk9nYJVCR5MkS2t3RvzFK?=
 =?us-ascii?Q?KqKqBpmhqwjqcXclNknKkm1VX3Dfc3lGH9jKlLtn5oxXzbCe1pH48jQXWBBC?=
 =?us-ascii?Q?R+1A2+lIy6LFlXl6i4bv1M0u0+yAGGZ8QA3G6XXTBmhtY0JcyLTGwd4xWuNz?=
 =?us-ascii?Q?t4TSX+k4VvgGnCuhZMS0hS0A1BVFCfa7tVuy3t2aZ9A5ylfKrvYf3hifIBmo?=
 =?us-ascii?Q?x0Kei9wmtF3t/DyaqsLQqL/TuDnmx5K7QlPsQHGuhsCJrcLrv/Uw7ZE6d48M?=
 =?us-ascii?Q?clqur+wol2hkbwZ2sNus8dHVIxpM8S0uKZmSQyQ8PrZkHTaZSFyqSLHPpcU5?=
 =?us-ascii?Q?HynfigsYTbId/fg54Xrg34W1AXxGP37sZfIsLFY9Wvr7iFCoPH3bz38Yc74n?=
 =?us-ascii?Q?6SdSMOYnh94l2J9+lk/I53l9TIgkVMJabReZXNR/5R4r3oU0g2ma1FJJsxsF?=
 =?us-ascii?Q?UnUhy4tQav1+iLz5rTZtHRUWgR3Pt6Fg1Vet2zLD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d624ef-c103-4ace-955e-08dbf7ca76fe
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5146.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 08:48:35.6700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PUi2I12uDFQ+Tuxuf2OYtNQ2nDtVl6J5PdtcJ2C1YJJXnlyt5djgQjnuRxE4amStrP5zpSWN/fwEZIHXyaD2hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9978
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/perf/fsl_imx9_ddr_perf.c | 69 +++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 261fa7d85753..1a4fe247006b 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -51,6 +51,7 @@
 
 #define NUM_COUNTERS		11
 #define CYCLES_COUNTER		0
+#define CYCLES_EVENT_ID		0
 
 #define to_ddr_pmu(p)		container_of(p, struct ddr_pmu, pmu)
 
@@ -235,6 +236,14 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	NULL,
 };
 
+static bool ddr_perf_is_specific_event(int event)
+{
+	if (event >= 64 && event <= 73)
+		return true;
+	else
+		return false;
+}
+
 static const struct attribute_group ddr_perf_events_attr_group = {
 	.name = "events",
 	.attrs = ddr_perf_events_attrs,
@@ -507,6 +516,7 @@ static int ddr_perf_event_init(struct perf_event *event)
 	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
 	struct perf_event *sibling;
+	int event_id, counter;
 
 	if (event->attr.type != event->pmu->type)
 		return -ENOENT;
@@ -519,6 +529,18 @@ static int ddr_perf_event_init(struct perf_event *event)
 		return -EOPNOTSUPP;
 	}
 
+	counter = (event->attr.config & 0xFF00) >> 8;
+	if (counter > NUM_COUNTERS) {
+		dev_warn(pmu->dev, "Only counter 0-10 is supported!\n");
+		return -EINVAL;
+	}
+
+	event_id = event->attr.config & 0x00FF;
+	if (ddr_perf_is_specific_event(event_id) && counter == 0) {
+		dev_err(pmu->dev, "Need specify counter for counter specific events!\n");
+		return -EINVAL;
+	}
+
 	/*
 	 * We must NOT create groups containing mixed PMUs, although software
 	 * events are acceptable (for example to create a CCN group
@@ -552,6 +574,39 @@ static void ddr_perf_event_start(struct perf_event *event, int flags)
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
+		 * can't used for the other events.
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
@@ -559,9 +614,17 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
 	int cfg = event->attr.config;
 	int cfg1 = event->attr.config1;
 	int cfg2 = event->attr.config2;
-	int counter;
+	int event_id, counter;
 
-	counter = (cfg & 0x0000FF00) >> 8;
+	event_id = cfg & 0x00FF;
+	counter = (cfg & 0xFF00) >> 8;
+
+	/* check if counter is available */
+	counter = ddr_perf_alloc_counter(pmu, event_id, counter);
+	if (counter < 0) {
+		dev_dbg(pmu->dev, "There are not enough counters\n");
+		return -EOPNOTSUPP;
+	}
 
 	pmu->events[counter] = event;
 	pmu->active_events++;
@@ -597,9 +660,11 @@ static void ddr_perf_event_del(struct perf_event *event, int flags)
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

