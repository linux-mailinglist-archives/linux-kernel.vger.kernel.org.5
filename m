Return-Path: <linux-kernel+bounces-70236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F30B85951B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 07:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 546C31C2114C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 06:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2ECB168C6;
	Sun, 18 Feb 2024 06:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DAZD/k2T"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2067.outbound.protection.outlook.com [40.107.21.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1944D14AAA;
	Sun, 18 Feb 2024 06:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708238904; cv=fail; b=IafpTk1oJSw8dJ1xSLw2bukj4GdfAMiiIPzDVbzy5JJtzjB1Fqw0ELqLlybZ2i70spIA6q0yeZfeSofww2h3rVrDETXXc8c+8/Pj1ygqcQlCnTNH+ZGtHyzNwP/+I4rB1+O2cpLi+U07hA38YEyVe57Fdqv6YhKC+uaj6hcIxY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708238904; c=relaxed/simple;
	bh=1IuCGX8DwpQumIvWq/FcKiT25GcB/QBynq2IqKsv8UA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=HLQ1JysHIP3DzDiYvmudWUUyt8qsvhTKvH06ItI52k1ShgLQGAOcr4XOtTxG4AgdP9U0Z4C+I25IWcGNse7oRilN4ybj/32IMROl1IAb1wpmBwtQYJhhXVdl79SzWyzWVb01U0pqa0TlYMRy2cy6qckjeLq2Mg5TAGeXSryw/tA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=DAZD/k2T; arc=fail smtp.client-ip=40.107.21.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqrEsY9V9kmDL4UT/09ymYtpESUW+zdJAszcaufPQaaLJjqLOHExfMlTrVCNOsYxuYbwqmXW2YVMdfiKSjJA2o4NUviSuUd1p6yV/+WtuJBGVIF3c8wDQajlshXUZf0aP4Be4flXnLrAgqg4g9fpwO0jBj0ytkE8zk5VhmVBE/eC/ylFtw2tLqCloX3cCNd7Nm0KExUyFjI/OqvpD+96IcCjBMR7+e/cqmh8XyzYLhsQf4I8K/Bjv13zdvmnVKslxTS7FJCa7Eq0J0rl+Sd0wSLBw5Vtj844ybqLE1VD1t9qhqXhVnKAv0UMKkIh3/7bjzRLkg4WgzdQcSHAE6vy5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWArvz7J90WanI8GX1iUCYhXTMJeIk/4bgfoMfW89NQ=;
 b=hFt2HIMn8R14uZTwfBFqeuBrd89KtsUGjJrTNfXu1n2HZyVVrJ3JBdX4pGKD9zmPbtmboPtjAd5egNH87QSn9FmWBmPb0W5+sUxHD6APbnIj2gUsTo48HzVEQNGkERYmpB8HilQmWwLvEFqVsSQ0Tl+UhNkr17IP5QSRksOZ/gWyWNx6f0kpbGRSs0dAMUGwhCgAA4sqeTqjh0JG3uLohfvwTiPh8gfJzUcfmWRgYLd1P0IWc//QYX6Q7TVPZQSxDvy5nkE7GWJLmeBqi+rkMmcWni+OtQ1isn0FACPcyIgmfNzHyQVQq6lkjPRLcOaAF3cLtMgNaJiyzwN42Ybfbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWArvz7J90WanI8GX1iUCYhXTMJeIk/4bgfoMfW89NQ=;
 b=DAZD/k2TGfLVcytJC6ABMxyHOewsGtSd/revTSPzaNX+CSJVr23K1/+qjOcbiYCLAEtmUpVKiV1kgsbhwTqn0Hel4HGKiagv+R9EoJ+yKpnzBx3PxUyLa5Uyej6wbdQ1HryBj8fmZEJvgyuRaaaGk4VZqtUddOhrZJEVDQiQbvE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB8011.eurprd04.prod.outlook.com (2603:10a6:10:1ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Sun, 18 Feb
 2024 06:48:20 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1%4]) with mapi id 15.20.7292.033; Sun, 18 Feb 2024
 06:48:20 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 18 Feb 2024 14:56:16 +0800
