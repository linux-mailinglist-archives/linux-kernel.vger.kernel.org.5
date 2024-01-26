Return-Path: <linux-kernel+bounces-39658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8512383D4AC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCA17B2407D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 08:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D311B974;
	Fri, 26 Jan 2024 06:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BAbv7aNG"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2088.outbound.protection.outlook.com [40.107.105.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC60E1B942;
	Fri, 26 Jan 2024 06:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706250316; cv=fail; b=oY0tmqdz0C31wZvFfyDrwLED2mrQsZcO0CEQjgaqL3buLwGunVonhUyCEsvQ33HvvPfstOCGxW6m07IAxjaeh1ymTgSlXPKEqjU/J40YacYZHKQ5Jgk67DFoIkQSRtgaPaLn4Z6+N7W++1VtHMpZHLsx8V4jLVQLNcpshtgcedY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706250316; c=relaxed/simple;
	bh=K/S6pyJUIDT0tXIlmXhJJFSXcOymqJN+bu2cfQyjZYw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=tewkOZeJNXYMhpakky+vPIQ7xGRYe52BYRL1BSsWjZNt4JjgAz5sVxNOjtJoKR8NAB9xBKReSlZ3K1OzEX10n7Mrl8pnPhjr6mE7fpIboZU2FLYUa9zoKJHMg2GBhr6a/gTjZhhc/OR3VBKLcIZWUCPDCTKr22O1+SQfZ6GRL5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=BAbv7aNG; arc=fail smtp.client-ip=40.107.105.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWiyYbWUePhRkqPLw9rTIreo+H/tqJwswxO8/F20xHB+FqnOEVd1DdM6KofgQb/HcU0olEctPFzNGXfHUwscGp3F2U22qbmPYtepnqQSndMWFeeFEVegXDzHJcpsBMCXy2T0jcGo4R68wsJXbJeIYV/9JpjGX7OzWjy3G2i9uY8VAhhQHY+cL4BeyE43MWttqN1Sf4CCtdtr7GCy5hI23sZSoVboCr2LZe0V15O4YBceds0a+R2fkahTea8WisnRs0R9CEXTR1HdyPcr/HnObYmBUuzY1kn6BV8KITKZDO0B92x4fghrOgtal3AkKCsMFD4M8kR6/KLQAxCHmVjP2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcXrRKBabQlOTHo50b7cbdxKf1Mnfm+dGC/o8m8tAJ8=;
 b=ATJQTBbOO4Oo4hkDCXX9I4MCJo8UZ7sFRGcbzzMrtovd/v9IFjvV2grZZcI9PAvYrmdZWxe8DzI4Fz1L6vZLYYfqvaRexfEIps14HidNlk/GiEQjCWlcIZ5bXrTJiWmmoKksKz0Ql4SHFU2r2zl2mVrx+vbOWLkX0FARfghrrWYzw/0Qkvipzo2J/MxOw4ymckpW2QoeYLOodTAN0boF7x8Dv788wP9Sh/q4w9tn3W8YEue0tMTFnMO1U1OAj22LtVD4umWBYE8bRJtZYcY/guMhdpMidpN0y+69kTolm3DUJm2oz8RVs1sOJttmUA/uR16Sov8aPiH6eDRBgHmumQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcXrRKBabQlOTHo50b7cbdxKf1Mnfm+dGC/o8m8tAJ8=;
 b=BAbv7aNGuM0eyrgCKckb/5YkfbhaarbTjr1gk9d4wYJrs+zlLo+Pv7ryPQXAvClwszkYKNyT5MoQ9AAJfxrz1nPJLdleZIOGFt2qh40sld7pwGxxd3JO5p1ZDcGQSiysJ3Qenct4xCmZkPCEpUFawh96qoYJVgSh8U5HFmo6hH0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6851.eurprd04.prod.outlook.com (2603:10a6:208:182::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Fri, 26 Jan
 2024 06:25:10 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7228.022; Fri, 26 Jan 2024
 06:25:10 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 26 Jan 2024 14:29:16 +0800
Subject: [PATCH v5 3/4] mailbox: imx: get RR/TR registers num from
 Parameter register
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-imx-mailbox-v5-3-7ff3a3d53529@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706250566; l=4351;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=ZIPe1ShyvGcJ7GWp7Z6UAmZB3DJN28oXn0B1jjJz194=;
 b=xIqAmhXo+Q+nsmIkZUvmIxxHiQw3+Eka12KjoYQknKGh561X9rhE0E5gHSLmIokCYoXtSteFb
 X6QBl+eraH3BFZkqUKXUm2P5v39n63aJsvQM5Tnm1y2+li0KvXNEUav
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
X-MS-Office365-Filtering-Correlation-Id: 77764ebc-407e-41b3-5f8c-08dc1e378c16
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	asFVqYRAsEM4yfTFpoeGCHh7byl95DdsEwccjJQH/MW6ltxto/GQlF52b8k0N8N//TJnfOXqaDZUL5Vw7jpAJzAuOwPnT3dkuol1dB4D5h7NxFuOVsvyuFrvDor8b2O1jzxFEL4qm2gWOxBAWHIcHU1HV+hW9iHY8U3nzFvYWeAUPF8dripCeObBg5x7s/hBAL3GqLvj4g7QF951KV0DDMat0BnXa8rjS2t5L9UXi/BvnKxnxuPJ48e614wsVJMMJ8u06b3iSqA9j54ZNw2NZHmLl5xCzzjpTtE2n4xV0+nlxIihtCbhXM3x1OoP6jYyM6pVfHzTGvWYJCO6yvFZuJRV/8/KE0uXld+sV/7z5B3c3NaaoJ7z4ChquD8MyDR4qKXodtHMAoMuDvw4TwgurEyAmKujvECyS5I4ftPSibD5xXY7naqRk/UVMMd4yD5hygcY4FdeXI88y+//gHogrZ/U//DNwXZzCvViYSGJIyzJub7n3U+lXr2DdKTcJD7vkmLA/A2wVPepFbjtQ3ZBK1FkeIl7la9PV6Fg1poa1EiogknJG2sphcf4muTNFyuPt1qBBjn87pISnYag7en5mey1wnbCkBW3N/NawC4BJy8Cgf+tDEmeRPN2B9iFrVX3t3WA/jRTL0ATAkdWpOpNLg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(396003)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(52116002)(921011)(38350700005)(478600001)(6486002)(36756003)(86362001)(26005)(83380400001)(38100700002)(110136005)(8936002)(9686003)(4326008)(6512007)(15650500001)(8676002)(316002)(6506007)(2906002)(5660300002)(41300700001)(66476007)(66556008)(66946007)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXFIUzJlYmlmR2hZOWlhZDNBVHhKTnh1UUNrdGYvaWVkNzBpNm1QVjN0ZDI3?=
 =?utf-8?B?VmQrMEs2QkhOajUzd3RGb05lK1dMVjZ0RXIrM3N1dTNZSVdkeFFuemZ5QW13?=
 =?utf-8?B?NTVNK2NJblFGYXhzSGRmMUJ0V2ExZlpTUGZVbUhPRXhBK0RFZnBHSEs4TERI?=
 =?utf-8?B?TEl6Sm1kSmUyU1pybmJkUG43Q0NiSTlRaHNQdWJZVXlodlR2MjVkMjJPVWhI?=
 =?utf-8?B?UFZPSUxGMXhicUV6T2U1VUZuYkVSU3VDcGU4RlIvY0RTTXJJRGc0RmFxbGln?=
 =?utf-8?B?R1ZXSXhWK0MwbHNyRDJ2YStyNmptYzBnbzRNMVliazhSYy84VEhjRFcrTGZP?=
 =?utf-8?B?QnYzRjZORGZJT2syeGpwc3V6VEJiVlp3cXBjNkIyNnp4OVEyWEpNQTNSZnM2?=
 =?utf-8?B?MzRSTkZPdHZUenZRTit0MGFSMmtkdVVkNjRIYWRKWFhKN3c3U0tpL2lVS0N6?=
 =?utf-8?B?a3BmZXZ0cGtLbng2TVRUSjh6Q01GV09GY3ovc3lIVXZCYlpIOXhicWtnUFAr?=
 =?utf-8?B?QzUrNXhJMUUxRzIxaU1GV1pLWTFDZW9oUkJvakRWdHdOTVRnbnZHSEltS2hJ?=
 =?utf-8?B?YzU0ZS8wMElQQmR0WTh2ZEpUdk43UklhbTVoK0c3Q2FrdkdUb29TanErSk95?=
 =?utf-8?B?WDJJL2Qxbm1PbWNXWWNBTnJGOXZLRllmZFkrclA2OG0yQVpsMW1WdDR3S0ht?=
 =?utf-8?B?QVFzZFZYTzVZVWFpUEVzQTNQbVhRY25VSjJ3NGYvVk9jNXVXR2VTZzZPTzRD?=
 =?utf-8?B?V09KNVg1UUw4TThoUUFUOWhxb0Z0RmhOZ2x2b1pDRmRvNDEzczNoajFkNTJh?=
 =?utf-8?B?eHFGWjUyRUZOWHJXMng4Z2RldS9GMnVlRmRFdFc5UjFlVXdLMlhPWjR0TUV5?=
 =?utf-8?B?cjVocUxjVDc2SEt1Mi8ybmdRVmNpYUNEQkVQMitxNml0d29RbmYrMHUzV0JU?=
 =?utf-8?B?Q3NXWjVUUWZOTmU1UmpvU2F2SThReTVDTFRQdmlpb3RYUzkyTGdBclFXL1VY?=
 =?utf-8?B?a1VmTHJWS012R2lzOFhMKzROemgvbzdzNjZQYzdoSytSMTEwNVRGc1Zmc3F5?=
 =?utf-8?B?OGlGTU1PR2QyaWxGb2ZxNlRtSnYyaGhZdHhna0IyODhBZllkQktiQUl5VG9j?=
 =?utf-8?B?WTFhZE1QR3lrYnB6RVZ0Y1RmSjA4bktmd1A0Q3lQRjloRVZZWHBjTGVhWEhP?=
 =?utf-8?B?cHUyV1lvRnE5MkJlQTA1Z2ZXb1g2MGVyaHZyRTYzM0VxQ0RRU0FIWWZwd0NT?=
 =?utf-8?B?Zk1UcWU1VllUZWRSaFpMS3ZSUGF1Ky9lVGxtbDZMYjd4azJsZnViUU1mZERq?=
 =?utf-8?B?ays4UkRxZ0QwQ2NLUG5aNlFiSlljNmJiK0hCWHgzbDc4RWpJWG9EMzRhR0FD?=
 =?utf-8?B?UnhUcjFIa1VqeE1aMUZBV0wyRlAyeXFCZC95UHpFakdmajVvVmdOOW9Qdm9Y?=
 =?utf-8?B?Qm9nSFRCWUdEbzhiUGJVWWw3bHVHS1JMNUZleEVpMWJaMC94d3VRaWJJRkpJ?=
 =?utf-8?B?aW9KT040ODQyU3VSQ1djcTVCeWtNT2hZaDR1S1ZlQ0xsNWhnV05yUDdKdEt1?=
 =?utf-8?B?SWV5WnpVNUZuWHhZbFd0R0FxbWZOenFnSVRZVXlGdmJUVVlTUlAwQ2c4bWVS?=
 =?utf-8?B?dG1vOW1tYnltSEdtMmJoWmtOdjBRblVFYXk2ZTF1Y001b2VGZG4xSWswaGI5?=
 =?utf-8?B?QnVabklza09OMTQwVEpvUktHdWt2NmFYMzRUY2kvREhLNnI1WTJRVEszd1Vq?=
 =?utf-8?B?cnNrajhSbWdwOUlPSG5jeSsrR0tDSGRLZi94NDlkc0FZMWptLytwK2RXU3Vi?=
 =?utf-8?B?QVNBeUUvZyt3TDhqemViNU0yMXRJLzd2aldsOGJybW95eG96MWRkWGg3ajh2?=
 =?utf-8?B?Uk9YS3pzY2lob3hxSUhOTXFDbjQ2U1o3c1VQMTdDQmtjMnVhMDNhWWtGTDVI?=
 =?utf-8?B?Qy9mWFhOR2ZreURseE5TSDVrWjlXcEJrbjgvcTV1ZmliMWFvTjUwdGN4bXFo?=
 =?utf-8?B?MUNrSDE2RlZOT1N6RnBvZXRnZ3RoSTlSTktQOXlTVTVFUnh1MWxGZ2JUZXE0?=
 =?utf-8?B?dU5pWkJ6elBkMEJLa3NCRnJscHQ2MzJmUHFpcEtHQVYvb29STkg0a2dJb2l5?=
 =?utf-8?Q?sHfOgZan13O7CPpXR3YoGwoSZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77764ebc-407e-41b3-5f8c-08dc1e378c16
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 06:25:10.2856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jk6CKcGcVGJEnwb5I6EaoSsqP9vEO881ejfVZHgZOK3omy7pYHL6+yVav6x1ADk7ZQq3AA60OEpayANeUXZxdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6851

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


