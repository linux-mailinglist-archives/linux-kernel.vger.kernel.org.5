Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499D57E8B28
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 15:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjKKOUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 09:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjKKOUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 09:20:02 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2778A2D77
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 06:19:59 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53e2308198eso4645830a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 06:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699712397; x=1700317197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ptbiafykJ7pRIMqCQZ06p889hMKKC590ILuJm+wGBD4=;
        b=B0qdyuO/jUCpcDtPvNLuwdV38f5yqma60rauBCnaq2ysK7eOpMku3EGkNSnUbzTFfM
         37MKFNqPHx7yzdet44hHrdMaSuoY08KOzuaZnaZSIb8eUS56dL8vvEpc7lk2Bx3dRC6a
         prt4r+VI2V7hs3HgMgbNKX+NGB8+HViayYM+S/QARLnxwh8KKe6fpYGmxqXJnq3uNWS9
         ZV33sFTOJY2N+rcXN5ly2Ts4H1or0+JwkLDcaaOFlKyWy6ue+LDqD/dbuxHgj/XwLZEP
         xVN+dLKXFecjODi+PyRwPRcmIYZSvN7tPXP3Bg1dPg/TqF3NRX4wnAyVktE7KAexPPEI
         NuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699712397; x=1700317197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ptbiafykJ7pRIMqCQZ06p889hMKKC590ILuJm+wGBD4=;
        b=MLhNRx4pJGhUOBhKY5crOLySzzuGAYlTmNhSPpUz5UkvS+R/6H8XruzxAn90bS0kiV
         wyT9hglvwXUSuIQdakmA1/pRYLbU8PUWjLcI7hlMaS5XEgb+Wg8a7MTG8TpsuEdGcvi0
         e1YhxTDtpGoZWY7eaxVr6cIY3gF9D83iiD291yLztbak9awcmFpEZXxL2pmAJzAHKnN5
         l6fI98WDwWqn/If4W1FxyEybMkZKPZbxgLRVoqQ3U10T9yLoGsKyDb8LRRlcptkwoAqu
         NfXG+KxzuIX5MAsLhgglf0t60zBM/hDkvd0Pm3Q42Yxafhcotql/3l9/JUy2gBXBAgUF
         dxVA==
X-Gm-Message-State: AOJu0YytOzue+8Jl9/qN3StodjKctwXztRyeeZIUHyX+LhYBf8mZDBRy
        cWzrzPO1fKmGGyhZi0bvUdqnmw==
X-Google-Smtp-Source: AGHT+IF6WuaSFh+2WoYZFrNj5cszOB/hqZsoJg0oXGWaqi+IL9O7EVOR6XOKlu/R5PzGbWOpD3GPlQ==
X-Received: by 2002:aa7:dd56:0:b0:53e:7781:2279 with SMTP id o22-20020aa7dd56000000b0053e77812279mr1490668edw.36.1699712397566;
        Sat, 11 Nov 2023 06:19:57 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id dm20-20020a05640222d400b00537666d307csm1035408edb.32.2023.11.11.06.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 06:19:57 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: usb: qcom,dwc3: adjust number of interrupts on SM6125
Date:   Sat, 11 Nov 2023 15:19:53 +0100
Message-Id: <20231111141953.51841-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Qualcomm SM6125 DWC3 USB controller comes with two interrupts (verified
with downstream/vendor code of Trinket DTSI from Xiaomi Laurel device).
Move the qcom,sm6125-dwc3 to appropriate place in allOf:if:then blocks
constraining interrupts.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
index 64043b91ffb9..3f41362b2a91 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
@@ -375,7 +375,6 @@ allOf:
               - qcom,sdx65-dwc3
               - qcom,sdx75-dwc3
               - qcom,sm4250-dwc3
-              - qcom,sm6125-dwc3
               - qcom,sm6350-dwc3
               - qcom,sm8150-dwc3
               - qcom,sm8250-dwc3
@@ -408,6 +407,7 @@ allOf:
               - qcom,msm8996-dwc3
               - qcom,msm8998-dwc3
               - qcom,sm6115-dwc3
+              - qcom,sm6125-dwc3
     then:
       properties:
         interrupts:
-- 
2.34.1

