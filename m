Return-Path: <linux-kernel+bounces-110814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34787886440
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 01:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5809C1C21EA1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 00:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B98389;
	Fri, 22 Mar 2024 00:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W1aTD4vd"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F6D637
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 00:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711066206; cv=none; b=AFMYwP/NGmynP3gSj+C+8WJ3kid0JJIzG5myO+Ny/8yQoONh6169phzX3fPxfZ8JaRHAJMar/VCYnQsJ8ski4Uy9ZG3xgHu+Pemxfb9GkytFupZTW+WkJDdDqWd/DAZx+8idmkrGIyMuYZY19XH6NEFfVLSE2319jPrAuxWzVxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711066206; c=relaxed/simple;
	bh=mFzJzegFZnX78rHE7ZuYJsO+80ntfZmAuv2DBMbi5hY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=F8M7FHM+t+QICUooY88ryo2B0pb6iehTP5Cx4lt4Ks0hgigbNGLJo14/K8As5wA+ZTqHjT4CjSmHZpk99brNVf/FCNl8C7hz+CvKL9Ty7PIGUcPcbSu619vG7sUTpAeqyytfShrCqTZ7zTKTNPGBAy+7wRYp+X0RAIhDW1ke71Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W1aTD4vd; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a0b18e52dso19352117b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 17:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711066203; x=1711671003; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w5K+vZiiCmgzoDXluPHngobfmz20rWM1f5eE3ArbH1M=;
        b=W1aTD4vd2vDgO++lUzQ+W9IaT5QDe3ODkrE3zpnXDAIINZCfpl8LLaGEN446Zmc0oy
         H1xKawQYBqtWownwJkwP6GH5kcBnqfq/dbnelw6dG1nT1cOlDTfb7AP7McDJU4ZQ6nXj
         WAIxtaL0GfCuRntm7MSrbzv8GMJ1zH/B+dkfecAiioJhdrpZZtxjFp9ZGsW82rSw8h6R
         EqduskmlY30Kd0H2k8NrXDa6Bam8n1KUvdweEbVk3Enx4S1rjAzrxSkV0IW+4o3Ss6/X
         EW1u+XFU72PZVXgJDHxmMAjdGcUt6OhRWDN6w2f2/9A+w9VQ2ZiWWes04WasGlI6Bm+8
         tRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711066203; x=1711671003;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w5K+vZiiCmgzoDXluPHngobfmz20rWM1f5eE3ArbH1M=;
        b=LAZqZsk3OZVCI7HmePROxZVd9e7GaYVa2NQ4H7FF5Hr1L2ZbxHG/VsAoYHmRLks1BE
         V7t/WMsM2aSW2RImTPjlcAtDERzurvGUVuWYnGlOSAiSQleAruN/lxtEHivv+Uc0/HRU
         GEtkA2JQFBIW9UhpspexWyl7y59XiCQo5OKX1Q/rrQFausgm+JuWQ6iSXVb9DG1ejD2v
         W/6LSa6lrxtaTNjmHsoY95wX7ddA23Zgao/DPId11KrvdTabkWHlydP6y8lY3l27sPeN
         /9S58jlh8wGCROo8QP9Wmi+m0J3S9F64Dm/4D9nMfprf3RPYBQRaimXLu5JexAeGn+B+
         vozQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOo4fw/T34p6kr1wAt/zXo3fpY2S61xvnJ82HuV9F6qrU9YBErkxWOa+2A8hRalio0wtJG6JOzBPHkAv0GHqHcT5gtGFPcOGGwt1D1
X-Gm-Message-State: AOJu0Yylec0+HM5RC5hcOfvt1JQaiXElogaSS+bKJ+P6eH74mayq9z0n
	Mias1YZkW54kAWgE8tImzNaapbHQRr65ccpHhKrWjOJzl7Hb1F4mUPY6QkqxQJ5ZR4Mqssx0MeY
	zHz2B2F7RmFZbslkRaw==
