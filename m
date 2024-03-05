Return-Path: <linux-kernel+bounces-91831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B814871741
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01860281E21
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC1C7EEF4;
	Tue,  5 Mar 2024 07:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Lqwlte2r"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2091.outbound.protection.outlook.com [40.92.53.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B737E775;
	Tue,  5 Mar 2024 07:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709624919; cv=fail; b=oYqvgzpgKm006qRI54hcUcz3QxRv3xrF4yTBf0QsqiPc3giknx5fSe0HRldXu08945joF84cGm0u7cH5p7YWDvSmO/ecJ40hfe4Np4Lu1+Bm68371l9RQbSi3azNBk91ELgeuRYOhttDHSKW/y+XYaYnY/Cgya1Q1G/yWAPetf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709624919; c=relaxed/simple;
	bh=BQZCMwy66Q4U4jm/ByyR/1t/Lj3aqlHi33PXtTHxRIc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bUnaojceK/ZmxuqIXBIConpsV5ZwOV3GcneEOcnUPidYkiws3pUmeykz6bX5CXyNng0bAVV9VWF7yIOKU1kyu+unyzjafVkmJ7y+4aW59lANiZFWGgumU5Z4f+99rFQsmwbFW4xLlVeGFrpb5HfCYlAWRA9aX8cLdMUSjEk5WPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Lqwlte2r; arc=fail smtp.client-ip=40.92.53.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvyoLgxpwYabO+TgNLIXxwqSMkXGdX6vATiBGNBQPNeMe1SbOpCSktBJ8+DeK7fH1jA/8H5cpR2ae6dsrfqWYT55O7st0dJXuGxlyqDJ2odPDginF2zCLp/0f/5hQqot/uDiVzllrWfVHqLoO4gD4lHunMkUvfDpSRosUbBmXPO4wQzfjU747fqBhHCNALXKhqYLVUNhdyyd1aipGyOh+yux+ccxw6bEHP/UdNwONLPc5DNTWCnTKtoEmxLVGaAJWGFkStOB5z0WOzjKsipgnijBvP9Xi1iNnU+s5P5MUwNViTJUVYIEDW/16suU5fx1QM2xEhBdEFAxPU1H4EQnJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuY2BVgoiypQrTj0tOnQc2fLKrq3MflVfpbq4aytfNU=;
 b=G37vHU9TNWdm0V9IDSfIIuoFka02COd+Deg626Pdf3ZxXpMvIrNnmkKooApaOAFzZ/AYa+eLsqgoBLJkBTfczH8zufVoUgKMb3AG2BYlN/hP5ChqoA6mmaT0BY8m5Jsi8HLCMkMjn+i9MQS33GQcaiwYAYQc2NNORQj/nXfVHiDsN4Je4gyoS4JUfrQHWeTRLBpr1JQO0kGFGLjXcICRJq0SDW5AsYIXHvqkADiHmpUIYlkhziq+C/rq/4A+K78Mw2Yvhzd1YKRFwu7zSOFcTI7UEijKKOI4e5rR1S8HMj0s1ZMFlp6HKV6k9pEvVNzN99mypXjvAsOw6e5gWOhS9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuY2BVgoiypQrTj0tOnQc2fLKrq3MflVfpbq4aytfNU=;
 b=Lqwlte2rh0YqZDpfnsmsZZ7sN7sdjn4gLVlO3Jw4Mo/JgEH40xYC7VwSC6wjdyfj8TAOpopse0FOm6wDdl5sfSugXZpl4vBeFyHaPHhZ3m70WlXmZUEB+kU29AL68eUcZ5QqMQvCrW4luq+CYGo37Fo2NH4mN7QKbHuEbdRclhcan8JPVeNJlgeAFyG9y0ZO2g3tl/F/yAsQPUfk7g/1vCgI9FQ6GM71/C3EQpEXVJVTtdB3RaB83GXlJlBuI1GE/WmeHHS6HI+Qd0qvQ7clDQ0rtGgzG3uTojU/x7ROGjnbXklTr5ZwuPMP/XssMadiLAmqrPyud+ZC9zY3+FtsqQ==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by SEZPR06MB6206.apcprd06.prod.outlook.com (2603:1096:101:e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 07:48:30 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8%2]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 07:48:30 +0000
Message-ID:
 <SEZPR06MB6959FF8B9FBD5EA7502B468896222@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Tue, 5 Mar 2024 15:48:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 10/11] net: hisi_femac: remove unused
 compatible strings
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
References: <20240228-net-v6-0-6d78d3d598c1@outlook.com>
 <20240228-net-v6-10-6d78d3d598c1@outlook.com>
 <11d0bf3a-3341-4c7f-9a1a-e7c7bc078725@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <11d0bf3a-3341-4c7f-9a1a-e7c7bc078725@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [PR91U1obEj3OFTfGRpOa1zDoWCH9J3ZXXUb4xOsTi0xA/X/RWPPiQ8RXcyht44OM]
X-ClientProxiedBy: PS2PR01CA0042.apcprd01.prod.exchangelabs.com
 (2603:1096:300:58::30) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <eaab97d9-c105-4551-97a0-ad6fafcad53b@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|SEZPR06MB6206:EE_
