Return-Path: <linux-kernel+bounces-57980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AC684DFE6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E16DB26F8A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED55B7318B;
	Thu,  8 Feb 2024 11:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dGfqvEQ1"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422BC73181;
	Thu,  8 Feb 2024 11:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707392532; cv=none; b=lcIalDWoJoF3W3yyOe6luFhwsrqiZqrP3R1FwpbWmipS8LEX0NS3bXGVQDXxtOY/3gYsoJ8ItlXt6tV03Vw1Gqa1Xq+xaJ5p21z4YIg3Y6zCt6VyOH/Y0LHiINCX7oyi+VC2UVOzJWjV8XxpAg8WXg5HMbHEHi/W4/GFvF3Fzf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707392532; c=relaxed/simple;
	bh=A7EVTIDLHtGX9lO4EdDXrAGB8NfIUDtJqg9uBTSY2ak=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UECySTCgWDbTEDehL3M1+Ofm7Pcezf1RKeSgXdCFcONHf7En7O6m8jVjzqEqaF9z8JxmzwWsW5yhqeFIaoSxd6+JRHWU7n4x1zWKCeK98jKQs0+X5/iizOQTPr1QxNXB5xkpotp72WnQHyLI/9uATdyAipe99Ntna+ddnNntMUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dGfqvEQ1; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 418BfMu8057672;
	Thu, 8 Feb 2024 05:41:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707392482;
	bh=i66KRsT5MXiCMeRUrNYxeiPCd7Z1pAneWKX/rWP8R50=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=dGfqvEQ1JzgAqtWGw2+20+CzKARBxpWSBtxIq8yRbg1+dIY5GagVnpDjCLqbDxGFO
	 77YGa89Jh8aXTmTgb+m8cKX/kj6WZnSWTallKhUyagUq2E67zFQmYu4r4f7z3tcDwq
	 ljQeLZ2/NZnDP8rvAIEO+toS86lUx7niVETYF4Gg=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 418BfM9k025668
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 05:41:22 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 05:41:21 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 05:41:21 -0600
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.162.93])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 418BepBx007761;
	Thu, 8 Feb 2024 05:41:15 -0600
From: Shenghao Ding <shenghao-ding@ti.com>
To: <linux-kernel@vger.kernel.org>
CC: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <perex@perex.cz>, <tiwai@suse.com>, <13916275206@139.com>,
        <mohit.chawla@ti.com>, <soyer@irl.hu>, <jkhuang3@ti.com>,
        <tiwai@suse.de>, <pdjuandi@ti.com>, <manisha.agrawal@ti.com>,
        <s-hari@ti.com>, <aviel@ti.com>, <hnagalla@ti.com>, <praneeth@ti.com>,
        Shenghao Ding <shenghao-ding@ti.com>
Subject: [RESEND PATCH v4 4/4] ASoc: dt-bindings: PCM6240: Add initial DT binding
Date: Thu, 8 Feb 2024 19:40:48 +0800
Message-ID: <20240208114049.1429-4-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20240208114049.1429-1-shenghao-ding@ti.com>
References: <20240208114049.1429-1-shenghao-ding@ti.com>
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
Change in v4:
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
 - Remove dix4192
 - simplify the compatibility
---
 .../devicetree/bindings/sound/ti,pcm6240.yaml | 172 ++++++++++++++++++
 1 file changed, 172 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ti,pcm6240.yaml

diff --git a/Documentation/devicetree/bindings/sound/ti,pcm6240.yaml b/Documentation/devicetree/bindings/sound/ti,pcm6240.yaml
new file mode 100644
index 000000000000..05fcb5459920
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ti,pcm6240.yaml
@@ -0,0 +1,172 @@
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
+              - ti,pcmd512x
+              - ti,pcm9211
+              - ti,taa5212
+              - ti,tad5212
+          - const: ti,adc6120
+      - items:
+          - enum:
+              - ti,pcm6260
+              - ti,pcm6140
+              - ti,pcm3140
+              - ti,pcm5140
+          - const: ti,pcm6240
+      - items:
+          - enum:
+              - ti,pcmd3140
+              - ti,pcmd3180
+              - ti,pcm1690
+              - ti,taa5412
+              - ti,tad5412
+          - const: ti,pcm6240
+      - enum:
+          - ti,adc6120
+          - ti,pcm6240
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
+...
-- 
2.34.1


