Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA1C78BB90
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 01:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbjH1XeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 19:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbjH1Xda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 19:33:30 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831D112D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 16:33:28 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-68bff8f3351so4636139b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 16:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693265608; x=1693870408;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cdnModp3UHPesHrMiYbasA77T6X4L8s34myJUUsNDqw=;
        b=BaJDLeW20NuEFec2oAO68NEPY8XNBrqkpeisxk5dZbxgnWHQ0r2PhoENHFifb29a85
         wkcQ36f5pboCfp5upZdXeouVQ/0c7EuGiOlftOTQ7QED4HRVXJaE8f3Wet7A9n2Rj856
         vSFPpwUufWhdTYEK9e0YxtG9T7V5niVLg1OGtXwve+hU15y1awhfiS+ph4sxssMScLfY
         3FyWbOnA+EFg7ZsT4U1Ke97tXPWCjqO0X2CsZjdqw14iDY0ncsKKN+1F4C/05uDjI0Yu
         Vcck/XfFVgXP+e2uByfABv9Rt2GwqKStdZUxd2y8AJciGF9zoxxWBpNJ74POirqQMS0t
         +/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693265608; x=1693870408;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cdnModp3UHPesHrMiYbasA77T6X4L8s34myJUUsNDqw=;
        b=N64/T2/8SUcXug2XYejTh2N4gHN/dKOA7vOiRQq27kO8Ey4B9FC9FITvSTfHCZeTCV
         cVtbPbpU7dvolgxUbOnNhQB58iAwjvOnmkBuZUAnYffWr2102puWLz21744AfKKCyJX1
         oNfeJbAIWbreISQ6hbXDyGLMF3QdksEsIuLg8D7cbIlE6ogSvdlU555JwOS5d/2pVUFt
         5XyNnQl7S+OsMsg6P6I3wJifvV8gcnYo6VlMPEym2UXA2/hv4rEebCIsWUjN1vJz2u8M
         b6PFiw7cfO8gS9vd4OEHU/xVZIurQcpA3mnV3Gq3jwUm8o16kEed+psGRgdS85OWqsE3
         PKsA==
X-Gm-Message-State: AOJu0YxaqVb6hZa5akJOv/om3dk2FCIsFzISkRvJMMt2Z+j0vGD/jkAl
        AMNy4QHCiY6Nu8aKZbCdea8J1CBWkQZDRFGZ
X-Google-Smtp-Source: AGHT+IHAq4VgXKo8P6aYPET0HHb7Rp2LuZeLVocuW54MrcmyDai0zFV6jlRJW28aJMih5PpmlindTt5puuPdOpLx
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a05:6a00:13a7:b0:68a:5467:9974 with
 SMTP id t39-20020a056a0013a700b0068a54679974mr8979137pfg.0.1693265607909;
 Mon, 28 Aug 2023 16:33:27 -0700 (PDT)
Date:   Mon, 28 Aug 2023 23:33:17 +0000
In-Reply-To: <20230828233319.340712-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230828233319.340712-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <20230828233319.340712-4-yosryahmed@google.com>
Subject: [PATCH v2 3/4] mm: memcg: let non-unified root stats flushes help
 unified flushes
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unified flushing of memcg stats keeps track of the magnitude of pending
updates, and only allows a flush if that magnitude exceeds a threshold.
It also keeps track of the time at which ratelimited flushing should be
allowed as flush_next_time.

A non-unified flush on the root memcg has the same effect as a unified
flush, so let it help unified flushing by resetting pending updates and
kicking flush_next_time forward. Move the logic into the common
do_stats_flush() helper, and do it for all root flushes, unified or
not.

There is a subtle change here, we reset stats_flush_threshold before a
flush rather than after a flush. This probably okay because:

(a) For flushers: only unified flushers check stats_flush_threshold, and
those flushers skip anyway if there is another unified flush ongoing.
Having them also skip if there is an ongoing non-unified root flush is
actually more consistent.

(b) For updaters: Resetting stats_flush_threshold early may lead to more
atomic updates of stats_flush_threshold, as we start updating it
earlier. This should not be significant in practice because we stop
updating stats_flush_threshold when it reaches the threshold anyway. If
we start early and stop early, the number of atomic updates remain the
same. The only difference is the scenario where we reset
stats_flush_threshold early, start doing atomic updates early, and then
the periodic flusher kicks in before we reach the threshold. In this
case, we will have done more atomic updates. However, since the
threshold wasn't reached, then we did not do a lot of updates anyway.

Suggested-by: Michal Koutn=C3=BD <mkoutny@suse.com>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/memcontrol.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 90f08b35fa77..f3716478bf4e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -647,6 +647,11 @@ static inline void memcg_rstat_updated(struct mem_cgro=
up *memcg, int val)
  */
 static void do_stats_flush(struct mem_cgroup *memcg)
 {
+	/* for unified flushing, root non-unified flushing can help as well */
+	if (mem_cgroup_is_root(memcg)) {
+		WRITE_ONCE(flush_next_time, jiffies_64 + 2*FLUSH_TIME);
+		atomic_set(&stats_flush_threshold, 0);
+	}
 	cgroup_rstat_flush(memcg->css.cgroup);
 }
=20
@@ -665,11 +670,7 @@ static void do_unified_stats_flush(void)
 	    atomic_xchg(&stats_flush_ongoing, 1))
 		return;
=20
-	WRITE_ONCE(flush_next_time, jiffies_64 + 2*FLUSH_TIME);
-
 	do_stats_flush(root_mem_cgroup);
-
-	atomic_set(&stats_flush_threshold, 0);
 	atomic_set(&stats_flush_ongoing, 0);
 }
=20
--=20
2.42.0.rc2.253.gd59a3bf2b4-goog

