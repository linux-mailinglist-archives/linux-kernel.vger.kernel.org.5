Return-Path: <linux-kernel+bounces-147533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 579838A75E4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B5D41C21362
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330A240877;
	Tue, 16 Apr 2024 20:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SO9uN2hx"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13A217736
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 20:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713300279; cv=fail; b=noWuqdPXGBMZLzyvwZ4QzcS2a5ldWpoiDAPFTWTa+SFDwgkJPCfVsLuJzvWVQ8AuO5/2xjbFOEBCpDEdXqSnKK8UDIevl+38qdsZh4oxrh7pctnB07f54/RyclCSHkw/b3s2bXldy97qksenDWX2nQwYjORKuGk8mJ7sWN9RQIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713300279; c=relaxed/simple;
	bh=qhR0odIS6L3+BKXONOGnzImPr2sytgv7l77Q+vbh7a0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GBuLEy2zNiXWXvLWymIslLefv2egOek+7XlWZCtbUZnTEOSXHKzA/AQQbkFj6rLWcGReQvGKYkY6I+/hkh8bOE0WWrHieWx4YnQNqdeBjyabyZkVKQpeSzbFgzHowtGPVynQnsSvlSCeidFcaVWQ8MEqEuPW8fKu+Ib6y+R5qf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SO9uN2hx; arc=fail smtp.client-ip=40.107.95.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UIN+npd7PVdzL2HPx3glglPNh2WMbZewTaKxiFwY61qxkf3et0Rp7h4o76GEdGWZx/11WLplkGLRZH+ID+Xxp2XaIrHENX0MzLvkN+mWw3JvKle2Zhihfs4v2+31cPazDyAAeDsmUCEkhAGhRbiUhr4Ducb8P7QmCDk6iCS6vX0duiyX1W7wgkL20uCfJV3OF68VRBHUgyPrwjDYRfJyng6zS/7HEqfZEFyttY/80o6AiI7MkrhzCP/z0jm8udVvgfkb9X01/ci5RewfeVTcsa7apFKtkAGVBShtLKoab97gTQawLke7BAUA0b3Gt/bLcu7YSmjzLz4Gtm8De/MVig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/39lth5wRFzpVjijVlcOvaecBOQx6eB1LDmnPTtmLGw=;
 b=KGW/ZewwtznV5Rnf0S9mpaAMVhwoRSzPlXEElTGQ1qlaDLRKZ+pOClv31DdQRlBm8Nofi+sTt8OXu9Mwz6o+VLyoOrsfga+Jiy09R8k8MLXzixIS57MhLE17BqGmg9q1vlklsesiebPtaCiQTei0ERvAOWy/zSl40XcTQ0/9LWV30NKxAy7vgHqhHpT/Lh6L44EiwaZN8gE5ftsLCk1yAPFbK6ZR3NwvUvu0hNHekodwDP/2OwH11NqIBJB5NwTz3zoN0M6EWbBg6mEWdBRzWlzzEvgjPsFRFgr0+MzGLOrc0YUmYYEmPCUvBVUFBCYk1WDT4uCm7NbM12OKPMmeEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/39lth5wRFzpVjijVlcOvaecBOQx6eB1LDmnPTtmLGw=;
 b=SO9uN2hxpI6IHIIp75c+h4A33h1o9qFIb6v2tszQQINjk5AWcy4GPN2i83I3BKTfhdwlHqFdnsl29Zrt+yN6ipsEc79lDxwqlqxF923lUt5zh5Wx+sYufFFTbb9wMeN9x8K6EcS/BsmG1V86puLSDUDOE623pJRRa8mzfW9ZO48=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM4PR12MB6205.namprd12.prod.outlook.com (2603:10b6:8:a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 20:44:34 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57f3:51f5:d039:ed24]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57f3:51f5:d039:ed24%5]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 20:44:33 +0000
Message-ID: <f4265c87-4f57-46fe-bb1d-b4d1ce3df06f@amd.com>
Date: Tue, 16 Apr 2024 15:44:29 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v1 02/31] x86/resctrl: Add a helper to avoid reaching into
 the arch code resource list
