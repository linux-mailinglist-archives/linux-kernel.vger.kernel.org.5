Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFB3806B01
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 10:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377297AbjLFJqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 04:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377299AbjLFJqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 04:46:37 -0500
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [IPv6:2001:41d0:203:375::b0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FB8D53
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 01:46:42 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <zhouchengming@bytedance.com>
Date:   Wed, 06 Dec 2023 09:46:27 +0000
Subject: [PATCH 4/7] mm/zswap: change dstmem size to one page
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231206-zswap-lock-optimize-v1-4-e25b059f9c3a@bytedance.com>
References: <20231206-zswap-lock-optimize-v1-0-e25b059f9c3a@bytedance.com>
In-Reply-To: <20231206-zswap-lock-optimize-v1-0-e25b059f9c3a@bytedance.com>
To:     Vitaly Wool <vitaly.wool@konsulko.com>,
        Nhat Pham <nphamcs@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701855988; l=1265;
 i=zhouchengming@bytedance.com; s=20231204; h=from:subject:message-id;
 bh=HqwNJM8tE/N/sls10yfGIW7SQYFQNs7CH/U23vKZJJA=;
 b=vLSavMUZY2NbU7Ht3zXNimzw+b1It8sOxPqmY7gDO7tM7+foam8clg5CtKs4bOcNaCYz3xPso
 WsTwNYwXlA9BQKJg3zkaJ53yg9R0yBfDoIjVp0o2j0FWuC1shqBwv4r
X-Developer-Key: i=zhouchengming@bytedance.com; a=ed25519;
 pk=xFTmRtMG3vELGJBUiml7OYNdM393WOMv0iWWeQEVVdA=
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe I missed something, but the dstmem size of 2 * PAGE_SIZE is
very confusing, since we only need at most one page when compress,
and the "dlen" is also PAGE_SIZE in acomp_request_set_params().

So change it to one page, and fix the comments.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/zswap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index d93a7b58b5af..999671dcb469 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -699,7 +699,7 @@ static int zswap_dstmem_prepare(unsigned int cpu)
 	struct mutex *mutex;
 	u8 *dst;
 
-	dst = kmalloc_node(PAGE_SIZE * 2, GFP_KERNEL, cpu_to_node(cpu));
+	dst = kmalloc_node(PAGE_SIZE, GFP_KERNEL, cpu_to_node(cpu));
 	if (!dst)
 		return -ENOMEM;
 
@@ -1649,8 +1649,7 @@ bool zswap_store(struct folio *folio)
 	sg_init_table(&input, 1);
 	sg_set_page(&input, page, PAGE_SIZE, 0);
 
-	/* zswap_dstmem is of size (PAGE_SIZE * 2). Reflect same in sg_list */
-	sg_init_one(&output, dst, PAGE_SIZE * 2);
+	sg_init_one(&output, dst, PAGE_SIZE);
 	acomp_request_set_params(acomp_ctx->req, &input, &output, PAGE_SIZE, dlen);
 	/*
 	 * it maybe looks a little bit silly that we send an asynchronous request,

-- 
b4 0.10.1
