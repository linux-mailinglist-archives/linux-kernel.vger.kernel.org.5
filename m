Return-Path: <linux-kernel+bounces-140923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 238F98A19A2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2D802897CA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F05E1A0AE0;
	Thu, 11 Apr 2024 15:36:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360EA19DF5E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849765; cv=none; b=uJKdmNT9fjBQkNiQD8agyFUkvfaQJ7gqMb/DogUyE8CbqagximeZR83Kx536umxN5fw7kdCaGVATfK2vHrZGK7Dv+RZe9cG6fim9dQlzkEFwwPqCLlL4Nzsg/P87pBht9eiw0kjX/MxmvQHmJ9T7oPsCzkNAliA7RvG5ICGMrn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849765; c=relaxed/simple;
	bh=0VVDSxDozDuY9366NJCNFekjulkSHGITutb5i0OFTy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9CYrEn/8Pax0BYKYP4vBtTq2Bu00IVqsUu5w8SoV+5G3mpL2a2RNephDLzGzuaP3YUVZGzGh0DIiJKE2ikH9vdwfLrVWO6htIqRdBsMl00XeD9BOUXFwM8CBg/L5fno0onX7VWDDrHx0c84h0k/CwHxKvo4VTCaVIqSgKGVABo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0626D113E;
	Thu, 11 Apr 2024 08:36:33 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 960F23F6C4;
	Thu, 11 Apr 2024 08:36:00 -0700 (PDT)
Date: Thu, 11 Apr 2024 16:35:58 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Shawn Wang <shawnwang@linux.alibaba.com>
Cc: James Morse <james.morse@arm.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
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
Subject: Re: [PATCH v1 10/31] x86/resctrl: Move monitor init work to a
 resctrl init call
Message-ID: <ZhgDXhcUgS/uV3p5@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-11-james.morse@arm.com>
 <beee157c-6e7b-466e-93cd-81a9eb033fe7@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <beee157c-6e7b-466e-93cd-81a9eb033fe7@linux.alibaba.com>

On Wed, Apr 10, 2024 at 10:57:30AM +0800, Shawn Wang wrote:
> Hi James,
> 
> On 3/22/24 12:50 AM, James Morse wrote:
> > rdt_get_mon_l3_config() is called from the architecture's
> > resctrl_arch_late_init(), and initialises both architecture specific
> > fields, such as hw_res->mon_scale and resctrl filesystem fields
> > by calling dom_data_init().
> > 
> > To separate the filesystem and architecture parts of resctrl, this
> > function needs splitting up.
> > 
> > Add resctrl_mon_resource_init() to do the filesystem specific work,
> > and call it from resctrl_init(). This runs later, but is still before
> > the filesystem is mounted and the rmid_ptrs[] array can be used.
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>
> > ---
> >   arch/x86/kernel/cpu/resctrl/internal.h |  1 +
> >   arch/x86/kernel/cpu/resctrl/monitor.c  | 24 +++++++++++++++++-------
> >   arch/x86/kernel/cpu/resctrl/rdtgroup.c |  4 ++++
> >   3 files changed, 22 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> > index 031948322eab..7a0c74779c53 100644
> > --- a/arch/x86/kernel/cpu/resctrl/internal.h
> > +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> > @@ -540,6 +540,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg);
> >   void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
> >   		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
> >   		    int evtid, int first);
> > +int resctrl_mon_resource_init(void);
> >   void mbm_setup_overflow_handler(struct rdt_domain *dom,
> >   				unsigned long delay_ms,
> >   				int exclude_cpu);
> > diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> > index 06565153ceb2..929ec1430b45 100644
> > --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> > +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> > @@ -1003,12 +1003,28 @@ static void l3_mon_evt_init(struct rdt_resource *r)
> >   		list_add_tail(&mbm_local_event.list, &r->evt_list);
> >   }
> > +int resctrl_mon_resource_init(void)
> > +{
> > +	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
> > +	int ret;
> > +
> > +	if (!r->mon_capable)
> > +		return 0;
> > +
> > +	ret = dom_data_init(r);
> > +	if (ret)
> > +		return ret;
> > +
> > +	l3_mon_evt_init(r);
> > +
> > +	return 0;
> > +}
> > +
> 
> Now x86 platform defaults to all monitoring features on the L3 cache, but some monitoring features may also be on the L2 cache or memory controller according to the MPAM spec. For example, the memory bandwidth monitors could be on the memory controller.
> 
> Will resctrl_mon_resource_init() consider this scenario?
> 
> Best Regards,
> Shawn

My understanding is limited here, so this will probably have to wait
until James gets back for a full answer.

The resctrl userspace filesystem interface looks like it can describe
monitors at multiple levels of the memory system, so my assumption would
be that it should be possible to wire it up.

This series focuses on refactoring and does not try to add new
functionality, though.

Cheers
---Dave

