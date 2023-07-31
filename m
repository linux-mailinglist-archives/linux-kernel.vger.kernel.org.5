Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4277691F8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjGaJnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjGaJnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:43:18 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11333139
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:43:16 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so1632777a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690796594; x=1691401394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6++1atFcJlpU6KcQ6EW+qw2Dj8W42OQi/XJDZGdi1g=;
        b=dhc03fGGpA5as1+HMhYMWdZE3IsL092HC0LprsNTQBPQ7s6TkXj6YxXAQqPWytVh44
         cb7SNFy7YjkMCHLx7fxXAZBDfQvbHE87OLNS2OdhRomqKJJlzT6k6gHtLaZEOZy2CLOx
         2VRDt7SdmllRm1yYORj/MI3aRZbrIwKLb2/6RnHVesH2HAh1d5L6M3ZHrZhtkYl+0Vpm
         OrVV5xkeBfvzo1fxSl3sE/3HPfPBEYMcyLl+L6/C3UMXWC651H+jsnnSOBFAzr8DxI3w
         udHKxhJmN8ichJzsj0QspP+1UYSEPxBXkMJi88MqqrUlzTtP8d81k25fDK4sYQ5R5ls+
         SvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690796594; x=1691401394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6++1atFcJlpU6KcQ6EW+qw2Dj8W42OQi/XJDZGdi1g=;
        b=OKMtYqhxhShH2tqX/0xrhKoBvMKA44K58Zpx4nrU/xi6cEmKYYPyx/ye8FI/St8lVz
         ZFv2snJGUTxGq3M4x44M7H1utwcWYKqS6eSpMxMAIonqpMdMmM64HMZsHWOSZKXvwxwC
         a3ML7zTUB/q4GAc31DOlZX0ztX3290HE7QEXSZQrhsaYFxI546tzDeUAov4FS3nTWr3J
         XwyDsFpZ/qJsQ105baJxnvXzRStyVIKhaTcrmk4EMSUGBVdWJ0H+DJbsVMiQxhUM4cNx
         h6pgl1QHXlbTI5CcL8siuL9PQzGntZlpo/LvBU8hen/AErrublSERLByDyFYfEmn3bvz
         FJUw==
X-Gm-Message-State: ABy/qLZqKDX3NyjZAaiI/h1q0L/FJRBU3W/1WcKONY0qJ5Bso4OAOFRN
        s4j1SIe/BVGTgd1+vBwLpWOMuw==
X-Google-Smtp-Source: APBJJlGWo3hFADwY+WaMzw9Z36mCtTdvjCEOo31rIf0hKufIkRKpCycEbTJFgmy0co12hnDOO35r7Q==
X-Received: by 2002:a17:907:7711:b0:99b:f3ef:f088 with SMTP id kw17-20020a170907771100b0099bf3eff088mr6220810ejc.69.1690796594520;
        Mon, 31 Jul 2023 02:43:14 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id z17-20020a170906815100b0099bcdfff7cbsm5867547ejw.160.2023.07.31.02.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 02:43:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Rohit kumar <quic_rohkumar@quicinc.com>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Rao Mandadapu <srivasam@codeaurora.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 01/12] ASoC: dt-bindings: amlogic,gx-sound-card: correct maxItems constraints
Date:   Mon, 31 Jul 2023 11:42:52 +0200
Message-Id: <20230731094303.185067-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731094303.185067-1-krzysztof.kozlowski@linaro.org>
References: <20230731094303.185067-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

minItems without maxItems implies upper limit, so add some high maxItems
to fix dtbs_check warnings like:

  meson-gxm-s912-libretech-pc.dtb: sound: audio-routing: ['AU2 INL', 'ACODEC LOLN', 'AU2 INR', 'ACODEC LORN', '7J4-14 LEFT', 'AU2 OUTL', '7J4-11 RIGHT', 'AU2 OUTR'] is too long

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/sound/amlogic,gx-sound-card.yaml        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/amlogic,gx-sound-card.yaml b/Documentation/devicetree/bindings/sound/amlogic,gx-sound-card.yaml
index b358fd601ed3..45d6202d9730 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,gx-sound-card.yaml
+++ b/Documentation/devicetree/bindings/sound/amlogic,gx-sound-card.yaml
@@ -21,6 +21,7 @@ properties:
   audio-routing:
     $ref: /schemas/types.yaml#/definitions/non-unique-string-array
     minItems: 2
+    maxItems: 32
     description: |-
       A list of the connections between audio components. Each entry is a
       pair of strings, the first being the connection's sink, the second
@@ -29,6 +30,7 @@ properties:
   audio-widgets:
     $ref: /schemas/types.yaml#/definitions/non-unique-string-array
     minItems: 2
+    maxItems: 8
     description: |-
       A list off component DAPM widget. Each entry is a pair of strings,
       the first being the widget type, the second being the widget name
-- 
2.34.1

