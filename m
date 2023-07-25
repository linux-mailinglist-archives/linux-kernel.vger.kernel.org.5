Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0931761185
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjGYKwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbjGYKvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:51:14 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AF01FEF;
        Tue, 25 Jul 2023 03:50:45 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4R9DMh2YK6z4f3tDK;
        Tue, 25 Jul 2023 18:50:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgC3quj+qL9kl7XQOg--.17520S10;
        Tue, 25 Jul 2023 18:50:42 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ritesh.list@gmail.com,
        ojaswin@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH v2 08/10] ext4: return found group directly in ext4_mb_choose_next_group_goal_fast
Date:   Wed, 26 Jul 2023 02:51:04 +0800
Message-Id: <20230725185106.2147273-9-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230725185106.2147273-1-shikemeng@huaweicloud.com>
References: <20230725185106.2147273-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgC3quj+qL9kl7XQOg--.17520S10
X-Coremail-Antispam: 1UD129KBjvdXoWrZFykAr45Wry5CFWxAFy5Arb_yoWDKrb_Ga
        47AFs3AayrAr18G3WF9wsYyr48KFWkAr4DXr9xtF45W3WUCFykK3Wq9r4rAay8ua10yry3
        KasIvFWxKF4SqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbq8FF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M28IrcIa0xkI8V
        A2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJ
        M28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2I
        x0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK
        6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4
        xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8
        JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20V
        AGYxC7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
        wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
        0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AK
        xVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F
        4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRKfOw
        UUUUU
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

Return good group when it's found in loop to remove futher check if good
group is found after loop.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/mballoc.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 73f8ecdf4d23..88a3c00e484f 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -959,16 +959,14 @@ static void ext4_mb_choose_next_group_goal_fast(struct ext4_allocation_context *
 	for (i = mb_avg_fragment_size_order(ac->ac_sb, ac->ac_g_ex.fe_len);
 	     i < MB_NUM_ORDERS(ac->ac_sb); i++) {
 		grp = ext4_mb_find_good_group_avg_frag_lists(ac, i);
-		if (grp)
-			break;
+		if (grp) {
+			*group = grp->bb_group;
+			ac->ac_flags |= EXT4_MB_CR_GOAL_LEN_FAST_OPTIMIZED;
+			return;
+		}
 	}
 
-	if (grp) {
-		*group = grp->bb_group;
-		ac->ac_flags |= EXT4_MB_CR_GOAL_LEN_FAST_OPTIMIZED;
-	} else {
-		*new_cr = CR_BEST_AVAIL_LEN;
-	}
+	*new_cr = CR_BEST_AVAIL_LEN;
 }
 
 /*
-- 
2.30.0

