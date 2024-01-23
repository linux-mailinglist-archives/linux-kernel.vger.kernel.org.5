Return-Path: <linux-kernel+bounces-35178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AC7838D26
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E39F01F2312D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3AC5D900;
	Tue, 23 Jan 2024 11:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="R3vVvDrI"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D669A5D8E3;
	Tue, 23 Jan 2024 11:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706008543; cv=none; b=de6dImS3Uc9ufWsoKU/O9IYxjV5siBYOeq4Rn92d8EjE3x9y2lEclwWfTLCJF0lh/mIEcVMjNnuaLjRISawiNzv/8kS9GGhacnEtJsrrWjkUcvC5RFqPTZRCZHV0IIO1GzNbdZSzQdNjjaWtHfr9BV+p9SJy5M90ikdo2bZLMp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706008543; c=relaxed/simple;
	bh=CQ7tFTTrMu33i0T+tPoAxNwOmkHva4ezG2UGpbm12ZI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TbA+ibRgdJvVzbmmf29rfwBFo8MLyeIVKfSKjTarrHZMGyHU4opIH5mjD2jalVM5LJGDNNB7IVY+PEcrWUpIXeuhHFNDReIZrQNM+W7Nnm7A29PEWLRg+XaWpI458RgrAJsnoDzL/aZ1DdvoarzcWnhz0LtGrwUc0yP3he/G9l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=R3vVvDrI; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NBEnQD008311;
	Tue, 23 Jan 2024 05:14:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706008489;
	bh=zk2vPEHry0BmB+vqIbKpDwwWZQyauRfgfOziNQ6D3K4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=R3vVvDrIAUP2aScn40NFAkO80XNzE6HzCco+omq9bNL/zwdHBEDzTGxkZACGteRCe
	 5u408G1ROsV5CvO7lkKTwVdfN0WTidITRxvrw+BcCDn1+vkyZnxMYmjwnqbGzP9cBZ
	 Q8f+4brlT0iZrC0D9VpVsd7gD1fJ5MaA2idbabBg=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NBEnlO098291
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 05:14:49 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 05:14:48 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 05:14:49 -0600
Received: from LT5CG31242FY.dhcp.ti.com (lt5cg31242fy.dhcp.ti.com [10.85.14.124])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NBEHxT083823;
	Tue, 23 Jan 2024 05:14:42 -0600
From: Shenghao Ding <shenghao-ding@ti.com>
To: <broonie@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski@linaro.org>
CC: <robh+dt@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <kevin-lu@ti.com>, <baojun.xu@ti.com>, <devicetree@vger.kernel.org>,
        <lgirdwood@gmail.com>, <perex@perex.cz>,
        <pierre-louis.bossart@linux.intel.com>, <13916275206@139.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liam.r.girdwood@intel.com>, <soyer@irl.hu>, <jkhuang3@ti.com>,
        <tiwai@suse.de>, <pdjuandi@ti.com>, <j-mcpherson@ti.com>,
        <navada@ti.com>, Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v1 4/4] ASoc: dt-bindings: Create yaml file for pcm6240 codec driver
Date: Tue, 23 Jan 2024 19:14:10 +0800
Message-ID: <20240123111411.850-4-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20240123111411.850-1-shenghao-ding@ti.com>
References: <20240123111411.850-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

PCM6240 driver implements a flexible and configurable setting for register
and filter coefficients, to one, two or even multiple PCM6240 Family Audio
chips.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
Change in v1:
 - Create yaml file for pcm6240 codec driver
---
 .../devicetree/bindings/sound/ti,pcm6240.yaml | 303 ++++++++++++++++++
 1 file changed, 303 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ti,pcm6240.yaml

