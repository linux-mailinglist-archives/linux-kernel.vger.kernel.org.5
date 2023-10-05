Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5C77B9F96
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbjJEO0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbjJEOYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:24:06 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B809008
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 01:36:55 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9ad8a822508so137778666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 01:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696495014; x=1697099814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b8UTzhAdpyBQxIe5FDho0E0NnDq18CgBro9Bv3TILXw=;
        b=qNOw5QDqz1U7dhoRI5x1OY260qBxXhNrZq/lh/fw/x31GjTF/jvl0uZW8yoZM3VP8p
         QwMsR7CIXTjRAsnLzkUraqwaiKKyiDBm8AiA7PRqmAhSbPGEYWuQ7hT2EPkhINP2GeFl
         tmZqon3Sxw+793p0kZk1YS4iKcO5dAWvVBkPo29NfWRjhpttlTj8jxJ7HcAc8KufHAFS
         ZZ6Rwf/7eww6mgQAHXXcdAZYQnd18Enz/+o5NF51s10SvPas17wd5TtLPWFXAKVNGPrJ
         SqpLGmlQbm3sIN52B44CJHbfURII70opAUYFme5nVej9+T1FKhx0bKzSYB0et52LkDvm
         JesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696495014; x=1697099814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b8UTzhAdpyBQxIe5FDho0E0NnDq18CgBro9Bv3TILXw=;
        b=HSw6vVaono/1hZ+FY9vl+24FF0pji4DFFEgdWtJ6wyOmO9QU85DooRG4A6zN2NKPQp
         e+e3m7MMelhSSSkVFJx0NvfzmTDhLbjI00i6c1azIspZKxaufGrnBdPdqICnbSHc5PZe
         oE1DJzyFicUgkuEtLlbBiPs1ByYZGfYjt92k5wHyxDRPCR1EWXxukbJLEN5uDFR3x/Gx
         8nc+QXXzoKfSiUwaUh5R6ipnE93GqGljoBhu3Wxw7I8vDf9zTcd/oyYzRQ1Zni6WMnOR
         5tV9RlQnBOrWmxd6BQ0HVrcKMLDkiK/xRJ5FYlD1kFDK8GHsSLfh3kibBP8h1ybvbXxy
         mOCQ==
X-Gm-Message-State: AOJu0Yy8LxVdObpDi1XZ3y6mthSnxb2shLbHC57c2Q+1dkqXrqp39Lli
        U65xx71v0ZRRxCNPBKXU4xtXgg==
X-Google-Smtp-Source: AGHT+IFj3x7hP+Xsklyuu9mY6jxW5m7RoNCenO2OgtzW5rQJ1pySLYfpomU4uGapvb3bWcxfehQX9A==
X-Received: by 2002:a17:906:2da:b0:9b2:ccd8:2d2b with SMTP id 26-20020a17090602da00b009b2ccd82d2bmr4134279ejk.77.1696495014255;
        Thu, 05 Oct 2023 01:36:54 -0700 (PDT)
Received: from krzk-bin.. (5-157-101-10.dyn.eolo.it. [5.157.101.10])
        by smtp.gmail.com with ESMTPSA id i8-20020a17090671c800b009a198078c53sm780677ejk.214.2023.10.05.01.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 01:36:53 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: iio: add missing reset-gpios constrain
Date:   Thu,  5 Oct 2023 10:36:50 +0200
Message-Id: <20231005083650.92222-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Documentation/devicetree/bindings/gpio/gpio-consumer-common.yaml
schema does not enforce number of reset GPIOs, thus each device binding
must do it.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml | 3 ++-
 Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml    | 3 ++-
 Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml | 3 ++-
 Documentation/devicetree/bindings/iio/health/ti,afe4404.yaml | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml b/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
index 2594fa192f93..2a04906531fb 100644
--- a/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
+++ b/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
@@ -32,7 +32,8 @@ properties:
 
   spi-cpol: true
 
-  reset-gpios: true
+  reset-gpios:
+    maxItems: 1
 
   interrupts:
     minItems: 1
diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml
index 4e508bfcc9d8..5121685337b5 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml
@@ -78,7 +78,8 @@ properties:
           - const: -1000
           - const: 22000
 
-  reset-gpios: true
+  reset-gpios:
+    maxItems: 1
 
   adi,dc-dc-ilim-microamp:
     enum: [150000, 200000, 250000, 300000, 350000, 400000]
diff --git a/Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml b/Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml
index b9b5beac33b2..5b6cde86b5a5 100644
--- a/Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml
+++ b/Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml
@@ -23,7 +23,8 @@ properties:
     maxItems: 1
     description: Connected to ADC_RDY pin.
 
-  reset-gpios: true
+  reset-gpios:
+    maxItems: 1
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/iio/health/ti,afe4404.yaml b/Documentation/devicetree/bindings/iio/health/ti,afe4404.yaml
index 2958c4ca75b4..167d10bd60af 100644
--- a/Documentation/devicetree/bindings/iio/health/ti,afe4404.yaml
+++ b/Documentation/devicetree/bindings/iio/health/ti,afe4404.yaml
@@ -23,7 +23,8 @@ properties:
     maxItems: 1
     description: Connected to ADC_RDY pin.
 
-  reset-gpios: true
+  reset-gpios:
+    maxItems: 1
 
 additionalProperties: false
 
-- 
2.34.1

