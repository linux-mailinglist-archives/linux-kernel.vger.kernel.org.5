Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF14A7C885F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbjJMPNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 11:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbjJMPNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:13:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A8895
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 08:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BOh82QvDFZhJOtnIgbuStQUDwvPFQ9iupCs1NikscMw=; b=NW+tvKqeZ0wjPGq7fFq6dMhae3
        TS9ygR0E3gU67YisMzAFIgo3fe32bEPTBSQh53LYVPYwLVDmHBxEpYMnBFEdHlHOug4EnBcG0LqHX
        WCl9oX3bokAQUPTK0jmkt1AATxNuwD/Sh9x12A76R3IFYk0IzqUAHq8ijIUtkUu8qK6B96521FMn2
        gfpG/H+9Wpw1xIbsvIP+L+3BUMbtGERHqRbuukPehdqfR1uQm6vcuNtj2m6CYeu3VWKObbnv45vGs
        pclH9hg6P7q3Rl9YR8ZodXdgKu9X4GWcGXzDr3pHZCYkM2BklT7c2+agus4kQ3zyN9Ax9rLe2IL4N
        gkvnN5OA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qrJqt-0064bK-3u; Fri, 13 Oct 2023 15:13:23 +0000
Date:   Fri, 13 Oct 2023 16:13:23 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ying.huang@intel.com,
        david@redhat.com, Zi Yan <ziy@nvidia.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH -next v2 09/19] mm: mprotect: use a folio in
 change_pte_range()
Message-ID: <ZSlekx1pYOh7ltaF@casper.infradead.org>
References: <20231013085603.1227349-1-wangkefeng.wang@huawei.com>
 <20231013085603.1227349-10-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013085603.1227349-10-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 04:55:53PM +0800, Kefeng Wang wrote:
> Use a folio in change_pte_range() to save three compound_head() calls.

Yes, but here we have a change of behaviour, which should be argued
is desirable.  Before if a partial THP was mapped, or a fs large
folio, we would do this to individual pages.  Now we're doing it to the
entire folio.  Is that desirable?  I don't have the background to argue
either way.

> @@ -157,7 +159,7 @@ static long change_pte_range(struct mmu_gather *tlb,
>  					continue;
>  				if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
>  				    !toptier)
> -					xchg_page_access_time(page,
> +					folio_xchg_access_time(folio,
>  						jiffies_to_msecs(jiffies));
>  			}
