Return-Path: <linux-kernel+bounces-126982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C48B89455F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF2501C21818
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E163E51C52;
	Mon,  1 Apr 2024 19:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aVqP8prO"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5F922085
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 19:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711999046; cv=fail; b=M2T3T0ZETsy+/JoYbqqmXgAr1uP9pR9wINUlBQOXMN5DXbXXTpCQ84JH0t06r3IDNjNIldlrVDZa4nZB5bv+AgBNDW9FffSoRrIt2Mn84nZ0BEWaBfod4q3ldZTp2qW7GRnT91vQ8111QiwLoHeieYIqzz0Q4E7Nmewnf0VoL3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711999046; c=relaxed/simple;
	bh=i6jefUUzPO1c9dLjKq1/Zg346XzS+tkJvt9abmrG4Rc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z5t1acw6JEggWpiMdU5q7CFY6qIpzkwYGwKV6P0SraRLGItFv9kLOw/bY+GXaUxhREF/i6H/AVuxg0oKRLwwqf057NH6pOPhPN3w9dZ3GjzeX6zpQZPgs1P/WgOB1u5gmC/3m6/8nOhpPrzPbhRDk65YdWXWWhRll6i2m10J+mQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aVqP8prO; arc=fail smtp.client-ip=40.107.236.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2SgYYspai/1fvPEJb4zl3D2qeeHSNJCGqS9F5nYdpBy/92v3Dje+skDva7KdtdZ15KxT/sNOZQNVobpiBzxYy+KoGIV7RXylGET/u6ILSre1vpo8sOyBXItJkOSoYvKBXDUhodGcvnzRp+Q9yvyPWfiEexIOp+IWsfpzFQGs06aeZP1BnTPxAZb91U+oYyLSN120drlBJuLw6PbPkVJIIdRtzvu3ET6cRMJZjRvkHiRdt9P0sm4JAs0kwpxhmRsBrqIEFIiTEVN3GAwRMq0nlD+D2AHSftqMIu4Cteo0Q7ydsTFkii1XGQ3NRlhUnvD9rmayGsn65euV16/mFwsGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yy9t0CI9CiKmFBNWwR5TCXCJ2e5w1kKRhnf+uG/QpAs=;
 b=kxww5GKFjvIkuYFWXn0g3vfshhp4w00oaFzWVjzb5ekEsNkLWfUtyvxBwHEJwlBh8I5zWZ3VJOXrR1CnBSA24/Sse7EE2V9+s8i5WeG7nwIDKt4tIuqbTjwymvBVAG1WplMk6WwZse0Rx6UCRAY6HgySjKaNiRioX6qlms3A/2veF3FIxerECYVaO3vnvo6xt49wsSxCRp6TfekWi5ZivIhWZMPdusgC9d8EyCnEmvz/gEWvgt0tcjDr1NEQxsWnZmZ1K3KM2V7XSrEFiyx2+pKOGb+RoaaiqjVkb5Rhv6ZNVISJVd+Ufw/u7BeNJlIpvg/UP068rTXeuBmPOAavgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yy9t0CI9CiKmFBNWwR5TCXCJ2e5w1kKRhnf+uG/QpAs=;
 b=aVqP8prOQShTHpoPB/jZMMrBmwBIOL57kHbEXYpm/ktnfTIKBWvB6JrmOGNDnKkAK9To964eJ1BZaYfJZ2Rw7OJx+mKCTl6rH9jDqZpek0IoYd/ns/0O6M/T1PxoesCtmbInd8Q06ieoM153xA48IJrnd0DbDVqOn8BF+00OWZE=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS0PR12MB7746.namprd12.prod.outlook.com (2603:10b6:8:135::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 19:17:21 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57f3:51f5:d039:ed24]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57f3:51f5:d039:ed24%5]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 19:17:21 +0000
Message-ID: <73122f30-44b9-4868-958c-99218e5c1185@amd.com>
Date: Mon, 1 Apr 2024 14:17:18 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH] x86/resctrl: Fix uninitialized memory read when last CPU
 of domain goes offline
To: Reinette Chatre <reinette.chatre@intel.com>, fenghua.yu@intel.com,
 bp@alien8.de, james.morse@arm.com, tony.luck@intel.com,
 peternewman@google.com, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org
