Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D16760AE3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 08:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjGYGuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 02:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGYGuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 02:50:12 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FE68E;
        Mon, 24 Jul 2023 23:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690267811; x=1721803811;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=sMXp8XuVx7sja1Zb9TfJOl/mMXazPG34qUPoSd0z870=;
  b=HeyeRT4vEGYP1dT/vgdWjFTZL8Y2iA5lgHvM7mSuhlQxvlztFQqxXBSO
   AJLgrY5ew5b6ZY1UoTUVwiF5SQAczoe5OitkA4g4ASwXaKS/cJ2UGjWsi
   nfqUy7fpaPIXfvFNDqN7MVudSMpTX0xE8gaUIf+AaPZFfcrgr9fOwg6AT
   CRA+vp563AkOGU573kRhqOKeRgMUZYYxrLiBz4nhkZUcMBIz1pfR2AHrb
   qF35cDrIGlZT+uWmMtFYw+Pa7katgTa6CXQjLkHcBh6WXlOxQT+krOBz6
   z4yQCnZxZSw3hPQsKZE4CzwHRfxCxX3MJ3vKSPMaiAOeIyQAwUxV4EgRR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="347242146"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="347242146"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 23:50:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="1056698073"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="1056698073"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 23:49:39 -0700
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
In-Reply-To: <87ila8zo80.fsf@nvdebian.thelocal> (Alistair Popple's message of
        "Tue, 25 Jul 2023 12:45:01 +1000")
References: <20230721012932.190742-1-ying.huang@intel.com>
        <20230721012932.190742-4-ying.huang@intel.com>
        <87ila8zo80.fsf@nvdebian.thelocal>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date:   Tue, 25 Jul 2023 14:47:47 +0800
Message-ID: <87h6psxzak.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair Popple <apopple@nvidia.com> writes:

> Huang Ying <ying.huang@intel.com> writes:
>
>> A memory tiering abstract distance calculation algorithm based on ACPI
>> HMAT is implemented.  The basic idea is as follows.
>>
>> The performance attributes of system default DRAM nodes are recorded
>> as the base line.  Whose abstract distance is MEMTIER_ADISTANCE_DRAM.
>> Then, the ratio of the abstract distance of a memory node (target) to
>> MEMTIER_ADISTANCE_DRAM is scaled based on the ratio of the performance
>> attributes of the node to that of the default DRAM nodes.
>
> The problem I encountered here with the calculations is that HBM memory
> ended up in a lower-tiered node which isn't what I wanted (at least when
> that HBM is attached to a GPU say).

I have tested the series on a server machine with HBM (pure HBM, not
attached to a GPU).  Where, HBM is placed in a higher tier than DRAM.

> I suspect this is because the calculations are based on the CPU
> point-of-view (access1) which still sees lower bandwidth to remote HBM
> than local DRAM, even though the remote GPU has higher bandwidth access
> to that memory. Perhaps we need to be considering access0 as well?
> Ie. HBM directly attached to a generic initiator should be in a higher
> tier regardless of CPU access characteristics?

What's your requirements for memory tiers on the machine?  I guess you
want to put GPU attache HBM in a higher tier and put DRAM in a lower
tier.  So, cold HBM pages can be demoted to DRAM when there are memory
pressure on HBM?  This sounds reasonable from GPU point of view.

The above requirements may be satisfied via calculating abstract
distance based on access0 (or combined with access1).  But I suspect
this will be a general solution.  I guess that any memory devices that
are used mainly by the memory initiators other than CPUs want to put
themselves in a higher memory tier than DRAM, regardless of its
access0.

One solution is to put GPU HBM in the highest memory tier (with smallest
abstract distance) always in GPU device driver regardless its HMAT
performance attributes.  Is it possible?

> That said I'm not entirely convinced the HMAT tables I'm testing against
> are accurate/complete.

--
Best Regards,
Huang, Ying
