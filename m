Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D237DAF12
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 23:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjJ2W4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 18:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjJ2Wzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 18:55:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF79A10D2;
        Sun, 29 Oct 2023 15:55:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12A0C433CB;
        Sun, 29 Oct 2023 22:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620109;
        bh=Ntf0w8qRyYGhdO1CgTARNydagiZ086VTsRI5WB97xJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SZgeRFAJAkg0yLUb4VgRNFFLuZ9dhhVQfszxduV77bRLdEVZog8YC3YUgdVq8+va5
         N0Zf6L0Yi2tBglCYWiJHutmEiG4Ra8NfYZwVgpMr3GhAaB0+foNsnidf6xDcN4z4b0
         FRgOhWSlxcr+/dv91/H03ZY2375gqv8CFeh2UjuFANwqviLibxDFRwop7ZNpHTKQul
         gowKGz377FgPNwULTDsELzrKbv9atujqHpGLenTorqZb3a+Hy7vmjAiHSmcfCG3ZCX
         SsSezLm8QAKBKp6Oz2Y5fHV544xpauHXVmD7VWWfAsHyb+zab8tLPHW1JbubNnANVT
         A4ZOuMeHnwGMA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.5 18/52] ASoC: soc-dapm: Add helper for comparing widget name
Date:   Sun, 29 Oct 2023 18:53:05 -0400
Message-ID: <20231029225441.789781-18-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225441.789781-1-sashal@kernel.org>
References: <20231029225441.789781-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.9
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 76aca10ccb7c23a7b7a0d56e0bfde2c8cdddfe24 ]

Some drivers use one event callback for multiple widgets but still need
to perform a bit different actions based on actual widget.  This is done
by comparing widget name, however drivers tend to miss possible name
prefix.  Add a helper to solve common mistakes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20231003155710.821315-2-krzysztof.kozlowski@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/soc-dapm.h  |  1 +
 sound/soc/soc-component.c |  1 +
 sound/soc/soc-dapm.c      | 12 ++++++++++++
 3 files changed, 14 insertions(+)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 87f8e1793af15..295d63437e4d8 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -423,6 +423,7 @@ void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card);
 
 int snd_soc_dapm_update_dai(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params, struct snd_soc_dai *dai);
+int snd_soc_dapm_widget_name_cmp(struct snd_soc_dapm_widget *widget, const char *s);
 
 /* dapm path setup */
 int snd_soc_dapm_new_widgets(struct snd_soc_card *card);
diff --git a/sound/soc/soc-component.c b/sound/soc/soc-component.c
index 4356cc320fea0..10b5fe5a3af85 100644
--- a/sound/soc/soc-component.c
+++ b/sound/soc/soc-component.c
@@ -242,6 +242,7 @@ int snd_soc_component_notify_control(struct snd_soc_component *component,
 	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
 	struct snd_kcontrol *kctl;
 
+	/* When updating, change also snd_soc_dapm_widget_name_cmp() */
 	if (component->name_prefix)
 		snprintf(name, ARRAY_SIZE(name), "%s %s", component->name_prefix, ctl);
 	else
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 3091e8160bad7..5fd32185fe63d 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2726,6 +2726,18 @@ int snd_soc_dapm_update_dai(struct snd_pcm_substream *substream,
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_update_dai);
 
+int snd_soc_dapm_widget_name_cmp(struct snd_soc_dapm_widget *widget, const char *s)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(widget->dapm);
+	const char *wname = widget->name;
+
+	if (component->name_prefix)
+		wname += strlen(component->name_prefix) + 1; /* plus space */
+
+	return strcmp(wname, s);
+}
+EXPORT_SYMBOL_GPL(snd_soc_dapm_widget_name_cmp);
+
 /*
  * dapm_update_widget_flags() - Re-compute widget sink and source flags
  * @w: The widget for which to update the flags
-- 
2.42.0

