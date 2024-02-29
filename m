Return-Path: <linux-kernel+bounces-86972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5158986CDB8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC4871F21D53
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7BE14F9D7;
	Thu, 29 Feb 2024 15:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r2UFvNu2"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4483914F9CE;
	Thu, 29 Feb 2024 15:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221774; cv=fail; b=M0ADC53rz9pVez4b/gHnUnu/rfSQiTcxRGftxTq45hxAZm1Uhkx8foD3BocmfaI96Pvr85s2bxad4NkkgSpDJppdXueVCSZwGuH2WiI+zhGU7zWo1puUeH+ohQ3g3V++s2vUu48cr+E+f5i6BoYRA0/kN3mdPdqzOJJj5yJaXAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221774; c=relaxed/simple;
	bh=+Dw8edFdMdA0uyoHmCNrZzovNsc8HpILqenNxaqzmq0=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eSSvgIyxLtf0cPo03cNiGxwakLb58sK6IyOCLvKP9TP5xhJjL2niRyaWknsDc+hP9aaE99q0Q3GvjjFxc3ekuEUDkH6E+VT91HSqrsw8DDUpZKEKb4gAPUsT1AMO1bhdN/xylowZ57+JzbhxWMGv1uIURoG6X//H08nRbBV9QCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r2UFvNu2; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOnbli8e+467mSiBC6ZSDmYOLBPs6tdEiHF/J6vauXeL4D7nOXd1bQUdYejVGUiQt9EKu9iXY6s/QGn9wfaq9MDGqXfEb+NfdE56eAfZkM2X2IoaQtXpF8MaUwUlQEtaIOKlXz6waEBDeHvgz/CKgNKEodONUVsc2unrJiw3vRJKlL72bHyWE5T+PzvcjqHXh6OOxjrqbSRTFMfhrAoOOpsxy6I48UceM1NGRgxher4hUcPH6EE+z++5dAdbzktonlXEtvslPBFLCFf0u+6/nV4SZSUE4Di78FH/Yu1JflXNJKhrcSpkXppX7fkl1SU3CoOnpYdRgPwXMvInvhfwIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKc95lCag79HJIV13vA3y+ZGRIZShHdDXC65a1suKwg=;
 b=EIKy8ZCCQS8ZU/cpOvBBB2nJ3S6lF+t6k4C1CqJwdKZ9PMB3ASPPO0ImRLxsv9tXAD8E9NQIAZBgX5sRqLDjDYohBUypolwyWDijVcFHcJZPKdrm4sOYUOrJYGi1yH1foyyPRf+U0P3PWLFtjSqfvirN8CxgJ8p8a3RPEQOKBzOhC7NJdrHdms2umWjaO0AHBUzBu5jaE6/w7Xv6oS/t5hZxLsBIsTJt3kptscRVPTrmEiuVVwqaWcVuaQqEwQhtICq8xfkHcQmHtg5IBx6nDkgRNClknCqLyxnOzfQWM5aLboPZzreK7YNsRDHYk+cCsEegnvJICkRgZhXYgmbfbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKc95lCag79HJIV13vA3y+ZGRIZShHdDXC65a1suKwg=;
 b=r2UFvNu2b48duGKj52VeOxHus++9/kChhgqFIPP5fIEI8M6SDV3w+Mwm1L1hxEq4vHZLU9BhgaxFSpl9mRMP9oIa2q5ZZlUHDn5YWAyeAiV+/sEJ67PW3yPfRUUYYrlvSyeX9pHpBgThf/g4hOGTbICm4+DFBTmbNVYtE+ZaU7k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by IA1PR12MB7518.namprd12.prod.outlook.com (2603:10b6:208:419::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Thu, 29 Feb
 2024 15:49:22 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::1b8a:49d4:d256:d169]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::1b8a:49d4:d256:d169%3]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 15:49:21 +0000
