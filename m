Return-Path: <linux-kernel+bounces-147215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8635F8A7112
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133E51F212ED
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F2B130492;
	Tue, 16 Apr 2024 16:16:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A2F27446
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 16:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713284218; cv=none; b=mHhHSNdP7rFGqakwI9S9+40PWzaaxg/0F7pzu8CM3LMJhw+8wWY7TakQ0E44t5fxtKlw3IaSBHNEs4CYwStGqeVN0Ll2n8ng6WZyHKU5EjX2KPWDlA0gxgDR4DOs6QkQiEyNHQQeffZ6nLgauD1vzAqtxW20Dvsc7ly9/tlZyQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713284218; c=relaxed/simple;
	bh=yGPl9/wFp5sYFz3QHozF1Rn4eHOEZ6n9LkMpHRunJU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ahz+EKEQDMTafrJ3HP+4XEAkKgcXxqYxhStlAk1LHnGvTZjZMwJ2szbEJ63lEiQ9LvBlsRxYEf1Q2TrzctQZ0vAt4mwCarnHJn/p4Q0x71NB1j7C3hTko751iOOnoD+rye9d28D6/e5jIhxsC0VBT4DqGdPeQc7FGImKK7i7bQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DEEE339;
	Tue, 16 Apr 2024 09:17:24 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 396B73F792;
	Tue, 16 Apr 2024 09:16:53 -0700 (PDT)
Date: Tue, 16 Apr 2024 17:16:50 +0100
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
Message-ID: <Zh6kchkH9Dy+ywXc@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-6-james.morse@arm.com>
 <6bbff669-cbe5-4284-b64a-4825a541b35f@intel.com>
 <ZhldWJVck7VmU3G3@e133380.arm.com>
 <0698418a-aede-40d6-90ce-dbf6e8796916@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0698418a-aede-40d6-90ce-dbf6e8796916@intel.com>

