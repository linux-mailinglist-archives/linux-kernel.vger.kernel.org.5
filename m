Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A8679E114
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 09:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbjIMHqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 03:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238656AbjIMHqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 03:46:17 -0400
Received: from mail-ot1-x34a.google.com (mail-ot1-x34a.google.com [IPv6:2607:f8b0:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58710198A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 00:46:13 -0700 (PDT)
Received: by mail-ot1-x34a.google.com with SMTP id 46e09a7af769-6bb31a92b44so7225743a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 00:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694591172; x=1695195972; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JvedlnHbJ7Xvblewl93Q0+oTKItg5cpjvq/m6HrJuqg=;
        b=lacPXZCnYV6/vIWpFg9hxB8CDWi++lVyp1GJRBJD7ynepGQzJJLgZ/P4iE7jAnj3c2
         rcnLLrZPckBR4yJx0/4oh11GKMCeMlsZwhCTC4ZIO2fmq8nWawi69xaMdjOxz5ShqKgf
         s7l8PntkrI+Tadeu7k1PypmIZGHj7vIuhHGesSGhGqE+B2iDX3kNJ0Z359mSeNX/U5yv
         vW/5eQ+wAzPLh5kYoHQh8r+ukLPm607mrph4wyEtAB56RIH3DN/03uIciRvAS+lukCvI
         5Kfdjx1nmh6hH/9g43gV1BHj98Ic8ze5i4iujvxgDY0j8i10SCA/stwn3XRAevDtwJtH
         QcJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694591172; x=1695195972;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JvedlnHbJ7Xvblewl93Q0+oTKItg5cpjvq/m6HrJuqg=;
        b=f5fuUxahPl5a4NukO56UeOxasus6QkRAUU10687p2mSLnGbZq52sdwUyt1F67gy+2b
         TjTk8jWxa5DThGC6Ou7ykampR5YKmZQB2Y5/OuiZ41RjPf8xe+IsGa0R57iyx7f2T/Hs
         etjMfioMYHv1oxJ3XKQkFTVai4DgXu5U8hRP4mSCuikZUo9XVIFwQtlOMUogsuGqnFq6
         hzO5VsCSj23esou+VsWHpMcz4DHpLh2tDMT/XF7rGm5zTJtZ5PLh2dJDPt7r5McYOVzP
         TZ0empkQRE/QFLKQzVo8zsaKu0lmwS5b4loHjno/eB5IKxoKXkaUDyWuH60WwEJRigzB
         OUXA==
X-Gm-Message-State: AOJu0Yw6yIzVt/2FKte27UldUvuCGTKDPpkB9jjEWT3Q7oQfAE8y9TTS
        SLm/7Fg3AT0uiwcf1W65Gle7SktlKs/hlCva
X-Google-Smtp-Source: AGHT+IHlBNs2Mx/ZSSb+5tjW06WVFGJiIVkb2ZqOrPE3dU6m0k0diTK/q/q6GD3+gQB+u8r6mi7KeG2OWdyZrcyi
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a25:d393:0:b0:d7e:dff4:b0fe with SMTP
 id e141-20020a25d393000000b00d7edff4b0femr32185ybf.7.1694590732515; Wed, 13
 Sep 2023 00:38:52 -0700 (PDT)
Date:   Wed, 13 Sep 2023 07:38:44 +0000
In-Reply-To: <20230913073846.1528938-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230913073846.1528938-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230913073846.1528938-2-yosryahmed@google.com>
Subject: [PATCH 1/3] mm: memcg: change flush_next_time to flush_last_time
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

flush_next_time is an inaccurate name. It's not the next time that
periodic flushing will happen, it's rather the next time that
ratelimited flushing can happen if the periodic flusher is late.

Simplify its semantics by just storing the timestamp of the last flush
instead, flush_last_time. Move the 2*FLUSH_TIME addition to
mem_cgroup_flush_stats_ratelimited(), and add a comment explaining it.
This way, all the ratelimiting semantics live in one place.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/memcontrol.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b29b850cf399..35a9c013d755 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -590,7 +590,7 @@ static DECLARE_DEFERRABLE_WORK(stats_flush_dwork, flush_memcg_stats_dwork);
 static DEFINE_PER_CPU(unsigned int, stats_updates);
 static atomic_t stats_flush_ongoing = ATOMIC_INIT(0);
 static atomic_t stats_flush_threshold = ATOMIC_INIT(0);
-static u64 flush_next_time;
+static u64 flush_last_time;
 
 #define FLUSH_TIME (2UL*HZ)
 
@@ -650,7 +650,7 @@ static void do_flush_stats(void)
 	    atomic_xchg(&stats_flush_ongoing, 1))
 		return;
 
-	WRITE_ONCE(flush_next_time, jiffies_64 + 2*FLUSH_TIME);
+	WRITE_ONCE(flush_last_time, jiffies_64);
 
 	cgroup_rstat_flush(root_mem_cgroup->css.cgroup);
 
@@ -666,7 +666,8 @@ void mem_cgroup_flush_stats(void)
 
 void mem_cgroup_flush_stats_ratelimited(void)
 {
-	if (time_after64(jiffies_64, READ_ONCE(flush_next_time)))
+	/* Only flush if the periodic flusher is one full cycle late */
+	if (time_after64(jiffies_64, READ_ONCE(flush_last_time) + 2*FLUSH_TIME))
 		mem_cgroup_flush_stats();
 }
 
-- 
2.42.0.283.g2d96d420d3-goog

