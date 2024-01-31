Return-Path: <linux-kernel+bounces-47367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA985844D56
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBD01B3873B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E318A13E236;
	Wed, 31 Jan 2024 23:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bDPvUAfb"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2048.outbound.protection.outlook.com [40.107.8.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A03913E216;
	Wed, 31 Jan 2024 23:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706743305; cv=fail; b=eAckPrKZS2s8sEbduc1ndb9FUglMKdCRJNnLd9Bp7dwG5SuJvcPTeKwzrhiK0wPlt7PT6hbrOOihozQYQdIM3AcwV689bNVwmMCu9DopjOP20oZIkOl4Jg1hra4+ng+Ap6dtZosIivYsQ0nth0ukU6xVxWAacgGur8n/HF4zQyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706743305; c=relaxed/simple;
	bh=K/S6pyJUIDT0tXIlmXhJJFSXcOymqJN+bu2cfQyjZYw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=J26tFS5dms+jzoQpgke7Ij7g24GvXpS+N6QcClRjDEES2CbNWIOXl5Nnd2pofNvp4Umj5x4S6IUjUC4h9CWVzdsZd7nUMKGYSHW/UPkLnaM6PiwhbU5qODOfSrANkor4V30w+7hmTv/UQRCkhtJWVqeJ8jRVYz834wOpdQNm/VU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bDPvUAfb; arc=fail smtp.client-ip=40.107.8.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3WwI53FJEmRfv4vREC2l7gEBaGFA6H7xrCffGpMlTjdKmVSJPyFpvOW/ufhFitnMLonR026JfrlOEk/m1KmF7HWe5xuwROVI9CnufeYI7fgzXlKRH9cVjU7SNqqrOT+RV0Epxkc3kdGr9mk6gYS5+uxQLAuc9y339q0otEs71X9qBj47aLg02+VTG63MsBa6ojKkoCkLCUx8EVGdzqqRiKPIgEpchmy/E/2bp3zcDBZ/Rbu+9AP60OYEUHNCSU/b9E9uVJkP3zpN0KuJhQXMzy1u7kKX/Hc1exnaqjLiNgbHee/1Q7nUXu7yb5O0llE/cZECm/dytnlVKc104JyxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcXrRKBabQlOTHo50b7cbdxKf1Mnfm+dGC/o8m8tAJ8=;
 b=Tvkqr7kbmYSv97sCnkZhstFYWRIAFsx6QFR4t5/tuyRgLsDXTNruQwWRg6n6mL1bA9m3+SE2LQL8DGce0CICiWsLFOhKF1XgROxiv/IYedLQNIQTEu4OSv68fLbVOen68SEfj4hI97OT8+ng38GAUfGvmzHGogDsaHeEGOJ8AXnXn4uV5bZewO+HfCGNdWdcrglG+iVUFSf5o/+xtB8QaZsNJRMeUfkUfx0u+Ig9/DkXDm1ihQonn9isoZ5NlD9zJmY3e6chleJwc1N9gcf+P0lTgTIqQ/KZdhUPZJ++gD9fZYnCCiaVl4NOVhWDpsPO3fbRedyVJ10vH5A/TAI9oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcXrRKBabQlOTHo50b7cbdxKf1Mnfm+dGC/o8m8tAJ8=;
 b=bDPvUAfb/yjQthPhlFgEW30LpGf6IdaQZPsEwxGv/ZKyNEYN4NbFq4/7EdLaBzOBqC2fIK/nlWsQGSBXKNWvDxdVNNmTf2qogQNnWsYr2mbUY460uHHL48bb4tJlpV9gM4q7rT0VzJ25nawovjbb+F5AxhdFCfagnh2TwAD6DG4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7396.eurprd04.prod.outlook.com (2603:10a6:20b:1da::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Wed, 31 Jan
 2024 23:21:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7249.023; Wed, 31 Jan 2024
 23:21:41 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 01 Feb 2024 07:25:39 +0800
Subject: [PATCH v6 3/4] mailbox: imx: get RR/TR registers num from
 Parameter register
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240201-imx-mailbox-v6-3-76f4f35b403e@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706743555; l=4351;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=ZIPe1ShyvGcJ7GWp7Z6UAmZB3DJN28oXn0B1jjJz194=;
 b=jYPxB8fmyqs28ZGG+s4UND+7th+LqGwtnEzqRiWlVn1rZZbMDl2OKagX0jYZA3PRhBunBX23z
 fJIbkK5+esdARtoS+lXRhkZoPnTp06BKv4bFHcfTD2y1VkcxxKsyygY
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
X-MS-Office365-Filtering-Correlation-Id: 309a02e0-e1f9-4947-d221-08dc22b361c9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YMS6nve3wbwdB/bXwWQEpav8dHQBYX6NO4i+7hURFIaO2xkg6DEgajTDuUkoe1QZ5aAbdqiKpCprYkSz9rbRL0jGPmsko2C6aVfEUH7ro+NAV/lvtGMCLQDezWPpZBa3YjFdAsl8yhR2nvmPeVFHeQX/SqLNLzdymx/FZe/Yr1QDfg7WIVZvx70bHUt9ggxVNx4nMYl1oCymq10FwqNVtMZwG8Dj9TbXzYbPJgz1Nj9nXplrindz+RFLujLpq/YAM8e9MBjN6iO7lZaBoSRdFYZ67MDXX/RH1lVBNJz3BWe1NngdmWuaxIfb/fbn35OoWxR8wTdZKZqqu7N5gtBBk2R9BSoA0oFZ0yYTJz74twkmseGi/8RqcaOJYmccMxs5eCzIdciphFuT1XeNNSkFZYPWZSJF6QyCJTTn2iUwa6tW8/UHt7z1wWL85g9lodvqhVci7NE2AzzJ+WuBmdX4h5xs+IafvmdhSmJdpb+YZ4sBmBraLmwKlC9kNTn6Zgf1Jy0GjBDVeQLuWy7NGmhs8JS3pfZRmdiRKjoBsJ125HpoDYCNRstCZ8FLrAmdw+xColDqYBukTaMo9C/1Fn1wmtzw3nq4hoojVBo9WGn/nFpauzflitBbDgWzVjpj7pKnBo1iT1sWiAuGlxxSPJ9PAA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(39860400002)(136003)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(921011)(26005)(41300700001)(316002)(38350700005)(66556008)(478600001)(36756003)(6512007)(9686003)(6506007)(83380400001)(52116002)(6486002)(66476007)(38100700002)(66946007)(5660300002)(2906002)(8936002)(15650500001)(86362001)(8676002)(110136005)(4326008)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXpJRlk3ZXFiMXNBcWNHdGNEQXJvejhiYWlQYXdPODFKTGZKNGUzV1RNZ3Bv?=
 =?utf-8?B?d1VuQm5QSG1TV3lMdUk5cUgxZGlQK1FUTHZPWG1saTl4NkZ3dnAxMk9BS28w?=
 =?utf-8?B?eTJmeEtCVkNiaTYyQUdhenJCVDgzU3JPdnlqYnlHMFNpV1Y3WXJtSTQycmNL?=
 =?utf-8?B?RnFXQ2txNkFETVYvc29wc05RWEl1VGFzRHVTY0xScTV5UWhxRzdtV1FqWnRl?=
 =?utf-8?B?cGMwMkFGWXdia1RzM01qQm95dTFNZU0xQVYxUldTamRwTEZRWU5QMXByVTI5?=
 =?utf-8?B?bGZ0V2RVeHFla1RDYkU2ZE9kNURycUdPcitXN2RDZC9Ta1ZRNmpMMVliY2dQ?=
 =?utf-8?B?cHNUMVZVbWtJMWNkb29JWDVXc285N09MTkpINloyQ1BWeEcyZjcwYTIyc0lK?=
 =?utf-8?B?dk9ZUEdCQ01mYUlod1ZFYi9qLzJ1RDJ3V2JieWlER3FjTTZEc3JkK01maklQ?=
 =?utf-8?B?bjNmWmRVNlZ3R0Mrdk5maENLU0ZiL3B6MkJwQjY2b082Zzg4ZUoxMFV2MEx3?=
 =?utf-8?B?VjE0RG1hb1RiMENSU0RjTFpHQkF0S2FpMjUxTlhOa2w0QWM1WUNFZ1c0d3cv?=
 =?utf-8?B?TFZ3MU1INDF1a3JQZGNQSGM1N3RiUGxYTThsb2Y0Rjh6cngvMEkvOUw2cVVl?=
 =?utf-8?B?RndWUzVtNlh3OXdkWWFJUjdLZEdtbzBQZ3NWbXRseDBwSHFlSWdPRTNKblZR?=
 =?utf-8?B?TWNJbWRBNTlhMjhxaE45cEZVZGtlQTArSXZYYldadzA3RXpJQWIwQW96R2Jx?=
 =?utf-8?B?Z0E0elZZNmhWWWFBeEN4TVZJdVRSWVY2OEp1TWJqU0Zmb3JrbDV5bXM2b1Jj?=
 =?utf-8?B?SkNvaGZJWE1GeHRXMDlhYXk1ZHNFZHlhYmtWZ3Bta2hXQXVuZks2UEhEd0Qz?=
 =?utf-8?B?SzhmY0hOWUdNdVJVV2JKTUFSLzYxQlNxQzh0cVpQZi93Q01taVlBWHFySHgy?=
 =?utf-8?B?bGlkNkY0ejJGN1hxZ1o0NVNucHlibE1ua0VnLzRWeFg0WURZZ3QxSzErYmln?=
 =?utf-8?B?RzJ4ZyttQTN3cE8rQ2NFVzkzYnYvK0VVMlpaNVc3S1hiVFZEK1Q2ZzBYWmYy?=
 =?utf-8?B?bWhqVGpLWXVlcnJUYXR4VWFWeTJQRzdMNUR5dTBQaXV2ZHJjNjRWWGlDTXhT?=
 =?utf-8?B?WEIzNm96NjE1STVjaUkwTHRWOUdpMFFXa0tCUmw1ajBRaEpkanU0NUtaSHNl?=
 =?utf-8?B?a0JlL1M0c0w3SE5ad3pGbzdTbDJ3bm9xSXBvYS9qZFdpOE1VekYwS2R3MHlV?=
 =?utf-8?B?VVZwdWY5OGkxejJKSmZvRWdWa1RFMTZ0UGZZbTdCS0p4aTdOcHVvMEZ6WktC?=
 =?utf-8?B?OFEvRC85TkVPZlBGQXhEbitOZWZZNFN5a1lBNTRqMW5YV2xxR2hyaWxxWGdj?=
 =?utf-8?B?VnN6MDE2UlNZV1ZRU3dIcFJWWlNXQU5PSVMxMlE0dW1XVkZYOVFZYjhVU0Js?=
 =?utf-8?B?TDdLR09jMGRhK3N5dUE4amMxazdQakplSGJMU2xQbUp5a1V6bzFtd3pUb3Ax?=
 =?utf-8?B?YjNZUkNHcmNoSVM3RWY5bStRVjl0cDV2OENOYmtnRG5OS1A0SzZBZmQ4Z2V4?=
 =?utf-8?B?WHJxOUovQUFkWHk4OFpYTDhGSVAzV3UwaFcxZ0U5Z3pPWEI1S002Q05xZWhw?=
 =?utf-8?B?eDdUdXAvMGtYS3JvVm83TUJhYWNnVFRxd2o3dXNueVlLT0k0dUQ0bVVDMHZv?=
 =?utf-8?B?QitOSG8rSTlTSG5xUTJ4Mi9sbWgxRjNCMWVtSXJ1bThidjVOa0JyUXNHYkR2?=
 =?utf-8?B?YzI3bEhFNXlicGJXeE9rNHg4M0ZpQW9qR0Q3UCt3UG84TlBjeHVZcG9nZmVi?=
 =?utf-8?B?b21wSE1rTnJqSVF3TzZjMUpkaUpaTkR1THVmVkY3ZGdqOUJRbmQ0eEl6TXh2?=
 =?utf-8?B?amxvR2hIT1Y1VDVCSURaRDZRMFQzcmRVam1xQUhDZ25QUWV3WEVHaFJ5alBC?=
 =?utf-8?B?Y1MrL3lBbXpBanFtd2Y5ZTJNV09oMnhKcnRJNVVrK2pobjlESjZ6UVNkUGhM?=
 =?utf-8?B?SzZtUlFEU1VoVmdKYVBCbzh2MmYzdmd2VzRibWFkc3gvaTZKMjJIQVh5ZTFD?=
 =?utf-8?B?aEVxYmJwcjZ0aGdEWk15UG51WWdVLzdlZHBydExpQW1EOVJ5ZDE3eERKTVhP?=
 =?utf-8?Q?WSgngiSuL2vEVGyUcVfNMOEzd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 309a02e0-e1f9-4947-d221-08dc22b361c9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 23:21:41.5668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: buwUqna9tut/qGFOhsAfAwauE6g97PGnirT8plf4nTfzhgZCuGzl+KnDvRAWaAsB99+AEZ1dL/O1i3ahbUk/Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7396

From: Peng Fan <peng.fan@nxp.com>

i.MX8ULP, i.MX93 MU has a Parameter register encoded as below:
BIT: 15 --- 8 | 7 --- 0
      RR_NUM    TR_NUM

So to make driver easy to support more variants, get the RR/TR
registers number from Parameter register.

The patch only adds support the specific MU, such as ELE MU.
For generic MU, not add support for number larger than 4.

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 46 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index dced4614065f..9e89f773d2f9 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -29,7 +29,9 @@
 #define IMX_MU_S4_CHANS		2
 #define IMX_MU_CHAN_NAME_SIZE	20
 
-#define IMX_MU_NUM_RR		4
+#define IMX_MU_V2_PAR_OFF	0x4
+#define IMX_MU_V2_TR_MASK	GENMASK(7, 0)
+#define IMX_MU_V2_RR_MASK	GENMASK(15, 8)
 
 #define IMX_MU_SECO_TX_TOUT (msecs_to_jiffies(3000))
 #define IMX_MU_SECO_RX_TOUT (msecs_to_jiffies(3000))
@@ -93,10 +95,11 @@ struct imx_mu_priv {
 	struct clk		*clk;
 	int			irq[IMX_MU_CHANS];
 	bool			suspend;
-
-	u32 xcr[IMX_MU_xCR_MAX];
-
 	bool			side_b;
+
+	u32			xcr[IMX_MU_xCR_MAX];
+	u32			num_tr;
+	u32			num_rr;
 };
 
 enum imx_mu_type {
@@ -264,18 +267,17 @@ static int imx_mu_generic_rxdb(struct imx_mu_priv *priv,
 static int imx_mu_specific_tx(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp, void *data)
 {
 	u32 *arg = data;
+	u32 num_tr = priv->num_tr;
 	int i, ret;
 	u32 xsr;
-	u32 size, max_size, num_tr;
+	u32 size, max_size;
 
 	if (priv->dcfg->type & IMX_MU_V2_S4) {
 		size = ((struct imx_s4_rpc_msg_max *)data)->hdr.size;
 		max_size = sizeof(struct imx_s4_rpc_msg_max);
-		num_tr = 8;
 	} else {
 		size = ((struct imx_sc_rpc_msg_max *)data)->hdr.size;
 		max_size = sizeof(struct imx_sc_rpc_msg_max);
-		num_tr = 4;
 	}
 
 	switch (cp->type) {
@@ -324,6 +326,7 @@ static int imx_mu_specific_rx(struct imx_mu_priv *priv, struct imx_mu_con_priv *
 	int i, ret;
 	u32 xsr;
 	u32 size, max_size;
+	u32 num_rr = priv->num_rr;
 
 	data = (u32 *)priv->msg;
 
@@ -345,13 +348,13 @@ static int imx_mu_specific_rx(struct imx_mu_priv *priv, struct imx_mu_con_priv *
 
 	for (i = 1; i < size; i++) {
 		ret = readl_poll_timeout(priv->base + priv->dcfg->xSR[IMX_MU_RSR], xsr,
-					 xsr & IMX_MU_xSR_RFn(priv->dcfg->type, i % 4), 0,
+					 xsr & IMX_MU_xSR_RFn(priv->dcfg->type, i % num_rr), 0,
 					 5 * USEC_PER_SEC);
 		if (ret) {
 			dev_err(priv->dev, "timeout read idx %d\n", i);
 			return ret;
 		}
-		*data++ = imx_mu_read(priv, priv->dcfg->xRR + (i % 4) * 4);
+		*data++ = imx_mu_read(priv, priv->dcfg->xRR + (i % num_rr) * 4);
 	}
 
 	imx_mu_xcr_rmw(priv, IMX_MU_RCR, IMX_MU_xCR_RIEn(priv->dcfg->type, 0), 0);
@@ -737,11 +740,30 @@ static struct mbox_chan *imx_mu_seco_xlate(struct mbox_controller *mbox,
 	return imx_mu_xlate(mbox, sp);
 }
 
+static void imx_mu_get_tr_rr(struct imx_mu_priv *priv)
+{
+	u32 val;
+
+	if (priv->dcfg->type & IMX_MU_V2) {
+		val = imx_mu_read(priv, IMX_MU_V2_PAR_OFF);
+		priv->num_tr = FIELD_GET(IMX_MU_V2_TR_MASK, val);
+		priv->num_rr = FIELD_GET(IMX_MU_V2_RR_MASK, val);
+	} else {
+		priv->num_tr = 4;
+		priv->num_rr = 4;
+	}
+}
+
 static int imx_mu_init_generic(struct imx_mu_priv *priv)
 {
 	unsigned int i;
 	unsigned int val;
 
+	if (priv->num_rr > 4 || priv->num_tr > 4) {
+		WARN_ONCE(true, "%s not support TR/RR larger than 4\n", __func__);
+		return -EOPNOTSUPP;
+	}
+
 	for (i = 0; i < IMX_MU_CHANS; i++) {
 		struct imx_mu_con_priv *cp = &priv->con_priv[i];
 
@@ -768,8 +790,8 @@ static int imx_mu_init_generic(struct imx_mu_priv *priv)
 	imx_mu_write(priv, val, priv->dcfg->xSR[IMX_MU_GSR]);
 
 	/* Clear any pending RSR */
-	for (i = 0; i < IMX_MU_NUM_RR; i++)
-		imx_mu_read(priv, priv->dcfg->xRR + (i % 4) * 4);
+	for (i = 0; i < priv->num_rr; i++)
+		imx_mu_read(priv, priv->dcfg->xRR + i * 4);
 
 	return 0;
 }
@@ -874,6 +896,8 @@ static int imx_mu_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	imx_mu_get_tr_rr(priv);
+
 	priv->side_b = of_property_read_bool(np, "fsl,mu-side-b");
 
 	ret = priv->dcfg->init(priv);

-- 
2.37.1


