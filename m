Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10954762DE9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbjGZHhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjGZHgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:36:16 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB68DD;
        Wed, 26 Jul 2023 00:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690356918; x=1721892918;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=6qVZBUs21Wpj2aQjHSwyHHybwSsIvWbW48TAPSEojyI=;
  b=mCUDzwLl38z3ni6L3EOAGiy1sL3sfPdd0Q8dQRPnIL0DVNPfGIkfTt40
   kkDpfsicBD4FmzUvXdTXJyVRbYwdVTbtuC1C1fbsW+X8AuY0ExfQfcFJl
   ypNetggn9k3R9htzu/v+aoo23OKFdEt0V2oc8VRph/7xk5+QmNA1vc6jM
   +gF2o1+e3uc0SDScjnfOYY9q9zqcfX6bfgSW96eolGRMMOjVm0Ftbw9G6
   e/Ioi8SqDZ4UFOmSZDIKfW7P0TafqKUSQjIkMp/aM5qrUNX+ECeJaCbnG
   huVnzEIs39y9xwzeUOkEWVIeSom/rWHaxSIzIQEyoluaPbEQhueW4uDJw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="398875133"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="398875133"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 00:35:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="726408026"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="726408026"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 00:35:13 -0700
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
Date:   Wed, 26 Jul 2023 15:33:26 +0800
In-Reply-To: <87sf9cxupz.fsf@nvdebian.thelocal> (Alistair Popple's message of
        "Tue, 25 Jul 2023 18:26:15 +1000")
Message-ID: <878rb3xh2x.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair Popple <apopple@nvidia.com> writes:

> "Huang, Ying" <ying.huang@intel.com> writes:
>
>> Hi, Alistair,
>>
>> Thanks a lot for comments!
>>
>> Alistair Popple <apopple@nvidia.com> writes:
>>
>>> Huang Ying <ying.huang@intel.com> writes:
>>>
>>>> The abstract distance may be calculated by various drivers, such as
>>>> ACPI HMAT, CXL CDAT, etc.  While it may be used by various code which
>>>> hot-add memory node, such as dax/kmem etc.  To decouple the algorithm
>>>> users and the providers, the abstract distance calculation algorithms
>>>> management mechanism is implemented in this patch.  It provides
>>>> interface for the providers to register the implementation, and
>>>> interface for the users.
>>>
>>> I wonder if we need this level of decoupling though? It seems to me like
>>> it would be simpler and better for drivers to calculate the abstract
>>> distance directly themselves by calling the desired algorithm (eg. ACPI
>>> HMAT) and pass this when creating the nodes rather than having a
>>> notifier chain.
>>
>> Per my understanding, ACPI HMAT and memory device drivers (such as
>> dax/kmem) may belong to different subsystems (ACPI vs. dax).  It's not
>> good to call functions across subsystems directly.  So, I think it's
>> better to use a general subsystem: memory-tier.c to decouple them.  If
>> it turns out that a notifier chain is unnecessary, we can use some
>> function pointers instead.
>>
>>> At the moment it seems we've only identified two possible algorithms
>>> (ACPI HMAT and CXL CDAT) and I don't think it would make sense for one
>>> of those to fallback to the other based on priority, so why not just
>>> have drivers call the correct algorithm directly?
>>
>> For example, we have a system with PMEM (persistent memory, Optane
>> DCPMM, or AEP, or something else) in DIMM slots and CXL.mem connected
>> via CXL link to a remote memory pool.  We will need ACPI HMAT for PMEM
>> and CXL CDAT for CXL.mem.  One way is to make dax/kmem identify the
>> types of the device and call corresponding algorithms.
>
> Yes, that is what I was thinking.
>
>> The other way (suggested by this series) is to make dax/kmem call a
>> notifier chain, then CXL CDAT or ACPI HMAT can identify the type of
>> device and calculate the distance if the type is correct for them.  I
>> don't think that it's good to make dax/kem to know every possible
>> types of memory devices.
>
> Do we expect there to be lots of different types of memory devices
> sharing a common dax/kmem driver though? Must admit I'm coming from a
> GPU background where we'd expect each type of device to have it's own
> driver anyway so wasn't expecting different types of memory devices to
> be handled by the same driver.

Now, dax/kmem.c is used for

- PMEM (Optane DCPMM, or AEP)
- CXL.mem
- HBM (attached to CPU)

I understand that for a CXL GPU driver it's OK to call some CXL CDAT
helper to identify the abstract distance of memory attached to GPU.
Because there's no cross-subsystem function calls.  But it looks not
very clean to call from dax/kmem.c to CXL CDAT because it's a
cross-subsystem function call.

>>>> Multiple algorithm implementations can cooperate via calculating
>>>> abstract distance for different memory nodes.  The preference of
>>>> algorithm implementations can be specified via
>>>> priority (notifier_block.priority).
>>>
>>> How/what decides the priority though? That seems like something better
>>> decided by a device driver than the algorithm driver IMHO.
>>
>> Do we need the memory device driver specific priority?  Or we just share
>> a common priority?  For example, the priority of CXL CDAT is always
>> higher than that of ACPI HMAT?  Or architecture specific?
>
> Ok, thanks. Having read the above I think the priority is
> unimportant. Algorithms can either decide to return a distance and
> NOTIFY_STOP_MASK if they can calculate a distance or NOTIFY_DONE if they
> can't for a specific device.

Yes.  In most cases, there are no overlaps among algorithms.

>> And, I don't think that we are forced to use the general notifier
>> chain interface in all memory device drivers.  If the memory device
>> driver has better understanding of the memory device, it can use other
>> way to determine abstract distance.  For example, a CXL memory device
>> driver can identify abstract distance by itself.  While other memory
>> device drivers can use the general notifier chain interface at the
>> same time.
>
> Whilst I think personally I would find that flexibility useful I am
> concerned it means every driver will just end up divining it's own
> distance rather than ensuring data in HMAT/CDAT/etc. is correct. That
> would kind of defeat the purpose of it all then.

But we have no way to enforce that too.

--
Best Regards,
Huang, Ying
