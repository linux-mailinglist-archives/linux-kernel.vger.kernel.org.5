Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8177178F959
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 09:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348542AbjIAHwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 03:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjIAHwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 03:52:10 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9514910DE
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 00:52:06 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RcVbz2G29z4f3lVf
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 15:51:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDnw6YfmPFk1Z5cCA--.13825S2;
        Fri, 01 Sep 2023 15:52:00 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        mgorman@techsingularity.net, david@redhat.com, willy@infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/6] Fixes and cleanups to compaction
Date:   Fri,  1 Sep 2023 23:51:35 +0800
Message-Id: <20230901155141.249860-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDnw6YfmPFk1Z5cCA--.13825S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CrWrtFyrAr1kGw4rZrWxtFb_yoW8GFW3pr
        s3tw1fJw43G3WS9FWSya18Z3W5Kr4rGr1UJrnFgryrW3Z0kwn2yFn2yFyrZryUXryayrZF
        qr4kKFWxGFsrZFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E
        3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r
        xl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv
        0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z2
        80aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
        IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jIGQDUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        MAY_BE_FORGED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
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

v2->v3:
-Collect RVB and ACK from Baolin and Mel
-Avoid blockpfn outside pageblock in original likely(order <= MAX_ORDER)
block in patch 3
-Move comment into __reset_isolation_suitable in patch 4
-Improve indentation in patch 6

v1->v2:
-Collect RVB from Baolin.
-Keep pfn inside of pageblock in patch 3.
-Only improve comment of is_via_compact_memory in patch 6.
-Squash patch 8 and patch 9 into patch 7 and use ALLOC_WMARK_MIN
instead of magic number 0.

Kemeng Shi (6):
  mm/compaction: use correct list in move_freelist_{head}/{tail}
  mm/compaction: call list_is_{first}/{last} more intuitively in
    move_freelist_{head}/{tail}
  mm/compaction: correctly return failure with bogus compound_order in
    strict mode
  mm/compaction: remove repeat compact_blockskip_flush check in
    reset_isolation_suitable
  mm/compaction: improve comment of is_via_compact_memory
  mm/compaction: factor out code to test if we should run compaction for
    target order

 mm/compaction.c | 91 ++++++++++++++++++++++++++++---------------------
 1 file changed, 52 insertions(+), 39 deletions(-)

-- 
2.30.0

