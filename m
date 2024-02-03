Return-Path: <linux-kernel+bounces-50883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EE9847FD7
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 04:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ACDA1F276EA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 03:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A00879FE;
	Sat,  3 Feb 2024 03:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hPuLUHxg"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D2879C0;
	Sat,  3 Feb 2024 03:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706929717; cv=none; b=EjlYOngMan7Rj8eRZzpRN+evte57vkKKYQfqZiapyV//Juh8O/Pqx7xmQRiRasJWVLL+zTQlwE7RNPBEsw+mY8HLQrYCdHBc08xIiCuVHRO2QJTBzLb97xiMYBkH8Rv85IgYD3jdGD5UG4YOsb8tFVGj/HuA3vd5GbGLk7pPndY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706929717; c=relaxed/simple;
	bh=vK5dW/PRRoIO6MZcxfMO5hEmtNmPer552nVlJ/dQ3tM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FqhmtOgkm/h0zGxw+m9d8N9t3P+0F61ndZKOatMOrYvWB62Of6+ta14xyEk3/xqUR4kNAOVVaESxwGZQUGvgv5lNzdDRzOEZK2bdl6LQu+wp4xZZXafKk86ocBNyYlzRP6Bu2iDClV3903x+lp5AkDo6weHvuBaf9WJ66KRWan8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hPuLUHxg; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41335oDM013030;
	Fri, 2 Feb 2024 21:05:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706929550;
	bh=993adIjBeKvC8pKrVaumjq+I7IEyGHVR7caepVpb+QI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=hPuLUHxggKhRTIXdeNkGXgTIppqDNKdRPGkG5voEAPD02Qc6kdqA3uZ7tPtUXb7hc
	 j3UUWSj9QYOGFFAHnyNyCNfZDzWaOSu1Oo/J1aVatSn6Vcwbm2OiE3zHL2UdvAaCOn
	 KCgAwLZnVfNp5nzCb96POvuV1T+TfQDUqANuLCW0=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41335oTb022971
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 2 Feb 2024 21:05:50 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 2
 Feb 2024 21:05:50 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 2 Feb 2024 21:05:50 -0600
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.162.93])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 413358h8021917;
	Fri, 2 Feb 2024 21:05:41 -0600
From: Shenghao Ding <shenghao-ding@ti.com>
To: <broonie@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski@linaro.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <linux-sound@vger.kernel.org>, <liam.r.girdwood@intel.com>,
        <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>
CC: <kevin-lu@ti.com>, <baojun.xu@ti.com>, <v-po@ti.com>, <navada@ti.com>,
        <perex@perex.cz>, <j-mcpherson@ti.com>,
        <pierre-louis.bossart@linux.intel.com>, <13916275206@139.com>,
        <mohit.chawla@ti.com>, <soyer@irl.hu>, <jkhuang3@ti.com>,
        <tiwai@suse.de>, <pdjuandi@ti.com>, <manisha.agrawal@ti.com>,
        <s-hari@ti.com>, <aviel@ti.com>, <hnagalla@ti.com>, <praneeth@ti.com>,
        Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v3 4/4] ASoc: dt-bindings: PCM6240: Add initial DT binding
Date: Sat, 3 Feb 2024 11:05:02 +0800
Message-ID: <20240203030504.1724-4-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20240203030504.1724-1-shenghao-ding@ti.com>
References: <20240203030504.1724-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

PCM6240 family chips are popular among audio customers, in spite of only a
portion of the functionality of codec, such as ADC or DAC, and so on, for
different Specifications, range from Personal Electric to Automotive
Electric, even some professional fields.yet their audio performance is far
superior to the codec's, and cost is lower than codec, and much easier to
program than codec.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
Change in v3:
 - Rewrite the subject to match something similar to other commits.
 - And none of them are compatible with something.
 - minItems, then maxItems.
 - Drop reset-gpios description
 - Remove the repeated reg descriptions and reg constraints.
 - Drop redundant spaces.
 - Add missing line breaks between blocks and additionalProperties.
 - Correct compatibility issue on adc6120 and pcm6240.
 - All these chips have only a portion of the functionality of codec,
   such as ADC or DAC, and so on, but their audio performance is far
   superior to the codec's, and cost is lower than codec, and much easier
   to program than codec. Simply one or two register settings can enable
   them to work. Init for these chips are hardware reset or software reset.
   As to some audio filter params for internal filters, it is up to the
   special user cases, which can be saved into the bin file. The default
   value also can work well.
 - Add blank line before reg.
 - remove unneeded items and if branches.
 - Add missing compatible devices, such as adc6120, etc.
 - Add necessary people into the list for DTS review
 - correct misaligned.
---
 .../devicetree/bindings/sound/ti,pcm6240.yaml | 214 ++++++++++++++++++
 1 file changed, 214 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ti,pcm6240.yaml

diff --git a/Documentation/devicetree/bindings/sound/ti,pcm6240.yaml b/Documentation/devicetree/bindings/sound/ti,pcm6240.yaml
new file mode 100644
index 000000000000..c0f8e8cf1d06
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ti,pcm6240.yaml
@@ -0,0 +1,214 @@
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
+      ti,adc5120: 2-Channel, 768-kHz, Burr-Brown™ Audio ADC with 120-dB SNR.
+
+      ti,adc6120: Stereo-channel, 768-kHz, Burr-Brown™ audio analog-to-
+      digital converter (ADC) with 123-dB SNR.
+
+      ti,pcm1690: Automotive Catalog 113dB SNR 8-Channel Audio DAC with
+      Differential Outputs.
+
+      ti,pcm3120: Automotive, stereo, 106-dB SNR, 768-kHz, low-power
+      software-controlled audio ADC.
+
+      ti,pcm3140: Automotive, Quad-Channel, 768-kHz, Burr-Brown™ Audio ADC
+      with 106-dB SNR.
+
+      ti,pcm5120: Automotive, stereo, 120-dB SNR, 768-kHz, low-power
+      software-controlled audio ADC.
+
+      ti,pcm5140: Automotive, Quad-Channel, 768-kHz, Burr-Brown™ Audio ADC
+      with 120-dB SNR.
+
+      ti,pcm6120: Automotive, stereo, 123-dB SNR, 768-kHz, low-power
+      software-controlled audio ADC.
+
+      ti,pcm6140: Automotive, Quad-Channel, 768-kHz, Burr-Brown™ Audio ADC
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
+      ti,pcmd3140: Four-channel PDM-input to TDM or I2S output converter.
+
+      ti,pcmd3180: Eight-channel pulse-density-modulation input to TDM or
+      I2S output converter.
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
+      - items:
+          - const: ti,adc6120
+          - const: ti,pcmd512x
+      - items:
+          - const: ti,pcm1690
+          - const: ti,pcm9211
+      - items:
+          - enum:
+              - ti,pcmd3180
+          - const: ti,pcmd3140
+      - items:
+          - enum:
+              - ti,taa5412
+          - const: ti,taa5212
+      - items:
+          - enum:
+              - ti,tad5412
+          - const: ti,tad5212
+      - enum:
+          - ti,pcm6240
+          - ti,pcmd3140
+          - ti,taa5212
+          - ti,tad5212
+          - ti,pcmd3180
+
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
+             <0x4b>; /* secondary-device */
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


