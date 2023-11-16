Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E3A7ED954
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 03:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344535AbjKPCYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 21:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344511AbjKPCYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 21:24:25 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95371A1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 18:24:21 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7b9e83b70so2727857b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 18:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700101461; x=1700706261; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hOK1UyBshtkV5dW8DFB6ZrNswsHIuDTjDTN/Td8b6tw=;
        b=BtLeQoZOY6gplEYKT8GsxkS/HMmtbYqTAqkTPUYtN4ZZ8qc9kZEcRwXXcGXjMr7iiw
         K65RwDcE8mVY9CIrbDPkNAQxw5dlRLOpy36Zv8LhW/sx1ZIyngRWETOlBm9teHKMorXj
         IpJP+dVuFRm+E8bs9a6LcSQhietVMOlvvFh/DgIbEniCY0oGCwX5b0Z3ndjqdnQJIWjm
         paGm4VfQnc9OAsIzE85KCRMpHGFN/JqEOlPE8SxIiogKfOcjg12J3WClyqAOZXIFn2ag
         rPVUXRKjT1wX2l9MtP5nU4IRcQ245oqZtSU5CnPTln8IDy7BbWByTyAczWdNvP8U8SzD
         NWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700101461; x=1700706261;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hOK1UyBshtkV5dW8DFB6ZrNswsHIuDTjDTN/Td8b6tw=;
        b=DH7GSjQLDDW3LoJ/rVYLiW9oT9cZUt8ltn+1hob3e4sw6l1YEOIH4As/qPJ1I8Y4lO
         30JLFljnvNMhNPrSyyX5KOnoI06Vp8BGuKhX/AstDFcim/xRi8cZkYuXzLX4hkhRRcEH
         s4JkYwuFpBz3OHec2EhBeXn9pm0f+iUQ/en6B9k8Y01H0PhldWY5iY/aJHf6WQjkIoN+
         QPReB2jx9Cr9jq05JeOVHVua9v7hBsXvpZnFfgPKkf+BH7/NKTtrang01YhbAy8CysxH
         Ol5GipblWrFo+kfTtpw6axVk8NkmSTsjmVSxtKYIPWz2asaDQes8sAEwdGIeNSYksNCT
         laHA==
X-Gm-Message-State: AOJu0Yyl2HHso/1IoUAFb6IITA/XciGmzPq/0UaTcIinpWBZ3ljo8fyQ
        osI75BcHw0vKqqfkko1hxKWPjGuhlbJ8tvYY
X-Google-Smtp-Source: AGHT+IEQtgXmf9iSCqMERLu3YFDRxYLIfFN9r8bkSUo7k+VLrtBcNBEUIUl5/rQbpV2uMfGCYzqdDt8J6V5tLAR0
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a0d:d716:0:b0:5ae:75db:92c5 with SMTP
 id z22-20020a0dd716000000b005ae75db92c5mr12091ywd.2.1700101461069; Wed, 15
 Nov 2023 18:24:21 -0800 (PST)
Date:   Thu, 16 Nov 2023 02:24:09 +0000
In-Reply-To: <20231116022411.2250072-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20231116022411.2250072-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231116022411.2250072-5-yosryahmed@google.com>
Subject: [PATCH v3 4/5] mm: workingset: move the stats flush into workingset_test_recent()
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
index b192e44a0e7cc..a573be6c59fd9 100644
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
2.43.0.rc0.421.g78406f8d94-goog

