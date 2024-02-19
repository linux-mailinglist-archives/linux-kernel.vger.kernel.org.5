Return-Path: <linux-kernel+bounces-70725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10016859B92
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 348831C2150A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 05:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13501CF95;
	Mon, 19 Feb 2024 05:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WCBoOTLQ"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2057.outbound.protection.outlook.com [40.107.13.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF62208BB;
	Mon, 19 Feb 2024 05:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708319674; cv=fail; b=lq6BfHbfYUYTxee7/AJVVeM+yvw8FLveeXrU+KTZpWg7xy5b0KF0wkiddshNjVU65Xt0vxwKr8R2d7+utnosjSgp8t1yDAI+oaSvgGjePeHHqZtkhAJluuk1BMASSFew5iMMHHWdciGU2NPg98A+EjQv++VctHkVtfebKPjuPsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708319674; c=relaxed/simple;
	bh=2zJxqBVqaNuhlGWo42e1QHXlvX1q4/WgIXGzbYmGZIA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=G8/26v7QbqYynRF06gK9c5yrmB1BmYJro7kdk0vHXAuPTnfOL2V1otNSc/JDYvVSuRtkeClvHNFuSUL9L9QX3tpm+YfzfnxXo59dr2qpd6XFOdPTpnm7jovjQhK2Zw2CFMwOhhuuJ5EZrNu4KblUW81nQYiI+lvF43iVI6HxI9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=WCBoOTLQ; arc=fail smtp.client-ip=40.107.13.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRptMHnBGFQzVmKVLojirra/lRKQOmeE8sY8FBTXfilZAhPRG+E0hXv+RvGNij0Tm6w4ci2gcLbCCiwbgy0QNYEt31Qb4cG8fWKRvOvvWSi6jzK0rom1n27pS0KmMqakYoBCMdpD6pQKGipMKsorrzsLMec27M4Lm2Bm9YsBwqVSGqZ9z7mj1wCEzvD+moM7uahFbZU4Ro3NtPUzyWpNaMspKmjlGFskTBKLyRT/QD5TAPrDQ4b3YWDfVqtjGuORQDBP7/bxXkqpZ+h86cCHV0U1XXp5xBEkm7uUQlkPRCX3HYaB0WkVA41hysx3HJqkqnrVsqSZrFiq9F7J/7rjiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yroYNvtM+ftxkBYnpAH09lTiB04eMcTiVCGoXVH7uV4=;
 b=bFfjTTwERtnWNkZAOI2lZkDhBwzLWp1G3dJNy+4kVff6fxxUJMUa7vSXsX5/MiwmWSc0l1NLuLN7Dub0lDOqBkUy9F38iscLtcdZBh0WajPHErep6vXcjjNAzpRKftGhCm2Gk/hHMuLNgVffeREzemnjB0ja7KfBiFXAoCdMB0Hz6Hqv0huQZJcWHU9iQ5BgqWuW5YIM/vpXcIKgLEi7U/CdKv8wimHnNoMwQwKMDmppSUFJTOCzHTPq6OOfaB6SSBJTSsp4HdVJwq3nzvCGyBhKjvEQoM1EAO/RrcxG+29PFlBNHfuiaHaWlsgpl+mzqT6WLi36ybvhuQnMm2socg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yroYNvtM+ftxkBYnpAH09lTiB04eMcTiVCGoXVH7uV4=;
 b=WCBoOTLQAQ4dFeh0ji8jV84CAMvUCGg/2COMLDq5cei0DmRT+7sKNU94fb6xo/7Itxk46Br/jO716apW8E9hmLA/tkDtciyntUOaiEmdsqmFENM+T2oxyg/jOCWYNwX/w4/cHhTSYIDiogeAu5f9RJViVuuYDsAyMyHUsPbL/Eo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7228.eurprd04.prod.outlook.com (2603:10a6:102:8c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Mon, 19 Feb
 2024 05:14:29 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1%4]) with mapi id 15.20.7292.033; Mon, 19 Feb 2024
 05:14:29 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 19 Feb 2024 13:22:37 +0800
