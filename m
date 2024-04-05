Return-Path: <linux-kernel+bounces-132427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098488994C3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B3311C22915
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 05:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7751626296;
	Fri,  5 Apr 2024 05:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3LJID+pE"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFE323754
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 05:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712295320; cv=none; b=TI67GtkImj3SrHaUBFTQgX1IHoMK6f/bXg1aD9Q2p5A3MgLGSBx+/BTi+uiEho7Fsqa+9WKJ0epcL4pRjJqK7szaB+lukNKvzsYoI7QUpdiLbBkBJVPdpLKHcRgeOKI1Vrh+c160teeB+j0nk0CMgNZzsYJDfxIYtUmyW/TTG4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712295320; c=relaxed/simple;
	bh=5F9Bd2r28dJJtSqVJvAZgDM+tkC4MEPTNqJzfo5xl94=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=co+w8QEZpxaETuZD74gJXEhtLIfs0s1XwRawdKjfhWryEbdDK/KDDbVxyX7olYqkb9E04GtyDDOybaMdw9F3tjyZCDcLOoqP9DixyfWyWo5FeY/9nfNV0NV78VuWpaSP3jx5t90eTyJrtFW6NcUsrlmrb9CWMOe+52GuR5q3qyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3LJID+pE; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26845cdso2671109276.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 22:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712295318; x=1712900118; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WDqFLsTFGLxbu9w6SZiJvC7ASuSVfXA4IdBaekrBdf8=;
        b=3LJID+pEMcwH0yskP0DUVBV2i+K6M4YSiMLshgOUMvFPpVFyUnPs04ou2cP14RQ3fQ
         wc2zNRvL5OwymJ6/qLuZ3Sz39rM8NTEPIpuMzB+ZRrvcDdL/wcQ+ZoWh3ENe3QlPfWFM
         Izj0oxVMv8mf2suI4zInck5ABr5I7LC5BM/OI6zo5lP867H93VXMG10rPa0PaxrnNTFB
         EDAFXN/GFDZ4O4qkITUnQppisW6UUxykUEtc4RwF/d6xUgLylNyuR6uoerNRLwIpZHCG
         GkTwEMTfIj9E5N6khHxyNfPkT1sXacSfcQW36XlRi6HDqUNZtEOZLK9b0/fPvlULH6/f
         Bz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712295318; x=1712900118;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WDqFLsTFGLxbu9w6SZiJvC7ASuSVfXA4IdBaekrBdf8=;
        b=QOdjZlZeJCJ+Z9xc8YNa83aNrj7uLKEtq75BMGewVyp0Q4RAmZ0F35DVrK5U1v9gOF
         MbW1pys+nu2hxoR4Xbj6lvLV4HeAzGMXW6cT29BCD/DV+RYkCluNfxawL5PTp1syBMTN
         yqU7j6XfkRw+Byn3AtHkdyF72JDy+sMim90tHmObYMLLeFBz9ro81f+hY6Kp7o2667xL
         Pu6ZQ97IrlCqQm+thxd15vK9swrbqgRpFDH2kXYXiIW3z7dDHVl3ZmluAC5UWddbDcqE
         HysiYZ+dgfx2crQUYPilUpeWY9ictZUDIeasKt97E579WNdGT16iE2UQT7bl4AJ5WWSt
         v+/A==
X-Forwarded-Encrypted: i=1; AJvYcCWSSL1ykBC81KknABgiY7mSCmHoywIIDKZuSB7Cb/+uCCVjIWgxqzFIsZWR2t5rpxLZiJHLLoiouGhYwEwgYyBrEpeSKUy+xRM4PGfk
X-Gm-Message-State: AOJu0YysFeC4Yittima2ESMUSW6pz+F6Lq+YG9wKvXVNXgXqpo/lIN5Z
	nI+2DUcrsZ9F3yCaBKpbh0U+l4F7yp9yVHOBRxn6hqaI1CP0yLWdUbJh2/W7vYgnsQBJcnvBn1J
	TnS6aZihqYYHBgDwziA==
X-Google-Smtp-Source: AGHT+IEIkNqISvh3/kP7GIAdlqcFQuxDthw7sLxMpCyp0IlORn7H21arD9nnFY26GvXJUA85AaAzJMEQR86jOyJW
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:1893:b0:dcc:5a91:aee9 with
 SMTP id cj19-20020a056902189300b00dcc5a91aee9mr112599ybb.7.1712295318409;
 Thu, 04 Apr 2024 22:35:18 -0700 (PDT)
Date: Fri,  5 Apr 2024 05:35:08 +0000
In-Reply-To: <20240405053510.1948982-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405053510.1948982-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405053510.1948982-4-yosryahmed@google.com>
Subject: [PATCH v2 3/5] mm: zswap: refactor limit checking from zswap_store()
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
 mm/zswap.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 832e3f56232f0..ab3cd43cdfc9d 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1444,6 +1444,20 @@ static void zswap_fill_page(void *ptr, unsigned long value)
 	memset_l(page, value, PAGE_SIZE / sizeof(unsigned long));
 }
 
+static bool zswap_check_full(void)
+{
+	unsigned long cur_pages = zswap_total_pages();
+
+	if (cur_pages >= READ_ONCE(zswap_max_pages)) {
+		zswap_pool_limit_hit++;
+		zswap_pool_reached_full = true;
+	} else if (zswap_pool_reached_full &&
+		   cur_pages <= READ_ONCE(zswap_accept_thr_pages)) {
+		zswap_pool_reached_full = false;
+	}
+	return zswap_pool_reached_full;
+}
+
 bool zswap_store(struct folio *folio)
 {
 	swp_entry_t swp = folio->swap;
@@ -1452,7 +1466,6 @@ bool zswap_store(struct folio *folio)
 	struct zswap_entry *entry, *old;
 	struct obj_cgroup *objcg = NULL;
 	struct mem_cgroup *memcg = NULL;
-	unsigned long max_pages, cur_pages;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
 	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
@@ -1475,20 +1488,8 @@ bool zswap_store(struct folio *folio)
 		mem_cgroup_put(memcg);
 	}
 
-	/* Check global limits */
-	cur_pages = zswap_total_pages();
-	if (cur_pages >= READ_ONCE(zswap_max_pages)) {
-		zswap_pool_limit_hit++;
-		zswap_pool_reached_full = true;
+	if (zswap_check_full())
 		goto reject;
-	}
-
-	if (zswap_pool_reached_full) {
-		if (cur_pages > READ_ONCE(zswap_accept_thr_pages))
-			goto reject;
-		else
-			zswap_pool_reached_full = false;
-	}
 
 	/* allocate entry */
 	entry = zswap_entry_cache_alloc(GFP_KERNEL, folio_nid(folio));
-- 
2.44.0.478.gd926399ef9-goog


