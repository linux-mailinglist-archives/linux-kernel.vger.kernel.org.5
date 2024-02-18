Return-Path: <linux-kernel+bounces-70237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AED85951D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 07:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DE162836D1
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 06:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F07168BE;
	Sun, 18 Feb 2024 06:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="O4W3dGKZ"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B802F182D5;
	Sun, 18 Feb 2024 06:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708238909; cv=fail; b=gjUN3NcLR0T2lN0MRWLBiZSb2si9VCHYkMeRvgVMnFdQiUbt+VEv7zqSjsYq2HKFr3SddrI57u8LxFv1MgDnTPcedDW1UuNQgy0Md1HR6rwktKY/Pw4L1GVl31ci/3j99QtaL7khiZNGkDddKqTlWVBochfmbmmqLyKGp0MmFFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708238909; c=relaxed/simple;
	bh=pCeU+bTczyOqJg3nKPKJLkhMrLDlmg/Bi3NzPuoI1JQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=DCO7FbLt6DMd4SG6PEHy70b2H1DA9YANyb8Y5v+FJSD5ZjM+edIRXsih8rK0pX9+AxxmvWqXxTT86xiGLw6KIYhxVwaXxMwIy4ETEzu6WU5PVLuHGz/rSieX+AD+6tVftqaTz/c2USHNfD97XC/hgsvisZL/consPjr8Ys226u8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=O4W3dGKZ; arc=fail smtp.client-ip=40.107.21.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9gLlvj3eOtyd2vUPooSHvfafgChzfdA+8l93xog2bhTrSXQCSt0UG/nBJGw1nOBGBbpkF+5+3lIKoOZJuVoNll0yltkbcvFyPNR8jZcAYafv1SEB4tfTvVJsSFfqrdVn/eC/oqwEU98L7nQm0E3bFW0flJ1y3M1U5OxxaR44aQ5CEi7xUT10SfMcOvpxuvJ4ER/W7HLZ8+zKPMK/MMUbA4PlJ+nqrB792fNTQhEBptAfr5gPG0NPctOQ0kKCZlWlHKU2+IgZvl6nDUNsf386a+vmvOZrfEOy2msQ55+tCo02nAdDrKUt6rHkYk5jac/uY0EcFZilJ3Bj/saclQYDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvkBaNHIUgjGJ5yym/tBqi+SD6g5RuSBpWRmGGNYSaI=;
 b=V2iYj46auiB4fGFvh1BfQ+Qfz2GCsHmSG9It2/TybfpuxLWtk8f/g8udmzibLhKDvz3uYgYBz7sNB+pPUHws5OFWSih3QvrFJOSPmIcdR+oAtwnCFGNm8zi9SZnsFftqAbJViFOQEYcsYsGOt7pCXQVs843hiIM3rOw4r3nMfacxOget4N4K6dy8UNca0Yb3ExSQqMsHDh36rHmsRXgWj/cDA7RteAX+OcuUkWkoRMCfLvT1dhh/6a55MxyZLDtyij+7kuUW4xKmjgXd9cnjnKOE6d2hdZ5JqTU8ZcbOJajzpFkrprL9A3KcfdHah8rPJLsWP+j7DwTxzLwdXnT2kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvkBaNHIUgjGJ5yym/tBqi+SD6g5RuSBpWRmGGNYSaI=;
 b=O4W3dGKZ7MwFlL0oTCKP/VKLmhvh2ut9SU4l/ysY+gemXAXEXygs47oIkb4dmoKrP+post46EauJsvdDcOEs+lp3OhjzFWuMdoYwvy3c+ixBZTcN3SFsZP0WiUcJalX2hsM284rWkhLbexHixyxLinDO9IsRUUTFeXt2rBlqqi4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB8011.eurprd04.prod.outlook.com (2603:10a6:10:1ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Sun, 18 Feb
 2024 06:48:24 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1%4]) with mapi id 15.20.7292.033; Sun, 18 Feb 2024
 06:48:24 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 18 Feb 2024 14:56:17 +0800
