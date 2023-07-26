Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE95762C08
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 08:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjGZG4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 02:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjGZG4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:56:44 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A01212D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 23:56:40 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5222bc916acso4085970a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 23:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690354599; x=1690959399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeYoJcI9+nc3aMAhSELiLoIJUhDdoYKAVtJZmlKc8rc=;
        b=VGBiX2D8Wkc6uMVIX2s3N9rDZr9TPsjHxr1e4uLCTb5su35xr65IUVY+crCxg4I8xH
         OOCjxuXtXL0HmiXp8/tWx2GThcnSV73ib0Ui06RODzd5tnZ4mRtHmF5OgyMWGs788zsy
         VtVw+aiZ8iJXIJ07f0Lfwzxws6/qV8ffzNJrmQtD/q7uBmJjYK9wRKKMPpW+tiOGqUxg
         kw65XfaBS/8Zis6g5muQr0Z0J8wt+c8/3Jm8tU7eXf558JpC8W6Ne1/wlTSC398EIKw5
         H79szsKBY0ZcOZ9/ANLfibk/8IDP5DxqwNzZQYwlczXBGNGH5isx7e4c9dh+vM7C6S/Y
         a32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690354599; x=1690959399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YeYoJcI9+nc3aMAhSELiLoIJUhDdoYKAVtJZmlKc8rc=;
        b=hCf0BegVT65uSfn/9mJeXxQ18A74usuDqhNE2ubuI46Oxv5lFmn359h5zFxSbfgvHH
         2M1KjOkwi+gdkJyvHvGA2l4mF0lB6nfIQ2DMTAOnc8P+4irpRYf80WFXsKo/2WHyV7H4
         oi48jNzPRQs5eN5EMbTlI4cAUULHCEDxsqokUASaCMzE4Tezp/6lVQhDOPBYvkZz9dGw
         FRjHteNY1KWGKds5+A5iKRAE63ObW/S69zwgrVmJzRkIerrdJ7VsE4YUrcFbWPPJ06di
         5l7LQ0CCg+I9R0fObXclz+0bBpxivpI4/3RUCQ2ccic7XJknvhYANPUl++Ys4nKmrHay
         bUtA==
X-Gm-Message-State: ABy/qLbIGpyJsn/C4+nFz+RIx2+Z9kay2YukHwCt/Rw9Chyi+BDfYF0m
        vo2IGZuMGr4876m0SdIfXbaoEQ==
X-Google-Smtp-Source: APBJJlHISoAIvvOoxDEOIb3s0jT3Wu6oJsKB1Hkw8x3hGuAg+4W++u890P3bp3VMPxwYaoE8/LHoAA==
X-Received: by 2002:a17:906:2002:b0:989:3148:e9a with SMTP id 2-20020a170906200200b0098931480e9amr766471ejo.41.1690354599136;
        Tue, 25 Jul 2023 23:56:39 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id gs18-20020a170906f19200b00993150e5325sm9178420ejb.60.2023.07.25.23.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 23:56:38 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        pascal Paillet <p.paillet@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 2/2] dt-bindings: mfd: stericsson,db8500-prcmu: Add missing unevaluatedProperties for each regulator
Date:   Wed, 26 Jul 2023 08:56:33 +0200
Message-Id: <20230726065633.74924-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726065633.74924-1-krzysztof.kozlowski@linaro.org>
References: <20230726065633.74924-1-krzysztof.kozlowski@linaro.org>
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

Each regulator node, which references common regulator.yaml schema,
should disallow additional or unevaluated properties.  Otherwise
mistakes in properties will go unnoticed.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v3:
1. None

Changes in v2:
1. None
---
 .../bindings/mfd/stericsson,db8500-prcmu.yaml | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/stericsson,db8500-prcmu.yaml b/Documentation/devicetree/bindings/mfd/stericsson,db8500-prcmu.yaml
index 1d4d88f7e82d..678a6c0fd7d6 100644
--- a/Documentation/devicetree/bindings/mfd/stericsson,db8500-prcmu.yaml
+++ b/Documentation/devicetree/bindings/mfd/stericsson,db8500-prcmu.yaml
@@ -72,44 +72,52 @@ properties:
           main voltage domain for the chip.
         type: object
         $ref: ../regulator/regulator.yaml#
+        unevaluatedProperties: false
 
       db8500_varm:
         description: The voltage for the ARM Cortex A-9 CPU.
         type: object
         $ref: ../regulator/regulator.yaml#