Cc: hpa@zytor.com, james.greenhalgh@arm.com, linux-kernel@vger.kernel.org
References: <979cfd9522021aa6001f8995cd36fb56e1c9cd39.1711659804.git.reinette.chatre@intel.com>
 <133312c4-6ddb-4752-a7fa-3e7e526e9335@amd.com>
 <ea8ef700-daf2-4408-888f-f5c93db82331@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <ea8ef700-daf2-4408-888f-f5c93db82331@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR18CA0020.namprd18.prod.outlook.com
 (2603:10b6:806:f3::14) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS0PR12MB7746:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rKFedIsiQ9tqgRbMtqPvVDeWNgYEzAJ5nkM4Lladuo2qPKQSPqS4YcY28f5vp2LxMzjfXnMC0DbQe9g7btoMxSNU1mUHIPP5h1CZ+FOAXlcditvDLEmpRe4kyXLBA4DNafuEJTGeYhhoJksXYT6CqzuL/ESDntmjsez5LCa6z2NdAfse1lFedRHPX47U/76SrY7lfNZ/QZhZ2HaIIQpWMX57eiz5MUwIssDdFxqPIZ+xdNzRragJ8t15jvcUq8m3cHMrS03CgcLMblCrenhn+oZoFLZVW/2wUqk5BnJ6u1TTdmnZiFwfFHFQ0YOM0MNYykY7JwVbrZ0iHWstNVTlug0eTWlYEwArordoFtIvKcWsR7dT6EjJzUEwwFgOi3c9gPk+I3YQm9SwiskDjmFvTRsTSe3VbgZz+suFvEMgGBUEa/zEnX6Wj5QT4Qyc9MVB+DmiIzEXRdb1eRskXnxD0qFwyjCcjjjdvbdD33IYnmVikrFRjEo4kTu7lDqkwXLErkuOfhcSLzilmYrQeI3bvJEw2jBQvjb7ndssX9Byq+6gPtTux9fi6UrSc5yaX/8YFUwF11IvxucSMQeDZM3Rb4oYDQO/0a4mqKrJJBYweJa0+ecap8po8YJaXwE0Zsul5lRIWB1FO/HRxwlE8XMuaA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEFnUncvUi91YUNqREZ4UmRRN2hrbkZxRWVxaTFmM242YzVEZ0ppTGJ4dGRT?=
 =?utf-8?B?ZEpFVmxZc2t3SnhGN25Yd2NmankweURVVjNxeTJqT21WTUxHRERZVitGbG1D?=
 =?utf-8?B?bElvRWtoOS9qTXVqRnpoaXIvZFBuRXd1aEp1Z2hiQTdNRkN2RTBTV1BLZVkr?=
 =?utf-8?B?S2ZVckt3a3ZQL2hCVlBaNUlreDdzWDlXbHo3R0xXVHIxR29kTTlxNlNqbmlI?=
 =?utf-8?B?NU1NTzlBNkI0NURzSEVlZ0lQK2dHM3hQSGlvTzRSN3JLa2xoak9MelVxUU5h?=
 =?utf-8?B?ZEFpaUMyOWhlYVVhZk1WVDltMUZuenk1bXQ4R0pFUXBiOVU2MHFacU5DZlU0?=
 =?utf-8?B?ckFYaEM5TExLWlVhVGxoYlpKT2IvRXVteHc4ajM5UXEwazc0NlBmekplem81?=
 =?utf-8?B?cjJKRmdvZXNMbVVvTFZIZWVsT0ROWEYwd3B5MDRpbmc5ZEVUa1QrdGJJUys0?=
 =?utf-8?B?T1Zydk9qdlgwTnZMK2JFbEowSERXZmhiQWNCRlVUNmN2VGZEbitWbkxWQkxB?=
 =?utf-8?B?SWpiZ2Fxd3cxSC9rVDM2cklHOWpTa2J4eXd2YTgyR2hHcWdUNkQ2UlJuOVFt?=
 =?utf-8?B?dVJxOWRRRjhqRS9wTWR5aG9QM3l1SDRHUHpSYmE2U1ZJaTI4WFZiUElOQXRU?=
 =?utf-8?B?K0kyNW44WTYreHhTanFIMkw1K1hESWYxWGpmYUZCSjQ3TUVZaTZlTmJoZ3ho?=
 =?utf-8?B?eGY3YUdLNVFEVkFMeVdJTm52amhkQ05tMUtlc2tqU0twRUZIME5Sa2FDWktT?=
 =?utf-8?B?N0Q0V2NnMEdvN2N5bEEzaXIxZjExeUYrUFRMWCtTQXdmUXdVd1ViNVFYYWRl?=
 =?utf-8?B?OVZvL2ozVWRWbTFJSlZMZ2VmT2dVcGVrU2FhUDZyRHNabW5NcFYvOW1HUzdD?=
 =?utf-8?B?dnA3bVZuNCtQVjc0R0YxQVNOUWhrNTY1Vi9TNVBvTkpsMkpwRFRiS1RPTUpV?=
 =?utf-8?B?TlBHRjBabEZOcHFnTU5aSXlGSHlvemd2d1IwTXEwU2dGajVwSHlLUHRZSzdo?=
 =?utf-8?B?SUlaNVhWQnB3YTQ5QXlEOHkyZ3pPdzZNWFB6UFJjZjZVcWNMZzNScXY2aktn?=
 =?utf-8?B?dk5NS0VubE5xcVFpTHJ6MythbWVzbWVidnZ1enJ5U1Z2KzcwcVljKy80bkx4?=
 =?utf-8?B?QmtZT2RuQ2JYSW5UekdNWHV1RGw5aVdMQnVSUTU0WG1RNFRTYXJFSWQ1Z2ND?=
 =?utf-8?B?L0hUK2I0QlAzZDAvTkU5S1lKdE9uM2lZMW5MYzFJdzF1K1Q3dkp1MCsvTVZJ?=
 =?utf-8?B?UXNzd1orTlpaWjdHY0VYUnJLbFh3V0M3blZjM2FnZ2NCQzZoSmZLQWhNQWM3?=
 =?utf-8?B?WjIvMUM1L0FvTzZtSUsydklER0o4ZTdlK0MyM1QwVzhpc05wNTQ1ejJYdUZ4?=
 =?utf-8?B?bkxhTEE1eFhDcm5IOENiN3R2SkdLcEFNOUJGeW9WaWZqaVpIS0JqWjUzb3Fh?=
 =?utf-8?B?V3p1bkl5eWRoZmhteHdiOFNHTm55ajgwZjQ4V2ZNOGh4aWtpbkxib2RheGlB?=
 =?utf-8?B?Rm9MdEdldDg3YTRXcmN4OCttdzBaUlB5OVBGZWxrUStVNUtzRGdBRnFMMHNo?=
 =?utf-8?B?OG9JQ29GdjNsczhxTTF3UkdsUlN4YmhKcHBIWjk1azVGQjRZZU4wbnBEYXI5?=
 =?utf-8?B?VGRIWGhrTE81T1VCdnRMNHA5aVlXeittN2tCekxrc0xQcGFpbjRuaE5BVVdu?=
 =?utf-8?B?SXNVWGlPRWVjZmQ5VEpBV2hrVmozUElDVkIyU1BSOEc1RlFiZjlWNnFxTFpl?=
 =?utf-8?B?OVdydEwwS3piUmJna3NMenVldko4TGdCUkJIQkswM2paQ1JudGRMZFVvNXRJ?=
 =?utf-8?B?WnhBRW1WVEF1NFB6eFVMUjdtb041akVmd0t4U1I2c2tGSk42QmJic1lZNFlM?=
 =?utf-8?B?U3REZUEvUmlnRkVrbjlkaGhZRis5ZGtMWVVpcndCT3E1RkhTNmR0M0dCSGlJ?=
 =?utf-8?B?R2tHZUkxR2s0TGhkQkUyTDFGRnFpSWdCUGRLL0tFS1JoMW40RGpTUDd4Njdr?=
 =?utf-8?B?RzE4c1hhNXZ6NjJ1Q3MrR2wwem9idXlQc1VpQWV0TlV4UzZwZzl6bkVGdU8x?=
 =?utf-8?B?VHFiQkV4VFBycXorOEdwUkt5VmNpbDFUWHlWQmNOQVljdWtReVFjcDhDYjdI?=
 =?utf-8?Q?jmfc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d050b3-e06a-46d9-6b4c-08dc52805af2
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 19:17:21.6570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+QpI+wQ99SkGFFY2AbWWTuZFDAjzolLio8Nt4/jgUy2s3u94RRElGvi2VEJjc+f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7746



