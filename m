Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88117D43A2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 02:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbjJXAHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 20:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjJXAHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 20:07:35 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B6C10D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 17:07:34 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cab2c24ecdso23561365ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 17:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698106053; x=1698710853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+shCuLeYUeGg9T4PC0PI70XXw4EiiSOxksaZg6E+gi8=;
        b=bsS43uCCH8YDD1LsBvsTswY1lPXu/0tXvyuqruFo+XpTZhAXlKGi973j0QQN5UGdyl
         pY/PFkHlez7aJhG+sJgp6WVKiJdT+dsfWDq7FmbnGn0qC2oT6lX4wtwMZTe7uDLsz6/1
         dmMHRzAnNb7ZaFiORa9NGEMkrEIXBbY7SlYjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698106053; x=1698710853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+shCuLeYUeGg9T4PC0PI70XXw4EiiSOxksaZg6E+gi8=;
        b=S7EslIY6QbKymCT2jgZ8Ga0KIAQzhCkPewXe5OL9FjrnCUh+8B9Fzf8UeYxEC2M4Lv
         bE0m4aqfFfhVaEjCf31pztlMZkzw3v/2vlKAtv1HHm75WpOwzGUBK4YtWk4+vIAOYgFc
         20uHSZI7A4gGwCIpgbxjGzGEV6xaltMvx/wtDmt8ypAE8mGkfohV5reSAWE/ebD7vY1G
         bih3luwDA0JV1V9b8n/2E8Jl1qZJmoSn5noxtQSIKoLcUzDzP3Tb1vDJ4Q7hhQHHTy+A
         cCB4poWN5AmnDLWpDSIKT76/suxfaXGc3aUIQ5g4U4voSzrahDMIMdrHyHkZMgVg1sA4
         HssQ==
X-Gm-Message-State: AOJu0YxgTB1Ehc39KAZ/fX5CNdnvcdCBYfiJFEDe9Wg/RnYuaCdAjTy6
        k+YnWQKFyG4HxuwEjAzdyISfIA==
X-Google-Smtp-Source: AGHT+IFyDFfPXnOzCWduhBGQR8TvVevfvrQncsDbKw4d5+Hws9B2jLP9qII9Z2Vy6KpNGikr7rQrjg==
X-Received: by 2002:a17:902:d2d1:b0:1c7:398c:a437 with SMTP id n17-20020a170902d2d100b001c7398ca437mr9319153plc.69.1698106053509;
        Mon, 23 Oct 2023 17:07:33 -0700 (PDT)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:5a2d:c345:7f3f:d26c])
        by smtp.gmail.com with ESMTPSA id a10-20020a170902ecca00b001c5dea67c26sm6505510plh.233.2023.10.23.17.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 17:07:33 -0700 (PDT)
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
Subject: [PATCH 3/6] dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-makomo
Date:   Mon, 23 Oct 2023 17:02:26 -0700
Message-ID: <20231024000724.57714-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
In-Reply-To: <20231024000724.57714-1-hsinyi@chromium.org>
References: <20231024000724.57714-1-hsinyi@chromium.org>
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

Add makomo sku0 and sku1 which uses different audio codec.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index fe8c488a3207..b131e0bdbf01 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -250,6 +250,18 @@ properties:
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

