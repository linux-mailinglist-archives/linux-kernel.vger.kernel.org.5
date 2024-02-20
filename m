Return-Path: <linux-kernel+bounces-73694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA81585C60F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE9461C211E1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9814C67C72;
	Tue, 20 Feb 2024 20:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yNM0b5Sp"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889C51FDB;
	Tue, 20 Feb 2024 20:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708462131; cv=fail; b=ajlr29lHSjLd8L3YCp+IvT1x29sL7gG4qN3iUP4Ku8AX9EjMw3vhcEk+mq51zFuqfPcx8XpuGe8eFonQb+aBM3XLg/opoPzpxScudEuvYgXSqu0Kni+gJnreqG8akn2XQ/ywgCzkntUiCjYMRMROFxvD+9M0BK9thsW6WinuzHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708462131; c=relaxed/simple;
	bh=19BWRNIoXRFgUXlcI9uFng/Rbe1gAJEN6C471RQ4Tlw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lkmkWLA6aSA8+nm04eXKt9n7h0dcNGv084gcUHdhVUYtdigjIcrHPUFRyUYBIK2cG2dexEu+9Bcl2wngq7e4qPewtepziG7ZIIComkrUKpYmDVtLLVaP9V1vg7vo786Dvksz/z232oJ1zcji2LOYmoFZ8FXmn729G/dvnZvUIlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yNM0b5Sp; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFbtLqkEWwm9jkeHnqZb5s/qJ2jLuj2KMUAL3TRXCXNqT1FtW/CaI++Q+9bcH0deyNcW/6+FDgxRR5q5oO9YPRQVPmUhlA9AFYclnpx/KAOhY0QEufCDw5o7HmKkcQswkGAdyR3nh9s8jsH9qImmDhBxevhhC4hMZBL4FmnDBQzHRtsMTdrQ62cV7CLhTC9g2VlP/esJJ0VRiHnAoOyHZO7hpj8Fmu3KqUCA54zW5aB56v/LCBeAbPoBRJi7etjW24phviXGuxXAT5O1AB5HxaOSkRKzWNaVaTr0JAlXXzyFRzUKRxLTwEPY6wlN/LUhZixGtDhognAfvp3U3tRkCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GBIrbzThaQDser2R6EXpGoRkEOb6ZKciBUJmkj5tag=;
 b=fL0KU7Sq5NoU0/7RGTUqqmVs0Id9agcIf+28qmeKStBkOoLHnBsJdL9GYk15A6CVvQcF6kSGbYTCcfrWn92aIjejAyThq+PSt+hNFDGkBBYuwMq+ze3IMJGF95wpbNONBmKK1KY8ACOQqW8ptf3I2BeSue/IacypLEHMKV5ZcQ8ggcGsQz3fA3njRcCqz53kAM8sjRb5OwzVJmaEvUQL7npqqDjx2/nSVwIIkjaRXXvThQ9G1DyYyvTsSmpJhLLChb+LTwiNHpXfwidc2g+Ph8ascGj725RvKOE/KddFADnKJvyADBhXNTtisIH5Ov7RGATZfmgHmPF1qlGELifDVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GBIrbzThaQDser2R6EXpGoRkEOb6ZKciBUJmkj5tag=;
 b=yNM0b5Sp36A+em3FYuBdo2dcCCFhjJANejOKh5b/Tg+rexdUVgAVpyk3naOQ2XiNUWQYPBSZCFuBxIGZ7fBWfQmC05sxY/s6o7lptxctCSMqxFjrT1c8lVdtbRTyihVn5evXbLrTKdAlXI9TDRkqgE8nre46oXiu5yGENV6nlN8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM6PR12MB4043.namprd12.prod.outlook.com (2603:10b6:5:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Tue, 20 Feb
 2024 20:48:47 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ee3b:5116:72be:be7a]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ee3b:5116:72be:be7a%4]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 20:48:47 +0000
Message-ID: <474ebe02-2d24-4ce3-b26a-46c520efd453@amd.com>
Date: Tue, 20 Feb 2024 14:48:42 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v2 00/17] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Content-Language: en-US
To: James Morse <james.morse@arm.com>, corbet@lwn.net, fenghua.yu@intel.com,
 reinette.chatre@intel.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com
