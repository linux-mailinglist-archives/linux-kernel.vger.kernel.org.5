Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21D176912B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjGaJLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGaJLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:11:22 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 369E4102;
        Mon, 31 Jul 2023 02:11:20 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.201])
        by gateway (Coremail) with SMTP id _____8Bx5fC1esdkRCINAA--.31526S3;
        Mon, 31 Jul 2023 17:11:17 +0800 (CST)
Received: from localhost.localdomain (unknown [10.20.42.201])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxriOkesdk1DFCAA--.2097S3;
        Mon, 31 Jul 2023 17:11:17 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, Yinbo Zhu <zhuyinbo@loongson.cn>
Subject: [PATCH v2 1/2] gpio: dt-bindings: add parsing of loongson gpio offset
Date:   Mon, 31 Jul 2023 17:10:58 +0800
Message-Id: <20230731091059.17323-2-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230731091059.17323-1-zhuyinbo@loongson.cn>
References: <20230731091059.17323-1-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxriOkesdk1DFCAA--.2097S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add parsing GPIO configure, input, output, interrupt register offset
address and GPIO control mode support.

Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
---
 .../bindings/gpio/loongson,ls-gpio.yaml       | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml b/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
index fb86e8ce6349..cad67f8bfe6e 100644
--- a/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
@@ -29,6 +29,33 @@ properties:
 
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
@@ -39,6 +66,11 @@ required:
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
 
@@ -54,6 +86,11 @@ examples:
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

