Return-Path: <linux-kernel+bounces-50627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A09E5847BEA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56E3328A59D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D999883A0D;
	Fri,  2 Feb 2024 21:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5ZEYTGMx"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2079.outbound.protection.outlook.com [40.107.96.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB421839F9;
	Fri,  2 Feb 2024 21:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706911085; cv=fail; b=BEcfCe9WtDRBuuC5Q8BHiSYcF/cg4Rp3PkC+fbew3wcqF3OCdlQbFIPUdeMHvPe3/sp7qpQC9pNytgyiZVTGGCxpbb7V2wOuEEbhvhHSW2ixuSIo5JjT8WbNJTkiMdWU0WIIFq14R/d+MduEqFmKHoWCGia0uRrFXowzrDn9778=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706911085; c=relaxed/simple;
	bh=PRuwYdySO4dZ3eZdnsjiCcCRNe9Q1hIgN43LSoELcTA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ouVGd7XmB52bc38YddyyS0vFPRopcqz0wIDokXkFyQFytNLz0rl/xZAhYyV83Rkd4NTxQjWJ6RPr+QKvvHsTD/0RtQFDfaVZt2MQPX41dBCFhG7pBQyoSc+jdmeE8Qjsx8tpyJUp6jealJdznd1MoSC05zuXqbq6G4MPSfz6Pbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5ZEYTGMx; arc=fail smtp.client-ip=40.107.96.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXMuRQmxgCwMGoTxboS9J4bL+NiH9ZuF3VB6rYROwuSAu9zj0egGc+1By5Tp5ZYfUODUvZ1aBLpv2JLOUpd6h/tKdFDRvXJfN69wRUfX8rjjZCIe0Mx++PwRU67Z31HrV5SJ8iTuebEr+Eari+kAllFKDFP3K2x14+dEIsdByLMp6Vg28luh8LNW+JA4g1aJqjmqSjdr6b3L0RWl0oLA5JPj1BSDhY+yKKzdwts/cf0zbh1VNF+9q0yfi18qQx8kYU/NzRWVGw33ULV+1K30ewvDTSi9TxyCeaxDj1PjLJAm2q63YEZTameNmh+uQdJELVOuFa3Uemv0RjwsLs4fmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIfnouJu0qlsbUU3n4fwJ0WUUVl/U6tt7slr+EROyGQ=;
 b=mo5kxeGel4znYjCObt6hsiyCwQznipLN97OyCZSbAp78wgS5/ihyROUnWYv130ZGVzKXn33uquMUeRT1iSu0SxseFhR/r7FZ5wU0bQuUOo4Xw+rn/E//i8U51Ph4gudezkqxonAXrRkBB5HrjRxvh7RL5ygQJMrWlu2wOILMixjTp3pSahKZAUIlKqx0FVqbHmCyzRYRrNFDeXcH+9Umj8aUE5kn7mFXyp5dbBcRxDQWi9sq2cph90D0V/YmY6WXoeH+OU5Bp//hOm7dvKXQbarr6CKJY/22UI/vN0LTlC5o6FS3Un0LFzKGGyKSbvL0vBBQ/cxAR+vd0RO1kUuPvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIfnouJu0qlsbUU3n4fwJ0WUUVl/U6tt7slr+EROyGQ=;
 b=5ZEYTGMxeFlhcldWQhjXuqjdpByjjuBOxxF+hHQIm72xtFnbhE5sx5AqDNiieosBgMUO3Dyr7Gwip/I/YkFtbkf72qy8In4BD5Sp+sWZrDClz3ooyPMpFvstQ5N2MioBIHyWF2rNuaB+k48B1mZ7LZSHucesb45gFngI1KBO+tU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH2PR12MB4214.namprd12.prod.outlook.com (2603:10b6:610:aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.12; Fri, 2 Feb
 2024 21:58:00 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f1ae:6833:99e2:9dd4]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f1ae:6833:99e2:9dd4%7]) with mapi id 15.20.7249.024; Fri, 2 Feb 2024
 21:58:00 +0000
Message-ID: <431d6ac4-53cb-2f73-3cda-22616df2f96a@amd.com>
Date: Fri, 2 Feb 2024 15:57:51 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v2 00/17] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, corbet@lwn.net, fenghua.yu@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com,
 "james.morse@arm.com" <james.morse@arm.com>
