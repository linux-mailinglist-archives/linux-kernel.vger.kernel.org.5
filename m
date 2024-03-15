Return-Path: <linux-kernel+bounces-104109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCDE87C910
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E05AFB2300D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 07:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBDA175A7;
	Fri, 15 Mar 2024 07:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UX6Vxm4h"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2042.outbound.protection.outlook.com [40.107.7.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51CB1799D;
	Fri, 15 Mar 2024 07:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710487504; cv=fail; b=T5sHkBxz5gJHWGABBSmmnxlnkx+BNVGRCs6R3/i6yutiWHUumueG6C2Zy1/9XyvCyolJKfH/tYwqSL3GUjZImhYG/g5c3tvD7nghW78+n/oJHHTGWT9965jc6pXZKggzTbSwqEnqv3EIPNtb3HUNuO5ipt0GXGqSsnJfZZDgjBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710487504; c=relaxed/simple;
	bh=4SWITo8f2BB9DLCj1Zk5rHwYy86FLJLNh0Re29dYsU0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bq5K/grdozOZNDpxJ/N5P/FPUX6Yvm+T5/E5gKFaVqIsLjq4UDeMMMKQI0A1Xgli2Dd4Dkw0hLQOqwPqhSksa4j9UkK3Hle4l09X1mTk8L8BABRuOullC0OhuOJiQ15bkm8e2jboUjViFE2IYGWs7xazWaYE/vg23o3+DmQoEyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UX6Vxm4h; arc=fail smtp.client-ip=40.107.7.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfjra5wQyEKDWoG4FEoMgBiAf+t07mUxDPcB4K6yHSkRwTtDRHKgM+/9XLhqYgUq0Q1JiBeb66SG8eNJA4A6+1dLss7dGmn6C40HL7BQx7EW5vwTxX+LamfyRe9tmTFCqKpinWP+5cuPBsLWwi+BZAt7j2B4FHAYg7h9P6cOvkjV3xq8NAnEB8udPznv81a9sH1zqJU3yjX2qDZb+XH3v3nc3im45KO3H/SJRlmKhekG7+UNxtQgaa6IKyu+rxapYUK1WAl8TyxMCTkjzsgGkZz5MO6EL9Jfyv22XCIHyE6DB8KAH51PUQlwUee4dQTKNsx2QIDOdLAxOjQbrmTvXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3vxszd3lkNqhYLQRSssvaWLbwZdWh/uS5AJNaIv+UI=;
 b=OWMWWfOSgqsqqLnsXAqZtyihTrhFGT0j3//DQz9orKFK75MRe88OeucngC2mD41gyHsI4dRQcbqwwHIq9pBdiX5oY6aj+37rxWP0JgBEGLSy7o3BWHINdnKC5/sVJBCCqukeXdh7cPc3pBp62K0Hnr6tbk64EHi7pgFOdcj2FdoE/WJZ4xeTOdKFLcEsRCp+SN45VNE6+xA8p4ED0Ty12iMkT+mj8+HSGkkGJFtKxKHoCNZ80L/l0CouvWVcWdsbYgFbSnOjkiKRB/4FNeqtEqUk0E5ziJa39lpHC4dHxxTbr/NdSctfQV8rpf/49L8R8dxhsAaoOFNZDEVzJlqnfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3vxszd3lkNqhYLQRSssvaWLbwZdWh/uS5AJNaIv+UI=;
 b=UX6Vxm4hA7TwST9SQnJ7K7gWJLn/idE9hpe4sSBkHKMNB5vzZYz9KT1E73K6X2UG92W37QdWnWBYbUNEiEefGnn9sxmSHABKFk6b5iDbctM7Dl1VNIpSNsMKru2oFcjVH6K4vfcUf+CnK1kIC6ohjyhYKkb9aCqq5txwT8AZ7G0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DB9PR04MB8332.eurprd04.prod.outlook.com (2603:10a6:10:24f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 15 Mar
 2024 07:24:58 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7386.021; Fri, 15 Mar 2024
 07:24:58 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: gregkh@linuxfoundation.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	shawnguo@kernel.org,
	conor+dt@kernel.org
Cc: s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	peter.chen@kernel.org,
	xu.yang_2@nxp.com,
	jun.li@nxp.com,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 04/11] dt-bindings: usb: chipidea,usb2-imx: move imx parts to dedicated schema
