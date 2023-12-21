Return-Path: <linux-kernel+bounces-9020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3C981BF57
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 899B0285A38
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672FB745ED;
	Thu, 21 Dec 2023 20:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oUd4oho2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEF973197
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 20:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703189099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=25+JPAVVR93qloIeZBPh87TvRbXcdeZ++9g3nzTCJ2g=;
	b=oUd4oho2PQFVBsMx441Y1BJ9xZLJRj3/NEa+HI+PvsMu+h8/Evf4eJR6JIIS7+fS93FGb7
	Ih/Fyn0cbQWAZzwK+nS3P7ZRUaf95dp2MAee2vmD/jR6DwOerV5e/55LchsDaXoVGmFMIn
	0QPWF12bI5PU1x2N2e+NkASW14dnAIM=
From: andrey.konovalov@linux.dev
To: Marco Elver <elver@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	kasan-dev@googlegroups.com,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm 02/11] mm, kasan: use KASAN_TAG_KERNEL instead of 0xff
Date: Thu, 21 Dec 2023 21:04:44 +0100
Message-Id: <71db9087b0aebb6c4dccbc609cc0cd50621533c7.1703188911.git.andreyknvl@google.com>
In-Reply-To: <cover.1703188911.git.andreyknvl@google.com>
References: <cover.1703188911.git.andreyknvl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Andrey Konovalov <andreyknvl@google.com>

Use the KASAN_TAG_KERNEL marco instead of open-coding 0xff in the mm
code. This macro is provided by include/linux/kasan-tags.h, which does
not include any other headers, so it's safe to include it into mm.h
without causing circular include dependencies.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/kasan.h | 1 +
 include/linux/mm.h    | 4 ++--
 mm/page_alloc.c       | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index d49e3d4c099e..dbb06d789e74 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -4,6 +4,7 @@
 
 #include <linux/bug.h>
 #include <linux/kasan-enabled.h>
+#include <linux/kasan-tags.h>
 #include <linux/kernel.h>
 #include <linux/static_key.h>
 #include <linux/types.h>
diff --git a/include/linux/mm.h b/include/linux/mm.h
index a422cc123a2d..8b2e4841e817 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1815,7 +1815,7 @@ static inline void vma_set_access_pid_bit(struct vm_area_struct *vma)
 
 static inline u8 page_kasan_tag(const struct page *page)
 {
-	u8 tag = 0xff;
+	u8 tag = KASAN_TAG_KERNEL;
 
 	if (kasan_enabled()) {
 		tag = (page->flags >> KASAN_TAG_PGSHIFT) & KASAN_TAG_MASK;
@@ -1844,7 +1844,7 @@ static inline void page_kasan_tag_set(struct page *page, u8 tag)
 static inline void page_kasan_tag_reset(struct page *page)
 {
 	if (kasan_enabled())
-		page_kasan_tag_set(page, 0xff);
+		page_kasan_tag_set(page, KASAN_TAG_KERNEL);
 }
 
 #else /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7ea9c33320bf..51e85760877a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1059,7 +1059,7 @@ static inline bool should_skip_kasan_poison(struct page *page, fpi_t fpi_flags)
 	if (IS_ENABLED(CONFIG_KASAN_GENERIC))
 		return deferred_pages_enabled();
 
-	return page_kasan_tag(page) == 0xff;
+	return page_kasan_tag(page) == KASAN_TAG_KERNEL;
 }
 
 static void kernel_init_pages(struct page *page, int numpages)
-- 
2.25.1


