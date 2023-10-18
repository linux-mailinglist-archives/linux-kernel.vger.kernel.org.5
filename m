Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA697CE821
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 21:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbjJRTtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 15:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbjJRTtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 15:49:39 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F288012C;
        Wed, 18 Oct 2023 12:49:00 -0700 (PDT)
Received: from smtp.gmail.com (1.general.jsalisbury.us.vpn [10.172.66.188])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 402FA4166C;
        Wed, 18 Oct 2023 19:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1697658538;
        bh=4pmQNv5cuKJdx4r3/SYwWbuS5xEyX4GGjTdNfRldRoE=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=V00gxXgqAOphSWpCadBNGWsMCNJ7MQ9x52GYK0yS2GcjAQ6s/7taWRQ+63q2fZc6k
         fs6rlyCmHxNT8FO5ASDUdWf3iDoQGU2veeNh+ZHnuf3vNfePDtG8Wp8c6oGdfqipP/
         bLFDgEPu6NUOE6RSDK1IW2Z+WtjkdYHlJgKljkL7/uzMVroGeG81jOaxNqHnpDMz+x
         M6AmVbS7jrKKJDmYuI+EfJovx8WKEz7IRgnGxvn6DfzJK1tl05IJ7a8kW5r6qHpkgB
         2FPHNONrJB3AlX6VpUQ5j32xivi3juCk/vufQCS1YAX0A/DvRDSkqQshtgJ1QyjZni
         9WXo0BifQMY0Q==
From:   Joseph Salisbury <joseph.salisbury@canonical.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>,
        Joseph Salisbury <joseph.salisbury@canonical.com>
Cc:     syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH RT 10/12] posix-timers: Ensure timer ID search-loop limit is valid
Date:   Wed, 18 Oct 2023 15:48:31 -0400
Message-Id: <20231018194833.651674-11-joseph.salisbury@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018194833.651674-1-joseph.salisbury@canonical.com>
References: <20231018194833.651674-1-joseph.salisbury@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

v5.15.133-rt70-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


posix_timer_add() tries to allocate a posix timer ID by starting from the
cached ID which was stored by the last successful allocation.

This is done in a loop searching the ID space for a free slot one by
one. The loop has to terminate when the search wrapped around to the
starting point.

But that's racy vs. establishing the starting point. That is read out
lockless, which leads to the following problem:

CPU0	  	      	     	   CPU1
posix_timer_add()
  start = sig->posix_timer_id;
  lock(hash_lock);
  ...				   posix_timer_add()
  if (++sig->posix_timer_id < 0)
      			             start = sig->posix_timer_id;
     sig->posix_timer_id = 0;

So CPU1 can observe a negative start value, i.e. -1, and the loop break
never happens because the condition can never be true:

  if (sig->posix_timer_id == start)
     break;

While this is unlikely to ever turn into an endless loop as the ID space is
huge (INT_MAX), the racy read of the start value caught the attention of
KCSAN and Dmitry unearthed that incorrectness.

Rewrite it so that all id operations are under the hash lock.

Reported-by: syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/87bkhzdn6g.ffs@tglx

(cherry picked from commit 8ce8849dd1e78dadcee0ec9acbd259d239b7069f)
Signed-off-by: Joseph Salisbury <joseph.salisbury@canonical.com>
---
 include/linux/sched/signal.h |  2 +-
 kernel/time/posix-timers.c   | 31 ++++++++++++++++++-------------
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 5f0e8403e8ce..9743f7d173a0 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -125,7 +125,7 @@ struct signal_struct {
 #ifdef CONFIG_POSIX_TIMERS
 
 	/* POSIX.1b Interval Timers */
-	int			posix_timer_id;
+	unsigned int		next_posix_timer_id;
 	struct list_head	posix_timers;
 
 	/* ITIMER_REAL timer for the process */
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index ed3c4a954398..2d6cf93ca370 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -140,25 +140,30 @@ static struct k_itimer *posix_timer_by_id(timer_t id)
 static int posix_timer_add(struct k_itimer *timer)
 {
 	struct signal_struct *sig = current->signal;
-	int first_free_id = sig->posix_timer_id;
 	struct hlist_head *head;
-	int ret = -ENOENT;
+	unsigned int cnt, id;
 
-	do {
+	/*
+	 * FIXME: Replace this by a per signal struct xarray once there is
+	 * a plan to handle the resulting CRIU regression gracefully.
+	 */
+	for (cnt = 0; cnt <= INT_MAX; cnt++) {
 		spin_lock(&hash_lock);
-		head = &posix_timers_hashtable[hash(sig, sig->posix_timer_id)];
-		if (!__posix_timers_find(head, sig, sig->posix_timer_id)) {
+		id = sig->next_posix_timer_id;
+
+		/* Write the next ID back. Clamp it to the positive space */
+		sig->next_posix_timer_id = (id + 1) & INT_MAX;
+
+		head = &posix_timers_hashtable[hash(sig, id)];
+		if (!__posix_timers_find(head, sig, id)) {
 			hlist_add_head_rcu(&timer->t_hash, head);
-			ret = sig->posix_timer_id;
+			spin_unlock(&hash_lock);
+			return id;
 		}
-		if (++sig->posix_timer_id < 0)
-			sig->posix_timer_id = 0;
-		if ((sig->posix_timer_id == first_free_id) && (ret == -ENOENT))
-			/* Loop over all possible ids completed */
-			ret = -EAGAIN;
 		spin_unlock(&hash_lock);
-	} while (ret == -ENOENT);
-	return ret;
+	}
+	/* POSIX return code when no timer ID could be allocated */
+	return -EAGAIN;
 }
 
 static inline void unlock_timer(struct k_itimer *timr, unsigned long flags)
-- 
2.34.1

