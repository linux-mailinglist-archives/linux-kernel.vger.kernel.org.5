Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCCE7D2EFF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbjJWJyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbjJWJyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:54:45 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF39FC
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:54:41 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31fa15f4cc6so2227089f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698054879; x=1698659679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P05PzWbQ4hBl2fNZN6KJaeVrZFnQ7VS3APzpcXPmWmM=;
        b=YyDzZncK1SgwNW8rl1WP9CGxpz9ct7i6WJ/499vb1v5JotULi+8q8XvQkkrJhCo0LE
         pX8cNofs2Tg4KWQOSr/zPBGkIRMtp1rpV9GGiOyPkWCrIOQlb3kY/g7APkMBvGA6qq0J
         uOOdz+Tjjue5Vssjbxj1/x3+stedYP7onNInINMnWiYC8cICOPSKN1j/BTthbT+NDnzb
         HTrs1Cd9hnNtMPnrSidKxLfhQzCZwsLphCjjCwtFg79hmoc9VZagiA2Wo0SHsUeK7XPV
         3Exp506pfU0Lvvfpy1Av4ttNcFoEpY0pWxJZpZq4mKWEXfOh+/sn8AeDg1uzBjxRx9Xa
         P9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698054879; x=1698659679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P05PzWbQ4hBl2fNZN6KJaeVrZFnQ7VS3APzpcXPmWmM=;
        b=TP3uIpKGBJfBPEVT0PkOOOaw6M3JG603AjPVwQYyuWylBwfh6MhLdlF12JNNLeR+iL
         S2C9J/c9fsyPwLXwq7ebu5FsoOXFWMBd+TPDLyyRpFRyi9WprQ0ji8+Kn3PqO0+eXUqx
         elPZ5HD2wGAMtCXdu6I7OVGXhcAtPB0xDPXljo7duJ6Y4s+ai1aipz3tRwAqTvTFStLX
         6vYeVOk4NTTwlFYYeYPh7y0U9r1W2BhcHgf/ppfF6vArP4JOXXrwbo3cWrmqq4YmyUZV
         BzkGeuzX+j2m47Hka+JNMZ1le5yff+acuuvArvfltMIntBM4GKBW1ubuGHYmEJrIxBGX
         eB/g==
X-Gm-Message-State: AOJu0YyyTgR+iLUlBfFbPmAnLgfnCYyn2cBrzo0zFFmJ3bONYEbpd8qR
        A3vdmI3ogi68aousbD6Fs/Fbug==
X-Google-Smtp-Source: AGHT+IE7M5wXmUXIEeObjapurzse0V6MkE8fsf1gV1jhgG074/79sH+mXQ9giKjm7AVwWA1w8KdepA==
X-Received: by 2002:a5d:67c5:0:b0:32d:b7d4:b90 with SMTP id n5-20020a5d67c5000000b0032db7d40b90mr4943276wrw.39.1698054879636;
        Mon, 23 Oct 2023 02:54:39 -0700 (PDT)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id u14-20020a5d468e000000b00323330edbc7sm7428801wrq.20.2023.10.23.02.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 02:54:39 -0700 (PDT)
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
Subject: [RFT PATCH 03/17] ASoC: codecs: adav80x: Handle component name prefix
Date:   Mon, 23 Oct 2023 11:54:14 +0200
Message-Id: <20231023095428.166563-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023095428.166563-1-krzysztof.kozlowski@linaro.org>
References: <20231023095428.166563-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use snd_soc_dapm_widget_name_cmp() helper when comparing widget names,
to include also the component's name prefix.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/adav80x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/adav80x.c b/sound/soc/codecs/adav80x.c
index bb08969c5917..c8c0fc928211 100644
--- a/sound/soc/codecs/adav80x.c
+++ b/sound/soc/codecs/adav80x.c
@@ -229,7 +229,7 @@ static int adav80x_dapm_sysclk_check(struct snd_soc_dapm_widget *source,
 		return 0;
 	}
 
-	return strcmp(source->name, clk) == 0;
+	return snd_soc_dapm_widget_name_cmp(source, clk) == 0;
 }
 
 static int adav80x_dapm_pll_check(struct snd_soc_dapm_widget *source,
-- 
2.34.1

