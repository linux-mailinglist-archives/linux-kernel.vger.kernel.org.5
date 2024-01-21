Return-Path: <linux-kernel+bounces-32010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 511F883553D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 11:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80C001C2184C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 10:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2354B36AFB;
	Sun, 21 Jan 2024 10:35:45 +0000 (UTC)
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C64D364D4;
	Sun, 21 Jan 2024 10:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705833344; cv=none; b=esXHtYlEguscYNUELjhUjdS1WqBSWFnuBVVKJM8Ja9VuMdNAtMEFOuLxb7AE2UIZfoGiJyH8phkUHaa1zf29cGmiJN5invjArag3ywrXBxc4JJFhMsj5KmUdvMjM4LZHcBZ0SdjB9du1NEGRCIzvkvxf07qIrdjloaMrB3B2h9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705833344; c=relaxed/simple;
	bh=kdK2yshyC0SfuVTXNi7LpFZV8VApEvpmuSEjTzIpuNo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kb4gA0HiYkl8MH3MKciZaj56aiazGOnPptiIxZRCZU6u3ezIW2MiqcMtTn9/+j7nVxS3LRPX5xXxp5ZCojq2PJRPcFJKJpv+gsC//ilakD73Nq42N1npd2g40C5rwU8VyWeVA9+8gWEsB9t8yJ1wR+Lg0z3ztp+ROFTfGoYNcbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40L3bAc3012166;
	Sun, 21 Jan 2024 05:35:28 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3vr8w7bgwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 21 Jan 2024 05:35:28 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 40LAZQGO059847
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 21 Jan 2024 05:35:26 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sun, 21 Jan 2024 05:35:26 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sun, 21 Jan 2024 05:35:25 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Sun, 21 Jan 2024 05:35:25 -0500
Received: from kim-VirtualBox.ad.analog.com (KPALLER2-L03.ad.analog.com [10.116.242.67])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 40LAZAoe021011;
	Sun, 21 Jan 2024 05:35:20 -0500
From: Kim Seer Paller <kimseer.paller@analog.com>
To: <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski
	<brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Kim
 Seer Paller" <kimseer.paller@analog.com>
Subject: [PATCH 1/2] dt-bindings: gpio: add adg1414
Date: Sun, 21 Jan 2024 18:35:04 +0800
Message-ID: <20240121103505.26475-2-kimseer.paller@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240121103505.26475-1-kimseer.paller@analog.com>
References: <20240121103505.26475-1-kimseer.paller@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: kAOBvFXmOQa-zG3sBzaJ4kPPc1M1i7WJ
X-Proofpoint-ORIG-GUID: kAOBvFXmOQa-zG3sBzaJ4kPPc1M1i7WJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-20_06,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 phishscore=0 clxscore=1015 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401210082

The ADG1414 is a 9.5 Ω RON ±15 V/+12 V/±5 V iCMOS Serially-Controlled
Octal SPST Switches

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 .../bindings/gpio/gpio-adg1414.yaml           | 66 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-adg1414.yaml

diff --git a/Documentation/devicetree/bindings/gpio/gpio-adg1414.yaml b/Documentation/devicetree/bindings/gpio/gpio-adg1414.yaml
new file mode 100644
index 000000000..24a51e79f
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-adg1414.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/gpio-adg1414.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ADG1414 SPST Switch Driver
+
+maintainers:
+  - Kim Seer Paller <kimseer.paller@analog.com>
+
+description:
+  The ADG1414 is a 9.5 Ω RON ±15 V/+12 V/±5 V iCMOS serially-controlled
+  octal SPST switches.
+
+properties:
+  compatible:
+    enum:
+      - adi,adg1414
+
+  reg:
+    maxItems: 1
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    const: 2
+
+  spi-cpha: true
+
+  reset-gpios:
+    description: GPIO specifier that resets the device.
+    maxItems: 1
+
+  '#daisy-chained-devices':
+    description: The number of daisy-chained devices.
+    default: 1
+    minimum: 1
+    maximum: 4
+
+required:
+  - compatible
+  - reg
+  - spi-cpha
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        gpio@0 {
+            compatible = "adi,adg1414";
+            reg = <0>;
+            spi-max-frequency = <1000000>;
+            spi-cpha;
+            reset-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 8d1052fa6..526145e69 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -461,6 +461,12 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/net/ieee802154/adf7242.txt
 F:	drivers/net/ieee802154/adf7242.c
 
+ADG1414 SPST Switch Driver
+M:	Kim Seer Paller <kimseer.paller@analog.com>
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/gpio/gpio-adg1414.yaml
+
 ADM1025 HARDWARE MONITOR DRIVER
 M:	Jean Delvare <jdelvare@suse.com>
 L:	linux-hwmon@vger.kernel.org
-- 
2.34.1


