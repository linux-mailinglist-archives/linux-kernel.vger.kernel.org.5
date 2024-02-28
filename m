Return-Path: <linux-kernel+bounces-84908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0601886AD8D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FC611F2AD02
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB3512EBF4;
	Wed, 28 Feb 2024 11:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="I1vaSeYd"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2050.outbound.protection.outlook.com [40.107.6.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E882561D;
	Wed, 28 Feb 2024 11:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119810; cv=fail; b=Blzss38uTYAHdLs2HDom59uk2Z0UvtXq42QeTG03PpQdoCxkap1kuBJCB0bG5S8khY5/Zsa9gawb9gv5ak6ulaaPBHjG1whz8jcbY3c2n7iKUjT0pnxdstkisSkU1dzeQZC2M3oXk+eGGakhAXzIx1jGBWE3e4I72EMEl+uJDYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119810; c=relaxed/simple;
	bh=qosfN203+0cL+poBI8ks0uJn5g0DNzAHgr+6cPLQ95A=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GcmFDdPvcQ8kM3VWMsYv0b0N+vQr2mqb08bZxrPbz3Xd2LwDqgeYdQu/7rfLkcptpwG8jPkTB8aVZe3KN6pSXEyQOXnqtdFcIbS6Ng0YyvkaNJ4ORKwuqcjBh7nwEZXOIcjKmjv3WKOT1z1l2p+Ycysgx2xGTJ40L3ud1S6IiCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=I1vaSeYd; arc=fail smtp.client-ip=40.107.6.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwN3Y9uHYJRfMw5N+5BlBxn+iwML1tLrtfori5EVs0xZ6zDWx/k0JCHnFJ3rAu2+IJ4S1BvkiaC6Kbtd9srenO+l/BIVkBxa/GHu+zeOZ895AqoNuj1aJ+NA17vd9kpiTE6DheeI0SNMEL7yql2f1i8jj0Bnh3SnoKuTFW5Hl46gj2e5ZpMQJQFbovGDSBqFNFNz8mR4VvHcresvYf39gRDl/S3mT6gSd8NzwdPNYTOpyiNgvlLKyLeDAkzFp3Cyf52ke4dEOe3fr0ZlZYZNW0Q89IJirdMsFCjNDJSm1+CATWS1GbIiP1/b5BzHyt4d0jeDv24wTdKlfFwFAsIzTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wi/cC+Q5WqnIEavx5IwSB2M0tKFIRYAILoKmLpCQJWI=;
 b=V6NYI2PO0YwKFHDSwnJ/MbhBZOD9OXIxVEhnN/O4lTF5sBqNK1PqpO7682SzUIJhJz0IkSJnaVH6xEIfcLlmXkDcfRLMDhpjHPc9qCJFhd+pPjygNs4ffSRUh5nOJACJmr7kf0gb9Na8Q0EvxPERHR3NfyVIKgLFcPudyKMSGGz/1qQDDhIrKXHjrWcvyzgnC5qnsLZYIkul1WAQPY05+dYAL0g04GhdSoxqnrSWWraje74l7tLHYfE3RGPJroqqxe8DTN01ytkIJIDNQukpRA0DHCad4OJkI97lMU3otx5wyx3jk69fWutb6q2q8QSwdPml5gF+jf64+n1rMEmGdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wi/cC+Q5WqnIEavx5IwSB2M0tKFIRYAILoKmLpCQJWI=;
 b=I1vaSeYdSqGIxBTQspcs6uKbBaOpy1LyLmvt9zc6o85f5sxrrqp/rYbMp2hYCWgKJchpW28vXOs13dfjd/+j1C71ITgzQmWGVfFZVemcud9rV+qb8ge8YGZNppUA6FZ9FchTc+epTbDWncmb2I6GFujDyUppvNp2gcL6INUm9+k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DB9PR04MB9332.eurprd04.prod.outlook.com (2603:10a6:10:36c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 11:30:05 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 11:30:04 +0000
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
Subject: [PATCH v7 01/11] dt-bindings: usb: usbmisc-imx: add fsl,imx8ulp-usbmisc compatible
Date: Wed, 28 Feb 2024 19:29:54 +0800
Message-Id: <20240228113004.918205-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0185.apcprd06.prod.outlook.com (2603:1096:4:1::17)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DB9PR04MB9332:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e49739a-09ae-46f0-3379-08dc38509bff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FNfTZ48gi+JzPjsFiEJf1LS+L1flZHhhqZI0U8FeRwANhTXm40moTpYIme8xaM7Z6WBanDVuMEepulwZHTZ2N/YVmRYJIORd8Js5oztMl7O8hiCIdBWA3uuTsWtofbFO02FZPfxgIsHtERuFcORVGp9ygNBB8/pYbZ+icPcFEoWmdBggLutaTCCslOlSZy7NIyKa0dWK785N915CaGg7kUPu5/LMygnM8erXMDF5kWRg/QdreFMnV3VUmYJlNu4szteB5Wk5X5wDHjgPXxrh1ZawF21PWWiKy+6urwfPfGHYY7Jpcz90VqOW9HjdBzpa9umF/wPhdHibjk9CW9qcPi7FBr53+btpoWwgvgMZBVgFmiYZTWcHQOGqJ24v2FgU0P0Whgw4Uvp4UnzkjKT898rlw79T28LGUp4HAve8DRBFItBfIsJkosrfvNAIvuq9RCzxEuHJ1TVcMy1ePyE9+CAsqu24x3eMMcxwc8Q5NtifveE/Do23puzKaGTRN/io9T1Y+Qj0mBLWodSO8GNLTHDc5BBilc48GePvjSkxlIExAzFxR0oJK1aBC1lu1R8r4UTVxghADwR+CT/3Oq/Cn9I/Jqw5WZLknp+Iduqc+ylcQkC+NpcTx/ImV2ru2nFXFa+ZrRL2XK0Sui0RIDkoTlxcfvA8DgLI5U6IQF4N+79w2ZkXGrjvGeZAQcQLH6UA/jmN2e1q7UP2dHEszD8m1SBLiebj7NTYjl8U/6CSKho=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dD+w9gk1rzQaSPEutnn1PormU4bHB3jZQR4jnes5mYt4lPaJmbdpDFjWMsYn?=
 =?us-ascii?Q?ciSr0TI1dKqup03KE6puCS3SDdgh5CvfiPMSDPpsK7leA/WPR65oof4i+RW/?=
 =?us-ascii?Q?z4NiV8+NI5V50vu0bq+6EJ6R+Xxn3oUaGrddE0l5LJdbZsn8Ulf8WJrVEC8t?=
 =?us-ascii?Q?My+NSpK0FBEFgFIh2+GFYd4N0xjbRyJ2aqkssBjEBO+c467N76s6GRYNWPHJ?=
 =?us-ascii?Q?i1uO7SwBc7hC9ifZcKVIqSMpcwN928Wj6fOekax/LAYoFdCeQmbfNXIftLJF?=
 =?us-ascii?Q?55KMbHJ7WtRzAirHcCeKrDGdFTQ2+/Xv7WfR+MQJj62UMCMVvVFeIqKj+XTP?=
 =?us-ascii?Q?T2WDVx0zffaA7k0hqywQexUtoAE3vfK8iKvNGEc6WxXFm7w5iASM0UiUJtRN?=
 =?us-ascii?Q?aYMS4eGnhxSMGEjFRkS5t28gj9O7tdgHgLDJL6n/svcV0JPXePqSKTlfvR6F?=
 =?us-ascii?Q?rbM0uSWhR5tzIMVvYqBRZ+UDqaEg5ZNaFicRwTK4FfVfJ6/tvUKRnzLvVxgj?=
 =?us-ascii?Q?20A49IfhIo5D/kPlS+AwTjVh1pjg3APqgpPSJxYjDBYkJi5m9eY8Lp8Ss/J3?=
 =?us-ascii?Q?JJq66XnN7nsPZvVyf+Ows9EM/4XEmeoHMNrsxMdvosDgStQMnWbwld9S9rYA?=
 =?us-ascii?Q?8KKLTriBhloIlIH4jVCDuP+C8bIRAjy4CCYt/aKgfBcUjsBnh8AawkhVb+Ue?=
 =?us-ascii?Q?8s6usPFaIIGPdMZJVQqniMbFOyz8tlCmkQIDTUjCRyu/hLA2S4wAZFUoOzkS?=
 =?us-ascii?Q?LTuS4gIn196FTLtwUgMqFbVp2rSH1NxXWWcJO28edEF0VPtjEGkrbW4TVvkH?=
 =?us-ascii?Q?Lh9mbs4gTxfvt90h7iqjo+1ynGpwpTFlSaBDgx+clBPcnO7aPBmZLFTEYlUE?=
 =?us-ascii?Q?+gK97KzuLNk6gbxvVNKwlTN967Guz04am8q88DgwLBFX5bybWE+FeRBGiTjQ?=
 =?us-ascii?Q?/1FJdHFQe95l44wOT+M8pOrRZVND4YcA+HLLqMtOKjGbBVUOs+Qp5W3jJXNV?=
 =?us-ascii?Q?6i5tCkcwyZd6vccKmijWZxIc1ZF8JT7Npo5w4D652bGVXrUSqpQW91V/7wlL?=
 =?us-ascii?Q?psxy8Uhf3WoN1BGgjoFKb9VuWxw0yhYD0pI9tL45UDlCu+5h8N8v2BxhEofk?=
 =?us-ascii?Q?9LLmwMaBecDSTlepEcnbj3/3iq/S1dVXjPFYObSqpzH6SlXA2vARAqJLu/4v?=
 =?us-ascii?Q?y66+0z1BAhzlP5a+wAI7CBeLMQWuca9QH1qBzng3J9scZHx5dg5lFbReVaPD?=
 =?us-ascii?Q?VIHPpT9KFqOxUlOqjUSfUFZ+SUlWUP9V8qtwK7zX2KjevIUlGEHYTtwsOBYF?=
 =?us-ascii?Q?ZgzXYOvBDllshINhw7S4GDTYT4PR2aFqv2Rj1vGCLsHlRf7Ybqml9Yl4dJTq?=
 =?us-ascii?Q?YVUkzow5WqQfWa5URP4ok1w7/5s7ijuvAncPEjVhHspBzgZBZpx76ccBA80t?=
 =?us-ascii?Q?iZDGnXdKq65FKXrPCD9wyX5oXFHqOZ9SmBNimr79q9ewIkjI/z2DRA9zbKWQ?=
 =?us-ascii?Q?BMZR5TUTosl3VhAW7PhtIBx5gOoRPfawJBxbyNaNvTMHLj3gnSO4pjfgrpeP?=
 =?us-ascii?Q?EgPZrQJpvgw/ubBs/cY7x9AW+cYDKCDDVTPPZmmg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e49739a-09ae-46f0-3379-08dc38509bff
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 11:30:04.8887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rhXoLSMXMQrEAvt8Ksxt4VmQibGNuumaXtcZjqDR0aVDYor29ri3VHB9fzcKCabUeqwlpD1RxnU1Nu/ytNDu9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9332

Add "fsl,imx8ulp-usbmisc" compatible.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v3:
 - new patch due to missed this little one
Changes in v4:
 - no changes
Changes in v5:
 - add Acked-by tag
Changes in v6:
 - no changes
Changes in v7:
 - no changes
---
 Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml b/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
index 2d3589d284b2..0a6e7ac1b37e 100644
--- a/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
+++ b/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
@@ -33,6 +33,7 @@ properties:
               - fsl,imx7ulp-usbmisc
               - fsl,imx8mm-usbmisc
               - fsl,imx8mn-usbmisc
+              - fsl,imx8ulp-usbmisc
           - const: fsl,imx7d-usbmisc
           - const: fsl,imx6q-usbmisc
       - items:
-- 
2.34.1