diff --git a/Documentation/devicetree/bindings/sound/ti,pcm6240.yaml b/Documentation/devicetree/bindings/sound/ti,pcm6240.yaml
new file mode 100644
index 000000000000..59fd48aa4445
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ti,pcm6240.yaml
@@ -0,0 +1,303 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2022 - 2024 Texas Instruments Incorporated
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/ti,pcm6240.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments PCM6240 Family Audio ADC/DAC/Router
+
+maintainers:
+  - Shenghao Ding <shenghao-ding@ti.com>
+
+description: |
+  The PCM6240 Family driver offer a flexible architecture to set the device
+  number, registers and params for different filters in a bin file.
+
+  Specifications about the audio chip can be found at:
+    https://www.ti.com/lit/gpn/tlv320adc3120
+    https://www.ti.com/lit/gpn/tlv320adc5120
+    https://www.ti.com/lit/gpn/tlv320adc6120
+    https://www.ti.com/lit/gpn/dix4192
+    https://www.ti.com/lit/gpn/pcm1690
+    https://www.ti.com/lit/gpn/pcm3120-q1
+    https://www.ti.com/lit/gpn/pcm3140-q1
+    https://www.ti.com/lit/gpn/pcm5120-q1
+    https://www.ti.com/lit/gpn/pcm6120-q1
+    https://www.ti.com/lit/gpn/pcm6260-q1
+    https://www.ti.com/lit/gpn/pcm9211
+    https://www.ti.com/lit/gpn/pcmd3140
+    https://www.ti.com/lit/gpn/pcmd3180
+    https://www.ti.com/lit/gpn/taa5212
+    https://www.ti.com/lit/gpn/tad5212
+
+properties:
+  compatible:
+    description: |
+      ti,adc3120: Stereo-channel, 768-kHz, Burr-Brown™ audio analog-to-
+      digital converter (ADC) with 106-dB SNR.
+
+      ti,adc5120: 2-Channel, 768-kHz, Burr-BrownTM Audio ADC with 120-dB SNR.
+
+      ti,adc6120: Stereo-channel, 768-kHz, Burr-Brown™ audio analog-to-
+      digital converter (ADC) with 123-dB SNR.
+
+      ti,pcm1690: 113dB SNR, 24-Bit, 192-kHz Sampling, Enhanced Multi-Level
+      ?S, Eight-Channel Audio Digital-to-Analog Converter with Differential
+      Outputs.
+
+      ti,pcm3120: Automotive, stereo, 106-dB SNR, 768-kHz, low-power
+      software-controlled audio ADC.
+
+      ti,pcm3140: Automotive, Quad-Channel, 768-kHz, Burr-BrownTM Audio ADC
+      with 106-dB SNR.
+
+      ti,pcm5120: Automotive, stereo, 120-dB SNR, 768-kHz, low-power
+      software-controlled audio ADC.
+
+      ti,pcm5140: Automotive, Quad-Channel, 768-kHz, Burr-BrownTM Audio ADC
+      with 120-dB SNR.
+
+      ti,pcm6120: Automotive, stereo, 123-dB SNR, 768-kHz, low-power
+      software-controlled audio ADC.
+
+      ti,pcm6140: Automotive, Quad-Channel, 768-kHz, Burr-BrownTM Audio ADC
+      with 123-dB SNR.
+
+      ti,pcm6240: Automotive 4-ch audio ADC with integrated programmable mic
+      bias, boost and input diagnostics.
+
+      ti,pcm6260: Automotive 6-ch audio ADC with integrated programmable mic
+      bias, boost and input diagnostics.
+
+      ti,pcm9211: 216-kHz Digital Audio Interface Transceiver (DIX)
+      With Stereo ADC and Routing.
+
+      ti,pcmd3140: Four-channel PDM-input to TDM or I�S output converter.
+
+      ti,pcmd3180: Eight-channel pulse-density-modulation input to TDM or
+      I�S output converter.
+
+      ti,taa5212: Low-power high-performance stereo audio ADC with 118-dB
+      dynamic range.
+
+      ti,tad5212: Low-power stereo audio DAC with 120-dB dynamic range.
+    enum:
+      - ti,adc3120
+      - ti,adc5120
+      - ti,adc6120
+      - ti,dix4192
+      - ti,pcm1690
+      - ti,pcm3120
+      - ti,pcm3140
+      - ti,pcm5120
+      - ti,pcm5140
+      - ti,pcm6120
+      - ti,pcm6140
+      - ti,pcm6240
+      - ti,pcm6260
+      - ti,pcm9211
+      - ti,pcmd3140
+      - ti,pcmd3180
+      - ti,pcmd512x
+      - ti,taa5212
+      - ti,taa5412
+      - ti,tad5212
+      - ti,tad5412
+
+  reg:
+    description:
+      I2C address, in multiple pcmdevices case, all the i2c address
+      aggregate as one Audio Device to support multiple audio slots.
+    maxItems: 4
+    minItems: 1
+
+  reset-gpios:
+    maxItems: 1
+    description:
+      A GPIO line handling reset of the chip. As the line is active high,
+      it should be marked GPIO_ACTIVE_HIGH.
+
+  interrupts:
+    maxItems: 1
+    description:
+      Invalid only for ti,pcm1690 because of no INT pin.
+
+  '#sound-dai-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: dai-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,pcm1690
+    then:
+      properties:
+        reg:
+          description:
+            I2C address, in multiple pcmdevices case, all the i2c address
+            aggregate as one Audio Device to support multiple audio slots.
+          maxItems: 4
+          minItems: 1
+          items:
+            minimum: 0x4c
+            maximum: 0x4f
+        interrupts: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,pcm3140
+              - ti,pcm5140
+              - ti,pcm6140
+              - ti,pcmd3180
+    then:
+      properties:
+        reg:
+          description:
+            I2C address, in multiple pcmdevices case, all the i2c address
+            aggregate as one Audio Device to support multiple audio slots.
+          maxItems: 4
+          minItems: 1
+          items:
+            minimum: 0x4c
+            maximum: 0x4f
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,adc3120
+              - ti,adc5120
+              - ti,adc6120
+              - ti,pcm3120
+              - ti,pcm5120
+              - ti,pcm6120
+              - ti,pcmd3140
+    then:
+      properties:
+        reg:
+          description:
+            I2C address.
+          maxItems: 1
+          items:
+            maximum: 0x4e
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,dix4192
+    then:
+      properties:
+        reg:
+          description:
+            I2C address, in multiple pcmdevices case, all the i2c address
+            aggregate as one Audio Device to support multiple audio slots.
+          maxItems: 4
+          minItems: 1
+          items:
+            minimum: 0x70
+            maximum: 0x73
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,pcm6240
+              - ti,pcm6260
+    then:
+      properties:
+        reg:
+          description:
+            I2C address, in multiple pcmdevices case, all the i2c address
+            aggregate as one Audio Device to support multiple audio slots.
+          maxItems: 4
+          minItems: 1
+          items:
+            minimum: 0x48
+            maximum: 0x4b
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,pcm9211
+    then:
+      properties:
+        reg:
+          description:
+            I2C address, in multiple pcmdevices case, all the i2c address
+            aggregate as one Audio Device to support multiple audio slots.
+          maxItems: 4
+          minItems: 1
+          items:
+            minimum: 0x40
+            maximum: 0x43
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,taa5212
+              - ti,taa5412
+              - ti,tad5212
+              - ti,tad5412
+    then:
+      properties:
+        reg:
+          description:
+            I2C address, in multiple pcmdevices case, all the i2c address
+            aggregate as one Audio Device to support multiple audio slots.
+          maxItems: 4
+          minItems: 1
+          items:
+            minimum: 0x50
+            maximum: 0x53
+additionalProperties: false
+
+examples:
+  - |
+   #include <dt-bindings/gpio/gpio.h>
+   i2c {
+     /* example for two devices with interrupt support */
+     #address-cells = <1>;
+     #size-cells = <0>;
+     two: pcmdevice@48 {
+       compatible = "ti,pcm6240";
+       reg = <0x48>, /* primary-device */
+            <0x4b>; /* secondary-device */
+       #sound-dai-cells = <0>;
+       reset-gpios = < &gpio1 10 GPIO_ACTIVE_HIGH >;
+       interrupt-parent = <&gpio1>;
+       interrupts = <15>;
+     };
+   };
+  - |
+   #include <dt-bindings/gpio/gpio.h>
+   i2c {
+     /* example for one device without interrupt support*/
+     #address-cells = <1>;
+     #size-cells = <0>;
+     one: pcmdevice@4c {
+       compatible = "ti,pcmd3180";
+       reg = <0x4c>;
+       #sound-dai-cells = <0>;
+       reset-gpios = < &gpio1 10 GPIO_ACTIVE_HIGH >;
+     };
+   };
+...
-- 
2.34.1


