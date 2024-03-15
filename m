Return-Path: <linux-kernel+bounces-104088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C9087C8D2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 07:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD1F4281C34
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 06:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5575D17543;
	Fri, 15 Mar 2024 06:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RgPhfjUj"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1377413FFC
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 06:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710484329; cv=fail; b=DL74IPg/DpyHsfY9Kq9+LRQtzA1yvUgKmbqBIT5XKpi8G1dCpSrQ7MSR//h271Y3S8TcPS4FECpZ6zbpi+byKnaJQy51zB6GOr9IcKmfOeYhb8T3X4CQQA5PXq/2/NlAm69x+1y6uRdiPVFMo0/stlOVSXYgonE+Kq3byvWD6z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710484329; c=relaxed/simple;
	bh=+JSN5vwcpgxNi+2CTGQUA37RSV27FHmIoZQw3r2VyJU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XglpeCBj+O7vsgeO+nbRJu+l7OhOPCTTFsNzl3Tnr/npboNt66nvdthdWVk57k45LKMdrB+ZK0jYwhmiU0YoScFDNz0sh6bcTMcfs/3jCNjkPFjQ3SRYeox+OFpIfbLXlutnXa2wFs266KcQMzviYVR0QvQTMPE0dZquOOpKy+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RgPhfjUj; arc=fail smtp.client-ip=40.107.223.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QlOOC51xD9UAonhNWRdmEK20uXUFYDtLAWdYCbpoe0mY3Xz1BuhWADgtZHEja6folPiW0FF8zgKLYHJLwr2Ihs/Kk5IGgbkbPYju1cxH4cpnzfXQZ1AYP9knRjkusAQxGs4fgmJAwhc5oc7kDzqQo00/kXCvmR75+lQd3THMm9pbAzQgKPrvFxm5q/VzYtPHV1RFQ0NJ0x7nNDz35atS3TxtBeqjmzYTf3k49qAHLtkXqwcEv8ia+2UswezDlcKufrMHoS7vM6lvewQUmOJ0sRpjhWxeDGGVkYlskLRxvEhRD5oibPLBlNY9Ol4SCfg3+pSq7QKxcOs2GNdKqpRgQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbhiLSLB5S2URQBXQoJv7+S/mKEXYEz4ncos1sA+fmk=;
 b=mDgJuN2rETNrbdzBckYSzznqspAmIer7UQvL8uOsnqEQKkUMWzosoB08FKTl16AThKNOBLy6E6Yw89G+g2UmJsnUCb2y0rciD9yTtfKwa8gMfEAE9ZmxzGrhTpgV4YnrXRG4ohtik9tTjYFStapfbaiDsTdZCbBiLsSv/gwuEhtNK78s+3jPVD9X9w0HX1cmjlJLUQkjagc5gckFoAiqLO7NWS8sSn2MS8n2FbT2u8hVZt84P+A9kogJ9Q8GuwqheC5e3avlQov3NXMBk1gTYoWY8h5FJnTyNcC3RGRsg7iEfp+Ts3GpQ9ePTGcSJXb0yDqwdhqlfNMs/UanKJWE6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbhiLSLB5S2URQBXQoJv7+S/mKEXYEz4ncos1sA+fmk=;
 b=RgPhfjUjSggReSqMLLieCxwlVdwvwRMpr5SEeW7FlTOtmvDuYWdupeVyukW1yMgMcu8twYbLf2MEKNeyfJX0zNBUyf+HTgpDN/zXqSEKXBnDbOQ+d1a8BH0z1vpeolEj08poxAFWGf+JouCEPFnwNr+jp1zatHYplDAYLwn1qTE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by CH3PR12MB9171.namprd12.prod.outlook.com (2603:10b6:610:1a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Fri, 15 Mar
 2024 06:31:59 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::3150:d50f:7411:e6bb]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::3150:d50f:7411:e6bb%5]) with mapi id 15.20.7386.020; Fri, 15 Mar 2024
 06:31:58 +0000
