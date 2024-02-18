Return-Path: <linux-kernel+bounces-70238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B81EE85951F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 07:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EA1F1F22D1A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 06:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E571BDF8;
	Sun, 18 Feb 2024 06:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="iN5KI3Oz"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0171CE574;
	Sun, 18 Feb 2024 06:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708238911; cv=fail; b=OMiiXBdOpJzzIcYCmZafl8X0fP8j/klP1XLN0bgCLEcUkeKCRXm+8QEXDcz4J12wLER0qmL6xpWY4HLaloQOsSoxfEhs34W2Hd2sEsuMnruj/NTJDien+U6//Sgyf8PzL4h0H6hQ+IHCpBB2qIlqPKRYpgvVdk03HeHUf558+GU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708238911; c=relaxed/simple;
	bh=1OUZeDlN1amBP7+PYcW7CUkThMi2ZyzKUKprJgVUa7I=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=nXQ6BgAlByIALfZrASQh872E2fPx1iD0vkluRjH6kZEK6Xuk71qxQ1p7XFN881ffkyUaKKqSQeOnDEpSv7h8z9SqeWHjSHiQnH5M1ZkDREAYTz3TlfV2j5/503YFtyvBnoufJZ6aIHvy1XLRTiy0iGPavaKMlElzvgoW6uBVQTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=iN5KI3Oz; arc=fail smtp.client-ip=40.107.21.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYR96C5HTweasjullWnBP2scxec8xOCv6plsCr2/aTHgwMuoNnpTLnn2K9r8UtvHy5lU+YRi3gOQt8UiqzS9HaMjWALObPfwSEf0ECxrfCfhSfvyR8UOwcFDzexkoHJx+JQ86CAQ/bd4o6yttyEFj18VtyLotXgct9KqO6Mq6zJkDnJj8sBzxQTLTk4IsB3XA50yjgdIZWQC5gMqV+uW91/YL0rB34zFdFMeUIj68PuXTxIXHR0Yr8BLS9MYzQUhBLStRnu/0mqntMN5cFbFBH2JWQCzKi8WTydZRNpM+JsYBCeEU38mObsXF7bbSF4GByHngHSVdFxKQH24E4Q8sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptTIaebQcuxJRRqep4bFx/oKrRjiTx/N+usGnZnKIkQ=;
 b=IrW20uUW7JuAuL9G7JqeuN/lh7wJn0imousvQ+okD1e/XrfhKorFU6s+tDb2JORFu8zt6xJANR/lCyGealFBlQyk/EDUUzOdaXJber5306ofSJxL+1jAmLwn9nMeveTTZc4jgOtSh0d2UP4VK7ZrNQoT7rW8n7gBOxjoZaE385lBcy/HqN3iAWeV2fWXpWumgFT5ZK7gmAOG3MsqLeCK3YB3RhkPGBJnyODsNnQ84UQVa0NyrRlBuVLMLtrIEx0aEE7VPnJOOhfMPnO2+Zjm8OxeEvG9DHRnzzUiH55tg7TJx6/xH/xEcYnrqSYeLC83dc7zwuhLCBl8DSFzIgS9jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptTIaebQcuxJRRqep4bFx/oKrRjiTx/N+usGnZnKIkQ=;
 b=iN5KI3Oz8M+l6ctsa9OcJ1wdmH2/JtiezVbY/Aqj2/3SUiAiTcXZZWZB12Dl32w+kOlp1SoHAg5Ey5ziwdvEWbu+U6I9OMAAjaatOwf1M1T5DWlpN9AbVIHG9dBSw/XYxLO1xsIqyQRF0sjPSR0eDirJE/wr/LHXpHMZt7SBtp8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB8011.eurprd04.prod.outlook.com (2603:10a6:10:1ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Sun, 18 Feb
 2024 06:48:28 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1%4]) with mapi id 15.20.7292.033; Sun, 18 Feb 2024
 06:48:28 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 18 Feb 2024 14:56:18 +0800
