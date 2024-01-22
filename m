Return-Path: <linux-kernel+bounces-32377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D20D835AD9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E076FB2625D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD612EAFC;
	Mon, 22 Jan 2024 06:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fWu9QhUu"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2048.outbound.protection.outlook.com [40.107.104.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A7363A7;
	Mon, 22 Jan 2024 06:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705904115; cv=fail; b=t483vDGYg0M6OIPp0FQRKYW/o+BzBhDu/j+P0eITVOIhrlRno+WDD7ZCyev7COrKRAUuj2dxuT5doS9SGeLY2J3VD7Nb5BSrca/kXymGw8DYTXcU//Ma4SaHWLGjGxxk4SD6g2npLw+WpGx8Z9LgqSYtIqoez4qd93qFuPtVe3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705904115; c=relaxed/simple;
	bh=Rppi4l+2cUbzP89VOD09YHTb/KvCtH9gc5rHbtx6/V4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Zi9efNTauipkHhlMOtRjBXIWC7cmab3lqR+zXwdZadaqMlb082UpdcTx5Sotb8l5Fms4CjqQtZMDt3QL7RDQ9NMn7tnPy/vfXlbry5BIYnOvrT3J1IEg1fyY6HB4fN3+mlM2UP1LQljmX1olFV0Sut7XOGZ6i7+I+9QNEXqfAxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=fWu9QhUu; arc=fail smtp.client-ip=40.107.104.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z46lBhOnARC0flBCz7i4nQDqJ8KajuIVc8ZyjkD1hwcb7vOO1BLAzWABWXHOhNlFhsn9ktzzJyKPYbjDhSb8loacIvBaOF+OsjKEeUat5LALDTEH1b5N43tvSIEmUDbdEk9nFTAb7j5FnCg8kgF1tI/PtQyYce5b1EdyDibpgBstOfsFQHVrr+qATmqSCN9KhuKV2Rrb+H3pV9MSSOZcIlBdsO3XqagrUkH9agZsaOSM5bp0nQ7MytwD9Xdef60JjLtzwjZ8NSoHVftdtPmzqQUfQAoKOsbN894KPJmQc/DWThwGisjSPbn11lqaU1UEwrb3vKivUVKkq9a3PyV2Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=he4OIZJtqx2Q7v153MilCDFIDshERVi2Xfa5pWrFZ3k=;
 b=jQwtKJ85mtzv4vin0uXxOQzwuxkZ02lzF88uOcZ42st4Yfxxh0mcp0KjoWRmbuMotmJM3p0AqDb4Agp80+ULnlZCBl3BcfO3vFAHQopRgdKQkRXGx6Zab5DyvdJDlsYE0tLYOT4IOWyVno7z1xaxW1nUZnBRsuOvVn56z1Mt5cNmD486xZlnivrCKESgNLvP2OUNm5FzgJpRDh1mygSQDLLk8WUB+WiCseCG9osb5vBsyaIjc88rnb9PGf9ayA8ghPqQTWsfQq4SKyx7nevkD64G2Vf+lZiRjmLswJAuGXOVnqSXvoZjC7lZSzM32SWL7tSfyUzHlSnzOCc4/aoXyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=he4OIZJtqx2Q7v153MilCDFIDshERVi2Xfa5pWrFZ3k=;
 b=fWu9QhUu6Y4F/uLWNTdmQVRRca4Bb3zN8t9TCCzoT67CA4tiU2hX5xMRHpt4nht9R4BvbWV3TM7c+xI70JErGKXjn9KxMbhA0RrJh62dCpG5HUGH+kzsL6ruWvR/Pa4kL5yFgUlLkrXYWTwoL8OVRG0T+CjdTARrwXFdeXRgNqQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7991.eurprd04.prod.outlook.com (2603:10a6:20b:289::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 06:15:12 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 06:15:12 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 22 Jan 2024 14:19:24 +0800
Subject: [PATCH v2 2/3] mailbox: imx: get RR/TR registers num from
 Parameter register
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240122-imx-mailbox-v2-2-7b3c80333b92@nxp.com>
References: <20240122-imx-mailbox-v2-0-7b3c80333b92@nxp.com>
In-Reply-To: <20240122-imx-mailbox-v2-0-7b3c80333b92@nxp.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705904372; l=4331;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=Iy65IwSAFryjGNiSZCuX9XbUK1AgEleuTe1kp75FjPk=;
 b=Kz4jb/S2/2GYaE5gDEsxQnvVF/jZGT1eic9YvgN9jMfc5zCqArTsSoyPY7d5mtUFT+9z5swca
 SqrIydptHM/AstttLmH+o8qnb8RspPFuvVCeeFUba1/A4rtW9Wj1In2
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:194::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: f3ce00e7-5666-4f39-8c6f-08dc1b117df8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cG4RCSAS5nlyKZ/M4VU535Ph+tsJv+cwCZIp8sjB98QknZZ+mu3ko2NOHEgB0LqDSFgh/vzou6vqUGSM96y+it9zGu80yg5TG2S+N2+QQ0yQTr4D7rVmp3vXp49btUUejuWh/FD4cdvKTqKVxsJTH0PMawXSgOocrzoSkh4Sg4hjraEdVOtHh8g32yXDmQwSuHCDCUASU6F9tAPh3RG+4nbWN1Zo1Ktqi9xTXwg5pfSIB3cMHrXp7k0BoX5EpFUfuZwSUzaBqc6qMdeb/9NB3ZN/wCs8kWBzBh3s3xGBGv/OmfJUe4D5LTvZHQiySK6Xd/Mwg0KHMO7IQLMC9XSDZJU37ugT0LaRMiDpK9Fp2W2GgqKQStAXcYLqQbJBSfV/AOdf5EgXtBY7N/UCpUKYoYCSZGn/Zt6ufeXsS8bFBgzBXb3VYyZhNmchXOKujmSDwyye8xCSxDKR4IrvNxkY6LsHXm8R5d5UEqR87vXWrhO2KRF9sx68GD8MCkFYCfk+S+7pYQctwRrfj9Ls4cu9d3toTKheXpViroFgsQqjX3mVGd+LhGXfjUWZerXLa6DLQKE6PybrjnD6cqffBrRzk4Nk9N1kKALNzBTdZZuh50YagIke3zCj6JSdgfIHCcnyv1coBC97Ev32iFK1YfoTiA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6666004)(6512007)(6506007)(15650500001)(5660300002)(66556008)(66476007)(66946007)(52116002)(38100700002)(8676002)(8936002)(9686003)(4326008)(2906002)(7416002)(6486002)(316002)(110136005)(478600001)(26005)(83380400001)(921011)(86362001)(41300700001)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHZxMmp3TC9DTzlpZlBLd2NWRGNvbFZGRi9ncUlHZ29ucVYxTWh5QzVJa2NC?=
 =?utf-8?B?aWRFc0hveDBnRmJOaEQ4ME9vYnRMQnJFUmw4YjArYnFSd256QzBXUUIxY3kv?=
 =?utf-8?B?OXZhS3V2RTZEQ2FoL0RRS2dHeVNLdlR5a0VsOWNrOTc2WXgvNXJmZ2Vwajhi?=
 =?utf-8?B?YU05VkZya2Q2QkJqaU1wWWZETm5MdnZXeVc1TEpJU2FPano5eVdHZ2NOUzNK?=
 =?utf-8?B?U2h3N1RZY0ZOUUYwbHh5bWFpaFZseU9tOVdLMkRuWE9XN1pvYmRwT29adXk0?=
 =?utf-8?B?NTNUeVpYem81OEpCVnM1TXFteXdwakVPcExScWFTNmZ5RUZjYTFucThJZEN6?=
 =?utf-8?B?SS9lK3pXYzBTUnNVY2svaHNINnRCaytEVE82MklsdnVxVkRXVk9qV0czeTJO?=
 =?utf-8?B?aEJVdXEyeGxqNVRYdG5HdSt5a1lMdkQzSUc3WjJJZGFUQVBXYzNmbDFnK08y?=
 =?utf-8?B?TU5QL2FEakN0Y09GaDhVVDhRZ2NoR3VURHQrMHZiWU5DRlV2YnVMMGRTczJZ?=
 =?utf-8?B?QUliRWZzZEdGRVBtbklWaXlHWWtmL2laMWxtQ0t3WFlwdHozVWNGYmFVNzMw?=
 =?utf-8?B?S1hTRFFEYlNveWI2UHA5L3Nya0RSMjlXaVBRYldnWmg2V3FFbk1PUG0rWlBn?=
 =?utf-8?B?SGd0aTJCeGh6dWdRdFplMUk3NzYxMmFRM3BqbHNod0MyVDNsSlFYTnZrL09v?=
 =?utf-8?B?TDRYWEdZTXlCb1hoNjZ4U2ZlcDFWRnE2ZERZQjZ0Mk5Vb2dSZEJZNDNOcWty?=
 =?utf-8?B?bHRVKzQwZUVIWkpSWXhva1RNemVjSlZyMkJ2dm43WHNIZmJzYklncGxlZFZy?=
 =?utf-8?B?RWlJdVhLSkRrQU4wcnZZMFpIQ081VlFWejdkbDA3WHRoYnJ1U0NjSk5Dajhv?=
 =?utf-8?B?SHNWVk9WcStSeUw1MFRFbkVDa1o2WElVdEpxSTkzVEhvZjIxOHNtUmRza1ov?=
 =?utf-8?B?SEFGYW1BU2c5VGNvY3BNWnVLVDl2Vm5CYWtXOTIzTUJSUitXVEo1UDBZSWRD?=
 =?utf-8?B?MFlGWGxNR0h5V2VuWVF0dWx6dWc4N09BdDZaNTdHMW1xcGhQeEdIa0I2UXVG?=
 =?utf-8?B?NXRNSjUrZFh5WjdrMDNjc0ViU0ZBeGRuVlZ0ZmpCN3R1d3JnMDl1SVhHcWhK?=
 =?utf-8?B?SjRNTE5jUVg4K1RiZDFBZHMzdHorV3g1K1hBaDFacDFDcnQ5aFcrZy8ybzUx?=
 =?utf-8?B?dlNMcUJtb0F4UTlBT0EwNDY0YjZJRjBxcjZWbTI3YjRlQlVsNjNOQmVPNERX?=
 =?utf-8?B?d1ZBMjk0dXYxR3dUdUNrcGd5MXJYRktESGtJMkd3SkJ0L3N1dm1pQW9XaUV2?=
 =?utf-8?B?eTBCTjdQVkxYREhJQit2czgrRTFqV0h2ak53Uit0WlYyK3NlZVVlaEk1UjlU?=
 =?utf-8?B?aEFkNXFVekdpa0JiS2x2ekFqSFI3NDBmclN6T2JGOUlkemNDeW9CMlRtNTFW?=
 =?utf-8?B?VGpBS0I1anZVZFQ1R1FmUEpldk82T3ZtdTFiQllkMC9yakhMYWhuS0hNaU9l?=
 =?utf-8?B?SW1Nc2tKL05rVlVUanI0TGR0NFl1VUdFNzhpcXVKRkpKMmVjTllhTGdoWFFR?=
 =?utf-8?B?aC9UNmFoaGZQN3ZGcWtPcTFiVFhrb292TmJtSGlTcE4wMkJWS0gzeFdtUFkr?=
 =?utf-8?B?SmxYQVlvR0U0R3Vzc3d5dkIxdVh5blRVK044OHgzS3NNdDlQeUE2V0thd1Jj?=
 =?utf-8?B?c0pZSTBFR1B0WCtjYU9MS1pnL3loNndaQmR6eHRNRFBWMVZNdnNaWWZRN1pJ?=
 =?utf-8?B?dG9LYTVZRGNYb3RnMWFJUDhQSTJCMmpUeUJKM3BBQ0RINDF2YUptd041d1lq?=
 =?utf-8?B?QmlSY1lBMCtZcHZvTmIyVTRic09kQlJudXV0bHlrakRRN0I4WS81TE5ITHEw?=
 =?utf-8?B?Rll6Q2VoNm9SL3RseFNUSDRrRTVrblZMNEVGVGN2RUpYYm5JNnlMQW5NbDJT?=
 =?utf-8?B?U2ducG1ZMEQ1SUExOGUyUFBqV2R5UFFDRTlpUFM3cDNQRlVsaSsyQTJ3d0ZQ?=
 =?utf-8?B?RVEwZ2lIWS9UNnVVVEk2Si9MaGRHak1QSGMxMGFkMCtRalNSTVZMS1BhaFcv?=
 =?utf-8?B?S1VPNE5WUTlrWG5vbmxkempVeU9sdTUvYlBaNUVGRUt2OERjWFRvbXdMcU5Y?=
 =?utf-8?Q?hb8dyl23IE+/mbLtpsigMIF8b?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ce00e7-5666-4f39-8c6f-08dc1b117df8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 06:15:12.3297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DrfeBoKawQAHWenwQoC0jxs0TTsfASwcxLh8+Iaxxpop5SNUl6ZThsO7qsciAHLwAoAmPmthuXL/o4vvCTEA4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7991

