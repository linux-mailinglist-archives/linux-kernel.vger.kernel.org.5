Return-Path: <linux-kernel+bounces-73393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3441285C1E7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B76BF1F22026
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3D276C6C;
	Tue, 20 Feb 2024 16:58:49 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5358076907
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 16:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708448329; cv=none; b=M0hTwUImmOUAAZ0aLwv1YBq7jJY9pWzLX7Gm62oBmJdz7CLmSOIFizo9/Xu92joRWXORXUj5OFBY6vGmTI5SKC7/95Nx1Au/ttnENBuOu4B9lAGZFtX6rZ46Zpj1KWg0DPURiJC0V00HBuNw4yEdDwIFL5elzYz6XgnLiy5UFbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708448329; c=relaxed/simple;
	bh=8dSL5GfjNj31WZBzU1RArK2AdDIYjJIAED64yK7aPeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r7OsfIc3nOYVJybjtR46mboT3r4FWCSDZKuOw68iSqxXEix4zSS4wKBqyYxK1Mx+bDB5vhIn1BPQ+EcNDM+MX2APfgVDCJwJbmFqzX/0yovXJ65llPA28ey6Idl73HUBDRE5cdK59s5MCWyEHgghqtNE/pGe5QrDJ94vmq6OtE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7BAC91F8AC;
	Tue, 20 Feb 2024 16:58:45 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 578FD139D0;
	Tue, 20 Feb 2024 16:58:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CEsVFUXa1GVKXQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 20 Feb 2024 16:58:45 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Tue, 20 Feb 2024 17:58:27 +0100
Subject: [PATCH 3/3] mm, slab, kasan: replace kasan_never_merge() with
 SLAB_NO_MERGE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-slab-cleanup-flags-v1-3-e657e373944a@suse.cz>
References: <20240220-slab-cleanup-flags-v1-0-e657e373944a@suse.cz>
In-Reply-To: <20240220-slab-cleanup-flags-v1-0-e657e373944a@suse.cz>
To: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
 Alexander Potapenko <glider@google.com>, 
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Zheng Yejian <zhengyejian1@huawei.com>, 
 Xiongwei Song <xiongwei.song@windriver.com>, 
 Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
 Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3299; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=8dSL5GfjNj31WZBzU1RArK2AdDIYjJIAED64yK7aPeY=;
 b=owEBbQGS/pANAwAIAbvgsHXSRYiaAcsmYgBl1NpC+Ron5uAKKATthXFJII/xHLgqduJBWbRQt
 JULEgGEAwCJATMEAAEIAB0WIQR7u8hBFZkjSJZITfG74LB10kWImgUCZdTaQgAKCRC74LB10kWI
 mt6zB/9ix1+cbRLwfxeQ4PhmyOPOXIy8AuaLRA62hsETFxjPOeumiQBXsvdbnzwsuTrbTPtKCkZ
 d9K8yRw2rpCG80loeAT/9uGKYzkw3j1XJrIDpXnpsp8/Jtb8zF38E0za2jDekAKVKziUs+xQQ1c
 VGAgxP7oyKW/Scrkzja41qVLuoQIjHK0k+XLXLFgkgs+iCPInGvRs4Nw50YuoG4okbZHICuchYX
 EJ07EGSqae4vCKCv3jipCwptC1gLJZ1gNSnfYu6Xla4IZmsWsXnVgCegTbcY8e9LdmySCBYecUL
 5FttxJXT+6E5QTHUN3Tw59fKT1yFq1PkGQFvhgv0TDslB5er
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 TAGGED_RCPT(0.00)[];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 7BAC91F8AC
X-Spam-Flag: NO

The SLAB_KASAN flag prevents merging of caches in some configurations,
which is handled in a rather complicated way via kasan_never_merge().
Since we now have a generic SLAB_NO_MERGE flag, we can instead use it
for KASAN caches in addition to SLAB_KASAN in those configurations,
and simplify the SLAB_NEVER_MERGE handling.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/kasan.h |  6 ------
 mm/kasan/generic.c    | 16 ++++------------
 mm/slab_common.c      |  2 +-
 3 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index dbb06d789e74..70d6a8f6e25d 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -429,7 +429,6 @@ struct kasan_cache {
 };
 
 size_t kasan_metadata_size(struct kmem_cache *cache, bool in_object);
-slab_flags_t kasan_never_merge(void);
 void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 			slab_flags_t *flags);
 
@@ -446,11 +445,6 @@ static inline size_t kasan_metadata_size(struct kmem_cache *cache,
 {
 	return 0;
 }
-/* And thus nothing prevents cache merging. */
-static inline slab_flags_t kasan_never_merge(void)
-{
-	return 0;
-}
 /* And no cache-related metadata initialization is required. */
 static inline void kasan_cache_create(struct kmem_cache *cache,
 				      unsigned int *size,
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index df6627f62402..d8b78d273b9f 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -334,14 +334,6 @@ DEFINE_ASAN_SET_SHADOW(f3);
 DEFINE_ASAN_SET_SHADOW(f5);
 DEFINE_ASAN_SET_SHADOW(f8);
 
-/* Only allow cache merging when no per-object metadata is present. */
-slab_flags_t kasan_never_merge(void)
-{
-	if (!kasan_requires_meta())
-		return 0;
-	return SLAB_KASAN;
-}
-
 /*
  * Adaptive redzone policy taken from the userspace AddressSanitizer runtime.
  * For larger allocations larger redzones are used.
@@ -372,13 +364,13 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 	/*
 	 * SLAB_KASAN is used to mark caches that are sanitized by KASAN
 	 * and that thus have per-object metadata.
-	 * Currently this flag is used in two places:
+	 * Currently this flag is used in one place:
 	 * 1. In slab_ksize() to account for per-object metadata when
 	 *    calculating the size of the accessible memory within the object.
-	 * 2. In slab_common.c via kasan_never_merge() to prevent merging of
-	 *    caches with per-object metadata.
+	 * Additionally, we use SLAB_NO_MERGE to prevent merging of caches
+	 * with per-object metadata.
 	 */
-	*flags |= SLAB_KASAN;
+	*flags |= SLAB_KASAN | SLAB_NO_MERGE;
 
 	ok_size = *size;
 
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 238293b1dbe1..7cfa2f1ce655 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -50,7 +50,7 @@ static DECLARE_WORK(slab_caches_to_rcu_destroy_work,
  */
 #define SLAB_NEVER_MERGE (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER | \
 		SLAB_TRACE | SLAB_TYPESAFE_BY_RCU | SLAB_NOLEAKTRACE | \
-		SLAB_FAILSLAB | SLAB_NO_MERGE | kasan_never_merge())
+		SLAB_FAILSLAB | SLAB_NO_MERGE)
 
 #define SLAB_MERGE_SAME (SLAB_RECLAIM_ACCOUNT | SLAB_CACHE_DMA | \
 			 SLAB_CACHE_DMA32 | SLAB_ACCOUNT)

-- 
2.43.1


