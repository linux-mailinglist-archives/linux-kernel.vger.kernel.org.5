Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827FB788E03
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 19:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235772AbjHYRuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 13:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbjHYRtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 13:49:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EBA212B;
        Fri, 25 Aug 2023 10:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692985789; x=1724521789;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6h29044JPGtXHYMRzJJgRsNjgN6sokE079HHjZToSbw=;
  b=IVpYH0A3lShmazJENGAM4DncRNqGKDRzgNhwUvwkYTVNQ5vhisIFCdts
   zGJz1hZw3M7Ay/lttCPCdl11xqDuUSHsFlt358R7MJN3KTsbmJ2vhQf9y
   /hc2xvBLd/gjt+vEsh/Inv+AXdrGg4ye8+iuqBLX/FZCgaJBhGnR0JCXc
   QXGL8nsBjRLlTmZd8Wj6fg4tdIvZ7rImFuOds58XwLVSYBoGF6N0vysiC
   42SQ7hrQP/Xxnb015kGvIl7GekTp+BEfJ96sZBLrkAZQjnSia9qIslzCh
   86PIPxhqsXjl/eqD9d++TC2MVb4JPjLSUF8/HERZbd78l0waomcOwoC0G
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="441115213"
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="441115213"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 10:49:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="1068311270"
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="1068311270"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 10:49:48 -0700
Date:   Fri, 25 Aug 2023 10:49:46 -0700
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
Subject: Re: [PATCH v4 5/7] x86/resctrl: Determine if Sub-NUMA Cluster is
 enabled and initialize.
Message-ID: <ZOjpugXNDVx/cGRl@agluck-desk3>
References: <20230713163207.219710-1-tony.luck@intel.com>
 <20230722190740.326190-1-tony.luck@intel.com>
 <20230722190740.326190-6-tony.luck@intel.com>
 <7c8650d5-eb69-dd28-81fc-7a97d45f9bfb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c8650d5-eb69-dd28-81fc-7a97d45f9bfb@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 10:32:29AM -0700, Reinette Chatre wrote:
> Hi Tony,
> 
> On 7/22/2023 12:07 PM, Tony Luck wrote:
> > There isn't a simple hardware enumeration to indicate to software that
> > a system is running with Sub-NUMA Cluster enabled.
> > 
> > Compare the number of NUMA nodes with the number of L3 caches to calculate
> > the number of Sub-NUMA nodes per L3 cache.
> > 
> > When Sub-NUMA cluster mode is enabled in BIOS setup the RMID counters
> > are distributed equally between the SNC nodes within each socket.
> > 
> > E.g. if there are 400 RMID counters, and the system is configured with
> > two SNC nodes per socket, then RMID counter 0..199 are used on SNC node
> > 0 on the socket, and RMID counter 200..399 on SNC node 1.
> > 
> > A model specific MSR (0xca0) can change the configuration of the RMIDs
> > when SNC mode is enabled.
> > 
> > The MSR controls the interpretation of the RMID field in the
> > IA32_PQR_ASSOC MSR so that the appropriate hardware counters
> > within the SNC node are updated.
> > 
> > To read the RMID counters an offset must be used to get data
> > from the physical counter associated with the SNC node. As in
> > the example above with 400 RMID counters Linux sees only 200
> > counters. No special action is needed to read a counter from
> > the first SNC node on a socket. But to read a Linux visible
> > counter 50 on the second SNC node the kernel must load 250
> > into the QM_EVTSEL MSR.
> > 
> > N.B. this works well for well-behaved NUMA applications that access
> > memory predominantly from the local memory node. For applications that
> > access memory across multiple nodes it may be necessary for the user
> > to read counters for all SNC nodes on a socket and add the values to
> > get the actual LLC occupancy or memory bandwidth. Perhaps this isn't
> > all that different from applications that span across multiple sockets
> > in a legacy system.
> > 
> > The cache allocation feature still provides the same number of
> > bits in a mask to control allocation into the L3 cache. But each
> > of those ways has its capacity reduced because the cache is divided
> > between the SNC nodes. Adjust the value reported in the resctrl
> > "size" file accordingly.
> > 
> > Mounting the file system with the "mba_MBps" option is disabled
> > when SNC mode is enabled. This is because the measurement of bandwidth
> > is per SNC node, while the MBA throttling controls are still at
> > the L3 cache scope.
> > 
> 
> I'm counting four logical changes in this changelog. Can they be separate
> patches?

Split into three parts. I couln't quite see how to get to four.

> 
> > Signed-off-by: Tony Luck <tony.luck@intel.com>
> > ---
> >  include/linux/resctrl.h                |  2 +
> >  arch/x86/include/asm/msr-index.h       |  1 +
> >  arch/x86/kernel/cpu/resctrl/internal.h |  2 +
> >  arch/x86/kernel/cpu/resctrl/core.c     | 82 +++++++++++++++++++++++++-
> >  arch/x86/kernel/cpu/resctrl/monitor.c  | 18 +++++-
> >  arch/x86/kernel/cpu/resctrl/rdtgroup.c |  4 +-
> >  6 files changed, 103 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> > index 80a89d171eba..576dc21bd990 100644
> > --- a/include/linux/resctrl.h
> > +++ b/include/linux/resctrl.h
> > @@ -200,6 +200,8 @@ struct rdt_resource {
> >  	bool			cdp_capable;
> >  };
> >  
> > +#define MON_SCOPE_NODE 100
> > +
> 
> Could you please add a comment to explain what this constant represents
> and how it is used?

