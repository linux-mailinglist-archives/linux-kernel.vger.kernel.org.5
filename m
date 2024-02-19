Return-Path: <linux-kernel+bounces-71808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A4D85AAF3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 845CE1C21964
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949FC482D1;
	Mon, 19 Feb 2024 18:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="WgPtKQNB"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2046.outbound.protection.outlook.com [40.92.53.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0A1446A1;
	Mon, 19 Feb 2024 18:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708367223; cv=fail; b=PrOp1daVqesSiJVtm417FJoytfG40DkroGhnohSv4Poz9tRwx1T+wDemq1be2EnbMERjTMmpPlQGGdGH61rnOR+jAsOxHru5KY9qQMujyaM9kU7SNWswNn+xiGX3kZsNBiV7ekytiawlxa+a/75NNfMjHRi8POMpJgx4g9ncSqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708367223; c=relaxed/simple;
	bh=5F6Wl3u0cnDX5OO5rYxXW9DEa2GVVNVECyH/RZqJvQo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j1XJqTqmRly/dbG1cEoknyYcIUo/CHuDmEVEWbvyZipfj3JOgOnj53tfymLfpQXPjtyafB2tWoJ3ydH/EXDeEcvMd/XJGertMfK2PGzEDY5qmE9xe+oAHM5TZ/yHONCc6vZt9U9Je8o7kaz/AeFgNKrkBaqQoZNG0BhPA8yaJMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=WgPtKQNB; arc=fail smtp.client-ip=40.92.53.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQ9aTOM/Y7UIMWovprn1EEYtLC3JTXjzP+SbMIUTQ2SxpyByQWMlc9LPeIV0eSfLW6VhKz6axcdw6GvLpFg+bqg9P9Bdd7XYzOARwn4ASmGTF0ucQbusqV6lAZ1u0/NjftWAwwWAoKvkIKE2j8+s6SiWKinywFXBpokMb8nD4FbAil3JV85PUbMH0mqVoLVsSL2GNBcTI/PTPwASlAG5gCfC7mO9JkXhc0wUP+o5+khDxKv3oQVFdPP4j4Mee/SibPG6+NfFcMzOIvhKzqLHV6me5CLYJZQVeRZdnqKEvZ6w5Y7EIy0D3ApKinRWK+rSXB8SwETPpQ3B8DMOOR0Izg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0MOxBnjdVsrelOBuP2cwdIgQKTYza60wqoZiH+zah3E=;
 b=Y+3ROG7PVUxHFtw3u1eFbnQ0SMW6aMmXxyymCdoN5xnF+GolZyJ+MsIed//2Kbzkd/V5K20GlnuBAyDsV5g+pGKc+N+kP90c3MBTHBUraEL5Y26lj5hAgZSoZOjN9oSaqt/+YvMU1lo+LmB8L4gFQijxkzm5Vo5i+Asflufg6s6RwDDTixARuhC7PsAIHx6U19ARCz8hIn145unxyUqG7heIwWtkBuNiXUD67PQ6Pn8jIMfhiczLDzCDatMQk8yj88q9Ap9LIHLCnmOcU1uzymPwoNEohyxNJbtLpw8d98Yc7p6kQqRFqiPgbML+++wsQfhcOrMk+iOFnEuQkEaK3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MOxBnjdVsrelOBuP2cwdIgQKTYza60wqoZiH+zah3E=;
 b=WgPtKQNBWVwR6MixHzjObDekkUqrjCJr2+Z0tKY31MTDTlljRzX7sfkyCJLB86FZNCHb2ppK599Qsa0BrZZjXFRN9/E80QRSTa/ha9XqsuZgIYx3UwDdq8oGy6tSbpQl9cr3373+jJL5IPX+sPaJIppKrzlwJeip1AyGg8qsHuHe0ytedYVj3FqXEH/5vdS3YgNIerIq3yDz6K24MX/Ql/Guybs0oc95han2o2FE2ItqzKpjC754r6Jk5nhKnUC4QasLn3k7vEYgBKBBc/XlZCAk2EAOjxv+nuuUfnQuJhBGwvH5AMeWSDJXhGbSoNbP+c1G124pihaFRWKlVK4taA==
Received: from KL1PR06MB6964.apcprd06.prod.outlook.com (2603:1096:820:121::11)
 by KL1PR0601MB4371.apcprd06.prod.outlook.com (2603:1096:820:74::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 18:26:54 +0000
Received: from KL1PR06MB6964.apcprd06.prod.outlook.com
 ([fe80::c971:fdb5:84cd:dd71]) by KL1PR06MB6964.apcprd06.prod.outlook.com
 ([fe80::c971:fdb5:84cd:dd71%7]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 18:26:53 +0000
Message-ID:
 <KL1PR06MB6964878A1F427305762D3B9196512@KL1PR06MB6964.apcprd06.prod.outlook.com>
Date: Tue, 20 Feb 2024 02:26:49 +0800
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
 [P7m/BO1uOI2KW94jNVxmFM2PICoCS1QreClcL1l0yCJdmQaSSoHViYWwY7rt9RSRP3yCVGfqHtM=]
X-ClientProxiedBy: TYCP286CA0034.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::11) To KL1PR06MB6964.apcprd06.prod.outlook.com
 (2603:1096:820:121::11)
X-Microsoft-Original-Message-ID:
 <fa68e9bb-e945-4489-a568-78cef3d3a2cc@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6964:EE_|KL1PR0601MB4371:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bd46e41-eda8-4afb-19e8-08dc317858e2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+5/U6K+xOf+gmDuYfF4F0e9eChuHQvyzqK0FfK+EKFSRh/O9eGyfaj8aYCtcxnJitEeHo7u8hjNRrzQguZy1iHHmOZm1XLyuB2t/b0v5n+3OVjcFpZ5qbSFCMUEGKlsY6pVmjhfjg2gwOSULr/cubB+wMeJsKzXTCBkA3QeMlSeFv59/L7ZWm13+sasdquk6LPI4ceIfn0T8pd+xR+lFUX97LTB0XAHf7YX1bgcnmtTWlceutm5ehafxoAKYW2GpGcLODerdFP7ejAuVmEUvdfJVOS0GxOqIi478t2i6+HNZovh0vQxa9ptFllETnBKRy0RizhNHJxO1RogdW+zfDydU8IAsPbzAtmVYNreINsnAkO8GuRGUieVwSNxp7Qq5wkaRn8P2EOLJgQf57sHNnNUcfgt7+vZLErp0Y65YnzfirNbWCyPHHSiO3La+8kJjM3KAmaxUDv111J9skO2SWBbiceosltZrxY6a8Nx/FHp3v3DI15ZETknwvR4dzLAvivAbXl9fxaZiGyPhp4YwQ8klm99mpeZlz6u77r9jmoHUoJqrGMnQuUL2lbaeCMOz
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MU5MeHV4c1o0SUFJSzRoQ3ZLcjkvM3VwZklQVXcvNlcvZ2F3VHEvZG81OFBt?=
 =?utf-8?B?UVFvTVEvdHNmMEJ4ZHdYc0daYk5FcjBoeXBic1hjc3hXeE92TVZtbXJlK1Ir?=
 =?utf-8?B?ZXdzM3J3REFvV0VOWk1RejFOVWJJWWl3b0U0em1jekYwL2REQTZJcDlBa2J5?=
 =?utf-8?B?cTlYeGZEbjB4NU9CZkxFTEdtYWRaL01lZUs0UldpR2xMT25ieGRNNk1UZkJ1?=
 =?utf-8?B?M2tHUnBwY2tta0xqQW5UQUcvQ3ZZVkdOSXN4YjNJa0JZeEpzY3JrUFZSbEZ0?=
 =?utf-8?B?aVovSVVtemoySEkrRXA3Mkd5K0xjTDVxTUJpRjM4Q21rREdVRDB3U0Q2N0FW?=
 =?utf-8?B?cTBXSG02RGRodUZkeUQ2VVplQWpDVUFwdDEvRnNyM0NxdFJYY1ZRR0RyYlV4?=
 =?utf-8?B?UE9HWFJvRVNrWXRVVmo4TXFENFVSZG4rOFVQbUk1ZWxRTWxmUEpkRDNURFVn?=
 =?utf-8?B?aG9iTTFuSWFuckNQT0VoZFdLNjM1RHZFMjF1cG9NUVNyTW1vbDF3Ly9IYUdm?=
 =?utf-8?B?MTY3SFk3dFV0M1hjQXJ3RWpleEYyQzZ5RmNlYnhQenAvUGVmenBwcDJZQnh4?=
 =?utf-8?B?SGwxTzRRcS95R3lBSTJIL0ppNWV3TU5PdENVRGVTaTh5RlFiMUdMR2hsTkhs?=
 =?utf-8?B?ZGdHWHEyZkptQjc5Wm8vMjRjcnpkaHpiQy9wZ3FQVjFIekFXQU04Y2pwRFZu?=
 =?utf-8?B?WjZXanNiV1VZdkZRcHk1Um5SSlJNN3FBWlkvSjc5QytvUVpPa09kTnFXNUlZ?=
 =?utf-8?B?OGo2S0VvYUtBMzVOeFg0OHJsLzhTUjJuK0hFUGkwNFpMRkkzcFB6NmVKQ0ZK?=
 =?utf-8?B?bWdSekV6Y1I0blVWUmc4QnJ3MUdkNGRkem93QWdWNG0ydmsrZmtCc2N6MEtp?=
 =?utf-8?B?cDhyaFZud0ZmSFpIdWU0QzNSSFhrQlRrTDFwMjZuOHZwcHpqSlZVVXU5MGNw?=
 =?utf-8?B?MGZ1R0dZYksrQ1VnaDZPZXhsSXh3aExDbnluZkdCNEhXU3ltNlNCeXBoRTJC?=
 =?utf-8?B?MTcweGMvRmZUVjlqSEFkdzNMY1REdE9UMENKOHhjUWhPU0o5angwNy9wcUcw?=
 =?utf-8?B?eDlvKzlVT01KOHB1UTd2QUtuS2tlb2dQYTNxaHlEM2p5c1c2dE9aSXRaOFln?=
 =?utf-8?B?aVg5WVNkaDV3UWVSQzVmdDI2dnpmclE3blhHY28zZm9QQ1c5dHgxWm5pZWpO?=
 =?utf-8?B?RzBON21HcTBvUWpUMHd0L1lxWm1NYlVpNFpSVW9OWXVHQ05qZDVtUTJWRVZX?=
 =?utf-8?B?TmVDSkdraVk1UitQQm94K1M4ZHZhSXpCcXBuM2toMk5tNUhVdEI0a1VzRGtk?=
 =?utf-8?B?Z213YnBWU014a2xXcUlhYWdOTHZ1MEdZK1FGdTZNR0F3ZVhGenhuRGxiR0xZ?=
 =?utf-8?B?cU1NVnR4WThVc2NTV0Q4bEJNZzFJVENxSTUrazM1QTc2WWx4T25XUDYreTZm?=
 =?utf-8?B?SUZybVJKSGpQVmRKM2FOS3J5RFhsaHZkWmt5aTN4aVhGNEQ5d3hYNmNqTWFh?=
 =?utf-8?B?aTQ2YlFFbkRGdlBRNkVobDU3alY1ckpZeWc0SEIxdVpET2xiUEQ2cWxDWmtL?=
 =?utf-8?B?SVl6andvSE5IVWRuM0JwK1c0bHZSVUZsQ0RQa3BncVh4TmNUMmlYbTIyN1l3?=
 =?utf-8?B?a0JRMCtOQ3hiOU94N0ExUzY5c0gxUktsbDBXeWhqODRHRDA4aTZXWkVkSFZv?=
 =?utf-8?B?RXJ0bnZCOGdrSDlxelZNVDFxeGEvb21qR2tJcnA2cG5ZUVN6UzQ2QU5DdkNn?=
 =?utf-8?Q?QZwtPGMNAT7ZLdRv6fjZH5FhOXRu7uA000HSOwZ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd46e41-eda8-4afb-19e8-08dc317858e2
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6964.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 18:26:53.8696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4371

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
I'll add it in next version. Though it's not very critical I think. It's 
already disabled from the control register.
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


