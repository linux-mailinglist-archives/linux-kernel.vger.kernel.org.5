Return-Path: <linux-kernel+bounces-11556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B17BB81E82B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 16:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E31EA1C21388
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 15:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A384F881;
	Tue, 26 Dec 2023 15:54:51 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ECF4F612
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 15:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Subject: [PATCH v4 0/6] mm/zswap: dstmem reuse optimizations and cleanups
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAB/3imUC/33NywrCMBAF0F8pWRvJq4+48j/ExTQZbcC2ktRILf13B5eiXQ33wj2zsIQxYGKHYm
 ERc0hhHCiYXcFcB8MVefCUmRJKSyU1f6Un3LlPU489941qLmWltdCe0aSFhLyNMLiORsPjdqOyC2ka
 4/x5kSWd0x8tSy54Y6uawMp6YY7tPKEnDfdu7NmZsKy2AEWAByi9BTQS6l+A3gI0AQbBCdtagw6/gX Vd31Uw7PQzAQAA
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Tue, 26 Dec 2023 15:54:07 +0000
Message-Id: <20231213-zswap-dstmem-v4-0-f228b059dd89@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>, Seth Jennings <sjenning@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Vitaly Wool <vitaly.wool@konsulko.com>, Nhat Pham <nphamcs@gmail.com>, Chris Li <chriscli@google.com>,
 Yosry Ahmed <yosryahmed@google.com>, Dan Streetman <ddstreet@ieee.org>
Cc: linux-kernel@vger.kernel.org, Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org,
 Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>, Chris Li <chrisl@kernel.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703606082; l=2468;
 i=zhouchengming@bytedance.com; s=20231204; h=from:subject:message-id;
 bh=YQTxvUwsZzqyH52o9J1hnYzVus+yan/sec/bpXl9qAA=;
 b=vtscZKZGioQki3CX7H/cGeD1VGNfoxL3URCIQMIxd7QzKGd3qrywLLvUUXdtpdCeOU9lmh3Ng
 d+07cNETScAA7d8uf9HF1edMEzA2Rk8z++NIbW4xC6ZQstVMAFOSu1Q
X-Developer-Key: i=zhouchengming@bytedance.com; a=ed25519;
 pk=xFTmRtMG3vELGJBUiml7OYNdM393WOMv0iWWeQEVVdA=
X-Migadu-Flow: FLOW_OUT

Hi everyone,

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
Chengming Zhou (6):
      mm/zswap: change dstmem size to one page
      mm/zswap: reuse dstmem when decompress
      mm/zswap: refactor out __zswap_load()
      mm/zswap: cleanup zswap_load()
      mm/zswap: cleanup zswap_writeback_entry()
      mm/zswap: change per-cpu mutex and buffer to per-acomp_ctx

 include/linux/cpuhotplug.h |   1 -
 mm/zswap.c                 | 246 +++++++++++++--------------------------------
 2 files changed, 71 insertions(+), 176 deletions(-)
---
base-commit: 1f242c1964cf9b8d663a2fd72159b296205a8126
change-id: 20231213-zswap-dstmem-d828f563303d

Best regards,
-- 
Chengming Zhou <zhouchengming@bytedance.com>

