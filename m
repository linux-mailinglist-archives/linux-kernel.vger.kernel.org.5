Return-Path: <linux-kernel+bounces-141753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F02A58A22F2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 650421F23567
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E8E15B7;
	Fri, 12 Apr 2024 00:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kLONX49l"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2080.outbound.protection.outlook.com [40.107.104.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEE4D27A;
	Fri, 12 Apr 2024 00:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712881297; cv=fail; b=Oc2v1adXznrZRdXGN+oJLwepChRQAOKY22kzckz2D75O14R9pBJ352Qs0L8eV0rTOdrW/vNCPiwQpQIMdqacFGC7eUYdcQ2iqpRPGM43QdV//V3S/fF/fxa1q4r82QXw7RNYdRpz9w6n6G35yrGuSv6+1kf9+gc5FDvgVizrYCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712881297; c=relaxed/simple;
	bh=7+IZpVhOzxW3JHD+Dq238kMHCc7u4HXNQ3Xdxr8ofG4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UOT3XQRPZCgg1Podezm/+twThvf9IAibpNvOElaO5yK4ybEJt43j38fFG+VzqKzHQgLBOaPq1yFDrCFplSCIvR+rw7GAQ7gLTlBQWcICh94/4Xiz3YXKhDHlwWy99dGs8dIpvgXAxWcHkj67zqw9jbwaK45wPzv58K1zajjNjoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kLONX49l; arc=fail smtp.client-ip=40.107.104.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RKYxzKNhjlSYehq7TcYYISkYsSFlaCcQxjiC0U2fvXmOWuk3ysOYfWAY63Lw4Mo5F3872sGKmDzRzW56T1UeGuTkwKgw6jr2L0NRaUx7fk8qwrqq4aD5/iWTu2HKEVXn2Ox8KLt1tyHC0jveFDbMs5KLgObCh2TdRx0oVq8pB2Uk64aqtiwX8JKyx+o1OF3fE13+jwq0qdMjO+CaueeahXvPXulhlzghjyC12PwAxoqzf8s+aC7y+kKBylAb5sAF+mTC12ojVsn1W3krg1r5b53351fMJul/0PsPQjiUVtLmV3wHoM5jlCoARwTe9zpuV/OIPNs8lp9YHB585QKORg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKQD3WctDvl9pLHfMfhzX+rQPwUR+6HbszRRKseMhT4=;
 b=VIYHNhSrEMZ52reTA3aYx3JQUfGOXdaHHTJbZJOmya0irMNgoJtjEOPy8GlIUz00aRkCVv45VX1IIbP3Cwx+d6mum3rYh5kQFheSBq5eGS8mNm9VL8+8mO2KoYm3FHAGL/1S/IDRA2o+w+LzF5W9aynF0zOfWdFB7tJezvLr60dTWI+xTkeWXFpcNVu/Ks40IN40iQPrbZUaRybyicPhqd8GTHcoKjMubAXoypDW1Mj0E+Vvotyc0l83JKDPueGUeElNarDgfiuc0eyShOQoR7nnXEMFnKVFn9K1dEdy7L/0AnWGDOSiXQTU0WyYNpqrZX3/zErIe0HnqfvsAiwm6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKQD3WctDvl9pLHfMfhzX+rQPwUR+6HbszRRKseMhT4=;
 b=kLONX49lxuxgrwD1L/jai9fv+y98QwjMsAxO3qR81qbsrhoATuA86dEN2P1cClChuwzuoA4skE7r/K2esuc+pJigcXVHVcxuKkoCkjcVH4djmGVvAlxY1P6C491v/yvQJxAnIODH5es3Ielah41jdbyXtr9m+XiEknIrIp/CCPw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7970.eurprd04.prod.outlook.com (2603:10a6:20b:24f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 00:21:32 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Fri, 12 Apr 2024
 00:21:32 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 12 Apr 2024 08:29:26 +0800
Subject: [PATCH 2/3] dt-bindings: firmware: arm,scmi: support i.MX95 SCMI
 Pinctrl
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-pinctrl-scmi-oem-v1-v1-2-704f242544c1@nxp.com>
References: <20240412-pinctrl-scmi-oem-v1-v1-0-704f242544c1@nxp.com>
In-Reply-To: <20240412-pinctrl-scmi-oem-v1-v1-0-704f242544c1@nxp.com>
To: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@arm.com>, 
 Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712881775; l=1004;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=vmpls3EeiII01c2hWPNvt6hnGq2HLnzccUt4tK+qRYQ=;
 b=y0p1DJSaXFaDKafPzdIgii/bGLRJttBZVCxgUHVSceOmH3vr3BGi9WmuGoFqlQv4AQLgqbEh0
 EnTTza7sLK+B0WSGgA4zAlNejp4vjiNfgaEJ5VHQxXLR2HUc5Fcjor6
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM8PR04MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: bd673e1d-4b76-475d-cd0f-08dc5a868176
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ST41wSF1+iNIhE4r5d2ypKjFAWh5Litbcjw0BYoXAFsk7V/HZiURQkw4lt6jl+R9HcQr31ON90rqNjODPhH4P5Q5R2/gkjsgomXOD8XBAIHbRpkjWjLZ9gvmTiqQwvHanD7jzE60TMEd5PaxO2d6MiG0rE1FnL9QWzSYB2dWkqeWTUBnzZbW6iCjdKdKAquL6wdY/or0noNw13a6wIiQGzLBp+uRMyS7hgqq2sOmqh/jfFbUWi0/+vEwB7bevrPZaVkTYTBu/yUdEJs+RXWGK6DoPQW5Gb13YaJ0XN2P99dL2Z0kf2AV+0tBoUA6EiSD2YW7leGRSLvo+K2KEo6EwamSWnFOWHur3kR5pier0nwmIFvXs6zI0c6mAm2cWe56bobPWf/V8kZXP1oM3ESmyuO8TJsDYV/T1QHCTbOaFJPimS5ETA0qTfe4I6ObrA0fVGclcEYYhzDUShuf9wOIrBhMh9apbeFwXYyhkc6nERElIW4NfZ7v6j7RWx2MN9lY9QMyPlrvR08f5JBfucTHqQtEayWr6dFKqc9JXBnqkxOqC8Ew/SY6yMssXVxXkQoR3wzjjvBT1dR4UqMob8dshz9hnLzU+BD/CE+D6AUyTI2pDtIXbXJjEWvDc/HMYV4EWPvTMR7DzkvXbKSiMsT4kgpOa+T8OxXeGF+25ls461mB9r8zcBN+sLWzEe1rbm+ozHGvfpgW0JUqvtqvwr6NMu9Yn071SQAoITGrGtLb70k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(7416005)(376005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzhTcC83STB3WStyR2l5alRyS2NJQVZ5WUx6bW5MamdpVmV4c3d3SUNBUzk3?=
 =?utf-8?B?dThIcjdxdGtkUmc5ejVPWmNpTGdrSWRXUjB2TWQvOVNwRXB6YnV1RmVZa3d5?=
 =?utf-8?B?V0RBOW03ZzMzQWErN0kxMW44LzFvdEgxWmRzeHVkdEpqdkdCbGdWblh0MWhX?=
 =?utf-8?B?NmdJK0I1djE0OVcvK1dvbXlyMDF1MUoyRjNCcGZtTDFGTE9nZ25jZG1ZcnBL?=
 =?utf-8?B?Ym8yT2M2V2lnNjVFaXZVdE9Pa3hZRmJZWVBtSXZST3J2S0JjdkNyZnNKcGc2?=
 =?utf-8?B?ZTJaR0tBN1lTRjU5U2ZKN3puOGZkVktIaGduZGl5cnFqdDgyaXRGcUFCU2xN?=
 =?utf-8?B?MjBZNXo4Yk9tT0J3bDRwN2YzS0RFN0lUMk9CaGcxRFUyVXRYVzA1RExNU0dx?=
 =?utf-8?B?NFkrTFdGcDB0R1JFeTV1THBYdmYwRWhYbHZJZnlkZU5XTG14VzExS0taYkRx?=
 =?utf-8?B?RUR5Wk81RmtUby92dHgwQ0dqMllmR2dBdGoyeW9BVmNEL21ZSVVGUkFLRnZT?=
 =?utf-8?B?cUsvckdEOWdLMmZVY1I4TUQ2M1lrV2puZ1U1QzRjaVUwbmZWV3YyWk9ZaUgy?=
 =?utf-8?B?QVFmUTlmVW1jMzhEcHdMVW9oc2pVdTdCL2xMUUNhSDFHYUdBclg1VG5KWTkv?=
 =?utf-8?B?RHJBdFRpUEdFbVcxRUxmeCtqckhYc3IrL1pjUkFRSEF5c2FvS1JFZGtVeUlz?=
 =?utf-8?B?dTJiS04raHBpWm5jbXJkMHFnbHBVMGtkVXIwdXZOUDhveTBvcnIxRnhnK2lu?=
 =?utf-8?B?NEJYRWdLazAycGM4Lzg4aEJWUDZwbWhDZ3N0T3k5TjZaQUU2ckdHc2tscVdK?=
 =?utf-8?B?b20zZUJnVnlUTGcydFRxbklQd01xUm1PbDk0R3VySC8zSXVyV0ZiWEgzWVNL?=
 =?utf-8?B?Vmx1Rm9rblNPSk0rNytObTNzSEZnOVhXSkFnUTNBd2wvTy9KMkJaaG5yWHNE?=
 =?utf-8?B?SVFjOVBVbGtCMjlRN2tRNEk5S2FreWxCV2xMZTZ6TjM4L09SQkx6WE1hY3ZG?=
 =?utf-8?B?WGo1Q29SZlBBZTBvZ1gvdnF5Vk1veGhPcGNWOWNwUTFIQjFsUXIvV3U0WG8v?=
 =?utf-8?B?VlFka1NTcVYxN1cveGtVU1BOWmpjVVRadHgyUDBJOWQxR2tXWWNCSnoweTl4?=
 =?utf-8?B?UjdGOEhPN05GVjFCakJCN3UyaW5hd0FLRkUrZG4yeDFmalVuQ3hjMUJ1S05L?=
 =?utf-8?B?enRTSTd2WWpoaWVVY0xHYzVYVlF1YXVuaXpNTENrbjZORStNam9wVFRXbUFY?=
 =?utf-8?B?cHFpaU5Ubk5ua3dFa20waGtFWkFvQXNTMFNta3FubjRYRmYvSk1HOFRMYUFV?=
 =?utf-8?B?Y2FDcjhOQjQvOCtDWEEvOUtuZE13YmtpRnNveVViZy8xMGVYSXM3SzMzeUNO?=
 =?utf-8?B?bU1id3l5UGZpVzlmVit5MVVlR3JYa2hQS2R1Y3FCaFExVk9jUlgrUSs4M3VD?=
 =?utf-8?B?a2hFWW53bVNmQzVGWW1SL2J1bFBORVRxRmNydTljNjNsMktwbUpvRjMrRUU5?=
 =?utf-8?B?Q3ByWjlXWWlaQkROR2s5a1NGajBqRGVRZUFmSXp6cDBCY0syYzRET3hzKzhk?=
 =?utf-8?B?TC85Q084U3h5eUZIV0RKRnNOYjUycnQ5dk45OFdxN2g4UTl2SW5WWUt4Tk1Y?=
 =?utf-8?B?ZTdBRXAvRjFNenh6bjgyMWFrandHYm85ZlU0UjZ5RW1ZcStwU3dSUlZ3cnZl?=
 =?utf-8?B?emlOYzl1Vlp5bHhnMmtMVkg1UHhXeC9ZSC9EK2pZTTdlRGkyYWFZbytXZ2J2?=
 =?utf-8?B?S3hGSnhCcE1YbDFEODZTZHo5Zk9kNGV1MmJJbzBNVE5ueHFlbVN3ZlhWYlRB?=
 =?utf-8?B?UEFJZWY2UC9oWjVycHNuRTJPZkkvUnYxbFd3bVIxZU5XSUtFaDJnbGVlMjlp?=
 =?utf-8?B?VXNkRjg1SnFiL3VGclo0N3dQa2c0ZmVKckcrRHZQVi9mOTdMa3c5NXZKR0Yr?=
 =?utf-8?B?Unk2WmgzMERrV0RUUFBFRnJSSXBKbjlDSXp3T0FpZDEwdTNidEh5aDQyK1U3?=
 =?utf-8?B?NEZUSjJJaDJISUlGekN4TUZaanZnaWpCMTRQYWdWTkhJRjVzRW5hMTgrRFRQ?=
 =?utf-8?B?M001ZlU5SlBXS2tLYnpSck1la3JzL2ttVUxMUStIdVI2MXR2RUFNZGgyM2wz?=
 =?utf-8?Q?AMYbIfwX0jYbwJLh1dnAWHIV9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd673e1d-4b76-475d-cd0f-08dc5a868176
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 00:21:32.4876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B9FFOpWDiD7dJI6MU84PO623L0GHbauJN8MtsDOrq46+sJVE9YKE+zBqVxVU26TIxQwi8N71hQa3ymKmtEeO5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7970

From: Peng Fan <peng.fan@nxp.com>

i.MX95 SCMI Pinctrl uses OEM specific units, so add '$ref' to
'/schemas/pinctrl/nxp,imx95-pinctrl.yaml' and an example.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index e9d3f043c4ed..ebc6c083b538 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -249,9 +249,11 @@ properties:
 
   protocol@19:
     type: object
-    allOf:
-      - $ref: '#/$defs/protocol-node'
-      - $ref: /schemas/pinctrl/pinctrl.yaml
+    anyOf:
+      - $ref: /schemas/pinctrl/nxp,imx95-pinctrl.yaml
+      - allOf:
+          - $ref: '#/$defs/protocol-node'
+          - $ref: /schemas/pinctrl/pinctrl.yaml
 
     unevaluatedProperties: false
 

-- 
2.37.1