X-Google-Smtp-Source: AGHT+IEyYfewi4gqRaFyQty4UL6G5sLBNRtvajjK0MhkKkIGFmsL8zb8iknEx5/grRR7qegyoT1CCr8zQBwOxswF
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a81:498c:0:b0:60a:13b8:6a5c with SMTP
 id w134-20020a81498c000000b0060a13b86a5cmr166506ywa.0.1711066203594; Thu, 21
 Mar 2024 17:10:03 -0700 (PDT)
Date: Fri, 22 Mar 2024 00:10:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240322001001.1562517-1-yosryahmed@google.com>
Subject: [PATCH v2] mm: zswap: remove nr_zswap_stored atomic
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

nr_stored was introduced by commit b5ba474f3f51 ("zswap: shrink zswap
pool based on memory pressure") as a per zswap_pool counter of the
number of stored pages that are not same-filled pages. It is used in
zswap_shrinker_count() to scale the number of freeable compressed pages
by the compression ratio.  That is, to reduce the amount of writeback
from zswap with higher compression ratios as the ROI from IO diminishes.

Later on, commit bf9b7df23cb3 ("mm/zswap: global lru and shrinker shared
by all zswap_pools") made the shrinker global (not per zswap_pool), and
replaced nr_stored with nr_zswap_stored (initially introduced as
zswap.nr_stored), which is now a global counter.

The counter is now awfully close to zswap_stored_pages. The only
difference is that the latter also includes same-filled pages. Also,
when memcgs are enabled, we use memcg_page_state(memcg, MEMCG_ZSWAPPED),
which includes same-filled pages anyway (i.e.  equivalent to
zswap_stored_pages).

Use zswap_stored_pages instead in zswap_shrinker_count() to keep things
consistent whether memcgs are enabled or not, and add a comment about
the number of freeable pages possibly being scaled down more than it
should if we have lots of same-filled pages (i.e. inflated compression
ratio).

Remove nr_zswap_stored and one atomic operation in the store and free
paths.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/zswap.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index b31c977f53e9c..1a79f99606cef 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -181,8 +181,6 @@ struct zswap_pool {
 
 /* Global LRU lists shared by all zswap pools. */
 static struct list_lru zswap_list_lru;
-/* counter of pages stored in all zswap pools. */
-static atomic_t zswap_nr_stored = ATOMIC_INIT(0);
 
 /* The lock protects zswap_next_shrink updates. */
 static DEFINE_SPINLOCK(zswap_shrink_lock);
@@ -885,7 +883,6 @@ static void zswap_entry_free(struct zswap_entry *entry)
 	else {
 		zswap_lru_del(&zswap_list_lru, entry);
 		zpool_free(zswap_find_zpool(entry), entry->handle);
-		atomic_dec(&zswap_nr_stored);
 		zswap_pool_put(entry->pool);
 	}
 	if (entry->objcg) {
@@ -1310,7 +1307,7 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
 #else
 	/* use pool stats instead of memcg stats */
 	nr_backing = zswap_total_pages();
-	nr_stored = atomic_read(&zswap_nr_stored);
+	nr_stored = atomic_read(&zswap_stored_pages);
 #endif
 
 	if (!nr_stored)
@@ -1330,6 +1327,11 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
 	 * This ensures that the better zswap compresses memory, the fewer
 	 * pages we will evict to swap (as it will otherwise incur IO for
 	 * relatively small memory saving).
+	 *
+	 * The memory saving factor calculated here takes same-filled pages into
+	 * account, but those are not freeable since they almost occupy no
+	 * space. Hence, we may scale nr_freeable down a little bit more than we
+	 * should if we have a lot of same-filled pages.
 	 */
 	return mult_frac(nr_freeable, nr_backing, nr_stored);
 }
@@ -1575,7 +1577,6 @@ bool zswap_store(struct folio *folio)
 	if (entry->length) {
 		INIT_LIST_HEAD(&entry->lru);
 		zswap_lru_add(&zswap_list_lru, entry);
-		atomic_inc(&zswap_nr_stored);
 	}
 	spin_unlock(&tree->lock);
 
-- 
2.44.0.396.g6e790dbe36-goog