Subject: [PATCH v7 4/6] tt
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240218-imx-mailbox-v7-4-8fb665eeae40@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708239387; l=537;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=jR+NVcux9cCBu+JtZYj6Wcg3vDYavvf8KPYnrh9G/ZQ=;
 b=XHux1iLuTVvM24zz05nbtqaEX5p+r21k9i116UmQaPQNbwVGPuadkU2S1fubv78LtpImOLa3/
 vEzg7IY74F3BNuEdWUmFabJKom9p+QhjEF3HYppbzyMu9ozRjepK7CC
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
X-MS-Office365-Filtering-Correlation-Id: 9b169c87-a6fa-47df-017e-08dc304d97fb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pXVVrGXFiCt+4Di0PJCk6AlTX2LrrLWoNKg4Lq93BZBNJKpEuwCaUaK966sLPn71t3+UP9xaEsvDDHTri+KpOvczb9Rh4yc3ou5QCTOXTMmLxJ0HveO3TdvVHj5RBkmkangtYbVc+cIvH07E/ezc7t1hlDDS7U4DtpCqrOwWPh+oKOWYOiq9o1jWtJNGZB4XQS9dQy5Har1HoN6fmbq2XhGo6mpMHEv9IFQZaOBscdLv/4glYfuucVtffIuxvmA5cSGM46TnhjtNij9tR7XRfVmh/ht1Xo/gGaO0GCdqIIcNW5LdTTkQxISZ11owqH/ig/RH7KPJSzWlIRHGpSRTIdg+7C6hH5kEzh+p8/jcWRqJhamipLLxi+M+ff6vwvU1dAONbaSvR6w7pDgybiWrHD4wfb15/WiVOXxq5gD5BydakQStcG3n532aTUHLH0rtvGVLgoH6v5HH3PXINUAV/Gn3yIRkyKs2er+pV+2Vp/Cj5XArH6249pds/q78+aQtK0S5jmMRZi1PNJuV3N86bWZLh+e2lg4wkAcxZ63ftzGMSs4oyOKdPoEw+i4uATtZbRqr3Z2ImuxtDAOQxbGnf06K7BDZoaUwXXx5xoKqc6MbY6p0MoPv8OeFnuHnX/6OkR5JrMcLpEpo7WlS8515WA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(5660300002)(4744005)(66946007)(4326008)(2906002)(8936002)(7416002)(8676002)(66476007)(66556008)(86362001)(36756003)(921011)(38350700005)(478600001)(83380400001)(110136005)(9686003)(6666004)(6512007)(41300700001)(316002)(6506007)(26005)(52116002)(6486002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFNLZWZMTjFualllR1RxWWNXTWkxamJ2emJGVHNkTzY5MmFqVDZuS2thUDZp?=
 =?utf-8?B?b1RKcVZZQkdRVGN4bVhmeVlHTkVWaGxyVG5WSy9zaUZtNXlVVXlVSm14NTBh?=
 =?utf-8?B?S3Q1ZWMxaUFRMitCWktoOXpTR0s0WVpaMjdnSDR0ZEVJQWxxbE1UdUFEaENz?=
 =?utf-8?B?dzBMZXBrMlFXTTVMODFKR2lSQ1Q2ZUhDME1SNGFBRzR5OGQ5MmRKN3g3T3BD?=
 =?utf-8?B?RjR4eXRRcVVuOTNPK3NJUkZVdy9GVVFKbzFCR1g3QXVKZ2FvektNVGg5cUs3?=
 =?utf-8?B?enB1RnVGbkpjaTkzcG82ZlBpTDU0U2RkOWYwTDErWHNkM3lWV2xVbWdUODBJ?=
 =?utf-8?B?MmNiSXNRcllFVUVQc1Ewekt2SDZYZ0NyaFVpek9xVTY4OUh5bHVweFVBUlJO?=
 =?utf-8?B?ZGdleXFGY01kSi85akpZTUpYSHJqMXFYWEVzenljMGdaaWRIWXlpUXVUbjdB?=
 =?utf-8?B?R1NEOVBaVVlsOHdYdUxkeW1qMDlmUG5iZzdOV0ROYS9tZXRWaXVSOFVZbWZk?=
 =?utf-8?B?TDV1L2NUWE0xMnZmNWVNRy9xSTVEcS9HcW1BeXpnTHdMdGY2VEh3Q2swbDh4?=
 =?utf-8?B?K0FiLzdrL2t2Njg5cEVaOHdOMEw0dXNFaExRTUNQVE1lOXZqemhEWGJ1S0xF?=
 =?utf-8?B?dm9vVDNKY1VyWlliTTl3RU10MlFJdzhrWWFJQ2E2dTdWdTdLYnBVWndIQUd0?=
 =?utf-8?B?U3V1OUk1WmdnRnpvZEMzUE84UmdyL3dZZ1pxcVR6Rlo4NHZ6UytUdUtzK0Z0?=
 =?utf-8?B?dnFOMWhYNU5BTllHQVJCSjBmOHZhMHhpTTNwZ3NkQjh4dlNTU1A0eEM3VEtx?=
 =?utf-8?B?dzE2ZngxRUFaQkx1ZEM3YmxpUmZPSVFMZDRXVXpzT09EOHgrQUZsZEV3d3VO?=
 =?utf-8?B?SG5YWkhLc1FBZnhDcXc2T2tpOGZQbGhNR09YUHEvRndNNWhoZWRTY0hISzZy?=
 =?utf-8?B?N1RPNUZnbmFiRjRybU05YnBJOXp1d1Z4UStpaDZiR3dIeVB1QVd1a0ROK0Rv?=
 =?utf-8?B?ajNuMzM4MEx5Zmc0SjJnNXFwU3o0eGpaN2RFeEpxb2hvMzBQZHpOQkFBR2Rx?=
 =?utf-8?B?RXlOdlVOMmpQRlRzeW02R0pUaEQ0M3RLZUlyVjhpaG1FY0g2MXhaU2RJV2hD?=
 =?utf-8?B?UDNGZHFTOEdqMGphQWNLSTZWc0dkV0VlNWcxU0dScVh6Y0pYaUIzSmNkd2hS?=
 =?utf-8?B?bXFYcSt3WWtUTCtGQzcvdDFwZXROSjZpc0JuM0ZsVCttZWRpdjhEQmIwZ3lt?=
 =?utf-8?B?dC9UMG5tU1lpUEs1NWdyREdzRGJSQW5iYlR4dENTYURRalZidTFBaS91Z2xV?=
 =?utf-8?B?dHZqVG9NQmdjY1VELzZCOWZ4UDA3ZDFDL3V5OUZzTzJ5R1pyamRDNXNqQXZp?=
 =?utf-8?B?dU1nekxZalQ5RE5odFVpTzRCZUtrZXlHZU9TT2h3VzFpRmVkVGdqazhBVXhW?=
 =?utf-8?B?L2VsL3dReGxrWEZHeG9rbDFrc2I2UUlKTTZZa2Z5dEVNNjY2QUQ3bnJzK0FM?=
 =?utf-8?B?SVVLazBXZWpzY0VSV1IrQzgvNE1wSEwxZkRVN0t6dVFlQzVsdVZOcDUwV3JI?=
 =?utf-8?B?dVI5Q3o5bGpSR0xkZnB1ejAwYlE1S2p0UU1XTVlUcStuOWU5enlOUklXRUli?=
 =?utf-8?B?WmtFVk02d1VIdHNMTXlIaCtpdDZ4VFVITnI2dU9jTFg3VHV6ZTVWQjRuRlIx?=
 =?utf-8?B?R3A0OGpwODU5ZzROUUxlVkJ2RVJqSzhQZVIvVmtQcS9NTDZ2cVFYWmtzVVRV?=
 =?utf-8?B?WnZTWVdNZHV6aVNKZkovaWZ5WE52WXNGWm9vdzN5b09uR3lCMDVZanVjaWQ0?=
 =?utf-8?B?NEVFUDk3YzVBem8yY0NPZjJxeDBHN2MxTTg0cE11WEpxNEc1N1oxVFl1bi9B?=
 =?utf-8?B?cG5mNHhGQklvTHZhUHVHdWswU0J3RmN6cTBSL0luTkV3MmllUm84REkxQnIx?=
 =?utf-8?B?NWtVbUJTdEl2V3dzbjBmeTE1elZ3d0VGN2xLS2VJVWtrM1JYTEEzK0NGK1Mv?=
 =?utf-8?B?N3Ywb1BBNXFFQmFyWG9JS25COVIwTGhpRlBjNjlNdXhFbUVuZkM2TmptejhS?=
 =?utf-8?B?N0hOelFXNWd0UXovZlBxaFdub2lRbjhJelZ6M1UrUThnY1BRdWF0NWFqczBq?=
 =?utf-8?Q?ttDdX7tVwYqZuIFSaBuCim4c9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b169c87-a6fa-47df-017e-08dc304d97fb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 06:48:20.0983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lhL9CjLMeoJbU1app1lewy0HkQKkRdHPWPrb3vmnVPCxaDWuqd4CZ8oR8Wcnd0HBK8mjzpAIWIrcvWPbG2rt2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8011

From: Peng Fan <peng.fan@nxp.com>

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 9e89f773d2f9..306af1880415 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -4,6 +4,7 @@
  * Copyright 2022 NXP, Peng Fan <peng.fan@nxp.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/firmware/imx/ipc.h>
 #include <linux/firmware/imx/s4.h>

-- 
2.37.1


