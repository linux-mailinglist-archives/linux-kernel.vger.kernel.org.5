Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0EFD7AE327
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 02:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbjIZA5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 20:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjIZA5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 20:57:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F0E109;
        Mon, 25 Sep 2023 17:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695689826; x=1727225826;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kWOrB4zO64UWmGfTlry+4aeq1uRND9+gyWJsQM/JdDc=;
  b=ma20tYGf917DdlQGw95oWGu4pOJrhilMxINnmy+tOTGJrZRSfsG7Oo+7
   6u59S6C0lenoMz5X5PqAPcorvmT2F2T6CB0yXGn/9T9sGpbEb521WndDV
   ncs/GxdsUAnRcUXIKfF4GkfT04V3aP9Vm/My2LHukkaiy2LOh4a1m4gJR
   lrYKae4AMiw0QTbZzOzIaZXYM+DWNm7dIh/Kf8rD1UFRqEDNiI+Kdc0/i
   y5AP0gjdtU1yuUZuhMtzM2WW9rr+ybn72SA4NcjuNLXXEQtK2uOT7Q7XQ
   Zhq2IVhfjDdizEoJxSD+hdYw3JQ0h3FvMG1hseeRsgSR6tCaENI8Gy5KH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="366510614"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="366510614"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 17:57:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="838807135"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="838807135"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 17:56:59 -0700
Date:   Mon, 25 Sep 2023 17:56:58 -0700
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
Subject: Re: [PATCH v5 1/8] x86/resctrl: Prepare for new domain scope
Message-ID: <ZRIsWmIiL8O57c9w@agluck-desk3>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-2-tony.luck@intel.com>
 <25dae76d-9e8e-9381-066f-7eaeadb85dc7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25dae76d-9e8e-9381-066f-7eaeadb85dc7@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 04:22:29PM -0700, Reinette Chatre wrote:
> Hi Tony,
> 
> On 8/29/2023 4:44 PM, Tony Luck wrote:
> > Legacy resctrl features operated on subsets of CPUs in the system with
> 
> What is a "legacy" resctrl feature? I am not aware of anything in resctrl
> that distinguishes a feature as legacy. Could "resctrl resource" be more
> appropriate to match the resctrl implementation? 

Ok. Will change.

> 
> Please use "operate on" instead of "operated on".

Ditto.

