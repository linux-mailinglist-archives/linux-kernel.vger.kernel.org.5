Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D195756214
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjGQLwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 07:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjGQLwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:52:00 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884B597
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 04:51:57 -0700 (PDT)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R4L5F6xJDz18LlC;
        Mon, 17 Jul 2023 19:51:13 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 19:51:54 +0800
From:   Wupeng Ma <mawupeng1@huawei.com>
To:     <catalin.marinas@arm.com>, <akpm@linux-foundation.org>,
        <sudaraja@codeaurora.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <mawupeng1@huawei.com>, <wangkefeng.wang@huawei.com>,
        <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <mark.rutland@arm.com>, <anshuman.khandual@arm.com>
Subject: [RFC PATCH] arm64: mm: Fix kernel page tables incorrectly deleted during memory removal
Date:   Mon, 17 Jul 2023 19:51:50 +0800
Message-ID: <20230717115150.1806954-1-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ma Wupeng <mawupeng1@huawei.com>

During our test, we found that kernel page table may be unexpectedly
cleared with rodata off. The root cause is that the kernel page is
initialized with pud size(1G block mapping) while offline is memory
block size(MIN_MEMORY_BLOCK_SIZE 128M), eg, if 2G memory is hot-added,
when offline a memory block, the call trace is shown below,

 offline_and_remove_memory
    try_remove_memory
      arch_remove_memory
       __remove_pgd_mapping
         unmap_hotplug_range
           unmap_hotplug_p4d_range
             unmap_hotplug_pud_range
               if (pud_sect(pud))
                 pud_clear(pudp);

There is no issue for block mapping with pmd level(2M) because the
memory block size is aligned with 2M.

Commit f0b13ee23241 ("arm64/sparsemem: reduce SECTION_SIZE_BITS") reduces
SECTION_SIZE_BITS from arm64, this make memory section size less than pud
size possible. Since only hotadded memory can be removed for arm64 due to
commit bbd6ec605c0f ("arm64/mm: Enable memory hot remove"), stop using pud
size kernel page entry during memory hot join can fix this.

Fixes: f0b13ee23241 ("arm64/sparsemem: reduce SECTION_SIZE_BITS")
Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
---
 arch/arm64/mm/mmu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 95d360805f8a..44c724ce4f70 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -44,6 +44,7 @@
 #define NO_BLOCK_MAPPINGS	BIT(0)
 #define NO_CONT_MAPPINGS	BIT(1)
 #define NO_EXEC_MAPPINGS	BIT(2)	/* assumes FEAT_HPDS is not used */
+#define NO_PUD_MAPPINGS		BIT(3)
 
 int idmap_t0sz __ro_after_init;
 
@@ -344,7 +345,7 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
 		 */
 		if (pud_sect_supported() &&
 		   ((addr | next | phys) & ~PUD_MASK) == 0 &&
-		    (flags & NO_BLOCK_MAPPINGS) == 0) {
+		    (flags & (NO_BLOCK_MAPPINGS | NO_PUD_MAPPINGS)) == 0) {
 			pud_set_huge(pudp, phys, prot);
 
 			/*
@@ -1305,7 +1306,7 @@ struct range arch_get_mappable_range(void)
 int arch_add_memory(int nid, u64 start, u64 size,
 		    struct mhp_params *params)
 {
-	int ret, flags = NO_EXEC_MAPPINGS;
+	int ret, flags = NO_EXEC_MAPPINGS | NO_PUD_MAPPINGS;
 
 	VM_BUG_ON(!mhp_range_allowed(start, size, true));
 
-- 
2.25.1

