Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B695A788D91
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 19:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344168AbjHYRF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 13:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344165AbjHYRFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 13:05:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0731FF7;
        Fri, 25 Aug 2023 10:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692983106; x=1724519106;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xjTr3RdquYQZshqoMMrT8zZd5hpw3eVfO5pTE854DFI=;
  b=JUt2HuwwooZCP9V3lg8J7DVGttuVVHkDUj/chZBNuH/WCKYjJCIPBUHH
   dz2ijMbKfjOB23af8LI0FWesKU1HTorDlW26gJK8yhKYXmAGPVf/Vtqoa
   Y4VizRGiOXcO4PO18DmY9uKiJU510c5YhXqIvbLiUb+Uh1aHLjcETpHUt
   SCieoqRUQTSXcLCMU2FPj6Pqhp/MvUSMVWaGfJBHHrBjB3n4mwzAOSkQX
   2I/UCc2arcff/HcJWtz7beJqFVlKM5rHnQYkjk9b3kVO01VUolnMid6ED
   mBGZchz6mIRv3XbZO0rFk32mZIVqcYKPKda/BqO7pFKCHnmQiBDd6WpCf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="359755330"
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="359755330"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 10:05:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="807600289"
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="807600289"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 10:05:04 -0700
Date:   Fri, 25 Aug 2023 10:05:03 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v4 1/7] x86/resctrl: Create separate domains for control
 and monitoring
Message-ID: <ZOjfPx8iwTULTqdg@agluck-desk3>
References: <20230713163207.219710-1-tony.luck@intel.com>
 <20230722190740.326190-1-tony.luck@intel.com>
 <20230722190740.326190-2-tony.luck@intel.com>
 <cc1a144f-6667-18fb-7fe7-cd15ebfedd08@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc1a144f-6667-18fb-7fe7-cd15ebfedd08@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 10:29:25AM -0700, Reinette Chatre wrote:
> Hi Tony,
> 
> On 7/22/2023 12:07 PM, Tony Luck wrote:
> > First step towards supporting resource control where the scope of
> > control operations is not the same as monitor operations.
> 
> Each changelog should stand on its own merit. This changelog
> appears to be written as a continuation of the cover letter.
> 
> Please do ensure that each patch first establishes the context
> before it describes the problem and solution. For example,
> as a context this changelog can start by describing what the
> resctrl domains list represents.
> 
> > 
> > Add an extra list in the rdt_resource structure. For this will
> > just duplicate the existing list of domains based on the L3 cache
> > scope.
> 
> The above paragraph does not make this change appealing at all.
> 
> > Refactor the domain_add_cpu() and domain_remove() functions to
> 
> domain_remove() -> domain_remove_cpu()
> 
> > build separate lists for r->alloc_capable and r->mon_capable
> > resources. Note that only the "L3" domain currently supports
> > both types.
> 
> "L3" domain -> "L3" resource?
> 
> > 
> > Change all places where monitoring functions walk the list of
> > domains to use the new "mondomains" list instead of the old
> > "domains" list.
> 
> I would not refer to it as "the old domains list" as it creates
> impression that this is being replaced. The changelog makes
> no mention that domains list will remain and be dedicated to
> control domains. I think this is important to include in description
> of this change.

I've rewritten the entire commit message incorporating your suggestions.
V6 will be posted soon (after I get some time on an SNC SPR to check
that it all works!)

