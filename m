Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B307D7734
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 23:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjJYVzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 17:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjJYVzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 17:55:33 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCBF133
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 14:55:31 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6b1d1099a84so210690b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 14:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698270931; x=1698875731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHcNRy2/Nv0NAoVYg7R7CrfDmOcMA/mofPCoLqjIELE=;
        b=EPdFLlPwhAORuiDF0keK+heq4Pq0YIZxZbn0t+jh3u3rTuih5nT3lhksviLr3875Kv
         xdWlWYzLxRpv0uReFcLrY8w05+ZET2v0aZV0jki4hTePmiusZ1wvDWwFg1XWcKwriTdo
         SCA4PcCN96ER8t5j+hhMkygXCcwvuCPt3wfiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698270931; x=1698875731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NHcNRy2/Nv0NAoVYg7R7CrfDmOcMA/mofPCoLqjIELE=;
        b=Z+YjoW0lfNoIUa1+3GkAlRLbmua6LH9MS+4nI2EArZda4gNXJjoe3Wrfkpu2wiQor/
         gkjcVaG1pwYOHrrIGHyoBMjM8F8JZCGykH4mnwWoXmqkJpX5JQZxQhxGnGxfMK7vk+CK
         J5qDN4X5gQIPGXRXitEUmBeVUWjNjRMMtBPxJYNqZOKHNFMjFIdZ/CLwfU8akDO1lf+v
         ctOIb+RMial4LmYKxgQDhxxmpVIMI7hq4AZrJOSA6PK7YGX70ynvygo9tIODqsYRGSP1
         teqnLg2HmpU2IiAkg8oJpxfHRxv+JM3MTRVDOtFNxfeApLg9XWIMjp9RoCC9GAv41jNx
         uDcw==
X-Gm-Message-State: AOJu0YwgXebazbmDnjYnKMUpb1Lbeu16XktTu/AtTAtvAKdTxo3apiRS
        vN+/BqZ0eCvkyqc5iO11zfOE4A==
X-Google-Smtp-Source: AGHT+IGVzOhxkSH/VY3HPPr3z24MzSL5wB6xSdbuILvtp1/p10yq0YsamgCEg9vTwFlTID+c+9Qf0g==
X-Received: by 2002:a05:6a21:120a:b0:17d:ec93:6a86 with SMTP id oe10-20020a056a21120a00b0017dec936a86mr5973524pzb.19.1698270930923;
        Wed, 25 Oct 2023 14:55:30 -0700 (PDT)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:f0fe:5c3b:1d70:d0bb])
        by smtp.gmail.com with ESMTPSA id w14-20020a63160e000000b005b8ebef9fa0sm2994943pgl.83.2023.10.25.14.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 14:55:30 -0700 (PDT)
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
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 6/7] dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-pico
Date:   Wed, 25 Oct 2023 14:48:48 -0700
Message-ID: <20231025215517.1388735-7-hsinyi@chromium.org>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
In-Reply-To: <20231025215517.1388735-1-hsinyi@chromium.org>
References: <20231025215517.1388735-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 54141b9bb714..bf793f644e6d 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -258,6 +258,13 @@ properties:
               - const: google,makomo-sku1
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

