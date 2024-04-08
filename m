Return-Path: <linux-kernel+bounces-135522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E2789C721
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17BA82840B9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F3113D63E;
	Mon,  8 Apr 2024 14:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ozbFH85J"
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E81313D53F;
	Mon,  8 Apr 2024 14:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712586718; cv=none; b=ldq9HodpXhxYamaaVcDltDIYf6G6owz0KncBaK8LbFsDFis7LduFPfOBobCGv/KOAUW9wm9fs9fPVw7ig4RH7YPXG1Bhszm/rBM6gBudAaVe/wpmrhjZA/KV2Xl27xL1hWogbtgusFweN24CTpim9FdSmVvYakX2z+vkhxIKdIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712586718; c=relaxed/simple;
	bh=yDMe6cN/Z8OI1Cu0k1bqGA1TRpL7xsCpw4sbpKzU/9k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ac7ZkG7A3ZLwueaZFNKVogX5vY+9OiZBtAIFToxZn7rPctqs+Eep6HPol0+JDFF6+digWmxipYpnvu5Y1oX9Ki5aQkwjMa2qjT58AXvr1y5Vw5qwdajRatmaXSdauV48QcNNTbT858JW8vsb6XJKM9XuCh/co4wF3A+tnjOH7uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ozbFH85J; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 438BnEZB027951;
	Mon, 8 Apr 2024 10:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=DKIM;
	 bh=025G570fNcUVPKUrkar8wsg4vvXOobxAl6CRokdCMAM=; b=ozbFH85JLJOo
	DVVGXh1RfbjldDmuZr7KoGB3P0IWRcIqEN1Po8iSRw9aYYiUti29edVjhMAbl5RU
	jKZOGUFeK7P/MgVdeFyT2dW1pMWRb3InB7hMQNPi7+RYe1VIWBvviFlk0zkMQwxc
	SKOEWU2aTJ4AlnF1c4rOt7zuwpKNOcUW4ECfrZB8twrw0AAtTLUAe7OtkuA7H96T
	K9R5NQtEIaprm9oVpYFZvOHbm0Vg/zrVPfLhMpZ1zHYXDA9P+Xp3cbU9UWjIyQ1l
	SjudFjwMwm8PdJ+KxdA6NwskfWV+klGBzMrVU7V+2puRVKHOiZCK7ga+BD/YKGhe
	M5hIMmoX2g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3xcbbn1qgf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 10:31:41 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 438EVd5I010489
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 8 Apr 2024 10:31:39 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 8 Apr 2024 10:31:39 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 8 Apr 2024 10:31:35 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 8 Apr 2024 10:31:35 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 438EVN4a017943;
	Mon, 8 Apr 2024 10:31:25 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: iio: adc: Add AD4000
Date: Mon, 8 Apr 2024 11:31:20 -0300
Message-ID: <7c877c865f0b7da28d9f1f177b3b2692b0ae20b9.1712585500.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1712585500.git.marcelo.schmitt@analog.com>
References: <cover.1712585500.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: Ni9NrE5p4_VFUBwBGnG3CcER0I32fQIK
X-Proofpoint-ORIG-GUID: Ni9NrE5p4_VFUBwBGnG3CcER0I32fQIK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_12,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 adultscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404080111

