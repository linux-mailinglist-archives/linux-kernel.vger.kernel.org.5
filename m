Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B50E7F6394
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjKWQHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjKWQHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:07:11 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD3110DA;
        Thu, 23 Nov 2023 08:07:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h24skFTIQvDD+2ZPelxQQ7ZheIusWE+bTKv4TDyywItkE8TdKrKktLOAoFZnhlEzG2/rCnHIbmLrPwEM5sbRATd9UmDMbjB7VDjYO/x/lQnE2MKtVGZCfwhfKjqW/s4yib7FjKMw/4IUcthlIlDXnLsBcglda4y2rqxUSL4SkcHI0KxpqqdDp6fzHmHnmgt7EaxBw9M9+sEdumhoEGvMi0IdUIfWKcOz577DGHlmZVzCUxj4bZNgg45pOjHpJjvRTVwBauMBk8smswi+A/wDdG9FnKEi2nNN1pyrq4A35P8eKiTXAfigCQ5KvXbnlR2mGuzraiJe2rDTpAhj2Bs/Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/H2VP17dgAu1wWSI+Qvs2YKovPiyKKYFumKe+HuuTD0=;
 b=AKAp1KsDtCTNSR/7HlvApE5QXzJBDFB8jAPojUWuejkjd+FznuMwr5sWR3/UfLykTff0uvmCVYvHfMlsa7bv7bjOfrOAGIhXbROkGNG4XDHPV1oqhu0NIK1MX9bkMiYtZlAFvb/ntpwYoVAycx7kJ6FmbhpMPlMVVgmrLb0Ol7GKka45ckBFn6RHtAv6Ajli8DR5IbgD7z9ODF9E2T/6fNDzu4er5iVdr6SvLF01HJp7Gs6/bnq/3D7D9t4aeCkFeLWUsIsoGXx1+t9uckUGHFGip6BQbNoFmrBNKLCuFsajjIxWVvvguQoA6lkcIxze3CL9VRZlVeA7SGR/fV/LKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/H2VP17dgAu1wWSI+Qvs2YKovPiyKKYFumKe+HuuTD0=;
 b=KLYMVDtwFu2BQxkcuxxKbUbIXerL/TSj2Kf2V5Gwo37IbgWKvj+hRKsv1+MHO2jX7iayAbzhXt1I6WEk4A0/ZQ5bn2us+tYo2xGPn/kJcaSuVXW+T78VRDhC7W28zL93DN9fzwqMlc5QcyEBUyMqWmF17CgWdoLNsskq1qM3rfw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com (2603:10a6:803:61::28)
 by PAXPR04MB9399.eurprd04.prod.outlook.com (2603:10a6:102:2b3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.12; Thu, 23 Nov
 2023 16:07:14 +0000
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::c688:1f14:2ab1:c78a]) by VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::c688:1f14:2ab1:c78a%4]) with mapi id 15.20.7025.019; Thu, 23 Nov 2023
 16:07:14 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        kuninori.morimoto.gx@renesas.com, daniel.baluta@gmail.com,
        robh+dt@kernel.org, iuliana.prodan@nxp.com, shengjiu.wang@nxp.com,
        linux-imx@nxp.com
