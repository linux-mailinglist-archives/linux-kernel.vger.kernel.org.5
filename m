Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4C2778071
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbjHJSjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235996AbjHJSil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:38:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175433A8D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:38:19 -0700 (PDT)
Message-ID: <20230810160806.222037973@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691692679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=gvgWHgk38J3qGADoq/3qmkZUlBXc3nLuAkYAzeigZSY=;
        b=YwdxmrVIawd2/tEOB/OcmWdiIdlO5T27/VUCnn1PqNODTt7cNKcTWe01bXLz3HAFwMHIgV
        iJMi4AU2Jhn9rCi+9Vf11m/Lky7rQDyC/ebdF9Zn+5ozAe7PrnDt4OUJCi/YrM7RjXtzdd
        Ual4qeE6canEBwI3tisTgNRCK4S1KXukxb8InWnrA7kREgQqvZBFUpr55hw+jidkU2AsDW
        H2pGqjWGlgA/ZHPj71jbX1t9xTr2HWnvXTJwSo8drxqoelxE0SW1OZL/WO7BjxPmkfwfwn
        4+Ovf3iAwNJ/MhZQDW4IQYxzaJs6jaqDRHjLTEyUIQLaaKN9I+oNDCdj1eG0lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691692679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=gvgWHgk38J3qGADoq/3qmkZUlBXc3nLuAkYAzeigZSY=;
        b=j7AbLqrH79qZK7uB3sVUmkBzri0ksIZc28OGMFu266vzzyspGkosRR7aIePBmBMflTFEAS
        In77FyU3+1IiSBBg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: [patch 22/30] x86/microcode: Add per CPU control field
References: <20230810153317.850017756@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 10 Aug 2023 20:37:58 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Add a per CPU control field to ucode_ctrl and define constants for it:

SCTRL_WAIT    indicates that the CPU needs to spinwait with timeout
SCTRL_APPLY   indicates that the CPU needs to invoke the microcode_apply()
	      callback
SCTRL_DONE    indicates that the CPU can proceed without invoking the
	      microcode_apply() callback.

In theory this could be a global control field, but a global control does
not cover the following case:

 15 primary CPUs load microcode successfully
  1 primary CPU fails and returns with an error code

With global control the sibling of the failed CPU would either try again or
the whole operation would be aborted with the consequence that the 15
siblings do not invoke the apply path and end up with inconsistent software
state. The result in dmesg would be inconsistent too.

There are two additional fields added and initialized:

ctrl_cpu and secondaries. ctrl_cpu is the CPU number of the primary thread
for now, but with the upcoming uniform loading at package or system scope
this will be one CPU per package or just one CPU. Secondaries hands the
control CPU a CPU mask which will be required to release the secondary CPUs
out of the wait loop.

Preparatory change for implementing a properly split control flow for
primary and secondary CPUs.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


---
 arch/x86/kernel/cpu/microcode/core.c |   20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)
---
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -324,8 +324,16 @@ static struct platform_device	*microcode
  *   requirement can be relaxed in the future. Right now, this is conservative
  *   and good.
  */
+enum sibling_ctrl {
+	SCTRL_WAIT,
+	SCTRL_APPLY,
+	SCTRL_DONE,
+};
+
 struct ucode_ctrl {
+	enum sibling_ctrl	ctrl;
 	enum ucode_state	result;
+	unsigned int		ctrl_cpu;
 };
 
 static DEFINE_PER_CPU(struct ucode_ctrl, ucode_ctrl);
@@ -468,7 +476,7 @@ static int ucode_load_late_stop_cpus(voi
  */
 static bool ucode_setup_cpus(void)
 {
-	struct ucode_ctrl ctrl = { .result = -1, };
+	struct ucode_ctrl ctrl = { .ctrl = SCTRL_WAIT, .result = -1, };
 	unsigned int cpu;
 
 	for_each_cpu_and(cpu, cpu_present_mask, &cpus_booted_once_mask) {
@@ -478,7 +486,15 @@ static bool ucode_setup_cpus(void)
 				return false;
 			}
 		}
-		/* Initialize the per CPU state */
+
+		/*
+		 * Initialize the per CPU state. This is core scope for now,
+		 * but prepared to take package or system scope into account.
+		 */
+		if (topology_is_primary_thread(cpu))
+			ctrl.ctrl_cpu = cpu;
+		else
+			ctrl.ctrl_cpu = cpumask_first(topology_sibling_cpumask(cpu));
 		per_cpu(ucode_ctrl, cpu) = ctrl;
 	}
 	return true;

