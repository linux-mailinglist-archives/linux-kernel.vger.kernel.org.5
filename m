Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282457C6DB5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 14:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378420AbjJLMNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 08:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347216AbjJLMN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 08:13:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F52C9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 05:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697112807; x=1728648807;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=w8yQt9oo86/nZjDSgadz2LDv3J3dqgnu9r6s3Un8WxE=;
  b=XlY83SVYM4hEj0iAialMTH+aijTKggwXLZFEYpiH/3OIuKPRYfbATtr8
   O+Jlo2mr7hVMYjbiOY8CPGcv5dq4m1e3cD40wpv8+mlQauw/SYhA5nmzR
   ggiK8oC36fS9yGC8CBKXkkLW5wUkKuUBzP1/57HOQhnhlSHBCfrVgoCvf
   0p6PWUOR3IBqBROa9OCDYAbcBspnPQzBM9VZJSrKDkPZf4aF7Dwch7Xdc
   iGaAum7zvCMbOomgOISYDQsJhFr2r+8OssSjodmf1tdHBbQy8iREWNZGh
   RxX3XAOJpuZFmJAcV8HqVLDnhZUPnyruzJQRxyLI6ppSTPkGUe1d+JrrV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="471162914"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="471162914"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 05:13:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="789374334"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="789374334"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 05:13:23 -0700
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
Subject: Re: [PATCH 03/10] mm, pcp: reduce lock contention for draining
 high-order pages
References: <20230920061856.257597-1-ying.huang@intel.com>
        <20230920061856.257597-4-ying.huang@intel.com>
        <20231011124900.sp22hoxoitrslbia@techsingularity.net>
Date:   Thu, 12 Oct 2023 20:11:19 +0800
In-Reply-To: <20231011124900.sp22hoxoitrslbia@techsingularity.net> (Mel
        Gorman's message of "Wed, 11 Oct 2023 13:49:00 +0100")
Message-ID: <87cyxkf3bs.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Mel Gorman <mgorman@techsingularity.net> writes:

> On Wed, Sep 20, 2023 at 02:18:49PM +0800, Huang Ying wrote:
>> In commit f26b3fa04611 ("mm/page_alloc: limit number of high-order
>> pages on PCP during bulk free"), the PCP (Per-CPU Pageset) will be
>> drained when PCP is mostly used for high-order pages freeing to
>> improve the cache-hot pages reusing between page allocating and
>> freeing CPUs.
>> 
>> On system with small per-CPU data cache, pages shouldn't be cached
>> before draining to guarantee cache-hot.  But on a system with large
>> per-CPU data cache, more pages can be cached before draining to reduce
>> zone lock contention.
>> 
>> So, in this patch, instead of draining without any caching, "batch"
>> pages will be cached in PCP before draining if the per-CPU data cache
>> size is more than "4 * batch".
>> 
>> On a 2-socket Intel server with 128 logical CPU, with the patch, the
>> network bandwidth of the UNIX (AF_UNIX) test case of lmbench test
>> suite with 16-pair processes increase 72.2%.  The cycles% of the
>> spinlock contention (mostly for zone lock) decreases from 45.8% to
>> 21.2%.  The number of PCP draining for high order pages
>> freeing (free_high) decreases 89.8%.  The cache miss rate keeps 0.3%.
>> 
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>
> Acked-by: Mel Gorman <mgorman@techsingularity.net>
>
> However, the flag should also have been documented to make it clear that
> it preserves some pages on the PCP if the cache is large enough.

Sure.  Will do this.

> Similar
> to the previous patch, it would have been easier to reason about in the
> general case if the decision had only been based on the LLC without
> having to worry if any intermediate layer has a meaningful impact that
> varies across CPU implementations.

Sure.  Will do this.

--
Best Regards,
Huang, Ying
