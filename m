Return-Path: <linux-kernel+bounces-103948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FD887C6E6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 02:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A92EF28219C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 01:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5606517E9;
	Fri, 15 Mar 2024 01:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WoZ37Of/"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2063.outbound.protection.outlook.com [40.107.20.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F0C613D;
	Fri, 15 Mar 2024 01:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710464538; cv=fail; b=WomGqI9vaXIjDU2qfFdU+qSlUGlhbi8NO1QhjEV1MXblZtnw3JO+SLHuUJy1TwjfaHytHgsqsz7buwJP5qp90pVMC894jl5GfVUQVKjFaboETsqadYUNtudBoRMn00PcpGvQbFP8ufQzQKq+ZmvsKgF8qA9q1H555rqnsLTiuSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710464538; c=relaxed/simple;
	bh=uSacvYHOYMGghF8wKHUB8QZILXrKkMd+o/GOxf4uLkM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=gAgkKNtCwvrLzxl/8B9JbiT94nJc/aXdwIVhpdxnDMK1fTTIxJcr8wE9kib13eFjhE31pfz5EoKjwfxHVcS9H4Uv1OV98Of/irj3WbgBTRlQemRxxfcEeKyH1ZXHfIe/4weMhL/OiWmjFipHC/040wdEcy9Hi6sKoAQEoOn4FN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=WoZ37Of/; arc=fail smtp.client-ip=40.107.20.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGaW/orPzzzomHg4unLmLslW76PNKkkq/xBPgXMmvB7VYFyS9Yx89iw0kxcF/SI3xlh9kLucRzjKFAySLRNyg3+y5KVsv8xYGaT6fhqaJSjCUA9ehYv4t4uPp0rFNDveczMENNLawC4HwQC3CwcJilVTwDxtvOA6C/UYIgoGq8V2WiWUICVELuhuaWg53ocia3ukfu3djX0sF+vCpv9bF6YBG1tfZYm9NQnkaXw69n2d937S0IRXuyJoYfKudBbbaTmBdK+VAxUoWJbZWD93b2RcfS0xaQ0kjrO7gAinsY7gmvKOPmlLsjKRBp1OWEHh/h2NxY+ZtsuSdKNcLKZu6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMxITTROFr7pcFnbdky1mAqE1r4IrTs0UNzC9IsD+nc=;
 b=ZT/YN0N+Ism7emx+lCp6u3ZZM2uOJpJLgASU6C4NaireHnS3TG3gRph6HcokUVAmLZOI0o5mQ1XbCgBViS0pHaP80n2FbnsBkb9eTjEGQpOpkb+78c7mLQa3fkZrsHybck5mSrvwlLK7Jh52kBQnbVv9rwvvX72QChjEFDf0ECaKiY68HgQ7AtrF/DEYtiQAzTDZenS87pIGcDCY3UVGlU2FCwqTVoR5G2XxAdhbTo+VS0eAC4o4fLuc2f238SaCiGKs9lbA9ztqE4m31KuJsD4a0w8GPcA6xFAMLOtEzIKnaTDQMekGY6hIM5HFDA06eBnmJKTSzPtexPr5Eolfag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMxITTROFr7pcFnbdky1mAqE1r4IrTs0UNzC9IsD+nc=;
 b=WoZ37Of/h3GvGvlMmlo/P3JfeiaHrmLPgWS5gWBYK1R3AubaJhjpUEgnJRyk/8XoeGqoZ0UTzm1pvtRE7hueIastFJchNfXipwLXSznVcAVpLnzjjIYPIKvBjDFvDwmBeeaIjGwsmTll290W2rvU82r+xeD203wsCxevw20DNUM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7864.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Fri, 15 Mar
 2024 01:02:13 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 01:02:13 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: linus.walleij@linaro.org,
	brgl@bgdev.pl,
	andy@kernel.org
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] gpiolib: use dev_err when gpiod_configure_flags failed
Date: Fri, 15 Mar 2024 09:10:15 +0800
Message-Id: <20240315011015.3106272-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:196::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: 34e5e75e-841e-4bd6-8ac2-08dc448b8ca5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7WfnHcrAmLMYtSaAH0xZq8xDvywJH7bw++EwxZSd/LDQLOp1q0UFvzrD1IFHqPl7PnEwCp97a/XVVhuqzslqcKdt/fpLFPvvF+hCbNE5GECFE+wU16LDhviv6DkIoWMjRahwiYWW1wC4+NG+2VayPRNhLF4Y8Pq6BhBque6Vqrft3GaKXqxPHkhZAh4AIVu+vU+NntbyUc6mQY65fZbwuZOlmF1YwS+MAX8Pydw3LoFwqlHi0GcMaXCpwUnmAOomGLx7/FmML5hmPfqMIWSOnKznYGOrZr5NfAodtpYZFgV3vWYIZOZ41HADb3rsH0KE0JxJpm3QRdVCRze7xVj8Eu7xCX4VmdTUEn4B5nE7VA3AM5HFkSbTKEl6Ivkh6kSFcC+GC6GpUiI+ReMzyEq4Cg3iH8vIMxW4qCdHGjGYcZ9Hhpvl4EurpqM39G44sGQC1cEWb7AFyaebOtXD66cpWE2qBqfFjYRzFbCx62KRNLVJE7ySz22EuDdfEPJLTZa/0zz2QJUR39jJ617o8jDgABL4mkWDd3GuAN7a4FS393fLlDjIVh9EQsUDd9z2UXiM38HX8DL1mZHEYI/xdEZx64tTrDMNagvMBie0Ph0g3dcvaVu0RBHVwhdckBMG78+XeRI2xKaMXb6aj5i+XWM3tKgcWUqxTbD1WaI26xfZVF3N2RAB9je48P2eG6AM4gh7hRJ744jwe9OC9Ts+o5SC/mIlSFgO6jqcoTIusHdunPo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YQO0mnT4fbcMS2jeFmTFA4a2r58qH7bA1XxXOxLuCiY9PdMrZ5Y3FGHjKQ9S?=
 =?us-ascii?Q?QbQ0CaIENbL8UNjYZZHd3jOINYB0YENsJc5u2usHJ53hwltPGhXeV9DzX5Ka?=
 =?us-ascii?Q?1IQlhSiN5J/ZuqwCiN8Xj07YVQ42jMTAu3C/+n8gftfC4+KqOsNoGKZUN3rq?=
 =?us-ascii?Q?j5Styz9E0u6X6w0Q5Rp1m6I2Yeo2BJq7FQr3S5kDakwzUVfy3aK3ZrYScFbv?=
 =?us-ascii?Q?dDwLv/LKdkGkHdOpPCiUrzJH6UsvoLFFJtIjdUOhq7E0CV8pFjmTYaeXvqFe?=
 =?us-ascii?Q?+/hH/cPS7djzER/P3jAJSA7HKTg2AL8W6Y7yNPkHsfWcaIP7CkSZNwk/797y?=
 =?us-ascii?Q?TpW+aSgUUql4JSp9yPqdlnvNpc1bt+E8qxJnsYUT6m4eCzxogN9v8txqYdK4?=
 =?us-ascii?Q?K9yTEiJW83nsJg5lHmMqBz102IwTuGEj15UO/YM13+PB+4EariLmDrLIPIWA?=
 =?us-ascii?Q?NnmKvIwetDl8HZd7KAEbjviDF1RK33230Db4VChh93LBy+b7KhDfHzowHnsE?=
 =?us-ascii?Q?o+6RX5SrRgKTGNxTZraSBRzIKGufk/4tq1ysHlXdySAbvWCuPUgahKlSwc3C?=
 =?us-ascii?Q?PTVnR48/iFGeEbMVrldH5p1ydU5XUAjQNkeHCVZkGo/2rAS6HlwgfwdkupC/?=
 =?us-ascii?Q?MXzGDW/dQ/HTxDAAlH1y71xU51x85wJJj0kiwGgWDyy/hynI55kdFJ3hVVzl?=
 =?us-ascii?Q?umT7VOccs2siNzRW8vHw0mJGm3MsnKejbHIS5W6l5VGMbEF96LydF03n0qNp?=
 =?us-ascii?Q?IO9EVoPswKkcvFozvKvPDE2ftKlFjOcJvhOqMI97YcSZTkYFQeRD7RhJl7Xv?=
 =?us-ascii?Q?c9iBO6cIoPVoiyQn5wk6VGQlyfrGtCj+zQjjopm1qe55veBkXEtRtnQvPle2?=
 =?us-ascii?Q?fEc132ePn/FmCZMAWvHUZxTNhXoSL5z3DQ85P1677jwFiYUGF0TXDGD7O8tS?=
 =?us-ascii?Q?FiZIIRwIlMxyfAwNpjqx+QQpMYiDy8lWcqUhN/2YKBJggpUu/wf8fuQMWi6x?=
 =?us-ascii?Q?hstfJjvWDnpSLFFxcKB3Ay3Oh3BpRYUGeSefUHgrvH2DJOoTx5SQwRsQ/qLJ?=
 =?us-ascii?Q?+h5z1rOvHw0dX+jJSpWzA1bxERpafEv1uCmxfz5Z7oA+WJ66yyR3aBTUb0cT?=
 =?us-ascii?Q?HuyEQnfMiPstFhFGvlY1n7jh+6+2t8SbXPEU+6NkB9EQ5I9dM8O5IHqbUrrb?=
 =?us-ascii?Q?Q5dc99O08O3Z4b/Gc5YzAz1r6hh3x/jtjUSRlkFq/S9pBKxe15GTF1H0AWuK?=
 =?us-ascii?Q?z9mQvwlw2DTiNprTwYwbTscsE4sAjH7lgvdIRHPEpkq0FZxvEEQHbzf5TxNQ?=
 =?us-ascii?Q?MX4/Ru/sMXOWVQDrXXHglAReeaogrwtDZsN6vJllCgMj+UVVrbqQe6l4Ia2R?=
 =?us-ascii?Q?YLhi2oGcquxMs84EoPYs758oa1p/wpubk4R9ienr02bcqFyD/p0rxxea/ycp?=
 =?us-ascii?Q?/jiyrIyLpHjccfadMFgVpXVUv6pnjCRj8E1aP9g9ngIRzVrT6BYTTgHmI/b7?=
 =?us-ascii?Q?CfJjzf6wTZpmBj5A7WkRRgfPQqsLbClgB3VbANE+VYlIY3zhu2HxMvbZRpfi?=
 =?us-ascii?Q?00X5KRXiC0jsnI6uJpt5Kzyi9IL+KcxRllCv+DC3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e5e75e-841e-4bd6-8ac2-08dc448b8ca5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 01:02:13.5162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iuEeQF3Aks2tFMdl6rD1ChjDhTZJ1QtNo/TpigswwibBYUmZXB/Ttp1Vffv5vnR3lKzFP2WYI1J6vhZcxe+hVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7864

From: Peng Fan <peng.fan@nxp.com>

Using dev_err to show error message will make life easier.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/gpio/gpiolib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index ce94e37bcbee..37fe9db0bd74 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4233,7 +4233,7 @@ struct gpio_desc *gpiod_find_and_request(struct device *consumer,
 
 	ret = gpiod_configure_flags(desc, con_id, lookupflags, flags);
 	if (ret < 0) {
-		dev_dbg(consumer, "setup of GPIO %s failed\n", con_id);
+		dev_err(consumer, "setup of GPIO %s failed: %d\n", con_id, ret);
 		gpiod_put(desc);
 		return ERR_PTR(ret);
 	}
-- 
2.37.1


