Return-Path: <linux-kernel+bounces-31682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9BB83327C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 03:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96E071F22B8B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 02:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B456FED2;
	Sat, 20 Jan 2024 02:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Q6L0vECJ"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED4A390;
	Sat, 20 Jan 2024 02:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705718670; cv=fail; b=XawM7o2/qhAP6T8DDPQVXgRpFPkgYOFvrAzWdwzseoBexsGwfL3q/jYoejcTWssr1OJx3a6ZILTkPCyrM1Qh379CfJ3tpxRgbfmYwJfoIiSwFcezVis0MQrka1jEon7a+F3hzwbK50h59soBJ/UKZlJ5goR+IUJZ+XYtnsiWQ2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705718670; c=relaxed/simple;
	bh=BCVCxD5K94Vrz2D4ufCqrS9wIvWdhix65ueIqMyV+YE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ub38YQ1QNTNHI9NsdZav2FhX/pQezvaMC/0E/OQpuSKkK4vQTd/ghykw8B12iOj+s3LYPm/7TBxdCxScv9xVMwVxHrLdO42eNApgbgoWzxIYQFQSrUO6fvuA8v2N4NYtMvP3s5bHucwkqXXOuMHUTBwu4Bte0ixfqMs8pR8dkrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Q6L0vECJ; arc=fail smtp.client-ip=40.107.21.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tp7wdz2kuRc6drzi3MCy7N35lYGwjpxK29dvA5zFLF1dVQ+Bbd+bAsufGQsY1cqhhEXa4nWtrU9B4ZwimS28mgTTpPLhx9TtQa1IHu5PxGzv8bCfJI7IPemL7RPaDCJEq2NOjv96YhcJpeWfOspDNhnMrZR+9WF3I/uV96I9FKE90rV1DEtajD1MpWs/ch0fi2cq2IXIH/2PyhXzPPO2jBnld+MrPS9PK3UYfajetBDBWtMz3XkecoI0XoH7mlv9o8lb7UKe7pmurYMbAu900ZSz4RYYnirBgJEZB07xEvo53zGtbGA+W1AfOxqA1B7V1jDEediVWOIK1oLsmapeMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhEmUxYFPWCjOlRKWExYjgUzqh4VkoREc+WZoyPUxTQ=;
 b=UnUGJPUbVNzSD0sFK1HObkpfN7+SKfCrasCFOyT60xunm6slKISDQpVkvS1fBuRDBK3rjUlQ/CED6xFAZ8q9R8WPFtJdFJZMTCAhvxO72Pk0nE81m4Dbs4QZCZnxXgo4DoZy4V/lEWiB9+6V0YsjBel3g4T7h8d9JSJ58ZZVzNjqjU4hEeLIInUxAnimfUG8DJEdoEmjyKL7ra37aiOIlnxAPnDI7+YDNwUwA2xYtFX23bCFR2Em874PiSPBpVG204udPqBFSthvnHnK0G5LAVZZedMaBnGBWP8qlaJ0igT6E05qJ7SR0AFDTvqqc3Ik7/RLFoCHplCh+oSxgNMuFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhEmUxYFPWCjOlRKWExYjgUzqh4VkoREc+WZoyPUxTQ=;
 b=Q6L0vECJ+Lg71WyNDukLlhlJmepvUp7AaAw8vixiccaenvc9k4uJ/Lyjp1n/GJ73903mm6AD1jK7hdqYkbvf3lMNapMYa74+zKdRvDQGCoiUMVkANkKfPtw8o0CJ6pGpJlF6hQqHMtQmrgqvyiDThl5dlJW0s7uYcnAlQgjB3kE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB7167.eurprd04.prod.outlook.com (2603:10a6:800:12a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Sat, 20 Jan
 2024 02:44:24 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7202.024; Sat, 20 Jan 2024
 02:44:24 +0000
Message-ID: <c9385ba8-b225-4c8d-b09f-971d9e6008ab@oss.nxp.com>
Date: Sat, 20 Jan 2024 10:44:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/2] clk: scmi: support state_ctrl_forbidden
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: sudeep.holla@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
References: <20240115060203.813168-1-peng.fan@oss.nxp.com>
 <20240115060203.813168-2-peng.fan@oss.nxp.com> <ZaltgIGyx1al-F9x@pluto>
