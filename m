Return-Path: <linux-kernel+bounces-130248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEC68975E8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0762F1C26DAB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA986E60F;
	Wed,  3 Apr 2024 17:04:34 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AE61B7F4;
	Wed,  3 Apr 2024 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712163873; cv=none; b=aTiwTaFaFY37TBnRQoUOG70BL4jA3ZsZzNZoGeUk7Gxr6irrECvvg4oQ7KqfV3Gxx/49QB/PiqnxtIzH+D97HgeyacJB1p/aos5VZ74huWd57EYXYdeh/Eh0HC1c/cqdBHRy/3LbosBwwjlZAGmlZhrj+WcoEUyIra+6fo7k+IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712163873; c=relaxed/simple;
	bh=azqNcTPpDk+LqX+JMJlzsNb8PpUCl7Tuk+sbvKdjO2Q=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eOaaWjMKacLz7VfTVqpGOqzAHoNtJNnQyA7bsbLnDrx5SJZJBTyLUok7mQTJGnv7pPJyiLOxUl0TX8rJ7edmBdklqGjW/Lt8Ew6QOasT7nBwuwcVvWCZn/EZk3DMYsgN+GSHnDibk+QBpLE4BxZPtfH5l+u/ptGWYpH9dY75ptQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V8rfg1yVsz6D8Yh;
	Thu,  4 Apr 2024 01:03:07 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 1B8041400D7;
	Thu,  4 Apr 2024 01:04:27 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 3 Apr
 2024 18:04:26 +0100
Date: Wed, 3 Apr 2024 18:04:25 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
CC: "Huang, Ying" <ying.huang@intel.com>, Gregory Price
	<gourry.memverge@gmail.com>, <aneesh.kumar@linux.ibm.com>, <mhocko@suse.com>,
	<tj@kernel.org>, <john@jagalactic.com>, Eishan Mirakhur
	<emirakhur@micron.com>, Vinicius Tavares Petrucci <vtavarespetr@micron.com>,
	Ravis OpenSrc <Ravis.OpenSrc@micron.com>, Alistair Popple
	<apopple@nvidia.com>, Srinivasulu Thanneeru <sthanneeru@micron.com>, SeongJae
 Park <sj@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, "Dave Jiang" <dave.jiang@intel.com>, Andrew
 Morton <akpm@linux-foundation.org>, <nvdimm@lists.linux.dev>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, "Ho-Ren (Jack) Chuang" <horenc@vt.edu>, "Ho-Ren (Jack)
 Chuang" <horenchuang@gmail.com>, <qemu-devel@nongnu.org>, Hao Xiang
	<hao.xiang@bytedance.com>
Subject: Re: [PATCH v10 2/2] memory tier: create CPUless memory tiers after
 obtaining HMAT info
Message-ID: <20240403180425.00003be0@Huawei.com>
In-Reply-To: <20240402001739.2521623-3-horenchuang@bytedance.com>
References: <20240402001739.2521623-1-horenchuang@bytedance.com>
	<20240402001739.2521623-3-horenchuang@bytedance.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

A few minor comments inline.

> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> index a44c03c2ba3a..16769552a338 100644
> --- a/include/linux/memory-tiers.h
> +++ b/include/linux/memory-tiers.h
> @@ -140,12 +140,13 @@ static inline int mt_perf_to_adistance(struct access_coordinate *perf, int *adis
>  	return -EIO;
>  }
>  
> -struct memory_dev_type *mt_find_alloc_memory_type(int adist, struct list_head *memory_types)
> +static inline struct memory_dev_type *mt_find_alloc_memory_type(int adist,
> +					struct list_head *memory_types)
>  {
>  	return NULL;
>  }
>  
> -void mt_put_memory_types(struct list_head *memory_types)
> +static inline void mt_put_memory_types(struct list_head *memory_types)
>  {
Why in this patch and not previous one?
>  
>  }
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index 974af10cfdd8..44fa10980d37 100644
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

