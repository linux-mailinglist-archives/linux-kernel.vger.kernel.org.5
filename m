Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C0B7691F6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjGaJnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjGaJnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:43:15 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE11BEB
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:43:13 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe389d6f19so867788e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690796592; x=1691401392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kdDSWpR2PwAaVc6xrPLUrP7cY8hR/WC31iRh9xFaQkU=;
        b=JRaT/+kfL9uh8R15DPTFuDwkvjklHTznvty/KmRSZmAoyGr1+CR9ocuL4kvmw/UjGk
         DJBS0rdn4ScZW5MInEzcVFhbv9GKdTDpJaBzNw0+/WzGByly5NW1xh/6u8bLsw9mtejZ
         +rpLlG+09SagscOFEVnloXPJDybDA5EO57eet55qG0VZVuYHDpeI8C60dzhPYcWcUpSX
         uW2370rK4gNIz6U2gPWBqCl5MRXooZ9CoM7efLE+ynZNjnJlunqSxScERrES7yClxhNT
         37irKwNHH3pa2PC1EXEellvCP2cqF/V5/7TLqTXj/ZTgIkZtTQj025MlucYHe8QE+A1G
         KT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690796592; x=1691401392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kdDSWpR2PwAaVc6xrPLUrP7cY8hR/WC31iRh9xFaQkU=;
        b=ROIycVGLo5+ZlEGZMSF0sRlUziGD5iqfLZyYQrJ3LpqpPyZjDj0rjyI8/mXjWMpb50
         CCSO6elZg4E511U7cVHWHej1twr+eV2401zniuO0jBh59oXS5W82Op20TPPk9WoBfdvt
         CfDYwWIlc9HpIoDRPuwtLATQMrCPSQRpYJOzEQDauU8BwdqDVfJwbmatPg8cmNOTPG+z
         yjhEv7txWTGN/nxe+dlbZxg+KhjrO/6+9FeYkUE/9QaNI9iK/U1/9hfWiE/bt+8olG34
         iJGEnMWE0N3hL4uuvnj61WoNFLqBYQfssDgBUdA1Hb6lvHtghFPXuDSk+ljJ1svyyB4G
         IUQQ==
X-Gm-Message-State: ABy/qLYZI4SUFDtI8EWJuSPPhj/ITNsft4M8m/P5DBl4nzbpPAqd0c6H
        XOVpVYe8nGLj5pG1RbcSdglBNg==
X-Google-Smtp-Source: APBJJlGki+SUDXYM8c3BbgK1LnBv0fjF2tGeoHiwrwf2124G5mJuEpJE4OQC/hLu1Gd0rntkBAJgrQ==
X-Received: by 2002:a05:6512:1c5:b0:4f8:766f:8dc3 with SMTP id f5-20020a05651201c500b004f8766f8dc3mr4904749lfp.32.1690796591857;
        Mon, 31 Jul 2023 02:43:11 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id z17-20020a170906815100b0099bcdfff7cbsm5867547ejw.160.2023.07.31.02.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 02:43:11 -0700 (PDT)
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
Subject: [PATCH 00/12] ASoC: dt-bindings: Add sound-card-common.yaml
Date:   Mon, 31 Jul 2023 11:42:51 +0200
Message-Id: <20230731094303.185067-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Almost every board machine / sound cards has "audio-routing" and "model"
properties, so we can make things simpler by introducing one common
binding.  It is also expected that given property has only one definition.

If the patchset looks good, then the next steps will be:
1. Convert more vendor audio-routing properties to audio-routing,
2. Add dai-links children to common binding.

Best regards,
Krzysztof

Krzysztof Kozlowski (12):
  ASoC: dt-bindings: amlogic,gx-sound-card: correct maxItems constraints
  ASoC: dt-bindings: Add common sound card properties
  ASoC: dt-bindings: mediatek,mt8188-mt6359: use common sound card
  ASoC: dt-bindings: samsung,aries-wm8994: use common sound card
  ASoC: dt-bindings: samsung,midas-audio: use common sound card
  ASoC: dt-bindings: samsung,odroid: use common sound card
  ASoC: dt-bindings: samsung,tm2: use common sound card
  ASoC: samsung: odroid: use of_property_present to check for property
  ASoC: samsung: aries_wm8994: parse audio-routing
  ASoC: samsung: midas_wm1811: parse audio-routing
  ASoC: samsung: odroid: parse audio-routing
  ASoC: samsung: tm2_wm5110: parse audio-routing

 .../sound/amlogic,axg-sound-card.yaml         | 15 +++--------
 .../bindings/sound/amlogic,gx-sound-card.yaml | 16 +++++------
 .../devicetree/bindings/sound/fsl,rpmsg.yaml  | 17 +++---------
 .../bindings/sound/google,sc7180-trogdor.yaml | 17 +++---------
 .../sound/google,sc7280-herobrine.yaml        | 17 +++---------
 .../bindings/sound/imx-audio-card.yaml        | 18 +++----------
 .../sound/mediatek,mt8188-mt6359.yaml         | 17 +++++-------
 .../bindings/sound/samsung,aries-wm8994.yaml  | 16 +++++------
 .../bindings/sound/samsung,midas-audio.yaml   | 16 +++++------
 .../bindings/sound/samsung,odroid.yaml        | 14 +++++-----
 .../bindings/sound/samsung,tm2.yaml           | 16 +++++------
 .../bindings/sound/sound-card-common.yaml     | 27 +++++++++++++++++++
 sound/soc/samsung/aries_wm8994.c              | 10 ++++---
 sound/soc/samsung/midas_wm1811.c              | 10 ++++---
 sound/soc/samsung/odroid.c                    | 15 ++++++-----
 sound/soc/samsung/tm2_wm5110.c                | 10 ++++---
 16 files changed, 119 insertions(+), 132 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/sound-card-common.yaml

-- 
2.34.1

