Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8657B778643
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 05:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbjHKDxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 23:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbjHKDxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 23:53:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1FE2D7B;
        Thu, 10 Aug 2023 20:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691725984; x=1723261984;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=WDGapeIqb0kOff3B56X84HvpVJViEsZOYrPk6MNaeOU=;
  b=Ctn66cBxofOwwkE03ffEPaHE/S+RI7dXPLTEzgxNj0svt+iYTdGcVRC3
   jO5bJeVzXYy8nhI39NjVkGHLGM8bKwgj9URhpKrGR9HwHJFTTvkz6BFwU
   0H9jgCBj034M6qceLULJ5TwrGy/1uyxTI08ErooUqCp27pL+IAudtXVou
   qRu8o9v/3Jpj93yEoHUAhvc1qNmaEGkkjMBLCXiBTUdXQ2qJCkthlHI97
   SpwncJKenw5Kc3C0vCUENwRWNVALJNdLCItKHNQ+SWqzbTh3sNw71vpcS
   PehQSoTLRq0SybPFgoxeHCgSoNLkh6wBYSU3xBvGfI+am3ke1hCp9HAeD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="356554302"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="356554302"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 20:53:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="762047251"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="762047251"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 20:52:58 -0700
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
        Rafael J Wysocki <rafael.j.wysocki@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH RESEND 1/4] memory tiering: add abstract distance
 calculation algorithms management
References: <20230721012932.190742-1-ying.huang@intel.com>
        <20230721012932.190742-2-ying.huang@intel.com>
        <87r0owzqdc.fsf@nvdebian.thelocal>
        <87r0owy95t.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <87sf9cxupz.fsf@nvdebian.thelocal>
        <878rb3xh2x.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <87351axbk6.fsf@nvdebian.thelocal>
        <87edkuvw6m.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <87y1j2vvqw.fsf@nvdebian.thelocal>
        <87a5vhx664.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <87lef0x23q.fsf@nvdebian.thelocal>
Date:   Fri, 11 Aug 2023 11:51:11 +0800
In-Reply-To: <87lef0x23q.fsf@nvdebian.thelocal> (Alistair Popple's message of
        "Fri, 28 Jul 2023 11:20:05 +1000")
Message-ID: <87r0oack40.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Alistair,

Sorry for late response.  Just come back from vacation.

Alistair Popple <apopple@nvidia.com> writes:

> "Huang, Ying" <ying.huang@intel.com> writes:
>
>> Alistair Popple <apopple@nvidia.com> writes:
>>
>>> "Huang, Ying" <ying.huang@intel.com> writes:
>>>
>>>> Alistair Popple <apopple@nvidia.com> writes:
>>>>
>>>>>>>> While other memory device drivers can use the general notifier chain
>>>>>>>> interface at the same time.
>>>>>
>>>>> How would that work in practice though? The abstract distance as far as
>>>>> I can tell doesn't have any meaning other than establishing preferences
>>>>> for memory demotion order. Therefore all calculations are relative to
>>>>> the rest of the calculations on the system. So if a driver does it's own
>>>>> thing how does it choose a sensible distance? IHMO the value here is in
>>>>> coordinating all that through a standard interface, whether that is HMAT
>>>>> or something else.
>>>>
>>>> Only if different algorithms follow the same basic principle.  For
>>>> example, the abstract distance of default DRAM nodes are fixed
>>>> (MEMTIER_ADISTANCE_DRAM).  The abstract distance of the memory device is
>>>> in linear direct proportion to the memory latency and inversely
>>>> proportional to the memory bandwidth.  Use the memory latency and
>>>> bandwidth of default DRAM nodes as base.
>>>>
>>>> HMAT and CDAT report the raw memory latency and bandwidth.  If there are
>>>> some other methods to report the raw memory latency and bandwidth, we
>>>> can use them too.
>>>
>>> Argh! So we could address my concerns by having drivers feed
>>> latency/bandwidth numbers into a standard calculation algorithm right?
>>> Ie. Rather than having drivers calculate abstract distance themselves we
>>> have the notifier chains return the raw performance data from which the
>>> abstract distance is derived.
>>
>> Now, memory device drivers only need a general interface to get the
>> abstract distance from the NUMA node ID.  In the future, if they need
>> more interfaces, we can add them.  For example, the interface you
>> suggested above.
>
> Huh? Memory device drivers (ie. dax/kmem.c) don't care about abstract
> distance, it's a meaningless number. The only reason they care about it
> is so they can pass it to alloc_memory_type():
>
> struct memory_dev_type *alloc_memory_type(int adistance)
>
> Instead alloc_memory_type() should be taking bandwidth/latency numbers
> and the calculation of abstract distance should be done there. That
> resovles the issues about how drivers are supposed to devine adistance
> and also means that when CDAT is added we don't have to duplicate the
> calculation code.

In the current design, the abstract distance is the key concept of
memory types and memory tiers.  And it is used as interface to allocate
memory types.  This provides more flexibility than some other interfaces
(e.g. read/write bandwidth/latency).  For example, in current
dax/kmem.c, if HMAT isn't available in the system, the default abstract
distance: MEMTIER_DEFAULT_DAX_ADISTANCE is used.  This is still useful
to support some systems now.  On a system without HMAT/CDAT, it's
possible to calculate abstract distance from ACPI SLIT, although this is
quite limited.  I'm not sure whether all systems will provide read/write
bandwith/latency data for all memory devices.

HMAT and CDAT or some other mechanisms may provide the read/write
bandwidth/latency data to be used to calculate abstract distance.  For
them, we can provide a shared implementation in mm/memory-tiers.c to map
from read/write bandwith/latency to the abstract distance.  Can this
solve your concerns about the consistency among algorithms?  If so, we
can do that when we add the second algorithm that needs that.

--
Best Regards,
Huang, Ying
