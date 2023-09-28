Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4390D7B23B8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 19:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjI1RV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 13:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjI1RV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:21:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACEA19E;
        Thu, 28 Sep 2023 10:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695921713; x=1727457713;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tiJWSSw+ZoRVQ306E03/wwzW11SO7i0xyWFwnoHn3JM=;
  b=ZV9jh2jWL6Bk+OtaCcOu4G9b0N6JKMN9te5qOrwU5uXJeJVRB0YJX2HZ
   1h9c0SCenlD44vC3VK3A+5ud/TDXULmK6clhM5znM/nnDIIhziZFVTFkt
   bHm/zYXMn4d/Juy2caC/8kkRZ5W/OTVTsNKyU50ZbGUN8RxRXd6UZApm3
   BZbNsimHbFKIfPwCgcGIoGP0q1MUQ84/MhQLHUeOLctHlybiLbE1vMDD+
   xbUxEJQCc0361hgN+24IUMQT16ZJz65oKCGSBuvuXY3XIvJRMhVgPE6ee
   gHdm86YpL5/yE/N4a5uFHhajFaIh7UPPTIZ8eP9BTNseZZhOhSS7mwdgk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="384938209"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="384938209"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 10:21:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="743146986"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="743146986"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 10:21:52 -0700
Date:   Thu, 28 Sep 2023 10:21:50 -0700
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
Subject: Re: [PATCH v5 2/8] x86/resctrl: Prepare for different scope for
 control/monitor operations
Message-ID: <ZRW2Lu6RxRPY/Yad@agluck-desk3>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-3-tony.luck@intel.com>
 <34671424-8dc5-3937-3779-8a8e52f47904@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34671424-8dc5-3937-3779-8a8e52f47904@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 04:24:10PM -0700, Reinette Chatre wrote:
> Hi Tony,
> 
> On 8/29/2023 4:44 PM, Tony Luck wrote:
> > Existing resctrl assumes that control and monitor operations on a
> 
> Please remove "Existing", it can just be "resctrl assumes ..."

Will do.

