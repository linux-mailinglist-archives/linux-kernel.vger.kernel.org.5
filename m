Return-Path: <linux-kernel+bounces-146105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2438A60C5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBEB51C209FD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 02:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E23125DE;
	Tue, 16 Apr 2024 02:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="rvu+wAen"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2080.outbound.protection.outlook.com [40.92.53.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5665011720;
	Tue, 16 Apr 2024 02:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713233583; cv=fail; b=jSfzakmVPGLRgXkErlxnNRLjJpSrBO6sTldR0pizUhk6eLHifnotpXCQgNZ4TMFeNT+9dN/NiCQnfh9tdDfF9s3mzS2EITKopK2vg0t48T7Zf4BHb82gepCVAGz2jbT4sq3Zb3I0JhMWz0osG1We+SlNTsB3S5ZPEsgWvwxqQAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713233583; c=relaxed/simple;
	bh=zpNqSVUlrN62Z1uCEHRK8dfLOVwB/3hrtcvMwua510Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hP+kuWjhI2iWxOthE8Su1DRm4kO95/kxlm9efHCVfJClFmAtRuzJVxfH27J1RcvR4BZC0OirNP54KptU8K4dDUkDsMYClITam/Pmqba42U/2ZzW0TkP3LgJ1y+EABYvrnloEURPi58hmicwea/Mj5d52sHYy2kDbW7TvjO/j0HE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=rvu+wAen; arc=fail smtp.client-ip=40.92.53.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qfa8ixKjzb732EAZ0l+2A9zt6TWimIt3Gf0cERPIiE2fIAbwT3LfqOXmQRXdccF3zU4kXoW5AMhjpnYafReRlEf5II/83tq6nsZcBg3kP1OuQNQZEfnRbSB2b9e8mq2tyvs0Pbl8BTaL13Dium5N3m7wz8+3f1ceL2m/DJSJgrB2O8/S7KjydvXW9aTLLG5x2C4zUAYgPrYYv0D4+Ls+uJHos/GAF10cyE3gLQoSlTj9q44utvd2kYnnctqWOGcHzVnAcZtKNwtBS89qVb+gyp9zywwL4NHfJRli7/gqgVrVzHe1oBb6wGhNBHukVHV+eUu7WVNZlUvXpR6Uqw17Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8l6JNomgXx6iLskAvS7xv0kglOAogOZdEre0qmlkQs0=;
 b=SgdmffTak7IEc76kirv5KQCGgmnxmjo9d5C5R/XcEJxY3hRFGtU4bLIVCR3bVZa/PLYTGzX9nRZlvSCkzsAuorrpLMln12BTCpkV7MMhqbUW5gx8MqyMkJ1p+0+L2Pj5Kz6G6h42x/bsZ3kbSmRNiS8vaDuKRKRbfkY1lR0VFujY2CUWdM5o50KfoMXrqHfVQ7nBgcKDRtBJv65gI4Hmg56a8D0vJ+guLFmqvW5csEFKqcVZLjLyWULGB3au44T5iyYZtUWbQ4HAxMGU/Ri/izW4FGsWicANeP14YkYiE5JkZZeakzP/Bko0MJy6mDAXIyIhUiBj2UI97BnQb1lqfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8l6JNomgXx6iLskAvS7xv0kglOAogOZdEre0qmlkQs0=;
 b=rvu+wAenHi6Fq0Ds9RM0lZyZMTD3JJNb1PbGq9PAZF1I42zrQEnFAx783qt6XEOGDANOLVyrstybfmeU23puPJxdQLwhjyl0/nsM4pGyUSIH/EUi0f1oWHqKJMqwoJ6dnQvVoOTwKL6DkOqIscjwN+T173DgHWnvphVVCgMyVhNCfzZCbMancQEsU3yFzDCIFjqcaIcDOFFqVTdcaKbsv18FE3H8ctipscwi823BmWo7RdBAWkxMYICkyt0fK6ZVoVc0Hu5O5uBcLmo385/GUVrd6oBJJ0xDVcj6xGZV/sS9rBLLD3qDtNDvsU8Afef1vo+LXwZoOoZEzA6bSs/06A==
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com (2603:1096:400:31e::8)
 by TYZPR06MB5323.apcprd06.prod.outlook.com (2603:1096:400:1f1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 02:12:56 +0000
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::d57a:9f0e:1ee7:85bf]) by TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::d57a:9f0e:1ee7:85bf%5]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 02:12:55 +0000
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
Subject: [PATCH v3 1/4] dt-bindings: input: Add Himax HX83102J touchscreen
Date: Tue, 16 Apr 2024 10:12:25 +0800
Message-ID:
 <TY0PR06MB56112682F500F8761F76DBA99E082@TY0PR06MB5611.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416021228.1092678-1-allencl_lin@hotmail.com>
References: <20240416021228.1092678-1-allencl_lin@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [xqfrmftdHqajCiJlIdZfpb6gfvHbyhpc]
X-ClientProxiedBy: PS2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:300:2d::14) To TY0PR06MB5611.apcprd06.prod.outlook.com
 (2603:1096:400:31e::8)
X-Microsoft-Original-Message-ID:
 <20240416021228.1092678-2-allencl_lin@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB5611:EE_|TYZPR06MB5323:EE_
