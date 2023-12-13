Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB8581090D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 05:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378415AbjLMESP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 23:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235222AbjLMESO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 23:18:14 -0500
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA072AC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 20:18:19 -0800 (PST)
Subject: [PATCH 0/5] mm/zswap: dstmem reuse optimizations and cleanups
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAHUweWUC/w3LSQqAMAwAwK9IzgZsgyL+pku0Ba3SuIDSv9vjHOYD4RxZYGo+yHxHiXuqUG0DLp
 i0MEZfDbrTpLQifOUxB3o5N97Qj3qc+4GoIw+1WCOMNpvkQk3pWtdSfqkk0JBjAAAA
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <zhouchengming@bytedance.com>
Date:   Wed, 13 Dec 2023 04:17:57 +0000
Message-Id: <20231213-zswap-dstmem-v1-0-896763369d04@bytedance.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Nhat Pham <nphamcs@gmail.com>, Chris Li <chriscli@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Yosry Ahmed <yosryahmed@google.com>
Cc:     Nhat Pham <nphamcs@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Chengming Zhou <zhouchengming@bytedance.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702441093; l=1265;
 i=zhouchengming@bytedance.com; s=20231204; h=from:subject:message-id;
 bh=4N/N3d6vf4Cr8tlyMdsv58l39FdZR4xTSa4G2vw01Tw=;
 b=1H0ZW0s0yYdhJDk8Es+apfTEC49Edv/TqZq9k2TzSK0aD8m5foU+riuo2CXYcYDjsAgQ/8ByF
 zBPo/uKizNyBUejluXNo+6s313o5t3iTXcbL5qro6LEOgIRKmJk29cE
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

This series is split from [1] to only include zswap dstmem reuse
optimizations and cleanups, the other part of rbtree breakdown will
be deferred to retest after the rbtree converted to xarray.

And the problem this series tries to optimize is that zswap_load()
and zswap_writeback_entry() have to malloc a temporary memory to
support !zpool_can_sleep_mapped(). We can avoid it by reusing the
percpu crypto_acomp_ctx->dstmem, which is also used by zswap_store()
and protected by the same percpu crypto_acomp_ctx->mutex.

[1] https://lore.kernel.org/all/20231206-zswap-lock-optimize-v1-0-e25b059f9c3a@bytedance.com/

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
Chengming Zhou (5):
      mm/zswap: reuse dstmem when decompress
      mm/zswap: change dstmem size to one page
      mm/zswap: refactor out __zswap_load()
      mm/zswap: cleanup zswap_load()
      mm/zswap: cleanup zswap_reclaim_entry()

 mm/zswap.c | 158 +++++++++++++++++++------------------------------------------
 1 file changed, 49 insertions(+), 109 deletions(-)
---
base-commit: 1f242c1964cf9b8d663a2fd72159b296205a8126
change-id: 20231213-zswap-dstmem-d828f563303d

Best regards,
-- 
Chengming Zhou <zhouchengming@bytedance.com>