Subject: [PATCH v3 1/2] ASoC: audio-graph-card2: Introduce playback-only/capture only DAI link flags
Date:   Thu, 23 Nov 2023 18:06:54 +0200
Message-Id: <20231123160655.188428-2-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231123160655.188428-1-daniel.baluta@oss.nxp.com>
References: <20231123160655.188428-1-daniel.baluta@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0146.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54::7) To VI1PR04MB5151.eurprd04.prod.outlook.com
 (2603:10a6:803:61::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5151:EE_|PAXPR04MB9399:EE_
X-MS-Office365-Filtering-Correlation-Id: 60b72a40-64a6-4583-da6b-08dbec3e41ee
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iZ6dYxhhx1HQ2PBqkgWMxJcwFBx2ZmS7uI7hO4T0658YN1S+BJ1vut8GXxa7NA4CLqzAF5L47LA5KrSyJfGvOotcIIkfjpRZrPByBxw/LViE37aeFuK0s/VXzYHQfvO5QpwVa98xbnvwg31J2ScFa+CSpVLRU9XE9MU2WvWU/zjxlmwODEjV0eHpmaxy6GG+CrxFSGC0Wp9X/9EKmhFnupd/c1cwATxGi1hgMeW3YSLFWIw9et0rBge4ueljA1OXVTf1krKaQgGtDD2ON0tEYNP7zctmVKJJhQ8x+vD3nO4BrX/+Z66+zXFAP0U3Ms/rlz0FYGHzZ/jdsTEnBogwbliSfg5KNsC1eH4oSMRylZIsQeC3rQS5j6SJ1H0ZYxyqtJQ0YOGd2yyuwmQE4QW5WKflwxJ7HR06DZbCZHlN70WmxG8wvIZJR7oYb5jwEdFng7JVvFe9mG5/CjHZMSN5itU75txc0Q8b5msPg66L44Yrm8eA4wjxYMFw+VDk/5HZNiUZArpJl0NcxRp4yuHrv5na2euq3+Ml6RIpW6hYSg9lwqPcXqcsYQFiuuoH9nVd3FPCpQB1sgRIpcgYULMA//rpIMCCDWRBUSklfR45DV10OXtVTcdEQJxarXry4q+PUlQG+kBt670+mmHJ+WnHAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(366004)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(86362001)(44832011)(5660300002)(38100700002)(1076003)(26005)(83380400001)(6666004)(6506007)(316002)(52116002)(6512007)(2616005)(4326008)(66476007)(66556008)(66946007)(8676002)(8936002)(38350700005)(41300700001)(2013699003)(6486002)(478600001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YeKLJ4ZW3nfCqWQZDqKgRWk/UIijh3RdLzNdlRsW18rdtjc+/Mf6rXw9AMze?=
 =?us-ascii?Q?UvsJ9AqWI9K4chXFvrWaOBm1YPav+HOo4fwZiIDOQLtC5JClLOMxiUtRahPf?=
 =?us-ascii?Q?8r8et7kWRTN0eJjx+CFbFf2+w4F9kKRgiqAmcKvZpb9o8Bd7nbM3ct6AG7jl?=
 =?us-ascii?Q?4hDcLUs5y5M5ezYUd6lfnob/mCu45RINUW5Lfrk3KNL1b8nEXXBnovWN+uws?=
 =?us-ascii?Q?PvNMka3g564mfE2SFUebDfSqL08WJjS/LXWSk/k4vHI21bXH0iUzCssAPyD1?=
 =?us-ascii?Q?3J0txvr378dZ/CqLd+LtKbjIJ4hizozrlpQOJ4z5IyWfo1V1Hj+Fd0IMzqXm?=
 =?us-ascii?Q?mJgZMaFpe7YCs4mQDUPNkgZ8fctpZSuIQYb1/Ff9ke+aWxrvg2opBA43P/Zh?=
 =?us-ascii?Q?U2IRmdJfckGC+931MN5FbRUzkf8JWoS7h1HYqskYFFzi3dGethR2a37EwbKc?=
 =?us-ascii?Q?CpoHFn76oF64Q4mueyc9hFQdB+xGjmCApO1SPMzTvbWOcRElqtgKaQWGZwR3?=
 =?us-ascii?Q?/TMs7mMc3XG9n0vEPQT372Ec7h0FYE9w6+59fA7oYVtEISedUqj+qHByg1oR?=
 =?us-ascii?Q?zfPKTgl7iFyDo+auJ2osGGWkjF4XXA6HtYwllGRtgLFe18O6LpDFjhQW4waX?=
 =?us-ascii?Q?ZlgV7JvsaaCOWC+cJ9tp/tfeC61DIuqAlgtzfiRCWYp5+7CoaoaV+kvU/39T?=
 =?us-ascii?Q?Eay4Kpk/siOBS0V0k8djrJiujil7qgZGzAKg9dGTSbEOyvF0w0nmOAngnOjJ?=
 =?us-ascii?Q?iwQueyApJrFH0oSEp0yO5Lhx57i/LhuepyFx8xaZfyRuDRpF1gCL34iQuU76?=
 =?us-ascii?Q?EkmUfG26H0TpbvV9AS1kEdycefNifd1niznHxnh7osQmZdB1juD/ASiOYZ+d?=
 =?us-ascii?Q?TUEVLGz77GaFJFS9L6vYCJJ6E+DGtaU3SQjRd6A19w447ZEiP4SJ7udOl9+w?=
 =?us-ascii?Q?mQQWmvmxz8cx07tmXfnnRbwXGu1ebNCyDpiVB5A7bF2//9RCiNvPHXzn6mtv?=
 =?us-ascii?Q?RA13NJ2FY8odocdLQH9crCOKXTcU+8EqIIpMoGmV06KHqeBNTzeOggb3vR9y?=
 =?us-ascii?Q?Y7XjAMIijpnw41LGWekEYlHcsCEmmnynPsXr42oyp0rYdcOBTH5hbxwM9BfR?=
 =?us-ascii?Q?kLScQYzmLBkMZrzLvGdL9H0zlLTf4Wb70SCW4b7aosmqWPEi83pf103lsmlT?=
 =?us-ascii?Q?9lw5y+6NhrQ9Doo7NxEjpKpGe4oSeLxClDjC3J63KMDetSXoXmyGh7d4w9qM?=
 =?us-ascii?Q?ufkr+sbEQ9Qe2oduxBEfiASwCC8zIDkw1lzkbvyTcH3BV0kCGTREXIOfTvlo?=
 =?us-ascii?Q?33uSpWOZMXaJyVlAd19ru6sKIlq/xDmIdrYxXvt6A+x2OX6ID+uRhdukOfbC?=
 =?us-ascii?Q?esRBARQiOB+2ajALQQ0/EgpX+nBKroPK6Xkm8LYGnUi1nF39H7lA74yNhnPM?=
 =?us-ascii?Q?by1WVb2cpblBGrRxgUM7ZWdYTER8sxNnk/XXiHkMP9/dDf3VthS0u8ok90qU?=
 =?us-ascii?Q?J1rkpvk/adjJu9zi2ma2KeFJhi8BUKJZdnKjDKcwC47T/teCVTfUAPHYdueS?=
 =?us-ascii?Q?d7aTQxGpNg7nYsTCGWi61wxeqnCqWxc90ZXYxVif?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b72a40-64a6-4583-da6b-08dbec3e41ee
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 16:07:14.4094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pjVNQ1K1dj3niuIPWvGaq/w29NtpTc1IEBLlXEmpHaGEVXezx3sJq6Jv7GRBVeXkkzhEMGJgYYClu4RDv6RYyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9399
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

We need this to signal that DAI link supports only one direction that
can only be either playback or capture.
---
 include/sound/simple_card_utils.h     |  3 +++
 sound/soc/generic/audio-graph-card2.c |  6 ++++++
 sound/soc/generic/simple-card-utils.c | 19 +++++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index e5da10b4c43b..ad67957b7b48 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -195,6 +195,9 @@ int graph_util_is_ports0(struct device_node *port);
 int graph_util_parse_dai(struct device *dev, struct device_node *ep,
 			 struct snd_soc_dai_link_component *dlc, int *is_single_link);
 
+int graph_util_parse_link_direction(struct device_node *np,
+				    bool *is_playback_only, bool *is_capture_only);
+
 #ifdef DEBUG
 static inline void simple_util_debug_dai(struct simple_util_priv *priv,
 					 char *name,
diff --git a/sound/soc/generic/audio-graph-card2.c b/sound/soc/generic/audio-graph-card2.c
index 7146611df730..04c2eac881c2 100644
--- a/sound/soc/generic/audio-graph-card2.c
+++ b/sound/soc/generic/audio-graph-card2.c
@@ -597,6 +597,7 @@ static void graph_link_init(struct simple_util_priv *priv,
 	struct device_node *ep;
 	struct device_node *ports;
 	unsigned int daifmt = 0, daiclk = 0;
+	bool playback_only = 0, capture_only = 0;
 	unsigned int bit_frame = 0;
 
 	if (graph_lnk_is_multi(port)) {
@@ -635,6 +636,11 @@ static void graph_link_init(struct simple_util_priv *priv,
 	if (is_cpu_node)
 		daiclk = snd_soc_daifmt_clock_provider_flipped(daiclk);
 
+	graph_util_parse_link_direction(port, &playback_only, &capture_only);
+
+	dai_link->playback_only = playback_only;
+	dai_link->capture_only = capture_only;
+
 	dai_link->dai_fmt	= daifmt | daiclk;
 	dai_link->init		= simple_util_dai_init;
 	dai_link->ops		= &graph_ops;
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index cfa70a56ff0f..9006ef5e95f5 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -1129,6 +1129,25 @@ int graph_util_parse_dai(struct device *dev, struct device_node *ep,
 }
 EXPORT_SYMBOL_GPL(graph_util_parse_dai);
 
+int graph_util_parse_link_direction(struct device_node *np,
+				    bool *playback_only, bool *capture_only)
+{
+	bool is_playback_only = false;
+	bool is_capture_only = false;
+
+	is_playback_only = of_property_read_bool(np, "playback-only");
+	is_capture_only = of_property_read_bool(np, "capture-only");
+
+	if (is_playback_only && is_capture_only)
+		return -EINVAL;
+
+	*playback_only = is_playback_only;
+	*capture_only = is_capture_only;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(graph_util_parse_link_direction);
+
 /* Module information */
 MODULE_AUTHOR("Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>");
 MODULE_DESCRIPTION("ALSA SoC Simple Card Utils");
-- 
2.25.1

