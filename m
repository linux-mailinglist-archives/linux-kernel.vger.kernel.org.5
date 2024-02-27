Return-Path: <linux-kernel+bounces-83986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F4286A0F8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B1D328B3B9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B3614DFEF;
	Tue, 27 Feb 2024 20:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k+CWh9Lr"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC1B134B1;
	Tue, 27 Feb 2024 20:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709066563; cv=fail; b=qwG1lTLyCkgqVHMGMZwd3ErIBj9y/2QgvcYQzcUG8EOvNk+/JQgDM3YkaFHyOAGgfq4Uo/YFVi92obuM4M8OO8WAd3TgXf+umpaOnv/IfBND6Q8gpzFVhasYi5YsWDkr4kh/joqE26GFUsj/VyTJ9h4zqD6LFLxxLzs5dUBANC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709066563; c=relaxed/simple;
	bh=hH64iq5y/dbaNEo67uomlCARyaRbvneTc4kfdnlCkVw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DcEc/KKe9mEd/4bmS+qIqv/TZsnzJF4YUaJBrhwRIY0Y2VB8ZPPUgG5o04JY/GVFzlrE/GwMHgJZWa16R9jJhZJBESSnO5XiY8GaZScIJX3todcaeDz3qaN98S4E/nmyuMTXbp0pvvXM0mgoRyzxgPEuUGXxGxe/4oVpls9QLiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k+CWh9Lr; arc=fail smtp.client-ip=40.107.243.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDeq6C/7z8kg8cO/iYccGalisCqGtBRnX4uCgD9ySEAYPdllQFJNySQajAB9IhExTpUFxv8Tu6ULu/rlSYlaRe+UTZw2eN+e/FNXtI+B8IDuvrbvR+VqT0Pvgxkzc4BM6qxZ7/GTjQnU0Pims1i4UYR2GT/u+Nms5Zna7FcfL9uxHI+QSa4Iljp/Qdvhppq4DMWeSOUJ4hhpUiQeTYde2j4MHIamTKMt9rFL2RI6DHumW6ZOYgxiH0EHoZkENmiXmZCWoQwB/ykqWJkopZ0Pk/eWyvGIoNNDro6QYs9MqeB9e+IoN3lvQUEnvOAv+bWtzge9RHGf6qRLxW5HmP6S/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LTrNzDtOMGiGUp1FmUSirS12BX4jCw1TYpLGtjXc5+M=;
 b=hxxFrjM2Cvu/AzX4oAaYCypspBTujHbt3wZoEgnTnNho+TRYO3uLk3C1znNGbDlYxDCRUnzveLIlLu0IgqkQhzgHJW30g5PdmRpSHtCV8zgFTA07xTZA8HOtdR0ptc7llTldZxJnUMsYBb+2e9RgTKE2c8hCNezlfLnL9TI1KEeGb5DQnxmGqbr5VEXwTDOZdlhBITaLgFva2N/+1NPr8hQvKpd3nzqNkFqJDtKeHwluSYvyP82JlBWOtKrHF/vaywZYeW7NDQHi5Ew9I/2OLTS0bbcTIbHyD9pQoFW/7WGskIUgdbEJu7Sg7shox1O/mFmbG0wCQFkVb7bfepXBVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTrNzDtOMGiGUp1FmUSirS12BX4jCw1TYpLGtjXc5+M=;
 b=k+CWh9LroCjFRpuqDWol+3O+aCkFVjNZajABT5H+BMW0LiDlrnnqzryeaYmUE0qCaJPVfs56E47OaUM/j7N0DODgWlJNao/tiw5G5JquYTJgx2sP0HqR44GFyLCSjZsXox94zO4CL583mLLQxHAf5l8EbTsFba5UXMXCo/9m5MI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA1PR12MB8357.namprd12.prod.outlook.com (2603:10b6:208:3ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 20:42:38 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b49d:bb81:38b6:ce54]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b49d:bb81:38b6:ce54%4]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 20:42:38 +0000
Message-ID: <c3838a4d-4b7f-4673-a416-9aa569eeddd0@amd.com>
Date: Tue, 27 Feb 2024 14:42:34 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v2 00/17] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Content-Language: en-US
To: Peter Newman <peternewman@google.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 James Morse <james.morse@arm.com>, corbet@lwn.net, fenghua.yu@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org,
 peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com,
 lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com,
 leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
 kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
 kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, eranian@google.com
