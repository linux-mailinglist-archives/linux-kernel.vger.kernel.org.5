Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B477D772C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 23:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjJYVzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 17:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjJYVz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 17:55:29 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D97E9D
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 14:55:27 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-581d4f9a2c5so191610eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 14:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698270926; x=1698875726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=maPZys3Husg1xXw3s250DwrK944nIzcFhej3lZUZ87w=;
        b=Y68lC1jsi7W7Xr9rJPgeJxvWGyGVP9hc9MVnuKR5bZ9k5OmSxKj/DQHvNBsluroAlr
         R2PMase9fZPq+DOsNIJSmDaNDPSWuwm/xp2TzNZvnEON4t5IlqSR5Fkiaeg6eUf/snl9
         1rjL8STYzIN49AdIa657l1TNtqwbbbpYOeT18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698270926; x=1698875726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=maPZys3Husg1xXw3s250DwrK944nIzcFhej3lZUZ87w=;
        b=GIk46vQF6nqvrJDyJwwAbyEoEXm8AnKaShE0bLiMfJUqnJWqt4Qv9H6Jo8UsJTjwMB
         +U8XnPiYAAqXztx86vpIYZ+z7kreqdTFNebJJZOy+jWIJdFDOxR+xQ5qoN8P6fNDJQ5e
         sad4sOyGgMspP6bPoyIQdYgvvV13X6oarTQuebU+nlysdMDIMeJ7kGetk1NbaP9OlhlG
         YxZq5jSBjsUSpJOAaC+jFYi3sAUNnCkNOuVZ6pQQIDyviXB4XSo/XUot+2zyIDgyPFFg
         Hu0dn76P0FHXvgkDTaTSw3OVZPLMqHrPaMJgRnd/n7NR3F7fD1oQ9egMudIr/C16IqAl
         h/9w==
X-Gm-Message-State: AOJu0Yyr4Qrayp1NtOIY0QDWD1vniun387K5j2gA4yR28+hhuIHihOGV
        eC8cdXq2VG924ABWnTUP8XN1NQ==
X-Google-Smtp-Source: AGHT+IEXp2iiwi0OzXg1ybXYcSTK0weNwhbjcuttoe7Qbdl31Zp2IvdlZ6c0LZV7ASE9Q2yxU4WSIg==
X-Received: by 2002:a05:6358:6a95:b0:168:f55d:4ef9 with SMTP id n21-20020a0563586a9500b00168f55d4ef9mr5866825rwh.28.1698270926641;
        Wed, 25 Oct 2023 14:55:26 -0700 (PDT)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:f0fe:5c3b:1d70:d0bb])
        by smtp.gmail.com with ESMTPSA id w14-20020a63160e000000b005b8ebef9fa0sm2994943pgl.83.2023.10.25.14.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 14:55:26 -0700 (PDT)
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
Subject: [PATCH v3 2/7] dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-katsu
Date:   Wed, 25 Oct 2023 14:48:44 -0700
Message-ID: <20231025215517.1388735-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
In-Reply-To: <20231025215517.1388735-1-hsinyi@chromium.org>
References: <20231025215517.1388735-1-hsinyi@chromium.org>
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
2.42.0.758.gaed0368e0e-goog

