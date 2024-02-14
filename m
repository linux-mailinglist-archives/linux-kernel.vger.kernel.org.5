Return-Path: <linux-kernel+bounces-64897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48107854469
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03CB028D490
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6080EAD2C;
	Wed, 14 Feb 2024 08:54:51 +0000 (UTC)
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E10879C0
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 08:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707900891; cv=none; b=KJVuksEDk9255n+s1y9fsjgJV+zeCxfxk9eHxhM6Dznew5c5qLgwGdHc5p6dS/XKP/8EvPvJm+RifBno1JmDyF5Vl44CSBcJLXN3qmr+qt3+mLtjaNX0gFl/VJavpuK9/SE0n+aw5NZwl6pTnECg8X/Cze+Xm8EWMqdkNPQNhJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707900891; c=relaxed/simple;
	bh=wl+vlR0haJswwYPNHJQRSnp3rCianEqOgPnnEcPTFNQ=;
	h=Subject:MIME-Version:Content-Type:From:Date:Message-Id:To:Cc; b=oPBmZT1K9ZyuzHW6Hgce9CfptHrf4z6Z6CtAmv61CLyLNXDv6Z330z+2Z/r+tXG8FlBg+ucAE7OXgEXB4b96YxW1YeSrL2hl6diAIAA2Ux2abWwBbAqV00qhk+WoWZuBYNwsuIaMbVaWmLB+SVaNpDmUKz3cZQpjW5Ni3dCtQ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Subject: [PATCH v2 0/2] mm/zswap: optimize for dynamic zswap_pools
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAMx/zGUC/32NQQ6CMBBFr0Jm7Zi2VAFX3sO4aOkEmtSWtIBBwt2deABXP+8n7/8dCmVPBW7VDp
 lWX3yKDOpUQT+aOBB6xwxKKC2UFPgpbzPhEJI1AUNesNNOd7W8yqa1wJo1hdBmE/uRxbiEwOXoy5zy
 9rtZJcfjz+IqUWB7qXVTu8YKZ+52m8nxIp379ILncRxfvcFj+bkAAAA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Wed, 14 Feb 2024 08:54:36 +0000
Message-Id: <20240210-zswap-global-lru-v2-0-fbee3b11a62e@bytedance.com>
To: Yosry Ahmed <yosryahmed@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>,
 Nhat Pham <nphamcs@gmail.com>
Cc: linux-mm@kvack.org, Chengming Zhou <zhouchengming@bytedance.com>, linux-kernel@vger.kernel.org
X-Migadu-Flow: FLOW_OUT



---
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

To: Andrew Morton <akpm@linux-foundation.org>
To: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
To: Nhat Pham <nphamcs@gmail.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

---
Chengming Zhou (2):
      mm/zswap: global lru and shrinker shared by all zswap_pools
      mm/zswap: change zswap_pool kref to percpu_ref

 mm/zswap.c | 201 ++++++++++++++++++++++++++-----------------------------------
 1 file changed, 87 insertions(+), 114 deletions(-)
---
base-commit: 191d97734e41a5c9f90a2f6636fdd335ae1d435d
change-id: 20240210-zswap-global-lru-94d49316178b

Best regards,
-- 
Chengming Zhou <zhouchengming@bytedance.com>

