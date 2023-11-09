Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC2B7E6BDA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 14:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbjKIN73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 08:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbjKIN7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 08:59:25 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2051.outbound.protection.outlook.com [40.107.6.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E006E1B3
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 05:59:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6dxzESp2E0iHsVYoAhRshvZRBfmc0cFijXnKs3ocsnV8oU/2ofpWJvlHh71+cM7zQA30buBaqiZeqJrVqcyqWJSvBeJlYXz6/OggKzzVkpUiVgCmI91POL/GpmJfLMCpxfEUsYQlXIccEPfaC2Vx2SxppHrYWSflJNsWlsaKO7ufy1PPXxCjr1pa9VI/AJgrQCmG7NNtikA+b7mL/vIiXdt78l1vrtQDVb6hUh3VG4lv7jbrr97lyyNDHQ331hqi1Wq/rakRWKWa63X3WQAg8gyDI/tu7deQKtDNMFHMExK+rWtbepRRHdqfua9pP7w9L+xssnx904rL7LOelVHUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlOsyK/dolSbMruRffxa6cpnWcDzlmhtoKGZxY+rj4w=;
 b=AfvPJN+P4EGQAinGiCj67L7QSn6zoC/vBe2/JRn7cgIGNgH7gC460HmXtU2ijMzDmXYIqoZ9cZuxjObHjrt+Qhbeo12a3c9g079LcH1J1wlBtwAfMbnCxq3h1obrIiJqrs1fBEvX8LWXP1/KJl4i3JZnGxDd+NjNWQCBUeWGw1kZNeGKM0VaNBSAtXbaz90rH1qnPxDzsx83AUnStBxchTP2zgh2UQh6GbXziNnfgNreT39uKzP1To8Xm9XS92Uhewhk8takBE5NrkmmHJmYjJwH2wLhDwIprnlzlEXBmnjsKywPMowpXl/DP9K78vVseLB6QxRrjdqytZKtsB1C1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlOsyK/dolSbMruRffxa6cpnWcDzlmhtoKGZxY+rj4w=;
 b=Ra6kirCnjxwFvkuYEh9QiGVaqKtJGmnQIQB04iJw75Mg//5AN9oZgwEM+1wGQezMQmeRXK63n5DlaK1oabTK7ux23KoKSo899ojcjmOwznvdJfKUbtE7gD+expLEF5cxTTs7bx8LJS1/LJ2n5eVLO8MOrTgIWUmLcynB1PE/usY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com (2603:10a6:803:61::28)
 by AM0PR04MB6867.eurprd04.prod.outlook.com (2603:10a6:208:182::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.7; Thu, 9 Nov
 2023 13:59:20 +0000
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::c688:1f14:2ab1:c78a]) by VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::c688:1f14:2ab1:c78a%4]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 13:59:20 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, daniel.baluta@gmail.com,
        kai.vehmanen@linux.intel.com, linux-imx@nxp.com,
        iuliana.prodan@nxp.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ASoC: SOF: Add support for configuring PDM interface from topology
