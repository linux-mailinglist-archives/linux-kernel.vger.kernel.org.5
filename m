Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DAE7CD8B0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 11:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjJRJ4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 05:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjJRJ4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:56:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA77BA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 02:56:51 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CE7651F383;
        Wed, 18 Oct 2023 09:56:46 +0000 (UTC)
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6A7432C16F;
        Wed, 18 Oct 2023 09:56:46 +0000 (UTC)
Date:   Wed, 18 Oct 2023 11:56:45 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 4/4] printk: Ignore waiter on panic
Message-ID: <ZS-r3QnpKzm7UVip@alley>
References: <20231013204340.1112036-1-john.ogness@linutronix.de>
 <20231013204340.1112036-5-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013204340.1112036-5-john.ogness@linutronix.de>
X-Spamd-Bar: +++++++++++++++
Authentication-Results: smtp-out2.suse.de;
        dkim=none;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
        spf=fail (smtp-out2.suse.de: domain of pmladek@suse.com does not designate 149.44.160.134 as permitted sender) smtp.mailfrom=pmladek@suse.com
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [15.00 / 50.00];
         ARC_NA(0.00)[];
         R_SPF_FAIL(1.00)[-all];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         CLAM_VIRUS_FAIL(0.00)[failed to scan and retransmits exceed];
         RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
         RCPT_COUNT_FIVE(0.00)[5];
         DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
         VIOLATED_DIRECT_SPF(3.50)[];
         MX_GOOD(-0.01)[];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MID_RHS_NOT_FQDN(0.50)[];
         R_DKIM_NA(0.20)[];
         RCVD_COUNT_TWO(0.00)[2];
         MIME_TRACE(0.00)[0:+];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 15.00
X-Rspamd-Queue-Id: CE7651F383
X-Spam: Yes
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-10-13 22:49:40, John Ogness wrote:
> Commit d51507098ff91 ("printk: disable optimistic spin during
> panic") added checks to avoid becoming a console waiter if a
> panic is in progress. However, the transition to panic can occur
> while there is already a waiter. If the panic occurred in a
> context that does not support printing from the printk() caller
> context, the waiter CPU may become stopped while still stored as
> @console_waiter.

I guess that "context that does not support printing" is NMI
or printk_safe when the console handling is deferred().

Another scenario is when the current owner gets stopped
or blocked so that it actually can't pass the lock to
the waiter.

> the panic CPU will see @console_waiter and handover to the
> stopped CPU.
> 
> Here a simple example:
> 
> CPU0                                CPU1
> ----                                ----
> console_lock_spinning_enable()
>                                     console_trylock_spinning()
>                                       [set as console waiter]
> NMI: panic()
> panic_other_cpus_shutdown()
>                                     [stopped as console waiter]
> console_flush_on_panic()
>   console_lock_spinning_enable()
>     [print 1 record]
>   console_lock_spinning_disable_and_check()
>     [handover to stopped CPU1]
> 
> This results in panic() not flushing the panic messages.

Great catch!

> Fix this by ignoring any console waiter if the panic CPU is
> printing.
> 
> Fixes: dbdda842fe96 ("printk: Add console owner and waiter logic to load balance console writes")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  kernel/printk/printk.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 56d9b4acbbf2..cd6493f12970 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1904,7 +1904,8 @@ static int console_lock_spinning_disable_and_check(int cookie)
>  	console_owner = NULL;
>  	raw_spin_unlock(&console_owner_lock);
>  
> -	if (!waiter) {
> +	/* Waiters are ignored by the panic CPU. */
> +	if (!waiter || this_cpu_in_panic()) {
>  		spin_release(&console_owner_dep_map, _THIS_IP_);
>  		return 0;
>  	}

This seems to work.

Well, I have spent some time thinking about possible scenarios and I would
go even further. I would block also console_lock_spinning_enable()
Also I would do the checks before taking console_owner_lock.

It would make the behavior symmetric. And more importantly, it would prevent
possible deadlocks caused by console_owner_lock.

See the proposed patch below. I created it to see the changes in the
code. Also I added info about possible scenarios and effects.

Here we go:

From 2b6e2b58df737e3a3e0f86134a53f560539be813 Mon Sep 17 00:00:00 2001
From: Petr Mladek <pmladek@suse.com>
Date: Wed, 18 Oct 2023 10:04:17 +0200
Subject: [PATCH] printk: Disable passing console lock owner completely during
 panic()

The commit d51507098ff91 ("printk: disable optimistic spin during panic")
added checks to avoid becoming a console waiter if a panic is in progress.

However, the transition to panic can occur while there is already waiter.
The current owner should not pass the lock to the waiter because it might
get stopped or blocked anytime.

Also the panic context might pass the console lock owner to an already
stopped waiter by mistake. It might happen when console_flush_on_panic()
ignores the current lock owner, for example:

CPU0                                CPU1
----                                ----
console_lock_spinning_enable()
                                    console_trylock_spinning()
                                      [set as console waiter]
NMI: panic()
panic_other_cpus_shutdown()
                                    [stopped as console waiter]
console_flush_on_panic()
  console_lock_spinning_enable()
    [print 1 record]
  console_lock_spinning_disable_and_check()
    [handover to stopped CPU1]

This results in panic() not flushing the panic messages.

Fix these problems by disabling all spinning operations completely
during panic().

Another advantage is that it prevents possible deadlocks caused by
"console_owner_lock". The panic() context does not need to take it
any longer. The lockless checks are safe because the functions become
NOPs when they see the panic in progress. All operations manipulating
the state are still synchronized by the lock even when non-panic CPUs
would notice the panic synchronously.

The current owner might stay spinning. But non-panic() CPUs would get
stopped anyway and the panic context will never start spinning.

Fixes: dbdda842fe96 ("printk: Add console owner and waiter logic to load balance console writes")
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 26a76b167ea6..fbe0dc1ca416 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1847,10 +1847,23 @@ static bool console_waiter;
  */
 static void console_lock_spinning_enable(void)
 {
+	/*
+	 * Do not use spinning in panic(). The panic CPU wants to keep the lock.
+	 * Non-panic CPUs abandon the flush anyway.
+	 *
+	 * Just keep the lockdep annotation. The panic-CPU should avoid
+	 * taking console_owner_lock because it might cause a deadlock.
+	 * This looks like the easiest way how to prevent false lockdep
+	 * reports without handling races a lockless way.
+	 */
+	if (panic_in_progress())
+		goto lockdep;
+
 	raw_spin_lock(&console_owner_lock);
 	console_owner = current;
 	raw_spin_unlock(&console_owner_lock);
 
+lockdep:
 	/* The waiter may spin on us after setting console_owner */
 	spin_acquire(&console_owner_dep_map, 0, 0, _THIS_IP_);
 }
@@ -1875,6 +1888,22 @@ static int console_lock_spinning_disable_and_check(int cookie)
 {
 	int waiter;
 
+	/*
+	 * Ignore spinning waiters during panic() because they might get stopped
+	 * or blocked at any time,
+	 *
+	 * It is safe because nobody is allowed to start spinning during panic
+	 * in the first place. If there has been a waiter then non panic CPUs
+	 * might stay spinning. They would get stopped anyway. The panic context
+	 * will never start spinning and an interrupted spin on panic CPU will
+	 * never continue.
+	 */
+	if (panic_in_progress()) {
+		/* Keep lockdep happy. */
+		spin_release(&console_owner_dep_map, _THIS_IP_);
+		return 0;
+	}
+
 	raw_spin_lock(&console_owner_lock);
 	waiter = READ_ONCE(console_waiter);
 	console_owner = NULL;
-- 
2.35.3

