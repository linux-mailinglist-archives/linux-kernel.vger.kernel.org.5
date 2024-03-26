Return-Path: <linux-kernel+bounces-119742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B215688CC9F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 315B01F66BAE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC73A13CA8E;
	Tue, 26 Mar 2024 19:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvvYb2t8"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1B9481A3
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 19:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711479858; cv=none; b=JuKLh1/29cPJKxSPYqEd3DaNr+MHv/kBRbhO6gar6hSfRfNWchN0M28DiC7OvHW+DraBm96eHN0PFPvNlhC78R7e6Y93oFegIN1PtTsHP6ITpflhce25SuWp7GgRXAV70/0rH9QMHA7u8gaG1m/gMToQ9YzuDV2Q7OzmgKJAPeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711479858; c=relaxed/simple;
	bh=8oXfY1G0fS4+cZF7nOtvS+yOZ5bqzBFtNVsaZMiqpq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kt8TJUAhuUXwiG6scjfTQgUiJ6LeOZu6jVxs6phlvXD4aD556M8DQ5BUa4QZWlyqLgWcGb9vUv4w9pzIna62tQ3y6oW8cIwAy6ocQw0cImpR18CY8NIzfPpDJ1Cr63zoPwfNosqguuPYxmpBS7NYSSrtE0P/4pE2gyoLvXHISEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvvYb2t8; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e6b729669bso4905337b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711479856; x=1712084656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5TWiE8V41/HEEkIeCCX/V6RExr75EhLxd3ozyRzvmEY=;
        b=hvvYb2t8am16UzGiCvmlX0iUDC/W1g7319xs4LyBqGgmbSRBKSkfBXCSNBBJh1kI4b
         wVazyLHT+Ndkyi4HT+BMEeysZD9WAQAJ/3/1YXj6VjpLkw1LU17dFMzRr0HBoZhs7117
         KUq46Oyu8X3UPGYABwhpbbmxAR3lI9uCf6tyeQKjzMDUWffWeIHsJzN7KMOu4T4HbJG5
         6WOeikZHM5BdanaHmjxKWy4qVzxiB/AtrpkMERXUp0JZy8VZDCLug4OdrqSdHtsElvwy
         wBT1Sjnn4w4jXQ8Kve/zVypEHLGyzxVYqqpjIVMyi/zE4MuAjTfNIs0lmOq2YnPaO5Ke
         wHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711479856; x=1712084656;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TWiE8V41/HEEkIeCCX/V6RExr75EhLxd3ozyRzvmEY=;
        b=u8Au+jibBCHzTznWEZWc3Fh5w82RZ5kffVcNCTJtrKjekfEoti+utc5/QT2XIOj3/b
         /lwvtIWBL2omEWxM4Od9DEXhctvR2LoJmgU++88kWdvPZtDrvUi/1P1a4McWtiQMCuIc
         XbFbwfv+tgKmUGvb4sdQWPnTGeJBZv3F0N/1XZrg6x88SU+qW4jvjfza2PGISdMF5S9i
         J21NjnVMG3hkHGqz9A22NuGOzcPFqYR8frAUfC/RkWAqUlI/JCaOUQN932N3yPCKsGUG
         PVOZp3u3l+LR7CEqBLwg78ZXxrqXWf6nTZBNywPBzFDlWop/duyZq1HqKOOxTFE/XbcZ
         4/PQ==
X-Forwarded-Encrypted: i=1; AJvYcCXp/B5cvPhInBeEjXEilWUdYxAwkoVtB/aR5XVS9za6a9HUGmAE684lOB/7dI8ERTtzotihJ6XyMSoMSKu1EKs+JIrjaqV+WHauhhfJ
X-Gm-Message-State: AOJu0YyKI5mW4Z9Ti3NbJ5tyYpCU/LoRIcJDZmW2kL3pQKlDso8AXAo5
	IqHGiAp5AYLQpLlA1oFBSTJaWRTByBIg+Cz1ihXghDEUrZcLMBKved1vfzBaAp0PtfUB
X-Google-Smtp-Source: AGHT+IFIfGQ6R0T488evah4toOxvgSsRkizRRM/1ePf0r5KQNN9KPJ5OobJvjzwCnxXLpwoSk0Kw3w==
X-Received: by 2002:a05:6a00:1996:b0:6ea:ad01:3590 with SMTP id d22-20020a056a00199600b006eaad013590mr6937777pfl.24.1711479856357;
        Tue, 26 Mar 2024 12:04:16 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([115.171.40.106])
        by smtp.gmail.com with ESMTPSA id j14-20020aa783ce000000b006ea790c2232sm6298350pfn.79.2024.03.26.12.04.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 Mar 2024 12:04:15 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: "Huang, Ying" <ying.huang@intel.com>,
	Chris Li <chrisl@kernel.org>,
	Minchan Kim <minchan@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yu Zhao <yuzhao@google.com>,
	SeongJae Park <sj@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [RFC PATCH 00/10] mm/swap: always use swap cache for synchronization
