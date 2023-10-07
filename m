Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C06A7BC944
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 19:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344054AbjJGRLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 13:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344118AbjJGRLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 13:11:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0599A2;
        Sat,  7 Oct 2023 10:11:01 -0700 (PDT)
Date:   Sat, 07 Oct 2023 17:10:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696698660;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5kiEoVZenwhxVMli/0Xg39anpqA8OnebqM0TKg7l87M=;
        b=O2ljeJ7DWqzWuSAcmkP8d3cC4NLYfheMTGuugOMskDc2g67go6jcdctunyY5Poza3puNIs
        6V9L6Wf1EY4T7Xdym01uo2KfPI2OzFmJkiXSgKubytDm1ntwMHxN2prMQ++dMsuTGDrqH7
        LEJm9iQ9SzGYs4tLxlTA3quk6W/fzNpHwHa1wa/MWQ31XvxbpULU1gUCxvoUid4nW0VmZL
        a4nPI0lIxDsjuKHbK9Oj88nqnRhhCz6AU4MjLcu+/xS2kgDzzy/TvTVWzzkA4NVIAJzWiI
        Gy04ZFMYGE0I70z04B6PUIXF33BnsLE+q397+16Q2AatfOxTezHiqETUqfqzVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696698660;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5kiEoVZenwhxVMli/0Xg39anpqA8OnebqM0TKg7l87M=;
        b=jkO21dyGBKA00KscUXdIDd0azQwuWAI7mmmI6wOx1i5AtYZwIfthpD4bRDtMeuo1j/P+Wd
        T4bSOCousVlAmhAg==
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] x86/speculation: Add __update_spec_ctrl() helper
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230727184600.26768-2-longman@redhat.com>
References: <20230727184600.26768-2-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <169669865996.3135.485844093321921238.tip-bot2@tip-bot2>
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

Commit-ID:     e3e3bab1844d448a239cd57ebf618839e26b4157
Gitweb:        https://git.kernel.org/tip/e3e3bab1844d448a239cd57ebf618839e26b4157
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Thu, 27 Jul 2023 14:45:57 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 07 Oct 2023 11:33:28 +02:00

x86/speculation: Add __update_spec_ctrl() helper

Add a new __update_spec_ctrl() helper which is a variant of
update_spec_ctrl() that can be used in a noinstr function.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20230727184600.26768-2-longman@redhat.com
---
 arch/x86/include/asm/spec-ctrl.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/include/asm/spec-ctrl.h b/arch/x86/include/asm/spec-ctrl.h
index cb0386f..c648502 100644
--- a/arch/x86/include/asm/spec-ctrl.h
+++ b/arch/x86/include/asm/spec-ctrl.h
@@ -4,6 +4,7 @@
 
 #include <linux/thread_info.h>
 #include <asm/nospec-branch.h>
+#include <asm/msr.h>
 
 /*
  * On VMENTER we must preserve whatever view of the SPEC_CTRL MSR
@@ -76,6 +77,16 @@ static inline u64 ssbd_tif_to_amd_ls_cfg(u64 tifn)
 	return (tifn & _TIF_SSBD) ? x86_amd_ls_cfg_ssbd_mask : 0ULL;
 }
 
+/*
+ * This can be used in noinstr functions & should only be called in bare
+ * metal context.
+ */
+static __always_inline void __update_spec_ctrl(u64 val)
+{
+	__this_cpu_write(x86_spec_ctrl_current, val);
+	native_wrmsrl(MSR_IA32_SPEC_CTRL, val);
+}
+
 #ifdef CONFIG_SMP
 extern void speculative_store_bypass_ht_init(void);
 #else
