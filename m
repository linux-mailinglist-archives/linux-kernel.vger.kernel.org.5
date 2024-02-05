Return-Path: <linux-kernel+bounces-52079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5830F8493E9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D76F71F23089
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 06:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549F5BE7F;
	Mon,  5 Feb 2024 06:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RQvNlpri"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2056.outbound.protection.outlook.com [40.107.249.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8372C122;
	Mon,  5 Feb 2024 06:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707114983; cv=fail; b=pmJq063j/ZuG21gyXxG6RkswmUmMTtAavCuvx12XxWU/odX5MfSNaSMOILsINBBEpdReJQO3z6TAdW7BB+LKR1YtmCdyV5YPmERpX0f4GQmYk2UccU7N1fdtLB/9ugB1Y4y1xtwEszb+15fVd0exrVais/qfSXD0zoGwBIlRNVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707114983; c=relaxed/simple;
	bh=JP1tUY0VmgcbwX6fbR87w2PH5YYvnZqripc4VyDYJQA=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t8PrbQPFq3segfu6P2Qdea6mu6rLeecoGAFHkphX9FEl7o2t7wI6drAqlYqJGfllh4mTEJjhcsH6/4LlAzefTBZjjLvcsX52yAuqYItCkmjVtsg3ISvVGEPlPEb+AcH/Wmh08LgP0ANm0HP2zzwKFqhWes/0NUpAieUVyEg/WIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=RQvNlpri; arc=fail smtp.client-ip=40.107.249.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0j8MULYX1rO7e63rpU3mlqALuPT+kSnBEDziYH1IFP5tpf7mEFgS2KdMkmxZ8z5PM8NPvgWXz5vOL5H8+ZOZ3F8LCBoRmxSFquBX+SbDXBDLbJVXPjAG/BvP9Yuc1Yju95tILIX9daM8Ys1Fzm9iaoIwN9tbRAQi9lRlruD4tEgnqIVUlKLYNNZVL2mDOTN02iimeUgUvRK4RvSPAt3x+4tH1/CPFrs1cYhpWEnaMe+mduJgkODnAMpuU1/LT5n6TiSVmoWSLkkE3k/WfJw98pJM9ejc5Zb/8/ANX4zv1ta2lQ1dOP4kqbyitqGkr2XNRD4Cn04WrFrBjkr9a/tgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vnCpitYPI2ijIONwFc936rwRl6H4w4ozdzA9VVy8k4=;
 b=d59vfMFlejjEFGWsS7EjjiIKq/EoxlGYdnzvEw2ZsT2V1R8cJlJ9ABi//P6vKMpPvwrtGJibUdjbBSMyy9YkZn56U8a2RTFqw/RXlV2zCDHhxS3T+RdvqtapztEsxvtKGsxNGA2WdgiktprVePxJKOERJNHoFzchgx9sLkTjuXgfCESOlyVJpa0L+NF2452ihgAAW16y4oLLhZmsazZNJ4cDikTXsxsflHUThdCuJ6Ay+QlpPRFClZWXhYDHPQdOz9B6fkK0dfNByBqMQN15e/RqAcXG41K3An+uQy4W+KQuhc6GgGPPA9asg7jxtM9SUJYuIkXHKrCs2K9fApKgag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vnCpitYPI2ijIONwFc936rwRl6H4w4ozdzA9VVy8k4=;
 b=RQvNlpriLumtnV9uLXU0AJoqeMB8PI9/6tIn+oHaVEfvmhmd8mgwlgpyhAS8Fk8KyQi3tUa+OOiH0ieNSCk7tuCfcvTkMjTzsRNgk4Ok78/kHelcUFiOosX+HaYbVQIhmPNROyv8XudIgUtWpBly6g6FZ/2i3ux/X9TGG9Ql9tI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24)
 by AM9PR04MB8305.eurprd04.prod.outlook.com (2603:10a6:20b:3ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 06:36:16 +0000
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::195c:9861:96a1:56ed]) by DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::195c:9861:96a1:56ed%4]) with mapi id 15.20.7249.027; Mon, 5 Feb 2024
 06:36:16 +0000
Message-ID: <f54d947c-58dc-498f-8871-b472f97be4a8@oss.nxp.com>
Date: Mon, 5 Feb 2024 08:34:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: clock: s32g: add uSDHC clock IDs
Content-Language: en-US
From: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
To: Conor Dooley <conor@kernel.org>
Cc: Chester Lin <chester62515@gmail.com>, Andreas Farber <afaerber@suse.de>,
 Matthias Brugger <mbrugger@suse.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, NXP S32 Linux Team <s32@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 NXP Linux Team <linux-imx@nxp.com>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, Ghennadi Procopciuc
 <ghennadi.procopciuc@nxp.com>, Ciprian Costea <ciprianmarian.costea@nxp.com>
