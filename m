Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AF67805D2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 08:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358015AbjHRGGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 02:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358010AbjHRGGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 02:06:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E5F3A9A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 23:06:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D24E363DA9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 06:05:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04F4C433C9;
        Fri, 18 Aug 2023 06:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692338759;
        bh=uh54hFbXQ/BfwpWzs/O+bKFUYp44N50ejYnxz4It+b0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=fnqnrGAnVQyXR1SS/0NXCLMP1X7tRNAp9dB+8XKfYgRvzDsbTaFsi/rxhGGW7IuU6
         +e+pSg5knwNBoIguA8cF0CMjDF1mPQDAkkk9o5tHAQ1OIq15vvfagkUnN3UFVye4IA
         y7lSunNnzFdJ/gUaPDMcBUoVZv+xg5EquAfE4ZPclYglXa8Za+JGEctXzdz7xeMloE
         7mipOXKSkwoNk+FJr0D+wIuuVlS5ESh4VTmOWRr5QBhsAx/fkt4lEZ6pdYaQ4ks/gU
         lPmxLd+NP4xvTdrGiwzYT6oBBvS6WT61fjeX0zl7HnBKfWhszwBaWETEUil8nFwrdT
         +JCr7unUVIkXg==
From:   Chris Li <chrisl@kernel.org>
Date:   Thu, 17 Aug 2023 23:05:23 -0700
Subject: [PATCH RFC 1/2] mm/page_alloc: safeguard free_pcppages_bulk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230817-free_pcppages_bulk-v1-1-c14574a9f80c@kernel.org>
References: <20230817-free_pcppages_bulk-v1-0-c14574a9f80c@kernel.org>
In-Reply-To: <20230817-free_pcppages_bulk-v1-0-c14574a9f80c@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        mgorman@techsingularity.net, Michal Hocko <mhocko@suse.com>,
        david@redhat.com, willy@infradead.org, linux-mm@kvack.org,
        Namhyung Kim <namhyung@google.com>,
        Greg Thelen <gthelen@google.com>, linux-kernel@vger.kernel.org,
        Chris Li <chrisl@kernel.org>,
        John Sperbeck <jsperbeck@google.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current free_pcppages_bulk() can panic when
pcp->count is changed outside of this function by
the BPF program injected in ftrace function entry.

Commit c66a36af7ba3a628 was to fix on the BPF program side
to not allocate memory inside the spinlock.

But the kernel can still panic loading similar BPF without the fix.
Here is the step to reproduce it:

$ git checkout 19030564ab116757e32
$ cd tools/perf
$ make perf
$ ./perf lock con -ab -- ./perf bench sched messaging

You should be able to see the kernel panic within 20 seconds.

Here is what happened in the panic:

count = min(pcp->count, count);

free_pcppages_bulk() assumes count and pcp->count are in sync.
There are no pcp->count changes outside of this function.

That assumption gets broken when BPF lock contention code
allocates memory inside spinlock. pcp->count is one less than
"count". The loop only checks against "count" and runs into
a deadloop because pcp->count drops to zero and all lists
are empty. In a deadloop pindex_min can grow bigger than pindex_max
and pindex_max can lower to negative. The kernel panic is happening
on the pindex trying to access outside of pcp->lists ranges.

Notice that this is just one of the (buggy) BPF programs that
can break it.  Other than the spin lock, there are other function
tracepoints under this function can be hooked up to the BPF program
which can allocate memory and change the pcp->count.

One argument is that BPF should not allocate memory under the
spinlock. On the other hand, the kernel can just check pcp->count
inside the loop to avoid the kernel panic.

Signed-off-by: Chris Li <chrisl@kernel.org>
Reported-by: John Sperbeck<jsperbeck@google.com>
---
 mm/page_alloc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1eb3864e1dbc7..347cb93081a02 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1215,12 +1215,6 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 	bool isolated_pageblocks;
 	struct page *page;
 
-	/*
-	 * Ensure proper count is passed which otherwise would stuck in the
-	 * below while (list_empty(list)) loop.
-	 */
-	count = min(pcp->count, count);
-
 	/* Ensure requested pindex is drained first. */
 	pindex = pindex - 1;
 
@@ -1266,7 +1260,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 
 			__free_one_page(page, page_to_pfn(page), zone, order, mt, FPI_NONE);
 			trace_mm_page_pcpu_drain(page, order, mt);
-		} while (count > 0 && !list_empty(list));
+		} while (count > 0 && pcp->count > 0 && !list_empty(list));
 	}
 
 	spin_unlock_irqrestore(&zone->lock, flags);

-- 
2.42.0.rc1.204.g551eb34607-goog

