Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A80C75E27F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 16:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjGWOQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 10:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjGWOP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 10:15:58 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4C110DF
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 07:15:56 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-997c4107d62so514744166b.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 07:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690121755; x=1690726555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N5gRIf9soWu1L4l6EUy8y1Fb5IIrkKYz0UV071lXLSI=;
        b=MY2L09s594Rox7deo3eNSWYQvAr+z2BXjSPPVBgshC6fWI5QB7qpBlWNt7twt78hxV
         xVqtqN3pCRJ/ciYQyfOpbK1gXro+47vCMtcik32TBmNjo0yIZyU2CJRnJitXXFxQdCCb
         LdnjXmdLImQKmqZtMvG8qvytQSnwvgRe4KVxd2u31O/p2ZszCLB41x/Cvp9YzLnKHlem
         4Zyl6BE2ejA2FzbRhDdkg34ruqfTU68VlAfejsCn6qvNuGhWI2WG3/XcYGNvrYiJ/4bt
         ePsAljjB5j3IB5mo05zkf416vxBzC1choRTs7lXLcYzxdEqoTx60ibwdrNwQ3iOIdI6G
         OgXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690121755; x=1690726555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N5gRIf9soWu1L4l6EUy8y1Fb5IIrkKYz0UV071lXLSI=;
        b=g3D5cJavUBUY4oVTO7Ma48p1paYF03GlG4wTp2Ic3OXWsw47wjnUb3ytLyMBpJf65/
         GWX9j9WQBbLPh1QHJCRa7XJbjWjMG9juJ0Rj0WIpPyYtU86gwciW8A24bz9xryb7+rZZ
         c5Elf3OS4TlY8DkG/ECN/uEb/lG+18FC6z9FdrTdZZfA4skLSeRJp+jgIwC/9ZjvLAF9
         KSoYkxh9CRqt3TFXoSASr4g8ygxqotvuudfzvhhsWoCaM49gQwWy0LG5ko/EAIZ46jnj
         buXd4G6jHXiQRqYlLPCyJhjq/dhAnQrg60iHL9rmrvG88C9n//lP/jyqGGb5g695R0om
         hv/Q==
X-Gm-Message-State: ABy/qLYn6OE0y9i6maR6gmEHGFximOWtn8Qgd8DL9VCgDgzNT4bqftPo
        cyfsFbnzSae5F9zCJx57Zj4+YXTFnDr87fVj8vY=
X-Google-Smtp-Source: APBJJlE4TRQ4jxiEhgw2ekB7zPZtl8glF3AfTjfQF+ItgZ3+t2ozlWJzjRTcL9Lm73lYnvG0ctZSxg==
X-Received: by 2002:a17:907:2c42:b0:982:9daf:9fcf with SMTP id hf2-20020a1709072c4200b009829daf9fcfmr7271159ejc.66.1690121755099;
        Sun, 23 Jul 2023 07:15:55 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id g6-20020aa7c586000000b0051dd1c10c13sm4810592edq.29.2023.07.23.07.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 07:15:54 -0700 (PDT)
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
Subject: [PATCH 1/2] dt-bindings: usb: qcom,dwc3: drop assigned-clocks
Date:   Sun, 23 Jul 2023 16:15:49 +0200
Message-Id: <20230723141550.90223-1-krzysztof.kozlowski@linaro.org>
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

The binding does not have to specify assigned-clocks, because they are
already allowed by core DT schema.  On the other hand, fixed
assigned-clocks in the binding will not fit different boards or SoCs.
Exactly this is the case for Qualcomm SuperSpeed DWC3 USB SoC controller
binding, where few boards have different assigned-clocks:

  ipq8074-hk10-c1.dtb: usb@8cf8800: assigned-clocks: [[5, 131], [5, 132], [5, 133]] is too long
  sdm660-xiaomi-lavender.dtb: usb@a8f8800: assigned-clocks: [[37, 92], [37, 91], [38, 64]] is too long

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
index 08d42fde466a..7cedd751161d 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
@@ -85,15 +85,6 @@ properties:
     minItems: 1
     maxItems: 9
 
-  assigned-clocks:
-    items:
-      - description: Phandle and clock specifier of MOCK_UTMI_CLK.
-      - description: Phandle and clock specifoer of MASTER_CLK.
-
-  assigned-clock-rates:
-    items:
-      - description: Must be 19.2MHz (19200000).
-      - description: Must be >= 60 MHz in HS mode, >= 125 MHz in SS mode.
   resets:
     maxItems: 1
 
-- 
2.34.1

