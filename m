Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF247933C4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 04:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236389AbjIFCeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 22:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjIFCd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 22:33:58 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9027CF0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 19:33:54 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RgRJW4dSQz4f3l72
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 10:33:47 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.26])
        by APP4 (Coremail) with SMTP id gCh0CgAHl6kO5fdkNo7mCQ--.16130S4;
        Wed, 06 Sep 2023 10:33:51 +0800 (CST)
From:   Xiu Jianfeng <xiujianfeng@huaweicloud.com>
To:     akpm@linux-foundation.org, Liam.Howlett@oracle.com,
        willy@infradead.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xiujianfeng@huawei.com
Subject: [PATCH] mm: remove duplicated vma->vm_flags check when expanding stack
Date:   Wed,  6 Sep 2023 10:33:12 +0000
Message-Id: <20230906103312.645712-1-xiujianfeng@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHl6kO5fdkNo7mCQ--.16130S4
X-Coremail-Antispam: 1UD129KBjvdXoWruryUGw17Xw1rXw4xJF1xGrg_yoWDtrc_X3
        yvgF18uF1UtFWfCws3Cr10qrnYvw4kGr4IkasYgFZxJr1DCrWrAFyDGry3X3y5tFZ8ta4D
        CF1qvayIvr1vgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb7AYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl8c
        AvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq
        3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gc
        CE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxI
        r21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87
        Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU0VnQUUUUUU==
X-CM-SenderInfo: x0lxyxpdqiv03j6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiu Jianfeng <xiujianfeng@huawei.com>

expand_upwards() and expand_downwards() will return -EFAULT if VM_GROWSUP
or VM_GROWSDOWN is not correctly set in vma->vm_flags, however in
!CONFIG_STACK_GROWSUP case, expand_stack_locked() returns -EINVAL first
if !(vma->vm_flags & VM_GROWSDOWN) before calling expand_downwards(), to
keep the consistency with CONFIG_STACK_GROWSUP case, remove this check.

Fixes: f440fa1ac955 ("mm: make find_extend_vma() fail if write lock not held")
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 mm/mmap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index b56a7f0c9f85..ed4848db7515 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2159,8 +2159,6 @@ struct vm_area_struct *find_extend_vma_locked(struct mm_struct *mm, unsigned lon
 #else
 int expand_stack_locked(struct vm_area_struct *vma, unsigned long address)
 {
-	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN)))
-		return -EINVAL;
 	return expand_downwards(vma, address);
 }
 
-- 
2.34.1

