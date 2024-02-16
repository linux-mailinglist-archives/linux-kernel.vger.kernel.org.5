Return-Path: <linux-kernel+bounces-68680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E142C857E4D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD5981C2267B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5FD12CDA8;
	Fri, 16 Feb 2024 13:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="AK/3c6oD"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2024.outbound.protection.outlook.com [40.92.52.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7870512BF1D;
	Fri, 16 Feb 2024 13:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708091913; cv=fail; b=u826tNShA9AYkJXpFj7+R2TxmWwu4pafqgqD0+REDECGu36ilddznCEQq5WLNNLr+BAH26apoyCAZWGSV+KLvLA31s7+2rSeGKqR7H71P9TJdgIBy3I6BH7I3axxZMR5ueoYjC1DdgfguK3x8s4JThxpXJDhVYC0kr99QxfEnsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708091913; c=relaxed/simple;
	bh=WoBwsrZ+R2ObDbtF4eWpXlYgv91KwJUHJHi3preXTMM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nohoFvEznj22YKPnN3Y5zcTmqg1t7Lj/aiDM60oqiDDXVtMHWQpKA7n6ipgGBYWuP2AmSbq9akKEbW3NHPENdThmD3ks8oUVRX3h9l3jBKoTTPQc4JYYt1XLSbcb8o9SZmnzEFOIwZFGRdz4KikW8rbKa9uZIJhbTPhIFgDrXf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=AK/3c6oD; arc=fail smtp.client-ip=40.92.52.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVIFf3vf3fIOERquF80jHGoJcQ1P6+aRYtj5m0tK6zHwEBMQAhe+YdrdyUuHnaeO88fUMuKFhzxu/tWyo1WhIbPpLjKHtXXBNx3DNgZwGGx/wOp+cscx6f5BaO2jU9mdh69IJgRYPGZaBfyn3M4LU16ajQpUeGltxb+xSSWvaUNqBJu9WPRO2lKjrVFXQwhX0sTc77EOukYbXeUEEtZH/6to37RNRiE2K4j1Z50ZBAsPkrFlfIEoFC25K2FcmHo4DjE0uXHp8jWfxr1ErwQAa3MWdLXMjgSTb8IOGAUbGC8Ln2rwP2axatWNiFxEsC529LAwB2KO4tNP3gF4D+3uYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+wdzkswL+zktvemtqTpBs+4mlLdJ++67Pk/7HXU02s=;
 b=Ony1w+INBpFhUtem3UOTZdZKtiIuBOBqmvD956MNzQijeAjoH/XJ4KeyygtOLmnzBngBpiGwy7JhNqM6qY+lfmkgPfLy/+euBYMpvYGyvkp5Scz5jJ7TBwmLYk71cb4YN3taP/oWuczdbpexiazGAkVQtxnLIBtzPsd1CJvGgZ4fU5FtEjX2x7FX72hkQdndZOkmH1pRd9gWvLk077+G7qsQ9Lp8zLv9g0ly//p/0P60gMQbQ8zEUG8Diy3PIn1TxAnibsLXziQ4moaUeEMz+5LD0sw1Crrp2zpxm0vLGk4U4ksqj53hKL7txUlNsna6I4aV98kwvJckFb+NOPEwBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+wdzkswL+zktvemtqTpBs+4mlLdJ++67Pk/7HXU02s=;
 b=AK/3c6oDHL1Dd/rZ1dmahQiFu4lvnfQtyWpywfR5iVanuTpHEJ+ztMmun9gacYKq9fWju15JBCLFv+nLvGI1oR44sCgeuqqFGMtZynRPYM4HCXI9wN6LP5sYCuyb6t7KROUoRBGr2Wwxh5v1dUhv/7cboNSlJqw2f807THVS4BZVRDn9dtj5tMI6kGh4Nag9TY2jVH389VHjPRXGbeQ+0hawhGYH2jl03JbVOTM6NpSOkssKPBsD/OVCMFoR33bMEctGKXyNtBbHXzlDeWA87x78EyZFK8rNVBG5UeBx7eltpGEfTXqbF+qEjB0jZP489fjUGBODuHldkLSkdR7kWQ==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TYSPR06MB7623.apcprd06.prod.outlook.com (2603:1096:405:bf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Fri, 16 Feb
 2024 13:58:26 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1%4]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 13:58:26 +0000
Message-ID:
 <SEZPR06MB6959CF6875201BFFDC6EF4DD964C2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Fri, 16 Feb 2024 21:58:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] net: hisilicon: add support for hisi_femac core on
 Hi3798MV200
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Yang Xiwen <forbidden405@foxmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240216-net-v1-0-e0ad972cda99@outlook.com>
 <20240216-net-v1-1-e0ad972cda99@outlook.com>
 <c00dad08-00f5-41f0-861c-cb40593b49fd@lunn.ch>
 <SEZPR06MB695972ECA5223EF5F81077BD964D2@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <f5453471-ed85-409c-a6a2-04c92e59a7fc@lunn.ch>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <f5453471-ed85-409c-a6a2-04c92e59a7fc@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:
 [J7tTsmLR4ZFtZdH/j72zLZUiht2pc6Dxgdcw0Lgp/gmR8JQIKUPe7ipCbHiXTY75SlStjQk186E=]
