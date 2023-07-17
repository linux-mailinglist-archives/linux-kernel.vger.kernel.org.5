Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB53756576
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjGQNuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjGQNuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:50:23 -0400
Received: from outbound-smtp28.blacknight.com (outbound-smtp28.blacknight.com [81.17.249.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66CD94
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:50:20 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp28.blacknight.com (Postfix) with ESMTPS id 2E04BCCB70
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 14:50:19 +0100 (IST)
Received: (qmail 650 invoked from network); 17 Jul 2023 13:50:19 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.20.191])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 17 Jul 2023 13:50:18 -0000
Date:   Mon, 17 Jul 2023 14:50:17 +0100
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
Message-ID: <20230717135017.7ro76lsaninbazvf@techsingularity.net>
References: <20230710065325.290366-1-ying.huang@intel.com>
 <20230710065325.290366-3-ying.huang@intel.com>
 <ZK060sMG0GfC5gUS@dhcp22.suse.cz>
 <20230712090526.thk2l7sbdcdsllfi@techsingularity.net>
 <871qhcdwa1.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20230714140710.5xbesq6xguhcbyvi@techsingularity.net>
 <87pm4qdhk4.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <87pm4qdhk4.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 05:16:11PM +0800, Huang, Ying wrote:
> Mel Gorman <mgorman@techsingularity.net> writes:
> 
> > Batch should have a much lower maximum than high because it's a deferred cost
> > that gets assigned to an arbitrary task. The worst case is where a process
> > that is a light user of the allocator incurs the full cost of a refill/drain.
> >
> > Again, intuitively this may be PID Control problem for the "Mix" case
> > to estimate the size of high required to minimise drains/allocs as each
> > drain/alloc is potentially a lock contention. The catchall for corner
> > cases would be to decay high from vmstat context based on pcp->expires. The
> > decay would prevent the "high" being pinned at an artifically high value
> > without any zone lock contention for prolonged periods of time and also
> > mitigate worst-case due to state being per-cpu. The downside is that "high"
> > would also oscillate for a continuous steady allocation pattern as the PID
> > control might pick an ideal value suitable for a long period of time with
> > the "decay" disrupting that ideal value.
> 
> Maybe we can track the minimal value of pcp->count.  If it's small
> enough recently, we can avoid to decay pcp->high.  Because the pages in
> PCP are used for allocations instead of idle.

Implement as a separate patch. I suspect this type of heuristic will be
very benchmark specific and the complexity may not be worth it in the
general case.

> 
> Another question is as follows.
> 
> For example, on CPU A, a large number of pages are freed, and we
> maximize batch and high.  So, a large number of pages are put in PCP.
> Then, the possible situations may be,
> 
> a) a large number of pages are allocated on CPU A after some time
> b) a large number of pages are allocated on another CPU B
> 
> For a), we want the pages are kept in PCP of CPU A as long as possible.
> For b), we want the pages are kept in PCP of CPU A as short as possible.
> I think that we need to balance between them.  What is the reasonable
> time to keep pages in PCP without many allocations?
> 

This would be a case where you're relying on vmstat to drain the PCP after
a period of time as it is a corner case. You cannot reasonably detect the
pattern on two separate per-cpu lists without either inspecting remote CPU
state or maintaining global state. Either would incur cache miss penalties
that probably cost more than the heuristic saves.

-- 
Mel Gorman
SUSE Labs
