Return-Path: <linux-kernel+bounces-59304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F0C84F4F2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96DCE1C24505
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 12:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A602EAE5;
	Fri,  9 Feb 2024 12:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v1W4MpYz"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815162E854
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 12:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707480049; cv=none; b=fRtbAxTAmtfWOJcgXLrevP8U1JA3LKAQR5qg54yOpihWaDwPga1GDWys11nDQxDtb79y965+6QVVdgAFfyOT0TPBbKISLBJhblMf9BjA1qYfJd36hV9kY9akGIR1RNRE+gnSqIgfUb9XYAb0RWXfj52A8KQ+GTdsLa491o2/fZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707480049; c=relaxed/simple;
	bh=Zu7L06jYFQlWzbX9n5ooim16fw606MESl/qmxOkoCFI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SjVVgUYp9WXXLZ+1egeG/axcCF2inE1BR6guVu9jNU19IqOnGUXLmQEmId3yu98Z624/8YLp2oV6TwgXRhrCnUFvMgGDokhaMWpIr3XT2tI73n9OtXvltFn3rmPReoqbA39VvZcsB4+wpeADTrtThm3atnTXTdAq48J58/z41nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v1W4MpYz; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707480040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iu/SOvWf0hKfo9wq+PAj0R5rFj1AjOSdhRH6wieMVN0=;
	b=v1W4MpYzxWVO+BDXLSHgO0OdvuI77K1u6J0SQ1NbDuYsn97FQagFhUMfUk/7oIg/zvkIOZ
	9f1OpxCvDilIWqNBjYVqIYqQHrSMCYJwFbscR+qsUlLyMMWwzeTbWGOCZ3XFFl/RmQj7VG
	8zRRwO0/xgjsMmdwUAofSI+LFgpR1pQ=
From: chengming.zhou@linux.dev
To: willy@infradead.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	chengming.zhou@linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH RFC 0/1] mm/zswap: fix LRU reclaim for zswap writeback folios
Date: Fri,  9 Feb 2024 11:59:49 +0000
Message-Id: <20240209115950.3885183-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chengming Zhou <zhouchengming@bytedance.com>

The memory shrinker of zswap is special: it has to first allocate more
memory (folio) to free less memory (compressed copy), later that folio
can be freed after written back. So it's better to evict these folios
before trying to reclaim other folios.

Here may come some problems of LRU management:

1. zswap_writeback_entry() reuses the __read_swap_cache_async(), which
   is normally only used in the swapin context. This may cause refault
   accounting and active/workingset information of the folio to be wrong.

   For example, zswap shrinker writeback try to reclaim the folio, but
   workingset_refault() mark it active to put it at head of active list.

2. folio_end_writeback() will check PG_reclaim flag which we did set
   in zswap_writeback_entry(), to try to rotate the folio to the tail
   of inactive list, to speed up its reclaim.

   But folio_rotate_reclaimable() won't work as we thought, actually
   all LRU move interfaces may don't work when the folio is isolated
   from LRU. (per-cpu add batch is somewhat like isolated from LRU)

   So when folio_end_writeback() calls folio_rotate_reclaimable(),
   it won't do nothing but just clear PG_reclaim flag if that folio
   is isolated (in per-cpu add batch or isolated by vmscan shrinker)

3. so the final result is the folio that has been written back and is
   expected to be evicted, but now is not at tail of inactive list.

   Meanwhile vmscan shrinker may try to evict other folios to cause
   more refaults. There is a report [1] of this problem.

We should handle these cases better. First of all, we should consider
when and where to put these folios on LRU.

1. after alloc: now we use folio_add_lru() to put folio on local batch,
   so it will be put at head of inactive/active list when batch drain.

2. after writeback: clear PG_reclaim and folio_rotate_reclaimable().
   - after add batch drain: rotate successfully to tail of inactive list
   - before add batch drain: do nothing since folio is not on LRU list

So these are two main time points we care about: the first is somewhat
correct IMHO since the folio is under writeback and has PG_reclaim set,
it may confuse shrinker if we put those to the tail of inactive list
too early. If we really want to put it to tail, we can easily introduce
another folio_add_lru_tail() to put on a new local lru_add_tail batch.

The second is where we need to improve, we should rotate it to tail
even when folio is in local batch. Since we can't manipulate folio LRU
status when it's isolated in local batch, an obvious fix is to use
folio flag to tell later lru_add_fn() where the folio should be put:
active or inactive, head or tail.

But the problem is that PG_readahead is the alias of PG_reclaim, we
can't put readahead folio to the tail of inactive list obviously.

So this patch changes folio_rotate_reclaimable() to queue to local
rotate batch even when !PG_lru at first, hoping that:

 - folio_end_writeback() finish on the same cpu with lru_add batch,
   so it must be handled after the lru_add batch, after which it will
   see PG_lru and successfully rotate it to tail of inactive list.

 - even folio_end_writeback() is not finished on the same cpu, there
   maybe a big chance that rotate batch is handled after add batch.

Testing kernel build in tmpfs with memory.max = 2GB.
(zswap shrinker and writeback enabled with one 50GB swapfile)

                           mm-unstable-hot   zswap-lru-reclaim
real                       63.34             62.72            
user                       1063.20           1060.30          
sys                        272.04            256.14           
workingset_refault_anon    2103297.00        1788155.80       
workingset_refault_file    28638.20          39249.40         
workingset_activate_anon   746134.00         695435.40        
workingset_activate_file   4344.60           4255.80          
workingset_restore_anon    653163.80         605315.60        
workingset_restore_file    1079.00           883.00           
workingset_nodereclaim     0.00              0.00             
pgscan                     12971305.60       12730331.20      
pgscan_kswapd              0.00              0.00             
pgscan_direct              12971305.60       12730331.20      
pgscan_khugepaged          0.00              0.00             

We can see that refault and sys cpu have some improvements.

As for the workingset_refault() caused by zswap writeback, maybe we
should remove it in zswap writeback case, but there are more pgscan
and some regression. I don't know why, so just leave it as it is.

This is RFC, any comment or discussion is welcome! Thanks!

[1] https://lore.kernel.org/all/20231024142706.195517-1-hezhongkun.hzk@bytedance.com/

Chengming Zhou (1):
  mm/swap: queue reclaimable folio to local rotate batch when
    !folio_test_lru()

 mm/swap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.40.1


