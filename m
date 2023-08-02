Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1134176D633
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbjHBR6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234212AbjHBR6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:58:11 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF496A3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:58:09 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fe1e1142caso1615325e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 10:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690999088; x=1691603888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ln5Wo7yMvulq8m4RXX5h43LD0FJm5RWbml3d8jCXUmU=;
        b=QmAr5gO5OJHe2+KrJTzPsNSLD5fPvr8qGS0MTNj11WsaZ15vvacM8igaJSLKO2+rx/
         s2bIZ4URxkPfkRThv9kbjVm1PQ84GbyVSVwDitcqqAHobVs98Gq8tPKKGj5oq6yjrYBq
         M3AT+OVH2j81fUJVXnISuA7S3XPq6o4zIt1cJvWZAGtsVxp68dTMZDoEWhEwLHeZjALz
         NDkdS5RgI+MUDvbjFraVu4LaArsUgkCI0K6Idp0Gxr0/TqK0Aknxqb0eTcfsW6p2/8Q1
         dJFtoCYdHIR15I9fzdLeXTyj+dIizXMBNxmaR/4BBAuXzD2xS6lK7MMOZTY+o8qripOK
         hg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690999088; x=1691603888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ln5Wo7yMvulq8m4RXX5h43LD0FJm5RWbml3d8jCXUmU=;
        b=KtmecCQ3qLT4D2HOF/wyj5kOYPifU3wSqtJsBSxolI8cwjUd+Z66vYR7qbDUeQWjpU
         6rOa4NcU+Z5Gk+JZlo/jm8FRn8Uv1PyiAovcBeWAqbvIRNUNkxJ4V7YDI/Prk0eo3cH4
         pbHQlmZKiaVYjtQVKxi24vQr53D7/tLD8T93cJ1asSe+m5XU+0fn14/YQF1kkdoeyM5u
         hgW/DXEKEpU1hjB+Iyh9BDgLuvTLKlVs6LehuvfL5NXR5PGVqlhJjuwhOwBlI/002ugi
         F159R2TZt2cwe/jY3wQLhAVzNqu+1sChom1Efzx9usNgOC8G7rJO5MPJ9ETujM3RwjxB
         EVhA==
X-Gm-Message-State: ABy/qLbtjtJY/EyFe0TBRXTdbz+m9Z90LVHwrZ5jWpnYmPpmPIeUoJsF
        Ko2hmEiF43oLUU7mzUumi8M=
X-Google-Smtp-Source: APBJJlF+GHDkkxI4yAurYVIyjrAJMP1jkpuyyPKJGc0fIuSZm0v3MllDtBGvGXHm8voz6pfDIhYP7w==
X-Received: by 2002:a05:600c:21d5:b0:3fd:2e1d:eca1 with SMTP id x21-20020a05600c21d500b003fd2e1deca1mr5313451wmj.4.1690999088263;
        Wed, 02 Aug 2023 10:58:08 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1])
        by smtp.gmail.com with ESMTPSA id l23-20020a7bc457000000b003fe20db88ebsm2192439wmi.31.2023.08.02.10.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 10:58:07 -0700 (PDT)
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
Subject: [PATCH 07/27] ASoC: Intel: bytcr_wm5102: Map missing Line Out jack kcontrol
Date:   Wed,  2 Aug 2023 20:57:17 +0300
Message-Id: <20230802175737.263412-8-alpernebiyasak@gmail.com>
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

Commit ecd77d494ec9 ("ASoC: Intel: bytcr_wm5102: Add jack detect
support") maps kcontrols for Headphone and Headset Mic jacks for this
driver so that PulseAudio and PipeWire can handle jack detection events
for these peripherals.

The WM5102 codec used here can also distinguish between Headphone and
Line Out connections that go into the same physical port. Expose the
latter to userspace as a kcontrol as well and add the necessary widgets.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---

 sound/soc/intel/boards/bytcr_wm5102.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_wm5102.c b/sound/soc/intel/boards/bytcr_wm5102.c
index f2382d4cb76f..5c9e06ed1a53 100644
--- a/sound/soc/intel/boards/bytcr_wm5102.c
+++ b/sound/soc/intel/boards/bytcr_wm5102.c
@@ -131,6 +131,7 @@ static const struct snd_soc_dapm_widget byt_wm5102_widgets[] = {
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 	SND_SOC_DAPM_MIC("Internal Mic", NULL),
 	SND_SOC_DAPM_SPK("Speaker", NULL),
+	SND_SOC_DAPM_LINE("Line Out", NULL),
 	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
 			    platform_clock_control, SND_SOC_DAPM_PRE_PMU |
 			    SND_SOC_DAPM_POST_PMD),
@@ -144,6 +145,7 @@ static const struct snd_soc_dapm_route byt_wm5102_audio_map[] = {
 	{"Headset Mic", NULL, "Platform Clock"},
 	{"Internal Mic", NULL, "Platform Clock"},
 	{"Speaker", NULL, "Platform Clock"},
+	{"Line Out", NULL, "Platform Clock"},
 
 	{"Speaker", NULL, "SPKOUTLP"},
 	{"Speaker", NULL, "SPKOUTLN"},
@@ -177,6 +179,7 @@ static const struct snd_kcontrol_new byt_wm5102_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
 	SOC_DAPM_PIN_SWITCH("Internal Mic"),
 	SOC_DAPM_PIN_SWITCH("Speaker"),
+	SOC_DAPM_PIN_SWITCH("Line Out"),
 };
 
 static struct snd_soc_jack_pin byt_wm5102_pins[] = {
@@ -188,6 +191,10 @@ static struct snd_soc_jack_pin byt_wm5102_pins[] = {
 		.pin	= "Headset Mic",
 		.mask	= SND_JACK_MICROPHONE,
 	},
+	{
+		.pin	= "Line Out",
+		.mask	= SND_JACK_LINEOUT,
+	},
 };
 
 static int byt_wm5102_init(struct snd_soc_pcm_runtime *runtime)
-- 
2.40.1

