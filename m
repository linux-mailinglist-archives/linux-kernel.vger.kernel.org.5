Return-Path: <linux-kernel+bounces-94014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 146C287384C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3DCC284B0D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7164E13248C;
	Wed,  6 Mar 2024 14:04:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F80A131E27;
	Wed,  6 Mar 2024 14:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709733850; cv=none; b=bWm2FP9VMYjvF1xrp2LQ7dpxwjKlQEbzAY4jI9eDzd8KTJkJK/sFR2MuuBkc7DyqhJvzEWIIIygjhoEvasvb3DQOnUfSasjhi1f6qDmXLc2iTE0NOTIwYf3qcNzaxvGX528zFwV18OlhW92mMFCBCmZ17Fe2hfj2VdAGEC3EFFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709733850; c=relaxed/simple;
	bh=PB1X8HjhDk0oq0CrNU+1M4O2qnfMn33yRD2/aftWKro=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NKCNsQUgsc0vkmP7bROGoaH67LA0h1f1oN5yCUZ1GVSa40DYrASYigfT6O8sM5AbkqovpHVR8eNEc3le7wK4H8VOvnwzEh/2m9egAArrZ24X6FCCSDen8crWKRTAq5bjzse7lavsKeaqkksV6mVaHxG4E8ldGxb2OELt/6ojBNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FD4C1FB;
	Wed,  6 Mar 2024 06:04:43 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F5CE3F762;
	Wed,  6 Mar 2024 06:04:04 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	"Huang, Ying" <ying.huang@intel.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] mm: swap: Fix race between free_swap_and_cache() and swapoff()
Date: Wed,  6 Mar 2024 14:03:56 +0000
Message-Id: <20240306140356.3974886-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was previously a theoretical window where swapoff() could run and
teardown a swap_info_struct while a call to free_swap_and_cache() was
running in another thread. This could cause, amongst other bad
possibilities, swap_page_trans_huge_swapped() (called by
free_swap_and_cache()) to access the freed memory for swap_map.

This is a theoretical problem and I haven't been able to provoke it from
a test case. But there has been agreement based on code review that this
is possible (see link below).

Fix it by using get_swap_device()/put_swap_device(), which will stall
swapoff(). There was an extra check in _swap_info_get() to confirm that
the swap entry was not free. This isn't present in get_swap_device()
because it doesn't make sense in general due to the race between getting
the reference and swapoff. So I've added an equivalent check directly in
free_swap_and_cache().

Details of how to provoke one possible issue (thanks to David
Hildenbrand for deriving this):

--8<-----

__swap_entry_free() might be the last user and result in
"count == SWAP_HAS_CACHE".

swapoff->try_to_unuse() will stop as soon as soon as si->inuse_pages==0.

So the question is: could someone reclaim the folio and turn
si->inuse_pages==0, before we completed swap_page_trans_huge_swapped().

Imagine the following: 2 MiB folio in the swapcache. Only 2 subpages are
still references by swap entries.

Process 1 still references subpage 0 via swap entry.
Process 2 still references subpage 1 via swap entry.

Process 1 quits. Calls free_swap_and_cache().
-> count == SWAP_HAS_CACHE
[then, preempted in the hypervisor etc.]

Process 2 quits. Calls free_swap_and_cache().
-> count == SWAP_HAS_CACHE

Process 2 goes ahead, passes swap_page_trans_huge_swapped(), and calls
__try_to_reclaim_swap().

__try_to_reclaim_swap()->folio_free_swap()->delete_from_swap_cache()->
put_swap_folio()->free_swap_slot()->swapcache_free_entries()->
swap_entry_free()->swap_range_free()->
..
WRITE_ONCE(si->inuse_pages, si->inuse_pages - nr_entries);

What stops swapoff to succeed after process 2 reclaimed the swap cache
but before process1 finished its call to swap_page_trans_huge_swapped()?

--8<-----

Fixes: 7c00bafee87c ("mm/swap: free swap slots in batch")
Closes: https://lore.kernel.org/linux-mm/65a66eb9-41f8-4790-8db2-0c70ea15979f@redhat.com/
Cc: stable@vger.kernel.org
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

Hi Andrew,

Please replace v1 of this patch in mm-unstable with this version.

Changes since v1:

 - Added comments for get_swap_device() as suggested by David
 - Moved check that swap entry is not free from get_swap_device() to
   free_swap_and_cache() since there are some paths that legitimately call with
   a free offset.

I haven't addressed the recommendation by Huang Ying [1] to also revert commit
23b230ba8ac3 ("mm/swap: print bad swap offset entry in get_swap_device"). It
should be done separately to this, and and we need to conclude discussion
first.

[1] https://lore.kernel.org/all/875xy0842q.fsf@yhuang6-desk2.ccr.corp.intel.com/

Thanks,
Ryan

 mm/swapfile.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 2b3a2d85e350..1155a6304119 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1232,6 +1232,11 @@ static unsigned char __swap_entry_free_locked(struct swap_info_struct *p,
  * with get_swap_device() and put_swap_device(), unless the swap
  * functions call get/put_swap_device() by themselves.
  *
+ * Note that when only holding the PTL, swapoff might succeed immediately
+ * after freeing a swap entry. Therefore, immediately after
+ * __swap_entry_free(), the swap info might become stale and should not
+ * be touched without a prior get_swap_device().
+ *
  * Check whether swap entry is valid in the swap device.  If so,
  * return pointer to swap_info_struct, and keep the swap entry valid
  * via preventing the swap device from being swapoff, until
@@ -1609,13 +1614,19 @@ int free_swap_and_cache(swp_entry_t entry)
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
2.25.1


