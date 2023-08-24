Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A487C7871AA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 16:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241714AbjHXOd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 10:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241689AbjHXOdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:33:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA2C19A2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 07:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692887556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dsOC4rI50hliPoJPpoEGUZrHCXo+EFetwI6VyN7asjY=;
        b=Eluo/8UdbH2yDhildmvNl7uQNO3l9hsP2mhtADqb9cKdHb7H0lMHeYZWIGn80ktFz16mrw
        MZkfFM584MspRbyE+hKqTeaeNJYgnVS+oN6VdTipDF4H4pqHjPaOL8V9Pz85Ub8TpFgOem
        9PPmLkJPqG6WEEDrjB3Xs/dXpXAlSyg=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-475-HN5FZ4ihN3mjj4wADRLsDw-1; Thu, 24 Aug 2023 10:32:32 -0400
X-MC-Unique: HN5FZ4ihN3mjj4wADRLsDw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B2A923C1350E;
        Thu, 24 Aug 2023 14:32:31 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.43])
        by smtp.corp.redhat.com (Postfix) with SMTP id 44C011121315;
        Thu, 24 Aug 2023 14:32:30 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 24 Aug 2023 16:31:45 +0200 (CEST)
Date:   Thu, 24 Aug 2023 16:31:42 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        peterz@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] introduce __next_thread(), fix next_tid() vs exec() race
Message-ID: <20230824143142.GA31222@redhat.com>
References: <20230824143112.GA31208@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824143112.GA31208@redhat.com>
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

next_tid(start) does:

	rcu_read_lock();
	if (pid_alive(start)) {
		pos = next_thread(start);
		if (thread_group_leader(pos))
			pos = NULL;
		else
			get_task_struct(pos);

it should return pos = NULL when next_thread() wraps to the 1st thread
in the thread group, group leader, and the thread_group_leader() check
tries to detect this case.

But this can race with exec. To simplify, suppose we have a main thread
M and a single sub-thread T, next_tid(T) should return NULL.

Now suppose that T execs. If next_tid(T) is called after T changes the
leadership and before it does release_task() which removes the old leader
from list, then next_thread() returns M and thread_group_leader(M) = F.

Lockless use of next_thread() should be avoided. After this change only
task_group_seq_get_next() does this, and I believe it should be changed
as well.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 fs/proc/base.c               |  6 ++----
 include/linux/sched/signal.h | 11 +++++++++++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 69dbb03ad55b..b9fb36cd5e9c 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3838,10 +3838,8 @@ static struct task_struct *next_tid(struct task_struct *start)
 	struct task_struct *pos = NULL;
 	rcu_read_lock();
 	if (pid_alive(start)) {
-		pos = next_thread(start);
-		if (thread_group_leader(pos))
-			pos = NULL;
-		else
+		pos = __next_thread(start);
+		if (pos)
 			get_task_struct(pos);
 	}
 	rcu_read_unlock();
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 0014d3adaf84..7fb34b8cda54 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -715,6 +715,17 @@ bool same_thread_group(struct task_struct *p1, struct task_struct *p2)
 	return p1->signal == p2->signal;
 }
 
+/*
+ * returns NULL if p is the last thread in the thread group
+ */
+static inline struct task_struct *__next_thread(struct task_struct *p)
+{
+	return list_next_or_null_rcu(&p->signal->thread_head,
+					&p->thread_node,
+					struct task_struct,
+					thread_node);
+}
+
 static inline struct task_struct *next_thread(const struct task_struct *p)
 {
 	return list_entry_rcu(p->thread_group.next,
-- 
2.25.1.362.g51ebf55


