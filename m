Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F2C75E281
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 16:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjGWOQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 10:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjGWOQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 10:16:00 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E701B8
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 07:15:59 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51bece5d935so5362512a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 07:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690121757; x=1690726557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/DSLBdhH7X1vmy5xHTXlVJgN8n1W999F5GQeMTfdzg=;
        b=KArJUGnZtn3cujM7E/FdcVSqCgs3QHFWEqsrcwPmq81wOqDXSdNpXEAh5VC61S7F+8
         /uSQJSkDqdbVQX+I2xPjfYAXouq3w8r3oLPbnxs2pNKry8MbubYsuQqlZ1v9B5PcCxBF
         sWOK3mj+hqpT1alPLsvXbb1jEYfh7jwm5VVx4alzxeSzs0uITxA86WIDUhj0OR+pqsXY
         9mpVKpHttv5r4JHBIaSbWULqQm1UsANQHCxAeWM8K3HU2VVpQIPi6hhpF9Mjudj5BI6G
         hsImMWY1LhOsBzaTLZkk1ZJbz9Wkk38DrAOcxYlWUyqa6gdUHwwl5A3Lim5Wr89fKy6z
         yi0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690121757; x=1690726557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E/DSLBdhH7X1vmy5xHTXlVJgN8n1W999F5GQeMTfdzg=;
        b=JyP+H5pJj1VB5u5FR1LO5K6mjaZ667sUW6euBKLcIf5zHK2FbFUa0QObpeXtI9ix93
         05gdSZNkLa2HBPrwjX3Jpy2rTaIp2sAAQttYfkhUty2Sdu25wmxZIMDasgm07Oc/SKF+
         PYBZwZ2ck3j5e9UU83aYGRMb2Psvn1vhR0B66NgXEV1PM/gtRRNo8g+mV960S8cq3aKB
         TA+gi1LAAWW2g02HnuKsOqpGYsaCGk6Ouv/MihrfEJaj31F9xb9uHvhIW/fOImyiQf/E
         hhdvYgf1RSUOcfKzzymDXXL5938cx2Qi9J/bBHwOJFEKA679ApAmpAKh2HqbaihIjNuS
         V1Hw==
X-Gm-Message-State: ABy/qLa0zp1oAq6B42f4PRHkj2MA6+Th9SjdHDJ6Ix+qF4FKGOfYwDF/
        oE3LjG7R6a6FHqaj2MrUsiESLg==
X-Google-Smtp-Source: APBJJlEX4LpS3ZjHEDOOmi5Cx26BxCrgURM43YDUukHpadNoKXFV9WgIjp5o/vmtrybGGVuyGVJOYw==
X-Received: by 2002:aa7:ce0f:0:b0:51d:9682:e30c with SMTP id d15-20020aa7ce0f000000b0051d9682e30cmr6814890edv.5.1690121757715;
        Sun, 23 Jul 2023 07:15:57 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id g6-20020aa7c586000000b0051dd1c10c13sm4810592edq.29.2023.07.23.07.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 07:15:57 -0700 (PDT)
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
Subject: [PATCH 2/2] dt-bindings: usb: qcom,dwc3: correct SDM660 clocks
Date:   Sun, 23 Jul 2023 16:15:50 +0200
Message-Id: <20230723141550.90223-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230723141550.90223-1-krzysztof.kozlowski@linaro.org>
References: <20230723141550.90223-1-krzysztof.kozlowski@linaro.org>
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

SDM660 SoC has two instances of DWC3 USB controller: one supporting USB
3.0 and one supporting only up to USB 2.0.  The latter one does not use
iface clock, so allow such variant to fix dtbs_check warnings:

  sda660-inforce-ifc6560.dtb: usb@c2f8800: clocks: [[37, 48], [37, 88], [37, 89], [37, 90]] is too short
  sda660-inforce-ifc6560.dtb: usb@c2f8800: clock-names:2: 'iface' was expected

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/usb/qcom,dwc3.yaml    | 24 ++++++++++++-------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
index 7cedd751161d..b84b104f2975 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
@@ -284,15 +284,23 @@ allOf:
     then:
       properties:
         clocks:
-          minItems: 6
+          minItems: 5
+          maxItems: 6
         clock-names:
-          items:
-            - const: cfg_noc
-            - const: core
-            - const: iface
-            - const: sleep
-            - const: mock_utmi
-            - const: bus
+          oneOf:
+            - items:
+                - const: cfg_noc
+                - const: core
+                - const: iface
+                - const: sleep
+                - const: mock_utmi
+                - const: bus
+            - items:
+                - const: cfg_noc
+                - const: core
+                - const: sleep
+                - const: mock_utmi
+                - const: bus
 
   - if:
       properties:
-- 
2.34.1

