Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E69A7ED94E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 03:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344522AbjKPCY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 21:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjKPCYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 21:24:19 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD3C1A5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 18:24:16 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9ab79816a9so401617276.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 18:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700101456; x=1700706256; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BcE9vJD0hOv2TBpe3ivca8OUmRQ1FOEoUuzJXTFrwQU=;
        b=xe5MtW0wJjFy8d59ZlUsqx91/pLiIvBH1MJeyaAasPiwtQqJCd6jwX49qQ1h70vghI
         3WCKs5vPHO9p3WE74yGqXixldwo7ea3GX2j/zYG63t8sgV4D8TCM41oN1ILr5opRDq05
         A2r2XGny+xev5ka+WgAXc4fyD4cCDVXkRzly3bMvHTmaQWfKTxOMRWbWoBZAbmeljHrK
         tsGAx4oLV/mEj0u5BGWis4ET1stjBpfvgpUIxFqm5JdjEe+d+glwpLcHgosogA9yVU8/
         bHDwB4H58NI2/8xBxNYoOzjZEkLVLApzAnk2NzeqtC9RpE5oCQom99LKC68s/eVGDwS0
         7JIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700101456; x=1700706256;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BcE9vJD0hOv2TBpe3ivca8OUmRQ1FOEoUuzJXTFrwQU=;
        b=O2DszXs/9K4LGM3IGnTxTluBI+O/Z8AXzFZ3Bb8Qx5ARrz/nr9KfXxVtDZpSDSLV47
         iMI1FEsjLNzEIb5AuXKX+jgWEuW0loGk/Y+ZahUbKJfqaYZnbx2pm36tASjCrM6qAJSy
         fo7nfNAZPXwqCnAlqMjsoOZ3KZXIvGPvhxbQ4ak2bzEUfJWf5+SiFTl8Wb/G5Mf5H4FH
         3gJk+iOg3fguFV31JBilgTqWw44wq2eeeM95vBl2uAMYjYb5YQbSiN/FrCM8EykPRhQ+
         ehgbZjN1j0wfafkzNVpMrzeEQRirhlxu36acdfBV2uCnjqoGOPBawMtYPTFwlqU3e2ey
         HnvQ==
X-Gm-Message-State: AOJu0YyvnZH77kXiymOZzaIyMrgdTFT+aK4cpDSvwc5tfS/VMJO60kxb
        JNOQMKNZwheDLEaNAd2YKvb8Ik8c0LPPVF3R
X-Google-Smtp-Source: AGHT+IFy97x2nQDJgIiWGH9dEF3svZisBvzaosL7zloYt6xMQ4EjhERYd/7GmdSfHzW6U7mYn8R6aavP5vLCYx6D
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:285:b0:d9a:d272:ee58 with SMTP
 id v5-20020a056902028500b00d9ad272ee58mr402081ybh.9.1700101456166; Wed, 15
 Nov 2023 18:24:16 -0800 (PST)
Date:   Thu, 16 Nov 2023 02:24:06 +0000
In-Reply-To: <20231116022411.2250072-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20231116022411.2250072-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231116022411.2250072-2-yosryahmed@google.com>
Subject: [PATCH v3 1/5] mm: memcg: change flush_next_time to flush_last_time
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
---
 mm/memcontrol.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 774bd6e21e278..18931d82f108f 100644
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
2.43.0.rc0.421.g78406f8d94-goog

