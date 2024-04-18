Return-Path: <linux-kernel+bounces-150376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E69228A9E2F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A213F283DE2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457E816C692;
	Thu, 18 Apr 2024 15:21:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E60C15FA73
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 15:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713453678; cv=none; b=WmDTDGw6O3sVJd/zJev/AI9qPR1PMm+qeg958vJwYQ+n+4/01AjU0Bl3l5o0QV3g4A9iMlzp44Lln7599NPgk100CiNOkZm2eZWUtDZ0+ZBN7ZEAyIGBJFjH3StdhgpPQKUcftBhJp49NzhiCo5hAqOtfIZtlKfa4X25jrKEH2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713453678; c=relaxed/simple;
	bh=BEQoL8Xy1DfYZX7VkjWLZGPArlBBiN1RTUiQ1OWe6kY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQ/LaB8NWvdPEunkLhFruHpxu4S51kI98x3WlOkHn2TYMX7ols7oOQX0JFgq3bQJnNub8bhi2AqNY2kyu99xjqUkU4k7fVxjqJQqqMyBrCCnojCqGjVf6Xijgd9o3iHMDETGV5rXgqC7ZVXeoiCHMpjUCnAi/BV99k4YEe8NuBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D77092F;
	Thu, 18 Apr 2024 08:21:42 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCC4D3F738;
	Thu, 18 Apr 2024 08:21:11 -0700 (PDT)
Date: Thu, 18 Apr 2024 16:21:03 +0100
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
Message-ID: <ZiE6X3nKu1ACFQDc@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-6-james.morse@arm.com>
 <6bbff669-cbe5-4284-b64a-4825a541b35f@intel.com>
 <ZhldWJVck7VmU3G3@e133380.arm.com>
 <0698418a-aede-40d6-90ce-dbf6e8796916@intel.com>
 <Zh6kchkH9Dy+ywXc@e133380.arm.com>
 <069c0e2e-81e1-4343-8a9f-21f1cb74bde6@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <069c0e2e-81e1-4343-8a9f-21f1cb74bde6@intel.com>

On Wed, Apr 17, 2024 at 10:12:35PM -0700, Reinette Chatre wrote:
> Hi Dave,
> 
> On 4/16/2024 9:16 AM, Dave Martin wrote:
> > On Mon, Apr 15, 2024 at 10:47:55AM -0700, Reinette Chatre wrote:
> >> On 4/12/2024 9:12 AM, Dave Martin wrote:
> >>> On Mon, Apr 08, 2024 at 08:16:08PM -0700, Reinette Chatre wrote:
> >>>> On 3/21/2024 9:50 AM, James Morse wrote:
> ..
> 
> >> Do you imply that this would maintain the order in this patch? It does
> >> not look to me that it would but I may be looking wrong.
> > 
> > I'm not sure without looking again, but since this discussion is not a
> > good use of your time I'll just go ahead and implement the change at
> > [*] above, while restoring referse FIR order, if that is good for you.
> > 
> >>
> >> sidenote: the "on_each_cpu_mask()" in update_closid_rmid() can be on
> >> one line.
> > 
> > I guess that might have been split to stick to the 80-char limit.
> > 
> > Due the the small size of this function, shall I just rename defaults_p to p?
> > Alternatively, there are already a few non-printk lines over 80 chars, so
> > maybe we can tolerate one more here?
> 
> 80 chars are not enforced so strictly that it impacts readability. You
> may refer to how update_task_closid_rmid() looks for more confidence in/
> motivation for placing this on one line.

Agreed.

(I did in fact rename default_p to p in my fixup, which shortens the
affected line as a side-effect anyway.)


<aside>

Although probably out of scope for this series, I wonder whether these
two paths can be combined?

update_task_closid_rmid() selects the cross_call target by task, where
update_closid_rmid() selects the cross_call target(s) by cpu.  But the
backend work that the arch code needs to do seems basically the same:
possibly update the the CPU default group membership, the reconfigure
the MSRs for the running task to ensure that they aren't stale (with a
possible optimisation not to bother if we sure that the MSRs are not
stale for the task actually running, or if we know they wouldn't be
changed by the write).

Even the check to see whether the right task is running seems somewhat
redundant: we already paid the cost of taking the IPI, and we have to
cope with spurious, idempotent updates to the MSRs anyway since this is
all racy.

Is there a high overhead to writing the MSRs on x86?

For arm64, the relevant system register only affects EL0 (i.e.,
userspace) execution, so we defer synchronisation of a whole bunch of
stuff until the return to userspace.

</aside>


> 
> > 
> >>
> >> ..
> >>
> >>>>> + * struct resctrl_cpu_sync, or NULL.
> >>>>> + */
> >>>>
> >>>> Updating the CPU's defaults is not the primary goal of this function and because
> >>>> of that I do not think this should be the focus with the main goal (updating
> >>>> RMID and CLOSID on CPU) ignored. Specifically, this function only updates
> >>>> the defaults if *info is set but it _always_ ensures CPU is running with
> >>>> appropriate CLOSID/RMID (which may or may not be from a CPU default).
> >>>>
> >>>> I think resctrl_arch_sync_cpu_closid_rmid() may be more appropriate
> >>>> and the comment needs to elaborate what the function does.
> >>>>
> >>>>> +void resctrl_arch_sync_cpu_defaults(void *info);
> >>>
> >>> That seems reasonable, and follows the original naming and what the
> >>> code does:
> >>>
> >>> What about:
> >>>
> >>> /**
> >>>  * resctrl_arch_sync_cpu_defaults() - Refresh the CPU's CLOSID and RMID.
> >>>  *				      Call via IPI.
> >>
> >> Did you intend to change function name?
> > 
> > Er, yes, I meant to use your suggestion here, so:
> > resctrl_arch_sync_cpu_closid_rmid().
> > 
> 
> I'm a bit confused here when comparing with your response in [1] mentioning
> a change to another name. 
> 
> [1] https://lore.kernel.org/lkml/Zh6kgs1%2fbji1P1Hl@e133380.arm.com/

My bad (sorry Babu!).

I read that suggestion carelessly and assumed it was aligned with
Reinette's.

The most important thing seems to be to transfer the "defaults" from the
name of the function to the name of the struct, since the struct is
about defaults (and only about defaults), while the function is about
defaults and the running task.

To avoid extra busy-work, I'll stick with
resctrl_arch_sync_cpu_closid_rmid() for now, but I don't mind changing
it if people prefer.


> > Also, Babu Moger's suggestion to rename struct resctrl_cpu_sync
> > to resctrl_cpu_defaults seems good, since that accurately describes what
> > is specified in the struct (and what is *not* specified if NULL is
> > passed).
> 
> Sounds good, yes.
> 
> Reinette
> 

Cheers
---Dave

