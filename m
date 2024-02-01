Return-Path: <linux-kernel+bounces-48110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A441B845758
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA2961C228C1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1990D15F309;
	Thu,  1 Feb 2024 12:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="R26txHms"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2084.outbound.protection.outlook.com [40.107.8.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066F115B961;
	Thu,  1 Feb 2024 12:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706790186; cv=fail; b=rzz3CdmMEe3X6BB8DGn6Ru925vjfVptHNT1pUiGhz2qkcKH2tL/1G2A1gPCZwwUgM2wSnv4JuvLFkO0UeZ1Nr/Hx6r2hqrCeFXK5+HfkKrtCqtiK9/499PB2cfwW/fWPNycUZdqbVVuhthCkDE5rDdSFTnaDGrBhqQuXmrxKkUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706790186; c=relaxed/simple;
	bh=JudX3nYemENdJMcQ4UDGstbpZSe++RKpsBccVSmnXpc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GvSpN4Y2YuQ1xVAdJyk8YnZOWZbBddqayTKQyBr05uqyNIKxiRkX85N5kwdIR4nBur1eVvuzwBYiAHhAXQItKOVojUoblheOoW0ZpCN1Q2vxqSELliFmBN+R5uGXXacmvG2IKS5SpkYAuA0oh7e/RHT31o8cQUmdDZ2JsNmen08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=R26txHms; arc=fail smtp.client-ip=40.107.8.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXVarSiI+pJNmyEKxhB6AmX9XzQX0a0MXXV2aZLhFrPck7nedhJSLOd3tdZoPaevdRHyAgdCTlZga40BQpbkJSwU6ZMR01jXIWJYe6tBvxHN4a1vHMcwnIr39sCAmDQdgDOFMQGFofrbdpGiwJWcqZgCH1XK++OAE4Wqb2NcgO3cr3VbJgG43YKbMFKfdNkbm6QXwHjnTXBLhopSlZ3du0MrSeTM8XgtxQ/EGcXjzL1mt508N26wrfZJJr2PipOb79QK4pmiIIK1nQK0X7x4NcFqNd+5EDBX619xr2ZNVeJz0byj7LL6ektu1Huf+dFKNLLXCvsV5VEccSlRpfDsaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8o3kKXjRRu/dtoZ++YLi4GGetqkDbMsSH5TWFO2wc+0=;
 b=g3E1M6iow46H3/Nc3H4JKDHLyInDfrnMVpLQgypUybKNdwwBMNjgRnz9AZXqwUOpLcjjMD1Z2wGrUSbV1iqWIPP0cAIi+gKvZPGNaVQulkX4Mjmu+SxtfEbn2Zpqigk13WKAEQCaqFK36jDvQStVMGQGRcic45uA2s1OBJvMZ68tqrmaOC4q1JG0IPhWnjIiGyAGM53U1BcGgkMEqPfapOTn9MkcwElLTG1+pB55vZI97Re2sd6YfcyF8/NTUpMgOuh8q4ggIFwPn3KGe1xS0Tb2n5UoCfv/GlOWIRqOBr9o6R/+VhyIuoEr/76mdpcpMWB7nsmtwPGWQxh4vmYk7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8o3kKXjRRu/dtoZ++YLi4GGetqkDbMsSH5TWFO2wc+0=;
 b=R26txHmsifpg2R7Dy08D1uZ3cJsRLRXQXxj1sn+B7jTwP+3/EIAeBuwraDr+UYUl0ghGdUoBoSBM3AZkn+a5JHrqA/1LSWwI9XeTE5R/z9zbDQl9Iirec4kgLny3YDCfVBOWQvih4iTbJmdETkfTgGeMnV/5RXh1U+1Vv+tarDo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR0402MB3910.eurprd04.prod.outlook.com
 (2603:10a6:209:1b::33) by AM8PR04MB7793.eurprd04.prod.outlook.com
 (2603:10a6:20b:240::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Thu, 1 Feb
 2024 12:22:58 +0000
Received: from AM6PR0402MB3910.eurprd04.prod.outlook.com
 ([fe80::1f2a:6f1c:51ea:e7d9]) by AM6PR0402MB3910.eurprd04.prod.outlook.com
 ([fe80::1f2a:6f1c:51ea:e7d9%7]) with mapi id 15.20.7228.029; Thu, 1 Feb 2024
 12:22:58 +0000
From: "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Viorel Suman <viorel.suman@oss.nxp.com>,
	Viorel Suman <viorel.suman@nxp.com>
Subject: [PATCH] pwm: imx-tpm: reset module on probe
Date: Thu,  1 Feb 2024 14:22:42 +0200
Message-Id: <20240201122242.1597601-1-viorel.suman@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P251CA0009.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::20) To AM6PR0402MB3910.eurprd04.prod.outlook.com
 (2603:10a6:209:1b::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3910:EE_|AM8PR04MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: 237ed8c5-2f91-49a7-d866-08dc23208620
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	L00I19vp7z/Hekpn6/Du4pCwlRCUhIscYBUua9+yjMt98InVrzXZw7kpbX8t9hfPfNtA2qTdtP7NaVOV2Ey3aMSMS8SA2nUe3g0UsVRIuM5PMh/VmAXHypF/iXS06ROb+rRhblo3iURLH3yHZo7+46eDYOLJcCZSBXYA3lknj8Js8x7VJ/iuc4AEeikSqmIaSgm/7RIWf2d6ecpIJk9KIp/P/iUEHYt8F0ZzR2tS3eGnFQVCPs4pzjl6YWu/TGqqF6QNzfeDLZszBYBR1aA/QPmPQQlJOlOONFDSqr2rikSDnqZD7jIlXc1EU4DDcSG5he44wyIhc2yaZQa/dMeoZcmHMxYrXeWfFs7mIZvjlmckQbCxvltOoyTObYHQAIjF8cQW3gRC/aZw4b+//2HInngObHVsDR5EoNN/i3obRa2G+nvJbv9nCt1XQD5x00MKANXtvI782AEmwIG+zUL2fQkV2qsX1Lo2YeKEst7MDk8T7pkKn8O0xVl7+CPhVfGA9yDl+iIgBQetvhAQqPa96/twIQiXsLU8mP0pv7T2flpj+5cvgmTQi+ev5IHUfW/FbTTkKr83OheoJmRN3KSqg5AuxmnJ3iCklBVQ1xedfGH3PRWtKabnYYH0e4+yhix4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR0402MB3910.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(396003)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(83380400001)(41300700001)(1076003)(86362001)(38350700005)(6512007)(26005)(38100700002)(2616005)(52116002)(2906002)(6486002)(6506007)(316002)(478600001)(110136005)(4326008)(66476007)(54906003)(5660300002)(8676002)(66556008)(8936002)(6666004)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?CXCPV94Dw8sETuDlBSr0VOTpbKZDPmlIJ7dF2iAkWoaBW0NVWbsr0L2f46?=
 =?iso-8859-1?Q?Sf10yKamZuxv3Q+GlE8lOHB31lh7o+TEx43nn4imv8GrnxtE7dLb7Wv2Nw?=
 =?iso-8859-1?Q?98jDF5xL5MXPYqdUryXnq3KzmXLpkTuppur2IHKNl5gQAYsftNHK1m10uR?=
 =?iso-8859-1?Q?y2pJyYpG/IBSffJw5CSC8ghdT7e0N8khhBYiyGQC5FkqLWYpw23QQgXjSx?=
 =?iso-8859-1?Q?s60a98Y2sQB1j2r82NyILTbav9l4nvj7lEw7TEqSBf2Gxg8gbeP+w9vUCx?=
 =?iso-8859-1?Q?CkGEtunrjjpAof4BI1jgZEeEqYFYW2ysQ82b1gT/iVxRav/OmR65756Sll?=
 =?iso-8859-1?Q?F53hfEDza9QjUmbXvmbnsJ5ax1zUPH4Gck+XTl5rEoLguak/roLuLm4mXF?=
 =?iso-8859-1?Q?QgcT7/BjBsPCZ7pIG5fmF0uhO6C6c5/+shro/6cXefxKKXuiglUJdoDiJc?=
 =?iso-8859-1?Q?l7nKCehOr2jdmbnPixqck/iO+TvQFiHfnLdPHxIHNsHxgHyKzxCeYnGzhX?=
 =?iso-8859-1?Q?9RbyCS64NIDlY3loM+0tQ9upvJVtZqmALTstCE/ES/Gpwphm02DyllRZPU?=
 =?iso-8859-1?Q?lZMI+xxXWsJ6Isjg093xVTle/1Qnb0rKbRJUerlE9HzAnk/ODMIr3LTW1F?=
 =?iso-8859-1?Q?E69H9JST964jQv1wJ+44sHTYu29FN/PHJhhPJFKQWZmN0PNiynMwJOZm6U?=
 =?iso-8859-1?Q?++q5xZRrrPzmJLUKw2yo0MsV/72XsdEGvlnZnVTIOoz7gcp697ebL+7YeI?=
 =?iso-8859-1?Q?HTsz7MIjovDVfO7XWGLi+IroMl5yIZpjy+ELOlmR0z26d507Ux27rxdMNw?=
 =?iso-8859-1?Q?mM7msdgCpI0ChKgYEKkiwn9zdqHgjrIkPHYtNxc8bw+byGjX0E5IR6LrGJ?=
 =?iso-8859-1?Q?SQayOWfioSgo1riR+Qr3ylkGTlimRhwU8Bxq+466JkXFnFQw8cSm3d1O1+?=
 =?iso-8859-1?Q?KFziXF3JkHfWeJmBAKWsiES9rhaAU289QxXIvpAIhnNCxqFEdeus0NFfyN?=
 =?iso-8859-1?Q?p+hFPZDXV24aCvqnBD4qC1kzKn3dJCPbx0KvmO+JtxXYS9ijBztDGvZuon?=
 =?iso-8859-1?Q?L50x8GY+LD9nGvLr+bfSUjinW8w8tbQKRFHeO20jNEMWaZfjqF03knoFTP?=
 =?iso-8859-1?Q?qKkq7ciRkGSE+rxo8nXayE0t89OzqL5ItAGzLxM0wvlESsUx/WFvOc5GPj?=
 =?iso-8859-1?Q?QcbC3SpTCDc6teATdRCggaRSuNDoPLDNPosRIv7j/8/fFvXnka9xkFfVFL?=
 =?iso-8859-1?Q?6tZB8GRzqbJ3MXa3sRZVVTIEf1hfJ9y35rF3bjAEHrOPtEA/5W/DEzr/P5?=
 =?iso-8859-1?Q?ELnkTTiWV7IE+3t8YkcltcIrMdYCKTBmqVwcKwxbpAfXmVjpZOR8GYOCLu?=
 =?iso-8859-1?Q?bWOeqaktGs7c+31XvrfpyCi57lZ3TOodfn82ZYTW6XllC5Y1f1f6GAMjnG?=
 =?iso-8859-1?Q?BIGjJHjDcsqq7W4xbiGyM8ZM+yvfjEvQtVlDrknmHA2KImsFmg1DKDiBgq?=
 =?iso-8859-1?Q?D33Xum/iDVEdCVmuUchJuIMNjA+8KIT9++AF3wGNQte7wtco/eB66M9Oln?=
 =?iso-8859-1?Q?bPy18qooc+Ex5mY554M4A75hIxQ/P6lnBhtN6aCAe/w71WtRQCoB0WuB6m?=
 =?iso-8859-1?Q?kaPM3UZxfcCrzcl9psGGxzYwxm/HLQO8i3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 237ed8c5-2f91-49a7-d866-08dc23208620
X-MS-Exchange-CrossTenant-AuthSource: AM6PR0402MB3910.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 12:22:58.0065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ZvGXqR9B7kuCJgqYslNvOwAscel7WW4iMMFkUnlFScdsBm1uURjiDRvJ/HUrdJRF2+0mHhOl3bbQ/yZswLcHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7793

From: Viorel Suman <viorel.suman@nxp.com>

Reset Timer PWM module on probe so that the module
takes the default state after probe is finished.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Florin Leotescu <florin.leotescu@nxp.com>
---
 drivers/pwm/pwm-imx-tpm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
index 9fc290e647e1..27e6a5342693 100644
--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -33,6 +33,7 @@
 #define PWM_IMX_TPM_CnV(n)	(0x24 + (n) * 0x8)
 
 #define PWM_IMX_TPM_PARAM_CHAN			GENMASK(7, 0)
+#define PWM_IMX_TPM_GLOBAL_RST			BIT(1)
 
 #define PWM_IMX_TPM_SC_PS			GENMASK(2, 0)
 #define PWM_IMX_TPM_SC_CMOD			GENMASK(4, 3)
@@ -362,6 +363,10 @@ static int pwm_imx_tpm_probe(struct platform_device *pdev)
 	val = readl(tpm->base + PWM_IMX_TPM_PARAM);
 	tpm->chip.npwm = FIELD_GET(PWM_IMX_TPM_PARAM_CHAN, val);
 
+	/* Resets all internal logic and registers */
+	writel(PWM_IMX_TPM_GLOBAL_RST, tpm->base + PWM_IMX_TPM_GLOBAL);
+	writel(0, tpm->base + PWM_IMX_TPM_GLOBAL);
+
 	mutex_init(&tpm->lock);
 
 	ret = devm_pwmchip_add(&pdev->dev, &tpm->chip);
-- 
2.34.1


