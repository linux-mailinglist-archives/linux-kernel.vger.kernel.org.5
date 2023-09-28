Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4734F7B2503
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 20:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjI1SNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 14:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjI1SNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 14:13:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136F211F;
        Thu, 28 Sep 2023 11:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695924815; x=1727460815;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R8UwbRq5+jIj7ezjLpVaAJtAGi7kCMFDIPjLblg+Ids=;
  b=VgWblMrhvT+NZ81Y4JZJQoTvXUmHlgKMGXAl/omO8R7yC7RYOCwxYp75
   Bybf4w7vfPUEhF8IIvSVyZndrxppru+dzBxxFRuInyWPLwcP7xFxDummc
   hh/vet29s8d+9acsPlhQQ2Q6T+XPlIGhn5gwdfv5+SW1KBFqYXNooq9lj
   8ldTbIPHxH8sBSk1G12yfBmOsg0dFMPRY4rZcDXjOIy/0J6XJy92uSsQ1
   X8F+rnlGzRqppPaiklscCddsUA0g81a12qNhI4Ug1UTvlWosP3eWuQ48v
   nU7Ii0eHV5RcNaSDXXel5JSPHoTjKHFCgE0+rb3L5iegb5A3lSN0WtBMj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="384951139"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="384951139"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 11:12:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="784801957"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="784801957"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 11:12:46 -0700
Date:   Thu, 28 Sep 2023 11:12:45 -0700
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
Subject: Re: [PATCH v5 6/8] x86/resctrl: Sub NUMA Cluster detection and enable
Message-ID: <ZRXCHVhpxhD6Joo8@agluck-desk3>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-7-tony.luck@intel.com>
 <20c243fd-5068-b8a0-31d3-369b739ff1ca@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20c243fd-5068-b8a0-31d3-369b739ff1ca@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 04:29:44PM -0700, Reinette Chatre wrote:
> Hi Tony,
> 
> On 8/29/2023 4:44 PM, Tony Luck wrote:
> > There isn't a simple h/w bit that indicates whether a CPU is
> > running in Sub NUMA Cluster mode. Infer the state by comparing
> 
> Sub NUMA Cluster (SNC)

Fixed.

> 
> > the ratio of NUMA nodes to L3 cache instances.
> > 
> > When SNC mode is detected, reconfigure the RMID counters by updating
> > the MSR_RMID_SNC_CONFIG MSR on each socket as CPUs are seen.
> 
> Can it be explained how RMID counters are reconfigured when
> the MSR is updated?

Added some in previous patch (which implements the changes needed
by the reconfuration). Small note in ths patch to refer to that.

> > 
> > Signed-off-by: Tony Luck <tony.luck@intel.com>
> > ---
> >  arch/x86/include/asm/msr-index.h   |  1 +
> >  arch/x86/kernel/cpu/resctrl/core.c | 68 ++++++++++++++++++++++++++++++
> >  2 files changed, 69 insertions(+)
> > 
> > diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> > index 1d111350197f..393d1b047617 100644
> > --- a/arch/x86/include/asm/msr-index.h
> > +++ b/arch/x86/include/asm/msr-index.h
> > @@ -1100,6 +1100,7 @@
> >  #define MSR_IA32_QM_CTR			0xc8e
> >  #define MSR_IA32_PQR_ASSOC		0xc8f
> >  #define MSR_IA32_L3_CBM_BASE		0xc90
> > +#define MSR_RMID_SNC_CONFIG		0xca0
> >  #define MSR_IA32_L2_CBM_BASE		0xd10
> >  #define MSR_IA32_MBA_THRTL_BASE		0xd50
> >  
> > diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> > index ed4f55b3e5e4..9f0ac9721fab 100644
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
> > +#include <asm/cpu_device_id.h>
> >  #include <asm/intel-family.h>
> >  #include <asm/resctrl.h>
> >  #include "internal.h"
> > @@ -724,11 +727,34 @@ static void clear_closid_rmid(int cpu)
> >  	wrmsr(MSR_IA32_PQR_ASSOC, 0, 0);
> >  }
> >  
> > +/*
> > + * The power-on reset value of MSR_RMID_SNC_CONFIG is 0x1
> > + * which indicates that RMIDs are configured in legacy mode.
> > + * Clearing bit 0 reconfigures the RMID counters for use
> > + * in Sub NUMA Cluster mode.
> > + */
> 
> I think I missed where "legacy mode" and "Sub NUMA Cluster mode"
> are explained. 

