Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC497D43A1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 02:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjJXAHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 20:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjJXAHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 20:07:39 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B6510CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 17:07:36 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c8a1541232so33207775ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 17:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698106056; x=1698710856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VOeGW1+YeyU2G0JvKEORbZjMo9uwDqxfDmsj8nfnjM=;
        b=K3buPjn5SIPBMATqT9XifkzXgi659zuh7sI+MJnFSOvTkY1/4AF93Kp1vBsMeOhzIE
         6A6RV9kH02Z/GchCLo89EYn4JagsCU66GBacqOeyLpuQZA4l5cV6aQrdheLj42RT1GM9
         EIEJOs1d3m+AHpaTJG15NwLOoZ1Dm7gFgJ40k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698106056; x=1698710856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VOeGW1+YeyU2G0JvKEORbZjMo9uwDqxfDmsj8nfnjM=;
        b=XAUNkn4jDbOE+sz6qxSHr000nJHdPoSuenHLAYIm0kuT1+/hdTP6NfI2RBfy8bQqXn
         Ux3hExnOoctzzWINDe7drR+0iqVzGzfMJfdL4VcBJ5QKdSpa+LmWlv0y5ukCrv1qSYaV
         0uMesmHmQxAv3I9TKlnnV1qZooCrIu7/F2I+1auAxaMLxvtJMDu0zWf0rN6J051F2pU0
         D8QAFufMwlt1Mcy/mILaAiLdmKC4FWa7d4+f49sz17nwnsgX9zArBaMZYnsZM1OyXRRv
         eA3YYUJO2i+Msr2MxKYnERXhmoIKIabOLCpF6S2+3+E3PletqoCo9UcczHulKL37Q2OG
         cHrw==
X-Gm-Message-State: AOJu0Yy+dMinc9wEfLtrDc75az09TbVXlOuUHOvycSNYSnx/4aGW/n5J
        Kf7TTTrEfnFbdZylrdmOigmQZA==
X-Google-Smtp-Source: AGHT+IGJlNox07Z+qWP/5jJ6ZTp86n/wGTcwmCUD6ggrOUjFIR1tQ0GTE4odCzw3VRIeGQT7pg3Dbg==
X-Received: by 2002:a17:902:ce88:b0:1ca:92a:df0 with SMTP id f8-20020a170902ce8800b001ca092a0df0mr11804998plg.59.1698106055836;
        Mon, 23 Oct 2023 17:07:35 -0700 (PDT)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:5a2d:c345:7f3f:d26c])
        by smtp.gmail.com with ESMTPSA id a10-20020a170902ecca00b001c5dea67c26sm6505510plh.233.2023.10.23.17.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 17:07:35 -0700 (PDT)
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
Subject: [PATCH 5/6] dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-pico
Date:   Mon, 23 Oct 2023 17:02:28 -0700
Message-ID: <20231024000724.57714-6-hsinyi@chromium.org>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
In-Reply-To: <20231024000724.57714-1-hsinyi@chromium.org>
References: <20231024000724.57714-1-hsinyi@chromium.org>
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

Add pico (sku1) and pico6 (sku2).

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index b131e0bdbf01..6bb1d80dd4eb 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -262,6 +262,13 @@ properties:
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

