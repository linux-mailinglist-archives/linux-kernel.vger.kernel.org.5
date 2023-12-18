Return-Path: <linux-kernel+bounces-3147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AF58167F3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD2661F20FF3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889DE134A8;
	Mon, 18 Dec 2023 08:22:35 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640E712B61
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Mon, 18 Dec 2023 08:22:00 +0000
Subject: [PATCH v2 1/6] mm/zswap: change dstmem size to one page
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231213-zswap-dstmem-v2-1-daa5d9ae41a7@bytedance.com>
References: <20231213-zswap-dstmem-v2-0-daa5d9ae41a7@bytedance.com>
In-Reply-To: <20231213-zswap-dstmem-v2-0-daa5d9ae41a7@bytedance.com>
To: Seth Jennings <sjenning@redhat.com>, Dan Streetman <ddstreet@ieee.org>, Chris Li <chriscli@google.com>,
 Nhat Pham <nphamcs@gmail.com>, Vitaly Wool <vitaly.wool@konsulko.com>, Yosry Ahmed <yosryahmed@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-kernel@vger.kernel.org, Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org, Yosry Ahmed <yosryahmed@google.com>,
 Chengming Zhou <zhouchengming@bytedance.com>, Chris Li <chrisl@kernel.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702887745; l=2012;
 i=zhouchengming@bytedance.com; s=20231204; h=from:subject:message-id;
 bh=knbPWkl1sBJOnq5pAv9yoWZfZi+/5lFRxFAsoTFiAeI=;
 b=wLIslRILYEE+m1faC45+NiuKmvx2YOrqYhYxcwRKSBnB/cOfAH9ePkRU4ZggKvwoWRd8ApqOE
 G59vRbwGIL6Cj27KS5MZI/t6FgZ7RE6FdEjYEhi/qQPb2ilNgqbCYBz
X-Developer-Key: i=zhouchengming@bytedance.com; a=ed25519;
 pk=xFTmRtMG3vELGJBUiml7OYNdM393WOMv0iWWeQEVVdA=
X-Migadu-Flow: FLOW_OUT

Change the dstmem size from 2 * PAGE_SIZE to only one page since
we only need at most one page when compress, and the "dlen" is also
PAGE_SIZE in acomp_request_set_params(). If the output size > PAGE_SIZE
we don't wanna store the output in zswap anyway.

So change it to one page, and delete the stale comment.

There is no any history about the reason why we needed 2 pages, it has
been 2 * PAGE_SIZE since the time zswap was first merged.

According to Yosry and Nhat, one potential reason is that we used to
store a zswap header containing the swap entry in the compressed page
for writeback purposes, but we don't do that anymore.

This patch works good in kernel build testing even when the input data
doesn't compress at all (i.e. dlen == PAGE_SIZE), which we can see
from the bpftrace tool:

bpftrace -e 'k:zpool_malloc {@[(uint32)arg1==4096]=count()}'
@[1]: 2
@[0]: 12011430

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/zswap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 7ee54a3d8281..976f278aa507 100644
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

