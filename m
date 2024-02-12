Return-Path: <linux-kernel+bounces-61577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 353968513D5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B50B71F22B21
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DD239FFF;
	Mon, 12 Feb 2024 12:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Z5b7pui+"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2052.outbound.protection.outlook.com [40.107.14.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729E53A1A0;
	Mon, 12 Feb 2024 12:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707742408; cv=fail; b=dqFC3wI1J6XwvxSYo3BStXrpL9ehqg/lpI2h6op3qYg5jx9c8TBw30jwa+MXYW850PUANRn6txwYIbLi1OxMovv7fe8pgpvxXyy9MlFRKStkA8vZzhf29h4FwFUxE9QMtOMju7424hNYROTKKDDFLTUKrweSGrq/psKs5tMMGHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707742408; c=relaxed/simple;
	bh=OA228PwybCWqf17/nKHTciZs8XFcQA9BhU6eKpO8xNg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LzWLLIIXkv1Mmn6z+i1XXN/vhiWdHErd18j1BjQSoRGUN+8C2wYyOHgkfJfkxD6RM8ncuq7DI4deX+w5ftJ0ryWVU01qiZ1PaQjEAjP4FANi2X2thGjUCQ7dSZxzBn6RLGmbnpj+MHDvotWAeWbGwimUl960CcPzsOmpL08hdbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Z5b7pui+; arc=fail smtp.client-ip=40.107.14.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f35p7H+izHROTRTrsl10SykGgqn8k81uSIaGFR5rFUmElngsQRVXn10mebw/aVm0psZIB/bPaKoCWKRfyRR/WeKZdgwUDcCHZQtVYgYhOK14rV2QB5cVLZKu+/KBfNmtrXcaqCKkasroFTbqoOiAv2/DxGODNrz+iHUBVplDTbbTUcGdp4YTlZtqc2dnLqPrgWZFvaL0Grw8SByhhhTRzjq1YV/Fv6JPvPoyzjY5fXCnrkPhQ3JntbSFxqsLtg0DnCQ8zLIYOAfYNRKJBK2L26w6qphfC/CiCJZtMewlBNyCRjK8dDwOVynHtoMyeiTdPXHgqyzOGieAoBMhfPEiHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8zvUdNzyJ30vdjANex5tGcSL148BsULUbx4+iLZINg=;
 b=iUPyBYqhglnJ4O94ig4eBjIkdgtOsWIbMVBHOGDxPJoePxHHbZoqhctOLw/zUKSdQsil45pheaTH7Ga2woQUF6fs2Ir8DCyT5Htz45AH3BCOrcAWmFzdYNVSmPl1MqLBaSVT0kYRO8rBq8tjGEG0jtvikfPf35rR5qsLn/lggh1ltXpwbaYvyC0ffO1VDpNOFnJtifCu7JK0er//FjRUrZFxI5Jd3iaZHS8PRgVga6It9HudXipVGjTQWshNcSUZHwvDeZmhaMufOAZ88UlXnwaj+l22rY60AXOQI6Um/0FmgsIbINtLUHEP85QjcxRvizUaUIUi6XbVyZ/f4NWz1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8zvUdNzyJ30vdjANex5tGcSL148BsULUbx4+iLZINg=;
 b=Z5b7pui+lFDIZ9qJ4a1nnVG8DkyDZi4vSwSrskrvKuiflhkaZHJfU4ABLfl2HwMS3L37ycuhVnfxuDcgB6qDWfBvv0XzNNk5ocff+2x8yMBnDhFSxWcjxQTGdOMm7TTKpN17KbS4qhJyd6r7lx6KS/+yu0Dh4UOd2zP1FZqlH2U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::13)
 by PA4PR04MB9365.eurprd04.prod.outlook.com (2603:10a6:102:2a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.38; Mon, 12 Feb
 2024 12:53:23 +0000
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::1a09:3c2:866a:8b2b]) by AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::1a09:3c2:866a:8b2b%5]) with mapi id 15.20.7270.033; Mon, 12 Feb 2024
 12:53:22 +0000
