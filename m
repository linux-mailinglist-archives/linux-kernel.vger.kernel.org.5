Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA727574B9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjGRG6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjGRG6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:58:02 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAC41AC
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:57:57 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4R4qWy6nB4z4f3mKq
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 14:57:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgB3a+nfN7Zk36ikOA--.34217S3;
        Tue, 18 Jul 2023 14:57:37 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     akpm@linux-foundation.org, pasha.tatashin@soleen.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH 1/3] mm/page_ext: add common function to get client data from page_ext
Date:   Tue, 18 Jul 2023 22:58:10 +0800
Message-Id: <20230718145812.1991717-2-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230718145812.1991717-1-shikemeng@huaweicloud.com>
References: <20230718145812.1991717-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgB3a+nfN7Zk36ikOA--.34217S3
X-Coremail-Antispam: 1UD129KBjvdXoWruF48ZF1kJFy3AF1Uur13CFg_yoWfZwc_Aw
        1xtr48Gr1IvF9avw1UKw1xtFy5t3y8Gr47XF1ktrZ0yrnrKrs0ya18JasxXw4kWr1fXr9r
        Ca1kWrnrtr17ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb6AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M28IrcIa0xkI8V
        A2jI8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Jrv_JF4l8cAvFVAK0II2c7xJM28C
        jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI
        8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E
        87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYx
        C7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
        Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x
        0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWU
        JVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
        AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRiDGYDUUUUU=
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

Add common page_ext_data function to get client data. This could hide
offset which is auto generated in page_ext core and expose the desgin
of page_ext data layout.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 include/linux/page_ext.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
index 8dd21d87e0da..be98564191e6 100644
--- a/include/linux/page_ext.h
+++ b/include/linux/page_ext.h
@@ -81,6 +81,12 @@ static inline void page_ext_init(void)
 extern struct page_ext *page_ext_get(struct page *page);
 extern void page_ext_put(struct page_ext *page_ext);
 
+static inline void *page_ext_data(struct page_ext *page_ext,
+				  struct page_ext_operations *ops)
+{
+	return (void *)(page_ext) + ops->offset;
+}
+
 static inline struct page_ext *page_ext_next(struct page_ext *curr)
 {
 	void *next = curr;
-- 
2.30.0