References: <20231201005720.235639-1-babu.moger@amd.com>
 <cover.1705688538.git.babu.moger@amd.com>
 <2f373abf-f0c0-4f5d-9e22-1039a40a57f0@arm.com>
 <474ebe02-2d24-4ce3-b26a-46c520efd453@amd.com>
 <b6bb6a59-67c2-47bc-b8d3-04cf8fd21219@intel.com>
 <3fe3f235-d8a6-453b-b69d-6b7f81c07ae1@amd.com>
 <9b94b97e-4a8c-415e-af7a-d3f832592cf9@intel.com>
 <1ae73c9a-cec4-4496-86c6-3ffcef7940d6@amd.com>
 <32a588e2-7b09-4257-b838-4268583a724d@intel.com>
 <088878bd-7533-492d-838c-6b39a93aad4d@amd.com>
 <CALPaoCgxSAWPYGcmnZZS7M31M+gMJQ-vWd+Q5Zn1Y548bxi2Kw@mail.gmail.com>
 <db9a87b8-40e5-419c-b36e-400f380892a0@amd.com>
 <CALPaoChiVXWz6ObQsLZudNo+ammmPnf_iLvvETDswzwY0n0rQQ@mail.gmail.com>
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <CALPaoChiVXWz6ObQsLZudNo+ammmPnf_iLvvETDswzwY0n0rQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0180.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::17) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA1PR12MB8357:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fc51614-fc26-4a5e-e512-08dc37d4a2fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VU5A8XXRPFiIJkx6JqiWl9wvGxideRcIDW8Ohq3bOk72eQY17HqTXK7RMECUxP4TxV0dQHkHFsMGayaoCD/QksEQm4D1EiCBiLQp5wmEPXaIOgOqChFvwBMU/BvklrloMPOTAN8kI9XDRyHHatwwffCT1qpwTJ2CL+FOz7Bme9D5bY190CCuxFovH4GOHZO3Bcsp2DBjypWG3A5LamAzoPRF/VTwkfwFaHhIjIKhiyDTX0TmGzYUR+dtikilTjcRKGTdtG1ate3JI2m87d23QmVzozm8olUdrWwi1kjkTYZa84CPvas7/Ao9dt4mtejLT0cVjF4JD9+7VY/hZ6ZV9un6igFNZqApvVO6HEVz7UvajGDj/Q1D0LzwKfoYUM2qNxepIH59RR9azy4sfyt3MniiF0UfPng2K+sviuSrykNaIP7CqftuHHqjA59GqCl/Fe7sXbstraGCjDFg0tlR+PprwrNlzPUehjZ9H6b2c2jy11zjU9gvjLHfqLny9y4Ess2yKZ6/AnQQYTHQOGgI4eZbaGMG3fsFgS+QEf8SV+/WKUDC9mOuuOzSvtnIo5jQx6EHHB/o7kyiLjWW3qr0/EJ+kB/fvjyU/TC/fAFlf0ors3b0xk/ERinq+EuAjRzI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWpxT3VvK0t5UXBPeEp1dGVoRG1vU0x0Z0s3REZVZC84YVlKeUEvN0VLeXEr?=
 =?utf-8?B?V3JoUWs5OXJlRVRWWFhVay9JdWd1UVZGek5tb0ppY0VYbzVnREc0ZUovbjhi?=
 =?utf-8?B?eUs0dzRTeEtwNm50SHByZ2NTREJoK2J0cDZWcjkwRmFCanpPSUljN2ZhNkVU?=
 =?utf-8?B?MG8wN1hITG9ENGtaZEdkWUZKYUcrOGxONTFEbGcxUTJoanRsYkxwSnM0SVN2?=
 =?utf-8?B?S0kzdXdQS2xxTW96eVRlSEJHZWFnU3E1V0RoQ3BsSUZYOTFaZmVxbnppOEN0?=
 =?utf-8?B?Qm9Ha0k4Q3BYV0xiQjBPcEkzc21zQTc5UFgvL3liMGpHdTY0ZUdrekR5Vlp2?=
 =?utf-8?B?VTZTN0huSUpoU1pjak43RWRLWlUzRHdzczkvL01JOVZRenlEVU9SclJ6YzIv?=
 =?utf-8?B?dFVKRm5ZVVh6aDR5ck1PbGduNHVRM2RHbUk0T0JYeEc3dm5waEJSeFRlSW00?=
 =?utf-8?B?ZzUyOWNnN095RlVCYjBQLzg4aSt3bTNlbUtTSDI4c3RLS0ltZXMzNUFlNVdn?=
 =?utf-8?B?d3oyNVpGOWhKc0RyYnpkVkIzdm5FOFZHamZzMCtpVVp1dHpIVGt6SGpWOHNi?=
 =?utf-8?B?VWxjWHBzaERiNktzZTZmU0xnSk1pVHJaVCtYSG96Z2lpKzZYWEdhQk9VMS9T?=
 =?utf-8?B?cGRBdzFHeWxMVk9nZ3VVN1lsT1E1Q2hSdEsxWnFPbU9Md0srT1ZLb25yQWtr?=
 =?utf-8?B?UWVReGM5OUE0UlBncjVKTEZYNmFlb3MydnB2SDBXQUthQk5GL2VWR2FDT0hz?=
 =?utf-8?B?YWNWYzZXczlXWTZrQnlqWmtjWExUaFF0b2g0MmNoajQycy9WYmdlRUUvZllQ?=
 =?utf-8?B?QnZHUUVCSDBoRXRScTZoVDZLeDgzTktzSjV1aDRKK0pSckkwZllFWVppN2ds?=
 =?utf-8?B?LzFVSGl2bU9xQzUwUFJtSlVxaW1iT0pvVXhiVG83bW5RbjlPcUFBWlE0M0Fj?=
 =?utf-8?B?T0dQM3NES2UxbjZzTnJncmxZQ2RUMmFTSWVyUU5VNlg5T0V6ZFJDMVpXN0JF?=
 =?utf-8?B?MWw3WjlRT2ErVS9YZ0tUSGllKzhYYU82V1VBM3V0Q2NBQkRqT2VOZUh2dDhO?=
 =?utf-8?B?bWp5c05VU09ZdkJ1MDBIeFZPaVlLZGJGNGZzcUFoK2hqVU5jaU9PekJGVlBI?=
 =?utf-8?B?c0lqdzR0UWZEYklTSEdXVlVvcEVhUm9ZYlQxQS9ycjBEL0FiWmlQMWYwSExR?=
 =?utf-8?B?U2UxYU1UY0JLMmxMdHMySVdMQjJYYXBhNTFEMUNWbUkyanFVc1FTR1N2dGNu?=
 =?utf-8?B?UW1NWG9CbFNJSVFaR2lMdExxSDRLVXZhSHowMndwWHNGRWljN0VQZGVIWElO?=
 =?utf-8?B?Wlk5Ri9ZUkdMbVk1alJQTk1WQnVlcnFSUThzemE0andSRGJheWVmVlBNUzIz?=
 =?utf-8?B?UURSRmxlNXluSmtqNlh1azFFcmQ0S3AxSGlYanlSY25MeVNuRFVTY2prcXRZ?=
 =?utf-8?B?aGV5a3NYOXZnRUYwNnlWaW94b0JyN0Z0aWcxL2hieGNRTlJmb3J1OUhjcjMv?=
 =?utf-8?B?US84TUpyRVhRNmEzVDRUNGV2SGJiZTVxMHJ0RWNLNll0cWZyR3B1UWduSmxG?=
 =?utf-8?B?UWtLR3ZjVVF1YXU2TVU5S1NlNGJMNlMyTVRZWGhUNjVpYjd1UWlIQnFkK0xI?=
 =?utf-8?B?QnBJampTQmFpeFdiR2IzY0hJRWZXYVVSS0pvTjZ1L1JJS2RXeC9HbmZvb29v?=
 =?utf-8?B?QlpFdmFBYXVtK1I4UEE1dWplMVN1N0REZlpxMVBEZnhCMWhFLzNUTHZOUVJD?=
 =?utf-8?B?cTNpNjVsUkZoeTIvZktXSUpmeGNQRXRFUlJHVEJGWkVjM2dGNHRJSUtqNkEy?=
 =?utf-8?B?ZTluYTZYb0RPZEpPR0ZpekMwQ0FxcFliVmFQcVlKeWNOaTJEeSsxQXJZTzZS?=
 =?utf-8?B?Y3E3UUxhOU9UVCtxb2RWTDRCRTEvdmowU01wV1NobHYyazNMYWZxZGVoK1JQ?=
 =?utf-8?B?c04xL3NMRG0yUFlLajZzWTNHVEdrdFRmSDNRbTJ4VDNwYUNOcjMyOE9PZ2FU?=
 =?utf-8?B?bnlzMXR2VVJ6UE9Sbm5GQnpvT1Brei8xK3pydEtEbSsxaEJ5Q1Jjd3lxcXl3?=
 =?utf-8?B?SzNsK2huLzlOTWpadGFzQ3N6YW9sRkw4eUtCSk5OeXNPQzJ6ekp3dVU5T1BG?=
 =?utf-8?Q?B5o4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc51614-fc26-4a5e-e512-08dc37d4a2fc
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 20:42:38.8477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ErUlLu5gv2YNW1uQQXugQpWVyJywTRcXnQbMawirFb3AR3FVdbaD/loHcQ/PeJ5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8357

