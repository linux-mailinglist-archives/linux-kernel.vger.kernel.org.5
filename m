Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA79768F03
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 09:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjGaHhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 03:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjGaHgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:36:45 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E7B12A;
        Mon, 31 Jul 2023 00:36:44 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fb7373dd35so6717179e87.1;
        Mon, 31 Jul 2023 00:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690789003; x=1691393803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ceNIGOPbsyHjJmTOQVPb/Eaqj2M4+lsBZ1EpEQosohQ=;
        b=DJ/sDPnzy3nCJlSj7g4OH8HbDEsuOk4b9KqLMo9yBq+CovS27mK9oR9qNWdrDczEPu
         ygntwmf3IlgUCzaE9DJOjSuJg4oGyCpPC14Scc1yCdoO6xTlbP731f3XJrm1dGhkcT1m
         GJ8zgBfZBbV8Lb8LZd1srCF/dhs4PJmXIpQPS0YGcpTW6+vaYnSE4Mj9hEd6dfjAHrVg
         TaXIX5I/pWdRk5KFexNYIg8XPHDC7/guX19mvITnbvbMyEMMM4Hk4VoB1Poo1WzQi//A
         wkle7jx8kJCzMht6G5Z67g7dWU0+RZ74txzTlKjLQ4+Kj8KadW5gQXHwCaVGEorZ2JJp
         hf9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690789003; x=1691393803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ceNIGOPbsyHjJmTOQVPb/Eaqj2M4+lsBZ1EpEQosohQ=;
        b=jY/UtDpcPrp3lEneIsKpUzgrJMfOtGfr0W4HdG9VFIdrCYn1eXDAZyQWvaW/9mXMeZ
         S/OqstEvBX2uW5CjpJd8uj3LJv40qxsuAcKkuR1SEeXzgcLKS+XCd58jRsyYEvf41ErC
         tfc17Qxe9jc7qI/HMcLjyxW21KqfvMxRuK9xMsIf1XP29I64kP6UhOP3PSeTsR5HIMR2
         dwWrpPB0IEWfpuCyh3PtrOuEd4FUxjVXQvGQTKfPfiesGF1TQCfPRafPyMfpAZav6Zoc
         13S8aakasW5V6pPupboxxKQS45+AeUUNO45s9yAI8XRaVF2pyTT4l6vL+1HHNnt6w9LU
         quPg==
X-Gm-Message-State: ABy/qLanaTYsX4dySgn2jdCOuEFRz3mMTCCv7uzrdt9PrMy9wBFOQrb+
        8xIzeVAP3rcf1AyUrXR26Uy+ckZ+lRjSUw==
X-Google-Smtp-Source: APBJJlFSW5teG7KWE/dA9664HNl+BXct0TqfLL4YJ/zeZnT0eUMedaMT6ZsUxJRmsygtYh+dTp/N4A==
X-Received: by 2002:a05:6512:2391:b0:4fb:c9e1:5286 with SMTP id c17-20020a056512239100b004fbc9e15286mr4097169lfv.7.1690789002457;
        Mon, 31 Jul 2023 00:36:42 -0700 (PDT)
Received: from xeon.. ([188.163.112.48])
        by smtp.gmail.com with ESMTPSA id m14-20020a056512014e00b004fe3229e584sm586898lfo.270.2023.07.31.00.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 00:36:42 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Iskren Chernev <me@iskren.info>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Stefan Hansson <newbie13xd@gmail.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v3 1/4] dt-bindings: power: supply: maxim,max17040: update properties
Date:   Mon, 31 Jul 2023 10:36:10 +0300
Message-Id: <20230731073613.10394-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230731073613.10394-1-clamor95@gmail.com>
References: <20230731073613.10394-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add status and temperature properties.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/power/supply/maxim,max17040.yaml | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml
index 2627cd3eed83..377cbb2c2c1f 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml
@@ -55,6 +55,14 @@ properties:
   interrupts:
     maxItems: 1
 
+  io-channels:
+    items:
+      - description: battery temperature
+
+  io-channel-names:
+    items:
+      - const: temp
+
   wakeup-source:
     type: boolean
     description: |
@@ -95,3 +103,26 @@ examples:
         wakeup-source;
       };
     };
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      fuel-gauge@36 {
+        compatible = "maxim,max17043";
+        reg = <0x36>;
+
+        interrupt-parent = <&gpio>;
+        interrupts = <144 IRQ_TYPE_EDGE_FALLING>;
+
+        monitored-battery = <&battery>;
+        power-supplies = <&charger>;
+
+        io-channels = <&adc 8>;
+        io-channel-names = "temp";
+
+        maxim,alert-low-soc-level = <10>;
+        wakeup-source;
+      };
+    };
-- 
2.39.2

