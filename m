Return-Path: <linux-kernel+bounces-39657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B026283D4A9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A38351C223EB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 08:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11EE1B819;
	Fri, 26 Jan 2024 06:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Y/wQuN5h"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2044.outbound.protection.outlook.com [40.107.105.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599EC1B80C;
	Fri, 26 Jan 2024 06:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706250311; cv=fail; b=a6GPOlcXtkyWZ1ILIyZXSMj9VwnicVmsIQ9CTiw6+X77cF6H1j/jo7+IFmQfIk0PrOupQbmM+4a/0pH0639fnTMPER0AHl9D8dL1p1MIb0NkO4kp3pvv1fn34MXv4xII+8fXvEEuTRkwFkwwuV9nuxnrkGDWSCP4ZQvwpkhL4kE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706250311; c=relaxed/simple;
	bh=2zJxqBVqaNuhlGWo42e1QHXlvX1q4/WgIXGzbYmGZIA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=PrI3kdCcbHgYWbDhuLXT8zpH+vP9ZBDay9wlcgIfdbTFyWxFLlEcAIJKq0dDVoZK8/Lb4dP2OTBDxrdcnXX9aCbooyKkH/5ANwl4G+QpF9pIO2r/iNsBW5kmsPyvVAfzUK4vmgHgxbhC75pNkkXTb10/U/95IuuKo71WGQbU7pM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Y/wQuN5h; arc=fail smtp.client-ip=40.107.105.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSO6PdL43qxY7vPj95mFGn4P/GkEAqKKhi6u5bUpCMMS6rl522jT56+LwvsQ5+Ef1yV5uGz4zG5mkRuDAS48XeI1w0ltbDDa+VhKl6mRrhxILUl2Q4cB1azmZXc4Uwp7ASvQi4cV3wIrj8IdRUUSh6d1cKXDL5dsKvph6BAsOR4G6hUsLx9neBnIu39rwEfu4Hg7TMhf9ZdkjKTTNh805FKrq2fUIQ8KBHPvWop5vXTk18Wtgu+jFitc7wb+lnrU5jApjpCAcUINoFJt8ImaLEUYYYFHjyPWfUO+95JFZv7pxlvw5OqBbgd7SCrFR55mQkrFX83IoThkV5rofAy4yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yroYNvtM+ftxkBYnpAH09lTiB04eMcTiVCGoXVH7uV4=;
 b=FtgGTUfbTf3FzRv3GJBhR/uhcCEexfnII0aaOLLv+Gjo9Uq4QwS05V7XLrY3691g5SH4dIPSywB5CanC/VdfmERbN1eK5PGSaud1oTi0SrowWkCVQ/PbSZvAESvY8hemPdrBamLfMm8e5li6s1UnJ0b9rCDNEOFNUsvNSTMHwOWKgeYGPvsj+1OV/sO5TjMAIwYhHslm6ztRyCvnklLi4O4iVjhKUkxbdfdJtUlr14WbiBAodlKDyaraTCysG6bopOTeYat2tS8BFbwq2Mv5vLxbComafVzkSLLwbSOtmCRH5Y6VKQisM7gLBxIkRnZEFD2ojah/I1IMEAl/xHi6Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yroYNvtM+ftxkBYnpAH09lTiB04eMcTiVCGoXVH7uV4=;
 b=Y/wQuN5htNJhbCsFEHzYhvI81xtMvI4mQ3YWqs2xzbJVrhbnzJxW5ykIOtI77UBoeo7aS/aALZmpQMUTJ/Wi36vaIHvvODvlbOXa51qQCQ27o2p+t/QtVdeU2IkMh4EYUadxibtJWW6zQaTvNrwmlnJWYx7/DDjLYdk1q26Qv4Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6851.eurprd04.prod.outlook.com (2603:10a6:208:182::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Fri, 26 Jan
 2024 06:25:06 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7228.022; Fri, 26 Jan 2024
 06:25:06 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 26 Jan 2024 14:29:15 +0800
Subject: [PATCH v5 2/4] mailbox: imx: support return value of init
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-imx-mailbox-v5-2-7ff3a3d53529@nxp.com>
References: <20240126-imx-mailbox-v5-0-7ff3a3d53529@nxp.com>
In-Reply-To: <20240126-imx-mailbox-v5-0-7ff3a3d53529@nxp.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706250566; l=3395;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=S0DKuiQSDcYtu53JqBC1+gV1zoHcWj4DjQyGEWhlcnk=;
 b=jzwjXdk6JYvqSvpdfhj2R1+TiUmh6bgnYKbWAMzrwdDXFeyfpWI21aOV/W1MbJ9SdcRl3ZhA0
 T50oGZzFFiwBQZ2hnG22aAFHll6MprwOfD1g6baWUl2Twy0gcg4eJAG
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR06CA0215.apcprd06.prod.outlook.com
 (2603:1096:4:68::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM0PR04MB6851:EE_
X-MS-Office365-Filtering-Correlation-Id: d287da3b-962a-4995-28e8-08dc1e378996
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	x3M4sOSnCP/lmFZMkyhtS6GAeQTXI5h1xbee1lRwwZs4oYlcf3NtAOVSJaHiBDEYIW0r8UU2kT0HsMxz8uJEvV18S+m3+F2HPzYqZGvkYPmZMRFM+TPALwvm1wErzRRaypuf8sMB9TzXgKAbHxoBY+nhS1dHK2/Gi24S+xBWzwlNBsP6qw0uJKGgkTGUs3jvgTN1PPC5H/THApIWa6lZuKf1a28ZgcpmbjLsVa17LYnNugpL4onkFPc0Zp+QbTjZDfG4t5cDBncrq468hpwaYIUZdvG3w3ZYv5JqlwTZrg8lDIKvFqszFwnYyq+4MlBMUO+D2qMdsq8rNcGO4P3xd4+ISdrO+L7K67H2PBsUTVydPd6HoxHdWVzuj/HHgX3JvXXRkmW8G7pKlpZF7tw4qSl7cXl/Cr4/lJa0ts0bvb9vp3ZwFOZUJq9VAuJXw3IiSGKCg5S/FVsnnnroFEu3PtlBVOzgiYlrugBHHzi9ImeIBXoQLjQsYeDoDtmV7AihKC/+Ihhe32Hy8lqKIOwJ6DFrmzbtiUhX5E/fkVWt8p/e6nsDGBnvXlvlzqMFK8C1rDybqrb8AIipm50XpuJ0/OjiN+0A+lj7JjSUnulfChSav4Lvj349ni9ogZdWTZNU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(396003)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(52116002)(921011)(38350700005)(478600001)(6486002)(36756003)(86362001)(26005)(83380400001)(38100700002)(110136005)(8936002)(6666004)(9686003)(4326008)(6512007)(15650500001)(8676002)(316002)(6506007)(2906002)(5660300002)(41300700001)(66476007)(66556008)(66946007)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3BaanlDVnp4SlFQMndSZ1hlU2VWOXRFRVlTbkZtYWNHc1p1UGtwUFdZS2Jy?=
 =?utf-8?B?UHliTU5ISWV3THNuQUZDUVRVaG9YVWRqTEFZbW1DckMybExiVDFLMjh5WWx1?=
 =?utf-8?B?THFjUytLMll0dUlOb3lEZUZnQWRiRW5jMnh2RTd2amZXU2swaWQ4NzhDUW5H?=
 =?utf-8?B?MENrVXpaVkROT1RUeDdFSDlRaDc3LzU0WkxJb1FJZkxxS0xjNmd4Y2dIRU5T?=
 =?utf-8?B?SlR3MzVoVStRb29qUVhzazBMc2lUUW8rQThVaGRZWGpmb1dNcVorakxidmZZ?=
 =?utf-8?B?WGNmWityejc4Qmc2alFNd1VBemVkaXB3WW1yVzMzWnJ2akVaSGlMR2hyM2Jz?=
 =?utf-8?B?Z0ZWT1VXR09DdnpCRWpYNFRvd2hwTlBLUzFGeWpNbnFjc2xVUjJ3TUV4SWIr?=
 =?utf-8?B?bzFvZ2lZZFFNWEdnNExsSFVtemxlQjZld1BtSVdSUFlRVTdwdU9LY280ZjRr?=
 =?utf-8?B?dVYvbHp4OUhxdHQwTk1DYWkzazd1bXVrZUdUSW4vRkFleVlISDRxa3ppV0h2?=
 =?utf-8?B?a09Hd3NKeWhmNU04UkJWSWVPWDZseXpSYlRsT1prVDdXY3ZmN1doZHZBYkk3?=
 =?utf-8?B?UTlBSWt5YWk3L0puSGwrS1VQcjgzREExdVNzMXlvYVB0LzdDNTBYOTc4dnVD?=
 =?utf-8?B?Mk5veFlmK2k0TjI5d1JRWGF6MDhUOGVlUWRRaWg4c1VJZUV3YXVIcytaSkhH?=
 =?utf-8?B?NDRaOU5xTUpSUDhPaDJ0VzcrNUpIT3IwTDZZdnFrWEZuVFVPVjlYTnlDTlRo?=
 =?utf-8?B?SWxwOWlteU9GVGlpYXlrZGNkZ1pFd0cvRjNCWFNHZG84SlZZeFk3cmM1ajNx?=
 =?utf-8?B?SzRUc3RFYnNDNm9VV0lKdEpYc0w0UzMxVGNob3FGaWg1a0lpRVdrS003TUFo?=
 =?utf-8?B?OEYvMnVvM2NYT0lHT1RwTTVqQ1VNYWlvTVNSZXZOTk1Sa3NxVC9BQzdEcjhw?=
 =?utf-8?B?L1FvdFk0TENISmxEK0tIdEJ3S1E5U1ZoQWdCdE93Y0xYSUFGa28zRUhpOVc0?=
 =?utf-8?B?ejlsQ1V0L1d1UnczMVJJSkRpdmtwWWg4UFc3MTRxMzdrbUthUUkxMkt1TWF6?=
 =?utf-8?B?RTcrVVM4a09aNFRaSjNTNllnWU9oR1NNUjM4RWJhVkxDK3RFMnZhSmlqK1R1?=
 =?utf-8?B?WXo2cnNDMUUvOVlpbjhVM3hMZzk4c2IvR1IzbTN6VURiS0MxUUpMYjBZUEo5?=
 =?utf-8?B?MlNGdUtoM00rb1ZMRGRZWnB0bGgyUVJHQmdMUUVOa1AySE9aZkNIUkNtRTN3?=
 =?utf-8?B?UVZrNW41MzZocDluZmhibkVmUUZOa2c2eHU4YVBNaFpmaFBLR1JFc1lKMFZV?=
 =?utf-8?B?RmV0TE5WdWpQeWRMQngrdGRJWGppQkRMaUhVNHQ4OUFYM3hLUVhzZHRnZGdx?=
 =?utf-8?B?eEtDczZiZHYxTFFGdkpKNXh5RVBFcFBQZVNnYmtXUWlLclVLR0paYVBhRGY4?=
 =?utf-8?B?UlI1c0I2RFdSQkk3cGI5ZTdBMys3anh6REJBdDU2Ukx4WktaazN3U2VWYjJh?=
 =?utf-8?B?Z2JLeHVGaWhUS0UvSHdoVzBzVE5MYktkeEtuMm5uNjdwRm1taEhjUWtDRXhG?=
 =?utf-8?B?TC8vTTRsa3ZnMCtKZ21MTlhaRXZXSXJVZlBjSFBDM2pOT1EvS0FPQWd1R0l3?=
 =?utf-8?B?OXZVM0luNzNwazBYK2RuVGgzWlIzOC91SXhRNkgxeER1bWNWbUtqZDczWDEr?=
 =?utf-8?B?UVZYTmdsZkpLQTRpQXpaUTBUeXhvTkYvMXNRZ0ZnY2hZZGpCdjBkZkVpcE15?=
 =?utf-8?B?QUhRLzJTYW9ac2FDUGMyZ3BuNHJMKzZ5V3BmMnN5cVJHS1g5U2U3VGUxSHhn?=
 =?utf-8?B?aXAwTks5aUlDdy9Qb084TXR5UXJJem5zZUNReGlYUlFDNWs3Mko1WFdFMERu?=
 =?utf-8?B?dm5kV3BOSnYxL3dwZm13S29qaHJXM3VvSnNNUzB0eExjS2N6cVUyeEUzVmpB?=
 =?utf-8?B?RHZwVkRMenF3N0xYTWlJOXhySWx6a3VFQTRVeGJMZGxaOVNOOGlHWVhIMUtj?=
 =?utf-8?B?aXZqak9iOVNuZzl6ZUtjcjhFYmIxUElyZEpJOUgxejAyOHlMb3JrOTRXRTlt?=
 =?utf-8?B?bWo0YUJ0K2VTOUQvU1QrTlJQMi92VG5sVzd0OTBQaElaeUtOMkpBZFJaRTVt?=
 =?utf-8?Q?8DTav5pVxX1wtjnR5WBCAEQTo?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d287da3b-962a-4995-28e8-08dc1e378996
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 06:25:06.1049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2CU7wChIrJOMAwOrGvzY6SBmilILBo4u5OvutqfbFwsexWWO3Lh74gceuOBXCyLDEjUYtZdYcs9TrUDNg6Q7Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6851

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


