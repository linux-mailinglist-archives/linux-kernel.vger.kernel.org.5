Return-Path: <linux-kernel+bounces-8884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C4D81BDBF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A1A028911B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA10634F6;
	Thu, 21 Dec 2023 18:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ea6gr3dH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822A55990A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 18:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703181649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ztPTKR8sr9h6D18SGkQNBYXp/fqVZdKTe5VGqgvKvQk=;
	b=ea6gr3dHoZVnBVxsz7Lv0gahIQ7R6TjWF+UWkxyDh6aRnEKLyT6WCUetH/UFbxrfUHM2nX
	ZiHFFaywum9XP//SPR5kuQLc5lxkrbC/ghAWwN1WS77TNJMUlFfKUnMlhUuaLnC/sPcJ4Y
	ZLmtpE2KnHgmrE0amIm/az1Ms2e+PQo=
From: andrey.konovalov@linux.dev
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	kasan-dev@googlegroups.com,
	Nathan Chancellor <nathan@kernel.org>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm] kasan: Mark unpoison_slab_object() as static
Date: Thu, 21 Dec 2023 19:00:42 +0100
Message-Id: <20231221180042.104694-1-andrey.konovalov@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Nathan Chancellor <nathan@kernel.org>

With -Wmissing-prototypes enabled, there is a warning that
unpoison_slab_object() has no prototype, breaking the build with
CONFIG_WERROR=y:

  mm/kasan/common.c:271:6: error: no previous prototype for 'unpoison_slab_object' [-Werror=missing-prototypes]
    271 | void unpoison_slab_object(struct kmem_cache *cache, void *object, gfp_t flags,
        |      ^~~~~~~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors

Mark the function as static, as it is not used outside of this
translation unit, clearing up the warning.

Fixes: 3f38c3c5bc40 ("kasan: save alloc stack traces for mempool")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v1->v2:
- Mark as "static inline" instead of just "static".
---
 mm/kasan/common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index ebb1b23d6480..f4255e807b74 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -277,8 +277,8 @@ void __kasan_kfree_large(void *ptr, unsigned long ip)
 	/* The object will be poisoned by kasan_poison_pages(). */
 }
 
-void unpoison_slab_object(struct kmem_cache *cache, void *object, gfp_t flags,
-			  bool init)
+static inline void unpoison_slab_object(struct kmem_cache *cache, void *object,
+					gfp_t flags, bool init)
 {
 	/*
 	 * Unpoison the whole object. For kmalloc() allocations,
-- 
2.25.1


