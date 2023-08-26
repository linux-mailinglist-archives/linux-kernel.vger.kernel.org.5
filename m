Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9701378963A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 13:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbjHZLQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 07:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbjHZLPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 07:15:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F849A6
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 04:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693048499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=xVqgls1rrijrR9dI1/nUCwe6XOmqKkfqcvgn3qYjyx8=;
        b=XI0hDax6pymvBQjqjSF6JOSx0utuQFqcy7iigd2qzfkwrzzzyy+g0DOU/ButgM0LhPzL4D
        cgwM4ECmWdiUnvS6BFfSkbv8DS7aGsh6gc9bYxELzfChSZDt5YDHWAg0uUXQVXpG1k6G1B
        AuxqNyfsSNbN9EZ01NnW371RrpYZRe4=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-qxsdwTZ7Oc2OMcFBLgKEkw-1; Sat, 26 Aug 2023 07:14:57 -0400
X-MC-Unique: qxsdwTZ7Oc2OMcFBLgKEkw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 57EF41C04B5E;
        Sat, 26 Aug 2023 11:14:57 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1BBFD1121319;
        Sat, 26 Aug 2023 11:14:55 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Sat, 26 Aug 2023 13:14:10 +0200 (CEST)
Date:   Sat, 26 Aug 2023 13:14:09 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] kill task_struct->thread_group
Message-ID: <20230826111409.GA23243@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230826111200.GA22982@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last user was removed by the previous patch.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 include/linux/sched.h | 1 -
 init/init_task.c      | 1 -
 kernel/exit.c         | 1 -
 kernel/fork.c         | 3 ---
 4 files changed, 6 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 609bde814cb0..2b012d446cad 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -997,7 +997,6 @@ struct task_struct {
 	/* PID/PID hash table linkage. */
 	struct pid			*thread_pid;
 	struct hlist_node		pid_links[PIDTYPE_MAX];
-	struct list_head		thread_group;
 	struct list_head		thread_node;
 
 	struct completion		*vfork_done;
diff --git a/init/init_task.c b/init/init_task.c
index ff6c4b9bfe6b..c0de0200fd56 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -132,7 +132,6 @@ struct task_struct init_task
 	.pi_lock	= __RAW_SPIN_LOCK_UNLOCKED(init_task.pi_lock),
 	.timer_slack_ns = 50000, /* 50 usec default slack */
 	.thread_pid	= &init_struct_pid,
-	.thread_group	= LIST_HEAD_INIT(init_task.thread_group),
 	.thread_node	= LIST_HEAD_INIT(init_signals.thread_head),
 #ifdef CONFIG_AUDIT
 	.loginuid	= INVALID_UID,
diff --git a/kernel/exit.c b/kernel/exit.c
index edb50b4c9972..f3ba4b97a7d9 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -133,7 +133,6 @@ static void __unhash_process(struct task_struct *p, bool group_dead)
 		list_del_init(&p->sibling);
 		__this_cpu_dec(process_counts);
 	}
-	list_del_rcu(&p->thread_group);
 	list_del_rcu(&p->thread_node);
 }
 
diff --git a/kernel/fork.c b/kernel/fork.c
index d2e12b6d2b18..3cd6913a90ef 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2579,7 +2579,6 @@ __latent_entropy struct task_struct *copy_process(
 	p->dirty_paused_when = 0;
 
 	p->pdeath_signal = 0;
-	INIT_LIST_HEAD(&p->thread_group);
 	p->task_works = NULL;
 	clear_posix_cputimers_work(p);
 
@@ -2707,8 +2706,6 @@ __latent_entropy struct task_struct *copy_process(
 			atomic_inc(&current->signal->live);
 			refcount_inc(&current->signal->sigcnt);
 			task_join_group_stop(p);
-			list_add_tail_rcu(&p->thread_group,
-					  &p->group_leader->thread_group);
 			list_add_tail_rcu(&p->thread_node,
 					  &p->signal->thread_head);
 		}
-- 
2.25.1.362.g51ebf55

