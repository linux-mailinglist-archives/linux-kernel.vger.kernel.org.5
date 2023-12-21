Return-Path: <linux-kernel+bounces-9026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE8481BF64
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29BC7288EA0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E72760A9;
	Thu, 21 Dec 2023 20:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="USMsmCfc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD73745D7
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 20:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703189165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ColijDwhDovJxdnzDPHxNzx5OycMVFqUSNs1GHs5mVk=;
	b=USMsmCfcfZYE03AC87Gmpyp9gmlr/kMJv0pWBUPw9nx0sHm6vrJx9MiJnMGDlRy1Np+vvg
	xVnk34bog6bJEXPpd1W0ZhX/6rrSohpzazwxYlJ0CsIiIqPW+tM023kd9Pj1/tI00TxpVr
	7puIg/6gNeTx8rsKTuL0nS4IqNynK+s=
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
Subject: [PATCH mm 08/11] kasan: check kasan_vmalloc_enabled in vmalloc tests
Date: Thu, 21 Dec 2023 21:04:50 +0100
Message-Id: <954456e50ac98519910c3e24a479a18eae62f8dd.1703188911.git.andreyknvl@google.com>
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

Check that vmalloc poisoning is not disabled via command line when
running the vmalloc-related KASAN tests. Skip the tests otherwise.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/hw_tags.c    |  1 +
 mm/kasan/kasan.h      |  5 +++++
 mm/kasan/kasan_test.c | 11 ++++++++++-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 80f11a3eccd5..2b994092a2d4 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -62,6 +62,7 @@ DEFINE_STATIC_KEY_TRUE(kasan_flag_vmalloc);
 #else
 DEFINE_STATIC_KEY_FALSE(kasan_flag_vmalloc);
 #endif
+EXPORT_SYMBOL_GPL(kasan_flag_vmalloc);
 
 #define PAGE_ALLOC_SAMPLE_DEFAULT	1
 #define PAGE_ALLOC_SAMPLE_ORDER_DEFAULT	3
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index dee105ba32dd..acc1a9410f0d 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -83,6 +83,11 @@ static inline bool kasan_sample_page_alloc(unsigned int order)
 
 #else /* CONFIG_KASAN_HW_TAGS */
 
+static inline bool kasan_vmalloc_enabled(void)
+{
+	return IS_ENABLED(CONFIG_KASAN_VMALLOC);
+}
+
 static inline bool kasan_async_fault_possible(void)
 {
 	return false;
diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
index 1c77c73ff287..496154e38965 100644
--- a/mm/kasan/kasan_test.c
+++ b/mm/kasan/kasan_test.c
@@ -1540,6 +1540,9 @@ static void vmalloc_helpers_tags(struct kunit *test)
 
 	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_VMALLOC);
 
+	if (!kasan_vmalloc_enabled())
+		kunit_skip(test, "Test requires kasan.vmalloc=on");
+
 	ptr = vmalloc(PAGE_SIZE);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
@@ -1574,6 +1577,9 @@ static void vmalloc_oob(struct kunit *test)
 
 	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_VMALLOC);
 
+	if (!kasan_vmalloc_enabled())
+		kunit_skip(test, "Test requires kasan.vmalloc=on");
+
 	v_ptr = vmalloc(size);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, v_ptr);
 
@@ -1627,6 +1633,9 @@ static void vmap_tags(struct kunit *test)
 
 	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_VMALLOC);
 
+	if (!kasan_vmalloc_enabled())
+		kunit_skip(test, "Test requires kasan.vmalloc=on");
+
 	p_page = alloc_pages(GFP_KERNEL, 1);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p_page);
 	p_ptr = page_address(p_page);
@@ -1745,7 +1754,7 @@ static void match_all_not_assigned(struct kunit *test)
 		free_pages((unsigned long)ptr, order);
 	}
 
-	if (!IS_ENABLED(CONFIG_KASAN_VMALLOC))
+	if (!kasan_vmalloc_enabled())
 		return;
 
 	for (i = 0; i < 256; i++) {
-- 
2.25.1


