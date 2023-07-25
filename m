Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0107618AB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 14:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjGYMqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 08:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbjGYMqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 08:46:37 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978C5B0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 05:46:36 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-98dfb3f9af6so933354266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 05:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690289195; x=1690893995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70cgH7bcTezXiFaY+4RlRcKU5uTrnjXCHWZFlgmgH40=;
        b=vZruUF3l7G9M/Qs7fx13Nq6q7Xt4B31DfefiM9maCXsLl7SHRZlX7dmPDAi2cqbkfV
         r311SrWYNErkvw3Y8pn32iObCCP/ZwM5Ha3wHmPueD+rKNyCRLEODVmX7zOIpMjcGPlR
         /PV87IF4YRLW7nIidvwxpg0WqebvDIPKBfZryDNEzt3Uc4KOjLIbd6ZM0eyC4Ef/VCbf
         bqgXfPP3tsNbawD8+waZBUigGw6l9TE/NFnQ18uXKi1sOb2vXuiH34kQRkrrc50G4F3i
         TZsp0cs0yJ1GJw59dTLw5c3KjPId9MjS3yOcFdWoKDr30WXVQEyzWg5PWdaI7PXq3pJV
         NG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690289195; x=1690893995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=70cgH7bcTezXiFaY+4RlRcKU5uTrnjXCHWZFlgmgH40=;
        b=N2mo46lFMpfS4Y0874Z3jCyimN7a4n3OVxNiz4Oq38EbJjcHGMHiYJ/GdDd0Thwn3p
         6pgAFiNfRe/yhz+cDKiNDVwAbk2kpidJsoIOAiBx2pii+BpGASpA8t8qnZsAbIKH5gJO
         1EenLMMvX5VIxGo+a8xQF/TQjHvh9f/IeHufA5BeNyqZOG9h0ewCKVUIeFtlpmwI+cYM
         8T1lqOyumY5SMfgUAgndjN+97+gE9kxnaFwV2j2AEU5AUWx9Hfu0nFonutSrXjFq95c9
         HZ06RFlFJdLZayxhMSpmXtLVN2Q1RiuRXWnSksJj//pKGlyHLhFF0KCav3xlfSX/iRF6
         TN9w==
X-Gm-Message-State: ABy/qLYR7EHLRqpIT+p8gWcFKX1nkN6xN4zuPwLlPn4P8q1dAbjGh5j1
        Lmh15Pnnu2mWR0EWsfYi1UxeYoA+GnqL8+IG2MM=
X-Google-Smtp-Source: APBJJlHjcFCQPbCZPxda5Sw+HCmSh48wGz11AgbOvYmiM3xmc6PtjaJLwXjzXSLP5fZ9HMGQQZXZ7g==
X-Received: by 2002:a17:906:73c1:b0:993:f4cd:34b5 with SMTP id n1-20020a17090673c100b00993f4cd34b5mr13377645ejl.29.1690289195056;
        Tue, 25 Jul 2023 05:46:35 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id xo18-20020a170907bb9200b0099b5a71b0bfsm7970576ejc.94.2023.07.25.05.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 05:46:34 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Adam Ward <Adam.Ward.opensource@diasemi.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] regulator: dt-bindings: active-semi,act8846: correct supplies
Date:   Tue, 25 Jul 2023 14:46:29 +0200
Message-Id: <20230725124629.150113-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230725124629.150113-1-krzysztof.kozlowski@linaro.org>
References: <20230725124629.150113-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regulator supplies are per-device, not per regulator, so they are
expected to be present in device node.  Moving them to proper place
allows to simplify a lot, because now none of the regulators differ.

This also fixes dtbs_check warnings like:

  rk3368-evb-act8846.dtb: act8846@5a: 'inl1-supply', 'inl2-supply', 'inl3-supply', 'vp1-supply',
    'vp2-supply', 'vp3-supply', 'vp4-supply' do not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../regulator/active-semi,act8846.yaml        | 82 +++++--------------
 1 file changed, 22 insertions(+), 60 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/active-semi,act8846.yaml b/Documentation/devicetree/bindings/regulator/active-semi,act8846.yaml
index 3725348bb235..02f45b5834d0 100644
--- a/Documentation/devicetree/bindings/regulator/active-semi,act8846.yaml
+++ b/Documentation/devicetree/bindings/regulator/active-semi,act8846.yaml
@@ -28,75 +28,37 @@ properties:
       the VSEL pin is assumed to be low.
     type: boolean
 
+  inl1-supply:
+    description: Handle to the INL1 input supply (REG5-7)
+
+  inl2-supply:
+    description: Handle to the INL2 input supply (REG8-9)
+
+  inl3-supply:
+    description: Handle to the INL3 input supply (REG10-12)
+
+  vp1-supply:
+    description: Handle to the VP1 input supply (REG1)
+
+  vp2-supply:
+    description: Handle to the VP2 input supply (REG2)
+
+  vp3-supply:
+    description: Handle to the VP3 input supply (REG3)
+
+  vp4-supply:
+    description: Handle to the VP4 input supply (REG4)
+
   regulators:
     type: object
     additionalProperties: false
 
-    properties:
-      REG1:
-        type: object
-        $ref: /schemas/regulator/regulator.yaml#
-        unevaluatedProperties: false
-
-        properties:
-          vp1-supply:
-            description: Handle to the VP1 input supply
-
-      REG2:
-        type: object
-        $ref: /schemas/regulator/regulator.yaml#
-        unevaluatedProperties: false
-
-        properties:
-          vp2-supply:
-            description: Handle to the VP2 input supply
-
-      REG3:
-        type: object
-        $ref: /schemas/regulator/regulator.yaml#
-        unevaluatedProperties: false
-
-        properties:
-          vp3-supply:
-            description: Handle to the VP3 input supply
-
-      REG4:
-        type: object
-        $ref: /schemas/regulator/regulator.yaml#
-        unevaluatedProperties: false
-
-        properties:
-          vp4-supply:
-            description: Handle to the VP4 input supply
-
     patternProperties:
-      "^REG[5-7]$":
+      "^REG([1-9]|1[0-2])$":
         type: object
         $ref: /schemas/regulator/regulator.yaml#
         unevaluatedProperties: false
 
-        properties:
-          inl1-supply:
-            description: Handle to the INL1 input supply
-
-      "^REG[8-9]$":
-        type: object
-        $ref: /schemas/regulator/regulator.yaml#
-        unevaluatedProperties: false
-
-        properties:
-          inl2-supply:
-            description: Handle to the INL2 input supply
-
-      "^REG1[0-2]$":
-        type: object
-        $ref: /schemas/regulator/regulator.yaml#
-        unevaluatedProperties: false
-
-        properties:
-          inl3-supply:
-            description: Handle to the INL3 input supply
-
 additionalProperties: false
 
 required:
-- 
2.34.1

