Return-Path: <linux-kernel+bounces-47366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB268844CE7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 664001F23285
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE1613E20E;
	Wed, 31 Jan 2024 23:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QVuTRRe4"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2048.outbound.protection.outlook.com [40.107.8.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EE613E205;
	Wed, 31 Jan 2024 23:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706743303; cv=fail; b=CQd0I37n/1PDVJirjqKhcv+Uc1Jd4Az9Jq/nh/Xx3LVF9//xYK8dvrN/0W8xZ7maPE5nk2gGUilPcZr0sgzfMXLPs+WwJ6J8bAVOJ1UisHl3bjPjED3AHtxAz0LiYfmz1HUkoEsJWFY8xbCm9YwmjipNZpJ5H07RKJ/8dlXSPeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706743303; c=relaxed/simple;
	bh=2zJxqBVqaNuhlGWo42e1QHXlvX1q4/WgIXGzbYmGZIA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=JjvT/pjtCkDsEJ6Jimyda3C//ZLv/N2oqhUnNbVbjKWmhIcqpY1DqjUrgjJm3KKlIwX1tKn7zVjVeL46D60Eif8Jbw4Y3txX0TYU1t63KnbUTOdv2BwQsEv1muEuq3F9hzCtHizKSBnNB6jOQzPSuQx3ZNrsvVUYkSDh/kv8Sbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=QVuTRRe4; arc=fail smtp.client-ip=40.107.8.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ytr8ofe3ts12bQiU7ebSXtHASkH9NSNZzGEY5ilCgXsIzQ6Mnpu15xWpr2EgAbxCyaCOEtDwGb9IdLHgIOOSaNPvakG5fb7UVmoNt430J+N+J0HT35oNtVZ9qaSU/JFp4hAgJCFg2qmVmtq7vHrPYY1S++oebt4/CAj3LYeKBl9Dcs4nQqKTjHejIVFYO5foZ0ArBRrQWqzjpXI/pyrdteLn/mbpR2G5OmmCscdzuk44jBPHobRc6kgvkvOj3Wli7H3cGxAPuOISAUMF91t8sRBqsPTyNxUNohaLzsyY9/89XFMsYIEYhLNMjMzCRq5Zjerhy3xcx7s06z685qTLxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yroYNvtM+ftxkBYnpAH09lTiB04eMcTiVCGoXVH7uV4=;
 b=KnJzDgIsUkS1eqGzn7yXliDTKYM14Q/8lkTPstjCyYAejspJOKdzaW3CVpE2CYW+/OJ2GcneEhqT4iWt6In9fidpquQGfD71XzgEtxZNuTSfTnEHi9BT4w3zWU8iiz6r8V44VQaHlKZ7bkC1f8psamLWdJdGV/xkdioPN0I0+MwdLSmTUncHQ8sXHPfxDbCogku0xwsVW7rd6LcMVcvmtKu/UqL54IYBvaR9kA9DdVxVV4wWKbSNDfK2yVxz019/DFp3vX28c2CS9IXaB2DdZnzl300PL5ZIhbv/Uvlm3P3w/zB+qARnS679dg+Aa47SiYlFdsaIGISPkDUA0a5YbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yroYNvtM+ftxkBYnpAH09lTiB04eMcTiVCGoXVH7uV4=;
 b=QVuTRRe4NWgUwBdI7ZquVmzmA3GIiUoq0HPftqtp2lzC82/f5uJtwMU+VJmWoJjpU6u4z2/TOpe1iLglVKW77H30tUqeY1BWOafIX+pm5R3rn1LPGD/yYuJlCi5ItLLg2xXSZuGQC33XdniNnE/st0hruCmWYAMNPTtxAsfDlKY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7396.eurprd04.prod.outlook.com (2603:10a6:20b:1da::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Wed, 31 Jan
 2024 23:21:37 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7249.023; Wed, 31 Jan 2024
 23:21:37 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 01 Feb 2024 07:25:38 +0800
Subject: [PATCH v6 2/4] mailbox: imx: support return value of init
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240201-imx-mailbox-v6-2-76f4f35b403e@nxp.com>
References: <20240201-imx-mailbox-v6-0-76f4f35b403e@nxp.com>
In-Reply-To: <20240201-imx-mailbox-v6-0-76f4f35b403e@nxp.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706743555; l=3395;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=S0DKuiQSDcYtu53JqBC1+gV1zoHcWj4DjQyGEWhlcnk=;
 b=W5a6ZzLKxqmgK4UssaJWiqZtbRVbEUDCD8H7KWbWha1f+NbQ5XEjWrNPiUMtG+qlAKot4FgiU
 avdfd5odp4cDwUC8V7lCYB6bgabets7kNASm2B93Fs9hzB5Jd+BaD1e
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM8PR04MB7396:EE_
X-MS-Office365-Filtering-Correlation-Id: a483c66f-1bce-488d-3378-08dc22b35f39
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7vDJrZ/G+7VsuhnyRbGzQpIFe9vxOWIzAb2wQksiltLvl6UEOAqbF9lYFGbGAmnlA0/e8hMK5E/FhWcF/UrkullK0leGDmOVnQI3/bFRTcoMOZf96c0UBjczjLCLz/lU3Ccl56gHVeTXknECKo4yndZdsG0i/LNe66PQYjwV4teCADRli7F2VMNVcOr91b+Hkl08/akymob9GmsG36nVy47+csGSHt5H3BxvcId367P2xt/gYHk/mlBiOuJcUvGLBbn1FFHjNSL+tIer/ld6ZN5HCEnzyrImDApViSDXXK4YQsUwNdKLFF2II6gMsoacXyWdK76UldmhATaQDP+IBvr45Ztr6rtNG47CM6cytsKLG89rqYsEyF2Z9OfclbumUfRN2j0JEdznTQDDksE+Vxv9jh7Kl45Avu/dqPk4g4Fl/ZE6AA42eF+uYoUdI6vQwoBz8C8NcGSEQzhQH+NbAUJPUt0GcBDPRnfmQ3mVN3iqLSJS+MpJ857GS1Rq9p2y24VATaJFi5Q9sNyvTanTAcMiX7yKb0rj3GtA6OQB+sAgWSt48I+cSzjYONquHNYYe0qW3mbpWr7CX5rau4q6JGMH03QMIvC7ygrfuz7PJCSnHqj2ExApL9xMdUQq3sCW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(39860400002)(136003)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(921011)(26005)(41300700001)(316002)(38350700005)(66556008)(478600001)(36756003)(6512007)(9686003)(6506007)(83380400001)(52116002)(6486002)(66476007)(38100700002)(66946007)(5660300002)(2906002)(8936002)(15650500001)(86362001)(8676002)(110136005)(4326008)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzhwaHkzdUpSRE5GZnB1ekxmUTlYNCtjWXl2NStrVkJVYkgrUVB2K0Nhc0VH?=
 =?utf-8?B?V1h2UGxzMitEWEdzdHdDeElPTkt4c0t1eFFENXNzKzRMQjZTZjJKbWV6c2kr?=
 =?utf-8?B?Mzg2M0ptYmV2RTVWSkpwY1ByMDFmbkt2emJMU1FRKzM2Q2Z5QWZJZTFhZ3dy?=
 =?utf-8?B?NVR5NnpSVjA4Nmw3UFp2eGZ2aU9QS3VneHN0emRSQnlYNHIyQVZzNkFXbENF?=
 =?utf-8?B?dS92eVpwZjEyZTVmcFI1Q0I2MmRYWWdteDNBdUxCcC85QVNiQUpSL2Q5MVBE?=
 =?utf-8?B?a2IvaWtRWkJrQm1MTmltTUZFZnVVcE1HNVhwWEhlVlB1b2phS3p5R0RYb0la?=
 =?utf-8?B?Q04vS2NrNkJ6OTQyUlkyeTNIRDBHTkMrVUFzbytBRWdLa2xiWVdxUjE0TFZH?=
 =?utf-8?B?Uk9RY2tpU1F0R1NZK3dBSFdBdGM2MEFrRjZobmZJUU5XekxhZUt0V3hMR1Fy?=
 =?utf-8?B?V0pPZVNHQXd0NENybUpreXZzZmppbjhaZ01nek5OdnR4TG5TQTl0N09tNG4r?=
 =?utf-8?B?enF4ZWhKNlg4WWdYa05tdHNnZ05jazFremNUOVBydEpiZ1ViM3orTmZyM2xq?=
 =?utf-8?B?VzMwa2JTTFJKcmJ6UmhyWURrZWNkblcyejIyT0NRZTlXZjRFRk9LTUprZjlo?=
 =?utf-8?B?Ulo4aTZCVk42bUdFZTBxSnJ3d1RjajlyZDZETzZMRGpKajUwYkl1aEdDeENv?=
 =?utf-8?B?ZUZZVGJCNTVpTEZ3VDlXQy9HY0xCK09DZlFXVDVZazhGY3Z0Mm15VW5LZmNX?=
 =?utf-8?B?Q25mbTJIcmJOcVBGZGhUT2tWdTRVNmIrc1FFM2RiRDlOZWZpQjV2RjdqQ0p6?=
 =?utf-8?B?NG80ZEJLcEtEVXBwNndNSTZGQ0NrOXNmeFZjWms4RlFHcmIvd2dXOURQSnVa?=
 =?utf-8?B?WlZ4ZGlwY2pFaC9iOEdSRlZBMit5dC9DV2lDdytTVnhWbmc2M3dOVWYva3Jt?=
 =?utf-8?B?NVI4MWRiRURaRGxtb3JIdTNFL0o1QTNGMnpvKzFmRkZKU2NnM2lIRDFFRmkv?=
 =?utf-8?B?ODh4Qk5XSXFOampscStDdFE5ZW9jb1U2eDdHTmwrOGswRzZhdVhNeVlqN3Mr?=
 =?utf-8?B?RXpLNFI5bkVSb0JZQ3ZvWkpDdmNzWm13dGJKYzZ3ckR2NjF2bTliTVN1M1d6?=
 =?utf-8?B?cmtBeERGeGszNGRLZ2k0akZxeVBkZE1lVzFWSjlJMnk4Zzd4RXRCcXBNWFMr?=
 =?utf-8?B?NHg1RStXUU5lQ2NmWlpBS2xlcXAvOUxVMW5PMzFpcGRwNlRkTmlCN2VGVTMw?=
 =?utf-8?B?TmxtNFRXUHdmak1IdndTOC95S1dCdE5WZVB0alFJZTNYK2FXNmJvN2c5L2li?=
 =?utf-8?B?Q0ord2w5MjlJM1BKL1NTdVVyak5KQ1ArMkttbVlxQm5qd2JXcEFMUmMwNjYx?=
 =?utf-8?B?Skw1dkJJS2lvMDc0T2lGV2xsTlprS0hIMXBIWVIrQktBcnVmOHVaY0ZkOW1u?=
 =?utf-8?B?a1FwTk1mTksrTjMzcXF1bzhQV2QyMWVtL0hLS0NPN3VQOGc0Vy9BZXlJNFEw?=
 =?utf-8?B?aGUzbDROd3VNYXVmVXd6eUgwZnVaanMwV2xTY1RlUnd2WGVUWHJ0Q1VEUEdW?=
 =?utf-8?B?RlB5MDNrd2JSUXdoTTFWNDU3RXZTY1g1dWlxbHEvMWRZM3c5YkpvMDRPVHU0?=
 =?utf-8?B?SEhxQWVWZEprNGZuc25nYjc2RzB4aEY2OGxwZGpEZGtFcDBHZmg0WUFjZGxH?=
 =?utf-8?B?VmJIQWhKTXN6Rk16Y1lIb2JoOWdwSVJYN3p1RlpYcytzVWQvNXk0dTdGcVBW?=
 =?utf-8?B?RkZ4allFWlpXUnk2RUNMVUJ2dHlqWkRjTmcvbnIvQTJQTFVYQ01yYVd6TzBP?=
 =?utf-8?B?b05COVdSNm1OOTRjVy9CYnJWUnVIa2hId2xaNEZ4Q0hXUENveUdZbEVQb2FY?=
 =?utf-8?B?cnlsVEFNNDlCWTQ4cjBYcXVuSUtsbWFPbitJT3JoVTJXZXpsMjhYSWYyUFIx?=
 =?utf-8?B?Q0VpckhKREJRYlhqc0FNSkhjSHJQNEVFRWYvcnkvKy9lMUc4ZHY4R2VjT09u?=
 =?utf-8?B?ZEZWU2pVdEJ1VFB5ZGlqT2M1ZmtuczBiVGVaRXEyV1hMbFh0Z3cwZ1Rub1lX?=
 =?utf-8?B?OEh1NXBRbnVFTlM5NkNKQ2VYcVRYb2FaMzRQekVLdzNtS2lHaGcyVUhmcXlv?=
 =?utf-8?Q?roUYNZv9jlDkqEELjw3DgH4GC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a483c66f-1bce-488d-3378-08dc22b35f39
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 23:21:37.3568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2fzl64/L6/nebCaXxcNwMfobmB9uQOh5FUxkToluiGlCJdsttgaeiU3D/cOZnnmXtVqqy6g0JE4MjHuQIQq4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7396

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


