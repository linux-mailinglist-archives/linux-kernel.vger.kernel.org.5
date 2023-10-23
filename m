Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429657D2F11
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbjJWJzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbjJWJzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:55:17 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC4F10D4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:54:59 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32dff202b4bso382839f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698054898; x=1698659698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOdWx51KZzcP4yPFkM05Libt2LPoTXL1hZ7dHc5xIDc=;
        b=VRzOtaijk3DPunlXmfnUUth0w3V9fJXXzPGCYioqENLagtGO2m808WvkrBqH1MON8S
         ZsZS/UEHkNtc4dogJGbwcUCKJ3EvBizW7pWxR2ukNm+Vyg+xSuqHMDm3RJTcHJP4r/Cm
         l/LFCw468LzBoRHcEWKp/V2r3gxtzTF1X5uCMeiR5rCLvgYglQB7+Ikps3mApyrgcgVW
         +Lbr8MvTawuo8MOJdqv0L5sy7DKAVHr6B7HXolgDXLpHmplMRb6Jm4Lgl+TyJIkFvd/H
         LUv+J4toQEq9z9fwm0pDecdB1xzbQUucDR1YaHRqAa6PWl3p4G8l3X1MAPESHWA9fHQi
         BNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698054898; x=1698659698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sOdWx51KZzcP4yPFkM05Libt2LPoTXL1hZ7dHc5xIDc=;
        b=WCzfe/N6VJoE9Lb72KYVI13FptNpqfVJAq3AlR6ZqqNNckT+m+aZ2BCCwHYN1SaOgY
         K6d9hid0otTUEG61lMzjr2qAQV9K79Nchcrr1SFPXrgoZozl7G9WR+63Q4yAcGa62PwH
         czVPGlXNnH8tciBiszYz2gGlKxo61RjvK7i/mpoQdV2RlTu26QSqMamccsyBmWxZAlyW
         KqKebm6VQMwVPVW+/nzWa/rq4giLv4CZDs9Y7jPkZOVPjS1H6DZ5vQ6mI56y8yxD9FnB
         YHqLonUGD6yLjWG2vqIUjj1WB8paWHFtk91uks2C3J1ZnN4irECLbuW6n+gzlMqqzpHh
         HUKQ==
X-Gm-Message-State: AOJu0Yya2+VhLCrvX98ThnO0GoPNnDuufE5TdBuLbSMx7idG1Ah50+Cj
        LupHqwTiUIe5qAM/OqVdcMk4tg==
X-Google-Smtp-Source: AGHT+IHEVLDPnEUrrX/PY+GOmXCghoQi2Q5x3tEYdDkzUdmjkSVDumB20aWrVD4RN64ThYu9YeLKpg==
X-Received: by 2002:a5d:6941:0:b0:32d:a022:855a with SMTP id r1-20020a5d6941000000b0032da022855amr5924003wrw.20.1698054898321;
        Mon, 23 Oct 2023 02:54:58 -0700 (PDT)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id u14-20020a5d468e000000b00323330edbc7sm7428801wrq.20.2023.10.23.02.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 02:54:57 -0700 (PDT)
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
Subject: [RFT PATCH 11/17] ASoC: codecs: wm8995: Handle component name prefix
Date:   Mon, 23 Oct 2023 11:54:22 +0200
Message-Id: <20231023095428.166563-12-krzysztof.kozlowski@linaro.org>
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
 sound/soc/codecs/wm8995.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8995.c b/sound/soc/codecs/wm8995.c
index 4ffa1896faab..59ef2ef8ce00 100644
--- a/sound/soc/codecs/wm8995.c
+++ b/sound/soc/codecs/wm8995.c
@@ -541,7 +541,7 @@ static int check_clk_sys(struct snd_soc_dapm_widget *source,
 		clk = "AIF2CLK";
 	else
 		clk = "AIF1CLK";
-	return !strcmp(source->name, clk);
+	return !snd_soc_dapm_widget_name_cmp(source, clk);
 }
 
 static int wm8995_put_class_w(struct snd_kcontrol *kcontrol,
-- 
2.34.1

