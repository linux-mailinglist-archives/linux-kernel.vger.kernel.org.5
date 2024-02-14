Return-Path: <linux-kernel+bounces-64770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC9C85429F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4142028E5D7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0CC12B84;
	Wed, 14 Feb 2024 06:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wY1I/0ng"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E904125B1
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 06:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707890767; cv=none; b=RXVrPB1JXd4Vhfq1MUeE9vvBzLv31S5TNulplVaQCYgmOI5B3dJzctJSBrs40yUc8f9QfvtJ5svqCuTEew0MoZmE2Qa3z6lYYACSWPvLav5avHwCLE3CTDvicuJHcH3ZYJ9Ns/yjV3LTT86xBbxNRZT7yShp8i6a1Tkdx1aLoPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707890767; c=relaxed/simple;
	bh=N9V0u3Ch6t/WSSGIrkB/hnLuxMA5NOlPuGRvTZgM1xU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dG3SwRYVS5/zY9SUJmWQObwVoZdPOSRSN0/HvOFa1rHREfwmSbrv+gvEH72MCcImPFL0dvubAyexniwSnTozAgaRyOhKkcEqSKeiCmS+9F6fF1ykZLfjlUkaw4+2AqVOAsFdVIdtkvxrE1/q3b/SvdnWM9IYvWwC8+7QFG3ekn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wY1I/0ng; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6e09015f811so5954067b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 22:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707890765; x=1708495565; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QH8wNJ7lAHDhvm3bFylVV17pyKkkH6HT7TXZodNBMaI=;
        b=wY1I/0ng2hVYWb4vthSvyheDQnCI1i6k0vFospCrhnotctDssViM/npp5seNlWu2NM
         32ruKaifotutq2sO3dqijdU0/Gp4H40hRdnUFGRAYxV+XPYfnWUXivzJYRMKihc1LJa4
         vUdiQCwi1e/HEB460zT+PIZfrmCT+tQynCS/H2Vlm/n/nu79MYB33TJyyH39edztJLBr
         eVAnKMwYMZo0SOhER6roD8n3oBTBStuz+cA3rIqFWK9MKV3oOHvBxEGFvmQfx4+6AqqC
         qJVZl/T/T8sJ5yHhmES4bCfaP1oBMFBZDyG6+yUU6RJbhXlSxPMIa8Uj8G0ttYpcIOI6
         AxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707890765; x=1708495565;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QH8wNJ7lAHDhvm3bFylVV17pyKkkH6HT7TXZodNBMaI=;
        b=p4MHeh/ufvsKh39QNwmyiBygjiWMqMt/UvlG1nQy3plxiKKqIEcSdyIRTUOCLYc0+8
         nGpxIJu8BgXUPjHXvELzRHzw7olySwYyXqZ3OyeCPYWEzix6hvrG+GJ/74hSx8ZURmi/
         KXBz9YNwYaYjoHFgD88nY6O4Dk+zeYq6TBEFbFofxc/uPBiRIYHL5pR/QfHazPtezIal
         LDSOwVf9IubtdmVN5VtpGvzrK3uN4J8Qn8vTZ1jPy481kEi4efVsQP8My8FfYBh1pyiX
         iSFl2JT+oSq9/8mR060/W5coo3SBBOvCM/wVG4AipZnkvRhaV8VcHXeh8l/xTEZK+s0C
         6MWA==
X-Forwarded-Encrypted: i=1; AJvYcCWv7MGMS1QbXcN0o2ps+iD4cKQnIcvyu29T0gSC47Ca2BA66CIXxdDhEo0p9kcdmO4g0xLLdf4rV4/SJVMNeieg9oCHU0ewEQsNnMAF
X-Gm-Message-State: AOJu0YwhBLPy2C1irbldv4nF0ZXIh6rSZBo9tgYn2hid8xioJKus/WzS
	RPP9/SzYjzCGXz6yw0Cwu9lGoBSblHa1BuUs0a6I4B1/IOPNU0EAS15xxMbu90Drl/ljpR4mUm6
	w/Czv11bEeg==
