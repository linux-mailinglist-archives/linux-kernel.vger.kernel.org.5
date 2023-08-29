Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18D178C837
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 17:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235523AbjH2PCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 11:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237196AbjH2PCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:02:02 -0400
Received: from outbound-smtp51.blacknight.com (outbound-smtp51.blacknight.com [46.22.136.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7021B7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 08:01:57 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp51.blacknight.com (Postfix) with ESMTPS id 683FFFA77F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 16:01:55 +0100 (IST)
Received: (qmail 15764 invoked from network); 29 Aug 2023 15:01:55 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.20.191])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 29 Aug 2023 15:01:55 -0000
Date:   Tue, 29 Aug 2023 16:01:53 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        david@redhat.com, willy@infradead.org
Subject: Re: [PATCH v2 4/7] mm/compaction: simplify pfn iteration in
 isolate_freepages_range
Message-ID: <20230829150153.j4lw36s7yx5be7al@techsingularity.net>
References: <20230826153617.4019189-1-shikemeng@huaweicloud.com>
 <20230826153617.4019189-5-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230826153617.4019189-5-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 11:36:14PM +0800, Kemeng Shi wrote:
> We call isolate_freepages_block in strict mode, continuous pages in
> pageblock will be isolated if isolate_freepages_block successed.
> Then pfn + isolated will point to start of next pageblock to scan
> no matter how many pageblocks are isolated in isolate_freepages_block.
> Use pfn + isolated as start of next pageblock to scan to simplify the
> iteration.
> 
> The pfn + isolated always points to start of next pageblock as:
> In case isolated buddy page has order higher than pageblock:
> 1. page in buddy page is aligned with it's order
> 2. order of page is higher than pageblock order
> Then page is aligned with pageblock order. So pfn of page and isolated
> pages count are both aligned pageblock order. So pfn + isolated is
> pageblock order aligned.
> 
> In case isolated buddy page has order lower than pageblock:
> Buddy page with order N contains two order N - 1 pages as following:
> |        order N        |
> |order N - 1|order N - 1|
> So buddy pages with order N - 1 will never cross boudary of order N.
> Similar, buddy pages with order N - 2 will never cross boudary of order
> N - 1 and so on. Then any pages with order less than pageblock order
> will never crosa boudary of pageblock.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

While I don't think the patch is wrong, I also don't think it
meaningfully simplifies the code or optimises enough to be justified.
Even though a branch is eliminated, the whole path is not cheap.

-- 
Mel Gorman
SUSE Labs
