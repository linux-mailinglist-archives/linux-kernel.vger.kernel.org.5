Return-Path: <linux-kernel+bounces-141883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2597E8A24A5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48E901C22DDF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A1817C98;
	Fri, 12 Apr 2024 04:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3/C/9Qpx"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF135179B2
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 04:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712894458; cv=fail; b=tlhESKHRbvPdwDlrzqqxsJwCB3Y5frZH86f20/ntdc9rzSfjGJBd+7bIsIk/jBTw93QrxJtv9EEx00+IROf9Qy85dcnzxNuY3ziICk/kDyNZ4fsIlxOx7OqzkRWhBXJ9IBVOSKW2a7XyzNS6brzWq7Mpxf0EgRVSUsozXie1IF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712894458; c=relaxed/simple;
	bh=gMK3REd2OlxsB9ANXV7nD7ShK1nfJtEbmFoxRIAK8us=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uOizc3CSVNEmZ3w0re0trFLZ9a1Haa/TUyJMEFM+ncl0zuYpvgJi6k8dWBegboj6z5TH16RJruPsJf2Ycv5jojZ066pj4dUBeYQ9SUX1XIvpsKHJZPGmSq+zq7SAJby9xA6eFYmuDo5FURrNUMY1/CM5Uk6YYfPSqenocyi/2UM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3/C/9Qpx; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+Gfq7TgtiYeyu661kiIHO4Z2Fw08N1ZcxyhlD/kWgMl02KxR5OyqFVLrP868Jo6Zqx4FMaoZ9zxHU3eQgEIzYvvsj3UVZCrqhSzYbby47N8hz9+P/8FOp7okfTddw0fr9zZHZc4reDRgvaY6efMOKfusDNoqOiyC3H8DpWJjcVcvBy6geoRuC0wfxJ//Mz3CAaL6zAVQEgEVcUqJMWKcunYIA+Cp8sxmjm0B4DDInFf9PS0l36Hj/Iz9M4AY1wBMbzifKMgSU1JvdrUNuvMpj0/LHSfUH8VP1bkowjU5R+iLZZuYU7l90n5aL4Wh8DfNa6o07KUjtw8w/2mmZdHCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXvm7y1s8FUqdFFvvKtP0I+Mruf9jAB+T7ysJyGAYbg=;
 b=nosB9Hc/ctmHIB4+sHJmgvXqOSSO3du9we4CofCTyKGx3+ORhzOu0FehHOi0ZuMJmGaCZVjBXHsPk85zMpxCO3AsS2aVDKv6HKOuI4l/yqFXRTP3/uR3HxnFxV8Y9bxYfRHh3I/EcYzJy0RnjmNC7YHbEV25Fh8xybsV24xuaFe9kwJAyCa3hutXAHx1ayhzItGNcPIppdxLuBUrWBEi7RA8/7cWV2VO07lHyIj99DgDo7yXWlMF42F4MYhJjxSfXaLdjLzOAkCnw0lrdbqPC0XsG/LIuKva1O5oxhsgAFOPhhAaNFyjBgPCcF/SJYUvrGQJSsaYEO3brGvo3n4fkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXvm7y1s8FUqdFFvvKtP0I+Mruf9jAB+T7ysJyGAYbg=;
 b=3/C/9Qpxm7x9hEwae/Ynm3uyKvrI39YIwRAi5/WflsU7CUhsFrQi4N3A3HP7Het6FcI/ci4CirdzWJwBxH4EoocPACuvmwyljxlqROZZs+or3tnpoYVhPuLGC2lMGDTKo81u4/UwBnwhdaG9kc8dvkfnGlXPd8jXwkhboZfnpNQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by SA3PR12MB7878.namprd12.prod.outlook.com (2603:10b6:806:31e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 04:00:53 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::a628:d2dc:a0e9:67e2]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::a628:d2dc:a0e9:67e2%5]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 04:00:53 +0000
