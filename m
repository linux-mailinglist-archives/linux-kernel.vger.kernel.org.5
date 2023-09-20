Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8B17A8C38
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjITTDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjITTDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:03:18 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D631EA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 12:03:08 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-690d8fb3b7eso109320b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 12:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695236588; x=1695841388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DHOkw8Z/lNeirjsVQWHKGHEmHDrpMBtO7DHMUSjWf4M=;
        b=UPaRRKZwY+hj/oE4Xcjnf+Bj2qnAre/roHBLcISkPc12jmPnYuDOSjtcu7qkQXYL1F
         eP555GMtU8GgWqpR7pcZJwIetiuVB5WCYxI1le2V4gcfDsNuqEcvYHKTddCIJyI8Dp6C
         X7bhvWTk12ZN+BTDl0fa6TQ2E2ywnRLo0U6wDn6LVQBTVimM+f7amCBVWSwmRWSOg0pT
         Ne4G8ANfLeXVNszEBSXJdVh1i3ttXMBAhz9stUgo9N0zTZ4XJe65Hn5wf/mUS5HF7EPP
         RTSLcHiX40GRH9u4nmartmIyU+n/lWoZgtN2f8YJhAgM2IXVbDtbednvxOLKIwsKp9wX
         Piow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695236588; x=1695841388;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DHOkw8Z/lNeirjsVQWHKGHEmHDrpMBtO7DHMUSjWf4M=;
        b=g9YMadu3SM6p0RPlJD+y7U+4k9bW7AmBVl3zrr+JI85X+0MzFlTwkpFgCRFYJXsCDg
         Kdsf94JAIAG2ng09d07pcfV7CaokXh8Nxu0Eey61hs8D2WdcJDqNsB9B8W8l2dfP06Ln
         dlwcQCJYF9sZiqlCSVdRkaAwyVXhI1ZuLdHN9S1IHTH6IfAh3svoghfKyxvMbJJNgiae
         osV6yBrlqS9TM0xG52vpCHWyNBvYjkLAp9l4o6yKKg0sVZigjdfH4VqpFGTHen4TN8ng
         jhZolmOFq/yFX22iUyZN3yQ/P9KewTxSncILnNKGMx3nayb2yvYCjijaesNItyH5hBmo
         /jlQ==
X-Gm-Message-State: AOJu0YzKzvPpwiR1SdL+dAkTjxwKcx64z3xBkmRGdqELx+cYI52qw7wU
        8Vcb/XvBno0CwoQ1jrrDkoU=
X-Google-Smtp-Source: AGHT+IELrwFtAaNAZSj3RuUKBX/6bRnBeBoGpeeG0jWHkgt6ISLm+F8uT2D8srjZchaOyGv6pWaVgg==
X-Received: by 2002:a05:6a20:8e1f:b0:137:23a2:2b3c with SMTP id y31-20020a056a208e1f00b0013723a22b3cmr3637857pzj.49.1695236587894;
        Wed, 20 Sep 2023 12:03:07 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([124.127.145.18])
        by smtp.gmail.com with ESMTPSA id m5-20020aa78a05000000b006871fdde2c7sm423935pfa.110.2023.09.20.12.03.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 20 Sep 2023 12:03:07 -0700 (PDT)
From:   Kairui Song <ryncsn@gmail.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>, Nhat Pham <nphamcs@gmail.com>,
        Yuanchu Xie <yuanchu@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "T . J . Mercier" <tjmercier@google.com>,
        linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
Subject: [RFC PATCH v3 2/6] workingset: move refault distance checking into to a helper
Date:   Thu, 21 Sep 2023 03:02:40 +0800
Message-ID: <20230920190244.16839-3-ryncsn@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920190244.16839-1-ryncsn@gmail.com>
References: <20230920190244.16839-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kairui Song <kasong@tencent.com>

