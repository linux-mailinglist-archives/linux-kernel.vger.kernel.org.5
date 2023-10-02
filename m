Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F3E7B5347
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237049AbjJBMdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbjJBMdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:33:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF51EAC
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 05:32:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABF03C15;
        Mon,  2 Oct 2023 05:33:37 -0700 (PDT)
Received: from [10.57.66.79] (unknown [10.57.66.79])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 545583F59C;
        Mon,  2 Oct 2023 05:32:56 -0700 (PDT)
Message-ID: <5caf5aee-9142-46f6-9a04-5b6e36880b21@arm.com>
Date:   Mon, 2 Oct 2023 13:32:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] Enable >0 order folio memory compaction
Content-Language: en-GB
To:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rohan Puri <rohan.puri15@gmail.com>,
        Mcgrof Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        John Hubbard <jhubbard@nvidia.com>
References: <20230912162815.440749-1-zi.yan@sent.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230912162815.440749-1-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zi,

On 12/09/2023 17:28, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Hi all,
> 
> This patchset enables >0 order folio memory compaction, which is one of
> the prerequisitions for large folio support[1]. It is on top of
> mm-everything-2023-09-11-22-56.

I've taken a quick look at these and realize I'm not well equipped to provide
much in the way of meaningful review comments; All I can say is thanks for
putting this together, and yes, I think it will become even more important for
my work on anonymous large folios.


> 
> Overview
> ===
> 
> To support >0 order folio compaction, the patchset changes how free pages used
> for migration are kept during compaction. Free pages used to be split into
> order-0 pages that are post allocation processed (i.e., PageBuddy flag cleared,
> page order stored in page->private is zeroed, and page reference is set to 1).
> Now all free pages are kept in a MAX_ORDER+1 array of page lists based
> on their order without post allocation process. When migrate_pages() asks for
> a new page, one of the free pages, based on the requested page order, is
> then processed and given out.
> 
> 
> Optimizations
> ===
> 
> 1. Free page split is added to increase migration success rate in case
> a source page does not have a matched free page in the free page lists.
> Free page merge is possible but not implemented, since existing
> PFN-based buddy page merge algorithm requires the identification of
> buddy pages, but free pages kept for memory compaction cannot have
> PageBuddy set to avoid confusing other PFN scanners.
> 
> 2. Sort source pages in ascending order before migration is added to
> reduce free page split. Otherwise, high order free pages might be
> prematurely split, causing undesired high order folio migration failures.

Not knowing much about how compaction actually works, naively I would imagine
that if you are just trying to free up a known amount of contiguous physical
space, then working through the pages in PFN order is more likely to yield the
result quicker? Unless all of the pages in the set must be successfully migrated
in order to free up the required amount of space...

Thanks,
Ryan

