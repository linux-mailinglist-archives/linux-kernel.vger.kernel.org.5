Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14E77ACB4F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 20:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjIXSUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 14:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXSUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 14:20:19 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7486BFC;
        Sun, 24 Sep 2023 11:20:13 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9b27bc8b65eso91450466b.0;
        Sun, 24 Sep 2023 11:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695579612; x=1696184412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a0W+/trWwbu/NCVII0SDu5FGXg+mV5jiZFYz95bx/6g=;
        b=O1017DMeB7e4IyOLE1zRSXZ2yQPXejz3LZNeQqqcMhfVn2aVCEUshik2ASpREF1hao
         ymKesFo1zDr60jy+R37+qS942KPbOLPcG1ofg08C62jYBL2z35PmX7KbGzn3XNm5aMtG
         XwlBfk7q9B/hQNLQCb/yKsYg4hn8li+hprKlA4LatiHzjkHYI3M6oYz4RBY/OMnx/90I
         /sAd2aw5P2U4IZqgT3TlAhVV7mBmdXs+LFmMB9HaZrzWeEGHMTXM4syWMdoYSOHPKraA
         HlqtMxUrmARdmX7XT/y1OfHQzgP7pmdOyB4T39YkYSuDIc850nJjeHsyEukEnMtpEonA
         ozRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695579612; x=1696184412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a0W+/trWwbu/NCVII0SDu5FGXg+mV5jiZFYz95bx/6g=;
        b=rPvf4xhJcojFqvE+ChSbVGBZjDpPE4iVBqhQ+0zgs7Z0EiM6eBDTD7nMiKDtwygnwe
         igt/TYEe5Y5hmk7o1tViPV4mm8jC8WQDINwSjYhcX63+bs0rOYm/1DUHNFc+yTT9h602
         sSnw/N/62tvOXMPAR+TdsT0iVVsYXqOZxXgg6qJ7OVRAkdVFb9clk5XAzL8+Res7/svr
         62oa9jj6QE3HKopsPxFydhD/C+cWkB0m06XOaAB/qBSInt6ZTiq3JUy7/urp8dYnSrSH
         Th6nr5o17CBeYgK3uw8y0Nd7d+dn4SvFH42x/h0LgWzTgeMzOmvhUdVbOl8gvisi4MIp
         TPTg==
X-Gm-Message-State: AOJu0YzXihYSDweb5ST3IP2Tn9r1KPT/adNIvzITLPtKENcqzQiTx3Ap
        f7akDms8ubVItiV1SJgRSxk=
X-Google-Smtp-Source: AGHT+IFUlRTZ1QgAlngEAHo+92fSn9CMPMRh4wWpOlzkRUyyzEgCeFe3JMjYONjMQbQRm2YFLIKh5g==
X-Received: by 2002:a17:906:3189:b0:9ae:3ee3:dc5a with SMTP id 9-20020a170906318900b009ae3ee3dc5amr4003581ejy.73.1695579611581;
        Sun, 24 Sep 2023 11:20:11 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8109:8c00:3664:78ff:216e:b54c:1933])
        by smtp.gmail.com with ESMTPSA id p20-20020a1709060e9400b009ae587ce135sm5249659ejf.223.2023.09.24.11.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 11:20:11 -0700 (PDT)
From:   Nik Bune <n2h9z4@gmail.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        skhan@linuxfoundation.org, claudiu.beznea@microchip.com
Cc:     Nik Bune <n2h9z4@gmail.com>, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3] dt-bindings: watchdog: atmel,at91rm9200-wdt: convert txt to yaml
Date:   Sun, 24 Sep 2023 20:19:59 +0200
Message-Id: <20230924181959.64264-1-n2h9z4@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert txt file to yaml.

Signed-off-by: Nik Bune <n2h9z4@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Changes in v3:
- Removed trailing whitespace in an element of the maintainers list.

v2 patch: https://lore.kernel.org/linux-devicetree/20230924172004.59208-1-n2h9z4@gmail.com/ 

 .../watchdog/atmel,at91rm9200-wdt.yaml        | 33 +++++++++++++++++++
 .../watchdog/atmel-at91rm9200-wdt.txt         |  9 -----
 2 files changed, 33 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/atmel,at91rm9200-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/atmel,at91rm9200-wdt.yaml b/Documentation/devicetree/bindings/watchdog/atmel,at91rm9200-wdt.yaml
new file mode 100644
index 000000000000..7af3571d89f2
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/atmel,at91rm9200-wdt.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/atmel,at91rm9200-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel AT91RM9200 System Timer Watchdog
+
+maintainers:
+  - Nicolas Ferre <nicolas.ferre@microchip.com>
+
+allOf:
+  - $ref: watchdog.yaml#
+
+properties:
+  compatible:
+    const: atmel,at91rm9200-wdt
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    watchdog@fffffd00 {
+        compatible = "atmel,at91rm9200-wdt";
+        reg = <0xfffffd00 0x10>;
+    };
diff --git a/Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-wdt.txt b/Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-wdt.txt
deleted file mode 100644
index d4d86cf8f9eb..000000000000
--- a/Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-wdt.txt
+++ /dev/null
@@ -1,9 +0,0 @@
-Atmel AT91RM9200 System Timer Watchdog
-
-Required properties:
-- compatible: must be "atmel,at91sam9260-wdt".
-
-Example:
-	watchdog@fffffd00 {
-		compatible = "atmel,at91rm9200-wdt";
-	};
-- 
2.34.1

