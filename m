Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1367B7D5D30
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 23:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344415AbjJXV0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 17:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344267AbjJXV0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 17:26:35 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737FE10DB
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:26:31 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1ca72f8ff3aso34800885ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698182791; x=1698787591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WT+66IxyTrpqd+XpQ36/yDuTAp9fjV5BitgE+rccN5g=;
        b=n6mpFgaagbvLHgbvBBwqgY9A5XSf+81GHPrNwCsvAg439HncfiPSX16XOC1t2VNc76
         jOyyHyDtavMdiTPSLwNjRiNptMZPunawPdKNpfYMl2TMDQ4MLZu37sCOSJCKZturr4BQ
         Gqsa5SyQt0b+h/P9i9ylG4T4hjW34Br0JeQFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698182791; x=1698787591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WT+66IxyTrpqd+XpQ36/yDuTAp9fjV5BitgE+rccN5g=;
        b=lF+xqnjLZFLPENjzjeskdjoCJ4v/JdPRes3o9miRkQ6kytdywrlErftU+BxCjCTVv/
         WfVoVZ7sigcPsqiEW2uc3rB0aE+8gwB9pmBnqKzFPuF6AiNBxlKjCFIa9PWHys9zcZ3m
         W0b712xw6eUT7UCUxllqJz3QYy93fdoy2FAyXEkOfpwwS7AGzaHJQBq8m5ZxKPS9lKVd
         o6t4YdjoXbEZz8sOx6fp+G/jz7Z8eJJRsDGuNeWMFACm6rwqLsewNbyYz5913F55ndoD
         nQ74Ynr97WEo8sk3Kh0maD7yY3wkN8u5YbECh0KScnYUTVXsB9iNQwOZu9lrSarT4UTZ
         odVg==
X-Gm-Message-State: AOJu0YzV88k2h2o0N6wD5ktxWRyUHVUoktUFJdtjODrSPbw5VdIOc3zO
        pBV+uHLxEsdffYBB9AFLPtkh2A==
X-Google-Smtp-Source: AGHT+IGVLiHOuR2GYs8wtD+k2Vea4FG0aVST3WDGqFFF4fAgZggjmK9W2KiixVxe//eZy70KsoUejA==
X-Received: by 2002:a17:902:e851:b0:1c9:e3b1:1f4 with SMTP id t17-20020a170902e85100b001c9e3b101f4mr13859071plg.62.1698182790947;
        Tue, 24 Oct 2023 14:26:30 -0700 (PDT)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:5a2d:c345:7f3f:d26c])
        by smtp.gmail.com with ESMTPSA id p9-20020a170902e74900b001b850c9d7b3sm7824140plf.249.2023.10.24.14.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:26:30 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>,
        =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 6/7] dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-pico
Date:   Tue, 24 Oct 2023 14:22:28 -0700
Message-ID: <20231024212618.1079676-7-hsinyi@chromium.org>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
In-Reply-To: <20231024212618.1079676-1-hsinyi@chromium.org>
References: <20231024212618.1079676-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pico (sku1) and pico6 (sku2).

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index af1037a95fd5..f7e2b742c798 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -263,6 +263,13 @@ properties:
           - const: google,makomo-rev5-sku1
           - const: google,makomo
           - const: mediatek,mt8183
+      - description: Google Pico (Acer Chromebook Spin 311)
+        items:
+          - enum:
+              - google,pico-sku1
+              - google,pico-sku2
+          - const: google,pico
+          - const: mediatek,mt8183
       - description: Google Willow (Acer Chromebook 311 C722/C722T)
         items:
           - enum:
-- 
2.42.0.758.gaed0368e0e-goog

