Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E767D6FF6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344143AbjJYOqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343659AbjJYOqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:46:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 940F9B0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:46:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB8F71477;
        Wed, 25 Oct 2023 07:46:42 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC0443F64C;
        Wed, 25 Oct 2023 07:45:59 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v3 3/4] mm: swap: Simplify ssd behavior when scanner steals entry
Date:   Wed, 25 Oct 2023 15:45:45 +0100
Message-Id: <20231025144546.577640-4-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231025144546.577640-1-ryan.roberts@arm.com>
References: <20231025144546.577640-1-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a CPU fails to reserve a cluster (due to free list exhaustion), we
revert to the scanner to find a free entry somewhere in the swap file.
This might cause an entry to be stolen from another CPU's reserved
cluster. Upon noticing this, the CPU with the stolen entry would
previously scan forward to the end of the cluster trying to find a free
entry to use. If there were none, it would try to reserve a new pre-cpu
cluster and allocate from that.

This scanning behavior does not scale well to high-order allocations,
which will be introduced in a future patch since would need to scan for
a contiguous area that was naturally aligned. Given stealing is a rare
occurrence, let's remove the scanning behavior from the ssd allocator
and simply drop the cluster and try to allocate a new one. Given the
purpose of the per-cpu cluster is to ensure a given task's pages are
sequential on disk to aid readahead, allocating a new cluster at this
point makes most sense.

Furthermore, si->max will always be greater than or equal to the end of
the last cluster because any partial cluster will never be put on the
free cluster list. Therefore we can simplify this logic too.

These changes make it simpler to generalize
scan_swap_map_try_ssd_cluster() to handle any allocation order.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 mm/swapfile.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 617e34b8cdbe..94f7cc225eb9 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -639,27 +639,24 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
 
 	/*
 	 * Other CPUs can use our cluster if they can't find a free cluster,
-	 * check if there is still free entry in the cluster
+	 * check if the expected entry is still free. If not, drop it and
+	 * reserve a new cluster.
 	 */
-	max = min_t(unsigned long, si->max,
-		    ALIGN_DOWN(tmp, SWAPFILE_CLUSTER) + SWAPFILE_CLUSTER);
-	if (tmp < max) {
-		ci = lock_cluster(si, tmp);
-		while (tmp < max) {
-			if (!si->swap_map[tmp])
-				break;
-			tmp++;
-		}
+	ci = lock_cluster(si, tmp);
+	if (si->swap_map[tmp]) {
 		unlock_cluster(ci);
-	}
-	if (tmp >= max) {
 		*cpu_next = SWAP_NEXT_NULL;
 		goto new_cluster;
 	}
+	unlock_cluster(ci);
+
 	*offset = tmp;
 	*scan_base = tmp;
+
+	max = ALIGN_DOWN(tmp, SWAPFILE_CLUSTER) + SWAPFILE_CLUSTER;
 	tmp += 1;
 	*cpu_next = tmp < max ? tmp : SWAP_NEXT_NULL;
+
 	return true;
 }
 
-- 
2.25.1

