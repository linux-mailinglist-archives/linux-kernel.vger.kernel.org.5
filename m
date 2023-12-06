Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC814806F3F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377854AbjLFLzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377853AbjLFLzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:55:09 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE7819B6
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 03:53:39 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50be8ced3ddso5057666e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 03:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701863618; x=1702468418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79i0nr6Mx6SDbEcWLjAX+WhVuGqRhzWJkAvdfcMiEaU=;
        b=p3QqQYRsXWnbie5anhv/gEkVbmXP+eNkMWIqF0qOZJjof3kLrph+lqB5F0Bc2Gxr0j
         rxNHvLYAXfmdFv/k886Unc/++nB1yCsa4Vqa4nzO8FQvKJmZibNRNMndsIdVX+xGQ0xP
         vdV+nkfWmR1PkxvPyJqGoKkL55KqdzYfSOjx4WrVeBIGQo6Et9DXfxqvwnkkleQYHpLT
         iFda1dgJGvEzAMxnF+YZmGxfS0uMNtExTzbV78MjzsbXGEn0vtyZdh2nvaeJJdJ9Q02b
         nN6aR0Rto3AXzUVgE7J84UMxRFbac2QfYTed2E8Yw1HtEWDvbjgUMb6H6RFRTxDKPTGA
         vEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701863618; x=1702468418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79i0nr6Mx6SDbEcWLjAX+WhVuGqRhzWJkAvdfcMiEaU=;
        b=RXlancLx2sUgOLrAXUTMh04hJv5zfrV9eaI2Urw8xTfFJsPgyB66fxBiMZfm/eXIBQ
         9NeYT10xWA08aezNRTdR5QWVzQuL7ZW+I8yIAVSLl9Eo+MXc7uLLc5ash8R0LcdXkg3y
         yazrf12E+KHulvSN2gAQH5HH8yLxFsT4JUhxPNbA+zo7B42TwQWOr0Sq+zo98CY8OXgb
         1NsECMByUA/1ULnifA8HS8d1Np+N6fbAlcN8LR9AnwgCQtkln7mj8veS2EJQ7zW4XyFT
         W2xV94Dv+nDP/aDnUCEWEZj5uUFLtsIDNPId5pV2xrTqlbOFH7wFBB3TPfYJ7D2tzpb8
         /cOw==
X-Gm-Message-State: AOJu0Yw5UQqv3lV6orhzO3iwi1NGz6QfjYgb1lvgbqJEAob0WKxQj06m
        jZAATJUEoN80/2n3cqAeo1OwTQ==
X-Google-Smtp-Source: AGHT+IE2TaPbtSnOjycRibKiMQ7n6YkJuP7QLfBLSQHgPk0U78Z5dIgqJ7F7+2AJZOkjIqFCKRcb3A==
X-Received: by 2002:ac2:5511:0:b0:50b:f82e:6d54 with SMTP id j17-20020ac25511000000b0050bf82e6d54mr496504lfk.20.1701863617804;
        Wed, 06 Dec 2023 03:53:37 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id i13-20020a056402054d00b0054c4fdb42e5sm2337326edx.74.2023.12.06.03.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 03:53:37 -0800 (PST)
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
Subject: [PATCH 2/3] dt-bindings: arm: qcom,coresight-tpda: drop redundant type from ports
Date:   Wed,  6 Dec 2023 12:53:31 +0100
Message-Id: <20231206115332.22712-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206115332.22712-1-krzysztof.kozlowski@linaro.org>
References: <20231206115332.22712-1-krzysztof.kozlowski@linaro.org>
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

"in-ports" and "out-ports" are defined by graph schema, so defining its
type is redundant.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
index e55f69c2ff38..66d291b56019 100644
--- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
@@ -66,13 +66,11 @@ properties:
       - const: apb_pclk
 
   in-ports:
-    type: object
     description: |
       Input connections from TPDM to TPDA
     $ref: /schemas/graph.yaml#/properties/ports
 
   out-ports:
-    type: object
     description: |
       Output connections from the TPDA to legacy CoreSight trace bus.
     $ref: /schemas/graph.yaml#/properties/ports
-- 
2.34.1

