Return-Path: <linux-kernel+bounces-106258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4215F87EB90
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD6681F21F84
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBB74EB4F;
	Mon, 18 Mar 2024 15:01:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914E34EB42
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710774105; cv=none; b=dOaVBCmRfSnGaTbH9xxC1YA94aos3iQ8BJgGCcZDMydL3b4SX02iGnE08ShGfK5EUjuVZ6wqZ51hwPnX0GlF9nfDXODeCmgjSmBeqFNo0cJ45cInJA7DxS025SdOME7tMpyttM4K5ieLNn+pwAXRpHxWMIklP+PmkSeiT1CZsZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710774105; c=relaxed/simple;
	bh=B01v2BmorpeoWlyvMbnBYeRTbh0s/FTEcVKUm1BkdEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UL/fGe659T/n3RAS8BDuLxDmooEllVeA235ol3zsFqZu5rZNYLaMs2fniMbFDaiDyHQhgkNos3tfK1KstYXF0EgPpt5lhdqUeBbNPSPI2CJvsNJSpEE5zgHjygJBmWu3ad72A001CKBHWYZRrPnAAvQVVNuotv7MnM9BxeUKyQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F51FDA7;
	Mon, 18 Mar 2024 08:02:15 -0700 (PDT)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.2.78.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CAE13F67D;
	Mon, 18 Mar 2024 08:01:39 -0700 (PDT)
Date: Mon, 18 Mar 2024 15:01:38 +0000
From: Ionela Voinescu <ionela.voinescu@arm.com>
To: Beata Michalska <beata.michalska@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	vanshikonda@os.amperecomputing.com, sudeep.holla@arm.com,
	will@kernel.org, catalin.marinas@arm.com,
	vincent.guittot@linaro.org, sumitg@nvidia.com,
	yang@os.amperecomputing.com, lihuisong@huawei.com
Subject: Re: [PATCH v3 2/3] arm64: Provide an AMU-based version of
 arch_freq_get_on_cpu
Message-ID: <ZfhXUuwcEC148cdx@arm.com>
References: <20240312083431.3239989-1-beata.michalska@arm.com>
 <20240312083431.3239989-3-beata.michalska@arm.com>
 <ZfGaAGr9Ej6i2EpJ@arm.com>
 <ZfI6y-YScbNzyWDC@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfI6y-YScbNzyWDC@arm.com>

Hey,

