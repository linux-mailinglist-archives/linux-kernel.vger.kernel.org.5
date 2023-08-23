Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C4378622A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 23:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237447AbjHWVRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 17:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237735AbjHWVRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 17:17:18 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF9F1702;
        Wed, 23 Aug 2023 14:16:58 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31aeedbb264so4023600f8f.0;
        Wed, 23 Aug 2023 14:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692825417; x=1693430217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0SXq78kITy+3F6975QNYAlOEwatlqb3yYsPUiIzHhc=;
        b=BqMoyWKVPmaVRnuEAnAFskDkZqw0g4JOWqkssnXg/IhvapZ8gRuMtQPII131OMw3Pb
         VqHkxZ/VQb1cCMoeaf9TFVLtJ5b2OGYL8P5uYYCo/nEwifFserg7H8/VqPxv0BfvELSg
         Wb7hG6OFl+WKJZOKPpioh9x7hbOlbN7rVpDRzG+2+iRMWzx6raKTVk9brM9W7OeM/f0K
         mzEhLZOcg3+oh4scFyA82j22+g1L0QuNtQctk+63HAptUz80LE/M7cDWjAUc62RpDHGv
         /L8tGJz9Usi+1k8GiRPlkDgdQPbW6uOPMPqVmY4wuCDxTggx/irUpXlwPMffaSmm0xmn
         qNvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692825417; x=1693430217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0SXq78kITy+3F6975QNYAlOEwatlqb3yYsPUiIzHhc=;
        b=RITYuaojjv9QcqdVTBQaPwNLqMHlRipg5Aa9XAorDkOlom1yNkEvn8gSvR+hkOGcwz
         azCZ2gwM5LdAJe9+0FylobcxJNFXforA4et/txYFa9miI48mozsNrKiLRspRyKY+8vdu
         Li7hYAQ4eWfY8UDiN1R1Qp5q3+1nfhEiw64nk3cJyCl438x3mIX7wsZyl94+pzJzkjJK
         /8KepUKbFT30JJf/VTLTuIs6ZGjAay0PRQ6Xqwg2ToPHFe64QT/36chLiHkJ+phO3oVV
         IvY0i1nqpZ6TtJbdXxZp3QuWk07fvffgZ1G5tONGaLFZywk1uoE4SZJFZb3N2UBm/Yel
         lkuQ==
X-Gm-Message-State: AOJu0YwRJ+psEP2fhhMaGpZBqI8Y3F8LcjmLoFK/3pmmMFkJU+zRS/5W
        vMA5nq8HwnKQW3I9bgbyC0VsovzUh07hAA==
X-Google-Smtp-Source: AGHT+IEVIgvede2H6lzCsw9URrQcv9ofjSzlZO2INQ515SlTKlOLmVCesgJYDK4nGVfg6RqZieS4IA==
X-Received: by 2002:adf:e5cf:0:b0:314:2132:a277 with SMTP id a15-20020adfe5cf000000b003142132a277mr11043759wrn.9.1692825416657;
        Wed, 23 Aug 2023 14:16:56 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:bb2:6df0:64ae:3840:3a64:b26a])
        by smtp.gmail.com with ESMTPSA id p11-20020adfe60b000000b003176c6e87b1sm20193399wrm.81.2023.08.23.14.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 14:16:54 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v8 1/7] dt-bindings: iio: Add KX132-1211 accelerometer
Date:   Wed, 23 Aug 2023 23:16:35 +0200
Message-Id: <0d6051ad217f91c7de0883c4ca1516bdacc343ce.1692824815.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1692824815.git.mehdi.djait.k@gmail.com>
References: <cover.1692824815.git.mehdi.djait.k@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the kionix,kx022a.yaml file to support the kx132-1211 device

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
v8:
v7:
v6:
v5:
v4:
v3:
- no changes 

 .../devicetree/bindings/iio/accel/kionix,kx022a.yaml | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml b/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
index 986df1a6ff0a..034b69614416 100644
--- a/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
@@ -4,19 +4,21 @@
 $id: http://devicetree.org/schemas/iio/accel/kionix,kx022a.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: ROHM/Kionix KX022A Accelerometer
+title: ROHM/Kionix KX022A and KX132-1211 Accelerometers
 
 maintainers:
   - Matti Vaittinen <mazziesaccount@gmail.com>
 
 description: |
-  KX022A is a 3-axis accelerometer supporting +/- 2G, 4G, 8G and 16G ranges,
-  output data-rates from 0.78Hz to 1600Hz and a hardware-fifo buffering.
-  KX022A can be accessed either via I2C or SPI.
+  KX022A and KX132-1211 are 3-axis accelerometers supporting +/- 2G, 4G, 8G and
+  16G ranges, variable output data-rates and a hardware-fifo buffering.
+  KX022A and KX132-1211 can be accessed either via I2C or SPI.
 
 properties:
   compatible:
-    const: kionix,kx022a
+    enum:
+      - kionix,kx022a
+      - kionix,kx132-1211
 
   reg:
     maxItems: 1
-- 
2.30.2