X-MS-Office365-Filtering-Correlation-Id: e9478ebe-b7cf-4672-a6a3-08dc5dbaba96
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DYmmPHsHz9aYbL9hEcxiAYZnDSFs5dbUlThxoT5xOQIhLwFu/ubZK+lbQLHQYraum65oVqldRWj4T2+lLK3YdmAvR99fXlJs8QzrZiVX1L627JAAlbyh5z2QY8niDJeEFZwJoWt2/oX0SnkTULrgaYDrK5+Y/aV/4LW3ZPbTbktS5+Vrc61nGT5/Em0eapDZVgl961mZ4KcYCdJ+VwNFHNka1Rpr20LBTsU0gbutdBAiaomGnhciin0q38kkQeD6NMVyTo41E9Dhur1w29fB5YPvRU3j4DwWP1rdmZReCEjvDb0G/EYDmfqvkpMDi/MltoVfGHWCI2OiKDcdg+dNs6J8yjGSSFxHl78WGPKPJkZB26i/gqVvWPEuXpyO0wnkbTOTyxGgeYOvFnOFlzT5Z6MhaKFauj4TF1js6s9bSA+35bIkXU4sqkh1XNiDdPg4iLjEyyGs65jlVg1f6R9/yURwDVEkEBGjD/pfQ++8nmXYSy8WZDf+KYCNKdC5OvVBd6O5QiqTmXClUyxl+5t7NYIemQ7WiGkaW9tuarih5juUygcwmYAPphH/Rv65/uN2s5bbFwRNYJLWq88gg3p0PxazqZDSw30ySvfjpSOKtHlNF2Gh4f139xBBUJiLSPnjU9OsjVU6EGXk6yPFW/141kYzN8qlL8nzc+0b/44ZhjnAS0DgX3pWV/AlPwibay8H
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aI047R7XjmHvjiibiSXENU3YZEzV5a9FT3Gnwn6gG4cCmCiQQuA4WIibvUPP?=
 =?us-ascii?Q?+Wcw0PDPq0bPwKS7km0SY32RLOkCKvTJ45Be8O0VtH0QvxgUJX665X3xkQPA?=
 =?us-ascii?Q?lPBhJb0c+OWYH6asjcfXXdEJqI6rIJ+cm+MOmWxBp0E/kLBVG0iAgF2xJnWQ?=
 =?us-ascii?Q?HxLPkKt8eYK6Fc8ms1yGIEsTmz9YBIwRwM3qCDCVlh9ekdJlBY0uEmx5XThj?=
 =?us-ascii?Q?lgpn4OKZI9FtX+m0nxt1IKfbACOqWRZizq1cg5mpmG0EPiZlD2ERyq3aIIo6?=
 =?us-ascii?Q?HVCujL80i4G9XaR2+FvGPhWM1DNXqp5bUufegD6AALFsHIYNVc3r11c+4W2p?=
 =?us-ascii?Q?+mgUOUpdMKKk4xvsJCFXklq5ojVseSRZuMzmWoYBQk4R0brooboasMF0p7w7?=
 =?us-ascii?Q?EtPh9Lfno6x0nrSvoPDF3Ncj4eN+UObtZYcMKkQ6Q+Gg6jtzRPEk1SqhraHg?=
 =?us-ascii?Q?edjvPe+wLk7FI3yP4rnyyVr+FB+uolhsgw31sHa7cGXt55HA3K+0w1EAtcK6?=
 =?us-ascii?Q?CzOg6iE9Pk2LfYAUC1yOg56Nr75SU/S1SFaWTl1n1xmjiTVy7C+juC9NxJvg?=
 =?us-ascii?Q?oTOj9f85UQcy/U0Us8uhXMQjkSsgMzKBtp/hg4DguYl+XXN9eznJitVH7q6D?=
 =?us-ascii?Q?GwUpfoLRRhE0U3Ii1ghgkqodJjYznxsODVwqKAAwwiHPAaQWCUSpVlQkJvQC?=
 =?us-ascii?Q?Ydx5wi1PuzgDvgBqbv8kSpstmqGM3CPiyYo9Yb3pCLRFC3sxPmPwAWR187SB?=
 =?us-ascii?Q?d/+A+hkujVhZMBGPHkRCaiSFDUqUEsgGZd9nwW/mqnf5/Rjaeqo8iqx3cBqI?=
 =?us-ascii?Q?GjC/KxK4dIiQUtKfgK2LBIfxgI0yw0tmhkcBR+vcd0ZmKMoE63ohXqvcr2sG?=
 =?us-ascii?Q?3ZnTdAhTCBVEi0XWprylAhMlgiRGwiLPwk4NdVLtFi3BRIaodUzkDjRnciwS?=
 =?us-ascii?Q?oLG1t1j7iDMiuEeKXJu1ANfNftH9F81Q3/Aft4yeY3WuR5sdkJhU+gwDjs1t?=
 =?us-ascii?Q?jJ3J2xlu1hPWyZJKob88f1VEXMaD79mfBtSYdIBk2ci5CAgHHBrS9WQwxWUA?=
 =?us-ascii?Q?eoASUP4K8STJxiTsH40Wxl1l55zKC0WbGk+pLVxq1iPdCYZbR6rGO8/REZ9G?=
 =?us-ascii?Q?vy/J5vG3kcB5WNXI9VlQoWwIv959JIiid+zXG9XPeNmUwai5n1YHr/Lq8A9b?=
 =?us-ascii?Q?Ugw+RVag+GnJxtAc+Jn/qfnyEHT8SWyUDRiEYNgRu55VKmB6WCi04cGgXzk8?=
 =?us-ascii?Q?krdwU1jJh9l1snvYrjlg?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3208f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e9478ebe-b7cf-4672-a6a3-08dc5dbaba96
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5611.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 02:12:55.8971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5323

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
index 000000000000..113fa7945c0a
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
\ No newline at end of file
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


