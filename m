Return-Path: <linux-kernel+bounces-75694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C85585ED7A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A215C1F22A78
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BF812CD85;
	Wed, 21 Feb 2024 23:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Guirq2Cs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF3D84FA5
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 23:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708559877; cv=none; b=DJMg7IypSX7RORLDXoMhrinCZNHpmgllr5WRECEkYTExZGbASqVMYnJI6ZQYaOGqFFjIBO7ug3URtFa36xH3PtgD+mspRDuMKVG4VhYce5xOMhGZcx9YiFAyorJrmT2t1N4lJsSOUnVpGvNDC28X9M1O1dX68/tcAtrSlPtfZ2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708559877; c=relaxed/simple;
	bh=L8PnU0k3Ilr5yG2BNMbT/RBCmodF5s2XXA6BdbEnj/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IcFsrDby0oZyOznCP2NMTL1dR63iHmNZVMV5sBTf5GGttnQK2bXo0XDIX1SmLKY/HqHGvXqpLydKEoRlxq09DPBBX8yUjHL2pu4MUXoKC062F6abrI0UoTfMvcUFQvsXTdUK7etviS1uO5bezZl0f9fO5mz0zWuTI7kwdF8+CyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Guirq2Cs; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708559875; x=1740095875;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L8PnU0k3Ilr5yG2BNMbT/RBCmodF5s2XXA6BdbEnj/U=;
  b=Guirq2CsFDlGFToBY6E/PX9vQgdI7f4nIT6o09xKWTzxejGs7tzJB19V
   QYm/zlWD7SElUGBar6DsRasfyhV3gmntHNjI5eiP6diYfxSLPPXK1ZoyT
   mPyEDl2ml713hUvrC2UecQaqyaP+XF2m4oktkRrMoxD+BEmOGmDGbk9aC
   /X+sT8zRMm3UBcZzTCf4CGcL3d5rdTjRtYfVOFHPfEcZ5Qf+VHIXODbN7
   kooVUFWWASW+44VVDTrBlu+qjXzbVhOKtB9NasHupVpvKuhaX56pmTFMw
   q7IP3YzkbpuRG+5fOwqSvBBTQBoI0Osfhwdkmbv6pLs1x4N7JmgV+faz3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="2626290"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="2626290"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 15:56:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="5199835"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 15:56:59 -0800
Date: Wed, 21 Feb 2024 15:56:58 -0800
From: Tony Luck <tony.luck@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	James Morse <james.morse@arm.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Yu, Fenghua" <fenghua.yu@intel.com>,
	Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	"carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
	"lcherian@marvell.com" <lcherian@marvell.com>,
	"bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
	"tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	"peternewman@google.com" <peternewman@google.com>,
	"dfustini@baylibre.com" <dfustini@baylibre.com>,
	"amitsinght@marvell.com" <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] x86/resctrl: Fix WARN in get_domain_from_cpu()
Message-ID: <ZdaNymyCFAXMn18k@agluck-desk3>
References: <20240213184438.16675-1-james.morse@arm.com>
 <20240217105543.GAZdCQr_nosDP4tGuO@fat_crate.local>
 <87zfvwieli.ffs@tglx>
 <ZdUSwOM9UUNpw84Y@agluck-desk3>
 <d409c32d-0f9a-4773-bc25-9d39de3c9e9b@intel.com>
 <SJ1PR11MB6083A759748EAF62EDF21D0FFC502@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ZdVFDIJmctsNaGd2@agluck-desk3>
 <ZdZPht8hY4J9uIOz@agluck-desk3>
 <89745b84-5ead-4694-b14c-341ca5a688f4@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89745b84-5ead-4694-b14c-341ca5a688f4@intel.com>

On Wed, Feb 21, 2024 at 02:59:43PM -0800, Reinette Chatre wrote:
> Hi Tony,
> 
> On 2/21/2024 11:31 AM, Tony Luck wrote:
> > reset_all_ctrls() and resctrl_arch_update_domains() use on_each_cpu_mask()
> > to call rdt_ctrl_update() on potentially one CPU from each domain.
> > 
> > But this means rdt_ctrl_update() needs to figure out which domain to
> > apply changes to. Doing so requires a search of all domains in a resource,
> > which can only be done safely if cpus_lock is held. Both callers do hold
> > this lock, but there isn't a way for a function called on another CPU
> > via IPI to verify this.
> > 
> > Fix by adding the target domain to the msr_param structure and passing an
> > array with CDP_NUM_TYPES entries. Then calling for each domain separately
> > using smp_call_function_single()
> 
> This work contains no changes to get_domain_from_cpu(). I expect the WARN
> within it to be removed as intended with [1] and then this work can build
> on that without urgency. As I understand, to support the stated goal of this
> work, I expect get_domain_from_cpu() in the end to not have any WARN or
> IS_ENABLED checks, but just a lockdep_assert_cpus_held(). 
> 
> Do you have different expectations?

