Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC537B8410
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242961AbjJDPr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbjJDPrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:47:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E196BCE;
        Wed,  4 Oct 2023 08:47:15 -0700 (PDT)
Date:   Wed, 04 Oct 2023 15:47:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696434434;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nH6tE9EI7ysD4tR/3JJt9rHH0u9Mq170wLjzJ0gD99U=;
        b=ujWZsBHxjEcAYyt5AIlbDWAoi6BSFH3jKCRLMu298spiQFv8K8BF1rTiwgC8fQk0VtwRCi
        CWXjwHjTwz57xcDM19eRXuxxC50OxXee+YuHTxg0/NPvFgeeihxVyXW7ZmgyVwQSJ+MFIh
        EqYd4pVXb2rI3Q5rbcpQ6MijTGi4kx9cSHqwMJ83jnBoGi2FU55YA5wAJv+vrMVOvogos5
        StFoLqs/v5C4cgOU161XFil286a5LaL5BiLEbuLoSx8xDGCIKoJCm35TCgtFOjDBDXG5J3
        24ztEdBYheL58dKhv/CViPCKVlmCipvbYLk4PNrzPQj7HFEIrrsBNttX/4MbfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696434434;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nH6tE9EI7ysD4tR/3JJt9rHH0u9Mq170wLjzJ0gD99U=;
        b=qVGwlninWedfbjs2YE+fdTnL94uhqCI+HFW2U3Mio+B2h8t+X3Z08RpioJwIdZ006CU0cP
        n5rxgUzAyvoGPVAg==
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
Message-ID: <169643443360.3135.5068891650571884994.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     aaa3e6678978b5e2b5c6e80e439fc4db9bbdb375
Gitweb:        https://git.kernel.org/tip/aaa3e6678978b5e2b5c6e80e439fc4db9bbdb375
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Thu, 27 Jul 2023 14:45:57 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 04 Oct 2023 13:48:48 +02:00

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
