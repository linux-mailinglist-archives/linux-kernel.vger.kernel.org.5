Return-Path: <linux-kernel+bounces-8936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5E881BE53
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0FE81C21BFC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7756518A;
	Thu, 21 Dec 2023 18:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WarMWAg0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97F76280C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 18:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703183747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9xuoTXuQnTI+pN/bKZ3i8KybAohyAUoP+IGmtMicRak=;
	b=WarMWAg0K7SHak78ygWtlpgqTMwt7mumTYTiIrRXvERxbmLV9b2mB09CJkEoY/kvKqecGT
	LJD1Iz9YrXuxQjpfGtqzVdMCmE1Di3rxLYHjeVLXbJ+cka5BV4sF8NvnLlPNSEtQ8xSxsE
	gYC+xeKuS4JVZvylLWKrrqmi4VV2GMA=
From: andrey.konovalov@linux.dev
To: Andrew Morton <akpm@linux-foundation.org>,
	Juntong Deng <juntong.deng@outlook.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm 2/4] kasan: reuse kasan_track in kasan_stack_ring_entry
Date: Thu, 21 Dec 2023 19:35:38 +0100
Message-Id: <20231221183540.168428-2-andrey.konovalov@linux.dev>
In-Reply-To: <20231221183540.168428-1-andrey.konovalov@linux.dev>
References: <20231221183540.168428-1-andrey.konovalov@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Andrey Konovalov <andreyknvl@google.com>

Avoid duplicating fields of kasan_track in kasan_stack_ring_entry:
reuse the structure.

Fixes: 5d4c6ac94694 ("kasan: record and report more information")
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/kasan.h       |  7 +------
 mm/kasan/report_tags.c | 12 ++++++------
 mm/kasan/tags.c        | 12 ++++++------
 3 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 5e298e3ac909..9072ce4c1263 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -279,13 +279,8 @@ struct kasan_free_meta {
 struct kasan_stack_ring_entry {
 	void *ptr;
 	size_t size;
-	u32 pid;
-	depot_stack_handle_t stack;
+	struct kasan_track track;
 	bool is_free;
-#ifdef CONFIG_KASAN_EXTRA_INFO
-	u64 cpu:20;
-	u64 timestamp:44;
-#endif /* CONFIG_KASAN_EXTRA_INFO */
 };
 
 struct kasan_stack_ring {
diff --git a/mm/kasan/report_tags.c b/mm/kasan/report_tags.c
index 979f284c2497..688b9d70b04a 100644
--- a/mm/kasan/report_tags.c
+++ b/mm/kasan/report_tags.c
@@ -31,8 +31,8 @@ static const char *get_common_bug_type(struct kasan_report_info *info)
 static void kasan_complete_extra_report_info(struct kasan_track *track,
 					 struct kasan_stack_ring_entry *entry)
 {
-	track->cpu = entry->cpu;
-	track->timestamp = entry->timestamp;
+	track->cpu = entry->track.cpu;
+	track->timestamp = entry->track.timestamp;
 }
 #endif /* CONFIG_KASAN_EXTRA_INFO */
 
@@ -80,8 +80,8 @@ void kasan_complete_mode_report_info(struct kasan_report_info *info)
 			if (free_found)
 				break;
 
-			info->free_track.pid = entry->pid;
-			info->free_track.stack = entry->stack;
+			info->free_track.pid = entry->track.pid;
+			info->free_track.stack = entry->track.stack;
 #ifdef CONFIG_KASAN_EXTRA_INFO
 			kasan_complete_extra_report_info(&info->free_track, entry);
 #endif /* CONFIG_KASAN_EXTRA_INFO */
@@ -98,8 +98,8 @@ void kasan_complete_mode_report_info(struct kasan_report_info *info)
 			if (alloc_found)
 				break;
 
-			info->alloc_track.pid = entry->pid;
-			info->alloc_track.stack = entry->stack;
+			info->alloc_track.pid = entry->track.pid;
+			info->alloc_track.stack = entry->track.stack;
 #ifdef CONFIG_KASAN_EXTRA_INFO
 			kasan_complete_extra_report_info(&info->alloc_track, entry);
 #endif /* CONFIG_KASAN_EXTRA_INFO */
diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
index c13b198b8302..c4d14dbf27c0 100644
--- a/mm/kasan/tags.c
+++ b/mm/kasan/tags.c
@@ -100,8 +100,8 @@ static void save_extra_info(struct kasan_stack_ring_entry *entry)
 	u32 cpu = raw_smp_processor_id();
 	u64 ts_nsec = local_clock();
 
-	entry->cpu = cpu;
-	entry->timestamp = ts_nsec >> 3;
+	entry->track.cpu = cpu;
+	entry->track.timestamp = ts_nsec >> 3;
 }
 #endif /* CONFIG_KASAN_EXTRA_INFO */
 
@@ -134,15 +134,15 @@ static void save_stack_info(struct kmem_cache *cache, void *object,
 	if (!try_cmpxchg(&entry->ptr, &old_ptr, STACK_RING_BUSY_PTR))
 		goto next; /* Busy slot. */
 
-	old_stack = entry->stack;
+	old_stack = entry->track.stack;
 
 	entry->size = cache->object_size;
-	entry->pid = current->pid;
-	entry->stack = stack;
-	entry->is_free = is_free;
+	entry->track.pid = current->pid;
+	entry->track.stack = stack;
 #ifdef CONFIG_KASAN_EXTRA_INFO
 	save_extra_info(entry);
 #endif /* CONFIG_KASAN_EXTRA_INFO */
+	entry->is_free = is_free;
 
 	entry->ptr = object;
 
-- 
2.25.1


