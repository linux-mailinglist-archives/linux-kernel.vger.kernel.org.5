Return-Path: <linux-kernel+bounces-142512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF1E8A2C9D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3247A1C23BE9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BEF5491E;
	Fri, 12 Apr 2024 10:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QG9E4IAI"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2059.outbound.protection.outlook.com [40.107.7.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD7144391;
	Fri, 12 Apr 2024 10:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712918371; cv=fail; b=jDs931XlUg8pBGrftRF6HPxOW+7Oqbv9FbaJVxoNsyI0VTUpKEq0oJfjzMQ586m7UDBtef9ow1p6luNfePRHooYF2JAB6hjgwMWpdAr/ayfDRhFkcXqskEK5nvzgiyWV1cc2r4iycxw1/g3PEMcRW8QkHArqQlbpuG1OKwZm+HU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712918371; c=relaxed/simple;
	bh=L6mtIgfApBmmZ5IfxvjixCiu2wYEte3cXGlY7EExcYA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VpASl6PA1+p/NQQ7ZOK222q03bHWLuwhNDB5GAvy/R7yISxSNiSW8T/d0H3d/bFQVL9+rylwy2u22Vqp/bxH2bvKJN8O43uvU7/f3jvMYQ94YtObFhwTbTRcGtAgsdQA34b6HC7scRo25324GdaKeDvhwcU4XA4NWIzDYgNGAr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=QG9E4IAI; arc=fail smtp.client-ip=40.107.7.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqWA7F5uo3P8h65XynFaitdDp5nPOO7UNqR/9q6Oc2k0w3LsiJLti+VuJZoqZAqa5b6uGd/fkpxbyOwGp2wiHAs0vWVCTIMtsEbHfjKKZCe4q0rC42aYekeIlmu2sDuL6Q7e7p9tsWDoFVvrkcZriNWFdXDrQz+Hon8TgFF9DRTNQ1A9JpPpcVdUuOTyNGzSOqa4pFg8qpk5Z4SeN6flshZcGs2j7L00fS3gZGaCUCK3NDA/5+urwyv4c0iTpH8nEClrKzWA1W2SmIMbzPU9HwFvEb9HS9nsae8XJ4PVUvNbiKcJKpkMALwu6W7MUfB6DJ3qD+ydI1QGjrY43YqCzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7F6ZhX6iuZZeC8ehCng386DvE6AU7+VQse2eQzKgOA=;
 b=B+jT22uWH+VtK1/t4em1oE7zSUBX8evx4AwO3uCnMuh61buGMAi6VAOMAYhsyJPIPwoPTtVXNyRBvQWN7kwpvdyqAo1IcfrrFBNwQjGJZJTkJGn7mw1cqBPszNk4zR0NHs07m/4l17uqbTKCmUYdpRXq9FPE67hjH9AetHhn/e89UjRx7qnJXm40FzueFWdIwqQyrzSz+eNsdEcg8uIBoJHgyYP0p/6WQwF2Ta0Sch70bC91gUmxrIcoo1J05ETG2d8ZK1LaKRLavmrVXxkhX/Zs1CCBcafbvR50qATGrAVmB9tuoz07abj7V5UXil5/S0+TKz5nQ51K+lfgVHAoMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7F6ZhX6iuZZeC8ehCng386DvE6AU7+VQse2eQzKgOA=;
 b=QG9E4IAIEbZGN98oXGuGRePPgAYrNfZNo7P8q10nYxjZr3CIpcgRbGap/wjWAeEEudsKRsbhMub4Ih5m8e5LJNKxV4v5j7uCQtPJZ/MKhbwwwaEbJMGGz0SsIEai5ZWlbxncGIT/yX5IsdP7ICaalSTm4s/jSu6eBUfRSw4B3qQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by PA4PR04MB7839.eurprd04.prod.outlook.com (2603:10a6:102:c9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 10:39:25 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9d65:d883:afbd:7f54]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9d65:d883:afbd:7f54%3]) with mapi id 15.20.7409.039; Fri, 12 Apr 2024
 10:39:25 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 12 Apr 2024 18:47:08 +0800
