Return-Path: <linux-kernel+bounces-109766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8C888556D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A16451C2132A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF5C78268;
	Thu, 21 Mar 2024 08:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DafXXMJe"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2059.outbound.protection.outlook.com [40.107.21.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCE077F3B;
	Thu, 21 Mar 2024 08:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711008889; cv=fail; b=fhpzR+k2J2ptSojr0oxtme42j/LJgmeYO9NqrWI9IuriXiDoUufW8hs2M4iH7GcmpqWzJaF7+8uQ7sLdcJdcmumCJNIlIF1NaQ2zLpQrVHzk2O+n1wjXc/VxWNpl776gppXkdm35upkvoYcVSuwCOM38Aj3erQiIm9YgAzrn9ZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711008889; c=relaxed/simple;
	bh=HKgAzNYtDyIQm2RhMYsS5+zUBF+JVmrUYz31el0KN5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ND4yyZw0LL5mrsSconCPWpQZrFpt15wkuZ6BJjEuPPZLmfPKLuQvcrR4sp2UZQEG2RJ6OZ8nvELkOKTuGoiqTRJeXlGae/94yrsVZHqv0hvtWfeLTmbFVt+E/+9vdsmBcicZL+T22GBUrNJ+gzTZ6f4ounTjJeHy9WTaYDsEaE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=DafXXMJe; arc=fail smtp.client-ip=40.107.21.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SwybwEykkNcnhDtmP51+JNiSRwnbyHPujt+2WJJDpD6JPOuiSS992kDO158tc+ZZM79NAG9QZph5/sqs7WcscSBmNYBGmii4gWkE17G60wOWX0L+vIcUuBQHjFP7k1I2LU8deSa2yfzKK/DFaIPJahL7QWz8tOS/9LxT0nYgFDmpbzKRUtt8ASPx84Ucw4XJhctMRbcHWJZZ4Oa+OT4JpxpGNwOcv3s3w+m5dEWEROSqq5A3U2UN2NBeHrLjIovCvLzrsYbxyf1yAc+zD0aAjTnTy3hUKqiVxo61fZVWu1SdnTWJ/X2WxfKF1GDyEE9G5mOFxtVxxya8j43SRDdhUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2NJpTRmPkwFMb95KaHsNw4/4jsuJe+h2oKUJPL9b7U=;
 b=ZhMBwifUtoEvUvNHuT6Q3nU57NJcn3/9/mBPKXa0DdwQJeJEh/qUDKSizBKhhLGnT35ERC8K6NZJSehZ8Te1jW5shZH/JIpFTtoUSWjAnyn9RelXm/Vvl9qkDnKxphmdhLQJHkyF/HPOB+oOayhmt3Gcshvmv6Ud7wIzWkT0QA3TDzD2kBrqLz7Nrx1c8GffQpcMabfxnmQZPaCaaLCvXmfA/JyLSS+PIi/gpuKgCuWZ7u1H2KSUPJrqtnqBZziLm8pnIibKsRJC7ro/Z0RV6w/MzTtqITbEDEU1gXOh2en5QjoxPGpOyrE7N1D3oO5kgN+r/HZpUeY2ZoSDqjXxVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2NJpTRmPkwFMb95KaHsNw4/4jsuJe+h2oKUJPL9b7U=;
 b=DafXXMJewiVhZ6nHLjRN/sKosfGq6jsnyRmD2uVE7xekuEzWO26LxeKFOGJo5e0FzJdxGbq4pwYs2JoLwXgXbFaRBrhPUaytOPavqlmXg0qHJMnLhkj7mZ4HZctY6AeZ7uDUC4KNa9PvkjFmTHUUi5zHYrL62szjMaNg0uPaNrg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB9191.eurprd04.prod.outlook.com (2603:10a6:20b:44e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Thu, 21 Mar
 2024 08:14:46 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7386.023; Thu, 21 Mar 2024
 08:14:45 +0000
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
Subject: [PATCH v10 05/11] dt-bindings: usb: ci-hdrc-usb2-imx: add restrictions for reg, interrupts, clock and clock-names properties
Date: Thu, 21 Mar 2024 16:14:33 +0800
Message-Id: <20240321081439.541799-5-xu.yang_2@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 78a379e2-b021-4fd5-7984-08dc497ef81d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6hlQN0UI1QbtolXTLa/m88l9angV0qV8waYGC6IepxrRv3yYlJoIprfShh+cbioGG+WYXVaDUkyAfgA+fzBP9SOhlg6tDHdy9BMrpvaweAecikb1n9pIyfvbG0ilqC2dZAjT8ml4B8PZ/x39oo5fwYnclCGOCN2KYc/JRNDEhd+6aC4ix+KpgWKFERU0MlhoO4Zdb6HEvmvnkSakAdCzRZcAbp1zNKcd1cVjVVkxbQ+XwX4h9elfBRC0VaHhgO4JVm8ywAe+TEyMGCsvVvyGYmdLWX0Pub0RQUl7PqjEm8Z+nw9vQodhHBdMflJMrlIL+1gNZ8rdyde8FZ7nxajlQHi+YMVKb7bO4fF64EqqFJdNj9+WNUk+zW6NzHwoll+3+12dYVhWAsjItiYqz0zSRQklUQ12lB5ZNgGQ2qH5nblbw6rY4njHIrZNpd9uLXf7OxIVqYk6GK4dMJ4LjS36TuyMC/78doLdWyvnaMRbHT6PQPSsPvdf7aFwYHuvG4kMWeH71bZxNhgC3Wb3S6Oyc5LnwkzOHG9q0GAks4M2UvXOwcERjJPngUx3lrn09+rk3u9qX7DQAV2jq3FTNQTNwwjjCAIpoed5V6a6/E/GmIKEOC/2OyCC7MKhj+xeD0N/ItXTaSNjoQL8G0sPYqS4nCs7V75Kl6tPAIKLUnOfSXZZJdFPvdsd/952Jbg9uA3QDUi1yfiRJ6wO8CA0r6vgeTkfPe/jWiwM+slw4N3xP9c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(7416005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+EfPj+eCJOBRnwXfLaSH+5hyfBHLVLTxI3yvd/xgySCXil3l1N3hZVL44rUs?=
 =?us-ascii?Q?0+SrD/6F+WKTZUi/Ktt/EL1gby8wiyJu5LmZynvnILxYnkUUI359Yvs2vlMG?=
 =?us-ascii?Q?PE6gmfI+lNxnw8PrDIQE+QgV9QhS8jy6hpeXDp0qrdrfbNuQB6Q6f0OO/2Xi?=
 =?us-ascii?Q?qSspBhNADQT9BAKCRe+4gFKiQU9lRrsJqVECmrGQTETra3lZvNOVuI2FijIT?=
 =?us-ascii?Q?RXx3Eq+0WJYr4nLYZ08/Z5m1oRPtD78pD1oz1zUABax4ye+R5v859ibgPK//?=
 =?us-ascii?Q?IGrc/B7Wf+6KcsNsZ9tqb2Izv8QWKtBEz37yYQRUy0RUntLyLmqWG9ebzzgN?=
 =?us-ascii?Q?D+FBxU/Xg2w5Fpd8S+W9mNUVh6mCDdaqqi1WogQRoGQ4Qp8qyIy0FL5LUOWy?=
 =?us-ascii?Q?TcrM5jxt2f2HNnSxI0W/TZpEFMCxXzdS+ic9N71IuOQN6UrP3S7U9fdYPGZ7?=
 =?us-ascii?Q?Z/MGJ+usCDq7wTXXbeiAxDN/peQdZY0YDufCtLLXPNlN6pM3J3DHwhD+aOs2?=
 =?us-ascii?Q?To80b3qjv34uHC63b88+06/ds/OJE7IQ1C8ABVTckBhb/qSIvvUn0h7ErZHd?=
 =?us-ascii?Q?t6h59+r+QGNDyesrkhjSlGiBUt4+/9KAqZ+OGWbPN2TDeFufXUBXG5kMpbUL?=
 =?us-ascii?Q?v4dDgVcqpIWKcqQXY4/Y4xGXazE/akUK78ADY1b8OLkxiSA9TpjdUeJRMbgq?=
 =?us-ascii?Q?aoRaSL+Gpw3Y3RxpnNqcfO5HLz2MYaXu4Ajq3ySMPu/ymcu2YhBp+mp4L5Qv?=
 =?us-ascii?Q?EeGTmtIe2d/tWwBieX15oiKfdoN+uf8zqub2z3Dlad7XQ8ACa9ulutVjiaQe?=
 =?us-ascii?Q?cApYebb0ffoOxJq4iYqeiPbXf2jzgEytLVZYRJQyhfWl4JsO1USJNwSP1+5Q?=
 =?us-ascii?Q?oXLKT1PFW2gadDYlSJh2OWVTv0hi25M7rTCvMsW3gsKngzLj+KxRIhx2yLJE?=
 =?us-ascii?Q?KMsm1TticOMctaMmPmezDC2JCBCv7Mg8hyND+uee4keCZpEB5wpHDBaOhd57?=
 =?us-ascii?Q?9Igmr5SIeuTkKRiCxN59EyTv+fOU+37Qoq3G2Dput6W1f5eqxSzZRJgcdLqz?=
 =?us-ascii?Q?86wwkHQs8LtZZq2MEEI0SbNMZ1D0rP0ykglwO9kbI3AhoaVHvKoKlRZ0vOo8?=
 =?us-ascii?Q?BbaNTi3CMLrqYdzYYX9xJfO4PzC18Q14FB5mbfvXiTG/5yM3lUcOhBj+soBY?=
 =?us-ascii?Q?gDIBaRn75seQoxDe3sZwDwNry1xGWpZMeNrvEm9gTpUogPiUIPj8qFC9qO4o?=
 =?us-ascii?Q?yBWS1bbLuaGanK8f1Y4Op1dkAZpPmeMF02n4tZj0RAxRSrSEDgbYiSNZCoNM?=
 =?us-ascii?Q?ST5wPwrcTiQN4EeiUi533f2Glw1D5C62qmZZOYjya+CPSQH+sGvwqJhbua9p?=
 =?us-ascii?Q?/eC45xGCGkq/Q6HEEtaVnaD83mZkOE1SfYFwEck0V7yQ/8sfNAijbBGlzC1h?=
 =?us-ascii?Q?jM1IqUODvRu+lWhBiV8B3/s4GKTB/4VEnFqi/QUsqyvR9fZh3clkXgeiPCOr?=
 =?us-ascii?Q?y6rKXjbKEfur8D8y8pWLVrDNeUxLNpjRYZejJLmOmAM8l5uIBEPlHck8i5pR?=
 =?us-ascii?Q?cc9fcavjy9H4/WMPjXEe0GdTL6j1wXCu9BzkNAd+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a379e2-b021-4fd5-7984-08dc497ef81d
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 08:14:45.9114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gwQ87NfnwijPDB6QZR7lG6ZwDQJNkFD+sTt+8mWswOZY2O2z4OomAVZ6i+0NQpweZpgIjuu/sl4JQUTQ8JBAmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9191

Add restrictions for reg, interrupts, clock and clock-names properties
for imx Socs.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v4:
 - new patch since v3's discussion
 - split the reg, interrupts, clock and clock-names properties into
   common part and device-specific
Changes in v5:
 - keep common property unchanged
 - make if-then more readable
 - remove non imx part
Changes in v6:
 - new patch based on ci-hdrc-usb2-imx.yaml
Changes in v7:
 - no changes
Changes in v8:
 - remove if:else:if:else:if:else block
Changes in v9:
 - remove maxItems
 - make clock-names if it's not needed
Changes in v10:
 - add Rb tag
---
 .../bindings/usb/chipidea,usb2-imx.yaml       | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/chipidea,usb2-imx.yaml b/Documentation/devicetree/bindings/usb/chipidea,usb2-imx.yaml
index cdbb224e9f68..e2eb60eaf6fe 100644
--- a/Documentation/devicetree/bindings/usb/chipidea,usb2-imx.yaml
+++ b/Documentation/devicetree/bindings/usb/chipidea,usb2-imx.yaml
@@ -49,6 +49,12 @@ properties:
           - const: fsl,imx6ul-usb
           - const: fsl,imx27-usb
 
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
   clocks:
     minItems: 1
     maxItems: 3
@@ -144,6 +150,76 @@ allOf:
             - const: idle
             - const: active
 
+  # imx27 Soc needs three clocks
+  - if:
+      properties:
+        compatible:
+          const: fsl,imx27-usb
+    then:
+      properties:
+        clocks:
+          minItems: 3
+        clock-names:
+          items:
+            - const: ipg
+            - const: ahb
+            - const: per
+
+  # imx25 and imx35 Soc need three clocks
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx25-usb
+              - fsl,imx35-usb
+    then:
+      properties:
+        clocks:
+          minItems: 3
+        clock-names:
+          items:
+            - const: ipg
+            - const: ahb
+            - const: per
+
+  # imx7d Soc need one clock
+  - if:
+      properties:
+        compatible:
+          items:
+            - const: fsl,imx7d-usb
+            - const: fsl,imx27-usb
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+        clock-names: false
+
+  # other Soc need one clock
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx23-usb
+              - fsl,imx28-usb
+              - fsl,imx50-usb
+              - fsl,imx51-usb
+              - fsl,imx53-usb
+              - fsl,imx6q-usb
+              - fsl,imx6sl-usb
+              - fsl,imx6sx-usb
+              - fsl,imx6ul-usb
+              - fsl,imx8mm-usb
+              - fsl,imx8mn-usb
+              - fsl,vf610-usb
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+        clock-names: false
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1


