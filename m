Return-Path: <linux-kernel+bounces-132990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AEB899CF9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 555D11C20BCA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390D716D33A;
	Fri,  5 Apr 2024 12:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QX5v7o9w"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2098.outbound.protection.outlook.com [40.107.14.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF6316D307;
	Fri,  5 Apr 2024 12:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712320305; cv=fail; b=M4EkRz/DJJhOi4d9WubFKZ57d9Kkx2DI+fevxneqAo9FkLWJl9BuFQcvb0baRPG34cOfTIo/2csYqMQBqwLg9kGCT6WuH5bbYOySANf7wm+do8znCHxNQpTnO22MaH0NFDAUye/79V4vWTJdahIxqVfkC3x/ZwAiXsXtdGhP80o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712320305; c=relaxed/simple;
	bh=KOS1fMTnSlxPBGgDLiRCFGLt/HM0/qdbCuH8E69P9xE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Uc8CsF3JB+tENzy8+c3jkTusXsLnfJ7O9FA25cQ+RKsnOBsCBKn8zHz2/vs4iyvlamatkNtp/Sydtp0Ue9c52DlFP+rxXPmwzoxp6cBs5HPU1nBr4kc434qscgEoKz8dtUi0qp5u1HMKBHOr3mDxhlwxbjRrrkP8tyqz+czvs+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=QX5v7o9w; arc=fail smtp.client-ip=40.107.14.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBWSKW4HwwJjL7Ep+rXjR84H/PurG43Ib7kDU+Vm8+HUTcqcAJytwPWIDaVGu8+teZSSauc/vBE57e16OUmBjVLrwNWiT2U4pZGfjqYBZpBjEhUjdQa0/VYhUPCvMcsXyKjQ8ZWVP+xx9u3Lqwgc4o1vK7E+rKJc29rGR+moYvXzGsa7wDMjXTioGBhfs3+le+EzwBo7GblM7I5fv3r7Z7WtZBuajhHgRvrMx0hkffD/fdr4DrOuirboKRUunaKUB/c4wotOhQ22wcctvLjnwVK8hFKX/6NEi115j1dTNK+gzQqIVY9+2urUPklyJ3vWMkVFkYlduLIqq7oU+a0nfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIrAYHJD3ymVgy/ukproqrrzJHlE56llh+9tPgyKp0o=;
 b=k6/1gvNc19yBWCxhqgoyf1EQSs3pC8tLUPwaRuc4xrLEHvZNOcCOf6DWOIQjza3Av/WpD2xe869M+/ahvStTqBjg53EsePRlW/AoyCZfr7NuYRJFOf+KexaG3MitfrrH+KCEcsacmlyP9mp6WB41trFgCgiE8j1my4S0RGu5lHO7+6qhWxcYI1/3kqRUWZLneCLH7ggsn+4yipX1DCkVEwvMJKCtP9XpNiK5qGhVMm45joDoqpvs5G7XRLI+JwSmU8mDJxXXVpRrFe8IHjHa0BLZOeY/YCo/S2ybeK9aQAQOOHTv+1+3AnT/sogh3HjlLAkWfknL6bnaBvN0Ehg1GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIrAYHJD3ymVgy/ukproqrrzJHlE56llh+9tPgyKp0o=;
 b=QX5v7o9wORXl08s5uSSCpEjyxbPfBzbVhpyOlYua3hPirFDUhbIaMQ+vQy0h1W7dGsJGODdBqNI7BeMKU671koQiY3XjRumXMbi/6nftRa8mLy7yyU1OpTXhod+SQC6eSxr3nsATEGs43j+IjQGvQzWEDIcVYmhwb3P7xJK7Nkc=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7744.eurprd04.prod.outlook.com (2603:10a6:102:c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 12:31:42 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Fri, 5 Apr 2024
 12:31:42 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 05 Apr 2024 20:39:23 +0800
Subject: [PATCH v2 1/6] dt-bindings: firmware: arm,scmi: set
 additionalProperties to true
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-imx95-bbm-misc-v2-v2-1-9fc9186856c2@nxp.com>
References: <20240405-imx95-bbm-misc-v2-v2-0-9fc9186856c2@nxp.com>
In-Reply-To: <20240405-imx95-bbm-misc-v2-v2-0-9fc9186856c2@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
Cc: Peng Fan <peng.fan@nxp.com>, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712320792; l=884;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=lZELwg5Facpp/lW5lmbNGyPbb53VuKGtVUUGB3YN3gs=;
 b=L7LEle0TWxTrxLLMwUZaxlTtYH9Do5x3OeJrBK/7pG2abqLibcEKIwhH+WeCe1xoCfxxREHAb
 Miau3NjRnvgA6bfJSZ9rYQmhShxJM6zPDS/At4YxObjd9QfAfIz41+g
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB7744:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4oeRl5COufZZ3qieCCsCx7VFdSDe39bNOqYvRPo5wz+wwXETHeGFJhVFPsersK0cMqMKK6dEV/Us782aJJ/j0UayBYA9UeACX+eCIVLdd3xEUUKe8q5+cEY4wfANu+icm1Q7GURuT96dnWLbCBIhS6un2RQEt0vayIo0QJCAKLVvRNcrIXhNicJCTDYDDh1CGpbu4C7EBkGxM22t2ejOKqG5W0BjuiHsuO5a15eyuIF0l5/m2h9hL0Qz1lu3NTa+qZzwgyq9AvCQAXZbEMDWRvIC1+avfl8y860yHeNWW1E0OwNfQmpCdwJrpswEMIaQQHOPHQ4rntcKVCZ6P38vwLep/X2fpGbAPjdroWOEOsqLMEsBUluPv0sr5pktha36B8KubzpOA1Nl/bZ5v48DZIKBLenmWWjInVQQzsM9/F1N7xRtq8bofoiuELVXWULzwarH7Uk7VAyiKLqYhMksgfIV26Z/LYaq+7iX0DPhyiUky3gShxjIe06H0jMJzD263KDs922HewMCsHj4ZryjZH5wm59Z9ZqBQiR4/1ROh2WzvrUqmWPitZemznRnM19HI9ue+MbIvcIFMjSWQVJyx4KBxmVUc8wHK2ciEMp/aP8HDLW0L0Sye9sYyGD1xmdy8ZQtYclp8eVIT9aKeIXHz48aAiNzD9ykSuUJ7W0znJ3K2EnzYz1yYjWQ9cBfTaEVbfGjE/7BRf1j0m2dTcvTN1FQbF4EJX9wc0+kWe3oAHQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(52116005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlIrL0JmUEhrZ1A4cDdUQVJEUXZ3ekFPaFJ1YkJmcUw3c0FZR3Bsa0pLem1t?=
 =?utf-8?B?cVNiVUphRE9IZWlUQTVLWlRpY1F4UmRCaGNpQWxvZGZXMVQ4cExOZnBvUTV0?=
 =?utf-8?B?K2tFNlJrTDlNdTNkUjFNeGpwNWJscWdYUXVkNW9LTFo2UW1MOVZKRnZQS0ov?=
 =?utf-8?B?Y3BHY0Jpb211TEpEaDFBMHpvbk1weHdkWm1oZUNTVXl1WUFnSGJBTGxJTVpN?=
 =?utf-8?B?SmdhVjJPU0lwb29hMVZyU1ZRRWtlbTU0dVljV0x5NW0xWjNNaUxNbjRRREt2?=
 =?utf-8?B?bXRYSWl1L2VsTVQ4M21oUjZPRnRoS1QybUJiOU1LenBONy9kY29tYmU3Nlpl?=
 =?utf-8?B?cmFVcHpTaDI0enpra1pmNFk1eDJFbTUySWdwNk1nMlpjYXFaK2MvdDB3UU9h?=
 =?utf-8?B?WFVYQ2h2MEs5WldKR0lCWDQvTjRZb3NpRGN2cElmbWQ2N2RobHlCeVUrR3NH?=
 =?utf-8?B?Qmh2REtJdkkxOXNRV1ZmVTZjcjlRM1J2clM1Wmp0NkZaSTZxcERyNS9lTFI2?=
 =?utf-8?B?SDMxYjhuSXV3QWxnUVcvSXZFL1I0cFdZNDJMUjAxcWMzTjd2RWN1ZjhDK2RF?=
 =?utf-8?B?YkQ3b2wzdk93T1c3U1ZmdG8zaURvZWpxUVdVTGRyZXoxRUFRS0Q1em9kb01V?=
 =?utf-8?B?blIxVDg3S2FQN2ppQnpuSzFOWTkrazd2NndGS2NpdG1qVzlQOW5XK1o5eWJN?=
 =?utf-8?B?UVRVak9IMTB1YlZzYXA0L3BxQWdoN1lvTmRsQVZXdmJUL1V4anFOUllNWU9r?=
 =?utf-8?B?TFI4ZlFhenE5NTB2bTVSOGZpM25Seml3bXdqdnI3NngycVlvaHpXaE5JcGVM?=
 =?utf-8?B?Y3JqRFhnazFObUk5VkxITE5MdU1VT0tqcDlTU0dHNXd2Z2lVZit5ZTRCbTFa?=
 =?utf-8?B?K0NCWklVdEoxODViMkpRcC82ek04Vk9wYXpyR2Ztd0RSUElKM0xsdVZoajUw?=
 =?utf-8?B?bzZrTCtPYTFTNkNEYjZHdXIzaTdQbHNkR294MTZPTDFMTXEzODZWTXdPWFZV?=
 =?utf-8?B?UXJjYlQ5UXNNU0EyN2RuWUJFUURISExJdml1Rk1kRCtwOWdVUEJRYmNNeDF6?=
 =?utf-8?B?MGd0VGtKWGJ5K1pITzVwK05UY1V2bGdZSXVWTEhINkhGN0k4N3dieEJLY1hX?=
 =?utf-8?B?MHRzYUozL3hxSGtOdE9wSytYazVpN3ZvajdqbEdJQVRUMFNNTTNuZkN4Y1dr?=
 =?utf-8?B?VTlVTTU5MnlGcVJIaTNVU01kRXY5YVBjM28vYk9ib1RSL21aL0RYTEdMa29G?=
 =?utf-8?B?YjdqYzhaY0dRdUhubll4Uk8xbmtHWHVlb2dHSytPNHdMWE1SSXFkUlFQZk45?=
 =?utf-8?B?d1g4U3ZjNStBWjlXZ0lhY1UySUNNZDJ2dm9mZlVoN3hZVUhpYUREbTQvNWQ4?=
 =?utf-8?B?eFJoYzg4SWx2VjBjSGluVnZLZmJDMzZRL1lFdDJEZ3FqWEtPdjIzN1JROVpE?=
 =?utf-8?B?STZvanVnSnlXeVpab05TYU1DektzcklPMUNuai92NkxCTmdEaThSQkc3L0Vy?=
 =?utf-8?B?UnZmSzJkSk5EbGVGZVhiYXFOczJMRkE5bW9XYXRmZEtGdEJaaGh0YjIvLytO?=
 =?utf-8?B?SUV1dm1rK3IvZGZaazM5Tm4xN0srSGczNVl2Q2o5US9EcytBWjYrYXVjVWJr?=
 =?utf-8?B?RU5LQmNyU0hmcWVOS2t6NnEwbGcwTlF6Z2hNZWZQaTFTTHE2QmsxWnJFdU5o?=
 =?utf-8?B?b0lGeHF6Y1JMWFloNWV5Y2lzOEV3L2h1QzA3S2tranJ1MzkzbzEzV3JUcUlB?=
 =?utf-8?B?ZFBQMkh4dEVyN0NQOVZPWkZjWEhsc3YxeUEyUkNKdjZrNjk4b3VJS3A5RzNC?=
 =?utf-8?B?TzM3YkI0cFV2emRZL3RVLzREbXFYVWxzYTNVai9HZHJHdWVteWFiRzc0VFpn?=
 =?utf-8?B?NFBSR0pOeTRRTFd2SnRoS0k4dGlYOHU4MkhVOHdZWDhVUVVrcEdsSWxaSFVO?=
 =?utf-8?B?WEVBTCsrQlBMRENiWlhRcXVyNXlXT0hBZmM4cHQrRW5NQ3o4WUxvV2xaZ3o3?=
 =?utf-8?B?cEUvVjNqb0F2bDgrNU9PV1hMcG9KMWlGTDc0UDdSbnFtdk5iZE51ZGcrYW81?=
 =?utf-8?B?RUNDMXM0RVM3bXNSQndnWXhGWEE0dU85ajZ2d0dTeTAzdEtjN1hUU2lDK0lx?=
 =?utf-8?Q?ORKdBiwODP/Vhu7cc80IalzYO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96292b8e-dbda-4ff6-7fad-08dc556c5904
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 12:31:41.9587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EB2khlVVl8J/zccl56AduvjQfsHXDlx2svT2om2Ki369wQpH0PTie4d5nE2yUg/TH6Gjsj/oOz2gkwjeS49ufg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7744

From: Peng Fan <peng.fan@nxp.com>

When adding vendor extension protocols, there is dt-schema warning:
"
imx,scmi.example.dtb: scmi: 'protocol@81', 'protocol@84' do not match any
of the regexes: 'pinctrl-[0-9]+'
"

Set additionalProperties to true to address the issue.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index 4591523b51a0..cfc613b65585 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -247,7 +247,7 @@ properties:
       reg:
         const: 0x18
 
-additionalProperties: false
+additionalProperties: true
 
 $defs:
   protocol-node:

-- 
2.37.1


