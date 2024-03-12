Return-Path: <linux-kernel+bounces-100187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAC4879349
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69B13284872
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3F479DA4;
	Tue, 12 Mar 2024 11:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ZnuBTszA"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2069.outbound.protection.outlook.com [40.92.52.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DDD7828D;
	Tue, 12 Mar 2024 11:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244033; cv=fail; b=m1hsRWtfuYCVYTNzQMf0aZrPkWARsAslaQzTStKtLfGIQaeW900yCabWly121EEeyKeAAsFCrsDywLwlmQIiUDu5r+tX1/HZsOceMunArwRtDUtDjqyoLj4ZA/xtxenR8P4iO+DaD/DZa7n4FWfCmy+KBQx1rl/eomfkap+v/HM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244033; c=relaxed/simple;
	bh=teBKC8GeJaFrp8TWWIR4GtYD9O/HNzdhsMURbIBqYG0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UH1thyu+iUplrscEJXgwAwrKzNDbatTgVJEowZ78tZUWNead7RYX72PnZsGF8tEbCVheLalClOnImIqBwMYIjynb7GmunYTGy2nTskvemU4DkjsAhAJBinpSzlscvivD8yJq+p0byhY2gpq4laGGllXCduHA8lSYYCs2OVcc6ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ZnuBTszA; arc=fail smtp.client-ip=40.92.52.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egz+PnjxHHkdBOhJkHh4ee8qRx5OEa1aLFPRYf1gF/Zfu6vazcYix9cJA1IR1blgcer8mrXmWjiurngHwnMQbUyK9GgtCI7Wf/uwFNx+O+qNS+uAzk5r362Iw0u23Nla3bip7LwFskXqgNMP+AdHvoDVT/EGuaUhuQTsCMDRYCUngbOMuFpEeh8fZw256QQZaiPJg3Xv65hdQAbt5VeLUnj1vz6Xb3Iq+tPoD6ie1WwrwVBQNev3SQV9eABMpxTVdYu77kpCE7hyHaObmA5r6yHbca1YebTffQLlnnynTigswVyyTx38t+fhWDEOFN2gNDyVzDhkxDR9P+wn5rLQWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/LMTjAasTC6GdsKU0fg9Dv0UD5w/7OpqvuY2pZkvQg=;
 b=e2Mynpo5rJgvgcPtJsej3vUptvtlJGJkEI2zNj9Ia4CRqeYGDcYauKmd7n7yClAq1mZv8WgjlN8njtm7NTpbthA95ROTGKWb5hZdoHjrwnvkXTUGOYaz6zS7CCMk6FyeXBZp0fqCF/khSoQRAWZNlY0/l90ZHVnS/MpBiMMHdR/IQkLTHu1hWIgT3lmFu/yZfOHXQ8+HyLCUH9VfKdpdLpb3umz458pydSewCmnFC0eDIELacoEK8mOJKV/4X6jdggSQMwC896tdRhZ17mrDh91Ko1Ed+GcFSvW4UyojtrOfF8w/ZUPE0fjr5GC5lJ0VbHZHjEkoP64YQi6tDIF1DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/LMTjAasTC6GdsKU0fg9Dv0UD5w/7OpqvuY2pZkvQg=;
 b=ZnuBTszAArhG0VNCb7CqXb/D4Kry52lJlmJFB9L/9c0HZdrIcpRodLrOBEvSEb5B4MD2etQ3b/okoad3jEolEpqL4hXGD1AIJNBlxZ//VIh2T015qvqgHRF+Q8chUojBhR4Jno4Fa5082/iUzfUV6viqzbs2KMDRRD7Xy52ZcvkY56kETmDzv9jaRpxiGASqM81IPU6Tagkfu+6o1VlxVW4erS0QVikudroCyUp2J2Z444YyQhd7p0mDFKASIcpOJvJr6Zb71RzmzkuQqOM9MU29MzWckjldpoGawYeKLmoIoSNiCvOwMx4Yf0rQPMyk+sI7X8QbFKEbjnkjRgijsQ==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TYZPR06MB6746.apcprd06.prod.outlook.com (2603:1096:400:44e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 11:47:04 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8%2]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 11:47:04 +0000
Message-ID:
 <SEZPR06MB69599C39A47E625A0C3CB83F962B2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Tue, 12 Mar 2024 19:46:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] arm64: dts: hi3798cv200: fix GICR size, add cache
 info, maintenance irq and GICH, GICV spaces
Content-Language: en-US
To: Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Jiancheng Xue <xuejiancheng@hisilicon.com>, Alex Elder <elder@linaro.org>,
 Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240219-cache-v3-0-a33c57534ae9@outlook.com>
 <SEZPR06MB695952078B51C4549191F8AB962B2@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <65F03D79.2070008@hisilicon.com>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <65F03D79.2070008@hisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [6nwJUtwr8k16QazPKUGcxLmhKix0C1ju65H2/doLlY4lgEIU9oOhiQMesrEPcq6+]
