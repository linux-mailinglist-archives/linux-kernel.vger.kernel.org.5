Return-Path: <linux-kernel+bounces-127631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D49894EAA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42EDFB209CE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D73858107;
	Tue,  2 Apr 2024 09:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gzq0dS8e"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2112.outbound.protection.outlook.com [40.107.92.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1E756451
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 09:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712050011; cv=fail; b=Mzz0k6iTatcu1KFVWkb964hCKTabgpxLUcZ4gzj8f+xDnahCtDUmw7EmTyax1qCPYTfr6VIIG8Qf9SODdvCyXQlWIQaHAA+pVBmM+BywzHeij7h+jSOwgpjQJx3O06LD9P2NeS8ln8wLEP68Nj8ty4P9j2svHESzaRzQClJvRxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712050011; c=relaxed/simple;
	bh=+w4SPFxsEgt8QCRX2K7u1+jQo4oXxDQCay/gGuPWiNw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h/qcPF2IQSvdceOBvt5yY2MyUuExiGjyAiTLtgDVjtVpcscRbR3531O/qdbzKjMGutMriATV2U6Ydhe2u6FcX/r8gBQAMwpeQV7D2Qmzeo+oVtQ6DPY5LjFXOM7GqauFYIe8IErXPnJtubsQ2MXouBELH3lQml843OkSDMvCRmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gzq0dS8e; arc=fail smtp.client-ip=40.107.92.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzC4/MrNMCM9MzA0zZisi20JDiGA39XvJdl8GvywpAt4H8ZFmR10ISo8UIjjJS9nR8QZ0XVG67HWdazB9TkdZqX2hew8ATGPk01YRwGpSftRLfhUJobtYPPwzooj+GHzZa+6pIhj3WTBbchfw55FVzpUJuHfjKx1WjDzQIwReDZJLkPlyTwGaknSdpR+kE8b+ZKoHa6qiIRP/7Rv7oMXpwCHhz3IQI+bh6M1CKboUBLjfQBfmSFlxl7KvBIR6L7qpPYfP6YoFD8huwfDyB3+1xN70I/1vFE9kMiozosqDQsx5RuPZjX89C2X/vRb1X7y3/7p31+VYxw6BQ5+ON8Vfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXWDecH4VXmtS5VBQ2VZmbUz8+AzUfjkMdJvnciD6k4=;
 b=StxKo6d23C2xI5aLUcrvuA3yFfgiBk0/p21R1IiYHEdM7nFGz/S1EiKrR3+x1bduP5MAGiiL3MbBed0yfWz1z77kk0fbsc4s8Ib975wk3Jzkc+lGiMY8F9bg7J/2V7RXTLASKdQkW322uohJWm2KjpJZ11dP85MQmoj35Ge0bmP086D/pE50SLmfzYyAhYP4c7IyWRDQ9KjC/S1j0wKrCtsI0QAEkM6kfHphl21KP4HSf5EnHM1F8xzlpXp8zyFZ6AO8zsz8TZ5tgP60WJCcR8ZzCM4K87yJHAzPZd2+kUNisrRxf/Vxj+6TMQ2aVyaukinsD25r2qqbAgbkUp1LHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXWDecH4VXmtS5VBQ2VZmbUz8+AzUfjkMdJvnciD6k4=;
 b=gzq0dS8ei5wBF75w24ImBz56+WEOhNGMx0F8DSdAAD6kaz61PHUKdUl0uYQt5jLwzOJYxKYspmncQ63dli0WKOCEimHmErp/PAV2pplv1pLpDA8ddAkfu71Qc3viSS4VZrOE06sgkr+6q5TO42/aBFSa+6P9d5vu4FWGSRwgP/w=
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by SN7PR12MB8171.namprd12.prod.outlook.com (2603:10b6:806:322::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 09:26:45 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::a628:d2dc:a0e9:67e2]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::a628:d2dc:a0e9:67e2%5]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 09:26:45 +0000
Message-ID: <9ec3b04b-bde8-42ce-be1b-34f7d8e6762d@amd.com>
Date: Tue, 2 Apr 2024 14:56:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] Hot page promotion optimization for large address
 space
