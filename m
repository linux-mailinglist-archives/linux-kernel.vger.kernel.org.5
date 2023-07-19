Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C507C759126
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjGSJGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjGSJGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:06:36 -0400
Received: from outbound-smtp06.blacknight.com (outbound-smtp06.blacknight.com [81.17.249.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4DF2136
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:06:07 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp06.blacknight.com (Postfix) with ESMTPS id 8E15EC2B5B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 10:05:21 +0100 (IST)
Received: (qmail 3286 invoked from network); 19 Jul 2023 09:05:21 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.20.191])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 19 Jul 2023 09:05:21 -0000
Date:   Wed, 19 Jul 2023 10:05:18 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC 2/2] mm: alloc/free depth based PCP high auto-tuning
Message-ID: <20230719090518.67g7hascnfcly6hk@techsingularity.net>
References: <20230710065325.290366-3-ying.huang@intel.com>
 <ZK060sMG0GfC5gUS@dhcp22.suse.cz>
 <20230712090526.thk2l7sbdcdsllfi@techsingularity.net>
 <871qhcdwa1.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20230714140710.5xbesq6xguhcbyvi@techsingularity.net>
 <87pm4qdhk4.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20230717135017.7ro76lsaninbazvf@techsingularity.net>
 <87lefeca2z.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20230718123428.jcy4avtjg3rhuh7i@techsingularity.net>
 <87mszsbfx7.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <87mszsbfx7.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 01:59:00PM +0800, Huang, Ying wrote:
> > The big remaaining corner case to watch out for is where the sum
> > of the boosted pcp->high exceeds the low watermark.  If that should ever
> > happen then potentially a premature OOM happens because the watermarks
> > are fine so no reclaim is active but no pages are available. It may even
> > be the case that the sum of pcp->high should not exceed *min* as that
> > corner case means that processes may prematurely enter direct reclaim
> > (not as bad as OOM but still bad).
> 
> Sorry, I don't understand this.  When pages are moved from buddy to PCP,
> zone NR_FREE_PAGES will be decreased in rmqueue_bulk().  That is, pages
> in PCP will be counted as used instead of free.  And, in
> zone_watermark_ok*() and zone_watermark_fast(), zone NR_FREE_PAGES is
> used to check watermark.  So, if my understanding were correct, if the
> number of pages in PCP is larger than low/min watermark, we can still
> trigger reclaim.  Whether is my understanding correct?
> 

You're right, I didn't check the timing of the accounting and all that
occurred to me was "the timing of when watermarks trigger kswapd or
direct reclaim may change as a result of PCP adaptive resizing". Even
though I got the timing wrong, the shape of the problem just changes.
I suspect that excessively large PCP high relative to the watermarks may
mean that reclaim happens prematurely if too many pages are pinned by PCP
pages as the zone free pages approaches the watermark. While disabling
the adaptive resizing during reclaim will limit the worst of the problem,
it may still be the case that kswapd is woken early simply because there
are enough CPUs pinning pages in PCP lists. Similarly, depending on the
size of pcp->high and the gap between the watermarks, it's possible for
direct reclaim to happen prematurely. I could still be wrong because I'm
not thinking the problem through fully, examining the code or thinking
about the implementation. It's simply worth keeping in mind the impact
elevated PCP high values has on the timing of watermarks failing. If it's
complex enough, it may be necessary to have a separate patch dealing with
the impact of elevated pcp->high on watermarks.

-- 
Mel Gorman
SUSE Labs
