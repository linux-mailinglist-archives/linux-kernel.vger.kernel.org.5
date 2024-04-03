Return-Path: <linux-kernel+bounces-130624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2825897AAA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 579CE28A457
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B681156865;
	Wed,  3 Apr 2024 21:29:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE00156671;
	Wed,  3 Apr 2024 21:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712179746; cv=none; b=TnSVkqhDWejnOhM9hLZAJNZebKV4MlZ6kqkk7gg3k687EKO9rN8ak7XwAPTvBgiTK5VYHTSi9WcSXwZoJmsV96ziwpgnff5z3lQ/8WQASOXHbYCHCRjaNLNSFKizYosxNO6hj003BHGH+aoeZPTrSnhvJ7NkR0b/ljAEqW9XbZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712179746; c=relaxed/simple;
	bh=w8WRtGLQk0N8W2IHPk9EV4yoJ/5lY4aQbsRyJibJhrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MrEsjxR0NoVzLpTYXpNMWRvI58jPiYCvNmxziHbUjlOeCBYMABWtXpVLSdi+mNMuAMmh5r4dhMO2aHICttGjqi81ITyCLQKUrR7jOAlXQRo64RZlsfOzK5F/uyy9BAV2fBtU9nmKDo6Kj0BTfF1vceKqKJ+pqI8UHz5ms78/5bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D91C01007;
	Wed,  3 Apr 2024 14:29:33 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8AF33F7B4;
	Wed,  3 Apr 2024 14:28:59 -0700 (PDT)
Date: Wed, 3 Apr 2024 23:28:54 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Sumit Gupta <sumitg@nvidia.com>
Cc: linux-arm-kernel@lists.infradead.org, ionela.voinescu@arm.com,
	sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com,
	vincent.guittot@linaro.org, yang@os.amperecomputing.com,
	lihuisong@huawei.com, vanshikonda@os.amperecomputing.com,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] arm64: Provide an AMU-based version of
 arch_freq_get_on_cpu
Message-ID: <Zg3KFuHF-rZGdl5Y@arm.com>
References: <20240312083431.3239989-1-beata.michalska@arm.com>
 <20240312083431.3239989-3-beata.michalska@arm.com>
 <370c98a5-30f7-917e-8fe8-10d2c48e4222@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <370c98a5-30f7-917e-8fe8-10d2c48e4222@nvidia.com>

