Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64AE7770D60
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 05:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjHEDHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 23:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjHEDHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 23:07:07 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9EB4EE3
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 20:07:02 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RHnYW3qQlz4f3lKk
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 11:06:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgAHvrHQvM1k6A5ePg--.23962S2;
        Sat, 05 Aug 2023 11:06:58 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        mgorman@techsingularity.net, david@redhat.com
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH 0/9] Fixes and cleanups to compaction
Date:   Sat,  5 Aug 2023 19:07:02 +0800
Message-Id: <20230805110711.2975149-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHvrHQvM1k6A5ePg--.23962S2
X-Coremail-Antispam: 1UD129KBjvJXoW7JryUCr4rJryrWr13Jw1DKFg_yoW8Jry5pr
        4ayw1fJa4xX3W3Cr4fta18ua15Kr4rGr4UJrnFqry8X3WYk3Z2y3Z7tFyrZryUZryayr4Y
        vFWDKr1xGFsrZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
        0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
        wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
        x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
        64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
        1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
        YI8I648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7sRi
        Pl1DUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, this is another series to do fix and clean up to compaction.
Patch 1-2 fix and clean up freepage list operation.
Patch 3-4 fix and clean up isolation of freepages
Patch 7-9 factor code to check if compaction is needed for allocation
order.
More details can be found in respective patches. Thanks!

Kemeng Shi (9):
  mm/compaction: use correct list in move_freelist_{head}/{tail}
  mm/compaction: call list_is_{first}/{last} more intuitively in
    move_freelist_{head}/{tail}
  mm/compaction: correctly return failure with bogus compound_order in
    strict mode
  mm/compaction: simplify pfn iteration in isolate_freepages_range
  mm/compaction: remove repeat compact_blockskip_flush check in
    reset_isolation_suitable
  mm/compaction: rename is_via_compact_memory to
    compaction_with_allocation_order
  mm/compaction: factor out code to test if we should run compaction for
    target order
  mm/compaction: call compaction_suit_allocation_order in
    kcompactd_node_suitable
  mm/compaction: call compaction_suit_allocation_order in
    kcompactd_do_work

 mm/compaction.c | 119 +++++++++++++++++++++++-------------------------
 1 file changed, 57 insertions(+), 62 deletions(-)

-- 
2.30.0

