Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DFF760B1D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjGYHEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjGYHE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:04:26 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0707E66;
        Tue, 25 Jul 2023 00:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690268664; x=1721804664;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=z+bpg4f1Gpa03QOb988ceLF/hGx+yZITJmrLI5YMZc0=;
  b=mV4V4BRx+RTi1uEMSg3bPKnwinSmNjEmL4ORRzD0oEI+XnXZDHuQ8BFD
   46jz+mEo3Re7E6aEmJVZdi1qwbNiWFHrrrwHo7kvMWsnPDQkIEQ7jFlZC
   RdfuC/4MPWslsuywufuqBSarNbXGn3UGoIZYDCV+Q757T/SXA4pzxz2DL
   sSgyXpMThRm7UtojdvVjxJBbN9jO72/hzHSp1WNvvXxO0W70uWIUi4Irh
   nXQxSYS8CDzdV4TdRPFAqzhFylObFDA2xYxISPs5GfD6sWCTpXbOPAl4g
   6bP5blVvhMm+8xCu6k6gTlOZI467xxSJze/2PyM+U5F0kyN7ddRtx7H+U
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="431438957"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="431438957"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 00:04:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="719946762"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="719946762"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 00:04:19 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Wei Xu <weixugc@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH RESEND 4/4] dax, kmem: calculate abstract distance with
 general interface
References: <20230721012932.190742-1-ying.huang@intel.com>
        <20230721012932.190742-5-ying.huang@intel.com>
        <87edkwznsf.fsf@nvdebian.thelocal>
Date:   Tue, 25 Jul 2023 15:02:42 +0800
In-Reply-To: <87edkwznsf.fsf@nvdebian.thelocal> (Alistair Popple's message of
        "Tue, 25 Jul 2023 13:11:12 +1000")
Message-ID: <87cz0gxylp.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair Popple <apopple@nvidia.com> writes:

