Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E14176D652
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 20:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbjHBSA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 14:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbjHBR7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:59:52 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A023C0B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:58:51 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbc244d384so1529055e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 10:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690999122; x=1691603922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7E+xhja+1jrCpHxegbBsk22hE7b38rXeL+uTtQJDC68=;
        b=ST/5jqkzflkWDXQ7+gy1tnzteCKA9DH+Zn3Z1bd3QWdweQMyxUoz3JNZy29M0TXkAk
         D8Luxt8lV3Y6OPtuKagLAhF2wyOk8n9x48E3AzWvSZF99I6hnGP1kmm1K3LcXvP0aXA1
         W3EteyHyGFO4Itb0ymixr81ge2PuwGmULbcmzj/bDKqrleD2wQ6oSxxU8ouxFJz9ZdJe
         yNKtdhiQMAZfAOd/XgA+XFcCCoTWHkS+Rq1z5zVEz0y9WVg5YchGPUbYYzaIoQw8NImi
         iT69PeQ3SA08IBAn3r/oTCgQvMW9VbqXZZHwWY/goiqG7BNWaoPDJutDmCETgB9ZwgGm
         4nqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690999122; x=1691603922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7E+xhja+1jrCpHxegbBsk22hE7b38rXeL+uTtQJDC68=;
        b=TMo9uuUGxtBIySqk74PjEtaC1lahSwRc9bhZqPhIZ3FjEmODajGc+5eeZwKm/DWNob
         zozaZjpoYJMvOqLkysrP29OivlCQmjAI9FF0TOJyFWVF1XahrXWxMmR1cfSHwpC7i6RH
         wxfoJsreJ5qCQ5lj18S6Ve1lzpY+Lr8nD5Dl06HwoFQNdm3HcpHjxsT4SJPVIk+acxZk
         4sz4Fv3N4Eqn9qJOAdWNhFmNz6V7EH6MxDsRjmQIE+Apl4eUN9GQb87Yk0Apk3hgIkUW
         ppkYAeei4eh4vNZUVK09rr6nrT8Q4dWNpqrrT3rrwfEdMA/x88WMJ8o01Jctqw3NbCFW
         eDZg==
X-Gm-Message-State: ABy/qLbLBQcjqBqJ1qfUmuPIK/SxmPYoPTqIeCkHLh8gSulEmJd6wJKH
        5aELki6KbVpNhh2huoBR1mw=
X-Google-Smtp-Source: APBJJlGzX3CO1LF4O7+6d9YH3/jJclKl+auO3bb9ktPlErNofRTvqIfFV9fV871SszD/KIJLlcRuKQ==
X-Received: by 2002:a05:600c:20f:b0:3fb:fa9f:5292 with SMTP id 15-20020a05600c020f00b003fbfa9f5292mr5339041wmi.25.1690999121618;
        Wed, 02 Aug 2023 10:58:41 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1])
        by smtp.gmail.com with ESMTPSA id l23-20020a7bc457000000b003fe20db88ebsm2192439wmi.31.2023.08.02.10.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 10:58:41 -0700 (PDT)
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
Subject: [PATCH 24/27] ASoC: rockchip: rockchip_rt5645: Map missing jack kcontrols
Date:   Wed,  2 Aug 2023 20:57:34 +0300
Message-Id: <20230802175737.263412-25-alpernebiyasak@gmail.com>
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
here supports detecting Headphone and Headset Mic connections. Expose
both to userspace as kcontrols.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---

 sound/soc/rockchip/rockchip_rt5645.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_rt5645.c b/sound/soc/rockchip/rockchip_rt5645.c
index e73a342b7953..ef9fdf0386cb 100644
--- a/sound/soc/rockchip/rockchip_rt5645.c
+++ b/sound/soc/rockchip/rockchip_rt5645.c
@@ -22,6 +22,16 @@
 #define DRV_NAME "rockchip-snd-rt5645"
 
 static struct snd_soc_jack headset_jack;
+static struct snd_soc_jack_pin headset_jack_pins[] = {
+	{
+		.pin = "Headphones",
+		.mask = SND_JACK_HEADPHONE,
+	},
+	{
+		.pin = "Headset Mic",
+		.mask = SND_JACK_MICROPHONE,
+	},
+};
 
 static const struct snd_soc_dapm_widget rk_dapm_widgets[] = {
 	SND_SOC_DAPM_HP("Headphones", NULL),
@@ -103,11 +113,13 @@ static int rk_init(struct snd_soc_pcm_runtime *runtime)
 	int ret;
 
 	/* Enable Headset and 4 Buttons Jack detection */
-	ret = snd_soc_card_jack_new(card, "Headset Jack",
-				    SND_JACK_HEADPHONE | SND_JACK_MICROPHONE |
-				    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
-				    SND_JACK_BTN_2 | SND_JACK_BTN_3,
-				    &headset_jack);
+	ret = snd_soc_card_jack_new_pins(card, "Headset Jack",
+					 SND_JACK_HEADPHONE | SND_JACK_MICROPHONE |
+					 SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+					 SND_JACK_BTN_2 | SND_JACK_BTN_3,
+					 &headset_jack,
+					 headset_jack_pins,
+					 ARRAY_SIZE(headset_jack_pins));
 	if (ret) {
 		dev_err(card->dev, "New Headset Jack failed! (%d)\n", ret);
 		return ret;
-- 
2.40.1

