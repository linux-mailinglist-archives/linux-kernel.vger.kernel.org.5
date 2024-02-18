Return-Path: <linux-kernel+bounces-70235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFF9859519
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 07:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F5721C21049
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 06:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764677492;
	Sun, 18 Feb 2024 06:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NFe6xcNv"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EC36AA7;
	Sun, 18 Feb 2024 06:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708238899; cv=fail; b=l/BMebyHP7FvLbNVg0YJjW25Ho5x6jqbGrbUvVETn3TMpDnxKvf5vn1orffNkG+20DgXpopHn27YhX1Usm4NsdBqxqd8CfILXcECk4eJcGp9tTInuiM/1Lpj58t4ZHNQpIzrHZSXw/w6cljePqPndYhVtDuWLQuBzd/sIyjiC5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708238899; c=relaxed/simple;
	bh=K/S6pyJUIDT0tXIlmXhJJFSXcOymqJN+bu2cfQyjZYw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dCFwtFvG8sgrIWm0iotdMP/JxKPbGAZxbHsLSYE+dbdzCpmW5gIMrpsl91ghbzWCUDzUhbwpWlkRMXpO0s34F9MIRrb0O/VkCxQ/0ghxN7itcIKmE9d9OEnxwsNZZNg5cwLfmhII+U5KKp3V91Fph/14N6DU8yym4haaFWPnRZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=NFe6xcNv; arc=fail smtp.client-ip=40.107.21.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SiC7rIfXj4OdbK+cVr5sFGmQ6kneRSeWH+LYYA98BGRsfOJr5blqAow4fgYYlsJ+jYitW9DLyudBDKLgQgspix++nbOtjmMMdxey/C7IJqUJCIvuqhWLugdANyt1xpUsoBit/pMVZRGEANKFCqMIG24UGLZKOoQp7kLVYKtXOP3Uva/5YbnsRW3Gtz2HaZfY2XOmWx+DOPENNS506pxRr3Z4sTPqjHREbH+6q4g4U8t/DNl7chrnKlrPaV8SmnLm7AaCwhwFVTl2KJAdqXCaMcpeO71Vx63dJboyk3EAcQNYAVNYrEb9FpxeQzotdtIiAy0XLkPSvdS08pSSuU79kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcXrRKBabQlOTHo50b7cbdxKf1Mnfm+dGC/o8m8tAJ8=;
 b=TS+TlvScYVgUtS8jWsw/XZiFMRUc+fDjugbVRFmPh7IJYAjS4TFYjTJOFpUtsxCR3mhQMPb2DX6LWNXx7bbXvPFmgt+4leqTuuxyhPdG5SjcPZSspLtUBGU8qqnJPFWcIYxOUqoOUwmbseD7ewon/GmqnkXu8W9hvffc/Bo8J8HNb178bgKyaMNhszD2Njr3Fj+7w6NSjb98cYzSTmq3IbFktXM7l+HlWiOeMU0zuaziRX+Wlv10HdibmUoyLGjqkjCvUpgXD8BzsfnileSUrELwLHxIfPhJwIFtYcwlsd5lcbYRTekvvR2PqyRtXxURYx3ILemvkOu6HZgDxbgNfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcXrRKBabQlOTHo50b7cbdxKf1Mnfm+dGC/o8m8tAJ8=;
 b=NFe6xcNv+5keqGUxJ7LWMq5k4BYIjtCrm0Jv2cENkeuS93wozM5Nxf/CCofhSbdw+JL5mQpu+3tiu6dznuX2nIEkkwVaswyZ99/zRFDHkA6o8RxzMTt4jSa2luVmSemJ2gK56oRoaIkv8ZZqgYMNXy2HO03RuBIIMqdVcE8f9vo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB8011.eurprd04.prod.outlook.com (2603:10a6:10:1ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Sun, 18 Feb
 2024 06:48:16 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1%4]) with mapi id 15.20.7292.033; Sun, 18 Feb 2024
 06:48:15 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 18 Feb 2024 14:56:15 +0800