> Huang Ying <ying.huang@intel.com> writes:
>
>> Previously, a fixed abstract distance MEMTIER_DEFAULT_DAX_ADISTANCE is
>> used for slow memory type in kmem driver.  This limits the usage of
>> kmem driver, for example, it cannot be used for HBM (high bandwidth
>> memory).
>>
>> So, we use the general abstract distance calculation mechanism in kmem
>> drivers to get more accurate abstract distance on systems with proper
>> support.  The original MEMTIER_DEFAULT_DAX_ADISTANCE is used as
>> fallback only.
>>
>> Now, multiple memory types may be managed by kmem.  These memory types
>> are put into the "kmem_memory_types" list and protected by
>> kmem_memory_type_lock.
>
> See below but I wonder if kmem_memory_types could be a common helper
> rather than kdax specific?
>
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> Cc: Wei Xu <weixugc@google.com>
>> Cc: Alistair Popple <apopple@nvidia.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Dave Hansen <dave.hansen@intel.com>
>> Cc: Davidlohr Bueso <dave@stgolabs.net>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Cc: Yang Shi <shy828301@gmail.com>
>> Cc: Rafael J Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>  drivers/dax/kmem.c           | 54 +++++++++++++++++++++++++++---------
>>  include/linux/memory-tiers.h |  2 ++
>>  mm/memory-tiers.c            |  2 +-
>>  3 files changed, 44 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
>> index 898ca9505754..837165037231 100644
>> --- a/drivers/dax/kmem.c
>> +++ b/drivers/dax/kmem.c
>> @@ -49,14 +49,40 @@ struct dax_kmem_data {
>>  	struct resource *res[];
>>  };
>>  
>> -static struct memory_dev_type *dax_slowmem_type;
>> +static DEFINE_MUTEX(kmem_memory_type_lock);
>> +static LIST_HEAD(kmem_memory_types);
>> +
>> +static struct memory_dev_type *kmem_find_alloc_memorty_type(int adist)
>> +{
>> +	bool found = false;
>> +	struct memory_dev_type *mtype;
>> +
>> +	mutex_lock(&kmem_memory_type_lock);
>> +	list_for_each_entry(mtype, &kmem_memory_types, list) {
>> +		if (mtype->adistance == adist) {
>> +			found = true;
>> +			break;
>> +		}
>> +	}
>> +	if (!found) {
>> +		mtype = alloc_memory_type(adist);
>> +		if (!IS_ERR(mtype))
>> +			list_add(&mtype->list, &kmem_memory_types);
>> +	}
>> +	mutex_unlock(&kmem_memory_type_lock);
>> +
>> +	return mtype;
>> +}
>> +
>>  static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>  {
>>  	struct device *dev = &dev_dax->dev;
>>  	unsigned long total_len = 0;
>>  	struct dax_kmem_data *data;
>> +	struct memory_dev_type *mtype;
>>  	int i, rc, mapped = 0;
>>  	int numa_node;
>> +	int adist = MEMTIER_DEFAULT_DAX_ADISTANCE;
>>  
>>  	/*
>>  	 * Ensure good NUMA information for the persistent memory.
>> @@ -71,6 +97,11 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>  		return -EINVAL;
>>  	}
>>  
>> +	mt_calc_adistance(numa_node, &adist);
>> +	mtype = kmem_find_alloc_memorty_type(adist);
>> +	if (IS_ERR(mtype))
>> +		return PTR_ERR(mtype);
>> +
>
> I wrote my own quick and dirty module to test this and wrote basically
> the same code sequence.
>
> I notice your using a list of memory types here though. I think it would
> be nice to have a common helper that other users could call to do the
> mt_calc_adistance() / kmem_find_alloc_memory_type() /
> init_node_memory_type() sequence and cleanup as my naive approach would
> result in a new memory_dev_type per device even though adist might be
> the same. A common helper would make it easy to de-dup those.

If it's useful, we can move kmem_find_alloc_memory_type() to
memory-tier.c after some revision.  But I tend to move it after we have
the second user.  What do you think about that?

--
Best Regards,
Huang, Ying

>>  	for (i = 0; i < dev_dax->nr_range; i++) {
>>  		struct range range;
>>  
>> @@ -88,7 +119,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>  		return -EINVAL;
>>  	}
>>  
>> -	init_node_memory_type(numa_node, dax_slowmem_type);
>> +	init_node_memory_type(numa_node, mtype);
>>  
>>  	rc = -ENOMEM;
>>  	data = kzalloc(struct_size(data, res, dev_dax->nr_range), GFP_KERNEL);
>> @@ -167,7 +198,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>  err_res_name:
>>  	kfree(data);
>>  err_dax_kmem_data:
>> -	clear_node_memory_type(numa_node, dax_slowmem_type);
>> +	clear_node_memory_type(numa_node, mtype);
>>  	return rc;
>>  }
>>  
>> @@ -219,7 +250,7 @@ static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
>>  		 * for that. This implies this reference will be around
>>  		 * till next reboot.
>>  		 */
>> -		clear_node_memory_type(node, dax_slowmem_type);
>> +		clear_node_memory_type(node, NULL);
>>  	}
>>  }
>>  #else
>> @@ -251,12 +282,6 @@ static int __init dax_kmem_init(void)
>>  	if (!kmem_name)
>>  		return -ENOMEM;
>>  
>> -	dax_slowmem_type = alloc_memory_type(MEMTIER_DEFAULT_DAX_ADISTANCE);
>> -	if (IS_ERR(dax_slowmem_type)) {
>> -		rc = PTR_ERR(dax_slowmem_type);
>> -		goto err_dax_slowmem_type;
>> -	}
>> -
>>  	rc = dax_driver_register(&device_dax_kmem_driver);
>>  	if (rc)
>>  		goto error_dax_driver;
>> @@ -264,18 +289,21 @@ static int __init dax_kmem_init(void)
>>  	return rc;
>>  
>>  error_dax_driver:
>> -	destroy_memory_type(dax_slowmem_type);
>> -err_dax_slowmem_type:
>>  	kfree_const(kmem_name);
>>  	return rc;
>>  }
>>  
>>  static void __exit dax_kmem_exit(void)
>>  {
>> +	struct memory_dev_type *mtype, *mtn;
>> +
>>  	dax_driver_unregister(&device_dax_kmem_driver);
>>  	if (!any_hotremove_failed)
>>  		kfree_const(kmem_name);
>> -	destroy_memory_type(dax_slowmem_type);
>> +	list_for_each_entry_safe(mtype, mtn, &kmem_memory_types, list) {
>> +		list_del(&mtype->list);
>> +		destroy_memory_type(mtype);
>> +	}
>>  }
>>  
>>  MODULE_AUTHOR("Intel Corporation");
>> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
>> index 9377239c8d34..aca22220cb5c 100644
>> --- a/include/linux/memory-tiers.h
>> +++ b/include/linux/memory-tiers.h
>> @@ -24,6 +24,8 @@ struct memory_tier;
>>  struct memory_dev_type {
>>  	/* list of memory types that are part of same tier as this type */
>>  	struct list_head tier_sibiling;
>> +	/* list of memory types that are managed by one driver */
>> +	struct list_head list;
>>  	/* abstract distance for this specific memory type */
>>  	int adistance;
>>  	/* Nodes of same abstract distance */
>> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
>> index 9a734ef2edfb..38005c60fa2d 100644
>> --- a/mm/memory-tiers.c
>> +++ b/mm/memory-tiers.c
>> @@ -581,7 +581,7 @@ EXPORT_SYMBOL_GPL(init_node_memory_type);
>>  void clear_node_memory_type(int node, struct memory_dev_type *memtype)
>>  {
>>  	mutex_lock(&memory_tier_lock);
>> -	if (node_memory_types[node].memtype == memtype)
>> +	if (node_memory_types[node].memtype == memtype || !memtype)
>>  		node_memory_types[node].map_count--;
>>  	/*
>>  	 * If we umapped all the attached devices to this node,
