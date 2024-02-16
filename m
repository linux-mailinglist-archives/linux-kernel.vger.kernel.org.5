Return-Path: <linux-kernel+bounces-68643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B3B857DB5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABD95B22260
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F96C12A14F;
	Fri, 16 Feb 2024 13:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="uz/yWUj1"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2070.outbound.protection.outlook.com [40.92.53.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3631E129A80;
	Fri, 16 Feb 2024 13:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708090411; cv=fail; b=miMpSAfzHoNrPCZPrke3fWPHoR5SVvdumthnQpu+QZTVrBCbClACIPJg67TlaN+rn8clbZd6PTSmyVbyktgrBYv57hDfM27RDO/DRamhPd/1GI/thujX2pJMUWx1M4Y6o09S7P7r587hCyZL5VGYobn28wMNYzc7Rr51xjXGV1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708090411; c=relaxed/simple;
	bh=BLJNHhVLrC0bFgyXKL7PfaL2FDe+xeBzZVEo+z+h8LI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NS+iKta0x5sPKfomxJf+Hd3cBOJbbvTUVAmxJ+aBRw5UtkeIh8hEgAn9F27Bh4R4EAvTD7H5R8nJX0pXSrc2dmnjZmxQ6cQOaO6flE22oh7GUEE0z7ZNsTxdFJYb/pNcM1hLzWXamWv+YHUoArZgCtJ4fPYyjMCqMT/ykaBqQRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=uz/yWUj1; arc=fail smtp.client-ip=40.92.53.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFDVudX6bTI28ljfQRxbCtc9WJySVGQUzzHZoUQ+eql4RTU0XpUkFfKlLEufzXJqdLqH5+ITwiCdZN2foFzFQqPky5WmQP6RB8gG1lLLWXR/M7JjdcDza52PnoEzOMnfESGeG1GKP7I+3unwdLY32oK8976tKsqY0L6vJgTmgKFcwe4M8jp9eOUAg3i4Pjg4NMbnksdQyh3aEm1edBQf9kJThBWkcbnsmQfIiERQzqqC2j8PaKj5GPH2wpvt8J9WO07wdJBfsJ1ZBUAvYpbKxVsGDPL5sovnW6hqaf5Ct/zRJEQy8l8S0dgg7Oz41kzzzgNnjsvBn39KacFrXNnW1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4V6O4ZrWXlxjbJDYofiT0QUlyZJRi748qTb6gdP3rj0=;
 b=a3kmZ1nrAZiAcHyQFTRxYtmPm3gONaPw8/wUs5ZbFfp9is0iMxPv6bkIc3RIRecmF++Dxc7stvHgApAIy+ysYjdaDU69rFV6TH+mGKYuQJ+4zXJpDFO23jmAa39hFgCJWLFQRyWbzF6FXyA4GFlDWn5AwxexJGX7NqKnwcxbhK1B1tqO/mSK7U4PcNONUemgsvJyWM1wF1HpYzSt2PY2PPVRlnWkYI0peOJiCbR3oxkZgL0nrtkqxk1zCHxtjMu9FegFPGec43u0FPiudelYFEPxNGtb3V7JbYg1k9pSZfyJXdMTbpFHytvk8P2K/Pzo4L4w3U03T3+e0lTNabnPjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4V6O4ZrWXlxjbJDYofiT0QUlyZJRi748qTb6gdP3rj0=;
 b=uz/yWUj1caoQvgYOPVLCTVahAR1yI3B755NsSirNj1AZ5aqkHuzQUc1QipapkCS37F19lspZzj7Vq756FrXmcR+0RLbBobn/zaf9HsK8p80My8UZy+osW7cROAnOUluxamQztDOP3dOTAIx2B9CdQJacUoNC/+qDY7PR0z99al07MXID50gdmAQsxxVp5Gk0hpcpcbU7/KoqqMEJT9cFyVFKmYitUKeuHb76NJkR0lxMiA1zZHJ38FESHmi+WWrojq8kq3437CTCvHdqULp+l8c2uQEyFgKfD0nPVAa4R/3EFx/DUEs/bWIhT2X1quPbNcVvu3QLbBpc+O1xv3hYyA==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by SEZPR06MB5692.apcprd06.prod.outlook.com (2603:1096:101:ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Fri, 16 Feb
 2024 13:33:22 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1%4]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 13:33:22 +0000
Message-ID:
 <SEZPR06MB69599F74D3C7D2B7705C9DA7964C2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Fri, 16 Feb 2024 21:33:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] dt-bindings: net: add hisilicon-femac
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
 <20240216-net-v1-4-e0ad972cda99@outlook.com>
 <6dbd998c-269d-44eb-bf00-1eb79ee66f0e@lunn.ch>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <6dbd998c-269d-44eb-bf00-1eb79ee66f0e@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:
 [cLHC7GZzbMbIIAcw+poDY5PbwgoVeXW8/8AcuzeVydFIbgKK03xZz25DqR36H3b6sehPyZT0zJE=]
