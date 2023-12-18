Return-Path: <linux-kernel+bounces-3504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E501816D28
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FDC61C2331F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E495335888;
	Mon, 18 Dec 2023 11:50:43 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83D335282
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 11:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Subject: [PATCH v3 0/6] mm/zswap: dstmem reuse optimizations and cleanups
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAAYygGUC/33NywrCMBAF0F8pWRvJo09X/oe4mHZGG2jTktRILf13B5eCroZ74Z7ZRKTgKIpTto
 lAyUU3eQ72kImuB38n6ZCzMMpYbbSVr/iEWWJcRhol1qa+FaW1yqLgSQuRZBvAdz2P/GMYuOxdXKaw
 fl4kzefyQ0taKlk3ZcVg2aDKz+26ELJGx24axZWxZP4BhgEEKLAByjVU38C+72+9xmDV8gAAAA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Mon, 18 Dec 2023 11:50:30 +0000
Message-Id: <20231213-zswap-dstmem-v3-0-4eac09b94ece@bytedance.com>
To: Seth Jennings <sjenning@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, Vitaly Wool <vitaly.wool@konsulko.com>,
 Dan Streetman <ddstreet@ieee.org>, Johannes Weiner <hannes@cmpxchg.org>, Chris Li <chriscli@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>
Cc: Chris Li <chrisl@kernel.org>, Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org,
 Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, Nhat Pham <nphamcs@gmail.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702900234; l=2082;
 i=zhouchengming@bytedance.com; s=20231204; h=from:subject:message-id;
 bh=L8x6KYYzMw8PAizyBBXr2eeH9yLgNTCwGP96aZA5ke0=;
 b=qtdZDlnipwv56Yz76sAz57UAeGKlswtXjtwY43QfKjITSQACoYeG0j5Bb4gDUS4t8hFdZYK5h
 oeibYk1o3/4DbUrMH6cUKspJSbCbYcbz+XVTUqsLgmTywADAlh3z3Nx
X-Developer-Key: i=zhouchengming@bytedance.com; a=ed25519;
 pk=xFTmRtMG3vELGJBUiml7OYNdM393WOMv0iWWeQEVVdA=
X-Migadu-Flow: FLOW_OUT

Hi everyone,

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
      mm/zswap: directly use percpu mutex and buffer in load/store

 mm/zswap.c | 209 +++++++++++++++++++++++--------------------------------------
 1 file changed, 77 insertions(+), 132 deletions(-)
---
base-commit: 1f242c1964cf9b8d663a2fd72159b296205a8126
change-id: 20231213-zswap-dstmem-d828f563303d

Best regards,
-- 
Chengming Zhou <zhouchengming@bytedance.com>

