Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8675F80B524
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 17:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjLIQFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 11:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLIQFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 11:05:05 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DBC10E0
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 08:05:11 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40c41b43e1eso2120515e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 08:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702137910; x=1702742710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lbsPZUF4ysy0Z2Xnr5Uq7PdWYL0AABtRsCTOnasJIcc=;
        b=xoGJUM7rfbBmtwsgiY0O1yvMYTlFDOoQczLgB/MlOsCyMIcbkdqQmom9a5Jj5iPvKs
         JKzoxg3F7qyXecj9zCmHCTXLvSUNm5fN06QIpRsja3SThHwH7sdSm506dkyGQr5laJIM
         74/n6q0QDuocVfJz3l5zN5LxHfy+O/vNHvqNluOP7DNP6/4UTLKSlwZIFktRnRScG5wI
         ya7QkbpdvLzpzUGObDk05zr4soz8DnjZNdx0AsetYbCKhZv4iDXl/ao0JPeHz5S6DQx9
         PX+yl0kx3IFDF1Nzyz1f/9lDvmui5C90HNByMN+7LzhJ2ziz+s8ZQY1DiHYIOs9l9doq
         cvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702137910; x=1702742710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lbsPZUF4ysy0Z2Xnr5Uq7PdWYL0AABtRsCTOnasJIcc=;
        b=whDeqmo/JTNICiHbnaa/LkUSQ6D84YkJ2Urntc/xFSn0AyDizILqn78rDoE7d7kLkK
         oSFCFQ4SmftMCJbs8dHwdwXAZqvmpzzNtFayDRKq9a7kxYzjd9gF9WqBgPceMYezXkk2
         WHDJ9EZiIqKMDVgm5cFhEmDYIupDljn//cZP+t20LqjWCw9q5JqJ4Eowuoyhevx7HDrM
         Fh13vb7OGq8YLDBp5weT4EHrCKVIj6hdhq05NZ0jAXyAlUbzeF7AzTkHv4zEMbRZX+g4
         b012bvn8flSlm8FE0Hri+okVSn1DIMNGF9SijxrJ9Ew8AxQj3y2XLzMxFXNxuXduoUyw
         EXbQ==
X-Gm-Message-State: AOJu0YwdcVH7FsX972xsZ+VzVOp70bSL8uvHkZCHozm8MT1+3VR4B5Wd
        P3LBf9dEkd81UK0CnYDkbbztrA==
X-Google-Smtp-Source: AGHT+IFkLcBZfcLMdnzbi+IoTj6s/20AM06M7UlkM7GEdf6A91oFcd3ajlkYSGSjJjvizw73O5wocg==
X-Received: by 2002:a05:600c:45c9:b0:40b:5e21:bdce with SMTP id s9-20020a05600c45c900b0040b5e21bdcemr840742wmo.93.1702137909793;
        Sat, 09 Dec 2023 08:05:09 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id mt39-20020a17090761a700b00a0ad10b3f68sm2343077ejc.205.2023.12.09.08.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 08:05:09 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        van Spriel <arend@broadcom.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next] dt-bindings: net: wireless: brcm,bcm4329-fmac: allow local-mac-address
Date:   Sat,  9 Dec 2023 17:05:05 +0100
Message-Id: <20231209160505.237843-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Some boards come with local-mac-address property.  Allow it, and
mac-address as well, to fix dtbs_check warnings like:

  apple/t8103-j456.dtb: network@0,0: Unevaluated properties are not allowed ('local-mac-address' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml  | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
index 4aa521f1be8c..4c8a7950c83e 100644
--- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
@@ -67,6 +67,9 @@ properties:
     description: Name for the OOB IRQ, this must be set to "host-wake".
     const: host-wake
 
+  local-mac-address: true
+  mac-address: true
+
   brcm,drive-strength:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: Drive strength used for the SDIO pins on the device in mA.
@@ -148,6 +151,8 @@ examples:
         interrupt-parent = <&gpio>;
         interrupts = <24 IRQ_TYPE_EDGE_FALLING>;
         interrupt-names = "host-wake";
+        /* To be filled by the bootloader */
+        local-mac-address = [00 00 00 00 00 00];
         reset-gpios = <&gpio 23 GPIO_ACTIVE_LOW>;
         brcm,ccode-map = "JP-JP-78", "US-Q2-86";
       };
-- 
2.34.1

