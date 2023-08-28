Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26BA78BADA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 00:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjH1WNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 18:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjH1WMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 18:12:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380E710A;
        Mon, 28 Aug 2023 15:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693260766; x=1724796766;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=smeLDazdJuViWAyyGs8jg0kCUa6XTlyoNMxBpVcpTW0=;
  b=nr2f7m4pAZvFCKSMSyN7W8in/WJ7SnnbVZaHmRH1O3aLYodDgBN5zm+4
   Ly/PEQieLrKnvDr/88wqcslR+jiWLJcLKCcUFux5mTL+161pnYZQm76/i
   Pa+yfOIbs/hR0dceQIBXrZpBbPkW8cwh3zAfz/1EUA3H8X8+TLz9BqnaD
   FAnvgXtteCrNlOOlV5VZj04VUTFktk8UGj0J+bxpxDI1hW3ouxOx+s+4L
   5ajUIHq5XRxCKPA+sks4PPbRRrodZHIgt8TLnFJGeR4EibCxCZKsMeOCw
   XvK+Z5oeV0ehILkVH8rSp3KqoP5x+mfCrPlYSxzCzIK8m03YIgkVEGcJ1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="374108595"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="374108595"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 15:12:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="912171798"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="912171798"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 15:12:44 -0700
Date:   Mon, 28 Aug 2023 15:12:42 -0700
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
Message-ID: <ZO0b2j5lOpxPu3iw@agluck-desk3>
References: <20230713163207.219710-1-tony.luck@intel.com>
 <20230722190740.326190-1-tony.luck@intel.com>
 <20230722190740.326190-2-tony.luck@intel.com>
 <cc1a144f-6667-18fb-7fe7-cd15ebfedd08@intel.com>
 <ZOjfPx8iwTULTqdg@agluck-desk3>
 <da2c0e45-56d0-e04d-774d-4292d156e1d0@intel.com>
 <ZOzroJqc22HFZOXq@agluck-desk3>
 <5b5962d3-6a7b-cc60-4221-8267bfbc3bfd@intel.com>
 <ZO0KtAefCStikXEm@agluck-desk3>
 <e3cbefc5-e686-5561-a71e-06417ab51d07@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3cbefc5-e686-5561-a71e-06417ab51d07@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 02:20:04PM -0700, Reinette Chatre wrote:
