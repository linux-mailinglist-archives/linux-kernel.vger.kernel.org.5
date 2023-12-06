Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC40F806AFD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 10:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377257AbjLFJq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 04:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377117AbjLFJq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 04:46:27 -0500
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD4AB9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 01:46:33 -0800 (PST)
Subject: [PATCH 0/7] mm/zswap: optimize the scalability of zswap rb-tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAO9CcGUC/32NQQ6CMBBFr0K6dkxboFFX3MO4mJZBGqElLWKAcHcnHsDVz/vJ+38XmZKnLG7FLh
 ItPvsYGNSpEK7H8CTwLbPQUpdKSwNb/uAEQ3QviNPsR78RSNNVtbmUVmor2LSYCWzC4Hp2w3sYuOx9
 nmNaf0+L4rj/H10USMBatdhdJVambuw6U8ujdHZxFI/jOL54/1j7vwAAAA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <zhouchengming@bytedance.com>
Date:   Wed, 06 Dec 2023 09:46:23 +0000
Message-Id: <20231206-zswap-lock-optimize-v1-0-e25b059f9c3a@bytedance.com>
To:     Vitaly Wool <vitaly.wool@konsulko.com>,
        Nhat Pham <nphamcs@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701855988; l=2374;
 i=zhouchengming@bytedance.com; s=20231204; h=from:subject:message-id;
 bh=ZUmVIzkk9h5a7jG1DSbEiHyv42C0TisIv/tuXS/b9FI=;
 b=v7FNoAm43YiIa5Npw5ppqnz5oIvdCJotBHotyX5cG8PUceUYEiOf3N55WEbaP5lOhfWY/Lo3P
 R9D2NFv19D6CWBJ+PWsVby49y+id2ERocDx3C8NuKgJg0fzzybdL5+5
X-Developer-Key: i=zhouchengming@bytedance.com; a=ed25519;
 pk=xFTmRtMG3vELGJBUiml7OYNdM393WOMv0iWWeQEVVdA=
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This patch series is based on the linux-next 20231205, which depends on
the "workload-specific and memory pressure-driven zswap writeback" series
from Nhat Pham.

When testing the zswap performance by using kernel build -j32 in a tmpfs
directory, I found the scalability of zswap rb-tree is not good, which
is protected by the only spinlock. That would cause heavy lock contention
if multiple tasks zswap_store/load concurrently.

So a simple solution is to split the only one zswap rb-tree into multiple
rb-trees, each corresponds to SWAP_ADDRESS_SPACE_PAGES (64M). This idea is
from the commit 4b3ef9daa4fc ("mm/swap: split swap cache into 64MB trunks").

Although this method can't solve the spinlock contention completely, it
can mitigate much of that contention.

Another problem when testing the zswap using our default zsmalloc is that
zswap_load() and zswap_writeback_entry() have to malloc a temporary memory
to support !zpool_can_sleep_mapped().

Optimize it by reusing the percpu crypto_acomp_ctx->dstmem, which is also
used by zswap_store() and protected by the same percpu crypto_acomp_ctx->mutex.

Thanks for review and comment!

To: Andrew Morton <akpm@linux-foundation.org>
To: Seth Jennings <sjenning@redhat.com>
To: Dan Streetman <ddstreet@ieee.org>
To: Vitaly Wool <vitaly.wool@konsulko.com>
To: Nhat Pham <nphamcs@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

---
Chengming Zhou (7):
      mm/zswap: make sure each swapfile always have zswap rb-tree
      mm/zswap: split zswap rb-tree
      mm/zswap: reuse dstmem when decompress
      mm/zswap: change dstmem size to one page
      mm/zswap: refactor out __zswap_load()
      mm/zswap: cleanup zswap_load()
      mm/zswap: cleanup zswap_reclaim_entry()

 include/linux/zswap.h |   4 +-
 mm/swapfile.c         |  10 ++-
 mm/zswap.c            | 233 +++++++++++++++++++++-----------------------------
 3 files changed, 106 insertions(+), 141 deletions(-)
---
base-commit: 0f5f12ac05f36f117e793656c3f560625e927f1b
change-id: 20231206-zswap-lock-optimize-06f45683b02b

Best regards,
-- 
Chengming Zhou <zhouchengming@bytedance.com>
