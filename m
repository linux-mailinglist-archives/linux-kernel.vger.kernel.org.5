Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7BA783668
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 01:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjHUXhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 19:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbjHUXhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 19:37:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26AA189;
        Mon, 21 Aug 2023 16:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692661021; x=1724197021;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=lyG/72iRKaKPXkXbLzVHa9J51DlyHySbY0/hxJRW8/0=;
  b=WRrc35K04ZX06NrV8igIABf/MWdu6qx13WcafxXW6xtWeoqVm2jJ9Q4t
   lBmUIkCHxYEMrUVkoELDV/BoJogcE5UXgYFxrPQu3CXVb93/jBg/T0tWg
   iSGloXZZCwXvF1I0O/2zbogN0JN6YdxRg/JacbiQvUxGAzdJ6TjyAtMhX
   MifkuGuEUTRijIT41DWJyoNDtd8rAWp5I5YBWkquxZ2G6XJj1dtaiCAjW
   0uFGwkiujVo8q3ukZ5dierlbAEd8t4pKzl+QZWtv8I8aRM3ClfjmzeZwQ
   XNwfrFbTzBAe46GAuRLXDkNAZ6VsqBTlte2mOLL1cO66isaz0woDJmC4F
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="440097320"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="440097320"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 16:35:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="850368628"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="850368628"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 16:35:33 -0700
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
        <87cz0gxylp.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <871qfwwqi3.fsf@nvdebian.thelocal>
Date:   Tue, 22 Aug 2023 07:33:28 +0800
In-Reply-To: <871qfwwqi3.fsf@nvdebian.thelocal> (Alistair Popple's message of
        "Mon, 21 Aug 2023 22:03:43 +1000")
Message-ID: <87a5ukc6nr.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair Popple <apopple@nvidia.com> writes:

> "Huang, Ying" <ying.huang@intel.com> writes:
>
>> Alistair Popple <apopple@nvidia.com> writes:
>>
>>> Huang Ying <ying.huang@intel.com> writes:
>>>
>>>> Previously, a fixed abstract distance MEMTIER_DEFAULT_DAX_ADISTANCE is
>>>> used for slow memory type in kmem driver.  This limits the usage of
>>>> kmem driver, for example, it cannot be used for HBM (high bandwidth
>>>> memory).
>>>>
>>>> So, we use the general abstract distance calculation mechanism in kmem
>>>> drivers to get more accurate abstract distance on systems with proper
>>>> support.  The original MEMTIER_DEFAULT_DAX_ADISTANCE is used as
>>>> fallback only.
>>>>
>>>> Now, multiple memory types may be managed by kmem.  These memory types
>>>> are put into the "kmem_memory_types" list and protected by
>>>> kmem_memory_type_lock.
>>>
>>> See below but I wonder if kmem_memory_types could be a common helper
>>> rather than kdax specific?
>>>
>>>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>>>> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>>> Cc: Wei Xu <weixugc@google.com>
>>>> Cc: Alistair Popple <apopple@nvidia.com>
>>>> Cc: Dan Williams <dan.j.williams@intel.com>
>>>> Cc: Dave Hansen <dave.hansen@intel.com>
>>>> Cc: Davidlohr Bueso <dave@stgolabs.net>
>>>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>>>> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>> Cc: Michal Hocko <mhocko@kernel.org>
>>>> Cc: Yang Shi <shy828301@gmail.com>
>>>> Cc: Rafael J Wysocki <rafael.j.wysocki@intel.com>
>>>> ---
>>>>  drivers/dax/kmem.c           | 54 +++++++++++++++++++++++++++---------
>>>>  include/linux/memory-tiers.h |  2 ++
>>>>  mm/memory-tiers.c            |  2 +-
>>>>  3 files changed, 44 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
>>>> index 898ca9505754..837165037231 100644
>>>> --- a/drivers/dax/kmem.c
>>>> +++ b/drivers/dax/kmem.c
>>>> @@ -49,14 +49,40 @@ struct dax_kmem_data {
>>>>  	struct resource *res[];
>>>>  };
>>>>  
>>>> -static struct memory_dev_type *dax_slowmem_type;
>>>> +static DEFINE_MUTEX(kmem_memory_type_lock);
>>>> +static LIST_HEAD(kmem_memory_types);
>>>> +
>>>> +static struct memory_dev_type *kmem_find_alloc_memorty_type(int adist)
>>>> +{
>>>> +	bool found = false;
>>>> +	struct memory_dev_type *mtype;
>>>> +
>>>> +	mutex_lock(&kmem_memory_type_lock);
>>>> +	list_for_each_entry(mtype, &kmem_memory_types, list) {
>>>> +		if (mtype->adistance == adist) {
>>>> +			found = true;
>>>> +			break;
>>>> +		}
>>>> +	}
>>>> +	if (!found) {
>>>> +		mtype = alloc_memory_type(adist);
>>>> +		if (!IS_ERR(mtype))
>>>> +			list_add(&mtype->list, &kmem_memory_types);
>>>> +	}
>>>> +	mutex_unlock(&kmem_memory_type_lock);
>>>> +
>>>> +	return mtype;
>>>> +}
>>>> +
>>>>  static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>>>  {
>>>>  	struct device *dev = &dev_dax->dev;
>>>>  	unsigned long total_len = 0;
>>>>  	struct dax_kmem_data *data;
>>>> +	struct memory_dev_type *mtype;
>>>>  	int i, rc, mapped = 0;
>>>>  	int numa_node;
>>>> +	int adist = MEMTIER_DEFAULT_DAX_ADISTANCE;
>>>>  
>>>>  	/*
>>>>  	 * Ensure good NUMA information for the persistent memory.
>>>> @@ -71,6 +97,11 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>>>  		return -EINVAL;
>>>>  	}
>>>>  
>>>> +	mt_calc_adistance(numa_node, &adist);
>>>> +	mtype = kmem_find_alloc_memorty_type(adist);
>>>> +	if (IS_ERR(mtype))
>>>> +		return PTR_ERR(mtype);
>>>> +
>>>
>>> I wrote my own quick and dirty module to test this and wrote basically
>>> the same code sequence.
>>>
>>> I notice your using a list of memory types here though. I think it would
>>> be nice to have a common helper that other users could call to do the
>>> mt_calc_adistance() / kmem_find_alloc_memory_type() /
>>> init_node_memory_type() sequence and cleanup as my naive approach would
>>> result in a new memory_dev_type per device even though adist might be
>>> the same. A common helper would make it easy to de-dup those.
>>
>> If it's useful, we can move kmem_find_alloc_memory_type() to
>> memory-tier.c after some revision.  But I tend to move it after we have
>> the second user.  What do you think about that?
>
> Usually I would agree, but this series already introduces a general
> interface for calculating adist even though there's only one user and
> implementation. So if we're going to add a general interface I think it
> would be better to make it more usable now rather than after variations
> of it have been cut and pasted into other drivers.

In general, I would like to introduce complexity when necessary.  So, we
can discuss the necessity of the general interface firstly.  We can do
that in [1/4] of the series.

--
Best Regards,
Huang, Ying
