Return-Path: <linux-kernel+bounces-111790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7078887105
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33BF7B22725
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1374B5D468;
	Fri, 22 Mar 2024 16:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QtD5iCkR"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A36F5674C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 16:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711125612; cv=none; b=ldHU+JCMYqEy+L57FYzEf7mm0RMt/fb0Xriii6WclrjxRcq1nsppEQI7aMgTnpM7nuz9TIBYWFSNFdJsZHHgnoKBxMkEM0r0/VVfkcowtiTvsMAJkVphzHELaSzynTROv0r9xSgXzWgMXhoHbIgNg33kxz3CyAyhkg0SbdU95l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711125612; c=relaxed/simple;
	bh=be5YocDWCbRGR4uAZlmMAzBgoMxaC0MoO2MNArRgWlk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AaL4YstlnFDpcHnmME8PCk3LT9YyrdOaSGXCFd/y5g5osU7p9jP70Fbcowj/n/nhz7j3UFPAa4/7cenSfrW1jRMXwfaGDLM8WOrIBj8TADdS5bbl1qO4/EIEcknunu4RrWwPSkXkYB8GNXUfjnnCYQdvnOB08lgpX5QFPaBXqHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QtD5iCkR; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711125608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=alKuNVPMUZUInvf3FonZiSKCsCjs3x5ZGIB2V/RJ1Bc=;
	b=QtD5iCkRCOfhonm2ViUGyN7iojeqGcmSW/yx+PEgNH3oECNvazjIbddo34MdYyNpjZy5zn
	fczjHWvReG1rzqrjx+YygIGC3C+mhwCueqod20QSEa+FBl2L+wCkWsSPtoHSv9PTmjXYfn
	zkOFNv+gtBAR+CY9T1yxCLa8bVZ3ID4=
From: chengming.zhou@linux.dev
To: hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: [RFC PATCH] mm: add folio in swapcache if swapin from zswap
Date: Sat, 23 Mar 2024 00:39:39 +0800
Message-Id: <20240322163939.17846-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chengming Zhou <chengming.zhou@linux.dev>

There is a report of data corruption caused by double swapin, which is
only possible in the skip swapcache path on SWP_SYNCHRONOUS_IO backends.

The root cause is that zswap is not like other "normal" swap backends,
it won't keep the copy of data after the first time of swapin. So if
the folio in the first time of swapin can't be installed in the pagetable
successfully and we just free it directly. Then in the second time of
swapin, we can't find anything in zswap and read wrong data from swapfile,
so this data corruption problem happened.

We can fix it by always adding the folio into swapcache if we know the
pinned swap entry can be found in zswap, so it won't get freed even though
it can't be installed successfully in the first time of swapin.

And we have to check if the swap entry is in zswap after entry pinned,
only then we can make sure the check result is stable.

Reported-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
Closes: https://lore.kernel.org/all/CACSyD1N+dUvsu8=zV9P691B9bVq33erwOXNTmEaUbi9DrDeJzw@mail.gmail.com
Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 include/linux/zswap.h |  6 ++++++
 mm/memory.c           | 28 ++++++++++++++++++++++++----
 mm/zswap.c            | 10 ++++++++++
 3 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index 2a85b941db97..180d0b1f0886 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -36,6 +36,7 @@ void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg);
 void zswap_lruvec_state_init(struct lruvec *lruvec);
 void zswap_folio_swapin(struct folio *folio);
 bool is_zswap_enabled(void);
+bool zswap_find(swp_entry_t swp);
 #else
 
 struct zswap_lruvec_state {};
@@ -65,6 +66,11 @@ static inline bool is_zswap_enabled(void)
 	return false;
 }
 
+static inline bool zswap_find(swp_entry_t swp)
+{
+	return false;
+}
+
 #endif
 
 #endif /* _LINUX_ZSWAP_H */
diff --git a/mm/memory.c b/mm/memory.c
index 4f2caf1c3c4d..a564b2b8faca 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4031,18 +4031,38 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 					ret = VM_FAULT_OOM;
 					goto out_page;
 				}
+
+				/*
+				 * We have to add the folio into swapcache if
+				 * this pinned swap entry is found in zswap,
+				 * which won't keep copy of data after swapin.
+				 * Or data will just get lost if later folio
+				 * can't be installed successfully in pagetable.
+				 */
+				if (zswap_find(entry)) {
+					if (add_to_swap_cache(folio, entry,
+							GFP_KERNEL, &shadow)) {
+						ret = VM_FAULT_OOM;
+						goto out_page;
+					}
+					swapcache = folio;
+					need_clear_cache = false;
+				} else {
+					shadow = get_shadow_from_swap_cache(entry);
+					/* To provide entry to swap_read_folio() */
+					folio->swap = entry;
+				}
+
 				mem_cgroup_swapin_uncharge_swap(entry);
 
-				shadow = get_shadow_from_swap_cache(entry);
 				if (shadow)
 					workingset_refault(folio, shadow);
 
 				folio_add_lru(folio);
 
-				/* To provide entry to swap_read_folio() */
-				folio->swap = entry;
 				swap_read_folio(folio, true, NULL);
-				folio->private = NULL;
+				if (need_clear_cache)
+					folio->private = NULL;
 			}
 		} else {
 			page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
diff --git a/mm/zswap.c b/mm/zswap.c
index c4979c76d58e..84a904a788a3 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1601,6 +1601,16 @@ void zswap_invalidate(swp_entry_t swp)
 		zswap_entry_free(entry);
 }
 
+bool zswap_find(swp_entry_t swp)
+{
+	pgoff_t offset = swp_offset(swp);
+	struct xarray *tree = swap_zswap_tree(swp);
+	struct zswap_entry *entry;
+
+	entry = xa_find(tree, &offset, offset, XA_PRESENT);
+	return entry != NULL;
+}
+
 int zswap_swapon(int type, unsigned long nr_pages)
 {
 	struct xarray *trees, *tree;
-- 
2.20.1


