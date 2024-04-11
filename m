Return-Path: <linux-kernel+bounces-141670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFF58A21C5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EFF31C213AE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FFD43ADD;
	Thu, 11 Apr 2024 22:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hP8sXUg5"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E322581
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 22:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712874870; cv=fail; b=XndXSu7cL92GNubETyUMIeyxRCVpZy+Nkb95EpoqhLLUfNJ83iJwTmV7GVyC/w68LlMdR+Mn1zLnVC+RrukFh8tu8UUD1Iad/mGTn/bVaB2TBpUkpm/5A76eOrsjUyhV/9jO9OSlKWS2reEO2RroHa+otGsirbhPgiISaP48c7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712874870; c=relaxed/simple;
	bh=U9Ub0eyHbASShJOTNFZFIdUULN6gUnihVJlkeT75cpQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l+58HcQ9XKPo7TWTT9zhCwzmU1wIqEXU9dKZ1CTnJQrqb4hYfagd5qICpXYkHhREj7BsRjjeO2qhEYVuXzKSfqkpBj2fGfx/64+fd0vxgubc44vL7ZqTmBrrgRJ+6vsh5WUK7ySZ1uKuZ1iJhIbg8xc2Ha/NEoODma4Y9TsMb0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hP8sXUg5; arc=fail smtp.client-ip=40.107.92.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xxw0/mvj/BEhNQgNcsvpl1T2QyY7V7xv0dZBCNu8E50H+xXQJbGrWtUmtr3HKMR80RsGz1s9ZVpGE57GK/KhdHaW4Ob8kSlXfahuleHasZ6cD4QvmSxzg1DzcgfyVAwepoZtL9000pEr9MVI7GlHXKxkw49gKrg3W7P2QhC/a252Rv9xKds6R0agDURaWwQhAeI0CpKXg9D4nFXxhZVdkb/6NeEgM5W8Dh92xYRvT4MBVG8NHCHPLxHckuSpGq0wxrKiaTxmACdtiSE/ihqmRytnDig2rB282R5N+NJpX7nz49o6KyWwdyghWU8HLUWZCdtQ+I//HL0FDwsKNv9mYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAaq4pO7TPYtk7W2CRlRsmQp6fdY214l5HYTA18unO0=;
 b=Va8YeBYOfC6xRKUCJOgUbac3zXqt4b04r1M9brA7n2t4futecFRwT/qIjLvhPsPZhSTiQt99EF/9As93s6V7nZSFE/J80l/OGlJ0i7nsoAmgHzmyy6qcJf81tS1/VZYLHABdqmFSNXB74N/tegf6TukiHy2ja0Vs5Ir2wyTIlGyLFSwRp3Pjh4O3Ey78wVKT9dg1ZdI68UOaruudqjo//ObnwPF0tgI/LpUuPuA/1p0Mhv14rvU/k9iMyW7M+vs/srUmTJgjCnsQsTMLLig6B3m7pgHen2lal6qw+aXhlX3Y/LyvalQc5MwfndbqksBuKXxYRMhQsXSo9VfpIXMprw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAaq4pO7TPYtk7W2CRlRsmQp6fdY214l5HYTA18unO0=;
 b=hP8sXUg5uB9eTq4SO5v2abx+MHzM7ATj3Ce6t8Ha8vnu9UYDpMwi59LQ6y/1xu6VdZVSss67ZfBF1LPPXPJrtjKw1N5h88teZSVgcge2hISeEPkWAhDnbYYtwyog2pmMUzIp7Lnh44I2sViZeLYYEQsRbro3TG3TWgATPfWTwpY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CY5PR12MB6550.namprd12.prod.outlook.com (2603:10b6:930:42::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 22:34:24 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57f3:51f5:d039:ed24]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57f3:51f5:d039:ed24%5]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 22:34:24 +0000
Message-ID: <acac43c0-d688-dcfe-51ce-b292f3c522d0@amd.com>
Date: Thu, 11 Apr 2024 17:34:19 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v1 0/6] x86/resctrl: Avoid searching tasklist during
 mongrp_reparent
Content-Language: en-US
To: Peter Newman <peternewman@google.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 James Morse <james.morse@arm.com>
Cc: Stephane Eranian <eranian@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 Uros Bizjak <ubizjak@gmail.com>, Mike Rapoport <rppt@kernel.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, Xin Li <xin3.li@intel.com>,
 Babu Moger <babu.moger@amd.com>, Shaopeng Tan <tan.shaopeng@fujitsu.com>,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Tycho Andersen <tandersen@netflix.com>, Nicholas Piggin <npiggin@gmail.com>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-kernel@vger.kernel.org
