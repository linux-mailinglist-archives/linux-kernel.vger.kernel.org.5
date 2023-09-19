Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FAE7A59A6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 07:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjISF6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 01:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjISF6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 01:58:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8548FC
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 22:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695103126; x=1726639126;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=KAmPPpxW9liLl58sEZSznsJl5MqLZx/QqZBmppsxNqU=;
  b=Ndx9wht2TEAgle9shkECPzjI5pr6rlcg26/awyAfwmfjy0IpHBLbyEkf
   z9we0Gl+9sYPE46P09pSFBaL7KPxocErPFPXXMDQJY/4UfyD+3dP0peI9
   ZQvr51JiOiphFGgqbOpjpN24l9AFFbOn7aCT2wU0BMkZVTBzUN6EDK3dO
   /bbLwIc/fv0ni0+XqANR+IvbBkeKt7HZ65OlCKBH0psjfheP2Saje2xxq
   aRkueChJpueOXUwJyIXYDybvQj/yFeIFAkiXAXbC6INRblxLFqUwJaAai
   gQEOHyopVGyOORb5KNgWY7JzN9w2qwoNjXlfFtNQ9lC39DcpShaYPd1UF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="379761900"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; 
   d="scan'208";a="379761900"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 22:58:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="919737430"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; 
   d="scan'208";a="919737430"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 22:58:41 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Bharata B Rao <bharata@amd.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Wei Xu <weixugc@google.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH -V3 4/4] dax, kmem: calculate abstract distance with
 general interface
References: <20230912082101.342002-1-ying.huang@intel.com>
        <20230912082101.342002-5-ying.huang@intel.com>
        <87y1h24tft.fsf@nvdebian.thelocal>
Date:   Tue, 19 Sep 2023 13:56:33 +0800
In-Reply-To: <87y1h24tft.fsf@nvdebian.thelocal> (Alistair Popple's message of
        "Tue, 19 Sep 2023 15:31:29 +1000")
Message-ID: <8734zayacu.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair Popple <apopple@nvidia.com> writes:

> Huang Ying <ying.huang@intel.com> writes:
>
>> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
>> index fa1a8b418f9a..ca68ef17554b 100644
>> --- a/mm/memory-tiers.c
>> +++ b/mm/memory-tiers.c
>> @@ -586,7 +586,7 @@ EXPORT_SYMBOL_GPL(init_node_memory_type);
>>  void clear_node_memory_type(int node, struct memory_dev_type *memtype)
>>  {
>>  	mutex_lock(&memory_tier_lock);
>> -	if (node_memory_types[node].memtype == memtype)
>> +	if (node_memory_types[node].memtype == memtype || !memtype)
>>  		node_memory_types[node].map_count--;
>>
>>  	/*
>>  	 * If we umapped all the attached devices to this node,
>
> This implies it's possible memtype == NULL. Yet we have this:
>
> 	 * clear the node memory type.
> 	 */
> 	if (!node_memory_types[node].map_count) {
> 		node_memory_types[node].memtype = NULL;
> 		put_memory_type(memtype);
> 	}
>
> It's not safe to call put_memory_type(NULL), so what condition guarantees
> map_count > 1 when called with memtype == NULL? Thanks.

Nothing guarantees that.  Thanks for pointing this out.  I will revise
the code to put_memory_type(node_memory_types[node].memtype) firstly.

--
Best Regards,
Huang, Ying
