Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02167A20A0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 16:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235658AbjIOOQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 10:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235554AbjIOOQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 10:16:27 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03DD2119
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 07:16:12 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-7708bfce474so137147185a.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 07:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1694787371; x=1695392171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G2Uip1Uwb6xT/nQq1q2KQArOgZwENC9dRHuAMMnQr3I=;
        b=OmBS0rpOLsbiFXyFusRKkHMw0RreMC/+fndygAZlEybxsNTXozPJuxhqVKx988l41x
         Lh6adcxYNGA737YTOUFj5h6QDmzYe1r/YYhn1MfCrQy+9GMwT4qKgP0zvm2e7M9/QR9u
         /9UM4gEB9zYQgnN7+KjmvRTLO5a7ew58eTXnGPj7ThwxIAyL5MQBKguxtr670kW9yz/G
         iXyCs6b1nWQ2uqsDpYX7CAUFIhI9HFLVZVs5WiSkUEdWAAAmpXfcRaqchx46LB6QCiyF
         JUdyXC6NMkjArajMAgFW67zlgSAzAZBYwNwXXCvPzJVpT7EMwPPrZ28K4lbTcUQRUNqD
         aSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694787371; x=1695392171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2Uip1Uwb6xT/nQq1q2KQArOgZwENC9dRHuAMMnQr3I=;
        b=ZeybHf3SZ7S+vjGt7VAcwIvUltpYTmYLg/xq4HqhX6BqCZGJjNYmf2SJwY9y3HvCLB
         pWb/Mckm7MTV89/CItW1Q8q55tjmwqD+568A7wuTjK1T/rOeSz6GlX0m+/8UeW54INhs
         qrXHE2VIanT5Biwi4mqrYk3yCuRYwybS74kqBqmnhZ2VDVv3PyVNT6fIWiJtceBs7kPh
         iKqVM81jB2kR82acqCgcE98oKrJSyqH9R4HtHVuQ4g02Edb8PsI+3Octh+bGacSBkYpC
         QK/jT97MiwP84obP94/Kl8e/qBYEL4UC6Cx3Qk08PRJysz22d7zstk8CwHOtrDSSrtBq
         GijQ==
X-Gm-Message-State: AOJu0YwGlnMG9YsJ0ymNYk2q64+2VYy5D7NR+qUt1dbcQBvba1Gorgw7
        NRyXDkNoyJn3JiU/r4Zr8ey3kg==
X-Google-Smtp-Source: AGHT+IEbdBO57oa5jdADk6A7X6ER8G0uRza8ttdV8YUgsuA0bMwCeymVC7cGI7d5I5fqSa/F1F3j5Q==
X-Received: by 2002:a0c:f3cc:0:b0:655:e577:88e4 with SMTP id f12-20020a0cf3cc000000b00655e57788e4mr1996136qvm.32.1694787371633;
        Fri, 15 Sep 2023 07:16:11 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:35bb])
        by smtp.gmail.com with ESMTPSA id h3-20020a0cf443000000b0064f66ae4be3sm1300287qvm.88.2023.09.15.07.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 07:16:11 -0700 (PDT)
Date:   Fri, 15 Sep 2023 10:16:10 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/6] mm: page_alloc: freelist migratetype hygiene
Message-ID: <20230915141610.GA104956@cmpxchg.org>
References: <20230911195023.247694-1-hannes@cmpxchg.org>
 <20230914235238.GB129171@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914235238.GB129171@monkey>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 04:52:38PM -0700, Mike Kravetz wrote:
> In next-20230913, I started hitting the following BUG.  Seems related
> to this series.  And, if series is reverted I do not see the BUG.
> 
> I can easily reproduce on a small 16G VM.  kernel command line contains
> "hugetlb_free_vmemmap=on hugetlb_cma=4G".  Then run the script,
> while true; do
>  echo 4 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
>  echo 4 > /sys/kernel/mm/hugepages/hugepages-1048576kB/demote
>  echo 0 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
> done
> 
> For the BUG below I believe it was the first (or second) 1G page creation from
> CMA that triggered:  cma_alloc of 1G.
> 
> Sorry, have not looked deeper into the issue.

Thanks for the report, and sorry about the breakage!

I was scratching my head at this:

                        /* MIGRATE_ISOLATE page should not go to pcplists */
                        VM_BUG_ON_PAGE(is_migrate_isolate(mt), page);

because there is nothing in page isolation that prevents setting
MIGRATE_ISOLATE on something that's on the pcplist already. So why
didn't this trigger before already?

Then it clicked: it used to only check the *pcpmigratetype* determined
by free_unref_page(), which of course mustn't be MIGRATE_ISOLATE.

Pages that get isolated while *already* on the pcplist are fine, and
are handled properly:

                        mt = get_pcppage_migratetype(page);

                        /* MIGRATE_ISOLATE page should not go to pcplists */
                        VM_BUG_ON_PAGE(is_migrate_isolate(mt), page);

                        /* Pageblock could have been isolated meanwhile */
                        if (unlikely(isolated_pageblocks))
                                mt = get_pageblock_migratetype(page);

So this was purely a sanity check against the pcpmigratetype cache
operations. With that gone, we can remove it.

---

From b0cb92ed10b40fab0921002effa8b726df245790 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Fri, 15 Sep 2023 09:59:52 -0400
Subject: [PATCH] mm: page_alloc: remove pcppage migratetype caching fix

Mike reports the following crash in -next:

[   28.643019] page:ffffea0004fb4280 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x13ed0a
[   28.645455] flags: 0x200000000000000(node=0|zone=2)
[   28.646835] page_type: 0xffffffff()
[   28.647886] raw: 0200000000000000 dead000000000100 dead000000000122 0000000000000000
[   28.651170] raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
[   28.653124] page dumped because: VM_BUG_ON_PAGE(is_migrate_isolate(mt))
[   28.654769] ------------[ cut here ]------------
[   28.655972] kernel BUG at mm/page_alloc.c:1231!

This VM_BUG_ON() used to check that the cached pcppage_migratetype set
by free_unref_page() wasn't MIGRATE_ISOLATE.

When I removed the caching, I erroneously changed the assert to check
that no isolated pages are on the pcplist. This is quite different,
because pages can be isolated *after* they had been put on the
freelist already (which is handled just fine).

IOW, this was purely a sanity check on the migratetype caching. With
that gone, the check should have been removed as well. Do that now.

Reported-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e3f1c777feed..9469e4660b53 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1207,9 +1207,6 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 			count -= nr_pages;
 			pcp->count -= nr_pages;
 
-			/* MIGRATE_ISOLATE page should not go to pcplists */
-			VM_BUG_ON_PAGE(is_migrate_isolate(mt), page);
-
 			__free_one_page(page, pfn, zone, order, mt, FPI_NONE);
 			trace_mm_page_pcpu_drain(page, order, mt);
 		} while (count > 0 && !list_empty(list));
-- 
2.42.0

