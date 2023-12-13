Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD21181090B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 05:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378493AbjLMES3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 23:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235248AbjLMESY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 23:18:24 -0500
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451A6DB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 20:18:28 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <zhouchengming@bytedance.com>
Date:   Wed, 13 Dec 2023 04:17:59 +0000
Subject: [PATCH 2/5] mm/zswap: change dstmem size to one page
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231213-zswap-dstmem-v1-2-896763369d04@bytedance.com>
References: <20231213-zswap-dstmem-v1-0-896763369d04@bytedance.com>
In-Reply-To: <20231213-zswap-dstmem-v1-0-896763369d04@bytedance.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Nhat Pham <nphamcs@gmail.com>, Chris Li <chriscli@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Yosry Ahmed <yosryahmed@google.com>
Cc:     Nhat Pham <nphamcs@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Chengming Zhou <zhouchengming@bytedance.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702441093; l=1331;
 i=zhouchengming@bytedance.com; s=20231204; h=from:subject:message-id;
 bh=SLwC/l/d7alrAZPMCA93CoRFuL9N61Dk4roVdlkjgAA=;
 b=FqWQBihVstOvjrBfPRgfiP9wgadr1XURWEFeQL4WfiDUcr3D21m8m/22XnhX+6BfBtu8xruQ4
 Mq4yNgcfV1aAyr2EQ0oZOFiKr5LalUHvp2MuUSb5WHaHk5Paq/AcXW5
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

Change the dstmem size from 2 * PAGE_SIZE to only one page since
we only need at most one page when compress, and the "dlen" is also
PAGE_SIZE in acomp_request_set_params(). If the output size > PAGE_SIZE
we don't wanna store the output in zswap anyway.

So change it to one page, and delete the stale comment.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/zswap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index edb8b45ed5a1..fa186945010d 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -707,7 +707,7 @@ static int zswap_dstmem_prepare(unsigned int cpu)
 	struct mutex *mutex;
 	u8 *dst;
 
-	dst = kmalloc_node(PAGE_SIZE * 2, GFP_KERNEL, cpu_to_node(cpu));
+	dst = kmalloc_node(PAGE_SIZE, GFP_KERNEL, cpu_to_node(cpu));
 	if (!dst)
 		return -ENOMEM;
 
@@ -1662,8 +1662,7 @@ bool zswap_store(struct folio *folio)
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
