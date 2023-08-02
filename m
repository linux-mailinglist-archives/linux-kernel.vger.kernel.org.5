Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B55976D634
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbjHBR6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbjHBR6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:58:01 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F18A3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:58:00 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9bee2d320so901681fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 10:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690999079; x=1691603879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ci67Td9oMJsLWbpviA9NcbMT0ChoVa0sXVbZDuba2eI=;
        b=mzEQx3XK3X+y5S6AkjDT4iX/ITs0YrzNj1ep4Yo+ghza6vJhgwrxFYPNIaWuna9+zk
         hjr35fZEIIj4OOMJRBhNKCWwInDeO+Mt61eTr226d5m/hfS+FC6ApSLoInZbn/4Vl591
         VX+neJj2OtSvBnic97wVGQTJLOcE6CUL/kfPribacVzgWGJUb0K2Vug577NVz2A8zU9j
         fNYFE7i8Pp3P//3Qtjpo++eP8/JBYO2c6YyzkygvLcgJrx68Fj5aBQ4lYpO/LWnc9umK
         hyB+xbwRspqMBXYDQO3tbO3tNa6CSTjpKhTwpR7eCDDV7tPPPa9IwPs+mvrynyPllz9N
         Je+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690999079; x=1691603879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ci67Td9oMJsLWbpviA9NcbMT0ChoVa0sXVbZDuba2eI=;
        b=I5iH6Zmwy2BwyTSsTKZoK2lsMwpg7++mgR2qs3GcXT9yHQphjTA93rgNRu4fsKxm5M
         hdjDPDaJ3SfRmB6FrUpV9kkbgzcX2qPv7Ulv3qDrVvuk8so6Pv2yz9vvD2c0eA3hOhY3
         J0ONA81dK1UsptJcYqx518l3v8Bh+oI5k9ELxSyDsoGCv4FNc4hJrWVtq7XX4mSZSdKt
         WhOgMsDgDT31+z59YRspETawhMwdrDQNMDzJC366VvzOTh08GJBkek5BH9qjiv6hwxE+
         x+QacP8tJh+OPWvLlYVE9aR0RT+iNW2MGEzI9eZvTcfieVHW02w0EWTU78dOVK80j5wG
         4Htg==
X-Gm-Message-State: ABy/qLYFyRQWlFIcttUS2Q1K35Fl2+x6ou/06ScaScpKGv1+DruRjPMe
        HD6az6cxqy0KJXykaNFrBnA=
X-Google-Smtp-Source: APBJJlEzrYBdkRnwRPJ4NN3iObXeOWT2+1vk/p4PnAN6HWDNRkwLIBV6+U3Nxn7N1ETTwqwFIcZb4A==
X-Received: by 2002:a2e:3001:0:b0:2b9:ef0a:7d4b with SMTP id w1-20020a2e3001000000b002b9ef0a7d4bmr5792077ljw.31.1690999078378;
        Wed, 02 Aug 2023 10:57:58 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1])
        by smtp.gmail.com with ESMTPSA id l23-20020a7bc457000000b003fe20db88ebsm2192439wmi.31.2023.08.02.10.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 10:57:57 -0700 (PDT)
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
Subject: [PATCH 02/27] ASoC: amd: acp-rt5645: Map missing jack kcontrols
Date:   Wed,  2 Aug 2023 20:57:12 +0300
Message-Id: <20230802175737.263412-3-alpernebiyasak@gmail.com>
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

 sound/soc/amd/acp-rt5645.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/sound/soc/amd/acp-rt5645.c b/sound/soc/amd/acp-rt5645.c
index 532aa98a2241..c8ed1e0b1ccd 100644
--- a/sound/soc/amd/acp-rt5645.c
+++ b/sound/soc/amd/acp-rt5645.c
@@ -42,6 +42,16 @@
 #define CZ_PLAT_CLK 24000000
 
 static struct snd_soc_jack cz_jack;
+static struct snd_soc_jack_pin cz_jack_pins[] = {
+	{
+		.pin = "Headphones",
+		.mask = SND_JACK_HEADPHONE,
+	},
+	{
+		.pin = "Headset Mic",
+		.mask = SND_JACK_MICROPHONE,
+	},
+};
 
 static int cz_aif1_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params)
@@ -76,11 +86,13 @@ static int cz_init(struct snd_soc_pcm_runtime *rtd)
 	codec = asoc_rtd_to_codec(rtd, 0)->component;
 	card = rtd->card;
 
-	ret = snd_soc_card_jack_new(card, "Headset Jack",
-				SND_JACK_HEADPHONE | SND_JACK_MICROPHONE |
-				SND_JACK_BTN_0 | SND_JACK_BTN_1 |
-				SND_JACK_BTN_2 | SND_JACK_BTN_3,
-				&cz_jack);
+	ret = snd_soc_card_jack_new_pins(card, "Headset Jack",
+					 SND_JACK_HEADPHONE | SND_JACK_MICROPHONE |
+					 SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+					 SND_JACK_BTN_2 | SND_JACK_BTN_3,
+					 &cz_jack,
+					 cz_jack_pins,
+					 ARRAY_SIZE(cz_jack_pins));
 	if (ret) {
 		dev_err(card->dev, "HP jack creation failed %d\n", ret);
 		return ret;
-- 
2.40.1

