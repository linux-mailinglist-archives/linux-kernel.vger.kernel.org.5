Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060A17B23F6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 19:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjI1RdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 13:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI1RdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:33:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8264C0;
        Thu, 28 Sep 2023 10:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695922384; x=1727458384;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UaI3IOgeRip6nCnklnCu8RvKQJKGDrgrxvS7T1G+758=;
  b=hR7fBSnxKpnLIOj8pyD8MT+b27slYIgZYQi6HEG6g+z0YDEuuei2X2RM
   6b16Atxd0iLNxSSjTq7MflIG2R7lLQj7gemK4ONoEnIGUdCq07mpdv2EJ
   Rk1uPkmpIoDshofbe7TXhaZmVutfR8hWYiNtAqX3GzwsT2BZGYkS7AVd1
   4+T/u+Xu58arJFzvNfULQgeSFF6XzGpb7A7wOBpAkSga0Y25m8OY5CFfB
   HJd0j+2OhIUSLpkMHGbwE2uAlp4Sv9JH3mLNnnh6EOyCgJTkEvjV5H6T9
   txLKY9kbsilryfuHrwLfesJ9OxcZSF7CdNmkzX7EYh42KuFGX833zZzCg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="384940752"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="384940752"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 10:33:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="839975576"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="839975576"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 10:33:02 -0700
Date:   Thu, 28 Sep 2023 10:33:01 -0700
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
Subject: Re: [PATCH v5 3/8] x86/resctrl: Split the rdt_domain structure
Message-ID: <ZRW4zRZtgZ0cdzqC@agluck-desk3>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-4-tony.luck@intel.com>
 <5f1256d3-737e-a447-abbe-f541767b2c8f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f1256d3-737e-a447-abbe-f541767b2c8f@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 04:25:15PM -0700, Reinette Chatre wrote:
> Hi Tony,
> 
> Subject:
> 
> x86/resctrl: Split the rdt_domain and rdt_hw_domain structures

Fixed subject as suggested.

> 
> 
> On 8/29/2023 4:44 PM, Tony Luck wrote:
> > The same rdt_domain structure is used for both control an monitor
> 
> "control an monitor" -> "control and monitor"

Fixed.

> 
> > functions. But this results in wasted memory as some of the fields
> > are only used by control functions, while most are only used for monitor
> > functions.
> > 
> > Create a new rdt_mondomain structure tailored explicitly for use in
> > monitor parts of the core. Slim down the rdt_domain structure by
> > removing the unused monitor fields.
> > 
> 
> Similar to the previous patch I think it will make the code
> easier to understand if the naming is clear for both
> monitoring and control structured. Why not rdt_mondomain
> and rdt_ctrldomain instead?

Done.

> 
> 
> > Similar breakout of struct rdt_hw_mondomain from struct rdt_hw_domain.
> 
> rdt_hw_mondomain and rdt_hw_ctrldomain?

Yes. rdt_hw_domain is split two ways and each gets an appropriate name.
I added an extra "_" to match shape of other names. So these are now
"rdt_hw_ctrl_domain" and "rdt_hw_mon_domain"

