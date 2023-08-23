Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0064784E96
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 04:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbjHWCQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 22:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjHWCQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 22:16:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7202CEF;
        Tue, 22 Aug 2023 19:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692756959; x=1724292959;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=weET49PXqdwT0hzjZq+4RXPZJW4sshvEkGy2Va57pBQ=;
  b=F9NF48MwHtGdBJ6QAgiw+KK7TdjER2Q2XQ+QYq8aNmeWK4K3aUpqXTlo
   ftODTaZmY7QfBUDTmY4SSEvE2P77nOfk9C/YaW+PaWcdNcEY3Ym9ehnlL
   pJn/mRXiAny0zNi6yc5vifvmJnw/M3cvf62h/GdtOZztRIB7G0MWAIFun
   sWoV11i/JGECOkdbP68MTpytu4gByw4VgCA1yH9xVBBO+/i3MlSUf4z1P
   u0t8s2P1OkT9GrHJ7iAmQHS7m+7ipb89hUaDdQVzbYOmg+W8OSU9tAcoQ
   LmSCoeGMgFFe4WSrqHsgEtubg4dDZqrTBEQTld0OTODYCh1LvMMD4ZmmJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="354373070"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="354373070"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 19:15:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="771553193"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="771553193"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 19:15:41 -0700
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
        <87a5ukc6nr.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <87sf8ble6g.fsf@nvdebian.thelocal>
Date:   Wed, 23 Aug 2023 10:13:31 +0800
In-Reply-To: <87sf8ble6g.fsf@nvdebian.thelocal> (Alistair Popple's message of
        "Tue, 22 Aug 2023 17:36:22 +1000")