Message-ID: <b019fb64-fde5-4ade-964b-03a3a217dfd2@amd.com>
Date: Thu, 29 Feb 2024 10:49:18 -0500
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, "Naik, Avadhut" <avadnaik@amd.com>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Avadhut Naik <avadhut.naik@amd.com>
Subject: Re: [PATCH] x86/mce: Dynamically size space for machine check records
To: Sohil Mehta <sohil.mehta@intel.com>, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>
References: <20240212093246.GBZcnlvkPKDC8C7rv5@fat_crate.local>
 <SJ1PR11MB6083B3511D18787BE823AB2CFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240212175408.GIZcpbQHVjEtwRKLS-@fat_crate.local>
 <SJ1PR11MB60830AF35FA89C7869B8C11EFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240212191401.GLZcpt-XHFqPg3cDw-@fat_crate.local>
 <SJ1PR11MB6083C60D7584B02E9CAF19D5FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ZcqPhVO_DtD2x5N7@agluck-desk3>
 <20240212220833.GQZcqW4WxKH34i-oBR@fat_crate.local>
 <20240212221913.GRZcqZYRd6EPTTnN97@fat_crate.local>
 <20240212224220.GSZcqezMhPojxvIcvO@fat_crate.local>
 <Zd--PJp-NbXGrb39@agluck-desk3>
 <015bf75e-bbe7-44ea-a176-9f1257f56b81@intel.com>
