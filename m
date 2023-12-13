Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9317A811F5A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377913AbjLMTvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbjLMTvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:51:22 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D88D0;
        Wed, 13 Dec 2023 11:51:29 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40c580ba223so17946695e9.3;
        Wed, 13 Dec 2023 11:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702497087; x=1703101887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERQju2Bh+K8GCwYjh7yY4rIstgFgSHVz3s7kTSLi67E=;
        b=PxZpM4VqAjX3hh3w7KfL7gHasGC60x2FIBV0oJfRcWeCf730qRvLCvHEv4cbtm4f9w
         H64G85TBhH4YvcQaScyCHw3FpcTADlrtONEAaXTVVMQu9TLJ19BbvRtZaZlokbjkc8hJ
         yWLvUthOomVkZM2wr7Bgbr8uvyRUHwJFW77Y5PIL1twF2TYLkUhxx3A+RspE82hdSMUf
         JbWUnMMpp8sfQkTpc/BKk86R1r8Xf5jKCAArMXJf+ARu2hMxw0mM7A9cxmkvNMs3Ma2m
         0lG8WQY116WdWGTDkhZKuHuVwqfYGRdG5y4Ctjh1UovgRYySbtkVKETXxCI/babj0X7O
         wIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702497087; x=1703101887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERQju2Bh+K8GCwYjh7yY4rIstgFgSHVz3s7kTSLi67E=;
        b=blNblyK/bKxDkfKd4vmOx30ygSiKC9vU6brHtyV9JDFPEpjpl7nopnNmOmWYEShuZh
         EuRST/QEUaaOJARtktpcob5zDQHNSZ3xcAHLnxnVXmFT8FIBF/cTVY4Wb2Yun8bMVPsR
         zOrPOKRQH5HGIK4LA9bZbIhnieQU9k9nhO3ZmC9u4dieF0QA6OfkUHbke5F0/xdoZNnI
         HEMc5669MmrBtglMSOnPyslvcTh9ShokI9/yRX0RBay83NacixGayNuLEbYQd9iHJwFa
         +oVKfhMV8bO9ZwFL8Z0h6Q4GG4hNLQWJWPGww73zd8ePp752gMAJKAv0aZnHLkBUDmiy
         l8Og==
X-Gm-Message-State: AOJu0YxU43Ff2dCXKCTEDVHJKPTEXe1b70xTznpIMsNIBdSLW5tfb8ij
        C7rE/mYvyQ1I82Lb2iSsUQ==
X-Google-Smtp-Source: AGHT+IFubGXtBYJHwawt+OjhdiJA2OK0SDjjVKO0Bx22olt+rzUfmcB1mZ2doozRlrhYe+3xiI98xg==
X-Received: by 2002:a05:600c:54f1:b0:40b:5e21:dd2a with SMTP id jb17-20020a05600c54f100b0040b5e21dd2amr4691135wmb.88.1702497087589;
        Wed, 13 Dec 2023 11:51:27 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:92dc:8b1c:e01c:b93c])
        by smtp.gmail.com with ESMTPSA id fm14-20020a05600c0c0e00b00407b93d8085sm24050698wmb.27.2023.12.13.11.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 11:51:27 -0800 (PST)
From:   Alex Bee <knaerzche@gmail.com>
To:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Andy Yan <andyshrk@163.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 01/11] dt-bindings: display: rockchip,inno-hdmi: Document RK3128 compatible
Date:   Wed, 13 Dec 2023 20:51:15 +0100
Message-ID: <20231213195125.212923-2-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213195125.212923-1-knaerzche@gmail.com>
References: <20231213195125.212923-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible for RK3128's HDMI controller block.
The integration for this SoC is somewhat different here: It needs the PHY's
reference clock rate to calculate the ddc bus frequency correctly. This
clock is part of a power-domain (PD_VIO), so this gets added as an optional
property too.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 .../display/rockchip/rockchip,inno-hdmi.yaml  | 30 +++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,inno-hdmi.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,inno-hdmi.yaml
index 96889c86849a..9f00abcbfb38 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip,inno-hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,inno-hdmi.yaml
@@ -14,6 +14,7 @@ properties:
   compatible:
     enum:
       - rockchip,rk3036-inno-hdmi
+      - rockchip,rk3128-inno-hdmi
 
   reg:
     maxItems: 1
@@ -22,10 +23,21 @@ properties:
     maxItems: 1
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: The HDMI controller main clock
+      - description: The HDMI PHY reference clock
 
   clock-names:
-    const: pclk
+    minItems: 1
+    items:
+      - const: pclk
+      - enum:
+          - pclk
+          - ref
+
+  power-domains:
+    maxItems: 1
 
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
@@ -55,6 +67,20 @@ required:
   - pinctrl-names
   - ports
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3128-inno-hdmi
+
+    then:
+      properties:
+        clocks:
+          minItems: 2
+        clock-names:
+          minItems: 2
+
 additionalProperties: false
 
 examples:
-- 
2.43.0

