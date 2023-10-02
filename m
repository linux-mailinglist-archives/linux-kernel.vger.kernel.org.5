Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527337B4AC1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 04:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbjJBCRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 22:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235404AbjJBCRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 22:17:36 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A08711F
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 19:17:31 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1dd4115b369so1159517fac.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 19:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696213050; x=1696817850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPOWcZHTqmoq/zqsh7e1DQOIHdOfQaJNQbue+Ak7Pz4=;
        b=gSI3n4hZCnR9n2j5PCWBmvhDXs4AUWsWvoh+NFIyVSdyWn1CQLufb7Rd9JG1h1mffj
         J1HrBFw5yWvDEn+t8ZKM/g78GpVgJtwvA6zYkMSbl4S3LFyy0XCictm/a/Xk+ig92LHV
         sDuzkGd//PF1LaQcJ5Qgh6JbQ6/YowtyviSoYZ4d5WxdykHdH/bQ045ABHKs+EijAlZU
         Mo++6IJxtxfSndNy8HYj70ca0Fpwvco6fkk9YWieSMfTy0HA0vQY4iC767+Gq9GyyOyu
         HoZGz6NwAodBGZSF9KnfwH8iTtb7EsCaCKEZwEy/GEFumuEMtw8tUyXkPwVyWXz+LsVT
         5iWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696213050; x=1696817850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RPOWcZHTqmoq/zqsh7e1DQOIHdOfQaJNQbue+Ak7Pz4=;
        b=Ait2dkGxRAQ5pRGU+Yzii67yZpAhvCzBg+Cxn4n+P9w9Xqv5odjmYLv84PxD5udPzY
         mVFGWnL/PrVGjlrpjvdYel9Tj11PKzjj2X+glczpcLT/V5aTgqqXkyKaMBRPHSkm90Pb
         iJ4lPbWhDL6O8hHwOkTabeHSjACfHkefgflrxK5+R/eYHWpZI/1Wg4oRH9RC1IoXm+9C
         HSokPKk8fAuLkPy141NEOSZcwyk0uBzxz/tBbbZas5ewPXp37V6MV159BgcctAZe1UpA
         3OmvUu4Jc9UN89HmPid3Se22c2qUke1AZJv5dv4UuNIwbkjkel3d+ArTWkIhGphtdUrp
         h38Q==
X-Gm-Message-State: AOJu0YxbhDeLFLNNmFxolxgEjOOQVdjv4Tdl6bZf5ObFTr1iTypblgRS
        qR0QvJ0LXL5bIBZx3R9W2Z4goCprfxpupaGCP7ypcw==
X-Google-Smtp-Source: AGHT+IGpOuQGzvtGHKgSr/mxvP55UKAmUGYnrFTePhofwASv4SkD/NQd9nZ9IBhVQqqOhXeqb9otNw==
X-Received: by 2002:a05:6808:2123:b0:3a9:f25d:d917 with SMTP id r35-20020a056808212300b003a9f25dd917mr13656079oiw.4.1696213049725;
        Sun, 01 Oct 2023 19:17:29 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:7ab1:199:d138:f054])
        by smtp.gmail.com with ESMTPSA id mg11-20020a17090b370b00b002609cadc56esm5278319pjb.11.2023.10.01.19.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 19:17:29 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     sudeep.holla@arm.com, cristian.marussi@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linus.walleij@linaro.org
Cc:     Oleksii_Moisieiev@epam.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC 4/4] dt-bindings: gpio: Add bindings for SCMI pinctrl based gpio
Date:   Mon,  2 Oct 2023 11:16:02 +0900
Message-Id: <20231002021602.260100-5-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231002021602.260100-1-takahiro.akashi@linaro.org>
References: <20231002021602.260100-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A dt binding for SCMI pinctrl based gpio driver is defined in this
commit. It basically conforms to generic pinctrl-gpio mapping framework.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 .../bindings/gpio/arm,scmi-gpio.yaml          | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/arm,scmi-gpio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/arm,scmi-gpio.yaml b/Documentation/devicetree/bindings/gpio/arm,scmi-gpio.yaml
new file mode 100644
index 000000000000..2601c5594567
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/arm,scmi-gpio.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/arm,scmi-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SCMI pinctrl based generic GPIO controller
+
+maintainers:
+  - AKASHI Takahiro <akashi.takahiro@linaro.org>
+
+properties:
+  $nodename:
+    pattern: "^scmi_gpio(@[0-9a-f]+)$"
+
+  compatible:
+    const: arm,scmi-gpio-generic
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
+    properties:
+      gpio-hog: true
+      gpios: true
+      input: true
+      output-high: true
+      output-low: true
+      line-name: true
+
+    required:
+      - gpio-hog
+      - gpios
+
+    additionalProperties: false
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
+    #include <dt-bindings/gpio/gpio.h>
+
+    scmi_gpio_0: scmi_gpio@0 {
+        compatible = "arm,scmi-gpio";
+        gpio-controller;
+        #gpio-cells = <2>;
+        gpio-ranges = <&scmi_pinctrl 0 10 5>,
+                      <&scmi_pinctrl 5 0 0>;
+        gpio-ranges-group-names = "",
+                                  "pinmux_gpio";
+    };
+
+    // Consumer:
+    sdhci0_pwrseq {
+        compatible = "mmc-pwrseq-emmc";
+        reset-gpios = <&scmi_gpio_0 0 GPIO_ACTIVE_LOW>;
+    };
-- 
2.34.1

