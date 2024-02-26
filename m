Return-Path: <linux-kernel+bounces-81453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DC4867626
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22AF628DCF7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9C184FD5;
	Mon, 26 Feb 2024 13:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jqdQIAew"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2058.outbound.protection.outlook.com [40.107.7.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578CC823B3;
	Mon, 26 Feb 2024 13:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708953130; cv=fail; b=osRYSy+IjVXLupODGwCl8TPBOHmVkrK5uvhYCifv0JNiItwDMqQXGXhNCu18opgQUaHGnYyPdD44lvkmfxMYczMEA0yogtsmRQLKT7fwzz4bd/zvLbSqrDNMYUkSNAtjVXKUS9CyZB4MaX5cQh9ZdBFlMxn1jwJ2iuvlnZpJO+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708953130; c=relaxed/simple;
	bh=leJ0P9yiO8h5a2UWrx8ua2Xp9yyDlgxex/qMdI2V32U=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ni+8iQGYG5Hi9HiK6k0t+YVbu9S1Sfhe82NmA/9XDLaQZ4zIwA2RLRPtEUN7MXBIrFhqPKWzoDs7ocQU3eurqqexVfxahoqqaPP51VD9A3hb8FwuHVV42+ur8uAtqsAxRcKGRylMGaN/T6HY9DbqDCOISGNpEagZuOs96q4RTDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jqdQIAew; arc=fail smtp.client-ip=40.107.7.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4JUU+W8QGbSnKF135jZBCAwKvIKbrvjgHoNts9CzqlJKfycmgj9MagIGF8v0Yk98L7AqN8gx1ajqb2bMmULhrnI5LuymhhS25ct7Q0AIygdUEq2rx+gCknKu3oXIBBAgZqZrxp39FN++eY3L4loWIO2czHJ63J9Tg3hn32xHBxCX4qUQYHRYtjdA4eHOTKhYgdrqI5zKHjqmOzg00HcXhhPwBu+jgt54aqTSAECvwL4sg7ogQeIctb9VOkxfINhurUjzf33bqW1Bt8cFoquWpk9n+Smq92B+T85Eko9WAGhlRbF6mvVxXQluNCB5EpEgOnKItqSglWtd9mYro3fmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vraf0BR9ssuevS3KPcYSEYMHAfppPMwQdczPoZa9Css=;
 b=YLA/Tosj2+hxfgBhFQXkQU2ANHzYx6J3oX3EWnOKHJNpJ0Tim+VJiMIAFMW866xzVuYXi0WjPTo03dtNhghljIRmdJ95YBd0jx8EEA6hGHUC656Uz7O/knnRVYPA4mMnZi4vV9wApJiIG2h2Top6xxMmC8nT/gvMbEXHS170MK77SvThWC5f8caSPzazEwGnLm0hiQztNKt/fkzWDZA/pVcjeBZCrqroueI+xMBiRo7eidWv7eQ99UPuJ1xXEeDrL68KdZO2iEonipgY3tZET4SaZA/tthup9AEmoK4/twOiz7bYMRUGM1L7tJdUNvcoTyiD28gKfvptuorGCTammg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vraf0BR9ssuevS3KPcYSEYMHAfppPMwQdczPoZa9Css=;
 b=jqdQIAewCPimYPx/cQyMdS7pomCdNYyNLIiOH0OsGzPI541omCRKpuagSLdsVSB3IP4F+3rXAFWwLkgvTebS8+VXpwABhGNPXWhTkNjDYawQ4KegzFGPSFUbuT4Y2aU/4tbkyOWHVnrsGpX3oiHKg8hG67vOepQT/42gbjMl4TI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8185.eurprd04.prod.outlook.com (2603:10a6:10:240::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Mon, 26 Feb
 2024 13:12:05 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd%4]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 13:12:05 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 26 Feb 2024 21:20:16 +0800
