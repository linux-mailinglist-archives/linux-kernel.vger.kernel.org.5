Return-Path: <linux-kernel+bounces-127777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 582528950D1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AC04285411
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0756A63CAC;
	Tue,  2 Apr 2024 10:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="umlzAGxE"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2074.outbound.protection.outlook.com [40.92.107.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0446605B6;
	Tue,  2 Apr 2024 10:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055009; cv=fail; b=RrBBhbNk4bn9mDo09R8kOwZo/ZILFnVYd8uzlIwHSDg7pW8N+fUKC1zNVOjLXy9E+fvAuWRJUzZA6KnlkKN+dPabnc6Of2oiaCBj2IMTamxGwuDfQwcRscxN4ZbcPKAdRbSgyQ1YAg/XeVUpGiWPMJYm4XltO81TC+Rbt9m+f+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055009; c=relaxed/simple;
	bh=jCTMoJQjnbuB2X3DycG5cnYK3Hme4YNYsdrxf3XDJ/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PYyBDDzKVSHj2zvPEv+6y/fpgaE1Cgv3j7rDlXhmFYjkz0sbClcQBLSaIVx8x/Xsyc76+JKmIkfH9eCUGtH6BIrmBBEyiYsdzdBDdnchPbyZkzWrROcSyIeopkzeMmG8rOyC2v+NEDHGLBdDNOJ/EJA9nBwY0u3rFxu79PFms1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=umlzAGxE; arc=fail smtp.client-ip=40.92.107.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LG5WZdNZ2LWimLHDmnECnt5zzJm9ALdzocomTcrgPzql17CAgoekKipyFM6zEH4CoRpgsDdERkL3OdPkM0kHt0Z6VCPVUDPJXRLBd5jKoq1Oymym7xsbuAR+Oq2BmwrMGaeWlKIclIIFcSe5PXntsFQaJ96oBHJaMQlGo5bxJvo9PmmecI7h5ZRndWDpedkrx96aVbL8DQtdrKsWo79AxFWlahHQ672u15ubsBFAg/jR9O5TipvkRC1bOkhVa/u+dMW2pYphjsUhxF0bbUK5Q8KbEDV5RzbTEcQ4cJQkOb9kX9tZeQDUKhZbMe/Tgi3vULQG9uqy4zjuLOLvny/TKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAJ/Bo+VRExAfvHYPdxG54EZGxUNoZ5ZWBsdzxxhroQ=;
 b=beTOPBjFDttjXDeY/wqrcokqnvFnohhrBa87ROJw9FteI+Tl1gY2L2AooRQnSihiiTGKEivDa5KtLymBU4mbU1k/Nv4ei0W6r1g5Ee0Lh6BXhkyL/gQJUnK0fyUa90JCrpBhL5x9QjXs6b0DVqLGlwqu0CMHvOo5nqiYk6L+KTvIo4HhB9aDVKfHCbbW54ehSOtHIsiZX18Gc52agS8/BgGGzO0fiGr/a8kDXfYpAodC8C5QlPR2NIM6LaDfrDPJp0plUX4H+Bt3YNskaMEFNRieK+Q7xssuXBIrJAFnA/YZBbj9V7/S6JV3BWleLljw5NSiRJsN6qBZIjbHmVlsrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAJ/Bo+VRExAfvHYPdxG54EZGxUNoZ5ZWBsdzxxhroQ=;
 b=umlzAGxEpIhFOoQ5MIvqEAVf+NqXYQr6jxcIK09GQXfxIB0abyfM18AYKZWuK1PldMPelzW/3jZZ5uahlk8zivAr3ugSffObaYdEdUj1PP1pR4DeMYQoyjwH1oqqC9heZ7cuaUHNIa5192D0UnrTC5ZkMOubO/dA5hu+YG9pF2myng3rLzloxpBoJuCXlu7SuSVeq8cT+tdYHbRBcukECSbWHYfw4MZJplB9mnJx0PYLT4KKwFyFdS6aeyJ33NWS7MWE7MlD43rX2iibVcKSXRxrbei+F2qEIGdXK9M9Cs5lKqVuU8F83Fj4jNKt858lxLdE7XsGAsAbAe7i0HnR6Q==
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com (2603:1096:400:31e::8)
 by KL1PR06MB6964.apcprd06.prod.outlook.com (2603:1096:820:121::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 10:50:04 +0000
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::d57a:9f0e:1ee7:85bf]) by TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::d57a:9f0e:1ee7:85bf%5]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 10:50:04 +0000
From: Allen_Lin <allencl_lin@hotmail.com>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor@kernel.org,
	jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Allen_Lin <allencl_lin@hotmail.com>
