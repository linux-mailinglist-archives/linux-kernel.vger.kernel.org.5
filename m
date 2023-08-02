Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4572776D641
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbjHBR7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbjHBR6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:58:25 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F048E19AD
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:58:23 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fe1e1142caso1617375e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 10:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690999102; x=1691603902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlBC1H0XtO+vTlN099a54STTMxr//GhxYmUmPY9nGaY=;
        b=P7SbG6nLbP5uQyIVD5oRSxcoBdInRHrHOSv3pvN/jypg+ocEyrjRbQ4lqEKp1vJiIu
         7mDOvNK00gS5ddxx1HL+aDnc287/Kef8HVateKq08UJ+ZxcQva9Q739eH7LKqylyQ/fz
         F66/1c6237DYGJ7C2P7le9/P9rNYRkgJB95gmL1ZDEfZ8wfaerwWkEUAWXGeiDjfxE+U
         TpYj3I1a81h68lFefEYaO6OOn0DJ39tBL5Yop8v3OTuu46N5a8rocO63RHcKojqrFgde
         z4Ip44DptNxtQ6sHAscXu8uNI+o+eo/aWuIYPBGLyoDeBYUCR+V7NCuCf4e7U1AfnM2Q
         RNxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690999102; x=1691603902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KlBC1H0XtO+vTlN099a54STTMxr//GhxYmUmPY9nGaY=;
        b=UhiZIYqS5vWN0MLEJEhUpTFrKp7+y2MSiFSLRsf2f0hgvCLkxWx+XxVKk9plnKKjcP
         0m6Nhh9vV0sVKcCqb/KFRNhK8zbIS0M8EGBIiKMLxHRkmeUmQRz58aYebORwaB5OI5vz
         ufz0N6F4R5DE3MNbb0uYGH3m3+/UJmdMwV+gvZVNe4Ve0Kp5hNzOY8ahtZ81pHIyQO/E
         /wm1+uTqDqKwNUwqpEyYMIh581wv7hf8Ik9HDZCsCvkMwFJZoccaOrUT/fCEMrDrvqio
         TMX4b8Q/cAf2Ym3UntLkKIPR8hMtnl5qu5ImfYIO3Fuv+y/n56/fgTCmijalV5ePUyEC
         qQwQ==
X-Gm-Message-State: ABy/qLYpXS0QpqBnq1V5SDx8soGFiR8G8ZD8OIBV1KtNhmyTX6a0KsoO
        l9MYqYWpW24/Ued+VX4VVYg=
X-Google-Smtp-Source: APBJJlGfeKrU/n8gCLLShGwZi3d6BtH6N8GQz9cTtygM4kg1m56ye3zCalthG5m6h7ODrfn0m0jQhw==
X-Received: by 2002:a7b:c8d2:0:b0:3fe:90f:8496 with SMTP id f18-20020a7bc8d2000000b003fe090f8496mr5507988wml.1.1690999102117;
        Wed, 02 Aug 2023 10:58:22 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1])
        by smtp.gmail.com with ESMTPSA id l23-20020a7bc457000000b003fe20db88ebsm2192439wmi.31.2023.08.02.10.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 10:58:21 -0700 (PDT)
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
Subject: [PATCH 14/27] ASoC: mediatek: mt8173-rt5650-rt5676: Map missing jack kcontrols
Date:   Wed,  2 Aug 2023 20:57:24 +0300
Message-Id: <20230802175737.263412-15-alpernebiyasak@gmail.com>
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

 .../mediatek/mt8173/mt8173-rt5650-rt5676.c    | 23 +++++++++++++++----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
index 8794720cea3a..ffb094284bfb 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
@@ -44,6 +44,17 @@ static const struct snd_kcontrol_new mt8173_rt5650_rt5676_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
 };
 
+static struct snd_soc_jack_pin mt8173_rt5650_rt5676_jack_pins[] = {
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
 static int mt8173_rt5650_rt5676_hw_params(struct snd_pcm_substream *substream,
 					  struct snd_pcm_hw_params *params)
 {
@@ -95,11 +106,13 @@ static int mt8173_rt5650_rt5676_init(struct snd_soc_pcm_runtime *runtime)
 				RT5677_CLK_SEL_I2S2_ASRC);
 
 	/* enable jack detection */
-	ret = snd_soc_card_jack_new(card, "Headset Jack",
-				    SND_JACK_HEADPHONE | SND_JACK_MICROPHONE |
-				    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
-				    SND_JACK_BTN_2 | SND_JACK_BTN_3,
-				    &mt8173_rt5650_rt5676_jack);
+	ret = snd_soc_card_jack_new_pins(card, "Headset Jack",
+					 SND_JACK_HEADPHONE | SND_JACK_MICROPHONE |
+					 SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+					 SND_JACK_BTN_2 | SND_JACK_BTN_3,
+					 &mt8173_rt5650_rt5676_jack,
+					 mt8173_rt5650_rt5676_jack_pins,
+					 ARRAY_SIZE(mt8173_rt5650_rt5676_jack_pins));
 	if (ret) {
 		dev_err(card->dev, "Can't new Headset Jack %d\n", ret);
 		return ret;
-- 
2.40.1

