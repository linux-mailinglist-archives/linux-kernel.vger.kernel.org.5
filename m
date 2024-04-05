Return-Path: <linux-kernel+bounces-132309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC638992D3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 03:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05BCB285CD9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 01:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5107C14AA0;
	Fri,  5 Apr 2024 01:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YClFmMvd"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C10ADF5B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 01:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712280955; cv=none; b=iQAXhm/nw/Y4DENQgMK9kYUTqEx9s0OBQlbmtA5eL5I1VjSVvsQcbmdvgXnTJAB3kfZQPaKEB3CjlA8fwpxOk/IITduXeAbN72pRLfSvntkTXluLeMSTMTJqZatxvVbOOTH/8w8N55tBtbDbP32Tm5Dyo2T9T6aeP4uGiddOamQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712280955; c=relaxed/simple;
	bh=xdeoQALEcG6ht6H/qeEdSKcmN0OlKaOV9IG/+7tK4mk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k56CHoNXFxnhbQhvlcz7+lA1mHMKbK+FAQZ099w1ZSOQwwUjr9oSCGhPank987EN/zxYnr3dXO4GySzxSh0C2CG6+W1PM4gjHPQWTDV3kwOPhNKyQx/dm4EeWdIy5PtmQ0f5VI5m6q2HIYms/CuuIubvZuBLqkaBk4sosrrSk6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YClFmMvd; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61510f72bb3so28792927b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 18:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712280953; x=1712885753; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l7c0YAXHYAARa4t+azzKsBRh7TpDkWZPSyUcI/Ckh5E=;
        b=YClFmMvdO6u4PCZBotOsmlWxQfLO7ERhi7C4gqTowBxJi+8055omKzgG19ykkSbO5A
         qVyNh4U88HxH5Zl1jWRIge9qz6Tp1YEWm4K43yPhni2JvFBUUuYX8os7u9clq8/cWJd0
         qLk+4FYemfi5sC9JXvorozy73AGJN0hYEoCbwwzcORX5l3+rYUpOsgPKAFlOiUw8KEIv
         ecEshsxnM3yRMIQXrN4DxaI5NFSqWBLCIola2/pTUiOAAeSD0UshPjMttq0oMs2I/YCU
         7RMlEk1SlS4wHitCZ/nDGUeOOubcYQWGD3y089UfoW5I3kIB5Ta/fhF1bBEh6K6amiRV
         pgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712280953; x=1712885753;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7c0YAXHYAARa4t+azzKsBRh7TpDkWZPSyUcI/Ckh5E=;
        b=QjMRPc65NaEfDpFpz7uSxZ4zwzVlrEKkDZIf+/xgJ0Zs0jZyRd/OdMZEb7SO9E0VV0
         Z16Dp+u85XbdMjeRQmB0NCI3yVzOqzsyXQcVFz1Sv2vkiZsmvDDOQ2bRsWihk12cn+ti
         Zi6xIp8/a4DfMopL1CA3yv5oXR+xsvwfiE5nZ9w8x9E2BW7RQ5iRRqTxb+g1pUtE+fdP
         sdMxfVS64vbJ77STiUDxXYByVliPnWsEox2jlfuzi+M1yX240SKOUmDGF0iyokjn4P/X
         KyjXfbxxubM80Vs8gUD89vni7CeN3kSPHljk6UXfGCysu7r28OBo+XO4oUow4sw9ytRW
         dF7A==
X-Forwarded-Encrypted: i=1; AJvYcCW2nXueW/aHq2VigevHxbtth/Oj6Hy3EGL3GRw/nx5aVdSYiq7iT1rAs0YI8Aj5jhA85KrvJG5Dy4fhnGYRVVCoVY6P9MGgsB40N5Ct
X-Gm-Message-State: AOJu0Ywpl5nzCEU+5QTBe4uSlcV3JJsIoFtclV40F3cQ/QjpgeWpX7tU
	kqCkDE8mroDa0tMZdg9PrjMLO7ilTPDeF0VRBBWxEDKtYaEuLKQnou292cTJfN695TvSxFBeB+1
	m94WSn+QcDDBJidJrjA==
X-Google-Smtp-Source: AGHT+IGnr9sjDIzkHfWFA3r7NPAbrRE0n1gPgA8ilwWP/trrO+2CchhEjdvuhVNlYmxNUVKzC30LK0N41cvBJ/wG
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:690c:24f:b0:615:2f17:17ca with SMTP
 id ba15-20020a05690c024f00b006152f1717camr300974ywb.8.1712280953119; Thu, 04
 Apr 2024 18:35:53 -0700 (PDT)
Date: Fri,  5 Apr 2024 01:35:44 +0000
In-Reply-To: <20240405013547.1859126-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405013547.1859126-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405013547.1859126-3-yosryahmed@google.com>
Subject: [PATCH v1 2/5] mm: zswap: refactor limit checking from zswap_store()
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

Refactor limit and acceptance threshold checking outside of
zswap_store(). This code will be moved around in a following patch, so
it would be cleaner to move a function call around.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/zswap.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 1cf3ab4b22e64..fba8f3c3596ab 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1391,6 +1391,21 @@ static void zswap_fill_page(void *ptr, unsigned long value)
 	memset_l(page, value, PAGE_SIZE / sizeof(unsigned long));
 }
 
+static bool zswap_check_full(void)
+{
+	unsigned long cur_pages = zswap_total_pages();
+	unsigned long thr = zswap_accept_thr_pages();
+	unsigned long max_pages = zswap_max_pages();
+
+	if (cur_pages >= max_pages) {
+		zswap_pool_limit_hit++;
+		zswap_pool_reached_full = true;
+	} else if (zswap_pool_reached_full && cur_pages <= thr) {
+		zswap_pool_reached_full = false;
+	}
+	return zswap_pool_reached_full;
+}
+
 bool zswap_store(struct folio *folio)
 {
 	swp_entry_t swp = folio->swap;
@@ -1399,7 +1414,6 @@ bool zswap_store(struct folio *folio)
 	struct zswap_entry *entry, *old;
 	struct obj_cgroup *objcg = NULL;
 	struct mem_cgroup *memcg = NULL;
-	unsigned long max_pages, cur_pages;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
 	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
@@ -1422,22 +1436,8 @@ bool zswap_store(struct folio *folio)
 		mem_cgroup_put(memcg);
 	}
 
-	/* Check global limits */
-	cur_pages = zswap_total_pages();
-	max_pages = zswap_max_pages();
-
-	if (cur_pages >= max_pages) {
-		zswap_pool_limit_hit++;
-		zswap_pool_reached_full = true;
+	if (zswap_check_full())
 		goto reject;
-	}
-
-	if (zswap_pool_reached_full) {
-		if (cur_pages > zswap_accept_thr_pages())
-			goto reject;
-		else
-			zswap_pool_reached_full = false;
-	}
 
 	/* allocate entry */
 	entry = zswap_entry_cache_alloc(GFP_KERNEL, folio_nid(folio));
-- 
2.44.0.478.gd926399ef9-goog