Subject: [PATCH v7 3/6] mailbox: imx: get RR/TR registers num from
 Parameter register
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240218-imx-mailbox-v7-3-8fb665eeae40@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708239387; l=4351;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=ZIPe1ShyvGcJ7GWp7Z6UAmZB3DJN28oXn0B1jjJz194=;
 b=dAjzUKexETXPNTb8jh8/NfTW+wCBpoqn3sAdgbDXBEFAqwrISZhZb7PV9WZMzi5166iG8w/m5
 z4DlaMa9JzDDMNBLid7MNzq1bHZhBdZcpyhxtE9dI4HZ0+bBP7Htdvv
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
X-MS-Office365-Filtering-Correlation-Id: 21a0ef62-b682-44e1-13fd-08dc304d9584
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UAdW3DqAIi6rGdwOjz7EIUG91a9Gd71tCEN0/uqN7Dot/M0jprZ4MxFZOf36Xcck7qTZ77BGYEMNsHtnvQ3f28GJwEVuX3rSkHUA1WbVJzuT9BcTfeoUMlyKur0jy6TslrzkE1cCAOrzMCXLRvv0gvh6aQoDcVHWe1MsbwhSnwaI70mIuuZxeVeuOBAT9rkvTD6Jnt0UPBCPLRdOoNLtiizMjVK3htNJBnkDt9eB5tbKANBmdvSMvrbik0JRTVfaQl1WRZ4C4yDj1u28E0dxpB3DaJ8eSB599HifeSWKSH4uK4zwCTZZtEUIqbN6MzlIYwI9CwyuAoT7SyApnhEVhWt+HPbezIP6HptZiRmsQzwCDwdN+2gXLQndzESa6+72wlLl9qUGJRLu7B7lh1eC2prvKCqBEwzr8DWI050MJKyKOi0rK9MfBPv6GoBNS2huI1yIgVMUXL89R4KAFTdGRrjNq0NVD0VrclF37JgofAgSVkfaghh2zmL61cOHXSjH+m6MckV8yUOX4K0CQMDMhBh2u9eRQl6785Cp/LusRqwLryLLMjhsr4qZC8y1W1CH1arp9UvCOy7j6Ua55m4WAF2AaOzycrqMNjaefYR3NOrbj88yMUcSqfhKSNEr2cp6jnLMvRW/09ttrpY9KFo6lQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(5660300002)(66946007)(15650500001)(4326008)(2906002)(8936002)(7416002)(8676002)(66476007)(66556008)(86362001)(36756003)(921011)(38350700005)(478600001)(83380400001)(110136005)(9686003)(6512007)(41300700001)(316002)(6506007)(26005)(52116002)(6486002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHVoZktqNXdkM09tR2RzWWQxZDdibVFWd2VpOEwxQTNCcmNaMEN3K0ZGSE81?=
 =?utf-8?B?eTdLRjBMUHV3WWM3SDRBdWIvNmc0Y0o5N1dBcXRjblZ6R0c2ZHVSUXNvQUtx?=
 =?utf-8?B?ZEt5MlpGVEhURlBHZkZPR3hxTEFad3pSdmJ5QlZuWUZEVTFJTGwvMHY2R05Y?=
 =?utf-8?B?MTlPYk1PaXVRdmtTSENUR2tkVmVwVmpFcUdWaTBnbSsxZ3hnWXV0Nld3dEgx?=
 =?utf-8?B?emMvSGNpZWo4NW5NSlpZTDJEWnZTa1RjWEFqaFNjZlVLUkVkZWtQRVJ4VmUx?=
 =?utf-8?B?bXhnelVwLzBrL0F2Ty9kQnF5elUyYzh2ODdOblZrc2M5T0lhMDI2OEVKOHBz?=
 =?utf-8?B?d0pwY3lxdGtab0FMRkxBZllVbFNTcElmN0d1OXBOTmVtRWsrR2pOOVQ0c0FE?=
 =?utf-8?B?dzFobFlhcnd5ekI3Y3YraGVTeHJBU3htWmZ4T1E0by9MaHRiNGdtS1BhcGNn?=
 =?utf-8?B?aGdlc044T29QS2svUitqK1ZPQUZRekY2RjZHKy9hMlNiblcxeWN6UmhsR2w5?=
 =?utf-8?B?T3lET2tKZUpCMUNMajRLenhYQllaUGdLTUhlYU1XMnVteDE3cHpKamFiYzBX?=
 =?utf-8?B?elZqM1owWDNOMCtXRVYrWjQ5bUw2MDh5Tzh3dkFaUm84YmNNbllxVE91aWdy?=
 =?utf-8?B?WGRKTjhnRlJFb1haUmNmR2lPZ2tMWFZNdHN5aWs5Y2pmZkdrU1VXZjN3NnZ2?=
 =?utf-8?B?R293TklYTHZadXhNQmpsN002bDMzZk5VWDF4blFQQjYxa1dqRGYrMjJuN3U4?=
 =?utf-8?B?dVFRQ2hUWUFGUzlialZ1TGdqbEFHdDJDUFUremF6Nkp1N2U4Z0wrRU9ROU53?=
 =?utf-8?B?a09kWXBIa3NmV29HNEVXMkR5WDlKM25Kd3R5QXdNTG5rWnZzZTl3bUdkUm81?=
 =?utf-8?B?R2RVVkUvT2dIRENLRlJqeW9FMFJTYmFsRHd1eU8zckswUVhzQlYzeW5LSmxS?=
 =?utf-8?B?WWpTNmZqbFBDS3QyQy9SSXlaK25oa2Z5ckxVeWxDcW91UDJRWGVxVllVcjRj?=
 =?utf-8?B?MFcwa1BZWngvWU04cmpVMlVxWkNlQm4yK1RVeU9zOXlBdmZIclBMWExBdjV6?=
 =?utf-8?B?QnpVcVAvZ0VCTmw5NElKZ0FOU0l0KzdrVThxRm42bFNFZ2xpenQwWWNLWUFI?=
 =?utf-8?B?VVVVUTdJdFVGczhKSEpodStXSzYrMVV1bGZ4ZlhGQ1BHc1RYVVdDZEd0Vm5t?=
 =?utf-8?B?ZmV3alZVa2ZGUG85TFNrdmZUMm9pdUFvMHpyMzMrM0ZScTNEck11ZzhISDl2?=
 =?utf-8?B?T0NjdTAxd29teEdmaGIvUVIwQjZITGlya0ZJMVhFTEVKQ3hoUDBjbktlOTBp?=
 =?utf-8?B?Zm96MzlHTXN3Tng4TGU2ZWpxSENpL3dycDB5dVhINVNWdEQreDMzUXc0V0pL?=
 =?utf-8?B?QWxmMU1ITVMrYVVMbHRMUmhTRUM5NENGTzU5aHptWGhtVGk3T2VuWk5ZZGRo?=
 =?utf-8?B?cGZqdWE3NDN1QTAzTkRQK2QrOWNsU3RIZVB5S0lYcWIraHk0K1M0V3BrOWVR?=
 =?utf-8?B?WVZTeklNVXplNEVzV25Zby9aelFheXptaHV2RHdHTm13RVh4bktYYXR4SVZE?=
 =?utf-8?B?VHgyQVhZZ3diMmtXc1hmbjRkaHoyMit5TDJtRGJoYkl4RTNYeTlFaWdHYURH?=
 =?utf-8?B?azc1WVhWbUpQR2VNVkgyY0RMOFFRUmRsZUtHMTBSZEZ6dThTUEdpR1V3Wjc4?=
 =?utf-8?B?eXRXT0N3bys5REVOb0RSajZlUWJKWlg0QlNvVjZzWmNNcUZwaUxVTUtMUHcx?=
 =?utf-8?B?cEhiOVdVRGpnWTc0ZU1NQ1RNaTY3eEhxZHovQWZRUjhJektJcFhSNUo1Szds?=
 =?utf-8?B?V3EyZUlkTlA4MkpYazdWREM3T0l4dU02VnNRaWFKQndaWUdhWmNaaHFxcDZU?=
 =?utf-8?B?TlpUTUdnTk5JSEpoUS9veTI0d1g1RFdTenIrNGFjbHhvVVl3clhzbFFnWm1i?=
 =?utf-8?B?eXV6Q0NjaVhBckNQd0NlVHRqYWpFaEw2YWJ5M3I4RTFkT29qcUVGTDR0T0Qv?=
 =?utf-8?B?NlVLWC9qSFlvTUtIOWlYeU5wUFFTNVdBcHNiTXRTMXg4TlZ5YTlHK09BS1dj?=
 =?utf-8?B?SjBBRnZzZ1pPaEdNM1hZS3duNnVkYlFld3FrWGlkejVab0pFNlE2ZVZ2bDBV?=
 =?utf-8?Q?bj21VXzTNECX60cHIK1AqHfWE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a0ef62-b682-44e1-13fd-08dc304d9584
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 06:48:15.9535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Z17DJOoaykXXg2Q/4NqFmptMSm/jwruOjuUrAIdU9mcYrcrLvqO7c1kwvjpW5thidTj/82U2DAuzey/Ij0d4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8011

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