From: "Daniel Baluta (OSS)" <daniel.baluta@oss.nxp.com>
To: broonie@kernel.org,
	linux-sound@vger.kernel.org
Cc: lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-imx@nxp.com,
	kai.vehmanen@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>,
	Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: [PATCH] ASoC: SOF: imx: Add devicetree support to select topologies
Date: Mon, 12 Feb 2024 14:52:58 +0200
Message-Id: <20240212125258.420265-1-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0042.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::19) To AS8PR04MB8247.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8247:EE_|PA4PR04MB9365:EE_
X-MS-Office365-Filtering-Correlation-Id: 3847e60f-33be-4c8a-cf44-08dc2bc9986a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kR0jsG4EmOD/Avx33LTNRl2Z/3+s/uZNs4EfJOlhxqbDPDWGFwJAU80E7T+TSN1WpwT8jARNDeGjZnz7FEvxjkv40vt4sjoONgr08mdDkfU0Fi3Uuj4wHAJRRKgOTGiK3kP9nYCn6iiP54ysu0dJZf4nNogBDXKhJrLpJ1uvWXdr57H5TTzGI1ksz0N/dIVrFHF10fTA5v6x1GWeindt0W6pHFevlYr1Ayhix8wkR4zHneaekHdZ/h6mFRmJYY/HfbgHD3xAcamJfBekgFE5Cj25QaJtWzVBmPDvKDEDftX8bMY+VGNJNBP0qEhI89Dsuu8mvEpa7cf5pncywKfliwqhbizB2MlfUZDYkeETfEZmKGiqFUQraNgfdEEptjj7FN94CZQqHV2Y7ZN1YO2Gwwthfepwcpnf+ymVvHOWxUzr69mt6i0QiVaaMnPUHB4lF27qJYkdyq7JBOzlxj/v/HDoznBp0sXE6CEs4Fs63doIXjOohO4Sw+bEj+y1QTPQC1P5CathOW8HBifWq8oCJj3ADL1+DQdYb4NKiWOfxQHspr2yUkAkyjebAXkEXG1wRjfBnlEJv+0zh2v93qTaqSb21j3HHkyvVU4WcqH0EdnOlKJs6yYIJb3icmyZutCD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8247.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(39860400002)(376002)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(38350700005)(8676002)(4326008)(8936002)(66946007)(316002)(66476007)(66556008)(54906003)(5660300002)(2906002)(6666004)(38100700002)(6512007)(2616005)(52116002)(6506007)(1076003)(26005)(86362001)(478600001)(6486002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aNjgqTqZv5xbdeh1bJ+8IyPMp1nMtMsGMJLFnNiSToxm8HoONJtK3oTMZD3c?=
 =?us-ascii?Q?miny8mGgIQP+e3Ookwzu/2OGIigtXqa6hG0MqWx8K/Hl2dNkEqr29hfJ15JZ?=
 =?us-ascii?Q?7CqeRgF5HpmIIA+YUbCsY6mH50i3mwAv8/b1KKdqwQgcvSKxWi0u5hN18jvD?=
 =?us-ascii?Q?G4xH1OhWcwORQIpMuhQQ632uF93Sb+LME+EviR4iS8I/+e8pfOkYpesAp5F1?=
 =?us-ascii?Q?mhJPBB49I48Mz9pLX9J7nVv9+10AcCAl/FSCYBLGy9In0LRPv8mMFj3CsnkT?=
 =?us-ascii?Q?bdM5YdHAmnzeXwYFcXjIIATtH4bn0scqT5L0cx8HUrHaJFaAJLLaWwUMoq9D?=
 =?us-ascii?Q?t6PptMhL0URW+IWTd8f+efthFShnp1ixyr44/PL/svb+0v/8AjoupmvlnQbI?=
 =?us-ascii?Q?ZU67u3Zai0iajaEQw7hw4EvpBBtMlW5+5US0XgYf6DKggeJHAmuv3H+kkBe5?=
 =?us-ascii?Q?/ofWPyen5wtaS2uKWIIX86+38o41BBQeRmGqYLSz7mdFqN4r9eR6eB3/3uq6?=
 =?us-ascii?Q?shANq5+Qq+xl+5V71Eine/yzuKieyZTvoBZ3JOGPYSsvqLa0cnWF9EkK6hBc?=
 =?us-ascii?Q?FTAgo+Ey3oHg+WaNWDHx1OsB1AT3DiYYf4uc7/XPt9gJE3M0YXNjii5T+Fkm?=
 =?us-ascii?Q?AYpo+z5zdZ/46xBHoZlZoPGw3OstUGke9tLok7wTKxG2Y760H5fuBWSxnp7O?=
 =?us-ascii?Q?LQbWagc46ZabJxAAo3FKYKi6hN47ebcuFNuNbtaG51awj+PQ94GcqRI3Ssh4?=
 =?us-ascii?Q?X+g17wOfmKQUO2jcbdq1dNxbBr1RkbO13jotX6pMnogV5uc9SK5P/xR5mhB4?=
 =?us-ascii?Q?HmaqAgGUtmQl3G/TL6EYyAfwnI0XUnlDabSuvy1TGDKBQbzKDb6+LY0VULQ3?=
 =?us-ascii?Q?+u2Y2KNNV5GdhCl6p4drC2KreB1v6w8ta1ZRJRUZB+ysMQGnW3au0DWIWLU/?=
 =?us-ascii?Q?ARNJoNO3OKEy+PTzsUJKVx2UVXYvmeW4OM2+uVoglN8q8lU9r28KdVEaE5R0?=
 =?us-ascii?Q?3U9rg4aPPDXHghrobrpgzSv8Cup8+Sb5eXyTKfnRCjq1+y95IttY9DuzulCZ?=
 =?us-ascii?Q?CwSwI/RLxwlhqXqg6/IxfeYBBBpJP6815zPaapozhAt9UC08krXNXpLyZIgA?=
 =?us-ascii?Q?+8cVPXnUrNQZJFqZa3aPsnxkG0E2Lm2m4oeRVct+08G58u53oVYQBEzCfKIt?=
 =?us-ascii?Q?I3oM9/jazmL5ICvLFOjQ15gwt9EcU3IRtHrih9QFFnuRADijVpL+bSQeVFgp?=
 =?us-ascii?Q?30TEk4GZtjh7QnAtFZkm+n2Au/bDfCPLqaqUMP5j6rC2ftWWWwLJV8RATK5v?=
 =?us-ascii?Q?RcxBdYf49xvGT1DAmU0gA3NgTYgn4C1s4yrhdE1cR487kyJwbFRVGb4duLZc?=
 =?us-ascii?Q?nomHsZljORL/1kmvUcJvOt0aWq2SMaHUEqLGkm2I6XjRJM2kgWeb5NGbnGax?=
 =?us-ascii?Q?sztF9ZRGLwhxQaXAl2p68hdGVZc1ZITzSRW5NGuz3VLRSx0muZvFcox5XHH9?=
 =?us-ascii?Q?Iv8jEgXBAdKkPSpMXtAT3AoPaBdML2iYDOan6x8pbcE/VTA0/HEN4Z3cAA7u?=
 =?us-ascii?Q?nG3t9ndTdQSU9kk4FsDrosFZuFkrTx398GTXTmR9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3847e60f-33be-4c8a-cf44-08dc2bc9986a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8247.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 12:53:22.8921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1hLG7g3J3BkJtxPbDVdapf6MWxIPhplZiRssi38Su5ptMSIs0IqFYqvGHhoy9zLSDRFyMlEZhmNIdM4lJuCTCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9365

From: Daniel Baluta <daniel.baluta@nxp.com>

We describe tplg_file_name and drv_name using snd_sof_of_mach
array and select correct machine description based on dts compatible
string.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Reviewed-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/imx/imx8.c    | 16 ++++++++++++++++
 sound/soc/sof/imx/imx8m.c   | 10 ++++++++++
 sound/soc/sof/imx/imx8ulp.c | 10 ++++++++++
 3 files changed, 36 insertions(+)

diff --git a/sound/soc/sof/imx/imx8.c b/sound/soc/sof/imx/imx8.c
index d777e70250efc..07f51489d6c9d 100644
--- a/sound/soc/sof/imx/imx8.c
+++ b/sound/soc/sof/imx/imx8.c
@@ -607,7 +607,22 @@ static struct snd_sof_dsp_ops sof_imx8x_ops = {
 			SNDRV_PCM_INFO_NO_PERIOD_WAKEUP
 };
 
+static struct snd_sof_of_mach sof_imx8_machs[] = {
+	{
+		.compatible = "fsl,imx8qxp-mek",
+		.sof_tplg_filename = "sof-imx8-wm8960.tplg",
+		.drv_name = "asoc-audio-graph-card2",
+	},
+	{
+		.compatible = "fsl,imx8qm-mek",
+		.sof_tplg_filename = "sof-imx8-wm8960.tplg",
+		.drv_name = "asoc-audio-graph-card2",
+	},
+	{}
+};
+
 static struct sof_dev_desc sof_of_imx8qxp_desc = {
+	.of_machines	= sof_imx8_machs,
 	.ipc_supported_mask	= BIT(SOF_IPC_TYPE_3),
 	.ipc_default		= SOF_IPC_TYPE_3,
 	.default_fw_path = {
@@ -624,6 +639,7 @@ static struct sof_dev_desc sof_of_imx8qxp_desc = {
 };
 
 static struct sof_dev_desc sof_of_imx8qm_desc = {
+	.of_machines	= sof_imx8_machs,
 	.ipc_supported_mask	= BIT(SOF_IPC_TYPE_3),
 	.ipc_default		= SOF_IPC_TYPE_3,
 	.default_fw_path = {
diff --git a/sound/soc/sof/imx/imx8m.c b/sound/soc/sof/imx/imx8m.c
index 1b976fa500aa2..222cd1467da67 100644
--- a/sound/soc/sof/imx/imx8m.c
+++ b/sound/soc/sof/imx/imx8m.c
@@ -476,7 +476,17 @@ static struct snd_sof_dsp_ops sof_imx8m_ops = {
 		SNDRV_PCM_INFO_NO_PERIOD_WAKEUP,
 };
 
+static struct snd_sof_of_mach sof_imx8mp_machs[] = {
+	{
+		.compatible = "fsl,imx8mp-evk",
+		.sof_tplg_filename = "sof-imx8mp-wm8960.tplg",
+		.drv_name = "asoc-audio-graph-card2",
+	},
+	{}
+};
+
 static struct sof_dev_desc sof_of_imx8mp_desc = {
+	.of_machines	= sof_imx8mp_machs,
 	.ipc_supported_mask	= BIT(SOF_IPC_TYPE_3),
 	.ipc_default		= SOF_IPC_TYPE_3,
 	.default_fw_path = {
diff --git a/sound/soc/sof/imx/imx8ulp.c b/sound/soc/sof/imx/imx8ulp.c
index 2badca75782b2..7b527ffde488f 100644
--- a/sound/soc/sof/imx/imx8ulp.c
+++ b/sound/soc/sof/imx/imx8ulp.c
@@ -476,7 +476,17 @@ static struct snd_sof_dsp_ops sof_imx8ulp_ops = {
 	.set_power_state	= imx8ulp_dsp_set_power_state,
 };
 
+static struct snd_sof_of_mach sof_imx8ulp_machs[] = {
+	{
+		.compatible = "fsl,imx8ulp-evk",
+		.sof_tplg_filename = "sof-imx8ulp-btsco.tplg",
+		.drv_name = "asoc-audio-graph-card2",
+	},
+	{}
+};
+
 static struct sof_dev_desc sof_of_imx8ulp_desc = {
+	.of_machines = sof_imx8ulp_machs,
 	.ipc_supported_mask     = BIT(SOF_IPC_TYPE_3),
 	.ipc_default            = SOF_IPC_TYPE_3,
 	.default_fw_path = {
-- 
2.25.1


