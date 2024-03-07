Return-Path: <linux-kernel+bounces-95047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0569D874894
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B2A81F23ED5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD321F5E6;
	Thu,  7 Mar 2024 07:22:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153DA1CFAD;
	Thu,  7 Mar 2024 07:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709796122; cv=none; b=HIcWNokRYYEZeusqZZs4rrMlNapw5F2Uowcyfx8xuqPfMyn2eX+lCukjPo33R3fqr5aIeUBgCfD7uS7Jp5db/mRn1/mMqJUwACCyhgQxFtY3AGqGMHT8zdN9Ho08tWj4KBoietrlNmPWwBdzx0V9KPb0d1Tp9h8yDWpi/KfpDho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709796122; c=relaxed/simple;
	bh=IQ7UV1OOTG3Mnp08L8IaLjwv22dHLJaG9E4J67iXGao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TyyUUU8lHmEBLKmfZq0FIGFjXRbXCBHwkQqSwE+iwBDEntQfXyjAUyS3SNQ+wGnbmyfOHOE+LHcCuJlwv+xhYxaBjyyuJinbf0nCW9/K5XB0NrMK5E10JEx/xMcO/1m2rcMqsBSX67jAP4qElhwhp9runrgc9omc8zUaJoDHRcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42E431FB;
	Wed,  6 Mar 2024 23:22:29 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 713713F73F;
	Wed,  6 Mar 2024 23:21:48 -0800 (PST)
Date: Thu, 7 Mar 2024 08:21:07 +0100
From: Beata Michalska <beata.michalska@arm.com>
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, rafael@kernel.org,
	sumitg@nvidia.com, zengheng4@huawei.com,
	yang@os.amperecomputing.com, will@kernel.org, sudeep.holla@arm.com,
	liuyonglong@huawei.com, zhanjie9@hisilicon.com,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 1/3] arm64: topology: Add arch_freq_get_on_cpu()
 support
Message-ID: <Zelq4xBIpsTu2Q_s@arm.com>
References: <20240229162520.970986-2-vanshikonda@os.amperecomputing.com>
 <ZegoMy7_BJ0Smvkl@arm.com>
 <rnkdlf2ps7zrb44y6ty7c5nmshe24mxjhajkuvzyksxxncotqo@rxx2vsachghs>
 <be619cc5-51c5-1f24-69bc-d9fe271a8837@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be619cc5-51c5-1f24-69bc-d9fe271a8837@huawei.com>