X-ClientProxiedBy: TYCP286CA0202.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::10) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <d015f940-2f4c-40ea-89d3-e1ca7a62cefe@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TYSPR06MB7623:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a837f0e-070c-4793-a00f-08dc2ef75882
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tIj4BEmoMRYDCZUVMkw5BTtvyRpwbN5p1BCmI8Tpc5lE+d3iELskoWSpX21KOtb3OrJTAAOl9eff2+8Emk+LuQjhSANPYZEqG2v0gzzg9dZn71o2NELlP2lWZSJOV5GPrwMcRuYQPvafllA5pw0Q8xzlj6fFPoN3p4TcvG93hiNQr/ThAkw9RwZHssyXsolHtBPk0NG1hlUT4PuABHgvIbHv4qZQNte+4ihiF611kRmN6LbNSmSZbTV91yJdCOHEDOmbZVqE7S0d16BlWGau+u4nARsPTqKyrAwbT38bIGBoq9/0betdV9mknQtCjuqzZ+tTPq8GOv7R3EdG3Raip+iDaUN7G5Kk9ss9vvCM1iGLCq8UdjyQqa5tvQoA7LqCp7vsxm8FpP5CpFkLAGqTmSbCl+MFRCp5bLyYl29e4PnQ1ajZiLmejDKyqnnRlqnAZmn/FuYy9g7WpMxN38gcAkgAsIN8KatwogoopAJRkGEvKRiUTtqqa3RvGFPXm10rBmSMXg811+6udzC4icsCWnuwkjPohN/tyRPRkDYzinfPx2jUMjHq+YSA8zb3KDf6
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDNwdHc4TklDUTIxcmhseUhucUFCQ0dFb0V6NGN4UmYweU5MeFJvSTY2Um1M?=
 =?utf-8?B?c0hlR1JPaGx1SmlmNmllUkcyTU1tcEtvblNlTm5TTkFLM0RpN3I4MFVjMSts?=
 =?utf-8?B?SzA0WFIrYkV6Y0ZDUDhxRi95UDBTYmdwL296dHhRV3VKQXcrVnFEK0s3bjBm?=
 =?utf-8?B?NTRKV1NBZEx5dWprdDdSa1RDM0dZSlR4L2R3MUVRUW9qS1c5RkFjSi9xcTY1?=
 =?utf-8?B?MG5lbm84cVBlVERxWHd2K2JuM1NZM3E5cytEQ21xdmpHY1dGZkVEVkdYQ0cw?=
 =?utf-8?B?cU54ZnFmcWdXM1Y4dkJENmlvNUpDQkNYeDVldFZ2WVV1TjNZNVY3eFpKRXpH?=
 =?utf-8?B?d2drSDFoVU9Uc1o1dUdsZThXcXY1YnIzQit4bUU4bjVTVkhQdzYwK2tySGxH?=
 =?utf-8?B?NlVSWThwbkpmdUdYQ2MzRFVJb3d6RkRLL3VGYXdZZmNDa21qV2NQWUtOcElX?=
 =?utf-8?B?NXFSQ3VlYlZRSlVsVnRzV0xzZnlhY3RLZzA4c3hic0FuUXl3Q3ZKUHRKeFdn?=
 =?utf-8?B?amZZOU5wdzYrWm9GVHhtREo1MEZaOEVMWDFrQUhxaEhLa1F3YjhuUzNzSWJI?=
 =?utf-8?B?YTJxOXdCSDh5VXVTS1dYbldIZG1WalJKVHFUOHE3RElod0hwcVljTjZPZDVl?=
 =?utf-8?B?QUgrNnpwaU1vbFNsT2pTcHVkYjBQMzgvWTR2ek9iNjJUTnYyVVRZQU1CUHBj?=
 =?utf-8?B?SGJJdXY4L09KZHlmRTlmNFlqSEE2RnRhTjd4UGxKeUFiejc2ZWt6bmtVZzlD?=
 =?utf-8?B?VUl6Vm4zSzZTTWFXWVRBclhSbFM4Q3FZRVFLczBCc3ppUUVxS0l3Y0xVL1Jm?=
 =?utf-8?B?dktSODdhN1FFRGVhZ1RHQU5iNklXOWsrUzRCK0lYOEIrNjA1YU1zZ1VJcWNw?=
 =?utf-8?B?YmR3OEQvOURJTVZmaGdpSXVPMXpOWVc0aTZ2T0JTOXFvK1BkS3JuclQvbWYy?=
 =?utf-8?B?M2ZwZHgxemhHM3R1WDJpdnp4Y29vUnBTT3lYSmJQd2tGdzc3NkRyTzdCalFQ?=
 =?utf-8?B?MTl0ZXI0ejQ5VnNKSElLcXF1cG50YjJCQWdaQ2VDd2ZpTzRmQVZlTEFyclc1?=
 =?utf-8?B?elhaOUsrc1pjeERjcWhabURGd0psVlo5Ui9uVnlPSm1qVFBUZTNsYmdZSS9w?=
 =?utf-8?B?M3YzWUhXS0V4cnVhWEtzQWwzK0o2bmxrYVJpZTRYZ2hsaWhKV2FPaTJ3YlRK?=
 =?utf-8?B?UHdzMFpIYVkrZUhQM0pMZklvMzRISW0wR1F3VmdpZ04xTkkyVm1SRVpPTGZu?=
 =?utf-8?B?MzRmQmRhLzFOeDRKOVlVbEFOZVJuenBDSUd4Qk44Snp1RElqM29LTi9QbENR?=
 =?utf-8?B?eEdVU2FINzFRQ3EwNlpIbitkcGhjYTMyVUpvRUNseElWUTFMNVRqS2Yxb3I1?=
 =?utf-8?B?eUFzb1h1cGpJbThCUlA4TDYvZ1VvbDV1b05mZ2hXeWVTSUQ1OXBVdVZuWk5z?=
 =?utf-8?B?LzNRNzFvakRURzI3bGtheDFLUzdrcmxsNjVJZXRaMG5mSGs0bVdxQjRBTHUw?=
 =?utf-8?B?TTQzTWt2ZDZ6ckVzeE0rSUlzVWVKaEVhNlI0dFMyQk9KeGtINFh5ZGZDZUlt?=
 =?utf-8?B?dElFRHRLR0t3S1N2U2xieDBGNkNiMWpFVE1ySnJ0cHE2bG40dUh5d0J3ajlX?=
 =?utf-8?B?VVM4Yk9BUHl2MEhDNmdGR29DRVppbFBMWkhrNFZ4dnR6cVlOUDJHbjJzU2J0?=
 =?utf-8?B?a0paUWo1R1MwcFlxRGNMaUEzOTJMWnRxSVdiQk1LYjRKZTFDOFl2aVRCeWgw?=
 =?utf-8?Q?L8nxWdzn9q4g5YSDzwkYtvvZdyA74H2fQ7c4Pxb?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a837f0e-070c-4793-a00f-08dc2ef75882
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 13:58:25.7960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7623