> 
> > resource are performed at the same scope.
> > 
> > Prepare for systems that use different scope (specifically L3 scope
> > for cache control and NODE scope for cache occupancy and memory
> > bandwidth monitoring).
> > 
> > Create separate domain lists for control and monitor operations.
> > 
> > No important functional change. But note that errors during
> > initialization of either control or monitor functions on a domain would
> > previously result in that domain being excluded from both control and
> > monitor operations. Now the domains are allocated independently it is
> > no longer required to disable both control and monitor operations if
> > either fail.
> > 
> > Signed-off-by: Tony Luck <tony.luck@intel.com>
> > ---
> >  include/linux/resctrl.h                   |  16 +-
> >  arch/x86/kernel/cpu/resctrl/internal.h    |   6 +-
> >  arch/x86/kernel/cpu/resctrl/core.c        | 227 +++++++++++++++-------
> >  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |   2 +-
> >  arch/x86/kernel/cpu/resctrl/monitor.c     |   2 +-
> >  arch/x86/kernel/cpu/resctrl/pseudo_lock.c |   2 +-
> >  arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  32 +--
> >  7 files changed, 199 insertions(+), 88 deletions(-)
> > 
> > diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> > index 2db1244ae642..33856943a787 100644
> > --- a/include/linux/resctrl.h
> > +++ b/include/linux/resctrl.h
> > @@ -155,10 +155,12 @@ enum resctrl_scope {
> >   * @alloc_capable:	Is allocation available on this machine
> >   * @mon_capable:	Is monitor feature available on this machine
> >   * @num_rmid:		Number of RMIDs available
> > - * @scope:		Scope of this resource
> > + * @ctrl_scope:		Scope of this resource for control functions
> > + * @mon_scope:		Scope of this resource for monitor functions
> >   * @cache:		Cache allocation related data
> >   * @membw:		If the component has bandwidth controls, their properties.
> > - * @domains:		All domains for this resource
> > + * @domains:		Control domains for this resource
> > + * @mon_domains:	Monitor domains for this resource
> >   * @name:		Name to use in "schemata" file.
> >   * @data_width:		Character width of data when displaying
> >   * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
> > @@ -173,10 +175,12 @@ struct rdt_resource {
> >  	bool			alloc_capable;
> >  	bool			mon_capable;
> >  	int			num_rmid;
> > -	enum resctrl_scope	scope;
> > +	enum resctrl_scope	ctrl_scope;
> > +	enum resctrl_scope	mon_scope;
> >  	struct resctrl_cache	cache;
> >  	struct resctrl_membw	membw;
> >  	struct list_head	domains;
> > +	struct list_head	mondomains;
> 
> kerneldoc is "mon_domains" while member is "mondomains".
> I do think to be consistent with other members that "mon_domains"
> would be appropriate. I also think it will be very helpful it
> domains is renamed to "ctrl_domains" to more accurately match
> "ctrl_scope" and what it represents.

Next version will use "mon_domains" (and "mon_" in all the associated
functions and macros). I'm also changing to "ctrl_" as suggested.

> >  	char			*name;
> >  	int			data_width;
> >  	u32			default_ctrl;
> > @@ -222,8 +226,10 @@ int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
> >  
> >  u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
> >  			    u32 closid, enum resctrl_conf_type type);
> > -int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d);
> > -void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
> > +int resctrl_online_ctrl_domain(struct rdt_resource *r, struct rdt_domain *d);
> > +int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_domain *d);
> > +void resctrl_offline_ctrl_domain(struct rdt_resource *r, struct rdt_domain *d);
> > +void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_domain *d);
> >  
> >  /**
> >   * resctrl_arch_rmid_read() - Read the eventid counter corresponding to rmid
> > diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> > index 85ceaf9a31ac..31a5fc3b717f 100644
> > --- a/arch/x86/kernel/cpu/resctrl/internal.h
> > +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> > @@ -511,8 +511,10 @@ void rdtgroup_kn_unlock(struct kernfs_node *kn);
> >  int rdtgroup_kn_mode_restrict(struct rdtgroup *r, const char *name);
> >  int rdtgroup_kn_mode_restore(struct rdtgroup *r, const char *name,
> >  			     umode_t mask);
> > -struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
> > -				   struct list_head **pos);
> > +struct rdt_domain *rdt_find_ctrldomain(struct list_head *h, int id,
> > +				       struct list_head **pos);
> > +struct rdt_domain *rdt_find_mondomain(struct list_head *h, int id,
> > +				      struct list_head **pos);
> 
> This is not what I expected after our previous discussion. It
> should not be necessary for caller to be aware of the different
> lists. It looks to me like the original parameters of (struct rdt_resource *r,
> int id, struct list_head **pos) can be maintained.

Discussed in other e-mail. There is now a "struct rdt_domain_hdr"
embedded in the control and monitor versions of the domain structure.
rdt_find_domain() operates on that, and callers user container_of() to
get to the enclosing structure.

> 
> >  ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
> >  				char *buf, size_t nbytes, loff_t off);
> >  int rdtgroup_schemata_show(struct kernfs_open_file *of,
> > diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> > index 0d3bae523ecb..97f6f9715fdb 100644
> > --- a/arch/x86/kernel/cpu/resctrl/core.c
> > +++ b/arch/x86/kernel/cpu/resctrl/core.c
> > @@ -57,7 +57,7 @@ static void
> >  mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m,
> >  	      struct rdt_resource *r);
> >  
> > -#define domain_init(id) LIST_HEAD_INIT(rdt_resources_all[id].r_resctrl.domains)
> > +#define domain_init(id, field) LIST_HEAD_INIT(rdt_resources_all[id].r_resctrl.field)
> >  
> 
> It may make the code easier to read if this is split into
> a "mon_domain_init()" and "ctrl_domain_init()"

Done

> 
> >  struct rdt_hw_resource rdt_resources_all[] = {
> >  	[RDT_RESOURCE_L3] =
> > @@ -65,8 +65,10 @@ struct rdt_hw_resource rdt_resources_all[] = {
> >  		.r_resctrl = {
> >  			.rid			= RDT_RESOURCE_L3,
> >  			.name			= "L3",
> > -			.scope			= RESCTRL_L3_CACHE,
> > -			.domains		= domain_init(RDT_RESOURCE_L3),
> > +			.ctrl_scope		= RESCTRL_L3_CACHE,
> > +			.mon_scope		= RESCTRL_L3_CACHE,
> > +			.domains		= domain_init(RDT_RESOURCE_L3, domains),
> > +			.mondomains		= domain_init(RDT_RESOURCE_L3, mondomains),
> >  			.parse_ctrlval		= parse_cbm,
> >  			.format_str		= "%d=%0*x",
> >  			.fflags			= RFTYPE_RES_CACHE,
> > @@ -79,8 +81,8 @@ struct rdt_hw_resource rdt_resources_all[] = {
> >  		.r_resctrl = {
> >  			.rid			= RDT_RESOURCE_L2,
> >  			.name			= "L2",
> > -			.scope			= RESCTRL_L2_CACHE,
> > -			.domains		= domain_init(RDT_RESOURCE_L2),
> > +			.ctrl_scope		= RESCTRL_L2_CACHE,
> > +			.domains		= domain_init(RDT_RESOURCE_L2, domains),
> >  			.parse_ctrlval		= parse_cbm,
> >  			.format_str		= "%d=%0*x",
> >  			.fflags			= RFTYPE_RES_CACHE,
> > @@ -93,8 +95,8 @@ struct rdt_hw_resource rdt_resources_all[] = {
> >  		.r_resctrl = {
> >  			.rid			= RDT_RESOURCE_MBA,
> >  			.name			= "MB",
> > -			.scope			= RESCTRL_L3_CACHE,
> > -			.domains		= domain_init(RDT_RESOURCE_MBA),
> > +			.ctrl_scope		= RESCTRL_L3_CACHE,
> > +			.domains		= domain_init(RDT_RESOURCE_MBA, domains),
> >  			.parse_ctrlval		= parse_bw,
> >  			.format_str		= "%d=%*u",
> >  			.fflags			= RFTYPE_RES_MB,
> > @@ -105,8 +107,8 @@ struct rdt_hw_resource rdt_resources_all[] = {
> >  		.r_resctrl = {
> >  			.rid			= RDT_RESOURCE_SMBA,
> >  			.name			= "SMBA",
> > -			.scope			= RESCTRL_L3_CACHE,
> > -			.domains		= domain_init(RDT_RESOURCE_SMBA),
> > +			.ctrl_scope		= RESCTRL_L3_CACHE,
> > +			.domains		= domain_init(RDT_RESOURCE_SMBA, domains),
> >  			.parse_ctrlval		= parse_bw,
> >  			.format_str		= "%d=%*u",
> >  			.fflags			= RFTYPE_RES_MB,
> > @@ -384,15 +386,16 @@ void rdt_ctrl_update(void *arg)
> >  }
> >  
> >  /*
> > - * rdt_find_domain - Find a domain in a resource that matches input resource id
> > + * __rdt_find_domain - Find a domain in either the list of control or
> > + * monitor domains that matches input resource id
> >   *
> >   * Search resource r's domain list to find the resource id. If the resource
> >   * id is found in a domain, return the domain. Otherwise, if requested by
> >   * caller, return the first domain whose id is bigger than the input id.
> >   * The domain list is sorted by id in ascending order.
> >   */
> > -struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
> > -				   struct list_head **pos)
> > +static void *__rdt_find_domain(struct list_head *h, int id,
> > +			       struct list_head **pos)
> >  {
> >  	struct rdt_domain *d;
> >  	struct list_head *l;
> > @@ -400,7 +403,7 @@ struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
> >  	if (id < 0)
> >  		return ERR_PTR(-ENODEV);
> >  
> > -	list_for_each(l, &r->domains) {
> > +	list_for_each(l, h) {
> >  		d = list_entry(l, struct rdt_domain, list);
> >  		/* When id is found, return its domain. */
> >  		if (id == d->id)
> > @@ -416,6 +419,18 @@ struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
> >  	return NULL;
> >  }
> >  
> > +struct rdt_domain *rdt_find_ctrldomain(struct list_head *h, int id,
> > +				       struct list_head **pos)
> > +{
> > +	return __rdt_find_domain(h, id, pos);
> > +}
> > +
> > +struct rdt_domain *rdt_find_mondomain(struct list_head *h, int id,
> > +				      struct list_head **pos)
> > +{
> > +	return __rdt_find_domain(h, id, pos);
> > +}
> > +
> >  static void setup_default_ctrlval(struct rdt_resource *r, u32 *dc)
> >  {
> >  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
> > @@ -431,10 +446,15 @@ static void setup_default_ctrlval(struct rdt_resource *r, u32 *dc)
> >  }
> >  
> >  static void domain_free(struct rdt_hw_domain *hw_dom)
> > +{
> > +	kfree(hw_dom->ctrl_val);
> > +	kfree(hw_dom);
> > +}
> > +
> > +static void mondomain_free(struct rdt_hw_domain *hw_dom)
> >  {
> >  	kfree(hw_dom->arch_mbm_total);
> >  	kfree(hw_dom->arch_mbm_local);
> > -	kfree(hw_dom->ctrl_val);
> >  	kfree(hw_dom);
> >  }
> >  
> > @@ -502,6 +522,93 @@ static int get_domain_id_from_scope(int cpu, enum resctrl_scope scope)
> >  	return -1;
> >  }
> >  
> > +static void domain_add_cpu_ctrl(int cpu, struct rdt_resource *r)
> > +{
> > +	int id = get_domain_id_from_scope(cpu, r->ctrl_scope);
> > +	struct list_head *add_pos = NULL;
> > +	struct rdt_hw_domain *hw_dom;
> > +	struct rdt_domain *d;
> > +	int err;
> > +
> > +	d = rdt_find_ctrldomain(&r->domains, id, &add_pos);
> > +	if (IS_ERR(d)) {
> > +		pr_warn("Couldn't find scope id=%d for CPU %d\n", id, cpu);
> 
> I am not sure here ... this generates identical error messages
> for control and monitor domain. How will the user know what failed?
> Also, how does printing id help? If I understand correctly it can
> only be -1 when the above prints.

Improved error messages in next version. Separate ones for failure in
get_domain_id_from_scope() and rdt_find_domain(). Each have "control"
or "monitor" in the message to help the user pinpoint exactly what
went wrong.

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
> > +	int id = get_domain_id_from_scope(cpu, r->mon_scope);
> > +	struct rdt_hw_domain *hw_mondom;
> > +	struct list_head *add_pos = NULL;
> 
> Please maintain reverse fir ordering. Please check all code.

I believe I got them all (for functions that are touched by this
series - there are a handful of places in resctrl code that don't
have reverse fir ordering - I didn't touch those).

> > +	struct rdt_domain *d;
> > +	int err;
> > +
> > +	d = rdt_find_mondomain(&r->mondomains, id, &add_pos);
> > +	if (IS_ERR(d)) {
> > +		pr_warn("Couldn't find scope id=%d for CPU %d\n", id, cpu);
> > +		return;
> > +	}
> > +
> > +	if (d) {
> > +		cpumask_set_cpu(cpu, &d->cpu_mask);
> > +
> 
> This is an unnecessary empty line that distracts from how the rest
> of the function looks.

Deleted it.

> 
> > +		return;
> > +	}
> > +
> > +	hw_mondom = kzalloc_node(sizeof(*hw_mondom), GFP_KERNEL, cpu_to_node(cpu));
> > +	if (!hw_mondom)
> > +		return;
> > +
> > +	d = &hw_mondom->d_resctrl;
> > +	d->id = id;
> > +	cpumask_set_cpu(cpu, &d->cpu_mask);
> > +
> > +	if (arch_domain_mbm_alloc(r->num_rmid, hw_mondom)) {
> > +		mondomain_free(hw_mondom);
> > +		return;
> > +	}
> > +
> > +	list_add_tail(&d->list, add_pos);
> > +
> > +	err = resctrl_online_mon_domain(r, d);
> > +	if (err) {
> > +		list_del(&d->list);
> > +		mondomain_free(hw_mondom);
> > +	}
> > +}
> > +
> >  /*
> >   * domain_add_cpu - Add a cpu to a resource's domain list.
> >   *
> 
> Note that this leaves the comments about list management here while all
> the list management code is moved away.

Moved the comment in front of rdt_find_domain() which does most of the
work. Small edit in the comment to say that callers do the rest.

> 
> > @@ -517,70 +624,28 @@ static int get_domain_id_from_scope(int cpu, enum resctrl_scope scope)
> >   */
> >  static void domain_add_cpu(int cpu, struct rdt_resource *r)
> >  {
> > -	int id = get_domain_id_from_scope(cpu, r->scope);
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
> >  
> > -static void domain_remove_cpu(int cpu, struct rdt_resource *r)
> > +static void domain_remove_cpu_ctrl(int cpu, struct rdt_resource *r)
> >  {
> > -	int id = get_domain_id_from_scope(cpu, r->scope);
> > +	int id = get_domain_id_from_scope(cpu, r->ctrl_scope);
> >  	struct rdt_hw_domain *hw_dom;
> >  	struct rdt_domain *d;
> >  
> > -	d = rdt_find_domain(r, id, NULL);
> > +	d = rdt_find_ctrldomain(&r->domains, id, NULL);
> >  	if (IS_ERR_OR_NULL(d)) {
> > -		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
> > +		pr_warn("Couldn't find scope id=%d for CPU %d\n", id, cpu);
> >  		return;
> >  	}
> >  	hw_dom = resctrl_to_arch_dom(d);
> >  
> >  	cpumask_clear_cpu(cpu, &d->cpu_mask);
> >  	if (cpumask_empty(&d->cpu_mask)) {
> > -		resctrl_offline_domain(r, d);
> > +		resctrl_offline_ctrl_domain(r, d);
> >  		list_del(&d->list);
> >  
> >  		/*
> > @@ -593,6 +658,30 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
> >  
> >  		return;
> >  	}
> > +}
> > +
> > +static void domain_remove_cpu_mon(int cpu, struct rdt_resource *r)
> > +{
> > +	int id = get_domain_id_from_scope(cpu, r->mon_scope);
> > +	struct rdt_hw_domain *hw_mondom;
> > +	struct rdt_domain *d;
> > +
> > +	d = rdt_find_mondomain(&r->mondomains, id, NULL);
> > +	if (IS_ERR_OR_NULL(d)) {
> > +		pr_warn("Couldn't find scope id=%d for CPU %d\n", id, cpu);
> > +		return;
> > +	}
> > +	hw_mondom = resctrl_to_arch_dom(d);
> > +
> > +	cpumask_clear_cpu(cpu, &d->cpu_mask);
> > +	if (cpumask_empty(&d->cpu_mask)) {
> > +		resctrl_offline_mon_domain(r, d);
> > +		list_del(&d->list);
> > +
> 
> This is an awkward empty line.

Deleted it.

> 
> > +		mondomain_free(hw_mondom);
> > +
> > +		return;
> > +	}
> >  
> >  	if (r == &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl) {
> >  		if (is_mbm_enabled() && cpu == d->mbm_work_cpu) {
> 
> ...
> 
> Reinette