Content-Language: en-US
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
 mgorman@techsingularity.net, raghavendra.kt@amd.com,
 dave.hansen@linux.intel.com, hannes@cmpxchg.org
References: <20240327160237.2355-1-bharata@amd.com>
 <87il16lxzl.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <dd2bc563-7654-4d83-896e-49a7291dd1aa@amd.com>
 <87edbulwom.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <929b22ca-bb51-4307-855f-9b4ae0a102e3@amd.com>
 <875xx5lu05.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <7e373c71-b2dc-4ae4-9746-c840f2a513a5@amd.com>
 <87o7asfrm1.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <87o7asfrm1.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::15) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|SN7PR12MB8171:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RYbRa9xSaep7UX0m/lDp5HJygaulFEVALFQxRTE8MivmUNuH8hVrt6UQQ/CDOtY4+3fuQt35UxFFCBU3wmPvm4E9CFrdv9UcR0AGi/1/KR4FDF4Sjj/Rg/I3yxTwXOnmdhEQoxRNxMLuK1ysGscY5gQwU77RZNaTgSKLYljqGUNneDNOkxAJpmJK+p04fNo4+0tvlBvzBv7CmPBokqBfGXIsFi0PTJimx540O2U7kmqSsaTb5TimSLhQQXUn7+ddqPrvU01TWwMCKTFBL/a0KQugboWpH+B9R+UYLmgPAn4iYemgprue6vBvcGgLjxcqs6jmi6Dsd66GZaK9XkYUynKCSj7DWPPUN+Vqr7rBIUrxhfsuksvXjam1Vp19ccQC/XJzkY6EiLC4esiyn0KK75PSfB5uh4b3x25+F7QtiGL7nYMMKyQLgIuqkYIpJX4vMRtpwwyTe7e982yTRFytpoN4H/4xlWfVCuiEnRhrY1PKT2FaaPnIDJlNjjqu4lUgsgB/bwbLHtZ3Dx1v8hRhXvqXzAY8QmkKCCOSRyLzyG17lXrbH5LFTxJXdqFT+jkFiEf57IfQyN/eOZn8kj6v9I0lS+R0Bl+AgSkQtN5TOJgyXoamjDWcnVdk5LELf+anGiSvOpB6u832yFtVgdZUJg+25np9ZA1uuRM8eT4ONto=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejQzWmdrTTlkRmVxQ1REcmJmeHkzR29TajEremprMGtONlhUZ2Q1YUw0ekx5?=
 =?utf-8?B?eVdNTW9LU0x2Ylg2a2M2Nml3WWtHc3JFV1FvaEF1bXFSS1RuN1VPSG44dWVo?=
 =?utf-8?B?VTA0OXRuQUUrM21zOGxDMm5obmFPcGxibHo1a3pDaTZSYy9SbGFNcElkeDZw?=
 =?utf-8?B?ZlR2eHVtZFFlWjBLa0dXVE5ielR3azNTbDJESHhWcFRhNWhGMk1xaVFDY1d1?=
 =?utf-8?B?ZGhNZEk3ZDcyZldjbjkwbm9uaWtZZVpWNTVoOTJPbmMrSUowTW1NUXRmZ0l0?=
 =?utf-8?B?QlF0VmovKy9MRlJZQWlZcEROKzN3OENTUVh2bzRGRmQ1aE80RndLNFpOR2lY?=
 =?utf-8?B?ZmlkZ2J5WXVRL0FKNHZmL0ZZL052b29iSE1xRmZRNS9MZFNhcDZTM2hkNHRu?=
 =?utf-8?B?RXU0TFd3eHZwUG9TK0lHUUlrajVkbEV5TXdaaG5YVXBKVmtWTWhoV011U3lT?=
 =?utf-8?B?K2hmMnk1SzlMaEE3UE1PeG1iZ2ZDUGIrc1BzaENTSitRamVjZzQzQjJVMTk2?=
 =?utf-8?B?YXdERVVoTzdtSldLSlluM2FPZXNxYklrcHUxNFg2WWQ1Tk95MmF6Y0RKTzM4?=
 =?utf-8?B?L1dIVytCR0JQa1kwL2hGck5VQlVXeUZ6MXU5RU1vTVovT1lwcXUrQXpwcWR6?=
 =?utf-8?B?aW9ER09nY2wyeW5nOHJNWHc5RVZ1UlFtbncxMldSbUM5YjQ1ZVdkajlRQmpX?=
 =?utf-8?B?MFFPMGh3dzR3MDFSTHZxMVpOTk5mWHg5RWkvem9pS2Z1c1FMQkR1dVQzVjdI?=
 =?utf-8?B?R3NVa010clN2aXZQSXJlK1RVd0hYdmZXa1grbWJheGZ6TktwRmFpMS9WbE1a?=
 =?utf-8?B?am5DbElWMXY5WlFaVjEvUHR0WENxS2oyL0ZsMmd1dklZdHF5MjRMc2EyaEdn?=
 =?utf-8?B?RGNzaDFZeWlCdEpPd0Y1VjdPTFp2NjZ4b3dPakh2eXl5aGQ1YTB4ZnV6N05X?=
 =?utf-8?B?SGJybFkvNHhaSWtJR2svcVV1aGNMOS9FMUJoaXN5NVpUYmNGUkZ3UDBSbk9u?=
 =?utf-8?B?WHhNb2draHZFMGRaazdUblFWUUNXbkJQY2pLN3E0WlJJc0JYUjBQL2dzSmI0?=
 =?utf-8?B?VVBCSnJKNlVnYkxqVXVXeS9yRlUrajUvcnFkMWxJRkE1ZDZ6T3JWdVU4NjZB?=
 =?utf-8?B?SmM5VXVCSmVhNmdVWXZ5ZTFnZHVHL011amRXM1hsQkliTjFmKzd1eHE1Z2Iy?=
 =?utf-8?B?ekxzNGdUMGNVVGF1bXBqQ1hMOVdWaFB6aHVaYWo3T1MxaXVjQnhCU2EwK1VY?=
 =?utf-8?B?bzFORUFNSW5PeEdlT01NNG1lbldUZFFKSnNjVnVLVmtSY0dJWDRCVWRlNDdx?=
 =?utf-8?B?S1l2QU55amt0K0xvNlZIUGQrejVpSjRpMXZUQ2VaZXJDSlp2ZkVLUWxSQWtT?=
 =?utf-8?B?dkNkKzJDdlI1d2xQVVpXR09BOHVOSng2Vmk3a0VXUkpKcll1NEg1NFVEdERr?=
 =?utf-8?B?cTVtdGI4SWc4UklSODd3VzhBa1oyRmtacU82ellYT0tjajQ0Z3NKbHNRTnlD?=
 =?utf-8?B?OXRyVjRYU3VKUVlkeUNLR3lYL2djTmNnbkRDaXBTRTZpdEFFRUlpRkRsL0RB?=
 =?utf-8?B?bFo3bWxRNFpGYXpyS2NQdnhGQWJkRzdYTVRKS3ZWams2cEszR3A4eWViYlhv?=
 =?utf-8?B?NmRBcjkyeTdkV3RQKzNVNnA3U1VJQVNoYXZkdFQ0WUEreUczbDNnUS9jWndX?=
 =?utf-8?B?YWRBN3VobE95SThBTlJSSXMrb01kT3RMSG5hZlo3Uk9uMXBwaTc4QWFHTjNR?=
 =?utf-8?B?YWd4S0ZvNVMrdmtlN2RZZFFPNmJtcVFhb0V3RHh0RE4vSWEwMzBRUWdNSjRT?=
 =?utf-8?B?YVR2RGl1MTJidloyakU4VXZmSEJGSzN1TUo5WklkVTFFZC9Nd1VvK3Nmd2R6?=
 =?utf-8?B?eTdSMTBObWQ5SFlSaDFLWHpNV3ZWazRyYlRvMHFoajlaWFhUc1NHSldNdytt?=
 =?utf-8?B?VmFoWnVIbmNtTmVkWEtxdlJESVBmdFp0bnFkTnoxWGxWWnVaOTF5b1RKV2gz?=
 =?utf-8?B?bUc0YmNqVEwzUW1JUG0wWGpxYUV6UmVRTWg5d3F5SHlTZ3RMVHVKcFQ4Unkv?=
 =?utf-8?B?c2J0UFFockNwVWZYZUI0Qmp2QTRXNkE4UlMvdWE5M1RnMG1jd2tFMFVjekov?=
 =?utf-8?Q?K4iyDritK1ch4W70B5y5xGWBW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b78bdef7-049e-4c6d-a6cf-08dc52f703db
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 09:26:45.7830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FkQV4IrV0+TayFdOLIur+4Ru0EEPIASQbjP5MbYArn0jbWcISfNoNAcMsEkW9GWOmoYxD1NzhYA2Gfk8Xmnneg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8171