References: <20231201005720.235639-1-babu.moger@amd.com>
 <cover.1705688538.git.babu.moger@amd.com>
 <2f373abf-f0c0-4f5d-9e22-1039a40a57f0@arm.com>
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <2f373abf-f0c0-4f5d-9e22-1039a40a57f0@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR11CA0029.namprd11.prod.outlook.com
 (2603:10b6:806:6e::34) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM6PR12MB4043:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fa5befe-96f0-484c-b7d6-08dc32555580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YkDcSzs8Oe56UpP4FTOPXO6k5d2r2rXhsPMX8AvLv9j/gS3ySGt12ZKiN40IF8xpix4RfmV4DHEO0m7YyVJuzkcF8SfaHeOph0IjLTb/zO8OmREXAiFO9utqa1k2NAZgD/XjeQl4/ju7M7whZdgSKE0WHbCOLx7K2ZFgzJstJwmaIWZ7NHOg42tyOWvpPb/oK+GYZNgus8dpYUW8A6CHtojNqD7q8JqxqRLkU0rp+dEg7FqfYjfxRar6C7sG/4OUCceqe6hmwtmyiRnuB102Ua1ov0St8IKm2KGhm0XOViBK9wUEHJf4QF+xbO1kKROJqGr/mcC3Lxr/HqZ77O/FDG1dG07Yrvps8aTbQCXgXWqL9NS2R2F2q0G7UDv3w4bMQ9qq+uBkIjq0x6RlLmcA1bqbmGSp8fLUSUWPUPcw3mZczvUzo5zmQC4jb6PX5Uk4xWbMEvaB0O/UXSuFrJRdniShxZat8rWeiZ3D2QtXq8T7BShvY6K1/dhPxM/wXSUcQXHvnUy4zeR69Ct0qgKHwg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1dleTd4ZW5BYmZWeXNFekZzY1drMGZRMGl2M1pvNktKQ2JXOWJQUHh4WlNv?=
 =?utf-8?B?RjAxZHo0TGVsZ0xieFlhNGNTOXl2Z3VLWG5qY01mcTlFNXhseURmaWYyWi9N?=
 =?utf-8?B?My85SHNITTVwSHlEUGFQL0xrUS9UMUprbC9mWHZCa3JYVTZJNXFoT1RYY0RI?=
 =?utf-8?B?THB6VDVCQ0RIdXk1WUFZREJUaDBYL2QxYzRZWm9TalZEcXU1NVp1VXBpLzl6?=
 =?utf-8?B?SG9tVDZBV0gzbEI0UlM3U1lVaHEyUHRkWkxvOTR5RjNSVXRFdVpzNXNURkJS?=
 =?utf-8?B?SXlublk0RTViNmZZaU1HdlNWcXBJdXJXZ3lhVUtLNHcwQnl1RFAxQ0hJY0V5?=
 =?utf-8?B?S204VkZENFd1Q3NndS9RT3RnZ2hoMmZvcFRDZjYvRHp0NjFsZktXa3ZHOS9Z?=
 =?utf-8?B?VXNpd2E3YmIrUXByZ29HWjVJbGRremJ5cDk3WStST25uM1NOczJJcFkvTmhk?=
 =?utf-8?B?MlBYcm9sOEdwRTVqcnhVcGYyYjdOK0NpWUx3UFQ0elNwMTRBbE5QM3haOSt3?=
 =?utf-8?B?TU10dWVQdEY4M3drUzJ5aDIrWGxENHRDVFBHdko3Z0cxK2lIcng3Z2RJNTNq?=
 =?utf-8?B?WEwxcUR5QWlRKys5RGRvaTBwcFZCVlRSRGpndDdoRlN3QU8xV3FGRTB4NXEy?=
 =?utf-8?B?SWdRckcxWG12NGErdkpEVkFtT0VlbXRGbnV2aGdVYXM3NTNlZTdnQnRmdFBj?=
 =?utf-8?B?a1ZIOVFVWmxZMDZxb2tZVjFqOGZkS0MyMnBmempnNnVLU0FWTWk0cFNKNm1w?=
 =?utf-8?B?SnA1dmFydG5EcThuM2hrNldvb1NBcm43eE51MHpsUHh1bGNBRnJMbFBCRjJB?=
 =?utf-8?B?RzNCbysvM2NGVWpuaUlOTXVnTndubTlwUS83U2JoVGpOTmJ6SjhhdUppNXJQ?=
 =?utf-8?B?cjJ5Ujk1WTV3VnZXTmlvdnRHS0VRakUzNXFPV3RpMjBWNmR4Wnl5eHpmWG1x?=
 =?utf-8?B?QVlGVERBNjF1SVZ5T3FjUGduR3pUUFhvMm1pckdKZG1ialJCR2hHOStrb1F2?=
 =?utf-8?B?a2k3cVJ2NHNyR2ttWUtaK2RpNitWWVlXMkJEM0FOVVRwYUtNUHQ0WDJrOGln?=
 =?utf-8?B?RXkrZFFpaGxzTHEycG95eTJldGZmS2NqZGN3NXlWamNCMmdTc3Y2eDdWSVo5?=
 =?utf-8?B?ZGpaZHI0TVljWjgybXZPY1pNWmpzSVBhQUFpUFJsUlVPTnBRV2VYY1A2Smwx?=
 =?utf-8?B?YjFWckZCcCt2YWpXVEFDQmtWbzE3ZTE4S1hQOVp0eThGdU9zc3luay9hQzBM?=
 =?utf-8?B?SGxKSkdXNFVNcmcrdUpsK0NPWi9XWU5nUExrM3dDQlZ6N2RZYXN2S1NkK2hv?=
 =?utf-8?B?ZmlkZHlVNC9pZUc4emFzSUt3TGN6ZExLM1VwN0RRZkZBbTBwaEp4M1hPcEdo?=
 =?utf-8?B?T1o0WG02aVZ1NmZYUWRCUENCNVZEZjBHQ2NxYkVrZWRzZXpLWU9xeDRaZSs5?=
 =?utf-8?B?TFNQS1U2QlVjdVN6NUVLVm81d3BBbVlzQWcrZDhqNnFVWDdtZHF2YWJ3aVFK?=
 =?utf-8?B?MHlFc0d5aGRwOThXRVMwZmg4ZjdiK3hhN1MrMVk2NUtRQmFnT0gyeU9EbWw4?=
 =?utf-8?B?ODkzckYrZEY4VldURklESFdpWnR2dGxnNkI4NjFhUTRkbi84U2ZQQXR0YTkr?=
 =?utf-8?B?T1pNdk5DVVA3YUYzWlFUTytuYmpJRjJ5TWd0eEk5MUk0ZDdZQ1ljTzlqam9w?=
 =?utf-8?B?RXdMd2UzZ01ac09CRWt3UUN0RlpOVE9vRmdLekR2K0VORFROZSs5R2YwelBv?=
 =?utf-8?B?WUFxZHZqbitSMWo0WnVOc1BBLzR1V25jUEpCeXpKUWJPOVo0SnVzMW01ZVdw?=
 =?utf-8?B?OVNNUGJQVWlmaktzcXJVNytiNGl0Ymw5WDVsSTR6c0pWVE9OK1dpOEtjYjJG?=
 =?utf-8?B?T1JiY0RhWG1qcTV4K3dxNGlPcWJKWkJyMWdaUUJ3N0Nod1Z3U1lkUzczWkxF?=
 =?utf-8?B?NFRFYmlmVTBoRzB2VjM0V040a1o3REt6QThCejJ1N1FaYzZLLzhnd2h5V002?=
 =?utf-8?B?RDk0YUU5bEF6aElEK1haV3pLQWR1TTF5b0pJRnR5Nk9FeXcycHhWN2wzd0NE?=
 =?utf-8?B?bzE5bE9aYzVHZWprUzZEc0ZPdERQUmQwdjlOcC9CYmtidmJGN215UmVkcWNP?=
 =?utf-8?Q?fnoE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa5befe-96f0-484c-b7d6-08dc32555580
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 20:48:47.1665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 71nRkRunv/oS9kUgUxkv8fdUThE/bBxfnMuJKNIF3tAxrNfG+tYdO4F0Z4PvOyOC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4043

