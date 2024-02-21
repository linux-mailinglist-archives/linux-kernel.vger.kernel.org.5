Return-Path: <linux-kernel+bounces-74281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9414385D205
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48ADD287333
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2254A3C499;
	Wed, 21 Feb 2024 08:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="op1wLzDk"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2048.outbound.protection.outlook.com [40.107.14.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4956B3C481;
	Wed, 21 Feb 2024 08:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708502581; cv=fail; b=dutAlIv+73fNG74YcZWLVzqDlE37nhdRzrxSd4b8kUAs/QfzY2g0gkDkMQIqPiJrx0csOP/B3wqJJw9aJGSPyETwluDWC3DFMjJ/48iLBB7+BvThzflqrytEz7Wglx1cNTYcRUOI73bmybOZIUI0pNglzIGXoy3P7mET5rVTxFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708502581; c=relaxed/simple;
	bh=zoB1G40HMGMaUnbvkdET6FupLf9uQGhM6mAxm/eXZeI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WU+C9wEn4Qduv5CXew9dfbH12hdw7wPZZv4Ej7SGUzEmQE/zzaQRppIFjDitYsEZoeafXK1jU2Qsad/k67fGY+HVJIwkOPOEawrfRESsjZtOeiW4Iiae3m3o/dc0lqv2+RWPuoextEOgJHvchf98EX99wcn94+6zuCv0Xjg2fFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=op1wLzDk; arc=fail smtp.client-ip=40.107.14.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggonKO4r855gDn3nutvtUo7jfhxfLdR5f0BrQibrRI8ju0eD/JGU7tnhsF8X0UIbt1G+aX7Z7GNycF+EssNx9M1p52/MI/IdCyZXCz0KMMN+O9/B5FzkW3tOhHGh6YxHD1/4W75izKHZrDYf2BHe9ap6O8s+cmqROXnbTvrAv2MEr2zZec0rIyAXpuBK3OpioiZFB0U1zHbK8a5MRNX5MNVXJ8h+XYjaYGQKODzHGcDZTis0JVV5FjiXR1bmsZpKMTZPzEODnmWBnhf2EC+TQB/cfeWshnvxpWVBk05zdX7+1XLW5mMOiVIXUcc4qdK7m0QFDmQP/ojQimxdTLJypw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Efo77SPUftdc6VSRPIBJO/of8Og+4gFvmQDRGFG4FDE=;
 b=bDO4aqB6ZTsUdo+Xdz9Xj7N8jhmKGIIy7zgpAE23PWdyNcyEwZAVdta1nO+zeZG7kUmNS+j6QOV8W57Z4BhdLRJJ6HFzKVLVfvWNrqFCqNK6/f2O/dnAdlLKd4fQgTU9HSQDApn63QFeLK2CaQtKRBOVIg4eT4p+LOIj87pDfZCaz5WTkYwzHb7+/nf6/yK5Ci+MRtwOTZAYbEokBnqJzvZ8Cn4lp7h35DgIc4E/vR7gXQ+OJgLaaS79ynBJJ217OALFrfx8qOAG9c/mFWRnRiycUuwvieG4SgfmVI/cgdCvz/L4bI+RrTZjdN3XAvMlMEmboiMQyUUCcgPTIZ12HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Efo77SPUftdc6VSRPIBJO/of8Og+4gFvmQDRGFG4FDE=;
 b=op1wLzDkIXVa8PvLAEA74yawlde/6uCu1V3FD+N/m93aOxPuQdr6htgSr4o5sUsZxFBY3tXlAsloxWyd/wqd6EeuwFQokETWHNzzUyWHmwMFl505Zcnsd5mVOOoAYsg+AFpGx9R1FsGJs24SYFjECk8xHARJJQnetSTjkP+i6jA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS5PR04MB9770.eurprd04.prod.outlook.com (2603:10a6:20b:654::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Wed, 21 Feb
 2024 08:02:58 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7292.029; Wed, 21 Feb 2024
 08:02:58 +0000
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
	linux-kernel@vger.kernel.org
Subject: [RESEND v6 4/9] dt-bindings: usb: add NXP ChipIdea USB2 Controller schema
Date: Wed, 21 Feb 2024 16:02:33 +0800
Message-Id: <20240221080238.1615536-4-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240221080238.1615536-1-xu.yang_2@nxp.com>
References: <20240221080238.1615536-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS5PR04MB9770:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d4e5fd6-287d-40a3-db67-08dc32b3841e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gduwVvUplHS4zNo0sZ83Uzbk0pEZmHUjntY6N1pxJNxoIm7pI3GDc3MoxNpyNXGFO7ttpUAqXoUxMypThoIrQtSMhgUe6qyYrl2/rjkD76FM/ZZH8w++YvHU+dk85C4RGpZ3NerjLSA2cPLOSt03DozspumCmv38uZfd2ZLrTlSPCbv6vslCY2mZKHx02oMQXJVdOsN5HA7J48ZZfmhi3EPy+1T8ILmZm9ha58K9lPOgLRLTjMiarMpBxGRzvpL03chkEQ7InKrePp0Eh1e3wCt00k9MJHBbJ2+2p8rT6FjyWFFQNvT3egr73p9yq0iMUEk3aMfQIjTSm81cFgDponOqJacBJu08j9o5+D/vGhFc0oycNbsxfdyQzRnqeCEXzKVTpV3Cb7o6EbhFQNte9bJsWCRy7MV3eR/73NewPDzLYW84oVEJNBvxnrLbRMMowOtbhezbOmxaayhSSL9Sw4zLRhMtBLfzod7CLrQ2DOi3ePDEVAKlXQxPPblFpzwye9LiiylyOCFa4gZnfDF+YakB6NsOrGFcwWE/y5QZ5SAeJLReyAzPnVCVvs3LMJHQg6mZsB8pY1X7s0xtehGn3TqfwlbjE3z4m+p6FekfyYQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vng4lcIC/k/YwAhyn542MrKfCAjKR5wiLC9PqyuxTlGh+CvEZWeFgaqgYX4d?=
 =?us-ascii?Q?kvCDnUO1kthsYp73HZvjqF9DQnH/hj0geIqRlGTqO5hmJ6fL6nD3fexcKr6d?=
 =?us-ascii?Q?V1BrfeF85Ew4muB8D9IeWpkrwnFfeRPhbE+CVeounOFJr2cB3ZOfsXKO/H4y?=
 =?us-ascii?Q?m9MNuycL/PWM02FRpN6WVtly08GhltVM1T8OmycqtSwTAPgPpSH0OlJDqKuf?=
 =?us-ascii?Q?yiw53lW54Upo3W10Cp2xNhvl/dDI/1whhWI7Nnbyf6mohp/OZhzX2pvyW88F?=
 =?us-ascii?Q?S+tx4qlaAlzul9dnjrw4c1Su/urtvW5Gkzg7wD0Ri401vslYHXecEGgNKK1y?=
 =?us-ascii?Q?+YHzlIGD8ur71NiQTgGhVqQPvwEz6URmIEAUP0Hih6RR/kKPOPJ/9PojTcxs?=
 =?us-ascii?Q?HCJXbgsF5fgW0v/qdDwsBWRPdqhs5qlYLQc5ePtNJqAIaSTljK5pHwHhw9OE?=
 =?us-ascii?Q?xLd9iOMwmaQmeVVbir9WvVuyzpKd1i2jwx6X/1azkE4PCaP6OicLlFAPSboz?=
 =?us-ascii?Q?L8dYkZ0a+ADfQxVHa3Qpu3y6gh3M3hGOLI81WnKrIddeuoDRA9nhtu+i6XtU?=
 =?us-ascii?Q?siacELL6DMJyxAW+MiLwvUOLvj41tNXjFQOXm21FCSPOtRRvXPV/OEBtPiSN?=
 =?us-ascii?Q?PPCnLAIfIf1Ii4JWwix4XiFe32K2k1Wi3KH6ZHC8cKjPoEKISq8ga6W+S1hx?=
 =?us-ascii?Q?45Z7jTnUpHEZL307MqDi1AwWd2j5yyhwz+TrczAMrNyMB6eRrLvKiouYyBH6?=
 =?us-ascii?Q?7tx0eZg4Q3KOkOrdhIGrfJ/9O5yMJgoCydOeBPsjc9tWN70J22nt4L0QkLvW?=
 =?us-ascii?Q?h9AY4sXfAKFqxRNAnQip+6HIa3m747LmfbGRcXD9+jKNaXAF0ezwioLGETyp?=
 =?us-ascii?Q?W/jC2rV83XiRRPr3JAl9SH/ZnSjR6ZTYwa6Cppaz04XFCt/5vRtO1tFMacCd?=
 =?us-ascii?Q?cX4RGFfgqLFgFxanNvwVRMJi5mf6+jsrA3QRJaC43EGamPdHbDaUcnjI1mhd?=
 =?us-ascii?Q?b2akDje7p3lENk7R961zCwChExQ4IfjmRKQRdZXz1QNKHRY5ajJxWZaoUjI8?=
 =?us-ascii?Q?B3jovq4jN9+o9q6G1KkgHs6nwFrQN8HL8xdHNpwL8Rnfx2Du6V5IPa4Bs841?=
 =?us-ascii?Q?VgcioH8SbZlCtub8FlR79AgRPy5SbCWcNRLx7pNmUpV/SSHEQ+uw0q4GB9iC?=
 =?us-ascii?Q?ExU11kNuwE3eLwDvPxI9PNKt+IaSHeMEOEYFrrL3m3UyMnQdPrZEVY1pWuDU?=
 =?us-ascii?Q?2jduq7DeLkUWlgNyvaNcMiLUfq291cEjdzL95lej3DFj68KbxRGHGwoIJZI9?=
 =?us-ascii?Q?UyAGZtcL9qL2GeO8if1/vzhyXuzx+qXVM0LAjdexQ0aeMM+stNcVN2BhCOcX?=
 =?us-ascii?Q?NmYqGTgae0VVsQuYg5BW81X9SHSBt6AJwgvgq0XY7pDqNFPHiezpPr00T6HO?=
 =?us-ascii?Q?zpzLW9FTse1WdjnKpkRb8ZBj9Rj5svHdTXt/ufsg1kKO3Mu88w0ACm7oirGR?=
 =?us-ascii?Q?oFGwY17vI7QY/hNxMrVXtK6EjaEWg8MBN+GP6uF+A7nomI/UDE9zHs2rDrb3?=
 =?us-ascii?Q?gaVp7IC5ndJ9Zjk9BAJNbaV8muXBQ+OwzDZbfKse?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d4e5fd6-287d-40a3-db67-08dc32b3841e
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 08:02:57.9472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VAZue0ytimOtA61t/G9uJpM/V+cvYyZUqo7hfbx4YxSajDsxJ0sQSCVQ4HYQAd2iJqwCqccoaSvGmcnIXRNM3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9770

As more and more NXP i.MX chips come out, it becomes harder to maintain
ci-hdrc-usb2.yaml if more stuffs like property restrictions are added to
this file. This will separate i.MX parts out of ci-hdrc-usb2.yaml and add
a new schema for NXP ChipIdea USB2 Controller.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v6:
 - new patch
---
 .../bindings/usb/ci-hdrc-usb2-imx.yaml        | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml
new file mode 100644
index 000000000000..2ec62f564bf5
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/ci-hdrc-usb2-imx.yaml#
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
+allOf:
+  - $ref: ci-hdrc-usb2.yaml#
+
+required:
+  - compatible
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
+...
-- 
2.34.1


