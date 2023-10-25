Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4477D7733
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 23:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjJYVzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 17:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjJYVzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 17:55:31 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4418D9D
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 14:55:29 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6b36e1fcee9so203575b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 14:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698270929; x=1698875729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79jtSdDl24cfVMtRgsa8bqnoadvLE5wlo58xyGE1d9Q=;
        b=OXl8Egtp4ErTW6gEES/Xj4DdasMuSIF1JyGGjtLyxW25o9yNaSN33OSxpwfsv+Jfv2
         DYF0t0vf0SnCsZZ0ejs3/7r2CQUtf6ok5cxARVWlzUzdyQVSHBoXNHIBBrr+TNAmeQ2y
         T04ZWQ16eSjAqKeNuTl2khsAr2RMhslGMkvCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698270929; x=1698875729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79jtSdDl24cfVMtRgsa8bqnoadvLE5wlo58xyGE1d9Q=;
        b=VLyel8ub5vKYWl953LtjR6PNp8fG6EKLRBnV2XKRGfkON9PL83l7iZJGmYINfQ9b2J
         BUqpu7vFqtb4MRYJyenP16UOyhPPWSebj34uANNqcbX75omiX8sLkii9iQaT0JsmR7DO
         SUoLgtjTcYKt/PBE6lCSk7Rct9ffuI1CSH4iCIS8EfL+0mPCrQIY4biripMa/LZE2nJ0
         IRvWy7CY73bW2EckvxYftEaJ+zwnt36A4DxmFsDF1S4gcYMXxN7et/HYi8pXX45bXFwm
         hxxYlD11OmIXS8W8OB46idThIGKQ4owTUXduSqd6t45pvIZUiDt/ORizhIfhoKMMI0lV
         1qFA==
X-Gm-Message-State: AOJu0YyTNOKPjrlemsD9wwZIXEnjav61FoS7APzLmhSc9uRNTsXRsHSH
        bZfEuwxgvpiBYMXRE3dZcxqGQw==
X-Google-Smtp-Source: AGHT+IFuGCQXgqHOERVCnmynQHpCmt3yHZRhhoyZFj7fm++vY0NnVC5T3ML6yQACdGrMP7uHxm1ntg==
X-Received: by 2002:a05:6a20:7fa4:b0:15e:b8a1:57b9 with SMTP id d36-20020a056a207fa400b0015eb8a157b9mr7855392pzj.24.1698270928820;
        Wed, 25 Oct 2023 14:55:28 -0700 (PDT)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:f0fe:5c3b:1d70:d0bb])
        by smtp.gmail.com with ESMTPSA id w14-20020a63160e000000b005b8ebef9fa0sm2994943pgl.83.2023.10.25.14.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 14:55:28 -0700 (PDT)
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
Subject: [PATCH v3 4/7] dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-makomo
Date:   Wed, 25 Oct 2023 14:48:46 -0700
Message-ID: <20231025215517.1388735-5-hsinyi@chromium.org>
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

Add makomo sku0 and sku1 which uses different audio codec.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
v2->v3: remove rev since match on sku is sufficient.
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 4fe58cfe6f1b..54141b9bb714 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -251,6 +251,13 @@ properties:
               - google,kodama-sku32
           - const: google,kodama
           - const: mediatek,mt8183
+      - description: Google Makomo (Lenovo 100e Chromebook 2nd Gen MTK 2)
+        items:
+          - enum:
+              - const: google,makomo-sku0
+              - const: google,makomo-sku1
+          - const: google,makomo
+          - const: mediatek,mt8183
       - description: Google Willow (Acer Chromebook 311 C722/C722T)
         items:
           - enum:
-- 
2.42.0.758.gaed0368e0e-goog

