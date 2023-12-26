Return-Path: <linux-kernel+bounces-11557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A47E81E82C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 16:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB4DB282D52
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 15:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772774F8B3;
	Tue, 26 Dec 2023 15:54:53 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8855D4F61D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 15:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Tue, 26 Dec 2023 15:54:08 +0000
Subject: [PATCH v4 1/6] mm/zswap: change dstmem size to one page
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231213-zswap-dstmem-v4-1-f228b059dd89@bytedance.com>
References: <20231213-zswap-dstmem-v4-0-f228b059dd89@bytedance.com>
In-Reply-To: <20231213-zswap-dstmem-v4-0-f228b059dd89@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>, Seth Jennings <sjenning@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Vitaly Wool <vitaly.wool@konsulko.com>, Nhat Pham <nphamcs@gmail.com>, Chris Li <chriscli@google.com>,
 Yosry Ahmed <yosryahmed@google.com>, Dan Streetman <ddstreet@ieee.org>
Cc: linux-kernel@vger.kernel.org, Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org,
 Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>, Chris Li <chrisl@kernel.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703606082; l=2061;
 i=zhouchengming@bytedance.com; s=20231204; h=from:subject:message-id;
 bh=AFQJqRTNy44iATFj1RKZvqHU27WPg0GQMTPIPLqlpaM=;
 b=vEekGORU58JK/Xo7doVi9/xQDqn1SRUlc3hL7E1KvYToyqnm/hNB5CBcjOCkuqUuNL67fzR90
 Z+hf+n1SDUGCIkh8qx1cZk4a0ATT8In1GnwVY+KqUFhinM4gqqu4nFg
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
Acked-by: Chris Li <chrisl@kernel.org> (Google)
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

