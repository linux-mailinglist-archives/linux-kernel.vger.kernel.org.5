Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB047B9ED2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjJEONW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbjJEOL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:11:26 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3771A3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 19:59:37 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6c7a4735a30so92764a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 19:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696474777; x=1697079577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRZiziU1GNu5avPXv2QF3oc3h3U4ax78pgVXLevlQ+c=;
        b=F0nD+MhFOP6CdU/bsjp3KWBaqAX1turrqx9w+vRy+yGxCK7aBulW1p0MyTZBUIN9GL
         luSC3viHz9AGehtm2QPXn+95Kz+LsSZieC5SVqpvBLjoFwiKG4HoffDxSInYWeVekmxe
         K72mOReleoYh6C84QgXt9NYKT0zPgXhTZTDONIcBFVtVdnL/ybNaq2jVk5IJvfTTB/3S
         TdB2zZu5nXs54di0lhGRdmOMSp58T+rNf7rcuaYdeZHtniqB+9EPJbgHxgI/9ARqJH0F
         hvItKCrYSGBksQeJBapJoEz6Z9ZN+Qq+Y2XVRBUA70DgJDt/jbDlk6m8iYHa2BYVOfIs
         ZQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696474777; x=1697079577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRZiziU1GNu5avPXv2QF3oc3h3U4ax78pgVXLevlQ+c=;
        b=P/NmCA8H1Ez2ZU0k67bSbYWOCXhuG7LKB0yaKxslKSQAg0d3ATm2oSEbVacImcZy1c
         Xjf+okwhToBebxFzFdt7jB5HQlYbgfQ1e9bhKSs9dGaywxszRooApHRR5OR7paio0EM3
         eUl63h0e5n7fRONv/e+w8cWyJDeJyOgsZo1sj2xlVxPNdeui9TAXgUU/VfVsl0x6g2c8
         AzBrTj7RgYEoe3PjC0TzUZExbPgV41eFheZl/Eytb+4RGcTd3JB+cBUOYQDIXiZXVDJ8
         d7AD4yAfAIHMWZ/+6pcPJ+46lkBYPxQgmrtlLHLYemGGUUD/fb/Wje3ppzeN9iIZHzuA
         51mQ==
X-Gm-Message-State: AOJu0YwU7tSMabjsm0fXEvBVKYkKh7stqbuAcnzx2yyI73vjtGMcJqyq
        9KU4TCkdX7NrpvWXBLN/LCMw6Q==
X-Google-Smtp-Source: AGHT+IGuF37bJRXm/rwj6uHFmdz4QeyGcUcT5VR8YemY6FCQGga77AWz0oRvrMhJuov669/ftxBMyw==
X-Received: by 2002:a05:6808:138b:b0:3ad:aadd:6cbf with SMTP id c11-20020a056808138b00b003adaadd6cbfmr4953939oiw.0.1696474776920;
        Wed, 04 Oct 2023 19:59:36 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:a16d:fce2:497:afb7])
        by smtp.gmail.com with ESMTPSA id b18-20020a637152000000b005782ad723casm269265pgn.27.2023.10.04.19.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 19:59:36 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     sudeep.holla@arm.com, cristian.marussi@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linus.walleij@linaro.org
Cc:     Oleksii_Moisieiev@epam.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC v2 5/5] dt-bindings: gpio: Add bindings for pinctrl based generic gpio driver
Date:   Thu,  5 Oct 2023 11:58:43 +0900
Message-Id: <20231005025843.508689-6-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005025843.508689-1-takahiro.akashi@linaro.org>
References: <20231005025843.508689-1-takahiro.akashi@linaro.org>
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

A dt binding for pin controller based generic gpio driver is defined in
this commit. One usable device is Arm's SCMI.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
RFC v2 (Oct 5, 2023)
* rename the binding to pin-control-gpio
* add the "description"
* remove nodename, hog properties, and a consumer example
RFC (Oct 2, 2023)
---
 .../bindings/gpio/pin-control-gpio.yaml       | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/pin-control-gpio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/pin-control-gpio.yaml b/Documentation/devicetree/bindings/gpio/pin-control-gpio.yaml
new file mode 100644
index 000000000000..bc935dbd7edb
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/pin-control-gpio.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/pin-control-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Pin control based generic GPIO controller
+
+description:
+  The pin control-based GPIO will facilitate a pin controller's ability
+  to drive electric lines high/low and other generic properties of a
+  pin controller to perform general-purpose one-bit binary I/O.
+
+maintainers:
+  - AKASHI Takahiro <akashi.takahiro@linaro.org>
+
+properties:
+  compatible:
+    const: pin-control-gpio
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
+  gpio-ranges: true
+
+  gpio-ranges-group-names: true
+
+patternProperties:
+  "^.+-hog(-[0-9]+)?$":
+    type: object
+
+    required:
+      - gpio-hog
+
+required:
+  - compatible
+  - gpio-controller
+  - "#gpio-cells"
+  - gpio-ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    gpio0: gpio@0 {
+        compatible = "pin-control-gpio";
+        gpio-controller;
+        #gpio-cells = <2>;
+        gpio-ranges = <&scmi_pinctrl 0 10 5>,
+                      <&scmi_pinctrl 5 0 0>;
+        gpio-ranges-group-names = "",
+                                  "pinmux_gpio";
+    };
-- 
2.34.1