X-ClientProxiedBy: TYWP286CA0006.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::16) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <a3f20aa9-75e3-46ee-b811-b641c6673d80@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|SEZPR06MB5692:EE_
X-MS-Office365-Filtering-Correlation-Id: e1654d88-b528-4b84-226d-08dc2ef3d7e7
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XZV5BYEmruRgeKFnLKIbLeTJ+S/QKLQDPUZ8UBpKFDMGr6LX5el/9403GVUSpwx2lT3zGWBQJKMK1ztDyYf6zU/8Z0wNq9cwFbE0iT2WxTWYW6Tee6He4J1UcE9Z9k5dUXysBjKJ1BQLNqpt6R7GjpZYGbqGl1w80emqjrOf0ll4JrKPVEfWqtfTdDilR26ChWAG+G/qjrogesbog7kqbQLZy0WRAe0cokgc/dFZVwU9m2Uj3F+G6izgjpJu8dqccxxiQ+7bZT6dw1aRkyvnM2qJphIzyTN4CniNPixm7EhdYakyo91VPvUT/oryw8h0qjeit43DoxTtcGrtQniw5JV6tdupNF6eZMHU04UaMZcTzoYgIpMYcaH5qR+//py1R9+2Frl+AoHqDEJP32oozFHWEZX7X04KUCI83a007BDjip3SrF87hLbLJ5o5WZFihmEhZ7Qfzg1TkQI8TkR+oLAbgBILBi1GLCdWbk3ar5EXCKSAMjTxIUXEKcRempQ1IMelgbRjrbd/bpWeRnzywNjAhZeDaf+svq4HRc0k1LoS48sWJMNvIDrqbRnZyVI1
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjFla3crZ1pYblRUNmVFUGtiR2JlNG9yS05mV296QVEyZXMwbEhxV3lyUUUz?=
 =?utf-8?B?bVJ6T1lsNjB0Q3dLRXp6ZURMWmIwcW5CdFBKK2kxSkJRUGVNZ2IzWE9SaVZC?=
 =?utf-8?B?T3RDV1FQQ0V1L3JRRllOUDQ1czFGQjNEVmdQaUtDU0MwN0tSTXRtOHFqSEU4?=
 =?utf-8?B?cG53YlZZZmUvcHBpSkszQVVlWHk0UTNnd2RXNTF6SlpGQ21nVTRGTmVxVnov?=
 =?utf-8?B?U25LRm1mWVRNNFp1d0ZiYlRJdzhJU3dOSlhQWXRuNVJOZnVMR0ZmQUxrYVFW?=
 =?utf-8?B?Ni9MWW9FRERvMFliQkpNVzE4QWFpVk5kS1djUnB0RFVaV0pUYlVENTFRZ254?=
 =?utf-8?B?UGMvOU9wS3N1ckF1a1FoelFqL1pnZlZsb0thb1JqQXlKT2pzZUE3MGJ4dlRY?=
 =?utf-8?B?VVZ3aVZkQmk4ZHF0dEMyd21oamhoTlJpcVZ6Z3gwWGp0VWI4dEtVY21WSFhw?=
 =?utf-8?B?NURpYldqSVQvb09nWjVMRVhYSkdxR1RYcHAwUUk0b0xTdTdNUTRzUUlJdEFN?=
 =?utf-8?B?ZFBpN043OWo0YlBCMVYybXNDQW5KVXR0NDYrMk1ZeERrZ1ZWREFaUGtVTXI0?=
 =?utf-8?B?MDY3U3lzb0FQK05hdUlKR3JiRkxsbDN1L1ZucS95MDRzaitTSmVXdW1PNU5T?=
 =?utf-8?B?UENNV09FaHpKMjRuZnI4RmduaDUwTTFHOGFIbkNDeklhSS9BNXU3eTdLUmRU?=
 =?utf-8?B?NXh0WDJyTGo0Y2E5dkM1Mk9Rc29saFA1cThQN1p1bFYwNjFkU1BISWVpRHZJ?=
 =?utf-8?B?WFhNUjR3M0tJeDNnLzFWRkxIUUFmMDMwVmNYakVxTHFPU1cyUXVjdGVpaTdM?=
 =?utf-8?B?azdsZGFVWEk5dUhBOUdGbERocTg5bGpYeWhRYWI3RU44SGRiUGJxVkdvdGNR?=
 =?utf-8?B?b1pFNzlXUjBHNllDSFgzdGRQYng2KytPekpqSzRDayt3TkJtdDFlTFI2MFJy?=
 =?utf-8?B?VnhubmxiSFpjTzhNSXhUbUhyYUlDWTE1Sk5pREZJNWRtd3JxUnNic2JkUk1z?=
 =?utf-8?B?LzVIdVpHek45SS85Y3VRMkw0cnM3YThzVTJWbVJqNTBVUzI1cHNDaFBvY3ZD?=
 =?utf-8?B?QmU0bWlaVGNTV2pCcXhkTkxKY2ZKUUpGeldFeWx1VFhOalVVci9ZWUluTVJp?=
 =?utf-8?B?TkFtanFmRzR0bWxrWTZNSnZEd3ZUaGFaVy8wd0hwRjA3bzVhcWprdHpVK2Vm?=
 =?utf-8?B?bkw3UzhNbUVzdENER3VUeTExWWVCZGE0dUFPOWp2NWNseFpsclg2aHRxMTBp?=
 =?utf-8?B?dFFMa0d4YnR6YXVrdHFoNnNqRU5STXZ1UmhOWWxCekpOaDg2TTg5aVhLRlpE?=
 =?utf-8?B?SW1yZHhlQitqZ01ZZnphcTdFcUFGZmVUdEZsY1NHWkZGTXZoc3pxTE5ocFhS?=
 =?utf-8?B?eVYzUUdGWXRTYU84R2tuZzF4a2xWTE9aRVdGWUhHQ1VUMjhITitTQmV3SEdZ?=
 =?utf-8?B?TmNuWFdTbWZIUWxxNnQvcG1sV0N0RjZhNGI4UjM1ZDYwa3ZMWVd1c0VrVHFN?=
 =?utf-8?B?SjBzWDUzSmFDcGttT04vRW02RmdLekZWNkplenZMZTA0Mk1Ba2ZpazJXRFF3?=
 =?utf-8?B?cDRuUHQ0YUVmaVZhUWlhY0traW91SzlmYSs2dnUwVXZ1U3BjWnNBTm1rNVJu?=
 =?utf-8?B?RmFPeXpBTFEvdnRsOVZDczl0RW9sVlUwY2VrdWUrbXRqYnQ1ZlY2emJkVExQ?=
 =?utf-8?B?L09udGkyUE5RalZGVVVOOUdMSTAxWmZBOEY4Uk5vZUF6eHhlQWp5NFNRSnda?=
 =?utf-8?Q?h7eiM5pyNrNoc7fRu3h+zsMpk7D+sm/KpEGYTrH?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1654d88-b528-4b84-226d-08dc2ef3d7e7
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 13:33:21.5745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5692