Content-Language: en-US
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <015bf75e-bbe7-44ea-a176-9f1257f56b81@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR12CA0027.namprd12.prod.outlook.com
 (2603:10b6:408:60::40) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|IA1PR12MB7518:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e30f22f-f4df-44a2-d85c-08dc393dfed3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bBQrqpBAYSsj0Hytu1VGQIc6ZcYIAXNNV41jCAm1BwJu3hkZ74ShR+sOVCIaTVO4N6vgeQ4t3EJqp3RdAFfk3B9ght1IwNLE0ktN0JSKzQ+AiOrTs7SFGkFDUF+xpyrazID17RvKv27+JiKA4+N4heOd/ndtSkV0caOxVm1xMI0jMP0q9jRO0UxrJVT9VHrtUcGXSuMtvJrWuPgco0CtfpMW9zV1qe/o8LksEEPAOyIdRJg/tvUlIDwhLjKROYN5Pa3o8Vup6SbSMmp3AT2tt4aDbgFE6Nk3buEjBYJ9QXZolGCwAZXcsiswicc3MtQqXFBAoKm4uLM6GJA26mrgu7KW75rIDMJqN27xA6ld/ryCBpoYCa+QjOf4CD+y66GLnfyE68XZpr5AyXicf0dqLOyXvB9o6xMODux6mLAUw9u34JXoLsro1lomJBt0ZvoNOvsdRgkwiBGZgnbILY1KwklDXZ3GLNE1lTAHnDwhbVbyUuwcMl8OVt/6d1vBorE5DYrc+S+qrfMtkrB5BNpfbzIOYMQuy1JSNQuAtfb7Op096DQ4ibH/T0UajfU/ELytxp6IL7/G4ivS7X0WyQQnKHMUVzV3EMz83aRHoRLhT86xXdvSfkWOcR3zIdffu5GoS4TT2CKLwXMngX5Y0Ehg/Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDk0OHFCQ1dZem43NGpxdGRuS1JPWmo3N2o5WGV0dnBkUmpacm1HVk1oNWZz?=
 =?utf-8?B?UHlNcFo1UmJDZytWT1pnZlRINGdZY0dCcGw3Y3NPay9sK3ZtSDdIN2ZPVS9X?=
 =?utf-8?B?K0hGV0tqbjdiUFZNQWRqTUhWVHdUamhPMGRNcnhlem9WNEhHdzdWdS8veHVV?=
 =?utf-8?B?bzRTd2IrZllreUdhWWwwZXg4RlpTWVZ3Nlp2blVMSE9FUGp2ZzU2ZWNBdnBu?=
 =?utf-8?B?Z0g1bGhNajZpalg1ckE5YzVqR3JwSXpzNkMxRkhJZHFDbmYxR3ZqRlJGMHpG?=
 =?utf-8?B?S05vZTZSZVlJZFBjWFpaNXV3K25xdzBvdWlndFFKdFlCSE1XVURIVUZvaEJN?=
 =?utf-8?B?bmthb0pqWm42R1JTTEJNczJRZHlHUWRJcXdZaXl0aGNRNXhsNXprTTcxamZD?=
 =?utf-8?B?dWJWRitLUE9vVkJlLzhmSW00V1VCMUNtUmQ4QnZuMEJydmwyc050UmpLVHVn?=
 =?utf-8?B?cVp2bEtsQVdtTjZCQzUzd2QzZk1raU8weTV0QUFkenFwVXRrMjhxQnE0aVNv?=
 =?utf-8?B?OWtwaGV4a3k2ZEU5cENCSHJLN09GeVdOUTVhWXpvUE1kcHQzZnFsS0xzTTg5?=
 =?utf-8?B?M0tFRmR2aVpWN0NMQ2RuMnlMN1pnVzdHSEN4ZUVsQjEycnpndTgrSnI2QUhC?=
 =?utf-8?B?cDR2dTRSUkxPaUgvU2I2RVVPc3Vwd2tnSEM2d05lWjVHUzkxbkh5Ulc1RE5X?=
 =?utf-8?B?a1k0QmYrWjRSdW1WQnI3YXdiQ3l4bDdyZ2lMSHpLTjhjcmdGUVFnT2Z0eDBa?=
 =?utf-8?B?aWpzK3dIeWMzRHZzZlVrLzNQUHJDMkV3NG9VaFpOSzJzSEk5bURUK09SUUk5?=
 =?utf-8?B?WGZsQXMyWTJ1TkN0WFJNeWo3ckVRYVlmU01HbWtMSHpoN0ZnenN1YzNwSGRx?=
 =?utf-8?B?dkFXcE5qSDNZb3ovdkJmZ1BUSDBFMVVsM2FIYkd2T2U4eU1NVXZhTU56WU5w?=
 =?utf-8?B?VldpQWkvNlNrbElkTG1mdUlydnpUN3NDdVVxSDlIV2d5emdZT1lvcUZpOWl2?=
 =?utf-8?B?VlFsaWxmQ2c3MWZ0TjRhTGZ0bk1KaDh5M3RXcVVGdkxIUU0yaEhXU25pVGt2?=
 =?utf-8?B?dWR5NitucmV0eXdrbnBQekRHRytGRWNSOGVoU3l0d3R5WGJ0elJOQVBFeXdz?=
 =?utf-8?B?NVhTWkRLbWtRSkpFU0tibklkUVVBV1FuUFN3NzdmYnJKNm9yWldQNGtLWU5Q?=
 =?utf-8?B?RnNCbm9nRGErV2pydWd2NVZ4a1FrYXNLVGcyWU1hU3NEY2tJQ0JRQ2RYQXoy?=
 =?utf-8?B?VEdHcW5kdGxJQi91ZVRQLzlHejVZbGM4dzhndWVoTVZkWFY4dUJQdE9zUDhG?=
 =?utf-8?B?Q2tnaitlZWJsUDFWU2lPOFJ2VWpRYmsrTERqeElYWUVRUjRlNVBvcW5RRWVT?=
 =?utf-8?B?eWhZa005RDg5b1FzdmRFTldYNGY3Yk1FZkh5b04zeStWczQ2RldZZlByTURF?=
 =?utf-8?B?aG9DQXh3dEh6ODZsV1FxZXRLZzcwM3k0bXJPN2V2MGl5WWpSL3lUVThWdnFP?=
 =?utf-8?B?MWZ6QW03dVpCVjRpaGVidmI5N1M3RGc5NmJwTzFpczB3TFVKaG1Lb1VZWXZZ?=
 =?utf-8?B?RWg5Rll2K3krZEVFOFd1dVJvY2hmdXhGR2FlbUlFSVo3UDVQQ1Bvc0pzWWJv?=
 =?utf-8?B?Zlk4ZTB6MmgwazNSaDV1ZUZ6UVJSaFg0MUhCK3F6OGgxUEtEdElPVVFIZjlx?=
 =?utf-8?B?SVJpdCt5QWhRR2V1Mllmc0lwY1F1aC9GL0dsWU1IN0pHcTJXOVh2bTVkSUx4?=
 =?utf-8?B?VnFNU2hIOTBYeDNKblQxdEdQTVBPTXhEVVNjTDZiOU15TENnbTdFaDRhb0dK?=
 =?utf-8?B?UzFGV2V1VHNnZ09zU21MeU1CYnFWVmZ5YzhKb0VaUnhTQUNCenQ2VXpMbFBN?=
 =?utf-8?B?enZXUXNNeFFrbk41OGQ0VGEvS2RBR0RVNDFvUjBONENSN0ZpYjloSkZUeGor?=
 =?utf-8?B?QjR1bzROUmREcllmWmhkVGJ6N0t1cXk0T1NzRVVlUmgxYTNwTHhLZG1hZGZZ?=
 =?utf-8?B?b3NBUUlEQWNRMVVibUlzU3NZcSthQWVBaENMekVvYlczanE1MDlaK2c2TkFs?=
 =?utf-8?B?MmVuOWkvR1RWVFBLUVZUY1lwMUptTkxSeThIbTBGN0xtY2QvdEhJY09ROVRu?=
 =?utf-8?Q?vVLInAnMGcGxmkcgyOXlYan8v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e30f22f-f4df-44a2-d85c-08dc393dfed3
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 15:49:21.2052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vaCCdOUPKFWn4rUzK0i892JkwWBnjnHLq9X7UYgS3+6Cy1mLzifQPs0zfdciZqRcfplj/yX//rINcxTzWRa9zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7518

