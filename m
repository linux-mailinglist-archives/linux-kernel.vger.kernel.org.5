Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57EC7D3B00
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjJWPif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjJWPia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:38:30 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0205EFF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 08:38:28 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32ddfb38c02so2484196f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 08:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698075506; x=1698680306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDj7JS/KJD1xRdPBFzxvlUHQ3OGRor14p4p7hBbICLs=;
        b=PZfWUgoBHqQPm7ulSzYNEGFcDYCyRdrCNuN1AMWOtiyRBdU/EB/cjKzszp3mjh/xde
         6hiGV8eivP/T4AdmuQmgRjO2oH1zlHf6BZjljkjmmH54N5By9V3HYhyZ6pZQjkdarc4m
         2LBzosQAgJ7INxhccOmW7OxJf5mApEhVGixxLyGj7ZWhtjA0TtgjWWRNCn/Foz0lgdhz
         Ed5rtHZFWrT7wHhYFXdUiGVq0S4bUw/z9WQEP5E20JvM7WmtVp46TdO9dr+hjHmIQRa5
         D24T3gX6B08ONgNoy4zNGmkh/rNqu9rrNoiXg5UQGAK61hmOzoCpQ5XB2CprxKAcZ6U/
         8z+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698075506; x=1698680306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BDj7JS/KJD1xRdPBFzxvlUHQ3OGRor14p4p7hBbICLs=;
        b=qmeWPVIQ+oq08sLf4F7XH6/pbTaoWVtAWyxQqeXk45ILi+nYB+/Rb+dNarfbjixdAz
         Nh3phhzmvMtbquT3QoFDg16lAWRSJSjmfbPBuP9oSSDWZIufX+Nt7lHkO87BbvwtEzzN
         RNB363LX482dl0YQ2mBC44TrfxvO/yGwLGYBsL0P+mJwSZMUfwsn9l/qImapydzdSBEt
         hq5fKMDDXlpgHQ1hx3rxW5bUpMcMT2izorrSklpVJIJja/c/eSav6auVjuEgsHm7qePK
         C/3H8W+ySCG/klWjun85DcF2xjPtYImQY38d0xJKZd9/HArNwKi4PjMsZYe+bkxw5mrd
         iXcg==
X-Gm-Message-State: AOJu0YwVBs3DpTeZs/U/i4Ppq5aBV4blqY6o0WKdeZCLEQOzu6WZXtpZ
        1u2J+y6VF+XyBG08xjMN4+c4uQ==
X-Google-Smtp-Source: AGHT+IHSrfR+mTF38SFfpfb5fgSu41v57/oBFZSMoNAELrDb4oNohc50orkkr+qWTWYz2dwBBoBcnw==
X-Received: by 2002:a5d:6443:0:b0:32d:8a4b:2715 with SMTP id d3-20020a5d6443000000b0032d8a4b2715mr7760624wrw.8.1698075506416;
        Mon, 23 Oct 2023 08:38:26 -0700 (PDT)
Received: from x13s-linux.nxsw.local ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id f4-20020a5d50c4000000b0032da319a27asm8096929wrt.9.2023.10.23.08.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 08:38:26 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        dmitry.baryshkov@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jonathan@marek.ca, quic_tdas@quicinc.com,
        vladimir.zapolskiy@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bryan.odonoghue@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3.1 1/4] dt-bindings: clock: Use gcc.yaml for common clock properties
Date:   Mon, 23 Oct 2023 16:38:18 +0100
Message-Id: <20231023153821.189331-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231023153821.189331-1-bryan.odonoghue@linaro.org>
References: <20231023153821.189331-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various of the camcc bindings are repeated serially. We can use
qcom,gcc.yaml to encapsulate the generic repeated patterns.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/clock/qcom,camcc-sm8250.yaml      | 18 ++++--------------
 .../bindings/clock/qcom,sc7180-camcc.yaml      | 18 ++++--------------
 .../bindings/clock/qcom,sc7280-camcc.yaml      | 18 ++++--------------
 .../bindings/clock/qcom,sdm845-camcc.yaml      | 18 ++++--------------
 .../bindings/clock/qcom,sm8450-camcc.yaml      | 18 ++++--------------
 5 files changed, 20 insertions(+), 70 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,camcc-sm8250.yaml b/Documentation/devicetree/bindings/clock/qcom,camcc-sm8250.yaml
