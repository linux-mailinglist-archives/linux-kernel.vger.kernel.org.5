Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2C57784D0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 03:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjHKBPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 21:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjHKBPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 21:15:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEA12D60;
        Thu, 10 Aug 2023 18:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691716505; x=1723252505;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=GSoNnc9ZROtEeZh8ssPdb9O3EsO5sMHiL/NsY3M9aQE=;
  b=LeikNHiqFaCFubmCHm5+fHrSGRB7SzGhVEbu/1FrQZ/H5Byz2nAGsPFZ
   9gwzydTS50Q+iTgSB4kkKnUAa8mXSu0K5v91Rfm9WvLS4l1o6B4BEEes3
   MTkf5NZdrTikyw+OR+fxrcmhwjMdfVi5uzDe/W6Mfr1hL6/uqW8pyLIUY
   /zRWmjIsmM2pnejPMf4eJPiFxE4efec2jy5CriqoqvEjHWHyyG9ElKwgx
   PCYx8rvb10+rz+bdV5ic8ZiRJffPImtwF4YGchfCVMBt53H1E00EbIhg2
   /r8a2LfXeDinnlVYFH35gLY9vlP5N5p6HohKsu8vwZQy86m5hsAEJrG4Q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="374332140"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="374332140"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 18:15:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="979042916"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="979042916"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 18:15:00 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Wei Xu <weixugc@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH RESEND 2/4] acpi, hmat: refactor
 hmat_register_target_initiators()
References: <20230721012932.190742-1-ying.huang@intel.com>
        <20230721012932.190742-3-ying.huang@intel.com>
        <20230807175546.00001566@Huawei.com>
Date:   Fri, 11 Aug 2023 09:13:23 +0800
In-Reply-To: <20230807175546.00001566@Huawei.com> (Jonathan Cameron's message
        of "Mon, 7 Aug 2023 17:55:46 +0100")
Message-ID: <87v8dmpej0.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jonathan,

Thanks for review!

Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:

