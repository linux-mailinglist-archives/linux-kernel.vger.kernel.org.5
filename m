Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640D880C9CE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 13:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbjLKMbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 07:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbjLKMbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 07:31:05 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E28A7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 04:31:10 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40c2d50bfbfso19862065e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 04:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702297869; x=1702902669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VOobDHbYbVICzHx4WCyFbYqB5rRjPFGXbV0nxhsk/8I=;
        b=ghveoY1bwOzOgcsFnUlIIc/xu6Y3A22M5CPGbNhTMCQa239S6IN8SHgbR7SOSbbG3+
         +aPqKal/NA/DP2e7k1Rw9FuoRGtrukDRGzAXhgmsrHNvNZsmWValn8T2XQtY7YLMLLQE
         Ic94uQViVJabjdQkV1oqmDSSyACZ3I/1Qi1eeXRodsb/duKQsm/mkZmRyj9dBPDgenb1
         k66uMmAVkjz+QRaOt4QL5eEeCqm1EBF0Xw2ZHwNbWe3Mp5Rpt/bwZAjjcfZBl16ZS/eg
         9N6w6rQe7GIyKC4HiSEZgbTWoveHn2g4eZ2nVsSrQxLxAFKf/8b8MZ99LUQ60vvoQs03
         P9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702297869; x=1702902669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VOobDHbYbVICzHx4WCyFbYqB5rRjPFGXbV0nxhsk/8I=;
        b=Pvh8FgxGy5uK5xjFr4kN+7rWx8gQH+fniXyl6S1x9TF9bL+ZKSorcKl/Jn6YJFh8WO
         U77QdixzXNz55JDCxRTexPFijqfmt+aizwRD6S7vXkAb5wrE8DWAIGfQgyLNF9KDOtFb
         k+hceo/aBv4uUImCeI/8Cxj2XDV/s19YD6V9dW58mVed0ZmqjzmdZhN/8DEYsQwhLOx9
         k5ImF7RsTzSwBx+FqeVCMQ6mAV6DnaXTT06VvIrqJwm7GB38InEjKg+Fg8WiwL4R3MoW
         YuFRYoxNYI1k6dIAGiBsBpydbzS+84PVZDPmCz9xPA843EJdoUFjX9CEzz7TBo0m11mU
         oCQA==
X-Gm-Message-State: AOJu0Yz2yvFiQaDXO4JpJ1icC7VrDzyiD9yF3sSKLccgT/9ieN0I5pC4
        u9/rQBzcJnogl1RQeR20yk126g==
X-Google-Smtp-Source: AGHT+IGRxkN6z/jb6t8VFhbLYKIQhgJmBNUTIAsiGZuBWuWXZWBx6PeaFMH3wkcyTYMkokuRlfngOw==
X-Received: by 2002:a05:600c:1503:b0:40c:2c5f:5887 with SMTP id b3-20020a05600c150300b0040c2c5f5887mr1997537wmg.22.1702297868774;
        Mon, 11 Dec 2023 04:31:08 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id s5-20020a05600c384500b0040b632f31d2sm12932313wmr.5.2023.12.11.04.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 04:31:08 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/4] ASoC: dt-bindings: qcom,lpass-rx-macro: Add X1E80100 LPASS RX
Date:   Mon, 11 Dec 2023 13:31:01 +0100
Message-Id: <20231211123104.72963-1-krzysztof.kozlowski@linaro.org>
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

Add bindings for Qualcomm X1E80100 SoC Low Power Audio SubSystem (LPASS)
RX macro codec, which looks like compatible with earlier SM8550.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/sound/qcom,lpass-rx-macro.yaml        | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
index cbc36646100f..b8540b30741e 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
@@ -19,7 +19,9 @@ properties:
           - qcom,sm8550-lpass-rx-macro
           - qcom,sc8280xp-lpass-rx-macro
       - items:
-          - const: qcom,sm8650-lpass-rx-macro
+          - enum:
+              - qcom,sm8650-lpass-rx-macro
+              - qcom,x1e80100-lpass-rx-macro
           - const: qcom,sm8550-lpass-rx-macro
 
   reg:
-- 
2.34.1

