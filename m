Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B0880AF11
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 22:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjLHVzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 16:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574814AbjLHVzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 16:55:41 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026B1198D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 13:55:46 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40c39e936b4so2541125e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 13:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702072545; x=1702677345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/60s+ovFXyEA70cJ6XBt4WPswR1xbbylguX4jwENxM=;
        b=W08R5cqHG0N0Oti1OxhAQvHDHr0dyy9FxmZrXL0EJd5CQaYwZYX1j8cW3/sAtugK88
         bjNAGAKxtmpCCSfdvGBrVYLnsOvoEHn3aLtBZlgCwUzsFdf6h4Ob2VBZqQurTAnCmQXr
         1GuHe4ftIPhWJ+zl98xWBEjk6lcoAqoaUATZM0FvbkgBkkGWOOEZ/1ClR/mrw/RF9zIh
         sapwK8GL11EliaKqim0rMxW9rr6fLwi7uzJqeQPY5X4jit3BH66ZPUkwiAhkJkSwnrkn
         h4yae7mMHDkT9cA+MtsY9QceDYAGfy1A7zkNICOofZzqwfzp7+bObTutBoM11xvB2Kvl
         3NYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702072545; x=1702677345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y/60s+ovFXyEA70cJ6XBt4WPswR1xbbylguX4jwENxM=;
        b=m6mruHAoGWSWWj3OrQGHzrGH01TPDktrmDlyA+MKF0w59+mPtO760x1RwR3di0hFw3
         aQL8FqJ0a3FWG9BAkI7XBBYoYLe+IDJZ7l9QVjQl2IUvUhjUIhOhk8PVVR11lP2YnHEL
         oNYoxAYE9Q8dyVQZxUlvCRq3DMoKxEg9ugJn7zw/kfzCkHAtHEvx1EmZdACybyKNHm1x
         BwDptJNFLFFU34YfUTNSv3HP9R3BOUa2z6eaQvZqFdIkid/268HGkXB2pmvcelLZc3Qc
         cuI6I5szbLTmuJcv1tlwziCsQtqDeG6NWMZZdBfDAKd2MeiKXB047ijjezD/9YNtIY+C
         vOOg==
X-Gm-Message-State: AOJu0YwW7rE/4dmnmnaD5jdiZF0YvTv+cpH6KpjGOguOmI6vKy9Esj9O
        w8FTNOampGR+raWFvJvqFb4eKw==
X-Google-Smtp-Source: AGHT+IG/7g3EBTnqDo4GiCJYV/XIJXTdM0ghJV6zrFK27kTkNmCoO5+KWkUuN5EmlBvhtlizjac6Yw==
X-Received: by 2002:a05:600c:231a:b0:40c:25ab:d6fc with SMTP id 26-20020a05600c231a00b0040c25abd6fcmr131489wmo.216.1702072545052;
        Fri, 08 Dec 2023 13:55:45 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id r20-20020a05600c459400b0040b349c91acsm6321789wmo.16.2023.12.08.13.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 13:55:44 -0800 (PST)
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
Subject: [PATCH 03/10] dt-bindings: pinctrl: qcom,sa8775p-tlmm: restrict number of interrupts
Date:   Fri,  8 Dec 2023 22:55:27 +0100
Message-Id: <20231208215534.195854-3-krzysztof.kozlowski@linaro.org>
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

SA8775p TLMM pin controller comes with only one interrupt, so narrow
the number of interrupts previously defined in common TLMM bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pinctrl/qcom,sa8775p-tlmm.yaml        | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sa8775p-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sa8775p-tlmm.yaml
index 2173c5255638..d27933258db7 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sa8775p-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sa8775p-tlmm.yaml
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