To: Dave Martin <Dave.Martin@arm.com>
Cc: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-3-james.morse@arm.com>
 <0790c576-944a-45f8-bc43-01eb0a8f67a9@amd.com>
 <Zh6kDStUw8AThV4s@e133380.arm.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <Zh6kDStUw8AThV4s@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0075.namprd12.prod.outlook.com
 (2603:10b6:802:20::46) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM4PR12MB6205:EE_
X-MS-Office365-Filtering-Correlation-Id: d9e4215e-a99c-409c-1746-08dc5e560556
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yDfbNscSGLyI2EqP1lO1MKEgqRelpKJgDt2UpGoKaDTJko2KVt9uqDaFjFpJsuahq5kRAe3fh0dXcLhrVZEr58rg9YmtCLXTXxvRBqrUYGh1eiR/+C24/BJqSCZvefXgT2Ni/weucCeyGicmcnKsW2tDhKsxR0JSznuU8NSFJaUMdqTIy+wl2oEENQuieGoOb6RFTIiyQfNp1hfEbWM9TipAb/lDzq7MbOMg/dTwbDzXjwbRNgzKGLsDEjbmuKTVLmUNlFT78t7YMxWI+KBFWKi41WzuGrCmNamSgG7zQ+VfVZ9TQaW1dPbEG7GlwTcOGQtN0s7RpmeYWIvSd3W+q6DBj7U/mI9n5sUEqq0W/pFSgKLCMh523107LqajcHfYONUFG8uWHV/eBebSlML8OC9eHkf8oPw9zf5PEKc86MSYkvf3gJrLmgCH6KH1se9uEctBdtK9ptH9DffYMsGVASiZ+0DS5JCz6jxcfFR6qMsiEDf0gSsA/fumWlIwsJaeVV6Qg2V+FXTpnUzb38VF120NTLCEfE3+1zoSIJaaDyO60amRAD1itRBcs0FINw45iBR3LsvkE3q3c/9SYvdHEXXA9LBTy1bty68KrScrp8IUGnOOON4CCRx7O7X/zt6VSB3E395qhWgWiGCK5nX7gFE9GMuzvjnoTbBBUQrm9QI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFErTDF4Q29VdUIxcGM2Q0RhU0p6QmNubEJEdklsUzhEWE9WVVJ6MTNrTTVp?=
 =?utf-8?B?NEw2TE9NRjJJQU9KWE9Ga2l1d0c5MHRFOTROYmZDMUVTblZOSlAyL3ZkR0E5?=
 =?utf-8?B?MUJRNUphSkRIaFBRalJSZUhWTDREbXczUGdlRW91bFRSUGE3NUg0ZVZNMGpJ?=
 =?utf-8?B?T29ud1cxRTRsS0tENFY4UnpELzdrZTFaQ3c3by9pekNJQXpNa3oyK1lRNnI2?=
 =?utf-8?B?dlZDbUQvOTRaZTdXQlZHUXZXcmdzbzAwbkt3WXR1SVBSd0V2MWVNSFZxcHlT?=
 =?utf-8?B?VUE4QVR4c1FpWTRydUt1cTdPOGl5aytQWTVYWnl6N2czaStYRE5vSytucjhP?=
 =?utf-8?B?cHlmMTk2NU1MQnI5S3Y1eEV2QlcyYy9YZHd6QTlPQjQvVUcyMzlITUg5aVJS?=
 =?utf-8?B?OTBvQVBrV0ZOT1ZWYjllUXFsWE4ydzR0YWR3eHl0M013Z2Z1OFBSK2l6NytY?=
 =?utf-8?B?U2ExdUVOTGFWR2REc1daNWFzVVJ2dzNYaUQ3OHFWNFlPN1FrYXphUkF0cFp3?=
 =?utf-8?B?VFJobldHYkZnUDFFQjhpSXBQajZtM2E1djQ2NU50ZXd3a09BWi9JaFVSY1Ix?=
 =?utf-8?B?SlJpRDF3aHJjZm9HYTRMZDNKenpqdU1xY3AveXkvYzE4TnhHeDJpQURMaDZZ?=
 =?utf-8?B?MlI1ZDcxeHBYNVdNaFFhRTIvSk1ReEtPYlVaTkx1MkgyaWxzU1lKWnZGN0R5?=
 =?utf-8?B?RW9MdWNOUTJldXhuaWlHV0Q1M1FuYVp0TGZyMUpmQjN5cHBUQ3htQk1NMity?=
 =?utf-8?B?S05UcldETjNMUDhKVi9zK2JaKzFWOUtmZHQ0eU9wZjJDYWI5Y1EySTdCZFVm?=
 =?utf-8?B?UENQNko3UlJ0RVkyWlUyWnUrUnVvbStxRFB4aFV2R3dtS1BUQ0NzL3ZFZ1FE?=
 =?utf-8?B?Q0NFYmhYZmNBNWtOMmlnUVVyb1BHaDA5V3lsNzRhdGxjZTFXU3dYM2F4U1Bx?=
 =?utf-8?B?aEtSdGxCSXpTUHRzYnUvK29Oby8xQUxoRzJ1RXkvMWozZGhkb0ZBVEM4KzB2?=
 =?utf-8?B?Qis0dzQ1ZjlFT1ZoRUsyNXVGbDk4cnlLWmFJcjBIaUNNMHFmMzF3czBkV0pC?=
 =?utf-8?B?RXJ0WUtWRXRCM3BXd2dLS2Q5SkRLQjBhcjNhYU9vRWNOeWp1T1VrUHRwQVhL?=
 =?utf-8?B?dzVIYkpLSm5GOVdGNEQ0c0xhL0Y4eFoyMzdyemEzTzhkYk1ZZVhjcXUwQjU4?=
 =?utf-8?B?bjE5Q0QxcGl4RXM4bWxVeURQU3NRQUY3Mm5NY1I3cTRKeStPbW5jbzlvR1o1?=
 =?utf-8?B?bDlFWkZQakxmdkd3ejFyVE1QK25MUnI0LzlYM24yWUo2TWt6eXZRNWdDbE42?=
 =?utf-8?B?NzIrT2NFODFLT0x5V0o2cktuNFRCMHBhSWtGOGNmblpiNk1zbEFUY01VaXdP?=
 =?utf-8?B?dTdTbmQ4aVlQOGJCT2E0WFBQZnZPNXR3RVBWMWRLVlhuRmhxTlF6RGhEUjlw?=
 =?utf-8?B?eDNIMXhVZ3RheTRRUlVoQS8xRmFzSUt5YTMwY1RqWUdMaGNTMk9SelM5ZEp4?=
 =?utf-8?B?aFcxRlhrbUtZdENZNE1sTUFZczlkUkxWVXV5ODFtMjAwbnpPTis4OHNzamtv?=
 =?utf-8?B?T1htVkIrQUM3Skg1ci8xZ1JhK0lCdHJkWEdSNTVEdlNTdDhpZ2dDOU5OV1pK?=
 =?utf-8?B?aU1WaHpIWDMxczBuT2FzdmVnNGZKL1ZwN080dEFUMjlIS3RncGpFQVdlMGlB?=
 =?utf-8?B?dThPbjNHS3NCOFplVjNrZHk0dXJnRDFDcnEwdFgweEEvUWl6THJndDUyR3lp?=
 =?utf-8?B?dXBrbVBDMmZxckZNSmc3YS9vUEJqUjIvNi9zUSszclB2NitsOElGQ0hHbUhT?=
 =?utf-8?B?VEUyNDZidTBpS0R0ajBJVHhqbUxZcDY0QVc3VWd5UFovdldoWDlwRUlTcjRp?=
 =?utf-8?B?RmhoYnpxUnVrakJLUlVjVFZLR2c2a2dIWDRlT05ucXJUUCtlOVYram5reGg5?=
 =?utf-8?B?ZlR5a2ZQRHBXVkJPd0FvMCt1TnNBSlhYaFRXamNRQ2k4YThWZHFaWTFPa1ZN?=
 =?utf-8?B?T0dhZEhRdEJZT2ppR1V2NlBzK2R5K3ZCcDczeDJMbE1uRkRhRlR4THEvS3R1?=
 =?utf-8?B?TmJZMDVSSWZBdHlTelN6dlVSd1d2enI5NlkrSHBGTytPVkxreWFEd0d5MElX?=
 =?utf-8?Q?hSVA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e4215e-a99c-409c-1746-08dc5e560556
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 20:44:33.1016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oFuKL067VbrqU7vWJrHi2X45qP0QSoqgF37Uaw2c4sYv3G9u8psGEt6b8mSg4tYD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6205

