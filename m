Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775ED78945C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 09:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbjHZHgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 03:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjHZHgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 03:36:35 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2345213C
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 00:36:32 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RXpXp2vb9z4f3khq
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 15:36:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP1 (Coremail) with SMTP id cCh0CgDHQi98q+lk6GgZBg--.2153S2;
        Sat, 26 Aug 2023 15:36:29 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        mgorman@techsingularity.net, david@redhat.com, willy@infradead.org
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH v2 0/7] Fixes and cleanups to compaction
Date:   Sat, 26 Aug 2023 23:36:10 +0800
Message-Id: <20230826153617.4019189-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDHQi98q+lk6GgZBg--.2153S2
X-Coremail-Antispam: 1UD129KBjvJXoW7JryUCr4rJryrWr4rtw13urg_yoW8JF18pr
        Z3tw13tw47t3ZI9F4ftF48Za15tr4rGr15JrnrKr1rW3Z0kw1vyFn2yryrZryUXryayr42
        vr4kKr48GFsrZFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
        0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xv
        wVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjc
        xK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
        W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
        0VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
        AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
        c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
        AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWU
        JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0pRQo7
        tUUUUU=
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
Patch 7 factor code to check if compaction is needed for allocation
order.
More details can be found in respective patches. Thanks!

v1->v2:
-Collect RVB from Baolin.
-Keep pfn inside of pageblock in patch 3.
-Only improve comment of is_via_compact_memory in patch 6.
-Squash patch 8 and patch 9 into patch 7 and use ALLOC_WMARK_MIN
instead of magic number 0.

Kemeng Shi (7):
  mm/compaction: use correct list in move_freelist_{head}/{tail}
  mm/compaction: call list_is_{first}/{last} more intuitively in
    move_freelist_{head}/{tail}
  mm/compaction: correctly return failure with bogus compound_order in
    strict mode
  mm/compaction: simplify pfn iteration in isolate_freepages_range
  mm/compaction: remove repeat compact_blockskip_flush check in
    reset_isolation_suitable
  mm/compaction: improve comment of is_via_compact_memory
  mm/compaction: factor out code to test if we should run compaction for
    target order

 mm/compaction.c | 106 +++++++++++++++++++++++++-----------------------
 1 file changed, 56 insertions(+), 50 deletions(-)

-- 
2.30.0

