Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1A67C6ECD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344005AbjJLNJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343765AbjJLNJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:09:27 -0400
Received: from outbound-smtp60.blacknight.com (outbound-smtp60.blacknight.com [46.22.136.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11DE91
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:09:25 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp60.blacknight.com (Postfix) with ESMTPS id 64163FB149
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 14:09:24 +0100 (IST)
Received: (qmail 469 invoked from network); 12 Oct 2023 13:09:24 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.197.19])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 12 Oct 2023 13:09:23 -0000
Date:   Thu, 12 Oct 2023 14:09:21 +0100
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
Subject: Re: [PATCH 01/10] mm, pcp: avoid to drain PCP when process exit
Message-ID: <20231012130921.mkcftgq4njnpl3qy@techsingularity.net>
References: <20230920061856.257597-1-ying.huang@intel.com>
 <20230920061856.257597-2-ying.huang@intel.com>
 <20231011124610.4punxroovolyvmgr@techsingularity.net>
 <20231011101617.2f814633defaa13e77308d9b@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20231011101617.2f814633defaa13e77308d9b@linux-foundation.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 10:16:17AM -0700, Andrew Morton wrote:
> On Wed, 11 Oct 2023 13:46:10 +0100 Mel Gorman <mgorman@techsingularity.net> wrote:
> 
> > > --- a/include/linux/mmzone.h
> > > +++ b/include/linux/mmzone.h
> > > @@ -676,12 +676,15 @@ enum zone_watermarks {
> > >  #define high_wmark_pages(z) (z->_watermark[WMARK_HIGH] + z->watermark_boost)
> > >  #define wmark_pages(z, i) (z->_watermark[i] + z->watermark_boost)
> > >  
> > > +#define	PCPF_PREV_FREE_HIGH_ORDER	0x01
> > > +
> > 
> > The meaning of the flag and its intent should have been documented.
> 
> I need to rebase mm-stable for other reasons.  So let's please
> decide (soon) whether Mel's review comments can be addressed
> via add-on patches or whether I should drop this version of this
> series altogether, during that rebase.

The cache slice calculation is the only change I think may deserve a
respin as it may have a material impact on the performance figures if the
"size_data" value changes by too much. Huang, what do you think and how
long do you think it would take to update the performance figures?  As it
may require multiple tests for each patch in the series, I would also be ok
with a follow-on patch like "mm: page_alloc: Simply cache size estimation
for PCP tuning" that documents the limitation of summing the unified caches
and the impact, if any, on performance. It makes for a messy history *but*
it would also record the reasons why summing hierarchies is not necessarily
the best approach which also has value.

I think patch 9 should be dropped as it has no impact on headline performance
while adding a relatively tricky heuristic that updates within a fast
path. Again, I'd like to give Huang a chance to respond and to evaluate
if it materially impacts patch 10 -- I don't think it does but I didn't
think very hard about it. Even if patch 9+10 had to be dropped, it would
not take much from the overall value of the series.

Comments and documentation alone are not grounds for pulling the series but
I hope they do get addressed in follow-on patches. I think requiring them
for accepting the series is unfair even if the only reason is I took too
long to review.

-- 
Mel Gorman
SUSE Labs
