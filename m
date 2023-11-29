Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF857FCD69
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 04:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376813AbjK2DV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 22:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376781AbjK2DV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 22:21:57 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F139170B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 19:22:03 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5cef61289fdso62231557b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 19:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701228122; x=1701832922; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fp/riADQZ1JFvdRujo1i1RQ8s//WQnrX4uDVuQ0rm8w=;
        b=sCdK98qgWhoJR3PGUUZRPS/hHV8LDZgsKmwDVzRPz3X+n0GVx6P7nB1IKmDXqs+xQT
         MQILFBRjJLTYuP+aGxavV9ic8GAChQdJdyffjaJc5HsyLTg3CsNY2eLlFQhHaYASI/ok
         T1lk+4CpefOD0ovHv65nHLt1YL0G2lBcqblVQ3GsNpgKyk2EzbhO2zAMcYPi81zH4X+e
         roFsoITbpKfSUsjXl8W8i0nL44kbdW1zRZdDrXQLBH/H6ejcC6MMVUuTZGsg1zhdkvPQ
         mleuzex/LXPKuNgFova6wbjk+qxPYzf3PiUAc7wHpHyO3H0OGMdEKPyFpiokfo4LNMVe
         CGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701228122; x=1701832922;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fp/riADQZ1JFvdRujo1i1RQ8s//WQnrX4uDVuQ0rm8w=;
        b=IkOfiXNos63Zcb9+IoiFEjmwAwHeNfrtrBXbvNSD60e7gdW+fMiaIktXy4ZwyDq/7S
         EB51m99fksnhlWTjAG6eS60bdj0Dbsl3fPRNdVmY4Ww2QXVko1ZGNk25dCQ8JC/29Z1x
         DGw1Nuc6SF40V4hH3TGJSCXbWzFRqPFFYcBwxc7+MWu/DmAJqqHpWGi0nO4zwHvZHsir
         IcWxkFXcBSiltIkYkPJedLe7GWoBK2cQFkQeBuakdxSL7arczw3kV4ewuhUKYAkuZpGI
         n7oUswescmLcMZF+wZguOdV0N6uVnrJ19AxTHN5F4tQ6nF3PSAKKExacotjZMUZyrH/b
         pf7Q==
X-Gm-Message-State: AOJu0YxH+rDedEB4JetsDKPFyvb+RiLWz1FQ4GnenHfblUlvDxW7kUN7
        i+EAgjNvIp2DFIp8UVYk/H5oXrm62kh/aU50
X-Google-Smtp-Source: AGHT+IF7CgJpm4ll7+nN91xVmCbgACzK5L5zzJqDfVPl2iyh6TzmkcueFovPIrPdqybEYEo2dnecWek0ZhORplj8
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:690c:989:b0:59b:ca80:919a with SMTP
 id ce9-20020a05690c098900b0059bca80919amr510184ywb.0.1701228122771; Tue, 28
 Nov 2023 19:22:02 -0800 (PST)
Date:   Wed, 29 Nov 2023 03:21:49 +0000
In-Reply-To: <20231129032154.3710765-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20231129032154.3710765-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231129032154.3710765-2-yosryahmed@google.com>
Subject: [mm-unstable v4 1/5] mm: memcg: change flush_next_time to flush_last_time
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
        linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>,
        Chris Li <chrisl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Tested-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Chris Li <chrisl@kernel.org> (Google)
---
 mm/memcontrol.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f88c8fd036897..61435bd037cb4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -593,7 +593,7 @@ static DECLARE_DEFERRABLE_WORK(stats_flush_dwork, flush_memcg_stats_dwork);
 static DEFINE_PER_CPU(unsigned int, stats_updates);
 static atomic_t stats_flush_ongoing = ATOMIC_INIT(0);
 static atomic_t stats_flush_threshold = ATOMIC_INIT(0);
-static u64 flush_next_time;
+static u64 flush_last_time;
 
 #define FLUSH_TIME (2UL*HZ)
 
@@ -653,7 +653,7 @@ static void do_flush_stats(void)
 	    atomic_xchg(&stats_flush_ongoing, 1))
 		return;
 
-	WRITE_ONCE(flush_next_time, jiffies_64 + 2*FLUSH_TIME);
+	WRITE_ONCE(flush_last_time, jiffies_64);
 
 	cgroup_rstat_flush(root_mem_cgroup->css.cgroup);
 
@@ -669,7 +669,8 @@ void mem_cgroup_flush_stats(void)
 
 void mem_cgroup_flush_stats_ratelimited(void)
 {
-	if (time_after64(jiffies_64, READ_ONCE(flush_next_time)))
+	/* Only flush if the periodic flusher is one full cycle late */
+	if (time_after64(jiffies_64, READ_ONCE(flush_last_time) + 2*FLUSH_TIME))
 		mem_cgroup_flush_stats();
 }
 
-- 
2.43.0.rc1.413.gea7ed67945-goog

