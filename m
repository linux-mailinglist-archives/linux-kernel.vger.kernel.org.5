Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2972B78170F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 05:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244954AbjHSDR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 23:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244670AbjHSDRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 23:17:36 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204634223
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 20:17:34 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6bcb5df95c5so1261314a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 20:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692415053; x=1693019853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=terWZwySlnATmuJMOqlx8HX9SM+9JePulFK7w3bJmCk=;
        b=uzjnUdmBIA+M9L8UZ815q/Hme4Tyj4IIPDcJIxvfc9JIAjGh2xQs/+apf6waiQbTQf
         1GGjkprqSGhXZwyF7wf2UuyUJj/c/3Pp/XUeEx+LvJTK1ymI28NmKaZynCuJCLOMVXyj
         2T/PAHrzx/dhxdOsU0YhoalSUHh4ItTqRdNp4YvyiP335Sn7vEfQMrdJkTc3eDF6lwyy
         MmIlgjNxgD68asVA9VDblH5IJeuEkqjQyp6504HV0GB2svmgH34FxP0CTqL5+2VCGV0t
         wLlqfyHQF6ycsrg44Pgw2srVBbEdbOFlyHu/KV0eJgksLhpMKmkfkg8hHkxng5yKV03+
         Fw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692415053; x=1693019853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=terWZwySlnATmuJMOqlx8HX9SM+9JePulFK7w3bJmCk=;
        b=SrRinTbEKejbzfk6dxDDv9eoKJic7ZqATKIOtY4zGkdIVA7Ux6wKvEzTm7ALzARVkD
         kJSW+sMvEhc4v6T/skwnbH3C6uzdDhxaVmKTScEqhigpYee7K8WUOEGn0jzt2/A1c1KO
         gMaR9+QJBSBLn/19oIXFs+cj2+l5euS8zMLh4VeuICe11oMnalEaJR76ptia9+zSPSLV
         1YEm3OAnX7h/SFoei1D4FsXKpX1R32N3qIBo9xgjwQdO8cYyLYtMGo+H6qcjm0ZqksMo
         uiZNCeqEIeTMrS9rizKvwb/KUBHtEi4niC4Kz+GvCt77nZsUixABWbKcfZIcC16s/rXa
         /qcg==
X-Gm-Message-State: AOJu0Yyua9jp6Neci+FXdCOZbInJdbMsQMtnd41uasN5Gn8t+us+3Wdw
        lDHNV8OPHrsRwagrqxiIzVwYZ1alo5TRboxrypI=
X-Google-Smtp-Source: AGHT+IE9p0fUrSh0BRemD6/2a57NfR3EO4r8wsYb4VaF67YNneCxT3TlxARU9Tja4q4pBzykKbc+LA==
X-Received: by 2002:a9d:4d8e:0:b0:6bc:f85e:ab0 with SMTP id u14-20020a9d4d8e000000b006bcf85e0ab0mr1464160otk.3.1692415053415;
        Fri, 18 Aug 2023 20:17:33 -0700 (PDT)
Received: from localhost ([136.49.140.41])
        by smtp.gmail.com with ESMTPSA id a1-20020a056830100100b006b922956cecsm1447686otp.25.2023.08.18.20.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 20:17:32 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     JaeHun Jung <jh0801.jung@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 1/8] dt-bindings: usb: samsung,exynos-dwc3: Add Exynos850 support
Date:   Fri, 18 Aug 2023 22:17:24 -0500
Message-Id: <20230819031731.22618-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230819031731.22618-1-semen.protsenko@linaro.org>
References: <20230819031731.22618-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exynos850 has dwc3 compatible USB controller, so it can reuse existing
dwc3 glue layer. Document a new compatible for Exynos850 and its clocks.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 .../bindings/usb/samsung,exynos-dwc3.yaml        | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml b/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml
index 42ceaf13cd5d..fc9a425be5fe 100644
--- a/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml
@@ -15,6 +15,7 @@ properties:
       - samsung,exynos5250-dwusb3
       - samsung,exynos5433-dwusb3
       - samsung,exynos7-dwusb3
+      - samsung,exynos850-dwusb3
 
   '#address-cells':
     const: 1
@@ -101,6 +102,21 @@ allOf:
             - const: usbdrd30_susp_clk
             - const: usbdrd30_axius_clk
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos850-dwusb3
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          items:
+            - const: bus_early
+            - const: ref
+
 additionalProperties: false
 
 examples:
-- 
2.39.2

