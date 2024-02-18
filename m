Return-Path: <linux-kernel+bounces-70227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B87D859508
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 07:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7101D1C2114C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 06:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A099AFBE1;
	Sun, 18 Feb 2024 06:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lZ3mIZbo"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63797F4EB;
	Sun, 18 Feb 2024 06:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708237871; cv=fail; b=fo1yPPNd4PtzdszeruGMCcYRR3ZD8ElnmsYXSq/an2AD6bNz4sYq1023kyIVK73FQTepqcZhOQMsgNB1owECXzLzKWGNJjXlsdwKgE0kS9Q9SfQrLQXlwwPCzXlLwFJpREWHFNgk67XisoYx/3/6DkZsI6HOYdK/5aGPF7hD0aA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708237871; c=relaxed/simple;
	bh=frQ3plv7i+YGvj3bO2QL8D9PMljl1C41BZ12kzws/KQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=HSuNX/CPIUF9XmsndnrQTrs7+8Mf1YgBjZHzMj9QVniF98GEytNTpv4OWRHYWvzCvdXB1+qqgF9pxYbhZGKvTapuVDGXPPzpR9axYEeGn4NRtyxggeE/gyA1NxLi/9Zma/FV7HmMh80Jt3sM68cxFH45qNMOShJ8Ud0SFfJESck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=lZ3mIZbo; arc=fail smtp.client-ip=40.107.20.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLW/Vr45UXvhsr1a3lBDSnSQZkgT9Uen3VYg0Vyt2DpcWEl51ecaX4sre69Fq/rhTz73RRxJSeHT1z2oYdjD5VfaiWqhRKQZH0q+xgy8PF2D0iuTkQAAtb8ZvTt5w//9o7y/nt3Ai5klLkhTX8tGgcUMoeRoRC+vLLGcPfN+7hcVsZSuafrCUBS68YM1C15nR/4XtMeLh/wATZ6mn8hZ1aq2G13thzf4L/ldNGBr6oP8zWTTwI/YnQt1PqxuHUOmLkR7Vx6dXoTcbKJm1B6AnIVOJeGvZQalORZ0K5xS8QU/3iGPcEq2mM9/Ad3SU1HmiMBHFViuXa/bNIYOemnv9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdCU/WGl6LD6/MCkvxIVJuG8zYHRcAN9TWzfJfL09S0=;
 b=BAFAcJU0/dfZ/a32Iv1ZekxX/GFumQBxIuKprKT9YbjCsmgtxqr7xZNybZJx8WYD8rD6cR7TFZCuSbEI8TxDeoA3YvKZXUkTWi/ZGWxxCMFDO08hILVaKz36QnvDwZ2fYVENsgaFjLehdjQPcCGgkva8rgXRQDkSOTeF2Xtu1WP0z5zqbyBBlI9Mcn5A7SPu2wzojwmcB7TbMAsW3wQEJxI9q6YVGaUnfGItLhdP0udiKCB6CJk0wWC9j5bmJQaAdX7x8GKfcXrNYRty8iQPIU8ur4ZcIheascs2KWV1DA7+Bvjtk0lwg2SfY7O77F9e+ey+uS7fSXHOF5bsMXtIWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdCU/WGl6LD6/MCkvxIVJuG8zYHRcAN9TWzfJfL09S0=;
 b=lZ3mIZbo00GgGy1c/aZwjyLasXvqBu7GdWOIz7dYY5h8u+CXWWHEVtVYK9BD15gVBf428Uobkb3X5YEHbInfhqZe/F5m32VPk59Kb/j2AKuHU5vYbFn7q1yeor1LbxnIMzFYQE45PCKhucv7YzTZEyMQR/UJa4i4NGrmwNYjm0k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8321.eurprd04.prod.outlook.com (2603:10a6:20b:3ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Sun, 18 Feb
 2024 06:31:06 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1%4]) with mapi id 15.20.7292.033; Sun, 18 Feb 2024
 06:31:06 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 18 Feb 2024 14:38:53 +0800