On Thursday 14 Mar 2024 at 00:46:19 (+0100), Beata Michalska wrote:
[..]
> > >  static void amu_scale_freq_tick(void)
> > >  {
> > > +	struct amu_cntr_sample *amu_sample = this_cpu_ptr(&cpu_amu_samples);
> > >  	u64 prev_core_cnt, prev_const_cnt;
> > >  	u64 core_cnt, const_cnt, scale;
> > >  
> > > -	prev_const_cnt = this_cpu_read(arch_const_cycles_prev);
> > > -	prev_core_cnt = this_cpu_read(arch_core_cycles_prev);
> > > +	prev_const_cnt = amu_sample->arch_const_cycles_prev;
> > > +	prev_core_cnt = amu_sample->arch_core_cycles_prev;
> > > +
> > > +	write_seqcount_begin(&amu_sample->seq);
> > 
> > The critical section here does not need to be this extensive, right?
> > 
> > The arch_freq_get_on_cpu() function only uses the frequency scale factor
> > and the last_update value, so this need only be placed above
> > "this_cpu_write(arch_freq_scale,..", if I'm not missing anything.
> 
> You're not missing anything. The write side critical section could span only
> those two, but having it extended gives a chance for the readers to get in on
> the update and as those are not really performance sensitive I though it might
> be a good option, especially if we can save the cycles on not needing to poke
> the cpufeq driver. Furthermore, if the critical section is to span only the two,
> then it does not really change much and can be dropped.
> 
> > 
> > >  
> > >  	update_freq_counters_refs();
> > >  
> > > -	const_cnt = this_cpu_read(arch_const_cycles_prev);
> > > -	core_cnt = this_cpu_read(arch_core_cycles_prev);
> > > +	const_cnt = amu_sample->arch_const_cycles_prev;
> > > +	core_cnt = amu_sample->arch_core_cycles_prev;
> > >  
> > > +	/*
> > > +	 * This should not happen unless the AMUs have been reset and the
> > > +	 * counter values have not been resroted - unlikely
> > > +	 */
> > >  	if (unlikely(core_cnt <= prev_core_cnt ||
> > >  		     const_cnt <= prev_const_cnt))
> > > -		return;
> > > +		goto leave;
> > >  
> > >  	/*
> > >  	 *	    /\core    arch_max_freq_scale
> > > @@ -182,6 +204,10 @@ static void amu_scale_freq_tick(void)
> > >  
> > >  	scale = min_t(unsigned long, scale, SCHED_CAPACITY_SCALE);
> > >  	this_cpu_write(arch_freq_scale, (unsigned long)scale);
> > > +
> > > +	amu_sample->last_update = jiffies;
> > > +leave:
> > > +	write_seqcount_end(&amu_sample->seq);
> > >  }
> > >  
> > >  static struct scale_freq_data amu_sfd = {
> > > @@ -189,6 +215,61 @@ static struct scale_freq_data amu_sfd = {
> > >  	.set_freq_scale = amu_scale_freq_tick,
> > >  };
> > >  
> > > +#define AMU_SAMPLE_EXP_MS	20
> > > +
> > > +unsigned int arch_freq_get_on_cpu(int cpu)
> > > +{
> > > +	struct amu_cntr_sample *amu_sample;
> > > +	unsigned long last_update;
> > > +	unsigned int seq;
> > > +	unsigned int freq;
> > > +	u64 scale;
> > > +
> > > +	if (!cpumask_test_cpu(cpu, amu_fie_cpus) || !arch_scale_freq_ref(cpu))
> > > +		return 0;
> > > +
> > > +retry:
> > > +	amu_sample = per_cpu_ptr(&cpu_amu_samples, cpu);
> > > +
> > > +	do {
> > > +		seq = raw_read_seqcount_begin(&amu_sample->seq);
> > > +		last_update = amu_sample->last_update;
> > > +	} while (read_seqcount_retry(&amu_sample->seq, seq));
> > 
> > Related to the point above, this retry loop should also contain
> > "scale = arch_scale_freq_capacity(cpu)", otherwise there's no much point
> > for synchronisation, as far as I can tell.
> I'm not entirely sure why we would need to include the scale factor within
> the read critical section. The aim here is to make sure we see the update if
> one is ongoing and that the update to the timestamp is observed along with
> one to the scale factor, which is what the write_seqcount_end will guarantee
> (although the latter is not a hard sell as the update happens under interrupts
> being disabled). If later on we fetch newer scale factor that's perfectly fine,
> we do not want to see the stale one. Again, I can drop the seqcount (which is
> slightly abused in this case I must admit) at a cost of potentially missing some
> updates.

Replying here for both comments, as they are related.

I fully agree, but I would be more inclined to drop the seqcount. It
would be a game of chance if there was an update in the last few ns of
the 20ms deadline which we might hit or miss due to the presence of an
extended write critical section or the lack of one.

> > 
> > For x86, arch_freq_get_on_cpu() uses the counter deltas and it would be
> > bad if values from different ticks would be used. But here the only
> > benefit of synchronisation is to make sure that we're using the scale
> > factor computed at the last update time. For us, even skipping on the
> > synchronisation logic would still be acceptable, as we'd be ensuring that
> > there was a tick in the past 20ms and we'd always use the most recent
> > value of the frequency scale factor.
> How would we ensure there was a tick in last 20ms ?

I just meant that we'd observe the presence of a tick in the last 20ms
(if there was one) and we don't necessarily need to guarantee that we'd
use the scale factor obtained at that time. We could use the latest, as
you mentioned above as well.

Thanks,
Ionela.

