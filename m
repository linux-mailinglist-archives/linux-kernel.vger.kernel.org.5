Return-Path: <linux-kernel+bounces-143023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 482DE8A3358
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B7E81C246FD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D39148FEE;
	Fri, 12 Apr 2024 16:12:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD001474A2
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 16:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938340; cv=none; b=HlFxH+889plT4PyHlexVVIPQD4RfqSFXdKMl17WCUaZId9Q9DtVaYvVeeCeaxWewRiOE3sJ3s/xQfEaqaR7XaChrrKPeO0idJANzY7ulom9lBEyXUITq9eJhTBaMWlPwn8d4/lE5i71lZmDBoM7EVcNtF/LB6UA+21JL0Ba/9rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938340; c=relaxed/simple;
	bh=iFq6HUwsZ+yQ51vSn3XxUBy2Qqrq2aWHcrC3qBN9gc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJWK02o0k3sLfCHlH1+zftEWiu+SYBW+TXNlppcohRUJfwLd+ikqEvz0D09c0ubTK19/WxGtelTkYjsKCOorPec01nxEPoBWiyeXHhPkjAXzZSViQjkVgVD7M1fzckiZlWiHqhv/CcKTQ5AJWjahvTBNzve/Ei3TacR3hxMY23k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99DBC339;
	Fri, 12 Apr 2024 09:12:46 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D7603F64C;
	Fri, 12 Apr 2024 09:12:14 -0700 (PDT)
Date: Fri, 12 Apr 2024 17:12:08 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: James Morse <james.morse@arm.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com, lcherian@marvell.com,
	bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
	dfustini@baylibre.com, amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>
Subject: Re: [PATCH v1 05/31] x86/resctrl: Remove rdtgroup from
 update_cpu_closid_rmid()
Message-ID: <ZhldWJVck7VmU3G3@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-6-james.morse@arm.com>
 <6bbff669-cbe5-4284-b64a-4825a541b35f@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bbff669-cbe5-4284-b64a-4825a541b35f@intel.com>

On Mon, Apr 08, 2024 at 08:16:08PM -0700, Reinette Chatre wrote:
> Hi James,
> 
> On 3/21/2024 9:50 AM, James Morse wrote:
> > update_cpu_closid_rmid() takes a struct rdtgroup as an argument, which
> > it uses to update the local CPUs default pqr values. This is a problem
> > once the resctrl parts move out to /fs/, as the arch code cannot
> > poke around inside struct rdtgroup.
> > 
> > Rename update_cpu_closid_rmid() as resctrl_arch_sync_cpus_defaults()
> > to be used as the target of an IPI, and pass the effective CLOSID
> > and RMID in a new struct.
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>
> > ---
> >  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 19 +++++++++++++++----
> >  include/linux/resctrl.h                | 11 +++++++++++
> >  2 files changed, 26 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > index 5d2c1ce5b6b1..18f097fce51e 100644
> > --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > @@ -341,13 +341,13 @@ static int rdtgroup_cpus_show(struct kernfs_open_file *of,
> >   * from update_closid_rmid() is protected against __switch_to() because
> >   * preemption is disabled.
> >   */
> > -static void update_cpu_closid_rmid(void *info)
> > +void resctrl_arch_sync_cpu_defaults(void *info)
> >  {
> > -	struct rdtgroup *r = info;
> > +	struct resctrl_cpu_sync *r = info;
> >  
> >  	if (r) {
> >  		this_cpu_write(pqr_state.default_closid, r->closid);
> > -		this_cpu_write(pqr_state.default_rmid, r->mon.rmid);
> > +		this_cpu_write(pqr_state.default_rmid, r->rmid);
> >  	}
> >  
> >  	/*
> > @@ -362,11 +362,22 @@ static void update_cpu_closid_rmid(void *info)
> >   * Update the PGR_ASSOC MSR on all cpus in @cpu_mask,
> >   *
> >   * Per task closids/rmids must have been set up before calling this function.
> > + * @r may be NULL.
> >   */
> >  static void
> >  update_closid_rmid(const struct cpumask *cpu_mask, struct rdtgroup *r)
> >  {
> > -	on_each_cpu_mask(cpu_mask, update_cpu_closid_rmid, r, 1);
> > +	struct resctrl_cpu_sync defaults;
> > +	struct resctrl_cpu_sync *defaults_p = NULL;
> 
> Please maintain reverse fir order.

Or, more tersely as follows?

	struct resctrl_cpu_sync defaults, *defaults_p = NULL;

"Reverse fir order" seems to be documented as a preference rather than a
rule.

The declarations can be swapped, but defaults_p is in some sense a weak
pointer to defaults, so it feels a bit strange to declare them backwards.

Alternatively, could we rename defaults_p to p?  Given the size of this
function I don't think that impacts clarity.

I'll wait for your opinion on this.


> > +
> > +	if (r) {
> > +		defaults.closid = r->closid;
> > +		defaults.rmid = r->mon.rmid;
> > +		defaults_p = &defaults;
> > +	}
> > +
> > +	on_each_cpu_mask(cpu_mask, resctrl_arch_sync_cpu_defaults, defaults_p,
> > +			 1);
> >  }
> >  
> >  static int cpus_mon_write(struct rdtgroup *rdtgrp, cpumask_var_t newmask,
> > diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> > index 6e87bc95f5ea..2b79e4159507 100644
> > --- a/include/linux/resctrl.h
> > +++ b/include/linux/resctrl.h
> > @@ -220,6 +220,17 @@ struct resctrl_schema {
> >  	u32				num_closid;
> >  };
> >  
> > +struct resctrl_cpu_sync {
> > +	u32 closid;
> > +	u32 rmid;
> > +};
> > +
> > +/*
> > + * Update and re-load this CPUs defaults. Called via IPI, takes a pointer to
> 
> "this CPU's defaults"?

Ack (also in the commit message).

> 
> > + * struct resctrl_cpu_sync, or NULL.
> > + */
> 
> Updating the CPU's defaults is not the primary goal of this function and because
> of that I do not think this should be the focus with the main goal (updating
> RMID and CLOSID on CPU) ignored. Specifically, this function only updates
> the defaults if *info is set but it _always_ ensures CPU is running with
> appropriate CLOSID/RMID (which may or may not be from a CPU default).
> 
> I think resctrl_arch_sync_cpu_closid_rmid() may be more appropriate
> and the comment needs to elaborate what the function does.
>
> > +void resctrl_arch_sync_cpu_defaults(void *info);

That seems reasonable, and follows the original naming and what the
code does:

What about:

/**
 * resctrl_arch_sync_cpu_defaults() - Refresh the CPU's CLOSID and RMID.
 *				      Call via IPI.
 * @info:	If non-NULL, a pointer to a struct resctrl_cpu_sync specifying
 *		the new CLOSID and RMID for tasks in the default resctrl ctrl
 *		and mon group when running on this CPU.  If NULL, the default
 *		CLOSID and RMID are not changed.
 *
 * This is how reassignment of CPUs and/or tasks to different resctrl groups
 * is propagated when requested by the resctrl fs core code.
 *
 * This function should typically record the per-cpu defaults specified by
 * @info (if any), and then reconfigure the CPU's hardware CLOSID and RMID
 * for subsequent execution based on @current, in the same way as during a
 * task switch.
 */

..?


Cheers
---Dave

