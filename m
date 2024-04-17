Return-Path: <linux-kernel+bounces-148069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2FB8A7D46
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADE391C20F5F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A0E70CC8;
	Wed, 17 Apr 2024 07:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="aIPzmDpp"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2053.outbound.protection.outlook.com [40.92.53.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550E86F065;
	Wed, 17 Apr 2024 07:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713339720; cv=fail; b=d2NnLQW6JUUyb/IPsITbyrfcz5qvKI8fnjfxxFu/UOAKze78IMrb/12g3CUz2sYSt3Q2YgGfjKXv7AX5Dxa/YUDQ9yVOA9fbflSeXLmN+zU6hU8FFWAxWzF1YTyV/0sX6Hk/J09wDQsE3Fre6FPI9SxQkz1tjP+T9G3KaRLPMZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713339720; c=relaxed/simple;
	bh=J6l2LySsQqAMCxxbQvpnK3TGFbNMDG4DjEwBHMkXTE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J8nE3/Uvotz/rkHeR0qxzVOD3H/H1y37+Q2qHw83UPmKSf+TVRemliGFsSmqCH+TpySOlmHVJgWTs1yQ4J3G8GcNe8OgDISYgVZguVELGUoPvh7QkawYyw5+oRMAAqFndwlh0qrFKcaW51tQSiswPfwM1qE7ncD7GQZ1raML+WQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=aIPzmDpp; arc=fail smtp.client-ip=40.92.53.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWDROn+dUtomnS0d4wskcO2MK9niqnBHPpLhEh8njlpB/OLwg02mTCtWPNcbTA8UKZ+4tyLKYCKpJaGT8wlJ3j4m38Ej0IqhccXlA0qBTaZ9JuRao/4l9NBkmQ08xslaPjB1wy2+x3Ks/GbW/QdSXGV/aF25BHMAxlztL7Lm+sl7np+SwghvgswtI38JOxIrj9LWNh9otlyBOfrdMD/NgwL2fTR3a8VpCfdbj5O8mC4h4UnZ+q345tV6MoixFYkLVf5o434687h+VHNlmR8Ie8Ka15Xh0Rad6lZG6SYcyqh4mM7hilAD3P1whivsnW3I7tTaMiurdTUWBDYEcpbuSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQZQBs31cFq1VLj5v8mgy4X3n6uPty4O8u39FP5Or/I=;
 b=C21UTh+i7P0sXW6TDBO3645hIehvrlB3sKCsH1BU7uKSjNDrBjcvIRJmVj/UEWhDtGIT0D0QTSmKyV96IiYrz4wxKsO494rTAGg+lkeOTt/oW6a6cenHaqaxLBMdNSa7kxVnqhOh84egqKm6w9SqKaFN+QRpcXqVUuZCH2D4aDxNjjn/nzcFPE4FXMUekKLw0xAP5zvTohsEBdNbkBr866S33I2S/jSjp1l37rn3P1iRYiSI9CYgdBRbjQ6Z1l18mP2BiIv8mDkhFqB1MnVPbsiMhGw5w+1g/Y8YtM4uhRGoYoguv8ygGzlEFoJmi6x9CV5xM2SPO5vLqpU98vM4tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQZQBs31cFq1VLj5v8mgy4X3n6uPty4O8u39FP5Or/I=;
 b=aIPzmDppHHMT4f9yXDkihF6KxWZAK1SE4jnqIcSi1gGMpLOJb9slRW6rNSCSlLIyTmBJpz2XbsDeFcsq98iZkwypYBYjJB5AcZ7zczLfgxzbaoK5gOyLKbyv/D1E9pc7xtyYgJ2RyIBS2mxWt8P1neahQpktiJIwpUq+veqE6tGwh8S6y8L9qErtLuOZsjxEBfBgohMfHn9vXxA3ru8IHgXnDASett9njVQFmD8xwz6tNTuHFnc4xeU2vLVmpUL74zYwuDX9vQpj47bsT+AyiT1mXdW3DY7qo6tdEDOHnL8AQdGfxen+BNxW7e8Qn5Qyqo0fJjvv6iQSTnWen5/c4Q==
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com (2603:1096:400:31e::8)
 by SEZPR06MB7228.apcprd06.prod.outlook.com (2603:1096:101:229::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 17 Apr
 2024 07:41:53 +0000
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::d57a:9f0e:1ee7:85bf]) by TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::d57a:9f0e:1ee7:85bf%5]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 07:41:53 +0000
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
Subject: [PATCH v4 1/4] dt-bindings: input: Add Himax HX83102J touchscreen
Date: Wed, 17 Apr 2024 15:41:12 +0800
Message-ID:
 <TY0PR06MB5611B4E88D79DE738241F5639E0F2@TY0PR06MB5611.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240417074115.1137885-1-allencl_lin@hotmail.com>