Message-ID: <8692d514-d1c8-4fbf-84d7-1ad609480070@amd.com>
Date: Fri, 12 Apr 2024 09:30:45 +0530
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
 <9ec3b04b-bde8-42ce-be1b-34f7d8e6762d@amd.com>
 <87il0yet4z.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <87il0yet4z.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::33) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|SA3PR12MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 219f862b-7c7d-4e0a-7310-08dc5aa525f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MURca7QU0HeFbbXfmWXSyUXfX5qusnGm3SSZlFh5WAZWerzpD3FcyhBzHOmKiKecrOJFubZK/m8ZJjKUng5+f5HolG5Dp9AJQmcdCRanFmwkhOtF6PEW3tatfz9boeP0aSFl4ZsENHC+4oTvpxkYlyxlGde/UkNeIh3HglSzJnU8ro/1A9bqZODKO2XEO+bgzT5G6yZrXRHOjiuNuyAWQ4y60jTXxQzzuVIfitzWPjjLjhehmPkhexVbVtF9Egmot6vpikbfZf/QcDARz8MDRIBkYUO0NgFifaghdV2N/wJnoxEqRqVZwfOjtKOp0hJXBkabYQ/7Vqf/X27bWXvJ6+Aam5X+pCgCz5r5C6uXJ3RzvLhllAe7Hd/GZxm86ZwB+vqQ1tl8T+SHZkKrO+qOkop/5ZMRV2qQuw/R60bp4ipmULwRNnT0OQ0ZpxxESCMjB/LoY2dfTaiK/WVTKWOkaW0pkqEhuVWPkgo+yYWH2naj43dFPMgYoe4dDCuFSwQHSV9KHVdrK29VqN3MOb9bCxig3Za0I/LVrfWNxcUq1Xi6vY/5zjCwajf2wgtbO/gEnqDDncDdnQkW1mxGQVRw+v5M1FzeZ/lcNHByy2thjSUGdZJknirplvqWEq/neVIYUdXtonal2AmiN91wOyes2lx7jXuOyiinsSE3G2pLthc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0srN1NmV215Sjd2eVlWcDJ2R0JXbFpKVmVZM3ZFZnRKZjFtbWY4OG55eUJk?=
 =?utf-8?B?WS9KcG85bUV3UDRVU3BEOXpuamRLdFJiOVAxVi93OVRHY29nOHZENmNUMUlt?=
 =?utf-8?B?SlNlWXB1eFRDbGZacmxtMVhoYWxLNGNzSmpHaHZnNlg5VVozZU1ZbWRqUzlx?=
 =?utf-8?B?TDBKK3d4cmtQRnFkd2tOVnRWR2NPay9rc1d4VU85TGF3dUZ0azFJMENmc3pU?=
 =?utf-8?B?ZGNwSk9yMHFRSThReFVscWpPbzRGRzE5d2ZDN3VLcXJkc1hpMG9uT05EbG1z?=
 =?utf-8?B?enVsRUxJWXNjdHV5c3Q1WmViVUI4UjU4dURrMWcyeEkreTJRM2p1QWRIN0Ew?=
 =?utf-8?B?K3dINXp3a1FUVUVCYUM4c2p1RGVJbXN5NEgvRkpVQ0w3SzZ3UEFPQnNJMGVT?=
 =?utf-8?B?cXlTazVTY25LMldXelZROUxMTHFGNEhFR3UzL1ZhaFdraHJGTFYwUFlIdEFt?=
 =?utf-8?B?YTMzbzZtaCtqMkdBM0RqdkgwNXkyZUtZWWI2elFKS2VvcVV2REhaRDNER0NW?=
 =?utf-8?B?K09BbVJERG9zRVJhZ2cwNFY5TnNwa1FDdU5aeGo0aUlha0JwTjVZV0FnaXVj?=
 =?utf-8?B?NDh0a1B6TStpODJJc0ZpMDhNb1FOamhvTzVxemNHVUNzMnp5MVlXbXZVa2VV?=
 =?utf-8?B?ajZnWkcxc2QvUTllNFdSZlNDOXdPWnRvcFdwZy9ReENiOVMwODBxTWgySEtx?=
 =?utf-8?B?N1AvMUI5OUpkQ3Zvc1FEWUVGcE9zTGZjRFlRM1QveGZWY1gwajRIdXpkbzFq?=
 =?utf-8?B?SmN2Y0lCakVGcFRQTWt2Q2lWQWtmYXdZZzJSbUswWnpvUzdnK1pRMUEyaDF3?=
 =?utf-8?B?eEhWcWVIeEQ4ekkrdnROSjN5OVVzaHRvWFJWMHFvTEtBSE0rWGsyeXB3RGJG?=
 =?utf-8?B?T0d0NVBqbHJHSTllZVJLY2NuTlJyNDJ4OW55MDlYQmIreFJ1TjNqdGtwaGRE?=
 =?utf-8?B?UVBLZFdtMG8xcFUwbWJaQ25LVlFRRlFkZlppR1YvS3krYStYVlZzWTZrRnVn?=
 =?utf-8?B?TWdFOHZuSG5vODAxUjN6M2YvZThqbG1kSHQ5MVJKdFNSM3ZwUExURGE2T2pM?=
 =?utf-8?B?ZUpHM3FpOGZ2YXU0NkY5MERHR3JTNmNvRFUxVkxPUjFnaDZEWEhDTy8wUjlJ?=
 =?utf-8?B?Q0lOSjl2bEh1azU2VUYyTmxqVnJvRlJyWC9tOW9OYWpuRlVYeEFUT2RrOG5a?=
 =?utf-8?B?YnZLb0xjUjNtdURIK1RkN0NJNThVak1LNmxxK2xGVFhsbmV6b1BUSW5mOHdO?=
 =?utf-8?B?NDRmazJGUjNwTjZMZnRudXpkbnlGQzVZZ1FQaG8vcmdhNmIrQit1aDFYQnpj?=
 =?utf-8?B?OTFDaU1LSE5BRDdyZy9sT0hlY0VzNk1UY3pwVWEyZTZsb0pCOGY5dmlZeWtP?=
 =?utf-8?B?NjBTbTBmaVFWQVhHQUxObmJ3RFhZSERlUTBHYUZJbGNlZitBTkdScTk0NUR0?=
 =?utf-8?B?UGZTRzY3aDZrME1hdjg1TUZ4VEdncDZlRXhjN0RDYjBhV2lsUDNnLy9QbDAw?=
 =?utf-8?B?YmdqMjlQSUZvdUltZkNSSmQwZnl5aDBpeXVZdm9nQW4rUTlKZCt3V1lDS2Qv?=
 =?utf-8?B?Z1g1Nnc2SWVMMmFUUktsR3N6THdiZll5S2MrdExJUllPOTlEejR6MzZLc1BI?=
 =?utf-8?B?SjM1Q09ReUVMS3Y5R0ZxVlp5WkJoSHVNTVF2N3VWNHlmcC94NGFTL2YyVFRC?=
 =?utf-8?B?YWdKMXRmRTFnN0FOTnVqaUtYTWVNdU5id0NCQXcrZkp5Z09sdzdHZ0RSRndt?=
 =?utf-8?B?MkFOVWVXTnFtRVpvRzk1ejdhNm5vRzlrUWlROXU5a0tvNkhsSTd4eDhBM2lC?=
 =?utf-8?B?aVdwYWh6T1Z4ZHBZUGpUOUx4Nlh0WjJ4Z2VJOW5vUWhyc01UYmJReU1wQVhR?=
 =?utf-8?B?bjJwZ3gzVHFHYmpkZEE2aUl5NWZVWFR0TnlWcTFtdHNhbVRSQVBoRUpmZWJV?=
 =?utf-8?B?dU9IeFJrbTlFbUkreGNzNFY5akVkNndvT2FCNnJubEYzaVJMMGsybWRHcVRE?=
 =?utf-8?B?amRhbFc5alZEQlpNZnFMdk1XQXdzdnUwd25RMmlxUElGUXo4a2FiUWY3THFF?=
 =?utf-8?B?SCtmNTJqaHduK3FLY25OYnBBcmFUOEl4OTNFYjJKdE1Uc0lWd1BFOW9nemJz?=
 =?utf-8?Q?A2EClVOtBD8IV373xeo5Y+Kti?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 219f862b-7c7d-4e0a-7310-08dc5aa525f7
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 04:00:53.5751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EoLWjSYqJcExoblJtz3zTuXiRAwc8ffnCdr2jGmA6NVVCyx4diICgLuQPACa56fjorndK0DD4PqeOEvvgyPBkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7878



