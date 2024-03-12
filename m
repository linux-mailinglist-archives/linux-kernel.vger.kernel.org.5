Return-Path: <linux-kernel+bounces-99963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB7C878FE9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D33A1F21FEB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428CA77F0A;
	Tue, 12 Mar 2024 08:45:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0918577A0E;
	Tue, 12 Mar 2024 08:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710233139; cv=none; b=UD/dMQTAjEikFviFALDA1o78TYK+Izhn981Vf49vH55R+XBVFhZKf+JriZNkzNPNfhOVCA3L/4xoYkEQf6UATgdF5648NpEN4sZRJgXxr42hNVx5b3sYiLaRaYnV1sxvMoIgyUul56du5gIL3UXHn0tgXuLDgs6eBnUVmnsYIH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710233139; c=relaxed/simple;
	bh=sh38yJG3tCaBIyKt3Moq30fT1P7GQyX2mpE8GaX4Wzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntfx0MeqHSgr3tJt7BbEk2mVbXFWFBHv0w0Qap38YW0rPybeCCp6Kp/msP/FjRI6aYz2IoW3gMk+YcgUe+vXVUhRv/qUMHS9nnKlDBbTnXhd1dclt7wd4MDgcNeWKG8DXbOJuatfvY9a1TySW5BPYfAVNPyauGhr1rfOl6Pxkc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 772891007;
	Tue, 12 Mar 2024 01:46:14 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC9F73F73F;
	Tue, 12 Mar 2024 01:45:33 -0700 (PDT)
Date: Tue, 12 Mar 2024 09:44:52 +0100
From: Beata Michalska <beata.michalska@arm.com>
To: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
Cc: "lihuisong (C)" <lihuisong@huawei.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, rafael@kernel.org,
	sumitg@nvidia.com, zengheng4@huawei.com,
	yang@os.amperecomputing.com, will@kernel.org, sudeep.holla@arm.com,
	liuyonglong@huawei.com, zhanjie9@hisilicon.com,
	linux-acpi@vger.kernel.org
Subject: Re: Re: [PATCH v1 2/3] arm64: idle: Cache AMU counters before
 entering idle
Message-ID: <ZfAWBPEnjcv1xS0J@arm.com>
References: <20240229162520.970986-1-vanshikonda@os.amperecomputing.com>
 <20240229162520.970986-3-vanshikonda@os.amperecomputing.com>
 <3ed907bf-9526-3a46-41b9-8a0c747122f1@huawei.com>
 <ghmdr7gksgdedikslax2wdxfzzifu3drviuhifbshhvgksmxjr@7giez2rzppil>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ghmdr7gksgdedikslax2wdxfzzifu3drviuhifbshhvgksmxjr@7giez2rzppil>

On Mon, Mar 11, 2024 at 11:27:27AM -0700, Vanshidhar Konda wrote:
> On Thu, Mar 07, 2024 at 11:17:26AM +0800, lihuisong (C) wrote:
> > 
> > 在 2024/3/1 0:25, Vanshidhar Konda 写道:
> > > AMU counters do not increment while a CPU is in idle. Saving the value
> > > of the core and constant counters prior to invoking WFI allows FIE to
> > > compute the frequency of a CPU that is idle.
> > > 
> > > Signed-off-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
> > > ---
> > >  arch/arm64/kernel/idle.c     | 10 ++++++++++
> > >  arch/arm64/kernel/topology.c | 14 ++++++++------
> > >  2 files changed, 18 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/arch/arm64/kernel/idle.c b/arch/arm64/kernel/idle.c
> > > index 05cfb347ec26..5ed2e57188a8 100644
> > > --- a/arch/arm64/kernel/idle.c
> > > +++ b/arch/arm64/kernel/idle.c
> > > @@ -26,6 +26,16 @@ void __cpuidle cpu_do_idle(void)
> > >  	arm_cpuidle_save_irq_context(&context);
> > > +#ifdef CONFIG_ARM64_AMU_EXTN
> > > +	/* Update the AMU counters before entering WFI. The cached AMU counter
> > > +	 * value is used to determine CPU frequency while the CPU is idle
> > > +	 * without needing to wake up the CPU.
> > > +	 */
> > > +
> > > +	if (cpu_has_amu_feat(smp_processor_id()))
> > > +		update_freq_counters_refs();
> > > +#endif
> > The below point I has mentioned in [1].
> > This is just for the WFI state.
> > What about other deeper idle states, like retention and power down?
> > The path to enter idle state is different for them. We should do this
> > for all idle states.
> > 
> 
> Yes. That makes sense. I'll account for them in the next version of the
> patch. I'll work on the next version of the patch based on the updated
> patch from @Beata.
> 
This should now be covered by [1]

---
[1]https://lore.kernel.org/all/20240312083431.3239989-4-beata.michalska@arm.com/

---
BR
Beata

> Thanks,
> Vanshi
> 
> > > +
> > >  	dsb(sy);
> > >  	wfi();
> > > diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> > > index db8d14525cf4..8905eb0c681f 100644
> > > --- a/arch/arm64/kernel/topology.c
> > > +++ b/arch/arm64/kernel/topology.c
> > > @@ -240,13 +240,15 @@ unsigned int arch_freq_get_on_cpu(int cpu)
> > >  	} while (read_seqcount_retry(&cpu_sample->seq, seq));
> > >  	/*
> > > -	 * Bail on invalid count and when the last update was too long ago,
> > > -	 * which covers idle and NOHZ full CPUs.
> > > +	 * Bail on invalid count and when the last update was too long ago.
> > > +	 * This covers idle, NOHZ full and isolated CPUs.
> > > +	 *
> > > +	 * Idle CPUs don't need to be measured because AMU counters stop
> > > +	 * incrementing during WFI/WFE.
> > >  	 */
> > > -	if (!delta_const_cnt || ((jiffies - last) > MAX_SAMPLE_AGE)) {
> > > -		if (!(housekeeping_cpu(cpu, HK_TYPE_TICK) && idle_cpu(cpu)))
> > > -			goto fallback;
> > > -	}
> > > +	if (!delta_const_cnt ||
> > > +	    ((jiffies - last) > MAX_SAMPLE_AGE && !idle_cpu(cpu)))
> > > +		goto fallback;
> > >  	/*
> > >  	 * CPU frequency = reference perf (in Hz) * (/\ delivered) / (/\ reference)
> > [1] https://lore.kernel.org/linux-arm-kernel/20231212072617.14756-1-lihuisong@huawei.com/
> > 