References: <20240325172707.73966-1-peternewman@google.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <20240325172707.73966-1-peternewman@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0091.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::32) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CY5PR12MB6550:EE_
X-MS-Office365-Filtering-Correlation-Id: 523834e6-d14c-454e-5b20-08dc5a778a03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m/QVCIdeCMWCZuseLUfl8xJSohH+dZSpl1gKwzJ+colv+439DZo3KbP+9grU2D0s8y+rWO+mMC6Y1n6kOS87n5u5GxGq1UDViFE1aJQoWRbou0DfoscpW1WtBiUE+8E3SQMqLp8BRG7tAroghPUc3KPcI4xqLLPvqh9DmmnVNDPO5Z3hD36/Xu+z2MP0YKvz7YkCm2aiDqGzDXNkei/vT8noIkZ/6Vpg0hjlBHMiBzx9xascCTYBwtAs/Wp+VgsnDX1JEB4Ov0SV7T+dVmVGVA4WsOqh562OSznpSC4mkx3ZUTQH3g8PBRRVsW/9ZQk82281fre3S53YT2nKBEU9WygLx0YfXLfScsbidVrK8z+EUXyaq1gyEoAtXe+rHD5Hxon3HzFiiO6Udm7r/GgnBUgXRbLNFlp7w+4K3NgCyb6MrizgshuAy8N6UnH2vFfgmYWS/iqe4seOneemmbcIa+nGDg8RLxy65mjhS+l0gaDx0f571LVa+za1p46qFd6rQDWosmgr7/5yjJWKwa6aticTwfdmIbGYC5rZzf3gyD4G1q5vXi/I9vfMZFgsNxUec/FeOCwWhRrCiM3LBcSzGWkDH1cNR77GbANFkyPEDiMfB9o6lXc1ZqSZx/QBJW8xEl0TH2Y7KEFlxZE/W6HOtb9e5MpuKLoG4HKllVpSvsI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3ZzTUhiRTFmRGtMMGNKVlN3U3FMUHRFNHJqQ2ZsNzVZZFE4bHBPZklpTks3?=
 =?utf-8?B?c0c2U3lwMVdML1JJWStSa2oxbE5JZGJ2cE9Lak5MSjRudU8yeWJobE4yeWw2?=
 =?utf-8?B?ZDE1Nk8vdHBweFhWYWJWeER1aHpWMHpJT2M1WGlPYzhkdmQ2ZXV3SGoyTkNt?=
 =?utf-8?B?VmtELzFlaGVTUGY5ZE55QTlDMWUzTTZLOGQrWkZHY0Q3bmZiZkFzM3VyWXZq?=
 =?utf-8?B?eGg0UGdjTjBKb01KeXl0OFJBNkJKWGprS2NPQnI5RS80UHJRRlpoQmhOK1h5?=
 =?utf-8?B?OG9LRmhpQkFOb3FKTGVPYXNZaGdpUjUxT1R3a2FlZkVYeFEzbVhBNXlRdE9B?=
 =?utf-8?B?aGwyK1lOWFBFOWpHUVJnZHVhem52bFdxcytUMHlNeGRmeU1yQm1UU0h6U1J2?=
 =?utf-8?B?TlFOQlNlOGMrU3M1WWVLbUZCbGR1MTJWeVRrUXdGUDVsK3pVYlZqd2NFVWhV?=
 =?utf-8?B?ZFh0TENUUjR1Mll1VTVYM1RrQm16UStScTlSTWpYSld1TWk4L29lWVB5eVBY?=
 =?utf-8?B?VHowWUY4RHN6Q09LQnJjd3RKZGphemM4NnZDL25jY1Bxb0xIVkFpQVdpcFdO?=
 =?utf-8?B?T3NaSWJhU1dUYlphaGR1Qkdydm5XMktpc3N5U2dFN0UzUXZLOUVhSENYNTd4?=
 =?utf-8?B?OEVUdTJya1dGeXQ5TW9zOVJvSXNxVjd1d1VGMVJHOTZ4aUkxSkhzUEszRnNZ?=
 =?utf-8?B?QjNZSFlqVVZnTkd0cWhtR1RXU1JHTE90UmE0bUtZS3p6SDJHc3NSOGM2U2JO?=
 =?utf-8?B?SUlFVVVvL3FnMVNhZkg5cE1QV0ZCaU8zU2FxSHhGdnhGWTJ1Q1VYQ3R2THQw?=
 =?utf-8?B?bytXZXd2TjJ2cDE0U1FkMDZKV21BYTFlazR3U2o4dGdGamp2MlR1T1RVbEhh?=
 =?utf-8?B?dzZQWVRXS0ZUQ2tSdGRlSjFaNlhKbzdwY0ozUWova2U0b3RaWjh2cDJjSkZw?=
 =?utf-8?B?U0owT3ZCSkJkRmNUdC9BRGJLYWN0YzRDQVRWODREK0pPTzY3dngwZXpGdHdw?=
 =?utf-8?B?MFdUd2hML3JtUnlLNFdLNkwzS0FObmpXemFHTm1MWEJISm5CTWNEU3BNWkF2?=
 =?utf-8?B?cjJuaTlOcFRmZEc0eEhmZmxrTVJIUnMzWk1pd2RFVC9MOWR3REdzS1FCVE9B?=
 =?utf-8?B?eEphdlNGcU9xMjNnTVNGSzIvNzFnMGdCTy9YWE5EUmpXZGpYS2RIOWlVUWo3?=
 =?utf-8?B?cTZ5emVlbVJ3NGJvMXVRSHZQbVFQZDVMUC92QkVKby9kTUUxdGhoeTdYSVR1?=
 =?utf-8?B?WndxNlFjelZ2aWcweUlJOVVLTCtZNFV1b2N3eGdydFkzVWJkU0pMcFFtYzFi?=
 =?utf-8?B?VS9KVFphUVlGOUJ3bElRMlhzZ3J1d2JKUXBvVlY1RFRsZXd2OXhKUTRhaUQ5?=
 =?utf-8?B?QjFMdTFjaWV3M3dkcS9YUjI1RkRBNGtzRko4ZjNTaTIzTzI1Q0RVZm1RZVlK?=
 =?utf-8?B?c09kN3lPK2pKZjdiV3U0aXFVcldwMnRLRm5EVFp6T2NxaTN4d1F6YVVhOXdx?=
 =?utf-8?B?MzFSUTdFTVN0NDBDMGJBNWNUTzZ1eWZiakl0RXlVYk0zY3hESmM4UzVlZHpG?=
 =?utf-8?B?QTZSeEFQeFlSZzliTWlIb0FVVnVmcEo1ZjdpV1JxeHQ5aDNvZU9LUTl3ZUZR?=
 =?utf-8?B?a0g1S2RMclhLZDJNWWNvTDk5RHZUQUR6YUhqOWZ1eHdaWkRMdE5pQTlZa0Rw?=
 =?utf-8?B?WWNaWkNvWmFOQnJLTXl0Ukx1OVYrRjhnQ1VwUFZrTFVpR2ZBR1NHNmFSUFFj?=
 =?utf-8?B?K3VWeXhnazMyTUc4UGF2VEw2TzlaUm5rbDJMRDViVllDZ3JmR1BtSXpiMFV1?=
 =?utf-8?B?Qi9VY0VTNEtXTXFISkpvZWhTekhINXpmVXJNVUdSZE5EK2Q2eXJSY2NCVHZ2?=
 =?utf-8?B?bU5RaWlVaGEwMndTMUpzcjBoSHdLcmx6UVVlNXVGcUJIWEs2ZVkrbGtESW1B?=
 =?utf-8?B?ajRjenFLdk5udkN3RlNTM2huQ0J2OTUwcElzZzBFb2hjcnlua2lYbWZORXQz?=
 =?utf-8?B?bjEzU2U5YTJSZzNmMWZTb2R0YUNYY2U4SXgrbEQ1RERBbVpnc2h6MTg3TXdt?=
 =?utf-8?B?TjE2QWtPRDU0T3NKVGM0cWJnSmxVTzJNd3ExQ0lXSTFwTWRzWmtEYjZYSmE2?=
 =?utf-8?Q?dno10BqYe4imOFVhoDl/OTbax?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 523834e6-d14c-454e-5b20-08dc5a778a03
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 22:34:24.3927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5YbQx4YKt+qP9On/lbpPyhi4OQtmoT7zhfOCtFR2ZVcT7XB837TSHeb4b7cuaeie
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6550

