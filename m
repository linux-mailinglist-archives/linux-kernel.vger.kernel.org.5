Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93AE75751F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjGRHP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjGRHPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:15:55 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F83010C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:15:54 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4R4qWz23nSz4f3mLB
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 14:57:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgB3a+nfN7Zk36ikOA--.34217S4;
        Tue, 18 Jul 2023 14:57:37 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     akpm@linux-foundation.org, pasha.tatashin@soleen.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH 2/3] mm/page_ext: use page_ext_data helper in page_table_check
Date:   Tue, 18 Jul 2023 22:58:11 +0800
Message-Id: <20230718145812.1991717-3-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230718145812.1991717-1-shikemeng@huaweicloud.com>
References: <20230718145812.1991717-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgB3a+nfN7Zk36ikOA--.34217S4
X-Coremail-Antispam: 1UD129KBjvdXoWrtr13Cr17KF4UZr13XFy3twb_yoW3Jrb_t3
        42qwn8Xr9YqFyYyrnrC3s7JrWUK3409F45Xr18Kr90vr4rWr4kZa48X3ZI9rWkXryjqFyk
        urZ5XFnxCr47ZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb6AFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M28IrcIa0xkI8V
        A2jI8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28C
        jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI
        8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E
        87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYx
        C7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
        Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x
        0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
        JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
        AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sREO6pDUUUUU=
        =
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        KHOP_HELO_FCRDNS,MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use page_ext_data helper in page_table_check to avoid access offset
directly.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/page_table_check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 84c8163984e5..46e77c12c81e 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -51,7 +51,7 @@ struct page_ext_operations page_table_check_ops = {
 static struct page_table_check *get_page_table_check(struct page_ext *page_ext)
 {
 	BUG_ON(!page_ext);
-	return (void *)(page_ext) + page_table_check_ops.offset;
+	return page_ext_data(page_ext, &page_table_check_ops);
 }
 
 /*
-- 
2.30.0

