Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7E37B1612
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 10:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjI1IdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 04:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjI1IdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:33:20 -0400
Received: from out-195.mta1.migadu.com (out-195.mta1.migadu.com [95.215.58.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1893B7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 01:33:18 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695889997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EK+Jf0tqtbrhgvVtYbc6M1gK2luKPcAwtjtGkN+0G7E=;
        b=DyrIRUf26UR/UJTU1Ws6FpvKsQg1V3IOLHQBP6BKhTzqv3DgfxHgWIVDmW9HhYKlmfWGRf
        cOFntnToBVir4TJMYBQsKAdjlCmjdhRrW1zo3tgjZZoATXInL4qUVAVLFU+7q4QrVuHual
        DwKiW7TDEJuWib4S5r80VzNQaEeY3J4=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     akpm@linux-foundation.org, rppt@kernel.org
Cc:     mike.kravetz@oracle.com, muchun.song@linux.dev,
        willy@infradead.org, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH v4 0/2] mm: Don't set and reset page count in MEMINIT_EARLY
Date:   Thu, 28 Sep 2023 16:33:00 +0800
Message-Id: <20230928083302.386202-1-yajun.deng@linux.dev>
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
 mm/mm_init.c    | 38 ++++++++++++++++++++++++--------------
 mm/page_alloc.c | 20 ++++++++++++--------
 4 files changed, 44 insertions(+), 24 deletions(-)

-- 
2.25.1

