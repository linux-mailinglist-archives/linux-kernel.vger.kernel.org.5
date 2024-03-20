Return-Path: <linux-kernel+bounces-108348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB55880976
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 03:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02DCF1F232CE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47F9101C2;
	Wed, 20 Mar 2024 02:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yvh0fv4N"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A520F519
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 02:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710900509; cv=none; b=bSInn0I/wSxK5GyuoNtUDJ+zTm2EMMED889O/tG1zRDzhWYOCK6ME0LFbpUodR8h4dLoMobXoqQNjBqyG5PDgli1D5JvaqIBaN/P1TtXu3BPuBmeMr62f16b83GtzN4TRg/irFaER/KCr2ApamLOswgy86hOi2BfeX5gMShmj2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710900509; c=relaxed/simple;
	bh=FIzuKYDAkoINuSiIZV6ZsNqzCJaExKmuCjePFZHvsVA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bOjehchW10WAz9YPQDF6DXfNOJgjR7mis33aAOIlIgtKn1UfrksMRBts3J7dLS/i1j5v9zUt6sK0JSwfI6ctl0cLWbO7R8ObvLdKUENIeHsnMo9Qi9vF8/4LR9UID4efyjcZBoqdT+aL8zGdYnqZ0HZd8OmVP48UsNzU9u/ClRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yvh0fv4N; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60f9d800a29so76023287b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 19:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710900505; x=1711505305; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yYVHze7eFk58oRqMFdcZXvqqb2SqrJB7jmdU82oAHB0=;
        b=Yvh0fv4NLxpxGJ2REGUxH9m52EIPIO8KubKCeRsqV1X7nE+UwlKYNKJpbJPBmgWlV0
         DxfhEB9TNFtrHkrEgiHqIQziLyASNTizxyUEy1Fafx7hwmwzlKfLEY1yV9xUUIessvGt
         3Ns2SHTve4Fti3k17jLBuu/bm6Vpx1xU+GOvqvlhRCs+dqOoDc21KdKjcOsA8xWYIwBZ
         kTzGOlofUUHKt9Vcnz8BFjFF0WhpbJsT2ufiqjs2bAkJ4MsaGZw8aKiIrHi1aHI1BiHi
         IHD5LiXXYUwLyNGPjKF0J9ta0T6tNbXKW4GzVY6idJERjInCQW3Uhxdv4nnW4fpEBKn0
         aLJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710900505; x=1711505305;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yYVHze7eFk58oRqMFdcZXvqqb2SqrJB7jmdU82oAHB0=;
        b=pLZVug/UJcmSFdV48qafGheVdkQlUO9TrgzPi7tG6aGKYvDcuX/eG3wBtPat837Grz
         IDGghsb43znBuY2bodYwur5WnoeUm2f+v4avk5eHae2/XzS6dkZNjOJXOUDeU6GFKs+j
         Bfnml6+00Oc2JKHi4m0lYM69yANRs5lgN2fSnusuNrG56ArqThdPsZx9g4Etfyi0Ty8X
         DRWE8jZAQ3unQtTXZWAD48kMF7DIPKUjy7EsNFq2ZoLSdoVsJj7wIJfkZthChvJzfpvR
         zxdm+EaVxE7TrReH67+FVWlm9HK4B7QK3IA7Awo5S/Cxkp5qzWztwrN+rQD7pxPXnipV
         x02g==
X-Forwarded-Encrypted: i=1; AJvYcCWEdfKyJjEqigUiNUFtF9AXDwbmeDb5e5sLoCFqmOHt8AUTtuEzkaBV6ffkGSV71nrVDzvbpcnDsFfPXv/BEtoa7GpMxL2yQey9MIBj
X-Gm-Message-State: AOJu0YzVP51HoK399wLBQs+Rhzs3rD6M+yZAsGseqlYxEZri6/YWqSMo
	JA3bS0xMUUN/GbE0on/EePaacNFP9XamTt6uiL+WVo6VC9ijuy3W41qteCBR4jcGtuhKgz5mtkO
	Ks/KQvejmeS011DuqRg==
