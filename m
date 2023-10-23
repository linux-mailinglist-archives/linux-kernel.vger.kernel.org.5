Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149C17D2F08
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbjJWJzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbjJWJy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:54:58 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E0A10E9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:54:51 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32db8924201so2094043f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698054888; x=1698659688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohG7h5MVOd61zy+5ypL65RpxKjVv+oL8L5RUWwJJdI0=;
        b=zt1WSV923YXZ9jiqUWxltIavwRi0qJrm3ZdsnmiGXDn4g5RzGRzoOKj2FcSIug+3G4
         STQT703eYTQCjkO4vkkps4aAlLoMr/BNeRiz2wPmKhhzxXUL5ddUytw72iZlh9wH7nN4
         5tiK8DcJGHzNBdNKD42B4jnU5r/J6nLE6cAaKcjnIL08Dvs8P5hQo7rhf5enpmkkt2We
         F+eQomS9eoHDDxFMgBiRWYHhfdUa/vGg/yWsA2OGsy75n/YlfVGuy8D0sE3EI0jGisSN
         j6Nb+myzHwdPy6PcSq3Ka/1mYSQiJnO0yjkZecqaQyIcjD0SutQZqjN4LirlWwV8PQkv
         FTgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698054888; x=1698659688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohG7h5MVOd61zy+5ypL65RpxKjVv+oL8L5RUWwJJdI0=;
        b=tKpaNAOoUQ6RbwiEfHHNN3DnfvWtYS6J0iTp9LGmjonZROmHo9aArbKFA71RbvJ8aC
         WxggDf6RpFqhSw3l+3ROp4g1i1/DTEaSU3w5cWc3Ptkg2FEw118OdycLynMnfwAK6vYU
         bdY9SSdfRzZjxVRKEAzLqwNED8XUsWm1G5agf0BJgv5CmtDIiYmO3JhJtFRF4kNu5TnA
         HNuLQWr4SmlDb0wNRR1FMjIPUcJ9II/58SGvgiazlrzZzFF4j/2ya03lhWwqKpWnrWhH
         uaCWzPnUIpC262w/xY+Cz6+HIenA78NG4xTMYzy+Go2PCLoPfIcbGzAoqojbiU8PjPg7
         uf7A==
X-Gm-Message-State: AOJu0YyYT2103KuMRWGLFotnr06zRvaoSTTZYnFHWQ09MeeqV1MZXpnn
        V37A+hgmLXy3ILjfBdrRHrsACA==
X-Google-Smtp-Source: AGHT+IF2XQ2NytyZKfSuKXcxhn8MgqaftjUTA3vcBEY0OG7GzuniO27qe9jeb7abDdumrFZMKzYUnQ==
X-Received: by 2002:adf:fd90:0:b0:32d:8a32:3b2f with SMTP id d16-20020adffd90000000b0032d8a323b2fmr5871452wrr.16.1698054888606;
        Mon, 23 Oct 2023 02:54:48 -0700 (PDT)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id u14-20020a5d468e000000b00323330edbc7sm7428801wrq.20.2023.10.23.02.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 02:54:48 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH 07/17] ASoC: codecs: rtq9128: Handle component name prefix
Date:   Mon, 23 Oct 2023 11:54:18 +0200
Message-Id: <20231023095428.166563-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023095428.166563-1-krzysztof.kozlowski@linaro.org>
References: <20231023095428.166563-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use snd_soc_dapm_widget_name_cmp() helper when comparing widget names,
to include also the component's name prefix.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/rtq9128.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rtq9128.c b/sound/soc/codecs/rtq9128.c
index 371d622c6214..c22b047115cc 100644
--- a/sound/soc/codecs/rtq9128.c
+++ b/sound/soc/codecs/rtq9128.c
@@ -291,11 +291,11 @@ static int rtq9128_dac_power_event(struct snd_soc_dapm_widget *w, struct snd_kco
 
 	dev_dbg(comp->dev, "%s: %s event %d\n", __func__, w->name, event);
 
-	if (strcmp(w->name, "DAC1") == 0)
+	if (snd_soc_dapm_widget_name_cmp(w, "DAC1") == 0)
 		shift = 6;
-	else if (strcmp(w->name, "DAC2") == 0)
+	else if (snd_soc_dapm_widget_name_cmp(w, "DAC2") == 0)
 		shift = 4;
-	else if (strcmp(w->name, "DAC3") == 0)
+	else if (snd_soc_dapm_widget_name_cmp(w, "DAC3") == 0)
 		shift = 2;
 	else
 		shift = 0;
-- 
2.34.1

