Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6AB78B9D9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 23:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbjH1VAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 17:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbjH1U7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 16:59:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1C410A;
        Mon, 28 Aug 2023 13:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693256381; x=1724792381;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BCWbeC1KQ8EIRfaoVmncypyCdf+8LIKkFWOdZ26XBMA=;
  b=Ozsol8e2RGp/QE44kY5nq2riBkZLQjB4P5GjcDXGvIrGcrpgi7yB+Cnn
   e0rdiBOO1POtCP/Q5VoQ7seLfkoq+BWaFCICQU+8OeNgEfLqUEP8eIKXZ
   NWuDvidNYVtUgkcgb1fvQqwb3xOZGKEwOsojqUPtltXPfaQFC46KmeTIe
   nC21LxR3yutkDWmRBDtFXJeBXW39I9s9oBFso1ln1zg9QiTgWvPgNm9Ox
   7QIdFNxVOGZ3Z/UPKaj+sV+xdDjvmO5d+X6MVAWnm+qIn3OyAV20+H/z0
   0GRGsT++9EYD3JgNJIQBJ0JqcN3xXYFtIkkFjYpgiN01GZcBShroPufgT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="439154301"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="439154301"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 13:59:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="803845832"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="803845832"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 13:59:34 -0700
Date:   Mon, 28 Aug 2023 13:59:32 -0700
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
Message-ID: <ZO0KtAefCStikXEm@agluck-desk3>
References: <20230713163207.219710-1-tony.luck@intel.com>
 <20230722190740.326190-1-tony.luck@intel.com>
 <20230722190740.326190-2-tony.luck@intel.com>
 <cc1a144f-6667-18fb-7fe7-cd15ebfedd08@intel.com>
 <ZOjfPx8iwTULTqdg@agluck-desk3>
 <da2c0e45-56d0-e04d-774d-4292d156e1d0@intel.com>
 <ZOzroJqc22HFZOXq@agluck-desk3>
 <5b5962d3-6a7b-cc60-4221-8267bfbc3bfd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b5962d3-6a7b-cc60-4221-8267bfbc3bfd@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 12:56:27PM -0700, Reinette Chatre wrote:
> Hi Tony,
> 
> On 8/28/2023 11:46 AM, Tony Luck wrote:
> > On Mon, Aug 28, 2023 at 10:05:31AM -0700, Reinette Chatre wrote:
> >> Hi Tony,
> >>
> >> On 8/25/2023 10:05 AM, Tony Luck wrote:
> >>> On Fri, Aug 11, 2023 at 10:29:25AM -0700, Reinette Chatre wrote:
> >>>> On 7/22/2023 12:07 PM, Tony Luck wrote:
> >>
> >>>>> Change all places where monitoring functions walk the list of
> >>>>> domains to use the new "mondomains" list instead of the old
> >>>>> "domains" list.
> >>>>
> >>>> I would not refer to it as "the old domains list" as it creates
> >>>> impression that this is being replaced. The changelog makes
> >>>> no mention that domains list will remain and be dedicated to
> >>>> control domains. I think this is important to include in description
> >>>> of this change.
> >>>
> >>> I've rewritten the entire commit message incorporating your suggestions.
> >>> V6 will be posted soon (after I get some time on an SNC SPR to check
> >>> that it all works!)
> >>
> >> I seem to have missed v5.
> > 
> > I simply can't count. You are correct that next version to be posted
> > will be v5.
> > 
> >>>
> >>>>
> >>>>>
> >>>>> Signed-off-by: Tony Luck <tony.luck@intel.com>
> >>>>> ---
> >>>>>  include/linux/resctrl.h                   |  10 +-
> >>>>>  arch/x86/kernel/cpu/resctrl/internal.h    |   2 +-
> >>>>>  arch/x86/kernel/cpu/resctrl/core.c        | 195 +++++++++++++++-------
> >>>>>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |   2 +-
> >>>>>  arch/x86/kernel/cpu/resctrl/monitor.c     |   2 +-
> >>>>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  30 ++--
> >>>>>  6 files changed, 167 insertions(+), 74 deletions(-)
> >>>>>
> >>>>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> >>>>> index 8334eeacfec5..1267d56f9e76 100644
> >>>>> --- a/include/linux/resctrl.h
> >>>>> +++ b/include/linux/resctrl.h
> >>>>> @@ -151,9 +151,11 @@ struct resctrl_schema;
> >>>>>   * @mon_capable:	Is monitor feature available on this machine
> >>>>>   * @num_rmid:		Number of RMIDs available
> >>>>>   * @cache_level:	Which cache level defines scope of this resource
> >>>>> + * @mon_scope:		Scope of this resource if different from cache_level
> >>>>
> >>>> I think this addition should be deferred. As it is here it the "if different
> >>>> from cache_level" also creates many questions (when will it be different?
> >>>> how will it be determined that the scope is different in order to know that
> >>>> mon_scope should be used?)
> >>>
> >>> I've gone in a different direction. V6 renames "cache_level" to
> >>> "ctrl_scope". I think this makes intent clear from step #1.
> >>>
> >>
> >> This change is not clear to me. Previously you changed this name
> >> but kept using it in code specific to cache levels. It is not clear
> >> to me how this time's rename would be different.
> > 
> > The current "cache_level" field in the structure is describing
> > the scope of each instance using the cache level (2 or 3) as the
> > method to describe which CPUs are considered part of a group. Currently
> > the scope is the same for both control and monitor resources.
> 
> Right.
> 
> > 
> > Would you like to see patches in this progrssion:
> > 
> > 1) Rename "cache_level" to "scope". With commit comment that future
> > patches are going to base the scope on NUMA nodes in addtion to sharing
> > caches at particular levels, and will split into separate control and
> > monitor scope.
> > 
> > 2) Split the "scope" field from first patch into "ctrl_scope" and
> > "mon_scope" (also with the addition of the new list for the mon_scope).
> > 
> > 3) Add "node" as a new option for scope in addtion to L3 and L2 cache.
> > 
> 
> hmmm - my comment cannot be addressed through patch re-ordering.
> If I understand correctly you plan to change the name of "cache_level"
> to "ctrl_scope". My comment is that this obfuscates the code as long as
> you use this variable to compare against data that can only represent cache
> levels. This just repeats what I wrote in
> https://lore.kernel.org/lkml/09847c37-66d7-c286-a313-308eaa338c64@intel.com/

