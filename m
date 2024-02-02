Return-Path: <linux-kernel+bounces-49269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2565384680D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0157286752
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D0B1757B;
	Fri,  2 Feb 2024 06:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HbzUJWTU"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2069.outbound.protection.outlook.com [40.107.241.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EC0175AB;
	Fri,  2 Feb 2024 06:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706855433; cv=fail; b=ExTOx1rqQ+rJ0djH3rUbWxbEr+VFsxJ5cUuYc6CnG+wUzBjcbjoI31D/jA5NRTiL2W+PyZbjccdtIcfb1PeVebswJpaKEZ8oe9UCMWAgWBd4ie2yiXLh3tsVLplmfe4PBqa9DbD4ZaTA4jkviehCgmcNkeD9PUaLzQtOUvTlkMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706855433; c=relaxed/simple;
	bh=xSASzz9xJX2SCycuFopzooIRsk9pJM2hdWRy/+R3sBg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=EjWGT2V2C71ROj6dzq2UYGWv6LUcNiyrMxgo92Q5gagM+TjqG9MLWP/aFbYth3eu7PlLAFJ2qxKLYhXfJxYyf9ZVZsp6qIsK21hys9od4WwfaZ1nXw/+VSwuZHNTLFVKuY31E6ee5VfVEKAYvDAD0I5n6KtX4U83p7HqiROquJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HbzUJWTU; arc=fail smtp.client-ip=40.107.241.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MoKuk/PwMyYH02Puuz7uSX03CTkOpB21n3gcWCEyLCtOYcKtKS0JpY03PdYIKrbsYgXBBkyh0fMBIkbjxPzm5yLcFxBUEWafQ08Fy0aGITnKi4+Bw8nwbEaDOU7CHfjMJr8Ar72aez7qyQVxjw7rWzggTrKjS7IDNAN1sLRbCjc2jUhJiKQcR7+5z+D61MfAA0xGquhHYhT0O+Fm7UXEWEC7GiZfu4ypoMnR/jHOy34f2t3tLVJHPZVNCBJjPiYIzVsMc0HuOzu0VG/pzf+gzQcap22bA0wu6y9fOq1t6WS4Xi0sRh2UYDl+flGhZpk2lBHwcacKrVzPIGbrQ3MeyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1w5Ox2XDe/kTQATWRcn4dqOKnSOQnf8cJTAmHRLgw7o=;
 b=RQfj8GfMzRJUixS0XK+GajlxYSYO7IoJm0K4hHce5+4npqiHjdZLB0N+9uIhROFraPowytVQ7U8Nau8ZEYmdsvUebw8G2wdkdPV+G6P+6swEO8E2RSvfatfXcHEKIZQOCeaCHFKoMGTI1IHPaQ/C7KAskYur/qciaCC3XDB53jtyDjfhhx/zTR7GAXyj11wbVcBmuMU3nfvVFdM7IDPPUURMbngTe/ahhrA0c7rfA/OtX2mZumM/eAoMW1kumS2y1bj81lLGoD0EujVu+7F0lDFFabzcqOLKVhPaCXmm/HBIRg5VmS1HtgZmabp07gmoJahZ1fPgSSSuE6T0wxcHkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1w5Ox2XDe/kTQATWRcn4dqOKnSOQnf8cJTAmHRLgw7o=;
 b=HbzUJWTUrfJUYH03607g5FZkeGNagGyhnRL67AzFrWT44K/rdAUnZv9oqIQkD9xfaR7warxNGlfwxEQ6LpDUQrp9M/h7zOJTSSjzXN7Hr9H2sBHWAk4QIrX9h+4KOt/qvluXo6E7SheVbf3nC4KibWtJXPvh5QXGYKWOQweNAt4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Fri, 2 Feb
 2024 06:30:28 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 06:30:28 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 02 Feb 2024 14:34:39 +0800
Subject: [PATCH 1/5] dt-bindings: firmware: add i.MX SCMI Extension
 protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-imx95-bbm-misc-v1-1-3cb743020933@nxp.com>
