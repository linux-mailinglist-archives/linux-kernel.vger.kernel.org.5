Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DA17E389D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 11:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbjKGKQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 05:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbjKGKQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 05:16:21 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51967116
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 02:16:17 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-507b9408c61so7204258e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 02:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699352175; x=1699956975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=95vD72c+bC2P8X8C/IdsTMXs0cKxT+IRop924lJhGj8=;
        b=hm/XMT7SZKzjyj8Ebsm372Kt5mKKn0eOerShTN0y4EaqYFGyT2nkRO7v1MDHjaBH6l
         FvyoRJZ4orOeOHCNBqBcU0vlncqIvAPJUkDvRc1/RR+rYmToBFrxwSr1RRjP0GD7skPk
         jggaO0Eox2MG8CPXzvNfK6L1hiZ8m8Klm2kLmsE1mOAXysg/79hDSUX80k1BCT57D991
         oguSIftO5JTQ+9YbqGhtyxUahhWNyKCUuu/n2RUuDmskDNZOenjvotUrPPDvSyIzJutK
         9KCKOhb8PCi5z5ByEpipK91gmSZcdHntPZyRrYeKuZn/d1omLndnW4rGvH2hyuNwH+Lb
         2OdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699352175; x=1699956975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=95vD72c+bC2P8X8C/IdsTMXs0cKxT+IRop924lJhGj8=;
        b=ejrc25Wlrb376VqHhMK+HaGcBapYOpVHn49EkcSXXhCJRSjwQWYjpDh+7y2yydOruC
         ZCPfXDJmKUQJEMZFOc4oHgVEnq7KZv2wOGXw2Z2g2yneM4s1h8bLUjDeehDVOhFBJXmL
         Khj4JH2OkTELV22oum/Ual/sJ6Oeq1yYb6UxYM3xfWVlXKOPNffJ+ovlbW2IN79cS3CU
         guNvz2lkxWurKuKrDh0U45c9VXj2mD9H9LfRpQPHu7hMr1px00ha1qyy3XbBYCYRz0uy
         TPXdU5fuS0ypiSQhecgDcFii+iSDXb8NAly0g8q/tP28gVeUik48bnMzU26Wd8fw3YIv
         HipQ==
X-Gm-Message-State: AOJu0Yzt4NjNrhLsT/LrJ3/IkHHVw0UGGwNO9EHXSpJSfEKrporcAjl6
        iaDLDYRsx10wMWQZudDlQr9wvQ==
X-Google-Smtp-Source: AGHT+IGJuO6mk0T3Wt1edO/lmNN8eTn2eGwaG7+JJc/a3UervFShShCwhOClqq8GfMz5fuLE3zkgEA==
X-Received: by 2002:ac2:546e:0:b0:507:9855:bc68 with SMTP id e14-20020ac2546e000000b005079855bc68mr23509396lfn.37.1699352175531;
        Tue, 07 Nov 2023 02:16:15 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id l3-20020a05600c4f0300b003fc0505be19sm15249922wmq.37.2023.11.07.02.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 02:16:14 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ryan Lee <ryans.lee@analog.com>, linux-sound@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH] ASoC: dt-bindings: use "soundwire" as controller's node name in examples
Date:   Tue,  7 Nov 2023 11:16:10 +0100
Message-Id: <20231107101610.13728-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Soundwire Devicetree bindings expect the Soundwire controller device
node to be named just "soundwire".  Correct examples, so the incorrect
code will not be re-used.

Reported-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/sound/adi,max98363.yaml | 2 +-
 Documentation/devicetree/bindings/sound/qcom,wsa883x.yaml | 2 +-
 Documentation/devicetree/bindings/sound/qcom,wsa8840.yaml | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/adi,max98363.yaml b/Documentation/devicetree/bindings/sound/adi,max98363.yaml
index a844b63f3930..c388cda56011 100644
--- a/Documentation/devicetree/bindings/sound/adi,max98363.yaml
+++ b/Documentation/devicetree/bindings/sound/adi,max98363.yaml
@@ -39,7 +39,7 @@ unevaluatedProperties: false
 
 examples:
   - |
-    soundwire-controller@3250000 {
+    soundwire@3250000 {
         #address-cells = <2>;
         #size-cells = <0>;
         reg = <0x3250000 0x2000>;
diff --git a/Documentation/devicetree/bindings/sound/qcom,wsa883x.yaml b/Documentation/devicetree/bindings/sound/qcom,wsa883x.yaml
index ba572a7f4f3c..8e462cdf0018 100644
--- a/Documentation/devicetree/bindings/sound/qcom,wsa883x.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,wsa883x.yaml
@@ -52,7 +52,7 @@ examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
 
-    soundwire-controller@3250000 {
+    soundwire@3250000 {
         #address-cells = <2>;
         #size-cells = <0>;
         reg = <0x3250000 0x2000>;
diff --git a/Documentation/devicetree/bindings/sound/qcom,wsa8840.yaml b/Documentation/devicetree/bindings/sound/qcom,wsa8840.yaml
index e6723c9e312a..d717017b0fdb 100644
--- a/Documentation/devicetree/bindings/sound/qcom,wsa8840.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,wsa8840.yaml
@@ -48,7 +48,7 @@ examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
 
-    soundwire-controller {
+    soundwire {
         #address-cells = <2>;
         #size-cells = <0>;
 
-- 
2.34.1

