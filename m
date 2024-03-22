Return-Path: <linux-kernel+bounces-111167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C648868A4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39528287CD0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8058720DCC;
	Fri, 22 Mar 2024 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Fo1Q6jTM"
Received: from SG2PR03CU006.outbound.protection.outlook.com (mail-southeastasiaazolkn19010001.outbound.protection.outlook.com [52.103.65.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3951F600;
	Fri, 22 Mar 2024 08:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.65.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711097810; cv=fail; b=HFHAKS4d2wY0zf8Luv1929n3pBQwWTteEMQvI2xz7W0Uwffd3WD889L67HwhQ2mqbJXYPy/D4MyVEwbTrQyy7yjH7865nUkhQLIes+JOo74cWrewh6lfGIFic+OLRUF8unnpok7e+/emH2s22e1degs+pu9YjdwHdAqj9H8jIM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711097810; c=relaxed/simple;
	bh=URATq/qNU4/yzyPVP92o6aHk9wpR2n81ciou8TdQG68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fhEvRkAsIUyOAvc0TJgpOePGPxNOaQeJtlrLrqTFC+RPWALcOt851lyktzOu0y0jAvRSLrogBce1JuuCdAaDb/PcGzAcYed33Eii0T855pqvj1iEtax32ktlUgAg3AhLfXOkq2UWI2Lg4laH+7HkfXhLOMK2lq2N4RArlPuzsG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Fo1Q6jTM; arc=fail smtp.client-ip=52.103.65.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYGXhsRQgXjcGxySlLKRv/2YxNJwdOy4RLvFk+Y2yukykOW7RD9Bkn1Tsswla+2iRsbnf8FsL0RDAG7poS3BVA3XyJ/KCIISVR2sI4Nlp1PYaEn2l/eDyhghSV+IHV6VXpOX80Pw2Cu0awIqSzNIuNFgVEqnQTHtGHwKwQOtziMbE7UPUGu8XTugZANM1WPLNtUz6UT3rhDyTNbji6FLYh3PrQXOOx2OS9TxvaZuCBGtiLqdqvCteRBqPorNSc12QtU/a0PrFG28CB7KbAb65iOtVHcsR+OVKYvL8XM18vBexNdPRtvZtphGiCAQtTGd2rK0N1JC+0P+3eHU2igjpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qGahpjz/KP/iKpGLaa0hS4iNC2njtHxI1QCSKzx7hU=;
 b=nT3yweGIY599OoPaf9yYNlM9sdpGO645Q2+lW0LBsivOdeywxfuErVEbcIHVAchnQtjWr4Y+6MF4h0s4hqQKVDPWmY6nNNn3cc6krodaaleC67Ehl0UyCDE45nR3zAYTQiS/4Y9UJVZ6XOyv0CIT/ElXDcPeFmd+PTWi4KvI6I5/A4HlYTkOmnktlFCLgn6HcubPwvIIJlmVbb6lYun3rTas5Tb+H4B3EryByTeA7EFcR9Yi/oF6EkjfRg3pnsqI0/bWDUaTFkjDpPg/qYk2vkK+HLy7XX5zSMDsbkQgekk9GuWAP5QRJHgzn5/JnwHfDpPng4tehRg/1PQ+yWTjZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qGahpjz/KP/iKpGLaa0hS4iNC2njtHxI1QCSKzx7hU=;
 b=Fo1Q6jTMuqvj4nUjTDf2FlCTe8DQxebfz3l/bNAclpkPmdIPsumZqdMD9g7AehpjvNp/n5qjYQLkWK5t5KumZ25b25URpjV//VyHMnY7slVGdwKZHzKUM4KhDEchdLAtpBVmCy+h0CeShQoGcYcc1cUydhR/97RfX6ufvEpTRpfRe3O+bxhaOv6yAaAEPTk98w+LqVoIQcZ2RlJjo1eqJ0GdElIv8OCaqzR+rWKUUYb2EdUCyb7NYqCuHG+qkiU4DuEm9Vs07trrWBeZeWpQJIvFc2hN4MtsrE7z/RhGPPyDSxgxV0KGPd67yRhRrS5IViNPUKFEZeP0CIYTbvPUIw==
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com (2603:1096:400:31e::8)
 by SEZPR06MB6870.apcprd06.prod.outlook.com (2603:1096:101:19d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.35; Fri, 22 Mar
 2024 08:56:40 +0000
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::d57a:9f0e:1ee7:85bf]) by TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::d57a:9f0e:1ee7:85bf%5]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 08:56:40 +0000
From: Allen_Lin <allencl_lin@hotmail.com>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Allen_Lin <allencl_lin@hotmail.com>
Subject: [PATCH v1 1/4] dt-bindings: input: Add Himax HX83102J touchscreen
Date: Fri, 22 Mar 2024 16:56:03 +0800
Message-ID:
 <TY0PR06MB56116F0902017225C78EDDDD9E312@TY0PR06MB5611.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240322085606.993896-1-allencl_lin@hotmail.com>
