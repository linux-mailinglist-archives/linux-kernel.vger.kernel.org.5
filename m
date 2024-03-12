Return-Path: <linux-kernel+bounces-100000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0422D879083
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57CA0B21D98
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60B379B62;
	Tue, 12 Mar 2024 09:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SiSmlQ3v"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2079.outbound.protection.outlook.com [40.107.6.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3F878275;
	Tue, 12 Mar 2024 09:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235036; cv=fail; b=o9pBSXCxpzRyiUiBvtKGL1aKifPU4VtJVvMwHIp7pq3xkPP6B4KSuCP5vnxx+bF3e2omot7nNIXcj8Inzwm5UBG2N2/6K/KaK6IC39aVv9YF9p3DZsj8jFBjAurSx4if0nfe9VDe79JwccLsGmJqawNg6SmBQ53uJeG76nHcnNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235036; c=relaxed/simple;
	bh=sew3kf5tFYH/bQFb3Z06WZaC6SLS0gR0wfSk6mw+LRM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hxXV8C/Na6I2h3jwDTpqxlAXzAodn9nGcDMA2ZxILYsYCbutcaruFdV3aQGq5RLSChR9AV7ikxpsI7x/DiCNKDiY7JbyExVqodXJI1fy8LAwELM+Rg9ZgUuceMPiu49UK/438BO0JO9xEUJms+lggzfWyX9iJfqO5Y3N7vx+kok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=SiSmlQ3v; arc=fail smtp.client-ip=40.107.6.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQ+Uo+I1AefrYcZ4ehqlAtlDvOqb6Cy3wDy19Vr0MUtT9mJq8pQrUpvL7kyWvrgrtwXCxaP2HSiz5fAYJ2h/4Rf1xD/9nmadwZ2S2YaBLAGDISUwdTHW8CVKqZeChXOBEQt4WEb2Sp6bEeB84/Wzn/OhmbYkmR5q0SoOgTUzL3wPAjkDTsuc6NEHWtZjaVZKr95OJhF3v6Y9bFfr+fNMGj4p7G4f/KrOsS4g9Xj10WXl3SB+3PpYgHThHQpqyXuZ1IJrTvYGtM7LkMp3aJuINBn6T5u575GP0EFOeeGyFxn4hbZh8eqH3QPjbnuqUQWD01DSoy3jfRBsyEhILa7n9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joxH+ODr9RmFAM5bWZGmeOMOW543Eu6Fl478NfzStj0=;
 b=TZka+8YJD1dAl+oXkamBAmLucIVHO8OMC9qMEjlO2nhLQ1F6eQX1NZ4l4sTdjWpJ8GNCGiL2ZlCPmxKB4uFovVdcqQyN6kXpXXgRh4UbzEvN4EaJF3R/sn4Wjlri8rick4XxglNCgHJ/adhTWboyr3d3zEpO0dJqb6O8QsigCFw2rr/KaiHLf+Zr5hpiN4IqH6itV5MUcLaoBy+/lOyiO3PtrE1SY0rUyJj9KFqlp3r3ze8Mr5SdXGet1xAiZZkWc9BHgqdkYxMMFx7zJ5AkqJVQHJQb0HNCRnvuEOwzHR4+drNCwKqQpUOXY8huC1onuWPTITD3zKikD7Jy4JSCxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joxH+ODr9RmFAM5bWZGmeOMOW543Eu6Fl478NfzStj0=;
 b=SiSmlQ3vaz8BExLqCtmxqa0o/lyaAGjrsJwiXO6NiwNCAByufFU/6thZs9qc0ddKEMOutKIpTe2JL9cTpJPrStxj53qnrra6m0by8nRbKuKNZnSf7U3LkrhcIZv+RDnopeoh9ljTT94DVUtrA0YUKzQP4DfbEmx60kbvAs7eMV8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AM8PR04MB7876.eurprd04.prod.outlook.com (2603:10a6:20b:240::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Tue, 12 Mar
 2024 09:17:11 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 09:17:10 +0000
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
Subject: [PATCH v8 04/10] dt-bindings: usb: chipidea,usb2-imx: move imx parts to dedicated schema
Date: Tue, 12 Mar 2024 17:16:57 +0800
Message-Id: <20240312091703.1220649-4-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312091703.1220649-1-xu.yang_2@nxp.com>
References: <20240312091703.1220649-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AM8PR04MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b8ec39c-e48c-4e0f-dd8a-08dc4275328a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VZekoUtNYC7zTz+LawrRWNif7iF9QJR1G8Xg+HrvsEvqvkWzqNbqXCpBaIx/PctqWpJ2jEIeKsRaiYzf5lXMyPWgaI/MqZLGpWFJWZEd+TpHqOurpsMsQHEfoJs2o3L9o4wtwCHf5oHcdA7zHhej/GPnd73UTxGdZRXFgViMpRuWojMTLCFyeyEnZ8SP5t4gbE19u2bVN1QUxQ+Z99eQoXSPagP00UQjt1zgsU2POJt5mnl/YlycYLQJXA1hp/rxVbLCWXm8c7YDMtAGAkA3Danj77sAfmN+qjMOW1BUMurdFN1/Rn7LqYZqtwuxM0TspwdFjIDjjXZ/VazL+gFno7Je3qryX+EnL5K8zBOpZ2vChITMhtQs13ouW0XclJsm57Fp7CtGFPjsTqKunVsgTkv1ykrA4Detkef7EcFGr+u4UrBGdezTPB5/oHPt/n0BmtMdPGwjd11UXxDDKlWTchAWp/e6FIHyXGTkG4PXT+Fkh3hl2EyvpZfqUjxYBCcLiZzeNJSSbzdBTR/bxX6idgZr/OlnvJ6wO16LygZKqQPf+9AUb/rb3nUKqaFBmfwf0mZgXneZaInbbOo3Bo8zD0EEBjLg1rVqxWGociFSL6xbLSeBxzW/s4Kbr7V8IeeCkzE/hgS7QmMIxS2q2REZLRWwoony6NPnzIPEPyZXrXY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d2mIQrF1A9qRJpSo0YbFi7nJ25Yp3DzggS7xXFgNj/aA672NBcVdq3SCjfKo?=
 =?us-ascii?Q?ORT+JzlCc2VxX190O8EtTvtVfsXfpFFGx1G9/Qhc3M+CeXR+dBnGX7xQRgH+?=
 =?us-ascii?Q?HPLFfGs3pO1gPh4+KRh96401tRhRRerEsCxOTSI90pMSobphpminzLMOvV7P?=
 =?us-ascii?Q?rTQK/bYrfwOGOsZN3lC/ZVAmxlUMli6YV6N43YXyHouY6Qwy9nuZVHjJMhuB?=
 =?us-ascii?Q?oW8KXnX+ssGL2csptXfBuH8DLlHiAvIyYEeubsK5JvSKvVIMt5gGt5ay4/rS?=
 =?us-ascii?Q?YIUZJemltICjxRMmYBTP6D3rBwApxLr/WJaQ1XRDvsA6DApWNF/WiwbZM0fi?=
 =?us-ascii?Q?D7RdNtL9KUwuGjVIaC3E7Exfy9mGtXgNDHq1GFOTQV06H762rQ7clTkpukvR?=
 =?us-ascii?Q?EnB6pbsDtE/O7kbFE8cbcgfjXUcWsN2+kJxxXC/tzHm6rgaATn5NMPN8Y0H2?=
 =?us-ascii?Q?5s8oFOL5sgRoyB9Hv6cHpm7FnG/OfXJO01P/pHsPmEAvbG6sTqokXbOx4jIK?=
 =?us-ascii?Q?zfIC8j06P8hVluG3m923GRZ0TWoOZzFXZzj+m1L++NCajCGgeOnobhR0S+hd?=
 =?us-ascii?Q?xpm9RVOSmM3EVebDVjP61+g+bSaZbt2MWWNSlK3GqslyFbxPJJtri3mDVoGy?=
 =?us-ascii?Q?nvNwEn7uivWxrifySJutzwxFNDNwQHsHwCRXKIFVIZidtncImazscA62+oR3?=
 =?us-ascii?Q?36v1iPl6c0PlmRzh+0cpWLejheWe+NXTlu2gF4f/VOCY8MI3wC/Iu7FlCb8H?=
 =?us-ascii?Q?IVkoG1Yw2i9FCLi71bbPDhHFco1FPxu7+rMPApBZpuinEP3Et/UqalP+q2rx?=
 =?us-ascii?Q?k7159d9xyTBUqVAZloI8U/rLDkcaAga1sgL3B7LhmROpoXlE1BnSvHh8OPIw?=
 =?us-ascii?Q?UBlwkMauH2a0OJa3CcgFCJQiUUjXYiKritw1zgsQ+U9hzU8XfD4W9BbvrvB9?=
 =?us-ascii?Q?eoA6XxG6RhkNj3cAZ4n4K2E/CQQyxQtaoILS2abINGu8waAFnIcu4bFw3X7C?=
 =?us-ascii?Q?oVGrVR42lGGf8zlUFEdReeCGjg3VoSbpqpUpZBs7mOVtR/z27ldNOQBxxTlw?=
 =?us-ascii?Q?uXa1XErbqU87KPscURa8Z5lLBauUGUtN73gbrHr88clNebDwO1h149Z5jVsM?=
 =?us-ascii?Q?6I+cVYPEePaZ14XN9E9YKJgT+eCte5QQjXVj/slUdCjxs0Slp4OH9WP5eQvz?=
 =?us-ascii?Q?wQNv/FEsKxgRWzGjuVwVcFA8AHl4TNufj2CFcwL6138UFD9+Glv0wojnKFAf?=
 =?us-ascii?Q?Q0MqgEAZN+sgqvApCybiAIcnMdiSxG2mIKP9la40GbtfB4jQlr5hiZe5r/vS?=
 =?us-ascii?Q?lOCGPC/6PV6zhfeo76H9wzwO3deqd95WIyxxmA6gUaNAZ+3kWn4t3UWlZOTQ?=
 =?us-ascii?Q?OJslfk8XRD0dX5XCOshx7UdXA5To9Yb+NwTKHwkAwvr3cKxaBjFTtFEwpq4t?=
 =?us-ascii?Q?JyOHiw3ePl7Hp1NzPA9/Mp77VdlVBOnVcjtbrleM+J7q7+32DXVwxZ1VXhJl?=
 =?us-ascii?Q?HvUDNFET+g1S+4ffV69hXme5nyOqHf68agJj4JlJZF1cKx6/ZTv7znxeG20C?=
 =?us-ascii?Q?1AqhOodowCg5Nbk5VOKP+qIIm2DJ066RdZ1H6WEM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8ec39c-e48c-4e0f-dd8a-08dc4275328a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:17:10.9095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CgunpXrR/uc78DZsYx21zKym/5aP0RDJ2Qt++xo6KflrwSdLtQlB7FJw0+nh+641vXAtpKkCAFepFyibcOfZXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7876

As more and more NXP i.MX chips come out, it becomes harder to maintain
ci-hdrc-usb2.yaml if more stuffs like property restrictions are added to
this file. This will separate i.MX parts out of ci-hdrc-usb2.yaml and add
a new schema for NXP ChipIdea USB2 Controller, also add a common schema.

1. Copy common ci-hdrc-usb2.yaml properties to a new shared
   chipidea,usb2-common.yaml schema.
2. Move fsl,* compatible devices and imx spefific properties
   to dedicated binding file chipidea,usb2-imx.yaml.

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


