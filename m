Return-Path: <linux-kernel+bounces-147212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B7E8A710C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099DF1F22AD6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDC213174B;
	Tue, 16 Apr 2024 16:15:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4C31E876
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 16:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713284117; cv=none; b=dRPP0eIeESPTFlHRBX+9rdaLKS+FMSg89IXIcALfafTUYoaA0vbf9o36iG12qm/e4i+STrGTJnmZjMLEFDA4PcU5xVhqKTMgCJV0Qr4RUvRZH3foJMBN5Mt+VZn3f82NFsOCpGx+dMaJCnliVO286/kL7uMbCKnb0NnnZLtFG84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713284117; c=relaxed/simple;
	bh=TQmb2s+xTbvPTiPV3fGqbdQmgFMdrxBUkbN8IxTkLrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HoyoyIHKaZCJohebxtsDdodZn/Ls+bC7uawZtY6WhOQ4RhI5dGY8BpuR33noJO+foUgQBZvzRRICkg9KaKpf39GJwVwPmZ+UKGeyUdw5Dx7U1f2LFvgRhoZdokY2lxMcLxJWFtOWnU6Pb2d3BiFuGGmShfiZnHdtXL7CajLIPyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BA79339;
	Tue, 16 Apr 2024 09:15:43 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3375B3F792;
	Tue, 16 Apr 2024 09:15:12 -0700 (PDT)
Date: Tue, 16 Apr 2024 17:15:09 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: "Moger, Babu" <babu.moger@amd.com>
Cc: James Morse <james.morse@arm.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>, shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com, lcherian@marvell.com,
	bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
	dfustini@baylibre.com, amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>
Subject: Re: [PATCH v1 02/31] x86/resctrl: Add a helper to avoid reaching
 into the arch code resource list
Message-ID: <Zh6kDStUw8AThV4s@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-3-james.morse@arm.com>
 <0790c576-944a-45f8-bc43-01eb0a8f67a9@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0790c576-944a-45f8-bc43-01eb0a8f67a9@amd.com>

On Mon, Apr 15, 2024 at 03:28:18PM -0500, Moger, Babu wrote:
> Hi James/Dave,
> 
> On 3/21/24 11:50, James Morse wrote:
> > Resctrl occasionally wants to know something about a specific resource,
> > in these cases it reaches into the arch code's rdt_resources_all[]
> > array.
> > 
> > Once the filesystem parts of resctrl are moved to /fs/, this means it
> > will need visibility of the architecture specific struct
> > resctrl_hw_resource definition, and the array of all resources.
> > All architectures would also need a r_resctrl member in this struct.
> > 
> > Instead, abstract this via a helper to allow architectures to do
> > different things here. Move the level enum to the resctrl header and
> > add a helper to retrieve the struct rdt_resource by 'rid'.
> > 
> > resctrl_arch_get_resource() should not return NULL for any value in
> > the enum, it may instead return a dummy resource that is
> > !alloc_enabled && !mon_enabled.
> 
> Nit.
> You may want to drop the second half of the statement. We don't have a
> dummy resource.

I guess not, but MPAM will, although I haven't fully understood the
logic.  See:

https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/tree/drivers/platform/mpam/mpam_resctrl.c?h=mpam/snapshot/v6.7-rc2

(Search for "dummy".)


In any case, the statement above is part of the definition of the new
interface: the resctrl core code is going to explicitly need to cope
with a dummy resource being returned, and the arch code is required
to return a pointer to something and not NULL.

So I would say that it is appropriate (or, at the very least, harmless)
to keep that statement here?

> 
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>
> > ---
> >  arch/x86/kernel/cpu/resctrl/core.c        | 10 +++++++++-
> >  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  2 +-
> >  arch/x86/kernel/cpu/resctrl/internal.h    | 10 ----------
> >  arch/x86/kernel/cpu/resctrl/monitor.c     |  8 ++++----
> >  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 15 +++++++--------
> >  include/linux/resctrl.h                   | 17 +++++++++++++++++
> >  6 files changed, 38 insertions(+), 24 deletions(-)
> > 

[...]

> > diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > index 1767c1affa60..45372b6a6215 100644
> > --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c

[...]

> > @@ -2625,10 +2625,10 @@ static void schemata_list_destroy(void)
> >  
> >  static int rdt_get_tree(struct fs_context *fc)
> >  {
> > +	struct rdt_resource *l3 = resctrl_arch_get_resource(RDT_RESOURCE_L3);
> 
> Its is probably best to keep the resource name as r here to be consistent
> with other changes.
> 
> >  	struct rdt_fs_context *ctx = rdt_fc2context(fc);
> >  	unsigned long flags = RFTYPE_CTRL_BASE;
> >  	struct rdt_domain *dom;
> > -	struct rdt_resource *r;
> >  	int ret;
> >  
> >  	cpus_read_lock();
> > @@ -2701,8 +2701,7 @@ static int rdt_get_tree(struct fs_context *fc)
> >  		resctrl_mounted = true;
> >  
> >  	if (is_mbm_enabled()) {
> > -		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> > -		list_for_each_entry(dom, &r->domains, list)
> > +		list_for_each_entry(dom, &l3->domains, list)
> >  			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL,
> >  						   RESCTRL_PICK_ANY_CPU);
> >  	}
> > @@ -3878,7 +3877,7 @@ static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *kf)

[...]

> Thanks
> Babu Moger

[...]

Yes, this does look a bit odd.

This looks like a no-op change to me -- I think that
resctrl_arch_get_resource() is supposed to be without side-effects,
so I would have expected this to be a one-line change at the assignment
to r, with no particular need for renaming r.

Does that make sense to you, or is there some complexity I'm not
noticing here?

Cheers
---Dave

