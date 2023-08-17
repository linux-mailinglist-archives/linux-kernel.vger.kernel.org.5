Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944EF77EFAC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 05:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347925AbjHQDxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 23:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347923AbjHQDwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 23:52:49 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF6526AB;
        Wed, 16 Aug 2023 20:52:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VpyHzpK_1692244315;
Received: from localhost(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VpyHzpK_1692244315)
          by smtp.aliyun-inc.com;
          Thu, 17 Aug 2023 11:52:44 +0800
From:   Liu Song <liusong@linux.alibaba.com>
To:     corbet@lwn.net, akpm@linux-foundation.org, paulmck@kernel.org,
        rdunlap@infradead.org, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, rostedt@goodmis.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, liusong@linux.alibaba.com
Subject: [PATCH] mm/khugepaged: increase transparent_hugepage_recommend_disable parameter to disable active modification of min_free_kbytes
Date:   Thu, 17 Aug 2023 11:51:55 +0800
Message-Id: <20230817035155.84230-1-liusong@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the arm64 environment, when PAGESIZE is 4K, the "pageblock_nr_pages"
value is 512, and the recommended min_free_kbytes in
"set_recommended_min_free_kbytes" usually does not exceed 44MB.

However, when PAGESIZE is 64K, the "pageblock_nr_pages" value is 8192,
and the recommended min_free_kbytes in "set_recommended_min_free_kbytes"
is 8192 * 2 * (2 + 9) * 64K, which directly increases to 11GB.

According to this calculation method, due to the modification of min_free_kbytes,
the reserved memory in my 128GB memory environment reaches 10GB, and MemAvailable
is correspondingly reduced by 10GB.

In the case of PAGESIZE 64K, transparent hugepages are 512MB, and we only
need them to be used on demand. If transparent hugepages cannot be allocated,
falling back to regular 64K pages is completely acceptable.

Therefore, we added the transparent_hugepage_recommend_disable parameter
to disable active modification of min_free_kbytes, thereby meeting our
requirements for transparent hugepages in the 64K scenario, and it will
not excessively reduce the available memory.

Signed-off-by: Liu Song <liusong@linux.alibaba.com>
---
 .../admin-guide/kernel-parameters.txt         |  5 +++++
 mm/khugepaged.c                               | 20 ++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 654d0d921101..612bdf601cce 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6553,6 +6553,11 @@
 			See Documentation/admin-guide/mm/transhuge.rst
 			for more details.
 
+	transparent_hugepage_recommend_disable
+			[KNL,THP]
+			Can be used to disable transparent hugepage to actively modify
+			/proc/sys/vm/min_free_kbytes during enablement process.
+
 	trusted.source=	[KEYS]
 			Format: <string>
 			This parameter identifies the trust source as a backend
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 78fc1a24a1cc..ac40c618f4f6 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -88,6 +88,9 @@ static unsigned int khugepaged_max_ptes_none __read_mostly;
 static unsigned int khugepaged_max_ptes_swap __read_mostly;
 static unsigned int khugepaged_max_ptes_shared __read_mostly;
 
+/* default enable recommended */
+static unsigned int transparent_hugepage_recommend __read_mostly = 1;
+
 #define MM_SLOTS_HASH_BITS 10
 static DEFINE_READ_MOSTLY_HASHTABLE(mm_slots_hash, MM_SLOTS_HASH_BITS);
 
@@ -2561,6 +2564,11 @@ static void set_recommended_min_free_kbytes(void)
 		goto update_wmarks;
 	}
 
+	if (!transparent_hugepage_recommend) {
+		pr_info("do not allow to recommend modify min_free_kbytes\n");
+		return;
+	}
+
 	for_each_populated_zone(zone) {
 		/*
 		 * We don't need to worry about fragmentation of
@@ -2591,7 +2599,10 @@ static void set_recommended_min_free_kbytes(void)
 
 	if (recommended_min > min_free_kbytes) {
 		if (user_min_free_kbytes >= 0)
-			pr_info("raising min_free_kbytes from %d to %lu to help transparent hugepage allocations\n",
+			pr_info("raising user specified min_free_kbytes from %d to %lu to help transparent hugepage allocations\n",
+				min_free_kbytes, recommended_min);
+		else
+			pr_info("raising default min_free_kbytes from %d to %lu to help transparent hugepage allocations\n",
 				min_free_kbytes, recommended_min);
 
 		min_free_kbytes = recommended_min;
@@ -2601,6 +2612,13 @@ static void set_recommended_min_free_kbytes(void)
 	setup_per_zone_wmarks();
 }
 
+static int __init setup_transparent_hugepage_recommend_disable(char *str)
+{
+	transparent_hugepage_recommend = 0;
+	return 1;
+}
+__setup("transparent_hugepage_recommend_disable", setup_transparent_hugepage_recommend_disable);
+
 int start_stop_khugepaged(void)
 {
 	int err = 0;
-- 
2.19.1.6.gb485710b

