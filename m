Return-Path: <linux-kernel+bounces-35457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B9B83917E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E84A01C26D82
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434F85FDCD;
	Tue, 23 Jan 2024 14:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GCljrsWv"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2089.outbound.protection.outlook.com [40.107.105.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4425FDB0;
	Tue, 23 Jan 2024 14:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706020485; cv=fail; b=QXaulmdpMywLl65uRQMPHVHenhEStDx+Rm4oT1dM+EivY4HMyfLxrqu+wurtWWXzspvT3auN1X/GlQXnXmXe/Qc0rZXH94ZUWuqmMs/OTofk/SNB5xRs/VUlAYVuWum+VIXca1rf1m6fqtv0Q1A8h3ziKvu3VqCypSoGUbJr3FQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706020485; c=relaxed/simple;
	bh=kA/UZP7RBLxFNlKx/I6oIWRdtMjAl2kfHc9r/eFLYi4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jMpvhUbSc/Ktor2F8gGKaG4t4oatl3ic94FWMXinKtd30+KgEjdQmpugDPf2v8bg1KEiEIqQdp88yuSzk1vnWpnX8EDOrG9cJy+ml/flUA7dFAMfi9N54C/Ejbs/Lh7Pg8gW2E8wEltb0UFwdFL0Cp/60jT4Nkn51Uuj19YYVBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=GCljrsWv; arc=fail smtp.client-ip=40.107.105.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RA1exWQImthHdxV1CqUcpb/cN0QecEYP/kwTfgeEaeAMSpwx4fhtGcbN3ToK1CQZkl8UltwdupOSbq21n4QDaIFAHk8Gec4f+LPitZm22s7bWMB7cwExqKgcdg+XLOqopwUqV9/eYrWJzP+oGhINNs5vwXU2s8H4TU8HhrnUpyjPYe7lrKj6e/O+byrDeJs6MPXtMGwGpP6gfmUVz//UZSSHbJantjy7v2KadYR2dP3r6yfkBcVaXZfs0522BFLuQV8oV7tFxwAAR60hFPIW2piUYTMdn8GpzVYBBUuJByYl2X8p0QJ1kq1MUDPhwqx4UBEzmNsx5tORAa26hd54rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4/oDx+cC2vKsvoZaiTqgZpD/H+Cdwy5IDIRZoQ1eUY=;
 b=Q4Zr8VLlbuaN07YW78cGvDGZaaESJdZuW8nnv194+n/C8drv3CrILTrXlaatBVbNhjNzUpWYTsOArcLfpgGEeaQm0fYepa84WgBtp0rsSVVWtSi4/hzRml6K12hwkYmSP8i87bmreyS2ip2Tr641FIFzkER5oJGp2G7/ET1GjxOkTL7ACst8nC439FTHQrCdz/Qr359LhG8wo+aBjIhGDOU5F6+qasIKyj0TlvMcRRPYlhw5l65jb+41rRauvUVYg5WH1KWkBYZR75GcbuVeXTyRAd5EZVfdBxkndjoySjx3QaS/laZxAmCiHQKd2g3m1ATYRU4KY3hdPGSSZCqnfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4/oDx+cC2vKsvoZaiTqgZpD/H+Cdwy5IDIRZoQ1eUY=;
 b=GCljrsWvhtPMQP3tPR4KQ39DvZWK5rp0nFDYSDp8jEY/cHpO23tYRKb8mYaqFUV0KfI1ihLhiHPYhJ7E3hIFd1nsvxbvMu4gisEt4JUJZFmedQhjxpVRYqD8VB6hVK+lYLSSKjDu63v8lDL/hAgYOS3FYA/tgFKTPK+QVBIttnU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBAPR04MB7304.eurprd04.prod.outlook.com (2603:10a6:10:1ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.36; Tue, 23 Jan
 2024 14:34:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 14:34:41 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 23 Jan 2024 22:38:45 +0800
Subject: [PATCH v3 4/4] mailbox: imx: support i.MX95 ELE/V2X MU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-imx-mailbox-v3-4-ed932945e0bf@nxp.com>
References: <20240123-imx-mailbox-v3-0-ed932945e0bf@nxp.com>
In-Reply-To: <20240123-imx-mailbox-v3-0-ed932945e0bf@nxp.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706020734; l=1973;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=lkPMpPy6UalcvetyTqhwBLnqDq8ONTaWTu9sur2v8yE=;
 b=iXhc8qJsSBjYUXXxziD+NU7sIZe5ZiIbff886vIYen1jwF7owmo8kpCizkGGNgWPMoPp8SNMX
 tDbmnFbFeV9CAg3VrPPkw/Ba1rvz0GhjsI4guZFUStZQqZEP6eolTtd
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0125.apcprd02.prod.outlook.com
 (2603:1096:4:188::13) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBAPR04MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ab2c8db-fb4e-4dc5-9af3-08dc1c206f95
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xqmwJpny/S/mR5Ch2G34PtprpVHuUucNJE1L9L/umg02bU8ecF9kSlm8QWFU2mczNudno3MqNItAd2PfgovGHMBccV7Uav3R//vzy8MvizSGos64//tHbkkR9h1Z5qMVp0Bd4t2SMaSb7vwxkAxhBUvIqFFDCRqYEhVWEoIzmAC4lsX3PxGvmSX3FK6l0pN41HyBhsuMcDzYYwHCZoJXU9KTmmx2S4tqC+0A4g2CJd7T2tflzKARGoi9XcsrLCDccQNwj4owXRJmeSY78dQVVV6HE+VVGasEjdrSG48shZM99nbONG4hNVkK4cm4bRqtq12XtHvONHX4NQPaftwMNUJ3IX23+d9V9wWi8NrHfI1NeIf/N9R1oukcENr2IlpH/TjBn+QBRewbhQLzXiS6Zz17Ga6RYb2frdfjxiElJZ19WvN7NX6HoO7n9456iQ6ofRv9h+/Wi1M+Vp+TbunXivLYJM8NScwASZrBiPziWpa1yBQipuoZyHj/EYubSEJIjQm9d996+MF3l/GOU2SsdfVWiOdhdZcAr5v1qkpYwfTc79eLF9MWCxMZLb9tAAeEtfK7DOz2wbT0CdfUqdBjCYviwnUikSst/u/YJlnVsxHRhQPFMn4TApSGZblBVk0JT94u944CEliMOw/AtGxhPg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(39860400002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(5660300002)(66946007)(66476007)(66556008)(110136005)(316002)(26005)(6486002)(6512007)(6506007)(9686003)(52116002)(478600001)(83380400001)(4326008)(2906002)(36756003)(86362001)(38100700002)(41300700001)(15650500001)(38350700005)(8936002)(8676002)(921011)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjhaNXMrVk9EaG9Id3BUMGdMMFBCL211OUxBaVdCZXBnT0RpUnV2R3I0Z3Fx?=
 =?utf-8?B?WkNUWkh6aW5BYU5TZnJNMU1ycVJyVDZPS1ZhckhleVZVOTB2ZDFJTFV5TU9o?=
 =?utf-8?B?Rm9yUW1zTUdQM1dVai9LSE5FS2hpRzEzZ014ZHI0QldiNnFVSW9DeXJoVHho?=
 =?utf-8?B?Q3ZnQy9mQWl1Z2ozcVJrVGhydC9SV1orejdWMEY0VGM1emFtVEJxNDdTRWZO?=
 =?utf-8?B?a1h1azBXNkJFVTNpNmNHdWJnRTJiSEdCd2hIRGl5YUwrWHlndDkwSFZWNFdP?=
 =?utf-8?B?L0lhZzVmMU1GdXZyNGwveGM4Vjg1Vm85RWpuZVNhZGltT3BKcnhjNHNmMzhw?=
 =?utf-8?B?SXJIWXVyMVRMdVRrMldNNk1uek5xQWtLN0RhMThmR010bUp6RXNhMVY2c1Fh?=
 =?utf-8?B?elZMU3ZLNm5rZGhoL2dOdmZOckNFSHhBbFVubTZ5ZU1UT0RnL3Eva3FHTTB1?=
 =?utf-8?B?Mm9teEZOWmhkMmdVNjRydjFDY0hwdlVpUWMvcFFHM1FtbGtaUzdRcEhWTXVH?=
 =?utf-8?B?eERoR1pjclhHcWVEMUtCZExjMWdIMzVsY2lYMjdFeW9GM3hJMDhoTWYxaDY0?=
 =?utf-8?B?OXB1bGZUTmpTdkVGS1RzNnpBeWpOMnJJRGdubFZJZktRbWhoYzArbUFLUnBr?=
 =?utf-8?B?VnYvSnc2eEpxc0p1WTVpNUZsYWo3dWZYTjZjSjBDYTFUUHFpSjJyOHorTEQ0?=
 =?utf-8?B?MDFRL0V3Mkg2ZWRnRlU1c0RLSW4zazFJZmVwYkxHNWtZbDFUR1k1Q2tQUUhh?=
 =?utf-8?B?VlBST1prUXp6TnNhNGZtcUw3SHlIaVh3VlBjcHU0QnNUelFWaGo2SHRCUXhT?=
 =?utf-8?B?THlValh2MXZ4OTRrdklqNE9FSXFQa1VxdjVLOHpTRnlDcDNwam9QS3AyS2ty?=
 =?utf-8?B?T01oMEs4cWNJUzk4QUZBUXFRc3N6TE9xc1VIMnBsRzVKS2FYZ1FxMmhtdFVD?=
 =?utf-8?B?OFBSWERwV0llb0gxNmozbjlZaUM4SVdvVlRTNW9MRHhYVlI2MmsrRVFWWWZj?=
 =?utf-8?B?K0ZhdTFYYk4zL2RLUkp5cGNSL3RzUXJYQ0JEcUE3UjMwYWFudTRjMStwa3Qx?=
 =?utf-8?B?NWdyQzRUMnBoWTlRWnN0ZjQyR1dQZ3RIWVZ4ZzVMM0NQUkp3OEdadnI3S1hl?=
 =?utf-8?B?RExTN3NmdkpPa09hLzZ6Yy8ySk0xZmNoaGl2RG1kRFVDdGVnblRQNWFIZ0h5?=
 =?utf-8?B?TGo0QWpRR0h2aGIvVmZhWkR1TmQzQnNNWDFya0tPcU53Q1hCTUpyKzNzRDJS?=
 =?utf-8?B?ZjBUNU1vYlo5QUZmRy9Za21DSTkyL2Z2L1AyUjBrQldJWGV3UVZ6d2lVa3pv?=
 =?utf-8?B?T01SL0xEeDdMWXpNY3QrZXFlV3pkUjQ5RDUvS1BjelpxTkVGay9yT21MWTc2?=
 =?utf-8?B?eTRvdWdsTUtuU21rMm1DamtMSTY0Zll1Zm1QTmVrM3V3cXoxclp6aDZKc0Nx?=
 =?utf-8?B?Qm9WaGcxdlNLM2VDSVFxSzN2MlRpdmgvZy8wUklXU1F3WjIzQklDckEyTUtL?=
 =?utf-8?B?N1ZRYzJHNlhZYWxwUklMY0wza29hNE9NRC9iUjNWSWx3QllPNEpYQitiNXVC?=
 =?utf-8?B?bkpCNUdua1NxemoxaDVsRmVvZmsvQXhqUWYyWm1INm0xZHo1RGs1ZmVaT05k?=
 =?utf-8?B?NHR5elk0OWVXTTRRL2xuQ0VtN1cra0Q2TUxyakt3bkNra0g1ak1pZVE0VlRE?=
 =?utf-8?B?RFA5RkJuM3NucjFiZFBDK2xrYmphaVhWMk9Jbjc5b0dlRHRDdFJpLzdyM05V?=
 =?utf-8?B?aUpMR1VHbGRaK0tHNitlVmhUVkxsQ2JkUzR6TGoxN2JZM3RCWk9PVzMvNEcw?=
 =?utf-8?B?d1RkNHA2eWNjZW1Nd1FPNWhTOUUwQzhzMUIwUGFGbFRBWWlCenYvRnIxV1B1?=
 =?utf-8?B?alU4ajVtUllKVFdLdC9UNmhvUzhhaWo4ekh6aW14cW82WXhNc0FsNEU4SWxz?=
 =?utf-8?B?bFFJUnhhWHloK2g2UmI2c1N1cFFhZjJVTnhDYjdsZ1gwc1FaWXRSa0s4ZVNm?=
 =?utf-8?B?OXZqT0tkbVM2WlJNaDFhSlJZbXZhOUwwVXZvaTJiakJXd0VEaDQyQW9GcVBq?=
 =?utf-8?B?U3dxZmVKc2NCU1NSVW4xSkZTaDlGRmtEem5Ua2g3MndJeEJ5S3F6NXZ3S2Rl?=
 =?utf-8?Q?nnzY4rxwZITfhwvHFVHm7DuZN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab2c8db-fb4e-4dc5-9af3-08dc1c206f95
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 14:34:41.7625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fqxn8DCdYw5+sZdSnbPci0Zmky1cIkYVDWr22F7IqLASHz7wW3LV6qACIrR3AOhYVmaCwI9Opggg38kGZvtjXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7304

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


