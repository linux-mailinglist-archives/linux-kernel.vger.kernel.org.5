Return-Path: <linux-kernel+bounces-77293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0683A860356
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22EBB1C2479C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98626AFB9;
	Thu, 22 Feb 2024 19:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="bLVAYb4h"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2116.outbound.protection.outlook.com [40.107.244.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40CD14B815;
	Thu, 22 Feb 2024 19:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708631759; cv=fail; b=jDSLO4Y864orbdH8poAtAkzm4lb+00Ww2HVzkeWoNQ2Z903QsVAdKQXn10/9loXoyIFgSinzAqhLBVGTkPhqgGX5fKIAgJ5SYaLAAGpRW97KZyBWj4TYzYp9iiIL+L8fmyZQOtszcwFNIU3azavFz/X6JaDI9Jvda56eJWB5ki4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708631759; c=relaxed/simple;
	bh=Oniqns53hIeXJo6DmyGOgYB8wduliu2yAzJHQ7c0dTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ptWMz45j3l0RVh3fp+UV24SKjWsz4G4RR1rlEvkKsdafFnztCCeNwijjXTTDnWopVjHIu+bmwsGeVKN3+kM4F7G68Dh3AaHBFu4fveIdHNfOQ4aLs55tZRt83TN8w//THsV8TDEsgSpEKJGzOYa/VnlLwuirneknH03rBHI7C2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=bLVAYb4h; arc=fail smtp.client-ip=40.107.244.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hurC6ZdXYtuYBYlCD0CGBs8OlgZeim5rNbFuOQEs/DLYRn6nVcTKW62QExHuEsdpcZlsRrNVnqBYz4Y9VLIYm88ox8Wkp8Qweooc+V5PStZw9B14uSHTmW3x0nnuJHncZYiRbT5uGDGo1dt4neDblN/Qdtue2b89JKQOgVKB7RhCv7jaK6GnRNgrMUIiM8ZWKxtxVbEFPGyaygo++Lxcds4+ljKrW1BmLrLXvFnwCV4RiBiRBKmonEsBFmb0fFiBEMLMxppVveL26vMUAGdR7/eVtsH1nXCzojShSBl7YPINxw3lypz3jO/qXSUsuAcKctfjxwXJwPE4SZiNqPgaBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMEjA9/kDkQWgO6M8rlKsmNBddzfz1XmNHUTwUkdBck=;
 b=dy0/vhxgKI89KsCtXPorbi7Y9rkEX35TBbuOGsU2LpUagpo3QjBKdxj82NvcSPvEEDWvjbbJda6Q+olsYEVzKVB2XQqxyPN/1w47p32GgpuKDQbhPLxvVZu5334ed3IvB5v1klfLSmq7vZ4Y0iO5VEcYyvTQr7fQf1bp7P10TTPgDBagrEjU9UCvZAw0JuD2wJmgzFkPXkcyeID3oiAO5+N0NkBQNV1PTReVaMTgwn9M8PmWMIvIhN2duZiJdWFHdXoabPNkiSalaHSXmWL6i54gJHUR8dDKqFcrL3u1nU1ioumxsE+m+W9zdCPkZsdkuZBLdfcY9Omf6qcOXZ7saQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMEjA9/kDkQWgO6M8rlKsmNBddzfz1XmNHUTwUkdBck=;
 b=bLVAYb4hdnAzZYFxQ2jxRcc0eyznZsbfZcsdMo1XLafd/GEHtsyBmA2nIQic6sJweqWjGRALsN+N9/+BPWX/74m0tL6UeBfaj7THLI+AivwhyjveXboUt1ahIMebkcjJHdPmdUMdcZ7y7Rxg8Sd17Gu5tUrON45fFvuQLJMGlLI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6498.prod.exchangelabs.com (2603:10b6:303:79::19) by
 SJ0PR01MB6127.prod.exchangelabs.com (2603:10b6:a03:290::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.24; Thu, 22 Feb 2024 19:55:55 +0000
Received: from MW4PR01MB6498.prod.exchangelabs.com
 ([fe80::7c00:4415:9732:a74b]) by MW4PR01MB6498.prod.exchangelabs.com
 ([fe80::7c00:4415:9732:a74b%4]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 19:55:55 +0000
Date: Thu, 22 Feb 2024 11:55:51 -0800
From: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
To: Beata Michalska <beata.michalska@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, sumitg@nvidia.com, sudeep.holla@arm.covm, will@kernel.org, 
	catalin.marinas@arm.com, viresh.kumar@linaro.org, rafael@kernel.org, 
	ionela.voinescu@arm.com, yang@os.amperecomputing.com, linux-tegra@vger.kernel.org, 
	Sudeep Holla <sudeep.holla@arm.com>, lihuisong@huawei.com
Subject: Re: [PATCH v2 1/2] arm64: Provide an AMU-based version of
 arch_freq_get_on_cpu
Message-ID: <7eozim2xnepacnnkzxlbx34hib4otycnbn4dqymfziqou5lw5u@5xzpv3t7sxo3>
References: <20231127160838.1403404-1-beata.michalska@arm.com>
 <20231127160838.1403404-2-beata.michalska@arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231127160838.1403404-2-beata.michalska@arm.com>
X-ClientProxiedBy: CH0PR08CA0029.namprd08.prod.outlook.com
 (2603:10b6:610:33::34) To MW4PR01MB6498.prod.exchangelabs.com
 (2603:10b6:303:79::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6498:EE_|SJ0PR01MB6127:EE_
X-MS-Office365-Filtering-Correlation-Id: 8172d936-75a8-4b7c-0452-08dc33e047d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JmSN94IdBBXFK+10XhQrIIX595RN3SiPYv47lQZl2d1AHkH8qaKX7KuV8fafGk40QNOzC/HqyjKOAM/OUM31kp0NsX9dp+SILYe4gbtwvW7GZjl6MmNsva6aPBcZV79vtrLTSFvSIdV1zRmJxmF+CkdvzJeRjK5Af12y+3XdcYSfIxVo58/NwwGXxvvB1uYdIVw5tRlTOekymsmzHkSquzdimEvr0UoCkIe5dk/xY6L5n4002hu05TTb6KffklsCukQcMjbSK6JrcUUsD+VgJs2mm/idS3o4Qq6O/DdAPOt7DejsQRXlTzdlv1eKA7AlEdv/sGD2tlc6IjUmxvEGIIXY/FHMxZVKGk4aY3gS5OMOwBAKJTCQQ+3l+oUCkz/gn1DkEKTDb2YoapwOtwDfXUDVvOUt/1UVikTbhjPA0Rc5c6u/YzNYgnxuwT8fgy3sAPsvY5GXhZB4DSScUOCwOaHrfVDgFHW500EmNhwU9kkMJ6q+h5K21taoZu5v8LlEfNQauzWpUE/S6v/lHdZcIw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6498.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RjLOHPX0OH0zENAw6Mtr2ksgwyTsEvrc9l2Z5GMOVO8rBWId6YP4AGpqtOaB?=
 =?us-ascii?Q?lwXmGdwoAMzJniFmRZahudHzJ3P3IDcPgvAUIiJN7MPQihqr5KrzNIVvQ8i+?=
 =?us-ascii?Q?YBIR4TzoIHpsjjf0D4fs6a5/rEhP4USpyVNJ73QGxYg4AttqLmTP/XG5BsKq?=
 =?us-ascii?Q?wvzFHm55c8KlzCLZAlPuQMKwC7Clt66olY5SisWi6oJ17a+vU1TZK179vGtF?=
 =?us-ascii?Q?YBaA5vIriR11+cKJlpa0qO9/Hr3tFMgbrUzv197ohz4IEoT2kNdH+zyI8byV?=
 =?us-ascii?Q?8Y3Yrn9W9Ds4ipmMH7VWedN24SENGrJlBJBkk86PcyiTG+PqQNOVriToBuaQ?=
 =?us-ascii?Q?CNsSHzLh/7hFOqjmD/4M3TdGJFNuVseFQGoMOpl/NweCj+M1AiSnPzsVHq8Y?=
 =?us-ascii?Q?3vweNCYL8It0qJ2ATV0Pi84tZuP0O1V3AF50EW0g3Q9NmQbB5bZmJgmCilL1?=
 =?us-ascii?Q?0eFUhT0iNoTHoQdcqrVsj5kKnFI2lu5gPFzXjlOMQPIeylPPt/TqaCQJGwdv?=
 =?us-ascii?Q?/Y8kCIaE4xXfN+X/X8KgS9wqzfRbrAQs7lRz16BJuxgTtgFoTOugiOlqawVz?=
 =?us-ascii?Q?gUW7QlLHm2PZQ6y7m0rra18qClqXv0TObvoWNwMO46NCQ9TJQoBSeJKo2Ug5?=
 =?us-ascii?Q?lYuhtHejbRB8OD5lps6gLTrZbnzlc5SlQT1zODQEBbwdwHBR61VKX7S13/TT?=
 =?us-ascii?Q?F2k/Ahvn8ZlSFP7SgaHSB1eLqJN3/x9S+hFyl/dI4dGRL5zm7acSSB8+VPbP?=
 =?us-ascii?Q?Rgc0KkeM0wgS7ELdr4R6uWEjMM/791iFEwOULq51NZIziezRa9JXzfW/SeEO?=
 =?us-ascii?Q?4X68VVEqZFLjdB1cWL7sj788YQa4uCZlaejFWsWjbbckZVjWdMbcYdLRAzUF?=
 =?us-ascii?Q?6Y7tWUwZsqssU7ClbLtSP78gMXwBnxsa65nHsFJ92xUHy1JZWM3P249ayg19?=
 =?us-ascii?Q?cJTbz/GRJWgG7h58giA1tPPa/mSfeIBh4z+YoygimMUt65WIdJ++MikPaJrI?=
 =?us-ascii?Q?vk/3vFecvta5D1o8wkvXIJ2+z6gdp7OYXOX79w+4cnEkaBSe7miuDlel8Awd?=
 =?us-ascii?Q?/Aej1hLhcP5HWQDUMQ0H3flx5Iv1B0ytuDb04i3/26Mg36tNCGBYvj6f+87a?=
 =?us-ascii?Q?YIGb9oKsvJEMrxvpFOq7GkQKMZ2jhxjoFx7UOPCP2hhkMLFu8aRamQKKojdb?=
 =?us-ascii?Q?jtQ4gGeBlInUJFDM6dDfgVrXZmL6VsyFgeoM2j7J/3EX4pgm/HrlOlPc44Mk?=
 =?us-ascii?Q?5OanSVjhcWYJfpHRrdN/LWaDLtJNpRgkSuaww89wh9t/YWDKRwsoP/fT5fnO?=
 =?us-ascii?Q?PbevmLwgRZ/t8+pvyyijKcuNPo5Zn31ARDFftU79Bqv8YE7yPCFC1EFU8927?=
 =?us-ascii?Q?aTXPh7qvBCXv9gMVmOjBAe6uJIkWWxQ2HActOOCHfbxh8jzDQ6H8KyHfc/Cm?=
 =?us-ascii?Q?0ReTH/3oYm9vUwzSyC98mvwsPEap9kYB26dYNsq/4ukqvB0JxDtba/TL81tx?=
 =?us-ascii?Q?4FCw70p659ykMHuj8UiuGDUBzz2hT3f+3xSnj/dd+fIG8BDu+xwrIbfghIrf?=
 =?us-ascii?Q?r7/p3VJq/cax3nH4NoOLNErtfqhX6v/BsVj5JMWgYGIBHw0fzBNwl73P/hmr?=
 =?us-ascii?Q?a0ODl0yTB791Og2y+QuZAQw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8172d936-75a8-4b7c-0452-08dc33e047d6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6498.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 19:55:55.2308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: drvy8+sHqWq1CquB/caLIX/ABa8fjFNQol20igJCmgsNi9rsAs5maa/T+3TxjwKR+9vJBaH0LGfwdtSKoSG3jDUnlHbhhSv66ag4J6bng2TuSJN/PT9YvWZnYMzi4TtC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6127

Hello Beata,

I tested this patch based on the discussion in [1] on an AmpereOne
system when the system was mostly idle. The results below are when only
I applied the first patch in this series to the kernel. I noticed that
the frequency reported through scaling_cur_freq vs cpuinfo_cur_freq is
quite different for some cores. When the cores are loaded using
stress-ng, the scaling_cur_freq and cpuinfo_cur_freq values are quite
similar.

Applying the second patch in this series causes the difference between
scaling_cur_freq and cpuinfo_cur_freq to disappear, but calculating the
core frequency based on the feedback_ctrs shows that the value is
incorrect for both.

The kernel I compiled for testing is based on the Fedora 39 config file.
These configs seem relevant to the discussion:

CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING_USER=y
# CONFIG_CONTEXT_TRACKING_USER_FORCE is not set
CONFIG_NO_HZ=y

[1]: https://lore.kernel.org/linux-arm-kernel/20231212072617.14756-1-lihuisong@huawei.com/

Results:
cpu_num scaling_cur_freq  cpuinfo_cur_freq
[11]:	  1874560	          1000000
[12]:	  2056158	          1385000
[13]:	  1974146	          1000000
[21]:	  1587518	          1000000
[23]:	  1593376           1000000
..
.. skipping similar results for ~50 other cores for brevity
..
nohz_full=113-118
[113]:	1874560	          1000000
[114]:	1968288	          1000000
[115]:	1962430	          1000000
[116]:	1871631	          1000000
[117]:	1877489	          1000000
[118]:	1877489	          1000000
isolcpus=119-127
[119]:	2999296	          1000000
[120]:	2999296	          1000000
[121]:	2999296	          1000000
[125]:	2999296	          1000000
[126]:	2999296	          1000000
[127]:	2999296	          1000000

Thanks,
Vanshi

On Mon, Nov 27, 2023 at 04:08:37PM +0000, Beata Michalska wrote:
>With the Frequency Invariance Engine (FIE) being already wired up with
>sched tick and making use of relevant (core counter and constant
>counter) AMU counters, getting the current frequency for a given CPU
>on supported platforms, can be achieved by utilizing the frequency scale
>factor which reflects an average CPU frequency for the last tick period
>length.
>
>Suggested-by: Ionela Voinescu <ionela.voinescu@arm.com>
>Signed-off-by: Beata Michalska <beata.michalska@arm.com>
>Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>---
>
>Notes:
>    Due to [1], if merged, there might be a need to modify the patch to
>    accommodate changes [1] introduces:
>
>    	freq = cpufreq_get_hw_max_freq(cpu) >> SCHED_CAPACITY_SHIFT
>    	to
>    	freq = per_cpu(capacity_freq_ref, cpu); >> SCHED_CAPACITY_SHIFT
>    [1]
>    https://lore.kernel.org/linux-arm-kernel/20231121154349.GA1938@willie-the-truck/T/#mcb018d076dbce6f60ed2779634a9b6ffe622641e
>
> arch/arm64/kernel/topology.c | 39 ++++++++++++++++++++++++++++++++++++
> 1 file changed, 39 insertions(+)
>
>diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
>index 615c1a20129f..ae2445f6e7da 100644
>--- a/arch/arm64/kernel/topology.c
>+++ b/arch/arm64/kernel/topology.c
>@@ -17,6 +17,7 @@
> #include <linux/cpufreq.h>
> #include <linux/init.h>
> #include <linux/percpu.h>
>+#include <linux/sched/isolation.h>
>
> #include <asm/cpu.h>
> #include <asm/cputype.h>
>@@ -186,6 +187,44 @@ static void amu_scale_freq_tick(void)
> 	this_cpu_write(arch_freq_scale, (unsigned long)scale);
> }
>
>+unsigned int arch_freq_get_on_cpu(int cpu)
>+{
>+	unsigned int freq;
>+	u64 scale;
>+
>+	if (!cpumask_test_cpu(cpu, amu_fie_cpus))
>+		return 0;
>+
>+	/*
>+	 * For those CPUs that are in full dynticks mode, try an alternative
>+	 * source for the counters (and thus freq scale),
>+	 * if available for given policy
>+	 */
>+	if (!housekeeping_cpu(cpu, HK_TYPE_TICK)) {
>+		struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
>+		int ref_cpu = nr_cpu_ids;
>+
>+		if (cpumask_intersects(housekeeping_cpumask(HK_TYPE_TICK),
>+				       policy->cpus))
>+			ref_cpu = cpumask_nth_and(cpu, policy->cpus,
>+						  housekeeping_cpumask(HK_TYPE_TICK));
>+		cpufreq_cpu_put(policy);
>+		if (ref_cpu >= nr_cpu_ids)
>+			return 0;
>+		cpu = ref_cpu;
>+	}
>+
>+	/*
>+	 * Reversed computation to the one used to determine
>+	 * the arch_freq_scale value
>+	 * (see amu_scale_freq_tick for details)
>+	 */
>+	scale = per_cpu(arch_freq_scale, cpu);
>+	freq = cpufreq_get_hw_max_freq(cpu) >> SCHED_CAPACITY_SHIFT;
>+	freq *= scale;
>+	return freq;
>+}
>+
> static struct scale_freq_data amu_sfd = {
> 	.source = SCALE_FREQ_SOURCE_ARCH,
> 	.set_freq_scale = amu_scale_freq_tick,
>-- 
>2.25.1
>
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