References: <20240119130231.2854146-1-ghennadi.procopciuc@oss.nxp.com>
 <20240119130231.2854146-2-ghennadi.procopciuc@oss.nxp.com>
 <20240119-magnetic-racing-0adf8e5fbd4a@spud>
 <20240119-cattle-antarctic-432fa8e1c0ef@spud>
 <75a16ac3-39eb-4874-9100-d605b2cfadfc@oss.nxp.com>
 <20240121-statutory-endurance-6d03d7e734c9@spud>
 <f45e02bb-1353-4c03-9a3d-294c3b78e8dd@oss.nxp.com>
In-Reply-To: <f45e02bb-1353-4c03-9a3d-294c3b78e8dd@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P189CA0025.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::30) To DU2PR04MB8582.eurprd04.prod.outlook.com
 (2603:10a6:10:2d9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8582:EE_|AM9PR04MB8305:EE_
X-MS-Office365-Filtering-Correlation-Id: ef89fb1d-06d2-42f1-a6b7-08dc2614beda
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hzpnfA/gCNyPCH+pvQmT8t7HMpNiyjdDGripJKeUJk8aMOiOYM8VNtSViuYB4dny4RfPmqQ+qwoU2V5daoNIm9xfFO+pR7SgMAqTXBsIxKXcFZjxtXiJbRJFiidn88IUmehriyYr3F41dOaFxW1FS5T1DjVJdFffia4t3CkRzNe5frJUrzj9B0/842gmqf6Ess7O56bFnqk0kQaLn1lYqw4xbUhlT5i4MqczvIfyAhbwRA/hhDogfDqxG2vX3nMVILJO1CioDL0sNWqgC1iydhRM7JjozvOX/Zlrt1BuBK0XxPpv7NPUlTHy5Wc3fusTC6OH4upxB2ya8Ywy5dCh08qyCpmE4LFKWEEr1QeaGLkbGTU6NRGq9WZcBlIS8+Xi2X3WsKtzW2lj1DUHcUtXRcw5HTDoZYPl7ul7zO2ovA9VsV3WgNr1cw/kgumLTykKwJ7tFr72TjCMAG+DMzCI0WTLaEK5PSTvVu4SU+pmq+s2Kw9vG2kbyI5CMh4QWFRO4PDo1+Wol+wlcaDUIlmldOtr1ImwQwrCnIFQWFHOv3XGLMQpLjHKCXr/2SsWrg22PklHhda8R4m0TFzzCiVDy2Q9FayQgCsMieUpvUFEihUajr/061Vp/PsAvYdl1+2OIYU95iPhf8XtHx+FxVHqXA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8582.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(376002)(396003)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(2616005)(26005)(31686004)(41300700001)(66556008)(316002)(54906003)(6916009)(66476007)(6512007)(478600001)(53546011)(6506007)(6486002)(83380400001)(6666004)(966005)(38100700002)(66946007)(7416002)(4326008)(2906002)(86362001)(5660300002)(8676002)(31696002)(44832011)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEdBMDZybklRbW0yRkY1U2ZPNHBtVGFudkUyTWEvazVPcHJsVCt4NWdmZElY?=
 =?utf-8?B?TmpSK3k5VDFnckZwTHNGd0NRRU9VOVc1RFNyQUQrNmpsdDdYaDBRdU5uWFhQ?=
 =?utf-8?B?eGhVNFowOVZ3a0RRWFBWV0Vpa2NrVWhnKys0bFkveGV2OWRuWWFDMEhVb1d6?=
 =?utf-8?B?OXZYOEtSZWpCVGxLUXptYVF3N3h2RzJWSjk1WHg0cHFzU05PRVRIZ3VRTWlH?=
 =?utf-8?B?alBWZkVUaDZmbEtEcGY0cFIyZE9WVk5MMXd6VUF0amJ4c3F5L09YcFQyTi9D?=
 =?utf-8?B?Q09SSWZGc2d0dStvVkhZYTJyYTdsMEF1czB4QlJtUmlpbkNCbEoyTHBLV3du?=
 =?utf-8?B?bnVuSnhpRGJSRnlEYmoyOVlkTDkxMEx4T0ZSZzluWFVYaUZHdS83RjJRNER0?=
 =?utf-8?B?OUtEYnBIQmJxWk1kUzk3a2cwd3dkQnRXZmRuMWhlSThJZ0FRTXcrajRmN3JE?=
 =?utf-8?B?K004WDFlaWlsKzB0dmFzNWJVMXRuN0pxOHBEZ1Zac0pGRnNzaWlhOTFpeFp6?=
 =?utf-8?B?TExhUzhvK1NQMUZidzEzQ0FzSnp3NndjWXhrdVhWdTQrc1dSSXhjbGZvL0w5?=
 =?utf-8?B?ZzVVYlZ5MFJ6VjRVeHpnbnhsQjNuSXV3cUJZTmVYeHRxSWY0ZHIzY0R2MDJa?=
 =?utf-8?B?ZGxXSW9ZSmFVaDFzNTZyZVFZNi9QT0dZdUJOVXFLbnNWblFlSkRqUFhTam5v?=
 =?utf-8?B?OG0xM3R5N0EwOTlVdnRQTStHQThwWUdHeDVOQ2s5ejZWOFFiRVg5S25LZm5t?=
 =?utf-8?B?amdZV3VmRGR6UDNmZXBVSWYzSWxSRUQyT3NiQWp1WTlOSlJodVhjL3NobkVl?=
 =?utf-8?B?Y3krZGxQb1JpbGFTbWpmdnk2ZkQ0Z0c1UG1hVHYzM1ZRUmpCR0sxd0h6OWMv?=
 =?utf-8?B?L3djamhYVm5sWnlyRVBFemR4VS91UVErU2dJRG80Smpjc3RCNDEzUE9aNU9x?=
 =?utf-8?B?MVZmdzJ0TjBvRkw3RjlNTEtlL3hCWnRiVmluNFMyRjlCS2swN1FuejZKcmQ1?=
 =?utf-8?B?dmp1R0xOM05iMFhlMEpZQnJPT044WHdybFBQZVRtT0htTGRNQVpOVVdlSjln?=
 =?utf-8?B?U3pyci96S2tqSCsxeTJHQlE0SHpqSk9peVVPbVRoUk4zME5DN2hRUytWb3hq?=
 =?utf-8?B?bVE2ZExCd0JLT3ZkeUpuRWIxVC9JNWlpdWxpQ0M0N093UzZMc3NGbzRpam9V?=
 =?utf-8?B?QkR2ZFB2T0JVZm41OG5iWWRBbDNRNWYydDFuNXNQdlFsSm9tZlN5aHkvK2RF?=
 =?utf-8?B?K001TTRzeVNLejRqYU1FMzkzcFpiRTJkaXFDYlFqRnJlMW9zSStnZUt3bGdh?=
 =?utf-8?B?R3N1OTc1M3RZU2VFbWZNMmh2OUxORlA5bnQzWmx1WTh0K25FS1VrUWlMaHMy?=
 =?utf-8?B?SzMvdmhzRmVLaUZkRnA4Q3JCN25IbVJ4UzNROGQ5bHB5N2h6MzRqMDRERmlk?=
 =?utf-8?B?MFJuNldCeHBIb1pGdy92SHUwNDlTR3J1UDZDNERPVzdpQVc5aDlGUldvSE14?=
 =?utf-8?B?eFoxS1NrN3hlVEpQaUVHb0tWRHFrcUVYVkFLM3BOOWFKVEVOVjNlQjVKZ2Jp?=
 =?utf-8?B?MEw0M1FYSTNVcmd6WW8vRUtVQmFJM0kzb3ZpcndUdEsydXgwc293MzB0QkFs?=
 =?utf-8?B?QkNkcU8vd2RnOWpyTURNcGdpRDVzUDBvSk0vSU40TVVpMFR2VFUwNEZnaHpE?=
 =?utf-8?B?V1ZKU2NNOWZpRUtNait3Qlk1eUI3ZmlVTDNrMThOWkJGRTQ3Tk1oTWZIQTVF?=
 =?utf-8?B?TE9HdmZQYnJiMG84YmI1c1ZpbnRwY1dtZFRKVzdXRkRaR25Ud01DSEFTQ3hi?=
 =?utf-8?B?bk5DUDRmRlpxUk00SWRKSVB3amJXcnFYUStDTjZKdDdrMkl5TTVYREFNQVBK?=
 =?utf-8?B?enBBUzk3dnc0RXF6WnNsdERJdkpWV0dULzV3SHhoY2VNem9FQXBOVHRYRnQx?=
 =?utf-8?B?QytITlVsdU9mSWpkY0dmQi9xSUh4UnZvcWlJN1MrQWdnd2JiU244bk01VHIz?=
 =?utf-8?B?WllCSFZTOVhTU00wZ3ljemVMcjBERm1yanNITE1tdWErVzN0S3R4RG9ZZ0t1?=
 =?utf-8?B?K2xNS2FuZ0FtTHlCZlh2eFF6U251OTJwb0RjOGFiTVJoQ0RrQkRLYUdaVnAw?=
 =?utf-8?B?UTBaVjh3MjBhaDc3OEpVS0IxaElDRE5xS2tyM0gxbStMeDNRaEpaeWd0MUZW?=
 =?utf-8?B?elE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef89fb1d-06d2-42f1-a6b7-08dc2614beda
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8582.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 06:36:16.6401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U9RH2awh1UXWT2uq6PZLaefF+J8m6mvJS2zV1NtNjDJoO8fnQeQMutG3ooGzhMTObeGHS/5JdubjTjJ5msSsT9zebK71zGTP/T4oBa3VD6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8305

On 1/22/24 12:09, Ghennadi Procopciuc wrote:
> On 1/21/24 15:32, Conor Dooley wrote:
>> On Fri, Jan 19, 2024 at 11:25:57PM +0200, Ghennadi Procopciuc wrote:
>>> On 1/19/24 18:14, Conor Dooley wrote:
>>>> On Fri, Jan 19, 2024 at 04:11:37PM +0000, Conor Dooley wrote:
>>>>> On Fri, Jan 19, 2024 at 03:02:28PM +0200, Ghennadi Procopciuc (OSS) wrote:
>>>>>> From: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
>>>>>>
>>>>>> Add the SCMI clock IDs for the uSDHC controller present on
>>>>>> S32G SoCs.
>>>>>>
>>>>>> Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
>>>>>> Signed-off-by: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
>>>>>> ---
>>>>>>  include/dt-bindings/clock/s32g-scmi-clock.h | 14 ++++++++++++++
>>>>>>  1 file changed, 14 insertions(+)
>>>>>>  create mode 100644 include/dt-bindings/clock/s32g-scmi-clock.h
>>>>>>
>>>>>> diff --git a/include/dt-bindings/clock/s32g-scmi-clock.h b/include/dt-bindings/clock/s32g-scmi-clock.h
>>>>>> new file mode 100644
>>>>>> index 000000000000..739f98a924c3
>>>>>> --- /dev/null
>>>>>> +++ b/include/dt-bindings/clock/s32g-scmi-clock.h
>>>>>> @@ -0,0 +1,14 @@
>>>>>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
>>>>>> +/*
>>>>>> + * Copyright 2020-2024 NXP
>>>>>> + */
>>>>>> +#ifndef _DT_BINDINGS_SCMI_CLK_S32G_H
>>>>>> +#define _DT_BINDINGS_SCMI_CLK_S32G_H
>>>>>> +
>>>>>> +/* uSDHC */
>>>>>> +#define S32G_SCMI_CLK_USDHC_AHB		31
>>>>>> +#define S32G_SCMI_CLK_USDHC_MODULE	32
>>>>>> +#define S32G_SCMI_CLK_USDHC_CORE	33
>>>>>> +#define S32G_SCMI_CLK_USDHC_MOD32K	34
>>>>>
>>>>> Why do these numbers not start at 0?
>>>>
>>>> Ah, because these are the SCMI IDs directly. If these are numbers that
>>>> are in the TRM, just use the numbers directly - there's no need to
>>>> create bindings for that.
>>>>
>>>
>>> Hi Conor,
>>>
>>> I appreciate you taking the time to review the proposed changes. I
>>> wanted to clarify that the IDs mentioned in the header are SCMI IDs
>>> exported by the TF-A and are utilized by the second patch of this
>>> series. These IDs are for the uSDHC controller to control its clocks. As
>>> other SoCs use this model, I have included all the necessary IDs in a
>>> dedicated header file:
>>> - rk3588s     (arch/arm64/boot/dts/rockchip/rk3588s.dtsi:97 [0])
>>> - stm32mp157c (arch/arm/boot/dts/st/stm32mp157c-ed1-scmi.dts:73 [1])
>>> - stm32mp131  (arch/arm/boot/dts/st/stm32mp131.dtsi:1372 [2])
>>>
>>> Should I remove the header and use raw numbers in the uSDHC node?
>>
>> IMO, yes. There's no abstraction/binding being created here if they're
>> the SCMI IDs.


I included the suggestion in the second version of this patchset.

>> Thanks,
>> conor.
> 
> Thank you for letting me know. I will make sure to include this change
> in the second version of the patchset.
> 
>>> For
>>> example:
>>>> +		usdhc0: mmc@402f0000 {
>>>> +			compatible = "nxp,s32g2-usdhc";
>>>> +			reg = <0x402f0000 0x1000>;
>>>> +			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
>>>> +			clocks = <&clks 32>,
>>>> +				 <&clks 31>,
>>>> +				 <&clks 33>;
>>>> +			clock-names = "ipg", "ahb", "per";
>>>> +			bus-width = <8>;
>>>> +			status = "disabled";
>>>> +		};
>>>
>>> [0]
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/rockchip/rk3588s.dtsi#n97
>>> [1]
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/st/stm32mp157c-ed1-scmi.dts#n73
>>> [2]
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/st/stm32mp131.dtsi#n1372
>>>
>>> -- 
>>> Regards,
>>> Ghennadi


