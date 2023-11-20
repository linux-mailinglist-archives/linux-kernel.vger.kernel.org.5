Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7107F0FD0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbjKTKGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbjKTKG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:06:28 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65836D9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:06:23 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-543456dbd7bso10031959a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700474782; x=1701079582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BNQ2xPx++wH1nrxiKy++CwCgkNUnb0789llzrpG+llY=;
        b=B/PEQ78mZuZ9GPtvo69D+zfDxtXZpG6/YYWVQDWwrR96Sizzr8tqpKqpw3norQCpuS
         Woa7VCgJRDEMkNZOxA0K6nTp77oxLY9A2IRRHrPNR+g4aodiHNcTa4sWrKb3ylL6hlU+
         vGBM1r4kFWThlbrIn1pWe26dkyssodLoi9+wQHzZj+atb9qmgXJ0ExbhoLMAEFL7mxNR
         v8pmys9p5bW4ztMSDsyOszXBbCFTjp3gmrNW2cxYKEmZaMRQR4pENQRPGbR+H/2s7y1o
         aHGmRnLPOQPqkJkL7Lg6bpW6skVFTElHsiYBDIJXXtlxTlk3vCFch0u0S9OzSaWx+KNp
         SHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700474782; x=1701079582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BNQ2xPx++wH1nrxiKy++CwCgkNUnb0789llzrpG+llY=;
        b=OzXL4mTSn+xnbEYXVFSvvwFLdOhZUMrc3WttPnvY/WaohAZPVIm1RXBxnCK/owk7AC
         DpxYPj+OJ/F4cm0IRx/ZK8YBqMt/Hm0aziDTwINMvX+WoKFdaQYjjW1Bw4Bp+GKOwYJO
         clQclpHoE0OwGiB/wZVWnhsTl7at2y53VMrhJdx7MVSJTrsyGlKca/007LcQ5K+Ic82b
         OVhaUoN/MMpeaevr+82cFSaoVyIhdvjTiKhaJKkB82lE/PS6owFeohFlnljd0SOul9sG
         P9iQ0hIw6yVTe9bBVoKKOSzwn6Mjp53b6MH7X0p2u4sIKnM79jixKgh3Lm0d0D7tOU0x
         enYA==
X-Gm-Message-State: AOJu0YwcZlk0K0Q/+/hfl+xKdg56jScuGoVLj6aRxzqMZAaQCTGUdk+4
        a03/Kew3Tv7n85936MgFqc+S3w==
X-Google-Smtp-Source: AGHT+IHAYX5jbEOAAbb7JbyibH41NWLc5m7fX4drhHV55VH6R4hupBnKsasjqhtvfqGrVuuzbd1fDw==
X-Received: by 2002:a17:906:74d1:b0:9c7:59ff:b7fd with SMTP id z17-20020a17090674d100b009c759ffb7fdmr1311917ejl.28.1700474781661;
        Mon, 20 Nov 2023 02:06:21 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.11])
        by smtp.gmail.com with ESMTPSA id f16-20020a170906391000b009fe16be6a65sm1075022eje.63.2023.11.20.02.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 02:06:20 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH] dt-bindings: arm: qcom-soc: extend pattern for matching existing SoCs
Date:   Mon, 20 Nov 2023 11:06:17 +0100
Message-Id: <20231120100617.47156-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing QDU, QRU and SDA platform names to the pattern matching all
Qualcomm compatibles.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Sibi Sankar <quic_sibis@quicinc.com>
---
 .../devicetree/bindings/arm/qcom-soc.yaml        | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom-soc.yaml b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
index 97621c92a1ab..09db42456c12 100644
--- a/Documentation/devicetree/bindings/arm/qcom-soc.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
@@ -23,7 +23,7 @@ description: |
 select:
   properties:
     compatible:
-      pattern: "^qcom,.*(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$"
+      pattern: "^qcom,.*(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sc|sd[amx]|sm)[0-9]+.*$"
   required:
     - compatible
 
@@ -31,17 +31,17 @@ properties:
   compatible:
     oneOf:
       # Preferred naming style for compatibles of SoC components:
-      - pattern: "^qcom,(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0-9]+(pro)?-.*$"
+      - pattern: "^qcom,(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sc|sd[amx]|sm)[0-9]+(pro)?-.*$"
       - pattern: "^qcom,(sa|sc)8[0-9]+[a-z][a-z]?-.*$"
 
       # Legacy namings - variations of existing patterns/compatibles are OK,
       # but do not add completely new entries to these:
-      - pattern: "^qcom,[ak]pss-wdt-(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$"
-      - pattern: "^qcom,gcc-(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$"
-      - pattern: "^qcom,mmcc-(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$"
-      - pattern: "^qcom,pcie-(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$"
-      - pattern: "^qcom,rpm-(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$"
-      - pattern: "^qcom,scm-(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$"
+      - pattern: "^qcom,[ak]pss-wdt-(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sc|sd[amx]|sm)[0-9]+.*$"
+      - pattern: "^qcom,gcc-(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sc|sd[amx]|sm)[0-9]+.*$"
+      - pattern: "^qcom,mmcc-(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sc|sd[amx]|sm)[0-9]+.*$"
+      - pattern: "^qcom,pcie-(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sc|sd[amx]|sm)[0-9]+.*$"
+      - pattern: "^qcom,rpm-(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sc|sd[amx]|sm)[0-9]+.*$"
+      - pattern: "^qcom,scm-(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sc|sd[amx]|sm)[0-9]+.*$"
       - enum:
           - qcom,dsi-ctrl-6g-qcm2290
           - qcom,gpucc-sdm630
-- 
2.34.1