Does the rename add anything major to the patch?
If not I'd leave it alone to reduce the churn and give
a more readable patch.  If it is worth doing perhaps
a precursor patch?

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
> @@ -655,6 +672,33 @@ void mt_put_memory_types(struct list_head *memory_types)
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
> +		if (node_memory_types[nid].memtype == NULL)
> +			/*
> +			 * Some device drivers may have initialized memory tiers
> +			 * between `memory_tier_init()` and `memory_tier_late_init()`,
> +			 * potentially bringing online memory nodes and
> +			 * configuring memory tiers. Exclude them here.
> +			 */

Does the comment refer to this path, or to ones where memtype is set?

> +			set_node_memory_tier(nid);

Given the large comment I would add {} to help with readability.
You could flip the logic to reduce indent
	for_each_node_state(nid, N_MEMORY) {
		if (node_memory_types[nid].memtype)
			continue;
		/*
		 * Some device drivers may have initialized memory tiers
		 * between `memory_tier_init()` and `memory_tier_late_init()`,
		 * potentially bringing online memory nodes and
		 * configuring memory tiers. Exclude them here.
		 */
		set_node_memory_tier(nid);


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
> @@ -668,7 +712,7 @@ int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
>  {
>  	int rc = 0;
>  
> -	mutex_lock(&memory_tier_lock);
> +	mutex_lock(&default_dram_perf_lock);

As below, this is a classic case where guard() will help readability.

>  	if (default_dram_perf_error) {
>  		rc = -EIO;
>  		goto out;
> @@ -716,23 +760,30 @@ int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
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

Looks like rc is set in all paths that reach where it isused.

>  
> -	if (default_dram_perf_ref_nid == NUMA_NO_NODE)
> -		return -ENOENT;
> +	mutex_lock(&default_dram_perf_lock);

This would benefit quite a lot from
guard(mutex)(&default_dram_perf_lock);
and direct returns throughout.


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
> @@ -745,9 +796,10 @@ int mt_perf_to_adistance(struct access_coordinate *perf, int *adist)
>  		(default_dram_perf.read_latency + default_dram_perf.write_latency) *
>  		(default_dram_perf.read_bandwidth + default_dram_perf.write_bandwidth) /
>  		(perf->read_bandwidth + perf->write_bandwidth);
> -	mutex_unlock(&memory_tier_lock);
>  
> -	return 0;
> +out:
> +	mutex_unlock(&default_dram_perf_lock);
> +	return rc;
>  }
>  EXPORT_SYMBOL_GPL(mt_perf_to_adistance);
>  
> @@ -858,7 +910,8 @@ static int __init memory_tier_init(void)
>  	 * For now we can have 4 faster memory tiers with smaller adistance
>  	 * than default DRAM tier.
>  	 */
> -	default_dram_type = alloc_memory_type(MEMTIER_ADISTANCE_DRAM);
> +	default_dram_type = mt_find_alloc_memory_type(MEMTIER_ADISTANCE_DRAM,
> +									&default_memory_types);

Unusual indenting.  Align with just after (

>  	if (IS_ERR(default_dram_type))
>  		panic("%s() failed to allocate default DRAM tier\n", __func__);
>  
> @@ -868,6 +921,14 @@ static int __init memory_tier_init(void)
>  	 * types assigned.
>  	 */
>  	for_each_node_state(node, N_MEMORY) {
> +		if (!node_state(node, N_CPU))
> +			/*
> +			 * Defer memory tier initialization on CPUless numa nodes.
> +			 * These will be initialized after firmware and devices are

I think this wraps at just over 80 chars.  Seems silly to wrap so tightly and not
quite fit under 80. (this is about 83 chars.

> +			 * initialized.
> +			 */
> +			continue;
> +
>  		memtier = set_node_memory_tier(node);
>  		if (IS_ERR(memtier))
>  			/*


