Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B62F803E9D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjLDTor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjLDTop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:44:45 -0500
Received: from mail.subdimension.ro (unknown [IPv6:2a01:7e01:e001:1d1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C43D2;
        Mon,  4 Dec 2023 11:44:50 -0800 (PST)
Received: from localhost.localdomain (unknown [188.24.94.216])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by mail.subdimension.ro (Postfix) with ESMTPSA id 988DB28EE6F;
        Mon,  4 Dec 2023 19:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
        s=skycaves; t=1701719088;
        bh=4wanOrlQPS66tajSBgXdI4zLh7IC9z4XmP+kH99JeJ4=;
        h=From:To:Cc:Subject:Date;
        b=PxbftUAS7Qrd10Z2OmvOju2U1IuULuwOs6w4DO8ctxRNLYTz/M6NUDtIaYHzzdiNV
         AxdRSo7/X7NxNK/3mE3l7EOlQmsD5YBpGLtvlczAoNXiKfSvTaKQG2MLAzGgx1qu3E
         GngDIzTkhEgqZT2x226pyS4LMH6YHizpr9kuPXf0=
From:   Petre Rodan <petre.rodan@subdimension.ro>
To:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Petre Rodan <petre.rodan@subdimension.ro>,
        Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 1/2] dt-bindings: iio: pressure: add honeywell,hsc030
Date:   Mon,  4 Dec 2023 21:43:58 +0200
Message-ID: <20231204194401.20891-1-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds binding for digital Honeywell TruStability HSC and SSC series
pressure and temperature sensors.
Communication is one way. The sensor only requires 4 bytes worth of
clock pulses on both i2c and spi in order to push the data out.
The i2c address is hardcoded and depends on the part number.
There is no additional GPIO control.

Datasheet:
https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-hsc-series/documents/sps-siot-trustability-hsc-series-high-accuracy-board-mount-pressure-sensors-50099148-a-en-ciid-151133.pdf [HSC]
Datasheet:
https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-ssc-series/documents/sps-siot-trustability-ssc-series-standard-accuracy-board-mount-pressure-sensors-50099533-a-en-ciid-151134.pdf [SSC]
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v2: - fix yaml struct
    - cleanup based on Krzysztof's review
v3: - rename range_str -> honeywell,pressure-triplet to define the string
       containing the pressure range, measurement unit and type
    - honeywell,pmax-pascal becomes uint32
v4: - added enum to honeywell,transfer-function
v5: - removed pmin-pascal, pmax-pascal $ref
    - added pmin-pascal, pmax-pascal constraints
v6: - no change
v7: - no change
---
 .../iio/pressure/honeywell,hsc030pa.yaml      | 142 ++++++++++++++++++
 1 file changed, 142 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml

diff --git a/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml b/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml
new file mode 100644
index 000000000000..65a24ed67b3c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml
@@ -0,0 +1,142 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/pressure/honeywell,hsc030pa.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Honeywell TruStability HSC and SSC pressure sensor series
+
+description: |
+  support for Honeywell TruStability HSC and SSC digital pressure sensor
+  series.
+
+  These sensors have either an I2C, an SPI or an analog interface. Only the
+  digital versions are supported by this driver.
+
+  There are 118 models with different pressure ranges available in each family.
+  The vendor calls them "HSC series" and "SSC series". All of them have an
+  identical programming model but differ in pressure range, unit and transfer
+  function.
+
+  To support different models one needs to specify the pressure range as well
+  as the transfer function. Pressure range can either be provided via
+  pressure-triplet (directly extracted from the part number) or in case it's
+  a custom chip via numerical range limits converted to pascals.
+
+  The transfer function defines the ranges of raw conversion values delivered
+  by the sensor. pmin-pascal and pmax-pascal corespond to the minimum and
+  maximum pressure that can be measured.
+
+  Please note that in case of an SPI-based sensor, the clock signal should not
+  exceed 800kHz and the MOSI signal is not required.
+
+  Specifications about the devices can be found at:
+  https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-hsc-series/documents/sps-siot-trustability-hsc-series-high-accuracy-board-mount-pressure-sensors-50099148-a-en-ciid-151133.pdf
+  https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-ssc-series/documents/sps-siot-trustability-ssc-series-standard-accuracy-board-mount-pressure-sensors-50099533-a-en-ciid-151134.pdf
+
+maintainers:
+  - Petre Rodan <petre.rodan@subdimension.ro>
+
+properties:
+  compatible:
+    const: honeywell,hsc030pa
+
+  reg:
+    maxItems: 1
+
+  honeywell,transfer-function:
+    description: |
+      Transfer function which defines the range of valid values delivered by
+      the sensor.
+      0 - A, 10% to 90% of 2^14
+      1 - B, 5% to 95% of 2^14
+      2 - C, 5% to 85% of 2^14
+      3 - F, 4% to 94% of 2^14
+    enum: [0, 1, 2, 3]
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  honeywell,pressure-triplet:
+    description: |
+      Case-sensitive five character string that defines pressure range, unit
+      and type as part of the device nomenclature. In the unlikely case of a
+      custom chip, set to "NA" and provide pmin-pascal and pmax-pascal.
+    enum: [001BA, 1.6BA, 2.5BA, 004BA, 006BA, 010BA, 1.6MD, 2.5MD, 004MD,
+           006MD, 010MD, 016MD, 025MD, 040MD, 060MD, 100MD, 160MD, 250MD,
+           400MD, 600MD, 001BD, 1.6BD, 2.5BD, 004BD, 2.5MG, 004MG, 006MG,
+           010MG, 016MG, 025MG, 040MG, 060MG, 100MG, 160MG, 250MG, 400MG,
+           600MG, 001BG, 1.6BG, 2.5BG, 004BG, 006BG, 010BG, 100KA, 160KA,
+           250KA, 400KA, 600KA, 001GA, 160LD, 250LD, 400LD, 600LD, 001KD,
+           1.6KD, 2.5KD, 004KD, 006KD, 010KD, 016KD, 025KD, 040KD, 060KD,
+           100KD, 160KD, 250KD, 400KD, 250LG, 400LG, 600LG, 001KG, 1.6KG,
+           2.5KG, 004KG, 006KG, 010KG, 016KG, 025KG, 040KG, 060KG, 100KG,
+           160KG, 250KG, 400KG, 600KG, 001GG, 015PA, 030PA, 060PA, 100PA,
+           150PA, 0.5ND, 001ND, 002ND, 004ND, 005ND, 010ND, 020ND, 030ND,
+           001PD, 005PD, 015PD, 030PD, 060PD, 001NG, 002NG, 004NG, 005NG,
+           010NG, 020NG, 030NG, 001PG, 005PG, 015PG, 030PG, 060PG, 100PG,
+           150PG, NA]
+    $ref: /schemas/types.yaml#/definitions/string
+
+  honeywell,pmin-pascal:
+    description: |
+      Minimum pressure value the sensor can measure in pascal.
+      To be specified only if honeywell,pressure-triplet is set to "NA".
+
+  honeywell,pmax-pascal:
+    description: |
+      Maximum pressure value the sensor can measure in pascal.
+      To be specified only if honeywell,pressure-triplet is set to "NA".
+
+  vdd-supply:
+    description:
+      Provide VDD power to the sensor (either 3.3V or 5V depending on the chip)
+
+  spi-max-frequency:
+    maximum: 800000
+
+required:
+  - compatible
+  - reg
+  - honeywell,transfer-function
+  - honeywell,pressure-triplet
+
+additionalProperties: false
+
+dependentSchemas:
+  honeywell,pmin-pascal:
+    properties:
+      honeywell,pressure-triplet:
+        const: NA
+  honeywell,pmax-pascal:
+    properties:
+      honeywell,pressure-triplet:
+        const: NA
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pressure@28 {
+            compatible = "honeywell,hsc030pa";
+            reg = <0x28>;
+            honeywell,transfer-function = <0>;
+            honeywell,pressure-triplet = "030PA";
+        };
+    };
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pressure@0 {
+            compatible = "honeywell,hsc030pa";
+            reg = <0>;
+            spi-max-frequency = <800000>;
+            honeywell,transfer-function = <0>;
+            honeywell,pressure-triplet = "NA";
+            honeywell,pmin-pascal = <0>;
+            honeywell,pmax-pascal = <200000>;
+        };
+    };
+...
-- 
2.41.0

