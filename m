Return-Path: <linux-kernel+bounces-37974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6000D83B903
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 850A21C23BBA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 05:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E33911187;
	Thu, 25 Jan 2024 05:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="P+GNyMdc"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B1610A3C;
	Thu, 25 Jan 2024 05:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706159768; cv=fail; b=gEJbwC8Myz4DB9m/z4l5GkZj708mtUbaJgySXcXnPQUG4PGmxhRs3JgHlmdWm7CXx6Cge06tmbUJszyf8hKDAhp9LHllR2gYF0kC4cuH7gkf+V8/4OG6+2QtnMFxzN0NkDxyXPFpZRY+oNOOEvLe0QcaB/y8rf9ZtWW+ArsM5Yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706159768; c=relaxed/simple;
	bh=Ytq/YKUFw5O5WUHiokG4DeEcdEZDqmMhKqH3lDOhYL8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=M6ajZWMDKiNqCOKC4KyFSXvM8rD3sD6+96Vq2z7FNTFtSLda2qEOF3bJ41CZmYtatBFAlU8gvs1KQzZ/QMVlZWisOlLGspUNaFQGZJDyRsGVG288sVSXHKUwxfAGKBumT6Hou982Z6XAoQ9E1vZpDG1z9VO1tSlORODRiykS7Jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=P+GNyMdc; arc=fail smtp.client-ip=40.107.21.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFLAcAMOnlHASGRa3ggznNurU31C7OZ+vqXTDZmxA6qN85RTf6e6uc+yBWw6Jyc6oi4T+nXVgy+XCG7jPXxnJ7v4sVhsGRNg6/ytIkNsAsqC0JMQSNFscifbrEUluc4o49puBAhGlbCQU1xFcCbt9uY5eHozvJE5bq2htbKP8h1HaDkIETz9lV8WlAqCyIYMVxbGlVqp1J9L1rlbzKq4PB/S9eF4pIxsgRCoYfDHLBBBHlY/ZQroRFfHXMRq6FZB+tjKn8xWOhMg9eK1HkuUjdx/AUHmBi0Ll6lu1f5WxxVdn7Z4Yh/wHkGl0JyTi8TMItKwwW+7HqFsRRZ3nFYJ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjHoK34g7+uBu3xT/B+UpWr/KWX8YJRjxsgH0FR0FB4=;
 b=e8xvoDjMFNOaYYGfNaQju9Ya6oargDIps1jXsQasahHfZa8azDh4lY6Vm2XznbGahN5TyRO3R5uwkDtzG8bFv5aEGlAwqmavWYp8iluF8SJhDtQQaSWFOrNhdcnWdyI8Qma8S2FYa8f5VJwOKOjtAPicXFuzygsd9DWr7vy9keRE5I8WjqjIu7aqX+QtbMUT3ehB/9EDFhiR02Q5mbmLLXMbldl9boZ4xBOap9tWanS/31xW50ryIz8RP2AFAZwlD4mOjiLGfLsEr7XdY+UAoqSQNdoE9F+uk/vD4+QAPxCxWbsS7kB66CGjjYeXD95UTHf72XtjHNWSebF+qUyfWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjHoK34g7+uBu3xT/B+UpWr/KWX8YJRjxsgH0FR0FB4=;
 b=P+GNyMdcmpY+aCyXqc9KQ4zXNSIZwSCjB2M2WExkmIdNmhe1twb1lIhGlDGIJUQf0BfNo3lf6Z9XZfilMar2QsnU8uuXBC9udccfOcN1jw/gwg4RQXsG3ZlUKclcow27/Wfr0cUomf8sBvmd93Ao8J7wSq5EtTz0PQ4J5kCcQDU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8275.eurprd04.prod.outlook.com (2603:10a6:20b:3ec::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 05:16:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 05:16:02 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 25 Jan 2024 13:20:05 +0800
Subject: [PATCH v4 3/4] mailbox: imx: get RR/TR registers num from
 Parameter register
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-imx-mailbox-v4-3-800be5383c20@nxp.com>
References: <20240125-imx-mailbox-v4-0-800be5383c20@nxp.com>
In-Reply-To: <20240125-imx-mailbox-v4-0-800be5383c20@nxp.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706160018; l=4299;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=SGrBffeqt2EmFannia/RLKGbk1G3zr8UaibaUsZBgP0=;
 b=R4B7JnzRAqG3ojY0Y86IJU0x3iLi7n945yzBGF7LlmjUggxllT7E8Y5RauMxE2UEc3x6XMl6N
 k3vhOyvhUy6AD2sj8epx7LcQjNY2uGSubQ9rI1Awa/qi7rORsdvK2BH
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::22) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8275:EE_
X-MS-Office365-Filtering-Correlation-Id: 03ed271c-086c-45a2-4d26-08dc1d64b942
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uMlW3qetcaOL07KG0vqd6u88UdYnN1LShS5QRwf2DkfBjsrCwmBMZWxcFNr7ryRyyC8cfgUxgyvVMqTTp/1bB5dTYuG/50rOSHxIxf8K+2/3XzGFauQ2uK0r3FXk1ILyExo6HArVnp8WSYEEj+aiuUG0VLEuK70cUCEZB1ddrz2Tsn53vtuV/fT3LKY15dm9O5npzlxF/Eh+Moze5tBVUCM5YScw7qUWJ/hiSJ8NilD4PUWFyQgQvxoXgCbIR44sHAIfWqrzyJVDl+N6fZD7A45XwOQwElWZckcq/RWnA7FbTs5ddRl6eWffF+oh+Z0Tf6v/x2SjfKYM/CpC/dnLSjLv2+dJfQwFEpNufKEb2HVCkRKwOKk/v+KSKBRauFOGLCbWhGYW3Z4XYzUdACYZ/uebswhT7vXKl400JHryYGNDyBRTnWLZ3Q/BomtMmRaPdukUjyIkqY1EwwjUxsIFdu/nbyh0nVpQPcTO8YaQF6HPwDu5o3SfQoFc8tjUxoDWZnECg7KNNFb6pN/zPXOmWgEd96n4KGCMKYhNDCoF+6RmPk0KBQ9jRg3MYwtTRII6ncML9/3EdexOcT1OjzUrTqdnGDeDFWryZecENN1bEhcXU3e7VpydxFc2TnynDu3WIDL7y4v60x6jCm6zJAImww==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39860400002)(366004)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(921011)(41300700001)(26005)(38350700005)(36756003)(9686003)(52116002)(6512007)(6506007)(478600001)(6486002)(83380400001)(38100700002)(316002)(5660300002)(66476007)(15650500001)(66556008)(66946007)(7416002)(86362001)(110136005)(2906002)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXMzQjd0STVGVDdKTkRUYXRKTjltK0w3SG02Q3YwdS9FK0VCL2xKZERQS0lz?=
 =?utf-8?B?R3RhV2psb1pqRWlnNDJIRWlxNER2NGM5U1pySUhkcE9hTXlMaVQ0ajlmRXpW?=
 =?utf-8?B?RDFHdGkrUGJPQWlOVHhTaFV5bGd6Qi9DMkdBNGtrZmgrd0g3SHF2ekxuRDNr?=
 =?utf-8?B?OFpwTzA5dVl5aXFEclRpcWszZitMMStKOUN2dkpMUkFhclVjamcwVEZjT3JU?=
 =?utf-8?B?ck9kOHUzZ3IrSUxuQVpQN3pKeFVLNEpEQXB1RmZuM1Q3TW5xdDY2c3NSTmtt?=
 =?utf-8?B?b1FVR0VWSEpPTGRaQlF6Zmt6L2NXeVgyVlNTNXE5TVVwbndXenZBZU9zbHln?=
 =?utf-8?B?bDJZaWoza3QvcmcvYlRxY0RjdVNXTnNSMkpQVFNwK29YZ1pjSnpXdFVsOURW?=
 =?utf-8?B?V3ROYk5RN29FbEE1OThiZ0Z5a1NIY1ZDdWtvWEhCbTVJZi9jd1pSWmVvTlBV?=
 =?utf-8?B?UTNtTDBSWnVMVmYxT0xPRDJlZGxheDVlVVErUWRCbHd2a2xmdmZ6MHRJcGZV?=
 =?utf-8?B?RzJpZVdjeXI0VDU3cGlLK2dqNlFPR080RWJyUFJHck5pbGFteWlJNHhSazVy?=
 =?utf-8?B?djV4MktDR3JkbG1CRnd2L2VxVXMvUlE0WlBISEJtL1M2VlA0dTVOVVcyMjE5?=
 =?utf-8?B?RVhvcGxYRnlDU0JiVVpnVjFIZ0k3cHN1eDhkUHArNk5laVJKaGtTMUdFM0ow?=
 =?utf-8?B?YUxpUTNlSDBFVC9uWCszVk54Q1h1VHhEekdSSEJ0NWdCSWFFN3QzWFQ1bWRB?=
 =?utf-8?B?TkVXb0JHVlo4aUM0VnBkM3VBRVI1bmovSmNwS2NTMGJBcHBWWktXRzBtMXFJ?=
 =?utf-8?B?RHphYVBXQllUSW81eVl3eTZnN1AvZnRUQ3JFNkViUFRIYUd3aTlhanppWDR4?=
 =?utf-8?B?NUFNR1FScjZPTEdHSDQ1S0NSM3E1c29iMGt1cjZHcjcwZnVSNXNDaHI0SnVC?=
 =?utf-8?B?T2lxVnpBbFk5RnphT1BFUHBZR2tDc3RKRHpiNGdwQWM5b3ZBNm5lQnZ1SjJ1?=
 =?utf-8?B?cVN2Q3ordm5GSEQvZWVEUDJkTmsxalRJZER1a3kxQ3B5RytSbmR6bXFOTXZr?=
 =?utf-8?B?KzlIb2k5VVR5ajhUeXB6bW1VZDFXS1gra09Kalc5bzhBZ2dLQzhiVENkUGwy?=
 =?utf-8?B?WFlHeDR4cG1LdWh5K1FlNWludDhBamNkVGpnYmZidml5QlMvckJWV1h6d1RP?=
 =?utf-8?B?dXhHUTlpRWsvMnpXeGVwTlJCS1RyVGNxVDl0QVk3OElhRk9Wc0loNmVZS0RB?=
 =?utf-8?B?cUkzRG9yWEFSTkFGdThTZTZQU1hxSXFLTXh2dlV0VWpOMHdaT1lETVRnTnpL?=
 =?utf-8?B?L1Z2bEhyUTViVEMvUHNWRkhMUHBzTTdxNFlxYzBtMCs1R2tZVDFCVU5VOVd1?=
 =?utf-8?B?cUloOGhpR1hDQVZmdTR6aEdpeXFmdjdlRVdxS0xRTmtINlU0QnVkaG02Vlpp?=
 =?utf-8?B?VzlSeUJaaVFKb2ovdTkyU3FvNHlvSG0xM2E4ZHYxSitoSDV3Y3EyNHhIN2x6?=
 =?utf-8?B?S0krU0FFdFROV3FINUMybHNQRDAyaVVoQituTExDcndCUXBrVERQQWFnMkdp?=
 =?utf-8?B?cGQ1S2ZYNHJKdzJNci9waDNvcjlHSkJxM1lGSnU2UUcya1hMei9qMUdYbTRu?=
 =?utf-8?B?TW9EbDFVbVhIbGx5S3NHZE1URFAwVWx5b1draDhLMGtjQW1PWUE5b2c1RFlh?=
 =?utf-8?B?RUhJT09WTFExQmlpQmthdHBZSnI2aHVlbmZJeHJYRER4dE05Z1VKeEEzTG11?=
 =?utf-8?B?UTVKU1VIK0QzVWNWREdpUDljRHhNa1grTllNOW1ET3BBcWxjSHlDYTJQQ2Fw?=
 =?utf-8?B?SGhuZGtSNWJNRUNQb2VnTXlQUGJobGpJYzg1MC84aXh0V2JxTjRLQzBib2pz?=
 =?utf-8?B?UXVvNStCcE5DQzBrRElXeGhjZEllUWNqNHIwZTBHdVg0RkNBMlZ3VkhRZHhi?=
 =?utf-8?B?OUJpMkl5VUJ0elQrbkZTTFFWWnJKNDNYVkc4alg1a2E5Z1RCQWQrVzVOMXdk?=
 =?utf-8?B?eEFGNThsTHAzdzhKWXNoUkE2VjBPVTZUVjhUUW53MkRhV1lRVEVHMGhYRTVE?=
 =?utf-8?B?cThtUWg0WStreHRnaUVBTWxHUDloZ0xnRWUvQkdGY0FKTGhYSG9hN3dOSy9P?=
 =?utf-8?Q?X6Gn8El+cCy/7ot7OOZTYoQwd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ed271c-086c-45a2-4d26-08dc1d64b942
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 05:16:02.4074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eclb3f/oPAb3sG2oM2bLhN0xlFWdAfl8C4LVso0YXfBXLiB66cw8oDIhGWOOinMeLPUJZUDOfcxc03D/Sixc7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8275

From: Peng Fan <peng.fan@nxp.com>

i.MX8ULP, i.MX93 MU has a Parameter register encoded as below:
BIT: 15 --- 8 | 7 --- 0
      RR_NUM    TR_NUM

So to make driver easy to support more variants, get the RR/TR
registers number from Parameter register.

The patch only adds support the specific MU, such as ELE MU.
For generic MU, not add support for number larger than 4.

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


