Return-Path: <linux-kernel+bounces-11560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 863FD81E82F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 16:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14E6CB21F41
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 15:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C9553808;
	Tue, 26 Dec 2023 15:55:01 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A0652F67
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Tue, 26 Dec 2023 15:54:11 +0000
Subject: [PATCH v4 4/6] mm/zswap: cleanup zswap_load()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231213-zswap-dstmem-v4-4-f228b059dd89@bytedance.com>
References: <20231213-zswap-dstmem-v4-0-f228b059dd89@bytedance.com>
In-Reply-To: <20231213-zswap-dstmem-v4-0-f228b059dd89@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>, Seth Jennings <sjenning@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Vitaly Wool <vitaly.wool@konsulko.com>, Nhat Pham <nphamcs@gmail.com>, Chris Li <chriscli@google.com>,
 Yosry Ahmed <yosryahmed@google.com>, Dan Streetman <ddstreet@ieee.org>
Cc: linux-kernel@vger.kernel.org, Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org,
 Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>, Chris Li <chrisl@kernel.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703606082; l=1518;
 i=zhouchengming@bytedance.com; s=20231204; h=from:subject:message-id;
 bh=rkes+J7eJM7t0YHK81EpBcYXvy/jNev7hTPxYOeqbUg=;
 b=EMECwijc3Cop46ntV6xtp5hN60obHUUAxQdRv1B1TZNaLQmm/7W7OGjUfEwdkOlvVPeLksp90
 8QboHPBWsnnD2aRQe8a9oroWGYNCKyszGFtZFKrkZZcaWZnrG3gi0aT
X-Developer-Key: i=zhouchengming@bytedance.com; a=ed25519;
 pk=xFTmRtMG3vELGJBUiml7OYNdM393WOMv0iWWeQEVVdA=
X-Migadu-Flow: FLOW_OUT

After the common decompress part goes to __zswap_load(), we can cleanup
the zswap_load() a little.

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
Acked-by: Chis Li <chrisl@kernel.org> (Google)
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/zswap.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 3433bd6b3cef..86886276cb81 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1759,7 +1759,6 @@ bool zswap_load(struct folio *folio)
 	struct zswap_tree *tree = zswap_trees[type];
 	struct zswap_entry *entry;
 	u8 *dst;
-	bool ret;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
 
@@ -1776,19 +1775,16 @@ bool zswap_load(struct folio *folio)
 		dst = kmap_local_page(page);
 		zswap_fill_page(dst, entry->value);
 		kunmap_local(dst);
-		ret = true;
-		goto stats;
+	} else {
+		__zswap_load(entry, page);
 	}
 
-	__zswap_load(entry, page);
-	ret = true;
-stats:
 	count_vm_event(ZSWPIN);
 	if (entry->objcg)
 		count_objcg_event(entry->objcg, ZSWPIN);
 
 	spin_lock(&tree->lock);
-	if (ret && zswap_exclusive_loads_enabled) {
+	if (zswap_exclusive_loads_enabled) {
 		zswap_invalidate_entry(tree, entry);
 		folio_mark_dirty(folio);
 	} else if (entry->length) {
@@ -1798,7 +1794,7 @@ bool zswap_load(struct folio *folio)
 	zswap_entry_put(tree, entry);
 	spin_unlock(&tree->lock);
 
-	return ret;
+	return true;
 }
 
 void zswap_invalidate(int type, pgoff_t offset)

-- 
b4 0.10.1