Date: Fri, 15 Mar 2024 15:24:48 +0800
Message-Id: <20240315072455.2481613-4-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240315072455.2481613-1-xu.yang_2@nxp.com>
References: <20240315072455.2481613-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0043.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::12)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DB9PR04MB8332:EE_
X-MS-Office365-Filtering-Correlation-Id: 02621a41-a6e8-4aec-4470-08dc44c104cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mUMEfdLL5reLjr6cELBP2DxJW27l2B9MsHjO+ZPLwom6d0aBHHQNjqabkGJkpDJuiOxtgWDnKruUGf5DaESj11u8DzSLOf2j2BGT8+yPyE+M0+ub8WL/xPF3cOUmqjYuH8H8tMNsgVbh0RIik/TXDF2E64WoBn9lnePTwSWjrrOV8qHBTXZjYJjgxo4Yrcjr0A71mrLCki2Hb+Zptba3OLjjm0wnA2vqj+HiZzdDNuXuPjTt8bilbF2EcyaJ2jjqJuEULo+JVeUog12D23u+SB3PR+ZbG0MOm4BFlEsohezRBFLPKORgJKQQh9Lhi/zxjgHocK/mumMg7/Dpg1eGNlXNXfhQSfjlCh84nrKMzjcVezfQyKpJo8wBa+yIwJFZzHmkizskiXOKnQmmbyNSBqz+F42LuA8c6NMffbSYvLfd2Az8NB1Iw1jouTh3A7wyu6nm44KMHom+fDo60gt8WHto1hiPk3FFJRkUVqdzoGpVJhmnJN8IaUxw3tJCIjpB22qRXlTE4SvrLGChp/vQJZ+2noXmDnECQZGutFJ9dshaVs/czBEmGIw4y4dyZRBcywlJ5xr74vqHbGn87hVeWiJmTodHykoT+sxz4tlzTo7txUtMOlpt1DClknTgGocYdkUkSUOARTOsRNvrydZ12647z6Sj+NVopU5NQEPgdXo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0Ya0L/mjG0g830hbeYe8+oGaGSIOQj6t+tMoECIuQ8HtQc0XV1vW5RITx9Q8?=
 =?us-ascii?Q?T5UAR5YzPXu/tGa3h/AaqA8dBy0qC2e9CkpWaD7XtWdHzPMkr9aV0iechiOU?=
 =?us-ascii?Q?1/76/scI/LEWNTNZiXQtId/QF1XIQbvh8lEwKNGJfrtbxob298HkWVZ0WsZW?=
 =?us-ascii?Q?7olafvjSkDxbdm7/595wMnpnJWEtU5SuFgqZ2gSIpu+i1iX4P3F0eaHwt1Tf?=
 =?us-ascii?Q?+hDv9KO4tkMxFHArP1ye6a79uLFmXd+cJQLg7GKPls3bjse8GEBGCRVMJhbA?=
 =?us-ascii?Q?gWGv0sJSzOkDTT2iqZPjoDxxH5ZvfHwVXz9Mv9RurBgldrdPXcRMzwAHmgpm?=
 =?us-ascii?Q?l2dRXnP8lfbz1EjttBQJmsJ8R6xCU3ST7lFmwIK+hEx74hLowk9/KrgDk5uT?=
 =?us-ascii?Q?1LmExWm3WPtBXfmkySQbTrpl+CmdIITpboUrmDD3Dl6HcjXf2w95oNXi9ytS?=
 =?us-ascii?Q?vFn3OuFBm643h74Nr4z7Nla0HuXLQx6SCxzmz6/tJaUSOlnZLVdosqIK9g/8?=
 =?us-ascii?Q?dlrb0RrmEyJY4nKSayb2lRloVk3Lk0KrpSL/f3ghafSGZzCwY1rxRZXgEWJq?=
 =?us-ascii?Q?kFi1lQFp+M4Nf17NPqmh7gQ6Wy5N5DcGkHaozCrBTKTuFh6YwMU/GaEHB/JW?=
 =?us-ascii?Q?xfEXeTnDuWQp+A7ZOLgmnIYmMZoyzBikov4K9niW6PtJ7s618arVfsomCtzB?=
 =?us-ascii?Q?KYZLtKYtHmy5cwTCsugiU5Or45Bp+LVoKyF/zgm5YikOtN71s1EYVxxOYry6?=
 =?us-ascii?Q?gYVLcZzmddtlUzXxl8NexzJo+v6Go4JlD+movilXbb8mbVgea/og9QXLDOEf?=
 =?us-ascii?Q?e/tZr/JOBINiTT47hUpz7NqfeLBxHp+EuvOMMpwni/FEoQ9Y62It3XjgpAL4?=
 =?us-ascii?Q?SJgB3qubka0PlMWxglOEfZ/8y79noxWlsnQvZi5BNjqRWY2Vw116x0vxbexW?=
 =?us-ascii?Q?42wnvsSgjfIdo9n9P6cRMqp3Sufh9l3SOb8nWk3hUebUWJRg8/y19tMLEHwY?=
 =?us-ascii?Q?NkjuFPqhz/D9/PqkCayUNQhFaMHT7sQnE7uXCcUf2nMGR2M6UWKNCRwq8Qmm?=
 =?us-ascii?Q?26CCvCukzIY5s3wM7QIfjMapogwhc1uEVKmporuTG9X8CO5q9gDUBFxh3s8A?=
 =?us-ascii?Q?T8f5auqruStMMXcEhzjQlcOZEy2Ee8pm3jCtbG+Ym3wUrVbTsqv17I4/taMH?=
 =?us-ascii?Q?ndWwpBZuETPrips1L1I16SsU9TKj4i9pb2TnrzRa4VhfH9wo1w5fU1Y/cyTb?=
 =?us-ascii?Q?IX45VBwapGjjKam9/mbZsP9dVEyNXVmSVFSmN3+J83yqhy6amfnaGgxARCQP?=
 =?us-ascii?Q?lRCIAibs6nuAhnErk/cJwnDOpFdbXAit1N8tS4nDiBxetJ/WriuvZUiskGbp?=
 =?us-ascii?Q?wIBFyu8t+cy2zU4r7+lEJiMq24IcYLDlatPfJo6+1H6pULGnJzJdYEAKpehP?=
 =?us-ascii?Q?A2oYtcJWT7AI9N2WUAv+eA4mjZ9wsAPgOaeW450+XW/Rwxt65FA4hwldoE/C?=
 =?us-ascii?Q?SdmiDC3bDiTpmtVz3J3WReI9Or1A6w7YMqwHWCNnrn8WlESfE6c3bFWyJMyq?=
 =?us-ascii?Q?FnrHyY1mK3bA0JPcrLnwQ1uBojBmzEWSGdfdCJno?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02621a41-a6e8-4aec-4470-08dc44c104cb
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 07:24:58.2725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GVfIddrSksfkgEyNHjIXp/fCTA3wsKa3X+pR8FiZFlMw7lm5S5k5SR1nmabGGIyPKGc+kuRn7KN2Qj5O3rO5kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8332

