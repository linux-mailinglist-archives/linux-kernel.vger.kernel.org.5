Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22A8785E32
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 19:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237658AbjHWRJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 13:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbjHWRJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 13:09:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175A4E6D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 10:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692810540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=8sTbMz14k9fn/ExbIVdisfNfCHWADPUBFFdEs+jLdGM=;
        b=f4tQQDwiy4fdsBtFHlns0vJN3VgVC08MNP4iThEQ0EpogqfurV5VDEz3yxFzIEOGw+LaQK
        fafx0H7lAp/SOKCef3SWUiYbCd9yEm4WiKuhxBZyg3qOWq9BFVCZiZd3Fy6Wt35vBsV0pA
        0XuofiJugm9MUBug0xRFiA/QjcMN4AU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-287-djt6bob_MHOEI1CXcjRl4A-1; Wed, 23 Aug 2023 13:08:54 -0400
X-MC-Unique: djt6bob_MHOEI1CXcjRl4A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 28C92856DED;
        Wed, 23 Aug 2023 17:08:54 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.210])
        by smtp.corp.redhat.com (Postfix) with SMTP id 28FA8140E962;
        Wed, 23 Aug 2023 17:08:52 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 23 Aug 2023 19:08:08 +0200 (CEST)
Date:   Wed, 23 Aug 2023 19:08:06 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] document while_each_thread(), change first_tid() to use
 for_each_thread()
Message-ID: <20230823170806.GA11724@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the comment to explain that while_each_thread(g,t) is not rcu-safe
unless g is stable (e.g. current). Even if g is a group leader and thus
can't exit before t, t or another sub-thread can exec and remove g from
the thread_group list.

The only lockless user of while_each_thread() is first_tid() and it is
fine in that it can't loop forever, yet for_each_thread() looks better
and I am going to change while_each_thread/next_thread.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 fs/proc/base.c               | 5 ++---
 include/linux/sched/signal.h | 4 ++++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 9df3f4839662..69dbb03ad55b 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3813,11 +3813,10 @@ static struct task_struct *first_tid(struct pid *pid, int tid, loff_t f_pos,
 	/* If we haven't found our starting place yet start
 	 * with the leader and walk nr threads forward.
 	 */
-	pos = task = task->group_leader;
-	do {
+	for_each_thread(task, pos) {
 		if (!nr--)
 			goto found;
-	} while_each_thread(task, pos);
+	};
 fail:
 	pos = NULL;
 	goto out;
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 0deebe2ab07d..0014d3adaf84 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -648,6 +648,10 @@ extern void flush_itimer_signals(void);
 
 extern bool current_is_single_threaded(void);
 
+/*
+ * Without tasklist/siglock it is only rcu-safe if g can't exit/exec,
+ * otherwise next_thread(t) will never reach g after list_del_rcu(g).
+ */
 #define while_each_thread(g, t) \
 	while ((t = next_thread(t)) != g)
 
-- 
2.25.1.362.g51ebf55


