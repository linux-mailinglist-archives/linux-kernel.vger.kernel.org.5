Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DE376DD80
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 03:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjHCBtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 21:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbjHCBs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 21:48:58 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8A430EA
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 18:48:48 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RGWwD62r5z4f403t
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 09:48:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP3 (Coremail) with SMTP id _Ch0CgCXQiB7B8tkVa5vOQ--.12634S2;
        Thu, 03 Aug 2023 09:48:45 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        mgorman@techsingularity.net, david@redhat.com
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH v2 0/4] Fixes and cleanups to compaction
Date:   Thu,  3 Aug 2023 17:48:57 +0800
Message-Id: <20230803094901.2915942-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCXQiB7B8tkVa5vOQ--.12634S2
X-Coremail-Antispam: 1UD129KBjvdXoWruF1ktF1kuFyUAF18JFWxXrb_yoW3trX_ua
        4xtFWUtr1F9Fy7ZF1DKw4SyFyDGFWUCry8J3s5Xr4UJ392van5J3ZrZrW3Zr13Xa47K3sx
        Gw1rJw10yr1a9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbxxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M28lY4IEw2IIxx
        k0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK
        6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7
        xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
        FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
        0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
        x2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_
        Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjTRNg
        AwUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, this series contains random fixes and cleanups to free page
isolation in compaction. This is based on another compact series[1].
More details can be found in respective patches. Thanks!

v1->v2:
-drop patch "mm/compaction: allow blockpfn outside of pageblock for high
order buddy page" no real issue will be fixed by this.
-Collect RVB from Baolin

Kemeng Shi (4):
  mm/compaction: set compact_cached_free_pfn correctly in 
    update_pageblock_skip
  mm/compaction: merge end_pfn boundary check in isolate_freepages_range
  mm/compaction: remove unnecessary cursor page in
    isolate_freepages_block
  mm/compaction: remove unnecessary "else continue" at end of loop in
    isolate_freepages_block

 mm/compaction.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

-- 
2.30.0