> > 
> > Signed-off-by: Tony Luck <tony.luck@intel.com>
> > ---
> >  include/linux/resctrl.h                   | 46 +++++++++++++++--------
> >  arch/x86/kernel/cpu/resctrl/internal.h    | 38 +++++++++++++------
> >  arch/x86/kernel/cpu/resctrl/core.c        | 18 ++++-----
> >  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  4 +-
> >  arch/x86/kernel/cpu/resctrl/monitor.c     | 40 ++++++++++----------
> >  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 24 ++++++------
> >  6 files changed, 101 insertions(+), 69 deletions(-)
> > 
> > diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> > index 33856943a787..08382548571e 100644
> > --- a/include/linux/resctrl.h
> > +++ b/include/linux/resctrl.h
> > @@ -53,7 +53,29 @@ struct resctrl_staged_config {
> >  };
> >  
> >  /**
> > - * struct rdt_domain - group of CPUs sharing a resctrl resource
> > + * struct rdt_domain - group of CPUs sharing a resctrl control resource
> > + * @list:		all instances of this resource
> > + * @id:			unique id for this instance
> > + * @cpu_mask:		which CPUs share this resource
> > + * @plr:		pseudo-locked region (if any) associated with domain
> > + * @staged_config:	parsed configuration to be applied
> > + * @mbps_val:		When mba_sc is enabled, this holds the array of user
> > + *			specified control values for mba_sc in MBps, indexed
> > + *			by closid
> > + */
> > +struct rdt_domain {
> > +	// First three fields must match struct rdt_mondomain below.
> 
> Please avoid comments within declarations. Even so, could you please
> elaborate what the above means? Why do the first three fields have to
> match? I understand there is common code, for example, __rdt_find_domain()
> that operated on the same members of the two structs but does that
> require the members be in the same position in the struct?
> I understand that a comment may be required if position in the struct
> is important but I cannot see that it is.

Discussed in other e-mail thread. Comments go away. The TWO (not three)
fields that must be common are now in an embedded "rdt_domain_hdr"
structure.

> 
> > +	struct list_head		list;
> > +	int				id;
> > +	struct cpumask			cpu_mask;
> > +
> > +	struct pseudo_lock_region	*plr;
> > +	struct resctrl_staged_config	staged_config[CDP_NUM_TYPES];
> > +	u32				*mbps_val;
> > +};
> > +
> > +/**
> > + * struct rdt_mondomain - group of CPUs sharing a resctrl monitor resource
> >   * @list:		all instances of this resource
> >   * @id:			unique id for this instance
> >   * @cpu_mask:		which CPUs share this resource
> > @@ -64,16 +86,13 @@ struct resctrl_staged_config {
> >   * @cqm_limbo:		worker to periodically read CQM h/w counters
> >   * @mbm_work_cpu:	worker CPU for MBM h/w counters
> >   * @cqm_work_cpu:	worker CPU for CQM h/w counters
> > - * @plr:		pseudo-locked region (if any) associated with domain
> > - * @staged_config:	parsed configuration to be applied
> > - * @mbps_val:		When mba_sc is enabled, this holds the array of user
> > - *			specified control values for mba_sc in MBps, indexed
> > - *			by closid
> >   */
> > -struct rdt_domain {
> > +struct rdt_mondomain {
> > +	// First three fields must match struct rdt_domain above.
> 
> Same comment.

Same solution.
> 
> >  	struct list_head		list;
> >  	int				id;
> >  	struct cpumask			cpu_mask;
> > +
> >  	unsigned long			*rmid_busy_llc;
> >  	struct mbm_state		*mbm_total;
> >  	struct mbm_state		*mbm_local;
> > @@ -81,9 +100,6 @@ struct rdt_domain {
> >  	struct delayed_work		cqm_limbo;
> >  	int				mbm_work_cpu;
> >  	int				cqm_work_cpu;
> > -	struct pseudo_lock_region	*plr;
> > -	struct resctrl_staged_config	staged_config[CDP_NUM_TYPES];
> > -	u32				*mbps_val;
> >  };
> >  
> >  /**
> 
> ...
> 
> > diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> > index 468c1815edfd..5167ac9cbe98 100644
> > --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> > +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> > @@ -521,7 +521,7 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
> >  }
> >  
> >  void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
> > -		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
> > +		    struct rdt_mondomain *d, struct rdtgroup *rdtgrp,
> >  		    int evtid, int first)
> >  {
> >  	/*
> > @@ -544,7 +544,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
> >  	struct rdtgroup *rdtgrp;
> >  	struct rdt_resource *r;
> >  	union mon_data_bits md;
> > -	struct rdt_domain *d;
> > +	struct rdt_mondomain *d;
> 
> Reverse fir order.

Fixed.

> 
> >  	struct rmid_read rr;
> >  	int ret = 0;
> >  
> > diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> > index 66beca785535..42262d59ef9b 100644
> > --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> > +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> > @@ -170,7 +170,7 @@ static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
> >  	return 0;
> >  }
> >  
> > -static struct arch_mbm_state *get_arch_mbm_state(struct rdt_hw_domain *hw_dom,
> > +static struct arch_mbm_state *get_arch_mbm_state(struct rdt_hw_mondomain *hw_dom,
> >  						 u32 rmid,
> >  						 enum resctrl_event_id eventid)
> >  {
> > @@ -189,10 +189,10 @@ static struct arch_mbm_state *get_arch_mbm_state(struct rdt_hw_domain *hw_dom,
> >  	return NULL;
> >  }
> >  
> > -void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
> > +void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_mondomain *d,
> >  			     u32 rmid, enum resctrl_event_id eventid)
> >  {
> > -	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
> > +	struct rdt_hw_mondomain *hw_dom = resctrl_to_arch_mondom(d);
> >  	struct arch_mbm_state *am;
> >  
> >  	am = get_arch_mbm_state(hw_dom, rmid, eventid);
> > @@ -208,9 +208,9 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
> >   * Assumes that hardware counters are also reset and thus that there is
> >   * no need to record initial non-zero counts.
> >   */
> > -void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_domain *d)
> > +void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_mondomain *d)
> >  {
> > -	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
> > +	struct rdt_hw_mondomain *hw_dom = resctrl_to_arch_mondom(d);
> >  
> >  	if (is_mbm_total_enabled())
> >  		memset(hw_dom->arch_mbm_total, 0,
> > @@ -229,11 +229,11 @@ static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
> >  	return chunks >> shift;
> >  }
> >  
> > -int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
> > +int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mondomain *d,
> >  			   u32 rmid, enum resctrl_event_id eventid, u64 *val)
> >  {
> >  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
> > -	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
> > +	struct rdt_hw_mondomain *hw_mondom = resctrl_to_arch_mondom(d);
> 
> Reverse fir.

Fixed.

> 
> >  	struct arch_mbm_state *am;
> >  	u64 msr_val, chunks;
> >  	int ret;
> > @@ -245,7 +245,7 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
> >  	if (ret)
> >  		return ret;
> >  
> > -	am = get_arch_mbm_state(hw_dom, rmid, eventid);
> > +	am = get_arch_mbm_state(hw_mondom, rmid, eventid);
> >  	if (am) {
> >  		am->chunks += mbm_overflow_count(am->prev_msr, msr_val,
> >  						 hw_res->mbm_width);
> > @@ -266,7 +266,7 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
> >   * decrement the count. If the busy count gets to zero on an RMID, we
> >   * free the RMID
> >   */
> > -void __check_limbo(struct rdt_domain *d, bool force_free)
> > +void __check_limbo(struct rdt_mondomain *d, bool force_free)
> >  {
> >  	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> >  	struct rmid_entry *entry;
> > @@ -305,7 +305,7 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
> >  	}
> >  }
> >  
> > -bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d)
> > +bool has_busy_rmid(struct rdt_resource *r, struct rdt_mondomain *d)
> >  {
> >  	return find_first_bit(d->rmid_busy_llc, r->num_rmid) != r->num_rmid;
> >  }
> > @@ -334,7 +334,7 @@ int alloc_rmid(void)
> >  static void add_rmid_to_limbo(struct rmid_entry *entry)
> >  {
> >  	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> > -	struct rdt_domain *d;
> > +	struct rdt_mondomain *d;
> >  	int cpu, err;
> >  	u64 val = 0;
> >  
> > @@ -383,7 +383,7 @@ void free_rmid(u32 rmid)
> >  		list_add_tail(&entry->list, &rmid_free_lru);
> >  }
> >  
> > -static struct mbm_state *get_mbm_state(struct rdt_domain *d, u32 rmid,
> > +static struct mbm_state *get_mbm_state(struct rdt_mondomain *d, u32 rmid,
> >  				       enum resctrl_event_id evtid)
> >  {
> >  	switch (evtid) {
> > @@ -516,7 +516,7 @@ void mon_event_count(void *info)
> >   * throttle MSRs already have low percentage values.  To avoid
> >   * unnecessarily restricting such rdtgroups, we also increase the bandwidth.
> >   */
> > -static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
> > +static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_mondomain *dom_mbm)
> >  {
> >  	u32 closid, rmid, cur_msr_val, new_msr_val;
> >  	struct mbm_state *pmbm_data, *cmbm_data;
> > @@ -600,7 +600,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
> >  	}
> >  }
> >  
> > -static void mbm_update(struct rdt_resource *r, struct rdt_domain *d, int rmid)
> > +static void mbm_update(struct rdt_resource *r, struct rdt_mondomain *d, int rmid)
> >  {
> >  	struct rmid_read rr;
> >  
> > @@ -641,12 +641,12 @@ void cqm_handle_limbo(struct work_struct *work)
> >  	unsigned long delay = msecs_to_jiffies(CQM_LIMBOCHECK_INTERVAL);
> >  	int cpu = smp_processor_id();
> >  	struct rdt_resource *r;
> > -	struct rdt_domain *d;
> > +	struct rdt_mondomain *d;
> 
> Reverse fir (Please check all code).

Fixed. (I wrote a simple awk script to find these (as I'm
obviously bad at noticing them). Included at end of this
message).

> 
> Reinette


#!/usr/bin/awk -f

BEGIN {
	keyw["bool"] = 1
	keyw["char"] = 1
	keyw["enum"] = 1
	keyw["int"] = 1
	keyw["long"] = 1
	keyw["short"] = 1
	keyw["static"] = 1
	keyw["struct"] = 1
	keyw["u16"] = 1
	keyw["u32"] = 1
	keyw["u64"] = 1
	keyw["u8"] = 1
	keyw["unsigned"] = 1
	keyw["void"] = 1
}

{
	source[NR] = $0

	if ($0 == "{") {
		infunction = NR
		skip
	}

	if ($0 == "}") {
		infunction = 0
		skip
	}

	if (infunction && ($1 in keyw)) {
		inlocals++
		if (inlocals > 1 && length(source[NR - 1]) < length)
			badfir = 1
		skip
	}
	if (inlocals && NF == 0) {
		if (badfir) {
			print "==== BAD FIR ===="
			for (i = infunction - 2; i < NR; i++)
				printf("%4d: %s\n", i, source[i])
		}
		inlocals = 0
		badfir = 0
	}
}
