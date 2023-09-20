Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B0B7A81F2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235790AbjITMvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbjITMvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:51:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8131583
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 05:51:47 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 427AC21BE1;
        Wed, 20 Sep 2023 12:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695214306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=07u4Q5pAxOrutNCPHuGqm79fyJmvNY+HPmPgd0ex2so=;
        b=FcDpi5m25Ust/F5P9vXeaMt5gXDitqy8owCtcQNUn3gM3H9+LJupun+aE3xkvm4IXdxEh9
        cO064jkZaj6HUD2gaCckqXXLDAOLhZAGU2V7J7UfSvl3CNAwtt6iZIyWdQu3eTciynPnBH
        pMTa6PXNvseArhOrg3ayw1eqIIiC5I8=
Received: from alley.suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        by relay2.suse.de (Postfix) with ESMTP id 95AFB2C142;
        Wed, 20 Sep 2023 12:51:45 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH] printk/nbcon: Add assert that CPU migration is disabled when calling nbcon_context_try_acquire()
Date:   Wed, 20 Sep 2023 14:51:36 +0200
Message-Id: <20230920125136.15504-1-pmladek@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nbcon console is locked when the 'prio' and 'cpu' fields in
console->nbcon_state stay the same. The locking algorithm would
break when the locked context got migrated to another CPU.

Add assert into nbcon_context_try_acquire(). It would warn when
the function is called in a context where the CPU migration
is possible.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
I propose this patch on top of the patchset adding basic support 
for nbcon consoles, see
https://lore.kernel.org/r/20230916192007.608398-1-john.ogness@linutronix.de

Or another way, it is on top of rework/nbcon-base branch in
printk/linux.git tree.
---
kernel/printk/nbcon.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index b96077152f49..2c2e98d61660 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -234,6 +234,19 @@ static void nbcon_seq_try_update(struct nbcon_context *ctxt, u64 new_seq)
 	}
 }
 
+#ifdef CONFIG_PROVE_LOCKING
+static inline void nbcon_assert_cpu_migration_disabled(void)
+{
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_SMP) &&
+		     __lockdep_enabled &&
+		     this_cpu_read(hardirqs_enabled) &&
+		     preempt_count() == 0 &&
+		     !current->migration_disabled);
+}
+#else
+#define nbcon_assert_cpu_migration(void) {}
+#endif
+
 /**
  * nbcon_context_try_acquire_direct - Try to acquire directly
  * @ctxt:	The context of the caller
@@ -579,6 +592,8 @@ static bool nbcon_context_try_acquire(struct nbcon_context *ctxt)
 	struct nbcon_state cur;
 	int err;
 
+	nbcon_assert_cpu_migration_disabled();
+
 	nbcon_state_read(con, &cur);
 try_again:
 	err = nbcon_context_try_acquire_direct(ctxt, &cur);
-- 
2.35.3

