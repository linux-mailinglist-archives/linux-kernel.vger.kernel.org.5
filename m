Return-Path: <linux-kernel+bounces-9022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2BE81BF59
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A680F286E1F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2CC760B9;
	Thu, 21 Dec 2023 20:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T3Q2NIda"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E565355E6C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 20:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703189101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=02IeghrfT0ytg5MuYoXhCbr9XM7hY33pPyxRWGvQP4Y=;
	b=T3Q2NIdanun939NScwaTG7WLvoYmfTTFiLEYJ3J+HNG2IsD+W9B/KY5/3GWHlronvX+HVx
	UO/qV9RzLo7I2y0mo6AY2SLB81+1FFxAYBxngYWc6AIhArd5EEHVGN3+RLEDZyXA+UgF4y
	2f6iUwmX7QGqhFZ2rrVU/A585fQMbwc=
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
Subject: [PATCH mm 04/11] kasan: clean up kasan_requires_meta
Date: Thu, 21 Dec 2023 21:04:46 +0100
Message-Id: <8086623407095ac1c82377a2107dcc5845f99cfa.1703188911.git.andreyknvl@google.com>
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

Currently, for Generic KASAN mode, kasan_requires_meta is defined to
return kasan_stack_collection_enabled.

Even though the Generic mode does not support disabling stack trace
collection, kasan_requires_meta was implemented in this way to make it
easier to implement the disabling for the Generic mode in the future.

However, for the Generic mode, the per-object metadata also stores the
quarantine link. So even if disabling stack collection is implemented,
the per-object metadata will still be required.

Fix kasan_requires_meta to return true for the Generic mode and update
the related comments.

This change does not fix any observable bugs but rather just brings the
code to a cleaner state.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/kasan.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 0e209b823b2c..38af25b9c89c 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -101,21 +101,21 @@ static inline bool kasan_sample_page_alloc(unsigned int order)
 
 #ifdef CONFIG_KASAN_GENERIC
 
-/* Generic KASAN uses per-object metadata to store stack traces. */
+/*
+ * Generic KASAN uses per-object metadata to store alloc and free stack traces
+ * and the quarantine link.
+ */
 static inline bool kasan_requires_meta(void)
 {
-	/*
-	 * Technically, Generic KASAN always collects stack traces right now.
-	 * However, let's use kasan_stack_collection_enabled() in case the
-	 * kasan.stacktrace command-line argument is changed to affect
-	 * Generic KASAN.
-	 */
-	return kasan_stack_collection_enabled();
+	return true;
 }
 
 #else /* CONFIG_KASAN_GENERIC */
 
-/* Tag-based KASAN modes do not use per-object metadata. */
+/*
+ * Tag-based KASAN modes do not use per-object metadata: they use the stack
+ * ring to store alloc and free stack traces and do not use qurantine.
+ */
 static inline bool kasan_requires_meta(void)
 {
 	return false;
-- 
2.25.1


