Return-Path: <linux-kernel+bounces-39591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D52D83D349
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 05:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 428B228C102
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 04:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D34212B6F;
	Fri, 26 Jan 2024 04:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sIQVz94g"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6370BC148;
	Fri, 26 Jan 2024 04:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706241632; cv=none; b=g4hU7cxWxp8KZQGzRieDBPr+GSWOXNRXqB5XmSjpsCw09Bp+pi5+3GE2cnj51hNXOuSkJkwfjP5tSQfJ/l10YVy3LL+XAxo1BFPqhf8lJ6H1c6PQNSyC5UE4I0qJbQtwOFlnM+FnK28S9OMZ0KOMP01ceQMrMWaKeDi/5HKMKic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706241632; c=relaxed/simple;
	bh=/ZaLaorxZVKXDmQQ94dz2LgT1yHrRCVTf9EreSVCmnc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u/qeyuV1hp49VnB2hTzqA8yfigOPGVhxUcJDzxSXbP8A04KBZ/Klo6GYCI00diFoV//kh4qHsUdusCLw6OpsanCKlFB3EAyk/MjrYebmVPPtvXzFivlDI3pagv0PfnrFs5w7R4ezW+xZWySiSzJiZMKswdT3BVhHPoPITN9P6FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sIQVz94g; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40Q3xb7t002216;
	Thu, 25 Jan 2024 21:59:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706241577;
	bh=OmG2xt00ADam0IKn7SFDfgt5iGcKImdOSOq7Qyb8+gc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=sIQVz94g8JXl5gRglD/0U9C7bRa79QOLBM+ILni0bCdDLamJOegHAiCcwn2rNSVr0
	 SbCPhehCm2zHMuC0d/M0Ae4XCNiNDaFPFjoCwLHCoqJmdpqc/q5Wizxt0L9cGJ9Ah3
	 1Yhw4X4XQVLmI+c7n5vU5NTyzK5bgMIb2mgKaclw=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40Q3xbBV023938
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 25 Jan 2024 21:59:37 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Jan 2024 21:59:37 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Jan 2024 21:59:37 -0600
Received: from LT5CG31242FY.dhcp.ti.com (lt5cg31242fy.dhcp.ti.com [10.85.14.72])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40Q3wwim025780;
	Thu, 25 Jan 2024 21:59:29 -0600
From: Shenghao Ding <shenghao-ding@ti.com>
To: <broonie@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski@linaro.org>
CC: <robh+dt@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <kevin-lu@ti.com>, <baojun.xu@ti.com>, <devicetree@vger.kernel.org>,
        <v-po@ti.com>, <lgirdwood@gmail.com>, <perex@perex.cz>,
        <pierre-louis.bossart@linux.intel.com>, <13916275206@139.com>,
        <mohit.chawla@ti.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <liam.r.girdwood@intel.com>,
        <soyer@irl.hu>, <jkhuang3@ti.com>, <tiwai@suse.de>, <pdjuandi@ti.com>,
        <j-mcpherson@ti.com>, <navada@ti.com>,
        Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v2 4/4] ASoc: dt-bindings: PCM6240: Add initial DT binding
Date: Fri, 26 Jan 2024 11:58:54 +0800
Message-ID: <20240126035855.1785-4-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20240126035855.1785-1-shenghao-ding@ti.com>
References: <20240126035855.1785-1-shenghao-ding@ti.com>
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
Change in v2:
 - Rewrite the subject to match something similar to other commits.
 - And something to be compatible with.
 - minItems, then maxItems.
 - Drop reset-gpios description
 - Remove the repeated reg descriptions and reg constraints.
 - Drop redundant spaces.
 - Add missing line breaks between blocks and additionalProperties.
 - All these chips have only a portion of the functionality of codec,
   such as ADC or DAC, and so on, but their audio performance is far
   superior to the codec's, and cost is lower than codec, and much easier
   to program than codec. Simply one or two register settings can enable
   them to work. Init for these chips are hardware reset or software reset.
   As to some audio filter params for internal filters, it is up to the
   special user cases, which can be saved into the bin file. The default
   value also can work well.
---
 .../devicetree/bindings/sound/ti,pcm6240.yaml | 276 ++++++++++++++++++
 1 file changed, 276 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ti,pcm6240.yaml

diff --git a/Documentation/devicetree/bindings/sound/ti,pcm6240.yaml b/Documentation/devicetree/bindings/sound/ti,pcm6240.yaml
new file mode 100644
index 000000000000..f06264d81b46
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ti,pcm6240.yaml
@@ -0,0 +1,276 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2022 - 2024 Texas Instruments Incorporated
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/ti,pcm6240.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments PCM6240 Family Audio ADC/DAC
+
+maintainers:
+  - Shenghao Ding <shenghao-ding@ti.com>
+
+description: |
+  The PCM6240 Family is a big family of Audio ADC/DAC for
+  different Specifications, range from Personal Electric
+  to Automotive Electric, even some professional fields.
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
+    oneOf:
+      - items:
+          - enum:
+              - ti,adc3120
+              - ti,adc5120
+              - ti,pcm3120
+              - ti,pcm5120
+              - ti,pcm6120
+          - const: ti,adc6120
+      - items:
+          - enum:
+              - ti,pcm6260
+              - ti,pcm6140
+              - ti,pcm3140
+              - ti,pcm5140
+          - const: ti,pcm6240
+      - items:
+          - const: ti,dix4192
+          - const: ti,pcm6240
+          - const: ti,adc6120
+      - items:
+          - const: ti,pcm1690
+          - const: ti,pcm9211
+          - const: ti,pcmd512x
+      - items:
+          - enum:
+              - ti,pcmd3180
+          - const: ti,pcmd3140
+      - items:
+          - enum:
+              - taa5412
+          - const: ti,taa5212
+      - items:
+          - enum:
+              - tad5412
+          - const: ti,tad5212
+      - items:
+          - enum:
+              - ti,pcm6240
+              - ti,pcmd3140
+              - ti,taa5212
+              - ti,tad5212
+              - ti,pcmd3180
+  reg:
+    description:
+      I2C address, in multiple pcmdevices case, all the i2c address
+      aggregate as one Audio Device to support multiple audio slots.
+    minItems: 1
+    maxItems: 4
+
+  reset-gpios:
+    maxItems: 1
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
+          minItems: 1
+          maxItems: 4
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
+          items:
+            minimum: 0x50
+            maximum: 0x53
+
+additionalProperties: false
+
+examples:
+  - |
+   #include <dt-bindings/gpio/gpio.h>
+   i2c {
+     /* example for two devices with interrupt support */
+     #address-cells = <1>;
+     #size-cells = <0>;
+     pcm6240: audio-codec@48 {
+       compatible = "ti,pcm6240";
+       reg = <0x48>, /* primary-device */
+            <0x4b>; /* secondary-device */
+       #sound-dai-cells = <0>;
+       reset-gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
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
+     pcmd3180: audio-codec@4c {
+       compatible = "ti,pcmd3180";
+       reg = <0x4c>;
+       #sound-dai-cells = <0>;
+       reset-gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
+     };
+   };
+...
-- 
2.34.1