There isn't any feature change, just move the refault distance checking
logic into a standalone helper so it can be reused later.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/workingset.c | 137 ++++++++++++++++++++++++++++--------------------
 1 file changed, 79 insertions(+), 58 deletions(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index 8613945fc66e..b0704cbfc667 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -170,9 +170,10 @@
  */
 
 #define WORKINGSET_SHIFT 1
-#define EVICTION_SHIFT	((BITS_PER_LONG - BITS_PER_XA_VALUE) +	\
+#define EVICTION_SHIFT	((BITS_PER_LONG - BITS_PER_XA_VALUE) + \
 			 WORKINGSET_SHIFT + NODES_SHIFT + \
 			 MEM_CGROUP_ID_SHIFT)
+#define EVICTION_BITS	(BITS_PER_LONG - (EVICTION_SHIFT))
 #define EVICTION_MASK	(~0UL >> EVICTION_SHIFT)
 
 /*
@@ -216,6 +217,79 @@ static void unpack_shadow(void *shadow, int *memcgidp, pg_data_t **pgdat,
 	*workingsetp = workingset;
 }
 
+/*
+ * Get the refault distance timestamp reading at eviction time.
+ */
+static inline unsigned long lru_eviction(struct lruvec *lruvec,
+					 int bits, int bucket_order)
+{
+	unsigned long eviction = atomic_long_read(&lruvec->nonresident_age);
+
+	eviction >>= bucket_order;
+	eviction &= ~0UL >> (BITS_PER_LONG - bits);
+
+	return eviction;
+}
+
+/*
+ * Calculate and test refault distance.
+ */
+static inline bool lru_test_refault(struct mem_cgroup *memcg,
+				    struct lruvec *lruvec,
+				    unsigned long eviction, bool file,
+				    int bits, int bucket_order)
+{
+	unsigned long refault, distance;
+	unsigned long active, inactive_file, inactive_anon;
+
+	eviction <<= bucket_order;
+	refault = atomic_long_read(&lruvec->nonresident_age);
+
+	/*
+	 * The unsigned subtraction here gives an accurate distance
+	 * across nonresident_age overflows in most cases. There is a
+	 * special case: usually, shadow entries have a short lifetime
+	 * and are either refaulted or reclaimed along with the inode
+	 * before they get too old.  But it is not impossible for the
+	 * nonresident_age to lap a shadow entry in the field, which
+	 * can then result in a false small refault distance, leading
+	 * to a false activation should this old entry actually
+	 * refault again.  However, earlier kernels used to deactivate
+	 * unconditionally with *every* reclaim invocation for the
+	 * longest time, so the occasional inappropriate activation
+	 * leading to pressure on the active list is not a problem.
+	 */
+	distance = (refault - eviction) & (~0UL >> (BITS_PER_LONG - bits));
+
+	/*
+	 * Compare the distance to the existing workingset size. We
+	 * don't activate pages that couldn't stay resident even if
+	 * all the memory was available to the workingset. Whether
+	 * workingset competition needs to consider anon or not depends
+	 * on having free swap space.
+	 */
+	active = lruvec_page_state(lruvec, NR_ACTIVE_FILE);
+	inactive_file = lruvec_page_state(lruvec, NR_INACTIVE_FILE);
+
+	if (mem_cgroup_get_nr_swap_pages(memcg) > 0) {
+		active += lruvec_page_state(lruvec, NR_ACTIVE_ANON);
+		inactive_anon = lruvec_page_state(lruvec, NR_INACTIVE_ANON);
+	} else {
+		inactive_anon = 0;
+	}
+
+	/*
+	 * When there are already enough active pages, be less aggressive
+	 * on reactivating pages, challenge an large set of established
+	 * active pages with one time refaulted page may not be a good idea.
+	 */
+	if (active >= inactive_anon + inactive_file)
+		return distance < inactive_anon + inactive_file;
+	else
+		return distance < active + \
+			(file ? inactive_anon : inactive_file);
+}
+
 #ifdef CONFIG_LRU_GEN
 
 static void *lru_gen_eviction(struct folio *folio)
@@ -386,11 +460,10 @@ void *workingset_eviction(struct folio *folio, struct mem_cgroup *target_memcg)
 	lruvec = mem_cgroup_lruvec(target_memcg, pgdat);
 	/* XXX: target_memcg can be NULL, go through lruvec */
 	memcgid = mem_cgroup_id(lruvec_memcg(lruvec));
