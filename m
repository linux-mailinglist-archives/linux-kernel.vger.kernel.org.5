Return-Path: <linux-kernel+bounces-68280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB3E85781F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE9B2B23ACA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB09518AE0;
	Fri, 16 Feb 2024 08:55:36 +0000 (UTC)
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4E9182B3
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 08:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708073736; cv=none; b=oLvKwAS7ge3SOgdoxokRgUgXqZWW1IkBLDk5GIgLZsAPlV1kEdDvBlhNv2SREe2dJHl/GaFSNQ0tgm6/thwFhp9qu7R2OBMjo1bcwBWxNIuSVb8H34XkZG5ywdZnQ8q8N065ZabM7c5gWO5SN1u9tNVwFgz9jlEfQ3A7giflv1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708073736; c=relaxed/simple;
	bh=g1er5ZxKGtwUnNO2nECx4C2HNzvwfP85esZKor8Azfg=;
	h=Subject:MIME-Version:Content-Type:From:Date:Message-Id:To:Cc; b=GcSiB6D7HcLT8Qfpwk+aFrbDQu4M/ueuq8noXFKfVd+3k7V+XSp7Tw6d+BM2wLle1BHlnm9YYuvB3FwtCtk64V3znf+9WylBW+fGn9dCI04T4rEHSy+bNowwCne6iDNIAF9Z5AFdlTRh9sYhFWcRTMB9NG+GTnItj2L9d3ZQr1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Subject: [PATCH v3 0/2] mm/zswap: optimize for dynamic zswap_pools
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAOciz2UC/4XNOw7CMBAE0Ksg1xj5Rz5U3ANReOMlsWRiZCdGIcrdWVFSQLWakebtyjImj5mddi
 tLWHz2caSg9zvWDXbskXtHmSmhjFBS8Fd+2gfvQwQbeEgzb40zrZaVrBtgNAObkUOyYzfQcJxDoHLw
 eYpp+bwpks7lh1gkF7w5alNrV4Nw9gzLhI5EPHTxzq4EFvUPUYTcAFGDlLZS+I1s2/YGZv2onv4AAA A=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Fri, 16 Feb 2024 08:55:03 +0000
Message-Id: <20240210-zswap-global-lru-v3-0-200495333595@bytedance.com>
To: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org,
 Chengming Zhou <zhouchengming@bytedance.com>
X-Migadu-Flow: FLOW_OUT

Changes in v3:
- Improve the commit messages and comments, per Yosry.
- Use percpu_ref_is_zero() for debug purpose, per Yosry.
- Collect tag.
- Link to v2: https://lore.kernel.org/r/20240210-zswap-global-lru-v2-0-fbee3b11a62e@bytedance.com

Changes in v2:
- fix build error when !CONFIG_MEMCG_KMEM.
- make zswap struct static and fix some error paths, per Yosry.
- add another shrink_lock to protect zswap.next_shrink, per Yosry.
- keep "WARN_ON(percpu_ref_tryget(&pool->ref))" in pool release path
  for debug, per Nhat.
- improve the commit messages.
- Link to v1: https://lore.kernel.org/r/20240210-zswap-global-lru-v1-0-853473d7b0da@bytedance.com

Dynamic pool creation has been supported for a long time, which maybe
not used so much in practice. But with the per-memcg lru merged, the
current structure of zswap_pool's lru and shrinker become less optimal.

In the current structure, each zswap_pool has its own lru, shrinker and
shrink_work, but only the latest zswap_pool will be the current used.

1. When memory has pressure, all shrinkers of zswap_pools will try to
   shrink its lru list, there is no order between them.

2. When zswap limit hit, only the last zswap_pool's shrink_work will
   try to shrink its own lru, which is inefficient.

A more natural way is to have a global zswap lru shared between all
zswap_pools, and so is the shrinker. The code becomes much simpler too.

Another optimization is changing zswap_pool kref to percpu_ref, which
will be taken reference by every zswap entry. So the scalability is
better.

Testing kernel build (32 threads) in tmpfs with memory.max=2GB.
(zswap shrinker and writeback enabled with one 50GB swapfile,
on a 128 CPUs x86-64 machine, below is the average of 5 runs)

        mm-unstable  zswap-global-lru
real    63.20        63.12
user    1061.75      1062.95
sys     268.74       264.44

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
Chengming Zhou (2):
      mm/zswap: global lru and shrinker shared by all zswap_pools
      mm/zswap: change zswap_pool kref to percpu_ref

 mm/zswap.c | 207 +++++++++++++++++++++++++++----------------------------------
 1 file changed, 93 insertions(+), 114 deletions(-)
---
base-commit: 191d97734e41a5c9f90a2f6636fdd335ae1d435d
change-id: 20240210-zswap-global-lru-94d49316178b

Best regards,
-- 
Chengming Zhou <zhouchengming@bytedance.com>