On 4/1/24 13:12, Reinette Chatre wrote:
> Hi Babu,
> 
> On 4/1/2024 10:57 AM, Moger, Babu wrote:
>> On 3/28/24 16:12, Reinette Chatre wrote:
> 
>>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>>> @@ -85,6 +85,10 @@ cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
>>>  	if (cpu < nr_cpu_ids && !tick_nohz_full_cpu(cpu))
>>>  		return cpu;
>>>  
>>> +	/* Only continue if tick_nohz_full_mask has been initialized. */
>>> +	if (!tick_nohz_full_enabled())
>>> +		return cpu;
>>> +
>>
>> I am curious why this below check didn't fail?
>>
>> if (cpu < nr_cpu_ids && !tick_nohz_full_cpu(cpu))
>>   		return cpu;
>>
>> The tick_nohz_full_cpu() already checks tick_nohz_full_enabled().
>>
>> It should returned 'false' and  returned cpu already.
>>
>> Did i miss something?
>>
> 
> The scenario occurs when the last CPU of a domain goes offline and the cpu itself
> is the cpu to be excluded. In this scenario cpu >= nr_cpu_ids in the check you
> quote.
> 
> You may, as did I, wonder why continue the check on a smaller set of CPUs
> if the first check already failed? James addressed that in:
> https://lore.kernel.org/lkml/bd8a64fa-86d3-4417-a570-36469330508f@arm.com/
> 

Got it.
-- 
Thanks
Babu Moger