Subject: [PATCH v2 1/4] dt-bindings: input: Add Himax HX83102J touchscreen
Date: Tue,  2 Apr 2024 18:49:27 +0800
Message-ID:
 <TY0PR06MB5611C37640AA40B2B7716ABE9E3E2@TY0PR06MB5611.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240402104930.1053016-1-allencl_lin@hotmail.com>
References: <20240402104930.1053016-1-allencl_lin@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [Qxv13yMcFL/mP+t9E2SGz3lG5huSO6Vf]
X-ClientProxiedBy: PS2PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:300:59::19) To TY0PR06MB5611.apcprd06.prod.outlook.com
 (2603:1096:400:31e::8)
X-Microsoft-Original-Message-ID:
 <20240402104930.1053016-2-allencl_lin@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB5611:EE_|KL1PR06MB6964:EE_
X-MS-Office365-Filtering-Correlation-Id: f83b2aff-e932-4cdf-479a-08dc5302a736
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Tbk36P0Jsgmf0CwojoyiRpEyUD0SyA/zDbsmkOHNd6lozfgikdXX/nz/g6zQaFx9mAU8C9hr+k2xVjyzWbsXz3gOnYD6YLV9wksSZUkWJnjaUTSQ4+S2yvnokDSKGRPbhbrGdieCjkB0y3iM9yx5D9FjIP7FaKmPM/7jZjV0y1pfynNR7rgEt0e1Qg9luTN2jPRMjlG8zB8kiQEJm2Rt31k/jYqDKiF0NUxpB8o538oJxk2Y15ICVbNAptdPc3btOMAmnI4Hi0uKo/NleA3pRQR/O5GrFhDV9jFmjRXTVEBYA3feASxwB0m6c7h5AeyUcFCG4HxbPHueIYrug+bxHh+SL4vMfRrBHaTAtOCUF0stbbjQ0Ak2ihm7IvcnXih60sXtWojjLut+9+ICYgFEpI8n48yn7JLRq27Dihk6ZeYQ7e2qkjn2lTQ7MzYaaOpK4zQZQauwv4mHZ8LCvQkOxzW/yY5pNtPM8w6mNLadMMYZrxjLMYbj/MsTEDZ7R4EmhoGXqpm0fDGhoBr1kLrJ4vKSS445cbbRMJjhoL85EtQgVyqEpVdTbAUnkDjyQs1MDM6ZsAn31WD08aA6St6e1li+0vvzX0Rl59yv9zW7lkVpo65iboseeNIbbtV4TqOWQjdVqq1sat8rptMVq15rna7V88vH/M0MVYpFuQeLdL7Zqo3lkhvPB6JVkfkG31Xz
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qQJoUNKIuIPsafIZJF1eUTfqXASowBAoPxftF/F5CrHMluLDDA4gKBg7PMi6?=
 =?us-ascii?Q?vSma7WwHApdd1ZemTZWqnFipYiaZ+5cIYLtA550fpTxfL5o0ZQDhEIdRUQkx?=
 =?us-ascii?Q?TKobYxRAkfISzNicVWFJSLPTC+Vj3kfbEA3T0Jrhh8VbZSAcHg2fuC0d8hkN?=
 =?us-ascii?Q?oQi/4HTb5gpR7ThYd4xSqb8EH4Kpj5oUVGI8Sfs0vkC/0oeL6B69xgW/BDNy?=
 =?us-ascii?Q?POlfzjAtDIpBvpSgS9EZVXS+tXG2ba0n2CRkCZ/v/1B74SAtNsi253qu2Nqo?=
 =?us-ascii?Q?9r/tqqqZ66hR13xz61CVNqEVN2tJ6Uh8wcnSRnkQEfptT6cqkVGeIictuAyg?=
 =?us-ascii?Q?qvgW+0mdUy7Nzwoi9Su6sOurG3/3yT5csolyFdqVEe1nxUQG0PpK3/WPxSLr?=
 =?us-ascii?Q?/nIVHJCbZnujpOP/YEbXPTL3TmGmIzh5vSiYEgjI9JYZELdUYYT9I+vm0QVY?=
 =?us-ascii?Q?FE/H3nRT2tK5k+MGT2q/1WMFN9b1Wd7UQyinnijs1fa66fJ2p0eGxzAu4Mdt?=
 =?us-ascii?Q?vvB0SN9QWr5y9qgDR9KNeidMWhDN0QqLLlUst8jdvdQqhwWpVSTt2GKU8VXU?=
 =?us-ascii?Q?cKcpNi4xnkYOuMQQlq/aTeMd7pIO2bHD/oOnh7AXsgnjNNWDRpVc70QK9Zob?=
 =?us-ascii?Q?r2/M9miCMMEcyMw3f661ZrY8Q1CCPZNGtIIBEoPxfsfKMg6UQokq9ZIQllxf?=
 =?us-ascii?Q?HH152Bc1kgna7LjW4s3OAdNG+5uOIYJN+mL1tWxV9tSIxaK6iWPPhGK6LjkS?=
 =?us-ascii?Q?Tll9EoULku0q3qc9B1TdrPLd0N74vSkHtAOwuis5kmL6OYHMdzFyHPxym9nP?=
 =?us-ascii?Q?ELKzXaD3IvhSpDkHpiFCztjmz/ayfnLe27nK92F13tzgMuibkfymFNDqL5Mp?=
 =?us-ascii?Q?J3g9X6MyzZlRdKhVe9KpKY9NO31uz+I9JNbiCyFKOOSsn1HDpPbXrIaBfcSA?=
 =?us-ascii?Q?/qkhj/Pp/SCTVeRtvTuI3AjJ66Lq6vJ64eGHtTkl6DPzjCQbFyXkE7x9j/Q0?=
 =?us-ascii?Q?COVWhxPRTes3FdvF3esi3xTWPM7OFZoJIWJh13jg+9woIo5RbqJNEXU5bcLu?=
 =?us-ascii?Q?Tq/tUGHn9BrTfEmNvEkinBLT2bsua33ddSuyoXmQxQvx6ddVn016/OigKZOY?=
 =?us-ascii?Q?OkbLX2eLcr34S7DhAhyU0TEvSHCOr7YjmYYpp7gEhF7MzaJaUDO8jeWcgRTZ?=
 =?us-ascii?Q?zcRBqFTmJ7t/3tqnABZqApGchGULw9vhccwMJ6czEsokieyDyFFAcRNzu6c?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3208f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f83b2aff-e932-4cdf-479a-08dc5302a736
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5611.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 10:50:04.3251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6964

