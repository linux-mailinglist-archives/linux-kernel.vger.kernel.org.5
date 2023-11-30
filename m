Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C33F7FF985
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346563AbjK3Sh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbjK3Sh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:37:26 -0500
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734C010E2;
        Thu, 30 Nov 2023 10:37:32 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-9e1021dbd28so180955566b.3;
        Thu, 30 Nov 2023 10:37:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701369451; x=1701974251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DrjTsTYO2xlkgWoVz4wv+b3rfotA5xQPi9VNa2keNcM=;
        b=ZszbT5XWILnOA2CWjrt9midoU2oe6iPofHAaMm56f/kw4FWr+jcrkZa/pAK3v3KaDc
         OvQjmaS3aS3ntkDIHRgFIuEOhjJxRoV3HHhSn9ad1tnPPfWhDq80sY+pGO7Hj3+Fv10j
         f77VGhTikPmHVLaRv856SbUz+6MrhztnqacQbZhVF0EzOAxc0GFORLBQW/Ca11VvdFyN
         gJtBnWWuFuCarXUwliq/rcVZcE/gmmNmmbZsSRrvHR08loz3GS4B+c7/MtM/RvzLDTY3
         glQrXyvp+xJBEW5r5ULrMFwhR0rdb+Z7KDY5GR5U6pF3ncrZCTltdiue9UkpDxGGXj4o
         jF7g==
X-Gm-Message-State: AOJu0YyoFiFyKKV/mvypbXC+NapgrpyUKNWSvFezwDRRv1Raf5pR8xjZ
        b96PAOkPaa4RbnwrlN7MMWNJHzMTOd2bpA==
X-Google-Smtp-Source: AGHT+IFhceBOXFtFeNygHnG7iLef2czfYaT82CSBsd3d1NEQeS+IegeaK1ATdIjiZxnS9JQx5C4GUg==
X-Received: by 2002:a19:8c02:0:b0:50b:c4e3:b601 with SMTP id o2-20020a198c02000000b0050bc4e3b601mr11990lfd.66.1701367365369;
        Thu, 30 Nov 2023 10:02:45 -0800 (PST)
Received: from localhost (ec2-13-42-112-133.eu-west-2.compute.amazonaws.com. [13.42.112.133])
        by smtp.gmail.com with ESMTPSA id r11-20020ac25a4b000000b005033948f108sm214420lfn.272.2023.11.30.10.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 10:02:44 -0800 (PST)
Date:   Thu, 30 Nov 2023 18:02:42 +0000
From:   Fam Zheng <fam@euphon.net>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: Re: [PATCH v12 7/8] x86/resctrl: Sub NUMA Cluster detection and
 enable
Message-ID: <ZWjOBw0Ygyw226Cc@dell>
References: <20231109230915.73600-1-tony.luck@intel.com>
 <20231130003418.89964-1-tony.luck@intel.com>
 <20231130003418.89964-8-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130003418.89964-8-tony.luck@intel.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On Wed, Nov 29, 2023 at 04:34:17PM -0800, Tony Luck wrote:
