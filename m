Return-Path: <linux-kernel+bounces-49552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D02D1846BC8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EB231C21355
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517FC77F00;
	Fri,  2 Feb 2024 09:21:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3497377637;
	Fri,  2 Feb 2024 09:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706865680; cv=none; b=VErClbij3pvj4wEBWSz6oL5c7HV7OoMGEY7xvmSVMl7oIpH+11p3EMp4iPBQHSkSuX2KsJjIr8p6+NumYow39NKzje5sDPbc5KniuDZdLOMgIejG/v49wc5l7OSLrx9HuFTve3G0MTjibUnqqiwI6J9Dq9Jtj1FI4FC9u24X7fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706865680; c=relaxed/simple;
	bh=O6GmnznGee1J1ZEBFNdrhE/ly46AQTTQPmWiAnOmNRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEvre0KD4fz9OllPxZ5cSnb0sswU0EKabvFK8p7TdV7MrxaXD3NdoY0e8g/DMV/ueFNMrcDcwlW3UkfRvK6TYXXg16UeqPUgmpTM7tDGK+rbuFV3TIQy1GlnMt35yN6DKiJE2BGNpTjUGuSo6CTzf1fwkTgsQDYaDPWbpsdI4rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2E34DA7;
	Fri,  2 Feb 2024 01:21:59 -0800 (PST)
Received: from e129154.nice.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 454CC3F5A1;
	Fri,  2 Feb 2024 01:21:11 -0800 (PST)
Date: Fri, 2 Feb 2024 10:20:34 +0100
From: Beata Michalska <beata.michalska@arm.com>
To: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, sumitg@nvidia.com, sudeep.holla@arm.covm,
	will@kernel.org, catalin.marinas@arm.com, viresh.kumar@linaro.org,
	rafael@kernel.org, yang@os.amperecomputing.com,
	linux-tegra@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 1/2] arm64: Provide an AMU-based version of
 arch_freq_get_on_cpu
Message-ID: <Zbyz4mQHLI9aPK6e@e129154.nice.arm.com>
References: <20231127160838.1403404-2-beata.michalska@arm.com>
 <ZWYDr6JJJzBvsqf0@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWYDr6JJJzBvsqf0@arm.com>

On Tue, Nov 28, 2023 at 03:13:51PM +0000, Ionela Voinescu wrote:
> Hi Beata,
> 
> On Monday 27 Nov 2023 at 16:08:37 (+0000), Beata Michalska wrote:
> > With the Frequency Invariance Engine (FIE) being already wired up with
> > sched tick and making use of relevant (core counter and constant
> > counter) AMU counters, getting the current frequency for a given CPU
> > on supported platforms, can be achieved by utilizing the frequency scale
> > factor which reflects an average CPU frequency for the last tick period
> > length.
> > 
> > Suggested-by: Ionela Voinescu <ionela.voinescu@arm.com>
> > Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> > 
> > Notes:
> >     Due to [1], if merged, there might be a need to modify the patch to
> >     accommodate changes [1] introduces:
> >     
> >     	freq = cpufreq_get_hw_max_freq(cpu) >> SCHED_CAPACITY_SHIFT
> >     	to
> >     	freq = per_cpu(capacity_freq_ref, cpu); >> SCHED_CAPACITY_SHIFT
> >     [1]
> >     https://lore.kernel.org/linux-arm-kernel/20231121154349.GA1938@willie-the-truck/T/#mcb018d076dbce6f60ed2779634a9b6ffe622641e
> > 
> >  arch/arm64/kernel/topology.c | 39 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> > 
> > diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> > index 615c1a20129f..ae2445f6e7da 100644
> > --- a/arch/arm64/kernel/topology.c
> > +++ b/arch/arm64/kernel/topology.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/cpufreq.h>
> >  #include <linux/init.h>
> >  #include <linux/percpu.h>
> > +#include <linux/sched/isolation.h>
> >  
> >  #include <asm/cpu.h>
> >  #include <asm/cputype.h>
> > @@ -186,6 +187,44 @@ static void amu_scale_freq_tick(void)
> >  	this_cpu_write(arch_freq_scale, (unsigned long)scale);
> >  }
> >  
> > +unsigned int arch_freq_get_on_cpu(int cpu)
> > +{
> > +	unsigned int freq;
> > +	u64 scale;
> > +
> > +	if (!cpumask_test_cpu(cpu, amu_fie_cpus))
> > +		return 0;
> > +
> > +	/*
> > +	 * For those CPUs that are in full dynticks mode, try an alternative
> > +	 * source for the counters (and thus freq scale),
> > +	 * if available for given policy
> > +	 */
> > +	if (!housekeeping_cpu(cpu, HK_TYPE_TICK)) {
> > +		struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> > +		int ref_cpu = nr_cpu_ids;
> > +
> > +		if (cpumask_intersects(housekeeping_cpumask(HK_TYPE_TICK),
> > +				       policy->cpus))
> > +			ref_cpu = cpumask_nth_and(cpu, policy->cpus,
> > +						  housekeeping_cpumask(HK_TYPE_TICK));
> > +		cpufreq_cpu_put(policy);
> > +		if (ref_cpu >= nr_cpu_ids)
> > +			return 0;
> > +		cpu = ref_cpu;
> > +	}
> > +
> > +	/*
> > +	 * Reversed computation to the one used to determine
> > +	 * the arch_freq_scale value
> > +	 * (see amu_scale_freq_tick for details)
> > +	 */
> > +	scale = per_cpu(arch_freq_scale, cpu);
> 
> Any reason for not using arch_scale_freq_capacity() here?
> 
> To me it seems a bit nicer to use the "official" function to return the
> frequency scale factor.
> 
Noted.
> > +	freq = cpufreq_get_hw_max_freq(cpu) >> SCHED_CAPACITY_SHIFT;
> 
> Given Vincent's patch at [1] I think here might be best to call
> arch_scale_freq_ref() instead. That's because the frequency scale factor
> will use that frequency as the maximum frequency in its calculations and
> we'd not want to use a different one here.
> 
OK.
> The annoyance is coping with capacity_freq_ref not having been set
> yet, and that would be easy if capacity_freq_ref was initialized to 0.
> Luckily with Vincent's changes it can now be 0. I'll comments on his
> patches and ask him to make this change.
> 
> So I think you can safely use arch_scale_freq_ref() here. If
> arch_scale_freq_ref() returns 0, arch_freq_get_on_cpu() will just return
> 0 as well.
> 
Will do.
> [1] https://lore.kernel.org/lkml/20231109101438.1139696-8-vincent.guittot@linaro.org/
> 
> > +	freq *= scale;
> 
> In some scenarios the frequencies visible to cpufreq might not look like
> actual frequencies, but some scaled abstract performance values. One
> example is cppc_cpufreq when one does not provide the optional frequency
> information in the CPC objects but just the performance information.
> 
> Therefore the maximum frequency seen here can be quite a small value, so
> it might be best to do the multiplication first and the shift after that.
> 
Right, that was in v1! Must have mixed up things ending with stale data.
Will address that in the next version - if one is out.

---
BR
Beata
> Thanks,
> Ionela.
> 
> > +	return freq;
> > +}
> > +
> >  static struct scale_freq_data amu_sfd = {
> >  	.source = SCALE_FREQ_SOURCE_ARCH,
> >  	.set_freq_scale = amu_scale_freq_tick,
> > -- 
> > 2.25.1
> > 

