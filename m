Return-Path: <linux-kernel+bounces-109765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7262488556B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E19C31F22338
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6C269966;
	Thu, 21 Mar 2024 08:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EmnLM+lA"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2059.outbound.protection.outlook.com [40.107.21.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB8977F27;
	Thu, 21 Mar 2024 08:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711008886; cv=fail; b=bp+kHNyhY/xhD2gjbiiOItuovCWLzZ8h982bNaTjHhgG2dJZfO52AKogl45rikJq1LG7oiUn21vhc7puoJA5berlrsJri2wAMJnBeeE1fFmrc9SLZ4Pgs1c/Ui4D6rIGnhT8l9IL1Jnn3VCR6XOCZpWPcf63Nbl0sj4phant5jU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711008886; c=relaxed/simple;
	bh=r9V90u9L6C/MhFFcEAKj3gvsT97DoMmaO/ENS7Jer1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YQO7mHX1YYDmfWkmgV3jT9kc/FJ9LicW4dDkWXm2WeMDFuBG9JbKiMOTk9KmM6fxUdUXiTDWkMUhX8w5YWgrkm91flPjZnQ6y1us7pzSnMbQO8TzZ5Wks8BKktUrs85/55zP3PmzNLnKaw8D623MMXOLSWSut9cipkHnL5Tj6G4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=EmnLM+lA; arc=fail smtp.client-ip=40.107.21.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkpcGCHI4u+Ho2UjnSeIlZy6Va1Yku3eI0UOKloyeU2eFPkVBlSucdFE2YchsnZh0NK0j7/3Bcg/R6ylGklxq01DolNvSXD8kc1+iEXtGjU2WnNOMCJV7Z/WPEgJyzP3cAvOy3+ofayyG2FmoTZAoxrFueJjz9xy2exz7CO2sGz854negD0ZemEdYb72wLTExSx5AW7TuQgq65/W1/gD1e5bCtFUYeO2W9QKO9M5TW3KPtsGlIzvCSSYBAkfH26h1uF4n5TCIZWNHCWyLw8ajeIcIYxh0D6+wnaQaYEBB1Lvb6eXGNLZUZ3SQuLLO93u+wAbqaMl2Bo38WuadPSy2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymAa+aSuAn7HQrlJXJU79VtPZK115RslhJZzV8dit40=;
 b=NeLPfEoIp2PDAjFS5j++UBOghQKpC2Up7aYnnwCwd+5lweqmE6VFa8A/fGHZN1ATtlwYNtnMjB+8G98vy3sCpogOfesSFB53VBmLuSPyFuizifnqwWc7knwNM2hspJPDopmiGuxWAr6Gz5TVWMiRYkmn7P95DrFXT5ax45j6zltFV+Xx4laHVorCytdti6yixO7tjMUGyLq2TWeyBCBoQ3cR/gj33PWCushWdsEjNSB1C1wgs9M2C2L4PiugxqFOtg3aFdtYTdutOsVXqJeVe+CFz1aR6cl+UuwKEjpHiXY1IXUmRl8+UeYe9a5DTuMG3SF2i8nSF6q9ihtHGkzPlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymAa+aSuAn7HQrlJXJU79VtPZK115RslhJZzV8dit40=;
 b=EmnLM+lAODmLNu4bbfqidyNFnhclvmb3dfgkxQwZ/CcuXQpX1ogFlarjDndd2ggmNPdxhiu9rzbFgZLztDFxPNS8wDerf4qBkJZ3oCu5xAD6brROyxWGKvSJgcrKd0y7xMms1BlUc3Nfi/8m0el8ZUQPNVGkqo8DnSIBFxawUJ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB9191.eurprd04.prod.outlook.com (2603:10a6:20b:44e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Thu, 21 Mar
 2024 08:14:40 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7386.023; Thu, 21 Mar 2024
 08:14:40 +0000
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
Subject: [PATCH v10 04/11] dt-bindings: usb: chipidea,usb2-imx: move imx parts to dedicated schema
Date: Thu, 21 Mar 2024 16:14:32 +0800
Message-Id: <20240321081439.541799-4-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240321081439.541799-1-xu.yang_2@nxp.com>
References: <20240321081439.541799-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:3:17::34) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS8PR04MB9191:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b7b1dd6-ce96-400f-7193-08dc497ef4bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CWTwGTm++2gEF7DQaa79MYnhHih9cP+404yKNgamuVWd7/N1VMOVaVpf7QkOWm0CO2G9R2ubxgb50/XHmA8xRcWXMBjAjpDSJ/S+88nCjNoWgPrjV0qPLehrSBVO6pFWhNFxWA1/QXgL9BwBj340Hk52UYpj46mUVxefW+HP/aOWAVu+Od2fX+1gADb5+qYdOb1i05LD3xCbXCwoNYhkPJdGg0OTW7uuED+9eIftYTK2ZHsG7sISgGrbhs4ncntpORmzr0a/QCbB0v17IH/w0+u6rSncQe7Ve1JQ7WMdyr+sipHRsCfRLYux4BjqS9oCHyE2b2DXd78K/zbHZQ86jImadOvlN+e3xQ/Wyhcw/dXG3gCqqgsUDB8Qdvg0qMF3DxgWgSed/r8XNqGyOuQuYsmZO+jCIzrbVezRpcdZKHC6fp64FOkbzftNTK5r4ouaG0Rw/eEeNI4FofHdjR2HNuTHrGsXsoGETfzEax+FiwzRBucMkVB465VHgWOrBsoEKyXoAu4U20qhYN9lrDSaiyvh6mccZ17tBPYrlXVaGudwV59/s4OZpEQPnaUPwtSjAWPgM3gfWEdo/EysTIf3kIFQidfLFPYShbIDvovQvrW37rF5AmUc4Kfz9xYEw9AuF6afykIibhO+D7YtB+j3JXdYbLbloxxYid0s5EmKC9M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(7416005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Euw6uWmOr5RO8F7kGizCjA2SsmmKU7URg0x9efBZpUV7g2esaxMB4FhVgOD+?=
 =?us-ascii?Q?V3FuxUuG6prCkHENe/h27oi780G5AlewKSzRsMJQ0KsZP6H/1mPsEtvWEB5b?=
 =?us-ascii?Q?WfU7Q/znH1Z2pe30cK/zDZ4/B/0GqfViFhhpW3eJ4NZMZFTVqs378pc8J2gl?=
 =?us-ascii?Q?f6w2Tna+4JbsU4M+IA7laPZICXV6+tyjh3NZSBcinBo5f0xz9UsrTPbRrqVB?=
 =?us-ascii?Q?UyGVR3IFRd34lP35m0uw0qH0E6UsTF4q3nVLOmrdBX56Fx7GJDbxP5D3yBET?=
 =?us-ascii?Q?utOLkI3cMoXerdYcAKpfUgyqfktxYZnc1ND0W9YiraUZjJAR1oaKNa8A0EVP?=
 =?us-ascii?Q?hP2rMgQjzD69Ya9o6jlLsKC5UZOcLwdnYPCv7ijzq58mP/03UY0xxM13dM0h?=
 =?us-ascii?Q?F8kvkXoEqRV+5XQ8v+xkaPEMiNVFRvaX8fXAmrDqBVbri1J5vAFwKNFck62A?=
 =?us-ascii?Q?GUCMcacW8tbF+DvDz4UnVJYyN1QU0H8HFvBS7JGDy/lr0G04w/EhH67ieswN?=
 =?us-ascii?Q?hr/Ib/pr7KqIpH2/Xq9Y2T24lmYS1ghBPSrOEfs8BuTNuTjYxWXqATH0nGVl?=
 =?us-ascii?Q?tf5K2XUB+Qxl4hBA4iGGhypgk8SfBXzn8BcRAgyGLj5jYOmBfJTzqsQAqXJZ?=
 =?us-ascii?Q?Y0SZMPkNIj43p8E97mpkSgA4Z7eR3dsK1X8LmoyrTBEHEKV+TBHHAqMhyFMa?=
 =?us-ascii?Q?pLVD6TLQ4+KO4AoajMUlhzWVRQ69sqfE/7FJ7c95n/+EkVKtQWsak/xrmnPO?=
 =?us-ascii?Q?lbx2ux7R9Wr5jAy++DX/MyHTmjjiV+qT7gsEtHE53F9dA4xXL0XDF9+wrEM2?=
 =?us-ascii?Q?JeuzD7t2ES63P3PqvrIND8C4SplisKO12h5fM66e2uVhgA8McyY/Cu2oqDuZ?=
 =?us-ascii?Q?6sDO+OfVOr84UHXtJk/nQNCMwkjGuQTJF73wPBqnVqoHy3XAntNat7czVVn1?=
 =?us-ascii?Q?jyZ8DsPW7myvz2Ii8XH+7HKrpntR3KS/wzLrhCzn6jEu29IpVfT70SwBzmc6?=
 =?us-ascii?Q?m537QEEKD1UExTQxoRXgj+LN11ZwsDiSLhlp1L0QgLQgFLrHuNn9Z5HnjBb9?=
 =?us-ascii?Q?77ARB5e0as5DvYkW4Cm67+YclQ8DHdJlTBHtVuSo7q4oLgAn96ElbE42RTph?=
 =?us-ascii?Q?pPB4qpuGkLV06l5jnppAzmWtlknKM59uo101lcSuXFgcRdUiTIbdkJbJS+pH?=
 =?us-ascii?Q?G+fTCSxvkQumgDK2njz5Zv/Pr+K0sGDFPvLATE3KdTtT39K9zyNMES3L9W83?=
 =?us-ascii?Q?SaVBup5G5QWjak9GcXlYVIShvwbYVCh8U7cSqa0HpU9nk0+J5Wid+ip0iCrt?=
 =?us-ascii?Q?Qi4HZs+4XLmZZse0yOycKflisSkuZzYsTCcVgPiLN4CzWmfSs0WvHkqDuzd3?=
 =?us-ascii?Q?aj4iFWYfVhoFUu1GPtUYQCPyIIb0/8zw0ufAI8HAOmzJMcb2mh5967HaEjvt?=
 =?us-ascii?Q?NdYyoRaUbwktjusSsubWWJPC5VFkEUe8Kysyz+VZG9jaYhijcanuyL+Xzut8?=
 =?us-ascii?Q?O7Xu/HuPQ1/pHG7YPYdeR28839qYnEdwZ7UON3kgB3hCl5C9TauvqCjrRZoD?=
 =?us-ascii?Q?md+EUZFySXUNPPvNWVbtlf9yEzONtjSraLkN+xut?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b7b1dd6-ce96-400f-7193-08dc497ef4bc
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 08:14:40.4011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QhzRN8s9SW0ftpfU0DPIp0leAuX7E66MRDhyXi/3zTu6T3z8UQScs823SZ/dtZV6ugvOucc0ik581R8QxjthPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9191

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
Changes in v10:
 - no changes
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


