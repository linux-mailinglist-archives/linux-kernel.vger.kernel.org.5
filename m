Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C0D7937F0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 11:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235898AbjIFJUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 05:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjIFJUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:20:49 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5CA99CC2;
        Wed,  6 Sep 2023 02:20:45 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.176])
        by gateway (Coremail) with SMTP id _____8Bx5fBrRPhkIUMgAA--.65163S3;
        Wed, 06 Sep 2023 17:20:43 +0800 (CST)
Received: from loongson-pc.loongson.cn (unknown [10.180.13.176])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxJ8xYRPhksV9uAA--.28103S2;
        Wed, 06 Sep 2023 17:20:41 +0800 (CST)
From:   Hongchen Zhang <zhanghongchen@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        "Mike Rapoport IBM)" <rppt@kernel.org>,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        "Matthew Wilcox Oracle)" <willy@infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: [PATCH v3] LoongArch: add p?d_leaf() definitions
Date:   Wed,  6 Sep 2023 17:20:19 +0800
Message-Id: <20230906092019.4681-1-zhanghongchen@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxJ8xYRPhksV9uAA--.28103S2
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/1tbiAQAGB2T3-DUDaQAFs1
X-Coremail-Antispam: 1Uk129KBj93XoW7Cr18AF4Dtr1UZF4ktr15ZFc_yoW8JFyrpF
        nrCFyvgF45GF97C34DJr1Y9F1DAws7WF42gryYya18JF13Xw4kZryDXrs8ZFW5XaykXFWI
        gFs3Kw1YgF18XwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUk529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
        6F4UJVW0owAaw2AFwI0_Jw0_GFyle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
        Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
        WrylYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x02
        67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0byCPUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I do LTP test, LTP test case ksm06 caused panic at
	break_ksm_pmd_entry
	  -> pmd_leaf (Huge page table but False)
	  -> pte_present (panic)

The reason is pmd_leaf is not defined, So like
commit 501b81046701 ("mips: mm: add p?d_leaf() definitions")
add p?d_leaf() definition for LoongArch.

Fixes: 09cfefb7fa70 ("LoongArch: Add memory management")
Cc: stable@vger.kernel.org
Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
---
v2->v3: add Cc: stable@vger.kernel.org
v1->v2: add Fixes in commit message
---
 arch/loongarch/include/asm/pgtable.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index 370c6568ceb8..ea54653b7aab 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -243,6 +243,9 @@ static inline void pmd_clear(pmd_t *pmdp)
 
 #define pmd_phys(pmd)		PHYSADDR(pmd_val(pmd))
 
+#define pmd_leaf(pmd)		((pmd_val(pmd) & _PAGE_HUGE) != 0)
+#define pud_leaf(pud)		((pud_val(pud) & _PAGE_HUGE) != 0)
+
 #ifndef CONFIG_TRANSPARENT_HUGEPAGE
 #define pmd_page(pmd)		(pfn_to_page(pmd_phys(pmd) >> PAGE_SHIFT))
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE  */
-- 
2.33.0