Message-ID: <87fe0305-d698-608a-3801-fd31c52fc082@amd.com>
Date: Fri, 15 Mar 2024 12:01:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH 00/14] Introducing TIF_NOTIFY_IPI flag
Content-Language: en-US
To: Julia Lawall <julia.lawall@inria.fr>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 Tim Chen <tim.c.chen@linux.intel.com>, David Vernet <void@manifault.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>
References: <20240220171457.703-1-kprateek.nayak@amd.com>
 <CAKfTPtBqPVQ5bo8HTZ=sPCUTYr48qtH61A8Z1dwCT434O7cSyQ@mail.gmail.com>
 <alpine.DEB.2.22.394.2403072036080.3161@hadrien>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <alpine.DEB.2.22.394.2403072036080.3161@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0111.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::26) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|CH3PR12MB9171:EE_
X-MS-Office365-Filtering-Correlation-Id: aae63544-106d-469a-6457-08dc44b99d89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Z90p7WOID75+rMjZChmthSOZaJJAONyuj9TgdWZko8c5RhlLZOhF8wTK687PNzEo3i7f8pyjXGo6MNW3DhIGU7/t2EgQdu+SpCj/wWmNMwitdRRwqih7HnPYDTB+8ogPOs4pduaD8i6ujSpHAbPsCV8WvuCT20ds2NjpxS//uY2zq7WLvOlXKG2PCWvl3RICwylk0Z7DBRPZ2IGj6maQqr5mzqjR2l0R4pXRAEgpcCIMp6bR37tJCfN/OpCxYmrz4O4pa7FPUxLoBHruZdscs7XyiVy5ipMfrLiMKk2k6pVYXIg3rnyJk3i6nBaaeu30rdxRY0L3tfldyH7p/a1Dfd5yy9O2zFOIg7toecX54PtOTKoaA8jMuuuf2wsywMmOZ4VItR2FyAz1w+4ENhcdqIOzjaZtlEATvxHAXEZxTDkRhk0x3nUPs8WKp9iePinfBbUrh44Vt1sfLKiOLFohHNn1XRO8PuOCHB+BIfsbQk7DsMzL9/Kw60VO39QoXpuferRILkLJYMykp/U2WfuUGCfdwhik6Oy/KPXyPUVWiXIHWzeeqchb9MHFpBilaQcWYvGw6WQNd/pwNbc3faunCO31RSSj6zYjOK1bZT4HCRO31bp4mDJxCnxChJFZL0ra
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U09YR3QwbzRyYWZPRk9ZRElxVktKZ0VKV213K1prWVlQMVU2aHBXUW9yNDJY?=
 =?utf-8?B?OFlRT0pvaEk3UDNabXVOaW8xMkY5OVJVV1lRYlB2Tkc1TnFNeUJXV2pwRkw3?=
 =?utf-8?B?R2JFdVRuV05KbkRZSWRUZk5QcVZNc1JFa0tVZHdsWjB0a0lSRGtHRmMvaGV2?=
 =?utf-8?B?NzJYT2V5WnU2NHA3Q3RjL0EyTlRJWHdQcUxaMkhZU0RYU2JWekM1cFRTTEJY?=
 =?utf-8?B?T1ZxcmxWMkR4cGd3Y0RYMCtmVW9iKy8wZzg3SU5YSDJhMk1vb2lzL2xqRXpX?=
 =?utf-8?B?QnM3QUEvSjY4SXlPSnZyaGJwcGRNc2lDQzZLTzJlcTgrREpvWjVPbktOdlhY?=
 =?utf-8?B?UENreFVrZkNOU2JEQmVoYzd3WnlPN3g2THptZVBXemplYTlIcjhwUlBqdWhY?=
 =?utf-8?B?ZXp2bVQ4aytxdWY4Nk1zVlc2d2d2VjI3eVkzNXBnK0dISXhsMEVMYXZ0NnZ6?=
 =?utf-8?B?YjZIZXh6N1pVQWtFZkpiVGRGUWsyaWpManRlbmE0TEJFcDFFbHFTSjV2U3BS?=
 =?utf-8?B?ekZ3U0ZscUlOSUY3SjY5R0tka2NXTEtMa3VJbjBNYlpoa05zZVNmK2pKdjNw?=
 =?utf-8?B?dXZEUVRhY2IwbU9DSDlnRlFaTkpOTUFIVWM2eVV1bEZvKzk3Z3RuM0dkbjB1?=
 =?utf-8?B?NFpsVUFTSHFDRFlwendkNE0ybTZ2bFQ2dHFTcjhDaklIelZSbS85REJXaldl?=
 =?utf-8?B?MFJRbzZmWHVSRy9iTC9nN3k0YlR2aEhCRkpsc1BEZGxyQmtnMHY0TjBnN2ZJ?=
 =?utf-8?B?NkJCamtLRFpVL08xV09ZQ3c3V0VLTC9ZM2ZXTmhIZGpwaUhYaDdCRVdzL3VC?=
 =?utf-8?B?MVRFREV1dlQrUFRjTy9LM1pkbVFPKzRkaTdwZG1UNXJDT0lyRU9XRnBnYzJO?=
 =?utf-8?B?ZkJtK1V5OHpmZ0pxYTZaSnRxcC83Y3lxa1ZLUm8yZjFVeFRUQlBVSGJZenFT?=
 =?utf-8?B?T2tkajNCaDJqZXdhS1l6bEh6NFdaWmEzOThzclhxc0hHeEcyYzFKYlVSRThR?=
 =?utf-8?B?bFFzUnorcVNHOGx0c2tJc3dVOGp6amVHMTc5R05qRDNwN3lsd3JFaUs3dklJ?=
 =?utf-8?B?bi82eXJKMFAxYndvenZld0FlM3orSG5YWVR4V3JzREw5T3dKSE5BY01wUHAy?=
 =?utf-8?B?ZEZrUiszQ3dmc1ZVQUU3NmRVVEMrWmUwQW5UMjFKaS94TXM4MXpSRit3MGJh?=
 =?utf-8?B?bVQrL2Q0NXBTYkMrNDYxcjNNL3VHSTVmTEdCd3VkOTlzcnV0TDBXNmhZUEdX?=
 =?utf-8?B?djc4aDdPb1Q1NDFMK0grWk00OG9uMGlQdWhsalJXcGR5ZWlHcUFqZnZWVmcw?=
 =?utf-8?B?ZUhvQ1ozMHEwTHM1N3l1MDB2eVhkL0hkbU83bHdpSXdtckFCU1ZVRzR2M0pC?=
 =?utf-8?B?ZDdGeDlGZzRudUtmdjF0QjNTYTh3cVAxZ0wvTk5sb2N2M2VQZFlRMWhESkUx?=
 =?utf-8?B?ZnJTWVQzdDhuZHdRL3VFVzYvZnhLN0k2ajNLakdhMzA0Qk1wV2NTR2ExZGFx?=
 =?utf-8?B?QW0rc0pUdlVEdndFdG4yOEhtdEdRZFJFZXJiSm1ZNnhHb0VkbEZ4RDN2M2RW?=
 =?utf-8?B?NXpvSFZQQ0huWVo4VG9HK3hsSld3ZVpnLzNIM2ZiQmpUUksrL3pMakJ0UXVI?=
 =?utf-8?B?ZkE4UEN4MUpQQUlQTnZSVlNvSi9yT2Q1clpzUnJqYTRlUFRKZHQ4cGpFaFo5?=
 =?utf-8?B?bFZtSE9zUlN2SzI2bFJyRUprMkMyb0NUSUhCQlM5aVNxVFJvSUhnTzlKRmFv?=
 =?utf-8?B?UUtQSGZNVXgrL0grRzN3cUZOMVlnQkpEWklxbjE1YmswdERHM3kyMlNUN200?=
 =?utf-8?B?RkpHTEFPNkdzdldONmFnRVFKSUxvSi9LWHJhcERXSGg3akswZEsydnNhdFZ5?=
 =?utf-8?B?b1hPUDlVdWdrQXlHblNwS1MrVHlEVEd1S3pNRUk5U3BjWXNUKzdDM2pPT01V?=
 =?utf-8?B?VU11dngxRC9XSmN2Mmw3U1BEVHdQbDZXcXRzYjk3SkdpRnhUTkt4N24vTkFq?=
 =?utf-8?B?bUUzQldmMEZFemgvSExXZk12NjRndTlZa3pnSFlGT1R1M0FBdVVoOGNoa2dX?=
 =?utf-8?B?SVdINHNwck9BNWp6NkZ0Nm5tUWhMcGMwNFVjTWJSTyt2NVZ3TUNaRUNkK0lo?=
 =?utf-8?Q?2qSnX93FGL2qeBlTGRxlIbvKW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aae63544-106d-469a-6457-08dc44b99d89
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 06:31:58.8044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ltvc1ybyjVoi17EDJzDAZ0e+KRAmN6CwQs2Hu1WjcaxczdozF+avh2XgUh6kczkYC+fM08f6kjJeGuiOIJBuHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9171

