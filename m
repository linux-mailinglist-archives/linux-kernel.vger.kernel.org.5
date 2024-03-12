Return-Path: <linux-kernel+bounces-100018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B46018790DB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8B7D1C21F47
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D637779DD9;
	Tue, 12 Mar 2024 09:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eyBmgX04"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE6477F2C;
	Tue, 12 Mar 2024 09:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235282; cv=none; b=gN/ZKg9qUSgX0simGEfiJ1xjgBFLz+ioKfxb7GMfn/EdtkJ29fWNPktvlPRJfdSkQjPN3sXydUFzt4OhpjU+pUAXSigYExurFr95D+xeBIaIupNuuC8cbS5Q+QKkntYcSqrAltjGGx4Z/9oAv7+NEhwh0+lxvk2VwATbLl0vFM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235282; c=relaxed/simple;
	bh=4GCwzfGbTS24EMO9wkYt9MaMxJ9FDXPxqe6Ri3RZJG4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dPASjNS4MGD7ClcRTZkVwnsDUdLf5o0w58VDOoij9yvpfChSDR2u4ZqAvytViVOC36XJroCcaEGjikYMn51BfucIja+koZh5xumfMdrXCeaXEKg1NNHCL5OhTGD4ARhUgYX5sJ/Lh76zYKyA9Cx/avdLbSaBuXuOj/5a1pmaCDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eyBmgX04; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710235281; x=1741771281;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=4GCwzfGbTS24EMO9wkYt9MaMxJ9FDXPxqe6Ri3RZJG4=;
  b=eyBmgX04mwU0S7Is9KXI70n1cHWNCQsW6t9H8oQ67lTOjjJsSfUNOeVy
   tfHQzrQju2wzV/Cd+slpIIAFRsHp+VBRf1OpOWn1XOPvwBuvKVsXOX6Y2
   D2W5VVlrx1HyJnYuUjKuwSbNb1NjhKXW2D0lf1wZmeb3tV6mRNEywqMcG
   OfccknTLF5EWlICMbmeDvKkUQZapk9WRe4uQeWTjmJvl9TGQdN2ZbliTx
   XHZ1fRi/S2d28R+Cqd3ODPv8+GC5TOXcOi52NN18Zr9Dr7cL2Bp+KBQe1
   wtNk+lk6yyLFdJZL4cHn2THc7zCg0nFb4xINqRKl2ajvhcCFfpM2coPdW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="16373638"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="16373638"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 02:21:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="11905406"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 02:21:14 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Cc: "Gregory Price" <gourry.memverge@gmail.com>,
  aneesh.kumar@linux.ibm.com,  mhocko@suse.com,  tj@kernel.org,
  john@jagalactic.com,  "Eishan Mirakhur" <emirakhur@micron.com>,
  "Vinicius Tavares Petrucci" <vtavarespetr@micron.com>,  "Ravis OpenSrc"
 <Ravis.OpenSrc@micron.com>,  "Alistair Popple" <apopple@nvidia.com>,
  "Rafael J. Wysocki" <rafael@kernel.org>,  Len Brown <lenb@kernel.org>,
  Dan Williams <dan.j.williams@intel.com>,  Vishal Verma
 <vishal.l.verma@intel.com>,  Dave Jiang <dave.jiang@intel.com>,  Andrew
 Morton <akpm@linux-foundation.org>,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  linux-acpi@vger.kernel.org,
  linux-kernel@vger.kernel.org,  nvdimm@lists.linux.dev,
  linux-cxl@vger.kernel.org,  linux-mm@kvack.org,  "Ho-Ren (Jack) Chuang"
 <horenc@vt.edu>,  "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>,
  qemu-devel@nongnu.org,  Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [PATCH v2 1/1] memory tier: acpi/hmat: create CPUless memory
 tiers after obtaining HMAT info