On 03-Apr-24 2:10 PM, Huang, Ying wrote:
> Bharata B Rao <bharata@amd.com> writes:
> 
>> On 02-Apr-24 7:33 AM, Huang, Ying wrote:
>>> Bharata B Rao <bharata@amd.com> writes:
>>>
>>>> On 29-Mar-24 6:44 AM, Huang, Ying wrote:
>>>>> Bharata B Rao <bharata@amd.com> writes:
>>>> <snip>
>>>>>> I don't think the pages are cold but rather the existing mechanism fails
>>>>>> to categorize them as hot. This is because the pages were scanned way
>>>>>> before the accesses start happening. When repeated accesses are made to
>>>>>> a chunk of memory that has been scanned a while back, none of those
>>>>>> accesses get classified as hot because the scan time is way behind
>>>>>> the current access time. That's the reason we are seeing the value
>>>>>> of latency ranging from 20s to 630s as shown above.
>>>>>
>>>>> If repeated accesses continue, the page will be identified as hot when
>>>>> it is scanned next time even if we don't expand the threshold range.  If
>>>>> the repeated accesses only last very short time, it makes little sense
>>>>> to identify the pages as hot.  Right?
>>>>
>>>> The total allocated memory here is 192G and the chunk size is 1G. Each
>>>> time one such 1G chunk is taken up randomly for generating memory accesses.
>>>> Within that 1G, 262144 random accesses are performed and 262144 such
>>>> accesses are repeated for 512 times. I thought that should be enough
>>>> to classify that chunk of memory as hot.
>>>
>>> IIUC, some pages are accessed in very short time (maybe within 1ms).
>>> This isn't repeated access in a long period.  I think that pages
>>> accessed repeatedly in a long period are good candidates for promoting.
>>> But pages accessed frequently in only very short time aren't.
>>
>> Here are the numbers for the 192nd chunk:
>>
>> Each iteration of 262144 random accesses takes around ~10ms
>> 512 such iterations are taking ~5s
>> numa_scan_seq is 16 when this chunk is accessed.
>> And no page promotions were done from this chunk. All the
>> time should_numa_migrate_memory() found the NUMA hint fault
>> latency to be higher than threshold.
>>
>> Are these time periods considered too short for the pages
>> to be detected as hot and promoted?
> 
> Yes.  I think so.  This is burst accessing, not repeated accessing.
> IIUC, NUMA balancing based promotion only works for repeated accessing
> for long time, for example, >100s.

Hmm... When a page is accessed 512 times over a period of 5s and it is
still not detected as hot. This is understandable if fresh scanning couldn't
be done as the accesses were bursty and hence they couldn't be captured via
NUMA hint faults. But here the access captured via hint fault is being rejected
as not hot because the scanning was done a while back. But I do see the challenge
here since we depend on scanning time to obtain the frequency-of-access metric.

BTW, for the above same scenario with numa_balancing_mode=1, the remote
accesses get detected and migration to source node is tried. It is a different
matter that eventually pages can't be migrated in this specific scenario as
the src node is already full.

Regards,
Bharata.

