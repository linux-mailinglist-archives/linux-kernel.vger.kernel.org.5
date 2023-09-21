Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C787A9E8E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjIUUDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjIUUCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:02:40 -0400
Received: from mail-ot1-x349.google.com (mail-ot1-x349.google.com [IPv6:2607:f8b0:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF5E51023
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:15:31 -0700 (PDT)
Received: by mail-ot1-x349.google.com with SMTP id 46e09a7af769-6c49f8a445aso766342a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695316530; x=1695921330; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ap3WQf9RL9Y6q/AtYDIGLhJT98YcDdn8KWtOOFcbuqo=;
        b=C5y0XD+vi7QSz3yEnCzQjmt4g2pWnWb2cYXwIERC1F7l7KRclYhu/pPpGBk2BXmmvf
         nqXkvWTtpMJsjuYoh8JpRQecU29VIqVTEUzLjghan1J7X5LNyI8iQEeLSs6htPmCzoCb
         Y/dVOs14pEjSDrUkGE33jaNVsPq0l9YFasadR0mKn8zhfTft379+rCeXkr2U90vPzkQQ
         96fkv79aEOp/lUebsKcrlJYT9JwQS1g/ccT1Cg+PVxMANVXTJhTQJAZL/wpjIj2als1M
         106b6nuPDS8ZxuF68Qt2oFMQyZmDaAp2Skumqy8POABdgfoh+J4hh21gK2yGRlKHbae3
         SrsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316530; x=1695921330;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ap3WQf9RL9Y6q/AtYDIGLhJT98YcDdn8KWtOOFcbuqo=;
        b=W1KNwPFk//yB/ySbKvBREyUyGQ8bMbbhDrJVnVcn24ycNvy0SeFcnrzcn9pvePp7SR
         fz/65JmmdfsuljLJm4JiIhkbwozF2vLVHTK6h8+55o0iz6t+lhD7UJJ61BvUomPbB6wz
         Z0yRQrbQ0V42cIQDFM52NuuhVeD5sLtlqv4dlA7O4Stn2sa5+uBUv65fbMXBcACLNG7t
         73VUB8vDRlMVrTU6vbmjMQ/N5chW5Ri+C8UC5OlqGA2gs6Qcsl2peS7e1qbbAE3n7LEJ
         GYyI1a0xWfrIPYKTe8F6BE9nzLmnZoMo8m+JV/gXFqnF1KbbcxQlkZYJZOFKA8uBVrLQ
         DQEA==
X-Gm-Message-State: AOJu0YxnXk3+PlRgjWT83vBgdd5W5nBFzlL2ZXLwdlQ0enXEkXV0Op2P
        h9O87++9/vaV0jLMxj7FGe4P36IzZlJByl2Y
X-Google-Smtp-Source: AGHT+IEctDDQF0RHmq3JRn62J6oQCd8whI4eyWsA+THF8MJIpkdXC4/+HB3bqA3JcJDKn3Dhk9UKpKL30JXlgF3v
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a25:504d:0:b0:d62:7f3f:621d with SMTP
 id e74-20020a25504d000000b00d627f3f621dmr75596ybb.11.1695283868835; Thu, 21
 Sep 2023 01:11:08 -0700 (PDT)
Date:   Thu, 21 Sep 2023 08:10:56 +0000
In-Reply-To: <20230921081057.3440885-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230921081057.3440885-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230921081057.3440885-5-yosryahmed@google.com>
Subject: [PATCH 4/5] mm: workingset: move the stats flush into workingset_test_recent()
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
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
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
---
 mm/workingset.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index b192e44a0e7c..79b338996088 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -425,8 +425,15 @@ bool workingset_test_recent(void *shadow, bool file, bool *workingset)
 	struct pglist_data *pgdat;
 	unsigned long eviction;
 
-	if (lru_gen_enabled())
-		return lru_gen_test_recent(shadow, file, &eviction_lruvec, &eviction, workingset);
+	rcu_read_lock();
+
+	if (lru_gen_enabled()) {
+		bool recent = lru_gen_test_recent(shadow, file,
+						  &eviction_lruvec, &eviction,
+						  workingset);
+		rcu_read_unlock();
+		return recent;
+	}
 
 	unpack_shadow(shadow, &memcgid, &pgdat, &eviction, workingset);
 	eviction <<= bucket_order;
@@ -451,6 +458,12 @@ bool workingset_test_recent(void *shadow, bool file, bool *workingset)
 	if (!mem_cgroup_disabled() && !eviction_memcg)
 		return false;
 
+	css_get(&eviction_memcg->css);
+	rcu_read_unlock();
+
+	/* Flush stats (and potentially sleep) outside the RCU read section */
+	mem_cgroup_flush_stats_ratelimited();
+
 	eviction_lruvec = mem_cgroup_lruvec(eviction_memcg, pgdat);
 	refault = atomic_long_read(&eviction_lruvec->nonresident_age);
 
@@ -493,6 +506,7 @@ bool workingset_test_recent(void *shadow, bool file, bool *workingset)
 		}
 	}
 
+	mem_cgroup_put(eviction_memcg);
 	return refault_distance <= workingset_size;
 }
 
@@ -519,19 +533,16 @@ void workingset_refault(struct folio *folio, void *shadow)
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
@@ -540,7 +551,7 @@ void workingset_refault(struct folio *folio, void *shadow)
 	mod_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + file, nr);
 
 	if (!workingset_test_recent(shadow, file, &workingset))
-		goto out;
+		return;
 
 	folio_set_active(folio);
 	workingset_age_nonresident(lruvec, nr);
@@ -556,8 +567,6 @@ void workingset_refault(struct folio *folio, void *shadow)
 		lru_note_cost_refault(folio);
 		mod_lruvec_state(lruvec, WORKINGSET_RESTORE_BASE + file, nr);
 	}
-out:
-	rcu_read_unlock();
 }
 
 /**
-- 
2.42.0.459.ge4e396fd5e-goog

