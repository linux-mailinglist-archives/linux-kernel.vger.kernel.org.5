Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A3E75A748
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjGTHIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjGTHIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:08:31 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8A12681
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:08:30 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-563396c1299so385072a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689836910; x=1692428910;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P4XNYMJYgxf4Y2ysW943aMZDD9DgQegnQSW9aAxie4w=;
        b=PyMiTiRslPlYxeAzNGyf+s2RMn2Y5D+io4F49/M2XRwJrS8TwV/LhLqLj0BM+kLdbs
         SJdh95igG91J+W+YW3QhUBoovRNlfDdy0rtENHO9Q0tdlMq6Mi6nZDp8wPmseQG3GEz7
         yTNtdLVRNpjOoL79dp3VDPbMRHNV99200JwxoCivq9oH22XjolvYivx1g2ceZNC2Pn7s
         Da/CFyreh5mYpyR/lWRRdvMG1hkWdPWRhELE3hNZjAEKxkN7vhsHgeLNCSqpeMvOeAHq
         lRZ2ErdDGOl8n4urJ5Mk+4WBu+P+b25Mk8sxetPQU+cK2DCaPQPxX5kv/nJSdD/CPPwf
         W7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689836910; x=1692428910;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P4XNYMJYgxf4Y2ysW943aMZDD9DgQegnQSW9aAxie4w=;
        b=D+x9Ttgf66GMzNraB1oKm0s+5HHbQiMS3S5v1q/h68SHLqhKP76fPiVOij5ia9+47k
         GaFHOMH3ePsFs1IURfOdTYpkYR7o36HUeB79w1pk8OU85coUGOy/nYuQknzhP/LxIJ82
         u3vSSU/Z0E2SyTv7GtuOIZ351YdACFL3y4iEU43Hw/7Gd25HN/OEm5dx7MNtQCJ4KtN3
         TI/ae9DnzcaND4HDATLTVIT/VPpjv1QeAVXm7V88OUFWIrhhgEJK8WozXucND4lxGYCQ
         nEy6nK0WVBRICPbAYJBvkz2VH6OdLvYPjwJOW9Sw/MUoRpKdlfDDe9FG+ZihJsI8mXgs
         SfLA==
X-Gm-Message-State: ABy/qLYkgWSyZSUlW5W+VRyV9L2M3N3W8Hm9bjYyqT2LavrdslHbHjBj
        S42cv8T9kykYPwsUsENlkbT84b0Vku846GD9
X-Google-Smtp-Source: APBJJlEGR67b7I5wM02HN8lsWXpPeepUUbVvmNMwkaq7frNphjV2zKpBSorV/PgnNk3Mo7NS/0jW1PWGUeUjmfjP
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a63:3e8f:0:b0:563:3b08:f869 with SMTP
 id l137-20020a633e8f000000b005633b08f869mr22818pga.2.1689836909753; Thu, 20
 Jul 2023 00:08:29 -0700 (PDT)
Date:   Thu, 20 Jul 2023 07:08:18 +0000
In-Reply-To: <20230720070825.992023-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230720070825.992023-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230720070825.992023-2-yosryahmed@google.com>
Subject: [RFC PATCH 1/8] memcg: refactor updating memcg->moving_account
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>
Cc:     Muchun Song <muchun.song@linux.dev>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Yu Zhao <yuzhao@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "T.J. Mercier" <tjmercier@google.com>,
        Greg Thelen <gthelen@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memcg->moving_account is used to signal that a memcg move is taking
place, so that folio_memcg_lock() would start acquiring the per-memcg
move lock instead of just initiating an rcu read section.

Refactor incrementing and decrementing memcg->moving_account, together
with rcu synchornization and the elaborate comment into helpers, to
allow for reuse by incoming patches.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/memcontrol.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e8ca4bdcb03c..ffdb848f4003 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6305,16 +6305,26 @@ static const struct mm_walk_ops charge_walk_ops = {
 	.pmd_entry	= mem_cgroup_move_charge_pte_range,
 };
 
-static void mem_cgroup_move_charge(void)
+static void mem_cgroup_start_move_charge(struct mem_cgroup *memcg)
 {
-	lru_add_drain_all();
 	/*
 	 * Signal folio_memcg_lock() to take the memcg's move_lock
 	 * while we're moving its pages to another memcg. Then wait
 	 * for already started RCU-only updates to finish.
 	 */
-	atomic_inc(&mc.from->moving_account);
+	atomic_inc(&memcg->moving_account);
 	synchronize_rcu();
+}
+
+static void mem_cgroup_end_move_charge(struct mem_cgroup *memcg)
+{
+	atomic_dec(&memcg->moving_account);
+}
+
+static void mem_cgroup_move_charge(void)
+{
+	lru_add_drain_all();
+	mem_cgroup_start_move_charge(mc.from);
 retry:
 	if (unlikely(!mmap_read_trylock(mc.mm))) {
 		/*
@@ -6334,7 +6344,7 @@ static void mem_cgroup_move_charge(void)
 	 */
 	walk_page_range(mc.mm, 0, ULONG_MAX, &charge_walk_ops, NULL);
 	mmap_read_unlock(mc.mm);
-	atomic_dec(&mc.from->moving_account);
+	mem_cgroup_end_move_charge(mc.from);
 }
 
 static void mem_cgroup_move_task(void)
-- 
2.41.0.255.g8b1d071c50-goog