Message-ID: <87lee2bj5g.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
>>> "Huang, Ying" <ying.huang@intel.com> writes:
>>>
>>>> Alistair Popple <apopple@nvidia.com> writes:
>>>>
>>>>> Huang Ying <ying.huang@intel.com> writes:
>>>>>
>>>>>> Previously, a fixed abstract distance MEMTIER_DEFAULT_DAX_ADISTANCE is
>>>>>> used for slow memory type in kmem driver.  This limits the usage of
>>>>>> kmem driver, for example, it cannot be used for HBM (high bandwidth
>>>>>> memory).
>>>>>>
>>>>>> So, we use the general abstract distance calculation mechanism in kmem
>>>>>> drivers to get more accurate abstract distance on systems with proper
>>>>>> support.  The original MEMTIER_DEFAULT_DAX_ADISTANCE is used as
>>>>>> fallback only.
>>>>>>
>>>>>> Now, multiple memory types may be managed by kmem.  These memory types
>>>>>> are put into the "kmem_memory_types" list and protected by
>>>>>> kmem_memory_type_lock.
>>>>>
>>>>> See below but I wonder if kmem_memory_types could be a common helper
>>>>> rather than kdax specific?
>>>>>
>>>>>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>>>>>> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>>>>> Cc: Wei Xu <weixugc@google.com>
>>>>>> Cc: Alistair Popple <apopple@nvidia.com>
>>>>>> Cc: Dan Williams <dan.j.williams@intel.com>
>>>>>> Cc: Dave Hansen <dave.hansen@intel.com>
>>>>>> Cc: Davidlohr Bueso <dave@stgolabs.net>
>>>>>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>>>>>> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>>>> Cc: Michal Hocko <mhocko@kernel.org>
>>>>>> Cc: Yang Shi <shy828301@gmail.com>
>>>>>> Cc: Rafael J Wysocki <rafael.j.wysocki@intel.com>
>>>>>> ---
>>>>>>  drivers/dax/kmem.c           | 54 +++++++++++++++++++++++++++---------
>>>>>>  include/linux/memory-tiers.h |  2 ++
>>>>>>  mm/memory-tiers.c            |  2 +-
>>>>>>  3 files changed, 44 insertions(+), 14 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
>>>>>> index 898ca9505754..837165037231 100644
>>>>>> --- a/drivers/dax/kmem.c
>>>>>> +++ b/drivers/dax/kmem.c
>>>>>> @@ -49,14 +49,40 @@ struct dax_kmem_data {
>>>>>>  	struct resource *res[];
>>>>>>  };
>>>>>>  
>>>>>> -static struct memory_dev_type *dax_slowmem_type;
>>>>>> +static DEFINE_MUTEX(kmem_memory_type_lock);
>>>>>> +static LIST_HEAD(kmem_memory_types);
>>>>>> +
>>>>>> +static struct memory_dev_type *kmem_find_alloc_memorty_type(int adist)
>>>>>> +{
>>>>>> +	bool found = false;
>>>>>> +	struct memory_dev_type *mtype;
>>>>>> +
>>>>>> +	mutex_lock(&kmem_memory_type_lock);
>>>>>> +	list_for_each_entry(mtype, &kmem_memory_types, list) {
>>>>>> +		if (mtype->adistance == adist) {
>>>>>> +			found = true;
>>>>>> +			break;
>>>>>> +		}
>>>>>> +	}
>>>>>> +	if (!found) {
>>>>>> +		mtype = alloc_memory_type(adist);
>>>>>> +		if (!IS_ERR(mtype))
>>>>>> +			list_add(&mtype->list, &kmem_memory_types);
>>>>>> +	}
>>>>>> +	mutex_unlock(&kmem_memory_type_lock);
>>>>>> +
>>>>>> +	return mtype;
>>>>>> +}
>>>>>> +
>>>>>>  static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>>>>>  {
>>>>>>  	struct device *dev = &dev_dax->dev;
>>>>>>  	unsigned long total_len = 0;
>>>>>>  	struct dax_kmem_data *data;
>>>>>> +	struct memory_dev_type *mtype;
>>>>>>  	int i, rc, mapped = 0;
>>>>>>  	int numa_node;
>>>>>> +	int adist = MEMTIER_DEFAULT_DAX_ADISTANCE;
>>>>>>  
>>>>>>  	/*
>>>>>>  	 * Ensure good NUMA information for the persistent memory.
>>>>>> @@ -71,6 +97,11 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>>>>>  		return -EINVAL;
>>>>>>  	}
>>>>>>  
>>>>>> +	mt_calc_adistance(numa_node, &adist);
>>>>>> +	mtype = kmem_find_alloc_memorty_type(adist);
>>>>>> +	if (IS_ERR(mtype))
>>>>>> +		return PTR_ERR(mtype);
>>>>>> +
>>>>>
>>>>> I wrote my own quick and dirty module to test this and wrote basically
>>>>> the same code sequence.
>>>>>
>>>>> I notice your using a list of memory types here though. I think it would
>>>>> be nice to have a common helper that other users could call to do the
>>>>> mt_calc_adistance() / kmem_find_alloc_memory_type() /
>>>>> init_node_memory_type() sequence and cleanup as my naive approach would
>>>>> result in a new memory_dev_type per device even though adist might be
>>>>> the same. A common helper would make it easy to de-dup those.
>>>>
>>>> If it's useful, we can move kmem_find_alloc_memory_type() to
>>>> memory-tier.c after some revision.  But I tend to move it after we have
>>>> the second user.  What do you think about that?
>>>
>>> Usually I would agree, but this series already introduces a general
>>> interface for calculating adist even though there's only one user and
>>> implementation. So if we're going to add a general interface I think it
>>> would be better to make it more usable now rather than after variations
>>> of it have been cut and pasted into other drivers.
>>
>> In general, I would like to introduce complexity when necessary.  So, we
>> can discuss the necessity of the general interface firstly.  We can do
>> that in [1/4] of the series.
>
> Do we need one memory_dev_type per adistance or per adistance+device?
>
> If IUC correctly I think it's the former. Logically that means
> memory_dev_types should be managed by the memory-tiering subsystem
> because they are system wide rather than driver specific resources. That
> we need to add the list field to struct memory_dev_type specifically for
> use by dax/kmem supports that idea.

In the original design (page 9/10/11 of [1]), memory_dev_type (Memory
Type) is driver specific.

[1] https://lpc.events/event/16/contributions/1209/attachments/1042/1995/Live%20In%20a%20World%20With%20Multiple%20Memory%20Types.pdf

Memory devices with same adistance but was enumerated by different
drivers will be put in different memory_dev_type.  As a not-so-realistic
example, even if the PMEM devices in DIMM slots and the CXL.mem devices
in CXL slots have same adistance, their memory_dev_type will be
different.  Because the memory devices enumerated by the same driver
should be managed in the same way, but memory devices enumerated by
different drivers may be not.  For example, if we adjust the adistance
of the PMEM devices to put them in the lower memory tier via
not-yet-implemented abstract_distance_offset sysfs knob, we may not want
to adjust it of CXL.mem devices at the same time.

> Also I'm not sure why you consider moving the
> kmem_memory_types/kmem_find_alloc_memory_type()/etc. functions into
> mm/memory-tiers.c to add complexity. Isn't it just moving code around or
> am I missing some other subtlety that makes this hard? I really think
> logically memory-tiering.c is where management of the various
> memory_dev_types belongs.

IMHO, it depends on whether these functions are shared by at least 2
drivers.  If so, we can put them in mm/memory-tiers.c.  Otherwise, we
should keep them in the driver.

--
Best Regards,
Huang, Ying