X-ClientProxiedBy: SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <a37dc049-8925-401a-a427-5567a32d7fbc@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TYZPR06MB6746:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dfaf9f0-220b-4688-1b75-08dc428a2267
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	M054QJKCzi7P8raVFxvt/IxtsuavbN848C0keoBDovm3olemoj992Cz9sfZRtHW/QAj0Zgp6Ad2PxbG3jpNWxOCjX0qmlQ3RDQJozjAGuDPlMK4UEklQmLVbcv2MfRsPZSqsh+XqsQY+9T70Yydu0w8k/KqjHY6xFQL6GkgoFLaOEtJZnLNb8XJBX8iNXb5H5ejmCIfJSVpeOzv1JIea9+4NBLPxjnOouF1cIa4dz48C8rIi2FrjQjpEeioGXrwTwt68VhA9M4BrKAdWdk0ySgWjFq/tA5OWxwZzJabThbYxxIEEXEG3jamZteZ5G0kfvkJGvIQXmszrl/XxUmuE6vVKAK5r6BgHM/DvQ/7iGyUKkLjcLTwA2lEKzTTFq5i5rTufK7Jl4bIec0+F3BicM5mxOnt87mccQV+ERRGP17cXPI46GlLudme5XR+0FUj2EvIUBs5lBtA6+AwLEyV4Xe91YqbEAmoEMqIZ5aMU582ekB8NFDorV9ytpryaIn2LQHs2tFrvBP6r8cheYO6ZVkzGahJ8oWUjDTc/AS1y8Be4L6MpYNJhJucUnWoDm8ebtXDxzqloD6xlQypl8ooM0p+p9wlFTnbWgDKbQpJ2cJjy64R4ENX57hjQQJ40gOuomC7BaAvR5d69uPE80tAARim/Pv+BTmjmAaTHg9k8Xko=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWc0dk02MkVSV1pZdXdXT0R6ZmxtaUFBMXg4QVQ5ekt5Y2dkQmFpNjg5QlM2?=
 =?utf-8?B?SlVEMXNlSnJmYVRDSTNXZFJCczlTRnVFcUZpelhTakdLaDFwL2g1ZXVtMTN0?=
 =?utf-8?B?TFBwSStPek1CSGlKbHhhOWNoZnVsRm9wNG5ueWZjdGl5am9iL0VEdG1kYUth?=
 =?utf-8?B?WHpBZEdXWUQ0YUtVZG1MajNvMWhtWjI3K3ZJaUdtaUJSemdwK0Z1a2JhNmRN?=
 =?utf-8?B?VWJTYk9RVVQxSzhpMXdNOFIySWpYR3JyaUdxOTRpKy93RklNZHJPbURQVjVU?=
 =?utf-8?B?VTVNMEJpNnZCZDNIcEJLc05oRGZaaWc5NkdmWlhwU0d2UTVDbytQbWJhalZR?=
 =?utf-8?B?ckN1R2hYcmd1UmpxYjVUT0J6eHVxNFdBN2NNaWQ0OTdxdWJmUmdheTlHWUxD?=
 =?utf-8?B?dkZxN0RnY0Z3elVybUtvUkdiRCtER0pJTyttU2ZxYzRWUkg3RFpJV29jSWMw?=
 =?utf-8?B?WWFxdmdUZXN0dU9KdFN1eHE4WXpqWTJZb3prcmNURCtwYlF1azR2ays4b29J?=
 =?utf-8?B?ZXBvQ09FWERzdE02VHZrRHlDTDMrc3FPOFJSWlc4UEQyVXByWVlrd05jNEJV?=
 =?utf-8?B?dnRKQkt6U1JVMkdkTWZYWi9HWnFnOVQ4YVhwZi9HdXl5YnNSTGRMd3Vqbm9C?=
 =?utf-8?B?TjN6WkVmam5yNjBvOXl4MVg5UG94QnFUNkdjS1gxMXVMdlNPbGNIbXBLRFVP?=
 =?utf-8?B?SDhlcWZUWEZmdTl6VGpPYy9WZlFTQ0FST3F3T3A1cFIvaTY4OEVDb0U1YVNJ?=
 =?utf-8?B?WG9CaitPd3ZwZnBqbngyaTBXang5eWM5MTZxWDBaNk9LT3A3M29KOEJ2enBZ?=
 =?utf-8?B?MldmUityTmNZZ1BpSzNadSsvckpOK0hlR2c5MFJoZnBhNndaTmFhUWRwY2lZ?=
 =?utf-8?B?bWd2M1FSOGNVeDRuTGErNnlzQ20wMjZzS0JJSlhsWFZWSW9WU2U5ZGVFTGQ0?=
 =?utf-8?B?dXdaRG5zNEJua0MwY3FKL2Z0TjJ4UWdhSldEVnNEenJyb3E5dEtNVFhqSEFq?=
 =?utf-8?B?SkJ3OWo2enVkWitUMHNLT2pNZW5ZS0x5MEVUV0x4ckNpU1phQTJ2aG9NVFI3?=
 =?utf-8?B?bkc3RXZBeUw2T0FCTEczU0xlWStXN3ZjclRCRjZiZEtOM29lNEFIVE4wT251?=
 =?utf-8?B?NDJ0ZDJNdXJsbEttRTRnaWpiSmlBR2hSOVRVSm9KdVdjekhpRys1SFpVd3hu?=
 =?utf-8?B?eE0rZzVmREtudDlpbTBBT2hBNHRSU1FFY0ZmbWh1NmZrUTJXakRsUnNjckZw?=
 =?utf-8?B?QmdnNnZOODgyUFJUbWtGYUdzR1ZtSnQvQ3VlK2dnempCT0dlM2I5dHkrUHRs?=
 =?utf-8?B?U3FCSHJKaVByb05OWHJFS0FqMzdpMU1RZUEwMWNFMmlFTGJxTjhadGJ1YUQ3?=
 =?utf-8?B?WE80d0UvNjdXYVJBY2IzYjBaM0hoY0djVitOZHhvRGx1WVVzaVBaTGxrY0sw?=
 =?utf-8?B?NittOEFQZkFQZlFmSGdJWGJleWU3a3RmNExHcm5OQkNsRUJoQ1JKMU01UlZa?=
 =?utf-8?B?WEhzZzVRdUVUNVJHcXluaDlMQ2pOMnJxRVhRMHd2MmtUS1R6a3BVQUVMdkU4?=
 =?utf-8?B?TTNIa3N0VkZOL3N5L2VVUXcwall5NTdRY3JDb3p6NGVWbDF2aTlxYXBGZGhI?=
 =?utf-8?B?dU02Z1JVdkpUZzlQQXBsR29zY0YrZ0xYM0w4ay9ja2pQeEZTMTUyQzFiUlh5?=
 =?utf-8?B?Y3JUelJURTFGTXIyY0UxQWRXNVA4WFIzY0NmU0FZMDRsank1RkNzcEJjeHBT?=
 =?utf-8?Q?tDpYuwNL0uOKT9SGur27J3yDmhKejkdyJoLx0qk?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dfaf9f0-220b-4688-1b75-08dc428a2267
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 11:47:03.1978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6746

