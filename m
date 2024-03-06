Return-Path: <linux-kernel+bounces-94626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1118C874259
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92E0F1F2409E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE51E1BC2C;
	Wed,  6 Mar 2024 22:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="UMX7N+KC"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2115.outbound.protection.outlook.com [40.107.93.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588091AAA5;
	Wed,  6 Mar 2024 22:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709762684; cv=fail; b=h2T/5jBZV4VXlM2rNCl9X2a9jsvGdsgWORAKgFb6KjC67mxqoXIq1eT2du/8QsPjnX0TR2oLExfy0+pryKV6d/ffWsVQR16DcDwcD8F+vcCDlIcGYylVGqh++VNWcmpGy7SABouqP3IKKdGtwvdrO+LUa3IeYGiQKX9enUIluPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709762684; c=relaxed/simple;
	bh=DwOUWRopia6geBEFQd4obj8RU/70oOTiu8bG/RM/BIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iKGd0//g4V9sNYHU3k0rF/OaVZ/bCeg4XubGwX9cvbjoUmd4OcoxomaVg52smlIrekSCS3fe0RcQEW1arMNqLVlnm8cRTxzHQ57CVYlMO9cbGgF85jG0U4Wdy5fH1cJ9NKNx0mi8O6cY2MZFAIoGTbYUE83fPy5NaNSBbxrsMu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=UMX7N+KC; arc=fail smtp.client-ip=40.107.93.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISGfoiAg2QasgoVlYO2fh1URpQDsQBCAcNGXtjmWzCmy9Boa1a7kpGZC1oZeWu9ip4DU1n+sstkLB32Etga4iA4vJNvRb+A/vagtsGgY8Sx/fXttMc70tnlwto5DwdsYlODgs18k9lFFBJMTVrKJnfesj8kqP+5PysSRMBaY3MDl3BQDhuJq47qXEsf0ZbYYr9e5E2MOyLGtjhNzCGShdOUmyz2c8BP26/bmFJXS9zHFTDYbaP4bRMTFaY4OVGvZM7dXOR4aTumx0nj5ZvvM+X2Xbp5EJMHLvBjuJSrB1IgvvI1GX2mQh94xlwkrFiBIo1vi4yv9KdZLWxn1W+WpNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4EG4zirOQAKODBEX5IKeURuw1GtNsJjHxeJpT8TSM0=;
 b=G2rGGsg8N5EGRJHiclxZahWLLESjqaWuuOvdxeudPZrA21mOk2mpEJXWNB1OEMPlL554fSTWZMcdSh8z8yu4zQb2F9mbix4TpDCDk0dGC/UKBemAo3dhee9NJkNBpyVWUOXZhh32NerxLC+z1ViNd8qx8m3O9dslpBfbVdDp0e1cP3HsdkCQaBJa/WU6LQFEDK2SM6P4UB5oDh6UN073FJDNvgLGAYOqo6PiRABNo50to4XWiT2DFciqLaRwj6TiJRxFkTlE2IVWyKKog31igbY0AFsEWSqffDMosNpE8tTcX8uJ7dOx9o3Bwlil5ritmHrbSlkIQblusfxYo3v5pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4EG4zirOQAKODBEX5IKeURuw1GtNsJjHxeJpT8TSM0=;
 b=UMX7N+KCSQ3bm96FGN7r627znSgQ8hlviMBaWNLJjyqZxW7YjUYXfZlBHTc5F+BGTh9zoQa5xsBPrkL+9bLJJuC8ggA00tR9aFKM3P9uWw4BcFJjc8OBcx3LerFLEdYwZEmx/yT2QZ8ZUgj5VYEzMnWhomZYcmu4f1jvZjN5RNM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6498.prod.exchangelabs.com (2603:10b6:303:79::19) by
 DS7PR01MB7832.prod.exchangelabs.com (2603:10b6:8:7f::10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.39; Wed, 6 Mar 2024 22:04:37 +0000
Received: from MW4PR01MB6498.prod.exchangelabs.com
 ([fe80::4fc3:132:87ac:c13b]) by MW4PR01MB6498.prod.exchangelabs.com
 ([fe80::4fc3:132:87ac:c13b%5]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 22:04:37 +0000
Date: Wed, 6 Mar 2024 14:04:34 -0800
From: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
To: Beata Michalska <beata.michalska@arm.com>
Cc: Huisong Li <lihuisong@huawei.com>, 
	Ionela Voinescu <ionela.voinescu@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, rafael@kernel.org, sumitg@nvidia.com, zengheng4@huawei.com, 
	yang@os.amperecomputing.com, will@kernel.org, sudeep.holla@arm.com, liuyonglong@huawei.com, 
	zhanjie9@hisilicon.com, linux-acpi@vger.kernel.org
Subject: Re: Re: [PATCH v1 1/3] arm64: topology: Add arch_freq_get_on_cpu()
 support
Message-ID: <rnkdlf2ps7zrb44y6ty7c5nmshe24mxjhajkuvzyksxxncotqo@rxx2vsachghs>
References: <20240229162520.970986-2-vanshikonda@os.amperecomputing.com>
 <ZegoMy7_BJ0Smvkl@arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZegoMy7_BJ0Smvkl@arm.com>
X-ClientProxiedBy: CH2PR19CA0012.namprd19.prod.outlook.com
 (2603:10b6:610:4d::22) To MW4PR01MB6498.prod.exchangelabs.com
 (2603:10b6:303:79::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6498:EE_|DS7PR01MB7832:EE_
X-MS-Office365-Filtering-Correlation-Id: aa542299-66e4-4a0d-41bb-08dc3e2969b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ycQSyGUHwoJ8woVU/6msBmB/U6XhXD29evyLKLedOwXfaAXb0wGG9a1tUALAa+h2FEO8BgnlWu+bM0zI6FYD89enW00GjhURoRdShtJan+OiW6N7ZtRWEVmz0U7snI+S9Fxzu1FMnY6Ze9zanMDf8xP0PaBGetvqimP+fSXPwulrAIFXiMdl5KJNxh+0cPrkMmkFufnmjMDJb+AgCLyYkrUk78Ie05lxP7ZKo6nqFhF/a78q7FGmEwfMesXLI2v3dGmzasAARHfAExUxSo5AlMf0eYyZHmy/EYU5pjqtpId/RlSqUvs0J6epQtAjxLXlKiy5Hcm0uSwmKxKU9uekO+LIs45LFml4GkH9AQP/a5G8DwzCpomkyhJtL8zHsnlfUAW6//blY6aD5Yi8HLstCPRJrI7H/qNqolHzxrT0wnQakzgReSpMtdB3j9cwUx5QVeAJfWnBiV1nd1kVPhZYAdocO7oahOgxj4GGTDosZfyna9Ledzp6jxpuriUO2FUoPWwK8HG/sLtZbKO+sZSUSgVHneQRg3OkvuX+2dh4YXdDjUc16J8pkoW9w0vuXikSsI5ZL3MasCFT/2rgLnick4Tjukemd8rdBbMEJQ3VAfSjbe0c6bF91T8+yg6c3yBl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6498.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EnMWnQIGn63wUmb3DAe35+5P4iCK4w1WDMFzSkShpH5Kj3oXT/P1bFx57xhR?=
 =?us-ascii?Q?cQONCChHg6i/LB40JrHf7Q0OREmlqrciClZKfg3uvZ9YkpJVfwFGVhBSCQiH?=
 =?us-ascii?Q?9eMKwhZvIgTuLf2IYDWjsHi9fTwJ0qBYXEPo6JUE3bqmiRhAgbNk4ydGSsgg?=
 =?us-ascii?Q?WeHzIIY5GMu9Huo3VzaRUdglsW0Bz6dU1nzvlTLCAqF9fGwgCUvzFxVFjG2l?=
 =?us-ascii?Q?Twnb6wJEo7zijpODeDpM7kJLAvLVu0fW9iP3NI768Dc5oK2KemJPoy56CryB?=
 =?us-ascii?Q?O/RyZrIUQMFoJceOPsXEYi7Wj3aDH4rzxdhHQj8EkIezbId0Xg22Rhrq+02B?=
 =?us-ascii?Q?7n0VI029dWJz48bxFlwcI+Ke0yGLJIHfQKUAEr7z71Y+CWVa0frJPPFCqSjE?=
 =?us-ascii?Q?fVOTD2Ep7TpI4dzV0OEcptE3yfj9Y5sp3hQzGz//vvUYdQ/TQIYhgDqmT6N2?=
 =?us-ascii?Q?AWJfFrOsYLYxF2dAjf4q3FVkXIgqTx3P0BxOGg87tEOBW8h1W0oHAxvtrJl1?=
 =?us-ascii?Q?erXDxyi+gRH3so5lF+xfuduzIVupiG5mgWwDLiFWXZcItigJ2dKPWsFX5mXE?=
 =?us-ascii?Q?dB/8bQbj0iZRUhw2ZD4hpeZBT4vkexbxIH081/R1Arkz4RrT1APP90BBP8zQ?=
 =?us-ascii?Q?L7on6DOlteq5bv9ApfN4p+HvucrFB59f98l+Pe1miZvtI/SFGB6HJIAUZIlS?=
 =?us-ascii?Q?Ljsy9hP0UqrTy2ydYQbI+pNprJEvnPYHtjAGEv2UhYR2zHFM1/N9Xob3+WBU?=
 =?us-ascii?Q?RPkD6LfR9DlLnreu/RXSr9pUNlIIvzx0qgybNqPmk4LwAi6QpJJ7VBYfG7RT?=
 =?us-ascii?Q?i81XHD73qX+7cOB7Pr47IFsKkkhIt6kELJau8t76S5QDg0eyNc6hKRjFdBe9?=
 =?us-ascii?Q?X9zzW7N/nw5unTaOJKFnuCzoSJ5KvBny7T3mIBdINZy+ckGJXDUo86UrbAOL?=
 =?us-ascii?Q?OdjWiSlAomNKjKE+IEMHqT4UcEhJOJxlO8hA8oAQzUHV26iHaHufnYw6Wist?=
 =?us-ascii?Q?Mf1YNkK/plUq9+eSJp9QTes/enZio8wqTHnKGUyUd6TiYaIMfualsxNsv1MJ?=
 =?us-ascii?Q?fFRz9sTuPC5S5s54q2+k3nnQKpOb5jTGcAS2Qc2pbU/f8DpMYzjmdL3VcY3a?=
 =?us-ascii?Q?b6GrV/wC+2mRw5AB6vvvwtJv0QtX8+G5siz/WTf1WmFSM5zdpJR11nduyOH1?=
 =?us-ascii?Q?dYpDaCIbgdBYL884FK9VacupSy1JYYdPYtZCzU1PF4cFXQEqscyaDm+YpGxt?=
 =?us-ascii?Q?68iYoIEKghsv8QBE7MolFGn15kDkQORlN6I5GgiO3Ipn/rjozS0iDJMNU+vD?=
 =?us-ascii?Q?eul99ZDxc5c5dJW6ZXgswuD1M+xGiigpaVmqc2u8J2ANuUr8aP64oPElvFek?=
 =?us-ascii?Q?byzJvV1mx7ingUuePnTmbzwQiDmBxV0iNgaHuzt+lZBBX6VZswrSyaJeja6R?=
 =?us-ascii?Q?TONqRZfrKQ/szg7Jw0M8DHYkCINjEF4Si7k11gnZ6S5xFURSwQ+MF+rKhzTo?=
 =?us-ascii?Q?U5RYgkcaV/bSce+v622tLP6aCGr94e93JNhbbCJJfFDccNpkHQVzCVhEiUQc?=
 =?us-ascii?Q?rQzYJTZytj39Mw5CPdQz9qZoL16LqBZf/Cf6FMdJVyKVbin1xsSN5ArmR0bJ?=
 =?us-ascii?Q?92ozohP1V2U0V5JwKY7kDd8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa542299-66e4-4a0d-41bb-08dc3e2969b7
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6498.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 22:04:37.0132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hxhSBboiDP/rUa5JGsRV6opZAyYm3pQo4PL4z5ZJNwvgBH5uCv5+lz3DsStNfVT2HH1j5ADLBTrj81V/+6tsACSiuqTdpxcC6QWBUrIT0mg2FnGedpmxJsMdwVduC0g6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR01MB7832

On Wed, Mar 06, 2024 at 09:24:19AM +0100, Beata Michalska wrote:
>
>Hi Vanshidhar,
>
>On Thu, Feb 29, 2024 at 08:25:13AM -0800, Vanshidhar Konda wrote:
>> AMU counters are used by the Frequency Invariance Engine (FIE) to
>> estimate the CPU utilization during each tick. The delta of the AMU
>> counters between two ticks can also be used to estimate the average CPU
>> frequency of each core over the tick duration. Measure the AMU counters
>> during tick, compute the delta and store it. When the frequency of the
>> core is queried, use the stored delta to determine the frequency.
>>
>> arch_freq_get_on_cpu() is used on x86 systems to estimate the frequency
>> of each CPU. It can be wired up on arm64 for the same functionality.
>>
>> Signed-off-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
>> ---
>>  arch/arm64/kernel/topology.c | 114 +++++++++++++++++++++++++++++------
>>  1 file changed, 96 insertions(+), 18 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
>> index 1a2c72f3e7f8..db8d14525cf4 100644
>> --- a/arch/arm64/kernel/topology.c
>> +++ b/arch/arm64/kernel/topology.c
>> @@ -17,6 +17,8 @@
>>  #include <linux/cpufreq.h>
>>  #include <linux/init.h>
>>  #include <linux/percpu.h>
>> +#include <linux/sched/isolation.h>
>> +#include <linux/seqlock_types.h>
>>
>>  #include <asm/cpu.h>
>>  #include <asm/cputype.h>
>> @@ -82,20 +84,54 @@ int __init parse_acpi_topology(void)
>>  #undef pr_fmt
>>  #define pr_fmt(fmt) "AMU: " fmt
>>
>> +struct amu_counters {
>> +	seqcount_t	seq;
>> +	unsigned long	last_update;
>> +	u64		core_cnt;
>> +	u64		const_cnt;
>> +	u64		delta_core_cnt;
>> +	u64		delta_const_cnt;
>> +};
>It still might not be necessary to track both last taken sample and deltas from
>previous ones, see[1].
>I could send v3 of [1] and take into account the changes you have suggested here,
>namely the last tick recorded. Otherwise few comments below.

For this specific patch it might suffice to just track the deltas. The
reason for storing the core_cnt/const_cnt values is for the case where
CPU is idle and we are trying to read the read the counters through CPPC
FFH - see patch 3 of this series.

One of the drawbacks of updating/merging just [1] as a standalone patch is
that it doesn't cover idle or isolated CPUs. This patch series accounts
for those cases as well. I'm open to suggestions on how we can make that
happen with [1].

I tested v2 of [1] on AmpereOne system and noticed that there were some
inconsistent measurements reported - see [2]. I think that might be due to
frequency scale not being updated when CPU goes idle.

>> +
>>  /*
>>   * Ensure that amu_scale_freq_tick() will return SCHED_CAPACITY_SCALE until
>>   * the CPU capacity and its associated frequency have been correctly
>>   * initialized.
>>   */
>> -static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, arch_max_freq_scale) =  1UL << (2 * SCHED_CAPACITY_SHIFT);
>> -static DEFINE_PER_CPU(u64, arch_const_cycles_prev);
>> -static DEFINE_PER_CPU(u64, arch_core_cycles_prev);
>> +static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, arch_max_freq_scale) =
>> +	1UL << (2 * SCHED_CAPACITY_SHIFT);
>> +static DEFINE_PER_CPU_SHARED_ALIGNED(struct amu_counters, cpu_samples) = {
>> +	.seq = SEQCNT_ZERO(cpu_samples.seq)
>> +};
>>  static cpumask_var_t amu_fie_cpus;
>>
>>  void update_freq_counters_refs(void)
>>  {
>> -	this_cpu_write(arch_core_cycles_prev, read_corecnt());
>> -	this_cpu_write(arch_const_cycles_prev, read_constcnt());
>> +	struct amu_counters *cpu_sample = this_cpu_ptr(&cpu_samples);
>> +	u64 core_cnt, const_cnt, delta_core_cnt, delta_const_cnt;
>> +
>> +	const_cnt = read_constcnt();
>> +	core_cnt = read_corecnt();
>> +
>> +	if (unlikely(core_cnt < cpu_sample->core_cnt) ||
>> +	    unlikely(const_cnt < cpu_sample->const_cnt)) {
>> +		WARN(1, "AMU counter values should be monotonic.\n");
>> +		cpu_sample->delta_const_cnt = 0;
>> +		cpu_sample->delta_core_cnt = 0;
>Not sure if zero-ing is really necessary here

I can remove that for the next version.

>> +		return;
>> +	}
>> +
>> +	delta_core_cnt = core_cnt - cpu_sample->core_cnt;
>> +	delta_const_cnt = const_cnt - cpu_sample->const_cnt;
>> +
>> +	cpu_sample->core_cnt = core_cnt;
>> +	cpu_sample->const_cnt = const_cnt;
>> +
>> +	raw_write_seqcount_begin(&cpu_sample->seq);
>> +	cpu_sample->last_update = jiffies;
>> +	cpu_sample->delta_const_cnt = delta_const_cnt;
>> +	cpu_sample->delta_core_cnt = delta_core_cnt;
>> +	raw_write_seqcount_end(&cpu_sample->seq);
>>  }
>>
>>  static inline bool freq_counters_valid(int cpu)
>> @@ -108,8 +144,7 @@ static inline bool freq_counters_valid(int cpu)
>>  		return false;
>>  	}
>>
>> -	if (unlikely(!per_cpu(arch_const_cycles_prev, cpu) ||
>> -		     !per_cpu(arch_core_cycles_prev, cpu))) {
>> +	if (unlikely(per_cpu_ptr(&cpu_samples, cpu) == NULL)) {
>>  		pr_debug("CPU%d: cycle counters are not enabled.\n", cpu);
>>  		return false;
>>  	}
>> @@ -152,19 +187,15 @@ void freq_inv_set_max_ratio(int cpu, u64 max_rate)
>>
>>  static void amu_scale_freq_tick(void)
>>  {
>> -	u64 prev_core_cnt, prev_const_cnt;
>> -	u64 core_cnt, const_cnt, scale;
>> -
>> -	prev_const_cnt = this_cpu_read(arch_const_cycles_prev);
>> -	prev_core_cnt = this_cpu_read(arch_core_cycles_prev);
>> +	struct amu_counters *cpu_sample = this_cpu_ptr(&cpu_samples);
>> +	u64 delta_core_cnt, delta_const_cnt, scale;
>>
>>  	update_freq_counters_refs();
>>
>> -	const_cnt = this_cpu_read(arch_const_cycles_prev);
>> -	core_cnt = this_cpu_read(arch_core_cycles_prev);
>> +	delta_const_cnt = cpu_sample->delta_const_cnt;
>> +	delta_core_cnt = cpu_sample->delta_core_cnt;
>>
>> -	if (unlikely(core_cnt <= prev_core_cnt ||
>> -		     const_cnt <= prev_const_cnt))
>> +	if ((delta_const_cnt == 0) || (delta_core_cnt == 0))
>>  		return;
>>
>>  	/*
>> @@ -175,15 +206,62 @@ static void amu_scale_freq_tick(void)
>>  	 * See validate_cpu_freq_invariance_counters() for details on
>>  	 * arch_max_freq_scale and the use of SCHED_CAPACITY_SHIFT.
>>  	 */
>> -	scale = core_cnt - prev_core_cnt;
>> +	scale = delta_core_cnt;
>>  	scale *= this_cpu_read(arch_max_freq_scale);
>>  	scale = div64_u64(scale >> SCHED_CAPACITY_SHIFT,
>> -			  const_cnt - prev_const_cnt);
>> +			  delta_const_cnt);
>>
>>  	scale = min_t(unsigned long, scale, SCHED_CAPACITY_SCALE);
>>  	this_cpu_write(arch_freq_scale, (unsigned long)scale);
>>  }
>>
>> +/*
>> + * Discard samples older than the define maximum sample age of 20ms. There
>> + * is no point in sending IPIs in such a case. If the scheduler tick was
>> + * not running then the CPU is either idle or isolated.
>> + */
>> +#define MAX_SAMPLE_AGE	((unsigned long)HZ / 50)
>This depends on the config, so for HZ_1000 it will indeed give 20ms,
>for CONFIG_250 that will be 5ms. It might be better to set it to number of
>expected missed ticks instead ? Or amend the comment.

I think using jiffies/missed ticks is probably better. I'll update for
next version.

>> +
>> +unsigned int arch_freq_get_on_cpu(int cpu)
>> +{
>> +	struct amu_counters *cpu_sample = per_cpu_ptr(&cpu_samples, cpu);
>> +	u64 delta_const_cnt, delta_core_cnt;
>> +	unsigned int seq, freq;
>> +	unsigned long last;
>> +
>> +	if (!freq_counters_valid(cpu))
>> +		goto fallback;
>> +
>> +	do {
>> +		seq = raw_read_seqcount_begin(&cpu_sample->seq);
>> +		last = cpu_sample->last_update;
>> +		delta_core_cnt = cpu_sample->delta_core_cnt;
>> +		delta_const_cnt = cpu_sample->delta_const_cnt;
>> +	} while (read_seqcount_retry(&cpu_sample->seq, seq));
>> +
>This seems to be taken from APERF/MPERF relevant code. Including the comments.

Yes. The idea for this patch series is based on APERF/MPERF which are
quite similar to AMU counters.

>> +	/*
>> +	 * Bail on invalid count and when the last update was too long ago,
>> +	 * which covers idle and NOHZ full CPUs.
>> +	 */
>> +	if (!delta_const_cnt || ((jiffies - last) > MAX_SAMPLE_AGE)) {
>Shouldn't the first condition (non-zero increase of cnt_cycles counter)
>disqualify the sample taken altogether ?

I was updating delta_*_cnt values to 0 in one case above. If we just
drop that sample and don't set delta_*_cnt values to 0 we wouldn't need
this check. I will remove that in the next version.

>> +		if (!(housekeeping_cpu(cpu, HK_TYPE_TICK) && idle_cpu(cpu)))
>> +			goto fallback;
>Not entirely convinced that this condition is what is expected ?
>For housekeeping cpu that is not idle it will still resolve to AMU counters,
>not sure if that's what was intended ?

For a CPU that is not idle my preference is that it uses AMU counters
for frequency measurement. For idle and isolcpus we fallback to the CPPC
mechanism - which could be through MMIO or PCC.

>Also, for cases when given cpufreq policy spans more than a single core, the
>frequency might be queried based on relevant CPU that might have seen the tick
>within specified timeframe (see [1])
>

This would not be ideal. On Ampere systems I've not come across a
cpufreq policy that spans multiple cores, so I overlooked that
configuration.

>> +	}
>> +
>> +	/*
>> +	 * CPU frequency = reference perf (in Hz) * (/\ delivered) / (/\ reference)
>> +	 * AMU reference performance counter increment rate is equal to the rate
>> +	 * of increment of the System counter, CNTPCT_EL0 and can be used to
>> +	 * compute the CPU frequency.
>> +	 */
>> +	return div64_u64((delta_core_cnt * (arch_timer_get_rate() / HZ)),
>/HZ/HZ_PER_KHZ ?
>> +			 delta_const_cnt);
>> +
>> +fallback:
>> +	freq = cpufreq_quick_get(cpu);
>> +	return freq ? freq : cpufreq_get_hw_max_freq(cpu);
>If the arch specific code cannot determine the frequency it should actually make
>it clear by returning '0' instead of trying to patch things up by itself (?)
>

This was following the same logic as APERF/MPERF logic. Returning 0 from
here would result in a call to cpufreq_driver->get() vs a call to
cpufreq_quick_get(). The only difference I can tell is that
cpufreq_quick_get() will call read_lock_irqsave() before calling
cpufreq_driver->get(). I don't have enough knowledge to point out
which one is more appropriate. Following the same logic as the x86
implementation seemed more prudent.

>Overall I'd prefer to revive [1] and amened it accordingly instead.
>

As mentioned earlier, I'm ok with what leads to a coherent solution for
all the configurations we have - isolcpus, idle and active in
housekeeping_cpus.

This issue impacts existing Ampere products. It would be great if we
could arrive at a solution soon.

>---
>[1] https://lore.kernel.org/all/20231127160838.1403404-1-beata.michalska@arm.com/
[2] - https://lore.kernel.org/all/7eozim2xnepacnnkzxlbx34hib4otycnbn4dqymfziqou5lw5u@5xzpv3t7sxo3/

Thanks for the discussion.

Vanshi

>---
>Best Regards
>Beata
>> +}
>> +
>>  static struct scale_freq_data amu_sfd = {
>>  	.source = SCALE_FREQ_SOURCE_ARCH,
>>  	.set_freq_scale = amu_scale_freq_tick,
>> --
>> 2.43.1
>>

