Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202DE7B6D8A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbjJCP5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjJCP5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:57:22 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D73B7
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 08:57:17 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-991c786369cso184635566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 08:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696348636; x=1696953436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=168VbodA38Hdi5eAfuNgKvUwcfZckCEtb5Hwk95lQ/Q=;
        b=CeAeEuVxmM9DqP0YxPLd+BognG8hCbMNVcieM9ACDCulZq7HW1KoAx9r7IICzdXLJ9
         TnncwebT87V89+b4AqI+TSrG9nzLYh6fkWXsMM1sQGitNih+6e0AaEekuhkQXsBmVP2o
         0z8oRGglXiUq8lj/NpHNhxFoPL01fWmmCKgPu4TygX7hbAsVDe44vDtVKRcUGO/5yWb+
         8oIPhss6CFRBiwOESDDx2wB0ZEmhE6efN3YcEK6HEfpJ4CbcwKPCl1mgVGKgjjG0kQ83
         HGmL2ny7J+rYe9uvxv6QTw1ai4x9uJDG6iSqPl0DluXMaEpB0siu3yNir56C9Mik3hhl
         Tt1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696348636; x=1696953436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=168VbodA38Hdi5eAfuNgKvUwcfZckCEtb5Hwk95lQ/Q=;
        b=QMSCKL5x0Vmo/8sEm4eDqzLF12zcaUPN5jk54cCHUvlLjOdZ10bgCJnYeIb5tICJ3G
         LPCyjlNyVF3tFxWQBJwD9vUvgF+jac0dm15EoNKKi2DYW2lg3ZOLxYaT57KNeJJvaHlv
         L2xNTjv7iJU5b2IqK4nGKN4SD5yymfvIGkm8KSvIiF+aBmkGC0nu5/fFbEi7f3NIbIG/
         Of31mHRHfFZRUGZYxUr9G2qsrRI3FGvKHnR9RAP+y9Kcrp2y2dGLP1uFKaeTK6UaPBYE
         4v/1Y5LGk0GRWX99d3Ny5K7Je0aOVJHoQ/8S1vU/qcSr2mzeeZJxG8o+8JshvmezKXpw
         I90Q==
X-Gm-Message-State: AOJu0Yxpo9uvdXn8LSPuHAtUMi6+cr78PS9irKMuQgDw+kO4XrY62Q8+
        9Grrx9GE71MNFgYlTOi2M1blCA==
X-Google-Smtp-Source: AGHT+IFxb7p6HyTQDTwuHqjaxVz5+dsTwm+VvkHaxagLHnQgS8VYvxoMpoZBnybgXCeiPC4gYQTmqQ==
X-Received: by 2002:a17:906:51db:b0:9b2:abda:2543 with SMTP id v27-20020a17090651db00b009b2abda2543mr14616486ejk.65.1696348636295;
        Tue, 03 Oct 2023 08:57:16 -0700 (PDT)
Received: from krzk-bin.. (5-157-101-10.dyn.eolo.it. [5.157.101.10])
        by smtp.gmail.com with ESMTPSA id w25-20020a170906481900b0099bc2d1429csm1288088ejq.72.2023.10.03.08.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 08:57:15 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] ASoC: soc-dapm: Add helper for comparing widget name
Date:   Tue,  3 Oct 2023 17:57:09 +0200
Message-Id: <20231003155710.821315-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003155710.821315-1-krzysztof.kozlowski@linaro.org>
References: <20231003155710.821315-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers use one event callback for multiple widgets but still need
to perform a bit different actions based on actual widget.  This is done
by comparing widget name, however drivers tend to miss possible name
prefix.  Add a helper to solve common mistakes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 include/sound/soc-dapm.h  |  1 +
 sound/soc/soc-component.c |  1 +
 sound/soc/soc-dapm.c      | 12 ++++++++++++
 3 files changed, 14 insertions(+)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index d2faec9a323e..433543eb82b9 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -469,6 +469,7 @@ void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card);
 
 int snd_soc_dapm_update_dai(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params, struct snd_soc_dai *dai);
+int snd_soc_dapm_widget_name_cmp(struct snd_soc_dapm_widget *widget, const char *s);
 
 /* dapm path setup */
 int snd_soc_dapm_new_widgets(struct snd_soc_card *card);
diff --git a/sound/soc/soc-component.c b/sound/soc/soc-component.c
index 69198de39e79..4d7c2e3c929a 100644
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
index 2512aadf95f7..8f22ce857f4a 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2728,6 +2728,18 @@ int snd_soc_dapm_update_dai(struct snd_pcm_substream *substream,
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
2.34.1