I'm proposing more than just re-ordering. The above sequence is a
couple of extra patches in the series.

Existing state of code:

	There is a single field named "cache_level" that describes how
	CPUs are assigned to domains based on their sharing of a cache
	at a particular level. Hard-coded values of "2" and "3" are used
	to describe the level. This is just a scope description of which
	CPUs are grouped together. But it is limited to just doing so
	based on which caches are shared by those CPUs.

Step 1:

	Change the name of the field s/cache_level/scope/. Provide an
	enum with values RESCTRL_L3_CACHE, RESCTRL_L2_CACHE aand use
	those througout code instead of 3, 2, and implictly passing
	the resctrl scope to functions like get_cpu_cacheinfo_id()

	Add get_domain_id_from_scope() function that takes the enum
	values for scope and converts to "3", "2" to pass to
	get_cpu_cacheinfo_id().

	No functional change. Just broadening the meaning of the field
	so that it can in future patches to describe scopes that
	aren't a function of sharing a cache of a particular level.

Step 2:

	Break the single list of domains into two separate lists. One
	for control domains, one for monitor domains. Change the name
	of the "scope" field to "ctrl"scope", add a new field
	"mon_scope".

Step 3:

	Add RESCTRL_NODE as a new option in the enum for how CPUs are
	grouped into domains.
