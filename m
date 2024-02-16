Return-Path: <linux-kernel+bounces-69276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFD5858683
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF595B20A01
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFAE1384BC;
	Fri, 16 Feb 2024 20:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Zkxkimc8"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2030.outbound.protection.outlook.com [40.92.53.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D08137C29;
	Fri, 16 Feb 2024 20:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708114178; cv=fail; b=EAIDDr2KgsILBmunjLn1JsstwDZ2moRFpBNxAGMJLxC/S2ejOBnFcxfLHKysx7m483+YQ/fh+LVLSwP+LJHu90g0/BCMBXrHJeu58ufEm0X6xMhsZYTHKe8c/mACG1U5vwGdUqHB5aFxPHhzGNJgLGtvNbNd/Bqibryc6hIAua0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708114178; c=relaxed/simple;
	bh=8fd2cPZ+uttj1DEcKpgua+yxCFcB83tYO55mwdA7zCE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BOR4+ANrz+ojWmYuktCECiU1YDb/+ftMKSjPEhmVzbIuP51fP2euzjTPHQE51zFTLuXYbn0gAfQLWyg9eNs7VhehIm9J3HJAdv8xPkHoJcBWCrjrOSsiDDjvGJMwqfNRvv66fb6+jnWSiVLRTOzmT6aImW5kGtdQdLn5OltjeVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Zkxkimc8; arc=fail smtp.client-ip=40.92.53.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqtryGdGvHmlJsKakQpBTKLMgMW0ReYNvaY8pVQcfkggWZUZeuybVTi/i5qHPFhCHdPm45Nq7ZdYAl1jDB58PU3M4sCKz12678R7JuOTBK7iRxLJrqRsxlxl2UxMfJrxdUIkkMrwcqYGxUrwscQVrwvqWbrESxcHAE02IqQ67095CKJJ5b5lyMC/+c7wNAt7xh5kqxL1Jlm9ElOalDBZJNkmN12fUSXVkS+88tbhf05OoSTNrvZvg6GpOLx1v7iiQJyU3Ej7m1/uFWBBD79jT3LlsIzCuT/zR+Ik1WikJRT6gSTyAFBDMDTjDK/R5VlulmhkzLBLv6W+NxosEosVmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xraofa5qdPYe6hn7aZn5JyWvggF2UnPsEIlszAEEvG4=;
 b=D505gInFHOKge7/JitbYZ0TgoOr7DHfsYA2cG1Wls6ghbVLEYg71QKxFHWasPUbQxIpnlrnn08v+htiLP0JjOuWjwz9uLxfSAA6Lda5E4VS8uUnh56IJwTweEPuqHGCuVXVaaWTOKA3DBeyJwZiZerjwXGsBXLKw4m6/NQ55uGYiYSu4smwpi79QH2OKBm3g583KBHq1FOmAnRoO2e/8gLq/Evdg4IVnzfNh4Alo9kbNveqKvrCgt++T/N30933l88BGzJ+kx3iN88bwo9VH0oJxtbCHTwLVoYhghgP80MNeQLnUymfttqtKrRIUfIT1pH25awmrYJezjI3HlxpxzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xraofa5qdPYe6hn7aZn5JyWvggF2UnPsEIlszAEEvG4=;
 b=Zkxkimc8gFfLN0cBCeceRPOMgjx51azLBBoaCAWEdanKGkgch8qt5/h+5ahvoJXKiezoD5AXsJvSc+rjDJrPmLUOt2Z3oxATvhce8t/jBW2P8hyPRntaWDmA2MXPLo7wIDQdX5hjSE6Qxdj0EFRSvoTEGE2q7JpLcb1Gj3EyBdjGRD4i8biPWxotY+V2FWXAF2LYMEtLPyhDNpSZuY8hhXEFGVopyljLSaeG9nYctBC+pQ6nJ2VkquBb7gMY8tfBGl1SGN+blAilqe6tVE0yJXoeQzBdTqZqFkxINLGc7yasH8Q8kzdxNNMOc+wSAqF1e3X4FgcD1U2T71XZB53o7Q==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TY0PR06MB5658.apcprd06.prod.outlook.com (2603:1096:400:276::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 20:09:28 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1%4]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 20:09:27 +0000
