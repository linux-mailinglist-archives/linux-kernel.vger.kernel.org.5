Return-Path: <linux-kernel+bounces-37975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE15883B906
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53A03285678
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 05:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7451D111B1;
	Thu, 25 Jan 2024 05:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gbx53IES"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E4D101E2;
	Thu, 25 Jan 2024 05:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706159770; cv=fail; b=llbckHNoLqbtJYXqT+jiOWVWLptB7Ily5LwqLJhooVJVXRKPVSrYQg6xTyM9YJoTwZBgAUycRWr77WSOrOWsilcsodZEAIbY+P+34El9Js/dgxMaLq8KaNgJ76D5NvQYMr7wbod5MZJnkucTe88xz5lZ2BvN3Bn5xCIeeBBf1Cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706159770; c=relaxed/simple;
	bh=kA/UZP7RBLxFNlKx/I6oIWRdtMjAl2kfHc9r/eFLYi4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=XTl1Eeu7A0Az0h/x4K5JB4ZWFuxuJ6RMJuqu8BvRldEHQW2hnCIny26aCzyHX7KEjpEhG74xEqfLrqPh2rCMwoyf3Nkx3wX2a8QCkEWbc+Kf/fUPO7CMmDjRZErQVg0oC4vBqcHsFYHBlX3gxGzCr90laWM0gyVBt/zyxJgWto4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=gbx53IES; arc=fail smtp.client-ip=40.107.21.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmSfyqRCXJS3xTxd3Ov862jIrhIR1pW4yQc2x3KBWosanzJ+jmPiEgjDpOhaptrOhe8lq/85MdlhSU45bi4qWOWXTh66WlYLuSOUiTohFJxpZhJfXliDiLmtFtDI2nv2qH+dHpQG+EGFuTtClyN0UWOhMJpee0bS/K1tyOV4YkMVHFC0e8nsMq9YW0KIyADcX4OBedzi/AE7a1rB2LRNAoieYfdyFG+1tq0uXIMVapsDFjGZwLXaySUuaW4hTUTCCpsDx+Qy085pGEFwqLPMlb9cT5TZJWZUGgIxrs64mUhAIxlRcw3AFiOpVMX+eKb3zws8NFqnBGxKsrbbLS9pug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4/oDx+cC2vKsvoZaiTqgZpD/H+Cdwy5IDIRZoQ1eUY=;
 b=fcqxEt33TibWvjcS/BHp8eoTaeR3D+xpStrOcI2wsUGZxC3HtYfzbj2r7Cpz21YUODj1nY/1Lzaa10h9V7NBPXgNprv2br4MbQ1wurbM9SO14+kG1QU+g0nGlkOqwxA5wu9CLBjXjcLw/FAuyg5hov/o3p0fHtdDZ2qu1Bz5LXdGut/c7WcfkRZV1GYcvLWM4d3ReDKX5Xds+iAwODt9T/3nFRrJ2RRz4OkQVB1sXuj6Pk2veITYGevTagGtwlRJY6///6TW/2x8cYjJk8XncLrG3ZEm2zpvg+KFGh6ieiHHsogdDkdIOwcJfuemidUNAir8XEhnP069zwU0cZgc9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4/oDx+cC2vKsvoZaiTqgZpD/H+Cdwy5IDIRZoQ1eUY=;
 b=gbx53IESBR9/gUXHGl83nwoHWK9bHg7qT4n6wCJ7G8KNQMDU0O8de7/34UH+toERtzoADlceX9a7JAp0MZO0OstKa+iZzRDd8JSCi7U5EnIoo4JlPA5VlwlImmQMmEhiDnYu3/0x5KVOJ5+d20MzgYSZuKSpr4/aNh0Kv0PlDm0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8275.eurprd04.prod.outlook.com (2603:10a6:20b:3ec::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 05:16:06 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 05:16:06 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 25 Jan 2024 13:20:06 +0800
Subject: [PATCH v4 4/4] mailbox: imx: support i.MX95 ELE/V2X MU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-imx-mailbox-v4-4-800be5383c20@nxp.com>
References: <20240125-imx-mailbox-v4-0-800be5383c20@nxp.com>
In-Reply-To: <20240125-imx-mailbox-v4-0-800be5383c20@nxp.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706160018; l=1973;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=lkPMpPy6UalcvetyTqhwBLnqDq8ONTaWTu9sur2v8yE=;
 b=sKmTvNHtaxOL1fzrDSRxh6YTKrjr6sD9nWt/6AC/y8NZv589HRitd4ANJ3Dc0/SQXi55wNTGT
 8+Li1inJ38TDG1BlqKurbW80YMCZKHXx8Wks4x+PyjfNqF8Kyb/awZv
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::22) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8275:EE_
X-MS-Office365-Filtering-Correlation-Id: ea6ba22e-d817-4799-5d63-08dc1d64bbef
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Hisa21zJ6QbjE64kH7JVF60nTvI4DOSt2nHUX09KMnusNp7F9JajCIKAEGn1YGhhJVeRXPD1XAAg83HoRGIpo1MmY60ThoNxgodk7InqUf1Jqh2VsefCiUN+oPMC6qZAMOutS7orYzKyeNqhgxBLYFYjZqqbrSYeLw8lsW72o9QELfbCmjVrwl0ke7r/EUYojuXeT0e0ZLhdumkgGwGzE9Qi5f2E5O//s80TW3rP9gZy1s+42W/tOftTDSyedwi1pOJqSksTPtAefBowKe3kMSQRPsN+Vsf3OBaNo6hr1Hz3qeaTTqSm+GsalB6a5vdI5lZA3KF2eII3GdhNjthzeYaa95+MWdDFIDat+/LWo7WSGr23TCYeqWceDYLBLqkHSN3ZrK316MfgmP5dWzkO7/L/wWc6DiLry+wS4xjEitt8rq1DYbNL66u69e2iRzK2bsi9VtHL7lWkeWIFTxunwLVVVvY2AG439AjzkaIjb7Z8x96jW5qmUseq8I/I2fbAAasXP7a9c6unZDKfcx1wzUhYg3PVX99t6noKJrO+8s4m2SlBjoi7KkaQL9Q74qnQu7UQ45vntmkjL1CSoB71cnqE20dQVIEOVRO2+5KBr/Oeur0C/kLHDSLNUV/PWOsmx/zbh4ONNaK5Q+3ZLkCjRg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39860400002)(366004)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(921011)(41300700001)(26005)(38350700005)(36756003)(9686003)(52116002)(6512007)(6506007)(478600001)(6486002)(83380400001)(38100700002)(316002)(5660300002)(66476007)(15650500001)(66556008)(66946007)(7416002)(86362001)(110136005)(2906002)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTZ3VGs0TThIMnloNXpDcnN3Y3owYXBYaXZ1SFQ3V2t0bi9xY1o3Yi9VZzlT?=
 =?utf-8?B?UEE2Q2pyeC9GaE1Sdzl6OVR1WGRzekF0SzA4UUdPSEZmempMZyt2ZnVOSEN0?=
 =?utf-8?B?c0JvZUNrWVdycE9oY0dGczVSb0VoQXlkQ3RSekdab3BwcDRTZjVickNqbmNl?=
 =?utf-8?B?NWd0WlI3bmZkUzQ1S1hUUjdxS2VINXdvL0NKYXZhSHZWM2V1NWZwSm5maEtN?=
 =?utf-8?B?YzhqQkQyY0NBRDNNQUVVa3picGF1ZG5ZZHVqZnh1aFRWM0o3S1dDL1p1cTRN?=
 =?utf-8?B?L25STWVQV3pqUUF3RmJIQmp0dUVSNUZwSld4L2QzRFAxUHJhWllJZVpCM0Jw?=
 =?utf-8?B?WTlHL2dBc1k4aFFlMStSRDZMVGFHcUJNKzU5eGJzU2kyV3RRd2I1eHRXZWpo?=
 =?utf-8?B?YWRyam1wNFVvMVFlWXRjMmNVU2NsUWZJZVV2MjB4T2wrbzJMSGNQNmRrTHNV?=
 =?utf-8?B?aUlCa3hKeExkV0FKV1M1ejZWNi9VTndETHhEM0JNVG04V05MTHkrVEtvNjBP?=
 =?utf-8?B?Nm5wdFEvZzkxa1E3UWlZSVhRdlFqV3NKYmZxcDJLTzlxbUhiR3JBTkNnVXdt?=
 =?utf-8?B?ejhwN0IrQnh3YjZ5ZVlqWVkzeTR0OHFPTE5xUVVmb01oa3oxZlovMk82S05j?=
 =?utf-8?B?VTQ0U3ZVTnlFNXA2RWxYNjZ3SkR0RWpqVTJ1TjhUaXJrUlIxQXZDbHFJM2J3?=
 =?utf-8?B?TmQ4dUpPaUhzYks3NzBOU2RnRitpYUFwa1A1cEZWM2hoUkFSdUZCR0YvR1ZC?=
 =?utf-8?B?bVQrM0hKTEhPbjVnQmpDL3A0aEFEbXJ6TEl6N3h3TCtCekI1SlRCbmZDdkJO?=
 =?utf-8?B?YXlxQ0RpUkNzSjh2L0d5b056L3dCMVdPcTdKODBQRjdmd3JoVnFvK3hYR3dW?=
 =?utf-8?B?OW5uWnhsaGxvYWxRajBvdzRUK3BZWlk5SXgyYUtDcWlWN3JuNEdVeWFQZjZh?=
 =?utf-8?B?SXdVa2xNMDhBMUE4YzhNKzBlb3VWdE51VTFJNFB1Q0Judm5Gb3RGV0Q0UDFw?=
 =?utf-8?B?TURheUVZSmFpcHRCTDBKaTc4OGZtelBWVWxhSDE3Qmg2WG0wSU1FMUNaK0Nl?=
 =?utf-8?B?cUJoTVcxWStRS3hrRzhVaGlPU2p5Qkc0ZW5wQUNjd1F0NCtqQUh6SS9xK3Zo?=
 =?utf-8?B?cVRiUm1SbCtsUTRyZjZoeTBtSjR0VlFObWo1c3BIV2xIcjRsU1lKRHlHTy9s?=
 =?utf-8?B?SFJRZlpRQzRoVEV4WWYybER6U3crZTFQZzg2bmNUcEZBT0F6VTlVZmU4QlBm?=
 =?utf-8?B?QlF0M0pxU05VMmNuOFY5ZlV2UUdLU1NFVThPbFoxNVpDbnZycERZTEZDNTU2?=
 =?utf-8?B?ZVM5N1hMdHlWNG1FV3Y2WXhSanRUNFRqVFhhWlNvRVhlejhwdVh6bFR3amsy?=
 =?utf-8?B?RUxHV2Y0WVNWanFneGphTEYwTjAyUEFSd3pnUnVzOFlUZCsrU0NaM2F6M2Vp?=
 =?utf-8?B?c1pNcTF4U1NXbERpeVkzNFNxVmFYL2FPQmRWdTg4MVhyYnpQdml4aDV1aUdR?=
 =?utf-8?B?ME9adFZ6YjJabi9nU29WUFJkOVV5NXRxcUt1amVVWElVR2ZrU2FUMU9yQnhx?=
 =?utf-8?B?NmVTSHJLNTlYTk15T1RndlE2SU9MMUpUU2xsb3RXN294OEdncXpwVnRtdXhC?=
 =?utf-8?B?ZVRDMDVXdG5oK1dXQUhvR3BtMXQzcjFyS0lPWTBTZEgzVmEwem9kRXBqN3I0?=
 =?utf-8?B?QmRLa3RXSG1DaVlTaEJjODFrNWhJTi8vaktpT3RQV0tEVVk2eW5VR1VrVHJS?=
 =?utf-8?B?Ym81R0pBMGNFS2hSV3lTMjJnMFNvY3RxMG5aZVF6MkQyS1lrc1BicVdKTTJC?=
 =?utf-8?B?TVRGcDJTZjFkS09wVXY5cHdDT0hZWjlmeHVCdC9YNlR2UGJBcDE1RitRMjU3?=
 =?utf-8?B?elh2Nm8zVkhxZGhmZExYNmRqK1BnQThDZFNoL1NaL1Q1WlB3NXNFdGJWSE1C?=
 =?utf-8?B?TzhwUzZDY1VmRFdLNGNVeHhodWtvcElaZVBSWktPdlU0cWorNVRXQ204V1Bt?=
 =?utf-8?B?RUxCakpWVU5Jd2NEeWtOQkJjK3hkeHgyMnE2anFjMC92NWdVaHdvN3RaV1Ns?=
 =?utf-8?B?OTB3RUNkR3JCM0d3MFFKRlNVQTJGbDAyZlhLSjJDL3RiRHJabVNsMndldVNP?=
 =?utf-8?Q?PS24sGnt5VOIxaVAU+ELTroIz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6ba22e-d817-4799-5d63-08dc1d64bbef
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 05:16:06.7790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MbvgiRrlEUKCf3Sqx8Ke3EbvXmeniBYdoKaRCwo0InLf1JaAjPcpzL4Dgu/8UnEFIkXbT4n/8NeQa0L79hXQ9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8275