> 
> > 
> > Signed-off-by: Tony Luck <tony.luck@intel.com>
> > ---
> >  include/linux/resctrl.h                   |  10 +-
> >  arch/x86/kernel/cpu/resctrl/internal.h    |   2 +-
> >  arch/x86/kernel/cpu/resctrl/core.c        | 195 +++++++++++++++-------
> >  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |   2 +-
> >  arch/x86/kernel/cpu/resctrl/monitor.c     |   2 +-
> >  arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  30 ++--
> >  6 files changed, 167 insertions(+), 74 deletions(-)
> > 
> > diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> > index 8334eeacfec5..1267d56f9e76 100644
> > --- a/include/linux/resctrl.h
> > +++ b/include/linux/resctrl.h
> > @@ -151,9 +151,11 @@ struct resctrl_schema;
> >   * @mon_capable:	Is monitor feature available on this machine
> >   * @num_rmid:		Number of RMIDs available
> >   * @cache_level:	Which cache level defines scope of this resource
> > + * @mon_scope:		Scope of this resource if different from cache_level
> 
> I think this addition should be deferred. As it is here it the "if different
> from cache_level" also creates many questions (when will it be different?
> how will it be determined that the scope is different in order to know that
> mon_scope should be used?)

I've gone in a different direction. V6 renames "cache_level" to
"ctrl_scope". I think this makes intent clear from step #1.

> 
> Looking ahead on how mon_scope is used there does not seem to be an "if"
> involved at all ... mon_scope is always the monitoring scope. 

Dropped the "if different" comment. You are correct that this is
unconditionally the monitor scope.

> 
> >   * @cache:		Cache allocation related data
> >   * @membw:		If the component has bandwidth controls, their properties.
> >   * @domains:		All domains for this resource
> 
> A change to the domains comment would also help - to highlight that it is
> now dedicated to control domains.

Done.