Message-ID:
 <SEZPR06MB6959A0CCF11F3E4FC956028A964C2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Sat, 17 Feb 2024 04:09:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] net: hisi_femac: remove unused compatible strings
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta
 <salil.mehta@huawei.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Yang Xiwen <forbidden405@foxmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240216-net-v1-0-e0ad972cda99@outlook.com>
 <20240216-net-v1-2-e0ad972cda99@outlook.com>
 <68c9477a-3940-4024-8c86-aa6106e8a210@linaro.org>
 <SEZPR06MB695938B228E762B9B53BAF2F964C2@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <d77faffc-5bde-41f1-b6a2-ddd665c3ee08@linaro.org>
 <SEZPR06MB6959592677F8F2C79BC2FBB7964C2@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <428581c5-48e5-4b89-8925-9847bd69dc70@lunn.ch>
 <20240216-pedometer-unselect-91abab6c5df0@spud>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <20240216-pedometer-unselect-91abab6c5df0@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:
 [WtkOJIGNnA6uuwPl5W2XfCCkXZj3WU+0+dXuEopJCq8+QYReuMyJM7daaxD3zvp+FGNzNnG6JN0=]
X-ClientProxiedBy: TYAPR01CA0214.jpnprd01.prod.outlook.com
 (2603:1096:404:29::34) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <f9dd084a-6559-4453-bc74-5993c2f011d7@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TY0PR06MB5658:EE_