On 2/16/2024 9:49 PM, Andrew Lunn wrote:
> On Fri, Feb 16, 2024 at 07:59:19AM +0800, Yang Xiwen wrote:
>> On 2/16/2024 7:57 AM, Andrew Lunn wrote:
>>>> +	for (i = 0; i < CLK_NUM; i++) {
>>>> +		priv->clks[i] = devm_clk_get_enabled(&pdev->dev, clk_strs[i]);
>>>> +		if (IS_ERR(priv->clks[i])) {
>>>> +			dev_err(dev, "failed to get enabled clk %s: %ld\n", clk_strs[i],
>>>> +				PTR_ERR(priv->clks[i]));
>>>> +			ret = -ENODEV;
>>>> +			goto out_free_netdev;
>>>> +		}
>>> The clk API has devm_clk_bulk_ versions. Please take a look at them, and see
>>> if it will simplify the code.
>> I know this API, but it can't be used. We need to control clocks
>> individually in reset procedure.
> /**
>   * struct clk_bulk_data - Data used for bulk clk operations.
>   *
>   * @id: clock consumer ID
>   * @clk: struct clk * to store the associated clock
>   *
>   * The CLK APIs provide a series of clk_bulk_() API calls as
>   * a convenience to consumers which require multiple clks.  This
>   * structure is used to manage data for these calls.
>   */
> struct clk_bulk_data {
> 	const char		*id;
> 	struct clk		*clk;
> };
>
> You pass the bulk API calls an array of this structure. After the get
> has completed, you can access the individual clocks via the clk
> pointer. So you can use the bulk API on probe and remove when you need
> to operate on all three, and the single clk API for your reset handler
> etc.
seems okay. I'll implement this in next version.
>
>         Andrew


-- 
Regards,
Yang Xiwen


