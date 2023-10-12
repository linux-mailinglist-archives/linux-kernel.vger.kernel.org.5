Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116CD7C6F17
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378801AbjJLNYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347230AbjJLNYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:24:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA53ECC
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697117068; x=1728653068;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=cZ4V9GzEqz4BgoOaXGC/uxjgn6AC9Hl2WV/jrbzKEVY=;
  b=U5xLo5pMDBHnfLqiwlJvQdJtHQIehW4ePqVD/PEjeAlpK2ez95hIu1n4
   IyKBP/7iOEfnaUVbZ8E3TapdadQVfkCG4IR3iaARQE5JpABF5ANKBeOAq
   CijYEEx4jKHfuGqOaYrTYBzj0VdsDkgS8tDrVOyMw2Yo0uJXo8btZAOZO
   AT3q1/sl/RrmlSG9ZU4npFbG6kZ+36YxYr+anZJXIe2nQwRr72CCQTSrP
   N5HihRsbAcA+L2RCQZ5fzaPV/cLIcreg7FkSILe69kfrdz7ZOvY+UG7Qm
   u+45TDtMEc2eZ1WYdg8HSc+wzJOL/SbrgxFK0MGnQryW9b/+5rbc32UiB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="3519284"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="3519284"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 06:21:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="927982873"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="927982873"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 06:21:08 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Christoph Lameter" <cl@linux.com>
Subject: Re: [PATCH 09/10] mm, pcp: avoid to reduce PCP high unnecessarily
References: <20230920061856.257597-1-ying.huang@intel.com>
        <20230920061856.257597-10-ying.huang@intel.com>
        <20231011140949.rwsqfb57vyuub6va@techsingularity.net>
        <87lec8ffij.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <20231012124958.dj5ug5hih3joa542@techsingularity.net>
Date:   Thu, 12 Oct 2023 21:19:03 +0800
In-Reply-To: <20231012124958.dj5ug5hih3joa542@techsingularity.net> (Mel
        Gorman's message of "Thu, 12 Oct 2023 13:49:58 +0100")
Message-ID: <87r0m0dlmg.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman <mgorman@techsingularity.net> writes:

> On Thu, Oct 12, 2023 at 03:48:04PM +0800, Huang, Ying wrote:
>> "
>> On a 2-socket Intel server with 224 logical CPU, we run 8 kbuild
>> instances in parallel (each with `make -j 28`) in 8 cgroup.  This
>> simulates the kbuild server that is used by 0-Day kbuild service.
>> With the patch, The number of pages allocated from zone (instead of
>> from PCP) decreases 21.4%.
>> "
>> 
>> I also showed the performance number for each step of optimization as
>> follows (copied from the above patchset V2 link).
>> 
>> "
>> 	build time   lock contend%	free_high	alloc_zone
>> 	----------	----------	---------	----------
>> base	     100.0	      13.5          100.0            100.0
>> patch1	      99.2	      10.6	     19.2	      95.6
>> patch3	      99.2	      11.7	      7.1	      95.6
>> patch5	      98.4	      10.0	      8.2	      97.1
>> patch7	      94.9	       0.7	      3.0	      19.0
>> patch9	      94.9	       0.6	      2.7	      15.0  <--	this patch
>> patch10	      94.9	       0.9	      8.8	      18.6
>> "
>> 
>> Although I think the patch is helpful via avoiding the unnecessary
>> pcp->high decaying, thus reducing the zone lock contention.  There's no
>> visible benchmark score change for the patch.
>> 
>
> Thanks!
>
> Given that it's another PCP field with an update in a relatively hot
> path, I would suggest dropping this patch entirely if it does not affect
> performance. It has the risk of being a magical heuristic that we forget
> later whether it's even worthwhile.

OK.  Hope we can find some workloads that can benefit from the patch in
the future.

--
Best Regards,
Huang, Ying
