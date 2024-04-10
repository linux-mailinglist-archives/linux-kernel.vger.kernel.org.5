Return-Path: <linux-kernel+bounces-137800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E8B89E7D2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 03:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDAFEB22977
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D7C17FD;
	Wed, 10 Apr 2024 01:30:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C875A5F;
	Wed, 10 Apr 2024 01:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712712602; cv=none; b=Y/j4+sddqFNTSc1FvTdJ/fC6zIJcAf+38t3o7Q5h2jmd0jv+HfglDBv6hJPHwbSkEtUT9RlG195HxF/Hl0ToTZuN46qrdNTBuWWzCcgyTV6OpDM/IodLRnxJmViUFMoa6IbJSNT3cRxWh29cALWvYRZKOX9iIdmhDiqad/zlSrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712712602; c=relaxed/simple;
	bh=uHiFFSLsaidzauMwTuWuhmbVbMnJ0UgPuS4VYYB1YtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q5O3a17gZUwbQkPKRw/+3S1JyQ5Wdg6cKcxxDLs8FSTQuTnWRvz1XbgFAkjJVRZ1NzZxpZnMF5CMulp5LUy4HdgXz3wkYGtpO1gYwWCCWsbyWIf8l8b3Kzz6bYG17dwj8Cw4/cPUzlTv9qB+7xXnWSQ+2UgX6uPRzt6DXksLoGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53E40139F;
	Tue,  9 Apr 2024 18:30:28 -0700 (PDT)
Received: from [172.27.42.111] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE7793F6C4;
	Tue,  9 Apr 2024 18:29:57 -0700 (PDT)
Message-ID: <abd135fa-c432-4e37-9792-07a0e17e93d5@arm.com>
Date: Tue, 9 Apr 2024 20:29:57 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ACPI: PPTT: Populate cacheinfo entirely with PPTT
Content-Language: en-US
To: Yunhui Cui <cuiyunhui@bytedance.com>, rafael@kernel.org, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 linux-riscv@lists.infradead.org
References: <20240407123829.36474-1-cuiyunhui@bytedance.com>
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20240407123829.36474-1-cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,


First thanks for working on this.

On 4/7/24 07:38, Yunhui Cui wrote:
> When the type and level information of this_leaf cannot be obtained
> from arch, cacheinfo is completely filled in with the content of PPTT.

I started reviewing this, based on what I understood to be the need to 
generate the topology entirely from the PPTT. But, it was raising more 
questions than answers because the PPTT is far too flexable in its 
ability to represent cache hierachies that arn't logically useful. For 
example multiple I or D caches at the same level, or I or D caches 
higher in the topology than unified ones.

At least for arm64 (and I think others) there is an understood 
simplification that there will be N levels of split I/D caches and M 
unified levels. And from that, the number of cache leaves are computed 
and allocated, and then we go in and largly skip PPTT cache nodes which 
don't make sense in view of a generic topology like that. (see the 
comment in cacheinfo.c:506)

Both of those pieces of information are available in 
acpi_get_cache_info(). The missing part is marking those N levels of I/D 
cache as such.

Looking at this code I don't really see all the error/allocation 
logic/etc that assures the cache leaf indexing is allocated correctly 
which worries me, although admidditly I could be missing something 
important.

In summary, did you consider just allocating matching I/D caches from 
the number of split levels in acpi_get_cache_info() then removing or 
invalidating the ones that don't have matching PPTT entries after 
running cache_setup_acpi()? Thats a fairly trivial change AFAIK if the 
decision is based on the lack of a cache_id or just changing the 
this_leaf->type = CACHE_TYPE_UNIFIED assignment to the correct type and 
assuring left over CACHE_TYPE_NOCACHE entries are removed. I think much 
of the "significant work" is likely fixed for that to work. Just 
tweaking detect_cache_level()/get_cache_type() to set 
CACHE_TYPE_SEPERATE if the level is less than the acpi_get_cache_info() 
split_level value probably also does the majority of what you need 
outside of having unequal counts of I and D caches.

