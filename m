Return-Path: <linux-kernel+bounces-152433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6128ABE5E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 03:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22E681F2162D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 01:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B096510A24;
	Sun, 21 Apr 2024 01:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uLp/GRyc"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC6E38C;
	Sun, 21 Apr 2024 01:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713664405; cv=none; b=NRQjAQhzE6uxb23+W+JSaB/iBJX5VjjMK8PLABeR3F/k8xySZY9R60m1CoX1/z9eHETZWDc+7Z8RVyjgKKWeD/k33q9/nNJ1IYRevaO4BaYiQKedagwIrgorYymM6D4d+GxiSa/5eKRxQv6A76kivcWX4opKBxoMAx/J7N0sCB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713664405; c=relaxed/simple;
	bh=rSDhC5PAkuAsXTcdlV+TqxFyDVc6SrLFiJeeck1bQec=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Br7NqD8F9cy5LgUP2baMK/rpv2+vlNmqFlHZJVzz5t6UKcXnrvqEn5FUJDBT+muTbmFuKOdV0IYCmGGo2SVHmthfPlG6VqAiF2cYejY/DI08FeP+0BHxJQIFG2hJDnUT9r4+Phd9GhIIP8w6Qgr9A973enO6i+ju8bfPH/e6eXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uLp/GRyc; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43L1qYXd000612;
	Sat, 20 Apr 2024 20:52:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713664354;
	bh=lefSTSp/ZxaykGj2g6ai9aSjJZIy05hDz3B0bEAtMx8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=uLp/GRycksCpfoxbUmJYQRuVl9FX+r/fOE0mUDc8jXoV/RKaZ6MZVuv3YUUCI7plq
	 7oyRCCp/FKzBMpiXl7PlwVXeBlxUGEmgHh4aVUEt8E/VjIKVDWsvPn6BeinW1eKnLY
	 KHT2BXQBHgfVd/OxSG2nTf4yK1/nLc8b6XOMAd+A=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43L1qYCm077920
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 20 Apr 2024 20:52:34 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 20
 Apr 2024 20:52:33 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 20 Apr 2024 20:52:33 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.160.109])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43L1pmOk047902;
	Sat, 20 Apr 2024 20:52:27 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <linux-kernel@vger.kernel.org>
CC: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <perex@perex.cz>, <tiwai@suse.com>, <13916275206@139.com>,
        <mohit.chawla@ti.com>, <soyer@irl.hu>, <jkhuang3@ti.com>,
        <tiwai@suse.de>, <pdjuandi@ti.com>, <manisha.agrawal@ti.com>,
        <aviel@ti.com>, <hnagalla@ti.com>, <praneeth@ti.com>,
        <Baojun.Xu@fpt.com>, Shenghao Ding
	<shenghao-ding@ti.com>,
        Rob Herring <robh@kernel.org>
Subject: [RESEND PATCH v9 4/4] PCM6240 family chips are popular among audio customers, in spite of only a portion of the functionality of codec, such as ADC or DAC, and so on, for different Specifications, range from Personal Electric to Automotive Electric, even some professional fields. Yet their audio performance is far superior to the codec's, and cost is lower than codec, and much easier to program than codec.
Date: Sun, 21 Apr 2024 09:51:43 +0800
Message-ID: <20240421015144.1154-5-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20240421015144.1154-1-shenghao-ding@ti.com>
References: <20240421015144.1154-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
v9:
 - No changes.
v8:
 - use some reasonable format of changelog.
 - Link to v5: https://lore.kernel.org/all/20240221051501.627-4-shenghao-ding@ti.com/
---
 .../devicetree/bindings/sound/ti,pcm6240.yaml | 177 ++++++++++++++++++
 1 file changed, 177 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ti,pcm6240.yaml

diff --git a/Documentation/devicetree/bindings/sound/ti,pcm6240.yaml b/Documentation/devicetree/bindings/sound/ti,pcm6240.yaml
new file mode 100644
index 000000000000..dd5b08e3d7a1
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ti,pcm6240.yaml
@@ -0,0 +1,177 @@
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
+      ti,dix4192: 216-kHz digital audio converter with Quad-Channel In
+      and One-Channel Out.
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
+      ti,pcm9211: 216-kHz digital audio converter With Stereo ADC and
+      Routing.
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
+              - ti,pcm3140
+              - ti,pcm5140
+              - ti,dix4192
+              - ti,pcm6140
+              - ti,pcm6260
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