Hi Peter,

On 2/27/24 14:06, Peter Newman wrote:
> Hi Babu,
> 
> On Tue, Feb 27, 2024 at 11:37 AM Moger, Babu <babu.moger@amd.com> wrote:
>> On 2/27/24 12:26, Peter Newman wrote:
>>> On Tue, Feb 27, 2024 at 10:12 AM Moger, Babu <babu.moger@amd.com> wrote:
>>>>
>>>> On 2/26/24 15:20, Reinette Chatre wrote:
>>>>>
>>>>> For example, if I understand correctly, theoretically, when ABMC is enabled then
>>>>> "num_rmids" can be U32_MAX (after a quick look it is not clear to me why r->num_rmid
>>>>> is not unsigned, tbd if number of directories may also be limited by kernfs).
>>>>> User space could theoretically create more monitor groups than the number of
>>>>> rmids that a resource claims to support using current upstream enumeration.
>>>>
>>>> CPU or task association still uses PQR_ASSOC(MSR C8Fh). There are only 11
>>>> bits(depends on specific h/w) to represent RMIDs. So, we cannot create
>>>> more than this limit(r->num_rmid).
>>>>
>>>> In case of ABMC, h/w uses another counter(mbm_assignable_counters) with
>>>> RMID to assign the monitoring. So, assignment limit is
>>>> mbm_assignable_counters. The number of mon groups limit is still r->num_rmid.
>>>
>>> That is not entirely true. As long as you don't need to maintain
>>> bandwidth counts for unassigned monitoring groups, there's no need to
>>> allocate a HW RMID to a monitoring group.
>>
>> We don't need to allocate a h/w counter for unassigned group.
>> My proposal is to allocate h/w counter only if user requests a assignment.
>>  The limit for assigned events at time is mbm_assignable_counters(32 right
>> now).
> 
> I said "RMID", not "counter". The point is, the main purpose served by
> the RMID in an unassigned mongroup is providing a unique value to
> write into the task_struct to indicate group membership.

