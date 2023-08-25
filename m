Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D727883F9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 11:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237650AbjHYJlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 05:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbjHYJkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 05:40:46 -0400
Received: from outbound-smtp23.blacknight.com (outbound-smtp23.blacknight.com [81.17.249.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DB01FD5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 02:40:43 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp23.blacknight.com (Postfix) with ESMTPS id 592CFBEEE9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 10:40:41 +0100 (IST)
Received: (qmail 15885 invoked from network); 25 Aug 2023 09:40:41 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.20.191])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 25 Aug 2023 09:40:41 -0000
Date:   Fri, 25 Aug 2023 10:40:39 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: page_alloc: remove stale CMA guard code
Message-ID: <20230825094039.w725owejmxsm7szt@techsingularity.net>
References: <20230824153821.243148-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230824153821.243148-1-hannes@cmpxchg.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 11:38:21AM -0400, Johannes Weiner wrote:
> In the past, movable allocations could be disallowed from CMA through
> PF_MEMALLOC_PIN. As CMA pages are funneled through the MOVABLE
> pcplist, this required filtering that cornercase during allocations,
> such that pinnable allocations wouldn't accidentally get a CMA page.
> 
> However, since 8e3560d963d2 ("mm: honor PF_MEMALLOC_PIN for all
> movable pages"), PF_MEMALLOC_PIN automatically excludes
> __GFP_MOVABLE. Once again, MOVABLE implies CMA is allowed.
> 
> Remove the stale filtering code. Also remove a stale comment that was
> introduced as part of the filtering code, because the filtering let
> order-0 pages fall through to the buddy allocator. See 1d91df85f399
> ("mm/page_alloc: handle a missing case for
> memalloc_nocma_{save/restore} APIs") for context. The comment's been
> obsolete since the introduction of the explicit ALLOC_HIGHATOMIC flag
> in eb2e2b425c69 ("mm/page_alloc: explicitly record high-order atomic
> allocations in alloc_flags").
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