> 
> 
> On 8/28/2023 1:59 PM, Tony Luck wrote:
> > On Mon, Aug 28, 2023 at 12:56:27PM -0700, Reinette Chatre wrote:
> >> Hi Tony,
> >>
> >> On 8/28/2023 11:46 AM, Tony Luck wrote:
> >>> On Mon, Aug 28, 2023 at 10:05:31AM -0700, Reinette Chatre wrote:
> >>>> Hi Tony,
> >>>>
> >>>> On 8/25/2023 10:05 AM, Tony Luck wrote:
> >>>>> On Fri, Aug 11, 2023 at 10:29:25AM -0700, Reinette Chatre wrote:
> >>>>>> On 7/22/2023 12:07 PM, Tony Luck wrote:
> >>>>
> >>>>>>> Change all places where monitoring functions walk the list of
> >>>>>>> domains to use the new "mondomains" list instead of the old
> >>>>>>> "domains" list.
> >>>>>>
> >>>>>> I would not refer to it as "the old domains list" as it creates
> >>>>>> impression that this is being replaced. The changelog makes
> >>>>>> no mention that domains list will remain and be dedicated to
> >>>>>> control domains. I think this is important to include in description
> >>>>>> of this change.
> >>>>>
> >>>>> I've rewritten the entire commit message incorporating your suggestions.
> >>>>> V6 will be posted soon (after I get some time on an SNC SPR to check
> >>>>> that it all works!)
> >>>>
> >>>> I seem to have missed v5.
> >>>
> >>> I simply can't count. You are correct that next version to be posted
> >>> will be v5.
> >>>
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>> Signed-off-by: Tony Luck <tony.luck@intel.com>
> >>>>>>> ---
> >>>>>>>  include/linux/resctrl.h                   |  10 +-
> >>>>>>>  arch/x86/kernel/cpu/resctrl/internal.h    |   2 +-
> >>>>>>>  arch/x86/kernel/cpu/resctrl/core.c        | 195 +++++++++++++++-------
> >>>>>>>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |   2 +-
> >>>>>>>  arch/x86/kernel/cpu/resctrl/monitor.c     |   2 +-
> >>>>>>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  30 ++--
> >>>>>>>  6 files changed, 167 insertions(+), 74 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> >>>>>>> index 8334eeacfec5..1267d56f9e76 100644
> >>>>>>> --- a/include/linux/resctrl.h
> >>>>>>> +++ b/include/linux/resctrl.h
> >>>>>>> @@ -151,9 +151,11 @@ struct resctrl_schema;
> >>>>>>>   * @mon_capable:	Is monitor feature available on this machine
> >>>>>>>   * @num_rmid:		Number of RMIDs available
> >>>>>>>   * @cache_level:	Which cache level defines scope of this resource
> >>>>>>> + * @mon_scope:		Scope of this resource if different from cache_level
> >>>>>>
> >>>>>> I think this addition should be deferred. As it is here it the "if different
> >>>>>> from cache_level" also creates many questions (when will it be different?
> >>>>>> how will it be determined that the scope is different in order to know that
> >>>>>> mon_scope should be used?)
> >>>>>
> >>>>> I've gone in a different direction. V6 renames "cache_level" to
> >>>>> "ctrl_scope". I think this makes intent clear from step #1.
> >>>>>
> >>>>
> >>>> This change is not clear to me. Previously you changed this name
> >>>> but kept using it in code specific to cache levels. It is not clear
> >>>> to me how this time's rename would be different.
> >>>
> >>> The current "cache_level" field in the structure is describing
> >>> the scope of each instance using the cache level (2 or 3) as the
> >>> method to describe which CPUs are considered part of a group. Currently
> >>> the scope is the same for both control and monitor resources.
> >>
> >> Right.
> >>
> >>>
> >>> Would you like to see patches in this progrssion:
> >>>
> >>> 1) Rename "cache_level" to "scope". With commit comment that future
> >>> patches are going to base the scope on NUMA nodes in addtion to sharing
> >>> caches at particular levels, and will split into separate control and
> >>> monitor scope.
> >>>
> >>> 2) Split the "scope" field from first patch into "ctrl_scope" and
> >>> "mon_scope" (also with the addition of the new list for the mon_scope).
> >>>
> >>> 3) Add "node" as a new option for scope in addtion to L3 and L2 cache.
> >>>
> >>
> >> hmmm - my comment cannot be addressed through patch re-ordering.
> >> If I understand correctly you plan to change the name of "cache_level"
> >> to "ctrl_scope". My comment is that this obfuscates the code as long as
> >> you use this variable to compare against data that can only represent cache
> >> levels. This just repeats what I wrote in
> >> https://lore.kernel.org/lkml/09847c37-66d7-c286-a313-308eaa338c64@intel.com/
> > 
> > I'm proposing more than just re-ordering. The above sequence is a
> > couple of extra patches in the series.
> > 
> > Existing state of code:
> > 
> > 	There is a single field named "cache_level" that describes how
> > 	CPUs are assigned to domains based on their sharing of a cache
> > 	at a particular level. Hard-coded values of "2" and "3" are used
> > 	to describe the level. This is just a scope description of which
> > 	CPUs are grouped together. But it is limited to just doing so
> > 	based on which caches are shared by those CPUs.
> > 
> > Step 1:
> > 
> > 	Change the name of the field s/cache_level/scope/. Provide an
> > 	enum with values RESCTRL_L3_CACHE, RESCTRL_L2_CACHE aand use
> > 	those througout code instead of 3, 2, and implictly passing
> > 	the resctrl scope to functions like get_cpu_cacheinfo_id()
> > 
> > 	Add get_domain_id_from_scope() function that takes the enum
> > 	values for scope and converts to "3", "2" to pass to
> > 	get_cpu_cacheinfo_id().
> > 
> > 	No functional change. Just broadening the meaning of the field
> > 	so that it can in future patches to describe scopes that
> > 	aren't a function of sharing a cache of a particular level.
> 
> Right. So if I understand you are planning the same change as you did
> in V3, like below, and my original comment still stands.
> 
>  @@ -1348,7 +1348,7 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
>   	num_b = bitmap_weight(&cbm, r->cache.cbm_len);
>   	ci = get_cpu_cacheinfo(cpumask_any(&d->cpu_mask));
>   	for (i = 0; i < ci->num_leaves; i++) {
>  -		if (ci->info_list[i].level == r->cache_level) {
>  +		if (ci->info_list[i].level == r->scope) {
>   			size = ci->info_list[i].size / r->cache.cbm_len * num_b;
>   			break;

No. I heard your complaint about mixing "scope" and "cache_level".
Latest version of that code looks like this:

1341 unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
1342                                   struct rdt_domain *d, unsigned long cbm)
1343 {
1344         struct cpu_cacheinfo *ci;
1345         unsigned int size = 0;
1346         int cache_level;
1347         int num_b, i;
1348
1349         switch (r->ctrl_scope) {
1350         case RESCTRL_L3_CACHE:
1351                 cache_level = 3;
1352                 break;
1353         case RESCTRL_L2_CACHE:
1354                 cache_level = 2;
1355                 break;
1356         default:
1357                 WARN_ON_ONCE(1);
1358                 return size;
1359         }
1360
1361         num_b = bitmap_weight(&cbm, r->cache.cbm_len);
1362         ci = get_cpu_cacheinfo(cpumask_any(&d->cpu_mask));
1363         for (i = 0; i < ci->num_leaves; i++) {
1364                 if (ci->info_list[i].level == cache_level) {
1365                         size = ci->info_list[i].size / r->cache.cbm_len * num_b;
1366                         break;
1367                 }
1368         }
1369
1370         return size / snc_nodes_per_l3_cache;
1371 }

>   		}
> 
> 
> >>>>>>> @@ -502,61 +593,19 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
> >>>>>>>   */
> >>>>>>>  static void domain_add_cpu(int cpu, struct rdt_resource *r)
> >>>>>>>  {
> >>>>>>> -	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
> >>>>>>> -	struct list_head *add_pos = NULL;
> >>>>>>> -	struct rdt_hw_domain *hw_dom;
> >>>>>>> -	struct rdt_domain *d;
> >>>>>>> -	int err;
> >>>>>>> -
> >>>>>>> -	d = rdt_find_domain(r, id, &add_pos);
> >>>>>>> -	if (IS_ERR(d)) {
> >>>>>>> -		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
> >>>>>>> -		return;
> >>>>>>> -	}
> >>>>>>> -
> >>>>>>> -	if (d) {
> >>>>>>> -		cpumask_set_cpu(cpu, &d->cpu_mask);
> >>>>>>> -		if (r->cache.arch_has_per_cpu_cfg)
> >>>>>>> -			rdt_domain_reconfigure_cdp(r);
> >>>>>>> -		return;
> >>>>>>> -	}
> >>>>>>> -
> >>>>>>> -	hw_dom = kzalloc_node(sizeof(*hw_dom), GFP_KERNEL, cpu_to_node(cpu));
> >>>>>>> -	if (!hw_dom)
> >>>>>>> -		return;
> >>>>>>> -
> >>>>>>> -	d = &hw_dom->d_resctrl;
> >>>>>>> -	d->id = id;
> >>>>>>> -	cpumask_set_cpu(cpu, &d->cpu_mask);
> >>>>>>> -
> >>>>>>> -	rdt_domain_reconfigure_cdp(r);
> >>>>>>> -
> >>>>>>> -	if (r->alloc_capable && domain_setup_ctrlval(r, d)) {
> >>>>>>> -		domain_free(hw_dom);
> >>>>>>> -		return;
> >>>>>>> -	}
> >>>>>>> -
> >>>>>>> -	if (r->mon_capable && arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
> >>>>>>> -		domain_free(hw_dom);
> >>>>>>> -		return;
> >>>>>>> -	}
> >>>>>>> -
> >>>>>>> -	list_add_tail(&d->list, add_pos);
> >>>>>>> -
> >>>>>>> -	err = resctrl_online_domain(r, d);
> >>>>>>> -	if (err) {
> >>>>>>> -		list_del(&d->list);
> >>>>>>> -		domain_free(hw_dom);
> >>>>>>> -	}
> >>>>>>> +	if (r->alloc_capable)
> >>>>>>> +		domain_add_cpu_ctrl(cpu, r);
> >>>>>>> +	if (r->mon_capable)
> >>>>>>> +		domain_add_cpu_mon(cpu, r);
> >>>>>>>  }
> >>>>>>
> >>>>>> A resource could be both alloc and mon capable ... both
> >>>>>> domain_add_cpu_ctrl() and domain_add_cpu_mon() can fail.
> >>>>>> Should domain_add_cpu_mon() still be run for a CPU if
> >>>>>> domain_add_cpu_ctrl() failed? 
> >>>>>>
> >>>>>> Looking ahead the CPU should probably also not be added
> >>>>>> to the default groups mask if a failure occurred.
> >>>>>
> >>>>> Existing code doesn't do anything for the case where a CPU
> >>>>> can't be added to a domain (probably the only real error case
> >>>>> is failure to allocate memory for the domain structure).
> >>>>
> >>>> Is my statement about CPU being added to default group mask
> >>>> incorrect? Seems like a potential issue related to domain's
> >>>> CPU mask also.
> >>>>
> >>>> Please see my earlier question. Existing code does not proceed
> >>>> with monitor initialization if control initialization fails and
> >>>> undoes control initialization if monitor initialization fails. 
> >>>
> >>> Existing code silently continues if a domain structure cannot
> >>> be allocated to add a CPU to a domain:
> >>>
> >>> 503 static void domain_add_cpu(int cpu, struct rdt_resource *r)
> >>> 504 {
> >>> 505         int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
> >>> 506         struct list_head *add_pos = NULL;
> >>> 507         struct rdt_hw_domain *hw_dom;
> >>> 508         struct rdt_domain *d;
> >>> 509         int err;
> >>>
> >>> ...
> >>>
> >>> 523
> >>> 524         hw_dom = kzalloc_node(sizeof(*hw_dom), GFP_KERNEL, cpu_to_node(cpu));
> >>> 525         if (!hw_dom)
> >>> 526                 return;
> >>> 527
> >>>
> >>
> >>
> >> Right ... and if it returns silently as above it runs:
> >>
> >> static int resctrl_online_cpu(unsigned int cpu)
> >> {
> >>
> >>
> >> 	for_each_capable_rdt_resource(r)
> >> 		domain_add_cpu(cpu, r);
> >> 	>>>>> cpumask_set_cpu(cpu, &rdtgroup_default.cpu_mask); <<<<<<<<
> >>
> >> }
> >>
> >> Also, note within domain_add_cpu():
> >>
> >> static void domain_add_cpu(int cpu, struct rdt_resource *r)
> >> {
> >>
> >>
> >> 	...
> >> 	if (r->alloc_capable && domain_setup_ctrlval(r, d)) {
> >> 		domain_free(hw_dom);
> >> 		return;
> >> 	}
> >>
> >> 	if (r->mon_capable && arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
> >> 		domain_free(hw_dom);
> >> 		return;
> >> 	}
> >>
> >> 	...
> >> }
> >>
> >> The above is the other item that I've been trying to discuss
> >> with you. Note that existing resctrl will not initialize monitoring if
> >> control could not be initialized.
> >> Compare with this submission:
> >>
> >> 	if (r->alloc_capable)
> >> 		domain_add_cpu_ctrl(cpu, r);
> >> 	if (r->mon_capable)
> >> 		domain_add_cpu_mon(cpu, r);
> >>
> >>
> 
> I'll stop trying

I'll see what I can do to improve the error handling.

-Tony