Same expectations. Boris should apply the simple fix (delete the WARN
that is giving a false positive) for this current cycle.

If there is support for my patch (with changes/fixes you point out
below), then it could be added in the future and get_domain_from_cpu()
can use lockdep_assert_cpus_held().

> > Change the low level cat_wrmsr(), mba_wrmsr_intel(), and mba_wrmsr_amd()
> > functions to just take a msr_param structure since it contains the
> > rdt_resource and rdt_domain information.
> 
> Could moving the rdt_domain into msr_param be done in a separate patch?

I can break it into more pieces if there is enthusiam to apply it.

> ...
> 
> > diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> > index 7997b47743a2..09f6e624f1bb 100644
> > --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> > +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> > @@ -272,22 +272,6 @@ static u32 get_config_index(u32 closid, enum resctrl_conf_type type)
> >  	}
> >  }
> >  
> > -static bool apply_config(struct rdt_hw_domain *hw_dom,
> > -			 struct resctrl_staged_config *cfg, u32 idx,
> > -			 cpumask_var_t cpu_mask)
> > -{
> > -	struct rdt_domain *dom = &hw_dom->d_resctrl;
> > -
> > -	if (cfg->new_ctrl != hw_dom->ctrl_val[idx]) {
> > -		cpumask_set_cpu(cpumask_any(&dom->cpu_mask), cpu_mask);
> > -		hw_dom->ctrl_val[idx] = cfg->new_ctrl;
> > -
> > -		return true;
> > -	}
> > -
> > -	return false;
> > -}
> > -
> >  int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
> >  			    u32 closid, enum resctrl_conf_type t, u32 cfg_val)
> >  {
> > @@ -304,59 +288,50 @@ int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
> >  	msr_param.res = r;
> >  	msr_param.low = idx;
> >  	msr_param.high = idx + 1;
> > -	hw_res->msr_update(d, &msr_param, r);
> > +	hw_res->msr_update(&msr_param);
> >  
> 
> Is this missing setting the domain in msr_param?

Indeed yes.

> >  	return 0;
> >  }
> >  
> >  int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
> >  {
> > +	struct msr_param msr_param[CDP_NUM_TYPES];
> >  	struct resctrl_staged_config *cfg;
> >  	struct rdt_hw_domain *hw_dom;
> > -	struct msr_param msr_param;
> >  	enum resctrl_conf_type t;
> > -	cpumask_var_t cpu_mask;
> >  	struct rdt_domain *d;
> > +	bool need_update;
> > +	int cpu;
> >  	u32 idx;
> >  
> >  	/* Walking r->domains, ensure it can't race with cpuhp */
> >  	lockdep_assert_cpus_held();
> >  
> > -	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
> > -		return -ENOMEM;
> > -
> > -	msr_param.res = NULL;
> > +	memset(msr_param, 0, sizeof(msr_param));
> >  	list_for_each_entry(d, &r->domains, list) {
> >  		hw_dom = resctrl_to_arch_dom(d);
> > +		need_update = false;
> >  		for (t = 0; t < CDP_NUM_TYPES; t++) {
> >  			cfg = &hw_dom->d_resctrl.staged_config[t];
> >  			if (!cfg->have_new_ctrl)
> >  				continue;
> >  
> >  			idx = get_config_index(closid, t);
> > -			if (!apply_config(hw_dom, cfg, idx, cpu_mask))
> > +			if (cfg->new_ctrl == hw_dom->ctrl_val[idx])
> >  				continue;
> > -
> > -			if (!msr_param.res) {
> > -				msr_param.low = idx;
> > -				msr_param.high = msr_param.low + 1;
> > -				msr_param.res = r;
> > -			} else {
> > -				msr_param.low = min(msr_param.low, idx);
> > -				msr_param.high = max(msr_param.high, idx + 1);
> > -			}
> > +			hw_dom->ctrl_val[idx] = cfg->new_ctrl;
> > +			cpu = cpumask_any(&d->cpu_mask);
> > +
> > +			msr_param[t].low = idx;
> > +			msr_param[t].high = msr_param[t].low + 1;
> > +			msr_param[t].res = r;
> > +			msr_param[t].dom = d;
> > +			need_update = true;
> >  		}
> > +		if (need_update)
> > +			smp_call_function_single(cpu, rdt_ctrl_update, &msr_param, 1);
> 
> It is not clear to me why it is needed to pass this additional data. Why not
> just use the original mechanism of letting the low and high of msr_param span the
> multiple indices that need updating? There can still be a "need_update" but it
> can be set when msr_param gets its first data. Any other index needing updating
> can just update low/high and a single msr_param can be used.

For some reason this morning I thought that the domain needed to be
different. It isn't, so keeping the code that just adjusts the range
of MSRs will work just fine.

The "need_update" variable isn't required. I will move the
	msr_param.res = NULL;
inside the for each domain loop, and can use non-NULL value to
decide whether to IPI a CPU.

-Tony