Subject: [PATCH v8 2/5] mailbox: imx: support return value of init
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-imx-mailbox-v8-2-75535a87794e@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708320164; l=3395;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=S0DKuiQSDcYtu53JqBC1+gV1zoHcWj4DjQyGEWhlcnk=;
 b=gr9A+GsNSjrArUHd/OF2V4iBesmVbMSKZw/32AIG4X456SV897HBeUiNhlttdCk6pFtRsEIu3
 rG1RibGeuoFASKvJ3A0cKy5s3PLRUE/1pFv655leQwdC6hL7VGfH75z
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
X-MS-Office365-Filtering-Correlation-Id: 9c012eb2-d482-4001-88d0-08dc3109a633
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gTukSGVndwJJ19RqUtsm8LKHPaXmbh6m6L8M5hrQkQHmN3wKL8wnoj6a9cpWldSa+3bkbb2StOQgW14uRNQvnkhbn4vq6+swzB5zSanW2fBTNfzLvc53vezRVkV/NL2GiId9HVvEMt2C0EzkUfBnjJ4lyXhNfnNyRHAOLLOatx+jx1hIz6+NAOFrvECfvOttzqX9gWRztOcrR1UlNB3z4vP1a0zJwiBZvkj5GeOr6A5NLQ6QXoKWf9eXnhjNGxZB8giywrCm15s/VxC4jyjUU0UOVao8ZJEc+SAHNg/2e9lr/CITlWXuX9MguHWOOylZWcnrW4yIPeaqdyOzoSuNv8fJWGK4h+aqTIcPrjZzTCFEZBY5nMuwgcAR18kncsTbCmK1Bq0k85WIqtvKKEOBezzRQX4kNze/OLmS2WUFH6Oe/AbF6CNdatfp9+4omFTSmN1ua274st5qZehJBCewnSQ7+A68Ltpt2FPDVaO71vjvOLjbgIkJW+xM7v+oUJFgalYTJ1683mIWQcBB1gAr0ILI3GRVUnAlDazj9D9kU8ijaTT9hC5BgwcqCLSmHJTlhZmn2JLYIox+lzt5/5ef+sjrPNN34XDiPFCD3Ua1R4LBTe5F9fpH9AoHTvG3UYMw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39860400002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(41300700001)(8676002)(4326008)(2906002)(8936002)(66476007)(66946007)(7416002)(66556008)(38100700002)(5660300002)(15650500001)(86362001)(52116002)(6512007)(6666004)(316002)(36756003)(6506007)(9686003)(6486002)(921011)(83380400001)(110136005)(478600001)(26005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmhVRmJoOU9Yck04T2svNVlTRURabWVRN1l3NFlDYko4NGVXZTFRY3ZSQkZq?=
 =?utf-8?B?TWMySnNZbnM5a2NCMFVCWXRTYkU3bDJkSjhOUzN1elRwNFExWVR5ZFgxSE9s?=
 =?utf-8?B?UWN2WEJJRjVWQXZZdmMvTTBpendFQjhaZkMybk4zNGh5UkJCZHQrcUtPZnFS?=
 =?utf-8?B?UmNzbk5EOGQycHdqeWtqQ0NIL2tVcS84TmdGbGJFVWdVeEhuZHRBTWl5Uk8w?=
 =?utf-8?B?OVprdjlWK0RXSVc2amM2R1R0RVlSWWJreUk0aklZVE14TWNHaHVQemhVRGhV?=
 =?utf-8?B?dS9WQldHQ1B0d1RCaVp6bkdpUm9ObEVPYnhLNmMvd1BPYUpkc1RIUDV0WldQ?=
 =?utf-8?B?ZTZDSGdJRUxHT0tkN05mdUtWY21zVWFxTERNQWNzekQzeUtzWlBKSlJBaUJi?=
 =?utf-8?B?SFZ3SkpHTlQyVlNtYWQyNFFXSE5hRmdxY2NLMGFVMEtWZDJPTGlYTGVqTFRM?=
 =?utf-8?B?V2o2UFRQeVN2bVdoK2lPaDFFSjdYOEpEekZwYWxaUkhzb0pLT0Nsc0NXWjUx?=
 =?utf-8?B?aHpqcTVJSlVoWURWK3dTeFkxY2xWcGx4d1ZuTDhSUlNpN2JkaHJocW1laXBH?=
 =?utf-8?B?Q2l2Z1ZiRzdtMXFIWnZsdzZucHNON2ZJaGlMZXJ6d3o1ZGk0Y3NLRy9iVGJz?=
 =?utf-8?B?Y3paR0U4YlpWUXE2NW1DL1hqUXRmSDd3WHhsbmV1NUlIMTUxRFJxWCt3eFha?=
 =?utf-8?B?UlhncnB3QTlqNXIxSklwUnNJRm1hY2xWb2ZRMGgvc2lrNWF3cTZEaWt0aUpo?=
 =?utf-8?B?WHBzVFk2bVdwblVBK0hsT3B5N25JbXlJOS9MSVdPY0h5dW94Vm1zRWFWbU9p?=
 =?utf-8?B?NnA0dWk1VmhyWjdJNzZlQ1gyU2VjWWF4NGNFbW0xYW5UOS9YNDRCQ2I2UW1V?=
 =?utf-8?B?cVNaZ1JBQjJQWnpxWHU3SXVET256Q1VUZk5UU3I0V1FNamJqM1EyM2Y5SWZR?=
 =?utf-8?B?SzRwdWVRSG9Bc2NGaGgwSTZWV3V3NEtIUS9YYWVDSTErOTF4WlNTc2xIYmw3?=
 =?utf-8?B?NkoyVkdlNzRuVUZBNmphK21TcDRGN1N0Uy9LaFNKMmtJSWhvbThPbmlteXE1?=
 =?utf-8?B?UzZvcVNOem1lbDJudWFyZkFYMkg4NkEvenB6bGRyN1U0M3ZOV05RNlRmN3R1?=
 =?utf-8?B?ZGN5aGVnaGJTb3BTVlV6c2tGeFJLa3oyT1JBMU1yODdNYTd5cnpoQnd0dENQ?=
 =?utf-8?B?TXQ3UXF4ZENzTFpCUGx1UXJIalhPc25IQnVhOW5OVmE1dzFBc1BpTVVPSE81?=
 =?utf-8?B?R0FUS2t5SjFxTjgxK1hqendndDZZaGpINFNaYUtxRkdOZTZJeERrelBTY1Ay?=
 =?utf-8?B?ZlI5dnB4MWJxQ3F0UWlBbGxVUkdmbWpVUmo3ZzVYVnVoSEszZGsyVElsdmt6?=
 =?utf-8?B?OC9KR1o2bkQ4SXlmWDVyUStKZVRLZGt1dElvVEtLT2VsYmk4cnlaM0NYUWxN?=
 =?utf-8?B?a2ZqTXA0a1hoQm1RTzdnWWpWZzhraGpJVUt3ZjRiRkVlYitBUjhIM3h3Sk1t?=
 =?utf-8?B?VFFvdWtqd083ZTdZNTlEMlU3NG5MUk94Q29BUU4vMlJtK0lVV2NDRnRIWlRl?=
 =?utf-8?B?NUR5TTRpQk5TVytQbWJvbjk4Rk4xTlBsVStFb0NpTWpSa0Z1VEJSMkVTa2pT?=
 =?utf-8?B?Qk1CQ3lPcVFjSkRSOUF2bWFFd1g2c0NDRzAvWE5nREV4SWZZdEw0RUZ2UzhM?=
 =?utf-8?B?UjRWT3JmQ2gwSE40R0FJRUV4THhtVnVxRU5jQmpXQ0tjYUYvK2xjZFpNQkFK?=
 =?utf-8?B?UkZSVmtBaTJqaFA2ODRrUU9kUVJ1S3o0S0hOU2FTcmxPODVFallVU1VITmNR?=
 =?utf-8?B?MkJQa1JxOU5Lb0phVnFBRTBPemdNeUlCZDBmTjc2bE5SZytXQUpnNmFkcUdQ?=
 =?utf-8?B?SDNvTmYvS2VBWkUxVVl0WHIrUkh6bFIzdnZqSjFzV1hhbHFDRkljR25hbGZs?=
 =?utf-8?B?QVR4NUJOdVVOZlB4dUlmd2Y0UDhNVFVBZXFzejcyb1djamwwR1FNMUdoYUNO?=
 =?utf-8?B?MXlRamlqYTZJb0FhNnF1bk0zNnhLelhUbGZ6cGZhdVdEOFQxYUIyWlllTGxa?=
 =?utf-8?B?aU1QTUhjY0lEM1ZBZE04YWZ2bEVRVkNWVGdqQndFb0ZBanNkQkc1aUtDMEV6?=
 =?utf-8?Q?+iayFMlTCfSR/D62z2a8ARVWx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c012eb2-d482-4001-88d0-08dc3109a633
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 05:14:29.3468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uyFp7gptauh9oESYIe2hex+1NoRZBGymsfEEYGVsUzDwysyo9rcNahAU0ig3zH2uS+fBkoJ3mGOCgQOJY/hrKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7228

From: Peng Fan <peng.fan@nxp.com>

There will be changes that init may fail, so adding return value for
init function.

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 656171362fe9..dced4614065f 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -110,7 +110,7 @@ struct imx_mu_dcfg {
 	int (*tx)(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp, void *data);
 	int (*rx)(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp);
 	int (*rxdb)(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp);
-	void (*init)(struct imx_mu_priv *priv);
+	int (*init)(struct imx_mu_priv *priv);
 	enum imx_mu_type type;
 	u32	xTR;		/* Transmit Register0 */
 	u32	xRR;		/* Receive Register0 */
@@ -737,7 +737,7 @@ static struct mbox_chan *imx_mu_seco_xlate(struct mbox_controller *mbox,
 	return imx_mu_xlate(mbox, sp);
 }
 
-static void imx_mu_init_generic(struct imx_mu_priv *priv)
+static int imx_mu_init_generic(struct imx_mu_priv *priv)
 {
 	unsigned int i;
 	unsigned int val;
@@ -757,7 +757,7 @@ static void imx_mu_init_generic(struct imx_mu_priv *priv)
 	priv->mbox.of_xlate = imx_mu_xlate;
 
 	if (priv->side_b)
-		return;
+		return 0;
 
 	/* Set default MU configuration */
 	for (i = 0; i < IMX_MU_xCR_MAX; i++)
@@ -770,9 +770,11 @@ static void imx_mu_init_generic(struct imx_mu_priv *priv)
 	/* Clear any pending RSR */
 	for (i = 0; i < IMX_MU_NUM_RR; i++)
 		imx_mu_read(priv, priv->dcfg->xRR + (i % 4) * 4);
+
+	return 0;
 }
 
-static void imx_mu_init_specific(struct imx_mu_priv *priv)
+static int imx_mu_init_specific(struct imx_mu_priv *priv)
 {
 	unsigned int i;
 	int num_chans = priv->dcfg->type & IMX_MU_V2_S4 ? IMX_MU_S4_CHANS : IMX_MU_SCU_CHANS;
@@ -794,12 +796,20 @@ static void imx_mu_init_specific(struct imx_mu_priv *priv)
 	/* Set default MU configuration */
 	for (i = 0; i < IMX_MU_xCR_MAX; i++)
 		imx_mu_write(priv, 0, priv->dcfg->xCR[i]);
+
+	return 0;
 }
 
-static void imx_mu_init_seco(struct imx_mu_priv *priv)
+static int imx_mu_init_seco(struct imx_mu_priv *priv)
 {
-	imx_mu_init_generic(priv);
+	int ret;
+
+	ret = imx_mu_init_generic(priv);
+	if (ret)
+		return ret;
 	priv->mbox.of_xlate = imx_mu_seco_xlate;
+
+	return 0;
 }
 
 static int imx_mu_probe(struct platform_device *pdev)
@@ -866,7 +876,11 @@ static int imx_mu_probe(struct platform_device *pdev)
 
 	priv->side_b = of_property_read_bool(np, "fsl,mu-side-b");
 
-	priv->dcfg->init(priv);
+	ret = priv->dcfg->init(priv);
+	if (ret) {
+		dev_err(dev, "Failed to init MU\n");
+		goto disable_clk;
+	}
 
 	spin_lock_init(&priv->xcr_lock);
 
@@ -878,10 +892,8 @@ static int imx_mu_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, priv);
 
 	ret = devm_mbox_controller_register(dev, &priv->mbox);
-	if (ret) {
-		clk_disable_unprepare(priv->clk);
-		return ret;
-	}
+	if (ret)
+		goto disable_clk;
 
 	pm_runtime_enable(dev);
 
@@ -899,6 +911,7 @@ static int imx_mu_probe(struct platform_device *pdev)
 
 disable_runtime_pm:
 	pm_runtime_disable(dev);
+disable_clk:
 	clk_disable_unprepare(priv->clk);
 	return ret;
 }

-- 
2.37.1