X-Google-Smtp-Source: AGHT+IHQunAmjkzKIPCb68OjVMfuFVv2mPMH+2t6Wiy6R/pOgsm2Z2RPiWQL7A62g5M5NjpLQpMX+lR14ejk/A==
X-Received: from kinseyct.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:46b])
 (user=kinseyho job=sendgmr) by 2002:a05:6a00:2d9e:b0:6e0:a9bc:ef63 with SMTP
 id fb30-20020a056a002d9e00b006e0a9bcef63mr112938pfb.0.1707890764929; Tue, 13
 Feb 2024 22:06:04 -0800 (PST)
Date: Wed, 14 Feb 2024 06:05:37 +0000
In-Reply-To: <20240214060538.3524462-1-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240214060538.3524462-1-kinseyho@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240214060538.3524462-5-kinseyho@google.com>
Subject: [PATCH mm-unstable v1 4/5] mm/mglru: improve struct lru_gen_mm_walk
From: Kinsey Ho <kinseyho@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>, Donet Tom <donettom@linux.vnet.ibm.com>, 
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Kinsey Ho <kinseyho@google.com>
Content-Type: text/plain; charset="UTF-8"

Rename max_seq to seq in struct lru_gen_mm_walk to keep consistent with
struct lru_gen_mm_state. Note that seq is not always up to date with
max_seq from lru_gen_folio.

No functional changes.

