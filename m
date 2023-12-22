Return-Path: <linux-kernel+bounces-9408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACA281C519
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C716DB20E24
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0A0944E;
	Fri, 22 Dec 2023 06:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T57cdlim"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2726A79C4
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 06:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703226498; x=1734762498;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=PVyWQo3ntB08M03wvTL+weiYWAOMsxFUiFWQcHmTM50=;
  b=T57cdlimDcRODlYPQ+5hW4hHpwjUn+qdiV8rtb9N0Y2IoTVVbMQHcYsY
   RjZwKy0DCO5HYFPGTygvJVrPH5WYwbY8t3MddNsrtyjultZe+7IyOD80o
   f0KIyFOfSgpqU8A5XgFUKRxI7HjnYxgQI4xnGVg8bYQKcpCdh7iGuloDO
   Gu9WqjXCIAEmJq2TOJWtwySlxBZdof89rd7rCW7WHShDzJwRrOS/IPhjN
   KxvubB2LLdH3SDPMAXZ3hEU3C5IczLDUAj4blaSIHlpPEkpRsL9EdU/ju
   YvRCcCZv44UcW/JZdi+IfGiS1zr13q3txnnEQ22p0VNMenhUOlho8Im6p
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="462520034"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="462520034"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 22:28:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="847362716"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="847362716"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 22:28:02 -0800
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: naoya.horiguchi@nec.com
Cc: linmiaohe@huawei.com,
	akpm@linux-foundation.org,
	tony.luck@intel.com,
	ying.huang@intel.com,
	fengwei.yin@intel.com,
	qiuxu.zhuo@intel.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] mm: memory-failure: Re-split hw-poisoned huge page on -EAGAIN
Date: Fri, 22 Dec 2023 14:27:06 +0800
Message-Id: <20231222062706.5221-2-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231222062706.5221-1-qiuxu.zhuo@intel.com>
References: <20231215081204.8802-1-qiuxu.zhuo@intel.com>
 <20231222062706.5221-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

During the process of splitting a hw-poisoned huge page, it is possible
for the reference count of the huge page to be increased by the threads
within the affected process, leading to a failure in splitting the
hw-poisoned huge page with an error code of -EAGAIN.

This issue can be reproduced when doing memory error injection to a
multiple-thread process, and the error occurs within a huge page.
The call path with the returned -EAGAIN during the testing is shown below:

  memory_failure()
    try_to_split_thp_page()
      split_huge_page()
        split_huge_page_to_list() {
          ...
          Step A: can_split_folio() - Checked that the thp can be split.
          Step B: unmap_folio()
          Step C: folio_ref_freeze() - Failed and returned -EAGAIN.
          ...
        }

The testing logs indicated that some huge pages were split successfully
via the call path above (Step C was successful for these huge pages).
However, some huge pages failed to split due to a failure at Step C, and
it was observed that the reference count of the huge page increased between
Step A and Step C.

Testing has shown that after receiving -EAGAIN, simply re-splitting the
hw-poisoned huge page within memory_failure() always results in the same
-EAGAIN. This is possible because memory_failure() is executed in the
currently affected process. Before this process exits memory_failure() and
is terminated, its threads could increase the reference count of the
hw-poisoned page.

Furthermore, if the h/w-poisoned huge page had been mapped for the victim
application's text and was present in the file cache and it was failed to
be split. When attempting to restart the process without splitting the
h/w-poisoned huge page, the application restart failed. This was possible
because its text was remapped to the hardware-poisoned huge page from the
file cache, leading to its swift termination due to another MCE.

To address this issue, leverage memory_failure_queue_delayed() to re-split
the h/w-poisoned huge page by a kernel worker. By the time this worker
begins re-splitting the h/w-poisoned huge page, the affected process has
already been terminated, preventing its threads from increasing the
reference count. Experimental results have consistently shown that this
worker successfully re-splits these h/w-poisoned huge pages on its first
attempt. After that the victim application restarted successfully.

The kernel log (before):
  [ 1116.862895] Memory failure: 0x4097fa7: recovery action for unsplit thp: Ignored

  After that, the victim application may fail to restart.

The kernel log (after):
  [  405.195308] Memory failure: 0x410756b: recovery action for unsplit thp: Delayed
  [  405.200267] Memory failure: 0x410756b: recovery action for clean LRU page: Recovered

  After that, the victim application restarted successfully.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
