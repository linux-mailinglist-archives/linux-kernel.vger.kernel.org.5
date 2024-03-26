Return-Path: <linux-kernel+bounces-118319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 910E488B7F2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 04:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B369C1C2CD3C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 03:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4063112839F;
	Tue, 26 Mar 2024 03:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SoWhG0VQ"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA511C6A8
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 03:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711422398; cv=fail; b=POBjFJUmMbHUjPu7rrClSvzDO/hy8vopQH4mwrjxJMDChM1zhvwNdAbjY/WeuBYmZ24uPyC1RL0VVB36XggP2taqjTeWoNbAM8SYXFrHAJFuTOdp90KylQsPH/FfN2XqmrFrLKO0J2mfuqxXu2Grmw/KLRyiOoRZO9Uo+Lpl520=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711422398; c=relaxed/simple;
	bh=A+RhczIxy4So156mgp932mswvDB7MNy1wHRuKOZH2Pg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qyFkflcAercor5KWnh4YNhRzYxzHVTjkU6mbbxSypXxoXhYgYvCatWGfeCKv7rIRZ4GfR9LNKQQ2CyLDAsGShFJCdb37ipiCQ6CaK2xKC5UunIyi4Z3UnG6BRn6ofoqAjCSLtXOt6/cZf7mqCCiLSRj42mk7eEUsUSHuxvuTUz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SoWhG0VQ; arc=fail smtp.client-ip=40.107.236.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmWWgCMSpRVgc0pcJzYE73V321p/fIA+6yp54AWUt8sDilDCJeMeuKrgFj7TkoIjh9UCKbybC4Kg/IEgMI5e5UkYvy6wc+4vcuNsTU5PrHCiCWJ1Q6S31Up1g8DMXMVmkWFHcqG8iAKaUqaJvQjYRxxna/4MU1jHbZ32Oqr+JXFwcG0bNBnbv1luY4AjarkqiUEog+OnEgNF1lgqCsePLYXcgmWGXLy9HxEYw3huTt14qf5kGqdzABR5C1WARbeCIqMyFyjlRCXR53AGR9P2KsR4cSox9d8ggvDLXlv7vV1HvBM7Sn6MBB/D0eB2uOi2WUWrL3jj+dhwup95WH6XEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qbf4TAhPtY94IuHiDjj3ZI71b3fJwxQ4hF/fvNhqfZQ=;
 b=XQ1nItOeR6xIaVTrOwyJcqLhJ5nT8lzED3hOsFExPxn5fO57kqg45l6si3Ks/JNJGR8/bM1Ht5+q77D5fOro4mGBcyjhka+piP1vZMhWBpCzFVdkm/41wRDs5b0CjGI9q+vHazEU83FNYFpBkQ3ji9cheETT6k0QHz4Uo3O/uvjE31xKbhk66bDQR0ACc+ecaI2TFcA/sY4d16gd3IFAJrmZ3Z9rKfJvMFQCpgEVRddgIbmJQD6XwBxVUJ6fKBYed8vYvt86swmYxfKKzD5rwKa9nl6yojIn8C9HodlOLWoE5QxhP97ZVazS8zwvLXMyBxhSHKZwF4WT5ijE2u/z1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qbf4TAhPtY94IuHiDjj3ZI71b3fJwxQ4hF/fvNhqfZQ=;
 b=SoWhG0VQTbLn1nRJ8H0Ofbo6MFuog0v5SsAeimqwFigMj2Ah9vzfXtKTbJGqusx5mjcDEzqJqsVLJIRYkSrCjXL5VUlAWuxai2yDqiPGgrPqlw7+7JHQTckCNG2sBwZRVMVQ5PNMTeI/ltYkE9joO9gPCTg+q1tzoC21uwxtAxs=
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by SJ2PR12MB8873.namprd12.prod.outlook.com (2603:10b6:a03:53d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 03:06:33 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::494b:99e2:884a:dca1]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::494b:99e2:884a:dca1%3]) with mapi id 15.20.7409.028; Tue, 26 Mar 2024
 03:06:32 +0000
Message-ID: <f59c92ff-259b-5b89-9af5-fcaefccd4b23@amd.com>
Date: Tue, 26 Mar 2024 08:36:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH 1/1] sched/eevdf: Skip eligibility check for current
 entity during wakeup preemption
