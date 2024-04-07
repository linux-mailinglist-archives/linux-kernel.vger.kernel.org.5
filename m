Return-Path: <linux-kernel+bounces-134207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8C389AEF4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06C7C281312
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 06:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC4679D1;
	Sun,  7 Apr 2024 06:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q0AFAdzQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214111DFC4
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 06:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712472908; cv=none; b=DaWT675Rrfv0LY+ZeCyc8SQsBNoTwIt536Ucds5RrZWG2f79BnrlePVHbvVb0dGQrZOsk83DpiESkn9uB2EAQzG/8CqLRI/zSMaqlEJ85HGNazEsr1Q0h7ow7LQ9b5FmWNARSCP/EGGvoywLwo1UynEJOlE4yrUMwI0m9sj5a24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712472908; c=relaxed/simple;
	bh=iCd4mqulyCBb7Qt4H3d7QCvUjxPxbKW3n2d2uZXJx4M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KuBkKRbeqwc3aZd59OOcZsFiiblEwha5AjvOR+tL6K1PJEqL1pMXsiQCZYot00WwJN6589GFgAlC+H/eUnkAJb/25yGXJ+xHNRERyV2W0MBy0PY3zpWZOVaWOHPHnYTNJyw+iCmBzH0PHUResEOfUhcCJeKN1xklWQjvGo+M828=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q0AFAdzQ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712472907; x=1744008907;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iCd4mqulyCBb7Qt4H3d7QCvUjxPxbKW3n2d2uZXJx4M=;
  b=Q0AFAdzQUAvyBzcGz5zV8zYtfmvFsgOc/12zDoLRs07NrvZ87J4toKla
   Eh+bwrZc/pI7Pd7pX0ZopSA5EToS+A0LUp+jML5IqG6Y7yKPfKT8OsVRL
   yMzZvGzysgnN9l7t98VXCsa8cHQF6SKdDO2yn1GQ0HnLTPH8m/e16p0CE
   2SdZdImIlCUzCyBm/CD33GDm3An2by7uBLkm3gxq7TKkxTpfs2HX6v3tS
   e/VZdxB9WG3IazrcGpFgrIehdi3t19pL8YBS3PgIp5+q3ZNDrFvvN8eb/
   SWHfegyPCdcGtkMXW8LIgqYLyS3FTsVLi0wXivboMlg5b97QAsFWes5ZR
   g==;
X-CSE-ConnectionGUID: OMOoyVPMRwK7zXjFAgCRPA==
X-CSE-MsgGUID: rmJ4PieIQjKSXi2Whq8eMw==
X-IronPort-AV: E=McAfee;i="6600,9927,11036"; a="11553347"
X-IronPort-AV: E=Sophos;i="6.07,184,1708416000"; 
   d="scan'208";a="11553347"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2024 23:55:06 -0700
X-CSE-ConnectionGUID: p7xOMK39Rwu9L0HLtgKMNw==
X-CSE-MsgGUID: vXEl9dyTRHuimbx6P1capg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,184,1708416000"; 
   d="scan'208";a="24243470"
Received: from yangdaiy-mobl.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.29.196])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2024 23:55:03 -0700
From: Huang Ying <ying.huang@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Huang Ying <ying.huang@intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Hugh Dickins <hughd@google.com>,
	Minchan Kim <minchan@kernel.org>
Subject: [PATCH] mm,swap: add document about RCU read lock and swapoff interaction
Date: Sun,  7 Apr 2024 14:54:50 +0800
Message-Id: <20240407065450.498821-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During reviewing a patch to fix the race condition between
free_swap_and_cache() and swapoff() [1], it was found that the
document about how to prevent racing with swapoff isn't clear enough.
Especially RCU read lock can prevent swapoff from freeing data
structures.  So, the document is added as comments.

[1] https://lore.kernel.org/linux-mm/c8fe62d0-78b8-527a-5bef-ee663ccdc37a@huawei.com/

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Minchan Kim <minchan@kernel.org>
---
 mm/swapfile.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 4919423cce76..6925462406fa 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1226,16 +1226,15 @@ static unsigned char __swap_entry_free_locked(struct swap_info_struct *p,
 
 /*
  * When we get a swap entry, if there aren't some other ways to
- * prevent swapoff, such as the folio in swap cache is locked, page
- * table lock is held, etc., the swap entry may become invalid because
- * of swapoff.  Then, we need to enclose all swap related functions
- * with get_swap_device() and put_swap_device(), unless the swap
- * functions call get/put_swap_device() by themselves.
+ * prevent swapoff, such as the folio in swap cache is locked, RCU
+ * reader side is locked, etc., the swap entry may become invalid
+ * because of swapoff.  Then, we need to enclose all swap related
+ * functions with get_swap_device() and put_swap_device(), unless the
+ * swap functions call get/put_swap_device() by themselves.
  *
- * Note that when only holding the PTL, swapoff might succeed immediately
- * after freeing a swap entry. Therefore, immediately after
- * __swap_entry_free(), the swap info might become stale and should not
- * be touched without a prior get_swap_device().
+ * RCU reader side lock (including any spinlock) is sufficient to
+ * prevent swapoff, because synchronize_rcu() is called in swapoff()
+ * before freeing data structures.
  *
  * Check whether swap entry is valid in the swap device.  If so,
  * return pointer to swap_info_struct, and keep the swap entry valid
@@ -2495,10 +2494,11 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 
 	/*
 	 * Wait for swap operations protected by get/put_swap_device()
-	 * to complete.
-	 *
-	 * We need synchronize_rcu() here to protect the accessing to
-	 * the swap cache data structure.
+	 * to complete.  Because of synchronize_rcu() here, all swap
+	 * operations protected by RCU reader side lock (including any
+	 * spinlock) will be waited too.  This makes it easy to
+	 * prevent folio_test_swapcache() and the following swap cache
+	 * operations from racing with swapoff.
 	 */
 	percpu_ref_kill(&p->users);
 	synchronize_rcu();
-- 
2.39.2


