Return-Path: <linux-kernel+bounces-74169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A22685D0AA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16F2B1F23C16
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F663B19D;
	Wed, 21 Feb 2024 06:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BzRQpNhq"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2042.outbound.protection.outlook.com [40.107.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D474E3AC25;
	Wed, 21 Feb 2024 06:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708498315; cv=fail; b=XqVaXFuYnDkPO9383SAhzsgEEBQQWAgJB1hPY+67Iub10O7Ff2c1f1erWwGXJldu6K6rvM6pSF5OCmSkN5uKvtLjDzYl+xtJ0Y147jPn2yc6fjcaeFFiMsEp8DQGpacb8CodNsO1jwPENWbdG15kdzU3T4YZYQGz7fvZLXrZuUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708498315; c=relaxed/simple;
	bh=zoB1G40HMGMaUnbvkdET6FupLf9uQGhM6mAxm/eXZeI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pCdAJ9pCiQymPN5vGDsSnCFLy8oVit0kBHV8GnUa1mWmqC1bnR0QxsZaGE1s0y+88l6hHoEPUZ+0CxmbgIK5jx2IhmgNkxjs/7h6H99NSzqRNX2w5gsNvYLkEGlGeXBbHE13+6tYbshbsgeweVpKiDX3QRnQ+4YdRzItjhp9qCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=BzRQpNhq; arc=fail smtp.client-ip=40.107.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izT7RGscfNrSXZ8Se6DW9Mb9tVbbmOEN9C1n8E3ghGFQ04RH7zCIXWNo9KOmeHHLZvYcU7TKX78lAigcGaTBuKQp9ASAr7QugtwSZXD8Mkj3mVEqAOZw6KSzEBwLEbDeM+UjalPssFRcOoGYFzqYaMdtw4QuSN08LDuYd6ISYWA5qqmsfab20NeRUW7ZOOAfACHgFyg1BFb9TRla9d26qIHw5uGA3U/PSHSmG/gnE1FXx5uMOgOkO/KxvVdP/9603Lkcm1NhgGDHaikP6gp2WHCP6DLcaK8oe+ZlXbIOEQsvHxvNPjwv77zKajWRmTljIQqoou9CNfREGWfmHom1yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Efo77SPUftdc6VSRPIBJO/of8Og+4gFvmQDRGFG4FDE=;
 b=SbpeD1674dcfMBr1u8h21v/0rUeX6cJBV0qXiz09UEPijBr9CdssXC5FQyWoIX0qUyKuaVGDCrlVcdeGCHI2c/wzRNDHi5AUqvJtAC0m5CfXsui82unatDZNBVJ++Y9mXWa6vyD5pb1fejxtg1IzxaJLzHnluZmKtjn/ZoNOltT5beokY56LMtSWJFy2gW2IiVUVgcTv9OoU/nOJ0dT4rd8yHCPTXKycpu+TauuJ3YofFP+CJGArs1kx4/XGSoX1Vyi25tYfDg6MIg2Mtx+yy3wUF2i+8PpOAfdvdP3lFQ6JDXNzXJqclT1FEdkSWQKO6b8mmdNwhrBA3weW6NTzNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Efo77SPUftdc6VSRPIBJO/of8Og+4gFvmQDRGFG4FDE=;
 b=BzRQpNhqKDhJKjCZwemAyoKK0w2J5raCPc/DeNC5la/hszV47b6qEUFMib60hzbK2tjjCKiQAcrRKOPrZJw6bnXYa1gqs9gg3f4q8jfSY0H0xh22/QiKL9HvRqC5jGQnaKhQkDA3aPTKJQkhgtcNvNExNZWMwsbxgnRJNDUi8SI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by PAXPR04MB9304.eurprd04.prod.outlook.com (2603:10a6:102:2b6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 06:51:50 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7292.029; Wed, 21 Feb 2024
 06:51:50 +0000
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
Subject: [PATCH v6 4/9] dt-bindings: usb: add NXP ChipIdea USB2 Controller schema
Date: Wed, 21 Feb 2024 22:58:41 +0800
Message-Id: <20240221145846.1611627-4-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240221145846.1611627-1-xu.yang_2@nxp.com>
References: <20240221145846.1611627-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|PAXPR04MB9304:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ea61284-dede-4a24-4131-08dc32a99446
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	J5L8OSup3E+InYyi6MQtWnK6Kmw8uVL5Bmm8zOA1J5fUa7YUkwHXvLBQncovokpOFdhlMchl3ByPaVzigaJS8Lht57qngLTWZkCZB+Z52uk5QzpKojmS7ILuFPwzAPUN+GbII4wMqGpAj4wuySZlqjpJ0pmAaD23tbdNnmXpX9sY52DGyaF8iwy5glx/SLAVP0JM4ZRXMnc6Ki5xJYkQ8B+1nI2u30AvStziNbK7BrPdsePd4CPKFlQyLP/3QKTCVzjeVCC0Fhh+Z7DLibkwJWIsNz9KYm3FMu0vjMZjgnC9809EtTdkP6E9gUyzgqir72D4Faz8BJ/n0VoUaqgtAODGeXVkWvyRQ4i/PW0E2gwyYSdSHwPSJypgF+8r3Cv0r4n558c5+OFekl3w4kxwax8NzIbsiS0/3ta/nopp8nK+UobtQmCjk8DPgzhAYG5KIr2bDz2MjjvORWFlpAWpi0JUMNRyHgSjeCQv2Z5TVlII2l2s0VsHG27KHRl4DEUZZkda9qJBKMXNDEWj6o2GQ270ZFHVmpyoL+mHDgqJtiZC0fu5Xp75sIuwwHiCR6MRqeECdN0jFFDaul9Zl8/hVDmmE8T/GGfJT10IDPb5dL8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g4tibJfEXPexFzoTuwm9LfIG/KyTT8qoJKvxg0fAr9tTIgP4v4sCiHb2g4JZ?=
 =?us-ascii?Q?HvHzRW1RmMVVbMx8xcGxQ0EZ4v21nQNXkIGvMvH3B66kWvRgMZGlFwONRrLZ?=
 =?us-ascii?Q?YkvDG+YJvQmWLdZZnc1B5Bym4R6GNAIU4MUXlFBDPi+e3/EUTE/N+Nr7fOq7?=
 =?us-ascii?Q?jbMtnEPW2QaZxcfcZBDtgdWURmbgwBkSf67X0dEYHPbYwvttSI2R+Bo6UBMy?=
 =?us-ascii?Q?eiQ9YkFAk3kN+v0FuBkpdLC8oYN3NOGBPRZow76stLAeiLDzaGHtZcqFkstU?=
 =?us-ascii?Q?jfrIai9h93r0myp6pWAvwd9ROpFDQ9Czc18uxP9KLzTMpe+90UmS7DDY3MsV?=
 =?us-ascii?Q?wPBA9K2DguVH2leS3inIURQqhIJClw+Kiakpfgezk9jHCGrQOz2/4jKoJG2l?=
 =?us-ascii?Q?ioUX/w37naK3UQkv/Jg05CRPKqaUZ6MhPvzSWBrBVWBdK4YpXej6SlsDhdzh?=
 =?us-ascii?Q?T+4Egstx5hDTxgRoJGJYJbOZLezezeOxXTp0JiUiUjxDKtV/VumdYeaOifLb?=
 =?us-ascii?Q?zZkcoodOROwg4NWsad7sZZPZlWvaQozus8vZhpxzJ1ko6T34DCJHyuAm1Nuu?=
 =?us-ascii?Q?nuBi8lhEiGmjEegKEmz1b8Vb7cw4y3psSwG9hb8e+hTmfthnDY2KJzR3MU64?=
 =?us-ascii?Q?ywCB52wlappSxDlG7ZSIfbM+hTFVoy6FqR4bBuOXyFAKj3AohySSQzLYAL7S?=
 =?us-ascii?Q?ALb6U4TdKVq2JtnwFasnMHe6I73+KwJWPg+D1/LCp5CMpCDwxMX0gd24mJDz?=
 =?us-ascii?Q?sPuBpVdpRpmAz2+j3tI84aDhxZVGizANgEgXYfu9GMI2NQk75Pf5vPON7BhS?=
 =?us-ascii?Q?TsdQLbbXErIiG0UNGyaFvz/FUAMJ00wT+33+4cOYMNHjzy/QEmZl+83stjUZ?=
 =?us-ascii?Q?CrFySbCbz/YNDYzbKFOPsqO25kyeY3Yl7bFkrtWmnVV+Et/ULvha4BQUKfOv?=
 =?us-ascii?Q?izRPMgn/GFlxaAd857uWAQGLME7SnbR4390d7sU4Ii9lUwZ1xg84IGZb/v4E?=
 =?us-ascii?Q?IuCcJGan9yZdmdxUYWuqzVPSyx5r4jpkBlzp2gdsrO9eCpvBIx3MwCXWT515?=
 =?us-ascii?Q?oUd++QgqPZp5AUd7PR+2Ajay/i6qVkirIVdaJrLtgrpPiMtyKp7RT7c3Gtux?=
 =?us-ascii?Q?yp9RSol2FpmFx/+0WX0PSUUeNzmzqu/3CYCvfi3LDxFbuQUtVt/+FAAXzZd7?=
 =?us-ascii?Q?kpe7K0U93suoZNObP6ojXq+jPtt2EKuoDQfgrvuTWDcpBGz5w+IQu1O8WS/C?=
 =?us-ascii?Q?9wClpHGFpRCI0qAhIClMYBt0ARCcklJfaHXu0PLzI3dqkn0bWVcLbJammy/r?=
 =?us-ascii?Q?LeeSyzstaMVm0gJWL5q5a+QsSoXKSLahY2tSvPHRa8Vcqt1zI8QRRiGP1f5N?=
 =?us-ascii?Q?Hceyh6FGP7ZK69rLZCK9PxG+Yh7eH6KcJWkP4n9tHa4Tt36FYCcR8eCQ1Bod?=
 =?us-ascii?Q?oxk4T3ik+/xehxrxGt9PIUXP+y+QT7Akc1fpgw1km0flpyhRHx/4SRG5iplh?=
 =?us-ascii?Q?zddgrjbYDJedVjp6f4338QvnsBozSsm/79QZWX6dRWmltQdg/AA3OZc6DU6+?=
 =?us-ascii?Q?cqDYVEKrv7nhk7R+jdVoqKmwEXyB4QZBW8+cmb6/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea61284-dede-4a24-4131-08dc32a99446
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 06:51:49.9852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8KTo4MvLOBC6WHQb85tToVXSx3B79qD+VskwcsQ/iliNHCYN4yyIjppWVF4vk74TFzrMigjMohWuEipVRXInCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9304

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