From: Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <ZaltgIGyx1al-F9x@pluto>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VI1PR04MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: ec5dfdfb-b3d7-4b15-3548-08dc1961b573
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pxfMU0hXCYKtpeBu8x0Hlku6aVMveVhGPKy2Vtd0f46Pa2FVgBLWVTNfckWgdXDU1qGAm/F1piJKBCLActrVdJkTqXc9CYD+cA2hT6ZEs9BCzV0EOrD+CG28Q+LPVcmm9d7VBW3pLZakvQGTpsZvccmXseddcax/R/NYbVqm1gTWMlN7yOS41bj/hCDEysTVq8VEqXDAop7+cfqSeCUMGmHY+56qU/pbMnsa4/vjXzDSv7BxVNm5xSAKhtsC89iVjZkg7mkd6BB1JCFWIPWpDJNPaOhOJmtLixAnCEPiZtj/rcZJ/yF+FLyJEPXXl/YvXrdB6798uOjoLyVfaV+xOLJS+SsXKSpRAZserjZ69M2bjxX3ITmQRfH2JBu8C4FFdtAJHmsK0Zxu6ImsG+KCwKc4yl0wsb+ykmcpviMUciG5imcY7tT2g1Up5ntsg/JOd86n4d4QzwIVbHmKqzt2sGz+RMc+NDlzzPbt7UkjovsR5LNEV67nBGkM0MFFls+bEVirJXtiCw4GNiJX4LLffZvtgzLdmZ42/veEspgl2ndEQYivL3bTodvCZ58OwOkJQC8KQyfLqOKBwQenCsF7HLYF4RFH+m86SfIK6sFfRFnTHR/7qLJL9Fb7+YMUq6FNywMSoBp4KjNydkF3kGTgXhf1W9EORgFfKHab9utKT2tH2NXXf6J0K4/Evf2B6Mw+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(31686004)(5660300002)(8676002)(8936002)(83380400001)(4326008)(6512007)(66556008)(478600001)(6666004)(66946007)(66476007)(26005)(316002)(6486002)(2616005)(44832011)(6916009)(6506007)(38100700002)(2906002)(41300700001)(86362001)(31696002)(21443003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTVQQzlmZFVsam5MWnNEczBnRkVJUzJaSXBwT1JXc3REeEpJNGk1aUhxV2kr?=
 =?utf-8?B?WHFuaWtLYmg2WldTYktRWnNQc0duaGJXWDNZWGc1WlFRdlhBbHVkSkUvYlh5?=
 =?utf-8?B?SDRzTERPQWhBNytua251dGlSRTcwNFdmaVhRcndKNHVieTlzUjNJcElzSllC?=
 =?utf-8?B?K2lTc0U1ZUVBelhZUlkyeERMWTZ2M2tCYlBDaTFnMGZOMGF2OEFxT21oakNz?=
 =?utf-8?B?S2lxY2d0dmVGR2RWMTJLTzRmRWd3WXppZXVrZ2M3TFVZYW5KdXJDd2ZqeXd2?=
 =?utf-8?B?TEJOT0lNSlJ0SUx1SnFCOHZDS2Y3UDdyaEE5d3c3N2UrQURoK1pxaFhiT21r?=
 =?utf-8?B?amZ2RVJ1eEZzZGh3Y1RSYWVuL3BVL0NRSVp1SUdOM2I5cXdBTElIVGZlOGxL?=
 =?utf-8?B?NHR3ZFpmbzJrblNMK0JwNHJieVFvZm5LRWx2YXYzSkZhWWtSZGY2a292WkJ4?=
 =?utf-8?B?QUw1YTNRQTVzQy9sdEVZTDIyY3kvSGgzV3Arbm5qRVNmcXlvcllFSDBCU25J?=
 =?utf-8?B?N3VJdW5Sb1huTWx4MWtGUTVPYy9oczJxUHBnenhXeFpGYS96STRLL3ZxbVRm?=
 =?utf-8?B?LzFXSTRBZVlERkFGVUdmTnFUS01Yc1BnMXlCWlpNck1qREVhaEtzaTdVS2lo?=
 =?utf-8?B?NzZubm4xSjFtYzVQeDdXZXpZTHRlR1pNZnRyT0U0RXgxL2huOTlOVXhGMkZM?=
 =?utf-8?B?RVFTbWdzalR4Uk51MXU1c3JjdFVnNCt5SGxTYlJ1Vjh2RXdvTnNySmlBTnJK?=
 =?utf-8?B?VXNqK21EY1gwT0dtQkJWUEFzWkswTnc2WWhIcjNramFvVU9WRDRIVjU2cVY4?=
 =?utf-8?B?ZUtFdmo2eUVaM3dqcmNVeElWbVVxcllkekZ2TVZkS2tEdDNPZlhSU3lKMXA4?=
 =?utf-8?B?cDJuYXFFZHVMdjJaYm9kMDYvbTZ4OVloOGlFbVA3NC9ML055NnZOTGZjbXVu?=
 =?utf-8?B?RVdhUDl3a0lQM2F1YkNUd1RYNE9uOU5nYWRQT0hkb0xwRHB5RDdPbks1dUZM?=
 =?utf-8?B?aEVXTVc5cjF6TVd1Smc2eWhTYVQxL2xmYlFqblV0c0YwSHcwQWp3M0xBajVQ?=
 =?utf-8?B?eDd2L3dsUVhNTnFTaEdDQ0dIaE1Ta0lQak4vTmYvWWFLU2Q0UkFLdSs2djc4?=
 =?utf-8?B?dzhCelkwR0Zkbi90WEVCNmJXaGJ6R3gxMzdSYnVPTkZCRzBBWFJWNUk3azU0?=
 =?utf-8?B?aDFWTjR0Zm9reEwxNjYwOTdPL1dzc0hVT3E2UWZBcWJoSlViQVgweTB4Qkwx?=
 =?utf-8?B?NlBLbGVhc2lwRU83NURHcEdjN29xcHVGUDFJY1VZSXROTWswUjZsNkoxWnpP?=
 =?utf-8?B?cmgwVHczdytvV3hLbnVKZXJOa05iTURtL2puTXVrRmxlKzUzNnFOZTFWc3Fo?=
 =?utf-8?B?U25lSTAwMHNMTlVXVmkrT0w4WWpnbHpNZGlQaUhoNHdWdGU0VXJZYUhYNTNT?=
 =?utf-8?B?czZhRWx1TGEzeS8rMzhYaEY2VGtWcmE5NTNYeVdzTUN2emZ4c3hpRlJLZlRX?=
 =?utf-8?B?NnJzRnc2VWpMeTEzYnQ3cXk4b3NqaWR3QjFkSWJxNnFEYmltZW0vMWhEemNX?=
 =?utf-8?B?RExkRkdNU0FINksydHIzQkpUWVNxczdpbE9uVzgyVnBib1lpK0lRVjNNS0JE?=
 =?utf-8?B?eDBlN0ptdytwU2NNNDVIR2VvMFkrb0dhaTVMb0JFUnR1UDQzemFVeFVTUmsy?=
 =?utf-8?B?aWRtR0lpcWFwY0JvVnlhMTBydGFsR3BNak5hSWdPelorLzlEKzRwTnBDbzlV?=
 =?utf-8?B?cDJ5UUJOR2ppNDZST3FhRGNhZ0dpRWJESkUvNlZTT3dCR3lyTjcwN21yYUNY?=
 =?utf-8?B?d2lLYW40YzlmemVTeTR6RnZUUTRkOUVVZjZyRExuUGFHOUVIeGsrWHU2cUxo?=
 =?utf-8?B?WVY1TEx0d2tWTkF6MEpGMTRuWUlHbkZPZW5meU5lNmFQc0ticVdtU2phb0Nv?=
 =?utf-8?B?M0pETXQ0Z1hvdFF0ZkEyNXBqM3JrYkF2dGNGOWlKMkpBS1hieTVPVk5HSzBP?=
 =?utf-8?B?YVdqdjZXVGhXOWxnRXRHbzcwQzZmYzd4b280ZFhnZUxqcHZUSGF0R2plSkNp?=
 =?utf-8?B?b2tqWHV0VDJZUUw4WTdDcG83V2ZWRTFVdldKSG92b0pXYm9rUkJNaklFRnZp?=
 =?utf-8?Q?IHKn7SIzBn+kgIG3kAtF9EMsQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec5dfdfb-b3d7-4b15-3548-08dc1961b573
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2024 02:44:23.9357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: myuavxk38q310+ELlcBtuDp15Z+JY3Zr42By6dLruPR5CBWst9rsb3Am3j+D/VrZX6zWNTXFg5f5aMq1ea+bGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7167



在 1/19/2024 2:27 AM, Cristian Marussi 写道:
> On Mon, Jan 15, 2024 at 02:02:03PM +0800, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> Some clocks may exported to linux, while those clocks are not allowed
>> to configure by Linux. For example:
>>
>> SYS_CLK1-----
>>               \
>> 	     --MUX--->MMC1_CLK
>>               /
>> SYS_CLK2-----
>>
>> MMC1 needs set parent, so SYS_CLK1 and SYS_CLK2 are exported to Linux,
>> then the clk propagation will touch SYS_CLK1 or SYS_CLK2.
>> So we need bypass the failure for SYS_CLK1 or SYS_CLK2 when enable
>> the clock of MMC1.
>>
> 
> Hi,
> 
> so this looks good to me and apparently (as noted) the CLK framework is OK
> with a driver swallowing the -EACCESS when a clock is immutable, BUT at the
> end of the day do we even need to try this SCMI call and hide the failure in
> case of immutable clocks ?
> 
> I mean, what if we just dont provide any callback for enable/disable...I can
> see plenty of drivers not providing those callbacks ?
> Maybe this is probably more of a question for Stephen...
> 
> IOW what about doing something like below...does it make any difference
> in your setup ? works fine in my emulated env

It should be fine to use your changes. Do you expect me to use your 
patch or make it as a follow up patch?

> 
> (Note that last snippet in clk_gate_restore_context() is probably a fix
>   that needs to be added anyway by looking at the code in clk.c)

This API seems only used by TI gate driver, this change should be in a
standalone change go through clk tree. So I would your changes
as a standalone optimization follow up patch, while not included
in my patchset.

THanks,
Peng.

> 
> Thanks,
> Cristian
> 
> --->8----
> diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
> index 5327e0547741..a669a2f2f78b 100644
> --- a/drivers/clk/clk-scmi.c
> +++ b/drivers/clk/clk-scmi.c
> @@ -121,11 +121,7 @@ static int scmi_clk_enable(struct clk_hw *hw)
>   	struct scmi_clk *clk = to_scmi_clk(hw);
>   	int ret;
>   
> -	ret = scmi_proto_clk_ops->enable(clk->ph, clk->id, NOT_ATOMIC);
> -	if (ret == -EACCES && clk->info->state_ctrl_forbidden)
> -		return 0;
> -
> -	return ret;
> +	return scmi_proto_clk_ops->enable(clk->ph, clk->id, NOT_ATOMIC);
>   }
>   
>   static void scmi_clk_disable(struct clk_hw *hw)
> @@ -140,11 +136,7 @@ static int scmi_clk_atomic_enable(struct clk_hw *hw)
>   	struct scmi_clk *clk = to_scmi_clk(hw);
>   	int ret;
>   
> -	ret = scmi_proto_clk_ops->enable(clk->ph, clk->id, ATOMIC);
> -	if (ret == -EACCES && clk->info->state_ctrl_forbidden)
> -		return 0;
> -
> -	return ret;
> +	return scmi_proto_clk_ops->enable(clk->ph, clk->id, ATOMIC);
>   }
>   
>   static void scmi_clk_atomic_disable(struct clk_hw *hw)
> @@ -204,6 +196,15 @@ static const struct clk_ops scmi_atomic_clk_ops = {
>   	.determine_rate = scmi_clk_determine_rate,
>   };
>   
> +static const struct clk_ops scmi_no_state_ctrl_clk_ops = {
> +	.recalc_rate = scmi_clk_recalc_rate,
> +	.round_rate = scmi_clk_round_rate,
> +	.set_rate = scmi_clk_set_rate,
> +	.set_parent = scmi_clk_set_parent,
> +	.get_parent = scmi_clk_get_parent,
> +	.determine_rate = scmi_clk_determine_rate,
> +};
> +
>   static int scmi_clk_ops_init(struct device *dev, struct scmi_clk *sclk,
>   			     const struct clk_ops *scmi_ops)
>   {
> @@ -300,8 +301,10 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
>   		 * specify (or support) an enable_latency associated with a
>   		 * clock, we default to use atomic operations mode.
>   		 */
> -		if (is_atomic &&
> -		    sclk->info->enable_latency <= atomic_threshold)
> +		if (sclk->info->state_ctrl_forbidden)
> +			scmi_ops = &scmi_no_state_ctrl_clk_ops;
> +		else if (is_atomic &&
> +			 sclk->info->enable_latency <= atomic_threshold)
>   			scmi_ops = &scmi_atomic_clk_ops;
>   		else
>   			scmi_ops = &scmi_clk_ops;
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index f0940af485a5..79b90a8099d7 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1200,9 +1200,11 @@ void clk_gate_restore_context(struct clk_hw *hw)
>   	struct clk_core *core = hw->core;
>   
>   	if (core->enable_count)
> -		core->ops->enable(hw);
> +		if (core->ops->enable)
> +			core->ops->enable(hw);
>   	else
> -		core->ops->disable(hw);
> +		if (core->ops->disable)
> +			core->ops->disable(hw);
>   }
>   EXPORT_SYMBOL_GPL(clk_gate_restore_context);
> ---8<---
> 
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>
>> V3:
>>   Add check in atomic enable
>>
>> V2:
>>   New. Take Cristian's suggestion
>>
>>   drivers/clk/clk-scmi.c | 14 ++++++++++++--
>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
>> index 8cbe24789c24..5327e0547741 100644
>> --- a/drivers/clk/clk-scmi.c
>> +++ b/drivers/clk/clk-scmi.c
>> @@ -119,8 +119,13 @@ static int scmi_clk_determine_rate(struct clk_hw *hw, struct clk_rate_request *r
>>   static int scmi_clk_enable(struct clk_hw *hw)
>>   {
>>   	struct scmi_clk *clk = to_scmi_clk(hw);
>> +	int ret;
>> +
>> +	ret = scmi_proto_clk_ops->enable(clk->ph, clk->id, NOT_ATOMIC);
>> +	if (ret == -EACCES && clk->info->state_ctrl_forbidden)
>> +		return 0;
>>   
>> -	return scmi_proto_clk_ops->enable(clk->ph, clk->id, NOT_ATOMIC);
>> +	return ret;
>>   }
>>   
>>   static void scmi_clk_disable(struct clk_hw *hw)
>> @@ -133,8 +138,13 @@ static void scmi_clk_disable(struct clk_hw *hw)
>>   static int scmi_clk_atomic_enable(struct clk_hw *hw)
>>   {
>>   	struct scmi_clk *clk = to_scmi_clk(hw);
>> +	int ret;
>> +
>> +	ret = scmi_proto_clk_ops->enable(clk->ph, clk->id, ATOMIC);
>> +	if (ret == -EACCES && clk->info->state_ctrl_forbidden)
>> +		return 0;
>>   
>> -	return scmi_proto_clk_ops->enable(clk->ph, clk->id, ATOMIC);
>> +	return ret;
>>   }
>>   
>>   static void scmi_clk_atomic_disable(struct clk_hw *hw)
>> -- 
>> 2.37.1
>>

