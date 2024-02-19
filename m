Return-Path: <linux-kernel+bounces-70726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DDA859B94
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FB871F222A7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 05:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6353220B0F;
	Mon, 19 Feb 2024 05:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HGneWwVZ"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2057.outbound.protection.outlook.com [40.107.13.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7C61CF8C;
	Mon, 19 Feb 2024 05:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708319677; cv=fail; b=D7Z/tNWZAwd3Viizqjx25zpf0hsI35wged0kyMGNTMHZYJ1gm0pv8FKvkDwtugz/XpyVjoh6ivWvRvsKVC4Pku17mshg6u0ZXL8/qmCLcYDJVGdSk1/bxO+coJkQcwNw/agFAMNi1WCpf9J7/wpDBq2AmlB1SzVNdEJ81to48uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708319677; c=relaxed/simple;
	bh=7M9rRbQSyHl15SxmDzFz1x0kvHQfKPe+N94l1TNlM9A=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=AWLHvwZ7UAg+eyYZP2x5ZYytI8yZ8+FKZj72uKqzDvzxNFINiRHJC9ILFYeAscuyTeSkBQzuiVv+XVj3eyi08xtxA4lMkjzMlIe7aXJW81++mbomLR8apSoDQbyVJBdYTWsTzWIOcfBMqxi5HzdD2hXeL/73bLQ56X1wiDCcR4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HGneWwVZ; arc=fail smtp.client-ip=40.107.13.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IziKeHMqcEqEEkZjOG4vu23NNm5N5pYQqsKJQ1Qvc0SV2d8OOf1b94Cq2Sc3fDh9ommnA75YsOgGAiaYPvE0opapPfRgopUhd/Lthzi/4CeawXCNSjqESmobfUWj2V36ddsKlw3mIDsmE/9DZfSJkyUII6aUdERYCXBTMY51WEHrnCSq5Z6tfsSPqKwjcr8Qj0GDPfp/5qVn0cRE7NXUhqR74sf7L3ePPitMZcX2MzPFQzxAomR8YTiDeff+w3fxJ9LkSy74JuLVyKK0BzlffzzqVLgUdk0bhMgfWnBj90PvvzjfZ3rnNOqhT6lVKB8d0IxmiPwSk2zqCH4a6GdB9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9ASzfsAckp3To8egZu08nxG9biwql10p21FAR/MCyQ=;
 b=VMHY9Vx46e2KpGjt5gcYeFOJsJAammVFOnMsLeo0svPkjtGPn7yP3dTrbgBejQeXct1GXPKpUMo15VefLilHDYu1kWKn04lZRnidUApBBZa5JZEDZaP67dOHNaN0BXFmFRnoKFwzbUsmka/fkeSXjMVnJS7V7OMDyRErd62aKosjAYFMuEc4aH2YqZ8l7hhST9YXwK65zIhYlblHwkOHSsTHK77PcdVsqZvMjogvXnYlBg8fVDFd5s4gapupPBpd5PfbRuUAUaPxM5/gnG0i5q94dta3khVItViwrEiEXuzcNHElfkoLBD7JVHE1mh6PRvq+LCpgmOFlcCIlPM5HaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9ASzfsAckp3To8egZu08nxG9biwql10p21FAR/MCyQ=;
 b=HGneWwVZish6n09LAoLeYyFDR67VOOxtszu4x5IKhw4cIeJwjiA5aqFW0+nbYhi9xufMSAwIvibPn6g0iJbULsRkXVuauhwLactnFEENUs+5b2+ZUgKuQBjV/+bqBGFvuhNqQi06BBljM6wjpPnISbXGs69V6c6C+FHtWaNR50s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7228.eurprd04.prod.outlook.com (2603:10a6:102:8c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Mon, 19 Feb
 2024 05:14:33 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1%4]) with mapi id 15.20.7292.033; Mon, 19 Feb 2024
 05:14:33 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 19 Feb 2024 13:22:38 +0800
