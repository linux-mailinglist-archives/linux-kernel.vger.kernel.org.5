Return-Path: <linux-kernel+bounces-9021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B31481BF58
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEC521F24FC9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1D774E15;
	Thu, 21 Dec 2023 20:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Gsy7nZlb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6A17319B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 20:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703189100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KWohJbv99PLbGcicyqYuN0s/R1C+lxZK4GlvmO4roNU=;
	b=Gsy7nZlbu3H2IDnesAWQe9qDJ7nAP2p+eXRNRSe4j32CC4JwsP4uLzkQ4/jEEkvX8mdv6F
	CcL25sh8fWcrq+2FBZ5UvJ9asZqD0ZHeEOOP3+qLu1cMEpc6sPWjqhJ9qWg89a+PRbHrc2
	K5hSrC+2HrBEnLQVSDx5tp5XvH3drbU=
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
Subject: [PATCH mm 03/11] kasan: improve kasan_non_canonical_hook
Date: Thu, 21 Dec 2023 21:04:45 +0100
Message-Id: <af94ef3cb26f8c065048b3158d9f20f6102bfaaa.1703188911.git.andreyknvl@google.com>
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

Make kasan_non_canonical_hook to be more sure in its report (i.e. say
"probably" instead of "maybe") if the address belongs to the shadow memory
region for kernel addresses.

Also use the kasan_shadow_to_mem helper to calculate the original address.

Also improve the comments in kasan_non_canonical_hook.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/kasan.h  |  6 ++++++
 mm/kasan/report.c | 34 ++++++++++++++++++++--------------
 2 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 69e4f5e58e33..0e209b823b2c 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -307,6 +307,12 @@ struct kasan_stack_ring {
 
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 
+static __always_inline bool addr_in_shadow(const void *addr)
+{
+	return addr >= (void *)KASAN_SHADOW_START &&
+		addr < (void *)KASAN_SHADOW_END;
+}
+
 #ifndef kasan_shadow_to_mem
 static inline const void *kasan_shadow_to_mem(const void *shadow_addr)
 {
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index a938237f6882..4bc7ac9fb37d 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -635,37 +635,43 @@ void kasan_report_async(void)
 
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 /*
- * With CONFIG_KASAN_INLINE, accesses to bogus pointers (outside the high
- * canonical half of the address space) cause out-of-bounds shadow memory reads
- * before the actual access. For addresses in the low canonical half of the
- * address space, as well as most non-canonical addresses, that out-of-bounds
- * shadow memory access lands in the non-canonical part of the address space.
- * Help the user figure out what the original bogus pointer was.
+ * With compiler-based KASAN modes, accesses to bogus pointers (outside of the
+ * mapped kernel address space regions) cause faults when KASAN tries to check
+ * the shadow memory before the actual memory access. This results in cryptic
+ * GPF reports, which are hard for users to interpret. This hook helps users to
+ * figure out what the original bogus pointer was.
  */
 void kasan_non_canonical_hook(unsigned long addr)
 {
 	unsigned long orig_addr;
 	const char *bug_type;
 
+	/*
+	 * All addresses that came as a result of the memory-to-shadow mapping
+	 * (even for bogus pointers) must be >= KASAN_SHADOW_OFFSET.
+	 */
 	if (addr < KASAN_SHADOW_OFFSET)
 		return;
 
-	orig_addr = (addr - KASAN_SHADOW_OFFSET) << KASAN_SHADOW_SCALE_SHIFT;
+	orig_addr = (unsigned long)kasan_shadow_to_mem((void *)addr);
+
 	/*
 	 * For faults near the shadow address for NULL, we can be fairly certain
 	 * that this is a KASAN shadow memory access.
-	 * For faults that correspond to shadow for low canonical addresses, we
-	 * can still be pretty sure - that shadow region is a fairly narrow
-	 * chunk of the non-canonical address space.
-	 * But faults that look like shadow for non-canonical addresses are a
-	 * really large chunk of the address space. In that case, we still
-	 * print the decoded address, but make it clear that this is not
-	 * necessarily what's actually going on.
+	 * For faults that correspond to the shadow for low or high canonical
+	 * addresses, we can still be pretty sure: these shadow regions are a
+	 * fairly narrow chunk of the address space.
+	 * But the shadow for non-canonical addresses is a really large chunk
+	 * of the address space. For this case, we still print the decoded
+	 * address, but make it clear that this is not necessarily what's
+	 * actually going on.
 	 */
 	if (orig_addr < PAGE_SIZE)
 		bug_type = "null-ptr-deref";
 	else if (orig_addr < TASK_SIZE)
 		bug_type = "probably user-memory-access";
+	else if (addr_in_shadow((void *)addr))
+		bug_type = "probably wild-memory-access";
 	else
 		bug_type = "maybe wild-memory-access";
 	pr_alert("KASAN: %s in range [0x%016lx-0x%016lx]\n", bug_type,
-- 
2.25.1


