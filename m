Return-Path: <linux-kernel+bounces-35455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DF383917A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5241F2850E9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883595FBB2;
	Tue, 23 Jan 2024 14:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="R8lLILfq"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2061.outbound.protection.outlook.com [40.107.105.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C0556777;
	Tue, 23 Jan 2024 14:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706020478; cv=fail; b=C+T3ZVfgXJeHMFWYuyHQIzWHgkmUIxZYhuWU1OiPwgEBbK05Cb3zGItc7A9J/b9gPfBx8/6NTgWlyzoqkNuiQcGECuhE09z4wH/c+dz5vZgYxvZ9okYdQVBGe3NZpcgD+qaVVWMnXtDnH6oL7JGfJdtaCkJHlGrK3vkN25UqefU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706020478; c=relaxed/simple;
	bh=LDN7O/dpGg31VW4DZx50TL7inOfSwn3xUBm8mLyixjA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WMoR9004mGWrQ2MT1CNk0RpdJDKAbHcqKSPEtEjE6qevzcqkH8tUK9HFzPjrncmKNmP0le5/RSNSRCNajmEoFuhyDvlp7ihrS+virwlN3QC/AgxajrRA7bOdhY3fuQ5haibVzD+THR7naBeal/QLwkMp5Qp2dTsVBtoCwXLOFVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=R8lLILfq; arc=fail smtp.client-ip=40.107.105.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/XEoqfJ4K8CgowLuLA6flobOamrpudz8zNDmmdjuAmIh2F/O1HfTM5+HsUTlMSCS96T35Evqy6WpJ9VegmPzgrmYjvMLt2PA6N8XhJSzwsZazi+2J+bh/zG6a1h6o8ngAe9BKI4fQLDK9lf0vLmzEjMkndk8jENOrI4MB+nQ0J2r1ZCaMKzZ1O9Rehrwj9VcM0RRSWOhr8I3wsdfjjy9v6/o9Hk3e7CW9D1u9AaZAryhiD6Kp6B1VDOcGU+YoQKv5+OYGrgXzXvbuHcmJMR9STZpnRrFpdOGE4xeDBpFPBQXI1Iu44WtiW6gLM7jy2EoRuUSKhjVHYYjkRq8CAx2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVF+lIifocnKZkWBqalKhcjKGKvD/NfO5sSqA4z8S+g=;
 b=HeK0JFWxlehyat8N6Eati3Qn65pGs72ONPxg4TXV0LYJ7mPUjJUdeV0h21RwCPhP9skToeHb2qJTwu7WZp1CYOQrLTlKWEKcAahKbjdNj9CtY2qCaaU3Aq4T5r7p6KZzZ1Qm6uZvkKfZZJ0UU98oUWJ7wynvVbvku0oiCWk9ESimJFvwJN4cBP033ZE8R7mxRQKU2mu2EBOciTxU1zChrrueOOSsRJ8GlLfUe7x5O+SOYj9oQQ7Z7UhfhqGXZAo1RdSJAlCO9m1hzBRh0Yz/c4ZNUzz2xTplqgSOquJBi8exDVMXGXAPfFH/iW9mBqjWGL8j0XEP1UzsHaj1QCeVWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVF+lIifocnKZkWBqalKhcjKGKvD/NfO5sSqA4z8S+g=;
 b=R8lLILfqPqT1SFKxgfCxRIcZ/Ug7XZ6utrM0t/S8dgBs3UgtRvdExuEQBx6wYaqQpRMspLOJ/yNYSD1oxHe7mpC8CG/C7riBjkKZYuOa2gkhHrrbpw036DghzISK7fhrsttef22m38SLBvJZ2RJikWRlUH+B0WW4KQEmupLh/Kc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBAPR04MB7304.eurprd04.prod.outlook.com (2603:10a6:10:1ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.36; Tue, 23 Jan
 2024 14:34:33 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 14:34:33 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 23 Jan 2024 22:38:43 +0800
Subject: [PATCH v3 2/4] mailbox: imx: support return value of init
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-imx-mailbox-v3-2-ed932945e0bf@nxp.com>
References: <20240123-imx-mailbox-v3-0-ed932945e0bf@nxp.com>
In-Reply-To: <20240123-imx-mailbox-v3-0-ed932945e0bf@nxp.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706020734; l=3343;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=+Gd+/hMaY4KbnLg+mAxCKcpz6HM1MVsMqwBCKUxGXc0=;
 b=5O3LBUBookNT8VKge0bq0I+VPLg6GIEYtk4VRy9cu9QXhIqyVEPaLkgYaCoa4B+5wEULmof2T
 liTlsjuu8pgBynhMx+EbuWxO2p/PBTnjf1U3jZ+1wTZsWQiSf6RaXt2
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0125.apcprd02.prod.outlook.com
 (2603:1096:4:188::13) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBAPR04MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: b029d009-942a-465b-77a4-08dc1c206a88
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LxlJl92cpFpU6b5kcWcYp1mzc+mN++YuCquE7CHSNRcJkonVFk5wAei5otaS2nzqpa213hQRVYtlCVMxUWJxrdFJpO4h9zcwnykXPv93Mo+ek5+p5J7Xz2OcHYrKy13BjJcsS6VQfcG4ukmwr3an0KJzLX3Hg3m5T6frHnnB5ZiXD27909BBqc4EUhbpA2rIFfJsd/A511FK6rkBWcMUSqQ6LDVcLFn5++xhgJWoboW4ASsxVflF0SQmBNYswpxmC3K4fSFWZjjb0AanFvW4BVO7w4+FQC/UKxhxq91BmYhFQ5y8LkIcIugab0fiQ7clR2vf+h1lmkgh92QIEf3WQLESwizVl369HSY5avTTc6LnzW2QmYhJxFw1j11L7J0BAnVDAn78N+XYnOFihgAVKq2gVm7qC68Cj/w0kAQ6MFTWlFcTBNrgTjO9wbClSrsbCVNGlWMwbMpj5VtPV2hVWih+uacn3jpMQWa1XyqDPLLP2KZtnSR4DrZr8fpP63hk3OslZtM1cPNW8jtmFQnwOZ8f3hUxod+FFuoel8X0HPLdn3ta4SMOxrxxOxSzLCgemeYbQeD5ZlNMY1yILEr2kxQOimlM+a/c7E7om5nXh1iKhiLAv6tnN10/4eFC+kcm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(39860400002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(5660300002)(66946007)(66476007)(66556008)(110136005)(316002)(26005)(6486002)(6512007)(6506007)(6666004)(9686003)(52116002)(478600001)(83380400001)(4326008)(2906002)(36756003)(86362001)(38100700002)(41300700001)(15650500001)(38350700005)(8936002)(8676002)(921011)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmVkUWthKys1UTBPSlgvdzZYbzk2YnFVWWd1dXpZNXBoS3l4eGFTOVV4K25z?=
 =?utf-8?B?RmtLYUN4OXovRW9GWGlyQ1MzRCtVYXBJTlJoc1BEZmVFMitua1dkWDBRZ2pw?=
 =?utf-8?B?UmlKckkwMDVXcFdXSXZjTkRxTmtSN05WUkJEMnczV0gvTWxoOURRYmgrYUc0?=
 =?utf-8?B?RldRVy91Q3hWZ29PYVZxZ1FTTCtqSzRtcVlSOG9hRkpjK3lsSlgzVXRla1Zr?=
 =?utf-8?B?WWN2cVhjRFNwclJxM0ZOM2JwWEc1dWhFbCtReFM3aVRyeHBna0xWZEx6ZkFU?=
 =?utf-8?B?aGh2M3NqSWY0T2FZMWtCeXkvaEFTRnh2MlNGTVNnUnRISHBvOEVCMzRsUFc4?=
 =?utf-8?B?Z3dQcEJ2L2RMVVV3ZDFXamNWZWd4VmJjTCs3VFBqTlFGSmpHWHJyWVFDTTNN?=
 =?utf-8?B?bytNMlQ5MHBub3prdjRCWW1PcnlBNlF4QWlVdkczZisyMFg1L2Q3VkcvWkkv?=
 =?utf-8?B?VE5zZU5PcGR6VHNuL0lHbU5TS1J2RHI0Q2swK1p5dkZwUHk4b29IekI0UFpY?=
 =?utf-8?B?MXBGRER0cGE4VktHT2ppdEV6eGtyNHhmMFN1VzRZOXJTMWx5ZUpPR0dWakdB?=
 =?utf-8?B?VFV6UkQxbzJHL2JDNnJFdURVU0EyaGlOS3NOWVROQkZ3bG15YjVLWEdXUWN1?=
 =?utf-8?B?a0xhKzc5ZXBxR3g4bWw2L2NqNGN0cTd0OC9UZ3V4OHdrMk50MFFad0kwQkQy?=
 =?utf-8?B?QWdCSjVzOEFWU2Y1SkVWMElHRHhNWEpvaXd1QTRVNVdHK1pVVjErdEVyNDBq?=
 =?utf-8?B?OW1lWTB3UjJoZzFRWDlRWEVPeTJsNTFmT2pJbkRneGF6ckZKL09rd2RBbk5h?=
 =?utf-8?B?L0h0dXdWdlBrMWkvRVRNWm5pcUMydXNwc0RVak94TVJZWHlWK09Xdm5xZm5t?=
 =?utf-8?B?NkluSXFlc2RiaEd1MzNQa0Jmb0l2THU4bDZsMHpScnRFM0QrT0Nnb1JKUklP?=
 =?utf-8?B?bndoQnk5cHlkRERYZnBrMlJNNWI1Wm0yME04TEQ0bGJuODg4UnJVaFpYSlhq?=
 =?utf-8?B?RjFyUmJKSFBSUnJlYUFjbURFRGtVOUttbGFUNXdld3Y2dmE0WDNZeXdSTDJP?=
 =?utf-8?B?STNXeHVoZFVYd09hc2hmblNCVzN3ZTFHd3hhU3d2MlZiRVkxMDF6RHdvWldK?=
 =?utf-8?B?c0FEY01zQ0lhNys4ellxME0yRU11MkFmVTdTalJhRklkMEIvbS9FczZ5ZjBy?=
 =?utf-8?B?REE0RUlBWlFSOUhvampRYjRpUmRXOWxkZURIQ2t5eE1RRjgzZzNoY2lNU0F4?=
 =?utf-8?B?M1M2b3Vxc2VOdW95cDB2M2RYdXdPWmlnZDhHS3N4cmxacFBpVDcvRHlad1JV?=
 =?utf-8?B?U1lYcXJnaC8ranNXdHFYbi9CZFJRZkVJSk1kblY5MGVIWEdLM0lyVkphb1da?=
 =?utf-8?B?SnltOXZNK0Z1VjY1WHFMOGVxdmo0M01Eci9FeE9iN1NuRHJqRTNGVzNKS3Ji?=
 =?utf-8?B?YmZlUnZLbTRzZU5oYi91KzdGYmx0eHFDRVFmMnJjbStXSUVXV3BhTSthOW5I?=
 =?utf-8?B?NDdsbEFmNHZmeTBCMzNzbTBJNG1iaWxaS0Rmdi9udk9EQmgwclhpT1EvMVd2?=
 =?utf-8?B?MGZxSGlWQnBWMEd0R3ZRL0owaEREMmNFU01VNHRXbitLTXU2Vzc2MGRSdEwy?=
 =?utf-8?B?NEk1QUY1ZFlRZTQxb1FNZzRVYzl2Zk51WWtPY1ZudTgwV3piZ0cxblgvVXN0?=
 =?utf-8?B?dGRSUUJ1Y1N0TGdtM3JWVHMrZUNBY0k2WjFjcWlhcVpzWDVDN1NWWFJFK0JZ?=
 =?utf-8?B?OVJqVEEySWZQSXFveEVUbkxBdzd0Q202THRZbjRiOFllbDFBM2pDQXFGRU1V?=
 =?utf-8?B?UmFDMmJMOWtrSGFjYlZFQVBYQXFldHpFNkFMUFZBVHg5dHJ3Z3BQeVVZcjFy?=
 =?utf-8?B?RHNtcjZ4THFGbXlyUktYWENzTmppbVArR1BkczQycW1rQUR5byswWFFJRlhn?=
 =?utf-8?B?VmlwZnZ5QjEzSVlIV25EOEc0dlZUY2wyV3JzOUQ0V1BUcnhFc3dSaERnY1U0?=
 =?utf-8?B?YnZDVXhrbEJ0cUxVK25JUlJvcHZlajdqSU0wLytFR0hYVk1aZDNmT29ZOU90?=
 =?utf-8?B?MlhXRE9nQisxMEc0MVlwZFBUUGpBZDNlV3BhU1g0K0VrdXNtQVl1TXBVOCsx?=
 =?utf-8?Q?r/X7ncCVt1QWQUUQ+/QvaKo8/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b029d009-942a-465b-77a4-08dc1c206a88
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 14:34:33.2903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: umuEQoWJ9Ef/0q8LbmvLze1mRa1FwXnHhbAzEUZg0UfRmArLoHWytncbdTXZUk6sdeLrHlcvvbUD7AxHyEGLFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7304

From: Peng Fan <peng.fan@nxp.com>

There will be changes that init may fail, so adding return value for
init function.

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


