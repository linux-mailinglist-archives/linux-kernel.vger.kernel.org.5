Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBB1806F35
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377875AbjLFLyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377980AbjLFLyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:54:05 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C2D1BE2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 03:53:41 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50be9e6427dso4691557e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 03:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701863619; x=1702468419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3Vdsej8Bcsh3gYcNaeKTgqd2sJv+6EY0djT8yDBbDk=;
        b=EuJb61s1xzZ1uFZdlp1PEd9uNv5NOjXtFxiXrm7kUEJZbhYuY5fyZEeCVJqtsd42aS
         X2TWswrASShvWvwi2A+hOFHGGYgbwIC55mdRW+Nrhv6jNTkb+5rFpaNzjBHU6a96NwXs
         IqfGEBHK1xjWFlUNQluISZ/8uqJXSX6PQKtYeDDcrNDD2eP2C+LgciKKigXsybjnjTPy
         bP7dyKjcFvJvA98xLlDdZVY6RMJY1qlJhTE19KWQN0kb23i3QZGmrA7U/jCbdTH12HCY
         2O2n0ZQo8GFOBMkFXJsyu9NFNd5OMk9XM1F2AdgsP+gp6+bngeOUVn00gPqnFLtDXLz2
         Bvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701863619; x=1702468419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A3Vdsej8Bcsh3gYcNaeKTgqd2sJv+6EY0djT8yDBbDk=;
        b=dA79h7zYFKuRpgg01LHyV2kdHZ79gYlWNAoYcHaElK58LyaCrWqN9htWnTP5TFIJ1D
         iqorGNbK5Rz5zM8gdnNnaPvQfxZsie4j/Qo/2zA8L1jHv+ZV2Fgp8xHT9E775Nti0MYn
         dtFX2rU19YV7Mf8OV8cJXrBClUuMucZjrQjjAKhNEvCog/lAk66/RKX8nGAQBaoX3wlV
         rdbvot6lbcH8vnP3cKm3IpJcgC2UaKBidBiNHG4FGMQkGPnu4lOV5KrAUmBwsaXaDSft
         4f7GfdJpjscTABQFXS1lelw81FGLd8OBx5olKdARwSN6Hu0WiviQgDIWcGlWiB2IehL7
         ha6g==
X-Gm-Message-State: AOJu0Ywc0nDEp09H3gYgCFUy/5iEUbQwr59QIYNAoO6iBylqhtMFE2zj
        6zdPJLCNM5CCIVpaj4ECY/ojAg==
X-Google-Smtp-Source: AGHT+IHPKqZmkMmocmv6VlyRh3i7wWNqaLeXnscUcnHn1+t/hyTb1DxF2EOqUPCQHRREgTtRU41nXQ==
X-Received: by 2002:a05:6512:3e01:b0:50b:e77d:32e4 with SMTP id i1-20020a0565123e0100b0050be77d32e4mr581228lfv.60.1701863619674;
        Wed, 06 Dec 2023 03:53:39 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id i13-20020a056402054d00b0054c4fdb42e5sm2337326edx.74.2023.12.06.03.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 03:53:39 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mao Jinlong <quic_jinlmao@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] dt-bindings: arm: qcom,coresight-tpda: fix indentation in the example
Date:   Wed,  6 Dec 2023 12:53:32 +0100
Message-Id: <20231206115332.22712-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206115332.22712-1-krzysztof.kozlowski@linaro.org>
References: <20231206115332.22712-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix triple-space indentation to double-space in the example DTS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/arm/qcom,coresight-tpda.yaml     | 32 +++++++++----------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
index 66d291b56019..b748cf21a4d7 100644
--- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
@@ -96,33 +96,31 @@ examples:
   # minimum tpda definition.
   - |
     tpda@6004000 {
-       compatible = "qcom,coresight-tpda", "arm,primecell";
-       reg = <0x6004000 0x1000>;
+      compatible = "qcom,coresight-tpda", "arm,primecell";
+      reg = <0x6004000 0x1000>;
 
-       clocks = <&aoss_qmp>;
-       clock-names = "apb_pclk";
+      clocks = <&aoss_qmp>;
+      clock-names = "apb_pclk";
 
-       in-ports {
-         #address-cells = <1>;
-         #size-cells = <0>;
+      in-ports {
+        #address-cells = <1>;
+        #size-cells = <0>;
 
         port@0 {
           reg = <0>;
           tpda_qdss_0_in_tpdm_dcc: endpoint {
-            remote-endpoint =
-              <&tpdm_dcc_out_tpda_qdss_0>;
-            };
+            remote-endpoint = <&tpdm_dcc_out_tpda_qdss_0>;
+          };
         };
       };
 
-       out-ports {
-         port {
-                 tpda_qdss_out_funnel_in0: endpoint {
-                    remote-endpoint =
-                    <&funnel_in0_in_tpda_qdss>;
-                  };
+      out-ports {
+        port {
+          tpda_qdss_out_funnel_in0: endpoint {
+            remote-endpoint = <&funnel_in0_in_tpda_qdss>;
           };
-       };
+        };
+      };
     };
 
 ...
-- 
2.34.1