Subject: [PATCH v3 2/6] dt-bindings: firmware: add i.MX95 SCMI Extension
 protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-imx95-bbm-misc-v2-v3-2-4380a4070980@nxp.com>
References: <20240412-imx95-bbm-misc-v2-v3-0-4380a4070980@nxp.com>
In-Reply-To: <20240412-imx95-bbm-misc-v2-v3-0-4380a4070980@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
Cc: Peng Fan <peng.fan@nxp.com>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712918849; l=2879;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=kBV4FDeFdLHNHdghSed8ocvNmBpb7al6GBdfi5DzB/A=;
 b=jNtAV/HgbMyj5+0To/cwcARNwVW3jtr1DH+hFL0+4jZb7yjeQsuYqH3p3w2bC37FL20K+dVZZ
 ZWB0FbWloefC0Mp7QKCHxCjPfZ17vaefK+H7nAwabgnT1BmyHBolzb8
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR06CA0243.apcprd06.prod.outlook.com
 (2603:1096:4:ac::27) To PA4PR04MB9416.eurprd04.prod.outlook.com
 (2603:10a6:102:2ab::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9416:EE_|PA4PR04MB7839:EE_
X-MS-Office365-Filtering-Correlation-Id: c0c97a4e-750c-43e4-34c3-08dc5adcd2bd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jXW8BL/f1qa37K3fjd+IMzU8BbG4GSFYfzYx6sLj7oMZo0QqqB1lG4BkX+wto7nfEoC++oGEhErEZF5T9eVi6ADmn8aW2OoXSYJtvh/OuxWvRziMIlS94CToi8V2pRFZro7rxAvF+dcKM9c0KOdcbVGKZKIuI4HZZPwyr9p6DV1pjTFmiDE0W8rqiQl/2WU9zaKNAA4tf9CcUU9+rPUUADqiLjBnI/+BtSmLOtf66IR+kRs45NyKQjKfBoS/EYIJxRRbaK6mKuV5Wg8yTxXUlEcwBwVoZ/v3nDc7BaYlZVKHgW3yrfdrGcAJ8oqmJUq7WDoTd4eHLUC8OZPMN+Wy/MmbstS2cuvDVRvGRDjoGaFQl+AJ2zdWiBuNJ6wHCkPbdICPaDXm8wDZZvp3JUsgo7tiXGU6buP+C43uGBiBaPHDhZVerf/a7oFsmZpmHbKacSjKzehxGE5OFPo7uK5I57kaXGhR/E6HgB0J6D1BPjAGdiaQhnmn8x+DlcPWPwx0rbSYI6AHTMdvzTolMLR2z/fVnWbCRBDLK8W+ge4zILAE5o8rPvyx+2OfZ4sovURqzz4ELQA+nG1BS3b8JPTi3FlKEPTX9/6YBx0Rhb71JCV+r1X1Ly/3+cjVWLzImOIQiaKbqE/1bl5H+kgG8W5LzIUsamwclSSCGwP9ysQkMq6QMNwdJqAG0kpdALyFROLv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(1800799015)(376005)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVZHUWR4TDRjSzZhSkhGSHJESzZwemhoUjJSQnpPZU0yaTBselJkS1p2Z3dP?=
 =?utf-8?B?T0R5VUpZZm1xdStWR05Ed3F4VWkybmIrbi9CYnJmSDZYS3g0bW1CRWNXdVNN?=
 =?utf-8?B?U0RRaGxkak11U0pMdGJKdlF2YUdrNEN4TFJnSHRrR21SSlVnamx3MG1EQjNE?=
 =?utf-8?B?QnhVMDM3OTdla3NLRlZGWGwzelpNL2JSS08rRzdZVGJjMU9ncWFHWFVwbzhV?=
 =?utf-8?B?Mk1aemYyYmxXN2tOb2tTYTFvMUpNV0J6Mmh2cnFmSnhFN2JFNFVZclQ4M21G?=
 =?utf-8?B?MzFkTnhocVYwV1Z2UWZpUHZwMmpjZnZEMkZNRE5Pd0VJQXZaSUw1U3FGWC9t?=
 =?utf-8?B?elhIRVRXWjl2L1YzZG5NaERBQ0tqWTFzM1h2ZFFaVkJsN2VNWXB1ZVU4UzQ3?=
 =?utf-8?B?cnBYVTBXTjgxQk5FUElUYkF0MDRLcHlpOGdDZ3VhWnNHSXBhTEF6V0p0cDRN?=
 =?utf-8?B?STRUcWlaYnJ5S0xVVEhOOURTMnFPQkhtMWQvVDdkUkV3S0ZjNlBmOWp6RlpJ?=
 =?utf-8?B?eWRWQTM0ZkZMSGRkQVJWY0E2Z0VEckZtdkJsdzlqZTVnZkFwbmFVRElkNDhV?=
 =?utf-8?B?L2FsSFFLK0VCbXZEbE56VlZnemJIbWhsc05zL1JsNjl3cVlSckFEQ1cxejJ2?=
 =?utf-8?B?eUVINEF5Uk1tNWZPaVBGL2tKRmQxNkpvUTFTcFowSDZuMEdrdVhlcVorQU8z?=
 =?utf-8?B?L2psVlpwQ3BvcGhYeHlYbW84UU5xQnBHNVc4ZHVTS2k1aVNCd0xBNlBpQitO?=
 =?utf-8?B?ZFQyOWtyaEw3V2dzSTFhY1AvNkRwNzRUVExXNVVSMFNYMHkxdHhtWUxUZHpQ?=
 =?utf-8?B?NWFKK3JETEJhbk0vRWw3dUM4K1JDb0FsVllCZjBQRGxaTElueDByanVnSnMx?=
 =?utf-8?B?LzZOK0hlUzRrOWR3aTlVT3EzdFRHYTRCbXpPb2h6b3ZPVTV3dVhCV1ZSK1lV?=
 =?utf-8?B?Y0QxaGRxSE9RVkVKaG1MWkc5elIzZVZCMXJESkVES3VkWmdPWFNmWXk1VkF2?=
 =?utf-8?B?S0QrWTR2dzlaQk1mampwVndrczRsbWdGUHdpSTFXdklWYkw5eTU4RXhXMWJL?=
 =?utf-8?B?K1ZOaDVvcXRIdGo0aS91QjdkbVZkRm5BdmcyTU9Qczh4S2ptbTdqSWFDUEV2?=
 =?utf-8?B?Vkw1dTR1MkhhS1BaNDZTcEU4MFhsYVZ5YVN5OGVrclkrdDZTRjNUS1BtY0dW?=
 =?utf-8?B?L085L09aOUZLS2tVWWlDR0c0VTVzdGIzOGpmMVZMZk5BMFMyaHpMdWRvemxt?=
 =?utf-8?B?TTRoYWR5VWQzbTNxOHZpN0JBQ0pQeUx1MlpuNFJvbTRpZnJ0eVhvbUNGQ0RU?=
 =?utf-8?B?bzA5MWVRZHI0Z0lKaHgyOEx3Q3dqWVdMZXlQSExYcXBpdDJjWUVVTVc4VHpO?=
 =?utf-8?B?ZTg4RG5JeFFsTGtUYkFOMDM0aVBTSkhOSWZROExOS1dmSnpiUGx4bTN0MW1J?=
 =?utf-8?B?a2k5UVFlTkRoYWpXZ1NDTnNaUlVjVEhhTStOczFmdXRaK1FzaXgrbUNkWDhM?=
 =?utf-8?B?dkdZdDRuMWVkNW5peERZVnd5MU1TT1VmZjFWaTI3MEhzSDV2ektndTdpMlpu?=
 =?utf-8?B?RkVZSlZzRzdGY2pZTHNTS0JCNVFVd3pqNWJiVUpxY21IV0t2azRlUXMyMmow?=
 =?utf-8?B?T3pPY1k5ekZva3hjUms0OVZ1M1hVaUVWbG5mdHdidTQ5MW5XL2JvUkc3RGI0?=
 =?utf-8?B?ZDZEVmRDdXFRV29yUXlCMHNQUWJNcE5hamoxZTF3TDJ5NXEwbCt2OEwzUUt6?=
 =?utf-8?B?akN4UmYxSkdrOEp2cEMzNmlzR0VFRWVIMzZJTEl1R0lNalQ1b0M4TGtpdkFp?=
 =?utf-8?B?VTFYdWhQcVUrelpQVUNvRlFBM09MZ3hMbWNqWVJFcWN4alJ6Yi9HUVhuV3lt?=
 =?utf-8?B?MGR2OVZFbHJxWmZEOERuRGtMOEJDcWJkQ2EwcFNrTndHUi9SUDcxdWxjY3Nx?=
 =?utf-8?B?ek9qM1M3L0tXNFdVL1dXNmZzSnlrak9WVVBnMXZ6Z3R6cGhwSnQvaXpIVEl6?=
 =?utf-8?B?aitPdDZIa1I4c1YzODYxZ0hNZ3RGaUhzUEVaeUh4TVAzV3dMMkt0NnZDUTdW?=
 =?utf-8?B?bDY2K2FzaFVsS2NmSVZxWXFvd29NMkRIUmRFL1BHay9FSXdGdmpJRGFXUnBx?=
 =?utf-8?Q?QNU4ECUKKWyq/pYmipa700Wds?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c97a4e-750c-43e4-34c3-08dc5adcd2bd
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 10:39:25.5792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KZiPdFBOPWwg+8RyPjHNQFcW7ELRAny4Pgi1yXAbYJ2Tqsi+nY1y/XM/3/0H3En0EZuZPSR7TOrf4X0phXDgbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7839

From: Peng Fan <peng.fan@nxp.com>

Add i.MX SCMI Extension protocols bindings for:
 - Battery Backed Module(BBM) Protocol
   This contains persistent storage (GPR), an RTC, and the ON/OFF button.
   The protocol can also provide access to similar functions implemented via
   external board components.
 - MISC Protocol.
   This includes controls that are misc settings/actions that must be exposed
   from the SM to agents. They are device specific and are usually define to
   access bit fields in various mix block control modules, IOMUX_GPR, and other
   GPR/CSR owned by the SM.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/firmware/arm,scmi.yaml     | 21 +++++++++++++
 .../bindings/firmware/nxp,imx95-scmi.yaml          | 36 ++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index 93fb7d05f849..fa2cc910c485 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -247,6 +247,27 @@ properties:
       reg:
         const: 0x18
 
+  protocol@81:
+    $ref: '#/$defs/protocol-node'
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        const: 0x81
+
+  protocol@84:
+    type: object
+    anyOf:
+      - allOf:
+          - $ref: /schemas/firmware/nxp,imx95-scmi.yaml
+          - $ref: '#/$defs/protocol-node'
+
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        const: 0x84
+
 additionalProperties: false
 
 $defs:
diff --git a/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml b/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml
new file mode 100644
index 000000000000..b84c4a53b78a
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2024 NXP
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/nxp,imx95-scmi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX95 System Control and Management Interface(SCMI) Vendor Protocols Extension
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+properties:
+  nxp,wakeup-sources:
+    description:
+      Each entry consists of 2 integers, represents the source and electric signal edge
+    items:
+      items:
+        - description: the wakeup source
+        - description: the wakeup electric signal edge
+    minItems: 1
+    maxItems: 32
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+
+if:
+  properties:
+    reg:
+      const: 0x84
+then:
+  properties:
+    nxp,wakeup-sources: true
+else:
+  properties:
+    nxp,wakeup-sources: false
+
+additionalProperties: true

-- 
2.37.1