On 2/28/2024 8:56 PM, Sohil Mehta wrote:
> A few other nits.
> 
> On 2/28/2024 3:14 PM, Tony Luck wrote:
>> diff --git a/arch/x86/kernel/cpu/mce/genpool.c b/arch/x86/kernel/cpu/mce/genpool.c
>> index fbe8b61c3413..a1f0a8f29cf5 100644
>> --- a/arch/x86/kernel/cpu/mce/genpool.c
>> +++ b/arch/x86/kernel/cpu/mce/genpool.c
>> @@ -16,14 +16,13 @@
>>    * used to save error information organized in a lock-less list.
>>    *
>>    * This memory pool is only to be used to save MCE records in MCE context.
>> - * MCE events are rare, so a fixed size memory pool should be enough. Use
>> - * 2 pages to save MCE events for now (~80 MCE records at most).
>> + * MCE events are rare, so a fixed size memory pool should be enough.
>> + * Allocate on a sliding scale based on number of CPUs.
>>    */
>> -#define MCE_POOLSZ	(2 * PAGE_SIZE)
>> +#define MCE_MIN_ENTRIES	80
>>   
>>   static struct gen_pool *mce_evt_pool;
>>   static LLIST_HEAD(mce_event_llist);
>> -static char gen_pool_buf[MCE_POOLSZ];
>>   
>>   /*
>>    * Compare the record "t" with each of the records on list "l" to see if
>> @@ -118,14 +117,25 @@ int mce_gen_pool_add(struct mce *mce)
>>   
>>   static int mce_gen_pool_create(void)
>>   {
>> +	int mce_numrecords, mce_poolsz;
> 
> Should order be also declared in this line? That way we can have all the
> uninitialized 'int's together.
> 
>>   	struct gen_pool *tmpp;
>>   	int ret = -ENOMEM;
>> +	void *mce_pool;
>> +	int order;
>>   
>> -	tmpp = gen_pool_create(ilog2(sizeof(struct mce_evt_llist)), -1);
>> +	order = ilog2(sizeof(struct mce_evt_llist)) + 1;
> 
> I didn't exactly understand why a +1 is needed here. Do you have a
> pointer to somewhere to help understand this?
> 
> Also, I think, a comment on top might be useful since this isn't obvious.
> 

Would order_base_2() work here? It automatically rounds up to the next power.

Thanks,
Yazen


