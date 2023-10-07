Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACF97BC940
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 19:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344144AbjJGRLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 13:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344021AbjJGRLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 13:11:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D7483;
        Sat,  7 Oct 2023 10:10:59 -0700 (PDT)
Date:   Sat, 07 Oct 2023 17:10:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696698658;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rEKjWkFLMKb1KqE8X1Cj8gxs9qu9BQZVwHibia4c8QI=;
        b=k4v9dR4B81+um3HdySa2CnsSEXB3VfurPXy/Qv7TiKW5M24xL3Hytk432iNEgUzVxKpv2M
        sfqwT/e/mybsilrQaAT5J85/G/QfSjeCxxDJzfDqtvnSx5k9yWiXSVFTZ9oJHf8kfkLKZ9
        kMUV+x0Hgh0zPztmrnpU0jwd3PHQOS5mTwx04qwTxDiQgg7415pI8oVGr3lUl4Zcl/FEPe
        nkwB3Y0q1+3YIN4OPq4LhE/pJQYB6A92V9mn8mNNfaue0TEs4VR1+D8zv6IYnkR5LQy6gU
        HOVuGGtFZFHt2pxjKzd8g2nl1sV8GNePmxWbmVdhMWZfLzloSVnlycCNsi9ldA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696698658;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rEKjWkFLMKb1KqE8X1Cj8gxs9qu9BQZVwHibia4c8QI=;
        b=CyLOWe6PN45IXaKHFUwpwQ9qXqrGnv4wYl3e5QDr1XJt0a7GfhezY6P3eXY9Bxj/P7Q/ia
        QIlopJx8JTnWXpBA==
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] intel_idle: Add ibrs_off module parameter to
 force-disable IBRS
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230727184600.26768-5-longman@redhat.com>
References: <20230727184600.26768-5-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <169669865746.3135.6564791936984807529.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     aa1567a7e6440b8c3af4b0d8a8219d8fc5028c5f
Gitweb:        https://git.kernel.org/tip/aa1567a7e6440b8c3af4b0d8a8219d8fc5028c5f
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Thu, 27 Jul 2023 14:46:00 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 07 Oct 2023 11:33:28 +02:00

intel_idle: Add ibrs_off module parameter to force-disable IBRS

Commit bf5835bcdb96 ("intel_idle: Disable IBRS during long idle")
disables IBRS when the cstate is 6 or lower. However, there are
some use cases where a customer may want to use max_cstate=1 to
lower latency. Such use cases will suffer from the performance
degradation caused by the enabling of IBRS in the sibling idle thread.
Add a "ibrs_off" module parameter to force disable IBRS and the
CPUIDLE_FLAG_IRQ_ENABLE flag if set.

In the case of a Skylake server with max_cstate=1, this new ibrs_off
option will likely increase the IRQ response latency as IRQ will now
be disabled.

When running SPECjbb2015 with cstates set to C1 on a Skylake system.

First test when the kernel is booted with: "intel_idle.ibrs_off":

  max-jOPS = 117828, critical-jOPS = 66047

Then retest when the kernel is booted without the "intel_idle.ibrs_off"
added:

  max-jOPS = 116408, critical-jOPS = 58958

That means booting with "intel_idle.ibrs_off" improves performance by:

  max-jOPS:      +1.2%, which could be considered noise range.
  critical-jOPS: +12%,  which is definitely a solid improvement.

The admin-guide/pm/intel_idle.rst file is updated to add a description
about the new "ibrs_off" module parameter.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20230727184600.26768-5-longman@redhat.com
---
 Documentation/admin-guide/pm/intel_idle.rst | 17 ++++++++++++++++-
 drivers/idle/intel_idle.c                   | 11 ++++++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/pm/intel_idle.rst b/Documentation/admin-guide/pm/intel_idle.rst
index b799a43..39bd6ec 100644
--- a/Documentation/admin-guide/pm/intel_idle.rst
+++ b/Documentation/admin-guide/pm/intel_idle.rst
@@ -170,7 +170,7 @@ and ``idle=nomwait``.  If any of them is present in the kernel command line, the
 ``MWAIT`` instruction is not allowed to be used, so the initialization of
 ``intel_idle`` will fail.
 
-Apart from that there are four module parameters recognized by ``intel_idle``
+Apart from that there are five module parameters recognized by ``intel_idle``
 itself that can be set via the kernel command line (they cannot be updated via
 sysfs, so that is the only way to change their values).
 
@@ -216,6 +216,21 @@ are ignored).
 The idle states disabled this way can be enabled (on a per-CPU basis) from user
 space via ``sysfs``.
 
+The ``ibrs_off`` module parameter is a boolean flag (defaults to
+false). If set, it is used to control if IBRS (Indirect Branch Restricted
+Speculation) should be turned off when the CPU enters an idle state.
+This flag does not affect CPUs that use Enhanced IBRS which can remain
+on with little performance impact.
+
+For some CPUs, IBRS will be selected as mitigation for Spectre v2 and Retbleed
+security vulnerabilities by default.  Leaving the IBRS mode on while idling may
+have a performance impact on its sibling CPU.  The IBRS mode will be turned off
+by default when the CPU enters into a deep idle state, but not in some
+shallower ones.  Setting the ``ibrs_off`` module parameter will force the IBRS
+mode to off when the CPU is in any one of the available idle states.  This may
+help performance of a sibling CPU at the expense of a slightly higher wakeup
+latency for the idle CPU.
+
 
 .. _intel-idle-core-and-package-idle-states:
 
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 86ac9a4..dcda0af 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -68,6 +68,7 @@ static int max_cstate = CPUIDLE_STATE_MAX - 1;
 static unsigned int disabled_states_mask __read_mostly;
 static unsigned int preferred_states_mask __read_mostly;
 static bool force_irq_on __read_mostly;
+static bool ibrs_off __read_mostly;
 
 static struct cpuidle_device __percpu *intel_idle_cpuidle_devices;
 
@@ -1852,11 +1853,13 @@ static void state_update_enter_method(struct cpuidle_state *state, int cstate)
 	}
 
 	if (cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS) &&
-			   state->flags & CPUIDLE_FLAG_IBRS) {
+			((state->flags & CPUIDLE_FLAG_IBRS) || ibrs_off)) {
 		/*
 		 * IBRS mitigation requires that C-states are entered
 		 * with interrupts disabled.
 		 */
+		if (ibrs_off && (state->flags & CPUIDLE_FLAG_IRQ_ENABLE))
+			state->flags &= ~CPUIDLE_FLAG_IRQ_ENABLE;
 		WARN_ON_ONCE(state->flags & CPUIDLE_FLAG_IRQ_ENABLE);
 		state->enter = intel_idle_ibrs;
 		return;
@@ -2175,3 +2178,9 @@ MODULE_PARM_DESC(preferred_cstates, "Mask of preferred idle states");
  * 'CPUIDLE_FLAG_INIT_XSTATE' and 'CPUIDLE_FLAG_IBRS' flags.
  */
 module_param(force_irq_on, bool, 0444);
+/*
+ * Force the disabling of IBRS when X86_FEATURE_KERNEL_IBRS is on and
+ * CPUIDLE_FLAG_IRQ_ENABLE isn't set.
+ */
+module_param(ibrs_off, bool, 0444);
+MODULE_PARM_DESC(ibrs_off, "Disable IBRS when idle");
