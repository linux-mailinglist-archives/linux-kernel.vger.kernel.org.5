Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C526377185C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 04:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjHGCdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 22:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjHGCdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 22:33:13 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5311722
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 19:33:09 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RK0fN06qsz1Z1Tm;
        Mon,  7 Aug 2023 10:30:20 +0800 (CST)
Received: from huawei.com (10.174.151.185) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 10:33:07 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <rppt@kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2] mm/mm_init: use helper macro BITS_PER_LONG and BITS_PER_BYTE
Date:   Mon, 7 Aug 2023 10:32:47 +0800
Message-ID: <20230807023247.308414-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's more readable to use helper macro BITS_PER_LONG and BITS_PER_BYTE.
No functional change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
v2:
  use BITS_PER_BYTE per Mike. Thanks.
---
 mm/mm_init.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 66aca3f6accd..93b1febd4a32 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -79,7 +79,7 @@ void __init mminit_verify_pageflags_layout(void)
 	int shift, width;
 	unsigned long or_mask, add_mask;
 
-	shift = 8 * sizeof(unsigned long);
+	shift = BITS_PER_LONG;
 	width = shift - SECTIONS_WIDTH - NODES_WIDTH - ZONES_WIDTH
 		- LAST_CPUPID_SHIFT - KASAN_TAG_WIDTH - LRU_GEN_WIDTH - LRU_REFS_WIDTH;
 	mminit_dprintk(MMINIT_TRACE, "pageflags_layout_widths",
@@ -1431,9 +1431,9 @@ static unsigned long __init usemap_size(unsigned long zone_start_pfn, unsigned l
 	usemapsize = roundup(zonesize, pageblock_nr_pages);
 	usemapsize = usemapsize >> pageblock_order;
 	usemapsize *= NR_PAGEBLOCK_BITS;
-	usemapsize = roundup(usemapsize, 8 * sizeof(unsigned long));
+	usemapsize = roundup(usemapsize, BITS_PER_LONG);
 
-	return usemapsize / 8;
+	return usemapsize / BITS_PER_BYTE;
 }
 
 static void __ref setup_usemap(struct zone *zone)
-- 
2.33.0