This is gone in V6. It's become part of an "enum" for each of the scope
options.

> 
> >  /**
> >   * struct resctrl_schema - configuration abilities of a resource presented to
> >   *			   user-space
> > diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> > index 3aedae61af4f..4b624a37d64a 100644
> > --- a/arch/x86/include/asm/msr-index.h
> > +++ b/arch/x86/include/asm/msr-index.h
> > @@ -1087,6 +1087,7 @@
> >  #define MSR_IA32_QM_CTR			0xc8e
> >  #define MSR_IA32_PQR_ASSOC		0xc8f
> >  #define MSR_IA32_L3_CBM_BASE		0xc90
> > +#define MSR_RMID_SNC_CONFIG		0xca0
> >  #define MSR_IA32_L2_CBM_BASE		0xd10
> >  #define MSR_IA32_MBA_THRTL_BASE		0xd50
> >  
> > diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> > index 016ef0373c5a..00a330bc5ced 100644
> > --- a/arch/x86/kernel/cpu/resctrl/internal.h
> > +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> > @@ -446,6 +446,8 @@ DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
> >  
> >  extern struct dentry *debugfs_resctrl;
> >  
> > +extern int snc_nodes_per_l3_cache;
> > +
> >  enum resctrl_res_level {
> >  	RDT_RESOURCE_L3,
> >  	RDT_RESOURCE_L2,
> > diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> > index 0161362b0c3e..1331add347fc 100644
> > --- a/arch/x86/kernel/cpu/resctrl/core.c
> > +++ b/arch/x86/kernel/cpu/resctrl/core.c
> > @@ -16,11 +16,14 @@
> >  
> >  #define pr_fmt(fmt)	"resctrl: " fmt
> >  
> > +#include <linux/cpu.h>
> >  #include <linux/slab.h>
> >  #include <linux/err.h>
> >  #include <linux/cacheinfo.h>
> >  #include <linux/cpuhotplug.h>
> > +#include <linux/mod_devicetable.h>
> >  
> 
> What does this include provide?

This header provides the defintion of struct x86_cpu_id.

> 
> > +#include <asm/cpu_device_id.h>
> >  #include <asm/intel-family.h>
> >  #include <asm/resctrl.h>
> >  #include "internal.h"
> > @@ -48,6 +51,13 @@ int max_name_width, max_data_width;
> >   */
> >  bool rdt_alloc_capable;
> >  
> > +/*
> > + * Number of SNC nodes that share each L3 cache.
> > + * Default is 1 for systems that do not support
> > + * SNC, or have SNC disabled.
> > + */
> > +int snc_nodes_per_l3_cache = 1;
> > +
> >  static void
> >  mba_wrmsr_intel(struct rdt_domain *d, struct msr_param *m,
> >  		struct rdt_resource *r);
> > @@ -543,9 +553,16 @@ static void domain_add_cpu_ctrl(int cpu, struct rdt_resource *r)
> >  	}
> >  }
> >  
> > +static int get_mon_scope_id(int cpu, int scope)
> > +{
> > +	if (scope == MON_SCOPE_NODE)
> > +		return cpu_to_node(cpu);
> > +	return get_cpu_cacheinfo_id(cpu, scope);
> > +}
> > +
> >  static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
> >  {
> > -	int id = get_cpu_cacheinfo_id(cpu, r->mon_scope);
> > +	int id = get_mon_scope_id(cpu, r->mon_scope);
> >  	struct list_head *add_pos = NULL;
> >  	struct rdt_hw_mondomain *hw_mondom;
> >  	struct rdt_mondomain *d;
> > @@ -692,11 +709,28 @@ static void clear_closid_rmid(int cpu)
> >  	wrmsr(MSR_IA32_PQR_ASSOC, 0, 0);
> >  }
> >  
> > +static void snc_remap_rmids(int cpu)
> > +{
> > +	u64	val;
> 
> No need for tab here.

Turned into a <SPACE>

> 
> > +
> > +	/* Only need to enable once per package */
> > +	if (cpumask_first(topology_core_cpumask(cpu)) != cpu)
> > +		return;
> > +
> > +	rdmsrl(MSR_RMID_SNC_CONFIG, val);
> > +	val &= ~BIT_ULL(0);
> > +	wrmsrl(MSR_RMID_SNC_CONFIG, val);
> > +}
> 
> Could you please document snc_remap_rmids()
> with information on what the bit in the register means
> and what the above function does?

Added header comment for this function describing the MSR
and the function.

