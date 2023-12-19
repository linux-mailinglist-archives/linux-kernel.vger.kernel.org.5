Return-Path: <linux-kernel+bounces-6041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 321D2819383
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAB26285AF3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E851D3D0C7;
	Tue, 19 Dec 2023 22:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cmqIC4mq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D113D0A2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 22:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703024951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4hIWKlq3vwUHvNMJIcXvuTboO6P/RRCs5XS67UMRG18=;
	b=cmqIC4mq/S1If3wT0VfK4ZSI8XnX48OZPjpLmv8Nch6LR34oryd27ZqdCEKyY6LHfFJJsq
	eErX9SPgAzm7ap40rzJt2NtwXY3A7eaRiArCtrdS3JJsvDA853U3/0S6FWfyzlfKznN6hI
	IldQO8JAQsTlsxMRb2XrXbDrvagtAkI=
From: andrey.konovalov@linux.dev
To: Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	kasan-dev@googlegroups.com,
	Evgenii Stepanov <eugenis@google.com>,
	Breno Leitao <leitao@debian.org>,
	Alexander Lobakin <alobakin@pm.me>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm 00/21] kasan: save mempool stack traces
Date: Tue, 19 Dec 2023 23:28:44 +0100
Message-Id: <cover.1703024586.git.andreyknvl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

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

There doesn't appear to be any conflicts with the KASAN patches that are
currently in mm, but I rebased the patchset on top just in case.

Changes RFC->v1:
- New patch "mempool: skip slub_debug poisoning when KASAN is enabled".
- Replace mempool_use_prealloc_only API with mempool_alloc_preallocated.
- Avoid triggering slub_debug-detected corruptions in mempool tests.

Andrey Konovalov (21):
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
  mempool: skip slub_debug poisoning when KASAN is enabled
  mempool: use new mempool KASAN hooks
  mempool: introduce mempool_use_prealloc_only
  kasan: add mempool tests
  kasan: rename pagealloc tests
  kasan: reorder tests
  kasan: rename and document kasan_(un)poison_object_data
  skbuff: use mempool KASAN hooks
  io_uring: use mempool KASAN hook

 include/linux/kasan.h   | 161 +++++++-
 include/linux/mempool.h |   1 +
 io_uring/alloc_cache.h  |   5 +-
 mm/kasan/common.c       | 221 ++++++----
 mm/kasan/kasan_test.c   | 870 +++++++++++++++++++++++++++-------------
 mm/mempool.c            |  67 +++-
 mm/slab.c               |  10 +-
 mm/slub.c               |   4 +-
 net/core/skbuff.c       |  10 +-
 9 files changed, 954 insertions(+), 395 deletions(-)

-- 
2.25.1


