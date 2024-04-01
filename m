Return-Path: <linux-kernel+bounces-126697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40237893BB7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4804282062
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4846B3FE5F;
	Mon,  1 Apr 2024 14:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kPNDFZZv"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2125.outbound.protection.outlook.com [40.107.20.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9E38BF0;
	Mon,  1 Apr 2024 14:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711980153; cv=fail; b=BQhiP5YUdiZbbpQH3Rh7nj0UmFuzz3a9G7AU6Hb3SwzVk0w2mHSr/9I7btYpLPtzMXva/kjOnMD4tf/LsimqdM4I/GoMGbuHLHjEBsrX7+FcZBCugyv9ANbjIL0/klyn+Fw0nlbvYJ0HCf81H7s2HFTJ7we85TURPmexuS7mSyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711980153; c=relaxed/simple;
	bh=V65muiz31vxeltMhbOpsl2/G1yuOhczryK+uYrQpxC0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nIKrRpX3xEvwJfnBieSAHVUiUDC6DFzD6FyItf/ABhaMK2XKbiv6ZbE8Ncv/iR1L8JcIlJlhD6wt0sKhpG6LhA6ND88qJs/YSenhZCBh/rrT29koX19Ux4pk6saqVEXLgjhrN6LlFGGwoqqQEnK7X8FK+ha5exMMu//nO2Q19ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kPNDFZZv; arc=fail smtp.client-ip=40.107.20.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1MQxEzob7xMHGS4w5s9UhKEAHClgPleHUDXFzNgvoe3HAKMALj4kU+0djjZCXnOYLDncDAZ9fPuhMz+eEPk/ZnBdh42GaqjwaAw3UoCA5m4/DGQWhx3ewj5k7g4DzolfQ8SEP3xBLE2EBt3Rx4Nb5ESvbXsYFf6X0mSSf6hcx8wQFli+v2HkcU4Gy5E27l4W/FWPSNqz16DCnq+EN9o+S6supckZLVizMvr6iGZfk4NvoDg4PiEi3RYF08VUVPWb4ydBtzfAAR3guFVxU6KR6NvLZKTXkfZQRgWi7x00gZH79Vq+kJveisLKRfso0+CB/vwFWc/TIk3Qx/J8ycQgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKi3yxM1vCpbNHyQmHoSi6bQ7ms55MmemK17wCp4B4M=;
 b=Lrk/ppx4pQc6Pave0fTpLOkR4rYY1DBL0DJeY7NgQhYTJzQQ2G5RlxZ/qknTl8V34UAKDhSmPH3Glh44Lesx+2lMdb2xQDNoZ8BgM2JCK8906Ml5diU4n+P708/+GienFJ/IaCrac/1ZIzI3gy/x3TqCMOxgRThi79LJB4m8DQbPMdLLiJ9qqLRuzoCjUizhi9GPAKm9ZRGLPLO9nR5wFfNvDKSG3oEjzKOEltUTHfHcdzaQdrn11/QMI4QIkuB8aCtUU2e3AnU9HQ8l8d50xYELT4SRxAIkYzTvq/iwBhJNoYWqcJarmvihbxugstlUJ6RsAPtcC6DXs+As1gqoCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKi3yxM1vCpbNHyQmHoSi6bQ7ms55MmemK17wCp4B4M=;
 b=kPNDFZZvvJCleLSR+5jE/2UkJnSjsXyxoYGFpbEBEHbO07DnJG77y1nyojEYeXwfrt+oHyyFUmo9syZiO2aC4mN45XyWFPnvDTmrOfyS1JdLN2E0H4MZv5aeDoF0hBX1ANO2nH8xjvpz3gP5YXcXq4DXoACWjCBIxs36hJBhtR8=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6956.eurprd04.prod.outlook.com (2603:10a6:10:11b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 14:02:27 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Mon, 1 Apr 2024
 14:02:27 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: linus.walleij@linaro.org,
	brgl@bgdev.pl,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: cristian.marussi@arm.com,
	sudeep.holla@arm.com,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] pinctrl: pinconf-generic: check error value EOPNOTSUPP