From: Peng Fan <peng.fan@nxp.com>

i.MX8ULP, i.MX93 MU has a Parameter register encoded as below:
BIT: 15 --- 8 | 7 --- 0
      RR_NUM    TR_NUM

So to make driver easy to support more variants, get the RR/TR
registers number from Parameter register.

The patch only adds support the specific MU, such as ELE MU.
For generic MU, not add support for number larger than 4.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 46 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 656171362fe9..f2a21baded29 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -29,7 +29,9 @@
 #define IMX_MU_S4_CHANS		2
 #define IMX_MU_CHAN_NAME_SIZE	20
 
-#define IMX_MU_NUM_RR		4
+#define IMX_MU_V2_PAR_OFF	0x4
+#define IMX_MU_V2_TR_MASK	GENMASK(7, 0)
+#define IMX_MU_V2_RR_MASK	GENMASK(15, 8)
 
 #define IMX_MU_SECO_TX_TOUT (msecs_to_jiffies(3000))
 #define IMX_MU_SECO_RX_TOUT (msecs_to_jiffies(3000))
@@ -93,10 +95,11 @@ struct imx_mu_priv {
 	struct clk		*clk;
 	int			irq[IMX_MU_CHANS];
 	bool			suspend;
-
-	u32 xcr[IMX_MU_xCR_MAX];
-
 	bool			side_b;
+
+	u32			xcr[IMX_MU_xCR_MAX];
+	u32			num_tr;
+	u32			num_rr;
 };
 
 enum imx_mu_type {
@@ -264,18 +267,17 @@ static int imx_mu_generic_rxdb(struct imx_mu_priv *priv,
 static int imx_mu_specific_tx(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp, void *data)
 {
 	u32 *arg = data;
+	u32 num_tr = priv->num_tr;
 	int i, ret;
 	u32 xsr;
-	u32 size, max_size, num_tr;
+	u32 size, max_size;
 
 	if (priv->dcfg->type & IMX_MU_V2_S4) {
 		size = ((struct imx_s4_rpc_msg_max *)data)->hdr.size;
 		max_size = sizeof(struct imx_s4_rpc_msg_max);
-		num_tr = 8;
 	} else {
 		size = ((struct imx_sc_rpc_msg_max *)data)->hdr.size;
 		max_size = sizeof(struct imx_sc_rpc_msg_max);
-		num_tr = 4;
 	}
 
 	switch (cp->type) {
@@ -324,6 +326,7 @@ static int imx_mu_specific_rx(struct imx_mu_priv *priv, struct imx_mu_con_priv *
 	int i, ret;
 	u32 xsr;
 	u32 size, max_size;
+	u32 num_rr = priv->num_rr;
 
 	data = (u32 *)priv->msg;
 
@@ -345,13 +348,13 @@ static int imx_mu_specific_rx(struct imx_mu_priv *priv, struct imx_mu_con_priv *
 
 	for (i = 1; i < size; i++) {
 		ret = readl_poll_timeout(priv->base + priv->dcfg->xSR[IMX_MU_RSR], xsr,
-					 xsr & IMX_MU_xSR_RFn(priv->dcfg->type, i % 4), 0,
+					 xsr & IMX_MU_xSR_RFn(priv->dcfg->type, i % num_rr), 0,
 					 5 * USEC_PER_SEC);
 		if (ret) {
 			dev_err(priv->dev, "timeout read idx %d\n", i);
 			return ret;
 		}
-		*data++ = imx_mu_read(priv, priv->dcfg->xRR + (i % 4) * 4);
+		*data++ = imx_mu_read(priv, priv->dcfg->xRR + (i % num_rr) * 4);
 	}
 
 	imx_mu_xcr_rmw(priv, IMX_MU_RCR, IMX_MU_xCR_RIEn(priv->dcfg->type, 0), 0);
@@ -737,11 +740,30 @@ static struct mbox_chan *imx_mu_seco_xlate(struct mbox_controller *mbox,
 	return imx_mu_xlate(mbox, sp);
 }
 
+static void imx_mu_get_tr_rr(struct imx_mu_priv *priv)
+{
+	u32 val;
+
+	if (priv->dcfg->type & IMX_MU_V2) {
+		val = imx_mu_read(priv, IMX_MU_V2_PAR_OFF);
+		priv->num_tr = FIELD_GET(IMX_MU_V2_TR_MASK, val);
+		priv->num_rr = FIELD_GET(IMX_MU_V2_RR_MASK, val);
+	} else {
+		priv->num_tr = 4;
+		priv->num_rr = 4;
+	}
+}
+
 static void imx_mu_init_generic(struct imx_mu_priv *priv)
 {
 	unsigned int i;
 	unsigned int val;
 
+	if (priv->num_rr > 4 || priv->num_tr > 4) {
+		WARN_ONCE(true, "%s not support TR/RR larger than 4\n", __func__);
+		return;
+	}
+
 	for (i = 0; i < IMX_MU_CHANS; i++) {
 		struct imx_mu_con_priv *cp = &priv->con_priv[i];
 
@@ -768,8 +790,8 @@ static void imx_mu_init_generic(struct imx_mu_priv *priv)
 	imx_mu_write(priv, val, priv->dcfg->xSR[IMX_MU_GSR]);
 
 	/* Clear any pending RSR */
-	for (i = 0; i < IMX_MU_NUM_RR; i++)
-		imx_mu_read(priv, priv->dcfg->xRR + (i % 4) * 4);
+	for (i = 0; i < priv->num_rr; i++)
+		imx_mu_read(priv, priv->dcfg->xRR + i * 4);
 }
 
 static void imx_mu_init_specific(struct imx_mu_priv *priv)
@@ -864,6 +886,8 @@ static int imx_mu_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	imx_mu_get_tr_rr(priv);
+
 	priv->side_b = of_property_read_bool(np, "fsl,mu-side-b");
 
 	priv->dcfg->init(priv);

-- 
2.37.1


