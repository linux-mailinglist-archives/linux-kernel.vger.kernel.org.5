Return-Path: <linux-kernel+bounces-36438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1812F83A0BF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADFDF1F2B906
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB43E54C;
	Wed, 24 Jan 2024 04:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Obpp6kWR"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EE5C2D2
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 04:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706071880; cv=none; b=Zp0MRqOLplEiOmWNhHR7zCCdWbYv0kpqXeBwmNsjH4p46fgbbwMftRVBVpJ+POSxToXcD+ZmFlkKlUH+tSmUGo+c3SywY0Lg5dXml13Kznf9gc3M8WPpZSc4Qfp3c1Ua2cTDkDaDqka2jSpXq8ryZUI9cfIC1PpHAqbxGqQc36g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706071880; c=relaxed/simple;
	bh=QQ4iFc7pBwn0Cc5xww2UkCQwKEjS5fJ6B1OQhRJ1HtA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yb8Y2yIf4bVe3qXN6pd2WxIOI0tP7LPYGUYL9lqaaj3v338RcHOx2LEtzYItBm1TYyfQy8D625+RUEiKFHHIX6mI+TXrZM4zsJWC+cH5JiKaWzFAZBR5z8Ezdx0Z4ehSc+ZfeNaNCLIlY1OQUIlFXjl8g6gumb5Hi/azN8fji0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Obpp6kWR; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6029c85922dso3813667b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 20:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706071877; x=1706676677; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tZ4zMgobYN5FtUkXrR87lWOCtHQq0Np8Yg1aQ6/7PDQ=;
        b=Obpp6kWRyAVsKVDvm5xY5j/VKQe0BA64N4XL7zXp79e2RKQ2rZbpLduMKW3EI2xsNZ
         l6ATDIjUsBsIr7GKfwB+NTrooc11NVeC4jXwXdW/3QTyAOLmNt7AEi5NZ41+6RIwIFIl
         g5trN/KTNKdH6fqC8LGh7KJDhgbPmTK72b8wPbocNGihdRfIAjeitHGq4YZPKB8g6aw6
         NNKWCfT1yffC3Y5xmCkjsJ5xRJNMk703t8vqqsXeqlw+YBkL78Ru7B5QTwqWEmxPOAxH
         Lc9QnYH9a+GdCsmSQ5I0c5n08IMX2o1v0EdmchMXwU0xx5kqnY/1HAsgbWW1DyG/gVWy
         fmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706071877; x=1706676677;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tZ4zMgobYN5FtUkXrR87lWOCtHQq0Np8Yg1aQ6/7PDQ=;
        b=wriGVbZzqF0asXl7MbN+wow451IiuHIdq4fLzE4CSFgUCLoyEwFOYa5JsU+2YxIQZJ
         4HJv3Ob+AbVQtkUukTxk4qlDJQU4qh5zZ/Df5OKKvAxSgdcrRU59xQzQsNFsrD/bN2hF
         dkUxyrBb1eDTyyScVbFxelR5xUJNCo+VNoWCLHnUcM6gwUWRjMPkPWG4YE7C38h0BkTF
         c/6m8UVQz7fBu16Sxfq5PTmfSNjTCwo9Plr9ukBUxGzMyDVVjo3ZVCbIDKulyzrd3mMN
         SPr67wZKSm4vrZIqX3oeErDegI9ANt/CRPke4V1S5FSea4txXTDAHsyToc6RUKn5RUKR
         FgMg==
X-Gm-Message-State: AOJu0YySlzvo5nlWbTg0RX0hyOAy4f5tW/I8ujNBEWjunanUJjBmZ2qY
	hO/624/f2pRkCt6NS7VJWYTMRBIORvYEo6a8N3t2XWIjpXgr8jLAau3amlp8alThLI16sx4ysB0
	TYZInysyXXRsCKeUP5A==
X-Google-Smtp-Source: AGHT+IH4dlOAA/aNVlbOqFDsv6qz2rL4n/3QH5h9ZkNH6atvYVWvPw72AEqTtaPY+eysFAbiENcG3HUSpBnk9xox
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a81:9806:0:b0:5fa:4896:7114 with SMTP
 id p6-20020a819806000000b005fa48967114mr148615ywg.5.1706071877573; Tue, 23
 Jan 2024 20:51:17 -0800 (PST)
Date: Wed, 24 Jan 2024 04:51:11 +0000
In-Reply-To: <20240124045113.415378-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240124045113.415378-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240124045113.415378-2-yosryahmed@google.com>
Subject: [PATCH v2 1/2] mm: swap: enforce updating inuse_pages at the end of swap_range_free()
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

In swap_range_free(), we update inuse_pages then do some cleanups (arch
invalidation, zswap invalidation, swap cache cleanups, etc). During
swapoff, try_to_unuse() checks that inuse_pages is 0 to make sure all
swap entries are freed. Make sure we only update inuse_pages after we
are done with the cleanups in swap_range_free(), and use the proper
memory barriers to enforce it. This makes sure that code following
try_to_unuse() can safely assume that swap_range_free() ran for all
entries in thr swapfile (e.g. swap cache cleanup, zswap_swapoff()).

In practice, this currently isn't a problem because swap_range_free() is
called with the swap info lock held, and the swapoff code happens to
spin for that after try_to_unuse(). However, this seems fragile and
unintentional, so make it more relable and future-proof. This also
facilitates a following simplification of zswap_swapoff().

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/swapfile.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index b11b6057d8b5f..0580bb3e34d77 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -737,8 +737,6 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 		if (was_full && (si->flags & SWP_WRITEOK))
 			add_to_avail_list(si);
 	}
-	atomic_long_add(nr_entries, &nr_swap_pages);
-	WRITE_ONCE(si->inuse_pages, si->inuse_pages - nr_entries);
 	if (si->flags & SWP_BLKDEV)
 		swap_slot_free_notify =
 			si->bdev->bd_disk->fops->swap_slot_free_notify;
@@ -752,6 +750,14 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 		offset++;
 	}
 	clear_shadow_from_swap_cache(si->type, begin, end);
+
+	/*
+	 * Make sure that try_to_unuse() observes si->inuse_pages reaching 0
+	 * only after the above cleanups are done.
+	 */
+	smp_wmb();
+	atomic_long_add(nr_entries, &nr_swap_pages);
+	WRITE_ONCE(si->inuse_pages, si->inuse_pages - nr_entries);
 }
 
 static void set_cluster_next(struct swap_info_struct *si, unsigned long next)
@@ -2049,7 +2055,7 @@ static int try_to_unuse(unsigned int type)
 	unsigned int i;
 
 	if (!READ_ONCE(si->inuse_pages))
-		return 0;
+		goto success;
 
 retry:
 	retval = shmem_unuse(type);
@@ -2130,6 +2136,12 @@ static int try_to_unuse(unsigned int type)
 		return -EINTR;
 	}
 
+success:
+	/*
+	 * Make sure that further cleanups after try_to_unuse() returns happen
+	 * after swap_range_free() reduces si->inuse_pages to 0.
+	 */
+	smp_mb();
 	return 0;
 }
 
-- 
2.43.0.429.g432eaa2c6b-goog