v1->v2:

  1. Include user-visible benefits in both the commit message and code comments.
     [ Address Naoya Horiguchi's comment on the unclear user-visible benefits in v1. ]

  2. Leverage memory_failure_queue_delayed() to re-split the h/w-poisoned huge page,
     which makes the recovery action more complete.
     [ Address Naoya Horiguchi's comment regarding the incomplete recovery in v1.
       Address Miaohe's concern about the possibility of being freed when the worker is scheduled in v1. ]

 include/linux/mm.h  |  1 +
 mm/memory-failure.c | 54 ++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 418d26608ece..87bd67d0a046 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3904,6 +3904,7 @@ enum mf_flags {
 	MF_UNPOISON = 1 << 4,
 	MF_SW_SIMULATED = 1 << 5,
 	MF_NO_RETRY = 1 << 6,
+	/* Bits {31:28} are reserved for encoding the THP split retry count. */
 };
 int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
 		      unsigned long count, int mf_flags);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 8f2c11863bae..2334d0417258 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2147,6 +2147,28 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 	return rc;
 }
 
+static void memory_failure_queue_delayed(unsigned long pfn, int flags, unsigned long delay);
+
+#define MF_RETRY_CNT_MASK	GENMASK(31, 28)
+#define MF_RETRY_CNT_SHIFT	28
+#define MF_RETRY_CNT_GET(f)	(((f) & MF_RETRY_CNT_MASK) >> MF_RETRY_CNT_SHIFT)
+#define MF_RETRY_CNT_SET(f, c)	(((f) & ~MF_RETRY_CNT_MASK) | ((c) << MF_RETRY_CNT_SHIFT))
+
+#define MAX_RETRY_CNT		10
+#define INIT_DELAYED_MS		1
+
+static bool split_thp_delayed(unsigned long pfn, int flags)
+{
+	int cnt = MF_RETRY_CNT_GET(flags);
+
+	if (cnt >= MAX_RETRY_CNT)
+		return false;
+
+	memory_failure_queue_delayed(pfn, MF_RETRY_CNT_SET(flags, cnt + 1),
+				     msecs_to_jiffies(INIT_DELAYED_MS << cnt));
+	return true;
+}
+
 /**
  * memory_failure - Handle memory failure of a page.
  * @pfn: Page Number of the corrupted page
@@ -2211,7 +2233,7 @@ int memory_failure(unsigned long pfn, int flags)
 	if (hugetlb)
 		goto unlock_mutex;
 
-	if (TestSetPageHWPoison(p)) {
+	if (TestSetPageHWPoison(p) && !MF_RETRY_CNT_GET(flags)) {
 		pr_err("%#lx: already hardware poisoned\n", pfn);
 		res = -EHWPOISON;
 		if (flags & MF_ACTION_REQUIRED)
@@ -2275,8 +2297,34 @@ int memory_failure(unsigned long pfn, int flags)
 		 * page is a valid handlable page.
 		 */
 		SetPageHasHWPoisoned(hpage);
-		if (try_to_split_thp_page(p) < 0) {
-			res = action_result(pfn, MF_MSG_UNSPLIT_THP, MF_IGNORED);
+		res = try_to_split_thp_page(p);
+		if (res < 0) {
+			/*
+			 * Re-attempting try_to_split_thp_page() here could consistently
+			 * yield -EAGAIN, as the threads of the process may increment the
+			 * reference count of the huge page before the process exits
+			 * memory_failure() and terminates.
+			 *
+			 * Furthermore, if the h/w-poisoned huge page had been mapped for
+			 * the victim application's text and was present in the file cache
+			 * and it was failed to be split. When attempting to restart the
+			 * application without splitting the h/w-poisoned huge page, the
+			 * application restart failed. This was possible because its text
+			 * was remapped to the hardware-poisoned huge page from the file
+			 * cache, leading to its swift termination due to another MCE.
+			 *
+			 * Leverage memory_failure_queue_delayed() to re-split the h/w-poisoned
+			 * huge page by a kernel worker. By the time this worker initiates
+			 * the re-splitting and recovery process, the affected process has
+			 * already been terminated, preventing its threads from incrementing
+			 * the reference count. After re-splitting the h/w-poisoned huge page
+			 * successfully (drop the text mapping), the application restart is
+			 * successful.
+			 */
+			if (res == -EAGAIN && split_thp_delayed(pfn, flags))
+				res = action_result(pfn, MF_MSG_UNSPLIT_THP, MF_DELAYED);
+			else
+				res = action_result(pfn, MF_MSG_UNSPLIT_THP, MF_IGNORED);
 			goto unlock_mutex;
 		}
 		VM_BUG_ON_PAGE(!page_count(p), p);
-- 
2.17.1


