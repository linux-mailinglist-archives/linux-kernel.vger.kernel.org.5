Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4269D8006F3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378198AbjLAJ3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378081AbjLAJ2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:28:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB571FCB
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:27:28 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701422846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lz8mvggzvpUJEzbVXb4zUQlWwIeSFK/TCyXr++4TCPE=;
        b=EdTH1vhM3NGV6kmiUinGxLJ1Pm0M49zT313ppufUyWkX5Xlv7reO3Fk/sLVkQhQK7lDkKO
        OKyWIf49mKkvRSRvEz9LZ5jjWbVDcj8jaEtC5xYrxylR/wiK7coOeLfGlMNmNN21nXNxHf
        sLA55soY106JsKuC2y5XYkXpChswmiJF6O35gv4lDjmZE9ckO49OZq9IJPQgcUO9H2pjss
        N8ZOv+qp88KBvyM5BxqOCJu8mB64sQctsoqxBAJ1AjggNxBxfqRnfryYYOwsaBJgc3yW80
        DJAqa12Niwukm8v9KHr9jy9njV6OEiO4TlibrrJzd9x+L3mFmztY9Gk/tbWvqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701422846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lz8mvggzvpUJEzbVXb4zUQlWwIeSFK/TCyXr++4TCPE=;
        b=7AWmEIidBRmfR/ZiDTR0IYKQlxe2r1jHuUlbpKg2IhmL9oFRBHb5oBeNAoamIAoHtCdXMK
        z8HthAkNaKBDp5Dg==
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH v9 29/32] timers: Introduce function to check timer base is_idle flag
Date:   Fri,  1 Dec 2023 10:26:51 +0100
Message-Id: <20231201092654.34614-30-anna-maria@linutronix.de>
In-Reply-To: <20231201092654.34614-1-anna-maria@linutronix.de>
References: <20231201092654.34614-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prepare for the conversion of the NOHZ timer placement to a pull at
expiry time model it's required to have a function that returns the value
of the is_idle flag of the timer base to keep the hierarchy states during
online in sync with timer base state.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
v9: new in v9
---
 kernel/time/tick-internal.h |  1 +
 kernel/time/timer.c         | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index e0e58dd18919..2d1a44850c20 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -166,6 +166,7 @@ extern void fetch_next_timer_interrupt_remote(unsigned long basej, u64 basem,
 					      unsigned int cpu);
 extern void timer_lock_remote_bases(unsigned int cpu);
 extern void timer_unlock_remote_bases(unsigned int cpu);
+extern bool timer_base_is_idle(void);
 # endif
 #else /* CONFIG_NO_HZ_COMMON */
 static inline void timers_update_nohz(void) { }
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index a797603dfd49..b6c9ac0c3712 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2201,6 +2201,16 @@ u64 timer_base_try_to_set_idle(unsigned long basej, u64 basem, bool *idle)
 	return __get_next_timer_interrupt(basej, basem, idle);
 }
 
+/**
+ * timer_base_is_idle() - Return whether timer base is set idle
+ *
+ * Returns value of local timer base is_idle value.
+ */
+bool timer_base_is_idle(void)
+{
+	return __this_cpu_read(timer_bases[BASE_LOCAL].is_idle);
+}
+
 /**
  * timer_clear_idle - Clear the idle state of the timer base
  *
-- 
2.39.2