-	eviction = atomic_long_read(&lruvec->nonresident_age);
-	eviction >>= bucket_order;
+	eviction = lru_eviction(lruvec, EVICTION_BITS, bucket_order);
 	workingset_age_nonresident(lruvec, folio_nr_pages(folio));
 	return pack_shadow(memcgid, pgdat, eviction,
-				folio_test_workingset(folio));
+			   folio_test_workingset(folio));
 }
 
 /**
@@ -408,11 +481,6 @@ bool workingset_test_recent(void *shadow, bool file, bool *workingset)
 {
 	struct mem_cgroup *eviction_memcg;
 	struct lruvec *eviction_lruvec;
-	unsigned long refault_distance;
-	unsigned long inactive_file;
-	unsigned long inactive_anon;
-	unsigned long refault;
-	unsigned long active;
 	int memcgid;
 	struct pglist_data *pgdat;
 	unsigned long eviction;
@@ -421,7 +489,6 @@ bool workingset_test_recent(void *shadow, bool file, bool *workingset)
 		return lru_gen_test_recent(shadow, file, &eviction_lruvec, &eviction, workingset);
 
 	unpack_shadow(shadow, &memcgid, &pgdat, &eviction, workingset);
-	eviction <<= bucket_order;
 
 	/*
 	 * Look up the memcg associated with the stored ID. It might
@@ -442,56 +509,10 @@ bool workingset_test_recent(void *shadow, bool file, bool *workingset)
 	eviction_memcg = mem_cgroup_from_id(memcgid);
 	if (!mem_cgroup_disabled() && !eviction_memcg)
 		return false;
-
 	eviction_lruvec = mem_cgroup_lruvec(eviction_memcg, pgdat);
-	refault = atomic_long_read(&eviction_lruvec->nonresident_age);
 
-	/*
-	 * Calculate the refault distance
-	 *
-	 * The unsigned subtraction here gives an accurate distance
-	 * across nonresident_age overflows in most cases. There is a
-	 * special case: usually, shadow entries have a short lifetime
-	 * and are either refaulted or reclaimed along with the inode
-	 * before they get too old.  But it is not impossible for the
-	 * nonresident_age to lap a shadow entry in the field, which
-	 * can then result in a false small refault distance, leading
-	 * to a false activation should this old entry actually
-	 * refault again.  However, earlier kernels used to deactivate
-	 * unconditionally with *every* reclaim invocation for the
-	 * longest time, so the occasional inappropriate activation
-	 * leading to pressure on the active list is not a problem.
-	 */
-	refault_distance = (refault - eviction) & EVICTION_MASK;
-
-	/*
-	 * Compare the distance to the existing workingset size. We
-	 * don't activate pages that couldn't stay resident even if
-	 * all the memory was available to the workingset. Whether
-	 * workingset competition needs to consider anon or not depends
-	 * on having free swap space.
-	 */
-	active = lruvec_page_state(eviction_lruvec, NR_ACTIVE_FILE);
-	inactive_file = lruvec_page_state(eviction_lruvec, NR_INACTIVE_FILE);
-
-	if (mem_cgroup_get_nr_swap_pages(eviction_memcg) > 0) {
-		active += lruvec_page_state(eviction_lruvec,
-						     NR_ACTIVE_ANON);
-		inactive_anon = lruvec_page_state(eviction_lruvec,
-						  NR_INACTIVE_ANON);
-	} else {
-		inactive_anon = 0;
-	}
-
-	/*
-	 * When there are already enough active pages, be less aggressive
-	 * on reactivating pages, challenge an large set of established
-	 * active pages with one time refaulted page may not be a good idea.
-	 */
-	if (active >= inactive_anon + inactive_file)
-		return refault_distance < inactive_anon + inactive_file;
-	else
-		return refault_distance < active + (file ? inactive_anon : inactive_file);
+	return lru_test_refault(eviction_memcg, eviction_lruvec, eviction,
+				file, EVICTION_BITS, bucket_order);
 }
 
 /**
-- 
2.41.0