On 02-Apr-24 7:33 AM, Huang, Ying wrote:
> Bharata B Rao <bharata@amd.com> writes:
> 
>> On 29-Mar-24 6:44 AM, Huang, Ying wrote:
>>> Bharata B Rao <bharata@amd.com> writes:
>> <snip>
>>>> I don't think the pages are cold but rather the existing mechanism fails
>>>> to categorize them as hot. This is because the pages were scanned way
>>>> before the accesses start happening. When repeated accesses are made to
>>>> a chunk of memory that has been scanned a while back, none of those
>>>> accesses get classified as hot because the scan time is way behind
>>>> the current access time. That's the reason we are seeing the value
>>>> of latency ranging from 20s to 630s as shown above.
>>>
>>> If repeated accesses continue, the page will be identified as hot when
>>> it is scanned next time even if we don't expand the threshold range.  If
>>> the repeated accesses only last very short time, it makes little sense
>>> to identify the pages as hot.  Right?
>>
>> The total allocated memory here is 192G and the chunk size is 1G. Each
>> time one such 1G chunk is taken up randomly for generating memory accesses.
>> Within that 1G, 262144 random accesses are performed and 262144 such
>> accesses are repeated for 512 times. I thought that should be enough
>> to classify that chunk of memory as hot.
> 
> IIUC, some pages are accessed in very short time (maybe within 1ms).
> This isn't repeated access in a long period.  I think that pages
> accessed repeatedly in a long period are good candidates for promoting.
> But pages accessed frequently in only very short time aren't.

Here are the numbers for the 192nd chunk:

Each iteration of 262144 random accesses takes around ~10ms
512 such iterations are taking ~5s
numa_scan_seq is 16 when this chunk is accessed.
And no page promotions were done from this chunk. All the
time should_numa_migrate_memory() found the NUMA hint fault
latency to be higher than threshold.

Are these time periods considered too short for the pages
to be detected as hot and promoted?

> 
>> But as we see, often times
>> the scan time is lagging the access time by a large value.
>>
>> Let me instrument the code further to learn more insights (if possible)
>> about the scanning/fault time behaviors here.
>>
>> Leaving the fault count based threshold apart, do you think there is
>> value in updating the scan time for skipped pages/PTEs during every
>> scan so that the scan time remains current for all the pages?
> 
> No, I don't think so.  That makes hint page fault latency more
> inaccurate.

For the case that I have shown, depending on a old value of scan
time doesn't work well when pages get accessed after a long time
since scanning. At least with the scheme I show in patch 2/2,
probability of detecting pages as hot increases.

Regards,
Bharata.

