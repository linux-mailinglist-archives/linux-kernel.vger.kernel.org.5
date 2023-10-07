Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17637BC93E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 19:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344134AbjJGRLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 13:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344113AbjJGRLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 13:11:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5611B9F;
        Sat,  7 Oct 2023 10:11:01 -0700 (PDT)
Date:   Sat, 07 Oct 2023 17:10:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696698660;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SAONc9WOBgvp1ZGsbpOFNuRJBUWaPIv7XR4QPQyRKsQ=;
        b=EdmAzSKxZ4wl8gyFRqgNq549vgm0LAtmrz5MQMP+iKC6i7i3HfSvskegIZ05rzVaA3Qo3/
        a+3uTBTGrBhzOMKvw8Lz1koTYERPKeMF61Guth3sVBS38yNutydRDOvKr/uTT/mOzpAm62
        CnrLzEIVSmrKBF51WBYrRFJqv7n3ZnQAu3vckgqRW7R0s9of6OSZHLdom8Bat/2bhnQD8n
        8Ko8CEsNxwPFzkKIb7WhSaS6oN5cv5q6MOumQyzx4gghY8Y8WqFIj3KiCULxXawIgrIVbQ
        VeBp03rTW5RxUTS2sH4kY6lV8eR0CImgFH5fvT3VTHTdhUTlrS4EQpuicsDX6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696698660;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SAONc9WOBgvp1ZGsbpOFNuRJBUWaPIv7XR4QPQyRKsQ=;
        b=exLohR973qAL3A9BeHy47VV1sK1J1Z+3QAlPOOSmZFY7sOM9VpHCaqR8AwshTorUdLLWXE
        ivYQCOe4K64gmvAg==
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] x86/idle: Disable IBRS when CPU is offline to
 improve single-threaded performance
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230727184600.26768-3-longman@redhat.com>
References: <20230727184600.26768-3-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <169669865877.3135.4050101364714116656.tip-bot2@tip-bot2>
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

Commit-ID:     2743fe89d4d41616ffbe1e7e96e443ae7a4b1cc6
Gitweb:        https://git.kernel.org/tip/2743fe89d4d41616ffbe1e7e96e443ae7a4b1cc6
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Thu, 27 Jul 2023 14:45:58 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 07 Oct 2023 11:33:28 +02:00

x86/idle: Disable IBRS when CPU is offline to improve single-threaded performance

Commit bf5835bcdb96 ("intel_idle: Disable IBRS during long idle")
disables IBRS when the CPU enters long idle. However, when a CPU
becomes offline, the IBRS bit is still set when X86_FEATURE_KERNEL_IBRS
is enabled. That will impact the performance of a sibling CPU. Mitigate
this performance impact by clearing all the mitigation bits in SPEC_CTRL
MSR when offline. When the CPU is online again, it will be re-initialized
and so restoring the SPEC_CTRL value isn't needed.

Add a comment to say that native_play_dead() is a __noreturn function,
but it can't be marked as such to avoid confusion about the missing
MSR restoration code.

When DPDK is running on an isolated CPU thread processing network packets
in user space while its sibling thread is idle. The performance of the
busy DPDK thread with IBRS on and off in the sibling idle thread are:

                                IBRS on         IBRS off
                                -------         --------
  packets/second:                  7.8M           10.4M
  avg tsc cycles/packet:         282.26          209.86

This is a 25% performance degradation. The test system is a Intel Xeon
4114 CPU @ 2.20GHz.

[ mingo: Extended the changelog with performance data from the 0/4 mail. ]

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20230727184600.26768-3-longman@redhat.com
---
 arch/x86/kernel/smpboot.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 48e0406..02765d9 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -87,6 +87,7 @@
 #include <asm/hw_irq.h>
 #include <asm/stackprotector.h>
 #include <asm/sev.h>
+#include <asm/spec-ctrl.h>
 
 /* representing HT siblings of each logical CPU */
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
@@ -1623,8 +1624,15 @@ void __noreturn hlt_play_dead(void)
 		native_halt();
 }
 
+/*
+ * native_play_dead() is essentially a __noreturn function, but it can't
+ * be marked as such as the compiler may complain about it.
+ */
 void native_play_dead(void)
 {
+	if (cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS))
+		__update_spec_ctrl(0);
+
 	play_dead_common();
 	tboot_shutdown(TB_SHUTDOWN_WFS);
 