On Mon, Apr 15, 2024 at 10:47:55AM -0700, Reinette Chatre wrote:
> Hi Dave,
> 
> On 4/12/2024 9:12 AM, Dave Martin wrote:
> > On Mon, Apr 08, 2024 at 08:16:08PM -0700, Reinette Chatre wrote:
> >> Hi James,
> >>
> >> On 3/21/2024 9:50 AM, James Morse wrote:
> >>> update_cpu_closid_rmid() takes a struct rdtgroup as an argument, which
> >>> it uses to update the local CPUs default pqr values. This is a problem
> >>> once the resctrl parts move out to /fs/, as the arch code cannot
> >>> poke around inside struct rdtgroup.
> >>>
> >>> Rename update_cpu_closid_rmid() as resctrl_arch_sync_cpus_defaults()
> >>> to be used as the target of an IPI, and pass the effective CLOSID
> >>> and RMID in a new struct.
> >>>
> >>> Signed-off-by: James Morse <james.morse@arm.com>
> >>> ---
> >>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 19 +++++++++++++++----
> >>>  include/linux/resctrl.h                | 11 +++++++++++
> >>>  2 files changed, 26 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> >>> index 5d2c1ce5b6b1..18f097fce51e 100644
> >>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> >>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> >>> @@ -341,13 +341,13 @@ static int rdtgroup_cpus_show(struct kernfs_open_file *of,
> >>>   * from update_closid_rmid() is protected against __switch_to() because
> >>>   * preemption is disabled.
> >>>   */
> >>> -static void update_cpu_closid_rmid(void *info)
> >>> +void resctrl_arch_sync_cpu_defaults(void *info)
> >>>  {
> >>> -	struct rdtgroup *r = info;
> >>> +	struct resctrl_cpu_sync *r = info;
> >>>  
> >>>  	if (r) {
> >>>  		this_cpu_write(pqr_state.default_closid, r->closid);
> >>> -		this_cpu_write(pqr_state.default_rmid, r->mon.rmid);
> >>> +		this_cpu_write(pqr_state.default_rmid, r->rmid);
> >>>  	}
> >>>  
> >>>  	/*
> >>> @@ -362,11 +362,22 @@ static void update_cpu_closid_rmid(void *info)
> >>>   * Update the PGR_ASSOC MSR on all cpus in @cpu_mask,
> >>>   *
> >>>   * Per task closids/rmids must have been set up before calling this function.
> >>> + * @r may be NULL.
> >>>   */
> >>>  static void
> >>>  update_closid_rmid(const struct cpumask *cpu_mask, struct rdtgroup *r)
> >>>  {
> >>> -	on_each_cpu_mask(cpu_mask, update_cpu_closid_rmid, r, 1);
> >>> +	struct resctrl_cpu_sync defaults;
> >>> +	struct resctrl_cpu_sync *defaults_p = NULL;
> >>
> >> Please maintain reverse fir order.
> > 
> > Or, more tersely as follows?
> > 
> > 	struct resctrl_cpu_sync defaults, *defaults_p = NULL;
> 
> Sure.

[*]

> > 
> > "Reverse fir order" seems to be documented as a preference rather than a
> > rule.
> 
> This does not seem to be a place that warrants an exception to this
> preference. Note how this function is not consistent with any other
> in the file.

Ack (just bikeshedding here TBH).

> 
> > The declarations can be swapped, but defaults_p is in some sense a weak
> > pointer to defaults, so it feels a bit strange to declare them backwards.
> > 
> > Alternatively, could we rename defaults_p to p?  Given the size of this
> > function I don't think that impacts clarity.

[...]

> > 
> > I'll wait for your opinion on this.
> > 
> > 
> 
> Do you imply that this would maintain the order in this patch? It does
> not look to me that it would but I may be looking wrong.

I'm not sure without looking again, but since this discussion is not a
good use of your time I'll just go ahead and implement the change at
[*] above, while restoring referse FIR order, if that is good for you.

> 
> sidenote: the "on_each_cpu_mask()" in update_closid_rmid() can be on
> one line.

I guess that might have been split to stick to the 80-char limit.

Due the the small size of this function, shall I just rename defaults_p to p?
Alternatively, there are already a few non-printk lines over 80 chars, so
maybe we can tolerate one more here?

> 
> ..
> 
> >>> + * struct resctrl_cpu_sync, or NULL.
> >>> + */
> >>
> >> Updating the CPU's defaults is not the primary goal of this function and because
> >> of that I do not think this should be the focus with the main goal (updating
> >> RMID and CLOSID on CPU) ignored. Specifically, this function only updates
> >> the defaults if *info is set but it _always_ ensures CPU is running with
> >> appropriate CLOSID/RMID (which may or may not be from a CPU default).
> >>
> >> I think resctrl_arch_sync_cpu_closid_rmid() may be more appropriate
> >> and the comment needs to elaborate what the function does.
> >>
> >>> +void resctrl_arch_sync_cpu_defaults(void *info);
> > 
> > That seems reasonable, and follows the original naming and what the
> > code does:
> > 
> > What about:
> > 
> > /**
> >  * resctrl_arch_sync_cpu_defaults() - Refresh the CPU's CLOSID and RMID.
> >  *				      Call via IPI.
> 
> Did you intend to change function name?

Er, yes, I meant to use your suggestion here, so:
resctrl_arch_sync_cpu_closid_rmid().

Also, Babu Moger's suggestion to rename struct resctrl_cpu_sync
to resctrl_cpu_defaults seems good, since that accurately describes what
is specified in the struct (and what is *not* specified if NULL is
passed).

> 
> How about "Refresh the CPU's ..." -> "Refresh this CPU's ..." I think it
> makes it more obvious how this function is called.

Agreed.

> 
> >  * @info:	If non-NULL, a pointer to a struct resctrl_cpu_sync specifying
> >  *		the new CLOSID and RMID for tasks in the default resctrl ctrl
> >  *		and mon group when running on this CPU.  If NULL, the default
> >  *		CLOSID and RMID are not changed.
> 
> "If NULL, this CPU is not re-assigned to a different group." ?

Agreed.

> >  *
> >  * This is how reassignment of CPUs and/or tasks to different resctrl groups
> >  * is propagated when requested by the resctrl fs core code.
> 
> Could you please use imperative tone here?  For example, "Propagates reassignment
> of CPUs and/or tasks to different resctrl groups."

Yes, that's better (and shorter).

> 
> >  *
> >  * This function should typically record the per-cpu defaults specified by
> 
> "should" sounds like there may be cases when this is not done? Maybe just
> "Records the per-CPU defaults specified ..."

I didn't want to pre-judge what implementation-specific cruft the arch
code needs here, so I was intentionally vague.  But the arch would need
to put the CPU defaults into effect somehow or other, so yes, I think
your text is better here.

I'll make a note of those changes.

[...]

Cheers
---Dave

