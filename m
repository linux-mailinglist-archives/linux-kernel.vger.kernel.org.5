Return-Path: <linux-kernel+bounces-123932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F8A890FEB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D48FA28B808
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B656612B83;
	Fri, 29 Mar 2024 00:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SXnpyI8o"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8892E56A;
	Fri, 29 Mar 2024 00:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711673957; cv=none; b=uV2wQ1LPoqXykYQpxC6nvKzEz9/Lg7hEZcz7Oj5rGgoouA9mGVdYlsO7uzpgz1yfn47U1SruVo1TPQ9eZYWMRXcqCEpOXJAJnXkjmaU1CzNKZ4bNtdPGLlVrGmm2eo75VxiFRIgDD3Iqxt9/5wADR5tA1urcqSEl7Sk/2lanAY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711673957; c=relaxed/simple;
	bh=K4JVW10yLm4zNnV4kPQnYT8v/YP7n6h53VOMc/kzU6o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S/NGX0ngATprdwJ0tOQdK8GjNDNF7P7JwWactinlzrT1kmv8SMgd+OTcISPGP3qJrNqmkUdYsxn89hjCd4IM6i6oPTcQ6yvz0ZRcr94u5VZXm5+3t6I/WDZOoCLSvr5ogBMQT9tNlCUP3+7ldyQdYB1hcK5d0GF/LLcAA7Ww3+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SXnpyI8o; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711673954; x=1743209954;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=K4JVW10yLm4zNnV4kPQnYT8v/YP7n6h53VOMc/kzU6o=;
  b=SXnpyI8oXjAj4JxyCq7mQyGvSlKHnjTIP8m2HpLvYQ1Wmo7lTFnLDhfC
   +hXy3j7TXAtTSBHrVuZjDDWrH8pysIM8VZaJW4d9xsTjhNu9/iheqFM/E
   /V77pchVNkrYDRETYBz/EFEtXnB02XwO5JUJfC0Aap1cKodo0k4+ZN4S0
   /71eOYiQQWBA/sH7X0Taj9psGD3ZKGR+rsMkR2pTbD/G6ITTB22hEPpGf
   fW+d35YiXxxgJDiK1VhDPRmJVskRYvk1jAhSjainzxpxxu2i/oBEaQ1P3
   ziNGCCaxY4wIDQuLPRWywnfgF0yBq8rRgXyX8io0IDWJhNQR4G29R9H5P
   Q==;
X-CSE-ConnectionGUID: mQgVk1oGQ4uRoJ7z745hvQ==
X-CSE-MsgGUID: RzIsXq30Rs6w1cHeNI+JMA==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="10663925"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="10663925"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 17:59:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="16860173"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 17:59:09 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Cc: "Gregory Price" <gourry.memverge@gmail.com>,
  aneesh.kumar@linux.ibm.com,  mhocko@suse.com,  tj@kernel.org,
  john@jagalactic.com,  "Eishan Mirakhur" <emirakhur@micron.com>,
  "Vinicius Tavares Petrucci" <vtavarespetr@micron.com>,  "Ravis OpenSrc"
 <Ravis.OpenSrc@micron.com>,  "Alistair Popple" <apopple@nvidia.com>,
  "Srinivasulu Thanneeru" <sthanneeru@micron.com>,  Dan Williams
 <dan.j.williams@intel.com>,  Vishal Verma <vishal.l.verma@intel.com>,
  Dave Jiang <dave.jiang@intel.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  nvdimm@lists.linux.dev,
  linux-cxl@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org,  "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,  "Ho-Ren
 (Jack) Chuang" <horenchuang@gmail.com>,  qemu-devel@nongnu.org,  Hao Xiang
 <hao.xiang@bytedance.com>
Subject: Re: [PATCH v8 2/2] memory tier: create CPUless memory tiers after
 obtaining HMAT info