X-Google-Smtp-Source: AGHT+IHmnbH7OIFT3vXCgDBMNN/LSpOqXUQlqADVGRo/DP6oT7pIALKkMG8DtSLjyTbflgHEateyR8upPPsuWMd6
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:70e:b0:dcc:6bf0:2eb6 with SMTP
 id k14-20020a056902070e00b00dcc6bf02eb6mr966645ybt.6.1710900505416; Tue, 19
 Mar 2024 19:08:25 -0700 (PDT)
Date: Wed, 20 Mar 2024 02:08:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240320020823.337644-1-yosryahmed@google.com>
Subject: [PATCH 1/2] mm: zswap: increase shrinking protection for zswap
 swapins only
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, the number of protected zswap entries corresponding to an
lruvec are incremented every time we swapin a page. This happens
regardless of whether or not the page originated in zswap. Hence,
swapins from disk will lead to increasing protection on potentially
stale zswap entries. Furthermore, the increased shrinking protection can
lead to more pages skipping zswap and going to disk, eventually leading
to even more swapins from disk and starting a vicious circle.

Instead, only increase the protection when pages are loaded from zswap.
This also has a nice side effect of removing zswap_folio_swapin() and
replacing it with a static helper that is only called from zswap_load().

No problems were observed in practice, this was found through code
inspection.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 include/linux/zswap.h |  2 --
 mm/swap_state.c       |  8 ++------
 mm/zswap.c            | 10 +++-------
 3 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index 2a85b941db975..1f020b5427e3d 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -34,7 +34,6 @@ int zswap_swapon(int type, unsigned long nr_pages);
 void zswap_swapoff(int type);
 void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg);
 void zswap_lruvec_state_init(struct lruvec *lruvec);
-void zswap_folio_swapin(struct folio *folio);
 bool is_zswap_enabled(void);
 #else
 
@@ -58,7 +57,6 @@ static inline int zswap_swapon(int type, unsigned long nr_pages)
 static inline void zswap_swapoff(int type) {}
 static inline void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg) {}
 static inline void zswap_lruvec_state_init(struct lruvec *lruvec) {}
-static inline void zswap_folio_swapin(struct folio *folio) {}
 
 static inline bool is_zswap_enabled(void)
 {
diff --git a/mm/swap_state.c b/mm/swap_state.c
index bfc7e8c58a6d3..32e151054ec47 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -696,10 +696,8 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	/* The page was likely read above, so no need for plugging here */
 	folio = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
 					&page_allocated, false);
-	if (unlikely(page_allocated)) {
-		zswap_folio_swapin(folio);
+	if (unlikely(page_allocated))
 		swap_read_folio(folio, false, NULL);
-	}
 	return folio;
 }
 
@@ -872,10 +870,8 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 	/* The folio was likely read above, so no need for plugging here */
 	folio = __read_swap_cache_async(targ_entry, gfp_mask, mpol, targ_ilx,
 					&page_allocated, false);
-	if (unlikely(page_allocated)) {
-		zswap_folio_swapin(folio);
+	if (unlikely(page_allocated))
 		swap_read_folio(folio, false, NULL);
-	}
 	return folio;
 }
 
diff --git a/mm/zswap.c b/mm/zswap.c
index b31c977f53e9c..323f1dea43d22 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -773,14 +773,9 @@ void zswap_lruvec_state_init(struct lruvec *lruvec)
 	atomic_long_set(&lruvec->zswap_lruvec_state.nr_zswap_protected, 0);
 }
 
-void zswap_folio_swapin(struct folio *folio)
+static void zswap_lruvec_inc_protected(struct lruvec *lruvec)
 {
-	struct lruvec *lruvec;
-
-	if (folio) {
-		lruvec = folio_lruvec(folio);
-		atomic_long_inc(&lruvec->zswap_lruvec_state.nr_zswap_protected);
-	}
+	atomic_long_inc(&lruvec->zswap_lruvec_state.nr_zswap_protected);
 }
 
 void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)
@@ -1644,6 +1639,7 @@ bool zswap_load(struct folio *folio)
 	zswap_entry_free(entry);
 
 	folio_mark_dirty(folio);
+	zswap_lruvec_inc_protected(folio_lruvec(folio));
 
 	return true;
 }
-- 
2.44.0.291.gc1ea87d7ee-goog