References: <20240417074115.1137885-1-allencl_lin@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [IWK61BoEzNO4l40pgofjSdfN7jDdhNFx]
X-ClientProxiedBy: PU1PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:803:15::28) To TY0PR06MB5611.apcprd06.prod.outlook.com
 (2603:1096:400:31e::8)
X-Microsoft-Original-Message-ID:
 <20240417074115.1137885-2-allencl_lin@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB5611:EE_|SEZPR06MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: b8e67a79-98a6-49a5-2082-08dc5eb1d96d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sgHdTFYRWQmzUzOcrGn3rE6FIvDHa22FzMPl0upwdgt1ZxZbN+jtu9LOzm7AJ2zalW2Qa4veXeVvlHIgxCImGNaj8w7CRDtJ3drajsQdZyM40Ch8DXpqbKxxXOFznMAupKgIKOd/+1AEIXxgQUpzfzK1OwjZTPRqpGo1buNp0ZsdGfd0iyPbYypzrhmbUKVwh+ZusMw5VbZxpYb6cMbczZ90tjwWDQpSK5EVn1tdKyycGy+6sElwnPTSmCWadlV83pJ6yFFKufYWGVdjUjT5+5Z5XEEJcDLusHvsMJo/vrcK6DQ1DM/CeVcdaMYiEaW5vK0Mc+bj2NeyEUe7wPAQkvEnllAgzP32tTz/F9yuwvAhncMLgBImAsompJaOmM4buoNa0Jx7WRPYg4+cjEsEzMV+2H8kc8IBbx7zJjRCJm9bXRtCvqYCZ67KgDOX78or4V06wr59AqJd3xA9UuKWMG4XqtScnRrN2L2Rce7DxnuHcN70dDFptOgIlCXDC0HID6pcpASy+PXZlH92yo1mVuIvXQgr+i/yaDc3bm3VIjUfx8HIyXCiXbOTep9QGA0+E/J3/FQaVi8xASgvZ2IZGS8tRmA2lvS8K4ase9/yQttarcDdlZnHF5X7r2CkY3/u2C8UsFPg8Z8GEj1u9qoP+FBGIgt1kl3tJyxF37aKsGnueYDCfmoy3tcA5KtNAR8Ps8WjN2sA+71b7Wwtnz6qPQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f+PT6lua/0qElAGZInRnewI5G1hY3xkE11RnSXTyGON45VMYXMsvHpfO5KZK?=
 =?us-ascii?Q?1cW6yBqP6NQKwmpDLp3fIhEWM1oyFEX2EAQMrv7SRrJtn8nJ8xJXSUz3SV93?=
 =?us-ascii?Q?TZ7rPDV2YPn1Xb1WUabD/G4EMSkTCGvueOs/N9dtu9OBXAak8/MkWi6Bj47a?=
 =?us-ascii?Q?X3oojHRFn8ZQIR5q5piJRLEBc9Kqu8SAxfi3fY0lEHC/CSmWLgoJQjBCT6fx?=
 =?us-ascii?Q?CVxEB/D5ZHWtQWuXObdMzfCFcAXppZ9hKRSGPmEArHxuW5/nV0YsHboVxeBZ?=
 =?us-ascii?Q?waAJcJOl8nS9HoeKP8X4JR21F7ONHJ2aZJGHXk2JygNEpJJ6jznJB9pvsWSX?=
 =?us-ascii?Q?olqznMQDzjtivau74AlbB6DslaEcQ+/16G0ymSPoegKi0iExjhmROgtif0BW?=
 =?us-ascii?Q?Bir2iO5wCsxv9tbrnRTqda8rgen17n6dzW3b0lLkLjg74x0+KHhjNCSZCsxF?=
 =?us-ascii?Q?xTsb7DhLe1eM96sKzMpM/mAlyyXZmzpXHShncV5Je51AXx5WF0LdwLmnkj7/?=
 =?us-ascii?Q?fhawHswdymc40G0BYftdiuKW3RetyWEBW7Z6MXo84jDtEuuRMR4zuTL1Iiao?=
 =?us-ascii?Q?9Mh33gOmNzgTWIlxX3gcftHaHVLhEZIIOcS1WKgfnB5hXGQXVoWXvgD2Ig4Y?=
 =?us-ascii?Q?p53Do05Z/clNpQdCbeVQkr2pa4VR8xD53Dd+73NqeW2i8N5TRDLVQCZPRGbD?=
 =?us-ascii?Q?1tSVaKxzqOPldqF/KqwQeKw8l8Vm6zURMdfOqOIoCxNSoZ8M0OuY1CqjDoIz?=
 =?us-ascii?Q?9XT0+Hbl0NmkffasgZQHipzeXo/HCBqkt6oZibA22GVS3rSVRV+b1dPHe0Mu?=
 =?us-ascii?Q?J4XBuQ8R6cNhqxX8Z8lJjm8162lnU++rhaWceewsnX58zXMusaq8iJUV/rGE?=
 =?us-ascii?Q?ronZJyOLipGo8AQ1tw/ktTh1HkcClBsIdemUqgy3ajQZFEY1wigQna07dj4R?=
 =?us-ascii?Q?At03A2Ir9RpSKqs3nhlPdBc4uc63sNNMS7qCrUEn5aSP/Nz0bvU8rAKiAVQm?=
 =?us-ascii?Q?Gc9NQQrsuEahbecJc3UV6CPrv4ZmrrgEFYmlc/s5zIyswXyXfc3y41dm0/iI?=
 =?us-ascii?Q?ZCXp4itc9yKfSm+5YLTH69B1lhzp8mpmkB2Isjxz304PTxfXWhrO8Li8KKBk?=
 =?us-ascii?Q?12EnRJ7sCkj8WWVm5qkyIkYAW2uSJFtIFSXx0wtCqgItx6dZdzAf27OZROLw?=
 =?us-ascii?Q?gkLsqBPQQFmh/OHhbjf+KGA1JHn1/IMjhRVMYgD296T6JVhPSfH6r8U7Rq8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3208f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b8e67a79-98a6-49a5-2082-08dc5eb1d96d
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5611.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 07:41:53.4493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7228

Add the HX83102j touchscreen device tree bindings documents.
HX83102j is a Himax TDDI touchscreen controller.
It's power sequence should be bound with a lcm driver, thus it
needs to be a panel follower. Others are the same as normal SPI
touchscreen controller.

Reviewed-by: Rob Herring <robh@kernel.org>

Signed-off-by: Allen_Lin <allencl_lin@hotmail.com>
---
 .../input/touchscreen/himax,hx83102j.yaml     | 93 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 99 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/himax,hx83102j.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/himax,hx83102j.yaml b/Documentation/devicetree/bindings/input/touchscreen/himax,hx83102j.yaml
new file mode 100644
index 000000000000..d16fba2ef5f9
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/himax,hx83102j.yaml
@@ -0,0 +1,93 @@
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
+    description: A phandle for the regulator supplying IO power.
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
+  firmware-name:
+    description: Specify the file name for firmware loading.
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
index 43b39956694a..bb7b363cb2ed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9669,6 +9669,12 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/misc/hisi_hikey_usb.c
 
+HIMAX HID TOUCHSCREEN
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