On 3/12/2024 7:33 PM, Wei Xu wrote:
> Hi Yang,
>
> On 2024/3/12 19:19, Yang Xiwen wrote:
>> On 2/19/2024 11:05 PM, Yang Xiwen via B4 Relay wrote:
>>> The patchset fixes some warnings reported by the kernel during boot.
>>>
>>> The cache size info is from Processor_Datasheet_v2XX.pdf [1], Section
>>> 2.2.1 Master Processor.
>>>
>>> The cache line size and the set-associative info are from Cortex-A53
>>> Documentation [2].
>>>
>>>   From the doc, it can be concluded that L1 i-cache is 4-way assoc, L1
>>> d-cache is 2-way assoc and L2 cache is 16-way assoc. Calculate the dts
>>> props accordingly.
>>>
>>> Also, to use KVM's VGIC code, GICH, GICV registers spaces and maintenance
>>> IRQ are added to the dts with verification.
>>>
>>> [1]: https://github.com/96boards/documentation/blob/master/enterprise/poplar/hardware-docs/Processor_Datasheet_v2XX.pdf
>>> [2]: https://developer.arm.com/documentation/ddi0500/j/Level-1-Memory-System
>>>
>>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>>> ---
>>> Changes in v3:
>>> - send patches to stable (Andrew Lunn)
>>> - rewrite the commit logs more formally (Andrew Lunn)
>>> - rename l2-cache0 to l2-cache (Krzysztof Kozlowski)
>>> - Link to v2: https://lore.kernel.org/r/20240218-cache-v2-0-1fd919e2bd3e@outlook.com
>>>
>>> Changes in v2:
>>> - arm64: dts: hi3798cv200: add GICH, GICV register spces and
>>>     maintainance IRQ.
>>> - Link to v1: https://lore.kernel.org/r/20240218-cache-v1-0-2c0a8a4472e7@outlook.com
>>>
>>> ---
>>> Yang Xiwen (3):
>>>         arm64: dts: hi3798cv200: fix the size of GICR
>>>         arm64: dts: hi3798cv200: add GICH, GICV register space and irq
>>>         arm64: dts: hi3798cv200: add cache info
>>>
>>>    arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi | 43 +++++++++++++++++++++++++-
>>>    1 file changed, 42 insertions(+), 1 deletion(-)
>>> ---
>>> base-commit: 8d3dea210042f54b952b481838c1e7dfc4ec751d
>>> change-id: 20240218-cache-11c8bf7566c2
>>>
>>> Best regards,
>> May someone apply this patchset to their tree so that it can land in stable at the end? This is a fix, not adding new functionalities. It's been 2 weeks already.
>>
> Sorry for the delay, I am too busy to catch up with this cycle.
> I will go through this patch set and maybe apply it during the next cycle.


No problem. I'm just a bit worried if this patch is getting lost. It's 
good to know it's still maintained. Because i've seen some maintainers 
not reviewing any patches for over 1 year already, with their names and 
emails still in MAINTAINERS.


By the way, I think fixes and new features are in different cycles? Most 
maintainers seem to have multiple branches to handle this.


>
> Best Regards,
> Wei


-- 
Regards,
Yang Xiwen


