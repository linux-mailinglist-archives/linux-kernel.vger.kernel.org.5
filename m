Return-Path: <linux-kernel+bounces-6063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC238193B3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 178DAB23D39
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD69D4D588;
	Tue, 19 Dec 2023 22:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PVS7/Vp9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8C54CB34
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 22:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703025150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EPGVjwO+qP/d7FcuwPK2D6CcDKWjvT42oG4AsVrb0Go=;
	b=PVS7/Vp9rKcCStvahkmREEOMnuEX6kau1z/8KUeJ+M+L9oh0S/muURork3hPcDgoR/5lvV
	ReB2LpYutwX5p3c63FdFGnocPloJeeIBz+IrzYNEY41q/t2SiRz0dp5ZLm4EF8f/mEHnF3
	IzsuSBbMxsPovIvvYoBbisxMLMXLZwo=
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
Subject: [PATCH mm 21/21] io_uring: use mempool KASAN hook
Date: Tue, 19 Dec 2023 23:29:05 +0100
Message-Id: <eca18d6cbf676ed784f1a1f209c386808a8087c5.1703024586.git.andreyknvl@google.com>
In-Reply-To: <cover.1703024586.git.andreyknvl@google.com>
References: <cover.1703024586.git.andreyknvl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Andrey Konovalov <andreyknvl@google.com>

Use the proper kasan_mempool_unpoison_object hook for unpoisoning cached
objects.

A future change might also update io_uring to check the return value of
kasan_mempool_poison_object to prevent double-free and invalid-free bugs.
This proves to be non-trivial with the current way io_uring caches
objects, so this is left out-of-scope of this series.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 io_uring/alloc_cache.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/alloc_cache.h b/io_uring/alloc_cache.h
index 8de0414e8efe..bf2fb26a6539 100644
--- a/io_uring/alloc_cache.h
+++ b/io_uring/alloc_cache.h
@@ -33,7 +33,7 @@ static inline struct io_cache_entry *io_alloc_cache_get(struct io_alloc_cache *c
 		struct io_cache_entry *entry;
 
 		entry = container_of(cache->list.next, struct io_cache_entry, node);
-		kasan_unpoison_range(entry, cache->elem_size);
+		kasan_mempool_unpoison_object(entry, cache->elem_size);
 		cache->list.next = cache->list.next->next;
 		cache->nr_cached--;
 		return entry;
-- 
2.25.1


