Return-Path: <linux-kernel+bounces-32378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD15835ADB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B335287D4A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012A363A0;
	Mon, 22 Jan 2024 06:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fXGNWFDp"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2083.outbound.protection.outlook.com [40.107.104.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CDFFBE7;
	Mon, 22 Jan 2024 06:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705904122; cv=fail; b=okALCF49OI5zsQfCI/nuIuSvbgAlbILMzC17asYohzklf1Tuuyjcl0U1V7s+Ub90sv6NhgdJnnUkMLCF8o45Kdzj1LVbALTS5PFd3KivS0d7Z1+x649+NslcCw51/Uyq+jBnXegv1ORWnC7MIv3ncSn+++9IVktw5nPOLXqPPZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705904122; c=relaxed/simple;
	bh=OLG9wG9LUNbqZgE7A6vouI4hKE6Or0wu0XkTbvbXM/U=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=K1gmsKSkCdLREVE0zCw/tuiTgdUUKkG1gHbOrhNmetWXhq3Hdi5kV7mSjofgt6TA9qXJpiD2av+2iju3KphBCPY3i5Fnt0fDg6mv6QPW9LljVmLkxKWUW3qT+7aX5l2k54mhEptJNocxrSP3I45bet9H0K70FoTgwJxoTz4kawA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=fXGNWFDp; arc=fail smtp.client-ip=40.107.104.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vr4QqslISUzM7TSBNkf83aRcV/3Y3xqUh6mn1DZaAaBgp9QQMtDmdWnjTPHpuwE5d+RMhiV5nHG7O6AsPbjTRqnbdSU7/3PEEu6jmWEB0G+IRSwvbjgT9QTQ8s5OLtwIPjI8Y5mVyQF22zt6tWgcqb1fS4sPyS0YScWTIu7EbRGQC0V6cq/lZOqQAbo93myM4Pyrbm3VtBGGRO5uxvAbWWax6QLMGZ9dTod0gHBO8oeq5IZ5DUnvnvIYkitLimlDqfPB+sLfNgRFV0C65Mswm8KLfF1ThUEHvsgUWc/53PNY+aER1NgnR3I7ybv5AYidl0DSX5qr/roglg8PmNshbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S00LkTCO5ug4Wk2kAzcZUF6yq0Qq/+Ds7+Kxe0oX3wY=;
 b=HkoHwdZ10NEwJROrZ4G8piznTz+74TB/Pwp1H9gfULFkqbz9O+IUViCX4pMWazrUoRVsHXRoP2wjwf9SXNT2QH5kLyCoA1Ck6uV1KP0ADTUFIuParuw6F5bTfC7FsidYDhfzOd5Q5w0WsxFhbDfKvlC8W7H4B89YUcxk9rBprZzK5bge7KWgHp1qSpICs83ehlzJhFDhO7IK3MRk+XOm3Iu4eMUmysE5DMKOeQrG0V73Dq/5FLKskvmwgR9L9jp0I8qEGbMF8kbaIwGxQUt2jClqpF7MjZ4AkhuZrgY/dndM4X+5YoFVM1Y8p/Wtcwb5qom/FT7iNX81jo4a+xzpqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S00LkTCO5ug4Wk2kAzcZUF6yq0Qq/+Ds7+Kxe0oX3wY=;
 b=fXGNWFDpPIHryX+KHqLLikLzglGVyvCUw8Hl6Q13KLY4cW3AX3bIDqQ7TGPAMAe9Bj43SO7NJIsSuyMfeoG9dvp9fGY9yhrLnX1RNJtqLnWnu8JaW/TuMZnh+wFbb6zodhHbuMy2TlX+7HK0uFXyORntHxZVIHWpCA9HXbUVcvk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7991.eurprd04.prod.outlook.com (2603:10a6:20b:289::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 06:15:17 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 06:15:17 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 22 Jan 2024 14:19:25 +0800
Subject: [PATCH v2 3/3] mailbox: imx: support i.MX95 ELE/V2X MU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240122-imx-mailbox-v2-3-7b3c80333b92@nxp.com>
References: <20240122-imx-mailbox-v2-0-7b3c80333b92@nxp.com>
In-Reply-To: <20240122-imx-mailbox-v2-0-7b3c80333b92@nxp.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705904372; l=1750;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=0B4VqTwtXtRr4S+gF9oNw8ppit14PJMMR/X9Pho1nAU=;
 b=6/Y4PilE0iGqExizKj2SGLsapcs3S3CBDLyoANg4NG0ZmEb1Ayh5qHAJq9bs8xpqJmIH7XVFL
 oHrjtEShkEDDjL21nANa9vQoP7xczhaqgVvegMFnphq4FRSoMKftuEb
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:194::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a816271-624b-48ed-6e09-08dc1b1180e0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rs2HSsXjnE1TU9XtmStwNgJRd2Dq78P8xnQ4Hovs8Cftzg7/zRbBRZZuVu1vP/GlXmJU2OKZgvqb7TG45wePRUPuZeYHwVUtowNvtnfCN/hhciSCcHp/Esm47tGGXDL8qdrF4L56WX+IWOtksO/59f+UtBiHaVhXJelbwOHm8jjx6m74AmCUG6uQpHvJrF/Wz6yru6cK9YDV+iIPfhSt2HZPB+D61L8UznAbNm7CKuWqvt5JesOMnkEvLW2v6yrzr6hvwIhkC182vAOfc585+ME0DaoHMZcdpfXZg5ZE96WsaYeyTY4drKtXLKc2oN6hD6r2iHeieB7BsCGspCqgzkFF7vFueYA3N8/f96JwQp2cTwzG0OLA1kcYY0js8w2qpODc4llAwDfW1cMiTBtBFmV+MgFYVyBShWZAhJ1JVDl4EfxkyfoDmsGZJWu6HYApmF6jj2mnBY9CnG5uuwBh50vFIk92ccAi0xWiA488veGSMrfog6P1zvOe1AEHk8rUeLy6lix4PjMkL+2lh4c6+Zf4ICHD4vuMlKFURIAXwET4vXBrQA2dKEd+fJ7pkzoScVfSalCG/5+OASUJOktrRhkEUiCAUKPN/9EcNu7WaA6bLrp5bG4FYIvKo3P/CAs2vTMWHzmH7RHATTxtV2O/5A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6666004)(6512007)(6506007)(15650500001)(5660300002)(66556008)(66476007)(66946007)(52116002)(38100700002)(8676002)(8936002)(9686003)(4326008)(2906002)(7416002)(6486002)(316002)(110136005)(478600001)(26005)(83380400001)(921011)(86362001)(41300700001)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1M0TzZ1dGZJeVZIL1RoYlF1cEtUT0J6KzQvTDhZdjRaVkh6RHFxODNIRlZv?=
 =?utf-8?B?NkNKRU5GQzlSZFRrMnlJdWljN1ZRbWJwT3pwNVVWOEVWY0haellQOFlNd29r?=
 =?utf-8?B?MEY3eit5UUhyUVNDejRtb1BpVWFrTVgzejlwVit0N1Bob3Y3eTE0emcrOUhW?=
 =?utf-8?B?Z1ZSMUhvd3pGcG9IYkpTOHEvTlA2UG1KeU05R2JCaHdmK3NDWFZmT0ppRC9q?=
 =?utf-8?B?NkFNcUFwZGJaRExzVitCZnQyV04ydzdGN3g4ODVBVUc5bGFNb3hOQ1lJZEZQ?=
 =?utf-8?B?VXJHUkZzUTVodW5qN2ZadzBkQkowTEVIcjNaVkdSYXlDbEtTNEo5SVlHYk94?=
 =?utf-8?B?M2pvb21tdXVLbmJ5QjE3M1dWTC94UjhJY20yRzNxZ05lWG5qekdVOHpsSUIy?=
 =?utf-8?B?UGExT21vaUxLZ1ZYVzZjRXFIR3ZZNDJtbXAwUWsxVjJFaU1OMzYyaU4vc3k3?=
 =?utf-8?B?OVZVTmhzbkpVT0Y2SE1LdDdJdWpCWVNjUlV0MzN3TnVpaHRUQ1JXZmQ4U3Fz?=
 =?utf-8?B?VC9Sa0ZFWHF1U1VoR1Y4M09wTVRwd3BIaStwVGV1Q08yUnNhNmw4T20vVU1h?=
 =?utf-8?B?TUh5c0NUNDhkSisvM0hrM1Y0NGtnQXhjaUo3TG4wVmNRTHYvb0FxZ3k5RVEy?=
 =?utf-8?B?Y1BWSzE4c1czQy94c2g3Sm1YVXFoQm5BRG1lOWQwcDFvYnIxZ3luR0lYdkRS?=
 =?utf-8?B?RUFHWUpmODg4NmNyQUlrRjh5RjdSMVJ3aWdsdis5b1lmeEtGNjltcFI2bDBw?=
 =?utf-8?B?VVY2blJuZDlXTWdXS1c0dGZZTGxLNWZiTDB6RSs0OWtub2FTR3BZbWNRMDE4?=
 =?utf-8?B?ektyaUlPSWV3Y3RSZkZEcUdOMEtjUEd2ZnhUNm42anpPNkhyVGc1WFRXRXh3?=
 =?utf-8?B?VTAzeHdqNG84d1VBaWZ0WXhuai9YZlBnck5Ta1JmcFMycDZtOXpueG5RODBS?=
 =?utf-8?B?VHhDOVVjQ2hQOW13T0ppelRad01BSmNJNlVYNS9KT0xPVGg1a1JuSENETWlU?=
 =?utf-8?B?V2xwR0ljT0tpTEZCL1YyMW8xSmFBRkprU3JpNkNyY3ZuSzNMWlljZHZMQTBz?=
 =?utf-8?B?dlVWNVp0WHFwTWczSmN1NFVxL012b010N3BKRGVWb2xLMk9xRlRKVGZaT0hI?=
 =?utf-8?B?R0ZvZTRINEdXWGRaL3NZaU9iamZ2Mzc2NUxUSVFFM3E2MWZ4Q0JaRE1Jdlc4?=
 =?utf-8?B?VFVXQjRJWEtmS29zZ0lScUNnNDVTemxpLzJnVWlYd0pzVVlSVEgrMmtrYS9l?=
 =?utf-8?B?MUhZdzVVUjFXcUIyTEY3MjRzdEFhVTZOZnhZeS9FVWZQY0c0RGo1R2c0WlRO?=
 =?utf-8?B?T3NoZTR2d1ZhdjVPejIyMEMvNkphRER2aU92U2REN2lybWkzY0tkN1ZIdllF?=
 =?utf-8?B?aUZqaGxKRTUvUDdqWU5yNERWSjN5OURNM2pHR0R2akFGZ04xSFpMYnhWSDF3?=
 =?utf-8?B?Y0V5QVR1cWdYMHp2OUg0OE9nWWlzWHFoN2Q3dWNUNHdLSUNPRDhzYVpVeXV3?=
 =?utf-8?B?K0VnTE51QXIwMDZzMVdhQklJcjExZEs2SXNhNWM4M09MaGsrMEYzb1p0U084?=
 =?utf-8?B?OUwxZ21tUEc4aTRBL290OUJCeWxQYWRDeU9DUElvM1lwN1Fzc1dzZ1Z0aWZa?=
 =?utf-8?B?aHNITFV0bnBTODhZSFNIQm1JSitncFFURy9PUVNXVkdSRm0wc3VENlV2cmll?=
 =?utf-8?B?N1NFcUhmZkFvV3dLaEJHVDN4elRyMis0cms4L0RKOEx5UzZsV1NOWldiZkV6?=
 =?utf-8?B?QnNYQjN2Y1lNQUcvN3ZBZU0zNlRkRGZZV0ZlZGpSTzRlRUxZdjlpL0JpZWMy?=
 =?utf-8?B?U21jMG9CTnVUUXlzQW5acnhueDdjRi9BR20xVGM5R25FQy83aVIzOVNsdmI2?=
 =?utf-8?B?K0E5VytwQ29pSHFKN1V5VGJHQ3VFbDRQSFVtdkp5T1dFNjF0U1F0cjFPVkh2?=
 =?utf-8?B?NlFlZ2Z3OTluQVlpL2tCSCtOc09VQmtpbERvaERmNXQ2VzFoSzd0WW5yeitu?=
 =?utf-8?B?WmpNTWx5c051MW03MzgwanBkR0M5bVdvSjZSY0NnaFNhQ3lHRllQOXBlc0NU?=
 =?utf-8?B?R0x5aUhYYkluMy9CY01TaVZDUFRaSW9RSk9GUnNnZ1ppVmFLbFh6TzRyL0ZC?=
 =?utf-8?Q?CZUUldXQF/gAQygaCg2Ig/H7R?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a816271-624b-48ed-6e09-08dc1b1180e0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 06:15:17.1581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /M4NLGZhUJQmpp87H8Yq32zV6p+SwTWgXlYpeUrXO9Xnp0UfGLBGTuhPbr1eV2K0d2Pl8ZpE+yQ2dEoF/1VuDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7991

