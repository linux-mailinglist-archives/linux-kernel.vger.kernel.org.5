Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA56A7E2DC0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 21:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbjKFUKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 15:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbjKFUKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 15:10:40 -0500
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [IPv6:2001:41d0:203:375::b0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF147D75
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 12:10:35 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699301433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2N8dClZX4LkeO9h3I7+1TV9x58bgqnnBtKmXGx6mG/E=;
        b=BE0rMBjPXM6NBg2ZLuCgNQZtZtu/Aes69+x5dc6h44mRv0DPnGCIuDvU3eryTOAcGk3hNg
        ivAZm/6KtxWe38HMEo8I8/AMzJXDVBqo4Mn3ZcihM5yvVZ3QNqmM7j4WvztErIv6cds9PK
        vR9a7t1q0ywIWsjkIqIoYhpVX9OdwQo=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH RFC 00/20] kasan: save mempool stack traces
Date:   Mon,  6 Nov 2023 21:10:09 +0100
Message-Id: <cover.1699297309.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

This series updates KASAN to save alloc and free stack traces for
secondary-level allocators that cache and reuse allocations internally
instead of giving them back to the underlying allocator (e.g. mempool).

As a part of this change, introduce and document a set of KASAN hooks:

bool kasan_mempool_poison_pages(struct page *page, unsigned int order);
void kasan_mempool_unpoison_pages(struct page *page, unsigned int order);
bool kasan_mempool_poison_object(void *ptr);
void kasan_mempool_unpoison_object(void *ptr, size_t size);

and use them in the mempool code.

Besides mempool, skbuff and io_uring also cache allocations and already
use KASAN hooks to poison those. Their code is updated to use the new
mempool hooks.

The new hooks save alloc and free stack traces (for normal kmalloc and
slab objects; stack traces for large kmalloc objects and page_alloc are
not supported by KASAN yet), improve the readability of the users' code,
and also allow the users to prevent double-free and invalid-free bugs;
see the patches for the details.

I'm posting this series as an RFC, as it has a few non-trivial-to-resolve
conflicts with the stack depot eviction patches. I'll rebase the series and
resolve the conflicts once the stack depot patches are in the mm tree.

Andrey Konovalov (20):
  kasan: rename kasan_slab_free_mempool to kasan_mempool_poison_object
  kasan: move kasan_mempool_poison_object
  kasan: document kasan_mempool_poison_object
  kasan: add return value for kasan_mempool_poison_object
  kasan: introduce kasan_mempool_unpoison_object
  kasan: introduce kasan_mempool_poison_pages
  kasan: introduce kasan_mempool_unpoison_pages
  kasan: clean up __kasan_mempool_poison_object
  kasan: save free stack traces for slab mempools
  kasan: clean up and rename ____kasan_kmalloc
  kasan: introduce poison_kmalloc_large_redzone
  kasan: save alloc stack traces for mempool
  mempool: use new mempool KASAN hooks
  mempool: introduce mempool_use_prealloc_only
  kasan: add mempool tests
  kasan: rename pagealloc tests
  kasan: reorder tests
  kasan: rename and document kasan_(un)poison_object_data
  skbuff: use mempool KASAN hooks
  io_uring: use mempool KASAN hook

 include/linux/kasan.h   | 161 +++++++-
 include/linux/mempool.h |   2 +
 io_uring/alloc_cache.h  |   5 +-
 mm/kasan/common.c       | 221 ++++++----
 mm/kasan/kasan_test.c   | 876 +++++++++++++++++++++++++++-------------
 mm/mempool.c            |  49 ++-
 mm/slab.c               |  10 +-
 mm/slub.c               |   4 +-
 net/core/skbuff.c       |  10 +-
 9 files changed, 940 insertions(+), 398 deletions(-)

-- 
2.25.1

