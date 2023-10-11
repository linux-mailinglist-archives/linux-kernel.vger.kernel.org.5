Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664927C54C2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbjJKNFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbjJKNFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:05:11 -0400
Received: from outbound-smtp01.blacknight.com (outbound-smtp01.blacknight.com [81.17.249.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FCB8F
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:05:09 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp01.blacknight.com (Postfix) with ESMTPS id D71CDC6048
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 14:05:07 +0100 (IST)
Received: (qmail 2271 invoked from network); 11 Oct 2023 13:05:07 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.197.19])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 11 Oct 2023 13:05:07 -0000
Date:   Wed, 11 Oct 2023 14:05:05 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH 00/10] mm: PCP high auto-tuning
Message-ID: <20231011130505.356soszayes3vy2n@techsingularity.net>
References: <20230920061856.257597-1-ying.huang@intel.com>
 <20230920094118.8b8f739125c6aede17c627e0@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230920094118.8b8f739125c6aede17c627e0@linux-foundation.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 09:41:18AM -0700, Andrew Morton wrote:
> On Wed, 20 Sep 2023 14:18:46 +0800 Huang Ying <ying.huang@intel.com> wrote:
> 
> > The page allocation performance requirements of different workloads
> > are often different.  So, we need to tune the PCP (Per-CPU Pageset)
> > high on each CPU automatically to optimize the page allocation
> > performance.
> 
> Some of the performance changes here are downright scary.
> 
> I've never been very sure that percpu pages was very beneficial (and
> hey, I invented the thing back in the Mesozoic era).  But these numbers
> make me think it's very important and we should have been paying more
> attention.
> 

FWIW, it is because not only does it avoid lock contention issues, it
avoids excessive splitting/merging of buddies as well as the slower
paths of the allocator. It is not very satisfactory and frankly, the
whole page allocator needs a revisit to account for very large zones but
it is far from a trivial project. PCP just masks the worst of the issues
and replacing it is far harder than tweaking it.

> > The list of patches in series is as follows,
> > 
> >  1 mm, pcp: avoid to drain PCP when process exit
> >  2 cacheinfo: calculate per-CPU data cache size
> >  3 mm, pcp: reduce lock contention for draining high-order pages
> >  4 mm: restrict the pcp batch scale factor to avoid too long latency
> >  5 mm, page_alloc: scale the number of pages that are batch allocated
> >  6 mm: add framework for PCP high auto-tuning
> >  7 mm: tune PCP high automatically
> >  8 mm, pcp: decrease PCP high if free pages < high watermark
> >  9 mm, pcp: avoid to reduce PCP high unnecessarily
> > 10 mm, pcp: reduce detecting time of consecutive high order page freeing
> > 
> > Patch 1/2/3 optimize the PCP draining for consecutive high-order pages
> > freeing.
> > 
> > Patch 4/5 optimize batch freeing and allocating.
> > 
> > Patch 6/7/8/9 implement and optimize a PCP high auto-tuning method.
> > 
> > Patch 10 optimize the PCP draining for consecutive high order page
> > freeing based on PCP high auto-tuning.
> > 
> > The test results for patches with performance impact are as follows,
> > 
> > kbuild
> > ======
> > 
> > On a 2-socket Intel server with 224 logical CPU, we tested kbuild on
> > one socket with `make -j 112`.
> > 
> > 	build time	zone lock%	free_high	alloc_zone
> > 	----------	----------	---------	----------
> > base	     100.0	      43.6          100.0            100.0
> > patch1	      96.6	      40.3	     49.2	      95.2
> > patch3	      96.4	      40.5	     11.3	      95.1
> > patch5	      96.1	      37.9	     13.3	      96.8
> > patch7	      86.4	       9.8	      6.2	      22.0
> > patch9	      85.9	       9.4	      4.8	      16.3
> > patch10	      87.7	      12.6	     29.0	      32.3
> 
> You're seriously saying that kbuild got 12% faster?
> 
> I see that [07/10] (autotuning) alone sped up kbuild by 10%?
> 
> Other thoughts:
> 
> - What if any facilities are provided to permit users/developers to
>   monitor the operation of the autotuning algorithm?
> 

Not that I've seen yet but I'm still in part of the series. It could be
monitored with tracepoints but it can also be inferred from lock
contention issue. I think it would only be meaningful to developers to
monitor this closely, at least that's what I think now. Honestly, I'm
more worried about potential changes in behaviour depending on the exact
CPU and cache implementation than I am about being able to actively
monitor it.

> - I'm not seeing any Documentation/ updates.  Surely there are things
>   we can tell users?
> 
> - This:
> 
>   : It's possible that PCP high auto-tuning doesn't work well for some
>   : workloads.  So, when PCP high is tuned by hand via the sysctl knob,
>   : the auto-tuning will be disabled.  The PCP high set by hand will be
>   : used instead.
> 
>   Is it a bit hacky to disable autotuning when the user alters
>   pcp-high?  Would it be cleaner to have a separate on/off knob for
>   autotuning?
> 

It might be but tuning the allocator is very specific and once we
introduce that tunable, we're probably stuck with it. I would prefer to
see it introduced if and only if we have to.

>   And how is the user to determine that "PCP high auto-tuning doesn't work
>   well" for their workload?

Not easily. It may manifest as variable lock contention issues when the
workload is at a steady state but that would increase the pressure to
split the allocator away from being zone-based entirely instead of tweaking
PCP further.

-- 
Mel Gorman
SUSE Labs
