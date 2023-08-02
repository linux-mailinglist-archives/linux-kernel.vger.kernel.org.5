Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FF876C662
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjHBHU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbjHBHUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:20:17 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE5C1FCF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 00:20:15 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-686bc261111so4707370b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 00:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1690960815; x=1691565615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJ5YLO0IIt+aIbJ11JJ3Kxjx5y5WL9E8nDB9fSOF3J4=;
        b=3DqIUdoDZtsnVT36Z++jOJ+maleHOtfrQIXS3qBH7UitgBTt6KgD5Jc99pCKGSWHci
         gyGtcilxvvzDK2xbCijB0BOp0D0Be+apt6qUUjw/vJtMz3Js5PnlF8SRe9bxT56N27+2
         O06udsLWhywr52jJwokjky3t0VzSQyHuHM2m13+uvvNpR3LbAPsKG2VKZ0SsM1BRSSyD
         s/kkmVEdB29nl1G6KFfoQ6knPyGwDpIojYqh208Ni+dewpTxes8lSrjmNL1Q5cpj8e53
         Jzw2/kHf45inKBmu5R5qLV9Ksxa0L3f2xr0AbwfJJHX4Gz8GWdLEJMBub8cTyVsQj5eq
         AFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690960815; x=1691565615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJ5YLO0IIt+aIbJ11JJ3Kxjx5y5WL9E8nDB9fSOF3J4=;
        b=VISy6jGcSRixPKDqkKfkO90cDyyl4DsQ3BtQ1jUSCQuAmICO9/hOH+rTZiSeBLm2vW
         vXzvBEfkcUUOwYwoxr5a6QU9JK0gFM/nGt4oqm3fo6vEFRMPivCXi71gdqc6Dyudja8I
         eYker2Jq2coRglXBroDdLYpKWtz3ynWJCxXmDjjX7CMReV5BVTD8onrelfK4+W4udKra
         Jt8/yiliDRf9n+d4V636fEQxAHew30qB9rzisjOs27B/wzxtoWil4Bvky/Q9+MDOEdZh
         L0vs+wRhrUe6pK0w1VjKUAwcJPbTUVC/rhB8+OphTpd+5sG2k0PWIpQvyhO2Bs5JZjIU
         S4QQ==
X-Gm-Message-State: ABy/qLY5ykbVG2UbLqi6OI7qPw7/sc7q2YiAeBuTTjtS/baAfSEKR790
        9g0fvy9JfZo8brNS3alKFnDGZw==
X-Google-Smtp-Source: APBJJlE7D+YzaMMSTrnCX09X4zmAYfYhotDDIscNtvS9jL5G3mAL5vIMIJYEF1jvFGViH7uoKbB9iw==
X-Received: by 2002:a05:6a00:1590:b0:687:4bd8:159a with SMTP id u16-20020a056a00159000b006874bd8159amr6479581pfk.19.1690960814911;
        Wed, 02 Aug 2023 00:20:14 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.205])
        by smtp.gmail.com with ESMTPSA id fe12-20020a056a002f0c00b00684ca1b45b9sm10732543pfb.149.2023.08.02.00.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 00:20:14 -0700 (PDT)
From:   Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dmitry.torokhov@gmail.com,
        dianders@google.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, hsinyi@google.com
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 1/2] dt-bindings: input: i2c-hid: Introduce Ilitek ili9882t
Date:   Wed,  2 Aug 2023 15:19:46 +0800
Message-Id: <20230802071947.1683318-2-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802071947.1683318-1-yangcong5@huaqin.corp-partner.google.com>
References: <20230802071947.1683318-1-yangcong5@huaqin.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ili9882t touch screen chip same as Elan eKTH6915 controller
has a reset gpio. The difference is that ili9882t needs to use
vccio-supply instead of vcc33-supply. Doug's series[1] allows panels
and touchscreens to power on/off together, let's add a phandle for this.

[1]: https://lore.kernel.org/r/20230607215224.2067679-1-dianders@chromium.org

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
---
 .../bindings/input/ilitek,ili9882t.yaml       | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/ilitek,ili9882t.yaml

diff --git a/Documentation/devicetree/bindings/input/ilitek,ili9882t.yaml b/Documentation/devicetree/bindings/input/ilitek,ili9882t.yaml
new file mode 100644
index 000000000000..c5d9e0e919f9
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/ilitek,ili9882t.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/ilitek,ili9882t.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ilitek ili9882t touchscreen controller
+
+maintainers:
+  - Cong Yang <yangcong5@huaqin.corp-partner.google.com>
+
+description:
+  Supports the Ilitek ili9882t touchscreen controller.
+  This touchscreen controller uses the i2c-hid protocol with a reset GPIO.
+
+allOf:
+  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
+
+properties:
+  compatible:
+    const: ilitek,ili9882t
+
+  reg:
+    const: 0x41
+
+  interrupts:
+    maxItems: 1
+
+  panel: true
+
+  reset-gpios:
+    maxItems: 1
+    description: Reset GPIO.
+
+  vccio-supply:
+    description: The 1.8V supply to the touchscreen.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - panel
+  - vccio-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      touchscreen: touchscreen@41 {
+        compatible = "ilitek,ili9882t";
+        reg = <0x41>;
+
+        interrupt-parent = <&pio>;
+        interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
+
+        panel = <&panel>;
+        reset-gpios = <&pio 60 GPIO_ACTIVE_LOW>;
+        vccio-supply = <&mt6366_vio18_reg>;
+      };
+    };
-- 
2.25.1