X-MS-Office365-Filtering-Correlation-Id: 439020f5-e60d-4c93-27f8-08dc2f2b2d30
X-MS-Exchange-SLBlob-MailProps:
	dx7TrgQSB6c1cOtx239ZsHXxlFKPF+zuna/7fYIkKFSNkXQhzryTwyECZfJJxDhx1cCRIvtAKg7Uh+EzLWKBgVY682J5Ku3R/+9ml7dch0K6x37dNLOkeoTBFicMOlHeHjAtcPCZcPVfuCjMAV77GQytzPc+M9XKL69Ur64qyAFM0sxOnrZdNwiqtVNdFM5XBCgUu855o5EcPqiWpywZI84iQKIZC0OKXQ1govcJ5IiAK0F8NGmRoEVPMN1M1/CDwud5mtb4/Dsak0dE/N7KVf9gRLgPt9I7fiJMnKGu6iN7R5EX6u1jgTDQsm1hbGyu+lgG6RX0flj5/wFBj2fTUZVwfBAe2L/iV14LsT5yp9SNUZY0bxEy8PgyoLzLQYPW6IPAwTnzJFPxVBaufhDySF7WWPrhR6WGzSnvxuT9CIh7+I6WRe7FgMN8Jc2FgcY9bEh8nDfZESdiowOw/wtr/CU72dVJzrakeNN5cb0SweOjodnFy+GUmXz9ddCZa+5q47/SQeahXBaJfw1iPsLp3JsR9WsU0iTznRx4rcpUVCCgZ5g6ejdskfwcDYlpE4MKQ+bn0qOLsQwyiwHwFsQuFh5csUj3/oraLfiMWJO+zAlvh59NseV0CJZziobDvjZz996LBjwW2cli7FA0mt+vWWf+9Bv9tt633k62S8ZwqIGlIXgb+JH87o3JmNl0uiYM5e0WSdcbd+SVF42ZBL8mN/LZAHzSV3sFq7lLO5sHFjbYZ6DfBHKyinYoUG3YzkegbeOuRowU/78=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1qLa/EVJZyTVBH91nSQmb7ZjC6YcF6ee6wYWgVPs4Yb8XkFatu6jamD8KE0eUg42hL8xX/QebxAg17tYUv4GL5OlSORFL2hGoTapp0vx2eDyNCwVXCBBtCpUsqOhyu7LKc91csawxXjqpu/pzP9KQQnRPsAu3J5X6LHRcQdW5J5JfPgs4hZeJeJRflFM39SacowETttNN8aLOOv0GaCxm3jVzYD8jJnbfVYLBqHj02kfoSOkTAGRt1NLOsYZuwMVncko03e5Dh5PGsOnYY1MB2V1ciYOheRq5c2zpaeb0XvGGg7YYLLHGajjI3LOqvfUTkP0RoLCeU1mm+yIgf+1kvZBPUerT6PYf+Nn77R+2/7DBjLRjxzNED3lEjnNvwjyG72b0HwZknvc36YELCIgoqFxtpfOxTugX+Eh9VM9jHAL142h9EJcpaToj41w/yjx2IlY2+QuBYjr5sdg+jFyeu2EsugfVahq4tHjTFe/IFmKfxOiT+Xb0u4RTNMiaFx2paUnqylDQhYfmDhHIu15zLmCapKzpBs25B4GpLFCKfLCm8jmCn78JFXp8shPt61a
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHZvWjBPVVoyTUxvNkZxdDZVRVl0VFI1YU9aQWMyRjV5Y1BWNW9uUDVjdk9t?=
 =?utf-8?B?MmhIbVVyTVF0UjZNRkVqK1RpVG1YQUJKdHBxcldwck1jZnA3MTJRS0k5N0Z6?=
 =?utf-8?B?QTFISm8vS0xKNzQvaDh5bDRGRngxZ3QraDNwMytUeTl4ay9kY2R0ZTdLWGFY?=
 =?utf-8?B?UHJXdENxMUd1RTRoNGF2UWdkQVM2SG9aZ1BpUUdXZXJxV3MxcDM3TzBxVWdN?=
 =?utf-8?B?dGtWN1dvWlRBT0trbk4wZC9BUnI0MHdMUlhZUzRXQmwzK3BRQmwxdDRNdk4x?=
 =?utf-8?B?cGEwVkMyOFdEOTcrMEtlQmQ4RDk3aWRMS3lpTEdEVUlRZWUvd3FxS0VhalJh?=
 =?utf-8?B?aTFpYS9QS0xlems2Qy84UCs5bjVPZUVJQm8vblBySTJmMmpzWFdjdjFNMmV2?=
 =?utf-8?B?Q3JleFNpOFJNZ3ppVksxS01tNkxvWml5L3pVMHNSaW5NVHZjRDZhcnFRMCtK?=
 =?utf-8?B?aEgwM1JQWlV0dmNBaGZJL1VoWnBVY1NFMTJqYmZMQ2loQnp2S000NXVMdWNV?=
 =?utf-8?B?U21XTVE1NTh2SmRSN09wSlBRc1JDVUc0ZnJWelBsc2tHYWVCeFRSWnZLMkta?=
 =?utf-8?B?MXh4eTVyQlpkL0tBT3hBVEV4V0FVRHVHcVVHS25TNzJSY3ljRDcxekRzcjMz?=
 =?utf-8?B?UlNPc1lldVpxUTdYeFRWeVB4d3FhanUzQUVaUVo5ZnV1dlV4UkVxaFdmcmZD?=
 =?utf-8?B?clZIWmpnKzNLOXg1UGxJV2kyTk5tdU04dXRwV0NEMTM0cytMMFNUdGhFUEV0?=
 =?utf-8?B?Nmc3ekRxRmxxaHlPVFg4YnBCZG55OGtVa1VpbFpyK1BIY2ZpNlo4WmZNNHNr?=
 =?utf-8?B?MGJwMHl0UE1qVit1VHJGck5KY3J6eWpPb2VwQVQrMUlvWGlKRTBWWXk3Mkdw?=
 =?utf-8?B?NHBUc2FVQXczSlZPSVNQeEVtZzJxblViS0NuNEdQUGFsS0tEM0w1Ui8rK1NH?=
 =?utf-8?B?cUE2eTQvVjFldW9tc2djQjdtcEExYnlETVdycDUycnZWY2NqUWIyYW82UHY5?=
 =?utf-8?B?RmlOSG1nWTdDYzhkdDhFWHJJZERpd3hPT1phK3pJZlBxR0NEeGNpdXY5cSs2?=
 =?utf-8?B?TS9uOXFrWVRISkp1Q09YV0MwdXRqeURPR3VvbUI2Tzk1Wm9LSUNXRGk3Q0hh?=
 =?utf-8?B?VmF4OHFDdE5hSlk4ZnN4cERhbnBSUUcvaGxtTUxRZlhmL2ZtTzVLRzllTFUr?=
 =?utf-8?B?VVRPUFlHMnBqUWxCUnVOaEFLeDRYZkkrNEZ1OTlpUXNhTk5tYk5Bckc4RjJL?=
 =?utf-8?B?Mk9KWVpESjRBVGJ3OFQyQmlMQnRtc1JJZFBDSE00S2g3V3A4ZTdrSUlrUzU3?=
 =?utf-8?B?VUYxNkRzTGVOWEFKK0lrVDF6RHFrT1MyTVlWazB0b0FPdWY4TFN3RUJuYk9D?=
 =?utf-8?B?dThYOFNZZkhzcHhscU5sVXN4MW9raHFTNWZOKzBnSXNqTVB2REZsWERsUjZS?=
 =?utf-8?B?OVRNV2hrazRVdTBUYWpHdElHbFVpM1h2b0xVd0xvT2ozQlo5VVYwY3JwWXpD?=
 =?utf-8?B?cGtRRHlnQzhoV1JMZnFqMWhGTld2U3JoeHhKTWNwV1pjUVgxV2tkcEUyTHZD?=
 =?utf-8?B?VjR4aDVNYUhYM050UURDRk52YmlhNFFrVEpQUU9kdnBZeUhHOVlUZE9kVmg1?=
 =?utf-8?B?YXpaNTZMYlE5QjNTWVJrMEFLZWdubis5TllJWXJhMEpmQ0FqSE5XdmJWbTQr?=
 =?utf-8?B?M0d3SWVicmxFbjJydi8yUGNva1lsZU4xZDRBelFOOE5DbVduaWVUalhjajZJ?=
 =?utf-8?Q?S5gSkGjXK/G9X1CqFEfsD4uXcACU85Z08+/Y2mT?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 439020f5-e60d-4c93-27f8-08dc2f2b2d30
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 20:09:26.9470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5658

