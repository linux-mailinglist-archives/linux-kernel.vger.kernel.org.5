Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583537E363D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 09:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbjKGIEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 03:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbjKGIEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 03:04:43 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30DC1B2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 00:04:40 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53dfc28a2afso9010996a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 00:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699344279; x=1699949079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bmn5eiaE58u9BZEkyunhEFzoCx9m/5MWM1mIBk7TdSg=;
        b=aFf5aoZ5pVH5l7u4+4mvFc8mBE17uup67AygY3iB+dwtYvNSUCxOiGcRhQ0jucdYoN
         9BDXrNWYfAc5QVeJt3q/BTyJsMtTZ841BxNt5rQfU1alj40G9DQV0MlOrGZgVRcFGFlV
         afqA1SSlS8oteBKtggi8KrdxKlnlf1HFANiuyLwTkkVgx/x3I98Px9r0Mz3SItAiXAG7
         lKeIpnjC8zTtU4se2z0/bmDpjKDRYplHN0IXGwumQVqZqo59tqSYJQjLaOxTdPatcGoA
         qwzCzYWne2E+bSAZP3YT6vsAc05otZybGNBsvzOxqINw3QVcdCMqHdjJz7TPA6WtaN03
         8MYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699344279; x=1699949079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bmn5eiaE58u9BZEkyunhEFzoCx9m/5MWM1mIBk7TdSg=;
        b=Y9/Gd+okv4F0m7oTXG21/TyeplqR6PUMjz8lYm4YkBui6Pg7ju2zki6lNQYgQ7TDXK
         Tb1LVuHSt1SYQgfxNOY/bhZCRC7Rz3dHo3+/1Ji5MlmTzmdjJsk8APFbMGfPcbn/b+zQ
         su329v+ZiOOYUG3kymJ82Frtt9eycqnfW2BYC4mTNBYS6uoYQTWLkcJ9ACWpGfbKQbZK
         0v2b+pi1f8lkOEWFLiu28SIBGH7kzXKnvVOcikh6sdsDwMXKOwUST67hfoclzhl6F0k3
         RfjRhykeslTNACr4wVWhaj++tDFGKOXUoiftTmhC8KraB1Um0IPC95/8vywTRllBmRES
         IYIw==
X-Gm-Message-State: AOJu0YzmW8cM3G9pvCJRDnp2L9JeLTChUu17h6kmsXBRkj/eCn7nZxYL
        7mXuml93MW0Hqmg3pEM0sCpznA==
X-Google-Smtp-Source: AGHT+IHNFiZZAS89De+r2+NiutX0cPO4+E7YrX4WohWqo/WH7cVUrGbpP8xLShQxZ+YINYWMxIJEPQ==
X-Received: by 2002:aa7:d755:0:b0:541:29c8:9575 with SMTP id a21-20020aa7d755000000b0054129c89575mr25058249eds.28.1699344279060;
        Tue, 07 Nov 2023 00:04:39 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id x16-20020aa7d6d0000000b00532eba07773sm5049106edr.25.2023.11.07.00.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 00:04:38 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: cache: qcom,llcc: correct QDU1000 reg entries
Date:   Tue,  7 Nov 2023 09:04:36 +0100
Message-Id: <20231107080436.16747-1-krzysztof.kozlowski@linaro.org>
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

Qualcomm QDU1000 DTSI comes with one LLCC0 base address as pointed by
dtbs_check:

  qdu1000-idp.dtb: system-cache-controller@19200000: reg-names:2: 'llcc2_base' was expected

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Recent LLCC patches were not tested on QDU1000 thus the LLCC is there
broken.  This patch at least tries to bring some sense according to
DTSI, but I have no clue what is here correct: driver, DTS or bindings.
---
 Documentation/devicetree/bindings/cache/qcom,llcc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/cache/qcom,llcc.yaml b/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
index 580f9a97ddf7..d610b0be262c 100644
--- a/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
+++ b/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
@@ -64,6 +64,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,qdu1000-llcc
               - qcom,sc7180-llcc
               - qcom,sm6350-llcc
     then:
@@ -101,7 +102,6 @@ allOf:
         compatible:
           contains:
             enum:
-              - qcom,qdu1000-llcc
               - qcom,sc8180x-llcc
               - qcom,sc8280xp-llcc
     then:
-- 
2.34.1