From: Peng Fan <peng.fan@nxp.com>

Add i.MX95 ELE/V2X MU support, its register layout is same as
i.MX8ULP, but the Parameter registers would show different
TR/RR. Since the driver already supports get TR/RR from Parameter
registers, not hardcoding the number, this patch just add
the compatible entry to reuse i.MX8ULP S4 cfg data.

To use the internal SRAM, need populate its sub-nodes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index f2a21baded29..8506f92c0238 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -15,6 +15,7 @@
 #include <linux/mailbox_controller.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/suspend.h>
@@ -907,6 +908,8 @@ static int imx_mu_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	of_platform_populate(dev->of_node, NULL, NULL, dev);
+
 	pm_runtime_enable(dev);
 
 	ret = pm_runtime_resume_and_get(dev);
@@ -1018,6 +1021,8 @@ static const struct of_device_id imx_mu_dt_ids[] = {
 	{ .compatible = "fsl,imx8ulp-mu", .data = &imx_mu_cfg_imx8ulp },
 	{ .compatible = "fsl,imx8ulp-mu-s4", .data = &imx_mu_cfg_imx8ulp_s4 },
 	{ .compatible = "fsl,imx93-mu-s4", .data = &imx_mu_cfg_imx93_s4 },
+	{ .compatible = "fsl,imx95-mu-ele", .data = &imx_mu_cfg_imx8ulp_s4 },
+	{ .compatible = "fsl,imx95-mu-v2x", .data = &imx_mu_cfg_imx8ulp_s4 },
 	{ .compatible = "fsl,imx8-mu-scu", .data = &imx_mu_cfg_imx8_scu },
 	{ .compatible = "fsl,imx8-mu-seco", .data = &imx_mu_cfg_imx8_seco },
 	{ },

-- 
2.37.1