X-MS-Office365-Filtering-Correlation-Id: 47fdb7a1-7af8-44be-16a1-08dc3ce8a640
X-MS-Exchange-SLBlob-MailProps:
	dx7TrgQSB6ctpbu0D5OXN8ruBkhA8DzsNKLHInsk+f3IfIwEYj65f0IuDP0Y/WaME0slUJEEu9AQCCPchUCQm09FVGrxXh1cog/ZuKO5m37nMOd2MrPuU9Bzk6nfqk5fM5b0frEbkGLbVy/Xr0KDNzOUeNo2qxXPHQzdR1rfgbCzrR38qh62pet3sN3TD8ZoNx3s74WDwKpisroentR+fhr+o8Yd+jTIcRm4KCtVF4joaeO98yrzGBwlM7sZByQKB5AI3wXVhaYJ++TBfpqKIgnqg64Z1wPnilIJCh/x3Ho3/TTa9zpq77epOdjTkDLI32tt+te5/dFjpq8Rj2iXuEnAY3jqG3SKsSW7Iw/5tVdPMtpoKmHmtISq3pYdHyQKC+V+U5HDsO+PY3mGEoE8eBHKcoEn12ADgrGWRUW9I9YqAKh+JsxG3Oo2PGRDBEZMrfuYqnm+4ZrAVSYCURTljrMoE9yzeDbzjFcxVYradxx8lgru3MF9ugaQyNCP1bvtEn/Wb3WFxLtW345cOpGygBA+caNqpqd/QyIKS9rvt/8zHOCwMe1sDGIzRVgTjx+HFfrHS8pXWgKYmrrDvENt+hTEEre8DA/COOWJi9VgX8FtBBECAaL8VNvEqi3FvHYIKStilSK9d1MWHsfADUi3YUEtBYWgRwLZLIhcrjV1d7b4l9mOAM2ypordhU+6TpOdDCFSrpRnr2vkmVFNUdy4K3v88AaWaszYJi6v6sXfPAy6CrJZio+a1zgC4tWn7zs2umpCCAZU14k=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dGOdFIH1a/aboYIKfNf3YzmZ6YtUO5LNmwYYPnUMZCQg6FcmWxMyJPmfrN552wGlfbYyAhmraMQeNcd3QUjqV+3ikqB6APk4cChwWCPWjAh3p90epN24sS5dLGYJJQEbiDF2dJDK9c5lhzj6ktoTepKT/ODkIFjtbhFjWvR2nZdAeM/2UOBFXyTUo/CMm4ARKs4Wu3wrLEXKyMUxcI822i4n0Ptn8gY+j9wVQbQD2KTUusCSv84OE25k1vzYEDW+83x3fvpqrjk4lP4KhKSHXHHQe1X5KP8wp6c1orDy6Q7b5C+Rfz91blyezi58KGf0lnsi/OgJZP5noG75Fe+sslbbURhVLuwVp4xlcPFTXtKObPIl3qjOGxYZ6xmXtNChOI3kPCTbTZrWGoU28s2yL4PitQ/691pR4UdY9WUAfq8GY4RTIAUHIhgGU0qt1T1f90kdNCmQErsGgAQOBT7v0oC/IC5x5gdmDeNIgZzrfla45epT9LiWGaczDrKptU+mh9LLWhxwHAr7PC1O8mkj7ntFjC2KmG7bNwocxNE3fi7m7JQNsduvn51fDryCuJnK
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkRjYVZRczZuWVBUT2lFeWJNcHZIWDZYcTFXK1NsekNlMFdsWUU1OHlpMVRE?=
 =?utf-8?B?cGpYaHlqc2tBNEZvZ3dVS012b0szQ3BQNG5pTVcwMEJXd1crRVJKMHNubnVT?=
 =?utf-8?B?SmZoVEV0SVVvTng4eG96OERxTHBGWUZYUmZGTzNUWlVsODBNVTNZOHhjVTB5?=
 =?utf-8?B?a2NER0NnbzF0UDJ6dWZSbVVRR1UwRVFGV3NyeHRtbFNlMmxYNzNDQVpVVlFG?=
 =?utf-8?B?eGVYTGVUSGJERVhUNXJpUlIyOUZZaktEVnF2M0RTRWllVGxsdStrcFNEc1dB?=
 =?utf-8?B?ZGVXNGFLMW1vWjVQZDVjYW11MVdTREp5UjR1R25GdDYyV0RHbGZ0ZVJuOWFO?=
 =?utf-8?B?dGJSTmpFeE1OTEtueXdkbm9CQXZ3eWp1TEdrQlBoTjVMd2RnMkVKNC9aaFg5?=
 =?utf-8?B?VTlxTVRUa21YZnpKOFkvR05HMCtBaE1Fa3c3Zm50M29vKzQ5MjFmc0VoeGJv?=
 =?utf-8?B?U0k5eXlFNWQwb2ZXSDczTkpNV3NMM096dUVrbk5UWE1zSkJjWTRDcllRL2xa?=
 =?utf-8?B?RHoveHN2NSszR3JtVkRBWTg2VHZjeTZIVnhRWUNwWjllQUtGOE9RMjNvVE9Y?=
 =?utf-8?B?VU56aytVWFJSa3lYeWErdWtFQzdkYzFkdHhpNHNwNklQanl2ZytBZmR5NWlE?=
 =?utf-8?B?NjZSeGJKSVVlSEtaaXdkZjVMNk9jS0tWdEFxNHExRWlEWmFXV1VKSzlocWd2?=
 =?utf-8?B?TjFZdUpvYWlMNWZESUFpOGtxNGxQVEtLc3RLRnF1a0lmaE02RnZEd2x5dWxZ?=
 =?utf-8?B?NUM3TTJvUXIvSk80eHlkWmZQeVB6a05vZUpQT3JXR1U4cTZic01IcXpKcXZq?=
 =?utf-8?B?TWpZcGFtc01uU1JPMmZ4SWhJcVJxYWVyd2pjWldtd3ZzclI4NHEvRVhaM25U?=
 =?utf-8?B?NEtxTVFFQ0FDd3ZyVTR5NGovc01NYWtXMngvUWptSkJwTUg5VGk5SnVlaXNQ?=
 =?utf-8?B?ZkFtKytCQ2ZoN2lMTk9qWmxlSnVhQ0wrREYrTG1rNXo2TnZDdHJnODU4eU9Z?=
 =?utf-8?B?Q1B0eE5MdmpwVnNCV204Sm9JalZaT29VWFhRa3V2bFJuWEIrSzU5bXQwSXY3?=
 =?utf-8?B?L0c2OE9zRlIxRGpuRURaUHhSTFpEckN3ckNlVjdLV2t1TnQvK2hKOGw0cGxZ?=
 =?utf-8?B?Y1BYM0N6bHhCcDNkWk5obzZlNThxSExTN0lWVjhrVDZ6Slk1b3dTK1Y0c0ZS?=
 =?utf-8?B?anV5SHMwOTYyMDRPeGdTdkYyS3FNc0RjNXJkZU9Jejc0elFTVVNFeThBYnBO?=
 =?utf-8?B?dVVzbld6WHpRdGJjeWp6QTlybHVlY0hiRHlweUxLOGlUQnNJN0FGZElDdFhN?=
 =?utf-8?B?c291RVE0OGNBVTZvV0VaYkw4N09YZm1ybjAwb2VCUEs2ZW1MVitkKzRBWHRy?=
 =?utf-8?B?TmNRWGY3cUp3OFphaTlHMHlvLzNQbEQ2L1pzTHB4R3RrRW9xeEc4S0dQeHRp?=
 =?utf-8?B?MlN1K3E4aWxjLzZ3VEZLOS9mQmNONXdBVTZWN0E2aFN1SXRSZHh4alJjL1Zp?=
 =?utf-8?B?cVpFZDFUbnRlc3h6ZWVKSm5KQ09qMDZ4TGxNZmtjQ0pPTC9KT3ZwMUVUeUFa?=
 =?utf-8?B?Z2tlaEJML0V2ZzR5cUR6RzdaVEhtQnhmWHFZaENLWXhmQTljMTBUNnkyeTA2?=
 =?utf-8?B?ZS8vT1pveVBMSDl5djZIT3FnM0ZSQXlMVjF4alhSQmN3SFllaTNTWEowdWVG?=
 =?utf-8?B?b1prVXhoUnVKL3JkNG5tdzFVTGN6WHp2b1hwMDhzZWF2ak9QUWl1UjlySzBS?=
 =?utf-8?Q?qFrrxouVnrG+s6z82z8OWusd82RgC9A2PYdvfJY?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47fdb7a1-7af8-44be-16a1-08dc3ce8a640
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 07:48:30.1070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6206

On 2/29/2024 4:07 PM, Krzysztof Kozlowski wrote:
> On 28/02/2024 10:02, Yang Xiwen via B4 Relay wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> It's hard to get the version number for each FEMAC core and it's unknown
>> how the version can be used. Remove them until it's really needed.
>>
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>> ---
>>   drivers/net/ethernet/hisilicon/hisi_femac.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/hisilicon/hisi_femac.c b/drivers/net/ethernet/hisilicon/hisi_femac.c
>> index 2406263c9dd3..3c5c095dad05 100644
>> --- a/drivers/net/ethernet/hisilicon/hisi_femac.c
>> +++ b/drivers/net/ethernet/hisilicon/hisi_femac.c
>> @@ -945,8 +945,7 @@ static int hisi_femac_drv_resume(struct platform_device *pdev)
>>   #endif
>>   
>>   static const struct of_device_id hisi_femac_match[] = {
>> -	{.compatible = "hisilicon,hisi-femac-v1",},
>> -	{.compatible = "hisilicon,hisi-femac-v2",},
>> +	{.compatible = "hisilicon,hisi-femac",},
> Drop and just use SoC compatibles.


Will be fixed in v8.


>
>>   	{.compatible = "hisilicon,hi3516cv300-femac",},
>
>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


