Return-Path: <linux-kernel+bounces-597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB5F81435E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A145D1C2258E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C9C171D4;
	Fri, 15 Dec 2023 08:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V81Ln0dK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F72171C8
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 08:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702627956; x=1734163956;
  h=from:to:cc:subject:date:message-id;
  bh=ZdpnPF5yz8wPHVueRT0u50qtNAiFwZAenFpSXobBWK4=;
  b=V81Ln0dKhJrqERME7/vYV/NvMvcgiG8eHzmuMyQtbbl3Z91t+DwhVLWL
   ASiw4h5atuLC3kourZIhSx9kUiAHJP9eFIrIAcB92v1bfE9/wz8gKjTiM
   f53OWYUEVnTkDxG1wGxGrKyGIpdjONy6oZ/Tp8SCfjYoD0d12lFIawWbC
   v59NqdLVpsO92MngaiV2HB/AVqsYrSifa+21d8z7zmfBM0h+4Vwp6TGfW
   6mBabPwgIfvayFlgeYCEHS0z10O2LxuNvLgXUdiSspi3dTYimkj4j97pi
   l8ylrRKLBCWQPCSCcaBOGUI8zQLRXCeAJpq9qyvSBbvmo0XRMu4bQl94G
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="2098121"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="2098121"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 00:12:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="22745475"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 00:12:32 -0800
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: naoya.horiguchi@nec.com
Cc: linmiaohe@huawei.com,
	akpm@linux-foundation.org,
	tony.luck@intel.com,
	ying.huang@intel.com,
	qiuxu.zhuo@intel.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] mm: memory-failure: Re-split hw-poisoned huge page on -EAGAIN
Date: Fri, 15 Dec 2023 16:12:04 +0800
Message-Id: <20231215081204.8802-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
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

To address this issue, employ the kernel worker to re-split the hw-poisoned
huge page. By the time this worker begins re-splitting the hw-poisoned huge
page, the affected process has already been terminated, preventing its
threads from increasing the reference count. Experimental results have
consistently shown that this worker successfully re-splits these
hw-poisoned huge pages on its first attempt.

The kernel log (before):
  [ 1116.862895] Memory failure: 0x4097fa7: recovery action for unsplit thp: Ignored

The kernel log (after):
  [  793.573536] Memory failure: 0x2100dda: recovery action for unsplit thp: Delayed
  [  793.574666] Memory failure: 0x2100dda: split unsplit thp successfully.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 mm/memory-failure.c | 73 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 71 insertions(+), 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 660c21859118..0db4cf712a78 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -72,6 +72,60 @@ atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
 
 static bool hw_memory_failure __read_mostly = false;
 
+#define SPLIT_THP_MAX_RETRY_CNT		10
+#define SPLIT_THP_INIT_DELAYED_MS	1
+
+static bool split_thp_pending;
+
+struct split_thp_req {
+	struct delayed_work work;
+	struct page *thp;
+	int retries;
+};
+
+static void split_thp_work_fn(struct work_struct *work)
+{
+	struct split_thp_req *req = container_of(work, typeof(*req), work.work);
+	int ret;
+
+	/* Split the thp. */
+	get_page(req->thp);
+	lock_page(req->thp);
+	ret = split_huge_page(req->thp);
+	unlock_page(req->thp);
+	put_page(req->thp);
+
+	/* Retry with an exponential backoff. */
+	if (ret && ++req->retries < SPLIT_THP_MAX_RETRY_CNT) {
+		schedule_delayed_work(to_delayed_work(work),
+				      msecs_to_jiffies(SPLIT_THP_INIT_DELAYED_MS << req->retries));
+		return;
+	}
+
+	pr_err("%#lx: split unsplit thp %ssuccessfully.\n", page_to_pfn(req->thp), ret ? "un" : "");
+	kfree(req);
+	split_thp_pending = false;
+}
+
+static bool split_thp_delayed(struct page *thp)
+{
+	struct split_thp_req *req;
+
+	if (split_thp_pending)
+		return false;
+
+	req = kmalloc(sizeof(*req), GFP_ATOMIC);
+	if (!req)
+		return false;
+
+	req->thp = thp;
+	req->retries = 0;
+	INIT_DELAYED_WORK(&req->work, split_thp_work_fn);
+	split_thp_pending = true;
+	schedule_delayed_work(&req->work, msecs_to_jiffies(SPLIT_THP_INIT_DELAYED_MS));
+	return true;
+}
+
 static DEFINE_MUTEX(mf_mutex);
 
 void num_poisoned_pages_inc(unsigned long pfn)
@@ -2275,8 +2329,23 @@ int memory_failure(unsigned long pfn, int flags)
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
+			 * Employ the kernel worker to re-split the huge page. By the time
+			 * this worker initiates the re-splitting process, the affected
+			 * process has already been terminated, preventing its threads from
+			 * incrementing the reference count.
+			 */
+			if (res == -EAGAIN && split_thp_delayed(p))
+				res = action_result(pfn, MF_MSG_UNSPLIT_THP, MF_DELAYED);
+			else
+				res = action_result(pfn, MF_MSG_UNSPLIT_THP, MF_IGNORED);
 			goto unlock_mutex;
 		}
 		VM_BUG_ON_PAGE(!page_count(p), p);
-- 
2.17.1


