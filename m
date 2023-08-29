Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F3C78C1A4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbjH2Jjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbjH2JjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:39:17 -0400
Received: from outbound-smtp05.blacknight.com (outbound-smtp05.blacknight.com [81.17.249.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF799E
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:39:13 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp05.blacknight.com (Postfix) with ESMTPS id 3E70DCCC1E
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:39:12 +0100 (IST)
Received: (qmail 20350 invoked from network); 29 Aug 2023 09:39:12 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.20.191])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 29 Aug 2023 09:39:11 -0000
Date:   Tue, 29 Aug 2023 10:39:09 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        david@redhat.com, willy@infradead.org
Subject: Re: [PATCH v2 3/7] mm/compaction: correctly return failure with
 bogus compound_order in strict mode
Message-ID: <20230829093909.4hpria3qtouvdv6a@techsingularity.net>
References: <20230826153617.4019189-1-shikemeng@huaweicloud.com>
 <20230826153617.4019189-4-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230826153617.4019189-4-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 11:36:13PM +0800, Kemeng Shi wrote:
> In strict mode, we should return 0 if there is any hole in pageblock. If
> we successfully isolated pages at beginning at pageblock and then have a
> bogus compound_order outside pageblock in next page. We will abort search
> loop with blockpfn > end_pfn. Although we will limit blockpfn to end_pfn,
> we will treat it as a successful isolation in strict mode as blockpfn is
> not < end_pfn and return partial isolated pages. Then
> isolate_freepages_range may success unexpectly with hole in isolated
> range.
> 
> Fixes: 9fcd6d2e052ee ("mm, compaction: skip compound pages by order in free scanner")
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Modify the (likely(order <= MAX_ORDER)) block to avoid ever updating
blockpfn past the end of the pageblock. Then remove the second redundant
check.

-- 
Mel Gorman
SUSE Labs