> 
> 
> >> ...
> >>
> >>>>> @@ -502,61 +593,19 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
> >>>>>   */
> >>>>>  static void domain_add_cpu(int cpu, struct rdt_resource *r)
> >>>>>  {
> >>>>> -	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
> >>>>> -	struct list_head *add_pos = NULL;
> >>>>> -	struct rdt_hw_domain *hw_dom;
> >>>>> -	struct rdt_domain *d;
> >>>>> -	int err;
> >>>>> -
> >>>>> -	d = rdt_find_domain(r, id, &add_pos);
> >>>>> -	if (IS_ERR(d)) {
> >>>>> -		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
> >>>>> -		return;
> >>>>> -	}
> >>>>> -
> >>>>> -	if (d) {
> >>>>> -		cpumask_set_cpu(cpu, &d->cpu_mask);
> >>>>> -		if (r->cache.arch_has_per_cpu_cfg)
> >>>>> -			rdt_domain_reconfigure_cdp(r);
> >>>>> -		return;
> >>>>> -	}
> >>>>> -
> >>>>> -	hw_dom = kzalloc_node(sizeof(*hw_dom), GFP_KERNEL, cpu_to_node(cpu));
> >>>>> -	if (!hw_dom)
> >>>>> -		return;
> >>>>> -
> >>>>> -	d = &hw_dom->d_resctrl;
> >>>>> -	d->id = id;
> >>>>> -	cpumask_set_cpu(cpu, &d->cpu_mask);
> >>>>> -
> >>>>> -	rdt_domain_reconfigure_cdp(r);
> >>>>> -
> >>>>> -	if (r->alloc_capable && domain_setup_ctrlval(r, d)) {
> >>>>> -		domain_free(hw_dom);
> >>>>> -		return;
> >>>>> -	}
> >>>>> -
> >>>>> -	if (r->mon_capable && arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
> >>>>> -		domain_free(hw_dom);
> >>>>> -		return;
> >>>>> -	}
> >>>>> -
> >>>>> -	list_add_tail(&d->list, add_pos);
> >>>>> -
> >>>>> -	err = resctrl_online_domain(r, d);
> >>>>> -	if (err) {
> >>>>> -		list_del(&d->list);
> >>>>> -		domain_free(hw_dom);
> >>>>> -	}
> >>>>> +	if (r->alloc_capable)
> >>>>> +		domain_add_cpu_ctrl(cpu, r);
> >>>>> +	if (r->mon_capable)
> >>>>> +		domain_add_cpu_mon(cpu, r);
> >>>>>  }
> >>>>
> >>>> A resource could be both alloc and mon capable ... both
> >>>> domain_add_cpu_ctrl() and domain_add_cpu_mon() can fail.
> >>>> Should domain_add_cpu_mon() still be run for a CPU if
> >>>> domain_add_cpu_ctrl() failed? 
> >>>>
> >>>> Looking ahead the CPU should probably also not be added
> >>>> to the default groups mask if a failure occurred.
> >>>
> >>> Existing code doesn't do anything for the case where a CPU
> >>> can't be added to a domain (probably the only real error case
> >>> is failure to allocate memory for the domain structure).
> >>
> >> Is my statement about CPU being added to default group mask
> >> incorrect? Seems like a potential issue related to domain's
> >> CPU mask also.
> >>
> >> Please see my earlier question. Existing code does not proceed
> >> with monitor initialization if control initialization fails and
> >> undoes control initialization if monitor initialization fails. 
> > 
> > Existing code silently continues if a domain structure cannot
> > be allocated to add a CPU to a domain:
> > 
> > 503 static void domain_add_cpu(int cpu, struct rdt_resource *r)
> > 504 {
> > 505         int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
> > 506         struct list_head *add_pos = NULL;
> > 507         struct rdt_hw_domain *hw_dom;
> > 508         struct rdt_domain *d;
> > 509         int err;
> > 
> > ...
> > 
> > 523
> > 524         hw_dom = kzalloc_node(sizeof(*hw_dom), GFP_KERNEL, cpu_to_node(cpu));
> > 525         if (!hw_dom)
> > 526                 return;
> > 527
> > 
> 
> 
> Right ... and if it returns silently as above it runs:
> 
> static int resctrl_online_cpu(unsigned int cpu)
> {
> 
> 
> 	for_each_capable_rdt_resource(r)
> 		domain_add_cpu(cpu, r);
> 	>>>>> cpumask_set_cpu(cpu, &rdtgroup_default.cpu_mask); <<<<<<<<
> 
> }
> 
> Also, note within domain_add_cpu():
> 
> static void domain_add_cpu(int cpu, struct rdt_resource *r)
> {
> 
> 
> 	...
> 	if (r->alloc_capable && domain_setup_ctrlval(r, d)) {
> 		domain_free(hw_dom);
> 		return;
> 	}
> 
> 	if (r->mon_capable && arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
> 		domain_free(hw_dom);
> 		return;
> 	}
> 
> 	...
> }
> 
> The above is the other item that I've been trying to discuss
> with you. Note that existing resctrl will not initialize monitoring if
> control could not be initialized.
> Compare with this submission:
> 
> 	if (r->alloc_capable)
> 		domain_add_cpu_ctrl(cpu, r);
> 	if (r->mon_capable)
> 		domain_add_cpu_mon(cpu, r);
> 
> 
> 
> >>
> >>> May be something to tackle in a future series if anyone
> >>> thinks this is a serious problem and has suggestions on
> >>> what to do. It seems like a catastrophic problem to not
> >>> have some CPUs in some/all domains of some resources.
> >>> Maybe this should disable mounting resctrl filesystem
> >>> completely?
> >>
> >> It is not clear to me how this is catastrophic but I
> >> do not think resctrl should claim support for a resource
> >> on a CPU if it was not able to complete initialization
> > 
> > That's the status quo. See above code snippet.
> 
> Could you please elaborate what you mean with status quo?

Status quo. System may be booting and add a bunch of CPUs to the
first domain for a resource. When it finds a CPU from a different
domain it calls domain_add_cpu(), but for some reason the allocation
of a rdt_hw_domain fails here:

524         hw_dom = kzalloc_node(sizeof(*hw_dom), GFP_KERNEL, cpu_to_node(cpu));
525         if (!hw_dom)
526                 return;

domain_add_cpu() returns with no message to the console, no error code.
System boots, but this CPU is missing from the domain (likely the whole
domain is missing as the same allocation will most likely fail for the
remainder of the CPUs in this domain). Only indication to user is when
they read the schemata file and see something like this:

$ cat /sys/fs/resctrl/schemata
    MB:0= 100
    L3:0=7fff;1=7fff

(assuming that all domains were successfully allocated for L3, and the
failure described above happened on the allocation for the second domain
of the MB resource.)

-Tony
