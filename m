Return-Path: <linux-kernel+bounces-84506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1179F86A79A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 05:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC76828E5D0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 04:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACF920DC4;
	Wed, 28 Feb 2024 04:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Vab4Cauh"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A83220DF5;
	Wed, 28 Feb 2024 04:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709094188; cv=fail; b=RuqTMqIclQZGRB7NGq4jeiY9GF4ciMs6a6lZBYmYFEy0DzvzPkLIvE4CWoKppfVL0k6sfPwDikIogCoey11s0xmuUKaZ3Y2jiXB52ua2m2pM2bbRC+7jPfq0GLZ5T9g7S7xwP+pD552skSPP3FlO0ByYn3yniaTtvmIdbAfyqGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709094188; c=relaxed/simple;
	bh=fDE9BWjTxN0JFNMOAlkEvZ2Xp4/m3vom/AAIEN+mkLY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Q0/cbi0ljvPxc/fODhO+rV2Yxl9hJJf4MmWhi+XgcDcETWJJcRctFzEcXmAXtHYVv4LGOkSXulquhmwKfx3ivZjGgJs6Uy/v3xwIa/FPhNw2I30KtR7tiS+M7ZK0wruV8ngTSw+yMICCo/BvAQ2P6Ot6r2epj7B0Mi6oPQe9OaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Vab4Cauh; arc=fail smtp.client-ip=40.107.21.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSaLLXLfuCx+wZJY8YfbgKYf48+3wBwYFfiz5ddya1+cwUQLUZIhYssVQo75zH9fR96I4gizJ5Y5GJSw3KS5Q4DnC6yD9bwL88Qdzu5baF+quHHLNRGIylaPHzxjODL8oj875rrTk9DZ0UAh27k4uB4K9PSZLckjfi6XnnjHWmaUbMHVW0FENDA4E6U+KlkcU+KXn+O7VkJ4dxldEftu7DrRCpU5ZR5H5w5Y+ZNOOl0BTMe08+iCSPuhxYoxoWsI3hlZDwtoFzBeWt6VjiEb1psPLNsJcPEmJwXGuajw3cRj3BeVkxE3PLtKfilxatpRDN+s7xXehgAcSmjLul5+Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWFZDVTupKRHqGzPzOcozEj38Hip9TgR0m5LQhPIOCE=;
 b=iJtsVrsu/RRLv3A7uvo/vMnOxW+tKnO1OO4tL6uhXVvClNes1UMJ4ZyBaR2kbEyt0Bh1af56fAo8kTGwef9Y+Oz6HoXTV/7ljVs/GrNppenL3wuGWS2j9nscCLCXRHDGOPd8I6DK6inBT2n/ADhnNdqzZ7wITj/xVOVsY2+xW3qqGUc6t1ItrI6ZObo2x8NWFjClQpjT1F0feFWG7e7AUweBlPLW6s/2BfvHyhT4uyC8CNDqrYonis9wf4XNrl+xOqOJdWHrkoyQA9xtB9rNfMzVOB7bf5b/Y+c7P7UfpWLzscE9aD0OLj2F+uonz44HnGhzU0G9kTWfCYPX177d8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWFZDVTupKRHqGzPzOcozEj38Hip9TgR0m5LQhPIOCE=;
 b=Vab4CauhqeS5Xc6DwHmhy3aq8IgllZfXpNI9OAm/qj+Fop6ock/N0yZSOoWJumnNF05dDQqfgZRfmXpl2Oe7UhPYWkU6LLvff8TPIGfkqklvOlSdkJYQPwolEL6gkn27umnp6Z6OEUlr+50gV4xDl0xbk2I5nKcLkKhgmpXOcoQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by GVXPR04MB10071.eurprd04.prod.outlook.com (2603:10a6:150:11a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Wed, 28 Feb
 2024 04:23:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd%4]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 04:23:02 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 28 Feb 2024 12:31:05 +0800