As more and more NXP i.MX chips come out, it becomes harder to maintain
ci-hdrc-usb2.yaml if more stuffs like property restrictions are added to
this file. This will separate i.MX parts out of ci-hdrc-usb2.yaml and add
a new schema for NXP ChipIdea USB2 Controller, also add a common schema.

1. Copy common ci-hdrc-usb2.yaml properties to a new shared
   chipidea,usb2-common.yaml schema.
2. Move fsl,* compatible devices and imx spefific properties
   to dedicated binding file chipidea,usb2-imx.yaml.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v6:
 - new patch
Changes in v7:
 - not remove ci-hdrc-usb2.yaml and move imx parts to ci-hdrc-usb2-imx.yaml
Changes in v8:
 - rename yaml name to chipidea,usb2-common.yaml and chipidea,usb2-imx.yaml
 - remove common properties from ci-hdrc-usb2.yaml
 - add new end line to chipidea,usb2-common.yaml
 - remove fsl,anatop since it's not needed by controller
 - fix pinctrl-names formats
Changes in v9:
 - add Rb tag
---
 .../bindings/usb/chipidea,usb2-common.yaml    | 200 ++++++++++
 .../bindings/usb/chipidea,usb2-imx.yaml       | 193 ++++++++++
 .../devicetree/bindings/usb/ci-hdrc-usb2.yaml | 360 +-----------------
 3 files changed, 396 insertions(+), 357 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/chipidea,usb2-common.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/chipidea,usb2-imx.yaml

