Return-Path: <linux-kernel+bounces-52006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 873DD8492B3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 04:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F04441F228C2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 03:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837AEBE65;
	Mon,  5 Feb 2024 03:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="SVj91D6E"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E38B669;
	Mon,  5 Feb 2024 03:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707102830; cv=fail; b=CtWzjuHZOBofAfjMiAVMl73g1Ix8A3xvjbkMNmFJsNkUE9XMYyh5QVzjdRE5hZqDMc8z7yWbaIaUVwl9LIpHutO3WkClGYTMIrtc1brdCE0ZOQBluf2HQqzu/uqJD6Dqef5Q79QnekMZvLSttZ9viDzEK868hgjIDHVH8jCY3GU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707102830; c=relaxed/simple;
	bh=bj6eErTwpCYW0J5CJyTcfq4n9TtYf3VpeOyjHVfqZoY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=LexUOS6+GkcEW0S+MDoXMkI1NO7oWOPD0Kkj6eM/zXoQ5UR5v2MW1V8HOh0n8G0JHFnsEhbfF+/0fhBwgDoHl9FgrqRuw5AHahxFcbqsbvqUlQXL6nBjAFWCOTHIaBu/BgkC/EUUPNAuUUzyaHv2lRh693wBsU3bKty1TlG/xUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=SVj91D6E; arc=fail smtp.client-ip=40.107.21.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDUN1A9lR7/JXWTSVEPI4mYMjwju3oxabUnmckKUhwFkARHBPoaY8+sJKy+4wm4PtOeHNFaOmz4l1ksCdD4lUnZ2TT8HcQ7DSEG/HCFg/429Iy2NbLuhoyfF5wSEn7LYNoLlQQZL7w0FcIl+JPzR4h8HLNLjPOBjQTWXdg50AWzfmxNMAM0oVrqmTXGdgFpnxxeXvRL5GP7o6bulHywQtQ5C84myO3ncex/Dt91+3yxqaP7GMiU3mQoxygao+pACEgtXCFQk5xZEHbNmnqqAMOalkc/Md1tR+3qjEr4K5ZufY6H1b2yDLS8pNS58eNNob9kS0pklJ9lDzJf5LJ2m9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifTADVj1jYTuSpgJQkwpP5OCUaKEn5cq9ppTHD9eifA=;
 b=NrNoOmc5wSo/BpMMZMSj6kELR49EWgZs8zT4oqxyYxWnKxxPNJrbzaitvWzlzgGH4QTEN9QCZY8PH8DnNl0YTXbCPBBZj6d9nfVthVzAG3Oqv+vNQcVSJE/J8ox3kkxY2NXt8hHmO/CMbyGif2UetVkYC/NTlqCwdWJx/qrkDjBDOsN/7+t6wnAZXJ6TP2hsDmcPR+gGCJJzeaeNePiQb9BszNsFNqvtRSo8S2iMGkdiSRoayHx93mkZf83fDhadKf4J5SpAQOHBLPFQG/iNoBCYLvjo6mYBkjAgONuRd4J2NMDg8qkNYw2KgMdkf1h9jZ+U1Q/u5/ZYAKpFx1U96Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifTADVj1jYTuSpgJQkwpP5OCUaKEn5cq9ppTHD9eifA=;
 b=SVj91D6EEWYk1OblPJX56pf4DvbUh/5Gookoet+UcKcJ5Gk0WTXUC4+TfegwtEoORMthGDGNjSdGaKTe8EHuM6oR43fP8EbIskcRozzvy+dOvw9jX0tUQ33ol63CB+8GH+oET1hYum3XW3fyxcndTNUUkhrod/Xz0u/TXfkmPxU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7775.eurprd04.prod.outlook.com (2603:10a6:102:c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 03:13:45 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 03:13:45 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 05 Feb 2024 11:17:57 +0800
Subject: [PATCH v4 1/3] dt-bindings: timer: nxp,sysctr-timer: support
 i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240205-imx-sysctr-v4-1-ca5a6e1552e7@nxp.com>
References: <20240205-imx-sysctr-v4-0-ca5a6e1552e7@nxp.com>
In-Reply-To: <20240205-imx-sysctr-v4-0-ca5a6e1552e7@nxp.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bai Ping <ping.bai@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Marco Felsch <m.felsch@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707103086; l=930;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=R3Mof/eCE3OJuvH86ahzlO+hC65KLueYK0QmUKdlf1k=;
 b=BvCwBGBde+Mue8cogJ4dxEungzIGT8+VH6r+TaxapChoZW074VXBTYh46Ngou/qlZVt+ek4eW
 erN8adRNax+DNImA2km51cRrknh1mUzzBDuQOgT3RY3nbrnztCsBoR1
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0124.apcprd02.prod.outlook.com
 (2603:1096:4:188::9) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: 9594af99-cb50-4813-b92b-08dc25f876aa
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3uOp9eo2/0IvBm08SuIpr/vDWzg1IJWeQXa4nGRuvu84ZP+KInotOOxlkBBgGs4d8Yz7NwZlrX8nrINc0YPosm44/rqngGkNYqxi07jZaS6D9PkCsutZOxLH+XgkhkkUIpQ+/l2maqGn49kFjt2spnspBsSawnsSra5cl3IxVnu+DLs3WuEY+e3/clZsoIK7kUvqgYNpCvg7nC4IDRCjDbO7y7dEr+5/7qSMN4uLy+hpLrCFkMQ+0DhVr0WDatUiIPe/APUknQYpp1uyBuOSxA9ZsKWPVJN6nNjWb9xakPWItij+f4EECQaPgmzA5aHR0ck1MVegRclv+e1frcdjCpxQCqc+sNXRC7DTEVtRFbmyw0ipl0fm0SIPcXR7J59T4QHsPJAXmxTzylgmHBCznMMUK1NnBhPIzGReo3kjTkCxQVn+dAUYO900kgU1p2BForrXj80bSp6AqXaJEPIGDlR5sfhzt8yXCpXFGOX9pwYLfsSAzthBoBrqPyNO/IFb8TGu6mQIgfHXsvF92vuhAGB0ty5kXUfpdYlhy0aBPbov3NNGso21rrNp2qcoMr7ho6sqJ4edtvoSo9x/IlfJNTggy0V0K/IAFffw9CorCs5Kri+7pooxt5TRWxIKxI5X
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(396003)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(6666004)(52116002)(6506007)(83380400001)(38100700002)(26005)(86362001)(41300700001)(4326008)(36756003)(8936002)(8676002)(9686003)(6512007)(921011)(478600001)(2906002)(6486002)(7416002)(4744005)(5660300002)(66476007)(54906003)(316002)(66946007)(66556008)(38350700005)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVdHRHRoRS8yZytsaUdrZVZnL3B1ZmRhcUxaa3ltbFV1d3VEbDlBQlZseEhG?=
 =?utf-8?B?V1R1cUJEVmFIRzlXc0ZId243OHR0b0tRQzRhelRhMzh1Q2Y4dUk5ZERsdmVU?=
 =?utf-8?B?Z1l0ZWJWcTBaMHhHbmU5M3RVdUQ5bkIxOGZUU1pnaVRLUU5FUUhhM0tTTE4v?=
 =?utf-8?B?alJEVWxVTHo1UFNOK2NJay93VHBiNzNOSkZlNnlQOEFzRmFZeFFyT2syNHlC?=
 =?utf-8?B?bDNtTFFwN205cFdSZUN0cERQN3NySzBlcjN3emFPTS9RRUwwRFNiMDN0RTQy?=
 =?utf-8?B?OEc1YmoxWUVFa1pCSUlXdzJod2kvczhFa0ZBRnNJUkwyMUY0endFQmI3SzVa?=
 =?utf-8?B?ODY3VGR5RHNvNy95a3gvVUxUc2xkdi9lMVU2VjBFSndobkxMS1JNNFR4RXcy?=
 =?utf-8?B?SmM0VFdXUk5ZYmJwZ1M1czlLRHBJT1I4NDMwblB4S0FWSllENUlMTk9FK0JX?=
 =?utf-8?B?ZlgzUHQ4MngvTDNMdzJDWHRCSDJTdkk2MlVWbE1YVHBJa1prN3Q5TUxPamV5?=
 =?utf-8?B?L3UrZWtzY09vNDhmU1RCNWZmSGdUSXF0MlFnV2MzV3BKaU5TSXN0S0NOOVBi?=
 =?utf-8?B?S3VlWk5HQVZMQ3lBbUZkM2UzaSttWnV1bzdremlEOCtWVHVkUGs0dGlBU1R4?=
 =?utf-8?B?Qk8xOEl6WG1vZm1ZUmdVK3ZHVGx1VzZsRVZSbDhrUG12ZTBPNUhkcUlUOU1D?=
 =?utf-8?B?aWNBcHFPNysrVWQ2RmlWcCtPK1M4aWJXdXNRNGlzdDNlRUdndlQ2Z3VYYWZZ?=
 =?utf-8?B?S2NYeEJWRXV6MWF6VTZ1cm5MZ1V3ZURiNUN3akxVSzUzTXdoTW13RjRyK0U4?=
 =?utf-8?B?bkYxZkQybEZlK1NidytIVUN4Z2RoMmpzSHVoREdlWWRiK1dZV2lYd0ZUaWdz?=
 =?utf-8?B?dHROdVU2dzU0OHZqdWh4MU5IT1YwcFJrak9vclgyMjV3aWhrSVk0WlljeDFL?=
 =?utf-8?B?UUd5VkVlbnNxWlBXdWhyN1dyN0gvL2V4Ynhxb2dua2lBbzdJZUJUNE81TVVN?=
 =?utf-8?B?WHFHR0VrM1I3Z0YzSDgzUkwvWjcxaDRBeFJQNEdodDRqeEI2cGQ4YVdVMFVE?=
 =?utf-8?B?NmpNQVpmb0ZBSG5VeUovK0VvdmJTYTd5WDVNVEZHTW5EWE5UejJlRVpiaElw?=
 =?utf-8?B?ZlhTazB0aWZjTTdPNmNoaFhGL1VaRVFmN3JDc01iQ1BvTVAwV3YwVnMxcVUx?=
 =?utf-8?B?M1diZFlRdmtjTDIvd2hobGdHMTJEOVpYM1FmQ09sOGFMUnlvOUtxZmNnNnIw?=
 =?utf-8?B?eGE0RzE1RUlpMkdGZUtvWTZkVjZHelVqNDRDQnBjMHN6b0RQcnlKZWdiZ01L?=
 =?utf-8?B?Z2UrRWFxdUduMFFnTmY3dEpLeE9veTIvYnJvcUZrYmh3aFpIaWhoRk80ZUJB?=
 =?utf-8?B?MCsrSFVUTFRYbm1ITEIyb3dXVGM0UDlFU0NSZ3AyU25LZUROY283R09zQkVN?=
 =?utf-8?B?R2VSNk42TDhTYzVoTEcraTEzS0VpYUtTRDlhVnhmd01uUFRVNUdSVzBhSU1r?=
 =?utf-8?B?c2xLbjVQTmEydS9SQUprZW9iWU5nbkNaYXMyMnpVVEhGVWh6VjVBd1ExTmhO?=
 =?utf-8?B?T0Fac3QzQXdHbUFUcDBsZmFhbVBPTVlSNll0L2lNcDNYYXVBcyt1cWdoOXlh?=
 =?utf-8?B?M3RNZXJERk55dmI0aFlpUEg3aEF2VUlxTG93V09MRnFnZkViTTZ6cFFwVk4y?=
 =?utf-8?B?MXdKRzN6Smhka0lpUTh6N21aaGtwVnlvNmdCQVBIVWRHcjVKZ0s3TFpBUDlt?=
 =?utf-8?B?M3QxSGx3UGRZcjNnQkpjRWJ1czh1V0ZiMmFvek1WOG12SnhRVmphdERtSnpy?=
 =?utf-8?B?aXBPUmVsbDd1cG5Fa0pjOFkrcExzVDZzK1hzdGNYQmczVWk3TmN6b1N0a0tx?=
 =?utf-8?B?ci9QYVJYQWRiNWx6WkdJREJ6Z2hzb0JZbTRsUkZJNlFVM1Y1aVBWdkExK1JI?=
 =?utf-8?B?NlFkSExmS0VocXQvblNGZXlablhVenVvQ3MvZ3UvMzY4UU9aUzB0SFFiVTZZ?=
 =?utf-8?B?T0pEaDFRNHYrYytsQzR4cjd4d2hUb1VnWHZxYitFTG9wZS9NZWpnNlJCZzlL?=
 =?utf-8?B?Qzd6UlNmOC9NL255ZXNFTXV5dFZOckJBQjhERDRmeFZWek54U01GRDBqdHdW?=
 =?utf-8?Q?9Z2qwtSAPOMqET/NoLCwUiH1f?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9594af99-cb50-4813-b92b-08dc25f876aa
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 03:13:45.4060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nOE92U2kUYzYxhRJNRCIgbSSx6SI8BNR4NO7Bf4UPaT69nOclAQ6CsaWuN88gr6DqPG1PkFghLyUGjefdyc/FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7775

From: Peng Fan <peng.fan@nxp.com>

Add i.MX95 System counter module compatible string, the SCMI
firmware blocks access to control register, so should not
add "nxp,sysctr-timer" as fallback.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml b/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml
index 2b9653dafab8..891cca009528 100644
--- a/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml
@@ -18,7 +18,9 @@ description: |
 
 properties:
   compatible:
-    const: nxp,sysctr-timer
+    enum:
+      - nxp,imx95-sysctr-timer
+      - nxp,sysctr-timer
 
   reg:
     maxItems: 1

-- 
2.37.1