Subject: [PATCH 2/2] clk: imx: add i.MX95 BLK CTL clk driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240228-imx95-blk-ctl-v1-2-9b5ae3c14d83@nxp.com>
References: <20240228-imx95-blk-ctl-v1-0-9b5ae3c14d83@nxp.com>
In-Reply-To: <20240228-imx95-blk-ctl-v1-0-9b5ae3c14d83@nxp.com>
To: Abel Vesa <abelvesa@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709094675; l=13492;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=xdgyrgvjxybTyzDq8X/GTHuUjGIxReFNUQBlt7Wg4qY=;
 b=WgblZVVeGQHSl14sz7C0ASKpaE7ZPRrECKgAvYIQimT5VlcHq4Nuwx4THNPsng0PajrtKRokz
 MEwzK7rH9xwC8Mvr23++B5Mq0kOfKDBb1nbLb/lacEWgVpKBj+u4Wug
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|GVXPR04MB10071:EE_
X-MS-Office365-Filtering-Correlation-Id: 30a2b881-aa73-4a34-4a3d-08dc3814f416
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FJaONLvQUzkUBX2Uwvw1CZT0cDZJ7wNCMKFxT5qrEHlUPYkAUVnljcsyMyFOawc+/zYSNW0LLqa/m6iGpBEueyl6SR0Vw2japjbSOzZdmHkAZbbk6wj5dbMmho/Iq889b9tUh1HhDf7Ps/OpNDQKUtH6L0PBIeaNC3CBAzH1qV/R7eG2QrXsntnNfanpwrUsiufmN+HPpl4XrZ54tb/Jep3ZgKktnhx7nW3uNPuHgsxIoaplKVo3Lye68xCWcVPhyJHiB9lDjgapujeWi/6cKvoqzxgfsaGjuhejQojpkZ5vruCcarQ7ZXQ3Sjl7l5pASwPfbUwm8x4Z+F0nnJ/1SNVSjkJWhNI9foAXDcFdjW2fnvOyhjKPfmnBers4BZYQn94r+XT7coVYQLLM73KOF3fovcEydPlXJl4ensWWxG9BrpShBzHQU8r4PMaeI6VX7OgK2AiqGvU8McQC1WgZhmt75nkWTkIlhUObgJ6McdvpYtGb0i5W14cHZo/pyUwRY83+I6QcrUlw0Z3usuO1EONg8t5+CzpUV4DrqTh4tdbw5aiK8agBzuBsHlFi6wTtYjgRIGnQm43zepH1uX8Ha4k61BC6EK+DkUX/HwmiAnMzA53TjKDWcdLW3v4dAQNlQZJDJ0UNLzr2dvlYwH4DABE1LbTPLwTE1teHv7gSdgirvyRlQFb+YD3BEf2flHTM+TT5R+X1XuqWiTJIFaRIa8lHC49LA55WqEn1b/uoYPU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlJKYnNPU3BjN3RVbmxCQ21CbUV5Ym5YVlNSemx4Q2xBK3d3TThmZFJNK2Y1?=
 =?utf-8?B?aDdxOG9oWnVUaXg0Mzc3QjYxZ2JacnJjaVVlZkpCU2hMOXFpRXNqaytvbnFL?=
 =?utf-8?B?WDM0SmM3UzJUamV0NTJJVldTKytITE1LdXpQeFYzWXVUNzZLRHJaOVdtTGlW?=
 =?utf-8?B?WmpTNXh4MDd0UnJzRGZSaDZPRi9KbmY5VXc0U1l2alBDeCs1RHIveGVYS3Ey?=
 =?utf-8?B?TVdZSFo0clY0YmNPMVp2eHphbldkMnJFdGxUSmh4NThSeXJoRGREeW96aDBj?=
 =?utf-8?B?dk5xSmVmQWhjUDVPWmUyVTE4cW9YWWtyRm5tS0JGdFQ3Q0Z0cEZKbU56K3pM?=
 =?utf-8?B?NmlydUtVYmk4OVM2N3hyZERicW5LOGZZVHNGQlBabHpRZTdUMy8yZHdmNUMx?=
 =?utf-8?B?Yk1Ham1jYzhhUi9PcTJHanY1VDNjRjl6L3FsbERVT05JajBRM3RVUTA5b09X?=
 =?utf-8?B?SitrSC9UNkV2Rkw5NmZZbUgvRERMSVpkSlZsZVRQWUtGU3FwdXpvMlB6bSsx?=
 =?utf-8?B?WWVTMk1sM2xGd2RUSXlMazZRa2NiR2pINGFCR2RRVDVEYlN5Q09kTU5XYkZr?=
 =?utf-8?B?T1hPaWtWZXovVTVVZnNlc2Fhc2lQK3VtcjBMa2JJY1Bab1hneDJMUG8xQk1W?=
 =?utf-8?B?TVcyNEhHWjA3OVRTOWt5OVA2dGxJcWY4WFR4YWZ3VmltUDlBRmh2M25sQVQw?=
 =?utf-8?B?OE45cTVBaGJoRjI5bmNWakVUOWZ3czlZdndJTTc5WnBVS3NTMElUL21UemFZ?=
 =?utf-8?B?eDBFL3ZZYkFjVm10NFVuVk12MVlLTWdHU2JoKy9UVHNraDJaSHFzcVZrUGRW?=
 =?utf-8?B?NEFJMEJ5RkwwczRoVWJ6TmQxbVZQSmxyS0ZxVUxseEZzOWxOZDBHdGVjamtK?=
 =?utf-8?B?TzQ4RmZMTUZFd3o2UzNrV0ovdWtFSThidS80VVAyeG5UUGd1Z1R6QU9kRm90?=
 =?utf-8?B?UUZiRHJmTFR1SDlzUVladjNXTFAwTkV6eW5HL2NmUGh2dUZFMlVXNXMvdXhB?=
 =?utf-8?B?OXVQN2RuQ0hmUTE1enpkTS80RS9UWE04djVEbnlmOUk5Q0dBWU53Vm5DckZF?=
 =?utf-8?B?S2pmUXZPTUpYam5mY0Y5Zlk0cVl5S01MYTBsdUNRdjhRT1lPS0crVitScTBJ?=
 =?utf-8?B?YzJ4Rkh6RFNnelV1andYWDdjVVBvMGM5SjMrek8xcWNLWTVpQ21ScEtWekxh?=
 =?utf-8?B?Y0NQKzY0c0hSd0YxVTI5djEzaVNlNFl6cndEQVE4akRJM0xWZ2lpWUtiemRC?=
 =?utf-8?B?WXJTSWQ5a08zNDlVU0NYUlRyOGJkaDhPdElYak1RS3B2ZG9GM3I4R0NaYW5s?=
 =?utf-8?B?TDBWaGdETGFDM1VQNDZibjA4bVUra1RXZHNYVi9IeWVmNkpDeEZTbjJEYXVh?=
 =?utf-8?B?QnhNNlJKUVYxWW5XdDRTKzEwVjY4ZHNmRkdZNTdKUFZ6VmJmbGF6WGhsUWhY?=
 =?utf-8?B?cnBiZE5JMUpEeHhnM3lEZG9rdDNONFVmTnR6bWVZRndic20vamJkMWhLbm1C?=
 =?utf-8?B?OXZISk4xS256SVdJdllrZ3VpOXNDNG4zck1uYWtvMmJqZjQzTG5wZ2haMTF2?=
 =?utf-8?B?bkZOT2tGWktsbzZ4eE9xc1RtRml2dS9UTzBlazJLTTRHZ1lOOUlQdEhHQ1Uv?=
 =?utf-8?B?Z2tNckxEeHhpZ2RuYjBSYlhCUGVjY3NjQWdGZmRhV1pMK0YrYkxybEFBRk8v?=
 =?utf-8?B?bFhoM1hRZ2ltajgzTnkweTdxV2JuOEZ5M05jSExxa0dvaUhPc1N5aVJlRlho?=
 =?utf-8?B?WHNWTWRFLzhFL2pIRGtOMDJ6aGV5YVQ5VTB3ZnlDc3E5UUNudk1PWTZVSlVL?=
 =?utf-8?B?cDhBYlhVYUx4S3M2N1RtT3BQTjl4ckxxd3R5OUIxemF0dHpoN3dJbkF1MTZi?=
 =?utf-8?B?a0tvcUN5VGpyY3NveTlGemk5aDhTOExoOGU5WDRGbWdVZmZQVlAzWWtpV2tL?=
 =?utf-8?B?UVl3eFgraTZ4bUl5dDNxbnhqbVdHcjVTcWZlN09JQkhLUkJXb2JOK2pVN25Z?=
 =?utf-8?B?K0FseWpaZzE3WFAvRkFDUjI3aFVOVFhaeCtKZ1hLMGxacGRQbHpTa0RiemFC?=
 =?utf-8?B?YnZlWStKa2VTT1dRWjlhMjVtYzZJb0M4a1dzdXV2MjBNRHkvZ2NST21hM3ht?=
 =?utf-8?Q?M4XYIqt3rUvbIyhZHac0zoal2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a2b881-aa73-4a34-4a3d-08dc3814f416
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 04:23:02.6791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cwULBlt5HXbNnBtWIF4QrTN/nFG464teOP5et7Ev9AYeG+AyI02v0k8XOnivyMqWsB8IkYf6/VpVsk32hDYl2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10071