(Trimming the cc list to only include scheduler folks)

Hello Julia,

On 3/8/2024 1:26 AM, Julia Lawall wrote:
> 
> 
> On Wed, 6 Mar 2024, Vincent Guittot wrote:
> 
>> Hi Prateek,
>>
>> Adding Julia who could be interested in this patchset. Your patchset
>> should trigger idle load balance instead of newly idle load balance
>> now when the polling is used. This was one reason for not migrating
>> task in idle CPU
> 
> My situation is roughly as follows:
> 
> The machine is an Intel 6130 with two sockets and 32 hardware threads
> (subsequently referred to as cores) per socket.  The test is bt.B of the
> OpenMP version of the NAS benchmark suite.  Initially there is one
> thread per core.  NUMA balancing occurs, resulting in a move, and thus 31
> threads on one socket and 33 on the other.
> 
> Load balancing should result in the idle core pulling one of the threads
> from the other socket.  But that doesn't happen in normal load balancing,
> because all 33 threads on the overloaded socket are considered to have a
> preference for that socket.  Active balancing could pull a thread, but it
> is not triggered because the idle core is seen as being newly idle.
> 
> The question is then why a core that has been idle for up to multiple
> seconds is continually seen as newly idle.  Every 4ms, a scheduler tick
> submits some work to try to load balance.  This submission process
> previously broke out of the idle loop due to a need_resched, hence the
> same issue as involved in this patch series.  The need_resched caused
> invocation of schedule, which would then see that there was no task to
> pick, making the core be considered to be newly idle.  The classification
> as newly idle doesn't take into account whether any task was running prior
> to the call to schedule.
> 
> The load balancing work that was submitted every 4ms is also a NOP due a
> test for need_resched.
> 
> This patch series no longer makes need resched be the only way out of the
> idle loop.  Without the need resched, the load balancing work that is
> submitted every 4ms can actually try to do load balancing.  The core is
> not newly idle, so active balancing could in principle occur.  But now
> nothing happens because the work is run by ksoftirqd.  The presence of
> ksoftirqd on the idle core means that the core is no longer idle.  Thus
> there is no more need for load balancing.

Thinking slightly ahead, assuming that the idle balancer realizes
the ksoftirqd is running for load balancing itself and discounts it
from consideration, won't the NUMA_IMBALANCE_MIN considered by
adjust_numa_imbalance() continue to keep the 33-31 distribution?

In both task_numa_find_cpu() [1] and calculate_imbalance() [2],
even though the scheduler classifies the local group as
"group_has_spare", with the imbalance <= NUMA_IMBALANCE_MIN which is 2,
a migration across the NUMA domains is still restricted I believe.

Can you try setting NUMA_IMBALANCE_MIN to 0 and checking if the
situation changes with the upstream kernel? I'm hoping the newidle
balance that is triggered without this series on the way to idle, is
good enough to pull the task towards itself.

Please ignore if you've already tried this. I might have missed it
when going through the original thread.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/sched/fair.c?h=v6.8&id=e8f897f4afef0031fe618a8e94127a0934896aba#n2368
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/sched/fair.c?h=v6.8&id=e8f897f4afef0031fe618a8e94127a0934896aba#n10743 

> 
> [snip..]
>

--
Thanks and Regards,
Prateek