Hi James,

On 2/20/24 09:21, James Morse wrote:
> Hi Babu,
> 
> On 19/01/2024 18:22, Babu Moger wrote:
>> These series adds the support for Assignable Bandwidth Monitoring Counters
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
> 
> At a high level, if existing software can't use the counters, I'd prefer we move them into
> perf. We're currently re-inventing the perf wheel. (this argument doesn't hold for the
> llc_occupancy, which is a state not counter!)
> 
> But if this lets someone 'pin' the counters for the groups they monitor, then use existing
> tools, that seems a good enough argument for doing this.

Not sure if I understand this. Yes. This feature provides the option to
pin the counters to the monitor group.

> 
> 
>> Without ABMC enabled, monitoring will work in current mode without
>> assignment option.
> 
> To check I understand: the counters will get spuriously reset a the whim of the hardware?

[1] Not spuriously. Hardware can keep track of certain number of counters
active simultaneously (active counters). If there are more monitor groups
than the hardware can track, then only most recent associations are kept
active. The active set can change based on user actions(RMID association
changes from user).

This feature can help to pin a counter so it does not reset.

> 
> 
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
>>    Monitoring works in legacy monitor mode when ABMC is not enabled.
>>
>> 	#cat /sys/fs/resctrl/info/L3_MON/mbm_assign_enable
>> 	0
>>
>> c. There will be new file "monitor_state" for each monitor group when ABMC
>>    feature is supported. However, monitor_state is not available if ABMC is
>>    disabled.
>> 	#cat /sys/fs/resctrl/monitor_state 
>> 	Unsupported
>> 	
>> d. Read the event mbm_total_bytes and mbm_local_bytes. Without ABMC
>>    enabled, monitoring will work in current mode without assignment option.
>> 	
>> 	# cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>> 	779247936
>> 	# cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes 
>> 	765207488
>> 	
>> e. Enable ABMC mode.
>>
>> 	#echo 1 > /sys/fs/resctrl/info/L3_MON/mbm_assign_enable
>>         #cat /sys/fs/resctrl/info/L3_MON/mbm_assign_enable
>>         1
> 
> Why does this mode need enabling? Can't it be enabled automatically on hardware that
> supports it, or enabled implicitly when the first assignment attempt arrives?
> 
> I guess this is really needed for a reset - could we implement that instead? This way
> there isn't an extra step user-space has to do to make the assignments work.