Date: Mon,  1 Apr 2024 22:10:31 +0800
Message-Id: <20240401141031.3106216-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB8PR04MB6956:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6JQTpco7ltBd2l4BfEW7VI7yDCrriV/Tm5c6Csz0HZYIteu6H/bk5taV6CZ7mLuAiQmDFtTW0ov3Vp5QLiFYqW2yrKHBD0d79yD5u0tFNk8Z+gJy0y/Gz4Myc6HK6RVH9M1mYXt/vyZYJNv161aCCKJAoHRTWPPvOTAc//V/JT48s3iqwIj82bH079LTKX89m4w/Qsw2ZwgYIJlzD6Uk1+92uTq7plgXOKs29RmuIlKsv+s76ktc2gOlBqyoNdmCLELmPG391nb6OgaXo7qGh8YeeGWTwHAjWVmiB15uJ0WNtr3EmnT+ubKbvOeQ7/KACPWJ+LrukMT4zSlQ+wkIcUExIp5my2/XkkWU3i4Dhm+mSRdGuaayXMCBS5hhABPOeCZ/5Q/eObZhkkZkUfI0dOpqqDiPDF9htVFbd4IQ6k2TfPEb5KyKCLx6fPjMuO+zb1Yhpe5YBxcPYJbbHc5XdQjBzXaAzW7xAib3vlnmKWSnSho9ohvQF2SCoOyYEjqapCDnLrLro6qpkUUvg2aM/mUSfoFydHJNAd4gI3zIpnJymTUfMgZLMukHj/ULRQle9g1opQlHqKgxgVFWCSoyqbM5aI+sGI4hbW5KUKqexpHKXn1uOWpU1v/qZ+t0/EEgq/iMGMhvGu3aBHucHlwmvCfD2bQZFaQn2a7zIDnRcABW/9IF4IxjwWwf7HXh3IpK4+Wjw3ws/YcBe4QqapqZ/Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ClbEW2MlMdaKuMRUdVCbSdZMUGP1HTd/tVgg7K85XFaymAO8RXA+JSbShCUZ?=
 =?us-ascii?Q?J875E0d4qoJe+ZYcPXQshFtQpVLpS47ZJ1sX+G7s70pjuVoY6+bGd5hgJSaZ?=
 =?us-ascii?Q?kHcPaaYC8CiNBfBJnjz7Wyso/ssw9CvyIZ83U5uvmhkoSm1tcuBMHCE8E3Z1?=
 =?us-ascii?Q?DxsapSp7SQex+SZr85nUyImabZxcg+5f0G76FELOudc+e/p0Pc3prGH5e8Ha?=
 =?us-ascii?Q?gTSl/qhlkxUDqkZlTBCu1JREip5sErhXGtB5XzfbFPNX/WsLSXDTDNbt7nx0?=
 =?us-ascii?Q?y706Jju0IF1Mi+mpVnVUjP30Kvvqu9wSkhyjuK+YpFk6ewOdPvbwFwAAesda?=
 =?us-ascii?Q?r/N3nVNu4B6CYTgaM+ZhA5YLG+/vBJgZhg4sRzBlzOuDpGSEoRrcmf3HdzeR?=
 =?us-ascii?Q?vvp17n1fTQQuLsz4+03LCDg8JRhbn0rMJqunCsM7U7s5gdC3QDBLVLETbK9M?=
 =?us-ascii?Q?mpdf7Oh3CrAcu11ZYvM1IWwx2+KLOIUpzdz46VMU84Ga0SOH7YD94WtDkCAc?=
 =?us-ascii?Q?vtpjG3EgUdW1zoeFc/kRxcZVAcEvm5NGvSWqC9P1p8hyDjJHenR1m0nBrpzl?=
 =?us-ascii?Q?PNYIizRPuprIK8pSkhl+Lwgny1eNqYtcjYZwnhae7PnIUquxP9Qgxo3xXkaK?=
 =?us-ascii?Q?PXWFClImH5cN80xFIbyRovrVgcodBEB60Q3VGZGMyXKJgzlrLojGKgrkDrNz?=
 =?us-ascii?Q?8EVlNH/euKE5mygnv1jniWrBFnraP4Jk/2LYUAb8tS1z3dUhWTnBbyicGrYE?=
 =?us-ascii?Q?MrVxiVteS36g8Go8ZSCgj28cVVaI/hLKMiEl2x7bBjak3392k3ess6zd1JpO?=
 =?us-ascii?Q?+PSIxu9n37IBjuNuKiaGzjWeObtikk5z3hOPGJJUXv3Nj8c5byUXAvxyCrrz?=
 =?us-ascii?Q?XLP4Hh2LnL40PBwPH2yV/wVyqGe9ZUpLbRnCzg/6j50SzmdE/0rQlfPmxGA+?=
 =?us-ascii?Q?a0mjpP1CojcfePZfUtgegKVuHTQAQVLKWC0z8v14ONJHpLt4T83B2rqKNjRu?=
 =?us-ascii?Q?8AITxmrGXkVVujMNleoeRQJoBSu95tvlpx7FEIDU2IRH03eKegbh+iMkZ5FK?=
 =?us-ascii?Q?aVJ5ohuatPHOXZy4okNRPZob9AUn/eoJcpAPnyf3xJ20C8DlYA6wNo3OYx13?=
 =?us-ascii?Q?DJsunkR/n/0eRvocGF0zavscijnMbFCB0eLevc+OCts35T8umS3FJ7kLksNR?=
 =?us-ascii?Q?DH6ytQXEabstmvPUGlRKF0oWe9ygQiHqSuuMBrDyC2j73AMcq+lwV+abCDBi?=
 =?us-ascii?Q?BTDATOfvftc2WNRpyDxBMIOtVblXdYnT9S9UMwwkURpc73169BimD3yVsxdl?=
 =?us-ascii?Q?rGoqtH7sEZR238vFaY/ds3BvefQWuR22GZgMajKVaJzVcItVrxm7Vga8LFBy?=
 =?us-ascii?Q?Pcxh9ugyQXb1TdU9TUpRzQ6DWfXlDiGU9FjLC95lVvsCVzIaeSVsiqdgv4iS?=
 =?us-ascii?Q?jsS20ymdqqRvbcm1cEgXjxtz84mq+b1PocaDa3ZtLxxFu30vK7vFaGW2HKj8?=
 =?us-ascii?Q?mCU3ueOcRpxtsCWuta9O4xLPbBGlPTqRt5CfHU/AXqZ6zG4wnIo8f7gpD7wL?=
 =?us-ascii?Q?F+vH9vTbk09ey96igvpNkVhpD9DwqREqcfuZbc8P?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e4e63e-7a0a-4a57-3f89-08dc52545cda
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 14:02:27.3799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aMWU+Q8fo+rgFQPmVzsVneIl3OgnVtIXlFGKIRBHVc7tXxwYjy3nWyqEPCrL3DyITNpgOuItuS1A55d5IQQi8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6956

From: Peng Fan <peng.fan@nxp.com>

The SCMI error value SCMI_ERR_SUPPORT maps to linux error value
'-EOPNOTSUPP', so when dump configs, need check the error value
EOPNOTSUPP, otherwise there will be log "ERROR READING CONFIG SETTING".

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/pinconf-generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinconf-generic.c b/drivers/pinctrl/pinconf-generic.c
index cada5d18ffae..541c2ac9ffcb 100644
--- a/drivers/pinctrl/pinconf-generic.c
+++ b/drivers/pinctrl/pinconf-generic.c
@@ -75,7 +75,7 @@ static void pinconf_generic_dump_one(struct pinctrl_dev *pctldev,
 		else
 			ret = pin_config_get_for_pin(pctldev, pin, &config);
 		/* These are legal errors */
-		if (ret == -EINVAL || ret == -ENOTSUPP)
+		if (ret == -EINVAL || ret == -ENOTSUPP || ret == -EOPNOTSUPP)
 			continue;
 		if (ret) {
 			seq_printf(s, "ERROR READING CONFIG SETTING %d ", i);
-- 
2.37.1


