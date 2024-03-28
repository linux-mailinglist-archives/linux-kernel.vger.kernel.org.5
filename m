Return-Path: <linux-kernel+bounces-122405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1003B88F67F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 05:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B61042979D6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 04:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480E53A1B0;
	Thu, 28 Mar 2024 04:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ICC0xjl7"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400C52B9A6
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 04:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711600803; cv=fail; b=kW9ry+3LdXyPj1p7/6C/SfeetWraRRSmtwwwqe14O8wQby/aQg5VdwTHyerAbsNsIhUavSs71OkgC/THILBku2xDRAu5qLlfoOa672AAEHpPyBuxfRXgzc+iGJCx92CkrmNZtfRdu3lfPxSCEWdAggo7Qsvp6p6UK0PUiDz7jr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711600803; c=relaxed/simple;
	bh=KHZEFSTUMrlPhHPZwQGt5xvd4zDY58mcukvPElWnl94=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e6POhlY/5pdE5jjlvwTSm/rXFZzEbo6YF2ZKneMdfHdEJwgXFUBAAgDaaWAOeZuEaaSZq9ODTe4UViatejTdYgIaeE58THFJRtUjvOwDja7QdwfQ6BeR1KSoq7gFN0OEzPDgKUJSJ6Yj4LXDEwx31adnSdkGjLfI1LpDr2RAGIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ICC0xjl7; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECtWmV22zCfEg9blk3drEqnimCXb0zktDkJgKhn00R7ECZTDokPRtBT7lgPgvg06FKyHVgsSPRKabI1HNpMYJoOY3jjlq9fgmK2BwgxY0p18372M/ucJIL9SG0LvkSlvOwinaVZO7AOWfptiwKgSqHWgJ2xoP3YtiRjqFwFMF/Lj7R1NmidQOmqkBy3SQ4N6m9Ddjl2o7F1Se2vymVcAu4+qdKAsQd8Ot+mIv9emX+cmYe9ECllCqmig25/czdjPGmTK95kCnFUkPa0s7djm+1Q8UEYhbKNGiPpKiptvoraxKQROsKr8iaSGcxPIEiuD32nXUuouKBEERxbFETg2RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHcR65Do7XXIsRgXpJ5OurLAaHBLxChcoVKPgehASSs=;
 b=Uy+UCeNaZ+g47I1U941+9YuToikXIspKyEOtcsHbEAoWd1ELdBpwE1MDTjYLjmq1To7EAQOdi2EYRLAaDLPIt3KQKj2Zm8OCSL1UY2pzhmo2g0t/5a/PclzNQgm0Q8O2IfUpzHwzKoBbFpW7fO3KvWzyuiQ0unOnWRDJF/CS08x2RbYSYYx7F0M10Uoq51HaMnRNDL0trlaXZqOse5RN+erj82v3cRa4BGQR0JY3BAFYKUwLDXrXnBiD8jDpc9VweBRDT0dFJPprDZpGqgq8LVEaaSOFVgdor4cZ3lUqALIdWD1l3byKoFNY+Y4USGoT8UYuJ03tp8wHrtzEp+rptA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHcR65Do7XXIsRgXpJ5OurLAaHBLxChcoVKPgehASSs=;
 b=ICC0xjl7sUfncGsFNlGdLUVmdYzyHqGXeZLtoqvTlK45shzbfp83izbY/slInIUwmg1/a1oaHDe/rI9vH6ko5jPaqJamihY6Dg7Ov2fK6FeDeVjOtpY+xMjNVPDnS3ge7TaxqnrF0qEdE2Ge8+2wrHtnDTiUhf8R45nFPvcQ61g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by MW6PR12MB8913.namprd12.prod.outlook.com (2603:10b6:303:247::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 04:39:58 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::a628:d2dc:a0e9:67e2]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::a628:d2dc:a0e9:67e2%5]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 04:39:58 +0000
Message-ID: <e059df52-48fc-4e65-9eb0-c0d197625e6e@amd.com>
Date: Thu, 28 Mar 2024 10:09:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] sched/numa: Fault count based NUMA hint fault
 latency
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
 mgorman@techsingularity.net, raghavendra.kt@amd.com,
 dave.hansen@linux.intel.com, hannes@cmpxchg.org