Subject: [PATCH 3/3] arm64: dts: freescale: add i.MX95 19x19 EVK minimal
 board dts
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240218-imx95-dts-v1-3-2959f89f2018@nxp.com>
References: <20240218-imx95-dts-v1-0-2959f89f2018@nxp.com>
In-Reply-To: <20240218-imx95-dts-v1-0-2959f89f2018@nxp.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Li Yang <leoyang.li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708238355; l=3026;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=WQfinqbFc+GB4U3fIJuCteL81XHN1Ph6wum+yKUZq8E=;
 b=t6Y/uPAuS+WEfj7lBArAsgdCyyD/0RXbSVuiZ41rs0GLSFdQUPMmY39UjQ/T+vqpTbfiimplP
 W/gKWyxvae/Da5Kd+s1cIZYok1eujoJa2Hg+gXPdRLHB7RyBbxNUGM4
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR03CA0127.apcprd03.prod.outlook.com
 (2603:1096:4:91::31) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8321:EE_
X-MS-Office365-Filtering-Correlation-Id: 230c82ba-dd31-40cd-b633-08dc304b2fb1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wjabHavB56jEeu9vfgw3x1WPz8bIvQpDcBzFKD3iKmoTEnz+OCfDazYtr8JrYnBBCs4Z37b54FHg9ZCHubhcGiglGTJEpRp5P239dMN++4gzylAzfwBw/msBpm5WPW5MuC2GvQbKrP7mKb1pnSk1teWlvvDteuSaMu7S4Zn2BMWEP96tNS1+niQMVpNsKzelMSEseG6FgRiCShoQb+OMNLe+8SN7Y5TplE36vCSQpQDFdmJd0xKART9ExFzJtC69Vg7evCgxXu4UKOZx98t+jSVSuCGJTxacxXyCe5mPWj0vdjV6aYfn4bkqH4qnwZ7MHAXOtSNaXjPVYQP8WjxXAsm9VZe/3Dr167reMlxvuEKq2x79/VW4uHNej2dvIc1u4itPmycuQeGOeYGPIIsNyI5roOqYwSm62Kk9OoI9sQvL9iaBociYLlDO7tiMVplBBahpllBhUwSs8v3cPBExN62Au2Fd1p1zafFUezekh98oD5YNSCvL46xEbfdKuahXGGF7eIJ6G+2RzCJD4oNcZh5NpWwNfh33svp9teCHdU55vz/SVyUcI7PHcwUUUY+4l/4EAvIC2tcZkSQxetD13KPDDeHITDlbsVJ+T5bdo6RdyVk0FKpYDY2Bq8cHpL57
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(346002)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(38100700002)(2906002)(7416002)(5660300002)(4326008)(8676002)(8936002)(86362001)(41300700001)(316002)(66556008)(66476007)(66946007)(6486002)(6512007)(9686003)(478600001)(6666004)(110136005)(6506007)(52116002)(38350700005)(36756003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnBpRktsUVhqek9tUGxudWdlWmdkZU9jL2g5RlYxQjV1VzFMYTRBRnBQNkxV?=
 =?utf-8?B?R3JrWTQ5K2pjWVIzWFBKUjZGNFVYMTUxYUZkN2hDMDBKTWlUemVZMW1EeVps?=
 =?utf-8?B?VmhwUXdkYURTY1Q1SzlsUmIwdmFUamhQMmxXd084K1hGSnpGNWpBU3JmZFJa?=
 =?utf-8?B?OU1rcm5DSVhmRnhVTWFidGkyMlkrTmw0djd5dXpSSkFxQkRUZFdRZmdoeXBa?=
 =?utf-8?B?ZkNIczFsbDZobFR1Y3Vmb1BTcmVWZ0VWMHRoak9WdlB6VXJ3cmdMaXRrMnVB?=
 =?utf-8?B?UGJKWEhkT212S0hFVnprRXlUelNLSk5ybkFLNGUwbFYxZGxQcVlibmlldUcw?=
 =?utf-8?B?VmF4MDNWWTRGQjVwaUdUOFdVY1RYZlFaVC9Lak5nZE16SlloL0VBK1pzYy9m?=
 =?utf-8?B?eExBQ28wOXNONmtyM0p6QXdkczJtQTZBa1lHZVk1Ni9taS9LWXdSallPMEZq?=
 =?utf-8?B?Q29CUmxBOEhweDVhdDczZ0JmemxrVXNJWmJ4TWY0T2cxbXkxdHlLVnR3ZXRZ?=
 =?utf-8?B?UE44RG1JbXNIelpjTS9ZaDhwRGFkK2xaRGdSdCs5YUxCM2JWR09yUkVPTUNK?=
 =?utf-8?B?WmVFSTdPTHl0VkIycHpKSTBRZEZ4eml0bjJSTjdZVC9WSzhRNTVNY01RY2tE?=
 =?utf-8?B?VStURktjWHBRS1pWYTd5eHRUeW9VZ3FjUXh1RWVVQWF3eS9Zcm5OTXNoWWgw?=
 =?utf-8?B?bzY5OVZzSk1CNTJTSmRVU1VjVmRENzY0aXpTVlJ4cnRxVFIzUUZZYnBvSkRV?=
 =?utf-8?B?eGZMSzc4cFliYk8yQ1l1T0o0cnRCMTRSeGJlTkJKZS82cmhxQ25la215MVJI?=
 =?utf-8?B?S3lrTkhCeW16aUY5Zk5jM1IwTDk5M0oxdDQ5cjZCY1pEb2JlK3lZYWhWeVcy?=
 =?utf-8?B?TGpFdGpFa3JqRFgxamEyeVp3cVVacTFGek0vbStBblFIeWtGbE13cFYvNXpH?=
 =?utf-8?B?SGlQL1kzQ095T3AvWkR5WUljR3Jrb1A1cDFtWEhuQytOck5DYWZXalgyZVpF?=
 =?utf-8?B?cWtDdWd6YjJDa1ZhNE9SZmxOUU4vSFhTZ1BLaWZJc0g3ak03UjY3bERTVHow?=
 =?utf-8?B?cDN3ejRwNmZvbjYrWSt5QWZmdlNpUVZkaFBpc09vRU5WRHpVYTNmdlE0NXk0?=
 =?utf-8?B?ZnBZMnZEcnRpVWc1Y1I1T0ViaUZ0Y1ZBRmRzamJqQ1pVQzM2OHR2QTMvMFc2?=
 =?utf-8?B?UDdtQk1RMUxhQVBVbUdKZTdMUW9aWVlXRmJnV1VRdDV3SjBjUXpOSm1KaGVw?=
 =?utf-8?B?ZGdlT3pCZzgvVHBsc2NDbk81a3BYUTFPNlBOTVc0eEZCZGhGdVFmbUVJOFJ4?=
 =?utf-8?B?YVcrMlcwMW1udU5jMXIwR1Z1U3Z6Qmh2bUxGRnRvMjI2TUpxUDNYSzVHSWZ6?=
 =?utf-8?B?OEh3RncvRVErMWdrMk1PMmtZa2JVczIyTjZWMWZMY29lRS91czkvcDlNR3g3?=
 =?utf-8?B?RlVwQ0pFbVVTMkkya0VnekYyUzZyTGFwbkxzbEQrWkNVdEtpQVNGUEc0TmU3?=
 =?utf-8?B?QlJkUVRFTGE1TkswNlJzTjJPTzUzNzNwbE83MG1ueVdwUnZwU0ZFdzBPTWx4?=
 =?utf-8?B?UXIwTENwWnNiNmc1Mk5xbFR0ejZpRzgvbXVIZ0xBTmNtZ0VnSzFsL3Rrdjhu?=
 =?utf-8?B?bTdPUnU3cU05eGRtbHRWV3Q0M3c3VEsrc21pSk9LalhPMVFCcG9GbUk0eHI2?=
 =?utf-8?B?MGFWVkNYS2ppSG1MV2Z5SGxuL2RQcVVUZWJSUllGbGg0Y2F4L2x3Mmowd0Zm?=
 =?utf-8?B?TE44Njh2UXlJSmV5Wk1kMVFjWjRRajRwMWtkNTVoMUM3YW9kWk1YMWVUR05x?=
 =?utf-8?B?Ny90RHNNbTdjQ0Rac05XaEJtWDRIQTQxaVVXNVJnMWF2Ukx1MVdrbDZPYkcx?=
 =?utf-8?B?RU5KVnN6NjRZM1NVcGtnZXJFOEZDdG0zRjA0TzZQRjJVcXdDemVGRkt0dzY0?=
 =?utf-8?B?NEtSRlVjOVFud0hWN29GKzVZL2V3UW5qNEQrTlhzTEduWmxpbzNYeUMxc0Vq?=
 =?utf-8?B?YitlWHZTNGNOVkJsZklzbG45VzZMajRaN1NQNmVrZHN4M1g0YnZ0V2Flendo?=
 =?utf-8?B?WHRmTjVuWVZTajNRNlV5VkR2YVZaYUxLWDMvQVhHZmxsY3AwUE1vZERRMEhm?=
 =?utf-8?Q?v9HP2M6CDrF/cfURe3RwnPJze?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 230c82ba-dd31-40cd-b633-08dc304b2fb1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 06:31:06.1495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N5rDbYzeKN8AqWx5352du3zjn/xgWkc6gSYei9gbgpAQYn7ybxdqs3RQDnhY/kOEsmPwO2E/pIvonw/87+2TtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8321

From: Peng Fan <peng.fan@nxp.com>

Add a minimal dts for i.MX95 19x19 EVK board:
 - lpuart1 as console
 - sdhc1/2 as storage

As of now, because scmi pinctrl support not ready, so count on
bootloader to set the pinctrl.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile            |  1 +
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 88 +++++++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 518149d295a1..c830ff88f5f8 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -209,6 +209,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxca.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-var-som-symphony.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk.dtb
 
 imx8mm-venice-gw72xx-0x-imx219-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-imx219.dtbo
 imx8mm-venice-gw72xx-0x-rpidsi-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rpidsi.dtbo
diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
new file mode 100644
index 000000000000..9640f3b49e63
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2024 NXP
+ */
+
+/dts-v1/;
+
+#include "imx95.dtsi"
+
+/ {
+	model = "NXP i.MX95 19X19 board";
+	compatible = "fsl,imx95-19x19-evk", "fsl,imx95";
+
+	chosen {
+		stdout-path = &lpuart1;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0 0x80000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		linux_cma: linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0 0x3c000000>;
+			alloc-ranges = <0 0x80000000 0 0x7F000000>;
+			linux,cma-default;
+		};
+	};
+
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "+V1.8_SW";
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "+V3.3_SW";
+	};
+
+	reg_vref_1v8: regulator-adc-vref {
+		compatible = "regulator-fixed";
+		regulator-name = "vref_1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+};
+
+&displaymix_irqsteer {
+	status = "okay";
+};
+
+&lpuart1 {
+	/* console */
+	status = "okay";
+};
+
+&mu7 {
+	status = "okay";
+};
+
+&usdhc1 {
+	bus-width = <8>;
+	non-removable;
+	no-sdio;
+	no-sd;
+	status = "okay";
+};
+
+&usdhc2 {
+	non-removable;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&wdog3 {
+	status = "okay";
+};

-- 
2.37.1