Date:   Thu,  9 Nov 2023 15:59:00 +0200
Message-Id: <20231109135900.88310-3-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231109135900.88310-1-daniel.baluta@oss.nxp.com>
References: <20231109135900.88310-1-daniel.baluta@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0114.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::11) To VI1PR04MB5151.eurprd04.prod.outlook.com
 (2603:10a6:803:61::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5151:EE_|AM0PR04MB6867:EE_
X-MS-Office365-Filtering-Correlation-Id: f780f851-82a3-40ab-af20-08dbe12c1241
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c2k9FnpFOSCSnmSBqdXlmoUg+CisFDa4X3lAy2dZDKZ1gzBXqfv3+YX7Rn7xTT4zzROwk3wciBXPbLFrqZQ2O70jWaGKPXwutGDAwSO5v4aSTFoqwX28iiIX8RzaMlm1qpIdQGaFsQGJ+Q7Drq32tFJFfECQ8IYcltjYnwgBBUyghnET6qyFk2b4Es4B0kyagtjDEqGh3wFJmYEZSHdGcIK0qKzZaL+o/PeNSSq7AE3emnOma6exusoPoesdiEZu0bqH6VVshTibWEziqj7We1hFie2mzRtWeTU0LZtgnea7Jci7XXqh0gjz9SbLGG8Mi9Ge8lxVP4XoSBWk5ZwCfL0n258RFWv3xCxE4Dxsh09hIrJaotFVU1DjLYRISpUxWbletaluiweEKPdGm0YisSYb+QlAi166vUo3rVVfhQLiLVddYgr72MZs9znJJj6v4wodJaoZcBWPHEByZ01l65OLpoLmJaiFGMWahOo/+l38P1LvyetyOVVBF39D4y4TtxMgSs2SCjDr5z3iSxrBAIHecL3tUhZ8v3Z/jxOdVdsCJJD8/QmU7rINHfEstxZa2aC7BnEs5MSfFGSqbF0XMYpBk1e9igMTZ18MADYJrmlIbWUemtSk251R4+lpMigM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(39860400002)(346002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(478600001)(316002)(66556008)(66476007)(52116002)(6512007)(6486002)(26005)(66946007)(66574015)(44832011)(8676002)(4326008)(6666004)(83380400001)(8936002)(6506007)(2616005)(1076003)(5660300002)(7416002)(38100700002)(41300700001)(86362001)(2906002)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEMzYk92ZXpOMTNMcmJDdmY0UENCUHMrb2E4RGlqVi9pa2kxSjZkU3ArWmFK?=
 =?utf-8?B?S2NxdUtQZit4YmJSSEU0OVRadmljN3hiQWRiaG1xYWtYZE9uVjl4OC9wbXlz?=
 =?utf-8?B?TThpOTVmeVdnWGlrZDk1eGFLQmxBanY3eHNEOWVpZEtZWFcxUEJKQy9YeUdt?=
 =?utf-8?B?Z0tOS0Y0bjZmdGNNTmR4eXBvaU9mM20rNVNUMGx2bnJ4ekwvdmFWREE1OFVB?=
 =?utf-8?B?ZXU4Z1ROMmlCRzBsRUJVNlRsYzU1NmN6N3FXdVJkWlF3MSsxVXlLQUtiTzR6?=
 =?utf-8?B?TUpXKzRhUGo4bDV5dlR1RGFiaElIcXM4VEFadC8yTlhkNjYxdmNPQzZOUFJY?=
 =?utf-8?B?ZWpMRmNqWjhORE1VVFpOOTJrcm83THMxMldOejVaRkhrS084clM4OXM4N2dr?=
 =?utf-8?B?N1pJdng4b20wdWZPZU5IVjBpWGYwc2I5WXNURUFOSm5aeUhjNFBLdnpPc0dQ?=
 =?utf-8?B?RGkvbWpFUVNldENGWTBCR0tweWVOMHZjdnRWcU1MSUYzeExLZ0ZNUG9JelFp?=
 =?utf-8?B?VmQ5bkNYazVzZEIzSm1pZTlDQWt3Z3haV3l0c0ZySFNBVmM4ZW9IWG95c013?=
 =?utf-8?B?ZUlMR0ExemYzb2dldkxlZS9lZ0RKL0pVV0w5NGl4bUxJVStpK3hsaWIrYU8w?=
 =?utf-8?B?ZXlHaEtyd3ZGZjJvbzBNaFErNnZwMVNxUU5KK3FlQWxMUm9XbnZmVUxsRE5h?=
 =?utf-8?B?TWdwQytQeDZmSXNVbjd5VjlIeFQ3bGRvZG01QlRRQmU1YlBCcTRDMlNoL2hC?=
 =?utf-8?B?ZGloWGlqa3QxWmd0ZjBiKzN1aU1PVzJHT0tSdWJsT2hUZkdoZjNmUThvUEpv?=
 =?utf-8?B?TThtd0h1OHNpTitXWjliZVBaZ0NBdDJ6K0FzWG5xWlJ6RnFya3lOMUdZTU5r?=
 =?utf-8?B?Y05SSk81NEFqZlB1OS9DdC9mbmtuald3eEt1MzVES1JJTHlaQStPT253Yzgr?=
 =?utf-8?B?bllTREdLclNsTnB0ZW5weG0ySHk2amgwbjZnMUk2aTZsWW1VSkxGa05KamhE?=
 =?utf-8?B?MVNRQ29oSW9JQm9DbEh6QmEyeXpMSEdmZVB5ZXZIcUdOVGhVb2xYajlPY20y?=
 =?utf-8?B?VG50ZmxvaThKYXFRVlkxNmRKdXZtaXA1ZjhZNkc3cklQaWx5dVhBQmNhRDg0?=
 =?utf-8?B?ZDZSWHUyLzhvR090ZEU1ZDQ0VzR5KzNhNTNMcWNINk5mQ2xwdjJEeG0vUU02?=
 =?utf-8?B?R2UzZkdwS2NRVUJsK1ZuVWY5R1g4Q3Jqbm5KRGtsN1FxSEw3NmRIcXhweitI?=
 =?utf-8?B?TXBmWmhxd0U5dUZndmVaMXE3a2p0TGIxQ0ZYdkhERWVLK0s5Y0hqMmRYODNF?=
 =?utf-8?B?TVJLMlE3UWx3SEUvNFlicFppZy8wZGowUndNK3ZmaGRuUFhEQkVPTS9GOHFJ?=
 =?utf-8?B?NVFCb2tjRFlDay92Y0h6MFZsbUt1aUxWT0hDOWdjRC9SMGp1azYzcTNiSlM4?=
 =?utf-8?B?cTZNU2loRkw3cnp0d2hvQnFuZDU5d2VDWlRIck5sZHpqUnJmRnJRcXFjSWtC?=
 =?utf-8?B?SU9vOUNnOUFURDY3cGxwaVluK3dPRHJyTnVjVG85OElRWjFnNGx2V01GdExx?=
 =?utf-8?B?cm04TVNQNTJMMXowQmwxL0FwUVptRjV2aWNtS0NaRkQ1YkoweTltN08vdVdU?=
 =?utf-8?B?bWRabS9ReUFXeWF5a284SFJjbHc3bHJrNmE2VTUzQnVvalZ3YnBuaGFKTjgw?=
 =?utf-8?B?aEQwemZ3c0I5Y1JLWlRtU0dVaElqM1dLYm5vZUtvVnBEOFBQSEJmK3lVSWdw?=
 =?utf-8?B?RFR3YkpxTnhST2xpeCt4YVllMTRGY09ZMVRGanB3RXVtSlBRWjB6SVZrZWF3?=
 =?utf-8?B?bDl5ZS9ITHRCTDdxb0JBYWRIazJRdWF1WkVwRnRSZC9YTFBQclJqYU1WK1JM?=
 =?utf-8?B?U1NPeERFSU5YR05HRlQ0MmNvdDc1SnBEY0x0eWdCOUVLWG4zV1U4SUFUSGlj?=
 =?utf-8?B?RXlEZDlLYWYxRnpjOERvcTRKeTNickdCRWtMWlpaamZjYXNYK0g2eDcwSGFS?=
 =?utf-8?B?b1J2VnlPcm5XRFpIYzJIazJkMkFCRXFxbUpYb1o1Z3ZITUovWGF3UHZqNElW?=
 =?utf-8?B?RTd4TkJKaVcxbjFrQkdpUW9FUStkN3pZVUdKNUJDZWZaWU8ycldEZUFnTkQ1?=
 =?utf-8?Q?o5+I+Tbl5WgIBTrWXSJ4zK1QC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f780f851-82a3-40ab-af20-08dbe12c1241
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 13:59:20.6479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KPWVEX7Noclh6dbYDAcTCAc9P/vmuJsUkEWyBQGs9N29mYJGDpt2mmKehmbBTHwRBO3fqX0rPLx0FE+CJ5VwBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6867
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

Currently we only support configuration for number of channels and
sample rate.

Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 include/sound/sof/dai-imx.h     |  7 +++++
 include/sound/sof/dai.h         |  2 ++
 include/uapi/sound/sof/tokens.h |  4 +++
 sound/soc/sof/ipc3-pcm.c        | 11 ++++++++
 sound/soc/sof/ipc3-topology.c   | 46 +++++++++++++++++++++++++++++++++
 sound/soc/sof/sof-audio.h       |  1 +
 sound/soc/sof/topology.c        |  5 ++++
 7 files changed, 76 insertions(+)

diff --git a/include/sound/sof/dai-imx.h b/include/sound/sof/dai-imx.h
index ca8325353d41..6bc987bd4761 100644
--- a/include/sound/sof/dai-imx.h
+++ b/include/sound/sof/dai-imx.h
@@ -51,4 +51,11 @@ struct sof_ipc_dai_sai_params {
 	uint16_t tdm_slot_width;
 	uint16_t reserved2;	/* alignment */
 } __packed;
+
+/* MICFIL Configuration Request - SOF_IPC_DAI_MICFIL_CONFIG */
+struct sof_ipc_dai_micfil_params {
+	uint32_t pdm_rate;
+	uint32_t pdm_ch;
+} __packed;
+
 #endif
diff --git a/include/sound/sof/dai.h b/include/sound/sof/dai.h
index 3041f5805b7b..4773a5f616a4 100644
--- a/include/sound/sof/dai.h
+++ b/include/sound/sof/dai.h
@@ -88,6 +88,7 @@ enum sof_ipc_dai_type {
 	SOF_DAI_AMD_HS,			/**< Amd HS */
 	SOF_DAI_AMD_SP_VIRTUAL,		/**< AMD ACP SP VIRTUAL */
 	SOF_DAI_AMD_HS_VIRTUAL,		/**< AMD ACP HS VIRTUAL */
+	SOF_DAI_IMX_MICFIL,		/** < i.MX MICFIL PDM */
 };
 
 /* general purpose DAI configuration */
@@ -117,6 +118,7 @@ struct sof_ipc_dai_config {
 		struct sof_ipc_dai_acpdmic_params acpdmic;
 		struct sof_ipc_dai_acp_params acphs;
 		struct sof_ipc_dai_mtk_afe_params afe;
+		struct sof_ipc_dai_micfil_params micfil;
 	};
 } __packed;
 
diff --git a/include/uapi/sound/sof/tokens.h b/include/uapi/sound/sof/tokens.h
index 453cab2a1209..0fb39780f9bd 100644
--- a/include/uapi/sound/sof/tokens.h
+++ b/include/uapi/sound/sof/tokens.h
@@ -213,4 +213,8 @@
 #define SOF_TKN_AMD_ACPI2S_CH			1701
 #define SOF_TKN_AMD_ACPI2S_TDM_MODE		1702
 
+/* MICFIL PDM */
+#define SOF_TKN_IMX_MICFIL_RATE			2000
+#define SOF_TKN_IMX_MICFIL_CH			2001
+
 #endif
diff --git a/sound/soc/sof/ipc3-pcm.c b/sound/soc/sof/ipc3-pcm.c
index 2d0addcbc819..330f04bcd75d 100644
--- a/sound/soc/sof/ipc3-pcm.c
+++ b/sound/soc/sof/ipc3-pcm.c
@@ -384,6 +384,17 @@ static int sof_ipc3_pcm_dai_link_fixup(struct snd_soc_pcm_runtime *rtd,
 		dev_dbg(component->dev, "AMD_DMIC channels_min: %d channels_max: %d\n",
 			channels->min, channels->max);
 		break;
+	case SOF_DAI_IMX_MICFIL:
+		rate->min = private->dai_config->micfil.pdm_rate;
+		rate->max = private->dai_config->micfil.pdm_rate;
+		channels->min = private->dai_config->micfil.pdm_ch;
+		channels->max = private->dai_config->micfil.pdm_ch;
+
+		dev_dbg(component->dev,
+			"MICFIL PDM rate_min: %d rate_max: %d\n", rate->min, rate->max);
+		dev_dbg(component->dev, "MICFIL PDM channels_min: %d channels_max: %d\n",
+			channels->min, channels->max);
+		break;
 	default:
 		dev_err(component->dev, "Invalid DAI type %d\n", private->dai_config->type);
 		break;
diff --git a/sound/soc/sof/ipc3-topology.c b/sound/soc/sof/ipc3-topology.c
index ba4ef290b634..7a4932c152a9 100644
--- a/sound/soc/sof/ipc3-topology.c
+++ b/sound/soc/sof/ipc3-topology.c
@@ -286,6 +286,16 @@ static const struct sof_topology_token acpi2s_tokens[] = {
 		offsetof(struct sof_ipc_dai_acp_params, tdm_mode)},
 };
 
+/* MICFIL PDM */
+static const struct sof_topology_token micfil_pdm_tokens[] = {
+	{SOF_TKN_IMX_MICFIL_RATE,
+		SND_SOC_TPLG_TUPLE_TYPE_WORD, get_token_u32,
+		offsetof(struct sof_ipc_dai_micfil_params, pdm_rate)},
+	{SOF_TKN_IMX_MICFIL_CH,
+		SND_SOC_TPLG_TUPLE_TYPE_WORD, get_token_u32,
+		offsetof(struct sof_ipc_dai_micfil_params, pdm_ch)},
+};
+
 /* Core tokens */
 static const struct sof_topology_token core_tokens[] = {
 	{SOF_TKN_COMP_CORE_ID, SND_SOC_TPLG_TUPLE_TYPE_WORD, get_token_u32,
@@ -322,6 +332,8 @@ static const struct sof_token_info ipc3_token_list[SOF_TOKEN_COUNT] = {
 	[SOF_AFE_TOKENS] = {"AFE tokens", afe_tokens, ARRAY_SIZE(afe_tokens)},
 	[SOF_ACPDMIC_TOKENS] = {"ACPDMIC tokens", acpdmic_tokens, ARRAY_SIZE(acpdmic_tokens)},
 	[SOF_ACPI2S_TOKENS]   = {"ACPI2S tokens", acpi2s_tokens, ARRAY_SIZE(acpi2s_tokens)},
+	[SOF_MICFIL_TOKENS] = {"MICFIL PDM tokens",
+		micfil_pdm_tokens, ARRAY_SIZE(micfil_pdm_tokens)},
 };
 
 /**
@@ -1136,6 +1148,37 @@ static int sof_link_esai_load(struct snd_soc_component *scomp, struct snd_sof_da
 	return 0;
 }
 
+static int sof_link_micfil_load(struct snd_soc_component *scomp, struct snd_sof_dai_link *slink,
+				struct sof_ipc_dai_config *config, struct snd_sof_dai *dai)
+{
+	struct snd_soc_tplg_hw_config *hw_config = slink->hw_configs;
+	struct sof_dai_private_data *private = dai->private;
+	u32 size = sizeof(*config);
+	int ret;
+
+       /* handle master/slave and inverted clocks */
+	sof_dai_set_format(hw_config, config);
+
+	config->hdr.size = size;
+
+	/* parse the required set of MICFIL PDM tokens based on num_hw_cfgs */
+	ret = sof_update_ipc_object(scomp, &config->micfil, SOF_MICFIL_TOKENS, slink->tuples,
+				    slink->num_tuples, size, slink->num_hw_configs);
+	if (ret < 0)
+		return ret;
+
+	dev_info(scomp->dev, "MICFIL PDM config dai_index %d channel %d rate %d\n",
+		 config->dai_index, config->micfil.pdm_ch, config->micfil.pdm_rate);
+
+	dai->number_configs = 1;
+	dai->current_config = 0;
+	private->dai_config = kmemdup(config, size, GFP_KERNEL);
+	if (!private->dai_config)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int sof_link_acp_dmic_load(struct snd_soc_component *scomp, struct snd_sof_dai_link *slink,
 				  struct sof_ipc_dai_config *config, struct snd_sof_dai *dai)
 {
@@ -1559,6 +1602,9 @@ static int sof_ipc3_widget_setup_comp_dai(struct snd_sof_widget *swidget)
 		case SOF_DAI_IMX_ESAI:
 			ret = sof_link_esai_load(scomp, slink, config, dai);
 			break;
+		case SOF_DAI_IMX_MICFIL:
+			ret = sof_link_micfil_load(scomp, slink, config, dai);
+			break;
 		case SOF_DAI_AMD_BT:
 			ret = sof_link_acp_bt_load(scomp, slink, config, dai);
 			break;
diff --git a/sound/soc/sof/sof-audio.h b/sound/soc/sof/sof-audio.h
index 5d5eeb1a1a6f..99c940b22538 100644
--- a/sound/soc/sof/sof-audio.h
+++ b/sound/soc/sof/sof-audio.h
@@ -275,6 +275,7 @@ enum sof_tokens {
 	SOF_GAIN_TOKENS,
 	SOF_ACPDMIC_TOKENS,
 	SOF_ACPI2S_TOKENS,
+	SOF_MICFIL_TOKENS,
 
 	/* this should be the last */
 	SOF_TOKEN_COUNT,
diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index d3113f1865ed..c1f66ba0e987 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -296,6 +296,7 @@ static const struct sof_dai_types sof_dais[] = {
 	{"AFE", SOF_DAI_MEDIATEK_AFE},
 	{"ACPSP_VIRTUAL", SOF_DAI_AMD_SP_VIRTUAL},
 	{"ACPHS_VIRTUAL", SOF_DAI_AMD_HS_VIRTUAL},
+	{"MICFIL", SOF_DAI_IMX_MICFIL},
 
 };
 
@@ -1960,6 +1961,10 @@ static int sof_link_load(struct snd_soc_component *scomp, int index, struct snd_
 		token_id = SOF_ACPI2S_TOKENS;
 		num_tuples += token_list[SOF_ACPI2S_TOKENS].count;
 		break;
+	case SOF_DAI_IMX_MICFIL:
+		token_id = SOF_MICFIL_TOKENS;
+		num_tuples += token_list[SOF_MICFIL_TOKENS].count;
+		break;
 	default:
 		break;
 	}
-- 
2.25.1