On Thu, Mar 07, 2024 at 11:20:46AM +0800, lihuisong (C) wrote:
> 
> 在 2024/3/7 6:04, Vanshidhar Konda 写道:
> > On Wed, Mar 06, 2024 at 09:24:19AM +0100, Beata Michalska wrote:
> > > 
> > > Hi Vanshidhar,
> > > 
> > > On Thu, Feb 29, 2024 at 08:25:13AM -0800, Vanshidhar Konda wrote:
> > > > AMU counters are used by the Frequency Invariance Engine (FIE) to
> > > > estimate the CPU utilization during each tick. The delta of the AMU
> > > > counters between two ticks can also be used to estimate the average CPU
> > > > frequency of each core over the tick duration. Measure the AMU counters
> > > > during tick, compute the delta and store it. When the frequency of the
> > > > core is queried, use the stored delta to determine the frequency.
> > > > 
> > > > arch_freq_get_on_cpu() is used on x86 systems to estimate the frequency
> > > > of each CPU. It can be wired up on arm64 for the same functionality.
> > > > 
> > > > Signed-off-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
> > > > ---
> > > >  arch/arm64/kernel/topology.c | 114 +++++++++++++++++++++++++++++------
> > > >  1 file changed, 96 insertions(+), 18 deletions(-)
> > > > 
> > > > diff --git a/arch/arm64/kernel/topology.c
> > > > b/arch/arm64/kernel/topology.c
> > > > index 1a2c72f3e7f8..db8d14525cf4 100644
> > > > --- a/arch/arm64/kernel/topology.c
> > > > +++ b/arch/arm64/kernel/topology.c
> > > > @@ -17,6 +17,8 @@
> > > >  #include <linux/cpufreq.h>
> > > >  #include <linux/init.h>
> > > >  #include <linux/percpu.h>
> > > > +#include <linux/sched/isolation.h>
> > > > +#include <linux/seqlock_types.h>
> > > > 
> > > >  #include <asm/cpu.h>
> > > >  #include <asm/cputype.h>
> > > > @@ -82,20 +84,54 @@ int __init parse_acpi_topology(void)
> > > >  #undef pr_fmt
> > > >  #define pr_fmt(fmt) "AMU: " fmt
> > > > 
> > > > +struct amu_counters {
> > > > +    seqcount_t    seq;
> > > > +    unsigned long    last_update;
> > > > +    u64        core_cnt;
> > > > +    u64        const_cnt;
> > > > +    u64        delta_core_cnt;
> > > > +    u64        delta_const_cnt;
> > > > +};
> > > It still might not be necessary to track both last taken sample and
> > > deltas from
> > > previous ones, see[1].
> > > I could send v3 of [1] and take into account the changes you have
> > > suggested here,
> > > namely the last tick recorded. Otherwise few comments below.
> > 
> > For this specific patch it might suffice to just track the deltas. The
> > reason for storing the core_cnt/const_cnt values is for the case where
> > CPU is idle and we are trying to read the read the counters through CPPC
> > FFH - see patch 3 of this series.
> > 
> > One of the drawbacks of updating/merging just [1] as a standalone patch
> > is
> > that it doesn't cover idle or isolated CPUs. This patch series accounts
> > for those cases as well. I'm open to suggestions on how we can make that
> > happen with [1].
> > 
> > I tested v2 of [1] on AmpereOne system and noticed that there were some
> > inconsistent measurements reported - see [2]. I think that might be due
> > to
> > frequency scale not being updated when CPU goes idle.
> > 
> > > > +
> > > >  /*
> > > >   * Ensure that amu_scale_freq_tick() will return
> > > > SCHED_CAPACITY_SCALE until
> > > >   * the CPU capacity and its associated frequency have been correctly
> > > >   * initialized.
> > > >   */
> > > > -static DEFINE_PER_CPU_READ_MOSTLY(unsigned long,
> > > > arch_max_freq_scale) =  1UL << (2 * SCHED_CAPACITY_SHIFT);
> > > > -static DEFINE_PER_CPU(u64, arch_const_cycles_prev);
> > > > -static DEFINE_PER_CPU(u64, arch_core_cycles_prev);
> > > > +static DEFINE_PER_CPU_READ_MOSTLY(unsigned long,
> > > > arch_max_freq_scale) =
> > > > +    1UL << (2 * SCHED_CAPACITY_SHIFT);
> > > > +static DEFINE_PER_CPU_SHARED_ALIGNED(struct amu_counters,
> > > > cpu_samples) = {
> > > > +    .seq = SEQCNT_ZERO(cpu_samples.seq)
> > > > +};
> > > >  static cpumask_var_t amu_fie_cpus;
> > > > 
> > > >  void update_freq_counters_refs(void)
> > > >  {
> > > > -    this_cpu_write(arch_core_cycles_prev, read_corecnt());
> > > > -    this_cpu_write(arch_const_cycles_prev, read_constcnt());
> > > > +    struct amu_counters *cpu_sample = this_cpu_ptr(&cpu_samples);
> > > > +    u64 core_cnt, const_cnt, delta_core_cnt, delta_const_cnt;
> > > > +
> > > > +    const_cnt = read_constcnt();
> > > > +    core_cnt = read_corecnt();
> > > > +
> > > > +    if (unlikely(core_cnt < cpu_sample->core_cnt) ||
> > > > +        unlikely(const_cnt < cpu_sample->const_cnt)) {
> > > > +        WARN(1, "AMU counter values should be monotonic.\n");
> > > > +        cpu_sample->delta_const_cnt = 0;
> > > > +        cpu_sample->delta_core_cnt = 0;
> > > Not sure if zero-ing is really necessary here
> > 
> > I can remove that for the next version.
> > 
> > > > +        return;
> > > > +    }
> > > > +
> > > > +    delta_core_cnt = core_cnt - cpu_sample->core_cnt;
> > > > +    delta_const_cnt = const_cnt - cpu_sample->const_cnt;
> > > > +
> > > > +    cpu_sample->core_cnt = core_cnt;
> > > > +    cpu_sample->const_cnt = const_cnt;
> > > > +
> > > > +    raw_write_seqcount_begin(&cpu_sample->seq);
> > > > +    cpu_sample->last_update = jiffies;
> > > > +    cpu_sample->delta_const_cnt = delta_const_cnt;
> > > > +    cpu_sample->delta_core_cnt = delta_core_cnt;
> > > > +    raw_write_seqcount_end(&cpu_sample->seq);
> > > >  }
> > > > 
> > > >  static inline bool freq_counters_valid(int cpu)
> > > > @@ -108,8 +144,7 @@ static inline bool freq_counters_valid(int cpu)
> > > >          return false;
> > > >      }
> > > > 
> > > > -    if (unlikely(!per_cpu(arch_const_cycles_prev, cpu) ||
> > > > -             !per_cpu(arch_core_cycles_prev, cpu))) {
> > > > +    if (unlikely(per_cpu_ptr(&cpu_samples, cpu) == NULL)) {
> > > >          pr_debug("CPU%d: cycle counters are not enabled.\n", cpu);
> > > >          return false;
> > > >      }
> > > > @@ -152,19 +187,15 @@ void freq_inv_set_max_ratio(int cpu, u64
> > > > max_rate)
> > > > 
> > > >  static void amu_scale_freq_tick(void)
> > > >  {
> > > > -    u64 prev_core_cnt, prev_const_cnt;
> > > > -    u64 core_cnt, const_cnt, scale;
> > > > -
> > > > -    prev_const_cnt = this_cpu_read(arch_const_cycles_prev);
> > > > -    prev_core_cnt = this_cpu_read(arch_core_cycles_prev);
> > > > +    struct amu_counters *cpu_sample = this_cpu_ptr(&cpu_samples);
> > > > +    u64 delta_core_cnt, delta_const_cnt, scale;
> > > > 
> > > >      update_freq_counters_refs();
> > > > 
> > > > -    const_cnt = this_cpu_read(arch_const_cycles_prev);
> > > > -    core_cnt = this_cpu_read(arch_core_cycles_prev);
> > > > +    delta_const_cnt = cpu_sample->delta_const_cnt;
> > > > +    delta_core_cnt = cpu_sample->delta_core_cnt;
> > > > 
> > > > -    if (unlikely(core_cnt <= prev_core_cnt ||
> > > > -             const_cnt <= prev_const_cnt))
> > > > +    if ((delta_const_cnt == 0) || (delta_core_cnt == 0))
> > > >          return;
> > > > 
> > > >      /*
> > > > @@ -175,15 +206,62 @@ static void amu_scale_freq_tick(void)
> > > >       * See validate_cpu_freq_invariance_counters() for details on
> > > >       * arch_max_freq_scale and the use of SCHED_CAPACITY_SHIFT.
> > > >       */
> > > > -    scale = core_cnt - prev_core_cnt;
> > > > +    scale = delta_core_cnt;
> > > >      scale *= this_cpu_read(arch_max_freq_scale);
> > > >      scale = div64_u64(scale >> SCHED_CAPACITY_SHIFT,
> > > > -              const_cnt - prev_const_cnt);
> > > > +              delta_const_cnt);
> > > > 
> > > >      scale = min_t(unsigned long, scale, SCHED_CAPACITY_SCALE);
> > > >      this_cpu_write(arch_freq_scale, (unsigned long)scale);
> > > >  }
> > > > 
> > > > +/*
> > > > + * Discard samples older than the define maximum sample age of
> > > > 20ms. There
> > > > + * is no point in sending IPIs in such a case. If the scheduler
> > > > tick was
> > > > + * not running then the CPU is either idle or isolated.
> > > > + */
> > > > +#define MAX_SAMPLE_AGE    ((unsigned long)HZ / 50)
> > > This depends on the config, so for HZ_1000 it will indeed give 20ms,
> > > for CONFIG_250 that will be 5ms. It might be better to set it to
> > > number of
> > > expected missed ticks instead ? Or amend the comment.
> > 
> > I think using jiffies/missed ticks is probably better. I'll update for
> > next version.
> > 
> > > > +
> > > > +unsigned int arch_freq_get_on_cpu(int cpu)
> > > > +{
> > > > +    struct amu_counters *cpu_sample = per_cpu_ptr(&cpu_samples, cpu);
> > > > +    u64 delta_const_cnt, delta_core_cnt;
> > > > +    unsigned int seq, freq;
> > > > +    unsigned long last;
> > > > +
> > > > +    if (!freq_counters_valid(cpu))
> > > > +        goto fallback;
> > > > +
> > > > +    do {
> > > > +        seq = raw_read_seqcount_begin(&cpu_sample->seq);
> > > > +        last = cpu_sample->last_update;
> > > > +        delta_core_cnt = cpu_sample->delta_core_cnt;
> > > > +        delta_const_cnt = cpu_sample->delta_const_cnt;
> > > > +    } while (read_seqcount_retry(&cpu_sample->seq, seq));
> > > > +
> > > This seems to be taken from APERF/MPERF relevant code. Including the
> > > comments.
> > 
> > Yes. The idea for this patch series is based on APERF/MPERF which are
> > quite similar to AMU counters.
> > 
> > > > +    /*
> > > > +     * Bail on invalid count and when the last update was too
> > > > long ago,
> > > > +     * which covers idle and NOHZ full CPUs.
> > > > +     */
> > > > +    if (!delta_const_cnt || ((jiffies - last) > MAX_SAMPLE_AGE)) {
> > > Shouldn't the first condition (non-zero increase of cnt_cycles counter)
> > > disqualify the sample taken altogether ?
> > 
> > I was updating delta_*_cnt values to 0 in one case above. If we just
> > drop that sample and don't set delta_*_cnt values to 0 we wouldn't need
> > this check. I will remove that in the next version.
> > 
> > > > +        if (!(housekeeping_cpu(cpu, HK_TYPE_TICK) && idle_cpu(cpu)))
> > > > +            goto fallback;
> > > Not entirely convinced that this condition is what is expected ?
> > > For housekeeping cpu that is not idle it will still resolve to AMU
> > > counters,
> > > not sure if that's what was intended ?
> > 
> > For a CPU that is not idle my preference is that it uses AMU counters
> > for frequency measurement. For idle and isolcpus we fallback to the CPPC
> > mechanism - which could be through MMIO or PCC.
> > 
> > > Also, for cases when given cpufreq policy spans more than a single
> > > core, the
> > > frequency might be queried based on relevant CPU that might have
> > > seen the tick
> > > within specified timeframe (see [1])
> > > 
> > 
> > This would not be ideal. On Ampere systems I've not come across a
> > cpufreq policy that spans multiple cores, so I overlooked that
> > configuration.
> > 
> > > > +    }
> > > > +
> > > > +    /*
> > > > +     * CPU frequency = reference perf (in Hz) * (/\ delivered)
> > > > / (/\ reference)
> > > > +     * AMU reference performance counter increment rate is
> > > > equal to the rate
> > > > +     * of increment of the System counter, CNTPCT_EL0 and can
> > > > be used to
> > > > +     * compute the CPU frequency.
> > > > +     */
> > > > +    return div64_u64((delta_core_cnt * (arch_timer_get_rate() / HZ)),
> > > /HZ/HZ_PER_KHZ ?
> > > > +             delta_const_cnt);
> > > > +
> > > > +fallback:
> > > > +    freq = cpufreq_quick_get(cpu);
> > > > +    return freq ? freq : cpufreq_get_hw_max_freq(cpu);
> > > If the arch specific code cannot determine the frequency it should
> > > actually make
> > > it clear by returning '0' instead of trying to patch things up by
> > > itself (?)
> > > 
> > 
> > This was following the same logic as APERF/MPERF logic. Returning 0 from
> > here would result in a call to cpufreq_driver->get() vs a call to
> > cpufreq_quick_get(). The only difference I can tell is that
> > cpufreq_quick_get() will call read_lock_irqsave() before calling
> > cpufreq_driver->get(). I don't have enough knowledge to point out
> > which one is more appropriate. Following the same logic as the x86
> > implementation seemed more prudent.
> > 
> > > Overall I'd prefer to revive [1] and amened it accordingly instead.
> > > 
> > 
> > As mentioned earlier, I'm ok with what leads to a coherent solution for
> > all the configurations we have - isolcpus, idle and active in
> > housekeeping_cpus.
> > 
> > This issue impacts existing Ampere products. It would be great if we
> > could arrive at a solution soon.
> +1 to have a solution soon, very expecting. @Vanshi and @Beata.

Understood.
Will prepare new version - should be out by Monday.
Apologies for delays on my side.

---
BR
Beata
> > 
> > > ---
> > > [1] https://lore.kernel.org/all/20231127160838.1403404-1-beata.michalska@arm.com/
> > [2] - https://lore.kernel.org/all/7eozim2xnepacnnkzxlbx34hib4otycnbn4dqymfziqou5lw5u@5xzpv3t7sxo3/
> > 
> > Thanks for the discussion.
> > 
> > Vanshi
> > 
> > > ---
> > > Best Regards
> > > Beata
> > > > +}
> > > > +
> > > >  static struct scale_freq_data amu_sfd = {
> > > >      .source = SCALE_FREQ_SOURCE_ARCH,
> > > >      .set_freq_scale = amu_scale_freq_tick,
> > > > -- 
> > > > 2.43.1
> > > > 
> > .