Mostly the new features are added as an opt-in method. So, kept it that
way. If we enable this feature automatically, then we have provide an
option to disable it.

> 
> 
>> f. Read the monitor states. By default, both total and local MBM
>> 	events are in "unassign" state.
>> 	
>> 	#cat /sys/fs/resctrl/monitor_state
>> 	total=unassign;local=unassign
> 
> 
>> g. Read the event mbm_total_bytes and mbm_local_bytes. In ABMC mode,
>>    the MBA events are not available until the user assigns the events
>>    explicitly.
> 
> How does this fit with "monitoring will work in current mode without assignment option.".

See my response above. [1]

> You mentioned the hardware resets the counters when this mode is enabled, does it also
> refuse to count until the MSR is programmed?

Yes. That is correct. We need to program the MSRs to start counting again.

> 
> If so - is there any mileage in auto-assigning the first N RMID to counters when the
> groups are created? This way existing user-space tools work until they exceed the limits
> of hardware. From that point a counter needs to be unassigned from another group. (we'd
> need to make it easy to find which groups have a counter assigned)

Yes. That is correct. To see the state of assignment, I have added a
monitor_state in each group to see if the counters are assigned to that group.

> 
> 
>> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>> 	Unsupported
>> 	
>> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes 
>> 	Unsupported
>>
>> h. The event llc_occupancy is not affected by ABMC mode. Users can still
>>    read the llc_occupancy.
>>
>> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/llc_occupancy 
>> 	557056
> 
> {
> 	MPAM would be the same - because llc_occupancy isn't a counter its a view of the
> 	state, its possible to multiplex a single llc_occupancy counter behind the scenes
> 	to provide the value for as many groups as needed. I suspect any other
> 	architecture would  have the same property.

ok. Good to know.

> }
> 
>> i. Now assign the total event and read the monitor_state.
>> 	
>> 	#echo total=assign > /sys/fs/resctrl/monitor_state
>> 	#cat /sys/fs/resctrl/monitor_state 
>> 	total=assign;local=unassign
>> 	
>> j. Now that the total event is assigned. Read the total event.
>> 	
>> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>> 	6136000
>> 	
>> k. Now assign the local event and read the monitor_state.
>> 	
>> 	#echo local=assign > /sys/fs/resctrl/monitor_state
>> 	#cat /sys/fs/resctrl/monitor_state
>> 	total=assign;local=assign
>>
>>         Users can also assign both total and local events in one single
>> 	command.
>>
>> l. Now that both total and local events are assigned, read the events.
>> 	
>> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>> 	6136000
>> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>> 	58694
> 
> (the bandwidth configuration stuff is the existing BMEC support right?)

Yes. correct.

> 
> From user-space's perspective MPAM could be made to look the same.
> 
> There ought to be some indication to user-space of how many counters it can assign, this
> number might be different for different resources. This won't be a problem today, but if
> we had 'mbm_total_bytes' on the L2 cache, the number of counters may be different.
> 
> MPAM platforms are unlikely to support both 'mbm_total' and 'mbm_local',  I think this is

Ok. Good to know.

> just a documentation problem to say that mbm_local can't be configured if its not
> supported - user-space can't blindly assign both.
> 
> If the configuration is changed over time - I bet user-space needs a quick way to find
> where the counters are currently assigned - walking the tree to find out is a bit rubbish.
> A file that lists the "control_group_name[/mon_group_name]" would help.

Looks like you already found in here.

https://lore.kernel.org/lkml/c16cac16c813a203390229d77d5ab37ebc923d95.1705688539.git.babu.moger@amd.com/

> 
> 
> Thanks,
> 
> James

-- 
Thanks
Babu Moger

