Return-Path: <linux-kernel+bounces-120347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F29C488D616
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30E142A6465
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2FF1CAAF;
	Wed, 27 Mar 2024 05:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PVvSXPPw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7FB1CD18;
	Wed, 27 Mar 2024 05:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711518754; cv=none; b=M6W2vh4RhE+VPd2lgXnlLI0TzYljxai3wS041Ii7xAWKeMwzCwB2R/1al3kxW3NJaadVeNYux/S2AUUmAP6KoBtJYV3bgDPhxmBVeN4EatoVeeJll0ES3sb1CB7gPgQaC+UOzHlo6m7E9/85TE3/Os96MKx6MP3Kppvm/HGIIIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711518754; c=relaxed/simple;
	bh=8I1UH/rkKDL/ZnyryRvPe87zpb54lxeFGn61pTVax28=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hIFw+ak+RNDzwKENSE0ZvQw9AvJaRnV1Bcy0/82poU6npZWfWvabvO1Z/uNOzIexD5SPK5XsxBrFc883jUNHu5/4sEst1v5LxppVGtkZUP8pFZpQHMqQLatedGCSWv4KqnFWPFqc5Bkuxa+TimgIS8co3EBpNbRSHWS8wwOhqeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PVvSXPPw; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711518753; x=1743054753;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=8I1UH/rkKDL/ZnyryRvPe87zpb54lxeFGn61pTVax28=;
  b=PVvSXPPw/cFTaT0ojzTc2v54M27kxVDTPvldsPDOT3Tr+MMtW2r1LYwf
   aPgNo/QN/JjlftnaFKcamC2JJ1TP0LJ13YJSbs6W9C5TSnyQV8z0grZzh
   ptCGcaJzgxmngOFbVShP78J7c32iwO3Ylu3UC2GIQf+uNW2z2aE/C4zqk
   gGp0mGUQ+MQIsb4GPwiA1rGKuvtfCw54+Hbo5hK5rAivn+6MQ2yvtmm18
   IagcnaNx/GaVk5w5mcbOgIYseYwna/Fye9kUiDXknBzFyIrrd+EQOzZ6A
   HZ9flE0wf74k+GDWaV6rcZc3u7oj++hRVr4NuokFAsy83J9racw4eU5bN
   g==;
X-CSE-ConnectionGUID: VbdRz39nT/G/IpAJnLbN1Q==
X-CSE-MsgGUID: sNOU4J2wSAGQLCeS7E7HrQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6788890"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="6788890"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 22:52:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="20669703"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 22:52:26 -0700
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
Subject: Re: [PATCH v5 2/2] memory tier: create CPUless memory tiers after
 obtaining HMAT info
In-Reply-To: <20240327041646.3258110-3-horenchuang@bytedance.com> (Ho-Ren
	Chuang's message of "Wed, 27 Mar 2024 04:16:46 +0000")
References: <20240327041646.3258110-1-horenchuang@bytedance.com>
	<20240327041646.3258110-3-horenchuang@bytedance.com>
Date: Wed, 27 Mar 2024 13:50:32 +0800
Message-ID: <874jcsnryv.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
> but also prevents holding a large lock simultaneously. Besides, this patch
> slightly shortens the time holding the lock by putting the lock closer to
> what it protects as well.
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
> * Fix a deadlock bug in `mt_perf_to_adistance`
> Because an error path was not handled properly in `mt_perf_to_adistance`,
> unlock before returning the error.
>
> Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> ---
>  mm/memory-tiers.c | 85 +++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 72 insertions(+), 13 deletions(-)
>
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index 974af10cfdd8..610db9581ba4 100644
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
>  
> -	memtype = node_memory_types[node].memtype;
> -	node_set(node, memtype->nodes);
> -	memtier = find_create_memory_tier(memtype);
> +	__init_node_memory_type(node, mtype);
> +
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
> @@ -668,7 +713,6 @@ int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
>  {
>  	int rc = 0;
>  
> -	mutex_lock(&memory_tier_lock);
>  	if (default_dram_perf_error) {
>  		rc = -EIO;
>  		goto out;
> @@ -680,6 +724,7 @@ int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
>  		goto out;
>  	}
>  
> +	mutex_lock(&default_dram_perf_lock);

Why do you move the position of locking?  mutex_lock/unlock() will be
unbalance for error path above.

>  	if (default_dram_perf_ref_nid == NUMA_NO_NODE) {
>  		default_dram_perf = *perf;
>  		default_dram_perf_ref_nid = nid;
> @@ -716,23 +761,26 @@ int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
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
> +	int rc = 0;
> +
>  	if (default_dram_perf_error)
>  		return -EIO;
>  
> -	if (default_dram_perf_ref_nid == NUMA_NO_NODE)
> -		return -ENOENT;
> -
>  	if (perf->read_latency + perf->write_latency == 0 ||
>  	    perf->read_bandwidth + perf->write_bandwidth == 0)
>  		return -EINVAL;
>  
> -	mutex_lock(&memory_tier_lock);
> +	mutex_lock(&default_dram_perf_lock);

It may be a little better to move lock position at the begin of the
function.  This will not avoid race condition (not harmful in practice)
but it will make code easier to be understood.

> +	if (default_dram_perf_ref_nid == NUMA_NO_NODE) {
> +		rc = -ENOENT;
> +		goto out;
> +	}
>  	/*
>  	 * The abstract distance of a memory node is in direct proportion to
>  	 * its memory latency (read + write) and inversely proportional to its
> @@ -745,8 +793,10 @@ int mt_perf_to_adistance(struct access_coordinate *perf, int *adist)
>  		(default_dram_perf.read_latency + default_dram_perf.write_latency) *
>  		(default_dram_perf.read_bandwidth + default_dram_perf.write_bandwidth) /
>  		(perf->read_bandwidth + perf->write_bandwidth);
> -	mutex_unlock(&memory_tier_lock);
> +	mutex_unlock(&default_dram_perf_lock);
>  
> +out:
> +	mutex_unlock(&default_dram_perf_lock);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(mt_perf_to_adistance);
> @@ -858,7 +908,8 @@ static int __init memory_tier_init(void)
>  	 * For now we can have 4 faster memory tiers with smaller adistance
>  	 * than default DRAM tier.
>  	 */
> -	default_dram_type = alloc_memory_type(MEMTIER_ADISTANCE_DRAM);
> +	default_dram_type = mt_find_alloc_memory_type(MEMTIER_ADISTANCE_DRAM,
> +									&default_memory_types);
>  	if (IS_ERR(default_dram_type))
>  		panic("%s() failed to allocate default DRAM tier\n", __func__);
>  
> @@ -868,6 +919,14 @@ static int __init memory_tier_init(void)
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

