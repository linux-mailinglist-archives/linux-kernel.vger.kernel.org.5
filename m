Return-Path: <linux-kernel+bounces-82547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 476F5868635
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B084E1F245F8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25140CA6B;
	Tue, 27 Feb 2024 01:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="U5uncJFb"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2105.outbound.protection.outlook.com [40.92.53.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220DC36E;
	Tue, 27 Feb 2024 01:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708998230; cv=fail; b=NN96qw4ZhYagZGwZdKzdSJTOyu0qkJbReq5oHV9W8qVZ5ucpJDGPqXKp+RsSQPSrYX7rbTwjQLPzcqHRjFe5RS15IKplwBG7h/mQxO4IGgs43jwofYL0X5eYEa67xIsn0caqUryHSXlTe9NnBnl6MnGssnQYj3GSRqh97OAc1mM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708998230; c=relaxed/simple;
	bh=tHsTQvs6hevESFuALIBYkmxmBNDIIUPi8hcEFBzrg70=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QR4V5bMkWZpRNOhFNEaUxl8cN+NKMVHXompvi+XFU0L0KQuz6ybE6w4APkApTT5XS1JK/eJZ4JfKJuKI+w+ZYDE89GI2tTzWqMvmO0pWI7EOho/RUDCbTsiYBslEjmvFL2b2MeEog5GVT2h7fVIUEMx14aG95jccILNTq22iF3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=U5uncJFb; arc=fail smtp.client-ip=40.92.53.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSCbVJRqyXFayPkBnpeW799HaL2Y6YQnckQSYYb90axcDoUhCukxd8iKqu6EOIma1u82HkOePd/RqlfyzxJAvvYzYZdgwy74iErp9tG1wJA1ASwWLm4JRKvfvhN8GvnSVUOb5Wl9EZ68S1nmh6RcmAP0HxM0yPjRnPJEssCL2Vp3K6qUzTbfs1uKXiWlfzQihCcZyK2ALuAlOAoB2iC3amrX8kl55T2FrfR9wfWTkNElsIHZlTvj/GmMyf+GgW/Rl43LRCTBQh0fqDrZMS4AS38zfPe6RjFWkVRQdpCPU7qmOyA31N4EEDZ1FA2JA/dHyZq6JN9Eh0ROnMmfuGnz4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHQkY8OYY0bqi3wEIM6ERHxbGwJP5tO06q6RvEb9Y90=;
 b=ijuvVyDlMi4Z89WLLyhA7YnbNZKo7qP16pxdizYvYcTdz4Mm0DS+ov/2psg+x2R1sifg7Q42ziwtWEH9ozxbgNkWwuYaOw8XxGuSz+ojjo2CcWbag5HebYoh1LtobwOk5ta8AmJ+bjbpz9tbSE+V1iJp9Nm1zMvl0/NtSVF/Jy83m1y28fGgZyyTIbA1JgnqmL6WsZ7ILyW5E7tugDEyn5olDQWIaM9HpGsLixO3Ftfjd6NORraRRWvs7JkYHpcT0zKCxvefkhmM4pg6AwXVC9uUhfYfj1mLp5/8IZd9CgLhuOns3QWPO8RP3xrn3ulzhioKKH4/vzv2Oi0MOZtfmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHQkY8OYY0bqi3wEIM6ERHxbGwJP5tO06q6RvEb9Y90=;
 b=U5uncJFbhjdLWUYkZ2OMizLDPXdXLQcjgr1Q9CNpvEJ70xxh/HoOENICBawqHAuymaR3wIwaOA8CtrWRzSIwL7Dy2KXL5zKm8H+JdhBgPN046B0AOMrkjS7chVJ0aGCd+R6FrEJMujbCURMkjSUtkq1+4zNW1w3GGYZeBdm0TP+cDarVxxuLPrkqqbj9NPGdv9axKKEhP+Ua+5PcBr5/MimqZBze90Q+gknjEcfnkd0Dneh7ZYBvvmhpyMLm6U9R66jrP6jYE6JmD9PA5ULpcB6EBaizIqXWfVfH3BxCAGUBxr5RP7UDuzfD9mBLnTPQEieAFxyQP6Qde/ZWIwNiZQ==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TYZPR06MB7073.apcprd06.prod.outlook.com (2603:1096:405:3f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Tue, 27 Feb
 2024 01:43:42 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 01:43:42 +0000
Message-ID:
 <SEZPR06MB695901BB60F786D7E209EAAC96592@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Tue, 27 Feb 2024 09:43:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 3/6] dt-bindings: net: remove outdated
 hisilicon-femac
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta
 <salil.mehta@huawei.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240222-net-v4-0-eea68f93f090@outlook.com>
 <20240222-net-v4-3-eea68f93f090@outlook.com>
 <c3f3d276-46a5-4cc7-ab79-e1ca3262abdf@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <c3f3d276-46a5-4cc7-ab79-e1ca3262abdf@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN: [A1Hg+HI8nXyBtQIK+XdlBvfB3cwU4lNBOg4JLxGfp4BbQQ/1U0f1HLhHbVOpL96A]
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <d01fdc0f-ed73-454d-bd8a-1633a0ebe257@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TYZPR06MB7073:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f542af6-b5fa-4397-40f1-08dc37358703
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9Azh9Ls4VyZk607KbdiOUrRNKNyEx3Iyc79kq5gyvhF6L8sQ4bUWY4M6rTReXrvBoagzJE01lTpSljRP7KH1n8sVcZpiITdVjTrW7iXVwzULiP+2IN6YuyztYBFGQYGJtDAcfHjaznSLwGd6frPW6SPknZTkwufPe/JdwiADA+1AL2ajKEz2ou5LLkWJsnWldDXqD29C68z4qZ9xvKI8TB6x9RwsRkMw9mz+r9m4eRHAd37bB5eBJCA2dflfMiThyIodeYILqkwzdfRH3sjqk4Nrl5rJnCu6CG9tsiuPOG7OpkR7UGPUi1MfMnOTlqCvJ2TnzD3gahx4RldvuEJTjONUJP7k5uYlAw+qJoy+MB11iuYuk98p7f3np4tjeNzmJn2DXnmgPGEDIY7Co7RKHSp3N5rduDtZNly4O9KZyIdIDmpG3KKdY0PCvzrY3FmSWHkzH0wJZkkMNs1fXlhGxxud7cpDB5QAVPHcFZaKIzfxdpk8JfXefO7BycN4GjNCE7/hJgvWpjnA4IzG+1kTXGCgpWOxHRYWSdcH7RvhpY6o5NffKdxNqDQv+HtYH4aN
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajZIY090MTd3OUpPNDBNK2NEbW5wNGM0UmpmcE9ROHp4aHFBTUlWUzdMUWly?=
 =?utf-8?B?RCs5N2FTU1hwTzhaY2NsdmVYZXZCQzUvL2FFWFgwd3lBTkpLeDBjWnBDSk1W?=
 =?utf-8?B?YnVCYWJMWURqcTlQdGoxRDZjaGtXYWxDWk43a0V3M0dFMndPYWY4VmlWc0Fy?=
 =?utf-8?B?bHBTYzhvM0NENFdMT2RMV1lWT0tpWWdwMWJsWHpMbENRUjFSUTlka0JwWjky?=
 =?utf-8?B?dTg2c3lpcnZqMFJJR1liNXMwWVRieEUzVi83OTNHYXQyYjY5cDM2ak51eUJp?=
 =?utf-8?B?a3BVbkZXaTRZU3Z4VDlsTUtob0FjbVMyemVWY1Vkek9zYXRzejlCank4N0tn?=
 =?utf-8?B?aFFlZzc3a3hKU3d2SnlNS2VoYkVZbHhwc0dRUUMzVGoyYVBIS3FnU1M1UzVV?=
 =?utf-8?B?WGlKU01WeVZlRUprN2JKVmQ0Q29zRHFtSU00eG1EYm0zYjZQWCtKYkJZZmli?=
 =?utf-8?B?RnJJVkZhYm1OSkFRN1hDb2dmK1NUQWxJWi9UWm1BdnRQb3NiT2tQbWE4NTFG?=
 =?utf-8?B?bEN3THArcGd5UzlJd05Lam56cWVMcE4xK1hnNFBBbWo1ZGkxcVlyT0d1UDda?=
 =?utf-8?B?bDFPUmNSTzVNY3hod0xBdExDQTkzMThRbTQ1T1lEczI0MkwvVDFpYTlwL2Vp?=
 =?utf-8?B?NjRzczVsdUhLemlqYy91UEN5WDZucHI1RTErUGQ0dExvNEQwbGV4cnB4Zm5j?=
 =?utf-8?B?NEs1R2RDbTFYMGFndlhlYnFHZ1pCaWtzTGtRcUh3eDFwMzdHcWZvQUxCRkd3?=
 =?utf-8?B?Kzd4UUtvaTNvMGpiaUNHbWNIS2wxVHJPL1EyUnJlZU01S3BCYmpWSDMrTjhF?=
 =?utf-8?B?dEo0TWkxMU1xeVFqa3MwUDk1TVJPOWhObEVLaGJEcnlBS2tkN2FxdHNsVzR5?=
 =?utf-8?B?aVR1MlIvNkhSYVprc1ltK0VvVXorZlFLYjdHOS9xeTRkYVE4Kzh4dWU2cmpE?=
 =?utf-8?B?cURiMk5JNGo1UnRUb05vMnJjMEZ5MGJjcUxIaU9TNHN0M1RnN1RCenZVMU1I?=
 =?utf-8?B?NDFEWDlicXh4aGZTNzN1d2NJWjZVa1FCQ3ZUeGZwSUhBYmVUSy8zK0VGdG5t?=
 =?utf-8?B?bGsxQnNOTkZSL0J0N0pUZjZpT3BRU3JJbUdOaEtCZ3F3Q1JGTW1VcFJ4bEx3?=
 =?utf-8?B?dHM0ZEthV1pEbWk2UlB0NmdtTE9GOHJPWHRSK1M2OXR6N2M4Q0xGQStnb3E2?=
 =?utf-8?B?TmRtYlhPNk01NjFoZzVxdWJLUGxPZEFKT3Q0ejUyUEtHS1I1NnVFelJjOER3?=
 =?utf-8?B?bDZpNUVHaDEveU1OY0RDMDRTWG54SmJoeTk0ZWEzK1VoZks0czlwZzV2SkVW?=
 =?utf-8?B?UlJQU2JOTlpYODFxd3ZGdkhZVDRWZS92cjM5eXpzYUNxeFkrbXBHQTJ1V1BI?=
 =?utf-8?B?QWp2aEl3QkVNOHR3MHdvenNkdTRRdEsrbUVEZXkveThrZTFzVUVMQm5aRUZQ?=
 =?utf-8?B?OVUvVnkydmd4Zy9MTGxHMzFLN090NWVVcjZnWkl6cGZFMVpzUk4rMU5yWFpO?=
 =?utf-8?B?YlI3TGY5eGh4N04xOXBQSGlTdVpwSkxQVjVEWVRGK1ZPS0hXeUI2OTRMTGFa?=
 =?utf-8?B?QjlzMndhbDFCWGl2SzMvRloxTDYyM3prbWg3MHVQbm9RSzRDSEt6b2cwVkMv?=
 =?utf-8?B?WVl4ZVBEeFNPVlFSUlAwRHF4SlN4QVNmV0RHZkgxRGZMT25vdUV0bGIzZTE5?=
 =?utf-8?B?elJHUllEbmFSWGtHQ1k3V01yKytVMWh1cGw1U2lkN081TFJHL1oxTXBVZGhk?=
 =?utf-8?Q?AZTh1FxnX0oTBd9KDIfh7wNLJLhJGxpgdbIGi/p?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f542af6-b5fa-4397-40f1-08dc37358703
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 01:43:41.9599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7073

On 2/26/2024 3:50 PM, Krzysztof Kozlowski wrote:
> On 22/02/2024 13:43, Yang Xiwen via B4 Relay wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> The user documented(Hi3516) is not found in current kernel anymore. And
>> it seems this SoC has been EOL for a long time. While at it, Remove this
>> binding entirely due to recent driver changes.
> 
> This removes documented compatibles, which:
> 1. should cause checkpatch issues,
> 2. is not what we want.
> 
> Driver is still there, so first the driver would have to be removed...
> but then why do you add it immediately back? No, it does not work like that.

I has downloaded TRM for this old Hi3519 SoC. So i think with the new
driver, it still works for Hi3519 FEMAC controller. So i'll rewrite
these 3 patches and describe the whole thing in commit logs. i.e. the
old binding is wrong, inconsistent with real hardware, etc..

So you mean conversion to YAML first, in a separate commit. And then do
necessary edition to match the real hardware? I believe Hi3519 FEMAC and
Hi3798MV200 FEMAC are compatible in hardware. So the old binding is
wrong, missing critical hardware resources.

> 
> Best regards,
> Krzysztof
> 

-- 
Best regards,
Yang Xiwen


