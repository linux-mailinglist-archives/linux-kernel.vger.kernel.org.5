Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D636E77FC39
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 18:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353688AbjHQQjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 12:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353701AbjHQQip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:38:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F48E2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 09:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692290279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=1tfx1R3/Udl4zZfQafPn1bbHLrkQF1hlwhkrlHQ6ihA=;
        b=Rwgufl6Z1IJvyQ7tcXWqYqUZ9NcG/Iaztgkj78/Kq6QKGR7eEsnTMj205rndIyh7aifQCv
        TZoY1bbN9ngbPVb+fQTwqPUMKlK13HLyKzhc3JD0LRUpc7R0BZAkgc+JEr4OoIaxe/T/Np
        Z0A5DI8B9iMrSbw7Z/vJMJHg3vpjWmc=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-681-8QPQOt-_OIuuCpJe-AGeXQ-1; Thu, 17 Aug 2023 12:37:56 -0400
X-MC-Unique: 8QPQOt-_OIuuCpJe-AGeXQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B4E529ABA1D;
        Thu, 17 Aug 2023 16:37:55 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.39])
        by smtp.corp.redhat.com (Postfix) with SMTP id A6E3B2166B2D;
        Thu, 17 Aug 2023 16:37:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 17 Aug 2023 18:37:11 +0200 (CEST)
Date:   Thu, 17 Aug 2023 18:37:08 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kill do_each_thread()
Message-ID: <20230817163708.GA8248@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric has pointed out that we still have 3 users of do_each_thread().
Change them to use for_each_process_thread() and kill this helper.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 arch/ia64/kernel/mca.c       | 4 ++--
 drivers/tty/tty_io.c         | 4 ++--
 fs/fs_struct.c               | 4 ++--
 include/linux/sched/signal.h | 7 -------
 4 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/ia64/kernel/mca.c b/arch/ia64/kernel/mca.c
index 92ede80d17fe..2671688d349a 100644
--- a/arch/ia64/kernel/mca.c
+++ b/arch/ia64/kernel/mca.c
@@ -1630,10 +1630,10 @@ default_monarch_init_process(struct notifier_block *self, unsigned long val, voi
 	}
 	printk("\n\n");
 	if (read_trylock(&tasklist_lock)) {
-		do_each_thread (g, t) {
+		for_each_process_thread(g, t) {
 			printk("\nBacktrace of pid %d (%s)\n", t->pid, t->comm);
 			show_stack(t, NULL, KERN_DEFAULT);
-		} while_each_thread (g, t);
+		}
 		read_unlock(&tasklist_lock);
 	}
 	/* FIXME: This will not restore zapped printk locks. */
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 63db04b9113a..27d8e3a1aace 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3031,7 +3031,7 @@ void __do_SAK(struct tty_struct *tty)
 	} while_each_pid_task(session, PIDTYPE_SID, p);
 
 	/* Now kill any processes that happen to have the tty open */
-	do_each_thread(g, p) {
+	for_each_process_thread(g, p) {
 		if (p->signal->tty == tty) {
 			tty_notice(tty, "SAK: killed process %d (%s): by controlling tty\n",
 				   task_pid_nr(p), p->comm);
@@ -3048,7 +3048,7 @@ void __do_SAK(struct tty_struct *tty)
 					PIDTYPE_SID);
 		}
 		task_unlock(p);
-	} while_each_thread(g, p);
+	}
 	read_unlock(&tasklist_lock);
 	put_pid(session);
 }
diff --git a/fs/fs_struct.c b/fs/fs_struct.c
index 04b3f5b9c629..64c2d0814ed6 100644
--- a/fs/fs_struct.c
+++ b/fs/fs_struct.c
@@ -62,7 +62,7 @@ void chroot_fs_refs(const struct path *old_root, const struct path *new_root)
 	int count = 0;
 
 	read_lock(&tasklist_lock);
-	do_each_thread(g, p) {
+	for_each_process_thread(g, p) {
 		task_lock(p);
 		fs = p->fs;
 		if (fs) {
@@ -79,7 +79,7 @@ void chroot_fs_refs(const struct path *old_root, const struct path *new_root)
 			spin_unlock(&fs->lock);
 		}
 		task_unlock(p);
-	} while_each_thread(g, p);
+	}
 	read_unlock(&tasklist_lock);
 	while (count--)
 		path_put(old_root);
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 669e8cff40c7..0deebe2ab07d 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -648,13 +648,6 @@ extern void flush_itimer_signals(void);
 
 extern bool current_is_single_threaded(void);
 
-/*
- * Careful: do_each_thread/while_each_thread is a double loop so
- *          'break' will not work as expected - use goto instead.
- */
-#define do_each_thread(g, t) \
-	for (g = t = &init_task ; (g = t = next_task(g)) != &init_task ; ) do
-
 #define while_each_thread(g, t) \
 	while ((t = next_thread(t)) != g)
 
-- 
2.25.1.362.g51ebf55


