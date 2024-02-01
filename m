Return-Path: <linux-kernel+bounces-48440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0014845C1A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A76E29AE6D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC1C626BB;
	Thu,  1 Feb 2024 15:50:20 +0000 (UTC)
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819CB626BE
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 15:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802619; cv=none; b=tie9Qhuo6bilgLx1evENGWtGZS/FwPnoAY0Z7gJc2vV/UrQZvkGQwNX0OuuK0LY/OdyADIEEH/vxqAWibvDK2DOZ9Cf7k2osmBT7eNHrjnF55rpKo3nbTTz21tzxebDh1N0mDIcY/LJurprPBUTYhnfGOIsctUEnRSzDJ6OjkYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802619; c=relaxed/simple;
	bh=xU3buMq542/mMylBw/4y0P4U7502NG24SzPKzrk0XA8=;
	h=Subject:MIME-Version:Content-Type:From:Date:Message-Id:To:Cc; b=fUlJ3MHshWuF9bvxU1DCxIH0DUE/xUazITg78oZvwTDj8TLVYWpVTg+je/0fsDXlf8tm02ZD7caUHYw6P6QsdRsPjJcs6uJE1sig0uhG0zhrhOC2FB0Fqg3RxxGykyiawV1p7GXyYoeskb5UOuh92/groAeVIPX0HEsploHwCQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Subject: [PATCH 0/6] mm/zswap: optimize zswap lru list
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAGy9u2UC/w3MTQqEMAxA4atI1gZqdabgbVIbxkCJ0viDinefLr/Few8YF2GDsXmg8CEmi1Z0bQ
 PTTPpjlFQN3vnBeddhHPC2k1YUPShLoo2RdSsXxhAS0ze43n+g9pGMMRbSaa4H3XN+3z91M6jccAAA AA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Thu, 01 Feb 2024 15:49:00 +0000
Message-Id: <20240201-b4-zswap-invalidate-entry-v1-0-56ed496b6e55@bytedance.com>
To: Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>,
 Yosry Ahmed <yosryahmed@google.com>
Cc: linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>, Chengming Zhou <zhouchengming@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org
X-Migadu-Flow: FLOW_OUT

Hi all,

This series is motivated when observe the zswap lru list shrinking,
noted there are some unexpected cases in zswap_writeback_entry().

bpftrace -e 'kr:zswap_writeback_entry {@[(int32)retval]=count()}'

There are some -ENOMEM because when the swap entry is freed to
per-cpu swap pool, it doesn't invalidate/drop zswap entry. Then
the shrinker encounter these trashy zswap entries, it can't be
reclaimed and return -ENOMEM.

So moves the invalidation ahead to when swap entry freed to the
per-cpu swap pool, since there is no any benefit to leave trashy
zswap entries on the zswap tree and lru list.

Another case is -EEXIST, which is seen more in the case of
!zswap_exclusive_loads_enabled, in which case the swapin folio
will leave compressed copy on the tree and lru list. And it
can't be reclaimed until the folio is removed from swapcache.

Changing to zswap_exclusive_loads_enabled mode will invalidate
when folio swapin, which has its own drawback if that folio
is still clean in swapcache and swapout again, we need to
compress it again. But it seems an unlikely case? I just send
it out for discussion. Please see the commit for details.

Another optimization for -EEXIST is that we add LRU_STOP to
support terminating the shrinking process to avoid evicting
warmer region.

Testing using kernel build in tmpfs, one 50GB swapfile and
zswap shrinker_enabled, with memory.max set to 2GB.

                mm-unstable   zswap-optimize
real               63.90s       63.25s
user             1064.05s     1063.40s
sys               292.32s      270.94s

The main optimization is in sys cpu, about 7% improvement.

Thanks for review and comments!

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
Chengming Zhou (6):
      mm/zswap: add more comments in shrink_memcg_cb()
      mm/zswap: invalidate zswap entry when swap entry free
      mm/zswap: stop lru list shrinking when encounter warm region
      mm/zswap: remove duplicate_entry debug value
      mm/zswap: only support zswap_exclusive_loads_enabled
      mm/zswap: zswap entry doesn't need refcount anymore

 include/linux/list_lru.h |   1 +
 include/linux/zswap.h    |   4 +-
 mm/Kconfig               |  16 ------
 mm/list_lru.c            |   3 ++
 mm/swap_slots.c          |   2 +
 mm/swapfile.c            |   1 -
 mm/zswap.c               | 136 ++++++++++++++++-------------------------------
 7 files changed, 54 insertions(+), 109 deletions(-)
---
base-commit: 3a92c45e4ba694381c46994f3fde0d8544a2088b
change-id: 20240201-b4-zswap-invalidate-entry-b77dea670325

Best regards,
-- 
Chengming Zhou <zhouchengming@bytedance.com>