Updated this comment to cover this better.

> 
> > +static void snc_remap_rmids(int cpu)
> > +{
> > +	u64 val;
> > +
> > +	/* Only need to enable once per package */
> 
> Sentence end with period.

Period added.
> 
> > +	if (cpumask_first(topology_core_cpumask(cpu)) != cpu)
> > +		return;
> > +
> 
> This is an area I am not familiar with. The above code seems
> to assume that CPUs are onlined in a particular numerical
> order. For example, if I understand correctly, if CPUs
> are onlined from higher number to lower number then
> the above code may end up running on every CPU online.

This sent me on a voyage of exploration into early Linux
bringup. There's a CONFIG_HOTPLUG_PARALLEL option to bring
CPUs up in parallel. I have it set on my kernel, but I still
see the "announce_cpu()" console messages show up in monotonic
increasing order:

[    3.148423] smpboot: x86: Booting SMP configuration:
[    3.148940] .... node  #0, CPUs:          #1   #2   #3   #4   #5   #6 #7 and so on

But, without solving this mystery, I realized this doesn't matter.
Whatever order the CPUs come online was all completed long before
resctrl is initialized:

	late_initcall(resctrl_late_init);

So the order that resctrl sees CPUs is dependent on the callbacks
from the registration with cpuhp_setup_state(). That happens with:

        /*
         * Try to call the startup callback for each present cpu
         * depending on the hotplug state of the cpu.
         */
        for_each_present_cpu(cpu) {

which is going to call in increasing numerical order as the bitmap
of present CPUs is traversed.

If someone changed this, the only ill effect on the code I'm
adding would be to set the MSR multiple times (which is
inefficient, but won't break anything).


> 
> > +	rdmsrl(MSR_RMID_SNC_CONFIG, val);
> > +	val &= ~BIT_ULL(0);
> > +	wrmsrl(MSR_RMID_SNC_CONFIG, val);
> > +}
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
> > @@ -983,11 +1009,53 @@ static __init bool get_rdt_resources(void)
> >  	return (rdt_mon_capable || rdt_alloc_capable);
> >  }
> >  
> > +/* CPU models that support MSR_RMID_SNC_CONFIG */
> > +static const struct x86_cpu_id snc_cpu_ids[] __initconst = {
> > +	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X, 0),
> > +	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, 0),
> > +	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X, 0),
> > +	{}
> > +};
> > +
> > +static __init int get_snc_config(void)
> 
> Could this function please get a comment about what it does?
> The first paragraph from the commit message should be ok.

Comment added. Also renamed to snc_get_config() so that these
SNC related functions use the same naming convention.
> 
> > +{
> > +	unsigned long *node_caches;
> > +	int mem_only_nodes = 0;
> > +	int cpu, node, ret;
> > +
> > +	if (!x86_match_cpu(snc_cpu_ids))
> > +		return 1;
> > +
> > +	node_caches = kcalloc(BITS_TO_LONGS(nr_node_ids), sizeof(*node_caches), GFP_KERNEL);
> 
> How about bitmap_zalloc()?

Excellent! Now using it.

> 
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
> > +
> > +	ret = (nr_node_ids - mem_only_nodes) / bitmap_weight(node_caches, nr_node_ids);
> 
> My static checker complains about the above line risking
> a "divide by zero" that may be the case if the bitmap_weight() returns
> zero. You may need to ensure this is safe here before more static checkers
> start analyzing this code.

Added defensive code that checks result of bitmap_weight() for a zero
return. If it does (somehow ... that means there are no nodes with
CPUs that have an L3 cache!) then the code will assume SNC is not
enabled.

> 
> > +	kfree(node_caches);
> > +
> > +	if (ret > 1)
> > +		rdt_resources_all[RDT_RESOURCE_L3].r_resctrl.mon_scope = RESCTRL_NODE;
> > +
> > +	return ret;
> > +}
> 
> As discussed there are scenarios where the above may not provide the
> correct value. Could you please document the assumptions of this code to
> highlight this to x86 maintainers for their opinions?

Added a note that booting with maxcpus=N boot parameter will break this
check in ways that cannot be worked around. Early boot code doesn't have
to worry about user taking CPUs offline, because it runs before users
can do that.

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
> 
> 
> Reinette
