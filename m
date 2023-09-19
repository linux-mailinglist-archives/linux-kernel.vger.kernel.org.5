Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D987A6F44
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 01:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbjISXKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 19:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbjISXJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 19:09:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F93123
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 16:09:21 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695164958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oTbjh+BCwK3ch0C9I9rGb2UB8TXtu3KoCP4n1cVIXrU=;
        b=CWBMhviIBeB0aywq9Iy69hMDQxMEDISIoCiLV53lxHkko2TxoIvVObviV3JzALZYuskOuF
        vLup+KdFFXXpr7hN459KkJ29SwtjuHMyrA3BSs7Ujrhd+abfz1H8ytLUEW+eJeFy6awq36
        2ENhovyBKC3vJZR4jV+OPnArx2KmR4sNhdzPBp/bzSrqb6EUEFX7E1fy6JAcJJv1yzxeLc
        A+iqlTdzrdh2m2RlOUFHJJgR68AsOVJpbN1YFDrFAjrkmHPhF2YQSdDMPxIPBZuTUOpH5X
        DjXVN0Jjlht76MiEJGEcYGxW/h7BnLOThqX2RssAMAXnyydqbgMJK2dhSHOkCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695164958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oTbjh+BCwK3ch0C9I9rGb2UB8TXtu3KoCP4n1cVIXrU=;
        b=CPLhIrrfnQOJB1t7QDK40++wEqAcYJmu2Ob8akLI6kcwcYqg0zr74n591slHOpJUudXLZ0
        tBo8+S8PCFkJpEAA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH printk v2 11/11] lockdep: Add atomic write enforcement for lockdep splats
Date:   Wed, 20 Sep 2023 01:14:56 +0206
Message-Id: <20230919230856.661435-12-john.ogness@linutronix.de>
In-Reply-To: <20230919230856.661435-1-john.ogness@linutronix.de>
References: <20230919230856.661435-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Invoke the atomic write enforcement functions for lockdep
splats to ensure that the information gets out to the consoles.

It is important to note that if there are any legacy consoles
registered, they will be attempting to directly print from the
printk-caller context, which may jeopardize the reliability of
the atomic consoles. Optimally there should be no legacy
consoles registered.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/locking/lockdep.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e85b5ad3e206..5310a94e3efd 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -56,6 +56,7 @@
 #include <linux/kprobes.h>
 #include <linux/lockdep.h>
 #include <linux/context_tracking.h>
+#include <linux/console.h>
 
 #include <asm/sections.h>
 
@@ -3967,9 +3968,13 @@ static void
 print_usage_bug(struct task_struct *curr, struct held_lock *this,
 		enum lock_usage_bit prev_bit, enum lock_usage_bit new_bit)
 {
+	enum nbcon_prio prev_prio;
+
 	if (!debug_locks_off() || debug_locks_silent)
 		return;
 
+	prev_prio = nbcon_atomic_enter(NBCON_PRIO_EMERGENCY);
+
 	pr_warn("\n");
 	pr_warn("================================\n");
 	pr_warn("WARNING: inconsistent lock state\n");
@@ -3998,6 +4003,8 @@ print_usage_bug(struct task_struct *curr, struct held_lock *this,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+
+	nbcon_atomic_exit(NBCON_PRIO_EMERGENCY, prev_prio);
 }
 
 /*
-- 
2.39.2

