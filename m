Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458CD7AA9BD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjIVHJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjIVHJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:09:53 -0400
Received: from out-218.mta0.migadu.com (out-218.mta0.migadu.com [91.218.175.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F9618F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 00:09:46 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695366584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=STMVv9/CmiXKMmwvCbzFA6MyMoHyyxo+IXJElKifvKA=;
        b=j0GTHFYy9Rk5aQNPly91khvCvLtwROqnl6vRLK2YLT+q+Ckq9y7J8JmUPeMGSeIGl6ob14
        RQel5IHpBuyun/wEWjeoBxFMWPpb5arxb/E6E05pBTu3mlyQ0pzqEI0SX+E2uvTNOdnRHG
        8GUu92LCbxLU8/Bk8txAzluhMqfxjas=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev, glider@google.com, elver@google.com,
        dvyukov@google.com, rppt@kernel.org, david@redhat.com,
        osalvador@suse.de
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH 0/4] mm: Don't set and reset page count in MEMINIT_EARLY
Date:   Fri, 22 Sep 2023 15:09:19 +0800
Message-Id: <20230922070923.355656-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__init_single_page would set page count and __free_pages_core would
reset it. A lot of pages don't need to do this when in MEMINIT_EARLY
context. It's unnecessary and time-consuming.

The first two patches are in preparation for the next two, they didn't
change anything.
The third patch only set page count for the reserved region, not all
of the region.
The fourth patch removes the set paget count in deferred_init_pages.

Yajun Deng (4):
  mm: pass set_count and set_reserved to __init_single_page
  mm: Introduce MEMINIT_LATE context
  mm: Set page count and mark page reserved in reserve_bootmem_region
  mm: don't set page count in deferred_init_pages

 include/linux/mmzone.h |  1 +
 mm/hugetlb.c           |  2 +-
 mm/internal.h          | 10 +++++---
 mm/kmsan/init.c        |  2 +-
 mm/memblock.c          |  4 +--
 mm/memory_hotplug.c    |  2 +-
 mm/mm_init.c           | 57 +++++++++++++++++++++++++-----------------
 mm/page_alloc.c        | 22 +++++++++-------
 8 files changed, 59 insertions(+), 41 deletions(-)

-- 
2.25.1