> 
> > + * @mondomains:		Monitor domains for this resource
> >   * @name:		Name to use in "schemata" file.
> >   * @data_width:		Character width of data when displaying
> >   * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
> > @@ -169,9 +171,11 @@ struct rdt_resource {
> >  	bool			mon_capable;
> >  	int			num_rmid;
> >  	int			cache_level;
> > +	int			mon_scope;
> >  	struct resctrl_cache	cache;
> >  	struct resctrl_membw	membw;
> >  	struct list_head	domains;
> > +	struct list_head	mondomains;
> >  	char			*name;
> >  	int			data_width;
> >  	u32			default_ctrl;
> 
> ...
> 
> > @@ -384,14 +386,15 @@ void rdt_ctrl_update(void *arg)
> >  }
> >  
> >  /*
> > - * rdt_find_domain - Find a domain in a resource that matches input resource id
> > + * rdt_find_domain - Find a domain in one of the lists for a resource that
> > + * matches input resource id
> >   *
> 
> This change makes the function more vague. I think original summary is
> still accurate, how the list is used can be describe in the details below.
> I see more changes to this function is upcoming and I will comment more 
> at those sites.

Re-worked this based on your other suggestions to have separate find*
functions for ctrl and mon cases calling to common __rdt_find_domain().

> 
> >   * Search resource r's domain list to find the resource id. If the resource
> >   * id is found in a domain, return the domain. Otherwise, if requested by
> >   * caller, return the first domain whose id is bigger than the input id.
> >   * The domain list is sorted by id in ascending order.
> >   */
> > -struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
> > +struct rdt_domain *rdt_find_domain(struct list_head *h, int id,
> >  				   struct list_head **pos)
> >  {
> >  	struct rdt_domain *d;
> > @@ -400,7 +403,7 @@ struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
> >  	if (id < 0)
> >  		return ERR_PTR(-ENODEV);
> >  
> > -	list_for_each(l, &r->domains) {
> > +	list_for_each(l, h) {
> >  		d = list_entry(l, struct rdt_domain, list);
> >  		/* When id is found, return its domain. */
> >  		if (id == d->id)
> > @@ -487,6 +490,94 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
> >  	return 0;
> >  }
> >  
> > +static void domain_add_cpu_ctrl(int cpu, struct rdt_resource *r)
> > +{
> > +	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
> > +	struct list_head *add_pos = NULL;
> > +	struct rdt_hw_domain *hw_dom;
> > +	struct rdt_domain *d;
> > +	int err;
> > +
> > +	d = rdt_find_domain(&r->domains, id, &add_pos);
> > +	if (IS_ERR(d)) {
> > +		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
> > +		return;
> > +	}
> > +
> > +	if (d) {
> > +		cpumask_set_cpu(cpu, &d->cpu_mask);
> > +		if (r->cache.arch_has_per_cpu_cfg)
> > +			rdt_domain_reconfigure_cdp(r);
> > +		return;
> > +	}
> > +
> > +	hw_dom = kzalloc_node(sizeof(*hw_dom), GFP_KERNEL, cpu_to_node(cpu));
> > +	if (!hw_dom)
> > +		return;
> > +
> > +	d = &hw_dom->d_resctrl;
> > +	d->id = id;
> > +	cpumask_set_cpu(cpu, &d->cpu_mask);
> > +
> > +	rdt_domain_reconfigure_cdp(r);
> > +
> > +	if (domain_setup_ctrlval(r, d)) {
> > +		domain_free(hw_dom);
> > +		return;
> > +	}
> > +
> > +	list_add_tail(&d->list, add_pos);
> > +
> > +	err = resctrl_online_ctrl_domain(r, d);
> > +	if (err) {
> > +		list_del(&d->list);
> > +		domain_free(hw_dom);
> > +	}
> > +}
> > +
> > +static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
> > +{
> > +	int id = get_cpu_cacheinfo_id(cpu, r->mon_scope);
> 
> Using a different scope variable but continuing to treat it
> as a cache level creates unnecessary confusion at this point.
> 
> > +	struct list_head *add_pos = NULL;
> > +	struct rdt_hw_domain *hw_dom;
> > +	struct rdt_domain *d;
> > +	int err;
> > +
> > +	d = rdt_find_domain(&r->mondomains, id, &add_pos);
> > +	if (IS_ERR(d)) {
> > +		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
> 
> Note for future change ... this continues to refer to monitor scope as
> a cache id. I did not see this changed in the later patch that actually
> changes how scope is used.

Changed all these messages to refer to scope instead of cache id.

> 
> > +		return;
> > +	}
> > +
> > +	if (d) {
> > +		cpumask_set_cpu(cpu, &d->cpu_mask);
> > +		if (r->cache.arch_has_per_cpu_cfg)
> > +			rdt_domain_reconfigure_cdp(r);
> 
> Copy & paste error?

Indeed yes. This code isn't appropriate for the monitor case.
Deleted.

> 
> > +		return;
> > +	}
> > +
> > +	hw_dom = kzalloc_node(sizeof(*hw_dom), GFP_KERNEL, cpu_to_node(cpu));
> > +	if (!hw_dom)
> > +		return;
> > +
> > +	d = &hw_dom->d_resctrl;
> > +	d->id = id;
> > +	cpumask_set_cpu(cpu, &d->cpu_mask);
> > +
> > +	if (arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
> > +		domain_free(hw_dom);
> > +		return;
> > +	}
> > +
> > +	list_add_tail(&d->list, add_pos);
> > +
> > +	err = resctrl_online_mon_domain(r, d);
> > +	if (err) {
> > +		list_del(&d->list);
> > +		domain_free(hw_dom);
> > +	}
> > +}
> > +
> >  /*
> >   * domain_add_cpu - Add a cpu to a resource's domain list.
> >   *
> > @@ -502,61 +593,19 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
> >   */
> >  static void domain_add_cpu(int cpu, struct rdt_resource *r)
> >  {
> > -	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
> > -	struct list_head *add_pos = NULL;
> > -	struct rdt_hw_domain *hw_dom;
> > -	struct rdt_domain *d;
> > -	int err;
> > -
> > -	d = rdt_find_domain(r, id, &add_pos);
> > -	if (IS_ERR(d)) {
> > -		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
> > -		return;
> > -	}
> > -
> > -	if (d) {
> > -		cpumask_set_cpu(cpu, &d->cpu_mask);
> > -		if (r->cache.arch_has_per_cpu_cfg)
> > -			rdt_domain_reconfigure_cdp(r);
> > -		return;
> > -	}
> > -
> > -	hw_dom = kzalloc_node(sizeof(*hw_dom), GFP_KERNEL, cpu_to_node(cpu));
> > -	if (!hw_dom)
> > -		return;
> > -
> > -	d = &hw_dom->d_resctrl;
> > -	d->id = id;
> > -	cpumask_set_cpu(cpu, &d->cpu_mask);
> > -
> > -	rdt_domain_reconfigure_cdp(r);
> > -
> > -	if (r->alloc_capable && domain_setup_ctrlval(r, d)) {
> > -		domain_free(hw_dom);
> > -		return;
> > -	}
> > -
> > -	if (r->mon_capable && arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
> > -		domain_free(hw_dom);
> > -		return;
> > -	}
> > -
> > -	list_add_tail(&d->list, add_pos);
> > -
> > -	err = resctrl_online_domain(r, d);
> > -	if (err) {
> > -		list_del(&d->list);
> > -		domain_free(hw_dom);
> > -	}
> > +	if (r->alloc_capable)
> > +		domain_add_cpu_ctrl(cpu, r);
> > +	if (r->mon_capable)
> > +		domain_add_cpu_mon(cpu, r);
> >  }
> 
> A resource could be both alloc and mon capable ... both
> domain_add_cpu_ctrl() and domain_add_cpu_mon() can fail.
> Should domain_add_cpu_mon() still be run for a CPU if
> domain_add_cpu_ctrl() failed? 
> 
> Looking ahead the CPU should probably also not be added
> to the default groups mask if a failure occurred.

Existing code doesn't do anything for the case where a CPU
can't be added to a domain (probably the only real error case
is failure to allocate memory for the domain structure).

May be something to tackle in a future series if anyone
thinks this is a serious problem and has suggestions on
what to do. It seems like a catastrophic problem to not
have some CPUs in some/all domains of some resources.
Maybe this should disable mounting resctrl filesystem
completely?

> 
> > -static void domain_remove_cpu(int cpu, struct rdt_resource *r)
> > +static void domain_remove_cpu_ctrl(int cpu, struct rdt_resource *r)
> >  {
> >  	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
> >  	struct rdt_hw_domain *hw_dom;
> >  	struct rdt_domain *d;
> >  
> > -	d = rdt_find_domain(r, id, NULL);
> > +	d = rdt_find_domain(&r->domains, id, NULL);
> >  	if (IS_ERR_OR_NULL(d)) {
> >  		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
> >  		return;
> > @@ -565,7 +614,7 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
> >  
> >  	cpumask_clear_cpu(cpu, &d->cpu_mask);
> >  	if (cpumask_empty(&d->cpu_mask)) {
> > -		resctrl_offline_domain(r, d);
> > +		resctrl_offline_ctrl_domain(r, d);
> >  		list_del(&d->list);
> >  
> >  		/*
> > @@ -578,6 +627,30 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
> >  
> >  		return;
> >  	}
> > +}
> > +
> > +static void domain_remove_cpu_mon(int cpu, struct rdt_resource *r)
> > +{
> > +	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
> 
> Introducing mon_scope can really be deferred ... here the monitoring code
> is not using mon_scope anyway.

Not deferring. But I did fix this to use r->mon_scope. Good catch.

> 
> > +	struct rdt_hw_domain *hw_dom;
> > +	struct rdt_domain *d;
> > +
> > +	d = rdt_find_domain(&r->mondomains, id, NULL);
> > +	if (IS_ERR_OR_NULL(d)) {
> > +		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
> > +		return;
> > +	}
> > +	hw_dom = resctrl_to_arch_dom(d);
> > +
> > +	cpumask_clear_cpu(cpu, &d->cpu_mask);
> > +	if (cpumask_empty(&d->cpu_mask)) {
> > +		resctrl_offline_mon_domain(r, d);
> > +		list_del(&d->list);
> > +
> > +		domain_free(hw_dom);
> > +
> > +		return;
> > +	}
> >  
> >  	if (r == &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl) {
> >  		if (is_mbm_enabled() && cpu == d->mbm_work_cpu) {
> 
> Reinette

-Tony
