Return-Path: <linux-kernel+bounces-132317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D80AB8992EC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 03:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70E3BB24F34
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 01:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE85917753;
	Fri,  5 Apr 2024 01:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Z6mF+gr7"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2107.outbound.protection.outlook.com [40.107.247.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C57168B7;
	Fri,  5 Apr 2024 01:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712281903; cv=fail; b=qSlEBuUtalcGCCxQ8QYrhKTaAA5BMVbuV+29iaNMIsa452epfsuvM+9/b03+SPPZsCLOQE7L1/H3cPuuhhDED4lzNTKSgRI4Lf7jYtIX+3fdxWWRu6iRwohK50ULbKOw4i84BwDNe83BF5pjBTNRM+39g+j0X7JgC89YOyeceD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712281903; c=relaxed/simple;
	bh=VyUgp1uqg2sd9efaIWkIGYr2e4EYKfjV9z7DdHViSYo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=uanjRVhdXii0ojLBq8j6/n/ipRWY1gSgT1+J7Xb2hwalcNcwxkA+Dqq107G9r0ObQn7/SJhRdy7J4cUWvZ9Y6UEPMN0v/bb69woxZQmIpcNMjVo1jGn9548jYx8k2KKhUUlCOWvdFkD7VVyJZgvrbO9nbmEi5f/J2fu0nRaSNkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Z6mF+gr7; arc=fail smtp.client-ip=40.107.247.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxKpsBf0zWtVP97or+M8KJAfgSxLkTt26IKCnXDdu1HY/a0JUBzt/OTO3Ggmza4a4vfKxb3pl279WNINIPJ9ZM2J7oRZ+BuydxfO8DnxBV3edfXFn5WzDDMpmrKc4EUbY7/ua0sN/7mVsadTYRRvxSDqsjWeoWUgK+zJiARbU8MHBuPopM3+IWEglf5rkYJlrDwQhfxyQukS8OZ3q+GcqsVyU6+daITA8bIUhfp5uKeRWPLW3gyqyZygaOIXSRxgVrEVMYDgxUQt1YBkdpKfYkAg4qbmbGTqxBbVPfGDrG5KnDdjaMfHI0/MO2kCeNAUFKdTF6tOQ+IHrS0p3dt0Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/BzLovi5aKNOiOuw8s4YMGfV7RBPkidh8VfX3S2pYQ=;
 b=GDlMpZLsJJ3MZAi3PoTN6Udsa5cwOS4iCZE06htIl9Kg7zQNfPzh/uJEZhpLwCmOKtgRzdemwCO4ITA8ltQlZax+xgxazlqUBJfxBU9WlMeLdlmSNXzcofQrGTOoL6T2J9MMXdRA1vV3Xu07Q7ju1Twc/aBtSnSjEgCW+ydM2MQfvF3kzeHKIc5HgnNH1zZAEOT3XcvXW39r03YnOv4k/p844tt12YGwRQa+vaMHdy6Gw291J0mSDAyS0XqzlX2D1a4XPHtAf2QMpWCViE7U8KaRFMipdDJ9qUcMdZxfTKdyG9i6n2XPr/UjGS2VY0HPb6CvfoIera3/ahWy9OVM0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/BzLovi5aKNOiOuw8s4YMGfV7RBPkidh8VfX3S2pYQ=;
 b=Z6mF+gr7BbXSr+H9yoNfUxdlplWIEpRY5Aq4ApNaNPY+t7ORnO4AanVjqKXGgiavhac/xuiSCI0bwxs2IYs3oO5PMeET9xNoc/3SWpNGu/oRCtns26wrHUPjiqcK04bB8WzlwlGECeMd0ZQ8DZuik+d8eYF/r7I6wx91t0azLFQ=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS1PR04MB9334.eurprd04.prod.outlook.com (2603:10a6:20b:4de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 01:51:38 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Fri, 5 Apr 2024
 01:51:38 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 05 Apr 2024 09:59:33 +0800
Subject: [PATCH v8 2/4] dt-bindings: firmware: arm,scmi: support pinctrl
 protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-pinctrl-scmi-v8-2-5fc8e33871bf@nxp.com>
References: <20240405-pinctrl-scmi-v8-0-5fc8e33871bf@nxp.com>
In-Reply-To: <20240405-pinctrl-scmi-v8-0-5fc8e33871bf@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712282385; l=2362;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=1H2rME0+2KWUaw0j7tYsXFokSaYx/bEPhCjn1uDoVYo=;
 b=BUg2Cj4WROOGS5yaciuXQoewxdfbg74i5cVScjfGO+Sj5vomm0JEOhabackVE8ZtBVN2UbgQv
 PU3CwxUabP1DXjMNnwwj8+2nYHZNcbdJv4mld2rtsaL5vzAsVWC3xLe
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS1PR04MB9334:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	So1+PPKJB5KIPLEJc9gt1uj6emVSWX1IrxMf//nOK/mDfmFEyWm0O3YXxpcvE5EnOobm2qYLBiPqoRQ3DoHge7UeHQGEV25Rp6qRfxrCnmNF6aSBwZhwnsfpfAxEL2YUti3e0qxqfj0N5yS7sOWzQMw2kr/JamkFzdZG1+QIRr1gJP0v9yIahNHKbnD5b5VgHu9PPWiHvFk+WZTQDwfknhR2bCUq5eBg6LdZXTAb2WLi0h3K9PyaSNqtPro1lk5/xLR00suH0xbOPVi3qj9vJArCP2Dwq4ysHOrS1RusjT0KtnSF2c3gXp2mSkdRiCqT19rMyXqcJ9mKBuIcN2G935EWRlCxC4Hr9WptbgsiVu70y6LQIr2e3i/ML4+7ZU2Hy/Kj3+7pL82nVGxAjJTDo/eYLHPc+BtIhG0Z1dTYEVcFIYxZrBxvCMoQqa22BOgdyRx2NWGXBy8QrCBZPFNIg5hCtD27+GvzIh2fivKSNGxB4MrhLRes3JmBvV40Fh28eOPvSjtwSqPJY4SX4+qtADsMJtllFGrLww7IfXjiBqqb1IdmHg0Rz4mqHo0tbVxvlXNpAH3bw19mIlQhYz7aHsmQmOq8UfP9DETP0kHfeF8ZBLMeEPp8Uaz572W/RmdnRXTiGdegTqMm3kj2nrGB3L2ehGYuOK/jFmodTCk+r2A32a4X+EOQWuzY0r4uboMJpXi98Vbcrj9IBj5kDIfDka0URgR4axQ94dQOBmNipBM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(52116005)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHRhTWkxWHo5dnJoNzQzWG9yeStXdEk0V091dllyL2F1MVpWU0hVcy9abml5?=
 =?utf-8?B?bjYyK3hnWTFYL1hxdmZIL2ZlRmY1ZTZ0b3ZwOGczRWZ0cUp0b1pud0xEbUZ5?=
 =?utf-8?B?Nk1LaGZEYzI1TDBLZmpKbjdldFR3RXJpU09UZTNrKzZRNklLakVnOXBjNXNi?=
 =?utf-8?B?eThpSVlmazlHcmhJR3V4dStYSEhwVVpTY0pVdVlVUVhpd3NlalJKejdFN3RJ?=
 =?utf-8?B?bVk3dmQzM0dnZnU3UTlSK210ZTNqVkU0WnVmS0J4Nk9IbHNDdmlsVFNrbHoy?=
 =?utf-8?B?MkFPazc5b1JrNHBsRTNzTXk4Z1hZNFdpeEVtSHlaWU5oTkRuYWhqQmp2Szh1?=
 =?utf-8?B?SE9ITEl1SmMvRXMrUHFtWktJNnF3MHpMV1NPYXJ5Y0k4Mk44cjBzVVRyQUl4?=
 =?utf-8?B?Z3VUaEdraUR0Zm1WR1FuemxpaE9XZ0RJaXNZNnlCVnBjanFWQVBIL1dnZ2dn?=
 =?utf-8?B?QTFhQ3pHQ1RXVGYxaXBHMms4VjVCbXU1clRFZmEyQXRjV2FaN0NWN1RORTlp?=
 =?utf-8?B?QVVPYXdaVm9CVFhZRUEwbGI4Q2kxR0x5RGJRaGVPVFgzUmo1OW8vNDhyaVcz?=
 =?utf-8?B?T0x3dy9WYmhjRnZ5ZmpDbUk5SHUzRWI5a0o1TWtiSjZ4Z1p1UjhnSGtYNUdp?=
 =?utf-8?B?azAxSzJxQTAxMmUxVDB0WXg5MDZvcU1iZ0lLMGRqLzJCRmFVaTBsQWJVaWVr?=
 =?utf-8?B?YThlLzdRaHdKSXZ6Uk5IYVlWdjBnajJmL0hnV0RTaUJ6VWhRc1pxbktSRjJw?=
 =?utf-8?B?TEZZOUloZXh3cVBlTzZIaXN3RXFPaElRaE1takI4TnRwK1RwM2VZQjIxWmRI?=
 =?utf-8?B?UEQ4NlZZUTIzblVlT1BXREVXakxmVDJsVnBiMEpDZ0x3WXNXTjI0RVUyVW5S?=
 =?utf-8?B?cXlYeXZHY0M4M3Q0Ni9kQzVUMzUzMjFrWDJ1RHN6WTEzYm1BdXJVSXJ5bkYx?=
 =?utf-8?B?LzA4RFdjdnNYZGRJMjN4RG96TVEyLzJlZlBTVUpDTzM4MjgvQ1FEUTdJVVFz?=
 =?utf-8?B?aUtjd3RNNzU5QTJVZ3J6RHBENEY0b21RNHhLdENFSEtoZy9yZXd5ZnkvenR0?=
 =?utf-8?B?NVRtT1VMZXBhRUdhSGZJK1FlS0FWTXZCMHVocThyaVFETGVjcUV4dGdPOHov?=
 =?utf-8?B?VGM2V3FLZlZQZlFxUEpiVHd5emtMam1rZys1QWJpYkF3T0RieTU1RFo5bTky?=
 =?utf-8?B?ejRjVDlTcG9DdlJzckxXOCt3eTFvb3BrZWxHSzI4Ti8vd3hXUHROUUV0cHFu?=
 =?utf-8?B?NkdJM01ZRmpLMjFQQ3cyWVhMcEJ5eWNzRnNJUnJoK2tQamJJMzJYWDBoS3JQ?=
 =?utf-8?B?TGZZS3ZrQU9rM2o3SFY2Q0kwSlZUdVhrQ3diRHFHOXJjSHhneE1aSFVqZXFH?=
 =?utf-8?B?cmV4UHlUMDNXNzh6eG12Zk9OY0V6RW9iSis0cktvSVJhVjhxZncvVGpYd2M4?=
 =?utf-8?B?L0VvclV0V1FaTXF5eVYxb0gzZjl5alhjSUpkbEgwcEVBRXdFN21sTzAyazNS?=
 =?utf-8?B?Szd1bEVWUlduSjd0Ym5KMDk5UFRFaE1mZ3BsTk4vUVNpcW16UFZla0pqV3hk?=
 =?utf-8?B?dWxDRjdQcDBqT2RoaFZ1SFNONGVNUVZjejd0UW12bG8yNWx1TE5ZcTRMU1U4?=
 =?utf-8?B?YXBoeTJ1dlZiN1VsQ3JPZWJWSHFCbm4vZ29rQThrU1RoYVdzdjAvVXUyQlh4?=
 =?utf-8?B?SFpwNG1aZVFJNUc4cUJNRHpOYmRhdi9Rc1RsOUI3MzZVMGEwNCtsWTAvdjVz?=
 =?utf-8?B?OUtLVG1GNFZWeTZRUERzZjdwWGpMK0I1KzQ2WnhEcTlOdVFDd01KUkhyYTk0?=
 =?utf-8?B?dkoveGxPMzQzQ2VzeE1nSko4anBOd2w4VTBpUUVWTHU5bXJFek84NmM3ZjhD?=
 =?utf-8?B?N1VaUCtFcjdsT0VFdDIxMGpRYzhYdkMyTllyVy9FVzRpcCtXQm90OExvN21y?=
 =?utf-8?B?MGcrMXE2S2k4eENteDNRTjVzZkYwaDJVU2JCK0VONmVBbEQ2UW1iNjFneDFN?=
 =?utf-8?B?eGY0RE12VDZYR0pXMjJSWmZXSzBEV3N0Si9vMklFOTFhcEdHZERBSkhtMVRp?=
 =?utf-8?B?RW5xek5aYWUvNUhVTFlrV1F5K3M2ZGlqeHREeW8yR0FuTC9XaUsrbTNQRERZ?=
 =?utf-8?Q?EObz9CDINPLLNv+3ATuv/BsaG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec8c218-02d7-4604-1dba-08dc5512ee9d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 01:51:38.1992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UJ3b4LYDluYeInuQqhKy82ZqKige506KSpgIVjUSnaBUWmjQ/t26h6KUxbqrE9qI0XLItmqaxUfe6zf1ieF6LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9334

From: Peng Fan <peng.fan@nxp.com>

Add SCMI v3.2 pinctrl protocol bindings and example.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/firmware/arm,scmi.yaml     | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index 4591523b51a0..e9d3f043c4ed 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -247,6 +247,37 @@ properties:
       reg:
         const: 0x18
 
+  protocol@19:
+    type: object
+    allOf:
+      - $ref: '#/$defs/protocol-node'
+      - $ref: /schemas/pinctrl/pinctrl.yaml
+
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        const: 0x19
+
+    patternProperties:
+      '-pins$':
+        type: object
+        allOf:
+          - $ref: /schemas/pinctrl/pincfg-node.yaml#
+          - $ref: /schemas/pinctrl/pinmux-node.yaml#
+        unevaluatedProperties: false
+
+        description:
+          A pin multiplexing sub-node describes how to configure a
+          set of pins in some desired function.
+          A single sub-node may define several pin configurations.
+          This sub-node is using the default pinctrl bindings to configure
+          pin multiplexing and using SCMI protocol to apply a specified
+          configuration.
+
+    required:
+      - reg
+
 additionalProperties: false
 
 $defs:
@@ -401,6 +432,25 @@ examples:
             scmi_powercap: protocol@18 {
                 reg = <0x18>;
             };
+
+            scmi_pinctrl: protocol@19 {
+                reg = <0x19>;
+
+                i2c2-pins {
+                    groups = "g_i2c2_a", "g_i2c2_b";
+                    function = "f_i2c2";
+                };
+
+                mdio-pins {
+                    groups = "g_avb_mdio";
+                    drive-strength = <24>;
+                };
+
+                keys_pins: keys-pins {
+                    pins = "gpio_5_17", "gpio_5_20", "gpio_5_22", "gpio_2_1";
+                    bias-pull-up;
+                };
+            };
         };
     };
 

-- 
2.37.1


