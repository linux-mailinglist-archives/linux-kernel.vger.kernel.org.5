Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D7D76DFBB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 07:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbjHCF01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 01:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjHCF0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 01:26:22 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6624199F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 22:26:15 -0700 (PDT)
X-UUID: 41754fe231be11ee9cb5633481061a41-20230803
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=FkR+gqGCuuesY9WOQbPQ2Y2ld+iDLFnZPn/SNaXxV5E=;
        b=D/+DfHPZ2FU502wGNVO1XdW+UcLF27SZTd9nIZDHJpJ0jKfUSW6U79/XwyoleGuGJ9Wav3CLORxCNygJM5+EwEsH7idnP9ZmtE97cpDZ0zn11GCI+D527D0lRfbOadLtnUEo+5YTUqEcsIySWDgmNRxwT8mFe0/ao7aokCKTFEs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:31c507b6-1201-4754-bfff-222274acbb9b,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.30,REQID:31c507b6-1201-4754-bfff-222274acbb9b,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:1fcc6f8,CLOUDID:b4cbd6a0-0933-4333-8d4f-6c3c53ebd55b,B
        ulkID:230803132610T9EIB3X3,BulkQuantity:2,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:43,QS:nil,BEC:nil,COL:0,
        OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,
        TF_CID_SPAM_FSD
X-UUID: 41754fe231be11ee9cb5633481061a41-20230803
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 211902098; Thu, 03 Aug 2023 13:26:10 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 3 Aug 2023 13:26:09 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 3 Aug 2023 13:26:09 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/3] ASoC: mediatek: mt8188-mt6359: support dynamic pinctrl
Date:   Thu, 3 Aug 2023 13:26:05 +0800
Message-ID: <20230803052607.25843-2-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230803052607.25843-1-trevor.wu@mediatek.com>
References: <20230803052607.25843-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid power leakage, it is recommended to replace the default pinctrl
state with dynamic pinctrl since certain audio pinmux functions can
remain in a HIGH state even when audio is disabled. Linking pinctrl with
DAPM using SND_SOC_DAPM_PINCTRL will ensure that audio pins remain in
GPIO mode by default and only switch to an audio function when necessary.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 sound/soc/mediatek/mt8188/mt8188-mt6359.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/sound/soc/mediatek/mt8188/mt8188-mt6359.c b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
index 7c9e08e6a4f5..e7ac2b6671d3 100644
--- a/sound/soc/mediatek/mt8188/mt8188-mt6359.c
+++ b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
@@ -246,6 +246,11 @@ static const struct snd_soc_dapm_widget mt8188_mt6359_widgets[] = {
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 	SND_SOC_DAPM_SINK("HDMI"),
 	SND_SOC_DAPM_SINK("DP"),
+
+	/* dynamic pinctrl */
+	SND_SOC_DAPM_PINCTRL("ETDM_SPK_PIN", "aud_etdm_spk_on", "aud_etdm_spk_off"),
+	SND_SOC_DAPM_PINCTRL("ETDM_HP_PIN", "aud_etdm_hp_on", "aud_etdm_hp_off"),
+	SND_SOC_DAPM_PINCTRL("MTKAIF_PIN", "aud_mtkaif_on", "aud_mtkaif_off"),
 };
 
 static const struct snd_kcontrol_new mt8188_mt6359_controls[] = {
@@ -267,6 +272,7 @@ static int mt8188_mt6359_mtkaif_calibration(struct snd_soc_pcm_runtime *rtd)
 		snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
 	struct snd_soc_component *cmpnt_codec =
 		asoc_rtd_to_codec(rtd, 0)->component;
+	struct snd_soc_dapm_widget *pin_w = NULL, *w;
 	struct mtk_base_afe *afe;
 	struct mt8188_afe_private *afe_priv;
 	struct mtkaif_param *param;
@@ -306,6 +312,18 @@ static int mt8188_mt6359_mtkaif_calibration(struct snd_soc_pcm_runtime *rtd)
 		return 0;
 	}
 
+	for_each_card_widgets(rtd->card, w) {
+		if (!strcmp(w->name, "MTKAIF_PIN")) {
+			pin_w = w;
+			break;
+		}
+	}
+
+	if (pin_w)
+		dapm_pinctrl_event(pin_w, NULL, SND_SOC_DAPM_PRE_PMU);
+	else
+		dev_dbg(afe->dev, "%s(), no pinmux widget, please check if default on\n", __func__);
+
 	pm_runtime_get_sync(afe->dev);
 	mt6359_mtkaif_calibration_enable(cmpnt_codec);
 
@@ -403,6 +421,9 @@ static int mt8188_mt6359_mtkaif_calibration(struct snd_soc_pcm_runtime *rtd)
 	for (i = 0; i < MT8188_MTKAIF_MISO_NUM; i++)
 		param->mtkaif_phase_cycle[i] = mtkaif_phase_cycle[i];
 
+	if (pin_w)
+		dapm_pinctrl_event(pin_w, NULL, SND_SOC_DAPM_POST_PMD);
+
 	dev_dbg(afe->dev, "%s(), end, calibration ok %d\n",
 		__func__, param->mtkaif_calibration_ok);
 
-- 
2.18.0