Hi Peter,

On 3/25/2024 12:27 PM, Peter Newman wrote:
> Hi Reinette,
>
> I've been working with users of the recently-added mongroup rename
> operation[1] who have observed the impact of back-to-back operations on
> latency-sensitive, thread pool-based services. Because changing a
> resctrl group's CLOSID (or RMID) requires all task_structs in the system
> to be inspected with the tasklist_lock read-locked, a series of move
> operations can block out thread creation for long periods of time, as
> creating threads needs to write-lock the tasklist_lock.
>
> To avoid this issue, this series replaces the CLOSID and RMID values
> cached in the task_struct with a pointer to the task's rdtgroup, through
> which the current CLOSID and RMID can be obtained indirectly during a
> context switch. Updating a group's ID then only requires the current
> task to be switched back in on all CPUs. On server hosts with very large
> thread counts, this is much less disruptive than making thread creation
> globally unavailable. However, this is less desirable on CPU-isolated,
> realtime workloads, so I am interested in suggestions on how to reach a
> compromise for the two use cases.

Before going this route, have you thought about your original solution 
where CONTROL_MON groups sharing the same CLOSID?

[3] https://lore.kernel.org/lkml/CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQTfuxY4a0w@mail.gmail.com

May be it is less disruptive than changing the context switch code.. Thoughts?