Date: Wed, 27 Mar 2024 02:50:22 +0800
Message-ID: <20240326185032.72159-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.43.0
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

A month ago a bug was fixed for SWP_SYNCHRONOUS_IO swapin (swap cache
bypass swapin):
https://lore.kernel.org/linux-mm/20240219082040.7495-1-ryncsn@gmail.com/

Because we have to spin on the swap map on race, and swap map is too small
to contain more usable info, an ugly schedule_timeout_uninterruptible(1)
is added. It's not the first time a hackish workaround was added for cache
bypass swapin and not the last time. I did many experiments locally to
see if the swap cache bypass path can be dropped while keeping the
performance still comparable. And it seems doable.

This series does the following things:
1. Remove swap cache bypass completely.
2. Apply multiple optimizations after that, these optimizations are
   either undoable or very difficult to do without dropping the cache
   bypass swapin path.
3. Use swap cache as a synchronization layer, also unify some code
   with page cache (filemap).

As a result, we have:
1. A comparable performance, some tests are even faster.
2. Multi-index support for swap cache.
3. Removed many hackish workarounds including above long tailing
   issue is gone.

Sending this as RFC to collect some discussion, suggestion, or rejection
early, this seems need to be split into multiple series, but the
performance is not good until the last patch so I think start by
seperating them may make this approach not very convincing. And there
are still some (maybe further) TODO items and optimization space
if we are OK with this approach.

This is based on my another series, for reusing filemap code for swapcache:
[PATCH v2 0/4] mm/filemap: optimize folio adding and splitting
https://lore.kernel.org/linux-mm/20240325171405.99971-1-ryncsn@gmail.com/

Patch 1/10, introduce a helper from filemap side to be used later.
Patch 2/10, 3/10 are clean up and prepare for removing the swap cache
  bypass swapin path.
Patch 4/10, removed the swap cache bypass swapin path, and the
  performance drop heavily (-28%).
Patch 5/10, apply the first optimization after the removal, since all
  folios goes through swap cache now, there is no need to explicit shadow
  clearing any more.
Patch 6/10, apply another optimization after clean up shadow clearing
  routines. Now swapcache is very alike page cache, so just reuse page
  cache code and we will have multi-index support. Shadow memory usage
  dropped a lot.
Patch 7/10, just rename __read_swap_cache_async, it will be refactored
  and a key part of this series, and the naming is very confusing to me.
Patch 8/10, make swap cache as a synchronization layer, introduce two
  helpers for adding folios to swap cache, caller will either succeed or
  get a folio to wait on.
Patch 9/10, apply another optimization. With above two helpers, looking
  up of swapcache can be optimized and avoid false looking up, which
  helped improve the performance.
Patch 10/10, apply a major optimization for SWP_SYNCHRONOUS_IO devices,
  after this commit, performance for simple swapin/swapout is basically
  same as before.

Test 1, sequential swapin/out of 30G zero page on ZRAM:

               Before (us)        After (us)
Swapout:       33619409           33886008
Swapin:        32393771           32465441 (- 0.2%)
Swapout (THP): 7817909            6899938  (+11.8%)
Swapin (THP) : 32452387           33193479 (- 2.2%)

And after swapping out 30G with THP, the radix node usage dropped by a
lot:

Before: radix_tree_node 73728K
After:  radix_tree_node  7056K (-94%)

Test 2:
Mysql (16g buffer pool, 32G ZRAM SWAP, 4G memcg, Zswap disabled, THP never)
  sysbench /usr/share/sysbench/oltp_read_only.lua --mysql-user=root \
  --mysql-password=1234 --mysql-db=sb --tables=36 --table-size=2000000 \
  --threads=48 --time=300 --report-interval=10 run

Before: transactions: 4849.25 per sec
After:  transactions: 4849.40 per sec

Test 3:
Mysql (16g buffer pool, NVME SWAP, 4G memcg, Zswap enabled, THP never)
  echo never > /sys/kernel/mm/transparent_hugepage/enabled
  echo 100 > /sys/module/zswap/parameters/max_pool_percent
  echo 1 > /sys/module/zswap/parameters/enabled
  echo y > /sys/module/zswap/parameters/shrinker_enabled

  sysbench /usr/share/sysbench/oltp_read_only.lua --mysql-user=root \
  --mysql-password=1234 --mysql-db=sb --tables=36 --table-size=2000000 \
  --threads=48 --time=600 --report-interval=10 run

Before: transactions: 1662.90 per sec
After:  transactions: 1726.52 per sec

