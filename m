Return-Path: <linux-kernel+bounces-140013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBE08A0A56
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D89F41F21674
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A052E13E3EB;
	Thu, 11 Apr 2024 07:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Qe4wEeho"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2102.outbound.protection.outlook.com [40.92.52.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34AD13DDD2;
	Thu, 11 Apr 2024 07:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712821485; cv=fail; b=CmwYeGdZRP8Ekz2OwGcNAgHpFPMwSOTTKUSIp1Wpz85HkdsvlghxEtlK/1deSA0doR9VGpQFBajoRFxtzrhzc9Nl0vMDJu11Cqem98KuloSmsD35Eq9Z6SGLozgWtiJCg0cjBuQvnf5xYbSrI1JbefnL9JSY9hyxHDp0O29vi20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712821485; c=relaxed/simple;
	bh=z8LAB0AuI6QIDJhBMww+VS74XwBMyK0M87x1itWwa8g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nQayulKvnaadmf00fSKiiqCXKvDoaXBexIb4jdudNHwn56+itLjBzrfgCizW5doqaCrTH1TRJou/yaWMUwhaMv0AtbLvUrjSMUlvHUpgKpyJ4FoF08zuKC1fJhRD7hYpVXdYt+vNBfqoA2t3JTQWhw3Wd04eI6W0jghiP5MGfhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Qe4wEeho; arc=fail smtp.client-ip=40.92.52.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2QA8ZKNy+ND0MtXV2Vm8mfZpv89s8GRXMEV2v4/BEmRx8lIqFPM/S4QLWQzOuWqNAaSy3ZgZBoHIXWp/ZPgHmpwXdogio73ci6BnKnGPP2LWt39mBmJbhAUgYhrqmqGyGnbz0anjnbY2bEaWjstotInkVMq6usqBeywKOomDfRmZg4juHu7EENHWU3SHMysqFw9HeznACdeU98z6v82V4zBaUJny+KOdHn6DlKLD4/H6PKqmel4j/acgg7DbkTK6HXObkJR/r78IVhMNOfSL7ARnjFbwo4+rz7+p44YroktWk5Rszx3g+QxpMZ6KcH/EpoiDjDkCMCjEDqqORUXJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7UkmL8VMitnMWZXcjoMsfpdTJKrEYfec1Rm6aZrRfCc=;
 b=YBMdw1iF7lTe6k4RXEseuTg+CdxO9HyT79vWrrzsrnGRJkAItUJJQoRQbzJGLpxMnAhr2df8HEAY5ORJfG3U4wNLPjU4N6k+RUUUjwaZI4BDVuyD1vy/ADvu7bVqSnwAzwjk4hsnnstasbo7BWjcnb2D4KXn8Tlh1rph1Ob2kBxrjHQVajjyCzjnM5338Kg7EJOt0JfKwtSU/RaEd6A244B5dkBUcyreocWqwWM3hC6ccJq8+KIEh34yhcLIUoSEBR1xdfTNvIS5472sW4rdZonKeloWBp0cYZIxOVd2B2UXDzIXHnaPa4R1O0g2zp08faC2sVUuYBnSOHWS41sjag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UkmL8VMitnMWZXcjoMsfpdTJKrEYfec1Rm6aZrRfCc=;
 b=Qe4wEehoFiRNzYiMZarSJDgY1hpKzYrj5infiBlEbreoy01DFH0PRK815Ddqv9CU9dSZx5Nqb9E0qgoLG+asP+fxNASwmWFHAMsmTIKq/5T/f/FTtzwwFgby4Bfhoq++bWvN8E65TSHl51IE2PDfGgrW7XlqLJy5woFRh7iWwf4xLzyuvp6Zn9S7fGsVE2B0QrFx2+gnMcrtzIjX4+EkhsoH+33EqRlPTEtjR561EssG1VdXZ1zpY14k+fFQ3kjydTtdsY+qCY62YuwP2jsOkaZHQjtOIZRZi2zAgxRQZlph1WiF95qthtUHUkEP+LyX10UcLRfwpXSTjOOnaIubMw==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by SEZPR06MB6958.apcprd06.prod.outlook.com (2603:1096:101:1ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 11 Apr
 2024 07:44:40 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::351e:200b:add4:6478]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::351e:200b:add4:6478%7]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 07:44:40 +0000
Message-ID:
 <SEZPR06MB6959E563B692827A3E5152DD96052@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Thu, 11 Apr 2024 15:44:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/2] clk: hisilicon: rename hi3519 PLL registration
 function
To: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, Igor Opaniuk
 <igor.opaniuk@foundries.io>,
 Jorge Ramirez-Ortiz Gmail <jorge.ramirez.ortiz@gmail.com>,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240225-pll-v1-0-fad6511479c6@outlook.com>
 <20240225-pll-v1-1-fad6511479c6@outlook.com>
 <d8dc639c2c6d188d2ce3728573d9a53d.sboyd@kernel.org>
