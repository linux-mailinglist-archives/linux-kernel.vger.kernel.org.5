Return-Path: <linux-kernel+bounces-159910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A090F8B3611
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDC481C217D7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C682F144309;
	Fri, 26 Apr 2024 10:50:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C39143C70
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714128657; cv=none; b=g9u6dwyw1222y7/MV58b+0q2jlLTf9RBexuG233uQuR8MjrrgTj/oNo6QRF/Cppk2lwZQ2Itp2pECTJuSq5xGkgsE9/+Y2qJMO1VhrFkKjzzmAmmN0aMlqxYMAhHfZ2ckw9bQxIXmJ3Aws68AtY0W6a40vCbcSetiwGjKLdqyQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714128657; c=relaxed/simple;
	bh=3uCSbU/Vs7da8ywRIp7xR8c95nU1hlqyVwcypMuvccs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAB9J1gcls8Nk7n5aZUD0tLvBLGYL5mPFSM56Fu9PnCDeXSCeoDrLU4xgzXjljwv3lauk8rcj6M/j2owAcu9HJWKXxksBagqiPP3355gIZxTg8GNVTU2BZ3uCXe3HFqrPVDcKF1mJw70BQWfS35Bcc20zKuOKW88MwgH3G8uptM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FE902F4;
	Fri, 26 Apr 2024 03:51:21 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44BD83F64C;
	Fri, 26 Apr 2024 03:50:50 -0700 (PDT)
Date: Fri, 26 Apr 2024 12:50:46 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	ionela.voinescu@arm.com, sudeep.holla@arm.com, will@kernel.org,
	catalin.marinas@arm.com, vincent.guittot@linaro.org,
	sumitg@nvidia.com, yang@os.amperecomputing.com,
	lihuisong@huawei.com, viresh.kumar@linaro.org
Subject: Re: [PATCH v5 3/5] arm64: Provide an AMU-based version of
 arch_freq_get_on_cpu
Message-ID: <ZiuHBsuAbBQp3TD6@arm.com>
References: <20240417093848.1555462-1-beata.michalska@arm.com>
 <20240417093848.1555462-4-beata.michalska@arm.com>
 <6inw6vhqe3uuxjozeioqujzdtksmsdr4estzkdsbb762rcxa7z@sn56uogdatjr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6inw6vhqe3uuxjozeioqujzdtksmsdr4estzkdsbb762rcxa7z@sn56uogdatjr>