> There isn't a simple hardware bit that indicates whether a CPU is
> running in Sub NUMA Cluster (SNC) mode. Infer the state by comparing
> the ratio of NUMA nodes to L3 cache instances.
> 
> When SNC mode is detected, reconfigure the RMID counters by updating
> the MSR_RMID_SNC_CONFIG MSR on each socket as CPUs are seen.
> 
> Clearing bit zero of the MSR divides the RMIDs and renumbers the ones
> on the second SNC node to start from zero.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Peter Newman <peternewman@google.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>  arch/x86/include/asm/msr-index.h   |  1 +
>  arch/x86/kernel/cpu/resctrl/core.c | 96 ++++++++++++++++++++++++++++++
>  2 files changed, 97 insertions(+)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 1d51e1850ed0..94d29d81e6db 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -1111,6 +1111,7 @@
>  #define MSR_IA32_QM_CTR			0xc8e
>  #define MSR_IA32_PQR_ASSOC		0xc8f
>  #define MSR_IA32_L3_CBM_BASE		0xc90
> +#define MSR_RMID_SNC_CONFIG		0xca0
>  #define MSR_IA32_L2_CBM_BASE		0xd10
>  #define MSR_IA32_MBA_THRTL_BASE		0xd50
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index cf5aba8a74bf..3293ab4c58b0 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -16,11 +16,14 @@
>  
>  #define pr_fmt(fmt)	"resctrl: " fmt
>  
> +#include <linux/cpu.h>
>  #include <linux/slab.h>
>  #include <linux/err.h>
>  #include <linux/cacheinfo.h>
>  #include <linux/cpuhotplug.h>
> +#include <linux/mod_devicetable.h>
>  
> +#include <asm/cpu_device_id.h>
>  #include <asm/intel-family.h>
>  #include <asm/resctrl.h>
>  #include "internal.h"
> @@ -740,11 +743,42 @@ static void clear_closid_rmid(int cpu)
>  	wrmsr(MSR_IA32_PQR_ASSOC, 0, 0);
>  }
>  
> +/*
> + * The power-on reset value of MSR_RMID_SNC_CONFIG is 0x1
> + * which indicates that RMIDs are configured in legacy mode.
> + * This mode is incompatible with Linux resctrl semantics
> + * as RMIDs are partitioned between SNC nodes, which requires
> + * a user to know which RMID is allocated to a task.
> + * Clearing bit 0 reconfigures the RMID counters for use
> + * in Sub NUMA Cluster mode. This mode is better for Linux.
> + * The RMID space is divided between all SNC nodes with the
> + * RMIDs renumbered to start from zero in each node when
> + * couning operations from tasks. Code to read the counters
> + * must adjust RMID counter numbers based on SNC node. See
> + * __rmid_read() for code that does this.
> + */
> +static void snc_remap_rmids(int cpu)
> +{
> +	u64 val;
> +
> +	/* Only need to enable once per package. */
> +	if (cpumask_first(topology_core_cpumask(cpu)) != cpu)
> +		return;
> +
> +	rdmsrl(MSR_RMID_SNC_CONFIG, val);
> +	val &= ~BIT_ULL(0);
> +	wrmsrl(MSR_RMID_SNC_CONFIG, val);
> +}
> +
>  static int resctrl_online_cpu(unsigned int cpu)
>  {
>  	struct rdt_resource *r;
>  
>  	mutex_lock(&rdtgroup_mutex);
> +
> +	if (snc_nodes_per_l3_cache > 1)
> +		snc_remap_rmids(cpu);
> +
>  	for_each_capable_rdt_resource(r)
>  		domain_add_cpu(cpu, r);
>  	/* The cpu is set in default rdtgroup after online. */
> @@ -999,11 +1033,73 @@ static __init bool get_rdt_resources(void)
>  	return (rdt_mon_capable || rdt_alloc_capable);
>  }
>  
> +/* CPU models that support MSR_RMID_SNC_CONFIG */
> +static const struct x86_cpu_id snc_cpu_ids[] __initconst = {
> +	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X, 0),
> +	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, 0),
> +	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X, 0),
> +	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_X, 0),
> +	{}
> +};
> +
> +/*
> + * There isn't a simple hardware bit that indicates whether a CPU is running
> + * in Sub NUMA Cluster (SNC) mode. Infer the state by comparing the
> + * ratio of NUMA nodes to L3 cache instances.
> + * It is not possible to accurately determine SNC state if the system is
> + * booted with a maxcpus=N parameter. That distorts the ratio of SNC nodes
> + * to L3 caches. It will be OK if system is booted with hyperthreading
> + * disabled (since this doesn't affect the ratio).
> + */
> +static __init int snc_get_config(void)
> +{
> +	unsigned long *node_caches;
> +	int mem_only_nodes = 0;
> +	int cpu, node, ret;
> +	int num_l3_caches;
> +
> +	if (!x86_match_cpu(snc_cpu_ids))
> +		return 1;
> +
> +	node_caches = bitmap_zalloc(nr_node_ids, GFP_KERNEL);
> +	if (!node_caches)
> +		return 1;
> +
> +	cpus_read_lock();
> +
> +	if (num_online_cpus() != num_present_cpus())
> +		pr_warn("Some CPUs offline, SNC detection may be incorrect\n");
> +
> +	for_each_node(node) {
> +		cpu = cpumask_first(cpumask_of_node(node));
> +		if (cpu < nr_cpu_ids)
> +			set_bit(get_cpu_cacheinfo_id(cpu, 3), node_caches);

Are we sure get_cpu_cacheinfo_id() is an valid index here? Looking at
the function it could be -1 or larger than nr_node_ids.

Fam

> +		else
> +			mem_only_nodes++;
> +	}
> +	cpus_read_unlock();
> +
> +	num_l3_caches = bitmap_weight(node_caches, nr_node_ids);
> +	kfree(node_caches);
> +
> +	if (!num_l3_caches)
> +		return 1;
> +
> +	ret = (nr_node_ids - mem_only_nodes) / num_l3_caches;
> +
> +	if (ret > 1)
> +		rdt_resources_all[RDT_RESOURCE_L3].r_resctrl.mon_scope = RESCTRL_NODE;
> +
> +	return ret;
> +}
> +
>  static __init void rdt_init_res_defs_intel(void)
>  {
>  	struct rdt_hw_resource *hw_res;
>  	struct rdt_resource *r;
>  
> +	snc_nodes_per_l3_cache = snc_get_config();
> +
>  	for_each_rdt_resource(r) {
>  		hw_res = resctrl_to_arch_res(r);
>  
> -- 
> 2.41.
