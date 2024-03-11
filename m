Return-Path: <linux-kernel+bounces-98552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 489F2877BE3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F26C11F218E9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 08:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A015812B7D;
	Mon, 11 Mar 2024 08:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C38SafKz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB24D125A9;
	Mon, 11 Mar 2024 08:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710146748; cv=none; b=V13ao0P+jGF9zCB6g+cymGZWcWvq6gQOpFMYhIB3r+g7HjQqbYk8NcBqNkfJM0Xh2VuNMVYUJt2lNFFABHbc/RaSbXtW3tNasaFqHrAmx+JuEo86zFQ+59qq0jkoQjYAzGjBR4+a9OgmJfKPSXbxjRpq1fyFO24G+8dEoPLSalI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710146748; c=relaxed/simple;
	bh=5zZfkh7bTy10cbt+byFNi1KVFCC5exwzUgnJ75DgeOM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lhk/drbJ2E/XaM8T8+CBnpQOVw9w2mL0uzPA4oEOr5h0qJTjXbJAtSGkh3EyIEf833TM8eojzCNdzGtcI+ePwWPFAIugZd13If7eN351VXLmZlNlUslZNGFOAk6q/5N3pQJ/1X/dy1xbKgKOCAzinccU5QhcLsHpv/T3DZ8vdMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C38SafKz; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710146747; x=1741682747;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5zZfkh7bTy10cbt+byFNi1KVFCC5exwzUgnJ75DgeOM=;
  b=C38SafKzUdAwb+LI1VWbsRiPY8w5ZSz0+3XNJYHNR0xe5xcgWbQFtWsT
   4FZ1oSpShbUvP8L0GABxCmjVmM7Wo9ZFlRDislIjcrZwkdjz8oO7DQ2uc
   LRqIMEA20XFhaQGslSVAVBdPmz83v24Md1i9kYVcwRfusEp+/SjB4oG4e
   Ys6V0VBrOwzLJbrOvmXeIIhafsut4JfFk2gihbRUDhZeCNxCaafFwvNnH
   a6O7CkGFDvvSx07MGUIDMlCKVCCaZkwOmXhiSveyOGcvfUNry5k5dUTvM
   9oRq6pRQPGbw6sP2KFe2s/xpJ9eIVSKaWQg0VXni1ngnECAft5uJ4YXlG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="27267162"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="27267162"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 01:45:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="11535184"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.6.133])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 01:45:43 -0700
From: Huang Ying <ying.huang@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Ryan Roberts <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	David Hildenbrand <david@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH -v3] mm: swap: fix race between free_swap_and_cache() and swapoff()
Date: Mon, 11 Mar 2024 16:44:26 +0800
Message-Id: <20240311084426.447164-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ryan Roberts <ryan.roberts@arm.com>

There was previously a theoretical window where swapoff() could run and
teardown a swap_info_struct while a call to free_swap_and_cache() was
running in another thread.  This could cause, amongst other bad
possibilities, swap_page_trans_huge_swapped() (called by
free_swap_and_cache()) to access the freed memory for swap_map.

This is a theoretical problem and I haven't been able to provoke it from a
test case.  But there has been agreement based on code review that this is
possible (see link below).

Fix it by using get_swap_device()/put_swap_device(), which will stall
swapoff().  There was an extra check in _swap_info_get() to confirm that
the swap entry was not free.  This isn't present in get_swap_device()
because it doesn't make sense in general due to the race between getting
the reference and swapoff.  So I've added an equivalent check directly in
free_swap_and_cache().

Details of how to provoke one possible issue:

--8<-----

CPU0                               CPU1
----                               ----
shmem_undo_range
  shmem_free_swap
    xa_cmpxchg_irq
    free_swap_and_cache
      __swap_entry_free
      /* swap_count() become 0 */
                                   swapoff
                                     try_to_unuse
                                       shmem_unuse /* cannot find swap entry */
                                       find_next_to_unuse
                                       filemap_get_folio
                                       folio_free_swap
                                       /* remove swap cache */
                                       /* free si->swap_map[] */
      swap_page_trans_huge_swapped <-- access freed si->swap_map !!!

--8<-----

Link: https://lkml.kernel.org/r/20240306140356.3974886-1-ryan.roberts@arm.com
Closes: https://lore.kernel.org/linux-mm/8734t27awd.fsf@yhuang6-desk2.ccr.corp.intel.com/
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: "Huang, Ying" <ying.huang@intel.com> [patch description]
Cc: David Hildenbrand <david@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
Hi, Andrew,

If it's not too late.  Please replace v2 of this patch in mm-stable
with this version.

Changes since v2:

 - Remove comments for get_swap_device() because it's not correct.
 - Revised patch description about the race condition description.

Changes since v1:

 - Added comments for get_swap_device() as suggested by David
 - Moved check that swap entry is not free from get_swap_device() to
   free_swap_and_cache() since there are some paths that legitimately call with
   a free offset.

Best Regards,
Huang, Ying

 mm/swapfile.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 2b3a2d85e350..9e0691276f5e 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1609,13 +1609,19 @@ int free_swap_and_cache(swp_entry_t entry)
 	if (non_swap_entry(entry))
 		return 1;
 
-	p = _swap_info_get(entry);
+	p = get_swap_device(entry);
 	if (p) {
+		if (WARN_ON(data_race(!p->swap_map[swp_offset(entry)]))) {
+			put_swap_device(p);
+			return 0;
+		}
+
 		count = __swap_entry_free(p, entry);
 		if (count == SWAP_HAS_CACHE &&
 		    !swap_page_trans_huge_swapped(p, entry))
 			__try_to_reclaim_swap(p, swp_offset(entry),
 					      TTRS_UNMAPPED | TTRS_FULL);
+		put_swap_device(p);
 	}
 	return p != NULL;
 }
-- 
2.39.2