On Wed, Apr 17, 2024 at 06:39:00PM -0700, Vanshidhar Konda wrote:
> On Wed, Apr 17, 2024 at 10:38:46AM +0100, Beata Michalska wrote:
> > With the Frequency Invariance Engine (FIE) being already wired up with
> > sched tick and making use of relevant (core counter and constant
> > counter) AMU counters, getting the current frequency for a given CPU,
> > can be achieved by utilizing the frequency scale factor which reflects
> > an average CPU frequency for the last tick period length.
> > 
> > The solution is partially based on APERF/MPERF implementation of
> > arch_freq_get_on_cpu.
> > 
> > Suggested-by: Ionela Voinescu <ionela.voinescu@arm.com>
> > Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> > ---
> > arch/arm64/kernel/topology.c | 110 +++++++++++++++++++++++++++++++----
> > 1 file changed, 100 insertions(+), 10 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> > index 3c814a278534..475fdbf3032a 100644
> > --- a/arch/arm64/kernel/topology.c
> > +++ b/arch/arm64/kernel/topology.c
> > @@ -17,6 +17,7 @@
> > #include <linux/cpufreq.h>
> > #include <linux/init.h>
> > #include <linux/percpu.h>
> > +#include <linux/sched/isolation.h>
> > 
> > #include <asm/cpu.h>
> > #include <asm/cputype.h>
> > @@ -88,18 +89,28 @@ int __init parse_acpi_topology(void)
> >  * initialized.
> >  */
> > static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, arch_max_freq_scale) =  1UL << (2 * SCHED_CAPACITY_SHIFT);
> > -static DEFINE_PER_CPU(u64, arch_const_cycles_prev);
> > -static DEFINE_PER_CPU(u64, arch_core_cycles_prev);
> > static cpumask_var_t amu_fie_cpus;
> > 
> > +struct amu_cntr_sample {
> > +	u64		arch_const_cycles_prev;
> > +	u64		arch_core_cycles_prev;
> > +	unsigned long	last_update;
> > +};
> > +
> > +static DEFINE_PER_CPU_SHARED_ALIGNED(struct amu_cntr_sample, cpu_amu_samples);
> > +
> > void update_freq_counters_refs(void)
> > {
> > -	this_cpu_write(arch_core_cycles_prev, read_corecnt());
> > -	this_cpu_write(arch_const_cycles_prev, read_constcnt());
> > +	struct amu_cntr_sample *amu_sample = this_cpu_ptr(&cpu_amu_samples);
> > +
> > +	amu_sample->arch_core_cycles_prev = read_corecnt();
> > +	amu_sample->arch_const_cycles_prev = read_constcnt();
> > }
> > 
> > static inline bool freq_counters_valid(int cpu)
> > {
> > +	struct amu_cntr_sample *amu_sample = per_cpu_ptr(&cpu_amu_samples, cpu);
> > +
> > 	if ((cpu >= nr_cpu_ids) || !cpumask_test_cpu(cpu, cpu_present_mask))
> > 		return false;
> > 
> > @@ -108,8 +119,8 @@ static inline bool freq_counters_valid(int cpu)
> > 		return false;
> > 	}
> > 
> > -	if (unlikely(!per_cpu(arch_const_cycles_prev, cpu) ||
> > -		     !per_cpu(arch_core_cycles_prev, cpu))) {
> > +	if (unlikely(!amu_sample->arch_const_cycles_prev ||
> > +		     !amu_sample->arch_core_cycles_prev)) {
> > 		pr_debug("CPU%d: cycle counters are not enabled.\n", cpu);
> > 		return false;
> > 	}
> > @@ -152,17 +163,22 @@ void freq_inv_set_max_ratio(int cpu, u64 max_rate)
> > 
> > static void amu_scale_freq_tick(void)
> > {
> > +	struct amu_cntr_sample *amu_sample = this_cpu_ptr(&cpu_amu_samples);
> > 	u64 prev_core_cnt, prev_const_cnt;
> > 	u64 core_cnt, const_cnt, scale;
> > 
> > -	prev_const_cnt = this_cpu_read(arch_const_cycles_prev);
> > -	prev_core_cnt = this_cpu_read(arch_core_cycles_prev);
> > +	prev_const_cnt = amu_sample->arch_const_cycles_prev;
> > +	prev_core_cnt = amu_sample->arch_core_cycles_prev;
> > 
> > 	update_freq_counters_refs();
> > 
> > -	const_cnt = this_cpu_read(arch_const_cycles_prev);
> > -	core_cnt = this_cpu_read(arch_core_cycles_prev);
> > +	const_cnt = amu_sample->arch_const_cycles_prev;
> > +	core_cnt = amu_sample->arch_core_cycles_prev;
> > 
> > +	/*
> > +	 * This should not happen unless the AMUs have been reset and the
> > +	 * counter values have not been restored - unlikely
> > +	 */
> > 	if (unlikely(core_cnt <= prev_core_cnt ||
> > 		     const_cnt <= prev_const_cnt))
> > 		return;
> > @@ -182,6 +198,8 @@ static void amu_scale_freq_tick(void)
> > 
> > 	scale = min_t(unsigned long, scale, SCHED_CAPACITY_SCALE);
> > 	this_cpu_write(arch_freq_scale, (unsigned long)scale);
> > +
> > +	amu_sample->last_update = jiffies;
> > }
> > 
> > static struct scale_freq_data amu_sfd = {
> > @@ -189,6 +207,78 @@ static struct scale_freq_data amu_sfd = {
> > 	.set_freq_scale = amu_scale_freq_tick,
> > };
> > 
> > +static __always_inline bool amu_fie_cpu_supported(unsigned int cpu)
> > +{
> > +	return cpumask_available(amu_fie_cpus) &&
> > +		cpumask_test_cpu(cpu, amu_fie_cpus);
> > +}
> > +
> > +#define AMU_SAMPLE_EXP_MS	20
> > +
> > +unsigned int arch_freq_get_on_cpu(int cpu)
> > +{
> > +	struct amu_cntr_sample *amu_sample;
> > +	unsigned int start_cpu = cpu;
> > +	unsigned long last_update;
> > +	unsigned int freq = 0;
> > +	u64 scale;
> > +
> > +	if (!amu_fie_cpu_supported(cpu) || !arch_scale_freq_ref(cpu))
> > +		return 0;
> > +
> > +retry:
> > +	amu_sample = per_cpu_ptr(&cpu_amu_samples, cpu);
> > +
> > +	last_update = amu_sample->last_update;
> > +
> > +	/*
> > +	 * For those CPUs that are in full dynticks mode,
> > +	 * and those that have not seen tick for a while
> > +	 * try an alternative source for the counters (and thus freq scale),
> 
> While testing this on AmpereOne system I found that the scaling_cur_freq
> and cpufreq_cur_freq are inconsistent for nohz_full CPUs that are being
> throttled (OS requested freq != HW provided freq).
> 
> For the test I ran stress-ng workload on 9 cores. All the other cores
> are idle. I then forced the hardware to throttle the active cores - core
> won't run at maximum frequency despite a request from the OS. Each core
> has an independent cpufreq policy.
> 
> For the nohz_full CPUs since arch_freq_get_on_cpu bails out. In
> show_scaling_cur_freq() the next check is to see if
> cpufreq_driver->set_policy method is implemented. cppc_cpufreq does not
> implement this method and we just end up returning the policy->cur
> value. As discussed in other threads, it looks like we want the behavior
> to be identical to x86 systems. In that case it seems like returning 0
> from arch_freq_get_on_cpu is not going to be valid behavior.
> 
So the tricky bit is that up until now, arch_freq_get_on_cpu has been solely
used by show_scaling_cur_freq and as a result APERF/MPERF based implementation
could make certain assumptions, based on which, an alternative source of
information regarding current frequency could be used, wrapping all within the
arch_freq_get_on_cpu implementation.
This approach is no longer valid if both cpuinfo_cur_freq and scaling_cur_freq
rely on arch specific feedback to determine current frequency. As mentioned
earlier, the most ideal way would be to not use that feedback for
scaling_cur_freq and have it plugged in for cpuinfo_cur_freq and thus to align
with the expectations (docs) as per what type of information each attribute is
to provide. But that does not seem to be an option and we have to deal with the
aftermath. I do get your point though and I will try to revive the discussion
we have had on this one in another thread [1]

---
[1] https://lore.kernel.org/all/ZiuF0zgqkMlmkEZz@arm.com/
---
BR
Beata
> Core    scaling_cur_freq cpufreq_cur_freq
> [0]:    2700000          2700000
> [1]:    2750000          2750000
> 
> nohz_full=2-7
> [2]:    3200000          2691000
> [3]:    3200000          2645000
> [4]:    3200000          2731000
> [5]:    3200000          2714000
> [6]:    3200000          2466000
> [7]:    3200000          2708000
> 
> isolcpus=8-11 (no workload applied to core 10-11)
> [8]:    2700000          2700000
> [9]:    2550000          2550000
> [10]:   1046875          1046875
> [11]:   1096875          1096875
> 
> Thanks,
> Vanshi
> 
> > +	 * if available, for given policy:
> > +	 * this boils down to identifying an active cpu within the same freq
> > +	 * domain, if any.
> > +	 */
> > +	if (!housekeeping_cpu(cpu, HK_TYPE_TICK) ||
> > +	    time_is_before_jiffies(last_update + msecs_to_jiffies(AMU_SAMPLE_EXP_MS))) {
> > +		struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> > +		int ref_cpu = cpu;
> > +
> > +		if (!policy)
> > +			goto leave;
> > +
> > +		if (!policy_is_shared(policy)) {
> > +			cpufreq_cpu_put(policy);
> > +			goto leave;
> > +		}
> > +
> > +		do {
> > +			ref_cpu = cpumask_next_wrap(ref_cpu, policy->cpus,
> > +						    start_cpu, false);
> > +
> > +		} while (ref_cpu < nr_cpu_ids && idle_cpu(ref_cpu));
> > +
> > +		cpufreq_cpu_put(policy);
> > +
> > +		if (ref_cpu >= nr_cpu_ids)
> > +			/* No alternative to pull info from */
> > +			goto leave;
> > +
> > +		cpu = ref_cpu;
> > +		goto retry;
> > +	}
> > +	/*
> > +	 * Reversed computation to the one used to determine
> > +	 * the arch_freq_scale value
> > +	 * (see amu_scale_freq_tick for details)
> > +	 */
> > +	scale = arch_scale_freq_capacity(cpu);
> > +	freq = scale * arch_scale_freq_ref(cpu);
> > +	freq >>= SCHED_CAPACITY_SHIFT;
> > +leave:
> > +	return freq;
> > +}
> > +
> > static void amu_fie_setup(const struct cpumask *cpus)
> > {
> > 	int cpu;
> > -- 
> > 2.25.1
> > 

