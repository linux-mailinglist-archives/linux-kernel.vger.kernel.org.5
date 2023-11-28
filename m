Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C717FB3B0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344057AbjK1ILu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344024AbjK1ILn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:11:43 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2041.outbound.protection.outlook.com [40.107.6.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E187E1;
        Tue, 28 Nov 2023 00:11:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMQ7Y2NRiuSII4ehSCSsp/Z8dqTrPSp4pEoN5aecWZZNHGebS7RHpXyA1/XlD8ddcJOIAHb2qbP6F9y3YXJ+u7uKsGz7p+ReZrCrfxheUBFV0HsaS4F42wsFfFUouXelBeyMPQ7nAo3G63AptfW5215M8um3MLrawCa3Ysennd7QK0TFCxXYmv3wFZPx++6PcbDh0jWsTn6EkLh5AwpAeXr85Ssl866CC0cNsEhFEyLZNyKs80RiVYrKvylXPo5e19qEiBF42kCBTfTOXYP5Z0owxxdeLaCk7tzsinCciv7rG9RJ+ry64ilmg7pT6MB+B0cjFR3cFLs/45pCeBJ5bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xa+BJtwOvvRKi1r0bDd0E+h8/KdUd8qm4TnbvqahfE=;
 b=QZQtmqweImENzSh31YC1ucFjgLEDreZIDTzLScaqxrSQF5TWB0/qSayyRIIalYWoUVSR4I1VHyUchMyKN+nMy2C9v9M/x9Znc85BbndTOAHZddgLX72A8rt4xFubn7ZKc8n+7u0nfn3eTzgN+2RbCB52r3f9yWItihQvA+88qDplPeRFyPfRhBDN49+sxUA2sPPDCfNo0Ghs77+k7nCbRr9HT7c5zKbwaQ0YEH7zT6UwQzOOpGOpn6QpA0GxeEIFmRrqM4uaWapA+XnJSJnln/VwloAdzk2e3kjoU+U6cWO734aR96nwrCkhOlWSgkMPg0s3OBY1+aopPuJKfCg9fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xa+BJtwOvvRKi1r0bDd0E+h8/KdUd8qm4TnbvqahfE=;
 b=SB/5p0X/FN6csv+J7Jc5gfaVamvt9w2J37uUi4TyHGvrTp3YLt8XL613qRyUHcorNETpHtgeyICnDsYipyHWcrBXh0gMXBuxNgEa9DqPEwbFg49A0xlYjQZ8llRFz159nEu9EzGK0M45xJPt0T+gsWmuDfld5aBOP/h8dpcrBjk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com (2603:10a6:803:61::28)
 by PAXPR04MB9445.eurprd04.prod.outlook.com (2603:10a6:102:2b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.19; Tue, 28 Nov
 2023 08:11:44 +0000
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::c688:1f14:2ab1:c78a]) by VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::c688:1f14:2ab1:c78a%4]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 08:11:43 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org, robh+dt@kernel.org
Cc:     kuninori.morimoto.gx@renesas.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        daniel.baluta@gmail.com, alsa-devel@alsa-project.org,
        iuliana.prodan@nxp.com, shengjiu.wang@nxp.com
