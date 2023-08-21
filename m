Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08AAB78364C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 01:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbjHUXbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 19:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjHUXbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 19:31:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EDC19B;
        Mon, 21 Aug 2023 16:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692660658; x=1724196658;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=EkN9k5iykyBDgII9+Wb82RB1BZVZdD0TgXowwLM8pWs=;
  b=LwDCq4/EbSGcutlSszkSTMs5X/DPIEuOBAZ1UJPjuwr9MkYagtchjOWd
   fTlarLYbwP9qIps2khxhj3YZxf1xwby6bGyGGmZIW3PUvhLq7qdmEguO3
   kMt/ybQZfs8k1xAAcjBMO/Xx2MOPGzNfMtmyVSMZOAh7gc0QC8wgj3/4Z
   cMh3x2WTxLwMh5H9uC4cQHEPJfBvPJ2fXyceRpplppYcUuCBO0SO/GB1h
   lHFNdfVp2Nq6mCemJzEAXnJ8RYaMUOfPLaBsAC0CddyYljg8oKc8t6FHU
   3ONcLZg7aBCr2mgVkjO733zBjm5VIvvAZxPo32yAlsdLF2tvoMLXwqPz3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="354052674"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="354052674"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 16:30:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="1066803842"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="1066803842"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 16:30:54 -0700
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
Subject: Re: [PATCH RESEND 3/4] acpi, hmat: calculate abstract distance with
 HMAT
References: <20230721012932.190742-1-ying.huang@intel.com>
        <20230721012932.190742-4-ying.huang@intel.com>
        <87ila8zo80.fsf@nvdebian.thelocal>
        <87h6psxzak.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <878ra4wqz0.fsf@nvdebian.thelocal>
Date:   Tue, 22 Aug 2023 07:28:49 +0800
In-Reply-To: <878ra4wqz0.fsf@nvdebian.thelocal> (Alistair Popple's message of
        "Mon, 21 Aug 2023 21:53:13 +1000")
Message-ID: <87edjwc6vi.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> "Huang, Ying" <ying.huang@intel.com> writes:
>
>> Alistair Popple <apopple@nvidia.com> writes:
>>
>>> Huang Ying <ying.huang@intel.com> writes:
>>>
>>>> A memory tiering abstract distance calculation algorithm based on ACPI
>>>> HMAT is implemented.  The basic idea is as follows.
>>>>
>>>> The performance attributes of system default DRAM nodes are recorded
>>>> as the base line.  Whose abstract distance is MEMTIER_ADISTANCE_DRAM.
>>>> Then, the ratio of the abstract distance of a memory node (target) to
>>>> MEMTIER_ADISTANCE_DRAM is scaled based on the ratio of the performance
>>>> attributes of the node to that of the default DRAM nodes.
>>>
>>> The problem I encountered here with the calculations is that HBM memory
>>> ended up in a lower-tiered node which isn't what I wanted (at least when
>>> that HBM is attached to a GPU say).
>>
>> I have tested the series on a server machine with HBM (pure HBM, not
>> attached to a GPU).  Where, HBM is placed in a higher tier than DRAM.
>
> Good to know.
>
>>> I suspect this is because the calculations are based on the CPU
>>> point-of-view (access1) which still sees lower bandwidth to remote HBM
>>> than local DRAM, even though the remote GPU has higher bandwidth access
>>> to that memory. Perhaps we need to be considering access0 as well?
>>> Ie. HBM directly attached to a generic initiator should be in a higher
>>> tier regardless of CPU access characteristics?
>>
>> What's your requirements for memory tiers on the machine?  I guess you
>> want to put GPU attache HBM in a higher tier and put DRAM in a lower
>> tier.  So, cold HBM pages can be demoted to DRAM when there are memory
>> pressure on HBM?  This sounds reasonable from GPU point of view.
>
> Yes, that is what I would like to implement.
>
>> The above requirements may be satisfied via calculating abstract
>> distance based on access0 (or combined with access1).  But I suspect
>> this will be a general solution.  I guess that any memory devices that
>> are used mainly by the memory initiators other than CPUs want to put
>> themselves in a higher memory tier than DRAM, regardless of its
>> access0.
>
> Right. I'm still figuring out how ACPI HMAT fits together but that
> sounds reasonable.
>
>> One solution is to put GPU HBM in the highest memory tier (with smallest
>> abstract distance) always in GPU device driver regardless its HMAT
>> performance attributes.  Is it possible?
>
> It's certainly possible and easy enough to do, although I think it would
> be good to provide upper and lower bounds for HMAT derived adistances to
> make that easier. It does make me wonder what the point of HMAT is if we
> have to ignore it in some scenarios though. But perhaps I need to dig
> deeper into the GPU values to figure out how it can be applied correctly
> there.

In the original design (page 11 of [1]),

[1] https://lpc.events/event/16/contributions/1209/attachments/1042/1995/Live%20In%20a%20World%20With%20Multiple%20Memory%20Types.pdf

the default memory tier hierarchy is based on the performance from CPU
point of view.  Then the abstract distance of a memory type (e.g., GPU
HBM) can be adjusted via a sysfs knob
(<memory_type>/abstract_distance_offset) based on the requirements of
GPU.

That's another possible solution.

--
Best Regards,
Huang, Ying