index 426335a2841c..3fd3dc1069fb 100644
--- a/Documentation/devicetree/bindings/clock/qcom,camcc-sm8250.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,camcc-sm8250.yaml
@@ -15,6 +15,9 @@ description: |
 
   See also:: include/dt-bindings/clock/qcom,camcc-sm8250.h
 
+allOf:
+  - $ref: qcom,gcc.yaml#
+
 properties:
   compatible:
     const: qcom,sm8250-camcc
@@ -33,15 +36,6 @@ properties:
       - const: bi_tcxo_ao
       - const: sleep_clk
 
-  '#clock-cells':
-    const: 1
-
-  '#reset-cells':
-    const: 1
-
-  '#power-domain-cells':
-    const: 1
-
   power-domains:
     items:
       - description: MMCX power domain
@@ -56,14 +50,10 @@ properties:
 
 required:
   - compatible
-  - reg
   - clocks
   - clock-names
-  - '#clock-cells'
-  - '#reset-cells'
-  - '#power-domain-cells'
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7180-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7180-camcc.yaml
index 2dfc2a4f1918..c7fe6400ea13 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sc7180-camcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sc7180-camcc.yaml
@@ -15,6 +15,9 @@ description: |
 
   See also:: include/dt-bindings/clock/qcom,camcc-sc7180.h
 
+allOf:
+  - $ref: qcom,gcc.yaml#
+
 properties:
   compatible:
     const: qcom,sc7180-camcc
@@ -31,28 +34,15 @@ properties:
       - const: iface
       - const: xo
 
-  '#clock-cells':
-    const: 1
-
-  '#reset-cells':
-    const: 1
-
-  '#power-domain-cells':
-    const: 1
-
   reg:
     maxItems: 1
 
 required:
   - compatible
-  - reg
   - clocks
   - clock-names
-  - '#clock-cells'
-  - '#reset-cells'
-  - '#power-domain-cells'
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7280-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7280-camcc.yaml
index 01feef1cab0a..dcef8de3a905 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sc7280-camcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sc7280-camcc.yaml
@@ -15,6 +15,9 @@ description: |
 
   See also:: include/dt-bindings/clock/qcom,camcc-sc7280.h
 
+allOf:
+  - $ref: qcom,gcc.yaml#
+
 properties:
   compatible:
     const: qcom,sc7280-camcc
@@ -31,28 +34,15 @@ properties:
       - const: bi_tcxo_ao
       - const: sleep_clk
 
-  '#clock-cells':
-    const: 1
-
-  '#reset-cells':
-    const: 1
-
-  '#power-domain-cells':
-    const: 1
-
   reg:
     maxItems: 1
 
 required:
   - compatible
-  - reg
   - clocks
   - clock-names
-  - '#clock-cells'
-  - '#reset-cells'
-  - '#power-domain-cells'
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/clock/qcom,sdm845-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sdm845-camcc.yaml
index 91d1f7918037..810b852ae371 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sdm845-camcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sdm845-camcc.yaml
@@ -15,6 +15,9 @@ description: |
 
   See also:: include/dt-bindings/clock/qcom,camcc-sm845.h
 
+allOf:
+  - $ref: qcom,gcc.yaml#
+
 properties:
   compatible:
     const: qcom,sdm845-camcc
@@ -27,28 +30,15 @@ properties:
     items:
       - const: bi_tcxo
 
-  '#clock-cells':
-    const: 1
-
-  '#reset-cells':
-    const: 1
-
-  '#power-domain-cells':
-    const: 1
-
   reg:
     maxItems: 1
 
 required:
   - compatible
-  - reg
   - clocks
   - clock-names
-  - '#clock-cells'
-  - '#reset-cells'
-  - '#power-domain-cells'
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
index dc3c18e4ead7..6915498deacf 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
@@ -17,6 +17,9 @@ description: |
     include/dt-bindings/clock/qcom,sm8450-camcc.h
     include/dt-bindings/clock/qcom,sm8550-camcc.h
 
+allOf:
+  - $ref: qcom,gcc.yaml#
+
 properties:
   compatible:
     enum:
@@ -40,29 +43,16 @@ properties:
     description:
       A phandle to an OPP node describing required MMCX performance point.
 
-  '#clock-cells':
-    const: 1
-
-  '#reset-cells':
-    const: 1
-
-  '#power-domain-cells':
-    const: 1
-
   reg:
     maxItems: 1
 
 required:
   - compatible
-  - reg
   - clocks
   - power-domains
   - required-opps
-  - '#clock-cells'
-  - '#reset-cells'
-  - '#power-domain-cells'
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.40.1