There are probably other choices as well, thoughts?


Thanks,







> 
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>   drivers/acpi/pptt.c | 135 ++++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 124 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index a35dd0e41c27..6c54fc8e3039 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -21,6 +21,9 @@
>   #include <linux/cacheinfo.h>
>   #include <acpi/processor.h>
>   
> +void acpi_fill_cacheinfo(struct acpi_pptt_cache *cache, struct acpi_table_header *table,
> +			 int cpu, int level, int *index);
> +
>   static struct acpi_subtable_header *fetch_pptt_subtable(struct acpi_table_header *table_hdr,
>   							u32 pptt_ref)
>   {
> @@ -77,6 +80,18 @@ static inline bool acpi_pptt_match_type(int table_type, int type)
>   		table_type & ACPI_PPTT_CACHE_TYPE_UNIFIED & type);
>   }
>   
> +static inline u32 get_cache_id(struct acpi_pptt_cache *cache)
> +{
> +	struct acpi_pptt_cache_v1 *cache_v1;
> +
> +	if (cache->flags & ACPI_PPTT_CACHE_ID_VALID) {
> +		cache_v1 = ACPI_ADD_PTR(struct acpi_pptt_cache_v1,
> +					cache, sizeof(struct acpi_pptt_cache));
> +		return cache_v1->cache_id;
> +	}
> +	return 0;
> +}
> +
>   /**
>    * acpi_pptt_walk_cache() - Attempt to find the requested acpi_pptt_cache
>    * @table_hdr: Pointer to the head of the PPTT table
> @@ -104,7 +119,7 @@ static unsigned int acpi_pptt_walk_cache(struct acpi_table_header *table_hdr,
>   					 unsigned int *split_levels,
>   					 struct acpi_subtable_header *res,
>   					 struct acpi_pptt_cache **found,
> -					 unsigned int level, int type)
> +					 unsigned int level, int type, int cpu, int *index)
>   {
>   	struct acpi_pptt_cache *cache;
>   
> @@ -125,7 +140,7 @@ static unsigned int acpi_pptt_walk_cache(struct acpi_table_header *table_hdr,
>   		     acpi_pptt_match_type(cache->attributes, ACPI_PPTT_CACHE_TYPE_INSTR)))
>   			*split_levels = local_level;
>   
> -		if (local_level == level &&
> +		if (level && local_level == level &&
>   		    acpi_pptt_match_type(cache->attributes, type)) {
>   			if (*found != NULL && cache != *found)
>   				pr_warn("Found duplicate cache level/type unable to determine uniqueness\n");
> @@ -137,7 +152,9 @@ static unsigned int acpi_pptt_walk_cache(struct acpi_table_header *table_hdr,
>   			 * to verify that we don't find a duplicate
>   			 * cache node.
>   			 */
> -		}
> +		} else
> +			acpi_fill_cacheinfo(cache, table_hdr, cpu, local_level, index);
> +
>   		cache = fetch_pptt_cache(table_hdr, cache->next_level_of_cache);
>   	}
>   	return local_level;
> @@ -147,7 +164,7 @@ static struct acpi_pptt_cache *
>   acpi_find_cache_level(struct acpi_table_header *table_hdr,
>   		      struct acpi_pptt_processor *cpu_node,
>   		      unsigned int *starting_level, unsigned int *split_levels,
> -		      unsigned int level, int type)
> +		      unsigned int level, int type, int cpu, int *index)
>   {
>   	struct acpi_subtable_header *res;
>   	unsigned int number_of_levels = *starting_level;
> @@ -161,7 +178,8 @@ acpi_find_cache_level(struct acpi_table_header *table_hdr,
>   
>   		local_level = acpi_pptt_walk_cache(table_hdr, *starting_level,
>   						   split_levels, res, &ret,
> -						   level, type);
> +						   level, type, cpu, index);
> +
>   		/*
>   		 * we are looking for the max depth. Since its potentially
>   		 * possible for a given node to have resources with differing
> @@ -197,7 +215,7 @@ static void acpi_count_levels(struct acpi_table_header *table_hdr,
>   			      unsigned int *levels, unsigned int *split_levels)
>   {
>   	do {
> -		acpi_find_cache_level(table_hdr, cpu_node, levels, split_levels, 0, 0);
> +		acpi_find_cache_level(table_hdr, cpu_node, levels, split_levels, 0, 0, 0, NULL);
>   		cpu_node = fetch_pptt_node(table_hdr, cpu_node->parent);
>   	} while (cpu_node);
>   }
> @@ -316,6 +334,7 @@ static u8 acpi_cache_type(enum cache_type type)
>   }
>   
>   static struct acpi_pptt_cache *acpi_find_cache_node(struct acpi_table_header *table_hdr,
> +						    int cpu,
>   						    u32 acpi_cpu_id,
>   						    enum cache_type type,
>   						    unsigned int level,
> @@ -325,6 +344,7 @@ static struct acpi_pptt_cache *acpi_find_cache_node(struct acpi_table_header *ta
>   	struct acpi_pptt_cache *found = NULL;
>   	struct acpi_pptt_processor *cpu_node;
>   	u8 acpi_type = acpi_cache_type(type);
> +	int index = 0;
>   
>   	pr_debug("Looking for CPU %d's level %u cache type %d\n",
>   		 acpi_cpu_id, level, acpi_type);
> @@ -333,7 +353,7 @@ static struct acpi_pptt_cache *acpi_find_cache_node(struct acpi_table_header *ta
>   
>   	while (cpu_node && !found) {
>   		found = acpi_find_cache_level(table_hdr, cpu_node,
> -					      &total_levels, NULL, level, acpi_type);
> +					      &total_levels, NULL, level, acpi_type, cpu, &index);
>   		*node = cpu_node;
>   		cpu_node = fetch_pptt_node(table_hdr, cpu_node->parent);
>   	}
> @@ -406,8 +426,14 @@ static void update_cache_properties(struct cacheinfo *this_leaf,
>   	 * specified in PPTT.
>   	 */
>   	if (this_leaf->type == CACHE_TYPE_NOCACHE &&
> -	    found_cache->flags & ACPI_PPTT_CACHE_TYPE_VALID)
> -		this_leaf->type = CACHE_TYPE_UNIFIED;
> +	    found_cache->flags & ACPI_PPTT_CACHE_TYPE_VALID) {
> +		if (acpi_pptt_match_type(found_cache->attributes, ACPI_PPTT_CACHE_TYPE_DATA))
> +			this_leaf->type = CACHE_TYPE_DATA;
> +		if (acpi_pptt_match_type(found_cache->attributes, ACPI_PPTT_CACHE_TYPE_INSTR))
> +			this_leaf->type = CACHE_TYPE_INST;
> +		if (acpi_pptt_match_type(found_cache->attributes, ACPI_PPTT_CACHE_TYPE_UNIFIED))
> +			this_leaf->type = CACHE_TYPE_UNIFIED;
> +	}
>   
>   	if (revision >= 3 && (found_cache->flags & ACPI_PPTT_CACHE_ID_VALID)) {
>   		found_cache_v1 = ACPI_ADD_PTR(struct acpi_pptt_cache_v1,
> @@ -417,19 +443,106 @@ static void update_cache_properties(struct cacheinfo *this_leaf,
>   	}
>   }
>   
> +static bool cache_is_filled_id(struct acpi_pptt_cache *cache, int cpu)
> +{
> +	u32 id = get_cache_id(cache);
> +	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
> +	struct cacheinfo *this_leaf;
> +	int index = 0;
> +
> +	while (index < get_cpu_cacheinfo(cpu)->num_leaves) {
> +		this_leaf = this_cpu_ci->info_list + index;
> +		if (this_leaf->id == id)
> +			return true;
> +		index++;
> +	}
> +	return false;
> +}
> +
> +static bool cache_is_filled_content(struct acpi_pptt_cache *cache,
> +				    struct acpi_table_header *table,
> +				    int cpu, int level, u8 revision)
> +{
> +	struct acpi_pptt_processor *cpu_node;
> +	struct cacheinfo *this_leaf, *tleaf;
> +	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
> +	struct cacheinfo tmp_leaf = {0};
> +	int index = 0;
> +
> +	cpu_node = acpi_find_processor_node(table, get_acpi_id_for_cpu(cpu));
> +	tleaf = &tmp_leaf;
> +	tleaf->level = level;
> +
> +	while (index < get_cpu_cacheinfo(cpu)->num_leaves) {
> +		this_leaf = this_cpu_ci->info_list + index;
> +		update_cache_properties(tleaf, cache,
> +					ACPI_TO_POINTER(ACPI_PTR_DIFF(cpu_node, table)),
> +					revision);
> +		if (!memcmp(this_leaf, tleaf, sizeof(struct cacheinfo)))
> +			return true;
> +		index++;
> +	}
> +	return false;
> +}
> +
> +static bool cache_is_filled(struct acpi_pptt_cache *cache, struct acpi_table_header *table,
> +				   int cpu, int level)
> +{
> +	u8 revision = table->revision;
> +
> +	/*
> +	 * If revision >= 3, compare the cacheid directly,
> +	 * otherwise compare the entire contents of the cache.
> +	 */
> +	if (revision >= 3)
> +		return cache_is_filled_id(cache, cpu);
> +	else
> +		return cache_is_filled_content(cache, table, cpu, level, revision);
> +}
> +
> +void acpi_fill_cacheinfo(struct acpi_pptt_cache *cache,
> +				struct acpi_table_header *table,
> +				int cpu, int level, int *index)
> +{
> +	struct cacheinfo *this_leaf;
> +	struct acpi_pptt_processor *cpu_node;
> +	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
> +
> +	if (!index)
> +		return;
> +
> +	cpu_node = acpi_find_processor_node(table, get_acpi_id_for_cpu(cpu));
> +	this_leaf = this_cpu_ci->info_list + *index;
> +	if (this_leaf) {
> +		this_leaf->level = level;
> +		if (cache_is_filled(cache, table, cpu, level))
> +			return;
> +		update_cache_properties(this_leaf, cache,
> +					ACPI_TO_POINTER(ACPI_PTR_DIFF(cpu_node,
> +							table)),
> +					table->revision);
> +		*index += 1;
> +	}
> +}
> +
>   static void cache_setup_acpi_cpu(struct acpi_table_header *table,
>   				 unsigned int cpu)
>   {
>   	struct acpi_pptt_cache *found_cache;
>   	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
>   	u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
> -	struct cacheinfo *this_leaf;
> +	struct cacheinfo *this_leaf = this_cpu_ci->info_list;
>   	unsigned int index = 0;
>   	struct acpi_pptt_processor *cpu_node = NULL;
>   
> +	if (!this_leaf->type && !this_leaf->level) {
> +		acpi_find_cache_node(table, acpi_cpu_id, cpu, 0, 0, &cpu_node);
> +		return;
> +	}
> +
>   	while (index < get_cpu_cacheinfo(cpu)->num_leaves) {
>   		this_leaf = this_cpu_ci->info_list + index;
> -		found_cache = acpi_find_cache_node(table, acpi_cpu_id,
> +		found_cache = acpi_find_cache_node(table, acpi_cpu_id, cpu,
>   						   this_leaf->type,
>   						   this_leaf->level,
>   						   &cpu_node);