In-Reply-To: <20240312061729.1997111-2-horenchuang@bytedance.com> (Ho-Ren
	Chuang's message of "Tue, 12 Mar 2024 06:17:27 +0000")
References: <20240312061729.1997111-1-horenchuang@bytedance.com>
	<20240312061729.1997111-2-horenchuang@bytedance.com>
Date: Tue, 12 Mar 2024 17:19:19 +0800
Message-ID: <874jdb4xk8.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
> * Abstract common functions into `find_alloc_memory_type()`

We should move kmem_put_memory_types() (renamed to
mt_put_memory_types()?) too.  This can be put in a separate patch.

> Since different memory devices require finding or allocating a memory type,
> these common steps are abstracted into a single function,
> `find_alloc_memory_type()`, enhancing code scalability and conciseness.
>
> * Handle cases where there is no HMAT when creating memory tiers
> There is a scenario where a CPUless node does not provide HMAT information.
> If no HMAT is specified, it falls back to using the default DRAM tier.
>
> * Change adist calculation code to use another new lock, mt_perf_lock.
> In the current implementation, iterating through CPUlist nodes requires
> holding the `memory_tier_lock`. However, `mt_calc_adistance()` will end up
> trying to acquire the same lock, leading to a potential deadlock.
> Therefore, we propose introducing a standalone `mt_perf_lock` to protect
> `default_dram_perf`. This approach not only avoids deadlock but also
> prevents holding a large lock simultaneously.
>
> Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> ---
>  drivers/acpi/numa/hmat.c     | 11 ++++++
>  drivers/dax/kmem.c           | 13 +------
>  include/linux/acpi.h         |  6 ++++
>  include/linux/memory-tiers.h |  8 +++++
>  mm/memory-tiers.c            | 70 +++++++++++++++++++++++++++++++++---
>  5 files changed, 92 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index d6b85f0f6082..28812ec2c793 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -38,6 +38,8 @@ static LIST_HEAD(targets);
>  static LIST_HEAD(initiators);
>  static LIST_HEAD(localities);
>  
> +static LIST_HEAD(hmat_memory_types);
> +

HMAT isn't a device driver for some memory devices.  So I don't think we
should manage memory types in HMAT.  Instead, if the memory_type of a
node isn't set by the driver, we should manage it in memory-tier.c as
fallback.

>  static DEFINE_MUTEX(target_lock);
>  
>  /*
> @@ -149,6 +151,12 @@ int acpi_get_genport_coordinates(u32 uid,
>  }
>  EXPORT_SYMBOL_NS_GPL(acpi_get_genport_coordinates, CXL);
>  
> +struct memory_dev_type *hmat_find_alloc_memory_type(int adist)
> +{
> +	return find_alloc_memory_type(adist, &hmat_memory_types);
> +}
> +EXPORT_SYMBOL_GPL(hmat_find_alloc_memory_type);
> +
>  static __init void alloc_memory_initiator(unsigned int cpu_pxm)
>  {
>  	struct memory_initiator *initiator;
> @@ -1038,6 +1046,9 @@ static __init int hmat_init(void)
>  	if (!hmat_set_default_dram_perf())
>  		register_mt_adistance_algorithm(&hmat_adist_nb);
>  
> +	/* Post-create CPUless memory tiers after getting HMAT info */
> +	memory_tier_late_init();
> +

This should be called in memory-tier.c via

late_initcall(memory_tier_late_init);

Then, we don't need hmat to call it.

>  	return 0;
>  out_put:
>  	hmat_free_structures();
> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index 42ee360cf4e3..aee17ab59f4f 100644
> --- a/drivers/dax/kmem.c
> +++ b/drivers/dax/kmem.c
> @@ -55,21 +55,10 @@ static LIST_HEAD(kmem_memory_types);
>  
>  static struct memory_dev_type *kmem_find_alloc_memory_type(int adist)
>  {
> -	bool found = false;
>  	struct memory_dev_type *mtype;
>  
>  	mutex_lock(&kmem_memory_type_lock);
> -	list_for_each_entry(mtype, &kmem_memory_types, list) {
> -		if (mtype->adistance == adist) {
> -			found = true;
> -			break;
> -		}
> -	}
> -	if (!found) {
> -		mtype = alloc_memory_type(adist);
> -		if (!IS_ERR(mtype))
> -			list_add(&mtype->list, &kmem_memory_types);
> -	}
> +	mtype = find_alloc_memory_type(adist, &kmem_memory_types);
>  	mutex_unlock(&kmem_memory_type_lock);
>  
>  	return mtype;
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index b7165e52b3c6..3f927ff01f02 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -434,12 +434,18 @@ int thermal_acpi_critical_trip_temp(struct acpi_device *adev, int *ret_temp);
>  
>  #ifdef CONFIG_ACPI_HMAT
>  int acpi_get_genport_coordinates(u32 uid, struct access_coordinate *coord);
> +struct memory_dev_type *hmat_find_alloc_memory_type(int adist);
>  #else
>  static inline int acpi_get_genport_coordinates(u32 uid,
>  					       struct access_coordinate *coord)
>  {
>  	return -EOPNOTSUPP;
>  }
> +
> +static inline struct memory_dev_type *hmat_find_alloc_memory_type(int adist)
> +{
> +	return NULL;
> +}
>  #endif
>  
>  #ifdef CONFIG_ACPI_NUMA
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> index 69e781900082..4bc2596c5774 100644
> --- a/include/linux/memory-tiers.h
> +++ b/include/linux/memory-tiers.h
> @@ -48,6 +48,9 @@ int mt_calc_adistance(int node, int *adist);
>  int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
>  			     const char *source);
>  int mt_perf_to_adistance(struct access_coordinate *perf, int *adist);
> +struct memory_dev_type *find_alloc_memory_type(int adist,
> +							struct list_head *memory_types);
> +void memory_tier_late_init(void);
>  #ifdef CONFIG_MIGRATION
>  int next_demotion_node(int node);
>  void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
> @@ -136,5 +139,10 @@ static inline int mt_perf_to_adistance(struct access_coordinate *perf, int *adis
>  {
>  	return -EIO;
>  }
> +
> +static inline void memory_tier_late_init(void)
> +{
> +
> +}
>  #endif	/* CONFIG_NUMA */
>  #endif  /* _LINUX_MEMORY_TIERS_H */
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index 0537664620e5..79f748d60e6f 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -6,6 +6,7 @@
>  #include <linux/memory.h>
>  #include <linux/memory-tiers.h>
>  #include <linux/notifier.h>
> +#include <linux/acpi.h>
>  
>  #include "internal.h"
>  
> @@ -35,6 +36,7 @@ struct node_memory_type_map {
>  };
>  
>  static DEFINE_MUTEX(memory_tier_lock);
> +static DEFINE_MUTEX(mt_perf_lock);

Please add comments about what it protects.  And put it near the data
structure it protects.

>  static LIST_HEAD(memory_tiers);
>  static struct node_memory_type_map node_memory_types[MAX_NUMNODES];
>  struct memory_dev_type *default_dram_type;
> @@ -623,6 +625,58 @@ void clear_node_memory_type(int node, struct memory_dev_type *memtype)
>  }
>  EXPORT_SYMBOL_GPL(clear_node_memory_type);
>  
> +struct memory_dev_type *find_alloc_memory_type(int adist, struct list_head *memory_types)
> +{
> +	bool found = false;
> +	struct memory_dev_type *mtype;
> +
> +	list_for_each_entry(mtype, memory_types, list) {
> +		if (mtype->adistance == adist) {
> +			found = true;
> +			break;
> +		}
> +	}
> +	if (!found) {
> +		mtype = alloc_memory_type(adist);
> +		if (!IS_ERR(mtype))
> +			list_add(&mtype->list, memory_types);
> +	}
> +
> +	return mtype;
> +}
> +EXPORT_SYMBOL_GPL(find_alloc_memory_type);
> +
> +static void memory_tier_late_create(int node)
> +{
> +	struct memory_dev_type *mtype = NULL;
> +	int adist = MEMTIER_ADISTANCE_DRAM;
> +
> +	mt_calc_adistance(node, &adist);
> +	if (adist != MEMTIER_ADISTANCE_DRAM) {

We can manage default_dram_type() via find_alloc_memory_type()
too.

And, if "node_memory_types[node].memtype == NULL", we can call
mt_calc_adistance(node, &adist) and find_alloc_memory_type() in
set_node_memory_tier().  Then, we can cover hotpluged memory node too.

> +		mtype = hmat_find_alloc_memory_type(adist);
> +		if (!IS_ERR(mtype))
> +			__init_node_memory_type(node, mtype);
> +		else
> +			pr_err("Failed to allocate a memory type at %s()\n", __func__);
> +	}
> +
> +	set_node_memory_tier(node);
> +}
> +
> +void memory_tier_late_init(void)
> +{
> +	int nid;
> +
> +	mutex_lock(&memory_tier_lock);
> +	for_each_node_state(nid, N_MEMORY)
> +		if (!node_state(nid, N_CPU))

We should exclude "node_memory_types[nid].memtype != NULL".  Some memory
nodes may be onlined by some device drivers and setup memory tiers
already.

> +			memory_tier_late_create(nid);
> +
> +	establish_demotion_targets();
> +	mutex_unlock(&memory_tier_lock);
> +}
> +EXPORT_SYMBOL_GPL(memory_tier_late_init);
> +
>  static void dump_hmem_attrs(struct access_coordinate *coord, const char *prefix)
>  {
>  	pr_info(
> @@ -636,7 +690,7 @@ int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
>  {
>  	int rc = 0;
>  
> -	mutex_lock(&memory_tier_lock);
> +	mutex_lock(&mt_perf_lock);
>  	if (default_dram_perf_error) {
>  		rc = -EIO;
>  		goto out;
> @@ -684,7 +738,7 @@ int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
>  	}
>  
>  out:
> -	mutex_unlock(&memory_tier_lock);
> +	mutex_unlock(&mt_perf_lock);
>  	return rc;
>  }
>  
> @@ -700,7 +754,7 @@ int mt_perf_to_adistance(struct access_coordinate *perf, int *adist)
>  	    perf->read_bandwidth + perf->write_bandwidth == 0)
>  		return -EINVAL;
>  
> -	mutex_lock(&memory_tier_lock);
> +	mutex_lock(&mt_perf_lock);
>  	/*
>  	 * The abstract distance of a memory node is in direct proportion to
>  	 * its memory latency (read + write) and inversely proportional to its
> @@ -713,7 +767,7 @@ int mt_perf_to_adistance(struct access_coordinate *perf, int *adist)
>  		(default_dram_perf.read_latency + default_dram_perf.write_latency) *
>  		(default_dram_perf.read_bandwidth + default_dram_perf.write_bandwidth) /
>  		(perf->read_bandwidth + perf->write_bandwidth);
> -	mutex_unlock(&memory_tier_lock);
> +	mutex_unlock(&mt_perf_lock);
>  
>  	return 0;
>  }
> @@ -836,6 +890,14 @@ static int __init memory_tier_init(void)
>  	 * types assigned.
>  	 */
>  	for_each_node_state(node, N_MEMORY) {
> +		if (!node_state(node, N_CPU))
> +			/*
> +			 * Defer memory tier initialization on CPUless numa nodes.
> +			 * These will be initialized when HMAT information is

HMAT is platform specific, we should avoid to mention it in general code
if possible.

> +			 * available.
> +			 */
> +			continue;
> +
>  		memtier = set_node_memory_tier(node);
>  		if (IS_ERR(memtier))
>  			/*

--
Best Regards,
Huang, Ying

