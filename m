Return-Path: <linux-kernel+bounces-70234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8B1859517
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 07:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D0AC28381A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 06:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC087FBED;
	Sun, 18 Feb 2024 06:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KcAimRvw"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D96F4FC;
	Sun, 18 Feb 2024 06:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708238897; cv=fail; b=C73exY4ZAb7M0kpHWCz2kcTX2YgmmWR4YyLLbT8uHvEcqlbX8esruVCAzlIkjg6cPpcicKJ2hyxMfgTu1XCzvRl/5vwQ52Utf5q7nASHW3CW78ORYNnQJYN6Kp5Z5Lgr/N7JNPorfPet3EdC3s6Dh3yD6fkcew0MifR4WQMkSpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708238897; c=relaxed/simple;
	bh=2zJxqBVqaNuhlGWo42e1QHXlvX1q4/WgIXGzbYmGZIA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZZ6KmN5Xv3VXZ/0sPCaQw/bWMotm7+0HSd26If4zvZN3TsVtS114pfZurCRBwF2/dZY43aecQfL1cQ9kc9mr2EKCz7fFlncSziIjnLVpPO6jZ7ApQcrBtlu/+d4t5wY01oOkeyZlqwepwzkhgbDFD1e5I3pP8xGlDDpgLaAW0AI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=KcAimRvw; arc=fail smtp.client-ip=40.107.21.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0ZPdQiov4XHfXbDhBHan0W9tZG6KJd7EvZNEfOKd2qao4VsOZFGehJlSWwMqsqg5g1lOsLcrlOvCLHCqZy8rFwm7PTD67LwtrwzLJPsmdsiiml0oNK15fAV+n53MLEz8EwuQ+W0VM9Uw+WnES3ELdKOxzfX0T1yd0lo2t5BXGm8iUtcmlFm91SwgObYEXWbpJTSakCHT0+Ts6EdDjYlzXl9RZRdat/VDvR9JFYkJ7z5QrbprOPPpVdXvpaVnGN5aPnYk4aiOm2k1Wzqpxh4LYUQC2Gy38qyOxZ4XwVJ/Vug2pc9kK1SAEFD03ATdcPc8LMOL7WM7IqDfweFK+W0uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yroYNvtM+ftxkBYnpAH09lTiB04eMcTiVCGoXVH7uV4=;
 b=WZKTdUP+TeOkoKrtzhN/KrZDXmrSC6U+B2kfqNVSdSb3AdhG9+QzcVKaeDAEKn4jFvobEUIsIbX3hKWqTVT00UqkLnoTKcaxmVAK8druWqumkNdDyBRBZsRfPxLJxWKv3//SyvoGDoOeWgFddqPy9DuAOmlXwCIuBzUG9JZOAE46JcsuUSp6ZPHBeEwtLC0yr3/CM0bo/oWdG+wPSeUpw4guTdvz3BS/QzcGBntUggYC5gf8el0HBldhckrnmlZoDm30YlGPRN2WheBky+L3bzA5Lubzg60cGRj7QZgIZXJiIQfrQIWJle9jJrQPWW6JDMym68aZYy57NBTrpQY9uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yroYNvtM+ftxkBYnpAH09lTiB04eMcTiVCGoXVH7uV4=;
 b=KcAimRvwmQ4KLlYq4zlsRUqYFIGon6AW+tzPJIUFZoizg0d7NtB121pz1kl3hy6VkuYnVszy2EzsvD8glU57+H6d1lJ7X384rn3Mdp4YLkt4JxzTK3EXk9OFdVx5Vh/L01CcYruazElpypyGG3wm0eanpDCXQlIw68jS7NXa3h0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB8011.eurprd04.prod.outlook.com (2603:10a6:10:1ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Sun, 18 Feb
 2024 06:48:11 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1%4]) with mapi id 15.20.7292.033; Sun, 18 Feb 2024
 06:48:11 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 18 Feb 2024 14:56:14 +0800