Content-Language: en-US
To: Youssef Esmat <youssefesmat@chromium.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, Tobias Huschle <huschle@linux.ibm.com>,
 Luis Machado <luis.machado@arm.com>, Chen Yu <yu.c.chen@intel.com>,
 Abel Wu <wuyun.abel@bytedance.com>, Tianchen Ding
 <dtcccc@linux.alibaba.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>
References: <20240325060226.1540-1-kprateek.nayak@amd.com>
 <20240325060226.1540-2-kprateek.nayak@amd.com>
 <CA+q576OCK24VSp+s4OLD2ogO48i95y39_JO=zV=TwHSEg3_b1w@mail.gmail.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CA+q576OCK24VSp+s4OLD2ogO48i95y39_JO=zV=TwHSEg3_b1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::7) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|SJ2PR12MB8873:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DsYstYz29QLhNAKoCC0Kuc/Qjg0DzJM5LoA6vHgiTtSTvL5KpDXBLwWIDj8/frQanFCSiO81tsmztGPafE9lkPRY2vriaVbmoA3W/g1cJgaFEtjT3kc6zxrmgAPrwtQ6VGjVYm1JvPaxq+6yD/c4sZEH6xwTFA1niT9PeaNw68Q9REJLdl+cFGMMj5iwIXxDFsuEJFI2gA9afKqb8AKUAW9GuBUEzwJjJqErP3rrVP0/EBfN9py1P7r7JgmdBcyLiZ+UWS+Xt3o/2u47hUPHvbKegOf5uf/npQ7oX4tTSi2PhJnjtomNrmxT3aI/nvmlGZ/nEwHmDkxkt31A78L+lXatJ8LOTlNu24ZBXIvmFdyvIfn1gycd+E1B2nwQXyHo9R/xMuBCaY0dJfxRar/wRAu/U+V9kcEDrhmTXf+xLpx1G4J6yrIJY+ASNS9SVrsTLvJ1tziyrvSSKa+BPzedlR6KKfet0q6HsjQKy0vGeOpzTpberqk8NltiDmH/1FY3WdBGXFQZvQN7pG4bfqJRZmwzNZklW9EjUCczh0ePIRMFV41b/Dt9AW1GQrktGZtUAfwxSwC221bIdfme1bWqUYMVvEwVNUC6qFrPmn46NLWBEMPJEONujDXWKk5D6kzw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RThQU29ISjlOdHZtcW1pNHhwdG1Cc3ZuK0tERCtDd1VmVnMrWmZ0QzhOQ1RZ?=
 =?utf-8?B?OTE1WXpmd2NPNk16VmlBSFc5blRySHFBNnM4dG5LaVRYaEZMeVcyU2l2RVZM?=
 =?utf-8?B?bjBsYXNHcitVcnJQdVkxL2ZYblZTa2NqSlVqRUpNYStENXl5QmNrOHNjLy8w?=
 =?utf-8?B?Zi9BSzdaeDNuelo5ci8zZTg2UjZnNGl2b1k2RE1ESUV4NDJPdU5jQkZPSGdQ?=
 =?utf-8?B?eVlkUVg3K0VjSzVMSGxHOEE4TGpqQkh1OVMvZ1NiUEpCcjhLYUJJZGMxaHZ5?=
 =?utf-8?B?bGNPSTBKdy91amI4d3N5MWdURWk0aTZPYVN0bCttRjJWbEVZNXNIczZtRUQw?=
 =?utf-8?B?QzdZYzJLSElaaGdZZW4yRHgzajdLSGZCUXM2cnFhOExHYzV3TTFNTG5ERllH?=
 =?utf-8?B?UXF5RWUyS1RDQUMzSHFsaG05TFJMK2NqRHpyOWhDQmUxdnJ5SDhhQ2IwSWhH?=
 =?utf-8?B?SGxTU3pZTWN0VHRPeGpjNlc3U2xzaEptbW0yME52MUNVL1F2VVhJWDBCNW1I?=
 =?utf-8?B?TG5pa2hhdVlmWi8wUnRqaU9ubDI0c2NVZVZxbS9yNmVtcFdLTkxhN0lqeU1Q?=
 =?utf-8?B?V0c3eTl4eVphOGY5c1dXWEZCNFlET1RLU28ybElKS3lyZHY0QWtPQThOLzFP?=
 =?utf-8?B?U21ncTY5Nkxlclh0dzh1OUsyMkt0dHcveGhUbkpXcVkxK0Y5Vld1R1prRjJ6?=
 =?utf-8?B?YUhnWGYxb2l1TUkzMFZ2Vk1teWVUYlBvbGZjdjlrTVZxT0xGVGxzWFFuZUFF?=
 =?utf-8?B?RTJtOHU0MEp3UU5OR0xOdFNLTEE2cWptN3c1MncwbmgrSll3RVBjd25aeW9y?=
 =?utf-8?B?dlBKUHBZME0vdUFrMFgraTlwUzNmRzdSbFNUUGZ0Wi9mVUhDREN0b2I2TzRZ?=
 =?utf-8?B?UEZxemlOa0FLSzJYWWc4T2FMZjlacGxnMjBqMGwvYnFMUWR4WjFPaWV1aDl2?=
 =?utf-8?B?LzFCcWRIejJMQ25RME1pV3BFZWpjQ0RmajZOVkdvTG8xdUVtS1cyRjc1SEw0?=
 =?utf-8?B?K2VoZG5SaHJuR3hpWE9FWEdheEZtN3lBUFR3TzJ5WnRCQWFQNWthaFBkT3I4?=
 =?utf-8?B?b0h2MUJZVTVVKzFUc1BYRmt6MCtGVWJWWXpyRStFcncwa2dWMk5NemprUlBy?=
 =?utf-8?B?ZWV2MXRqQTZNczU2bHRBVE1VTDBHV0dDZFM2OWI0ckowZzBCRm1jSGdRN1dY?=
 =?utf-8?B?Ukd3VHZuUTRsV1ErMk9pMTBTK3ZtOWk4a09DbHFXalh5WGVYT3VkT2piMzda?=
 =?utf-8?B?aFlSMlBESkswRzB2MmtvZE91c2NDQzJNajZiMUk2WUk3TU9DMlVsdGJMdTRV?=
 =?utf-8?B?bit2V2tDMW9uWmpyb2Z2MVN1OUt6WGZTeGUybVZKVXpKVkFwUlU5dEJ0aFlz?=
 =?utf-8?B?OUdUZm10RXdIaWZpV1gxa2NidFRHamtUamJENFdFVnROWExtV2dmMFRTZjhK?=
 =?utf-8?B?NjFBeE1qQ004MUxCZXJWVzRUOE5jbFAvUmNvSDkvN1pZTkszdWlvd0JxY3lR?=
 =?utf-8?B?WFdrL3hnQkVrb1VFQzdnMExpQWpMSGt1eVllREpXV3FjT2FvN2RiYUtyOTNW?=
 =?utf-8?B?WE9sM2dmNVlPc0YyWUV3MUtkNDkvWDhvdlIvM09QaUNDQ2piOG1kbkZzWDZQ?=
 =?utf-8?B?THZCSEtQSUZhbHZHL0J1YTZrekVVVnBUZDQ3dGpmNDZpdktXbmJYajRvVVBo?=
 =?utf-8?B?Zi9hNVZEZ1JGTlVxS0tGV1ZtRkFxTGo5UmRZM05yWDNuYmFHZ0xiUEttUVZX?=
 =?utf-8?B?cHovKzAyVlExVDRnRkFyRjhsK1FzZU9GMWkvUW5zcmp0SkZVem9FVHBTaG52?=
 =?utf-8?B?MDIwQUVncElHcmZCRUYzUWlOb3BGNWlMSUJ6eFpzNmNKYmZnczZqVFRKRHQ4?=
 =?utf-8?B?bXFWeDIxcTNDMVpaZ0V2WStjNTRVYWJweDJvcWJSL3ByMm0wL2Vma05EeUc1?=
 =?utf-8?B?OGZWSHprZVlqVGJwM29McFBrQXhSdkx3dFQzYU0wN3ZoS1E3VDFVTmxMcC9C?=
 =?utf-8?B?d2Y1QlYwYkorSGpTa1NCdmZQcEtlZUlEMXhNQ21GaFdITVcvUHNTczZaQStJ?=
 =?utf-8?B?U01xZ3lEcTAwT1NHWHJqeFhRdnZNdEZlb29LTGR2ZVM2ZFR3Y3NFakxGNWxj?=
 =?utf-8?Q?JNBtsmMor9CCefOA7h1C7SHEG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3cd61d-ac79-47d0-3d38-08dc4d41bd03
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 03:06:32.0458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b0e68Q8s1EIB85wIiFTw775gYvKyMaUfUJ2H6QbWAYXJy6ImkdToMU56aHJT+zkWY0cMBW7pMEFA/DIM3hzLzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8873

