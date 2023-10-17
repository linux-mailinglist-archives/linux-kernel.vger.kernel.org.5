Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB147CCF2F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 23:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344300AbjJQVZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 17:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344250AbjJQVYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 17:24:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB8910CE
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:23:51 -0700 (PDT)
Message-ID: <20231017211723.018821624@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697577830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=k082nSPppDUkOLh9xMaYiiJZSBP4qeS6H+UxEpdLYkw=;
        b=l2kPJv8n4GOVejsCnVP6iRSA/vsKQw93X1p+Wb15YN96cr94WkEAWzUW5UA8qIwy0bpIa/
        JItFlgQikDeguLVBCCjXYmaLqbijQoL4lIjf4h91bH0iMa2h5frCsXEloAAnZIEgBMzrBF
        Es5COMMDY8vHLUExrY8qWP1W+nDCCdWQQV4apAtHato/T1sFfwCXcjvLcYc4REzxQiaXeV
        gkB44OozvZOngaPVVTHayv3BQmlY5KaWZ0+VUph9kRFLB+O2gdROpLAw5KVgEGxMh2v7Op
        boesDTjxiSWGjPuR3WgutufxEJiJdiyRT2YRcnezBtqt6ZU0qd7HKmrKT4p3/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697577830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=k082nSPppDUkOLh9xMaYiiJZSBP4qeS6H+UxEpdLYkw=;
        b=oV8f795DOcI4kzPmF1+3APolA3gE4P91Peuk7h1rbjJuGPD8VUrfISmUVS9fNdN2hWNvEi
        MbAHAd77DfWRHhCA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>
Subject: [patch V5 19/39] x86/microcode: Remove pointless apply() invocation
References: <20231017200758.877560658@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 17 Oct 2023 23:23:49 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Microcode is applied on the APs during early bringup. There is no point
in trying to apply the microcode again during the hotplug operations and
neither at the point where the microcode device is initialized.

Collect CPU info and microcode revision in setup_online_cpu() for now.
This will move to the CPU hotplug callback later.

[ bp: Leave the starting notifier for the following scenario:

    - boot, late load, suspend to disk, resume

    without the starting notifier, only the last core manages to update the
    microcode upon resume:

    # rdmsr -a 0x8b
    10000bf
    10000bf
    10000bf
    10000bf
    10000bf
    10000dc <----

    This is on an AMD F10h machine.

    For the future, one should check whether potential unification of
    the CPU init path could cover the resume path too so that this can
    be simplified even more.

 tglx: This is caused by the odd handling of APs which try to find the
       microcode blob in builtin or initrd instead of caching the microcode
       blob during early init before the APs are brought up. Will be
       cleaned up in a later step. ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V5: Drop the starting notifier change as that requires rework of the
    AMD code.
---
 arch/x86/kernel/cpu/microcode/core.c |   23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)
---
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -487,17 +487,6 @@ static void microcode_fini_cpu(int cpu)
 		microcode_ops->microcode_fini_cpu(cpu);
 }
 
-static enum ucode_state microcode_init_cpu(int cpu)
-{
-	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
-
-	memset(uci, 0, sizeof(*uci));
-
-	microcode_ops->collect_cpu_info(cpu, &uci->cpu_sig);
-
-	return microcode_ops->apply_microcode(cpu);
-}
-
 /**
  * microcode_bsp_resume - Update boot CPU microcode during resume.
  */
@@ -552,14 +541,14 @@ static int mc_cpu_down_prep(unsigned int
 static void setup_online_cpu(struct work_struct *work)
 {
 	int cpu = smp_processor_id();
-	enum ucode_state err;
+	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
 
-	err = microcode_init_cpu(cpu);
-	if (err == UCODE_ERROR) {
-		pr_err("Error applying microcode on CPU%d\n", cpu);
-		return;
-	}
+	memset(uci, 0, sizeof(*uci));
 
+	microcode_ops->collect_cpu_info(cpu, &uci->cpu_sig);
+	cpu_data(cpu).microcode = uci->cpu_sig.rev;
+	if (!cpu)
+		boot_cpu_data.microcode = uci->cpu_sig.rev;
 	mc_cpu_online(cpu);
 }
 