Content-Language: en-US
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <d8dc639c2c6d188d2ce3728573d9a53d.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [CETL6HOtiA4todACOMssVEC1LRdsChYt5lfghm+n7CeQc6gT2qRNW2K8yUzZYy+y]
X-ClientProxiedBy: KL1PR01CA0153.apcprd01.prod.exchangelabs.com
 (2603:1096:820:149::11) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <9d92180b-ee11-414f-bea3-7979d6934cba@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|SEZPR06MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e83d031-8fb3-4bdb-f6d5-08dc59fb3e11
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnqJKUMRjg6lpwFly6pLS7oBG38mDNplFPHYnvKqiofdj5Nsy91x4Pf2e/nPhl0eEYj8pD0kNFzDJ7svFqRrk2jbCwAAgIC5LvcCQ+OqvaD3IWFFKbnK9BgeLWRVFGAP94ofBkzOzireFYUitk/rN5VbhIOP/o3ldVuJWBtlP3tLKjSwwws68P2/0tn9j70KstH03OGiyefRnfqhr+/DiXz9ag8sqaq62juuu02OtThToaa2dE1DysxOhanN3XSqN6z6wkFtyC9oW0cJUIZ5svFvHxe56ET7Viv0Nfj83uOzoHsdAlRLruEsC2ylxliEKm1BiqUbQXSi/EMkwNLN48ceDVvoUYLz6OB/biQvjR4MBouZ/rOKo2UubsHml7A+2WjGnYSVxHU/ExunLtZRJExa8bvujNOT//HmmyJpcBSFtPlDHBe69s8RROluz00dmOxqWotR/Ypd6vYef65uBefnW2VRoSu68dgFlao6SNG0QHCWj1E+rSHFlaB7fsim5yeC7wMYiHRodFok4Go+h73A4R5/WAPP/GOAff8eO/hH+/NST4Yc2y8serlr1mhHahCdlj8LhgVnSCkKZHtYAG+8OMoH8uiokINbYo0VI/h5Mms+AXSvgiBjJ33yx/8YTO4CEBCRlXqhr8szEEoIQfvwmK9jG4EcgSSWEt3aKLjsCfKcyJWEWEV8lhpCd8RHLFyQh8Go8FhQ7FOHt/Gkbuanp9ReyKapwvIvU+UKLTFSUj2+ML3ovwmy009VZ4eEgiU=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	B2YpWrLeJ1mJk/wa0e04HVxvZXbJjDb3wm+pf5Yy7UWedBTWEe4Z+VmUEEw8DJncl+gTDBR0jrYKfrz3ovbMvZsLo5BUQyUJrA3SRqi18hmyMfmsA8lYNO+bMQS1n97WLJfTc3qfRmw0lqluo+02mlEpTaXmwb7N6W4cqQN1YqwPJQfsi+S/pDF/8USLbGIKNp/U0TBtKSKBDSAAbizrlHZRPSEXeIJ2WGJ7BZwBXuOC3nFPrXmainQ3kBMqlztRgbMfkTbIAXP03ap3IhA+Z/tXligpoesKCTS5S0s2pixy2mYx8Uo0qeeVM/68xM7+swj4oNbRcHSbJlmR3xtU+JLktIo7CVNPGgpvl4tDYFcFPz6H1qKI60FsmeURZs4hGqSRA4ub8D8SXm8+Sa5yD7OdRd63dCjqa6tKA+357z8LbA8GRXrl1BHnhbTKEFK8xz9679p9u9eTwQ3WiI7Che3HsrXZmG7FpmEgTMsA3JyoWu9KK5RAx98KBeC/kW1tQyltup0ZppClOICBOZOhgbKM9AXEJI3pzlewDT2myIGWZbbAS0L7LxrV1QQyMXLT
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STEyL05mTnQrd3JXbmFQLzNRaHJoTEUxWU1EWGRLWEx2QmEvejZnUENpSUkz?=
 =?utf-8?B?MTZJTnZLeFJEWXlLSDI1SWdLQXVvUHFPWS9DUEtFTFAxbURXdWFFdUtnZUZZ?=
 =?utf-8?B?ODQ0QmczMjh6a2hGcDh3L3RuSXJRRW5ZS3hyei84bVJEeXBLd1Y0T1JlcXNQ?=
 =?utf-8?B?S2xJWkkxK2REZXhybFZXZFUwRnVZNXZiMVBTNDBQSG1ST3RpOTFhV0JDQVZC?=
 =?utf-8?B?S2VMaWhTa1dZOExqcUlUNzEyaWszWk5IS1RqT0t4M29kQk9xQ2pNTW5MRG5m?=
 =?utf-8?B?eCsySDBQV0MvWFJ6Ymh1bHZWdVNzRlQ2aHZmdUd1b2dMZFNvMDJsNWtUL0JR?=
 =?utf-8?B?bkFBVVBBUFhYMjBhTTFlSVU0YVN6WlFia2cvR3hrU3dwRXcyWm9rOWU5U2F2?=
 =?utf-8?B?alB6WllmOHFPRUE0R2tab3dwR242aHlIV0JLYlZRaHJvVEFxWmVKaUFMSHkv?=
 =?utf-8?B?YUg2NzRvNDRoZDVTVWMyVFV5TzY5Y1pGbVd4dTR1U254dG8vZzExQ0c5SEYx?=
 =?utf-8?B?NG5BdkZhTjZHUloyUXBzNW81NVVXUHZTSW9YQzh5c0FJWWxwcndIbGIrWmgr?=
 =?utf-8?B?RDU5VHVjU0gyZXVVdVY3ZUJ6VVhlaStRMEFHL3pEZlVJb0xrQXdoRndJQnI4?=
 =?utf-8?B?b2tTek9lbEs2bzFLY0dnNXpoclRzZGxNMzNvc2JnNU1ka0YrZi9MWkFrTSt4?=
 =?utf-8?B?c2R3RjUycENDcWJlSmk4MlJ5WlEyMGpRdExNVTZYaEM4ODdjQ1p5dXg3YnZK?=
 =?utf-8?B?RjZMZWpYRWJVUm9rQ0dGRHRQYm44aHo3YWpFNnhTUm05L2xjbzdXUDF4cjRh?=
 =?utf-8?B?QUZabVJjZjI0aDZqNU9DNWJiazRKSldvWWlXT3NUN3Qxa1lPRkhJNXVDbTNu?=
 =?utf-8?B?R2FRdEczUTI4L25zbDdQZHhNOUxvaTIvVWxjNWRQZG43djVnK0VObys0ZUYv?=
 =?utf-8?B?MjNqdEJOSlZ5d0V6THMrdXJPVHpldW1teXFiVDNiVitkYVlIZCtjTzFtQ1lR?=
 =?utf-8?B?M2NVQVhNZGVNaGNidUJwaSsrVW5ZZmVwVnczWWovUGM3K2FIQ1hROWIzNzFJ?=
 =?utf-8?B?UCs3SlJkenZwZVBwYWlDQUxuUWplVXhCTjA3S1phKzJiMUErMmtsYXlpY3Z0?=
 =?utf-8?B?L2hTR3RTR0pTengvM2gvNnFZdU1oU2oxWWNsUXJWSzQvQUw4RzI4RCtuM2Zr?=
 =?utf-8?B?TjN5ZnN1UThLaEZZR0RqVEVzbHgvcFUvdGNPcTRYRXh0WVlvczdUdkVYYS9Z?=
 =?utf-8?B?UEhCUit2YWp2T2ROeXA3NVEyNno3d2lmeHZwbis4aUxzUmFsTUZUMllGMXJI?=
 =?utf-8?B?eWN6VjdYbDVteWlJaWoyTWVlZHRwR3FTaWlrZzlVRGZBWVpFSFVzb3BqWnpK?=
 =?utf-8?B?Uk1WWU5MMllsWC9PcEVpci9nd2l6b05rbFUyeVJpeWo2MUlyVVRlNzlpODdz?=
 =?utf-8?B?NVBTVGdUQWIvYkoyT25zTjRrYkdVNXZYblNqcjlVQWZBcnBhbWVBQzFENEVG?=
 =?utf-8?B?RkNlU2dhdzZ2dTVWMHVkbVVSMmVPZmw2ZXh5NXVTck92VzhLeHkxWTM3Mjdn?=
 =?utf-8?B?eCtUbGcrTDRncFF1QVhJdytOTVFScHZBYUhRSEcvdjVKaXpIOWtpT1JudXh1?=
 =?utf-8?B?UnNORU5NS0N2NWJDblQ2cUJkdXZDM3JCK29pUTAxSXE2a1c1NVg5QVlEYzJz?=
 =?utf-8?B?SS9MVU5ScGh0NXZ1N1lDREVlaktyakZrV1A3aE5PNm9PeWVVK3BGTEpBaW5o?=
 =?utf-8?Q?CHJjIGpcKMIGIJAwL5BAMii+xKo6YhRZeseH4Fi?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e83d031-8fb3-4bdb-f6d5-08dc59fb3e11
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 07:44:39.5447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6958

On 4/11/2024 2:52 PM, Stephen Boyd wrote:
> Quoting Yang Xiwen via B4 Relay (2024-02-24 08:56:09)
>> diff --git a/drivers/clk/hisilicon/clk-hi3559a.c b/drivers/clk/hisilicon/clk-hi3559a.c
>> index ff4ca0edce06..77fa4203a428 100644
>> --- a/drivers/clk/hisilicon/clk-hi3559a.c
>> +++ b/drivers/clk/hisilicon/clk-hi3559a.c
>> @@ -452,7 +452,7 @@ static const struct clk_ops hisi_clk_pll_ops = {
>>          .recalc_rate = clk_pll_recalc_rate,
>>   };
>>   
>> -static void hisi_clk_register_pll(struct hi3559av100_pll_clock *clks,
>> +static void _hisi_clk_register_pll(struct hi3559av100_pll_clock *clks,
> Prefix it with hi3559a then to be SoC specific please. But this is also
> static so I'm not sure why this patch is needed at all.


it includes the header that marks this function non-static. Also the 
prototype is incompatible.



-- 
Regards,
Yang Xiwen