In-Reply-To: <20240329004815.195476-3-horenchuang@bytedance.com> (Ho-Ren
	Chuang's message of "Fri, 29 Mar 2024 00:48:14 +0000")
References: <20240329004815.195476-1-horenchuang@bytedance.com>
	<20240329004815.195476-3-horenchuang@bytedance.com>
Date: Fri, 29 Mar 2024 08:57:14 +0800
Message-ID: <87a5mhlus5.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

"Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> writes:

> The current implementation treats emulated memory devices, such as
> CXL1.1 type3 memory, as normal DRAM when they are emulated as normal memory
> (E820_TYPE_RAM). However, these emulated devices have different
> characteristics than traditional DRAM, making it important to
> distinguish them. Thus, we modify the tiered memory initialization process
> to introduce a delay specifically for CPUless NUMA nodes. This delay
> ensures that the memory tier initialization for these nodes is deferred
> until HMAT information is obtained during the boot process. Finally,
> demotion tables are recalculated at the end.
>
> * late_initcall(memory_tier_late_init);
> Some device drivers may have initialized memory tiers between
> `memory_tier_init()` and `memory_tier_late_init()`, potentially bringing
> online memory nodes and configuring memory tiers. They should be excluded
> in the late init.
>
> * Handle cases where there is no HMAT when creating memory tiers
> There is a scenario where a CPUless node does not provide HMAT information.
> If no HMAT is specified, it falls back to using the default DRAM tier.
>
> * Introduce another new lock `default_dram_perf_lock` for adist calculation
> In the current implementation, iterating through CPUlist nodes requires
> holding the `memory_tier_lock`. However, `mt_calc_adistance()` will end up
> trying to acquire the same lock, leading to a potential deadlock.
> Therefore, we propose introducing a standalone `default_dram_perf_lock` to
> protect `default_dram_perf_*`. This approach not only avoids deadlock
> but also prevents holding a large lock simultaneously.
>
> * Upgrade `set_node_memory_tier` to support additional cases, including
>   default DRAM, late CPUless, and hot-plugged initializations.
> To cover hot-plugged memory nodes, `mt_calc_adistance()` and
> `mt_find_alloc_memory_type()` are moved into `set_node_memory_tier()` to
> handle cases where memtype is not initialized and where HMAT information is
> available.
>
> * Introduce `default_memory_types` for those memory types that are not
>   initialized by device drivers.
> Because late initialized memory and default DRAM memory need to be managed,
> a default memory type is created for storing all memory types that are
> not initialized by device drivers and as a fallback.
>
> Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> ---
>  mm/memory-tiers.c | 94 +++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 78 insertions(+), 16 deletions(-)
>
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index 974af10cfdd8..e24fc3bebae4 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -36,6 +36,11 @@ struct node_memory_type_map {
>  
>  static DEFINE_MUTEX(memory_tier_lock);
>  static LIST_HEAD(memory_tiers);
> +/*
> + * The list is used to store all memory types that are not created
> + * by a device driver.
> + */
> +static LIST_HEAD(default_memory_types);
>  static struct node_memory_type_map node_memory_types[MAX_NUMNODES];
>  struct memory_dev_type *default_dram_type;
>  
> @@ -108,6 +113,8 @@ static struct demotion_nodes *node_demotion __read_mostly;
>  
>  static BLOCKING_NOTIFIER_HEAD(mt_adistance_algorithms);
>  
> +/* The lock is used to protect `default_dram_perf*` info and nid. */
> +static DEFINE_MUTEX(default_dram_perf_lock);
>  static bool default_dram_perf_error;
>  static struct access_coordinate default_dram_perf;
>  static int default_dram_perf_ref_nid = NUMA_NO_NODE;
> @@ -505,7 +512,8 @@ static inline void __init_node_memory_type(int node, struct memory_dev_type *mem
>  static struct memory_tier *set_node_memory_tier(int node)
>  {
>  	struct memory_tier *memtier;
> -	struct memory_dev_type *memtype;
> +	struct memory_dev_type *mtype = default_dram_type;
> +	int adist = MEMTIER_ADISTANCE_DRAM;
>  	pg_data_t *pgdat = NODE_DATA(node);
>  
>  
> @@ -514,11 +522,20 @@ static struct memory_tier *set_node_memory_tier(int node)
>  	if (!node_state(node, N_MEMORY))
>  		return ERR_PTR(-EINVAL);
>  
> -	__init_node_memory_type(node, default_dram_type);
> +	mt_calc_adistance(node, &adist);
> +	if (node_memory_types[node].memtype == NULL) {
> +		mtype = mt_find_alloc_memory_type(adist, &default_memory_types);
> +		if (IS_ERR(mtype)) {
> +			mtype = default_dram_type;
> +			pr_info("Failed to allocate a memory type. Fall back.\n");
> +		}
> +	}
> +
> +	__init_node_memory_type(node, mtype);
>  
> -	memtype = node_memory_types[node].memtype;
> -	node_set(node, memtype->nodes);
> -	memtier = find_create_memory_tier(memtype);
> +	mtype = node_memory_types[node].memtype;
> +	node_set(node, mtype->nodes);
> +	memtier = find_create_memory_tier(mtype);
>  	if (!IS_ERR(memtier))
>  		rcu_assign_pointer(pgdat->memtier, memtier);
>  	return memtier;
> @@ -655,6 +672,34 @@ void mt_put_memory_types(struct list_head *memory_types)
>  }
>  EXPORT_SYMBOL_GPL(mt_put_memory_types);
>  
> +/*
> + * This is invoked via `late_initcall()` to initialize memory tiers for
> + * CPU-less memory nodes after driver initialization, which is
> + * expected to provide `adistance` algorithms.
> + */
> +static int __init memory_tier_late_init(void)
> +{
> +	int nid;
> +
> +	mutex_lock(&memory_tier_lock);
> +	for_each_node_state(nid, N_MEMORY)
> +		if (!node_state(nid, N_CPU) &&

It appears that you didn't notice my comments about this...

https://lore.kernel.org/linux-mm/87v857kujp.fsf@yhuang6-desk2.ccr.corp.intel.com/

> +			node_memory_types[nid].memtype == NULL)
> +			/*
> +			 * Some device drivers may have initialized memory tiers
> +			 * between `memory_tier_init()` and `memory_tier_late_init()`,
> +			 * potentially bringing online memory nodes and
> +			 * configuring memory tiers. Exclude them here.
> +			 */
> +			set_node_memory_tier(nid);
> +
> +	establish_demotion_targets();
> +	mutex_unlock(&memory_tier_lock);
> +
> +	return 0;
> +}
> +late_initcall(memory_tier_late_init);
> +
>  static void dump_hmem_attrs(struct access_coordinate *coord, const char *prefix)
>  {
>  	pr_info(
> @@ -668,7 +713,7 @@ int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
>  {
>  	int rc = 0;
>  
> -	mutex_lock(&memory_tier_lock);
> +	mutex_lock(&default_dram_perf_lock);
>  	if (default_dram_perf_error) {
>  		rc = -EIO;
>  		goto out;
> @@ -716,23 +761,30 @@ int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
>  	}
>  
>  out:
> -	mutex_unlock(&memory_tier_lock);
> +	mutex_unlock(&default_dram_perf_lock);
>  	return rc;
>  }
>  
>  int mt_perf_to_adistance(struct access_coordinate *perf, int *adist)
>  {
> -	if (default_dram_perf_error)
> -		return -EIO;
> +	int rc = 0;
>  
> -	if (default_dram_perf_ref_nid == NUMA_NO_NODE)
> -		return -ENOENT;
> +	mutex_lock(&default_dram_perf_lock);
> +	if (default_dram_perf_error) {
> +		rc = -EIO;
> +		goto out;
> +	}
>  
>  	if (perf->read_latency + perf->write_latency == 0 ||
> -	    perf->read_bandwidth + perf->write_bandwidth == 0)
> -		return -EINVAL;
> +	    perf->read_bandwidth + perf->write_bandwidth == 0) {
> +		rc = -EINVAL;
> +		goto out;
> +	}
>  
> -	mutex_lock(&memory_tier_lock);
> +	if (default_dram_perf_ref_nid == NUMA_NO_NODE) {
> +		rc = -ENOENT;
> +		goto out;
> +	}
>  	/*
>  	 * The abstract distance of a memory node is in direct proportion to
>  	 * its memory latency (read + write) and inversely proportional to its
> @@ -745,8 +797,9 @@ int mt_perf_to_adistance(struct access_coordinate *perf, int *adist)
>  		(default_dram_perf.read_latency + default_dram_perf.write_latency) *
>  		(default_dram_perf.read_bandwidth + default_dram_perf.write_bandwidth) /
>  		(perf->read_bandwidth + perf->write_bandwidth);
> -	mutex_unlock(&memory_tier_lock);
>  
> +out:
> +	mutex_unlock(&default_dram_perf_lock);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(mt_perf_to_adistance);
> @@ -858,7 +911,8 @@ static int __init memory_tier_init(void)
>  	 * For now we can have 4 faster memory tiers with smaller adistance
>  	 * than default DRAM tier.
>  	 */
> -	default_dram_type = alloc_memory_type(MEMTIER_ADISTANCE_DRAM);
> +	default_dram_type = mt_find_alloc_memory_type(MEMTIER_ADISTANCE_DRAM,
> +									&default_memory_types);
>  	if (IS_ERR(default_dram_type))
>  		panic("%s() failed to allocate default DRAM tier\n", __func__);
>  
> @@ -868,6 +922,14 @@ static int __init memory_tier_init(void)
>  	 * types assigned.
>  	 */
>  	for_each_node_state(node, N_MEMORY) {
> +		if (!node_state(node, N_CPU))
> +			/*
> +			 * Defer memory tier initialization on CPUless numa nodes.
> +			 * These will be initialized after firmware and devices are
> +			 * initialized.
> +			 */
> +			continue;
> +
>  		memtier = set_node_memory_tier(node);
>  		if (IS_ERR(memtier))
>  			/*

--
Best Regards,
Huang, Ying