Signed-off-by: Kinsey Ho <kinseyho@google.com>
---
 include/linux/mmzone.h |  6 ++---
 mm/vmscan.c            | 50 ++++++++++++++++++++++--------------------
 2 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 22fd46c77840..e51c75270e82 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -468,7 +468,7 @@ enum {
 #define NR_BLOOM_FILTERS	2
 
 struct lru_gen_mm_state {
-	/* set to max_seq after each iteration */
+	/* synced with max_seq after each iteration */
 	unsigned long seq;
 	/* where the current iteration continues after */
 	struct list_head *head;
@@ -483,8 +483,8 @@ struct lru_gen_mm_state {
 struct lru_gen_mm_walk {
 	/* the lruvec under reclaim */
 	struct lruvec *lruvec;
-	/* unstable max_seq from lru_gen_folio */
-	unsigned long max_seq;
+	/* max_seq from lru_gen_folio: can be out of date */
+	unsigned long seq;
 	/* the next address within an mm to scan */
 	unsigned long next_addr;
 	/* to batch promoted pages */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 8c77c332a67a..f1019afa7813 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2906,7 +2906,7 @@ static void reset_mm_stats(struct lru_gen_mm_walk *walk, bool last)
 
 	lockdep_assert_held(&get_mm_list(lruvec_memcg(lruvec))->lock);
 
-	hist = lru_hist_from_seq(walk->max_seq);
+	hist = lru_hist_from_seq(walk->seq);
 
 	for (i = 0; i < NR_MM_STATS; i++) {
 		WRITE_ONCE(mm_state->stats[hist][i],
@@ -2915,7 +2915,7 @@ static void reset_mm_stats(struct lru_gen_mm_walk *walk, bool last)
 	}
 
 	if (NR_HIST_GENS > 1 && last) {
-		hist = lru_hist_from_seq(walk->max_seq + 1);
+		hist = lru_hist_from_seq(walk->seq + 1);
 
 		for (i = 0; i < NR_MM_STATS; i++)
 			WRITE_ONCE(mm_state->stats[hist][i], 0);
@@ -2944,9 +2944,9 @@ static bool iterate_mm_list(struct lru_gen_mm_walk *walk, struct mm_struct **ite
 	 */
 	spin_lock(&mm_list->lock);
 
-	VM_WARN_ON_ONCE(mm_state->seq + 1 < walk->max_seq);
+	VM_WARN_ON_ONCE(mm_state->seq + 1 < walk->seq);
 
-	if (walk->max_seq <= mm_state->seq)
+	if (walk->seq <= mm_state->seq)
 		goto done;
 
 	if (!mm_state->head)
@@ -2976,7 +2976,7 @@ static bool iterate_mm_list(struct lru_gen_mm_walk *walk, struct mm_struct **ite
 	spin_unlock(&mm_list->lock);
 
 	if (mm && first)
-		reset_bloom_filter(mm_state, walk->max_seq + 1);
+		reset_bloom_filter(mm_state, walk->seq + 1);
 
 	if (*iter)
 		mmput_async(*iter);
@@ -2986,7 +2986,7 @@ static bool iterate_mm_list(struct lru_gen_mm_walk *walk, struct mm_struct **ite
 	return last;
 }
 
-static bool iterate_mm_list_nowalk(struct lruvec *lruvec, unsigned long max_seq)
+static bool iterate_mm_list_nowalk(struct lruvec *lruvec, unsigned long seq)
 {
 	bool success = false;
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
@@ -2995,9 +2995,9 @@ static bool iterate_mm_list_nowalk(struct lruvec *lruvec, unsigned long max_seq)
 
 	spin_lock(&mm_list->lock);
 
-	VM_WARN_ON_ONCE(mm_state->seq + 1 < max_seq);
+	VM_WARN_ON_ONCE(mm_state->seq + 1 < seq);
 
-	if (max_seq > mm_state->seq) {
+	if (seq > mm_state->seq) {
 		mm_state->head = NULL;
 		mm_state->tail = NULL;
 		WRITE_ONCE(mm_state->seq, mm_state->seq + 1);
@@ -3348,7 +3348,8 @@ static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
 	struct lru_gen_mm_walk *walk = args->private;
 	struct mem_cgroup *memcg = lruvec_memcg(walk->lruvec);
 	struct pglist_data *pgdat = lruvec_pgdat(walk->lruvec);
-	int old_gen, new_gen = lru_gen_from_seq(walk->max_seq);
+	DEFINE_MAX_SEQ(walk->lruvec);
+	int old_gen, new_gen = lru_gen_from_seq(max_seq);
 
 	pte = pte_offset_map_nolock(args->mm, pmd, start & PMD_MASK, &ptl);
 	if (!pte)
@@ -3415,7 +3416,8 @@ static void walk_pmd_range_locked(pud_t *pud, unsigned long addr, struct vm_area
 	struct lru_gen_mm_walk *walk = args->private;
 	struct mem_cgroup *memcg = lruvec_memcg(walk->lruvec);
 	struct pglist_data *pgdat = lruvec_pgdat(walk->lruvec);
-	int old_gen, new_gen = lru_gen_from_seq(walk->max_seq);
+	DEFINE_MAX_SEQ(walk->lruvec);
+	int old_gen, new_gen = lru_gen_from_seq(max_seq);
 
 	VM_WARN_ON_ONCE(pud_leaf(*pud));
 
@@ -3546,7 +3548,7 @@ static void walk_pmd_range(pud_t *pud, unsigned long start, unsigned long end,
 			walk_pmd_range_locked(pud, addr, vma, args, bitmap, &first);
 		}
 
-		if (!walk->force_scan && !test_bloom_filter(mm_state, walk->max_seq, pmd + i))
+		if (!walk->force_scan && !test_bloom_filter(mm_state, walk->seq, pmd + i))
 			continue;
 
 		walk->mm_stats[MM_NONLEAF_FOUND]++;
@@ -3557,7 +3559,7 @@ static void walk_pmd_range(pud_t *pud, unsigned long start, unsigned long end,
 		walk->mm_stats[MM_NONLEAF_ADDED]++;
 
 		/* carry over to the next generation */
-		update_bloom_filter(mm_state, walk->max_seq + 1, pmd + i);
+		update_bloom_filter(mm_state, walk->seq + 1, pmd + i);
 	}
 
 	walk_pmd_range_locked(pud, -1, vma, args, bitmap, &first);
@@ -3628,7 +3630,7 @@ static void walk_mm(struct mm_struct *mm, struct lru_gen_mm_walk *walk)
 		err = -EBUSY;
 
 		/* another thread might have called inc_max_seq() */
-		if (walk->max_seq != max_seq)
+		if (walk->seq != max_seq)
 			break;
 
 		/* folio_update_gen() requires stable folio_memcg() */
@@ -3765,7 +3767,7 @@ static bool try_to_inc_min_seq(struct lruvec *lruvec, bool can_swap)
 	return success;
 }
 
-static bool inc_max_seq(struct lruvec *lruvec, unsigned long max_seq,
+static bool inc_max_seq(struct lruvec *lruvec, unsigned long seq,
 			bool can_swap, bool force_scan)
 {
 	bool success;
@@ -3773,14 +3775,14 @@ static bool inc_max_seq(struct lruvec *lruvec, unsigned long max_seq,
 	int type, zone;
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 restart:
-	if (max_seq < READ_ONCE(lrugen->max_seq))
+	if (seq < READ_ONCE(lrugen->max_seq))
 		return false;
 
 	spin_lock_irq(&lruvec->lru_lock);
 
 	VM_WARN_ON_ONCE(!seq_is_valid(lruvec));
 
-	success = max_seq == lrugen->max_seq;
+	success = seq == lrugen->max_seq;
 	if (!success)
 		goto unlock;
 
@@ -3833,7 +3835,7 @@ static bool inc_max_seq(struct lruvec *lruvec, unsigned long max_seq,
 	return success;
 }
 
-static bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long max_seq,
+static bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long seq,
 			       bool can_swap, bool force_scan)
 {
 	bool success;
@@ -3842,13 +3844,13 @@ static bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long max_seq,
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 	struct lru_gen_mm_state *mm_state = get_mm_state(lruvec);
 
-	VM_WARN_ON_ONCE(max_seq > READ_ONCE(lrugen->max_seq));
+	VM_WARN_ON_ONCE(seq > READ_ONCE(lrugen->max_seq));
 
 	if (!mm_state)
-		return inc_max_seq(lruvec, max_seq, can_swap, force_scan);
+		return inc_max_seq(lruvec, seq, can_swap, force_scan);
 
 	/* see the comment in iterate_mm_list() */
-	if (max_seq <= READ_ONCE(mm_state->seq))
+	if (seq <= READ_ONCE(mm_state->seq))
 		return false;
 
 	/*
@@ -3858,18 +3860,18 @@ static bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long max_seq,
 	 * is less efficient, but it avoids bursty page faults.
 	 */
 	if (!should_walk_mmu()) {
-		success = iterate_mm_list_nowalk(lruvec, max_seq);
+		success = iterate_mm_list_nowalk(lruvec, seq);
 		goto done;
 	}
 
 	walk = set_mm_walk(NULL, true);
 	if (!walk) {
-		success = iterate_mm_list_nowalk(lruvec, max_seq);
+		success = iterate_mm_list_nowalk(lruvec, seq);
 		goto done;
 	}
 
 	walk->lruvec = lruvec;
-	walk->max_seq = max_seq;
+	walk->seq = seq;
 	walk->can_swap = can_swap;
 	walk->force_scan = force_scan;
 
@@ -3880,7 +3882,7 @@ static bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long max_seq,
 	} while (mm);
 done:
 	if (success) {
-		success = inc_max_seq(lruvec, max_seq, can_swap, force_scan);
+		success = inc_max_seq(lruvec, seq, can_swap, force_scan);
 		WARN_ON_ONCE(!success);
 	}
 
-- 
2.43.0.687.g38aa6559b0-goog


