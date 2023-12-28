Return-Path: <linux-kernel+bounces-12540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF5B81F67A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 10:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BB94B2163A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 09:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCBF6FA6;
	Thu, 28 Dec 2023 09:46:24 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB69163CD
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 09:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Subject: [PATCH v5 0/5] mm/zswap: dstmem reuse optimizations and cleanups
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAMVDjWUC/33NTQrCMBAF4KtI1kby15q48h7iYpIZbcC20tSKSu/u4FK0q+E9eN+8RKEhUxG71U
 sMNOWS+45DtV6J1EB3JpmRszDKWG20lc9yh6vEMrbUSvTGn6raWmVR8CRCIRkH6FLDo+52uXDZ5DL2
 w+PzYtJ8Dn+0SUslfai3DNYBldvHx0jIGm1S34ojY5NZAgwDCFBhAHIatr8AuwRYBhxBUiEGR4l+AW 4JcAycjPFRVQHRh29gnuc3d8znDnQBAAA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Thu, 28 Dec 2023 09:45:41 +0000
Message-Id: <20231213-zswap-dstmem-v5-0-9382162bbf05@bytedance.com>
To: Barry Song <21cnbao@gmail.com>, Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Dan Streetman <ddstreet@ieee.org>, Vitaly Wool <vitaly.wool@konsulko.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Chris Li <chriscli@google.com>, Seth Jennings <sjenning@redhat.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Chengming Zhou <zhouchengming@bytedance.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703756775; l=2769;
 i=zhouchengming@bytedance.com; s=20231204; h=from:subject:message-id;
 bh=HVI1JIYzdU7odrUyugqLS5ZpMBpfAXLpq1+kutx4nKw=;
 b=0ZIIj3q0AvnJDzfu1QIRATwdEZ4lGT8Sp64+BP+0MmtVvY8NBjuizS6I0A5yqJURcKS/GmKSh
 HqmUevQo/cEDsrYYuZujFQpKuvKBfv4KtWL89rCYgYtpKJ4J0+pifkM
X-Developer-Key: i=zhouchengming@bytedance.com; a=ed25519;
 pk=xFTmRtMG3vELGJBUiml7OYNdM393WOMv0iWWeQEVVdA=
X-Migadu-Flow: FLOW_OUT

Hi everyone,

Changes in v5:
- Drop the first patch and change to use 2 pages for acomp_ctx buffer.
  Related report link: https://lore.kernel.org/lkml/0000000000000b05cd060d6b5511@google.com/
- Add comment why we need 2 pages for compression in the last patch.
- Link to v4: https://lore.kernel.org/r/20231213-zswap-dstmem-v4-0-f228b059dd89@bytedance.com

Changes in v4:
- Collect Reviewed-by and Acked-by tags.
- Fold in the comment fix in zswap_writeback_entry() from Yosry Ahmed.
- Add patch to change per-cpu mutex and dstmem to per-acomp_ctx.
- Just rename crypto_acomp_ctx->dstmem field to buffer.
- Link to v3: https://lore.kernel.org/r/20231213-zswap-dstmem-v3-0-4eac09b94ece@bytedance.com

Changes in v3:
- Collect Reviewed-by tag.
- Drop the __zswap_store() refactoring part.
- Link to v2: https://lore.kernel.org/r/20231213-zswap-dstmem-v2-0-daa5d9ae41a7@bytedance.com

Changes in v2:
- Add more changelog and test data about changing dstmem to one page.
- Reorder patches to put dstmem reusing and __zswap_load() refactoring
  together, still refactor after dstmem reusing since we don't want
  to handle __zswap_load() failure due to memory allocation failure
  in zswap_writeback_entry().
- Append a patch to directly use percpu mutex and buffer in load/store
  and refactor out __zswap_store() to simplify zswap_store().
- Link to v1: https://lore.kernel.org/r/20231213-zswap-dstmem-v1-0-896763369d04@bytedance.com

This series is split from [1] to only include zswap dstmem reuse
optimizations and cleanups, the other part of rbtree breakdown will
be deferred to retest after the rbtree converted to xarray.

And the problem this series tries to optimize is that zswap_load()
and zswap_writeback_entry() have to malloc a temporary memory to
support !zpool_can_sleep_mapped(). We can avoid it by reusing the
percpu crypto_acomp_ctx->dstmem, which is also used by zswap_store()
and protected by the same percpu crypto_acomp_ctx->mutex.

[1] https://lore.kernel.org/all/20231206-zswap-lock-optimize-v1-0-e25b059f9c3a@bytedance.com/

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
Chengming Zhou (5):
      mm/zswap: reuse dstmem when decompress
      mm/zswap: refactor out __zswap_load()
      mm/zswap: cleanup zswap_load()
      mm/zswap: cleanup zswap_writeback_entry()
      mm/zswap: change per-cpu mutex and buffer to per-acomp_ctx

 include/linux/cpuhotplug.h |   1 -
 mm/zswap.c                 | 251 ++++++++++++++-------------------------------
 2 files changed, 76 insertions(+), 176 deletions(-)
---
base-commit: 1f242c1964cf9b8d663a2fd72159b296205a8126
change-id: 20231213-zswap-dstmem-d828f563303d

Best regards,
-- 
Chengming Zhou <zhouchengming@bytedance.com>

