Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABC2771BAB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 09:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjHGHlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 03:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjHGHlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 03:41:04 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22EA010FE;
        Mon,  7 Aug 2023 00:41:01 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.201])
        by gateway (Coremail) with SMTP id _____8AxFvEJoNBkCOARAA--.40060S3;
        Mon, 07 Aug 2023 15:40:57 +0800 (CST)
Received: from localhost.localdomain (unknown [10.20.42.201])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxB838n9Bk+dBMAA--.56868S3;
        Mon, 07 Aug 2023 15:40:56 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn, Yinbo Zhu <zhuyinbo@loongson.cn>
Subject: [PATCH v3 1/2] gpio: dt-bindings: add parsing of loongson gpio offset
Date:   Mon,  7 Aug 2023 15:40:42 +0800
Message-Id: <20230807074043.31288-2-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230807074043.31288-1-zhuyinbo@loongson.cn>
References: <20230807074043.31288-1-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxB838n9Bk+dBMAA--.56868S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Loongson GPIO controllers come in multiple variants that are compatible
except for certain register offset values. Add support in yaml file for
device properties allowing to specify them in DT.

Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
---
 .../bindings/gpio/loongson,ls-gpio.yaml       | 40 ++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml b/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
index fb86e8ce6349..fc51cf40fccd 100644
--- a/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
@@ -14,6 +14,7 @@ properties:
     enum:
       - loongson,ls2k-gpio
       - loongson,ls7a-gpio
+      - loongson,ls2k1000-gpio
 
   reg:
     maxItems: 1
@@ -29,6 +30,33 @@ properties:
 
   gpio-ranges: true
 
+  loongson,gpio-conf-offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      This option indicate this GPIO configuration register offset address.
+
+  loongson,gpio-out-offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      This option indicate this GPIO output register offset address.
+
+  loongson,gpio-in-offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      This option indicate this GPIO input register offset address.
+
+  loongson,gpio-ctrl-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      This option indicate this GPIO control mode, where '0' represents
+      bit control mode and '1' represents byte control mode.
+
+  loongson,gpio-inten-offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      This option indicate this GPIO interrupt enable register offset
+      address.
+
   interrupts:
     minItems: 1
     maxItems: 64
@@ -39,6 +67,11 @@ required:
   - ngpios
   - "#gpio-cells"
   - gpio-controller
+  - loongson,gpio-conf-offset
+  - loongson,gpio-in-offset
+  - loongson,gpio-out-offset
+  - loongson,gpio-ctrl-mode
+  - loongson,gpio-inten-offset
   - gpio-ranges
   - interrupts
 
@@ -49,11 +82,16 @@ examples:
     #include <dt-bindings/interrupt-controller/irq.h>
 
     gpio0: gpio@1fe00500 {
-      compatible = "loongson,ls2k-gpio";
+      compatible = "loongson,ls2k1000-gpio";
       reg = <0x1fe00500 0x38>;
       ngpios = <64>;
       #gpio-cells = <2>;
       gpio-controller;
+      loongson,gpio-conf-offset = <0>;
+      loongson,gpio-in-offset = <0x20>;
+      loongson,gpio-out-offset = <0x10>;
+      loongson,gpio-ctrl-mode = <0>;
+      loongson,gpio-inten-offset = <0x30>;
       gpio-ranges = <&pctrl 0 0 15>,
                     <&pctrl 16 16 15>,
                     <&pctrl 32 32 10>,
-- 
2.20.1

