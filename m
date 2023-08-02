Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF18F76D637
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjHBR6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbjHBR6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:58:15 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15822A3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:58:14 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe1fc8768aso1458565e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 10:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690999092; x=1691603892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gA29wr7vIe71PHnjZ5O12+t0Upf2Tn7RCA7Ahjy5Xv0=;
        b=eUPPgU27Wo4JR9a2RIjYfG+xrznhiFt9Qe7qlU/+5xCKROjTMqCOKQuyxxbiACT0BO
         X8LR3/sOH47/yXSL31SYbZpkxpD6j8RFN5Y1DlDIttR7gbZ8S8X0i2JxnlvfH3o4wX+W
         m1TDvCHB9fKxLosYA3pbH4UypPxafLw4OU3trvvoM0Hvp1YcNe4GLPx/vz8V5o3FtyOW
         WQjqlzzzwgIrbNNeMoLJSv06ywQxuwD1+xee4JTf4rb58FpNp06uKNHrLDUUJrmMM1y2
         ufjo7mouFAdTL9DHyh8I9dWWRW9H8LSd19mvgdvrWaZ/DgDbXYtIdWEuzTgVfQHQfsiK
         0y+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690999092; x=1691603892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gA29wr7vIe71PHnjZ5O12+t0Upf2Tn7RCA7Ahjy5Xv0=;
        b=HpNHZxrchVAxlgm+2RdLgfhkJV6CsLdj06YVGxkrZz0GdyHkwin1KVemaIy2HWjzWV
         ks3Mc5//oX2+CSmiK0xrjmXQWIT+Yvos2Z4WHU1QlYLVIcuK0liYebKHYbXdDLowJyrs
         eIJhBH42zH6sqWzh2Fgyqnhb70a9SZmVo5w/Xv+2vEy1HJxmfa5WC3qbmx3L+jNQrDlc
         6uf0FXSv0ykX7rpR18zyod0K2Vaqei65W+JOYpCpwmkH629lO7JUK3/SMKyuYv/Sr2nI
         gImKlzR7Sl/Y/uK5MqbeUMl4ZfZOPay7E4d3RFuc53wc9lKu3nodYDooggY+jbCOJaDs
         zUQQ==
X-Gm-Message-State: ABy/qLYnMHnDMMYddWv8QMlekGpwZP5O/AQmACUsru7bmy255bgHMlyJ
        yey2ihu0ChYVgFOCiBM5VyY=
X-Google-Smtp-Source: APBJJlHngmzNEWhBf6DHJujPjqwuCj4M3FeWgtuZSVvq23YZ3ZtMNId2qLjVXZPX9ou5I5sdGphd8A==
X-Received: by 2002:a05:600c:2216:b0:3fe:16d3:7d60 with SMTP id z22-20020a05600c221600b003fe16d37d60mr5772777wml.9.1690999092232;
        Wed, 02 Aug 2023 10:58:12 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1])
        by smtp.gmail.com with ESMTPSA id l23-20020a7bc457000000b003fe20db88ebsm2192439wmi.31.2023.08.02.10.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 10:58:11 -0700 (PDT)
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
Subject: [PATCH 09/27] ASoC: Intel: kbl_da7219_max98927: Map missing Line Out jack kcontrol
Date:   Wed,  2 Aug 2023 20:57:19 +0300
Message-Id: <20230802175737.263412-10-alpernebiyasak@gmail.com>
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

Commit b9f53b9fc14e ("ASoC: Intel: kbl_da7219_max98927: remap jack
pins") maps kcontrols for Headphone and Headset Mic jacks for this
driver so that PulseAudio and PipeWire can handle jack detection events
for these peripherals.

The DA7219 codec used here can also distinguish between Headphone and
Line Out connections that go into the same physical port. Expose the
latter to userspace as a kcontrol as well and add the necessary widgets.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---

 sound/soc/intel/boards/kbl_da7219_max98927.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/intel/boards/kbl_da7219_max98927.c b/sound/soc/intel/boards/kbl_da7219_max98927.c
index ad4223fee0c5..a1f8234c77bd 100644
--- a/sound/soc/intel/boards/kbl_da7219_max98927.c
+++ b/sound/soc/intel/boards/kbl_da7219_max98927.c
@@ -102,6 +102,7 @@ static const struct snd_kcontrol_new kabylake_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
 	SOC_DAPM_PIN_SWITCH("Left Spk"),
 	SOC_DAPM_PIN_SWITCH("Right Spk"),
+	SOC_DAPM_PIN_SWITCH("Line Out"),
 };
 
 static const struct snd_soc_dapm_widget kabylake_widgets[] = {
@@ -109,6 +110,7 @@ static const struct snd_soc_dapm_widget kabylake_widgets[] = {
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 	SND_SOC_DAPM_SPK("Left Spk", NULL),
 	SND_SOC_DAPM_SPK("Right Spk", NULL),
+	SND_SOC_DAPM_LINE("Line Out", NULL),
 	SND_SOC_DAPM_MIC("SoC DMIC", NULL),
 	SND_SOC_DAPM_SPK("HDMI1", NULL),
 	SND_SOC_DAPM_SPK("HDMI2", NULL),
@@ -127,6 +129,10 @@ static struct snd_soc_jack_pin jack_pins[] = {
 		.pin    = "Headset Mic",
 		.mask   = SND_JACK_MICROPHONE,
 	},
+	{
+		.pin    = "Line Out",
+		.mask   = SND_JACK_MICROPHONE,
+	},
 };
 
 static const struct snd_soc_dapm_route kabylake_map[] = {
@@ -182,6 +188,7 @@ static const struct snd_soc_dapm_route kabylake_ssp1_map[] = {
 
 	{ "Headphone Jack", NULL, "Platform Clock" },
 	{ "Headset Mic", NULL, "Platform Clock" },
+	{ "Line Out", NULL, "Platform Clock" },
 };
 
 static int kabylake_ssp0_hw_params(struct snd_pcm_substream *substream,
-- 
2.40.1

