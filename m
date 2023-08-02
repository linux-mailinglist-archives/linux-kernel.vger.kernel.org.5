Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F76576D642
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjHBR7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbjHBR6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:58:34 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3322C1BF9
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:58:26 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe32016bc8so1309025e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 10:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690999104; x=1691603904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7Eujl9TONcNYsMANe/HBMPhXswxieLTEnBVw6VDaZs=;
        b=s3Ze57WvoBdJRWBk+oNorD4T96n4Clz5XVEh7ZN2O8aeoaDHpqSOR14ZBkCVUfP21q
         x18yJZRzpN3tpgvEZTXXAe7ooi3CK7xtbJurmgsoqtHblmM1G+nKmFSM4+2W0XwnxX0o
         9K9y98/XSe2pUvNwpcncrUPAoxNd0UIxEyFSP1kIMMC8nPrwwXfsXVzm4u+jvaVcfkq4
         vjXJ/0PTS5fQ3NJhljyw37VLDWvxZV1SSorsKJtNfUw7xwvqZybOvsNCcYTD0FRSV/WZ
         byX+kemK8LndSyfuYhDXNRJQSsnTfYCdNN8CXBy2A/9M5sEyv7+U4ceS/7PlGTBZZEWX
         HK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690999104; x=1691603904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e7Eujl9TONcNYsMANe/HBMPhXswxieLTEnBVw6VDaZs=;
        b=FpKkTXA4Sc7zVmT1qlg2PTOwj+Je6345jSB4Hzsj07t2RPTPiN4Ahwx5zatkH7xacU
         Gr29o++ncNz0bKQ0QYJOXoPJ6ukyz0mF6KtHc9WsBuJlb7Y0kkJvbOITMd/EO1+Bg8/u
         lGG2GnFrZ87D1PiDFeietMjYZ7Vc8c8zbV4RGcBSc+3acIY4vfXxufRASJSEeynb8UbW
         vRAZeiOmm+eyall0ixS+/1PiuEfKfU5DVIfOokZeeAaOM3E087IHiynkRvTQOpN/0fD/
         KyUtTJRk1yeFI6ZyLaoSo9Llmvyxz0Yj8c0D4/xIp0LitwtsodbZqh8ZaI9R23Xz0UUV
         lxBQ==
X-Gm-Message-State: ABy/qLarH7t8NrZhjRdqiPhKpf4YucFT8E67OGqwQezTf8oTBBhHmvXv
        iSh4E2SawCfbObXQQo3iBwKo/20rPUQ=
X-Google-Smtp-Source: APBJJlE9v5IMSE84zbQhqQGnEpXNG4pSickpNyGMWVqiZVTFXLE89xOKSB3Mt6As+quUq+SxsRUTZQ==
X-Received: by 2002:a1c:f309:0:b0:3fc:e7d:ca57 with SMTP id q9-20020a1cf309000000b003fc0e7dca57mr5432380wmq.2.1690999104110;
        Wed, 02 Aug 2023 10:58:24 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1])
        by smtp.gmail.com with ESMTPSA id l23-20020a7bc457000000b003fe20db88ebsm2192439wmi.31.2023.08.02.10.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 10:58:23 -0700 (PDT)
From:   Alper Nebi Yasak <alpernebiyasak@gmail.com>
To:     alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Alper Nebi Yasak <alpernebiyasak@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>
Subject: [PATCH 15/27] ASoC: mediatek: mt8173-rt5650: Map missing jack kcontrols
Date:   Wed,  2 Aug 2023 20:57:25 +0300
Message-Id: <20230802175737.263412-16-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230802175737.263412-1-alpernebiyasak@gmail.com>
References: <20230802175737.263412-1-alpernebiyasak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver does not properly map jack pins to kcontrols that PulseAudio
and PipeWire need to handle jack detection events. The RT5645 codec used
here can detect Headphone and Headset Mic connections. Expose both to
userspace as kcontrols.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---
Tested on a "Hana" Chromebook.

 sound/soc/mediatek/mt8173/mt8173-rt5650.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650.c b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
index 3ece4b5eaca2..18cf84bb25c7 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
@@ -54,6 +54,17 @@ static const struct snd_kcontrol_new mt8173_rt5650_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
 };
 
+static struct snd_soc_jack_pin mt8173_rt5650_jack_pins[] = {
+	{
+		.pin	= "Headphone",
+		.mask	= SND_JACK_HEADPHONE,
+	},
+	{
+		.pin	= "Headset Mic",
+		.mask	= SND_JACK_MICROPHONE,
+	},
+};
+
 static int mt8173_rt5650_hw_params(struct snd_pcm_substream *substream,
 				   struct snd_pcm_hw_params *params)
 {
@@ -128,11 +139,13 @@ static int mt8173_rt5650_init(struct snd_soc_pcm_runtime *runtime)
 	}
 
 	/* enable jack detection */
-	ret = snd_soc_card_jack_new(card, "Headset Jack",
-				    SND_JACK_HEADPHONE | SND_JACK_MICROPHONE |
-				    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
-				    SND_JACK_BTN_2 | SND_JACK_BTN_3,
-				    &mt8173_rt5650_jack);
+	ret = snd_soc_card_jack_new_pins(card, "Headset Jack",
+					 SND_JACK_HEADPHONE | SND_JACK_MICROPHONE |
+					 SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+					 SND_JACK_BTN_2 | SND_JACK_BTN_3,
+					 &mt8173_rt5650_jack,
+					 mt8173_rt5650_jack_pins,
+					 ARRAY_SIZE(mt8173_rt5650_jack_pins));
 	if (ret) {
 		dev_err(card->dev, "Can't new Headset Jack %d\n", ret);
 		return ret;
-- 
2.40.1