diff --git a/Documentation/devicetree/bindings/usb/chipidea,usb2-common.yaml b/Documentation/devicetree/bindings/usb/chipidea,usb2-common.yaml
new file mode 100644
index 000000000000..d2a7d2ecf48a
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/chipidea,usb2-common.yaml
@@ -0,0 +1,200 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/chipidea,usb2-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: USB2 ChipIdea USB controller Common Properties
+
+maintainers:
+  - Xu Yang <xu.yang_2@nxp.com>
+
+properties:
+  reg:
+    minItems: 1
+    maxItems: 2
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+
+  clocks:
+    minItems: 1
+    maxItems: 3
+
+  clock-names:
+    minItems: 1
+    maxItems: 3
+
+  dr_mode: true
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    maxItems: 1
+
+  "#reset-cells":
+    const: 1
+
+  phy_type: true
+
+  itc-setting:
+    description:
+      interrupt threshold control register control, the setting should be
+      aligned with ITC bits at register USBCMD.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  ahb-burst-config:
+    description:
+      it is vendor dependent, the required value should be aligned with
+      AHBBRST at SBUSCFG, the range is from 0x0 to 0x7. This property is
+      used to change AHB burst configuration, check the chipidea spec for
+      meaning of each value. If this property is not existed, it will use
+      the reset value.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0x0
+    maximum: 0x7
+
+  tx-burst-size-dword:
+    description:
+      it is vendor dependent, the tx burst size in dword (4 bytes), This
+      register represents the maximum length of a the burst in 32-bit
+      words while moving data from system memory to the USB bus, the value
+      of this property will only take effect if property "ahb-burst-config"
+      is set to 0, if this property is missing the reset default of the
+      hardware implementation will be used.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0x0
+    maximum: 0x20
+
+  rx-burst-size-dword:
+    description:
+      it is vendor dependent, the rx burst size in dword (4 bytes), This
+      register represents the maximum length of a the burst in 32-bit words
+      while moving data from the USB bus to system memory, the value of
+      this property will only take effect if property "ahb-burst-config"
+      is set to 0, if this property is missing the reset default of the
+      hardware implementation will be used.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0x0
+    maximum: 0x20
+
+  extcon:
+    description:
+      Phandles to external connector devices. First phandle should point
+      to external connector, which provide "USB" cable events, the second
+      should point to external connector device, which provide "USB-HOST"
+      cable events. If one of the external connector devices is not
+      required, empty <0> phandle should be specified.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    minItems: 1
+    items:
+      - description: vbus extcon
+      - description: id extcon
+
+  phy-clkgate-delay-us:
+    description:
+      The delay time (us) between putting the PHY into low power mode and
+      gating the PHY clock.
+
+  non-zero-ttctrl-ttha:
+    description:
+      After setting this property, the value of register ttctrl.ttha
+      will be 0x7f; if not, the value will be 0x0, this is the default
+      value. It needs to be very carefully for setting this property, it
+      is recommended that consult with your IC engineer before setting
+      this value.  On the most of chipidea platforms, the "usage_tt" flag
+      at RTL is 0, so this property only affects siTD.
+
+      If this property is not set, the max packet size is 1023 bytes, and
+      if the total of packet size for previous transactions are more than
+      256 bytes, it can't accept any transactions within this frame. The
+      use case is single transaction, but higher frame rate.
+
+      If this property is set, the max packet size is 188 bytes, it can
+      handle more transactions than above case, it can accept transactions
+      until it considers the left room size within frame is less than 188
+      bytes, software needs to make sure it does not send more than 90%
+      maximum_periodic_data_per_frame. The use case is multiple
+      transactions, but less frame rate.
+    type: boolean
+
+  mux-controls:
+    description:
+      The mux control for toggling host/device output of this controller.
+      It's expected that a mux state of 0 indicates device mode and a mux
+      state of 1 indicates host mode.
+    maxItems: 1
+
+  mux-control-names:
+    const: usb_switch
+
+  pinctrl-names:
+    description:
+      Names for optional pin modes in "default", "host", "device".
+      In case of HSIC-mode, "idle" and "active" pin modes are mandatory.
+      In this case, the "idle" state needs to pull down the data and
+      strobe pin and the "active" state needs to pull up the strobe pin.
+    oneOf:
+      - items:
+          - const: idle
+          - const: active
+      - items:
+          - const: default
+          - const: host
+          - const: device
+      - items:
+          - const: default
+          - enum:
+              - host
+              - device
+      - items:
+          - const: default
+
+  pinctrl-0:
+    maxItems: 1
+
+  pinctrl-1:
+    maxItems: 1
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    const: usb-phy
+
+  vbus-supply:
+    description: reference to the VBUS regulator.
+
+  usb-phy:
+    description: phandle for the PHY device. Use "phys" instead.
+    maxItems: 1
+    deprecated: true
+
+  port:
+    description:
+      Any connector to the data bus of this controller should be modelled
+      using the OF graph bindings specified, if the "usb-role-switch"
+      property is used.
+    $ref: /schemas/graph.yaml#/properties/port
+
+  reset-gpios:
+    maxItems: 1
+
+dependencies:
+  port: [ usb-role-switch ]
+  mux-controls: [ mux-control-names ]
+
+required:
+  - reg
+  - interrupts
+
+allOf:
+  - $ref: usb-hcd.yaml#
+  - $ref: usb-drd.yaml#
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/usb/chipidea,usb2-imx.yaml b/Documentation/devicetree/bindings/usb/chipidea,usb2-imx.yaml
new file mode 100644
index 000000000000..cdbb224e9f68
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/chipidea,usb2-imx.yaml
@@ -0,0 +1,193 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/chipidea,usb2-imx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP USB2 ChipIdea USB controller
+
+maintainers:
+  - Xu Yang <xu.yang_2@nxp.com>
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - fsl,imx27-usb
+      - items:
+          - enum:
+              - fsl,imx23-usb
+              - fsl,imx25-usb
+              - fsl,imx28-usb
+              - fsl,imx35-usb
+              - fsl,imx50-usb
+              - fsl,imx51-usb
+              - fsl,imx53-usb
+              - fsl,imx6q-usb
+              - fsl,imx6sl-usb
+              - fsl,imx6sx-usb
+              - fsl,imx6ul-usb
+              - fsl,imx7d-usb
+              - fsl,vf610-usb
+          - const: fsl,imx27-usb
+      - items:
+          - enum:
+              - fsl,imx8dxl-usb
+              - fsl,imx8ulp-usb
+          - const: fsl,imx7ulp-usb
+          - const: fsl,imx6ul-usb
+      - items:
+          - enum:
+              - fsl,imx8mm-usb
+              - fsl,imx8mn-usb
+          - const: fsl,imx7d-usb
+          - const: fsl,imx27-usb
+      - items:
+          - enum:
+              - fsl,imx6sll-usb
+              - fsl,imx7ulp-usb
+          - const: fsl,imx6ul-usb
+          - const: fsl,imx27-usb
+
+  clocks:
+    minItems: 1
+    maxItems: 3
+
+  clock-names:
+    minItems: 1
+    maxItems: 3
+
+  fsl,usbmisc:
+    description:
+      Phandler of non-core register device, with one argument that
+      indicate usb controller index
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to usbmisc node
+          - description: index of usb controller
+
+  disable-over-current:
+    type: boolean
+    description: disable over current detect
+
+  over-current-active-low:
+    type: boolean
+    description: over current signal polarity is active low
+
+  over-current-active-high:
+    type: boolean
+    description:
+      Over current signal polarity is active high. It's recommended to
+      specify the over current polarity.
+
+  power-active-high:
+    type: boolean
+    description: power signal polarity is active high
+
+  external-vbus-divider:
+    type: boolean
+    description: enables off-chip resistor divider for Vbus
+
+  samsung,picophy-pre-emp-curr-control:
+    description:
+      HS Transmitter Pre-Emphasis Current Control. This signal controls
+      the amount of current sourced to the USB_OTG*_DP and USB_OTG*_DN
+      pins after a J-to-K or K-to-J transition. The range is from 0x0 to
+      0x3, the default value is 0x1. Details can refer to TXPREEMPAMPTUNE0
+      bits of USBNC_n_PHY_CFG1.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0x0
+    maximum: 0x3
+
+  samsung,picophy-dc-vol-level-adjust:
+    description:
+      HS DC Voltage Level Adjustment. Adjust the high-speed transmitter DC
+      level voltage. The range is from 0x0 to 0xf, the default value is
+      0x3. Details can refer to TXVREFTUNE0 bits of USBNC_n_PHY_CFG1.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0x0
+    maximum: 0xf
+
+  fsl,picophy-rise-fall-time-adjust:
+    description:
+      HS Transmitter Rise/Fall Time Adjustment. Adjust the rise/fall times
+      of the high-speed transmitter waveform. It has no unit. The rise/fall
+      time will be increased or decreased by a certain percentage relative
+      to design default time. (0:-10%; 1:design default; 2:+15%; 3:+20%)
+      Details can refer to TXRISETUNE0 bit of USBNC_n_PHY_CFG1.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 3
+    default: 1
+
+  fsl,usbphy:
+    description: phandle of usb phy that connects to the port. Use "phys" instead.
+    $ref: /schemas/types.yaml#/definitions/phandle
+    deprecated: true
+
+required:
+  - compatible
+
+allOf:
+  - $ref: chipidea,usb2-common.yaml#
+  - if:
+      properties:
+        phy_type:
+          const: hsic
+      required:
+        - phy_type
+    then:
+      properties:
+        pinctrl-names:
+          items:
+            - const: idle
+            - const: active
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/imx7d-clock.h>
+
+    usb@30b10000 {
+        compatible = "fsl,imx7d-usb", "fsl,imx27-usb";
+        reg = <0x30b10000 0x200>;
+        interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clks IMX7D_USB_CTRL_CLK>;
+        fsl,usbphy = <&usbphynop1>;
+        fsl,usbmisc = <&usbmisc1 0>;
+        phy-clkgate-delay-us = <400>;
+    };
+
+  # Example for HSIC:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/imx6qdl-clock.h>
+
+    usb@2184400 {
+        compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
+        reg = <0x02184400 0x200>;
+        interrupts = <0 41 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clks IMX6QDL_CLK_USBOH3>;
+        fsl,usbphy = <&usbphynop1>;
+        fsl,usbmisc = <&usbmisc 2>;
+        phy_type = "hsic";
+        dr_mode = "host";
+        ahb-burst-config = <0x0>;
+        tx-burst-size-dword = <0x10>;
+        rx-burst-size-dword = <0x10>;
+        pinctrl-names = "idle", "active";
+        pinctrl-0 = <&pinctrl_usbh2_idle>;
+        pinctrl-1 = <&pinctrl_usbh2_active>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet@1 {
+            compatible = "usb424,9730";
+            reg = <1>;
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
index 3b56e0edb1c6..cc5787a8cfa3 100644
--- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
@@ -15,7 +15,6 @@ properties:
     oneOf:
       - enum:
           - chipidea,usb2
-          - fsl,imx27-usb
           - lsi,zevio-usb
           - nuvoton,npcm750-udc
           - nvidia,tegra20-ehci
@@ -31,40 +30,6 @@ properties:
               - nvidia,tegra124-ehci
               - nvidia,tegra210-ehci
           - const: nvidia,tegra30-ehci
-      - items:
-          - enum:
-              - fsl,imx23-usb
-              - fsl,imx25-usb
-              - fsl,imx28-usb
-              - fsl,imx35-usb
-              - fsl,imx50-usb
-              - fsl,imx51-usb
-              - fsl,imx53-usb
-              - fsl,imx6q-usb
-              - fsl,imx6sl-usb
-              - fsl,imx6sx-usb
-              - fsl,imx6ul-usb
-              - fsl,imx7d-usb
-              - fsl,vf610-usb
-          - const: fsl,imx27-usb
-      - items:
-          - enum:
-              - fsl,imx8dxl-usb
-              - fsl,imx8ulp-usb
-          - const: fsl,imx7ulp-usb
-          - const: fsl,imx6ul-usb
-      - items:
-          - enum:
-              - fsl,imx8mm-usb
-              - fsl,imx8mn-usb
-          - const: fsl,imx7d-usb
-          - const: fsl,imx27-usb
-      - items:
-          - enum:
-              - fsl,imx6sll-usb
-              - fsl,imx7ulp-usb
-          - const: fsl,imx6ul-usb
-          - const: fsl,imx27-usb
       - items:
           - const: xlnx,zynq-usb-2.20a
           - const: chipidea,usb2
@@ -73,163 +38,18 @@ properties:
               - nuvoton,npcm845-udc
           - const: nuvoton,npcm750-udc
 
-  reg:
-    minItems: 1
-    maxItems: 2
-
-  interrupts:
-    minItems: 1
-    maxItems: 2
-
   clocks:
     minItems: 1
-    maxItems: 3
+    maxItems: 2
 
   clock-names:
     minItems: 1
-    maxItems: 3
-
-  dr_mode: true
-
-  power-domains:
-    maxItems: 1
-
-  resets:
-    maxItems: 1
-
-  reset-names:
-    maxItems: 1
-
-  "#reset-cells":
-    const: 1
-
-  phy_type: true
-
-  itc-setting:
-    description:
-      interrupt threshold control register control, the setting should be
-      aligned with ITC bits at register USBCMD.
-    $ref: /schemas/types.yaml#/definitions/uint32
-
-  ahb-burst-config:
-    description:
-      it is vendor dependent, the required value should be aligned with
-      AHBBRST at SBUSCFG, the range is from 0x0 to 0x7. This property is
-      used to change AHB burst configuration, check the chipidea spec for
-      meaning of each value. If this property is not existed, it will use
-      the reset value.
-    $ref: /schemas/types.yaml#/definitions/uint32
-    minimum: 0x0
-    maximum: 0x7
-
-  tx-burst-size-dword:
-    description:
-      it is vendor dependent, the tx burst size in dword (4 bytes), This
-      register represents the maximum length of a the burst in 32-bit
-      words while moving data from system memory to the USB bus, the value
-      of this property will only take effect if property "ahb-burst-config"
-      is set to 0, if this property is missing the reset default of the
-      hardware implementation will be used.
-    $ref: /schemas/types.yaml#/definitions/uint32
-    minimum: 0x0
-    maximum: 0x20
-
-  rx-burst-size-dword:
-    description:
-      it is vendor dependent, the rx burst size in dword (4 bytes), This
-      register represents the maximum length of a the burst in 32-bit words
-      while moving data from the USB bus to system memory, the value of
-      this property will only take effect if property "ahb-burst-config"
-      is set to 0, if this property is missing the reset default of the
-      hardware implementation will be used.
-    $ref: /schemas/types.yaml#/definitions/uint32
-    minimum: 0x0
-    maximum: 0x20
-
-  extcon:
-    description:
-      Phandles to external connector devices. First phandle should point
-      to external connector, which provide "USB" cable events, the second
-      should point to external connector device, which provide "USB-HOST"
-      cable events. If one of the external connector devices is not
-      required, empty <0> phandle should be specified.
-    $ref: /schemas/types.yaml#/definitions/phandle-array
-    minItems: 1
-    items:
-      - description: vbus extcon
-      - description: id extcon
-
-  phy-clkgate-delay-us:
-    description:
-      The delay time (us) between putting the PHY into low power mode and
-      gating the PHY clock.
-
-  non-zero-ttctrl-ttha:
-    description:
-      After setting this property, the value of register ttctrl.ttha
-      will be 0x7f; if not, the value will be 0x0, this is the default
-      value. It needs to be very carefully for setting this property, it
-      is recommended that consult with your IC engineer before setting
-      this value.  On the most of chipidea platforms, the "usage_tt" flag
-      at RTL is 0, so this property only affects siTD.
-
-      If this property is not set, the max packet size is 1023 bytes, and
-      if the total of packet size for previous transactions are more than
-      256 bytes, it can't accept any transactions within this frame. The
-      use case is single transaction, but higher frame rate.
-
-      If this property is set, the max packet size is 188 bytes, it can
-      handle more transactions than above case, it can accept transactions
-      until it considers the left room size within frame is less than 188
-      bytes, software needs to make sure it does not send more than 90%
-      maximum_periodic_data_per_frame. The use case is multiple
-      transactions, but less frame rate.
-    type: boolean
-
-  mux-controls:
-    description:
-      The mux control for toggling host/device output of this controller.
-      It's expected that a mux state of 0 indicates device mode and a mux
-      state of 1 indicates host mode.
-    maxItems: 1
-
-  mux-control-names:
-    const: usb_switch
+    maxItems: 2
 
   operating-points-v2:
     description: A phandle to the OPP table containing the performance states.
     $ref: /schemas/types.yaml#/definitions/phandle
 
-  pinctrl-names:
-    description:
-      Names for optional pin modes in "default", "host", "device".
-      In case of HSIC-mode, "idle" and "active" pin modes are mandatory.
-      In this case, the "idle" state needs to pull down the data and
-      strobe pin and the "active" state needs to pull up the strobe pin.
-    oneOf:
-      - items:
-          - const: idle
-          - const: active
-      - items:
-          - const: default
-          - enum:
-              - host
-              - device
-      - items:
-          - const: default
-
-  pinctrl-0:
-    maxItems: 1
-
-  pinctrl-1:
-    maxItems: 1
-
-  phys:
-    maxItems: 1
-
-  phy-names:
-    const: usb-phy
-
   phy-select:
     description:
       Phandler of TCSR node with two argument that indicate register
@@ -240,87 +60,6 @@ properties:
       - description: register offset
       - description: phy index
 
-  vbus-supply:
-    description: reference to the VBUS regulator.
-
-  fsl,usbmisc:
-    description:
-      Phandler of non-core register device, with one argument that
-      indicate usb controller index
-    $ref: /schemas/types.yaml#/definitions/phandle-array
-    items:
-      - items:
-          - description: phandle to usbmisc node
-          - description: index of usb controller
-
-  fsl,anatop:
-    description: phandle for the anatop node.
-    $ref: /schemas/types.yaml#/definitions/phandle
-
-  disable-over-current:
-    type: boolean
-    description: disable over current detect
-
-  over-current-active-low:
-    type: boolean
-    description: over current signal polarity is active low
-
-  over-current-active-high:
-    type: boolean
-    description:
-      Over current signal polarity is active high. It's recommended to
-      specify the over current polarity.
-
-  power-active-high:
-    type: boolean
-    description: power signal polarity is active high
-
-  external-vbus-divider:
-    type: boolean
-    description: enables off-chip resistor divider for Vbus
-
-  samsung,picophy-pre-emp-curr-control:
-    description:
-      HS Transmitter Pre-Emphasis Current Control. This signal controls
-      the amount of current sourced to the USB_OTG*_DP and USB_OTG*_DN
-      pins after a J-to-K or K-to-J transition. The range is from 0x0 to
-      0x3, the default value is 0x1. Details can refer to TXPREEMPAMPTUNE0
-      bits of USBNC_n_PHY_CFG1.
-    $ref: /schemas/types.yaml#/definitions/uint32
-    minimum: 0x0
-    maximum: 0x3
-
-  samsung,picophy-dc-vol-level-adjust:
-    description:
-      HS DC Voltage Level Adjustment. Adjust the high-speed transmitter DC
-      level voltage. The range is from 0x0 to 0xf, the default value is
-      0x3. Details can refer to TXVREFTUNE0 bits of USBNC_n_PHY_CFG1.
-    $ref: /schemas/types.yaml#/definitions/uint32
-    minimum: 0x0
-    maximum: 0xf
-
-  fsl,picophy-rise-fall-time-adjust:
-    description:
-      HS Transmitter Rise/Fall Time Adjustment. Adjust the rise/fall times
-      of the high-speed transmitter waveform. It has no unit. The rise/fall
-      time will be increased or decreased by a certain percentage relative
-      to design default time. (0:-10%; 1:design default; 2:+15%; 3:+20%)
-      Details can refer to TXRISETUNE0 bit of USBNC_n_PHY_CFG1.
-    $ref: /schemas/types.yaml#/definitions/uint32
-    minimum: 0
-    maximum: 3
-    default: 1
-
-  usb-phy:
-    description: phandle for the PHY device. Use "phys" instead.
-    maxItems: 1
-    deprecated: true
-
-  fsl,usbphy:
-    description: phandle of usb phy that connects to the port. Use "phys" instead.
-    $ref: /schemas/types.yaml#/definitions/phandle
-    deprecated: true
-
   nvidia,phy:
     description: phandle of usb phy that connects to the port. Use "phys" instead.
     $ref: /schemas/types.yaml#/definitions/phandle
@@ -331,16 +70,6 @@ properties:
     type: boolean
     deprecated: true
 
-  port:
-    description:
-      Any connector to the data bus of this controller should be modelled
-      using the OF graph bindings specified, if the "usb-role-switch"
-      property is used.
-    $ref: /schemas/graph.yaml#/properties/port
-
-  reset-gpios:
-    maxItems: 1
-
   ulpi:
     type: object
     additionalProperties: false
@@ -350,67 +79,13 @@ properties:
         type: object
         $ref: /schemas/phy/qcom,usb-hs-phy.yaml
 
-dependencies:
-  port: [ usb-role-switch ]
-  mux-controls: [ mux-control-names ]
-
 required:
   - compatible
-  - reg
-  - interrupts
 
 allOf:
+  - $ref: chipidea,usb2-common.yaml#
   - $ref: usb-hcd.yaml#
   - $ref: usb-drd.yaml#
-  - if:
-      properties:
-        phy_type:
-          const: hsic
-      required:
-        - phy_type
-    then:
-      properties:
-        pinctrl-names:
-          items:
-            - const: idle
-            - const: active
-    else:
-      properties:
-        pinctrl-names:
-          minItems: 1
-          maxItems: 2
-          oneOf:
-            - items:
-                - const: default
-                - enum:
-                    - host
-                    - device
-            - items:
-                - const: default
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - chipidea,usb2
-              - lsi,zevio-usb
-              - nuvoton,npcm750-udc
-              - nvidia,tegra20-udc
-              - nvidia,tegra30-udc
-              - nvidia,tegra114-udc
-              - nvidia,tegra124-udc
-              - qcom,ci-hdrc
-              - xlnx,zynq-usb-2.20a
-    then:
-      properties:
-        fsl,usbmisc: false
-        disable-over-current: false
-        over-current-active-low: false
-        over-current-active-high: false
-        power-active-high: false
-        external-vbus-divider: false
-        samsung,picophy-pre-emp-curr-control: false
-        samsung,picophy-dc-vol-level-adjust: false
 
 unevaluatedProperties: false
 
@@ -438,33 +113,4 @@ examples:
         mux-control-names = "usb_switch";
     };
 
-  # Example for HSIC:
-  - |
-    #include <dt-bindings/interrupt-controller/arm-gic.h>
-    #include <dt-bindings/clock/imx6qdl-clock.h>
-
-    usb@2184400 {
-        compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
-        reg = <0x02184400 0x200>;
-        interrupts = <0 41 IRQ_TYPE_LEVEL_HIGH>;
-        clocks = <&clks IMX6QDL_CLK_USBOH3>;
-        fsl,usbphy = <&usbphynop1>;
-        fsl,usbmisc = <&usbmisc 2>;
-        phy_type = "hsic";
-        dr_mode = "host";
-        ahb-burst-config = <0x0>;
-        tx-burst-size-dword = <0x10>;
-        rx-burst-size-dword = <0x10>;
-        pinctrl-names = "idle", "active";
-        pinctrl-0 = <&pinctrl_usbh2_idle>;
-        pinctrl-1 = <&pinctrl_usbh2_active>;
-        #address-cells = <1>;
-        #size-cells = <0>;
-
-        ethernet@1 {
-            compatible = "usb424,9730";
-            reg = <1>;
-        };
-    };
-
 ...
-- 
2.34.1


