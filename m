Return-Path: <linux-kernel+bounces-31681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BADC833278
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 03:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C935283866
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 02:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497242105;
	Sat, 20 Jan 2024 02:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sBgNXW7P"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAFC111E
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 02:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705718415; cv=none; b=aFcKAcQgfggQSkMPN4clcxNuA/HRPzSMlS0qsnGZWgBChzEpnosnf80tAFLw/PdCtnoXq5Tjy4S8E4CqGKJrlbxMxuxu8DSdahwOa97dgXtALe3oGWWXI93czYZH02CPtM+1rKEFLSTZQETaFm5NRvgBuEvWL3hXPwBzm/aigN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705718415; c=relaxed/simple;
	bh=LCehRxHcPURdqDd+A6LsG5DhsUqvxC6slXr4dvoC3PU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dEjyFEM4d0fIY6XIZzBTzevgtQkEhk5LGxapwaQjvu+05OMrQ6m0LqyoD8vnESw/JMMNUIRVfBLgeYAJ+8c/ref33qSjXri52KQecL7QPYA38ME1s4S7wn9me2Tiq9qtezDP23SdI03zmf28pzjcmeX6xYhMKfXN60pN/4YG1yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sBgNXW7P; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc2358dce6bso1827186276.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 18:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705718413; x=1706323213; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fLiPaqnX6yFRN11bVOzAvgH/n62qJ4AjDWPdtJN5Ujg=;
        b=sBgNXW7Pm8YSvLOc9jyTZn/t64NP3NVT1OFKZFsGbX0hASC3KQFMd4YNMvsV7qZkkB
         HhdkU5+qw3hvNQL1/AeuGb1QXWya5wsoPc8ZliQHGBe8htQfeqyCy54S0qQqI3xX1Rwr
         bHFWFzBfQv5sohTMPFAxO0iPcBwz4Khha7mDNzMzL4E2OEymE4PBVG0NEBnCFhcbZ3UL
         5imQ8twmtaJuyIDktEqT7TjkvXxUjy2eVPf4cPbMrlbu+2P4UXKS1RXxY8cv4vgZlsWK
         9QUz88pPewed4IQCHWmkVt+yTsFmApHsbXMHJLubIwm8uz3XJBop3jUz6YyQKgwjAMma
         myNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705718413; x=1706323213;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fLiPaqnX6yFRN11bVOzAvgH/n62qJ4AjDWPdtJN5Ujg=;
        b=CyzqUSJGznVv5wNYQ06CXluh1ksUHSsC2Ffm8OgUgRMSOQUrsjBK3mqu4N3lt8mGeR
         reIn2XcL4eraftTX3p1Z1cz3KsdBNtD+6JazE5OAp0kEZgIrgLen5B/yGlUXMR5fvsGm
         ZdmbEYrVNnuJIWiXg0vdxICK5kwVA2oaeoibcNEylDMmRAZIIgGEJFHrUt/QxhaBkMnS
         6t70fU3iTzWpymtfUQdgbcak6rhlxXD1dkREpSQbvqjGRYlt0dxnd8A7ggVLCQPExGIw
         nSmc2XgVExS233WMSWvMUUPS6dSwY1zGk1H1LAQdiMR2eiEhxEQur1VI1iSJNS/1MX0D
         9JEg==
X-Gm-Message-State: AOJu0Yyzv4wTT3KsorBTH+hkuyzVqHQYFTE36E3r/Mf7e8W4DIQdCabr
	tXD2iWBnvTUbnIjOs3ygBh7e2icxg9fzkIH/5sIEML4JZf6EfaOZVRXhxBJ1vREHY/O67LYae3p
	moW/WgN7pBsOYZDRh+A==
X-Google-Smtp-Source: AGHT+IH62W2NQREKfSMAniaidxoTrzRePf8+sI0VOkuK1PVXyK3gj/XmLpZGQU6WH8o8uGiygsMnl+Yr/Hd/Kj2B
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:b1f:b0:dbe:abc7:ae5c with SMTP
 id ch31-20020a0569020b1f00b00dbeabc7ae5cmr76590ybb.3.1705718413333; Fri, 19
 Jan 2024 18:40:13 -0800 (PST)
Date: Sat, 20 Jan 2024 02:40:07 +0000
In-Reply-To: <20240120024007.2850671-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240120024007.2850671-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240120024007.2850671-3-yosryahmed@google.com>
Subject: [PATCH 2/2] mm: zswap: remove unnecessary tree cleanups in zswap_swapoff()
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

During swapoff, try_to_unuse() makes sure that zswap_invalidate() is
called for all swap entries before zswap_swapoff() is called. This means
that all zswap entries should already be removed from the tree. Simplify
zswap_swapoff() by removing the tree cleanup loop, and leaving an
assertion in its place.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
Chengming, Chris, I think this should make the tree split and the xarray
conversion patches simpler (especially the former). If others agree,
both changes can be rebased on top of this.
---
 mm/zswap.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index f8bc9e0892687..9675c3c27f9d1 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1790,17 +1790,12 @@ void zswap_swapon(int type)
 void zswap_swapoff(int type)
 {
 	struct zswap_tree *tree = zswap_trees[type];
-	struct zswap_entry *entry, *n;
 
 	if (!tree)
 		return;
 
-	/* walk the tree and free everything */
-	spin_lock(&tree->lock);
-	rbtree_postorder_for_each_entry_safe(entry, n, &tree->rbroot, rbnode)
-		zswap_free_entry(entry);
-	tree->rbroot = RB_ROOT;
-	spin_unlock(&tree->lock);
+	/* try_to_unuse() invalidated all entries already */
+	WARN_ON_ONCE(!RB_EMPTY_ROOT(&tree->rbroot));
 	kfree(tree);
 	zswap_trees[type] = NULL;
 }
-- 
2.43.0.429.g432eaa2c6b-goog


