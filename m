Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFDEA7D88C7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 21:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjJZTN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 15:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjJZTNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 15:13:52 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A49D1B1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 12:13:50 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5ab53b230f1so1052520a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 12:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698347630; x=1698952430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1OFWJeTJZ0BbVCP/+krvvrTex+iNjXDOseWbkL0Relg=;
        b=klRJuN/25vEKbKMA+xEcWihxEDSvIx8QHd56qMAMIkpWQh55uh8TJOvPhLRRaHxx24
         NUtLt3wK5XAAxOB6ldYrm09pnEUJab2Y2exVsLxthb7PqdOsf774IyIoihjFW404+L0W
         aNS1InTckZ+mp4imKDqRP1WN7ySsZuQ/7J5OA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698347630; x=1698952430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1OFWJeTJZ0BbVCP/+krvvrTex+iNjXDOseWbkL0Relg=;
        b=IxVaKfKTJnHek9IMoqwDejOa6ToQY7qF4x9Dz7KVfFqQrRzA+noYITw9HVFhFX+TAA
         CZ7PkyHrVtSE5ilXvNxcc14B6NKajcyZgrAD+pBPtcWMT8dMB7ombeSxm5hf0mZeahsa
         ldCcN6urOYm9i6wPeGyqlqyVVEzfYtvmxCKdbe2EkgfXNvuSHa5PDuySAbOwHiMCLxs/
         dtLESqeHCy8okxfHjdkT51MJNgFnQeeXZtGiREdFmFezq9OBcF/nUqvyBc2QqjrcuwCv
         V/B8/oIJpvyn2t4tkBn1oVwoFRAfmqa7Bx5JH7gHcIPgJwhM6GWehFonqkP8ckKzbdhP
         AlLQ==
X-Gm-Message-State: AOJu0YzDd8AVQ4HAsgPPUGNw9M67uoHmJKqJc3vTp14kIGDM5MB7U+8y
        Dhs+xA0vtR4zumBHu3JHVNS5zA==
X-Google-Smtp-Source: AGHT+IGKFCR2N7o33SsWtgj5xAsMYXuAF9RtVdH88kWpjjYB8UGtUqMYI8P2T4uYs5XYLatDKH++HA==
X-Received: by 2002:a17:90a:3003:b0:27d:8d42:6df2 with SMTP id g3-20020a17090a300300b0027d8d426df2mr447016pjb.43.1698347629959;
        Thu, 26 Oct 2023 12:13:49 -0700 (PDT)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:f0fe:5c3b:1d70:d0bb])
        by smtp.gmail.com with ESMTPSA id 22-20020a17090a031600b0027476c68cc3sm2183639pje.22.2023.10.26.12.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 12:13:49 -0700 (PDT)
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
Subject: [PATCH v4 2/7] dt-bindings: arm64: mediatek: Add mt8183-kukui-katsu
Date:   Thu, 26 Oct 2023 12:09:11 -0700
Message-ID: <20231026191343.3345279-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
In-Reply-To: <20231026191343.3345279-1-hsinyi@chromium.org>
References: <20231026191343.3345279-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add katsu sku32 and sku38 which uses different audio codec.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index a5999b3afc35..4fe58cfe6f1b 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -235,6 +235,13 @@ properties:
         items:
           - const: google,kappa
           - const: mediatek,mt8183
+      - description: Google Katsu (ASUS Chromebook Detachable CZ1)
+        items:
+          - enum:
+              - google,katsu-sku32
+              - google,katsu-sku38
+          - const: google,katsu
+          - const: mediatek,mt8183
       - description: Google Kodama (Lenovo 10e Chromebook Tablet)
         items:
           - enum:
-- 
2.42.0.820.g83a721a137-goog