> On Fri, 21 Jul 2023 09:29:30 +0800
> Huang Ying <ying.huang@intel.com> wrote:
>
>> Previously, in hmat_register_target_initiators(), the performance
>> attributes are calculated and the corresponding sysfs links and files
>> are created too.  Which is called during memory onlining.
>> 
>> But now, to calculate the abstract distance of a memory target before
>> memory onlining, we need to calculate the performance attributes for
>> a memory target without creating sysfs links and files.
>> 
>> To do that, hmat_register_target_initiators() is refactored to make it
>> possible to calculate performance attributes separately.
>> 
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
>
> Unfortunately I don't think I still have the tables I used to test the
> generic initiator and won't get time to generate them all again in
> next few weeks.  So just a superficial review for now.
> I 'think' the cleanup looks good but the original code was rather fiddly
> so I'm not 100% sure nothing is missed.
>
> One comment inline on the fact the list is now sorted twice.
>
>
>> ---
>>  drivers/acpi/numa/hmat.c | 81 +++++++++++++++-------------------------
>>  1 file changed, 30 insertions(+), 51 deletions(-)
>> 
>> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
>> index bba268ecd802..2dee0098f1a9 100644
>> --- a/drivers/acpi/numa/hmat.c
>> +++ b/drivers/acpi/numa/hmat.c
>> @@ -582,28 +582,25 @@ static int initiators_to_nodemask(unsigned long *p_nodes)
>>  	return 0;
>>  }
>>  
>> -static void hmat_register_target_initiators(struct memory_target *target)
>> +static void hmat_update_target_attrs(struct memory_target *target,
>> +				     unsigned long *p_nodes, int access)
>>  {
>> -	static DECLARE_BITMAP(p_nodes, MAX_NUMNODES);
>>  	struct memory_initiator *initiator;
>> -	unsigned int mem_nid, cpu_nid;
>> +	unsigned int cpu_nid;
>>  	struct memory_locality *loc = NULL;
>>  	u32 best = 0;
>> -	bool access0done = false;
>>  	int i;
>>  
>> -	mem_nid = pxm_to_node(target->memory_pxm);
>> +	bitmap_zero(p_nodes, MAX_NUMNODES);
>>  	/*
>> -	 * If the Address Range Structure provides a local processor pxm, link
>> +	 * If the Address Range Structure provides a local processor pxm, set
>>  	 * only that one. Otherwise, find the best performance attributes and
>> -	 * register all initiators that match.
>> +	 * collect all initiators that match.
>>  	 */
>>  	if (target->processor_pxm != PXM_INVAL) {
>>  		cpu_nid = pxm_to_node(target->processor_pxm);
>> -		register_memory_node_under_compute_node(mem_nid, cpu_nid, 0);
>> -		access0done = true;
>> -		if (node_state(cpu_nid, N_CPU)) {
>> -			register_memory_node_under_compute_node(mem_nid, cpu_nid, 1);
>> +		if (access == 0 || node_state(cpu_nid, N_CPU)) {
>> +			set_bit(target->processor_pxm, p_nodes);
>>  			return;
>>  		}
>>  	}
>> @@ -617,47 +614,10 @@ static void hmat_register_target_initiators(struct memory_target *target)
>>  	 * We'll also use the sorting to prime the candidate nodes with known
>>  	 * initiators.
>>  	 */
>> -	bitmap_zero(p_nodes, MAX_NUMNODES);
>>  	list_sort(NULL, &initiators, initiator_cmp);
>>  	if (initiators_to_nodemask(p_nodes) < 0)
>>  		return;
>
> One result of this refactor is that a few things run twice, that previously only ran once
> like this list_sort()
> Not necessarily a problem though as probably fairly cheap.

Yes.  The original code sorts once for each target.  But it appears that
it's unnecessary too.  We can sort the initiators list when adding new
item to it in alloc_memory_initiator().  If necessary, I can add an
additional patch to do that.  But as you said, it may be unnecessary
because the sort should be fairly cheap.

--
Best Regards,
Huang, Ying

>>  
>> -	if (!access0done) {
>> -		for (i = WRITE_LATENCY; i <= READ_BANDWIDTH; i++) {
>> -			loc = localities_types[i];
>> -			if (!loc)
>> -				continue;
>> -
>> -			best = 0;
>> -			list_for_each_entry(initiator, &initiators, node) {
>> -				u32 value;
>> -
>> -				if (!test_bit(initiator->processor_pxm, p_nodes))
>> -					continue;
>> -
>> -				value = hmat_initiator_perf(target, initiator,
>> -							    loc->hmat_loc);
>> -				if (hmat_update_best(loc->hmat_loc->data_type, value, &best))
>> -					bitmap_clear(p_nodes, 0, initiator->processor_pxm);
>> -				if (value != best)
>> -					clear_bit(initiator->processor_pxm, p_nodes);
>> -			}
>> -			if (best)
>> -				hmat_update_target_access(target, loc->hmat_loc->data_type,
>> -							  best, 0);
>> -		}
>> -
>> -		for_each_set_bit(i, p_nodes, MAX_NUMNODES) {
>> -			cpu_nid = pxm_to_node(i);
>> -			register_memory_node_under_compute_node(mem_nid, cpu_nid, 0);
>> -		}
>> -	}
>> -
>> -	/* Access 1 ignores Generic Initiators */
>> -	bitmap_zero(p_nodes, MAX_NUMNODES);
>> -	if (initiators_to_nodemask(p_nodes) < 0)
>> -		return;
>> -
>>  	for (i = WRITE_LATENCY; i <= READ_BANDWIDTH; i++) {
>>  		loc = localities_types[i];
>>  		if (!loc)
>> @@ -667,7 +627,7 @@ static void hmat_register_target_initiators(struct memory_target *target)
>>  		list_for_each_entry(initiator, &initiators, node) {
>>  			u32 value;
>>  
>> -			if (!initiator->has_cpu) {
>> +			if (access == 1 && !initiator->has_cpu) {
>>  				clear_bit(initiator->processor_pxm, p_nodes);
>>  				continue;
>>  			}
>> @@ -681,14 +641,33 @@ static void hmat_register_target_initiators(struct memory_target *target)
>>  				clear_bit(initiator->processor_pxm, p_nodes);
>>  		}
>>  		if (best)
>> -			hmat_update_target_access(target, loc->hmat_loc->data_type, best, 1);
>> +			hmat_update_target_access(target, loc->hmat_loc->data_type, best, access);
>>  	}
>> +}
>> +
>> +static void __hmat_register_target_initiators(struct memory_target *target,
>> +					      unsigned long *p_nodes,
>> +					      int access)
>> +{
>> +	unsigned int mem_nid, cpu_nid;
>> +	int i;
>> +
>> +	mem_nid = pxm_to_node(target->memory_pxm);
>> +	hmat_update_target_attrs(target, p_nodes, access);
>>  	for_each_set_bit(i, p_nodes, MAX_NUMNODES) {
>>  		cpu_nid = pxm_to_node(i);
>> -		register_memory_node_under_compute_node(mem_nid, cpu_nid, 1);
>> +		register_memory_node_under_compute_node(mem_nid, cpu_nid, access);
>>  	}
>>  }
>>  
>> +static void hmat_register_target_initiators(struct memory_target *target)
>> +{
>> +	static DECLARE_BITMAP(p_nodes, MAX_NUMNODES);
>> +
>> +	__hmat_register_target_initiators(target, p_nodes, 0);
>> +	__hmat_register_target_initiators(target, p_nodes, 1);
>> +}
>> +
>>  static void hmat_register_target_cache(struct memory_target *target)
>>  {
>>  	unsigned mem_nid = pxm_to_node(target->memory_pxm);