Hi Dave,

On 4/16/24 11:15, Dave Martin wrote:
> On Mon, Apr 15, 2024 at 03:28:18PM -0500, Moger, Babu wrote:
>> Hi James/Dave,
>>
>> On 3/21/24 11:50, James Morse wrote:
>>> Resctrl occasionally wants to know something about a specific resource,
>>> in these cases it reaches into the arch code's rdt_resources_all[]
>>> array.
>>>
>>> Once the filesystem parts of resctrl are moved to /fs/, this means it
>>> will need visibility of the architecture specific struct
>>> resctrl_hw_resource definition, and the array of all resources.
>>> All architectures would also need a r_resctrl member in this struct.
>>>
>>> Instead, abstract this via a helper to allow architectures to do
>>> different things here. Move the level enum to the resctrl header and
>>> add a helper to retrieve the struct rdt_resource by 'rid'.
>>>
>>> resctrl_arch_get_resource() should not return NULL for any value in
>>> the enum, it may instead return a dummy resource that is
>>> !alloc_enabled && !mon_enabled.
>>
>> Nit.
>> You may want to drop the second half of the statement. We don't have a
>> dummy resource.
> 
> I guess not, but MPAM will, although I haven't fully understood the
> logic.  See:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/tree/drivers/platform/mpam/mpam_resctrl.c?h=mpam/snapshot/v6.7-rc2
> 
> (Search for "dummy".)
> 
> 
> In any case, the statement above is part of the definition of the new
> interface: the resctrl core code is going to explicitly need to cope
> with a dummy resource being returned, and the arch code is required
> to return a pointer to something and not NULL.
> 
> So I would say that it is appropriate (or, at the very least, harmless)
> to keep that statement here?

