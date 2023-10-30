Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E21B7DBD38
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 16:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbjJ3P7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 11:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbjJ3P7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 11:59:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0255DF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 08:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698681495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=wOaUyTLUS0taBhz/WyCO0smnj0qbDFqjI3pF8ZVyn2U=;
        b=i59xOgDq7BMsuqMtx1DvOGe3QOCdZETwsPZPjVFnz1Q30TQ0NgZx0p2pTckjRiGFiKVhQg
        FwPZhM1rFPVD8eNQSYBmkwMJOW7nCB6tPhrIcNJkSR+xxWHm2j4VwCdoi65G8hGRhePGn0
        trvO0I9HA+6jGg0zPOfGnRzzl+DoQ0M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-QVZ95d_wODyJWmZnRTy1ag-1; Mon, 30 Oct 2023 11:58:13 -0400
X-MC-Unique: QVZ95d_wODyJWmZnRTy1ag-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 840E4185A788;
        Mon, 30 Oct 2023 15:58:13 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.219])
        by smtp.corp.redhat.com (Postfix) with SMTP id 61A921C060AE;
        Mon, 30 Oct 2023 15:58:12 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 30 Oct 2023 16:57:12 +0100 (CET)
Date:   Mon, 30 Oct 2023 16:57:10 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] introduce for_other_threads(p, t)
Message-ID: <20231030155710.GA9095@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cosmetic, but imho it makes the usage look more clear and simple, the
new helper doesn't require to initialize "t".

After this change while_each_thread() has only 3 users, and it is only
used in the do/while loops.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 fs/exec.c                    |  3 +--
 include/linux/sched/signal.h |  3 +++
 kernel/signal.c              | 11 ++++-------
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 6518e33ea813..e5bdce5e36ee 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1580,11 +1580,10 @@ static void check_unsafe_exec(struct linux_binprm *bprm)
 	 * will be able to manipulate the current directory, etc.
 	 * It would be nice to force an unshare instead...
 	 */
-	t = p;
 	n_fs = 1;
 	spin_lock(&p->fs->lock);
 	rcu_read_lock();
-	while_each_thread(p, t) {
+	for_other_threads(p, t) {
 		if (t->fs == p->fs)
 			n_fs++;
 	}
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index d7fa3ca2fa53..134a2c0bc283 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -655,6 +655,9 @@ extern bool current_is_single_threaded(void);
 #define while_each_thread(g, t) \
 	while ((t = next_thread(t)) != g)
 
+#define for_other_threads(p, t)	\
+	for (t = p; (t = next_thread(t)) != p; )
+
 #define __for_each_thread(signal, t)	\
 	list_for_each_entry_rcu(t, &(signal)->thread_head, thread_node)
 
diff --git a/kernel/signal.c b/kernel/signal.c
index ccfc3ded5672..f5781a54d89d 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1376,12 +1376,12 @@ int force_sig_info(struct kernel_siginfo *info)
  */
 int zap_other_threads(struct task_struct *p)
 {
-	struct task_struct *t = p;
+	struct task_struct *t;
 	int count = 0;
 
 	p->signal->group_stop_count = 0;
 
-	while_each_thread(p, t) {
+	for_other_threads(p, t) {
 		task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
 		/* Don't require de_thread to wait for the vhost_worker */
 		if ((t->flags & (PF_IO_WORKER | PF_USER_WORKER)) != PF_USER_WORKER)
@@ -2457,12 +2457,10 @@ static bool do_signal_stop(int signr)
 			sig->group_exit_code = signr;
 
 		sig->group_stop_count = 0;
-
 		if (task_set_jobctl_pending(current, signr | gstop))
 			sig->group_stop_count++;
 
-		t = current;
-		while_each_thread(current, t) {
+		for_other_threads(current, t) {
 			/*
 			 * Setting state to TASK_STOPPED for a group
 			 * stop is always done with the siglock held,
@@ -2958,8 +2956,7 @@ static void retarget_shared_pending(struct task_struct *tsk, sigset_t *which)
 	if (sigisemptyset(&retarget))
 		return;
 
-	t = tsk;
-	while_each_thread(tsk, t) {
+	for_other_threads(tsk, t) {
 		if (t->flags & PF_EXITING)
 			continue;
 
-- 
2.25.1.362.g51ebf55


