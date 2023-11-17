Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3477EEFC1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 11:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345778AbjKQKH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 05:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjKQKHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 05:07:55 -0500
Received: from outbound-smtp60.blacknight.com (outbound-smtp60.blacknight.com [46.22.136.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CFA85
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 02:07:50 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp60.blacknight.com (Postfix) with ESMTPS id E8D2EFB828
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 10:07:48 +0000 (GMT)
Received: (qmail 31407 invoked from network); 17 Nov 2023 10:07:48 -0000
Received: from unknown (HELO mail.blacknight.com) (mgorman@techsingularity.net@[81.17.254.19])
  by 81.17.254.26 with ESMTPA; 17 Nov 2023 10:07:48 -0000
Date:   Fri, 17 Nov 2023 10:07:45 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Hildenbrand <david@redhat.com>,
        akpm@linux-foundation.org, wangkefeng.wang@huawei.com,
        willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] mm: support large folio numa balancing
Message-ID: <20231117100745.fnpijbk4xgmals3k@techsingularity.net>
References: <a71a478ce404e93683023dbb7248dd95f11554f4.1699872019.git.baolin.wang@linux.alibaba.com>
 <606d2d7a-d937-4ffe-a6f2-dfe3ae5a0c91@redhat.com>
 <871qctf89m.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <f22001bb-e474-4ddb-8440-2668e6cec000@linux.alibaba.com>
 <87sf57en8n.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <87sf57en8n.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 10:58:32AM +0800, Huang, Ying wrote:
> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
> 
> > On 11/14/2023 9:12 AM, Huang, Ying wrote:
> >> David Hildenbrand <david@redhat.com> writes:
> >> 
> >>> On 13.11.23 11:45, Baolin Wang wrote:
> >>>> Currently, the file pages already support large folio, and supporting for
> >>>> anonymous pages is also under discussion[1]. Moreover, the numa balancing
> >>>> code are converted to use a folio by previous thread[2], and the migrate_pages
> >>>> function also already supports the large folio migration.
> >>>> So now I did not see any reason to continue restricting NUMA
> >>>> balancing for
> >>>> large folio.
> >>>
> >>> I recall John wanted to look into that. CCing him.
> >>>
> >>> I'll note that the "head page mapcount" heuristic to detect sharers will
> >>> now strike on the PTE path and make us believe that a large folios is
> >>> exclusive, although it isn't.
> >> Even 4k folio may be shared by multiple processes/threads.  So, numa
> >> balancing uses a multi-stage node selection algorithm (mostly
> >> implemented in should_numa_migrate_memory()) to identify shared folios.
> >> I think that the algorithm needs to be adjusted for PTE mapped large
> >> folio for shared folios.
> >
> > Not sure I get you here. In should_numa_migrate_memory(), it will use
> > last CPU id, last PID and group numa faults to determine if this page
> > can be migrated to the target node. So for large folio, a precise
> > folio sharers check can make the numa faults of a group more accurate,
> > which is enough for should_numa_migrate_memory() to make a decision?
> 
> A large folio that is mapped by multiple process may be accessed by one
> remote NUMA node, so we still want to migrate it.  A large folio that is
> mapped by one process but accessed by multiple threads on multiple NUMA
> node may be not migrated.
> 

This leads into a generic problem with large anything with NUMA
balancing -- false sharing. As it stands, THP can be false shared by
threads if thread-local data is split within a THP range. In this case,
the ideal would be the THP is migrated to the hottest node but such
support doesn't exist. The same applies for folios. If not handled
properly, a large folio of any type can ping-pong between nodes so just
migrating because we can is not necessarily a good idea. The patch
should cover a realistic case why this matters, why splitting the folio
is not better and supporting data.

-- 
Mel Gorman
SUSE Labs