Ok. fine.
> 
>>
>>>
>>> Signed-off-by: James Morse <james.morse@arm.com>
>>> ---
>>>  arch/x86/kernel/cpu/resctrl/core.c        | 10 +++++++++-
>>>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  2 +-
>>>  arch/x86/kernel/cpu/resctrl/internal.h    | 10 ----------
>>>  arch/x86/kernel/cpu/resctrl/monitor.c     |  8 ++++----
>>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 15 +++++++--------
>>>  include/linux/resctrl.h                   | 17 +++++++++++++++++
>>>  6 files changed, 38 insertions(+), 24 deletions(-)
>>>
> 
> [...]
> 
>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> index 1767c1affa60..45372b6a6215 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> 
> [...]
> 
>>> @@ -2625,10 +2625,10 @@ static void schemata_list_destroy(void)
>>>  
>>>  static int rdt_get_tree(struct fs_context *fc)
>>>  {
>>> +	struct rdt_resource *l3 = resctrl_arch_get_resource(RDT_RESOURCE_L3);
>>
>> Its is probably best to keep the resource name as r here to be consistent
>> with other changes.
>>
>>>  	struct rdt_fs_context *ctx = rdt_fc2context(fc);
>>>  	unsigned long flags = RFTYPE_CTRL_BASE;
>>>  	struct rdt_domain *dom;
>>> -	struct rdt_resource *r;
>>>  	int ret;
>>>  
>>>  	cpus_read_lock();
>>> @@ -2701,8 +2701,7 @@ static int rdt_get_tree(struct fs_context *fc)
>>>  		resctrl_mounted = true;
>>>  
>>>  	if (is_mbm_enabled()) {
>>> -		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>>> -		list_for_each_entry(dom, &r->domains, list)
>>> +		list_for_each_entry(dom, &l3->domains, list)
>>>  			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL,
>>>  						   RESCTRL_PICK_ANY_CPU);
>>>  	}
>>> @@ -3878,7 +3877,7 @@ static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *kf)
> 
> [...]
> 
>> Thanks
>> Babu Moger
> 
> [...]
> 
> Yes, this does look a bit odd.
> 
> This looks like a no-op change to me -- I think that
> resctrl_arch_get_resource() is supposed to be without side-effects,
> so I would have expected this to be a one-line change at the assignment
> to r, with no particular need for renaming r.
> 
> Does that make sense to you, or is there some complexity I'm not
> noticing here?

No other complexity..  Just keep the variable name as r.

struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);

-- 
Thanks
Babu Moger

