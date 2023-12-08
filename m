Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6278880AF2B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 22:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574841AbjLHV4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 16:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574849AbjLHVz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 16:55:56 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAE019A4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 13:55:57 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40c39e936b4so2542275e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 13:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702072556; x=1702677356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6LTNwuggOVu+lap2ETuWiVhYhZt32Ct7VN+rbmpRFk=;
        b=FYRj91d6mKvLUMYcHr1YnMzQMfdLDexOC1gI2Eo+vCHmcUbfbMVhRWmPfRo5HbjlZd
         j6D4+axb8PaD4UOwPKO67N4xtP6X0KcNke3ih8+b3NJEPQ5XDR9t4CDngIh1S61O2Mfw
         F7+Kf73tNw9qZNSKX/IrUKJOD+Wwv/EXW6t5CjptraUd7lFBs5wpz3Do22u/JQVuLD/b
         VTcpX+wYc4Xr+JB7mOv5lGtBjoxC4DzK/TXITMYdgIyPfHT2K8+bipVyTrQNyI4pf30D
         i2yjtly0Z3qiOFVTUcCoNdfhyFMtFS1bTZp8uHrrF4T9gABh1dmE3GFS3bg82WbnglVT
         TSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702072556; x=1702677356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a6LTNwuggOVu+lap2ETuWiVhYhZt32Ct7VN+rbmpRFk=;
        b=k23RCyqm8op5tAP3b8sSeVUsVnVVYMHfWwn74QdnnSV7ZN3ghzt5ytnAJaYnBt4Mgh
         hzzQmcnD6/q/VOzEyqCepsOxsIPxMBeuppI1upxOBX3dJiv2Rib8h0K7be52UkNUpo1r
         XHTsgUlbHpTtUWUeVzev07OdE+VJpJC/kbfzv7aIYjMcf+aY7TUDY5JfekmRZnNXkoKN
         mUgiIMGme7pl1Fe+T+ydyHwk/tSAtgjTxHYRC86XdBgP9uKmc08sTKPbNZD5ZUi108SZ
         YB5LrZteOFnXD5pNNtEVfVEAytP+pckSPa9DeTPIodcpvAX+LgrLZP72nzHsRxS2phsh
         cQyA==
X-Gm-Message-State: AOJu0YwZGxowwkTiXy/a3xVHgZCsnkg6/OFKpv88712vLWw861NKWd+T
        dtB12T6lWLzbwfKo/Lv1eGOWUg==
X-Google-Smtp-Source: AGHT+IEWfQLi04KhsOKfk1C7Xg7hp8O1Yu6kutUmlWu1o5Q8+ki5ONIPzOECHLhbr+eLPm1DSCf9bQ==
X-Received: by 2002:a05:600c:21c7:b0:40c:2878:7adb with SMTP id x7-20020a05600c21c700b0040c28787adbmr165191wmj.58.1702072555791;
        Fri, 08 Dec 2023 13:55:55 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id r20-20020a05600c459400b0040b349c91acsm6321789wmo.16.2023.12.08.13.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 13:55:55 -0800 (PST)
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
Subject: [PATCH 07/10] dt-bindings: pinctrl: qcom,x1e80100-tlmm: restrict number of interrupts
Date:   Fri,  8 Dec 2023 22:55:31 +0100
Message-Id: <20231208215534.195854-7-krzysztof.kozlowski@linaro.org>
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

X1E80100 TLMM pin controller comes with only one interrupt, so narrow
the number of interrupts previously defined in common TLMM bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pinctrl/qcom,x1e80100-tlmm.yaml       | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,x1e80100-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,x1e80100-tlmm.yaml
index 2bde8845a31e..3249c63a29cf 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,x1e80100-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,x1e80100-tlmm.yaml
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

