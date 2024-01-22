Return-Path: <linux-kernel+bounces-32267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E45583593B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 03:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B04AB1F2178A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 02:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AFF523B;
	Mon, 22 Jan 2024 02:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FzLDE1gt"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2077.outbound.protection.outlook.com [40.107.21.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501004C87;
	Mon, 22 Jan 2024 02:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705888940; cv=fail; b=uDWN2Jt4DCDsQHNKLxDfsQELrL8jNBplJAy8yleJblz+WP7tnc3qbsTIRG8NvVuuopZckQ4AK7GKNDSG9VDBaxwsZJ6N7KOgUJ+n1KecKcMMloAGTWIb6KwXol4ROFj7GCZmxe5SUA8PWp57DsfCOqJoHgrDrygxvBNfcjH5dYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705888940; c=relaxed/simple;
	bh=7BDOng647lurljS9U7rJiyPuxH75LfMc7g56fOuP+B8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ivEPDStkRNPcPoTw3crMqTAugZKR/ynwA9F6d8eEjCyF0RWVzyzt51OLKQNqa15apl8fSCbkuQrZIO0tO5GOhc5a1Cy91grsfRCYGhDPl+zJq6/1HPfPRL2LPlKTtwa6R7hkihz+HGFhbhLFJINpoI5Sppjle7BBz8pQH/LFuuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=FzLDE1gt; arc=fail smtp.client-ip=40.107.21.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2Yi8192p50kei3I+3UF/FO0gIVg0P5CyvvFyVAUfbE33NwQ5B5kN/PQceCV4FNKTgQqy7Wf2H6PgOIUIlVomlGPwBHNHIA5iSj2Fw/mupqL0p+HLzfte0rCOSXf8tjrXs817AcaEsFWUUgWyIXN4UX7hKz4hSG+O/6L5aJhr2uWlwiiB+1PRwBIQ/ejILSvotCDaev4bj10EBSFqFYjnMFloLCizvpwdxK0v6hYgL7Yf/u+AJM3Cf9NqH+zwuvXaiHDWWXhBA1k6onMrejyVw8QjzvTWtzJEB1o21IVi/Q2vrDvuM/nkn7BdaoCt+jCb2Ws3RsOleLYfNZk6KNbPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvUIy0TPa/4nBhGJqFzoNI+8Iv1U0SsQ+ywEB0Vj2E4=;
 b=bx7eS05rR0jOyjXEZdsvjhSqsVeBMLDCYWcjgUufXbo2lTD8bfjyFSlQdbestVAojj2Rs7jrQxg/uADAHFlCOFWz97wA1Ga+jvJ9BVGximG6wvLwfqrT2en6p463IF7iqv0gHsn5laYSZaDDEW0Oo2AyLwxw47T+3X9L8l7/KD0OnPwPQBeAXssS+UdPuB0usT7RxWbZopqxWjLZK2d1f8zhPgkvcmkoRJVmQXeM3octxNe9YCJuFji3Oq+PCL2G6OCAd32/DSdxINpuF0WzRtfXoRT8qeSJH4PBsfGPx5nUVvtbauXgf9V+lNmq+Lt4adQ3eO45nkhlhkPN8WONWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvUIy0TPa/4nBhGJqFzoNI+8Iv1U0SsQ+ywEB0Vj2E4=;
 b=FzLDE1gtYmDKSbsAk4LDsWnmqxSp+MrEiRwAlZMTsKXLSmrkaJQAvZSe6FzrpqBtzJqIKncEu9Z57tmmtOX2M70BGlcyXD2oyffKqiUmwVo9Nh8E4dhEAjhWgXSQPBbg0cmdK6TpuuySZ+He5Oafhw/jguGBhQ4JxkLlD0xqg9I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8153.eurprd04.prod.outlook.com (2603:10a6:10:245::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 02:02:15 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 02:02:15 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 22 Jan 2024 10:06:26 +0800
Subject: [PATCH 3/3] mailbox: imx: support i.MX95 ELE/V2X MU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240122-imx-mailbox-v1-3-81413f655210@nxp.com>
References: <20240122-imx-mailbox-v1-0-81413f655210@nxp.com>
In-Reply-To: <20240122-imx-mailbox-v1-0-81413f655210@nxp.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705889191; l=1218;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=NnhSxhZkVvzcxNDlb4dHpwNutlkNPmqChD6ADMtw6o4=;
 b=LQ8Fw2rOOQw6gi0rFYQw5E5KamexLFFKkwqW8SBuSYlnhDFa8vFTPizzFObYnWw1tBnsGSnJz
 CXtKJvET79SDF3+hdLho3oxV1nSXrbE84MPOxIizktjj1TPof434bhq
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SGXP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::31)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: 2765add7-56f1-4479-63b8-08dc1aee27c7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	D/qv4Vd3n/XM8aRwh9yW4F6l1eUyiSGT1OqNTR9Mf+Nb1nIugs+VU5L0+1w+bKo1V+Q+m9jpCcqKJmZ6UpU5ueZ9+WFKYNyD05jkF5qQykWZxJx7I1pQ9Z4HtZdF7XYkvmwW5Ax4ZK1+XAhrJTd8cRVWR0Aw99gqbd5xUi63P65DUfOOUEY2vasD3DQUs0TnjwjZG+Ngdms3luthyTc19rqlYg2kH5PuFF3fsck3j5jnS3dhJxeXx9Nz0Hk/SpHf3utNp6ge3n0B+O15nzQsZRnLUdapllNgJX8Xoqi6MzF1T9Ai6rEyOTq9FmGVFJOHJ32UAJPSV/Q8CvoruBOHXfGdCuNyJsxBEBkIB7lvrvFOwv71gZhZ6bY1+ikSauA+5lOG0H1gvrkXwqUFwVBsPChpUpzvF6U3pgjxSAuFCd1iMoaVCtcDN8WCXehhjgvwuNnmTOzLh90uVUC19AjnDzFd6TE9HKm+YB0nNk3vorv3R8qlSKb+PPhznE5lGTtNaqPR7PP5U1rqrH4cpB3r2Cgf5DjYcUbCgIA7JoI0cENbpo7TeIAm2WaPLdWnOco38oou+EF1Gt6teetNktaEJ+1ysfLAb+U7BSzXRYlvjFmM4pp6SYM8PP7S86hjI+4sDJV4q7psH256O2b+Eb03hw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(366004)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(26005)(6506007)(6666004)(6512007)(9686003)(52116002)(83380400001)(478600001)(5660300002)(7416002)(15650500001)(2906002)(41300700001)(6486002)(110136005)(8936002)(4326008)(66556008)(66476007)(316002)(66946007)(8676002)(921011)(36756003)(38100700002)(86362001)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVYxYmlPenZyTjdhd2tkL285TmdEU1dydzB5SUJjRWlWUXgxRWFTRnRIRzVV?=
 =?utf-8?B?azZsT1c2U2wyKzRJZmV2Rk44bWtjVWRWQWFxVjl6VDh4SEx6bHhIQm4xTFlr?=
 =?utf-8?B?OWM5ZU13T3NVSE5JTXUyRVNJNGQ2cjkwcTd0amh5cXRqdDJYTVVHNjlDS3Rv?=
 =?utf-8?B?Q3haRERMMllHSmdjVVo0QlNHUGJoZGlvblY5bXRsYVhyM056MjYzNU1SRUli?=
 =?utf-8?B?YThxSXk2RFR4TVQra0ZTWEZVLzRvcHB5UUJlMUFZN05HcHlGSXZBSnJmMG4v?=
 =?utf-8?B?OVdicGMrYjhaOWhxL3NFOG9mMU4yL2NrZkJibnhwTGNNdjdxQy9JSFVSdnM0?=
 =?utf-8?B?dCt6YXdjT0w5QXFPUWJNUnFqSjRURFdqWXJoajFYZTFpaGVOdDBLZnhtZW42?=
 =?utf-8?B?U0FWcHkyMktSU3RmeStMNmlsOWJnRHBLRmNxS0ZzRnNCRW9qMEtycmJ4aHRk?=
 =?utf-8?B?U0JFbTZjdHZIWHNIRitYcDkrMDdPcGdhajRKWnlxeEpXQmtLdEFYQUwxKzg4?=
 =?utf-8?B?Mm5qbFhoYTlVSGJGNjFQOVJlZXRlVWM1cTZQMURIbTljNGJuV0hzMnBpWGo5?=
 =?utf-8?B?VDE3Y013TDlDZTd4dW94eDRGVG9OdnlERUZ2WUV6M3ZRYWpLK1VMQUk1QkF6?=
 =?utf-8?B?YlUwTG1UZlhvODBBMmxsNVIrY3RGSEx3ZU9FdXVwRWtNKzdwanNhYW1VMEVR?=
 =?utf-8?B?dXowb0RTRjFtZ3I3N0xsWmN0RWh4cjNqT1FWUzF4WFpkYWJ0M1NYNFZuVFlk?=
 =?utf-8?B?eUNCeWovRHBLRFl1aXlSMnpuVThqMitrWGU1Z0U0Ymk3NmlmVkNtV0crMjR2?=
 =?utf-8?B?bC9EQXdMR0RGbWd3SzBRL01hUkYweUhOR0t0RTFCbEt2anBrM3ZtMU01MGlk?=
 =?utf-8?B?UmlTQ0lNSmRYZmFSSStoUlM4b29BV3ZlR2RhTmQ4NUhPdTFpUld1Zm1pVVdo?=
 =?utf-8?B?YktCT0U0WitPbHlkUloyLzRYSzFmR3dCK3FJcHp4QnRZNmw4RzFueVFNaVgx?=
 =?utf-8?B?dWVKaFR1bFRmbDBRNUh4bHhHWVAzRW1rWkpLQmlkd0N5R2sxMlZRcEZZRnI1?=
 =?utf-8?B?MEZmVjlYVUJ6amd1SFpMSDJpOTdNeXlGZnVCMFppZUliaDBIQ0oyNndYQXVp?=
 =?utf-8?B?VXkvKzBucFh2bzVRbmRXQ3dSS01xeVN2Tnp4UENEdzBxT2hnZ3p2ZUZqSEFE?=
 =?utf-8?B?dWZ4Z0x0RUV5Ym1ITVhiZXJoMHZPSUxkR3dFLzZBOUh6LzJaSFFoQWJoUWNo?=
 =?utf-8?B?V2EwMXhraEs2L1IyaHJycnVpK2k1N08welVoaFhLeDF5UzJ1SGdBNWJuNWM5?=
 =?utf-8?B?WjVaN0ErNFgyREN1MUZtY0ZPM3Nkd2REREdtRFRjOVlNSHhBM1poRUlDcjJw?=
 =?utf-8?B?Tmc1SEZjZXVrWVg0b1c1OUl1UjJOdXhwWlBmZG0ySWpSMTFjaDJKbWRsWXkv?=
 =?utf-8?B?SmtKTjFvQVRDNVJxM3pLWFZTU2g2dFdubzdPdUdEdzg4M3JKTEhSci9mdVM5?=
 =?utf-8?B?bkdFZHZxemc0WHAyemVFNlA4S25jeTg0WW1mZjg4MUdEc29vcXN6dzhrcXdo?=
 =?utf-8?B?WEMzcVRUb2R4UUM0VW1SSU0wazlWRS9JWUpudnhMT3gwRWxITXd1Y2VVSHNJ?=
 =?utf-8?B?eGpadVZPTnJqVGJFbmJFODNDZTBybnNaQmxTYU5rcllwYWlHL2pLVEMzcG8z?=
 =?utf-8?B?dkVNbFlOMFRQNmNvNGpab1ROVmxHdG0wZHlTVGtubi80My9pZnlRUDkrSHdR?=
 =?utf-8?B?WEhER1FpM1pEQ242MmxOVUFtRWRGT1kvek84ak9EeGFnNXVQWS9CSUpPY2g1?=
 =?utf-8?B?YzhlL0hBYkthMkxxV3BHZTZpd3k1QnlkV2VJNE82Vmk4dWY0dVEreEFQdDJJ?=
 =?utf-8?B?YklNZDFGZTBRTTRLbWl1c2IxelFKUnpHa280ZWk5T2FTRU9GSHpoM2kwcHll?=
 =?utf-8?B?MmYyWWdrU3FITTlJb05RMzBaek4zRVFCbmtON1RiU3hWNVVIbGlYUjN0S1NV?=
 =?utf-8?B?VGR2cFd4RE84bzFQaVkzTUlCR3VZSW1heUQwWlEzY1dUdmREVGc0TzJLWExr?=
 =?utf-8?B?RW82d0ZVUkt3dUZyNnBwL1owdlV5SUxWbjNwaDUwSjkwUlNuc0xVTTY3OXE0?=
 =?utf-8?Q?BX1EyHgNIx8d/sLdnGHbdM1IC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2765add7-56f1-4479-63b8-08dc1aee27c7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 02:02:15.3339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mMZIjtuhzOszKYhE0pSTb+Vp1xLpYlpCvWMLM4S1oUinswohCMMAJ/OizYft7plo6XepoYvydNHC0qNHOlnS+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8153

From: Peng Fan <peng.fan@nxp.com>

Add i.MX95 ELE/V2X MU support, its register layout is same as
i.MX8ULP, but the Parameter registers would show different
TR/RR. Since the driver already supports get TR/RR from Parameter
registers, not hardcoding the number, this patch just add
the compatible entry to reuse i.MX8ULP S4 cfg data.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index f2a21baded29..966503a5e9e3 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -1018,6 +1018,8 @@ static const struct of_device_id imx_mu_dt_ids[] = {
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