From: Peng Fan <peng.fan@nxp.com>

i.MX95 has BLK CTL modules in various MIXes, the BLK CTL modules
support clock features such as mux/gate/div. This patch
is to add the clock feature of BLK CTL modules

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/Kconfig             |   7 +
 drivers/clk/imx/Makefile            |   1 +
 drivers/clk/imx/clk-imx95-blk-ctl.c | 438 ++++++++++++++++++++++++++++++++++++
 3 files changed, 446 insertions(+)

diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
index db3bca5f4ec9..6da0fba68225 100644
--- a/drivers/clk/imx/Kconfig
+++ b/drivers/clk/imx/Kconfig
@@ -114,6 +114,13 @@ config CLK_IMX93
 	help
 	    Build the driver for i.MX93 CCM Clock Driver
 
+config CLK_IMX95_BLK_CTL
+	tristate "IMX95 Clock Driver for BLK CTL"
+	depends on ARCH_MXC || COMPILE_TEST
+	select MXC_CLK
+	help
+	    Build the clock driver for i.MX95 BLK CTL
+
 config CLK_IMXRT1050
 	tristate "IMXRT1050 CCM Clock Driver"
 	depends on SOC_IMXRT || COMPILE_TEST
diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index d4b8e10b1970..03f2b2a1ab63 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_CLK_IMX8MP) += clk-imx8mp.o clk-imx8mp-audiomix.o
 obj-$(CONFIG_CLK_IMX8MQ) += clk-imx8mq.o
 
 obj-$(CONFIG_CLK_IMX93) += clk-imx93.o