On 2/17/2024 4:05 AM, Conor Dooley wrote:
> On Fri, Feb 16, 2024 at 02:01:08PM +0100, Andrew Lunn wrote:
>>> For me, it's a bit lucky to find a (partially) working driver in mainline.
>>> It'll take me even more time if no mainline driver is available. In fact, i
>>> wrote the driver for mainline u-boot from scratch and it has been merged. So
>>> it's good to have this binding accepted unmodified, or i'll have to modify
>>> u-boot side driver code to keep them sync.
>> Sorry, but that is not how it works. If during review we decided it
>> needs to be modified, you will need to modify it.
>>
>> I would suggest you first mainstream bindings to the kernel, because
>> it has active DT maintainers how really care about bindings. Then get
>> is merged to u-boot.
> Just to note, the U-Boot folk are currently working on a model where
> they will be importing the kernel's dts files directly into their tree
> along with the bindings. I think they're adding dtbs_check too.
> Although that will be opt-in per board, it does point to an increased
> desire for compliance there too, which is great.

Of course. I'll sync this stuff back to u-boot once this gets accepted 
and merged. I begin working from u-boot simply because the Driver Model 
of U-Boot is much simpler than Linux's. I wrote the driver for U-Boot 
first to figure out how the hardware is working, then port it to Linux.

-- 
Regards,
Yang Xiwen