Subject: [PATCH v7 2/6] mailbox: imx: support return value of init
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240218-imx-mailbox-v7-2-8fb665eeae40@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708239387; l=3395;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=S0DKuiQSDcYtu53JqBC1+gV1zoHcWj4DjQyGEWhlcnk=;
 b=tF6LQLwXPX7VnjCtscYX4S8gGtph20GjvajegRmJtn5kV7mgtrY0loI1FP+uVZhnGaqpF6Tes
 Rxzzc7X6HAZBi6fM2quml1VxYS0RJWzdfztfZKc5VEXptAn1d8h8q2i
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
X-MS-Office365-Filtering-Correlation-Id: d5452c28-c670-41b5-92cd-08dc304d9308
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bRbaki3y8RTCbGydrk5J1Da4fWMNTY4UaliGzx6IRZCCuHq+4NVf1oqrGCakI9KAr2SUVOUlutxvMrj3wSmFOGrlLwqxaYBVrjh328YWm0TN1UwY3jd/UX4JALvVk4cQ0qmh622DZcoAyuI4CKSHUmhW8DRNLvzrdVwomV1Y3ECSWNE3BAYfTHbx6EOt0pEPEwomVPx2L5x1HudyDP0f3Lp/TzUbybnaOsjW0uuuQu1+KJKFJuhhCujve6Y3yoKM7AjusmMeDKgcPa2E9E83o1kDjjSPAdCMminD0Y+25wkEh1eYL8yCV9soOUdBzRxqjnObXX5ildIYKh3WEi2c4AZTe11WMIgQPpMIQLLG4xxBmuRC5DiPslSwP797S7LHzX/b5Hi+zlrIpkcNZvfCsAniq1cmhZxSQVtCX+CxayQSOU/Jr0wyI+otnMLbT3A55ezLfWDPNrZPMEz21Pf4CyAP1dRpnhZ2EoYxtYZfSXNwa7dtNB7J0YawLzZcdBzdeMb5JYDkBjYjt75CvnaF8PBT1rdPoGMlHMRQ94kVBvgsoSmPItcITEHKTLFNTI1ATPgBOg07tIBNxOA5GileOeWZd7XlVDKCUxVA7zWnfId0GnEDZq6Vp2CNvVZeActH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(5660300002)(66946007)(15650500001)(4326008)(2906002)(8936002)(7416002)(8676002)(66476007)(66556008)(86362001)(36756003)(921011)(38350700005)(478600001)(83380400001)(110136005)(9686003)(6512007)(41300700001)(316002)(6506007)(26005)(52116002)(6486002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmtYczNYdVh0WTB0VFFrUkxEdHFzNzByc1g3Wk1ITlhLN3BBYzQyeFdsSFhK?=
 =?utf-8?B?emo1NXAxRTZaYXlaQ3BIS2dlb05yRU9GZXYzRHF4STRnVnRCZUpLbFV1NmRE?=
 =?utf-8?B?QnV2UWxjM2s0c05qb3FHQVRFOWw5eEdRejdXSm5kem1IazVWVEJRcFFxOUdo?=
 =?utf-8?B?ZGprNVpIZHdvL3QxK3J0M1N3UkRUWHoydVNvbUVIc2tVR2RUZGZySUZ6ZzV0?=
 =?utf-8?B?WFpIY0VxQzlsVUkwZ082dFlxMjlpb1BHek1ZUXAveWIxRWZJOUhGcHNiTklC?=
 =?utf-8?B?T0hQTk1wb3VFdUN5ZUxnb0JlSWZXWTd3enJ3by9PTW1EWXpLam94cEMydWxV?=
 =?utf-8?B?QUgxSW00WEgrT1dXM25lUlV1bGxVcmQwS3o4QTJ2NGdQeldGZEw4Nnc3d29S?=
 =?utf-8?B?anpkV0lPWjUzcWNBaHNOZWJGdmxDV3hNS2hPVi9xWVIxWk9jL2FveGhlaW1P?=
 =?utf-8?B?YWhtM2lrUmROY1k2ZzJyWkR4aEtFOU9ZV1FWMGRjMDNzUUlYQzZSVURibm9w?=
 =?utf-8?B?QWFudFhLSUhtTW5PNjdseGdoZi9ra1lmUVZLeWlyUWJuT29UemxhaysxQ21I?=
 =?utf-8?B?VEM3UXQ1N1A4eUN5QkRZZjY3QlFyRTdlOExmU0NwRUdlR0NnSytBOU1CMWlu?=
 =?utf-8?B?L1BhdWlGZ1pLWU9ITjdSL0UzWWRRclRNUFlmeUYvUlA1eEFDOWp6QVNqUmJ1?=
 =?utf-8?B?dlBBR3l0SUlCRDA3bGltMlFxWWloWGg1enlHZmpsZXZBSE1tZUNWOTZkSjk3?=
 =?utf-8?B?c2lJeDJobUV4Rks1aGtsZ1l2akZQMWN6WXFuSEFETWhXMnAvcGx2QkRjWitj?=
 =?utf-8?B?blNTUFgrUFU2cnpYV0RXV1A0aXpYZ3Qzc3ByWHFjaUIyQ3VHTXpCTTNZTTdI?=
 =?utf-8?B?SEk5MzYxdkZLQW1rdlRGTVBxUUdRL1U5VWp4eHpMVXd6RFhEY0lWVVlhMzUx?=
 =?utf-8?B?dnRwRStTUlRmUXlqNjRKNTd3NGxDWnVvZnJUU29vMG9lVVlYNnFibWo4UjA1?=
 =?utf-8?B?K2todXowYTJ5T09PczIwR2VxakY1NXFmbHE3em4yMERiL3lOMmNnQmFTYm9Q?=
 =?utf-8?B?NlRsS1pYdE92WlJwaGFicmNXcFE0YWxodjhVR1VxZkFjRkpPMHRGVXlLeGJ1?=
 =?utf-8?B?cnVobEkyd1BvRWJWTjBOU1VNVmJ6LytmUXVkTzE2SDkyZi8wcm5YamlNa1ht?=
 =?utf-8?B?aFNGdnVVdklEN21vaHIwd2MwVElRdGtFNWFhK211TnZQM2MvdXJwblpLbk1F?=
 =?utf-8?B?UG5KWkJyMmJ3YS9KaTdiZFB6dXl4Ny9SRHRjRzZWRXRiTEpRd200NUFiTmg1?=
 =?utf-8?B?aTBoU3JhZ0tYdG5VWUdVb3dIMjgzU2JZWlRzTzdqSjVSOSs2bFZuNUowbVRT?=
 =?utf-8?B?ZXpEZjh4Q1hxeVdiU25yZHdzUllwcDhnZzVSRTlkb1ZQdUdJb1pHc2daTEFX?=
 =?utf-8?B?d085SjcvN0lRSmFKR0FLWDJjMXlNcU4zdVlralMvTXk5UExPWnB6RjFUd3c1?=
 =?utf-8?B?QTBpb1ZuQUNORDhPRnE3N3drYWNWME9PQktJWEZxMUVYN1hzYmlpMnRDdi9Z?=
 =?utf-8?B?Uitjem5vc3BWU3lEeE1ONnBOTTVYLy9vUFdlVy8xUjBTbHVYUmVqZ3ZnWElV?=
 =?utf-8?B?eUxlOUw4cEdvZmhKbGt6U0dodHcrZW5DUlB5YU9NYkUrNzU5aFZuTTZxTnpF?=
 =?utf-8?B?QWRGWWlYandlQnh4YWUyY2NvU1F2TEdDSDlrNE5tNGswcmpNN1RmNjZvNGpz?=
 =?utf-8?B?V2o5SW5RVVVFQ0dnOVExNW1tNnNCbUEvZEJwVXFjYm0vS0pGNXRHVERJb1Jv?=
 =?utf-8?B?cU1XU1cxLzA5VWZ1YTNtZ20vTDVkY3RFem5jT1pHVjJOOXo4N3pWKy9UakJU?=
 =?utf-8?B?QmV0QWlscDQ5dmpvd2V0UmJrZFcxN2h3MURtWXZQYnVUVmxPakxMd0RTUGll?=
 =?utf-8?B?YW1PaVpLN0VHek93VG5mRVA3VExYWVZwVHR3MzRCSHd5NWI1bytvbll1Uzlu?=
 =?utf-8?B?Y3B5WFlQSkVkL0JOUkNvWERNSkRzVEFGRWJIZWhWY3VPeEUvam54Q1doNWVL?=
 =?utf-8?B?M3VtUmd3SWNqdkVUUDBUUG1SOWN5aGtOVHlTbEFSK1RMYlNQMzg2dkErK2Y4?=
 =?utf-8?Q?HZmw8Wuqha06RVVuzWKYO0jmd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5452c28-c670-41b5-92cd-08dc304d9308
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 06:48:11.7913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCUU7yoDiFg8zc150KwTE2FXNJ+Es36vo/lU4L+Nq06mMlV6Ik4+2cszOJ+rFZQJEL8GLGJe32zRLQBfwE1SIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8011

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