From: Peng Fan <peng.fan@nxp.com>

Add i.MX95 ELE/V2X MU support, its register layout is same as
i.MX8ULP, but the Parameter registers would show different
TR/RR. Since the driver already supports get TR/RR from Parameter
registers, not hardcoding the number, this patch just add
the compatible entry to reuse i.MX8ULP S4 cfg data.

To use the internal SRAM, need populate its sub-nodes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 9e89f773d2f9..fff891d40f2f 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -4,6 +4,7 @@
  * Copyright 2022 NXP, Peng Fan <peng.fan@nxp.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/firmware/imx/ipc.h>
 #include <linux/firmware/imx/s4.h>
@@ -15,6 +16,7 @@
 #include <linux/mailbox_controller.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/suspend.h>
@@ -919,6 +921,8 @@ static int imx_mu_probe(struct platform_device *pdev)
 	if (ret)
 		goto disable_clk;
 
+	of_platform_populate(dev->of_node, NULL, NULL, dev);
+
 	pm_runtime_enable(dev);
 
 	ret = pm_runtime_resume_and_get(dev);
@@ -1031,6 +1035,8 @@ static const struct of_device_id imx_mu_dt_ids[] = {
 	{ .compatible = "fsl,imx8ulp-mu", .data = &imx_mu_cfg_imx8ulp },
 	{ .compatible = "fsl,imx8ulp-mu-s4", .data = &imx_mu_cfg_imx8ulp_s4 },
 	{ .compatible = "fsl,imx93-mu-s4", .data = &imx_mu_cfg_imx93_s4 },
+	{ .compatible = "fsl,imx95-mu-ele", .data = &imx_mu_cfg_imx8ulp_s4 },
+	{ .compatible = "fsl,imx95-mu-v2x", .data = &imx_mu_cfg_imx8ulp_s4 },
 	{ .compatible = "fsl,imx8-mu-scu", .data = &imx_mu_cfg_imx8_scu },
 	{ .compatible = "fsl,imx8-mu-seco", .data = &imx_mu_cfg_imx8_seco },
 	{ },

-- 
2.37.1