References: <20240202-imx95-bbm-misc-v1-0-3cb743020933@nxp.com>
In-Reply-To: <20240202-imx95-bbm-misc-v1-0-3cb743020933@nxp.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706855688; l=2092;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=O5WGPt6z08564VNPrITnGf4yj18gsknkJha38j3OpeQ=;
 b=wTvF3tfCl6P78HdhfSEmpO963ft47ptm8+VQufd4jDlpRfzSbzAwy6ZOnnr+gcb8oB/O2fTUz
 hqlODCAmJ7tAk8UL6Jt92/wo6GkNUHW/J7Sa15YUSeLIgJ/ttcK2pyO
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::11) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8604:EE_
X-MS-Office365-Filtering-Correlation-Id: d67690cb-29ae-4274-0855-08dc23b87279
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4DOL0EKFHt3tms/3QbxxRmLUqsVmVymMuut74ajYoNtMLyedKR5mGMDz5xPm55fKBfeGZaPH0WafFjEk3upeSRBEvd3wq487It3XNVWPC2MSa+H16/rs62zPBo1VY2ne0cIMMledDFKKOKgb4Ufpc0I+OBQ16YEDseJ7hz7vdfAxbOJ0ZAH9voB/dlvyYEgPoApPYk3uM1hS/ztsq9bEWo032pCFuGLixJg/LJTYmrgmzI1+8r0q+/5fl/mIkvQntwfjT0U96LLSrJCm7TtpkXM8hxxNnK2swhSwxtUWz1pSKi2TKsbFLzQlfx2ygDdw/FRPKo9x75goTs5l0VSiTiYBTwbKxdGBOkTWSeUwstjrX6p5++rM7KU+px7Wmmz7idZEuVwrXEDR9UIw86Q93blxebbSTPvBFaXR10PzvhNRIw9ia9Z92ERnnfz+4uc6JxRzabAegm+3ERKV9n3xcE1m55KOnA2tPx9eF8gZK/q/ls4qYGV4ehjHbb0IxCKHf+KCk3FOgQDTrg/v6m+Wr0SDKVYrvpVJXuL9Up/EE6DB70au+sDc99vO28gSfVkuns2dp+Y/u5fsgoisMib/vgoLXi9rN5pz4CANkCwQ4nIxZt768DWTw4xnny905y9Z
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(366004)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(9686003)(6512007)(6666004)(6506007)(52116002)(8936002)(921011)(4326008)(7416002)(2906002)(5660300002)(316002)(8676002)(66476007)(86362001)(66556008)(66946007)(38350700005)(26005)(36756003)(110136005)(41300700001)(6486002)(966005)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFkwZlUyYVVmSDk5aFNBREdyRXBiWlNNSis2QW8yZGlZZEVOZ0wydzFmRE8r?=
 =?utf-8?B?RWQrdnJ2QXdpK1hnQitpTjNQM1JMU1pmRk1EWWt2QmlwWVBydVdsbW0zRU0w?=
 =?utf-8?B?aklXWlNMeGpzUDZLVjlRdFBqUmdzTmJ2QVNBaVdveFdPQURHTElWY05wSmUx?=
 =?utf-8?B?VjU0aUwvRVdyRDRmaU80ZXJFNk9aMzhZOFRxUENTcTNrQVdzVjRxcS9EQm54?=
 =?utf-8?B?MmFtYzAxVnFqNVBvcXExQ2tIMTNYNzh2c3krMzV0WjAvOEdqNDU5SFE3NlJK?=
 =?utf-8?B?V0ttVUx2SDU2WjM4ajJtNVpYc0hTaGhHc2FEd0V3dUZlMGxXR1ErMTNrSDRn?=
 =?utf-8?B?bFpSV1ZXSlpKOEE3ZVFhUkJSQ0JnekplUC9wVW5ndUZmZUE4MGhaaFZ2WlZw?=
 =?utf-8?B?aEFBUXR5aERmenlKQlBicUNpTzM5V0R3K3pNS1ErOEUyVmtQMFBBbFVSRjJn?=
 =?utf-8?B?ZzdmR2pzaWpyanV4Y2YrVWMvMmN5VnAyWEk2UVU5anBxSkh0d294d0RnREQ4?=
 =?utf-8?B?UGlCMjhSQVh1aUNrS3VHSVY1a3BlVnFla0VJZTF0TTBIMDd3M3pGZmNmazR5?=
 =?utf-8?B?NjlmYWlhY1Q1NHpQMFJVZmVJYkhmVjkxN213U0V1cCtFOEwrWEhWVndWL2Zt?=
 =?utf-8?B?Mkhib2ZobXBheGhGVUFua3FlUkRFbFJGWWl5Nk9jclVaK21uNXhBT3dWalRQ?=
 =?utf-8?B?NzdZMXp4K05Hd0xrV1I4VTkvWmpMZXJpWlhVY0Z4R1BLbDk1ZHNiNjVnSUVP?=
 =?utf-8?B?dGlmdC85bER4THE5dFZscndKZDFZQkVxRVBKRWVWSDBVYm5IMDR4dVdDNlR4?=
 =?utf-8?B?RG8zYzdJWTVTdWtNOTN6VE1PMU90eUFMSzRCL3BpSTh0dy94cDVzaUtLdXNw?=
 =?utf-8?B?TXlXWjd4TWFFNGMxWG82a0NzR1N5QmtxUmZVb3N5Q0hxNWNFWVp2MzBYR01p?=
 =?utf-8?B?SHgxdlFUaUN0dHBXUmVhY3A3NWlmb2VzSXhGc3dVSGhhbjQ4aHJZejMxeTlX?=
 =?utf-8?B?WEVuOTRuNDJPRjNxYkdlQ3ZDMnpFaE14dlRVRDZDL241a3IyNTU0M3E3TjYz?=
 =?utf-8?B?b29FcHpNeGY2bW1LNkk5WGhRK2xnZFF2V0RXdHJJZ2JWMmE4em9qZENPMFE2?=
 =?utf-8?B?eFhiZXN5WkxKOG8rZDA0aWo3eWxEdnd0K3lFVWwxUCs2bkthRTFoNVRXSXpY?=
 =?utf-8?B?eXpHdktKZ0oyQlNjZDBTZHQ2YnZyQ1laYW1pdmNaTTdJaldJakJoOUlGbmNL?=
 =?utf-8?B?cXFCYi9WaEpZQ0NERFptUVR0cFVqNGVIQ093elVTMVJXdzNkU1FVVTZRMldE?=
 =?utf-8?B?ckR5M2V3M3RhU2V5TEZQZjV1NnpSSXVZbGpMN0N1dkxPc25scERmci9iakVC?=
 =?utf-8?B?QkR3bXJlekpMSXZBcEU5dWtCMWo2d1kxK3M1d2VFM1JBYXdtZHdRcHNLN1RD?=
 =?utf-8?B?VnowQmRaZ3RCRnRrc1RnZjlHamlnUjgvT05GZ0UrVTV2bjB1dDFuSzY4VG9B?=
 =?utf-8?B?RXowVENuNzdYRmpRYjhGQlBVcDlKK3JrS2Qxd3RmczlDZk9kR3gxTmNWLy9S?=
 =?utf-8?B?R2RLVGtiSzlSZVp6d09xZUdLZzZxVWpJK05wTThiM1FnVkYrOG9xdVV0cFdM?=
 =?utf-8?B?eHV3TGJPQnU3eE9xMkYxeWZzdml0SS9oWFhsakJodzBqSDFob0hSNC9GclZT?=
 =?utf-8?B?cGpHWEw0THU3U0MxeWorKzlJSGJZWUEwaW9aY0h2UHFXdmNBcWQyaThsU3B0?=
 =?utf-8?B?ZFpualE3U3ViQzZ5YkdlRWZvT1o1ejltTkQvbEtZZ2xHbTBBdmdETEFyb0lJ?=
 =?utf-8?B?dm9ZWDlYdUk1NUxIak5raWlia2VOZ1JzeTIzWDFIWHNRMkVnUURlRnlWRkJi?=
 =?utf-8?B?Rk8vanoySU8yZ0k2RTlCTFV5MU9uUk9qZ08xaW95UkZYYWIyK3hEdm9STW1K?=
 =?utf-8?B?YmlkOW05STlIMXBXd0VvRk1TenhxUzM4TlJER05IaW5RZk9MNUdQcGxvb2p4?=
 =?utf-8?B?cDFrMVZuQzliN3ZZc1R3Q29IeHhjNDJGVzZ3YVp1VjlIR2JWZGxFWkhaU0l6?=
 =?utf-8?B?NEg0RGRtKzVTcVB3T0tpeCttL2Q2ZkZxWFJ2RVkwMVBzSG9kTExHMy9nRk1y?=
 =?utf-8?Q?qgAWsTOdDkhTUVHbf1C/6tKlq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d67690cb-29ae-4274-0855-08dc23b87279
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 06:30:28.2496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OT72g6pxTPORrQcz2xNMsgqPXPiulq/HYxikjFM/uGCrrzF+SQQ2npPHEHXaXi2VKFuZFZKxcd2Ow+2pRUTpBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8604