Subject: [PATCH v2 1/3] dt-bindings: arm: fsl: add i.MX95 19x19 EVK board
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-imx95-dts-v2-1-00e36637b07e@nxp.com>
References: <20240226-imx95-dts-v2-0-00e36637b07e@nxp.com>
In-Reply-To: <20240226-imx95-dts-v2-0-00e36637b07e@nxp.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708953624; l=885;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=Nklp7H1eq3lawfmsctLvFDfp9Z+P0JWNRI1GhVcpZoM=;
 b=FlAGJZeMCjP73btIca85m9cwXO9ZSo7RJ5kC1u6uxUBCEMYjc1pcSOMk82YRgMKKRJrCuba7D
 itE5Dxn8IsICdEE3eSb13/6BKrzEkdheGjZyYjLYVuVBhhEv4fzXADf
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB8185:EE_
X-MS-Office365-Filtering-Correlation-Id: d6809c6d-5381-4ed8-2626-08dc36cc876d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yNvcFU9R4j09edbwtN4aeSMrE8jKR0HBtTZNrDbB1zHbBj96i1vOikl1CeL3wIpv9eqXOvuyTXCSGoXuJW1vLpbJDqCiR4yPAHLNwd3ANDYJN/7vh5ixbDJlREbLIqvcwDFDW2IDcU9Xu3T4V4Gokx2z1lO9DApleIsvzNF4YyXjRAEy71x0OqdvPyG4M/krkKO6YJXaW8XXeBk8Fpd/cFXQVS6nEyZmp+vK5PgIUR+j//OIyZPv0NC9y7cSnpkY4FJCrLMg40fqcxR4kQHlVWWdVNGTqmXBXVsqEW2SJa2L4CGaAUQWKijBFpuhjDIdpPJOAILlIt5teHPhlz8RakSrK/CG1EoLDRDLGt7ORJYen9FMHVfncz/ioWJy+rXogVXbvOQ6XAGEDwpmhOFr/zA4G8AJ6z3j1v73JJQe4IoJRdll4FofDerplk4+VlJ0Qkq6jdhh//L3Q7fyDJeupa1sgqSKDNSkn3LyOjeIXTaJRUy1tgv8TRt9SzGm9S6IfTUUEpkfvPYoQEium/Nyal6yfylFWZpqAW4FvmbAStuGm2ZlgPHfpX8kaTB+Fqmwy5QrgMjS1UoTGVAI/d+9bqejjthfGU8yCZq79wnqVEZmv8Ko2R38S29IcpoXzGwq4bzRRv5DFFQmzQaFgjqIlCG/ce9pPTApOEVMlWZsLP3mr6vVGEUyGZCnGx0rm1qVTenTKS6RWqQb1+CtlMGkEbQCN0KxcPTEGcBofy6xkII=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWtYWTBXYzFmaUEreXYrd2FKY1dEK3hlSTR3N1ZXNXRsTWJQQVpYOElDZ29G?=
 =?utf-8?B?aWJIVW1YYUZIWmlWWFFSTnd0UklLdXhUZmg5Zmp4Q0ZWZGl2dHB2QlZWY1dV?=
 =?utf-8?B?M0FBSnc2dmplTWFvSXd5VzEvTVZnaXh3MTE4M0lnL1p6VEV1V09aME8rYlVP?=
 =?utf-8?B?dEhjQ1B4TEpMTHFrMDArT3ZlaTR5dXV4ZU9rdGdMRzFyaTkzQ2xLSncvbE5L?=
 =?utf-8?B?UEpUeUlKdnNqSnAxbHB4SjRaWTNGQ2FabkV3Z2xGVU5pVWtvb3RvVjR0bHBm?=
 =?utf-8?B?RlJrWUZSWnZYZmNRbXNqbU5udHVwdzlCaWF1RURZY25vSHFUb0hrVE1rZ3ZE?=
 =?utf-8?B?K2xFazBzQU1YYS9IZ0oyV1pONm1HV3VIVXJUOTVzRG13dmtHTWMxOHRLaTVC?=
 =?utf-8?B?T1F0TmJET253aVBJcVpoeUwzTnhUd1VBT2ROd1Z6NDFiZWw5TTdiaFVJRHRx?=
 =?utf-8?B?U0V2RDFOUStFb05kZ3NqTkVRSHUxaDJVWE9CRDhhaTM3SFUrRHByU0ZnM3Zl?=
 =?utf-8?B?NEhCVEVMRnJrWnN3WmhMbjY5ZWVIT0R6WFoyRllWSEV2RXBNZDYraFZOSnJS?=
 =?utf-8?B?MGIzNEtQSU5UYUxTeEdNOWF0Y21YK3RUVTkxTTNhRFR6alh1NzFhRFFyWHpj?=
 =?utf-8?B?NUxNSEd3MFk4eXlqZC96MUpiaWFsTkZJVEdJbTZmQjBzMFR2WXNpOFpreXQz?=
 =?utf-8?B?WXdudUQ4ZDl5MTVnMWpIeWl0TG5jZFl5UEg0NHdJcjdQeXFCaDRtOUdjYVNl?=
 =?utf-8?B?R0I3OTJyWXQydjE4VW54bW5waTRzYWVHUHZ6NW5rbkQ5cVp4V1ppUlBnZGJz?=
 =?utf-8?B?bURjcER6eC9nSzlONklwM3F1Q0lLRU1pVGlSYzRBV0lMZjlCTUxHY2NSRzhE?=
 =?utf-8?B?ME85QmZkcU5PZWdHMHBScVJ5bmx3WE1Ua2lDam1MNnBvWTJERWVZWkRCWXVp?=
 =?utf-8?B?dDcwdC9YbzBETHdCZHExVU1TZ1lvL1UyaDE0QUZhaDQ5QVZod3JrYlJqOEVJ?=
 =?utf-8?B?WnM0KzJtTGhUaUxUZlFNcGI3VHlxbVBidFNiOVU2My9NSDRlanZpUVpKbDJk?=
 =?utf-8?B?aHhIQkhUMDFhQ1pYVG5VUjN5WmhibEh4dGVMaHlSbnJTK2h2T20rSFQrdUZ5?=
 =?utf-8?B?aXdOWVRHdEFYUTRzVkR5dFVjMnlOUGl6eHpJeGtOQ1NxVldKbGxlNzNhZFBM?=
 =?utf-8?B?TGgwTEkzNHprV3lmdUlDTWRtMXlvcGIrQkJuUmhNZ2ZQc2RxSUFDUExaT0o4?=
 =?utf-8?B?L0lKNlNkU3d5R2xYM3REekE0WmdYQm94RkVpc0dJWGFOWGNGRkYyYzNycSs4?=
 =?utf-8?B?QkJodk5yR1F0UnZjQzltak5VUVlWMmZvRHQ5aVRHYWlVU3VTeDZ5Y2FHb2kx?=
 =?utf-8?B?NWhYMTNxQnEvcUYxdmZ2bEN3bVdXcER3Z2NpVE0xMWpuRUVQVXRrYWtHeXc4?=
 =?utf-8?B?eUVHS20zOHJyUy9nNFVYOGpuQ1dpbURYeHRYOFJ6UlgxOVdqcjVtUHkvaktq?=
 =?utf-8?B?YUtWQm90eWlZbnlMNWlna2tqVVZuOUJRaVBYaDRQY0EzQ1VweWwxVUVqVFlP?=
 =?utf-8?B?cDhEeWkxaXRsamhhOFU0N0tjTGFqZzhkWmdWUjBrbzZrSnlDT2xhdmREMlZO?=
 =?utf-8?B?K0NTWDY0ZGVnUnVNNHBQNS81RWdIbzNuSXo4bU50SUdNeCtJZ28xRy9hTDFF?=
 =?utf-8?B?SVdkSWp1Ty9TQW1LVy91a0VTVnF4dzRCa0tFR3htR25SS3A2RHJPWU9DUXRP?=
 =?utf-8?B?bC9XSktZU1RlRTJwb1BrM29DTk5EbTh5clBQdnA3U2xhbVA2V1R2ZzBrb21r?=
 =?utf-8?B?a09XZ2cyMnd2cnFBcEN4TE8yZnYxdkhqc1NPMW44WGZTU0pVS3BmUXJoUnRy?=
 =?utf-8?B?YUlPaHJLMEY4K1ZwcUQ4dzNFVlFZR0JwYkhIRTNOdisrRWtRV2tjKzJ1clpW?=
 =?utf-8?B?ekJ0WXdBSEdPOW9mYjlBeDl3VFV6L1o1am13Nm1mdkpUTHYwRTVrYWJJSy83?=
 =?utf-8?B?Z1JzQUkwTDFteEdqd0NXOHkxWlQ1c01tNHlpVmd2RXBoTllwWW5SblpBcWRC?=
 =?utf-8?B?RzJ6eURWMHM1REwvdjNqaGw4em5LMEJrZHdRNVo1Zzh3bG1aaWViR1hCaWZq?=
 =?utf-8?Q?AdQs2ZSIn1RTIPlBkBcwAVyc5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6809c6d-5381-4ed8-2626-08dc36cc876d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 13:12:05.4303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LK5MAuLZGNfCYBuRaprry6xuXe5eTOukAO2H67WOcwnPqRtRSiUp69VHS5y7SLn8Wup2xv5KbAeTPwdjiUl3/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8185

From: Peng Fan <peng.fan@nxp.com>

Add DT compatible string for NXP i.MX95 19x19 EVK board.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 39378879777b..42c6e8467dc5 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1264,6 +1264,12 @@ properties:
               - fsl,imx93-11x11-evk       # i.MX93 11x11 EVK Board
           - const: fsl,imx93
 
+      - description: i.MX95 based Boards
+        items:
+          - enum:
+              - fsl,imx95-19x19-evk       # i.MX95 19x19 EVK Board
+          - const: fsl,imx95
+
       - description: i.MXRT1050 based Boards
         items:
           - enum:

-- 
2.37.1


