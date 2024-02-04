Return-Path: <linux-kernel+bounces-51389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA566848ABE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 04:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1898D1C21496
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 03:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3392879C1;
	Sun,  4 Feb 2024 03:06:20 +0000 (UTC)
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC327475
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 03:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707015979; cv=none; b=k8+eAtxYI2ElNJSiW8LPzFzzdLwhBuS0d0xfqIEYJG01Up+A9LIBpNwL6vmaB0JDrDMxU3CnGbEsIj9BvMchz7JkTQgewbO+3J/antaT0ODPtl73ob4j0gFEXppzC7yLzof0CtOFnaAhUL7b0X2T/EEcuZijzhLUNwXiH8R5C18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707015979; c=relaxed/simple;
	bh=Nle1CbTWygl79SjUtnzzQteGx1D4rVeb5GtGhT0DxKw=;
	h=Subject:MIME-Version:Content-Type:From:Date:Message-Id:To:Cc; b=WsxCsXyzFvalQz2Be6ZaiwU4l8IlX5BBt2rTrpPnUZzW8j4Zgqq5yQxUldTz+bQ9robM6IV30cQ1HV0PKbsOBs9pVQWzuL2FjuMq147YoRp2Vk2zu9d8kOPX6IznKRqOGMzWXwn68wATqtiZVcsFQ4hvoDAPwiGiiite4u+nVxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Subject: [PATCH v2 0/6] mm/zswap: optimize zswap lru list
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIABb/vmUC/42NQQrCMBBFr1Jm7UgamxRd9R7iImkGO1BTSWKklt7dwRO4+rwP//0NMiWmDJdmg0
 SVMy9RQB8aGCcX74QchEEr3SmtWvQdfvLbPZFjdTMHVwgplrSi7/tAzvbqpA3I3rtM6JOL4ySG+Jpn
 KSfOZUnr76+2Etd/1LVFhcZS6M7WWzJm8GuhIGo6jssDbvu+fwHL2bkYywAAAA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Sun, 04 Feb 2024 03:05:58 +0000
Message-Id: <20240201-b4-zswap-invalidate-entry-v2-0-99d4084260a0@bytedance.com>
To: Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-mm@kvack.org, Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <zhouchengming@bytedance.com>,
 linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>, Johannes Weiner <hannes@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

Changes in v2:
- Add comment above zswap_invalidate() to mention that large folio
  swap slot is not covered for now, per Yosry.
- Add comment about locking behaviour of LRU_STOP, per Yosry.
- Add the theory details and supportive testing results on why we
  choose the exclusive load as the default for zswap, per Johannes.
- Collect tags.
- Link to v1: https://lore.kernel.org/r/20240201-b4-zswap-invalidate-entry-v1-0-56ed496b6e55@bytedance.com

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
compress it again. Please see the commit for details on why
we choose exclusive load as the default for zswap.

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

 include/linux/list_lru.h |   2 +
 include/linux/zswap.h    |   4 +-
 mm/Kconfig               |  16 ------
 mm/list_lru.c            |   3 ++
 mm/swap_slots.c          |   3 ++
 mm/swapfile.c            |   1 -
 mm/zswap.c               | 136 ++++++++++++++++-------------------------------
 7 files changed, 56 insertions(+), 109 deletions(-)
---
base-commit: 3a92c45e4ba694381c46994f3fde0d8544a2088b
change-id: 20240201-b4-zswap-invalidate-entry-b77dea670325

Best regards,
-- 
Chengming Zhou <zhouchengming@bytedance.com>