thanks
Babu

>
> Also note that the soft-ABMC[2] proposal is based on swapping the RMID
> values in mongroups when monitors are assigned to them, which will
> result in the same slowdown as was encountered with re-parenting
> monitoring groups.
>
> Using pointers to rdtgroups from the task_struct been used internally at
> Google for a few years to support an alternate CLOSID management
> technique[3], which was replaced by mongroup rename. Usage of this
> technique during production revealed an issue where threads in an
> exiting process become unreachable via for_each_process_thread() before
> destruction, but can still switch in and out. Consequently, an rmdir
> operation can fail to remove references to an rdtgroup before it frees
> it, causing the pointer to freed memory to be dereferenced after the
> structure is freed. This would result in invalid CLOSID/RMID values
> being written into MSRs, causing an exception. The workaround for this
> is to clear a task's rdtgroup pointer when it exits.
>
> As a benefit, pointers to rdtgroups are architecture-independent,
> resulting in __resctrl_sched_in() and more of the task assignment code
> becoming portable, simplifying the effort of supporting MPAM. Using a
> single pointer allows the task's current monitor and control groups to
> be determined atomically.
>
> Similar changes have been used internally on a kernel supporting MPAM.
> Upon request, I can provide the required changes to the MPAM-resctrl
> interface based on James Morse's latest MPAM snapshot[4] for reference.
>
> Thanks!
> -Peter
>
> [1] https://lore.kernel.org/r/20230419125015.693566-3-peternewman@google.com
> [2] https://lore.kernel.org/lkml/CALPaoChhKJiMAueFtgCTc7ffO++S5DJCySmxqf9ZDmhR9RQapw@mail.gmail.com
> [3] https://lore.kernel.org/lkml/CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQTfuxY4a0w@mail.gmail.com
> [4] https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/log/?h=mpam/snapshot/v6.7-rc2
>
> Peter Newman (6):
>    x86/resctrl: Move __resctrl_sched_in() out-of-line
>    x86/resctrl: Add hook for releasing task_struct references
>    x86/resctrl: Disallow mongroup rename on MPAM
>    x86/resctrl: Use rdtgroup pointer to indicate task membership
>    x86/resctrl: Abstract PQR_ASSOC from generic code
>    x86/resctrl: Don't search tasklist in mongroup rename
>
>   arch/x86/include/asm/resctrl.h            |  93 --------
>   arch/x86/kernel/cpu/resctrl/core.c        |  14 +-
>   arch/x86/kernel/cpu/resctrl/internal.h    |  17 ++
>   arch/x86/kernel/cpu/resctrl/pseudo_lock.c |   4 +-
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 279 +++++++++++++---------
>   arch/x86/kernel/process_32.c              |   2 +-
>   arch/x86/kernel/process_64.c              |   2 +-
>   include/linux/resctrl.h                   |  38 +++
>   include/linux/sched.h                     |   3 +-
>   kernel/exit.c                             |   3 +
>   10 files changed, 239 insertions(+), 216 deletions(-)
>
>
> base-commit: 4cece764965020c22cff7665b18a012006359095