In case of ABMC, cpu(or task) association still uses RMID value stored in
"struct mongroup" data structure. Same value is written to PQR_ASSOC(MSR
C8Fh). It needs to be a valid value. Hope that make sense.

> 
>>
>>>
>>> In my soft-ABMC prototype, where a limited number of HW RMIDs are
>>> allocated to assigned monitoring groups, I was forced to replace the
>>> HW RMID value stored in the task_struct to a pointer to the struct
>>> mongroup, since the RMID value assigned to the mongroup would
>>> frequently change, resulting in excessive walks down the tasklist to
>>> find all of the tasks using the previous value.

You are using this pointer as unique value. This will work as long as you
are not writing this value to PQR_ASSOC MSR.


>>>
>>> However, the number of hardware monitor group identifiers supported
>>> (i.e., RMID, PARTID:PMG) is usually high enough that I don't think
>>> there's much motivation to support unlimited monitoring groups. In
>>> both soft-RMID and soft-ABMC, I didn't bother supporting more groups
>>> than num_rmids, because the number was large enough.
>>
>> What is soft-ABMC?
> 
> It's the term I'm using to describe[1] the approach of using the
> monitor assignment interface to allocate a small number of RMIDs to
> monitoring groups.
> 
> -Peter
> 
> [1] https://lore.kernel.org/lkml/CALPaoCiRD6j_Rp7ffew+PtGTF4rWDORwbuRQqH2i-cY5SvWQBg@mail.gmail.com/

-- 
Thanks
Babu Moger