References: <20231201005720.235639-1-babu.moger@amd.com>
 <cover.1705688538.git.babu.moger@amd.com>
 <7c26af23-fa1e-4e01-8088-8fbd9be3d6f3@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <7c26af23-fa1e-4e01-8088-8fbd9be3d6f3@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR04CA0106.namprd04.prod.outlook.com
 (2603:10b6:805:f2::47) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH2PR12MB4214:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a76b669-e125-4c2b-c4a8-08dc243a05cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	p7lG7y2FyXTeYnJcw4qZevEmXRVOfYZbMrt95AH1q8XgUdt4lcSgX3oOiE/jFtquUjdq9dWOaQw0aw1DPOnuYso0U064iZocfgl5o5NzEU4rjhpm7KXwASkqwN0J+vTlKNYZZMyskHqqaD7xREZCAzKhiTs0cKUdNmsXWA3No7k7ZzaVPPJAEioJ+rUAx907ef4ln7q5iK5KHLl2pnFwvNMlVeE0VVjHBdGsOFMLmt/D1Hva1MPD7s0atrura/RpZJS+BpX/RDPTQocAqTH/IV3ayQ1L+0Bvg6jCNsyigX9o1ywt/9GIfuY1GiSPIurIJK1Jey8CwGE7kzyz0ib5U5VyLXScbVc9hxWUs0aD70rabqmXRRKPtVGgIBk85jzIpa+F02B0dOQEynKxB9KOApXeNzp1wjdUYaVbG1VggcyB4g/DWfbwiMuO62oEIDo37SXVk49X9zcNNH9bl6IWT0wCzcTFxcdpkPiN3+iq0mj+8bYHLllLZLhBxza+6/GxZ2NURAari4BJfVr3dLevZdcBWB2q8em53BDXyWyCLQp5APQTGnPTcnXwvpwaHhyog7bAQZJFj4ekJNQ8wlg/ii2VRokveHGB4Oh8z/AwhNUVmZ8kcYIEhUZ8RGyGB3PGDgKrGb4ArCYfuVDhBI2noA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(346002)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(83380400001)(6512007)(5660300002)(41300700001)(7416002)(7406005)(6506007)(6666004)(53546011)(2616005)(31686004)(38100700002)(31696002)(66946007)(4326008)(8936002)(8676002)(36756003)(66556008)(66476007)(110136005)(478600001)(6486002)(966005)(316002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmNsVXpLQVc3Zldlb1dqRkpqQjVuZ21FTkhoc0F3YnQ2ZFRML0NzMld6UTJK?=
 =?utf-8?B?NW5xVFZXR0hITWlGeStleFlTeld1eHJQdnYwWlY1d0lSUTJaRC9GK2E1RWI1?=
 =?utf-8?B?dCtYQkxNWGZuMlhGZFBwUmJpRVRvbGtIaWF4WkE2Yjc4QzFiZ2hjQ3o1a054?=
 =?utf-8?B?cVk0Nlp6NlJzUVAwSnFRamx6aEJXT1doOWwyVmN6OWJYbzZXb2tMUXNwcjlC?=
 =?utf-8?B?QVZvbWxYTWFTWnlFZmc2MXROdGxnUTFyMXJ0YTZURHdJV3hTbnlVZEg1VTIv?=
 =?utf-8?B?QzNRaW94b0FJVVJmK2hCdFFjZjhVWUw5dElXQjlJTzZ0bXViWXowc3N4SzBx?=
 =?utf-8?B?MlYrcEp6dE40TnhocWJ5U25oOUNHb1VocGI3S2RtbGRJTHVUcmh5WVRORHhH?=
 =?utf-8?B?Q2lqNEtiMk1MRFhvZ1BZb0xqS2VBdEYvNWJacC8rSldjY2xyU1E1TC85K09k?=
 =?utf-8?B?Y0JVMW5qMjZiMW5NbXkzMmhuQityRGhmR1dWSUJ6OW10OWJjcmRzbW93Y2hw?=
 =?utf-8?B?V0RIQnVzZFFockw5Lyt3Wis5U09yc25ZY1QrQUsxcWREOUF1Y0NMQUxtT2lx?=
 =?utf-8?B?SFBiZzdMWk5pcEJ1QndEb2ZhcTYxNVpHcFYvWTErQ1N5dUpFVTF4M3dyVXdy?=
 =?utf-8?B?d0FnSTFISUltendURU80MzExY1UwWGlxSlJKNS9BV2lMeHBmRU9KNkFseHNV?=
 =?utf-8?B?MFRrTkhWR1VSR0ZZTnE5YmkySVZQT0VyQ2dwa1pQd3ZjQkVBejFVMjV3dTM1?=
 =?utf-8?B?bUNmQ1hvdkRmN2tWdytoeVovVDZ2SlhrWU5KSGpNaTMwVGZsd0FmWTMxb05S?=
 =?utf-8?B?dXZRSkVpaUFJSzBTaFRwTmpOQy9yN3cxRjlkdVRtdU9obU01YUZGRktYZENq?=
 =?utf-8?B?K0ExV2l3UDY5T2ZOZmloK2pUTnFkbEE3UTFEZU1tSXB0ck42WWl1K0lRVFpP?=
 =?utf-8?B?OVdlejB2Tkg4MjRSYktzT2FkSk1lVkZmblVSaE9aS3pMNXNyKzRPOVV5M2oy?=
 =?utf-8?B?ZkRYeDFNYmlSazFMWmYyYWlQMGc4QTJOaFUwUy9EZ3ZTNnJ0ZlFrNzMzN2FN?=
 =?utf-8?B?TU8vTmZHUHhVRkxkbnYwZHpIYmdBMWFabUs3UWxyaTRYbDhFQXVmUGh6VzYz?=
 =?utf-8?B?TkhFeDJhM0d1QVZ4T0JUM0lCdlRPS0hjRGtRd2RUcE8yb2NobCt0NTF5Slpp?=
 =?utf-8?B?MXFwTG0rNUhPUkFCaDNmZ2h1Q2lwZEhmKzlwUXFPUHdvRzhDUUhiUGNNUkNY?=
 =?utf-8?B?YlQyWXFadXhIdk1iZXFFNzVJOU4wYUNFRlpCcjREQjdpV2wxSkJvN2VKTjlE?=
 =?utf-8?B?dUx5bEkvbkVYVlZKMGN4ZnVQb3huenlHa2R2WkZUcHZWS1F6TGEzOUpqSldG?=
 =?utf-8?B?ZXlRZjE4ZVlSVjJNMlpLUjB1NS9lYUxtM2xQTnpYaS82RHlHSE9FdTNoc3VP?=
 =?utf-8?B?dURHNENJd2lqbmxCUG5sOEpzWkxPc2MzNVpCRzhQWkJLekM1Z1FlOEYrTXVH?=
 =?utf-8?B?ZHVrSXgxQ25OU051UVJXVEF0MDhhemNKTmJHZGtHMHVmNnFqRXh5ZUV3a2Z6?=
 =?utf-8?B?STJWVkxzS2pJeFlMMzRrekdJZXdrNU1nN0tjNmdjVGxSaFQ0OXdwNTF3MUxo?=
 =?utf-8?B?eGU2dkxhdXl6TnUycElJLzBBWTVCWDBEWkZ1TEhRSzRjS0Q2NVlNdDNqbytL?=
 =?utf-8?B?ZW9UejRwMExWSmhmcTNqWlpuanpPR3haTEtUYU5NdUtBcUZEU2tWbkZ3ckRS?=
 =?utf-8?B?L1NUN1VKaTJleXhnY1JzU2xlS0V2RFNqV3JSdk05em1lVlRKeXZ0QzNPMzRm?=
 =?utf-8?B?NzRJb3loKzFXbmRrWWJlNk0zSGpGWGtSd2VPSnhPSHFOOStBM3JFL21ra1E2?=
 =?utf-8?B?SHpmRHhNSFIyV013NUFMNkJQR1RRZmxDSFdSNHpBSFF6Q3FuWXE3dUhuNmpR?=
 =?utf-8?B?eEhGRUNPbnl6eFcreWtKZDhqdHhDNWFlU3dBV045UDJ0SU9TczNLOC8vZlJV?=
 =?utf-8?B?R09JQ3lBdURvTWxqRjZNUTFXTkFqa1pOeVhvK2d6Z1ZSQzNxZEVSbDAxOHk1?=
 =?utf-8?B?WGl2MHlkWTZyUUFuU2IwOHo5aU9OWDJnNGYrRFFNQTA1V2VhZFdmYjBMSUs1?=
 =?utf-8?B?YVg5L0paZFkzSkFCS3ZqTUtJY2xhMDhKVnVnS210QW9sS2F6cFBRU3AySnpU?=
 =?utf-8?Q?90nn7AI3PSaFaTXEK+YMgql3B/jQKBKTTYZ+VajFonem?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a76b669-e125-4c2b-c4a8-08dc243a05cf
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 21:58:00.5273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2ZkHHvt/Bwa21plCvfYsM+XyQtOnt1RdKwRGKZGxW9gJB1FZJXDe2ZlDwcN1ats
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4214

Hi Reinette,

On 2/1/2024 10:09 PM, Reinette Chatre wrote:
> Hi Babu,
>
> On 1/19/2024 10:22 AM, Babu Moger wrote:
>> These series adds the support for Assignable Bandwidth Monitoring Counters
> Not a good start ([1]).

Yea. My bad.

>
>> (ABMC). It is also called QoS RMID Pinning feature
>>
>> The feature details are documented in the  APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>> Monitoring (ABMC). The documentation is available at
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>>
>> The patches are based on top of commit
>> 1ac6b49423e83af2abed9be7fbdf2e491686c66b (tip/master)
>>
>> # Introduction
>>
>> AMD hardware can support 256 or more RMIDs. However, bandwidth monitoring
>> feature only guarantees that RMIDs currently assigned to a processor will
>> be tracked by hardware. The counters of any other RMIDs which are no longer
>> being tracked will be reset to zero. The MBM event counters return
>> "Unavailable" for the RMIDs that are not active.
>>      
>> Users can create 256 or more monitor groups. But there can be only limited
>> number of groups that can be give guaranteed monitoring numbers.  With ever
> "can be given"?

"can give guaranteed monitoring numbers."

I feel this looks better.

>
>> changing configurations there is no way to definitely know which of these
>> groups will be active for certain point of time. Users do not have the
>> option to monitor a group or set of groups for certain period of time
>> without worrying about RMID being reset in between.
>>      
>> The ABMC feature provides an option to the user to assign an RMID to the
>> hardware counter and monitor the bandwidth for a longer duration.
>> The assigned RMID will be active until the user unassigns it manually.
>> There is no need to worry about counters being reset during this period.
>> Additionally, the user can specify a bitmask identifying the specific
>> bandwidth types from the given source to track with the counter.
>>
>> Without ABMC enabled, monitoring will work in current mode without
>> assignment option.
>>
>> # Linux Implementation
>>
>> Linux resctrl subsystem provides the interface to count maximum of two
>> memory bandwidth events per group, from a combination of available total
>> and local events. Keeping the current interface, users can assign a maximum
>> of 2 ABMC counters per group. User will also have the option to assign only
>> one counter to the group. If the system runs out of assignable ABMC
>> counters, kernel will display an error. Users need to unassign an already
>> assigned counter to make space for new assignments.
>>
>>
>> # Examples
>>
>> a. Check if ABMC support is available
>> 	#mount -t resctrl resctrl /sys/fs/resctrl/
>>
>> 	#cat /sys/fs/resctrl/info/L3_MON/mon_features
>> 	llc_occupancy
>> 	mbm_total_bytes
>> 	mbm_total_bytes_config
>> 	mbm_local_bytes
>> 	mbm_local_bytes_config
>> 	mbm_assign_capable ←  Linux kernel detected ABMC feature
>>
>> b. Check if ABMC is enabled. By default, ABMC feature is disabled.
>>     Monitoring works in legacy monitor mode when ABMC is not enabled.
>>
>> 	#cat /sys/fs/resctrl/info/L3_MON/mbm_assign_enable
>> 	0
>>
> With the introduction of "mbm_assign_enable" the entry in mon_features seems
> to provide duplicate information.

ok. We can remove the text in mon_features and keep mbm_assign_enable. 
We need this to enable and disable the feature.

>
>> c. There will be new file "monitor_state" for each monitor group when ABMC
>>     feature is supported. However, monitor_state is not available if ABMC is
>>     disabled.
>> 	
>> 	#cat /sys/fs/resctrl/monitor_state
>> 	Unsupported
> This sounds potentially confusing since users will still be able to monitor
> the groups ...
How about "Assignment-Unsupported"?
>
>> 	
>> d. Read the event mbm_total_bytes and mbm_local_bytes. Without ABMC
>>     enabled, monitoring will work in current mode without assignment option.
>> 	
>> 	# cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>> 	779247936
>> 	# cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>> 	765207488
>> 	
>> e. Enable ABMC mode.
>>
>> 	#echo 1 > /sys/fs/resctrl/info/L3_MON/mbm_assign_enable
>>          #cat /sys/fs/resctrl/info/L3_MON/mbm_assign_enable
>>          1
>>
>> f. Read the monitor states. By default, both total and local MBM
>> 	events are in "unassign" state.
>> 	
>> 	#cat /sys/fs/resctrl/monitor_state
>> 	total=unassign;local=unassign
> This interface does not seem to take into account that hardware
> can support assignment per domain. I understand that this is
> not something you want to implement at this time but the user interface
> has to accommodate such an enhancement. This was already mentioned, and
> you did acknowledge the point [3] to this new version that does not
> reflect this is unexpected.

Yea. Domain level assignment is not supported at this point. Do you want 
me to explicitly mention here?

Please elaborate what you meant here.

>
> My previous suggestions do seem to still stand and and I also am not able to
> see how Peter's requests [2] were considered. This same interface needs to
> accommodate usages apart from ABMC. For example, how to use this interface
> to address the same counter issue on AMD hardware without ABMC, and MPAM
> (pending James's feedback).

Yea. Agree. Peter's comments are not addressed. I am not all clear about 
details of Peters and James requirement.

With respect to ABMC here are my requirements.

a.  Assignment needs to be done at group level.

b. User should be able to assign each event individually. Multiple 
events assignment(in one command) should be supported.

c. I have no plans to implement domain level assignment. It is done at 
system level.

d. We need only couple of states.  Assigned and unassigned.

e. monitor_state is name of file for user interface. We can change that 
based on comments.

Peter, James,

Please comment on what you want achieve in "assignment" based on the 
features you are working on.

Do you want to add new states?

>
> I understand that until we hear from Arm we do not know all the requirements
> that this interface needs to support, but I do expect this interface to
> at least consider requirements and usage scenarios that are already known.

Sure. Will try that in the next version. Lets continue the discussion.


>> g. Read the event mbm_total_bytes and mbm_local_bytes. In ABMC mode,
>>     the MBA events are not available until the user assigns the events
>>     explicitly.
>> 	
>> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>> 	Unsupported
>> 	
>> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>> 	Unsupported
>>
> This needs some more thought to accommodate Peter's scenario where the counter
> can be expected to return the final count after the counter is disabled.

I am not sure how to achieve this with ABMC. This may be applicable to 
soft rmid only. In case of "soft rmid", previous readings are saved in 
the soft rmid state.

>
>> h. The event llc_occupancy is not affected by ABMC mode. Users can still
>>     read the llc_occupancy.
>>
>> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/llc_occupancy
>> 	557056
>>
>> i. Now assign the total event and read the monitor_state.
>> 	
>> 	#echo total=assign > /sys/fs/resctrl/monitor_state
>> 	#cat /sys/fs/resctrl/monitor_state
>> 	total=assign;local=unassign
>> 	
> I do not see the "global assign/unassign" scenario addressed.

I am not all clear on meaning of "global assign/unassign".  Does it mean 
looping thru all the groups and assign the RMIDs?

It may not work in many cases. In case of ABMC, we have only limited 
number of hw counters. It will fail after hardware runs out of counters. 
It is better done selectively based on which group user is interested in.

But it can be done later if we find a use case for that.

>
> This version seems to ignore (without discussion) a lot of earlier
> feedback.

Please feel free comment. There are various threads of discussion. I may 
have missed.

Thanks

Babu

>
> Reinette
>
> [1] https://lore.kernel.org/lkml/5ce67d8f-e207-4029-8fb3-0bc7deab1e9f@amd.com/
> [2] https://lore.kernel.org/lkml/CALPaoCiRD6j_Rp7ffew+PtGTF4rWDORwbuRQqH2i-cY5SvWQBg@mail.gmail.com/
> [3] https://lore.kernel.org/lkml/38421428-84cb-b67e-f3ce-b7a0233e016b@amd.com/