> 
> > +
> >  static int resctrl_online_cpu(unsigned int cpu)
> >  {
> >  	struct rdt_resource *r;
> >  
> >  	mutex_lock(&rdtgroup_mutex);
> > +
> > +	if (snc_nodes_per_l3_cache > 1)
> > +		snc_remap_rmids(cpu);
> > +
> >  	for_each_capable_rdt_resource(r)
> >  		domain_add_cpu(cpu, r);
> >  	/* The cpu is set in default rdtgroup after online. */
> > @@ -951,11 +985,57 @@ static __init bool get_rdt_resources(void)
> >  	return (rdt_mon_capable || rdt_alloc_capable);
> >  }
> >  
> 
> I think it will help to add a comment like:
> "CPUs that support the model specific MSR_RMID_SNC_CONFIG register."

Done.

> 
> > +static const struct x86_cpu_id snc_cpu_ids[] __initconst = {
> > +	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X, 0),
> > +	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, 0),
> > +	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X, 0),
> > +	{}
> > +};
> > +
> > +/*
> > + * There isn't a simple enumeration bit to show whether SNC mode
> > + * is enabled. Look at the ratio of number of NUMA nodes to the
> > + * number of distinct L3 caches. Take care to skip memory-only nodes.
> > + */
> > +static __init int get_snc_config(void)
> > +{
> > +	unsigned long *node_caches;
> > +	int mem_only_nodes = 0;
> > +	int cpu, node, ret;
> > +
> > +	if (!x86_match_cpu(snc_cpu_ids))
> > +		return 1;
> > +
> > +	node_caches = kcalloc(BITS_TO_LONGS(nr_node_ids), sizeof(*node_caches), GFP_KERNEL);
> > +	if (!node_caches)
> > +		return 1;
> > +
> > +	cpus_read_lock();
> > +	for_each_node(node) {
> > +		cpu = cpumask_first(cpumask_of_node(node));
> > +		if (cpu < nr_cpu_ids)
> > +			set_bit(get_cpu_cacheinfo_id(cpu, 3), node_caches);
> > +		else
> > +			mem_only_nodes++;
> > +	}
> > +	cpus_read_unlock();
> 
> I am not familiar with the numa code at all so please correct me
> where I am wrong. I do see that nr_node_ids is initialized with __init code
> so it should be accurate at this point. It looks to me like this initialization
> assumes that at least one CPU per node will be online at the time it is run.
> It is not clear to me that this assumption would always be true. 

Resctrl initialization is kicked off as a late_initcall(). So all CPUs
and devices are fully initialized before this code runs.

Resctrl can't be moved to an "init" state before CPUs are brought online
because it makes a call to cpuhp_setup_state() to get callbacks for
online/offline CPU events ... that call can't be done early.

> 
> > +
> > +	ret = (nr_node_ids - mem_only_nodes) / bitmap_weight(node_caches, nr_node_ids);
> > +	kfree(node_caches);
> > +
> > +	if (ret > 1)
> > +		rdt_resources_all[RDT_RESOURCE_L3].r_resctrl.mon_scope = MON_SCOPE_NODE;
> > +
> > +	return ret;
> > +}
> > +
> >  static __init void rdt_init_res_defs_intel(void)
> >  {
> >  	struct rdt_hw_resource *hw_res;
> >  	struct rdt_resource *r;
> >  
> > +	snc_nodes_per_l3_cache = get_snc_config();
> > +
> >  	for_each_rdt_resource(r) {
> >  		hw_res = resctrl_to_arch_res(r);
> >  
> > diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> > index 0d9605fccb34..4ca064e62911 100644
> > --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> > +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> > @@ -148,8 +148,18 @@ static inline struct rmid_entry *__rmid_entry(u32 rmid)
> >  
> >  static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
> >  {
> > +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> > +	int cpu = get_cpu();
> 
> I do not think it is necessary to disable preemption here. Also please note that
> James is working on changes to not have this code block. Could just smp_processor_id()
> do?

Not needed to disable pre-emption - because it is already disabled ...
call sequence to get to here comes through smp_call_function_single()
which does it's own get_cpu()). Will change this code to use
smp_processor_id()
> 
> > +	int rmid_offset = 0;
> >  	u64 msr_val;
> >  
> > +	/*
> > +	 * When SNC mode is on, need to compute the offset to read the
> > +	 * physical RMID counter for the node to which this CPU belongs
> > +	 */
> > +	if (snc_nodes_per_l3_cache > 1)
> > +		rmid_offset = (cpu_to_node(cpu) % snc_nodes_per_l3_cache) * r->num_rmid;
> > +
> >  	/*
> >  	 * As per the SDM, when IA32_QM_EVTSEL.EvtID (bits 7:0) is configured
> >  	 * with a valid event code for supported resource type and the bits
> > @@ -158,9 +168,11 @@ static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
> >  	 * IA32_QM_CTR.Error (bit 63) and IA32_QM_CTR.Unavailable (bit 62)
> >  	 * are error bits.
> >  	 */
> > -	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
> > +	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid + rmid_offset);
> >  	rdmsrl(MSR_IA32_QM_CTR, msr_val);
> >  
> > +	put_cpu();
> > +
> >  	if (msr_val & RMID_VAL_ERROR)
> >  		return -EIO;
> >  	if (msr_val & RMID_VAL_UNAVAIL)
> 
> Reinette

-Tony