From: Peng Fan <peng.fan@nxp.com>

Add i.MX SCMI Extension protocol BBM and MISC binding.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/firmware/nxp,scmi.yaml     | 64 ++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/nxp,scmi.yaml b/Documentation/devicetree/bindings/firmware/nxp,scmi.yaml
new file mode 100644
index 000000000000..00d6361bbbea
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/nxp,scmi.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2024 NXP
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/nxp,scmi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX System Control and Management Interface (SCMI) Protocol Extension
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+allOf:
+  - $ref: arm,scmi.yaml#
+
+properties:
+  protocol@11:
+    $ref: 'arm,scmi.yaml#/$defs/protocol-node'
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        const: 0x81
+
+  protocol@13:
+    $ref: 'arm,scmi.yaml#/$defs/protocol-node'
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        const: 0x84
+
+      wakeup-sources:
+        description: each entry consists of 2 integers and represents the source and edge
+        items:
+          items:
+            - description: the wakeup source
+            - description: the wakeup edge
+        $ref: /schemas/types.yaml#/definitions/uint32-matrix
+
+additionalProperties: false
+
+examples:
+  - |
+    firmware {
+        scmi {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            protocol@81 {
+              reg = <0x81>;
+            };
+
+            protocol@84 {
+              reg = <0x84>;
+              wakeup-sources = <6 1
+                                7 1
+                                8 1
+                                9 1
+                                10 1>;
+            };
+         };
+    };
+...

-- 
2.37.1


