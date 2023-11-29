Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60EB7FCD70
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 04:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376870AbjK2DWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 22:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234807AbjK2DWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 22:22:05 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B871F19BC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 19:22:08 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d1b431fa7bso20791357b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 19:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701228128; x=1701832928; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GMYQlWUldBV9LWasymxz6cRCo6mSsi6IzDXKk+8BatU=;
        b=AZ/yirB/44st1c2ZHKBLXqzRbxEasy3KBBPGJALG7aHWkTWAW6SJwB49v+Nkz4U5m5
         8IIjgEvQfBPuM34E2f2eiEXoluDlyAzXsDwmwHq2lCpCN78fr/FdAMJKvjGV6o4VJSbM
         5dWuikSJx6swS7wEYfibZKtD3ymHsxK9YSOHGDo5qJWc6w8vyt/6Z3oW+RxU5JmU8NxG
         CrDWIZBk/vGYtRDZtO/3Kq9P+jZZ2iHbWCRNkOrgtDCc+TpnPP4EF4AvzRUg29AvLIIX
         kj1kBSMiSqYAlhE1ELnbhhLRirFG9jf9GMpRNbRcwkZq14LL3tXudmR6QEyqNVdkri3o
         Mpfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701228128; x=1701832928;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GMYQlWUldBV9LWasymxz6cRCo6mSsi6IzDXKk+8BatU=;
        b=JVeNKMAaTkK83AnoUwoefzfbaw9Y6bvGhVGOqXo8OBXNchOmM0ncPxJR6LgUSy/fsT
         OD5tRUdDNVmJfUFyEIJOG/2Y9iyhzvInMYkn17v0jCShFBYieVpcSRITC5KhYrEi44gr
         i5SHQJjhjzFCOlohOnXyqPgUCHDj1lKataTKJeIvN3lIzyjqb82PJZBdLa9eGhmj4a6Z
         /pxX66UQMA8UrYwLs4j3NnWmEXrWDoR93tAvGxB4qgvckdUqF+0Oi9V6hgwAI7iShVc9
         w4wlCwoi2w/WukubylRxRsag/i6x72ZnZpvApIyHvl/T8+JssdcvMA62p1l067rQN/+u
         daRQ==
X-Gm-Message-State: AOJu0YzrxNzQFMWOs3PkFgLrZzX2XcnGhVSdPjDAj8aSkpvUSFPDFxtM
        M+Q17kWbJ0wWktYCt2Ciu3RlQ6nH1kFHiRMB
X-Google-Smtp-Source: AGHT+IF6lUJvoUePL6awLPUorDhmrelziQ66K/nBRxKZkO4u8ApkLFgb5tzVr7krTn6SjMgmlcBKg7J4Ix+mgnzs
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:690c:f84:b0:5ca:ad72:2d78 with SMTP
 id df4-20020a05690c0f8400b005caad722d78mr634136ywb.8.1701228128017; Tue, 28
 Nov 2023 19:22:08 -0800 (PST)
Date:   Wed, 29 Nov 2023 03:21:52 +0000
In-Reply-To: <20231129032154.3710765-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20231129032154.3710765-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231129032154.3710765-5-yosryahmed@google.com>
Subject: [mm-unstable v4 4/5] mm: workingset: move the stats flush into workingset_test_recent()
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The workingset code flushes the stats in workingset_refault() to get
accurate stats of the eviction memcg. In preparation for more scoped
flushed and passing the eviction memcg to the flush call, move the call
to workingset_test_recent() where we have a pointer to the eviction
memcg.

The flush call is sleepable, and cannot be made in an rcu read section.
Hence, minimize the rcu read section by also moving it into
workingset_test_recent(). Furthermore, instead of holding the rcu read
lock throughout workingset_test_recent(), only hold it briefly to get a
ref on the eviction memcg. This allows us to make the flush call after
we get the eviction memcg.

As for workingset_refault(), nothing else there appears to be protected
by rcu. The memcg of the faulted folio (which is not necessarily the
same as the eviction memcg) is protected by the folio lock, which is
held from all callsites. Add a VM_BUG_ON() to make sure this doesn't
change from under us.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Tested-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
---
 mm/workingset.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index c17d45c6f29b0..dce41577a49d2 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -425,8 +425,16 @@ bool workingset_test_recent(void *shadow, bool file, bool *workingset)
 	struct pglist_data *pgdat;
 	unsigned long eviction;
 
-	if (lru_gen_enabled())
-		return lru_gen_test_recent(shadow, file, &eviction_lruvec, &eviction, workingset);
+	rcu_read_lock();
+
+	if (lru_gen_enabled()) {
+		bool recent = lru_gen_test_recent(shadow, file,
+				&eviction_lruvec, &eviction, workingset);
+
+		rcu_read_unlock();
+		return recent;
+	}
+
 
 	unpack_shadow(shadow, &memcgid, &pgdat, &eviction, workingset);
 	eviction <<= bucket_order;
@@ -448,8 +456,16 @@ bool workingset_test_recent(void *shadow, bool file, bool *workingset)
 	 * configurations instead.
 	 */
 	eviction_memcg = mem_cgroup_from_id(memcgid);
-	if (!mem_cgroup_disabled() && !eviction_memcg)
+	if (!mem_cgroup_disabled() &&
+	    (!eviction_memcg || !mem_cgroup_tryget(eviction_memcg))) {
+		rcu_read_unlock();
 		return false;
+	}
+
+	rcu_read_unlock();
+
+	/* Flush stats (and potentially sleep) outside the RCU read section */
+	mem_cgroup_flush_stats_ratelimited();
 
 	eviction_lruvec = mem_cgroup_lruvec(eviction_memcg, pgdat);
 	refault = atomic_long_read(&eviction_lruvec->nonresident_age);
@@ -493,6 +509,7 @@ bool workingset_test_recent(void *shadow, bool file, bool *workingset)
 		}
 	}
 
+	mem_cgroup_put(eviction_memcg);
 	return refault_distance <= workingset_size;
 }
 
@@ -519,19 +536,16 @@ void workingset_refault(struct folio *folio, void *shadow)
 		return;
 	}
 
-	/* Flush stats (and potentially sleep) before holding RCU read lock */
-	mem_cgroup_flush_stats_ratelimited();
-
-	rcu_read_lock();
-
 	/*
 	 * The activation decision for this folio is made at the level
 	 * where the eviction occurred, as that is where the LRU order
 	 * during folio reclaim is being determined.
 	 *
 	 * However, the cgroup that will own the folio is the one that
-	 * is actually experiencing the refault event.
+	 * is actually experiencing the refault event. Make sure the folio is
+	 * locked to guarantee folio_memcg() stability throughout.
 	 */
+	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	nr = folio_nr_pages(folio);
 	memcg = folio_memcg(folio);
 	pgdat = folio_pgdat(folio);
@@ -540,7 +554,7 @@ void workingset_refault(struct folio *folio, void *shadow)
 	mod_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + file, nr);
 
 	if (!workingset_test_recent(shadow, file, &workingset))
-		goto out;
+		return;
 
 	folio_set_active(folio);
 	workingset_age_nonresident(lruvec, nr);
@@ -556,8 +570,6 @@ void workingset_refault(struct folio *folio, void *shadow)
 		lru_note_cost_refault(folio);
 		mod_lruvec_state(lruvec, WORKINGSET_RESTORE_BASE + file, nr);
 	}
-out:
-	rcu_read_unlock();
 }
 
 /**
-- 
2.43.0.rc1.413.gea7ed67945-goog

