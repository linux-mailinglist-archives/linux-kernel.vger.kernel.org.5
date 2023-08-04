Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5972A76F83C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 05:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbjHDDHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 23:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbjHDDEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 23:04:55 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692D8448F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 20:04:43 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RH9YK1p8Bz4f3q2r
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 11:04:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP1 (Coremail) with SMTP id cCh0CgAXODLGasxkWSvZOg--.12542S3;
        Fri, 04 Aug 2023 11:04:40 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        mgorman@techsingularity.net, david@redhat.com
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH v3 1/8] mm/compaction: avoid missing last page block in section after skip offline sections
Date:   Fri,  4 Aug 2023 19:04:47 +0800
Message-Id: <20230804110454.2935878-2-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230804110454.2935878-1-shikemeng@huaweicloud.com>
References: <20230804110454.2935878-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgAXODLGasxkWSvZOg--.12542S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw1ktF4UAF1DKr4UJr1xuFg_yoW8Zw48pr
        yxCFy3Wrs0qa4Fga4Iyw1kuryYyrs3GF43JrW2yr18A3W5XFn2gF92yryqvryYg34fZFyj
        v3yvyFW8Cw47A37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_Jr4l82xGYIkIc2x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2
        F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjx
        v20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2
        z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
        IFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pR3PE3UUUUU
        =
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

skip_offline_sections_reverse will return the last pfn in found online
section. Then we set block_start_pfn to start of page block which
contains the last pfn in section. Then we continue, move one page
block forward and ignore the last page block in the online section.
Make block_start_pfn point to first page block after online section to fix
this:
1. make skip_offline_sections_reverse return end pfn of online section,
i.e. pfn of page block after online section.
2. assign block_start_pfn with next_pfn.

Fixes: f63224525309 ("mm: compaction: skip the memory hole rapidly when isolating free pages")
Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Acked-by: David Hildenbrand <david@redhat.com>

---
 mm/compaction.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 006fc35bffa1..a21b834c5898 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -250,6 +250,11 @@ static unsigned long skip_offline_sections(unsigned long start_pfn)
 	return 0;
 }
 
+/*
+ * If the PFN falls into an offline section, return the end PFN of the
+ * next online section in reverse. If the PFN falls into an online section
+ * or if there is no next online section in reverse, return 0.
+ */
 static unsigned long skip_offline_sections_reverse(unsigned long start_pfn)
 {
 	unsigned long start_nr = pfn_to_section_nr(start_pfn);
@@ -259,7 +264,7 @@ static unsigned long skip_offline_sections_reverse(unsigned long start_pfn)
 
 	while (start_nr-- > 0) {
 		if (online_section_nr(start_nr))
-			return section_nr_to_pfn(start_nr) + PAGES_PER_SECTION - 1;
+			return section_nr_to_pfn(start_nr) + PAGES_PER_SECTION;
 	}
 
 	return 0;
@@ -1690,8 +1695,7 @@ static void isolate_freepages(struct compact_control *cc)
 
 			next_pfn = skip_offline_sections_reverse(block_start_pfn);
 			if (next_pfn)
-				block_start_pfn = max(pageblock_start_pfn(next_pfn),
-						      low_pfn);
+				block_start_pfn = max(next_pfn, low_pfn);
 
 			continue;
 		}
-- 
2.30.0