Add the HX83102j touchscreen device tree bindings documents.
HX83102j is a Himax TDDI touchscreen controller.
It's power sequence should be bound with a lcm driver, thus it
needs to be a panel follower. Others are the same as normal SPI
touchscreen controller.

Signed-off-by: Allen_Lin <allencl_lin@hotmail.com>
---
 .../input/touchscreen/himax,hx83102j.yaml     | 100 ++++++++++++++++++
 MAINTAINERS                                   |   6 ++
 2 files changed, 106 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/himax,hx83102j.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/himax,hx83102j.yaml b/Documentation/devicetree/bindings/input/touchscreen/himax,hx83102j.yaml
new file mode 100644
index 000000000000..fe79129f704a
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/himax,hx83102j.yaml
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/himax,hx83102j.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Himax hx83102j touchscreen
+
+maintainers:
+  - Allen Lin <allencl_lin@hotmail.com>
+
+description:
+  This Himax hx83102j touchscreen uses the spi protocol.
+
+allOf:
+  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: himax,hx83102j
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  vccd-supply:
+    description: A phandle for the regualtor supplying IO power.
+ 
+  vsn-supply:
+    description: Negative supply regulator.
+ 
+  vsp-supply:
+    description: Positive supply regulator.
+
+  ddreset-gpios:
+    description: A phandle of gpio for display reset controlled by the LCD driver.
+      This is the master reset, if this reset is triggered, the TP reset will 
+      also be triggered.
+  
+  spi-cpha: true
+
+  spi-cpol: true
+
+  spi-max-frequency: true
+
+  panel: true
+
+  himax,firmware-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Specify the file name for firmware loading.
+
+  himax,pid:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      PID for HID device, used to validate firmware.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - reset-gpios
+  - panel
+  - vccd-supply
+  - vsn-supply
+  - vsp-supply
+  - ddreset-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      ap_ts: touchscreen@0 {
+        compatible = "himax,hx83102j";
+        reg = <0>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&touch_int0 &touch_reset>;
+        reset-gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
+        spi-cpha;
+        spi-cpol;
+        interrupt-parent = <&gpio1>;
+        interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
+        panel = <&panel>;
+        vccd-supply = <&regulator>;
+        vsn-supply = <&regulator>;
+        vsp-supply = <&regulator>;
+        ddreset-gpios = <&gpio1>;
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 43b39956694a..aa51c60fd66d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9669,6 +9669,12 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/misc/hisi_hikey_usb.c
 
+HIMAX HID HX83102J TOUCHSCREEN
+M:	Allen Lin <allencl_lin@hotmail.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/input/touchscreen/himax,hx83102j.yaml
+
 HIMAX HX83112B TOUCHSCREEN SUPPORT
 M:	Job Noorman <job@noorman.info>
 L:	linux-input@vger.kernel.org
-- 
2.34.1