Subject: [PATCH v7 5/6] mailbox: imx: populate sub-nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240218-imx-mailbox-v7-5-8fb665eeae40@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708239387; l=953;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=zmP601mImThDTxLev7/0znMw6wmWmFmrzE1cC9FHOTg=;
 b=fNOiY7ZKTAWVoPXxgE7iseOdYLiBYjTRWVLHmI7BcBYZx0357dHVF3zX9NNgfLMH8Zmoy6Asv
 mAZlHN1FNOTDFP0RKNUXRvCCRNonCbH7bAf0pgZ2tauqjVCMACvO+t1
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
X-MS-Office365-Filtering-Correlation-Id: e37ad53b-15dc-4d4e-5f8a-08dc304d9a81
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CU9JUqfP857SPivk83HUXhcu6tdguvtgn9X/BwWkyRHhO0p1mHYS6fSmiPXgnoGuXq2ynteToglbZdX30ZUBp8LMrAvx72Tn4fQpQqGPk7FBcNEzigOTBg3BkDN/alY7R+2iWDr21pVfilJ7cMg9QDF1Hghgb8MzwgO63jSQBsg5jGLRazOcmCzx2RorcBD2+fIgonxDWeTWRHLHaX7Umzy4czfqKPtlRPLzDOpTYVPRq88RXVln6SUNFcuSuQnbbErpsH+ALXO3dcR8CWaJia2dPS42IccH5uTNavdzEo/xQjBszjEaqRsc0kTQvR1QfqVFkC8tEPEGRts6yTf43Dl/6l0Zl1yXYl9pTx/vQG5Q3Wl3gdam8PfO+Wsq8y7TZbTlK1RWwLDee/guo8A/4MUya6OuF/53KgjoeeA1+7r6y1JQCbMMRloS9Tyn94N+wvDQUtlTYxd0KQbbflBqypEzTAYcGAcqCN0+4XLngxyOSCH2WaqUecLrMcdus7ZSUgXqW8j4I3t6AfdVIz+7JEji9qTdaAl79FmxDUhLZVdKsehvKrYrJinpU7LsnLt5MQ0DUbMVRnm5NwLkiIV3TMyC+VecRI+wpgYt+4wJ8AAB6K8g53orU8JlpfPJbUXyO7Eoj65Gg60KlGnJGJ9gMg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(5660300002)(4744005)(66946007)(15650500001)(4326008)(2906002)(8936002)(7416002)(8676002)(66476007)(66556008)(86362001)(36756003)(921011)(38350700005)(478600001)(83380400001)(110136005)(9686003)(6666004)(6512007)(41300700001)(316002)(6506007)(26005)(52116002)(6486002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0F2ZGdRN21CQnJwQUpDWnFCczJSRlJYUFpZcm93dm5vQUJ5RmhtMUlSZEVB?=
 =?utf-8?B?cThQdlpEZ2ZMZE5oc1NWZ1psOHA1U3pWVXJEWTg3VUt0RzhJYlZlSU1PM2xU?=
 =?utf-8?B?VC9xQWlNV3NZYWxOWUt6aU1yL2hpN2xEWFBUbE5yQkc3YmN5VHdFZ0hUckJT?=
 =?utf-8?B?SzhVeWNrWmNUYkZHbWF4WWFra0t5M3NsOFhQNFdWR2ZsT3lNWnBQM1ljOFc1?=
 =?utf-8?B?ZjFvVjBFeXMzSHBDeDlkREtNRXRpR0FsSjlYZHVWTHNrR3k3b0MrNXFBQ3pl?=
 =?utf-8?B?ZUhNdVcyeGwwWGlzN3RTUnhQYjQyYVkyMjl6ZmVlYWtGN1pqV2tqTDdLdVhO?=
 =?utf-8?B?Wm1aNmVvQ3o1NS81Uk1TaUpVNVluSDdiWGxvM0VJOVpid1Zma2h1UWM2ZExK?=
 =?utf-8?B?UVB2dFMrUU5mS1R1U2lsenJPNzBQVWZsMzA3ci93OG5ZbnBndW1YTnNaemgv?=
 =?utf-8?B?MWlTWFEvQy85aUFUVzVKdnNINzVneHZZUHVDQjNWa3piN3dQdlVucVNqWmE5?=
 =?utf-8?B?UE5YV2Jldll4VU5ZbXNJb2dIMlozQTVsdHM5YkRSVUM5bXBvVW93bDdoRUFv?=
 =?utf-8?B?eVVRQUIyTFBzdXZCNzRJcTZ2cGlvOGw3Q3pMT0t2TzVpd0dFMTM3SDVZZE12?=
 =?utf-8?B?RmxnUnFrZ0RaamZZTUpQOVVBZnBIb0ZoQ3pQMm9TKzZLSjF3Z1FtODVnQmtJ?=
 =?utf-8?B?RkxscWFzMm1WYWUwbkJUY1dScDliWkRFVDUxSnFkcU1yaFlidGErNU5QT01K?=
 =?utf-8?B?cFRkajhKUnY4QkpGRENnM1hLWFFBZW1tdXM4cGhoM3pBZjNsWDliSmUyQXcr?=
 =?utf-8?B?KzBONkI1Z3JuMTVEcUNSKy9Nd1p0VWg2MGx1ZlYzbGFnWjRjOFhXUWd5YnV0?=
 =?utf-8?B?a1JHWlgyWUNtYlJGeHFSYlBRZkYyWW5NS3dpK1lkTXhHa2FuNXNBSmRRTHpa?=
 =?utf-8?B?Q244YmZid21DMWM2Nzh2VDNKTFNWWlRoWDhYWUpmc3RtR1Q5NWZza1NrTXBL?=
 =?utf-8?B?c29ETWdQVmlFbUcvajhlSjFCdE1sdWtObVo3cUtGRXFicSs3b21TTnVxbktG?=
 =?utf-8?B?eUtWZWFxVWMvRFpDMklaVVNxZFZVdTlJc3MyeG13Qmx0WkxXS0NKSnBmeURD?=
 =?utf-8?B?bFRiY2JvcTEwaWN6TFliWmtPU0grckJHekFVL3ZvcUZ4Q00zeDVEN2FoS3dj?=
 =?utf-8?B?aDN0OXMwdUQreTdjV3QrZGlCWGlGY3VkNXpvSnRDUzJxNlRRYVkyeW5UZGNj?=
 =?utf-8?B?cnpYOHloSmwwV0RmYndldmJWWTFzVlR0MjhYQm8xd1hReHNkUGQ1eFE5eHlL?=
 =?utf-8?B?Z0pJNTRXci83Q2RubjBwbThka3crWUtCMzlBdlI4YTR0TUZ1MWdrbTNaczhN?=
 =?utf-8?B?SkNwYUp0YlhRQ00wRjF1UjN2N1U4SzNFOW1RbnNia3hxWGxqaEk3NTBDRUdQ?=
 =?utf-8?B?OVFQWVNaVjlCVnNOckg1SldNMkVQdVhwd2QvRU9lS0hySkg4MFoxc1ZhcXFO?=
 =?utf-8?B?TmtWNkFSYUhPNGMyb0RWbXpZLzBUMHZYVGNJMGdKRHh4VTliNjR4Ulp5UTBF?=
 =?utf-8?B?VjZtQnFPSDFkTGlpNkpaZnljeVVtN29veklsSllRZVN5VzdwaW1CR0JtNy9Z?=
 =?utf-8?B?RjBFSE9RazgxOXlYSGZwZkx2d2JqU3lJN2d1dzFIQzFxNlA3cTlrM3U3Qnlq?=
 =?utf-8?B?ZTE2YUdxWmY2OW5nTHdZN2ZhVlY3QlVhdkdKbmJuSldyRmUxTjJyY2p5bFRB?=
 =?utf-8?B?ckJUMEdqMkZ1T3JuaG1nYkFycGJyclVrbzkwaUZZd29aODUyUC8vTEVDVExv?=
 =?utf-8?B?YjltQXlwM2dWandMZy9uQ2hCT1lNUVQ0bFo3dG5rYXBYVnQvZUppYklzZi85?=
 =?utf-8?B?MTlIRitSaGxNZDhUQi9LZFF0N2VoQzdwQ1JOd2N3elFucHM5RTk2NVBIZDFj?=
 =?utf-8?B?VUV5QkNsdGMzZFNEZWtOUFZKRit6NVNlM0h0VCt2dkY5TS9GMmZDWjZnaVRm?=
 =?utf-8?B?bXZNc3ZRVDk1dVI5aWRMK0xlR0xndVpwMDB0TmEvVWdncCsrcmZ1bjdDUTRk?=
 =?utf-8?B?N1hQUC8yV2l1MWp4U0hsVlozTm1JYWUzZlpxaXptNk5qYXNTcGc2L2NaZzVq?=
 =?utf-8?Q?458oOBzXITkc/NsBIUcrFtp6Y?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e37ad53b-15dc-4d4e-5f8a-08dc304d9a81
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 06:48:24.3268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fflcqaUJmRaWXGda2OijgOvZUfLE5BnrKNDRzTtA9KD1iQ+8kJ051BEgNH3I4m2iFJL8jp7uZEd+fPiQaXPa7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8011

From: Peng Fan <peng.fan@nxp.com>

Some MUs such as i.MX95 MU, have internal SRAM which could be used
for SCMI shared memory, so populate the sub-nodes to use the SRAM.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 306af1880415..b36267591db2 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -16,6 +16,7 @@
 #include <linux/mailbox_controller.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/suspend.h>
@@ -920,6 +921,8 @@ static int imx_mu_probe(struct platform_device *pdev)
 	if (ret)
 		goto disable_clk;
 
+	of_platform_populate(dev->of_node, NULL, NULL, dev);
+
 	pm_runtime_enable(dev);
 
 	ret = pm_runtime_resume_and_get(dev);

-- 
2.37.1


