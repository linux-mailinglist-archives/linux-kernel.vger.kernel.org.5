Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52167EF5CF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 17:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbjKQQFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 11:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjKQQFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 11:05:02 -0500
Received: from outbound-smtp60.blacknight.com (outbound-smtp60.blacknight.com [46.22.136.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511C990
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 08:04:57 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp60.blacknight.com (Postfix) with ESMTPS id D8722FA856
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 16:04:55 +0000 (GMT)
Received: (qmail 17770 invoked from network); 17 Nov 2023 16:04:55 -0000
Received: from unknown (HELO mail.blacknight.com) (mgorman@techsingularity.net@[81.17.254.21])
  by 81.17.254.26 with ESMTPA; 17 Nov 2023 16:04:55 -0000
Date:   Fri, 17 Nov 2023 16:04:53 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Hildenbrand <david@redhat.com>,
        akpm@linux-foundation.org, wangkefeng.wang@huawei.com,
        willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC PATCH] mm: support large folio numa balancing
Message-ID: <20231117160453.dkbpwub7aq3jxksf@techsingularity.net>
References: <a71a478ce404e93683023dbb7248dd95f11554f4.1699872019.git.baolin.wang@linux.alibaba.com>
 <606d2d7a-d937-4ffe-a6f2-dfe3ae5a0c91@redhat.com>
 <871qctf89m.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <f22001bb-e474-4ddb-8440-2668e6cec000@linux.alibaba.com>
 <87sf57en8n.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20231117100745.fnpijbk4xgmals3k@techsingularity.net>
 <20231117101343.GH3818@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20231117101343.GH3818@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 11:13:43AM +0100, Peter Zijlstra wrote:
> On Fri, Nov 17, 2023 at 10:07:45AM +0000, Mel Gorman wrote:
> 
> > This leads into a generic problem with large anything with NUMA
> > balancing -- false sharing. As it stands, THP can be false shared by
> > threads if thread-local data is split within a THP range. In this case,
> > the ideal would be the THP is migrated to the hottest node but such
> > support doesn't exist. The same applies for folios. If not handled
> > properly, a large folio of any type can ping-pong between nodes so just
> > migrating because we can is not necessarily a good idea. The patch
> > should cover a realistic case why this matters, why splitting the folio
> > is not better and supporting data.
> 
> Would it make sense to have THP merging conditional on all (most?) pages
> having the same node?

Potentially yes, maybe with something similar to max_ptes_none, but it has
corner cases of it's own. THP can be allocated up-front so we don't get
the per-base-page hints unless the page is first split. I experimented
with this once upon a time but cost post-splitting was not offset by
the smarter NUMA placement. While we could always allocate small pages
and promote later (originally known as the promotion threshold), that
was known to have significant penalties of it's own so we still eagerly
allocate THP. Part of that is that KVM was the main load to benefit from
THP and always preferred eager promotion. Even if we always started with
base pages, sparse addressing within the THP range may mean the threshold
for collapsing can never be reached.

Both THP and folios have the same false sharing problem but at least
we knew about the false sharing problem for THP and NUMA balancing. It
was found initially that THP false sharing is mostly an edge-case issue
mitigated by the fact that large anonymous buffers tended to be either
2M aligned or only affected the boundaries. Later glibc and ABI changes
made it even more likely that private buffers were THP-aligned. The same
is not true of folios and it is a new problem so I'm uncomfortable with
a patch that essentially says "migrate folios because it's possible"
without considering any of the corner cases or measuring them.

-- 
Mel Gorman
SUSE Labs