Test 4:
Mysql (16g buffer pool, NVME SWAP, 4G memcg, Zswap enabled, THP always)
  echo always > /sys/kernel/mm/transparent_hugepage/enabled
  echo 100 > /sys/module/zswap/parameters/max_pool_percent
  echo 1 > /sys/module/zswap/parameters/enabled
  echo y > /sys/module/zswap/parameters/shrinker_enabled

  sysbench /usr/share/sysbench/oltp_read_only.lua --mysql-user=root \
  --mysql-password=1234 --mysql-db=sb --tables=36 --table-size=2000000 \
  --threads=48 --time=600 --report-interval=10 run

Before: transactions: 2860.90 per sec.
After:  transactions: 2802.55 per sec.

Test 5:
Memtier / memcached (16G brd SWAP, 8G memcg, THP never):

  memcached -u nobody -m 16384 -s /tmp/memcached.socket -a 0766 -t 16 -B binary &

  memtier_benchmark -S /tmp/memcached.socket \
    -P memcache_binary -n allkeys --key-minimum=1 \
    --key-maximum=24000000 --key-pattern=P:P -c 1 -t 16 \
    --ratio 1:0 --pipeline 8 -d 1000

Before: 106730.31 Ops/sec
After:  106360.11 Ops/sec

Test 5:
Memtier / memcached (16G brd SWAP, 8G memcg, THP always):

  memcached -u nobody -m 16384 -s /tmp/memcached.socket -a 0766 -t 16 -B binary &

  memtier_benchmark -S /tmp/memcached.socket \
    -P memcache_binary -n allkeys --key-minimum=1 \
    --key-maximum=24000000 --key-pattern=P:P -c 1 -t 16 \
    --ratio 1:0 --pipeline 8 -d 1000

Before: 83193.11 Ops/sec
After:  82504.89 Ops/sec

These tests are tested under heavy memory stress, and the performance
seems basically same as before,very slightly better/worse for certain
cases, the benefits of multi-index are basically erased by
fragmentation and workingset nodes usage is slightly lower.

Some (maybe further) TODO items if we are OK with this approach:

- I see a slight performance regression for THP tests,
  could identify a clear hotspot with perf, my guess is the
  content on the xa_lock is an issue (we have a xa_lock for
  every 64M swap cache space), THP handling needs to take the lock
  longer than usual. splitting the xa_lock to be more
  fine-grained seems a good solution. We have
  SWAP_ADDRESS_SPACE_SHIFT = 14 which is not an optimal value.
  Considering XA_CHUNK_SHIFT is 6, we will have three layer of Xarray
  just for 2 extra bits. 12 should be better to always make use of
  the whole XA chunk and having two layers at most. But duplicated
  address_space struct also wastes more memory and cacheline.
  I see an observable performance drop (~3%) after change
  SWAP_ADDRESS_SPACE_SHIFT to 12. Might be a good idea to
  decouple swap cache xarray from address_space (there are
  too many user for swapcache, shouldn't come too dirty).

- Actually after patch Patch 4/10, the performance is much better for
  tests limited with memory cgroup, until 10/10 applied the direct swap
  cache freeing logic for SWP_SYNCHRONOUS_IO swapin. Because if the swap
  device is not near full, swapin doesn't clear up the swapcache, so
  repeated swapout doesn't need to re-alloc a swap entry, make things
  faster. This may indicate that lazy freeing of swap cache could benifit
  certain workloads and may worth looking into later.

- Now SWP_SYNCHRONOUS_IO swapin will bypass readahead and force drop
  swap cache after swapin is done, which can be cleaned up and optimized
  further after this patch. Device type will only determine the
  readahead logic, and swap cache drop check can be based purely on swap
  count.

- Recent mTHP swapin/swapout series should have no fundamental
  conflict with this.

Kairui Song (10):
  mm/filemap: split filemap storing logic into a standalone helper
  mm/swap: move no readahead swapin code to a stand-alone helper
  mm/swap: convert swapin_readahead to return a folio
  mm/swap: remove cache bypass swapin
  mm/swap: clean shadow only in unmap path
  mm/swap: switch to use multi index entries
  mm/swap: rename __read_swap_cache_async to swap_cache_alloc_or_get
  mm/swap: use swap cache as a synchronization layer
  mm/swap: delay the swap cache look up for swapin
  mm/swap: optimize synchronous swapin

 include/linux/swapops.h |   5 +-
 mm/filemap.c            | 161 +++++++++-----
 mm/huge_memory.c        |  78 +++----
 mm/internal.h           |   2 +
 mm/memory.c             | 133 ++++-------
 mm/shmem.c              |  44 ++--
 mm/swap.h               |  71 ++++--
 mm/swap_state.c         | 478 +++++++++++++++++++++-------------------
 mm/swapfile.c           |  64 +++---
 mm/vmscan.c             |   8 +-
 mm/workingset.c         |   2 +-
 mm/zswap.c              |   4 +-
 12 files changed, 540 insertions(+), 510 deletions(-)

-- 
2.43.0


