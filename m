Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732C97D5D31
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 23:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344272AbjJXV0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 17:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344338AbjJXV0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 17:26:31 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D036698
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:26:28 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ca052ec63bso42552895ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698182788; x=1698787588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Zb5Wh/eo+im2l7B1fmvT/WoiYRemD8ZCN2J8BNebAU=;
        b=RBOIma0u/Jd98ghHje1VMFjESctYUnxAejEYDd0J0uC49gWIW6n8VYEh/8FJiTN7Fo
         RQvM7AnClANQblQvv2yrjbhGeFbNyw/MwRCOPrH0hyC98fM8XQJq0fCWwWWbF76kYItv
         2iRdnkFVv7PGcykcZ+Kf3owAF/OJjTvIrh848=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698182788; x=1698787588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Zb5Wh/eo+im2l7B1fmvT/WoiYRemD8ZCN2J8BNebAU=;
        b=v+g+UZD+hMvLKC1r4701nR3JQku8cOuKc9xqVwnFPQ6wJhTFupMt0Lcaan/ExS1GeR
         YZ3mCZzbkwUGdiIE7de+orN/tYxUnrmKo7RLT6wMlyhYE6Hr+Iq8pHcSlLuJS5ow5Srl
         ZU2ccGuutKRVZEe+ivZtt33LQULUdxtlE5zNUnBZot5tu6a56Y70yTABolAkOQbyOdDS
         UV2wfGBDnXIJtQQyu3q5yaB8au+dXihk4wpP8+yQeTHmlG3sDQG6gHeJY+5BPHDghGOQ
         qKwgErz395zLcgRbnTxSZGvQAao9JzuajTvXEeN5IxP86ZGvow6X3DRgGYxBKSE3/WEH
         0tBA==
X-Gm-Message-State: AOJu0Yz3ENMIIwvpjtvM2vn9DGDjoc8NKGWFhFqjdYBc3OOkgrfVb1VS
        sxYbNA1Nws7az2fI4hLU0lZZsg==
X-Google-Smtp-Source: AGHT+IEHZNbRevO+MX5QpplNtldSLlaYzi6eCiT26xP+SBmDo9AFqh2UChobD3gyVfCa1s1ke+FKJA==
X-Received: by 2002:a17:902:db09:b0:1c0:9b7c:f82a with SMTP id m9-20020a170902db0900b001c09b7cf82amr16579647plx.53.1698182788321;
        Tue, 24 Oct 2023 14:26:28 -0700 (PDT)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:5a2d:c345:7f3f:d26c])
        by smtp.gmail.com with ESMTPSA id p9-20020a170902e74900b001b850c9d7b3sm7824140plf.249.2023.10.24.14.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:26:27 -0700 (PDT)
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
Subject: [PATCH v2 4/7] dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-makomo
Date:   Tue, 24 Oct 2023 14:22:26 -0700
Message-ID: <20231024212618.1079676-5-hsinyi@chromium.org>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
In-Reply-To: <20231024212618.1079676-1-hsinyi@chromium.org>
References: <20231024212618.1079676-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add makomo sku0 and sku1 which uses different audio codec.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 4fe58cfe6f1b..af1037a95fd5 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -251,6 +251,18 @@ properties:
               - google,kodama-sku32
           - const: google,kodama
           - const: mediatek,mt8183
+      - description: Google Makomo (Lenovo 100e Chromebook 2nd Gen MTK 2)
+        items:
+          - const: google,makomo-rev4-sku0
+          - const: google,makomo-rev5-sku0
+          - const: google,makomo
+          - const: mediatek,mt8183
+      - description: Google Makomo (Lenovo 100e Chromebook 2nd Gen MTK 2)
+        items:
+          - const: google,makomo-rev4-sku1
+          - const: google,makomo-rev5-sku1
+          - const: google,makomo
+          - const: mediatek,mt8183
       - description: Google Willow (Acer Chromebook 311 C722/C722T)
         items:
           - enum:
-- 
2.42.0.758.gaed0368e0e-goog