References: <20240327160237.2355-1-bharata@amd.com>
 <20240327160237.2355-2-bharata@amd.com>
 <87r0fvktkn.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Language: en-US
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <87r0fvktkn.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0184.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::8) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|MW6PR12MB8913:EE_
X-MS-Office365-Filtering-Correlation-Id: 45bc9b98-b52f-4bbd-1f9a-08dc4ee11f7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	amqPoBl0j63LiT/oTJ0FLi2NbNpgS4krUTiO4kgOrW2Ed91YxZsdAPBjjl6mJTBSkTPchqVGQcnb/BQTOOM5/Lbzr3XcdnGSjsFC56AVvxrocJetDId0V9B8fYxsrSkXAU5CySgKg8hOEIbY8LEd1Nfcaa0ScMUylMjGcqiU1EO4dwKay8QlNi+1ZS9nzhhmp5THr6xwGdfSqzelktj12plDlaOGduDwLZBlvaZYARIq9B/DlDa2KMxRKdi8J+9rgJUx4s749QEeoTtnAI/sGZsDm84onyPd3hK8gVjodjmRwP+bBaTnAkjnIrlOQcJ9lrItxckT/g0OK87EKVpPcrwbUD3mcSsyZaNr/o2u/PAKmmLdsuEITFzqIRKlJ7v1Ksc1SXPXB+kXuSKgqPRGSxje4LN6a0oYU4DV3IyB7t3BySssTAPSvN3gw8AzezV2c31hybWvL0P2kIe2iuLJw7N3+rRXG3mnD4/KWFmO7zVHZaeR5+6N8m0YJxdyFAXiLiDSErTwenknm9uIuqiW1khOoQ/7UbWmpPl0x4UKrg3Cf0YhdSpE1bsxFwq/mo73pjhpztKiW4XhiFwWbPxKlUnEPi1DoGvR7oab/g2VaQNlPH+7daQJ1YGohARBisczVVuC00WV+ADAW5mZl+7EmqO3Ta4BANCgFbw5hFJJKT0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVFpRFowNGtBcmY5SHBQTjJxMWdzcVR1aUUzNmFxakxVVk5uN3YxNm0yM2la?=
 =?utf-8?B?cTR1aWRSbjBJdi9mL0xMeFQ1MGEwc2svbUdWam5GMm4yUmRqandaMENYNGdx?=
 =?utf-8?B?dlk5amtXVTR1b0FTN1lVaDNwbmlxUDlBVFhHY3Rqd0FVMjgrakFSUEhNYzFD?=
 =?utf-8?B?NUNOUU16VjNlRTBVcGtTYjRvYWd4RStCWGlyS1Jucmhqd0VaNno0TlhsNDB4?=
 =?utf-8?B?bU9MNFMveWhkb04zdGx5aTFsbUxISkVFOHNhU05HSUhabk54MUNsWHk0TDNN?=
 =?utf-8?B?VkdKay9LTzhPWnlXWmJZcmRKUFJoUEF2dXRQSGlyYUpEWHdCL3FMVEl2UHdO?=
 =?utf-8?B?ZW9FSm80YjUxeW1BOFphcjZ3RFllS3UwaVp2N2pjaDNwV3R1TFFUbVp1ZE1i?=
 =?utf-8?B?WUNqMWNDMWtzYThrTjZydmFmSlRKN0dBU3RYRFFRNmpLaGZrbFVKSU1pL250?=
 =?utf-8?B?SWtIUVhaa0NBSDlmcFlaRUpvVXdlTDE1cjhOZ2x2cVZxL2RWKzhqVFViNHdH?=
 =?utf-8?B?OGx0dG5sQVVFYktkellvaW5hbXFYN1g2T1lZMGZ5ZTNtNXlxbmhTaGo4VzJ6?=
 =?utf-8?B?UEFhd2VmTmREaHRFUWFRZmV6bVZTeVc1Skl2Z3FSY0tpaUZON0tPRFRXZ1Vi?=
 =?utf-8?B?d3I2RndITDhyNWVQUFRLMEo5OWNwL3RjeWl6RGdyNFJGZEFuMTUxODJnZ1V6?=
 =?utf-8?B?RnA1UExsZUwrd29saXB5aC8xSW9zTzN0aFdXM3B4YzlRUW9VRWduRDZGa3NB?=
 =?utf-8?B?M3JrbCtBczc4ckQxZE5uOGgwRnZ4VGV5alVMZTY0eE9ZK0VwZEk0MjVLRWJw?=
 =?utf-8?B?RWlQVEFzZUhNSWh0eU12UllJQkl1WUgveittRkdQUmMvSmJIcWhDdzRhSHhN?=
 =?utf-8?B?UVQ4bGdIRkJmbXJDK2s5a2lIS2toZzU4KzduVVIxck04VjB2OEZJZ3ZqL0hX?=
 =?utf-8?B?WjB1amVQRTE2S0F3OWNlOXZSaDVHZjRiR2IrUHRCZnVXK00rVTFRSjZvalEr?=
 =?utf-8?B?cHpqK2l2VE85YW9FYnZvL2hKVEltSHd1eWF1QUVubEp4eUJHZGVzMGhjV0tE?=
 =?utf-8?B?dlNpL1ZSR29vamlPRHc4MjFMbk1xdzhyN0RDQjgwRGtobEYrSGFNZ1BJd2Vt?=
 =?utf-8?B?VWgrWVdSRGpXRkFxS0Q3RHdIOHNSWWFNZTdnaFZzVWZib093Mjhpak9KQ3RX?=
 =?utf-8?B?SU5xSHZpZEVxRWJVOEluV1VwTGIweHhEeUdkMmdtMzk2STZuRkRnT09OREZj?=
 =?utf-8?B?S3NWK1MrL0lJVlFKcWZoVmF4U2RaMzkrbi9LdUJTb01FYTV5NE9TWUt6WnEz?=
 =?utf-8?B?L25qdjcreTY1UmNwVFc5TkxIYitGdjNJUWIxTTlKbnBJTVJrZmo1TFpjUTR5?=
 =?utf-8?B?THFZckNTOCsveHVtWVEvRXFpUmVodzBTWW5YSjZnYllJcnV2TTljcHZ1OGx2?=
 =?utf-8?B?TE9WcmFuNlhiM2o1TEc0U2kzaHZ6WGRwVHNnU2JYb1VtSExuZUVaNGtjWTZo?=
 =?utf-8?B?emVOZHhka3hVcS9QYjNKL1pZYmI5RGlvMmpvclozQXYxeG96RWluZVBDZm9Y?=
 =?utf-8?B?TUFSS0U0TVJmdXVGSTRucll4QU1IclIyZ0NlTEdvWHY0QzllcE1JL3lieWcr?=
 =?utf-8?B?bjdMNldSY1MyK1FacmpCOUxta2hhYjMzZklHSmZFUWMvK1pMTmp0WmIxcFRU?=
 =?utf-8?B?TkZEVDVzdE9qcDUzNzFBd2FIZDRXdy85ME13VVR0NmdzcUVaVHBEanljRjlY?=
 =?utf-8?B?S3g2NFJjSjNOV0xKb2RhbjNSQXlBek9UUUlxTENGbUt2NGtwNStKT1I4YWJm?=
 =?utf-8?B?M1F5cFZ3K29HRkNzVTcraTJHT3luMUhqaXNOM05zRTdyTmx1eWpnRHNBeHlO?=
 =?utf-8?B?V21hUmV5SkVGRGRkMFdFUU1RWHluZGJJUS9BQitCSkF6aWpDWndjT1p1VUY4?=
 =?utf-8?B?UUtlYVpLR2RMZUc1NmxoTjZublFTNmF3MExJakpCa25lL2VxN2VoeVdNalcx?=
 =?utf-8?B?ck5SblEwWVJ3Vm1ralBrYytpS3ltRWt0MUF1VDFkT2wyajJCQmZ3SXVPRm9O?=
 =?utf-8?B?YnJ3Mlh6QkYxd3N5dk9nS0xWNTZGOHJqOVVsallxU1hpbm1iejBacE0ybHU2?=
 =?utf-8?Q?Ui+ZHPggvlHCfpIRfDHBCpG1l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45bc9b98-b52f-4bbd-1f9a-08dc4ee11f7d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 04:39:58.5728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5TD5+AAREJfJSKLxKiAmgmI5jh2NgVHioj8QpsDjlmev3b9vfleyCNK66jX+Z2Wj8cCGDO4B65hQc0/YRgEUag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8913

