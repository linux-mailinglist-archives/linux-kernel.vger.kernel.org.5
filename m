Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE0D7C8253
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjJMJj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjJMJiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:38:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DA4D9;
        Fri, 13 Oct 2023 02:38:15 -0700 (PDT)
Date:   Fri, 13 Oct 2023 09:38:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697189894;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c6wa9XjmLkCQ3qyO7ju+/JngPbdKYlTfNmaJ+JxwaHM=;
        b=UDonnchuUez1ppBxaRt/5mymEc+wfrxX6KJ0Q21Nj7HP5pKalEQjLnROlq8VHk2UCQjUck
        oGknHOi/kPoLig/ztjobo0iaYwCNcABn1wx/el3yt9I9ziMzuCjylHwf1ohm621J6uhlq+
        /oT8eNwUTP+gJXekZ05dQ6FaR8UGKz7ty0vaNDK8sVwGRBV5f0ul+CJICvN69cZ675SsD4
        tA8g/Yh1Cy1uZQ+kec0LdT9DHYUy2+EChbpC0GxjF/v84FtHP87ExFf4CB609b7kIRZA69
        /NcaK1zduPB/4lT/IVtujvXmgAAtCfELMelA5tIJazb80p/uXT2wZorYMC32Qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697189894;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c6wa9XjmLkCQ3qyO7ju+/JngPbdKYlTfNmaJ+JxwaHM=;
        b=VmysQOnQWHeAUR2dahw4nL40brr8rLfW5s7ZYp37Z2W8sopcB3SUs3yqPKu2GTC0U4bHJw
        caq12SzT3GT73ZDA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] cpu/SMT: Make SMT control more robust against
 enumeration failures
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230814085112.149440843@linutronix.de>
References: <20230814085112.149440843@linutronix.de>
MIME-Version: 1.0
Message-ID: <169718989362.3135.9943655328316153268.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     d91bdd96b55cc3ce98d883a60f133713821b80a6
Gitweb:        https://git.kernel.org/tip/d91bdd96b55cc3ce98d883a60f133713821b80a6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 14 Aug 2023 10:18:27 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Oct 2023 14:38:17 +02:00

cpu/SMT: Make SMT control more robust against enumeration failures

The SMT control mechanism got added as speculation attack vector
mitigation. The implemented logic relies on the primary thread mask to
be set up properly.

This turns out to be an issue with XEN/PV guests because their CPU hotplug
mechanics do not enumerate APICs and therefore the mask is never correctly
populated.

This went unnoticed so far because by chance XEN/PV ends up with
smp_num_siblings == 2. So smt_hotplug_control stays at its default value
CPU_SMT_ENABLED and the primary thread mask is never evaluated in the
context of CPU hotplug.

This stopped "working" with the upcoming overhaul of the topology
evaluation which legitimately provides a fake topology for XEN/PV. That
sets smp_num_siblings to 1, which causes the core CPU hot-plug core to
refuse to bring up the APs.

This happens because smt_hotplug_control is set to CPU_SMT_NOT_SUPPORTED
which causes cpu_smt_allowed() to evaluate the unpopulated primary thread
mask with the conclusion that all non-boot CPUs are not valid to be
plugged.

Make cpu_smt_allowed() more robust and take CPU_SMT_NOT_SUPPORTED and
CPU_SMT_NOT_IMPLEMENTED into account. Rename it to cpu_bootable() while at
it as that makes it more clear what the function is about.

The primary mask issue on x86 XEN/PV needs to be addressed separately as
there are users outside of the CPU hotplug code too.

Fixes: 05736e4ac13c ("cpu/hotplug: Provide knobs to control SMT")
Reported-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230814085112.149440843@linutronix.de

---
 kernel/cpu.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6de7c6b..1a189da 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -659,11 +659,19 @@ static inline bool cpu_smt_thread_allowed(unsigned int cpu)
 #endif
 }
 
-static inline bool cpu_smt_allowed(unsigned int cpu)
+static inline bool cpu_bootable(unsigned int cpu)
 {
 	if (cpu_smt_control == CPU_SMT_ENABLED && cpu_smt_thread_allowed(cpu))
 		return true;
 
+	/* All CPUs are bootable if controls are not configured */
+	if (cpu_smt_control == CPU_SMT_NOT_IMPLEMENTED)
+		return true;
+
+	/* All CPUs are bootable if CPU is not SMT capable */
+	if (cpu_smt_control == CPU_SMT_NOT_SUPPORTED)
+		return true;
+
 	if (topology_is_primary_thread(cpu))
 		return true;
 
@@ -685,7 +693,7 @@ bool cpu_smt_possible(void)
 EXPORT_SYMBOL_GPL(cpu_smt_possible);
 
 #else
-static inline bool cpu_smt_allowed(unsigned int cpu) { return true; }
+static inline bool cpu_bootable(unsigned int cpu) { return true; }
 #endif
 
 static inline enum cpuhp_state
@@ -788,10 +796,10 @@ static int bringup_wait_for_ap_online(unsigned int cpu)
 	 * SMT soft disabling on X86 requires to bring the CPU out of the
 	 * BIOS 'wait for SIPI' state in order to set the CR4.MCE bit.  The
 	 * CPU marked itself as booted_once in notify_cpu_starting() so the
-	 * cpu_smt_allowed() check will now return false if this is not the
+	 * cpu_bootable() check will now return false if this is not the
 	 * primary sibling.
 	 */
-	if (!cpu_smt_allowed(cpu))
+	if (!cpu_bootable(cpu))
 		return -ECANCELED;
 	return 0;
 }
@@ -1741,7 +1749,7 @@ static int cpu_up(unsigned int cpu, enum cpuhp_state target)
 		err = -EBUSY;
 		goto out;
 	}
-	if (!cpu_smt_allowed(cpu)) {
+	if (!cpu_bootable(cpu)) {
 		err = -EPERM;
 		goto out;
 	}