Hello Youssef,

On 3/25/2024 8:43 PM, Youssef Esmat wrote:
> On Mon, Mar 25, 2024 at 1:03 AM K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>>
>> With the curr entity's eligibility check, a wakeup preemption is very
>> likely when an entity with positive lag joins the runqueue pushing the
>> avg_vruntime of the runqueue backwards, making the vruntime of the
>> current entity ineligible. This leads to aggressive wakeup preemption
>> which was previously guarded by wakeup_granularity_ns in legacy CFS.
>> Below figure depicts one such aggressive preemption scenario with EEVDF
>> in DeathStarBench [1]:
>>
>>                                 deadline for Nginx
>>                    |
>>         +-------+  |                    |
>>     /-- | Nginx | -|------------------> |
>>     |   +-------+  |                    |
>>     |              |
>>     |   -----------|-------------------------------> vruntime timeline
>>     |              \--> rq->avg_vruntime
>>     |
>>     |   wakes service on the same runqueue since system is busy
>>     |
>>     |   +---------+|
>>     \-->| Service || (service has +ve lag pushes avg_vruntime backwards)
>>         +---------+|
>>           |        |
>>    wakeup |     +--|-----+                       |
>>  preempts \---->| N|ginx | --------------------> | {deadline for Nginx}
>>                 +--|-----+                       |
>>            (Nginx ineligible)
>>         -----------|-------------------------------> vruntime timeline
>>                    \--> rq->avg_vruntime
>>
>> When NGINX server is involuntarily switched out, it cannot accept any
>> incoming request, leading to longer turn around time for the clients and
>> thus loss in DeathStarBench throughput.
>>
>>     ==================================================================
>>     Test          : DeathStarBench
>>     Units         : Normalized latency
>>     Interpretation: Lower is better
>>     Statistic     : Mean
>>     ==================================================================
>>     tip         1.00
>>     eevdf       1.14 (+14.61%)
>>
>> For current running task, skip eligibility check in pick_eevdf() if it
>> has not exhausted the slice promised to it during selection despite the
>> situation having changed since. The behavior is guarded by
>> RUN_TO_PARITY_WAKEUP sched_feat to simplify testing. With
>> RUN_TO_PARITY_WAKEUP enabled, performance loss seen with DeathStarBench
>> since the merge of EEVDF disappears. Following are the results from
>> testing on a Dual Socket 3rd Generation EPYC server (2 x 64C/128T):
>>
>>     ==================================================================
>>     Test          : DeathStarBench
>>     Units         : Normalized throughput
>>     Interpretation: Higher is better
>>     Statistic     : Mean
>>     ==================================================================
>>     Pinning      scaling     tip            run-to-parity-wakeup(pct imp)
>>      1CCD           1       1.00            1.16 (%diff: 16%)
>>      2CCD           2       1.00            1.03 (%diff: 3%)
>>      4CCD           4       1.00            1.12 (%diff: 12%)
>>      8CCD           8       1.00            1.05 (%diff: 6%)
>>
>> With spec_rstack_overflow=off, the DeathStarBench performance with the
>> proposed solution is same as the performance on v6.5 release before
>> EEVDF was merged.
> 
> Thanks for sharing this Prateek.
> We actually noticed we could also gain performance by disabling
> eligibility checks (but disable it on all paths).
> The following are a few threads we had on the topic:
> 
> Discussion around eligibility:
> https://lore.kernel.org/lkml/CA+q576MS0-MV1Oy-eecvmYpvNT3tqxD8syzrpxQ-Zk310hvRbw@mail.gmail.com/
> Some of our results:
> https://lore.kernel.org/lkml/CA+q576Mov1jpdfZhPBoy_hiVh3xSWuJjXdP3nS4zfpqfOXtq7Q@mail.gmail.com/
> Sched feature to disable eligibility:
> https://lore.kernel.org/lkml/20231013030213.2472697-1-youssefesmat@chromium.org/
> 

Thank you for pointing me to the discussions. I'll give this a spin on
my machine and report back what I see. Hope some of it will help during
the OSPM discussion :)

>>
>> This may lead to newly waking task waiting longer for its turn on the
>> CPU, however, testing on the same system did not reveal any consistent
>> regressions with the standard benchmarks.
>>
>> Link: https://github.com/delimitrou/DeathStarBench/ [1]
>> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
>> ---
>>  [..snip..]
>>
 
--
Thanks and Regards,
Prateek