On 28-Mar-24 7:26 AM, Huang, Ying wrote:
> Bharata B Rao <bharata@amd.com> writes:
> 
> [snip]
> 
>> @@ -1750,25 +1753,20 @@ static bool pgdat_free_space_enough(struct pglist_data *pgdat)
>>  }
>>  
>>  /*
>> - * For memory tiering mode, when page tables are scanned, the scan
>> - * time will be recorded in struct page in addition to make page
>> - * PROT_NONE for slow memory page.  So when the page is accessed, in
>> - * hint page fault handler, the hint page fault latency is calculated
>> - * via,
>> + * For memory tiering mode, when page tables are scanned, the current
>> + * hint fault count will be recorded in struct page in addition to
>> + * make page PROT_NONE for slow memory page.  So when the page is
>> + * accessed, in hint page fault handler, the hint page fault latency is
>> + * calculated via,
>>   *
>> - *	hint page fault latency = hint page fault time - scan time
>> + * hint page fault latency = current hint fault count - fault count at scan time
>>   *
>>   * The smaller the hint page fault latency, the higher the possibility
>>   * for the page to be hot.
>>   */
>> -static int numa_hint_fault_latency(struct folio *folio)
>> +static inline int numa_hint_fault_latency(struct folio *folio, int count)
>>  {
>> -	int last_time, time;
>> -
>> -	time = jiffies_to_msecs(jiffies);
>> -	last_time = folio_xchg_access_time(folio, time);
>> -
>> -	return (time - last_time) & PAGE_ACCESS_TIME_MASK;
>> +	return count - folio_xchg_fault_count(folio, count);
>>  }
> 
> I found count is task->mm->hint_faults.  That is a process wide
> counting.  How do you connect the hotness of a folio with the count of
> hint page fault in the process?  How do you compare the hotness of
> folios among different processes?

The global hint fault count that we already maintain could
be used instead of per-task fault. That should take care
of the concern you mention right?

Regards,
Bharata.

