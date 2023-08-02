Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FE776D63A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbjHBR6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234278AbjHBR6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:58:16 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A8EA3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:58:15 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fe2d218eedso1552915e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 10:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690999094; x=1691603894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNnRUj13sGKYiaqiH+uUTgS+yS59+A+KbZaO7xd9beM=;
        b=lkUVB3Er6Tk4LtvOzzFy83WjQTHW44mVzjLLbvGWYul576VCJEMkF8DHZhFSneRvs4
         FHhPDUsl0A/XDlnt9uJF8cDUfJNEZwP9vEysWWdghsgRnZ0/chZeN9CqgxVrYZNy+nGP
         S0gj35ahl4JEC+1+TbxKtDq8zKkgPo1MxPc0qEHuq5C9EVtS31K2lokeftsT7+X+Dcec
         o/H5LdipYetf+g0AosAO0r2fZqfh4QTLs5x3W+te7VnKDkF8Z6QBeFAZKA10HjFmsNhp
         Ai9VwROFVoKnv9wDuN6mEgRS4+oo23cxN3arsslC19XbJHKaTBjVl067/MvGkhnY9Qch
         VAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690999094; x=1691603894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNnRUj13sGKYiaqiH+uUTgS+yS59+A+KbZaO7xd9beM=;
        b=ELuC3l4e30E9vddg2GYu0Rp4Fkt9weWJHapRu40rPjb+QJReex8lXmXS7YnnAuAfNw
         oTv8eWC9BHESJJhfZQoOHPUOplaPJ8gNtY65vjAAGr/pRh2IXArkLnll8i7xQUzH/s+Q
         8hcWSpzPPosrhM+9jk9D4EhVOdfkwPEMGeIuufzlEIUQsdUhVa92uh9M8Y7HEKeXj4V/
         FDnji92MGVrXozxNaQ0WEt7YFBpLYoSzD+E/m9QAnUmrmV8ylBXs3wMxjUbZjXQlNOPJ
         jZg+/3eowJ7k6NZmAfRKIS0WNv6q9HDdfAehRwfkdeKF2w5mxID5OuGKrISgNU9kSWbi
         RSsw==
X-Gm-Message-State: ABy/qLa0ivMAY8EyXf+McC1jJqOEz3SEGkTyc0gka+TxbBXwkZzX3SBM
        tH8ZD0TqUj6QnABZ0GVIE8c=
X-Google-Smtp-Source: APBJJlGBjIeCNfjfwIJCCvX2YxfjXB5idSZwIp2n/1KH4BsL9nfFvZi5dAIObjjgRpBFhDgrA0/aLw==
X-Received: by 2002:a05:600c:281:b0:3fb:dff2:9f17 with SMTP id 1-20020a05600c028100b003fbdff29f17mr5479686wmk.15.1690999094138;
        Wed, 02 Aug 2023 10:58:14 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1])
        by smtp.gmail.com with ESMTPSA id l23-20020a7bc457000000b003fe20db88ebsm2192439wmi.31.2023.08.02.10.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 10:58:13 -0700 (PDT)
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
Subject: [PATCH 10/27] ASoC: Intel: sof_da7219_max98373: Map missing Line Out jack kcontrol
Date:   Wed,  2 Aug 2023 20:57:20 +0300
Message-Id: <20230802175737.263412-11-alpernebiyasak@gmail.com>
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

Commit 2913bb1f6830 ("ASoC: Intel: sof_da7219_max98373: remap jack
pins") maps kcontrols for Headphone and Headset Mic jacks for this
driver so that PulseAudio and PipeWire can handle jack detection events
for these peripherals.

The DA7219 codec used here can also distinguish between Headphone and
Line Out connections that go into the same physical port. Expose the
latter to userspace as a kcontrol as well and add the necessary widgets.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---

 sound/soc/intel/boards/sof_da7219_max98373.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/intel/boards/sof_da7219_max98373.c b/sound/soc/intel/boards/sof_da7219_max98373.c
index 740aa11cb019..bbd47e7e4343 100644
--- a/sound/soc/intel/boards/sof_da7219_max98373.c
+++ b/sound/soc/intel/boards/sof_da7219_max98373.c
@@ -65,6 +65,7 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 static const struct snd_kcontrol_new controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+	SOC_DAPM_PIN_SWITCH("Line Out"),
 	SOC_DAPM_PIN_SWITCH("Left Spk"),
 	SOC_DAPM_PIN_SWITCH("Right Spk"),
 };
@@ -72,6 +73,7 @@ static const struct snd_kcontrol_new controls[] = {
 static const struct snd_kcontrol_new m98360a_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+	SOC_DAPM_PIN_SWITCH("Line Out"),
 	SOC_DAPM_PIN_SWITCH("Spk"),
 };
 
@@ -79,6 +81,7 @@ static const struct snd_kcontrol_new m98360a_controls[] = {
 static const struct snd_soc_dapm_widget widgets[] = {
 	SND_SOC_DAPM_HP("Headphone Jack", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_LINE("Line Out", NULL),
 
 	SND_SOC_DAPM_SPK("Left Spk", NULL),
 	SND_SOC_DAPM_SPK("Right Spk", NULL),
@@ -98,6 +101,7 @@ static const struct snd_soc_dapm_route audio_map[] = {
 
 	{ "Headphone Jack", NULL, "Platform Clock" },
 	{ "Headset Mic", NULL, "Platform Clock" },
+	{ "Line Out", NULL, "Platform Clock" },
 
 	{ "Left Spk", NULL, "Left BE_OUT" },
 	{ "Right Spk", NULL, "Right BE_OUT" },
@@ -110,6 +114,7 @@ static const struct snd_soc_dapm_route audio_map[] = {
 static const struct snd_soc_dapm_widget max98360a_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone Jack", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_LINE("Line Out", NULL),
 
 	SND_SOC_DAPM_SPK("Spk", NULL),
 
@@ -128,6 +133,7 @@ static const struct snd_soc_dapm_route max98360a_map[] = {
 
 	{ "Headphone Jack", NULL, "Platform Clock" },
 	{ "Headset Mic", NULL, "Platform Clock" },
+	{ "Line Out", NULL, "Platform Clock" },
 
 	{"Spk", NULL, "Speaker"},
 
@@ -144,6 +150,10 @@ static struct snd_soc_jack_pin jack_pins[] = {
 		.pin    = "Headset Mic",
 		.mask   = SND_JACK_MICROPHONE,
 	},
+	{
+		.pin    = "Line Out",
+		.mask   = SND_JACK_LINEOUT,
+	},
 };
 
 static struct snd_soc_jack headset;
-- 
2.40.1

