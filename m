Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C7F7B6D89
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239438AbjJCP5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjJCP5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:57:23 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C149E
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 08:57:19 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso198488366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 08:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696348637; x=1696953437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GTMTkkvOrFaQjz0yOJaB7Q7/cPC8x6m+P9hBCS11kOw=;
        b=dyGtL9vVsFUMN/ZVcJsdpKPa6rpnPkhfC4dWHIA8hvJER+OuM+N7tfOOm+aBI5FgvD
         ooaSgZeCxHiGnwd7XrEpryNwTDK29A/TKd+SV2TqI/+BY86igyBQwLujLxoPsLcyeaNC
         3boQtHZ1/bodJ7zGVSo+A35eVq9kZzTPnBMFvW1bVCQVWbvGSjrA3QfiDkYc4YxsPLqX
         dncTZWVqoyDtpKTlTOc1XJyBa18pRhxukxhDTvin1oz4V9GOGyu/JbpWAnynJIexeD2O
         xdCbhhyN/DPEaoyz6y5Ku8Q9+YHJqrfNKGF6Z8o/88qPSIPMzNrho/uH/TW9n0KIxL7h
         F6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696348637; x=1696953437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GTMTkkvOrFaQjz0yOJaB7Q7/cPC8x6m+P9hBCS11kOw=;
        b=d6B+El1wcGFKWDOvD4D9nj5pZTWGsNqbcriV7Q+ZMNlFVCSkMxZduJYtkGVqVIfv/f
         1B+Km5fuUnFGf/DZtL4p2etdRqOsD95S+4Mrt5okAW6/atuGxms37ksSs5mTMA9XKyq6
         qlgqlNjhkdCzfOCBBqwfXg+evfT/Uh5kdRZBlV8/2viLWGqV2pq+6gJfVYc9oidYIQr7
         ftsA0p31hMw27Sx+Vtf3wzdF4+vYlexDSbcErmO6R4VtP9jHXypP/3KGJg1A9koCaH2o
         Ys/sSccre6Nvh3C1K302OIxh1BL/mjT3lFE81lSi9FP+eeTKkar4jG3It+s74hV6LTsk
         c8WA==
X-Gm-Message-State: AOJu0YwRFOa7THYYrz7zTux9gQ2LyjFZMhFral4c4kVHdKKh6zYLTnZi
        9nplI2qjvHtf+AKetEvVX51J8I6uU//KAywZmVBMOg==
X-Google-Smtp-Source: AGHT+IH6Iv8pRe5kVjLJr/VnS5qxhiKaTIKJ7fgCvAijxKTfbrDX6qtvCp9N5M3hF1FzRbOXyUwQig==
X-Received: by 2002:a17:906:7383:b0:9ae:5aa5:ee6c with SMTP id f3-20020a170906738300b009ae5aa5ee6cmr14822922ejl.12.1696348637599;
        Tue, 03 Oct 2023 08:57:17 -0700 (PDT)
Received: from krzk-bin.. (5-157-101-10.dyn.eolo.it. [5.157.101.10])
        by smtp.gmail.com with ESMTPSA id w25-20020a170906481900b0099bc2d1429csm1288088ejq.72.2023.10.03.08.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 08:57:17 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] ASoC: codecs: wsa-macro: handle component name prefix
Date:   Tue,  3 Oct 2023 17:57:10 +0200
Message-Id: <20231003155710.821315-3-krzysztof.kozlowski@linaro.org>
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

When comparing widget names in wsa_macro_spk_boost_event(), consider
also the component's name prefix.  Otherwise the WSA codec won't have
proper mixer setup resulting in no sound playback through speakers.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/lpass-wsa-macro.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index ea6e3fa7e9e1..7e21cec3c2fb 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -1675,12 +1675,12 @@ static int wsa_macro_spk_boost_event(struct snd_soc_dapm_widget *w,
 	u16 boost_path_ctl, boost_path_cfg1;
 	u16 reg, reg_mix;
 
-	if (!strcmp(w->name, "WSA_RX INT0 CHAIN")) {
+	if (!snd_soc_dapm_widget_name_cmp(w, "WSA_RX INT0 CHAIN")) {
 		boost_path_ctl = CDC_WSA_BOOST0_BOOST_PATH_CTL;
 		boost_path_cfg1 = CDC_WSA_RX0_RX_PATH_CFG1;
 		reg = CDC_WSA_RX0_RX_PATH_CTL;
 		reg_mix = CDC_WSA_RX0_RX_PATH_MIX_CTL;
-	} else if (!strcmp(w->name, "WSA_RX INT1 CHAIN")) {
+	} else if (!snd_soc_dapm_widget_name_cmp(w, "WSA_RX INT1 CHAIN")) {
 		boost_path_ctl = CDC_WSA_BOOST1_BOOST_PATH_CTL;
 		boost_path_cfg1 = CDC_WSA_RX1_RX_PATH_CFG1;
 		reg = CDC_WSA_RX1_RX_PATH_CTL;
-- 
2.34.1

