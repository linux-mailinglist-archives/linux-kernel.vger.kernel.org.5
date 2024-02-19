Return-Path: <linux-kernel+bounces-71850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 037F685ABB4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B04902850A2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E444878A;
	Mon, 19 Feb 2024 19:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="uCf0Rvna"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2039.outbound.protection.outlook.com [40.92.107.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3EA4A3B;
	Mon, 19 Feb 2024 19:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708369273; cv=fail; b=DYr5P1TcJvbtfUdIxD9LGINRap54X/T50UQsJ6wR8c7w64yyd3p6TDktF+vjKxdCodsWRdecCGUdZJ5S4U9IiGqw+W0d2L4mS951UyvspmFIFPBG3qR6gvR6J0VokI3EX+hVrbmn1LEgjIuKzYkhoQMpWQT8BlaZjSiDubIUtRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708369273; c=relaxed/simple;
	bh=m+jD4VJrgh/I6NvT/cQchiPSU28PxG7awbxj4X9lul4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p/Lyj/73Nf0j1VwnvwlLlYogsz/WI9uX7DuBrhnYE6rmEkViJq0ZoHKCOGwJGftJXnlZgGvfDtAf0OAMQNdla7AWiwtA9TINkkGze96nHL60OyilR5S6MfgLSv/fK1Td+wX5AjAzT5fjjAzxPCymDHZNbxo9GLyZT5vqUWExO1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=uCf0Rvna; arc=fail smtp.client-ip=40.92.107.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+DiJeBpS786B+6IX+1Y59rB0fJ1JI2968LetxffDPvZOcsep4hStq8mCmsdKwSPc5OE6U9Pml5SHHyyhmaDj1INlzo5Ya9ovurfklhKnmUxi8v4EZGpFxmz/RsTyVb/Cfb4WMzrIXe7bJT6DylIXotHuwSL5SX8XBaZ6c+wPTSMn/MiCw84vJk3j9PPNAoQ+L3ov2vu1Bnny2qsjP32K+r0UyedKkUjGAArUwTEKeLSgYhXIT6iJed+/obZH9ueSofJroa0Dgesq0Ov5idry2ERODPl4o03uQcW5LQfLFkajyRi2WdkNppdgf1ev3u+wdSKWZ3Ay0GQe8JmTb4qsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=No44qGWYmmB7ubfRHNTkkzYMc8a5Es3lBkS7Ywd1ISU=;
 b=L/yFYIwbZOjdl1JkC0AO9ccCR3XLeLELtLRa8CQoxXEhy7usA2flvltfEOfJMjZmnHryLJj4tbmDyBbntNEL6YeBZYx+IyKb+OULg8k5gQYSc0CJf1sWSxNYe5vjnBcnyqWZ4ZXivn6LV0yY7pLzCbfOnOBlquvJU0Hz7Oz73/ukQm3qmgm9FvcuL6YlywaScoXdWKYGkqg2/TUJEyFz0useBEBCQ6Iv+Tv0eTTtsxkwq/8Xa/4ID1RBx73ZwckKtAbz+7Lb9d75pLgY1fgteIrr+3CDi/cyd6CNhP3HOTkjc+/NqUkDvk+n5njDB9d2e5nvYohHXoXKG6VRa4CamQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=No44qGWYmmB7ubfRHNTkkzYMc8a5Es3lBkS7Ywd1ISU=;
 b=uCf0RvnazwpF+Qgf3Q+KRXEzDMG6vwF/pT1JNwVEHd3wdS6FtbtmqZPMzsw628k1cDAPwJp3NY2BD3WJYPz9DiE+kLsVmTYUNqSv4EIy7IPZD+wDTCMaDuGBirF4QlTLiLRJzxbwt2LnPNh2vH4fp8PPA4neotXP4fkngsRseP8u7TLeiVGRJij4c3L+lOoH/TlrQ87RqxwIo5w4BJ2VBfH5BMk1asZCq6fIlILhTz62Vd3Zx8tE/3y0RHQEC8ruLJd6Gk8C2upOI/eLz2D2LC7kBGx+iSdpSaPr/1WfTjwimyVLaFjSEUCr4e/fRCPRsdOmSybqaMb+AiFrl8No4A==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by SI2PR06MB5017.apcprd06.prod.outlook.com (2603:1096:4:1a1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Mon, 19 Feb
 2024 19:01:06 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 19:01:05 +0000
Message-ID:
 <SEZPR06MB6959D4BEC90745D94BF02BF596512@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Tue, 20 Feb 2024 03:00:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] watchdog: sp805_wdt: deassert the reset if
 available
Content-Language: en-US
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
 krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
 linux-watchdog@vger.kernel.org, linux@roeck-us.net, p.zabel@pengutronix.de,
 robh+dt@kernel.org, vireshk@kernel.org, wim@linux-watchdog.org
References: <20240220-hisi-wdt-v2-0-63edc4965b4c@outlook.com>
 <20240220-hisi-wdt-v2-1-63edc4965b4c@outlook.com>
 <534b62dc-3874-407f-a5c9-f67d366107dc@wanadoo.fr>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <534b62dc-3874-407f-a5c9-f67d366107dc@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:
 [xT1gUfdEglZt2ZQOFd6TkfIQ0E7cRjH3zSrZBrcYGmiFXu9VKgkY7HmLukmxRESraPGTrC4hxr0=]
X-ClientProxiedBy: TYXPR01CA0043.jpnprd01.prod.outlook.com
 (2603:1096:403:a::13) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <bcdd48f8-39d8-4606-b223-0938f139e5e7@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|SI2PR06MB5017:EE_
X-MS-Office365-Filtering-Correlation-Id: 07401a23-5638-4970-48b0-08dc317d1edb
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BFv5O4dqvWtqgT/TLFOIsvoxdjhITefjVAW9SzBfCdHSpPAOwAXV44+rjL1vk1fq93QfHhCnPQyDqo+OE3B1FGgQ3Nmhl1pCJvKDgN/tG1oYhKdiVrNxeoLuBszaGkK4U3D5CUqOHLwSfosAqJQFV4NgGn4UJ1dwixNxPDweuSa5Z5J49jEyzR/Wwb+Rnpk8etJrEVNYD6NKkt8H34ly1hBSKWF0k8xqXSEthJtQazhNUACuVWZgWBM+ztZpWF5O6OCrYo7bEggRFQwafw8eRQpElapUWRsYuxPPV7mRfZUZOOfX8Gd3meVtUjsLhAb+V7o2f+s2Tcw5nlvc7ANQT2YqsAEfDljVtNlgjoqweicAA8qMmNXtZEvCikbGCwo77JPqIHqudHuLHPRlnC+DKvLMvclLPRYCo/m/qiWWDMoPd/wPBcF2VmDf0D6hdGwuEhiK25RZ1ZEa3wM/iSM9Aa7PDt6sgqvX8/K0LoqDb35V34WTzDM5GIHzupaFEyJehypAhxBtfHesJT0kxzrqhCzsVjExPq7Bo7UfQIjcUdGUXm4bnHjHEan3ElYbNsJ4
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHNTcW1ZaXowYm9KV2ZxZW5DOG1ud0hoQXFybmcxZWVOWWxVY3ZWdjI2b2gr?=
 =?utf-8?B?N1Y3QkFzOXdwdkhJQnhocEMyT1VMNEFyMFd5cnRBNnV2SjZXWmY4OVl2ZUJ1?=
 =?utf-8?B?SzlIc1FmSTlwY0ZQRlBRUkhUT2VkcjJYYk1URHp2Mlg2OTBxY2QyYk53Z2lr?=
 =?utf-8?B?VytFbnZsOERmK2czWmg4dVJwWjgxeWt4ZXk1Um8wSHpKenRSY1lnbWFjRDZx?=
 =?utf-8?B?QXdlQnNZdktUTytzcDNIaUlrVVhqQmFvZ0ppbVZrbjFoVVRDdk5OM1B4Y2Zx?=
 =?utf-8?B?S1lCQk1mM29BdFhxZDNpSWd4cDV1WlFzemdiK3JscEdiNTl6Rm80ZG5hOUhH?=
 =?utf-8?B?L0U4bGZMOEhGOUJaUzZMZk9sV09qWFpaY21haVV5WjZkR053UW5uRmdQK0ly?=
 =?utf-8?B?Z0xnV3crUjJwZWhXcjhLMXBrazJCTDgxcWx1YkNOdWVIcmVsRWYxdTlpaTVa?=
 =?utf-8?B?bmlLUzhyTU9UOS9Dc054S0pKZGNmTjEvc1N5YWtzdWtDK1BlZ2pJTUhjTzEr?=
 =?utf-8?B?eDdlOEp4WVM1TkE5ZWpjSnJQYWRxUlFmYU5wWjVMdmNNTXB4bFlJY0NJUEJJ?=
 =?utf-8?B?NjZ2Z3cxd0J3RTU1U1hjUXRQS2VUWWxqL3EydkxEVCsyZk45Q0dpTXF2QnBo?=
 =?utf-8?B?QTMvdk1xeXFRU3JWQWt1YXYrcGUzL1hYZE9sK0NDQXo5QUltUTFaUDhIQUpU?=
 =?utf-8?B?K3o5VmhtOGxYMXNUTDY3dHd1Y2U1eE5iWkJoOXBzdGhnRjRpSDZBRjRzUGho?=
 =?utf-8?B?eDFVRTQ5QUp5c3dMK2lmSXBURmhqUmR4bUk3ZzRoNmtqVG44bk9oZU1ndmxh?=
 =?utf-8?B?NVRGcy9kUlZlWmZ5c0pMbzNxWEtRNkhad1VjckNOb1FaMjNIekRIUFR1dkFZ?=
 =?utf-8?B?cDF4L1ZvZWc4K2xJRGJ0ZXMyNlE2blJtbHZxYlJ3U0JtRGxOOHhzRVpyWm9H?=
 =?utf-8?B?Wmw1dC9pdEhFWHBuV0w3aFU0YjlNSWlaWVRzak9aTk14U0E4SDVoNmFBRUpP?=
 =?utf-8?B?NHNDRHVlUDl3Sm5qenNUY1hmSXJBNDRkTXlvZnRCUk9meDNVVTNJMWt5Umtw?=
 =?utf-8?B?cmVXeWlHT00wcGVKSERBSUJNTVU3YTh4NmV6WWtiSHFIWFRaTEdlbnp0dzNU?=
 =?utf-8?B?bTNLdXlBd3VjSEhVNGxjUWdVM3FxYkViYld2RzBTekJDVTBOR09Wc1NVOXVz?=
 =?utf-8?B?M2hXNlhtcmgxK3BTTzEyN3dxU1JTcmZKTlBZWVVTalRHOXFhZkRpSjRuaW1V?=
 =?utf-8?B?K1N4ZXJWTGhHOFBmMUlULzVnaE9UbW8wb2ZKS0VDZk9tTENUblg0QVZSdm9n?=
 =?utf-8?B?TWloNnJMQStDdU1SRzA1c0hGTXdPYVUvaXZEN1NaZmxwTXFkMEZNbnJvcWJD?=
 =?utf-8?B?M1NiZjNWdzU4a1VsVXpNYXVvcGVzVnBvckxFeW5zUE9zeUdqTUUyTWpoT1ZD?=
 =?utf-8?B?YVpGckFuaE5LQ1Z3YThVK21QVUN5ZkE0a3EyT2M0V1pxTUFmRTBZZDhuTjkw?=
 =?utf-8?B?KytlSUpxWUtGUThHeW1lcGRhaFFZRWx1a1ovR0ZERW5kVjlmNjVpcGxlY2V5?=
 =?utf-8?B?VE9PVGt1a1NVS1lsWmhuWnhITFpzb1B4dGR1V05SeHo4THJ3cng4SmZEMEtE?=
 =?utf-8?B?eFh1cVBzWWRxUDNyYllNL2lvK2tlOVo4bDRoTVZsZGxsVEozckR5TFN6ODBx?=
 =?utf-8?B?YTBqVS9GS21NU21wWmhRcHo3Wk4yVWNmMlFnSU8za1FMZ2I3eUFMb0VOUmY4?=
 =?utf-8?Q?NnxZoHfBQntBsevSqTIFsKbTgyOdGbwVIgYaBdC?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07401a23-5638-4970-48b0-08dc317d1edb
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 19:01:05.5089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5017

On 2/20/2024 2:22 AM, Christophe JAILLET wrote:
> Le 19/02/2024 à 19:14, Yang Xiwen via B4 Relay a écrit :
>> From: Yang Xiwen <forbidden405-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>
>>
>> According to the datasheet, the core has an WDOGRESn input signal that
>> needs to be deasserted before being operational. Implement it in the
>> driver.
>>
>> Signed-off-by: Yang Xiwen 
>> <forbidden405-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>
>> ---
>>   drivers/watchdog/sp805_wdt.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
>> index 2756ed54ca3d..b4bcfdeb39e6 100644
>> --- a/drivers/watchdog/sp805_wdt.c
>> +++ b/drivers/watchdog/sp805_wdt.c
>> @@ -25,6 +25,7 @@
>>   #include <linux/moduleparam.h>
>>   #include <linux/pm.h>
>>   #include <linux/property.h>
>> +#include <linux/reset.h>
>>   #include <linux/slab.h>
>>   #include <linux/spinlock.h>
>>   #include <linux/types.h>
>> @@ -59,6 +60,7 @@
>>    * @lock: spin lock protecting dev structure and io access
>>    * @base: base address of wdt
>>    * @clk: (optional) clock structure of wdt
>> + * @rst: (optional) reset control signal of wdt
>>    * @rate: (optional) clock rate when provided via properties
>>    * @adev: amba device structure of wdt
>>    * @status: current status of wdt
>> @@ -69,6 +71,7 @@ struct sp805_wdt {
>>       spinlock_t            lock;
>>       void __iomem            *base;
>>       struct clk            *clk;
>> +    struct reset_control        *rst;
>>       u64                rate;
>>       struct amba_device        *adev;
>>       unsigned int            load_val;
>> @@ -264,6 +267,12 @@ sp805_wdt_probe(struct amba_device *adev, const 
>> struct amba_id *id)
>>           return -ENODEV;
>>       }
>>   +    wdt->rst = devm_reset_control_get_optional(&adev->dev, NULL);
>> +    if (IS_ERR(wdt->rst))
>> +        return dev_err_probe(&adev->dev, PTR_ERR(wdt->rst), "Can not 
>> get reset\n");
>> +
>> +    reset_control_deassert(wdt->rst);
>> +
>
> Hi,
>
> Is a corresponding reset_control_assert() needed in the remove function?

I don't think it makes much sense. Many drivers in kernel does not 
reassert the resets in their driver's remove callback too.

Maybe it can save some power. But since it's already disabled in control 
register. Can't say it's too much.

>
> CJ
>
>>       wdt->adev = adev;
>>       wdt->wdd.info = &wdt_info;
>>       wdt->wdd.ops = &wdt_ops;
>>
>

-- 
Regards,
Yang Xiwen