References: <20240322085606.993896-1-allencl_lin@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [0NqGaOfYU591HIhNu4vUoX574wbr5sDh]
X-ClientProxiedBy: PS2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:300:59::28) To TY0PR06MB5611.apcprd06.prod.outlook.com
 (2603:1096:400:31e::8)
X-Microsoft-Original-Message-ID:
 <20240322085606.993896-2-allencl_lin@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB5611:EE_|SEZPR06MB6870:EE_
X-MS-Office365-Filtering-Correlation-Id: 65015dab-fa03-4b05-d281-08dc4a4dfd42
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	D81GQcCI8xhtp52GBRjptPFXm+s8qW+8O64/lve1O4H8WxdPODagmSc/NNUJg+L7D3u9l9RNnzH6Vdurdn6824wnDOVuH9bwAf8gkeo8O5G1pp7cleTnsm/zsNZMarGEa5afqRj+119QYV1Mi7X/x4be/ZSq5gLXJpkAPqrxBA29WWTxrVWkJtOPZ7PHNNOoJ5cqA8+rgIqvn+hN2Qy+HdN10FSUqVehFSuEPVTI0D1MBsYEIMPS5LSb2cPWW9JtBJvNOVB5jwvvyzXdI6Vd0/xdlBc2B8blekt73jy1fCrFjxZ1H416fgvD+QQ0MQLVf3YqoV0+1WhDwW1xbfAAkmNpIG4b6biBeUSardaXDAQxd5PalU5cJf36QOzWObnd3htgnDmsgF7YVY1rT+bb0E8QIsqTJs4/qMqZw8CDxJTf2QqHZ3ltc5Bci+C8B2o7hKzXA1i4nEtHbH1V41k5ls+lFFceNpOkC6BNjveMJ78HNN0t51AaA2u72G+rekJ6oJ3w+8Efu/U0nWJS9vA8HayRVlCRk2OW7bLyUmQsog3kKf8rAfyaN2i5jPP9GNIwZhkYN5BUfdX1ZGy8NcQB7D8tUoVrXhl0oBR0uSvd+SGNzuoghr+PmV+t/DQ7WHZJ9qgISvJy36AdouNRzd2FWnZI/5a/A+NPZKksL2jbPPiS516tp4E2BLbVh1hjvH3F
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6PCrRFojavGPJHvENuPLu6bj28WmiWkbg1KBYOmrl7NdjTkGFL2oORGWWiTN?=
 =?us-ascii?Q?cy3dW+nAQ+jpJ/TCPr4l26cax84NMOdKjiSmDbl/AvpvmUWKGW33Rp9+PvKZ?=
 =?us-ascii?Q?TdPdoNDwdFvF2LVG3EJf/OMGbMmMP0fZictYT1Shv99+pGXhMUcDqfmLNqXs?=
 =?us-ascii?Q?KhT5B2bFMmHsQzRyWU6WJf5huC8061q2kaWNuVN+9WROQIsHYZwR0LQviSw8?=
 =?us-ascii?Q?iuGqX8Z2JEmp/JEaLSDMkoh3fl9nNITjBcOGuLiFtCmfmlOl7D2UPtNsaoRy?=
 =?us-ascii?Q?O+Q+yZCSNMH6SwuRbZRfX5TmkMOPknE8DrMnON6GmI+z/Oh6XlApjuNaDJfP?=
 =?us-ascii?Q?KHbU3SCBH3WNtV4iMUEc6umGohIYR4XVA3oY7ByJsk38hBn8Xwg1qdkhZNNV?=
 =?us-ascii?Q?lcqibA3jUIY6HFLf72oBr7H/r2eySE5gpVHtBIGEmv7rk4aemxeOirCsW9q2?=
 =?us-ascii?Q?YPnMKBE5IhVUzwZ+pASFLYiqyNPx7UggYx4ebD/9NtGEkkf2EQFt0rrTobg/?=
 =?us-ascii?Q?jQSDWAs+hznU5cEwvGlo7NPIU2lM355m9Zofo+5YTbJ2A0ceYiQmlRq7ysXC?=
 =?us-ascii?Q?/PI0qU6NYHrEP3Fj1TepywJUKfCBt0ZFQRVdW3pTf69hzzraZFQdcC7KYSK/?=
 =?us-ascii?Q?fEsM89fYyNQkBdKX6vrgng2dtqF6NuUl7wXGBZ1Q82X8yvZ0uUax9uo+Ol7Z?=
 =?us-ascii?Q?FeDVaN4xmbtdsNuKj86qHVzNVm4qCdQJURr0lUQBgJ9Gat6swgKuSll5gh7d?=
 =?us-ascii?Q?/VHFo8JnQYtBo3/LL+5e7S/LiR9cv3ql56MIGGPCPgFwgjD4fps5/SGgYFQP?=
 =?us-ascii?Q?l3mhgGn2Wsth0W+nzzT6cElW7gpiESYk3eGskw1CfZvqwzl6jvPjGiUlDHEM?=
 =?us-ascii?Q?UMuocT01bFHLiIJk73N/AugvtFllaOtl3mlkNYqtRRRCqoujwJ3ODC+JRcth?=
 =?us-ascii?Q?AfCKcTFBY91/AiovBpvhawXJ4TcEOJt2Gpoa24iJlK7BXB+6dKqpeZiBBrV4?=
 =?us-ascii?Q?SPqxLTylByA3cHKTaemI+BMfqfVtmbJUSRLoWGMBPh8+FZitd8CpMe6qBROe?=
 =?us-ascii?Q?TWz6xlkS11GeZNLA1hQ+rW+9ctcEtZvSQzQ2Aw3y0hIul0Tftn5EoLc0sRSN?=
 =?us-ascii?Q?KBmcn9fiNr6oMKHt7xTTu4FLK/liFyxp8slzLJZuEsUF+x2YdtRP5jxgOxJ6?=
 =?us-ascii?Q?4WA8JwVFFPMTVoaAnU96UnOY7jNcvkZUywYQNgFZz/0C9Ur5m4o85mxbYxE?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-f764d.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 65015dab-fa03-4b05-d281-08dc4a4dfd42
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5611.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 08:56:40.3924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6870

Add the HX83102j touchscreen device tree bindings documents.
HX83102j is a Himax TDDI touchscreen controller.
It's power sequence should be bound with a lcm driver, thus it
needs to be a panel follower. Others are the same as normal SPI
touchscreen controller.

Signed-off-by: Allen_Lin <allencl_lin@hotmail.com>
---
 .../input/touchscreen/himax,hx83102j.yaml     | 73 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/himax,hx83102j.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/himax,hx83102j.yaml b/Documentation/devicetree/bindings/input/touchscreen/himax,hx83102j.yaml
new file mode 100644
index 000000000000..6c0a1ebf8d91
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/himax,hx83102j.yaml
@@ -0,0 +1,73 @@
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
+  spi-cpha: true
+
+  spi-cpol: true
+
+  spi-max-frequency: true
+
+  panel: true
+
+  himax,pid:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      PID for HID device, used to load correct firmware.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - reset-gpios
+  - panel
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