Subject: [PATCH v4 1/2] ASoC: audio-graph-card2: Introduce playback-only/capture-only DAI link flags
Date:   Tue, 28 Nov 2023 10:11:18 +0200
Message-Id: <20231128081119.106360-2-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231128081119.106360-1-daniel.baluta@oss.nxp.com>
References: <20231128081119.106360-1-daniel.baluta@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:78::11) To VI1PR04MB5151.eurprd04.prod.outlook.com
 (2603:10a6:803:61::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5151:EE_|PAXPR04MB9445:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fdb4ff4-4dcb-4eee-44b3-08dbefe9a52c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1iQzlQjOW43HEB8RA1vPBqjDunvxaVO76koBfK8Sv5VncKYr88bs3GMT4nhUMHLfZtsIDMWJMGFhrorq40VGeZ6zabH03UGqWyJCrogA6Ge0bHx5N23v0eeq9IhastyUv9mfOk8heYtc68F771UiklYDWqDdHO/DA2IrDNgP2R8UBYUzbWctF8vCGtvvKmmaZ3heipF9h0axysePmq3B/gjA913fKG7axEFKmYft0vTecnVcC6Wz0eUDUpgvplfoxgD0I0aE8aHG4nkuZ2ZvIBkfoBwlRxSZK8wKop7fGl5YOBBFOjiegBaClN6ndFZt7YsAY8sXHDlh/a2vNmKkKMpi3GW+HLPYUIIOqkacdQ3pp6WZWZ6kSnxdWrFKr7WXoy5gxcq7NA5Qasf/sNdKYU0whH2waN14qRBROZJdeFfUHjICjV2Yq9GQHen7GLSaruplAktGZr1NwlBR6WLdIOkb2x8SKAljh4fLTZ0c97U3TuCC0I/U17+W2ryPL6bnJ9kCQVAVWZ1+vY1F9sVELvHZUPqF65iILie+hOuihXnX9d6pFIr091x2BT96yxf3Qa0F/GhvNv3XXqQzOmNNedqDZvfA72QT7OE8G7dFia7IcFn/2k1ref4YfDVgSICo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(83380400001)(38100700002)(2013699003)(86362001)(316002)(66946007)(66476007)(6486002)(66556008)(478600001)(41300700001)(4326008)(5660300002)(44832011)(8676002)(8936002)(2906002)(1076003)(2616005)(6666004)(6506007)(52116002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?li5RRS2NGZvhll8vVA7hr1ECPLqqUO4VhHrySMwswsyb16OTRY+ym1k/tuEB?=
 =?us-ascii?Q?LDxId49WJ5abW/uIyv9Pbdu5mVgXZsDtlWjtZ6gFcDwYdUBLl+HOajOxFgEc?=
 =?us-ascii?Q?MQqyFBEiEGD4fXQZGM/a5LX9xpK/8I6M5vw9f90aD3k3E3fV1XSUtlE89Dib?=
 =?us-ascii?Q?kZmgTNmKsTB+IWFF4V2vSCxQYdQl7C60oIDUpwWT/FeHVPkww9fOyHpinzma?=
 =?us-ascii?Q?s+YpaoCLaJ4wxwClRfcSXXd+hfb7LakeE0Y3AHEjINolmNlqbfRGfu45Y1rP?=
 =?us-ascii?Q?THgRZv47MH2bHh3HocG77JPdvsIrUteEZzv1IvT9btorvubV++khimJ9VTw4?=
 =?us-ascii?Q?HvXknAZ+DS+Hvt9PxgSjNv5Z0xePkkHmMc113FtoDzoWsC+IzX9IQrN8IwbG?=
 =?us-ascii?Q?aWIO+puSkUzVJigyWfxlu/brQxW7wjh/kzGfVKxmvqPeyxvj7S0/8BJd08L4?=
 =?us-ascii?Q?edIQ8exIQsYpgfLJRW1O6ZByTDNMihT41FPDKF9old8SXyskHRAmMDeprslj?=
 =?us-ascii?Q?uVPQnNzp4dKBpO9iKewGlTvxMmwcQJlhFq/gv7fJy5pub8lmIJWDbtea0qP4?=
 =?us-ascii?Q?CR13NQfF4+hSsfSH7SwSkawzfwksGaGUJkllPyZjVlO022wEWydQ8vF++4OP?=
 =?us-ascii?Q?OWsQb6TD6Tj7VLsDCiyACLjB80HR2bg/XnM7oL3fFo+3NSoaSNzMzJZDr8us?=
 =?us-ascii?Q?KDF3xLU9xKs5QR5I3eNN4baAH9lBBJARb8XIAyl37/nv37rb1YuApcsGUmT6?=
 =?us-ascii?Q?miyrH9fzoXkZo7uE8bcBBnItWGex7Dl6s3e0i+gHUtW/j08SfzWdQstvpCTc?=
 =?us-ascii?Q?KhgNPOjHOh6JbLjm4ol0ftwqkrxjZ0Z0spRuuHNz2AHmhksyrlzOabWCJccs?=
 =?us-ascii?Q?tGKTDSoY3H3S0lueY8ntwUQ38rfYpidhA3LFHyWC9IS9w9v4NHH+ZF3gtfgG?=
 =?us-ascii?Q?TV1djaigfFvsvhzkDLFEumHTyY9TgNcu0VZABf+nk/u2Mu3u7TTG5WegEOVG?=
 =?us-ascii?Q?qQt6D3S/r7jxBq3b/zyIxZYYAMP/n+tJNfzmsDsVXVZkhEcmuImbIBfFJUFr?=
 =?us-ascii?Q?VMj8+P9zHwhqkvpyrLTikqb6fTgwErpIn1iw7H5UOLxCAS7d7eB8w5f0d+uC?=
 =?us-ascii?Q?JEyxuyRP+8IsZd1vR1fxB7uY9bV7CdOI8X4fDk611lOMavjXboB9CSRuYenW?=
 =?us-ascii?Q?o+Apujg/44ZSgDQH3TeOHzu9d9NCEvAfCAXDuYyBHylmBCVEqK4EgndM4tdD?=
 =?us-ascii?Q?0pmB0VC035lA9up69eZjBrXtUAWVkdgirHyUTI+kIHkdHx0RDOBLXxCFCN+G?=
 =?us-ascii?Q?ojyxIQacfLgRNKljT9/+WHQFVNzOX8i1YwdceVrd+heTvh8C61R52wwRw2aj?=
 =?us-ascii?Q?7ruWMaotUclGjcEaRdrOZqcnSHU6RH20Mbp+Qa+Qf5EZ3UbBgpM9tC2e78z6?=
 =?us-ascii?Q?iJMedVUQ+jBmVBZrtBTMPA3tSpNcvF06Axa0yU/W/8k3NhpsPXYTO7SRQTh4?=
 =?us-ascii?Q?/slhGVZ6z26+BMp2ydk6m96UlX7VV3j5PXkVNVVegkeAcRZox1Ali7PFuLO4?=
 =?us-ascii?Q?57hLlA6ptV/NcU5j1CqT4acCGGsnQe9mCt0MDDrg+BEhLEoknkPBYnoAfugz?=
 =?us-ascii?Q?v255V/BPLTZjUtfEW6xyE/2+sCimaqzcnUCxWhBeTtfIwDpHQZ6JCFDt2NPd?=
 =?us-ascii?Q?BoacbQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fdb4ff4-4dcb-4eee-44b3-08dbefe9a52c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 08:11:38.3222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mmk9/DWikcql40f26N94APnfuqjgLX1MtD6ZHJuWLzyUMgomVOwmcA4+azrC0pTCFWZ53svSsaMeJtwm3/7GZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

We need this to support MICFIL PDM found on i.MX8MP where the DAI link
supports only capture direction.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
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

