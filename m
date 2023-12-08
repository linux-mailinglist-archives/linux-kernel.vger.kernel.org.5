Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4AA80AF24
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 22:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574836AbjLHV4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 16:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574819AbjLHVzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 16:55:52 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7B1171C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 13:55:54 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40c19f5f822so14509735e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 13:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702072553; x=1702677353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SEeLdU51VRNsuOcRrVYSiWWzAmn1Zq+LC8LhMRr8pI=;
        b=W96UevFXHl/EVdt6Bhj2JzTDPGHKF6qokrUFOQmtJIbu89BRrlTEN/erVkUVOBVjVW
         zuLEQDZHTyXqwpvMMoaDk6Bq7KkPiJXbP+JGUuTCOZNE/u2cfqdvAxArlKm4mjUhTQQ6
         vr0v8PqMl98MgqVmmrOV4ol+P41mxCyC2+ndBEnieC/DLoc1DuQkrjxKOgnuRB5hzVB+
         jKHgPISr/Jlq2xmTbc4cM7BtHtRPNwfmXm0/DXjCI4vz7r3GQ8O/hhgYRFOGQf0xM7Mm
         N7AR2PqUT6jDzhcfBuMVVGcZ18GCsTyySEkKVw+8byJIQT0lmkUXugmRMH7QBkt7+JFE
         YVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702072553; x=1702677353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7SEeLdU51VRNsuOcRrVYSiWWzAmn1Zq+LC8LhMRr8pI=;
        b=F99s/+oQvZxW2jA/CMOZNuSwORHt+TlaxHRZB/2aa5W/VlNFPzkR7tvgh/a7fo6HUs
         cfzOil+U9gutivPnKqrypWTExTsGRr/Q/9x5BsBzeGZb7STOheMPWiMJsxxge0a7FEab
         0ofqjEA409fd1AJJCFNAdtPHib6e8KkXtS7v5CBrIeI0KKCfNtUXNU9nsxO80ow8NohX
         bZjvdEahBFeA/JY4h56bkxBpQy4h/m3G3b0wpylzXpoY8Xy9ywkhBQ1laEahyzlQdVAs
         hoauv+E7jYqlIY4pNIJnxOTiKhDdnGrNAZm7VfjRrMQnvs1Q6M3ZwUdTn/w9fqOEjbvP
         LHhw==
X-Gm-Message-State: AOJu0YwNkqM/NnLMrmy5v9xic5Mn/AgJ3aRQkP/FqO9pAWmSEFIXpUix
        gCtAoPC/hVF3zfHXfr0H5feidA==
X-Google-Smtp-Source: AGHT+IH2YxIlTLLK4i5DS0Di7M3Nby75kSR11nKAeqN1WNZPe7dcmtNKoTml4velulZGPfOwezFslA==
X-Received: by 2002:a05:600c:54c4:b0:40c:3984:4985 with SMTP id iw4-20020a05600c54c400b0040c39844985mr215151wmb.79.1702072553351;
        Fri, 08 Dec 2023 13:55:53 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id r20-20020a05600c459400b0040b349c91acsm6321789wmo.16.2023.12.08.13.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 13:55:53 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Rohit Agarwal <quic_rohiagar@quicinc.com>,
        Iskren Chernev <me@iskren.info>,
        Martin Botka <martin.botka@somainline.org>,
        Danila Tikhonov <danila@jiaxyga.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 06/10] dt-bindings: pinctrl: qcom,sm8650-tlmm: restrict number of interrupts
Date:   Fri,  8 Dec 2023 22:55:30 +0100
Message-Id: <20231208215534.195854-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208215534.195854-1-krzysztof.kozlowski@linaro.org>
References: <20231208215534.195854-1-krzysztof.kozlowski@linaro.org>
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

SM8650 TLMM pin controller comes with only one interrupt, so narrow
the number of interrupts previously defined in common TLMM bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pinctrl/qcom,sm8650-tlmm.yaml         | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8650-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8650-tlmm.yaml
index 30432be8fb07..370789ce934b 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8650-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8650-tlmm.yaml
@@ -22,7 +22,9 @@ properties:
   reg:
     maxItems: 1
 
-  interrupts: true
+  interrupts:
+    maxItems: 1
+
   interrupt-controller: true
   "#interrupt-cells": true
   gpio-controller: true
-- 
2.34.1