On Wed, Mar 20, 2024 at 10:13:18PM +0530, Sumit Gupta wrote:
> 
> 
> On 12/03/24 14:04, Beata Michalska wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > With the Frequency Invariance Engine (FIE) being already wired up with
> > sched tick and making use of relevant (core counter and constant
> > counter) AMU counters, getting the current frequency for a given CPU
> > on supported platforms can be achieved by utilizing the frequency scale
> > factor which reflects an average CPU frequency for the last tick period
> > length.
> > 
> > The solution is partially based on APERF/MPERF implementation of
> > arch_freq_get_on_cpu.
> > 
> > Suggested-by: Ionela Voinescu <ionela.voinescu@arm.com>
> > Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> > ---
> >   arch/arm64/kernel/topology.c | 103 +++++++++++++++++++++++++++++++----
> >   1 file changed, 92 insertions(+), 11 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> > index 1a2c72f3e7f8..42cb19c31719 100644
> > --- a/arch/arm64/kernel/topology.c
> > +++ b/arch/arm64/kernel/topology.c
> > @@ -17,6 +17,8 @@
> >   #include <linux/cpufreq.h>
> >   #include <linux/init.h>
> >   #include <linux/percpu.h>
> > +#include <linux/sched/isolation.h>
> > +#include <linux/seqlock_types.h>
> > 
> >   #include <asm/cpu.h>
> >   #include <asm/cputype.h>
> > @@ -88,18 +90,31 @@ int __init parse_acpi_topology(void)
> >    * initialized.
> >    */
> >   static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, arch_max_freq_scale) =  1UL << (2 * SCHED_CAPACITY_SHIFT);
> > -static DEFINE_PER_CPU(u64, arch_const_cycles_prev);
> > -static DEFINE_PER_CPU(u64, arch_core_cycles_prev);
> >   static cpumask_var_t amu_fie_cpus;
> > 
> > +struct amu_cntr_sample {
> > +       u64             arch_const_cycles_prev;
> > +       u64             arch_core_cycles_prev;
> > +       unsigned long   last_update;
> > +       seqcount_t      seq;
> > +};
> > +
> > +static DEFINE_PER_CPU_SHARED_ALIGNED(struct amu_cntr_sample, cpu_amu_samples) = {
> > +       .seq = SEQCNT_ZERO(cpu_amu_samples.seq)
> > +};
> > +
> >   void update_freq_counters_refs(void)
> >   {
> > -       this_cpu_write(arch_core_cycles_prev, read_corecnt());
> > -       this_cpu_write(arch_const_cycles_prev, read_constcnt());
> > +       struct amu_cntr_sample *amu_sample = this_cpu_ptr(&cpu_amu_samples);
> > +
> > +       amu_sample->arch_core_cycles_prev = read_corecnt();
> > +       amu_sample->arch_const_cycles_prev = read_constcnt();
> >   }
> > 
> >   static inline bool freq_counters_valid(int cpu)
> >   {
> > +       struct amu_cntr_sample *amu_sample = per_cpu_ptr(&cpu_amu_samples, cpu);
> > +
> >          if ((cpu >= nr_cpu_ids) || !cpumask_test_cpu(cpu, cpu_present_mask))
> >                  return false;
> > 
> > @@ -108,8 +123,8 @@ static inline bool freq_counters_valid(int cpu)
> >                  return false;
> >          }
> > 
> > -       if (unlikely(!per_cpu(arch_const_cycles_prev, cpu) ||
> > -                    !per_cpu(arch_core_cycles_prev, cpu))) {
> > +       if (unlikely(!amu_sample->arch_const_cycles_prev ||
> > +                    !amu_sample->arch_core_cycles_prev)) {
> >                  pr_debug("CPU%d: cycle counters are not enabled.\n", cpu);
> >                  return false;
> >          }
> > @@ -152,20 +167,27 @@ void freq_inv_set_max_ratio(int cpu, u64 max_rate)
> > 
> >   static void amu_scale_freq_tick(void)
> >   {
> > +       struct amu_cntr_sample *amu_sample = this_cpu_ptr(&cpu_amu_samples);
> >          u64 prev_core_cnt, prev_const_cnt;
> >          u64 core_cnt, const_cnt, scale;
> > 
> > -       prev_const_cnt = this_cpu_read(arch_const_cycles_prev);
> > -       prev_core_cnt = this_cpu_read(arch_core_cycles_prev);
> > +       prev_const_cnt = amu_sample->arch_const_cycles_prev;
> > +       prev_core_cnt = amu_sample->arch_core_cycles_prev;
> > +
> > +       write_seqcount_begin(&amu_sample->seq);
> > 
> >          update_freq_counters_refs();
> > 
> > -       const_cnt = this_cpu_read(arch_const_cycles_prev);
> > -       core_cnt = this_cpu_read(arch_core_cycles_prev);
> > +       const_cnt = amu_sample->arch_const_cycles_prev;
> > +       core_cnt = amu_sample->arch_core_cycles_prev;
> > 
> > +       /*
> > +        * This should not happen unless the AMUs have been reset and the
> > +        * counter values have not been resroted - unlikely
> > +        */
> >          if (unlikely(core_cnt <= prev_core_cnt ||
> >                       const_cnt <= prev_const_cnt))
> > -               return;
> > +               goto leave;
> > 
> >          /*
> >           *          /\core    arch_max_freq_scale
> > @@ -182,6 +204,10 @@ static void amu_scale_freq_tick(void)
> > 
> >          scale = min_t(unsigned long, scale, SCHED_CAPACITY_SCALE);
> >          this_cpu_write(arch_freq_scale, (unsigned long)scale);
> > +
> > +       amu_sample->last_update = jiffies;
> > +leave:
> > +       write_seqcount_end(&amu_sample->seq);
> >   }
> > 
> >   static struct scale_freq_data amu_sfd = {
> > @@ -189,6 +215,61 @@ static struct scale_freq_data amu_sfd = {
> >          .set_freq_scale = amu_scale_freq_tick,
> >   };
> > 
> > +#define AMU_SAMPLE_EXP_MS      20
> > +
> > +unsigned int arch_freq_get_on_cpu(int cpu)
> > +{
> > +       struct amu_cntr_sample *amu_sample;
> > +       unsigned long last_update;
> > +       unsigned int seq;
> > +       unsigned int freq;
> > +       u64 scale;
> > +
> > +       if (!cpumask_test_cpu(cpu, amu_fie_cpus) || !arch_scale_freq_ref(cpu))
> > +               return 0;
> > +
> > +retry:
> > +       amu_sample = per_cpu_ptr(&cpu_amu_samples, cpu);
> > +
> > +       do {
> > +               seq = raw_read_seqcount_begin(&amu_sample->seq);
> > +               last_update = amu_sample->last_update;
> > +       } while (read_seqcount_retry(&amu_sample->seq, seq));
> > +
> > +       /*
> > +        * For those CPUs that are in full dynticks mode,
> > +        * and those that have not seen tick for a while
> > +        * try an alternative source for the counters (and thus freq scale),
> > +        * if available for given policy
> > +        */
> > +       if (time_is_before_jiffies(last_update + msecs_to_jiffies(AMU_SAMPLE_EXP_MS))) {
> > +               struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> > +               int ref_cpu = nr_cpu_ids;
> > +
> > +               if (cpumask_intersects(housekeeping_cpumask(HK_TYPE_TICK),
> > +                                      policy->cpus))
> > +                       ref_cpu = cpumask_nth_and(cpu, policy->cpus,
> > +                                                 housekeeping_cpumask(HK_TYPE_TICK));
> > +
> 
> This is looking for any other HK CPU within same policy for counters.
> AFAIU, cpumask_nth_and() will return small_cpumask_bits/nr_cpu_ids
> if the number of bits in both masks is different. Could you check
> again if the current change is fine or needs something like below.
> BTW, we have one CPU per policy.
> 
>   cpumask_and(&mask, policy->cpus, housekeeping_cpumask(HK_TYPE_TICK));
>   retry:
> 	....
> 	cpumask_andnot(&mask, &mask, cpumask_of(cpu));
> 	ref_cpu = cpumask_any(&mask);
>
At this point this is indeed bogus though for a different reason.
I've rewritten that part a bit, though still, this will bail out for single-cpu
policies.

---
BR
Beata


> Thank you,
> Sumit Gupta
> 
> > +               cpufreq_cpu_put(policy);
> > +               if (ref_cpu >= nr_cpu_ids || ref_cpu == cpu)
> > +                       /* No alternative to pull info from */
> > +                       return 0;
> > +               cpu = ref_cpu;
> > +               goto retry;
> > +       }
> > +       /*
> > +        * Reversed computation to the one used to determine
> > +        * the arch_freq_scale value
> > +        * (see amu_scale_freq_tick for details)
> > +        */
> > +       scale = arch_scale_freq_capacity(cpu);
> > +       freq = scale * arch_scale_freq_ref(cpu);
> > +       freq >>= SCHED_CAPACITY_SHIFT;
> > +
> > +       return freq;
> > +}
> > +
> >   static void amu_fie_setup(const struct cpumask *cpus)
> >   {
> >          int cpu;
> > --
> > 2.25.1
> > 

