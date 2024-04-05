Return-Path: <linux-kernel+bounces-132311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4808992D5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 03:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7F4D1F27218
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 01:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF62B1B94F;
	Fri,  5 Apr 2024 01:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QvIk1C+Q"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A66175BE
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 01:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712280959; cv=none; b=ZcSYhkegYM4FlK2xmb7n1ZveyGv7H5tqdwQbOOp2dJQ9dsayE+BKFLuskioZtFvqT67oAqm1QS0BAbqRBuqMBzMSWwWA9Inm44FUdMnSkPIkPoyUZN5QU0qaZN4Be07RkbVRDKlpwBJ4nUz9C1zTswXXpd56pMEUQn22PP8JKrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712280959; c=relaxed/simple;
	bh=JNiEew8FxcxcGoJSLQWAp+oqkYs1/tc4TYyq14CFOd8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SO9cW0p0a6WkEhA0WgzqverDjzvLRrLsl/OOxtYu3rDXq6PB60EDxrVmLtetj5FjSRtd+xN2l8dEURthFpQuPasHOWRFgppHeEaBoalvAMuK3b9aKXhHs+OQV9iO8y/koFMQFyRWpD0+4tJZRycgxPfHKKaUH3nvgLdLm26Zzlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QvIk1C+Q; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc3645a6790so2794293276.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 18:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712280956; x=1712885756; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/m5gy6JRDNvLrFZhE09AdQy3FefAqzIV084ImGWBY7k=;
        b=QvIk1C+QuErYwc5F+h1YzJ7kj9kruLN8vg3x7rVBAahwU4Uv39lawGst6W3bpN/zqD
         wWPc5cyDtZpCciBTQEH00vO83RKA2zOSlM2ruruIC4jUlrHsUukOwH6+u2NnWKVkXmjF
         /K9pC5GijloMujgSyWDRNqZvwxIgMh/5Grxg8LyY1JSe6GeeldBkWmJKEndG32A1MK0N
         aCzF2GvwA9OmBNb+yA08XNB7zpckYWvsj4QSnViYV0rf9RARtxfTmkcrkV31E0qs9bvP
         XsK2dxcbUv9nG90Ey2pP8IokENR4dc7Evv6aPVJWK0X+Y/Mn6Pf2V5spExOhBdn/lfmC
         szCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712280956; x=1712885756;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/m5gy6JRDNvLrFZhE09AdQy3FefAqzIV084ImGWBY7k=;
        b=anIf7KJnjNe3azXWXcx37kqI60ShRaxZLSkR5gCyXhhN40m9HyqacekS0xx9V+OniW
         k/iT+dJQzeSdIGk2RxDxlr25On9WpJUCgfxpdiMTKmUF8iUFj8nc7/RPVrwXduW8VpRv
         h1F4ZL+fz04dQDjPAkl0cg3rxQlbGeliYeOvEHU8oe4rBa++0R1GoMPGmRLkbZ4ZY1lM
         a2w0SaAvxV0Ezx5ZrnIoKmt39tFP3YI+V74n9BD12d0OsLq/G+MQSM4yxyW5avQgBALi
         HKZcN/dYLYzI32+1u4Et/oneQvRFaitkxVil4GvaGBOVeZ/aY9BiatfvyrKZZC1cT2u+
         Q1Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUd1MPnN8mOecNifmTR6JkysRdwESBwP8wJB+oPYzpHBFBo2sVCLdf/Wtqbd7kIIGonwgX+keRZ8+UlZmKIAgwL8ybNRxLgGy0XXaWI
X-Gm-Message-State: AOJu0YyamzA6PcdFbOEG/rHsCvk3zPARNrBNVo0pMFNI/ulE0KWinNO+
	bOJ0hYMypZJO5h7CetvcsZGIypxppNAodtkTv2Pts0TzVnhX7JZKLATC5eokZzQCKgmmCeIaN1f
	A02ZikUGdMeeEt2fdzA==
X-Google-Smtp-Source: AGHT+IF7f54z2FdS42Ou0yg3jjIJwSZWrUbEzwVPRh5Hihv5pxBYL/oylI81O/dhSX/lYtxqrDRNaVzdafD0Up7i
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:20c5:b0:dc6:d233:ffdd with
 SMTP id dj5-20020a05690220c500b00dc6d233ffddmr362563ybb.0.1712280956608; Thu,
 04 Apr 2024 18:35:56 -0700 (PDT)
Date: Fri,  5 Apr 2024 01:35:46 +0000
In-Reply-To: <20240405013547.1859126-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405013547.1859126-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405013547.1859126-5-yosryahmed@google.com>
Subject: [PATCH v1 4/5] mm: zswap: remove same_filled module params
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

These knobs offer more fine-grained control to userspace than needed and
directly expose/influence kernel implementation; remove them.

For disabling same_filled handling, there is no logical reason to refuse
storing same-filled pages more efficiently and opt for compression.
Scanning pages for patterns may be an argument, but the page contents
will be read into the CPU cache anyway during compression. Also,
removing the same_filled handling code does not move the needle
significantly in terms of performance anyway [1].

For disabling non_same_filled handling, it was added when the compressed
pages in zswap were not being properly charged to memcgs, as workloads
could escape the accounting with compression [2]. This is no longer the
case after commit f4840ccfca25 ("zswap: memcg accounting"), and using
zswap without compression does not make much sense.

[1]https://lore.kernel.org/lkml/CAJD7tkaySFP2hBQw4pnZHJJwe3bMdjJ1t9VC2VJd=khn1_TXvA@mail.gmail.com/
[2]https://lore.kernel.org/lkml/19d5cdee-2868-41bd-83d5-6da75d72e940@maciej.szmigiero.name/

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/zswap.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index b92fa37bee277..a85c9235d19d3 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -123,19 +123,6 @@ static unsigned int zswap_accept_thr_percent = 90; /* of max pool size */
 module_param_named(accept_threshold_percent, zswap_accept_thr_percent,
 		   uint, 0644);
 
-/*
- * Enable/disable handling same-value filled pages (enabled by default).
- * If disabled every page is considered non-same-value filled.
- */
-static bool zswap_same_filled_pages_enabled = true;
-module_param_named(same_filled_pages_enabled, zswap_same_filled_pages_enabled,
-		   bool, 0644);
-
-/* Enable/disable handling non-same-value filled pages (enabled by default) */
-static bool zswap_non_same_filled_pages_enabled = true;
-module_param_named(non_same_filled_pages_enabled, zswap_non_same_filled_pages_enabled,
-		   bool, 0644);
-
 /* Number of zpools in zswap_pool (empirically determined for scalability) */
 #define ZSWAP_NR_ZPOOLS 32
 
@@ -1368,9 +1355,6 @@ static bool zswap_is_folio_same_filled(struct folio *folio, unsigned long *value
 	unsigned int pos, last_pos = PAGE_SIZE / sizeof(*page) - 1;
 	bool ret = false;
 
-	if (!zswap_same_filled_pages_enabled)
-		return false;
-
 	page = kmap_local_folio(folio, 0);
 	val = page[0];
 
@@ -1460,9 +1444,6 @@ bool zswap_store(struct folio *folio)
 		goto store_entry;
 	}
 
-	if (!zswap_non_same_filled_pages_enabled)
-		goto freepage;
-
 	/* if entry is successfully added, it keeps the reference */
 	entry->pool = zswap_pool_current_get();
 	if (!entry->pool)
-- 
2.44.0.478.gd926399ef9-goog


