Return-Path: <linux-kernel+bounces-143521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 926DD8A3A79
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 04:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23BAC28350B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 02:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3DD199B0;
	Sat, 13 Apr 2024 02:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t/t/P7aq"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0152F17C6B
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 02:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712975055; cv=none; b=iUB2B8j1qxqfRx8P8mjZaJRa2s5V4LWENBb9MbmwUt5nLY3RReo0H8WieCaERyA+ugcFGznUj0R0/gudlOIpVtojwM0VZUqGP+F2au2tMkagVzkBrOHioUb+vileyL7/yH2vL1K6o829wno7i9rBHmi6efEFcu6b0UyOJr5HnqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712975055; c=relaxed/simple;
	bh=3qZROuIu+1JIpszYBziqVDLibz3qxq/ZHL9aJhpHmNo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZOrLTpi+1DbbLAt551kNpVFV2OF/f9FOvbLICUJWhnN8h5I+H3YmTc5EZHcCCRur56T5dEQxtj3F33S5wD4aGCYDcolVjcFXKbOUJ9xprDALtlIhjOJzCW/1Oex+Xl3cN/DhrAOKjf8LHoMgJmgqZQkHuUO2iwlvnepPlUUXzG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t/t/P7aq; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6150dcdf83fso30140967b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 19:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712975053; x=1713579853; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pFcpj0TvebZcgya6byXyrm5KOadn+Q+ON/Bz5Cqkl5I=;
        b=t/t/P7aqZq5rTkxe8hYT5gfvR+tUrxppwvfZVbHHj6OxJlmJDzGUAWwvzlq8xa0zBU
         hk5gClJzfLawiwSsP5vuqrJ2YB9DlyPb57VuOTauEVV/RvXR7ewP4SinR0KpmRASDW4k
         LxGhatOAQ3XvWgjCHnb1AwWiEZlELdtRpMPg97LvvEqTPfOMNRGcr5JVtTiS7ss9DR4V
         HKTDk+zoq/wga7M2DMDwII1M+bNESN2B/vYYUGQ/cj+9PK/UkbzIjEnoeQ24g0fIqJIM
         cIf2cq0aQVCmmwBf9a0Gr4Ic5wGzTreVEPMXpqtptKu3NSnN6WgUSNuAK4AKyCTC9A7b
         l47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712975053; x=1713579853;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pFcpj0TvebZcgya6byXyrm5KOadn+Q+ON/Bz5Cqkl5I=;
        b=U5vp7T949toYYFyZdroaRaeZLKKK/ant5bcHdqSETRkBdOUj5Az/+SRluHh1dUEgRQ
         64lY4QLaIawWNC9QTK+js0ON23Zzms+UaTKP5kvuZM8w7bregfrIwkuOuqyBOGl8uuvW
         hVO7V19/79JiP7J2Eepih0ZPvOhaoDY5RSNPlqM75H991kale4qH5V/qqJ2F9II1TRKJ
         GvSEhlsuxvUIaW6QmsSHq10yMNKJs1YVDGT2XFww87AAuaWcPLhiz5jaZ/JjogAdBKzr
         iWDdIu2JfItXtJI0rH0OA47oftpd96SvE8aYZ8xdvv7BPTj7u19TfRGNlpR25GdU+IFl
         5xRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVH8ZJGrTTT0CWus03MP2YZT+N2r+UGk4gKH4O0ZxjwONu8Zn6YSeqoZZ7MSyWYqpWD8q4OvxtmfuCivkSLR7qOLyVSP3Z4seJj/eQS
X-Gm-Message-State: AOJu0YxMvgzSAPl/lf3TpLPjIL3UHhso4JJDcy0AdEdqy84RDwi5nAY6
	8cKy+faK7F3QbPZLb2u3Q0mpxEZ/Los6SEeRCBEEYonH4N40Za812LHeMF7CNu5wJng+9/Maxjw
	uZG6tzuYNEBzowWQr2w==
X-Google-Smtp-Source: AGHT+IHAlbeOydfvBUQ+AYR1qIuBuBzl/BOKahweaVpfLg8kz58GaVMgBySWi8xxEMGZJABW5nfoPZGjO8NmCCMB
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a0d:e209:0:b0:618:80c0:1a2e with SMTP
 id l9-20020a0de209000000b0061880c01a2emr834009ywe.6.1712975053165; Fri, 12
 Apr 2024 19:24:13 -0700 (PDT)
Date: Sat, 13 Apr 2024 02:24:05 +0000
In-Reply-To: <20240413022407.785696-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240413022407.785696-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240413022407.785696-3-yosryahmed@google.com>
Subject: [PATCH v3 2/4] mm: zswap: refactor limit checking from zswap_store()
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
index 77b6bb2099763..7cddbca3ac62c 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -517,6 +517,21 @@ unsigned long zswap_total_pages(void)
 	return total;
 }
 
+static bool zswap_check_limits(void)
+{
+	unsigned long cur_pages = zswap_total_pages();
+	unsigned long max_pages = zswap_max_pages();
+
+	if (cur_pages >= max_pages) {
+		zswap_pool_limit_hit++;
+		zswap_pool_reached_full = true;
+	} else if (zswap_pool_reached_full &&
+		   cur_pages <= zswap_accept_thr_pages()) {
+			zswap_pool_reached_full = false;
+	}
+	return zswap_pool_reached_full;
+}
+
 /*********************************
 * param callbacks
 **********************************/
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
+	if (zswap_check_limits())
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
2.44.0.683.g7961c838ac-goog


