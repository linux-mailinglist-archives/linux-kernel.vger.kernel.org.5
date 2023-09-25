Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4AE7AD188
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjIYHW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjIYHW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:22:26 -0400
Received: from out-194.mta1.migadu.com (out-194.mta1.migadu.com [95.215.58.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCA3192
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 00:22:15 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695626531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xYGJKvwyxelEGCoj1HuYpU6D4jZuMAySPDKkIDk1zzk=;
        b=Pe4cl4atEQiQ9Qr4Vs1ri25Wr5RLSc9i6noi+ib0BrhZ7cOI85cev+Qf4qrzLCjkiKzPBL
        y4WTkVs10+cFYeFIqHLzyYHbPUwe15k9gpQDNtBDV1ZvLKCZSuaMUGdduP8V28kzzgcKy2
        h3yaS7/Q/mbue5RK+JzfXzrGZXHrjcs=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     akpm@linux-foundation.org, rppt@kernel.org
Cc:     mike.kravetz@oracle.com, muchun.song@linux.dev,
        willy@infradead.org, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH v2 0/2] mm: Don't set and reset page count in MEMINIT_EARLY
Date:   Mon, 25 Sep 2023 15:21:48 +0800
Message-Id: <20230925072150.386880-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__init_single_page would set page count and __free_pages_core would
reset it. A lot of pages don't need to do this when in MEMINIT_EARLY
context. It's unnecessary and time-consuming.

The 1st patch is pass page count and reserved to __init_single_page.
It's in preparation for the 2nd patch, it didn't change anything.

The 2nd patch only set page count for the reserved region, not all
of the region.

Yajun Deng (2):
  mm: pass page count and reserved to __init_single_page
  mm: Init page count in reserve_bootmem_region when MEMINIT_EARLY

 mm/hugetlb.c    |  2 +-
 mm/internal.h   |  8 +++++++-
 mm/mm_init.c    | 45 ++++++++++++++++++++++++++++-----------------
 mm/page_alloc.c | 20 ++++++++++++--------
 4 files changed, 48 insertions(+), 27 deletions(-)

-- 
2.25.1

