Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A7480AF20
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 22:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574855AbjLHV4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 16:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235948AbjLHVzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 16:55:46 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B951710
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 13:55:52 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c26a45b2dso14531245e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 13:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702072550; x=1702677350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFdnrYwlBQ1rl9Jn+SrBUNOM0RDnJGbTZYEdwjlsUa0=;
        b=AUkmJp3Q7QFlgvGqnUuOOPd0cbpXznjFpVyo9hLdtqJWokt7fbhAJMs+jZhyO3tkQC
         01el1V2b9VI650kxyx8s6AEtmFo0gRvZNlj+ntMPxPJUJKLAyVd6Yqjtf3m1mYp5hkV9
         cFc18RNFQOwNAUPwGZuxSDhX/GXbhYiXg+aLdFwq9n3+AfpReV3WUf9OekJ3maBEVfBv
         mlMPsZGeycINiY+yFHyVGNYhLF9OFP5LGjpicDMwg7RQcg1kpjKYtPrLZnygoguVM2/R
         59BLKm4HRNxx1kcalixvj0KRX9N/PEuk/bYYswyqtJ83MUOsdvdNvIn0I8VSZQ2DXbAO
         /EWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702072550; x=1702677350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BFdnrYwlBQ1rl9Jn+SrBUNOM0RDnJGbTZYEdwjlsUa0=;
        b=oG5JEwU+9ebzueTQBAxTGB8xJejYTkQlYrBQ9iEt14IQoatAMpsgNU7Y88KHQcSfQA
         MSWvu0la4CHC7zC3ovyDPqvp4Nqj6Bt/6a/sYZaqva8jCPeNHPE2xivNTYOkfxEW2Mjv
         U04pdy/8FE/uVCMx86rfRHpOJGxUJ6d7413GhW7fBBXqHqvW2IIb7MtJzxUZy2/ciWzN
         dwRgitF88A6rTn5VoG5ZLCvtGXg1VyYveMC7LYo0Rfs+IQvsFAYkQUFALIg5WVYt5ltB
         8T8qhJ82cuO8bfpfDbLQuigjJbLIc4V8iF/ZZAFxodIrSy14z10Yx9ofEjb6Z6FebUmM
         llsw==
X-Gm-Message-State: AOJu0Yz03ij8CtpNn7HedqInX5FCC1oc/epjIkdVVNAAm6qHTBHSnjZ7
        94d4kCb0IrI1GMgTt6z9OZHUUA==
X-Google-Smtp-Source: AGHT+IHU/IYwKAHCB7iAsahZ45V6NPX2AnoxI7IsChjqPxB3N3uuuWn+G4VVqzC5+UjzecOZJzneoQ==
X-Received: by 2002:a05:600c:d4:b0:40c:2c36:29ee with SMTP id u20-20020a05600c00d400b0040c2c3629eemr374181wmm.82.1702072550789;
        Fri, 08 Dec 2023 13:55:50 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id r20-20020a05600c459400b0040b349c91acsm6321789wmo.16.2023.12.08.13.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 13:55:50 -0800 (PST)
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
Subject: [PATCH 05/10] dt-bindings: pinctrl: qcom,sm8550-tlmm: restrict number of interrupts
Date:   Fri,  8 Dec 2023 22:55:29 +0100
Message-Id: <20231208215534.195854-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208215534.195854-1-krzysztof.kozlowski@linaro.org>
References: <20231208215534.195854-1-krzysztof.kozlowski@linaro.org>
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

SM8550 TLMM pin controller comes with only one interrupt, so narrow
the number of interrupts previously defined in common TLMM bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pinctrl/qcom,sm8550-tlmm.yaml         | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8550-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8550-tlmm.yaml
index f789c7753a92..567e44875c29 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8550-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8550-tlmm.yaml
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