+obj-$(CONFIG_CLK_IMX95_BLK_CTL) += clk-imx95-blk-ctl.o
 
 obj-$(CONFIG_MXC_CLK_SCU) += clk-imx-scu.o clk-imx-lpcg-scu.o clk-imx-acm.o
 clk-imx-scu-$(CONFIG_CLK_IMX8QXP) += clk-scu.o clk-imx8qxp.o \
diff --git a/drivers/clk/imx/clk-imx95-blk-ctl.c b/drivers/clk/imx/clk-imx95-blk-ctl.c
new file mode 100644
index 000000000000..4448b7a3a2a3
--- /dev/null
+++ b/drivers/clk/imx/clk-imx95-blk-ctl.c
@@ -0,0 +1,438 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2024 NXP
+ */
+
+#include <dt-bindings/clock/nxp,imx95-clock.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/pm_runtime.h>
+#include <linux/debugfs.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+enum {
+	CLK_GATE,
+	CLK_DIVIDER,
+	CLK_MUX,
+};
+
+struct imx95_blk_ctl {
+	struct device *dev;
+	spinlock_t lock;
+	struct clk *clk_apb;
+
+	void __iomem *base;
+	/* clock gate register */
+	u32 clk_reg_restore;
+};
+
+struct imx95_blk_ctl_clk_dev_data {
+	const char *name;
+	const char * const *parent_names;
+	u32 num_parents;
+	u32 reg;
+	u32 bit_idx;
+	u32 bit_width;
+	u32 clk_type;
+	u32 flags;
+	u32 flags2;
+	u32 type;
+};
+
+struct imx95_blk_ctl_dev_data {
+	const struct imx95_blk_ctl_clk_dev_data *clk_dev_data;
+	u32 num_clks;
+	bool rpm_enabled;
+	u32 clk_reg_offset;
+};
+
+static const struct imx95_blk_ctl_clk_dev_data vpublk_clk_dev_data[] = {
+	[IMX95_CLK_VPUBLK_WAVE] = {
+		.name = "vpublk_wave_vpu",
+		.parent_names = (const char *[]){ "vpu", },
+		.num_parents = 1,
+		.reg = 8,
+		.bit_idx = 0,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+	[IMX95_CLK_VPUBLK_JPEG_ENC] = {
+		.name = "vpublk_jpeg_enc",
+		.parent_names = (const char *[]){ "vpujpeg", },
+		.num_parents = 1,
+		.reg = 8,
+		.bit_idx = 1,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+	[IMX95_CLK_VPUBLK_JPEG_DEC] = {
+		.name = "vpublk_jpeg_dec",
+		.parent_names = (const char *[]){ "vpujpeg", },
+		.num_parents = 1,
+		.reg = 8,
+		.bit_idx = 2,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	}
+};
+
+static const struct imx95_blk_ctl_dev_data vpublk_dev_data = {
+	.num_clks = IMX95_CLK_VPUBLK_END,
+	.clk_dev_data = vpublk_clk_dev_data,
+	.rpm_enabled = true,
+	.clk_reg_offset = 8,
+};
+
+static const struct imx95_blk_ctl_clk_dev_data camblk_clk_dev_data[] = {
+	[IMX95_CLK_CAMBLK_CSI2_FOR0] = {
+		.name = "camblk_csi2_for0",
+		.parent_names = (const char *[]){ "camisi", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 0,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+	[IMX95_CLK_CAMBLK_CSI2_FOR1] = {
+		.name = "camblk_csi2_for1",
+		.parent_names = (const char *[]){ "camisi", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 1,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+	[IMX95_CLK_CAMBLK_ISP_AXI] = {
+		.name = "camblk_isp_axi",
+		.parent_names = (const char *[]){ "camaxi", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 4,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+	[IMX95_CLK_CAMBLK_ISP_PIXEL] = {
+		.name = "camblk_isp_pixel",
+		.parent_names = (const char *[]){ "camisi", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 5,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+	[IMX95_CLK_CAMBLK_ISP] = {
+		.name = "camblk_isp",
+		.parent_names = (const char *[]){ "camisi", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 6,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	}
+};
+
+static const struct imx95_blk_ctl_dev_data camblk_dev_data = {
+	.num_clks = IMX95_CLK_CAMBLK_END,
+	.clk_dev_data = camblk_clk_dev_data,
+	.clk_reg_offset = 0,
+};
+
+static const struct imx95_blk_ctl_clk_dev_data lvds_clk_dev_data[] = {
+	[IMX95_CLK_DISPMIX_LVDS_PHY_DIV] = {
+		.name = "ldb_phy_div",
+		.parent_names = (const char *[]){ "ldbpll", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 0,
+		.bit_width = 1,
+		.type = CLK_DIVIDER,
+		.flags2 = CLK_DIVIDER_POWER_OF_TWO,
+	},
+	[IMX95_CLK_DISPMIX_LVDS_CH0_GATE] = {
+		.name = "lvds_ch0_gate",
+		.parent_names = (const char *[]){ "ldb_phy_div", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 1,
+		.bit_width = 1,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+	[IMX95_CLK_DISPMIX_LVDS_CH1_GATE] = {
+		.name = "lvds_ch1_gate",
+		.parent_names = (const char *[]){ "ldb_phy_div", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 2,
+		.bit_width = 1,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+	[IMX95_CLK_DISPMIX_PIX_DI0_GATE] = {
+		.name = "lvds_di0_gate",
+		.parent_names = (const char *[]){ "ldb_pll_div7", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 3,
+		.bit_width = 1,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+	[IMX95_CLK_DISPMIX_PIX_DI1_GATE] = {
+		.name = "lvds_di1_gate",
+		.parent_names = (const char *[]){ "ldb_pll_div7", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 4,
+		.bit_width = 1,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+};
+
+static const struct imx95_blk_ctl_dev_data lvds_csr_dev_data = {
+	.num_clks = IMX95_CLK_DISPMIX_LVDS_CSR_END,
+	.clk_dev_data = lvds_clk_dev_data,
+	.clk_reg_offset = 0,
+};
+
+static const struct imx95_blk_ctl_clk_dev_data dispmix_csr_clk_dev_data[] = {
+	[IMX95_CLK_DISPMIX_ENG0_SEL] = {
+		.name = "disp_engine0_sel",
+		.parent_names = (const char *[]){"videopll1", "dsi_pll", "ldb_pll_div7", },
+		.num_parents = 4,
+		.reg = 0,
+		.bit_idx = 0,
+		.bit_width = 2,
+		.type = CLK_MUX,
+		.flags = CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
+	},
+	[IMX95_CLK_DISPMIX_ENG1_SEL] = {
+		.name = "disp_engine1_sel",
+		.parent_names = (const char *[]){"videopll1", "dsi_pll", "ldb_pll_div7", },
+		.num_parents = 4,
+		.reg = 0,
+		.bit_idx = 2,
+		.bit_width = 2,
+		.type = CLK_MUX,
+		.flags = CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
+	}
+};
+
+static const struct imx95_blk_ctl_dev_data dispmix_csr_dev_data = {
+	.num_clks = IMX95_CLK_DISPMIX_END,
+	.clk_dev_data = dispmix_csr_clk_dev_data,
+	.clk_reg_offset = 0,
+};
+
+static int imx95_bc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct imx95_blk_ctl_dev_data *bc_data;
+	struct imx95_blk_ctl *bc;
+	struct clk_hw_onecell_data *clk_hw_data;
+	struct clk_hw **hws;
+	void __iomem *base;
+	int i, ret;
+
+	bc = devm_kzalloc(dev, sizeof(*bc), GFP_KERNEL);
+	if (!bc)
+		return -ENOMEM;
+	bc->dev = dev;
+	dev_set_drvdata(&pdev->dev, bc);
+
+	spin_lock_init(&bc->lock);
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	bc->base = base;
+	bc->clk_apb = devm_clk_get(dev, NULL);
+	if (IS_ERR(bc->clk_apb))
+		return dev_err_probe(dev, PTR_ERR(bc->clk_apb), "failed to get APB clock\n");
+
+	ret = clk_prepare_enable(bc->clk_apb);
+	if (ret) {
+		dev_err(dev, "failed to enable apb clock: %d\n", ret);
+		return ret;
+	}
+
+	bc_data = of_device_get_match_data(dev);
+	if (!bc_data)
+		return devm_of_platform_populate(dev);
+
+	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws, bc_data->num_clks),
+				   GFP_KERNEL);
+	if (!clk_hw_data)
+		return -ENOMEM;
+
+	if (bc_data->rpm_enabled)
+		pm_runtime_enable(&pdev->dev);
+
+	clk_hw_data->num = bc_data->num_clks;
+	hws = clk_hw_data->hws;
+
+	for (i = 0; i < bc_data->num_clks; i++) {
+		const struct imx95_blk_ctl_clk_dev_data *data = &bc_data->clk_dev_data[i];
+		void __iomem *reg = base + data->reg;
+
+		if (data->type == CLK_MUX) {
+			hws[i] = clk_hw_register_mux(dev, data->name, data->parent_names,
+						     data->num_parents, data->flags, reg,
+						     data->bit_idx, data->bit_width,
+						     data->flags2, &bc->lock);
+		} else if (data->type == CLK_DIVIDER) {
+			hws[i] = clk_hw_register_divider(dev, data->name, data->parent_names[0],
+							 data->flags, reg, data->bit_idx,
+							 data->bit_width, data->flags2, &bc->lock);
+		} else {
+			hws[i] = clk_hw_register_gate(dev, data->name, data->parent_names[0],
+						      data->flags, reg, data->bit_idx,
+						      data->flags2, &bc->lock);
+		}
+		if (IS_ERR(hws[i])) {
+			ret = PTR_ERR(hws[i]);
+			dev_err(dev, "failed to register: %s:%d\n", data->name, ret);
+			goto cleanup;
+		}
+	}
+
+	ret = of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get, clk_hw_data);
+	if (ret)
+		goto cleanup;
+
+	ret = devm_of_platform_populate(dev);
+	if (ret) {
+		of_clk_del_provider(dev->of_node);
+		goto cleanup;
+	}
+
+	if (pm_runtime_enabled(bc->dev))
+		clk_disable_unprepare(bc->clk_apb);
+
+	return 0;
+
+cleanup:
+	for (i = 0; i < bc_data->num_clks; i++) {
+		if (IS_ERR_OR_NULL(hws[i]))
+			continue;
+		clk_hw_unregister(hws[i]);
+	}
+
+	if (bc_data->rpm_enabled)
+		pm_runtime_disable(&pdev->dev);
+
+	return ret;
+}
+
+#ifdef CONFIG_PM
+static int imx95_bc_runtime_suspend(struct device *dev)
+{
+	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(bc->clk_apb);
+	return 0;
+}
+
+static int imx95_bc_runtime_resume(struct device *dev)
+{
+	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
+
+	return clk_prepare_enable(bc->clk_apb);
+}
+#endif
+
+#ifdef CONFIG_PM_SLEEP
+static int imx95_bc_suspend(struct device *dev)
+{
+	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
+	const struct imx95_blk_ctl_dev_data *bc_data;
+	int ret;
+
+	bc_data = of_device_get_match_data(dev);
+	if (!bc_data)
+		return 0;
+
+	if (bc_data->rpm_enabled) {
+		ret = pm_runtime_get_sync(bc->dev);
+		if (ret < 0) {
+			pm_runtime_put_noidle(bc->dev);
+			return ret;
+		}
+	}
+
+	bc->clk_reg_restore = readl(bc->base + bc_data->clk_reg_offset);
+
+	return 0;
+}
+
+static int imx95_bc_resume(struct device *dev)
+{
+	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
+	const struct imx95_blk_ctl_dev_data *bc_data;
+
+	bc_data = of_device_get_match_data(dev);
+	if (!bc_data)
+		return 0;
+
+	writel(bc->clk_reg_restore, bc->base + bc_data->clk_reg_offset);
+
+	if (bc_data->rpm_enabled)
+		pm_runtime_put(bc->dev);
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops imx95_bc_pm_ops = {
+	SET_RUNTIME_PM_OPS(imx95_bc_runtime_suspend, imx95_bc_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(imx95_bc_suspend, imx95_bc_resume)
+};
+
+static const struct of_device_id imx95_bc_of_match[] = {
+	{ .compatible = "nxp,imx95-cameramix-csr", .data = &camblk_dev_data },
+	{ .compatible = "nxp,imx95-display-master-csr", },
+	{ .compatible = "nxp,imx95-dispmix-lvds-csr", .data = &lvds_csr_dev_data },
+	{ .compatible = "nxp,imx95-dispmix-csr", .data = &dispmix_csr_dev_data },
+	{ .compatible = "nxp,imx95-netcmix-blk-ctrl", },
+	{ .compatible = "nxp,imx95-vpumix-csr", .data = &vpublk_dev_data },
+	{ /* Sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, imx95_blk_ctl_match);
+
+static struct platform_driver imx95_bc_driver = {
+	.probe = imx95_bc_probe,
+	.driver = {
+		.name = "imx95-blk-ctl",
+		.of_match_table = of_match_ptr(imx95_bc_of_match),
+		.pm = &imx95_bc_pm_ops,
+	},
+};
+module_platform_driver(imx95_bc_driver);
+
+MODULE_DESCRIPTION("NXP i.MX95 blk ctl driver");
+MODULE_LICENSE("GPL");

-- 
2.37.1