Subject: [PATCH v8 3/5] mailbox: imx: get RR/TR registers num from
 Parameter register
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-imx-mailbox-v8-3-75535a87794e@nxp.com>
References: <20240219-imx-mailbox-v8-0-75535a87794e@nxp.com>
In-Reply-To: <20240219-imx-mailbox-v8-0-75535a87794e@nxp.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708320164; l=4560;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=+IlXw1fjOboyTpIeSVF2fKTUEdBumvKo2AnSNJfxvrw=;
 b=41pBRlnIH6TjyGOqqmrKz3uruf12AZxg7vL+ILU9kg91mRfsdQxc5TUNuyWq9t4mYxS6Ypf+Y
 RnV7esNF01rDHO3CVVKH09DAows2Q1ek7n+Hd7YeShhrEyKcVs3HnTF
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PR3PR04MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: 76e3544b-f09b-42fb-9a71-08dc3109a8b6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	u26Nk+rvKP7150Hce/QHLE2MYXKlfldILCGmrpkN0bOvP4RwJ8Ygx3W2+vJV6svwPlTpadTuQ2PzJmy+KbIP6wmYFL+de/Rse4MmBi5pLFjP12Yc2TEk/deNUFVc8vqjtgI92J8cQDU6eLhhBNw8OwcUJoRQ972wLGn/8nCn7ub/l/rTWyNz3GD8tUyjGND/xOPvxRW6gyhV/aTxJy0/8AljLU2Wob21h4wFWKPl9VXVl+cUH1p1NhpGTq5mdCKtm5IpNt0fH5hcCpnM2SlOnTuRG3tFnXYED5jYqTtgEh++BDnB1dHtc2BhRwkOOuXB/vBxUNuSsHzoQX65BU4yjxAuoK+Dc7DCYSmZqPM4pQg24wRfSMsKJ5K2eDryhmpZTt+wzENNxc+ZVN66XOHqYBZe9/GoC3FOd6gacd3XHEAYcbdQ3tL/lbMADJW8DOO7aaIraJ9wDBPUc1wxiiuXaNq/nRydrHKcoYByAFXkImUGIr6APqdjkVu5neDT/HrIbIH8ngUNxDFheSNr/yooYgfhP+vidkIK9IxMDSZ3EkEFElUCpYLctns3hKLdokl1h23VPEzlUHpZgZiF/AVq7xQjKHDkJF/P+wCeyrVrlxIlaRK15FoFRBp6Syhv5hUoXLyy4U/VDSZpu/203NvUNA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39860400002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(41300700001)(8676002)(4326008)(2906002)(8936002)(66476007)(66946007)(7416002)(66556008)(38100700002)(5660300002)(15650500001)(86362001)(52116002)(6512007)(316002)(36756003)(6506007)(9686003)(6486002)(921011)(83380400001)(110136005)(478600001)(26005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHd3b3VpTy9KVHhmblJEaUJVRnViZmRkb2VNbktpbHM3Z2E1MzIzMjc4bDcz?=
 =?utf-8?B?YS9ra3orZGdlWU11QTZIZEtEYXZmRWFNajNXZ00wejJxK2wvUFUyMEdPbkc2?=
 =?utf-8?B?NnFKRjlOYkhDY3RVQU9nZWh3K3FpWXRSR1ErMDUwODJxcGdmOUkxR0NHb1BX?=
 =?utf-8?B?SEc3WTNadmh2dnVRUDk5NzRzcU96ZzErY211Q09LMnNIWWhXRjF3OSt6cCs4?=
 =?utf-8?B?TDFaYmErOVF4b0xvU1BYK3poMlVDZDZtL0lSTU9NRnFOTEV0bGhIYTIzZkZW?=
 =?utf-8?B?Tmd5dW5sVWFCam5YZzJkMGVoWEwrV3JIQ3VVdkp5aVNaTTlTSytRRlI3NUY0?=
 =?utf-8?B?TzZtTU0yNnNsNDZjQjNORUR1MGt4ZXVNQkNnYnlhRjZEZytmRkcvdFV3Zy9S?=
 =?utf-8?B?ajBjYkV1QzdFalAzTS82aXo5b2JmWDFIMWFmY0Rmd2x1QXFyWE00dkY4b0ww?=
 =?utf-8?B?WjludVBWTG9QNFprd1ZFSG9SMHZsd21xMnNQb080MFdsclhlLzBLZE1SUDl1?=
 =?utf-8?B?NS9GNU9FRXU1VEVWLzRGWWpMbm1ieHZDTWViczRiUml1NWVwZ1JzZ2pPMEJU?=
 =?utf-8?B?RzBvbndmZ3c0NC9vaUl3VkhrNEsyY01NbDlqVVhXMUh4WTJwY3pUZkJ6NEVD?=
 =?utf-8?B?Qm43UkV5eGk5KzkyZXBtanpBN0pnRE9tcEN1RncrWnhaUFVneWozZ05BWlpI?=
 =?utf-8?B?dm11Y0hka09kSnpqTFJucXV6dXB6Z25hOWl1K2JjVGxZVThrakJTVFcwUFp1?=
 =?utf-8?B?b2JNVXpraXN5WGlVSEZQT0hCWi9Jam45Q1dQOGs0VzlCYmVRcXFsRmFHakgw?=
 =?utf-8?B?cUJGSm41a0FOemZVaGxncFArUCtwR2tkRnlrQy8yNnhjMkd6QzBCTDdzMFMx?=
 =?utf-8?B?Z3A1TGNMVTJiNnhaS3dTOW5CTUFmZFdKOCs5MTJ4MUpmcVJZQTRsbWpQV2dI?=
 =?utf-8?B?RHQySlR2YjFGU0tlRVVrMExuRytWbWoxQnJMTnpWR0JRMVk0L0dYVjZIZlVz?=
 =?utf-8?B?NHg1RGk0K1hTMnMxVG1kbkFvcmo5b09rQXFYeTJ2MzhySWhRbDFVcWFpczhW?=
 =?utf-8?B?MTBCMHArelVqUFE4RFM5aHpQVWFVL05HMFhRVXFFVkd1MVM3d0Ftd2hNQVVU?=
 =?utf-8?B?VXpHaElqWTNzWXRUQ0d1cEtXODBXbEROMktrSVdaUTBUNkxlMWs0Sy82RGpF?=
 =?utf-8?B?d1ZacU5Na3grbVMzTGlFTFZsMlRyNEh5a1FENkRFd0F3aVFDeDBkVkhVY2Ja?=
 =?utf-8?B?UTFyalBQSmxJc0V4QkJmRzN6c3VGRVQ1d1ZBb25HOFQwVk4vdThlL0RwTDFU?=
 =?utf-8?B?WWp3NDg2TGo3TTRTY0pQNnd2WUFQeGRjSEFUSjlUSm5LRUZDaURnTnFTOXV4?=
 =?utf-8?B?Q3pZa2pyM2FrY29LdXl5Zm5yKzRjcEpabndWa3c2UDdnMDI4TlBRMGdmOGdG?=
 =?utf-8?B?T3Y3RXR5TkF1dWRRYk1peWZxSE5GRVFWb3l1b2ROVXZuNTNRUzRBQ1FGbnJj?=
 =?utf-8?B?N1ZwRjVEUXUvQ0lreDhPN280dE9zVDYxbmMvUGtTTEhPOFg0aW5xaVF4NzdZ?=
 =?utf-8?B?S0RWNlZMa1BDcDE4MkFWdURRbzNSZU9aWFd5cHpBWFRwdHFMT05BY1JaNVlZ?=
 =?utf-8?B?ODlhUVVvcnI1eUxSZU12MHVyaXZjamI0UVUzcjBFQmlIMTlZUW9PSThUSUZn?=
 =?utf-8?B?NG5TQVpPSVhDSjMwQkorY2RBSElLekt3WmFEUnM2UzVlL3hBdmJDeUJVK0dG?=
 =?utf-8?B?NnllTkJGT2wzSEhqdEJZOGJ3L2g2RTIrWU1hTjl0VTZtV204dEYvVWxGMWg0?=
 =?utf-8?B?ZUlNakwwVlpVWDg5UVZEekd3VnAzRERUdlZZb25RSnQxdG9peDNTLzcrMGFF?=
 =?utf-8?B?aTNTZmdkdUNDVFI1dlAvM3BPUksvZ1lUaEZud0NxUEFxYW9yUGNwZmlTc2p4?=
 =?utf-8?B?VC8rd1RneUN0aWs0V1crOU5FY3F6MXpJZDBpZkNCNldldEk5OEU3T1A2ZlBo?=
 =?utf-8?B?Y0tVUncvaVNPdm1saXA5WHZNdzRITXdxRTZEa2ZJWGdrRWN1cnJ6SzFHY3VO?=
 =?utf-8?B?VE5ZRjJUclVGVk9ZYmZZN2VCNElFL3hNNnhTamVmWEgrVUlKbU9oZ0pkNzBL?=
 =?utf-8?Q?0iJO91tbl8GdPA0cOaEh3I/8J?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e3544b-f09b-42fb-9a71-08dc3109a8b6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 05:14:33.5985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jz0MqbYpHx3ZQx0INYB7o++ajMlMgCbIWbhncpq849QspC/Eg3f+HMFVC2CtHThYEjyAo40AWMV+J2R5Bb2GoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7228

From: Peng Fan <peng.fan@nxp.com>

i.MX8ULP, i.MX93 MU has a Parameter register encoded as below:
BIT: 15 --- 8 | 7 --- 0
      RR_NUM    TR_NUM

So to make driver easy to support more variants, get the RR/TR
registers number from Parameter register.

The patch only adds support the specific MU, such as ELE MU.
For generic MU, not add support for number larger than 4.

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 47 +++++++++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 11 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index dced4614065f..306af1880415 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -4,6 +4,7 @@
  * Copyright 2022 NXP, Peng Fan <peng.fan@nxp.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/firmware/imx/ipc.h>
 #include <linux/firmware/imx/s4.h>
@@ -29,7 +30,9 @@
 #define IMX_MU_S4_CHANS		2
 #define IMX_MU_CHAN_NAME_SIZE	20
 
-#define IMX_MU_NUM_RR		4
+#define IMX_MU_V2_PAR_OFF	0x4
+#define IMX_MU_V2_TR_MASK	GENMASK(7, 0)
+#define IMX_MU_V2_RR_MASK	GENMASK(15, 8)
 
 #define IMX_MU_SECO_TX_TOUT (msecs_to_jiffies(3000))
 #define IMX_MU_SECO_RX_TOUT (msecs_to_jiffies(3000))
@@ -93,10 +96,11 @@ struct imx_mu_priv {
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
@@ -264,18 +268,17 @@ static int imx_mu_generic_rxdb(struct imx_mu_priv *priv,
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
@@ -324,6 +327,7 @@ static int imx_mu_specific_rx(struct imx_mu_priv *priv, struct imx_mu_con_priv *
 	int i, ret;
 	u32 xsr;
 	u32 size, max_size;
+	u32 num_rr = priv->num_rr;
 
 	data = (u32 *)priv->msg;
 
@@ -345,13 +349,13 @@ static int imx_mu_specific_rx(struct imx_mu_priv *priv, struct imx_mu_con_priv *
 
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
@@ -737,11 +741,30 @@ static struct mbox_chan *imx_mu_seco_xlate(struct mbox_controller *mbox,
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
 static int imx_mu_init_generic(struct imx_mu_priv *priv)
 {
 	unsigned int i;
 	unsigned int val;
 
+	if (priv->num_rr > 4 || priv->num_tr > 4) {
+		WARN_ONCE(true, "%s not support TR/RR larger than 4\n", __func__);
+		return -EOPNOTSUPP;
+	}
+
 	for (i = 0; i < IMX_MU_CHANS; i++) {
 		struct imx_mu_con_priv *cp = &priv->con_priv[i];
 
@@ -768,8 +791,8 @@ static int imx_mu_init_generic(struct imx_mu_priv *priv)
 	imx_mu_write(priv, val, priv->dcfg->xSR[IMX_MU_GSR]);
 
 	/* Clear any pending RSR */
-	for (i = 0; i < IMX_MU_NUM_RR; i++)
-		imx_mu_read(priv, priv->dcfg->xRR + (i % 4) * 4);
+	for (i = 0; i < priv->num_rr; i++)
+		imx_mu_read(priv, priv->dcfg->xRR + i * 4);
 
 	return 0;
 }
@@ -874,6 +897,8 @@ static int imx_mu_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	imx_mu_get_tr_rr(priv);
+
 	priv->side_b = of_property_read_bool(np, "fsl,mu-side-b");
 
 	ret = priv->dcfg->init(priv);

-- 
2.37.1