+        unevaluatedProperties: false
 
       db8500_vmodem:
         description: The voltage for the modem subsystem.
         type: object
         $ref: ../regulator/regulator.yaml#
+        unevaluatedProperties: false
 
       db8500_vpll:
         description: The voltage for the phase locked loop clocks.
         type: object
         $ref: ../regulator/regulator.yaml#
+        unevaluatedProperties: false
 
       db8500_vsmps1:
         description: Also known as VIO12, is a step-down voltage regulator
           for 1.2V I/O. SMPS means System Management Power Source.
         type: object
         $ref: ../regulator/regulator.yaml#
+        unevaluatedProperties: false
 
       db8500_vsmps2:
         description: Also known as VIO18, is a step-down voltage regulator
           for 1.8V I/O. SMPS means System Management Power Source.
         type: object
         $ref: ../regulator/regulator.yaml#
+        unevaluatedProperties: false
 
       db8500_vsmps3:
         description: This is a step-down voltage regulator
           for 0.87 thru 1.875V I/O. SMPS means System Management Power Source.
         type: object
         $ref: ../regulator/regulator.yaml#
+        unevaluatedProperties: false
 
       db8500_vrf1:
         description: RF transciever voltage regulator.
         type: object
         $ref: ../regulator/regulator.yaml#
+        unevaluatedProperties: false
 
       db8500_sva_mmdsp:
         description: Smart Video Accelerator (SVA) multimedia DSP (MMDSP)
@@ -117,18 +125,21 @@ properties:
           for video encoding and decoding.
         type: object
         $ref: ../regulator/regulator.yaml#
+        unevaluatedProperties: false
 
       db8500_sva_mmdsp_ret:
         description: Smart Video Accelerator (SVA) multimedia DSP (MMDSP)
           voltage regulator for retention mode.
         type: object
         $ref: ../regulator/regulator.yaml#
+        unevaluatedProperties: false
 
       db8500_sva_pipe:
         description: Smart Video Accelerator (SVA) multimedia DSP (MMDSP)
           voltage regulator for the data pipe.
         type: object
         $ref: ../regulator/regulator.yaml#
+        unevaluatedProperties: false
 
       db8500_sia_mmdsp:
         description: Smart Image Accelerator (SIA) multimedia DSP (MMDSP)
@@ -136,18 +147,21 @@ properties:
           for image encoding and decoding.
         type: object
         $ref: ../regulator/regulator.yaml#
+        unevaluatedProperties: false
 
       db8500_sia_mmdsp_ret:
         description: Smart Image Accelerator (SIA) multimedia DSP (MMDSP)
           voltage regulator for retention mode.
         type: object
         $ref: ../regulator/regulator.yaml#
+        unevaluatedProperties: false
 
       db8500_sia_pipe:
         description: Smart Image Accelerator (SIA) multimedia DSP (MMDSP)
           voltage regulator for the data pipe.
         type: object
         $ref: ../regulator/regulator.yaml#
+        unevaluatedProperties: false
 
       db8500_sga:
         description: Smart Graphics Accelerator (SGA) voltage regulator.
@@ -155,6 +169,7 @@ properties:
           accelerator block.
         type: object
         $ref: ../regulator/regulator.yaml#
+        unevaluatedProperties: false
 
       db8500_b2r2_mcde:
         description: Blit Blend Rotate and Rescale (B2R2), and Multi-Channel
@@ -162,28 +177,33 @@ properties:
           blocks.
         type: object
         $ref: ../regulator/regulator.yaml#
+        unevaluatedProperties: false
 
       db8500_esram12:
         description: Embedded Static RAM (ESRAM) 1 and 2 voltage regulator.
         type: object
         $ref: ../regulator/regulator.yaml#
+        unevaluatedProperties: false
 
       db8500_esram12_ret:
         description: Embedded Static RAM (ESRAM) 1 and 2 voltage regulator for
           retention mode.
         type: object
         $ref: ../regulator/regulator.yaml#
+        unevaluatedProperties: false
 
       db8500_esram34:
         description: Embedded Static RAM (ESRAM) 3 and 4 voltage regulator.
         type: object
         $ref: ../regulator/regulator.yaml#
+        unevaluatedProperties: false
 
       db8500_esram34_ret:
         description: Embedded Static RAM (ESRAM) 3 and 4 voltage regulator for
           retention mode.
         type: object
         $ref: ../regulator/regulator.yaml#
+        unevaluatedProperties: false
 
     required:
       - compatible
-- 
2.34.1