Subject: [PATCH v7 6/6] mailbox: imx: support i.MX95 Generic/ELE/V2X MU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240218-imx-mailbox-v7-6-8fb665eeae40@nxp.com>
References: <20240218-imx-mailbox-v7-0-8fb665eeae40@nxp.com>
In-Reply-To: <20240218-imx-mailbox-v7-0-8fb665eeae40@nxp.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708239387; l=1293;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=SPNe0FKcSKFv7bAkLa3HwYU4wd0uFOj0fhQIX1FNVn0=;
 b=Wxy9v56DpfosDiC5gFqmOX9x+gE4Ac0XOkwMkn+ZUPd437dRRPX5mVQbGQxZ5pwJj0ZjOz6a6
 CG/Hvha0jCaBqC4rXJ8UkMobx3OhtdtFANGKBLfiyrShEvyciHtdNIa
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB8011:EE_
X-MS-Office365-Filtering-Correlation-Id: c9b4369c-2ac7-4b61-456a-08dc304d9cfb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	B89KesXKUyYVlqns/+14IfzOs0/kiKREEg0QKIFZIqzYuv7JhxBoeFIjz1vAfjSqGq6dn7wt7wFq2TiEdOysUPYsoBbmghLtI0Qtt4g2erDNsXiWh2U6cVYxbAtK5doTx8uojkqgfN8vcutuhtd2Znk/Hqb1Ltm5XnLfXri5L38HCtpu/w1xsJu4FUXBj1OsDSu3/w4OYAoDBi5Lzgntfeg+GF4VXd++SGSKDMnizq8sMr+Adn6X0J0pZwzGoshGkO1CrrJIGqdLCYQpL89Kb/pDG51zLPr4hDHdYCyrvuHkMCU5c2iVm5tih89mf2hteg9K5k8ze8aT9DE+x0vCVglqIa756lANOssjBujcf4reqEqanQ8P7ZALvh97jCjmtFqt4ckvK0lX3D+qtAWfRW0TvWrs9YCJP3nHIsWwAqatE7YxasWvop/7DY0RyPVauJfA2k1vfJImsbat/3FO3peYzCRfHNsSA8wajsT98awNyCYM2tJvYhKqNQ0F/16lQLxvyTn0XD1yuzkVSt5D+sIkgsCIMzld9TstU94fmpHQlVtsOb9iTMqdnElmlEQhfBccOj6FZ6rEKYKhyJH96S+Rwfp9h1hceBlVZPqIcqgwHHGeWTYIDvjR+7BCXRWVBFjSYoNkzbOcgXslQCme4w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(5660300002)(66946007)(15650500001)(4326008)(2906002)(8936002)(7416002)(8676002)(66476007)(66556008)(86362001)(36756003)(921011)(38350700005)(478600001)(83380400001)(110136005)(9686003)(6666004)(6512007)(41300700001)(316002)(6506007)(26005)(52116002)(6486002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkNIRUF2ajFQcDBkS2cramNoa2FSWVNpNGVLSkxOU0lseGIrYWFqMzk4Mk9l?=
 =?utf-8?B?UGpzNmdhbHl3RWUwRnJ1VVhFSWJhbE1pZW9Cb3Nwa1lPNHR6Q2xkWUk4WDNy?=
 =?utf-8?B?bGJtUlgyRGRFN1NWMTczaWtPUGNrMlRudk56SHdHSDVvR3ZkbTRVUWZDMWtB?=
 =?utf-8?B?OW5pR1ZZQXp4SXk1RWdCc2R5TzNWSkd6S1YvU2svUlJ6dVd1TkZVTitnM3Jl?=
 =?utf-8?B?cm1UZnpBaXVBU1FTaGEwYktXL1F1UWF2ejJRamVjOHNDR0p2a3o3WEVrcjlo?=
 =?utf-8?B?STRLQU1BNHVnTjdubVBDTHB3dHF1SUNHWnVaNlZmYmxqY3Mzd2kzVlRzNGRJ?=
 =?utf-8?B?RHlwYUx5SFNhTnVBUHAxc21pVkZMazRLcDBCTE5vRHV2Mk1rVUpmamlTMWV6?=
 =?utf-8?B?ckZLTGZQUFNIcXlKVmlUd2dGcUtLTTNPdE5DUVI2NHp1UVQ3R2NpbU15VE1M?=
 =?utf-8?B?ZkdnaVNpd1hFVXVwWVFha1M4eDlsMW1kVFY0VCtoTnJpMFRvb3hQYnAzRllm?=
 =?utf-8?B?ZTJXZkxCNkR1dVZjZUdqY2FOZ1lrN2JmV255c2doVnNwV0tvclBCTlc1ZU9q?=
 =?utf-8?B?TytaMlRxL2JvcVZSWkl6M05PeS9ES0JzLzZJb0RZUVZQYkZ1QlNHcy8yTEI0?=
 =?utf-8?B?cjhObjFSOUlFTzg3OEV4LzJITUNmZ1BIeEphZEFacjFoS1hNWUx0ekJXV0tU?=
 =?utf-8?B?Q0RubzhOZjZPS0lIdkZLdWRTZGp3U3FFYmkrTUhDQ2NBL24xMlk3aEVrMVdq?=
 =?utf-8?B?cVJhbjRnZ1dnSDBERy8xYkxSb0tlaURTejNjY1Z4cFRycUV5QVdrMnpSY3Jv?=
 =?utf-8?B?RHJsT0JHQ0duSkoySlVZWm9nbkR4SG83UlRTeTg3R3hXbFBzazIydDN4bDR0?=
 =?utf-8?B?MzJYb1pJS05yZFArdGxZRy85bjFnZHZQUFplM1Nia3Vqanpwd3d1d0llT1hL?=
 =?utf-8?B?S2tVeG1PazJPejRGcTRjMExOaXlhc2s1Z05yanJ6SDdSY0xVMGhJSUF4MzVs?=
 =?utf-8?B?Z0JWNHg3dWlpRkdSdkh4SFNlQ3AvYjJZaVBSUVJicHUrRFdkKzJ1T3phUHZG?=
 =?utf-8?B?RmIrdGNqNmNYRXk2aFJMUDM5TTVOYm5tSkQxejlmKytlcnBuTFgyVmN3cFdL?=
 =?utf-8?B?dElTaXljYmxNUU9aZnBPRm91R2l5bUhla2Z1dXgxUG52b0Jhdkd5SVBYcjJE?=
 =?utf-8?B?WU54eEtqdUNwTE5CNllPWEQwdCtCUlpFSFdxSHVnRFRYUVBoTWFsM2FsOHJm?=
 =?utf-8?B?RkxJTXVkYnhYanRZdlFpLzQ3OGF0ZitxWXJvOXlnSENlWUZlZmFJRnlINks0?=
 =?utf-8?B?M3hxWTFXMkVNY2dDNjZxQmNYNkhCR1d4bWNqbmdvV0JjN3FTVStFWm5GcjU3?=
 =?utf-8?B?RS9EQUJWMlcwMXphelJWaVlBUXFMWDdmM2dwbzhraytIUXgwYVkyREZGWkpS?=
 =?utf-8?B?MXA5QnhoeTRHOCtXM2ZTQlcwbzQydjZwaDgydWV4Mm13Q3cwa3d2bEV3aVlh?=
 =?utf-8?B?R09JN2ZOQVBPSGJYNUFLNjJMTklNQnZhTHNlT0Y4SmQrS25SMGdja2IyS3pN?=
 =?utf-8?B?dFZtZ3dXMFBQVStqRVgwTU81d2JUR2tMS3dkMVRIZFdWVC9tN3FaUENTdTBy?=
 =?utf-8?B?eFZEV09rWDFVcGViOGwrWmxIK3pkNVN2aWkzZUNYU1JNQU1BZ3lDWEVqd1lQ?=
 =?utf-8?B?UFhvR0FGbFpjNExKa3JEQzFYM0xPcE5JT0lFN1g3a1dsZE52ZmVXWFpkZkda?=
 =?utf-8?B?YWJxRnhGQ0dUSFZmNXFlcFRXOEQ1WEhUbzdPNlN5WE5SMXd2UEJFckY2RUxE?=
 =?utf-8?B?VGkzSFhuaVdEMWk0UHFnZHMxLzFnNkRlN2hSQksyWEYyNFVTWVA1dUo0OG5B?=
 =?utf-8?B?cnJLNUZxcWlFNFA2aUxSazdoTmRRbW1ZazIwU05mVTBONXFwby9PcE1aU1py?=
 =?utf-8?B?WDlZS0tuTkZ2ZFVyRnZzaWZxMnc1V1hNTldQaXk1bnNIQUptZ0o0YittcWw0?=
 =?utf-8?B?cjdSWWtSbWhWMDVJWk85SXd3WFltY2p1ZUhQUWx6NVkwS2JleUlJblRXNDkz?=
 =?utf-8?B?dzNmUkFzTlhtNzkraWdmLzA2TFBJNEtXa21nNEZrTlNOSk5Sb29saURmajho?=
 =?utf-8?Q?mzIA6JrlQnzQ5qTh27zGzxkAC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b4369c-2ac7-4b61-456a-08dc304d9cfb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 06:48:28.4768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hmXnWDxtOICrAH5dF/KH/rZFnByeEvO2MbhuaiWL5f/HRg9y73vvobla9GMIWzfBwgGtRY9tiYKxToqIA7Y52Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8011

From: Peng Fan <peng.fan@nxp.com>

Add i.MX95 Generic/ELE/V2X MU support, its register layout is same as
i.MX8ULP, but the Parameter registers would show different
TR/RR. Since the driver already supports get TR/RR from Parameter
registers, not hardcoding the number, this patch just add
the compatible entry to reuse i.MX8ULP S4 cfg data.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index b36267591db2..5c1d09cad761 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -1035,6 +1035,9 @@ static const struct of_device_id imx_mu_dt_ids[] = {
 	{ .compatible = "fsl,imx8ulp-mu", .data = &imx_mu_cfg_imx8ulp },
 	{ .compatible = "fsl,imx8ulp-mu-s4", .data = &imx_mu_cfg_imx8ulp_s4 },
 	{ .compatible = "fsl,imx93-mu-s4", .data = &imx_mu_cfg_imx93_s4 },
+	{ .compatible = "fsl,imx95-mu", .data = &imx_mu_cfg_imx8ulp },
+	{ .compatible = "fsl,imx95-mu-ele", .data = &imx_mu_cfg_imx8ulp_s4 },
+	{ .compatible = "fsl,imx95-mu-v2x", .data = &imx_mu_cfg_imx8ulp_s4 },
 	{ .compatible = "fsl,imx8-mu-scu", .data = &imx_mu_cfg_imx8_scu },
 	{ .compatible = "fsl,imx8-mu-seco", .data = &imx_mu_cfg_imx8_seco },
 	{ },

-- 
2.37.1