On 2/16/2024 9:11 PM, Andrew Lunn wrote:
>> +    femac: ethernet@9c30000 {
>> +        compatible = "hisilicon,hi3798mv200-femac";
>> +        reg = <0x9c30000 0x1000>, <0x9c31300 0x200>;
>> +        ranges = <0x0 0x9c30000 0x10000>;
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +        interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
>> +        clocks = <&crg HISTB_ETH0_MAC_CLK>,
>> +                 <&crg HISTB_ETH0_MACIF_CLK>,
>> +                 <&crg HISTB_ETH0_PHY_CLK>;
>> +        clock-names = "mac", "macif", "phy";
>> +        resets = <&crg 0xd0 3>, <&crg 0x388 4>;
>> +        reset-names = "mac", "phy";
>> +        phy-handle = <&fephy>;
>> +        phy-connection-type = "mii";
>> +        // To be filled by bootloader
>> +        mac-address = [00 00 00 00 00 00];
>> +        hisilicon,phy-reset-delays-us = <10000 10000 500000>;
>> +        status = "okay";
>> +
>> +        mdio: mdio@1100 {
>> +            compatible = "hisilicon,hisi-femac-mdio";
> Is the MDIO bus master a device of its own? Is this compatible
> actually used anywhere?
>
> There are generally two different ways an MDIO bus master works. It is
> an individual device, with its own register space and it gets probed
> as an independent device. In this case, it needs a compatible to
> indicate what driver should be used.
>
> Or the MDIO bus master is embedded within a MAC driver. It shares the
> register space with the MAC driver. It is not a device which gets
> probed, and so it does not need a compatible. The MAC drivers
> compatible is sufficient.

I guess this is the main difference between the old "hi3516dv300-femac" 
and the new "hi3798mv200-femac".

The old binding says there are individual clocks for MDIO bus and MAC 
for hi3516. But according to my test, it's not true for hi3798mv200.

I've tried accessing MDIO address space and MAC controller address space 
in u-boot with `md` and `mw` [1]. From the result, i guess the CLK_BUS 
is the System Bus clock (AHB Bus clock), and the CLK_MAC is the clock 
shared by both MDIO bus and MAC. The MAC has a internal clock divider to 
divide the input clock(54MHz in common) to a configurable variable rate.

Due to the fact that MDIO bus address space is inside MAC address space 
( MAC is at `f9c30000- f9c40000`, MDIO bus is at `f9c31100-f9c31120` ). 
The only thing i can tell it's inside the SoC, but i can't say it's 100% 
completely integrated to the MAC controller, though highly possible.

[1]: the result is summarized below, `md f9c31300` in u-boot is used to 
poke the register values:

CLK_BUS  |  CLK_MAC  | register values

Off | Off | All zero

Off | On | All zero

On | Off | System Hangs

On | On | All okay

>
> 	Andrew


-- 
Regards,
Yang Xiwen


