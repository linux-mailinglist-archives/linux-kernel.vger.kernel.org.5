Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F413E7B383C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 19:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbjI2RAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 13:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbjI2RAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 13:00:49 -0400
Received: from out-196.mta0.migadu.com (out-196.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCFC1A7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:00:47 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696006845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TzFyE8zAwEgs0Q4irFkzPCcaXtODzp9uLW3nkoQP7WY=;
        b=wIX935S8qYqHMzheBghLWseBwTXg1uA6G99i7X59ETLXg1hy/6hwE4578pGY4pr18oxGDf
        0YBtfXEc0iFfRQ0YupoeS45PloX5DqzXXqAxUFCYFttQ8eiY63kaH83kIsffU+GPMqThXC
        oE8YAze/wzkyARxLUmy9qG0feJF3/8M=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     akpm@linux-foundation.org, rppt@kernel.org
Cc:     mike.kravetz@oracle.com, muchun.song@linux.dev,
        willy@infradead.org, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH v5 0/2] mm: Don't init and clear page count when MEMINIT_EARLY
Date:   Sat, 30 Sep 2023 01:00:24 +0800
Message-Id: <20230929170026.2520216-1-yajun.deng@linux.dev>
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

__init_single_page would init page count and __free_pages_core would
clear it. A lot of pages don't need to do this when in MEMINIT_EARLY
context. It's unnecessary and time-consuming.

The 1st patch is allow optional initialization of page count and
PG_reserved flag. It's in preparation for the 2nd patch, it didn't
change anything.

The 2nd patch only init page count for the reserved region, not all
of the region when MEMINIT_EARLY.

Yajun Deng (2):
  mm: allow optional initialization of page count and PG_reserved flag
  mm: Init page count in reserve_bootmem_region when MEMINIT_EARLY

 mm/hugetlb.c    |  2 +-
 mm/internal.h   |  8 +++++++-
 mm/mm_init.c    | 40 ++++++++++++++++++++++++++--------------
 mm/page_alloc.c | 20 ++++++++++++--------
 4 files changed, 46 insertions(+), 24 deletions(-)

-- 
2.25.1