Add device tree documentation for AD4000 family of ADC devices.

Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4000-4004-4008.pdf
Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4001-4005.pdf
Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4002-4006-4010.pdf
Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4003-4007-4011.pdf
Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4020-4021-4022.pdf
Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4001.pdf
Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4003.pdf

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 .../bindings/iio/adc/adi,ad4000.yaml          | 201 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 208 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
new file mode 100644
index 000000000000..ca06afb5149e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
@@ -0,0 +1,201 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad4000.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD4000 and similar Analog to Digital Converters
+
+maintainers:
+  - Marcelo Schmitt <marcelo.schmitt@analog.com>
+
+description: |
+  Analog Devices AD4000 family of Analog to Digital Converters with SPI support.
+  Specifications can be found at:
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4000-4004-4008.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4001-4005.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4002-4006-4010.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4003-4007-4011.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4020-4021-4022.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4001.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4003.pdf
+
+$ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    enum:
+      - adi,ad4000
+      - adi,ad4001
+      - adi,ad4002
+      - adi,ad4003
+      - adi,ad4004
+      - adi,ad4005
+      - adi,ad4006
+      - adi,ad4007
+      - adi,ad4008
+      - adi,ad4010
+      - adi,ad4011
+      - adi,ad4020
+      - adi,ad4021
+      - adi,ad4022
+      - adi,adaq4001
+      - adi,adaq4003
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 102040816 # for VIO > 2.7 V, 81300813 for VIO > 1.7 V
+
+  spi-cpha: true
+
+  adi,spi-mode:
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [ single, chain ]
+    description: |
+      This property indicates the SPI wiring configuration.
+
+      When this property is omitted, it is assumed that the device is using what
+      the datasheet calls "4-wire mode". This is the conventional SPI mode used
+      when there are multiple devices on the same bus. In this mode, the CNV
+      line is used to initiate the conversion and the SDI line is connected to
+      CS on the SPI controller.
+
+      When this property is present, it indicates that the device is using one
+      of the following alternative wiring configurations:
+
+      * single: The datasheet calls this "3-wire mode". (NOTE: The datasheet's
+        definition of 3-wire mode is NOT at all related to the standard
+        spi-3wire property!) This mode is often used when the ADC is the only
+        device on the bus. In this mode, SDI is tied to VIO, and the CNV line
+        can be connected to the CS line of the SPI controller or to a GPIO, in
+        which case the CS line of the controller is unused.
+      * chain: The datasheet calls this "chain mode". This mode is used to save
+        on wiring when multiple ADCs are used. In this mode, the SDI line of
+        one chip is tied to the SDO of the next chip in the chain and the SDI of
+        the last chip in the chain is tied to GND. Only the first chip in the
+        chain is connected to the SPI bus. The CNV line of all chips are tied
+        together. The CS line of the SPI controller can be used as the CNV line
+        only if it is active high.
+
+  '#daisy-chained-devices': true
+
+  vdd-supply:
+    description: A 1.8V supply that powers the chip (VDD).
+
+  vio-supply:
+    description:
+      A 1.8V to 5.5V supply for the digital inputs and outputs (VIO).
+
+  ref-supply:
+    description:
+      A 2.5 to 5V supply for the external reference voltage (REF).
+
+  cnv-gpios:
+    description:
+      The Convert Input (CNV). This input has multiple functions. It initiates
+      the conversions and selects the SPI mode of the device (chain or CS). In
+      'single' mode, this property is omitted if the CNV pin is connected to the
+      CS line of the SPI controller. If 'single' mode is selected and this GPIO
+      is provided, it must be active low.
+    maxItems: 1
+
+  adi,high-z-input:
+    type: boolean
+    description:
+      High-Z mode allows the amplifier and RC filter in front of the ADC to be
+      chosen based on the signal bandwidth of interest, rather than the settling
+      requirements of the switched capacitor SAR ADC inputs.
+
+  adi,gain-milli:
+    description: |
+      The hardware gain applied to the ADC input (in milli units).
+      The gain provided by the ADC input scaler is defined by the hardware
+      connections between chip pins OUT+, R1K-, R1K1-, R1K+, R1K1+, and OUT-.
+      If not present, default to 1000 (no actual gain applied).
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [454, 909, 1000, 1900]
+    default: 1000
+
+  interrupts:
+    description:
+      The SDO pin can also function as a busy indicator. This node should be
+      connected to an interrupt that is triggered when the SDO line goes low
+      while the SDI line is high and the CNV line is low ('single' mode) or the
+      SDI line is low and the CNV line is high ('multi' mode); or when the SDO
+      line goes high while the SDI and CNV lines are high (chain mode),
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - spi-cpha
+  - vdd-supply
+  - vio-supply
+  - ref-supply
+
+allOf:
+  # in '4-wire' mode, cnv-gpios is required, for other modes it is optional
+  - if:
+      not:
+        required:
+          - adi,spi-mode
+    then:
+      required:
+        - cnv-gpios
+  # chain mode has lower SCLK max rate
+  - if:
+      required:
+        - adi,spi-mode
+      properties:
+        adi,spi-mode:
+          const: chain
+    then:
+      properties:
+        spi-max-frequency:
+          maximum: 50000000 # for VIO > 2.7 V, 40000000 for VIO > 1.7 V
+      required:
+        - '#daisy-chained-devices'
+    else:
+      properties:
+        '#daisy-chained-devices': false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        /* Example for a AD devices */
+        adc@0 {
+            compatible = "adi,ad4020";
+            reg = <0>;
+            spi-cpha;
+            spi-max-frequency = <71000000>;
+            vdd-supply = <&supply_1_8V>;
+            vio-supply = <&supply_1_8V>;
+            ref-supply = <&supply_5V>;
+            cnv-gpios = <&gpio0 88 GPIO_ACTIVE_HIGH>;
+        };
+    };
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        /* Example for a ADAQ devices */
+        adc@0 {
+            compatible = "adi,adaq4003";
+            reg = <0>;
+            spi-cpha;
+            adi,spi-mode = "single";
+            spi-max-frequency = <80000000>;
+            vdd-supply = <&supply_1_8V>;
+            vio-supply = <&supply_1_8V>;
+            ref-supply = <&supply_5V>;
+            adi,high-z-input;
+            adi,gain-milli = <454>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index a7287cf44869..5dfe118a5dd3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1159,6 +1159,13 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
 F:	drivers/iio/dac/ad3552r.c
 
+ANALOG DEVICES INC AD4000 DRIVER
+M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
+
 ANALOG DEVICES INC AD4130 DRIVER
 M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
 L:	linux-iio@vger.kernel.org
-- 
2.43.0


