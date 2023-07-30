Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2241976870F
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 20:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjG3SId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 14:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjG3SIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 14:08:23 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5276D1B6
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 11:08:18 -0700 (PDT)
X-UUID: 09b555822f0411eeb20a276fd37b9834-20230731
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=7AGOYJf6IgitJjoa7VTj5ABs/QIt0Vp5FPUCdFNSDG0=;
        b=c/AbBvDmT1rZ4r8WplLNxxdFrimMcbieanc99EULugTYc1uOGz23ALQ4fMaKzhKMyPS7lPw1Dc2ZcXHV2RUlhx2mYvHq6o5JpenxrUu97ghUDK2cl0q7RAsF5T4ATHbremhBnabv/TVvDWfT/wcZZnI2ixLkve7DyM+e9pDoqdM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:b5aefbfa-0b55-4d4b-8f32-c94e53e4adb8,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:1fcc6f8,CLOUDID:0ffe7bd2-cd77-4e67-bbfd-aa4eaace762f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 09b555822f0411eeb20a276fd37b9834-20230731
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 105999778; Mon, 31 Jul 2023 02:08:08 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 31 Jul 2023 02:08:07 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 31 Jul 2023 02:08:06 +0800
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     <broonie@kernel.org>, <andrzej.hajda@intel.com>,
        <neil.armstrong@linaro.org>, <robert.foss@linaro.org>,
        <Laurent.pinchart@ideasonboard.com>,
        <kuninori.morimoto.gx@renesas.com>,
        <angelogioacchino.delregno@collabora.com>,
        <nfraprado@collabora.com>
CC:     <chunxu.li@mediatek.com>,
        <ajye_huang@compal.corp-partner.google.com>,
        <allen-kh.cheng@mediatek.com>, <dri-devel@lists.freedesktop.org>,
        <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: [v3 1/3] ASoC: hdmi-codec: Add event handler for hdmi TX
Date:   Mon, 31 Jul 2023 02:08:01 +0800
Message-ID: <20230730180803.22570-2-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230730180803.22570-1-jiaxin.yu@mediatek.com>
References: <20230730180803.22570-1-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the speaker and hdmi are connect to the same port of I2S,
when try to switch to speaker playback, we will find that hdmi
is always turned on automatically. The connection as follows:

			==> hdmi-codec ==> it6505(HDMI output)
DL1(FE) ==> I2S3(BE)
			==> rt1015p(SPEAKER output)

So in order to separately control their power on/off, we have
added a dapm widget to notify each output. Also the machine driver
need add a _PIN_SWITCH() on the output of the device that will
cause DAPM to keep the device powered down when not in use.

The purpose of adding .trigger callback here is to enable hdmi-codec
to notify the dp output driver to power on or off device.

Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
---
 include/sound/hdmi-codec.h    |  6 ++++++
 sound/soc/codecs/hdmi-codec.c | 32 ++++++++++++++++++++++++++++++--
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/include/sound/hdmi-codec.h b/include/sound/hdmi-codec.h
index 9b162ac1e08e..ea834a838754 100644
--- a/include/sound/hdmi-codec.h
+++ b/include/sound/hdmi-codec.h
@@ -81,6 +81,12 @@ struct hdmi_codec_ops {
 		       struct hdmi_codec_daifmt *fmt,
 		       struct hdmi_codec_params *hparms);
 
+	/*
+	 * PCM trigger callback.
+	 * Optional
+	 */
+	int (*trigger)(struct device *dev, int cmd);
+
 	/*
 	 * Shuts down the audio stream.
 	 * Mandatory
diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index d21f69f05342..6766b55c9b56 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -276,7 +276,31 @@ struct hdmi_codec_priv {
 	u8 iec_status[AES_IEC958_STATUS_SIZE];
 };
 
+static int hdmi_tx_event(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct hdmi_codec_priv *hcp = snd_soc_component_get_drvdata(component);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		if (hcp->hcd.ops->trigger)
+			hcp->hcd.ops->trigger(component->dev->parent, SNDRV_PCM_TRIGGER_START);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		if (hcp->hcd.ops->trigger)
+			hcp->hcd.ops->trigger(component->dev->parent, SNDRV_PCM_TRIGGER_STOP);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static const struct snd_soc_dapm_widget hdmi_widgets[] = {
+	SND_SOC_DAPM_OUT_DRV_E("SDB", SND_SOC_NOPM, 0, 0, NULL, 0, hdmi_tx_event,
+			       SND_SOC_DAPM_POST_PMD | SND_SOC_DAPM_PRE_PMU),
 	SND_SOC_DAPM_OUTPUT("TX"),
 	SND_SOC_DAPM_OUTPUT("RX"),
 };
@@ -831,9 +855,13 @@ static int hdmi_dai_probe(struct snd_soc_dai *dai)
 	struct hdmi_codec_daifmt *daifmt;
 	struct snd_soc_dapm_route route[] = {
 		{
-			.sink = "TX",
+			.sink = "SDB",
 			.source = dai->driver->playback.stream_name,
 		},
+		{
+			.sink = "TX",
+			.source = "SDB",
+		},
 		{
 			.sink = dai->driver->capture.stream_name,
 			.source = "RX",
@@ -848,7 +876,7 @@ static int hdmi_dai_probe(struct snd_soc_dai *dai)
 		if (!route[i].source || !route[i].sink)
 			continue;
 
-		ret = snd_soc_dapm_add_routes(dapm, &route[i], 1);
+		ret = snd_soc_dapm_add_routes(dapm, route, ARRAY_SIZE(route));
 		if (ret)
 			return ret;
 	}
-- 
2.25.1