> 
> > the defining attribute of each subset being an instance of a particular
> > level of cache. E.g. all CPUs sharing an L3 cache would be part of the
> > same domain.
> > 
> > In preparation for features that are scoped at the NUMA node level
> > change the code from explicit references to "cache_level" to a more
> > generic scope. At this point the only options for this scope are groups
> > of CPUs that share an L2 cache or L3 cache.
> > 
> > No functional change.
> > 
> > Signed-off-by: Tony Luck <tony.luck@intel.com>
> > ---
> >  include/linux/resctrl.h                   |  9 ++++++--
> >  arch/x86/kernel/cpu/resctrl/core.c        | 27 ++++++++++++++++++-----
> >  arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 15 ++++++++++++-
> >  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 15 ++++++++++++-
> >  4 files changed, 56 insertions(+), 10 deletions(-)
> > 
> > diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> > index 8334eeacfec5..2db1244ae642 100644
> > --- a/include/linux/resctrl.h
> > +++ b/include/linux/resctrl.h
> > @@ -144,13 +144,18 @@ struct resctrl_membw {
> >  struct rdt_parse_data;
> >  struct resctrl_schema;
> >  
> > +enum resctrl_scope {
> > +	RESCTRL_L3_CACHE,
> > +	RESCTRL_L2_CACHE,
> > +};
> 
> I'm curious why L3 appears before L2? This is not a big deal but
> I think the additional indirection that this introduces is
> not necessary. As you had in an earlier version this could be
> RESCTRL_L2_CACHE = 2 and then the value can just be used directly
> (after ensuring it is used in a valid context).

I appear to have misundertood your earlier comments. I thought you
didn't like my use of RESCTRL_L2_CACHE = 2, and RESCTRL_L3_CACHE = 3
so that the could be passed directly to get_cpu_cacheinfo_id().

But I see now the issue was "after ensuring it is used in a valid
context". Are you looking for something like this:

enum resctrl_scope {
	RESCTRL_UNINITIALIZED_SCOPE = 0,
	RESCTRL_L2_CACHE = 2,
	RESCTRL_L3_CACHE = 3,
	RESCTRL_L3_NODE = 4,
};

static int get_domain_id_from_scope(int cpu, enum resctrl_scope scope)
{
	switch (scope) {
	case RESCTRL_L2_CACHE:
	case RESCTRL_L3_CACHE:
		return get_cpu_cacheinfo_id(cpu, scope);
	case RESCTRL_NODE:
		return cpu_to_node(cpu);
	default:
	case RESCTRL_UNINITIALIZED_SCOPE:
		WARN_ON_ONCE(1);
		return -1;
	}

	return -1;
}

> 
> > +
> >  /**
> >   * struct rdt_resource - attributes of a resctrl resource
> >   * @rid:		The index of the resource
> >   * @alloc_capable:	Is allocation available on this machine
> >   * @mon_capable:	Is monitor feature available on this machine
> >   * @num_rmid:		Number of RMIDs available
> > - * @cache_level:	Which cache level defines scope of this resource
> > + * @scope:		Scope of this resource
> >   * @cache:		Cache allocation related data
> >   * @membw:		If the component has bandwidth controls, their properties.
> >   * @domains:		All domains for this resource
> > @@ -168,7 +173,7 @@ struct rdt_resource {
> >  	bool			alloc_capable;
> >  	bool			mon_capable;
> >  	int			num_rmid;
> > -	int			cache_level;
> > +	enum resctrl_scope	scope;
> >  	struct resctrl_cache	cache;
> >  	struct resctrl_membw	membw;
> >  	struct list_head	domains;
> > diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> > index 030d3b409768..0d3bae523ecb 100644
> > --- a/arch/x86/kernel/cpu/resctrl/core.c
> > +++ b/arch/x86/kernel/cpu/resctrl/core.c
> > @@ -65,7 +65,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
> >  		.r_resctrl = {
> >  			.rid			= RDT_RESOURCE_L3,
> >  			.name			= "L3",
> > -			.cache_level		= 3,
> > +			.scope			= RESCTRL_L3_CACHE,
> >  			.domains		= domain_init(RDT_RESOURCE_L3),
> >  			.parse_ctrlval		= parse_cbm,
> >  			.format_str		= "%d=%0*x",
> > @@ -79,7 +79,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
> >  		.r_resctrl = {
> >  			.rid			= RDT_RESOURCE_L2,
> >  			.name			= "L2",
> > -			.cache_level		= 2,
> > +			.scope			= RESCTRL_L2_CACHE,
> >  			.domains		= domain_init(RDT_RESOURCE_L2),
> >  			.parse_ctrlval		= parse_cbm,
> >  			.format_str		= "%d=%0*x",
> > @@ -93,7 +93,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
> >  		.r_resctrl = {
> >  			.rid			= RDT_RESOURCE_MBA,
> >  			.name			= "MB",
> > -			.cache_level		= 3,
> > +			.scope			= RESCTRL_L3_CACHE,
> >  			.domains		= domain_init(RDT_RESOURCE_MBA),
> >  			.parse_ctrlval		= parse_bw,
> >  			.format_str		= "%d=%*u",
> > @@ -105,7 +105,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
> >  		.r_resctrl = {
> >  			.rid			= RDT_RESOURCE_SMBA,
> >  			.name			= "SMBA",
> > -			.cache_level		= 3,
> > +			.scope			= RESCTRL_L3_CACHE,
> >  			.domains		= domain_init(RDT_RESOURCE_SMBA),
> >  			.parse_ctrlval		= parse_bw,
> >  			.format_str		= "%d=%*u",
> > @@ -487,6 +487,21 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
> >  	return 0;
> >  }
> >  
> > +static int get_domain_id_from_scope(int cpu, enum resctrl_scope scope)
> > +{
> > +	switch (scope) {
> > +	case RESCTRL_L3_CACHE:
> > +		return get_cpu_cacheinfo_id(cpu, 3);
> > +	case RESCTRL_L2_CACHE:
> > +		return get_cpu_cacheinfo_id(cpu, 2);
> > +	default:
> > +		WARN_ON_ONCE(1);
> > +		break;
> > +	}
> > +
> > +	return -1;
> > +}
> 
> Looking ahead at the next patch some members of rdt_resources_all[]
> are left with a default "0" initialization of mon_scope that is a
> valid scope of RESCTRL_L3_CACHE in this implementation that would
> not be caught with defensive code like above. For the above to catch
> a case like this I think that there should be some default
> initialization - but if you do move to something like you
> had in v3 then this may not be necessary. If the L2 scope is 2,
> L3 scope is 3, node scope is 4, then no initialization will be zero
> and the above default can more accurately catch failure cases.

See above (with a defensive enum constant that has the value 0).

> 
> > +
> >  /*
> >   * domain_add_cpu - Add a cpu to a resource's domain list.
> >   *
> > @@ -502,7 +517,7 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
> >   */
> >  static void domain_add_cpu(int cpu, struct rdt_resource *r)
> >  {
> > -	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
> > +	int id = get_domain_id_from_scope(cpu, r->scope);
> >  	struct list_head *add_pos = NULL;
> >  	struct rdt_hw_domain *hw_dom;
> >  	struct rdt_domain *d;
> > @@ -552,7 +567,7 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
> >  
> >  static void domain_remove_cpu(int cpu, struct rdt_resource *r)
> >  {
> > -	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
> > +	int id = get_domain_id_from_scope(cpu, r->scope);
> >  	struct rdt_hw_domain *hw_dom;
> >  	struct rdt_domain *d;
> >  
> > diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> > index 458cb7419502..e79324676f57 100644
> > --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> > +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> > @@ -279,6 +279,7 @@ static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
> >  static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
> >  {
> >  	struct cpu_cacheinfo *ci;
> > +	int cache_level;
> >  	int ret;
> >  	int i;
> >  
> > @@ -296,8 +297,20 @@ static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
> >  
> >  	plr->size = rdtgroup_cbm_to_size(plr->s->res, plr->d, plr->cbm);
> >  
> > +	switch (plr->s->res->scope) {
> > +	case RESCTRL_L3_CACHE:
> > +		cache_level = 3;
> > +		break;
> > +	case RESCTRL_L2_CACHE:
> > +		cache_level = 2;
> > +		break;
> > +	default:
> > +		WARN_ON_ONCE(1);
> > +		return -ENODEV;
> > +	}
> 
> I think this can be simplified without the indirection - a simplified
> WARN can just test for valid values of plr->s->res->scope directly
> (exit on failure) and then it can be used directly in the code below
> when the enum value corresponds to a cache level.

Is this what you want here?

	if (plr->s->res->scope != RESCTRL_L2_CACHE &&
	    plr->s->res->scope != RESCTRL_L3_CACHE) {
	    	WARN_ON_ONCE(1);
		return -ENODEV;
	}

> 
> > +
> >  	for (i = 0; i < ci->num_leaves; i++) {
> > -		if (ci->info_list[i].level == plr->s->res->cache_level) {
> > +		if (ci->info_list[i].level == cache_level) {

then drop this change to keep using plr->s->res->cache_level (and
delete the now unused local variable cache_level).

> >  			plr->line_size = ci->info_list[i].coherency_line_size;
> >  			return 0;
> >  		}
> > diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > index 725344048f85..f510414bf6ce 100644
> > --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > @@ -1343,12 +1343,25 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
> >  {
> >  	struct cpu_cacheinfo *ci;
> >  	unsigned int size = 0;
> > +	int cache_level;
> >  	int num_b, i;
> >  
> > +	switch (r->scope) {
> > +	case RESCTRL_L3_CACHE:
> > +		cache_level = 3;
> > +		break;
> > +	case RESCTRL_L2_CACHE:
> > +		cache_level = 2;
> > +		break;
> > +	default:
> > +		WARN_ON_ONCE(1);
> > +		return size;
> > +	}
> > +
> 
> Same here.

If above it what you want, will do it here too.

> 
> >  	num_b = bitmap_weight(&cbm, r->cache.cbm_len);
> >  	ci = get_cpu_cacheinfo(cpumask_any(&d->cpu_mask));
> >  	for (i = 0; i < ci->num_leaves; i++) {
> > -		if (ci->info_list[i].level == r->cache_level) {
> > +		if (ci->info_list[i].level == cache_level) {
> >  			size = ci->info_list[i].size / r->cache.cbm_len * num_b;
> >  			break;
> >  		}
> 
> 
> Reinette

-Tony
