Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75F47B3AEF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 22:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbjI2UIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 16:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbjI2UIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 16:08:52 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71FD1B6;
        Fri, 29 Sep 2023 13:08:50 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50305abe5f0so22435402e87.2;
        Fri, 29 Sep 2023 13:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696018129; x=1696622929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VN1081SHvTpVYN+hwqlWDocjpX1nTwlxlaQPrJNJTKs=;
        b=Fzjjbe3L73zL9Ibg4FztWUs0QwAUIIYiskDiuBR6ePKsHdNJsgefm7QtTB5ZE9CTJc
         CJvN6x22CggnCSgJWFfsmiZJNrqE92qDwlpsY62QVLeS0iFfpKbkVHeJBDYPPxMtrwIq
         wTMczLy8I1mJGxAc0UxQLVlJufr0h9E9eVA+3IvZTU46mCq17SNoScsVL2/4vk1mPL8q
         M9xAVonkommaM/vx5K6/Cbyxo1svX/5IRSuyJxO6cfVNonI7bIIexjEfqHPelumfn9uj
         ZJUCwqe7MzxdLGGOEEN9D89UuwVnCmmtBHVNXE8EcpzaYS5IzHbKkW9kxJRatGf8g1n/
         lPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696018129; x=1696622929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VN1081SHvTpVYN+hwqlWDocjpX1nTwlxlaQPrJNJTKs=;
        b=P6dKILrY38q8fc3eIKeBZKfSWpM8SXO7AsHKPMYakbS6S+u20W/ffWebHlt1Ca4Lq+
         P6szjDiQ5H9UDH4Lf1ymkvk1oGN12aUdW8BLVJJ6Pu3Jz4WvPO1OB70xyMupYq+8l3V7
         ewbEu4rd/1ZTJMr7jYGs6j8B5vS588H0m3ysxUHLEZ1goRIoaLZ9cZZS3gUGMrBFhPUt
         83ZYJxNVJ1oVBzWs59K64nIlF2F/ym9h/4mjb21ii38VtTbZRrFNK7Bnc1Mof3J8VmdH
         irjXvNOen59Yi43+yQncR+Q1rzNv+kAcotZn5jrcepvrblwbo+Hq4xX9qGMtqEQ1NCEc
         3IkQ==
X-Gm-Message-State: AOJu0YwluTlUE2wgac4tT3rJ+k+1BElMjNy9QDjIWOlMP1zhWuukYfOJ
        JNYC1AM48rOCgfVgkpjxs6akVm6xQ907+g==
X-Google-Smtp-Source: AGHT+IG0ANWUhDzZWyxdAcwunCQzBWAvJfaQNqJw06J5i96aWysl4EA+lhYv9Im3DC/nqgG6UoNpmw==
X-Received: by 2002:ac2:4daa:0:b0:503:9eb:d277 with SMTP id h10-20020ac24daa000000b0050309ebd277mr3645838lfe.49.1696018128757;
        Fri, 29 Sep 2023 13:08:48 -0700 (PDT)
Received: from fr.lan ([46.31.31.132])
        by smtp.googlemail.com with ESMTPSA id v12-20020a19740c000000b005056e9b734esm422439lfe.151.2023.09.29.13.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 13:08:48 -0700 (PDT)
From:   Ivan Mikhaylov <fr0st61te@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Ivan Mikhaylov <fr0st61te@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: adc: provide max34408/9 device tree binding document
Date:   Fri, 29 Sep 2023 23:08:43 +0300
Message-ID: <20230929200844.23316-2-fr0st61te@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230929200844.23316-1-fr0st61te@gmail.com>
References: <20230929200844.23316-1-fr0st61te@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hardware binding for i2c current monitoring device with overcurrent
control.

Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
---
 .../bindings/iio/adc/maxim,max34408.yaml      | 101 ++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
new file mode 100644
index 000000000000..cdf89fa4c80e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/maxim,max34408.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Two- and four-channel current monitors with overcurrent control
+
+maintainers:
+  - Ivan Mikhaylov <fr0st61te@gmail.com>
+
+description: |
+  The MAX34408/MAX34409 are two- and four-channel current monitors that are
+  configured and monitored with a standard I2C/SMBus serial interface. Each
+  unidirectional current sensor offers precision high-side operation with a
+  low full-scale sense voltage. The devices automatically sequence through
+  two or four channels and collect the current-sense samples and average them
+  to reduce the effect of impulse noise. The raw ADC samples are compared to
+  user-programmable digital thresholds to indicate overcurrent conditions.
+  Overcurrent conditions trigger a hardware output to provide an immediate
+  indication to shut down any necessary external circuitry.
+
+  Specifications about the devices can be found at:
+  https://www.analog.com/media/en/technical-documentation/data-sheets/MAX34408-MAX34409.pdf
+
+properties:
+  compatible:
+    enum:
+      - maxim,max34408
+      - maxim,max34409
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  maxim,input1-rsense-val-micro-ohms:
+    description:
+      Adjust the Rsense value to monitor higher or lower current levels for
+      input 1.
+    enum: [250, 500, 1000, 5000, 10000, 50000, 100000, 200000, 500000]
+    default: 1000
+
+  maxim,input2-rsense-val-micro-ohms:
+    description:
+      Adjust the Rsense value to monitor higher or lower current levels for
+      input 2.
+    enum: [250, 500, 1000, 5000, 10000, 50000, 100000, 200000, 500000]
+    default: 1000
+
+  maxim,input3-rsense-val-micro-ohms:
+    description:
+      Adjust the Rsense value to monitor higher or lower current levels for
+      input 3.
+    enum: [250, 500, 1000, 5000, 10000, 50000, 100000, 200000, 500000]
+    default: 1000
+
+  maxim,input4-rsense-val-micro-ohms:
+    description:
+      Adjust the Rsense value to monitor higher or lower current levels for
+      input 4.
+    enum: [250, 500, 1000, 5000, 10000, 50000, 100000, 200000, 500000]
+    default: 1000
+
+  maxim,shtdn:
+    description:
+      Shutdown Output. Open-drain output. This output transitions to high impedance
+      when any of the digital comparator thresholds are exceeded as long as the ENA
+      pin is high.
+    type: boolean
+
+  maxim,ena:
+    description:
+      SHTDN Enable Input. CMOS digital input. Connect to GND to clear the latch and
+      unconditionally deassert (force low) the SHTDN output and reset the shutdown
+      delay. Connect to VDD to enable normal latch operation of the SHTDN output.
+    type: boolean
+
+  supply-vdd: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@1e {
+              compatible = "maxim,max34409";
+              reg = <0x1e>;
+              maxim,input1-rsense-val-micro-ohms = <5000>;
+              maxim,input2-rsense-val-micro-ohms = <10000>;
+        };
+    };
-- 
2.42.0

