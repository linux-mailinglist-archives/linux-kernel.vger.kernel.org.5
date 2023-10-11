Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A347C544A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjJKMtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjJKMtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:49:06 -0400
Received: from outbound-smtp02.blacknight.com (outbound-smtp02.blacknight.com [81.17.249.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA9992
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:49:03 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp02.blacknight.com (Postfix) with ESMTPS id 69D69BAD2C
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 13:49:02 +0100 (IST)
Received: (qmail 12957 invoked from network); 11 Oct 2023 12:49:02 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.197.19])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 11 Oct 2023 12:49:02 -0000
Date:   Wed, 11 Oct 2023 13:49:00 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Huang Ying <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH 03/10] mm, pcp: reduce lock contention for draining
 high-order pages
Message-ID: <20231011124900.sp22hoxoitrslbia@techsingularity.net>
References: <20230920061856.257597-1-ying.huang@intel.com>
 <20230920061856.257597-4-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230920061856.257597-4-ying.huang@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 02:18:49PM +0800, Huang Ying wrote:
> In commit f26b3fa04611 ("mm/page_alloc: limit number of high-order
> pages on PCP during bulk free"), the PCP (Per-CPU Pageset) will be
> drained when PCP is mostly used for high-order pages freeing to
> improve the cache-hot pages reusing between page allocating and
> freeing CPUs.
> 
> On system with small per-CPU data cache, pages shouldn't be cached
> before draining to guarantee cache-hot.  But on a system with large
> per-CPU data cache, more pages can be cached before draining to reduce
> zone lock contention.
> 
> So, in this patch, instead of draining without any caching, "batch"
> pages will be cached in PCP before draining if the per-CPU data cache
> size is more than "4 * batch".
> 
> On a 2-socket Intel server with 128 logical CPU, with the patch, the
> network bandwidth of the UNIX (AF_UNIX) test case of lmbench test
> suite with 16-pair processes increase 72.2%.  The cycles% of the
> spinlock contention (mostly for zone lock) decreases from 45.8% to
> 21.2%.  The number of PCP draining for high order pages
> freeing (free_high) decreases 89.8%.  The cache miss rate keeps 0.3%.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

However, the flag should also have been documented to make it clear that
it preserves some pages on the PCP if the cache is large enough. Similar
to the previous patch, it would have been easier to reason about in the
general case if the decision had only been based on the LLC without
having to worry if any intermediate layer has a meaningful impact that
varies across CPU implementations.

-- 
Mel Gorman
SUSE Labs
