Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B438091E3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 20:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443847AbjLGTtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 14:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443836AbjLGTtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 14:49:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEF3A5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 11:49:27 -0800 (PST)
Message-ID: <20231207194518.401797191@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701978566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=RL2aUGa/0fCGlOcvBTwpDBVET2p1h9g7vOOa31RMm2Y=;
        b=iMm66hHYutaHMZyNgXhZ+NUJJ/Q84XYfn6Kdy3ZYQnR8hI70r+14JU6bBNynwg+T1HAehy
        Xjy+uX8uiTVEdDhc0IsVFTLYnKs+8QCKm5AAXVErIFz/f6pAL+UB7CkUv36lstLqMTNljO
        XDp4EdqqZHcson9iolfqCMn/jOQONsgXDqrQnihAAaKj7p5czEuyUJkdzLvQ7blDBWg8tt
        ej0/0NDse/jLOEzrerfH31NAYipIkJCWkuN3hVKQXHnutv4mSs9aP1rbLtgq3SC3QZ5ijA
        eBfLrvDUVZo0P2slpBUBq0V6UIb1ed6jJB68Zp9oRI0ucMF7yxvCsEt0T2O+Xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701978566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=RL2aUGa/0fCGlOcvBTwpDBVET2p1h9g7vOOa31RMm2Y=;
        b=910XjksgkcPwpDkvhFYaJHImSqHEk5thdypIC3+GOs+1Ypp17Be4ufGHHbhbLYiyqupVsa
        peopkJzCMCArp/Aw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     paul.gortmaker@windriver.com, x86@kernel.org,
        regressions@leemhuis.info, richard.purdie@linuxfoundation.org,
        regressions@lists.linux.dev
Subject: [patch 2/2] x86/alternatives: Disable interrupts and sync when
 optimizing NOPs in place
References: <ZXCXc+BtnLzqMbFv@windriver.com> <ZUEgAAGDVqXz2Seo@windriver.com>
 <0adb772c-e8d2-4444-92b0-00cbfdaf1fac@leemhuis.info> <87r0k9ym0y.ffs@tglx>
 <20231207193859.961361261@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu,  7 Dec 2023 20:49:26 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

apply_alternatives() treats alternatives with the ALT_FLAG_NOT flag set
special as it optimizes the existing NOPs in place.

Unfortunately this happens with interrupts enabled and does not provide any
form of core synchronization.

So an interrupt hitting in the middle of the update and using the affected
code path will observe a half updated NOP and crash and burn. The following
3 NOP sequence was observed to expose this crash halfways reliably under
QEMU 32bit:

   0x90 0x90 0x90

which is replaced by the optimized 3 byte NOP:

   0x8d 0x76 0x00

So an interrupt can observe:

   1) 0x90 0x90 0x90		nop nop nop
   2) 0x8d 0x90 0x90		undefined
   3) 0x8d 0x76 0x90		lea    -0x70(%esi),%esi
   4) 0x8d 0x76 0x00		lea     0x0(%esi),%esi

Where only #1 and #4 are true NOPs. The same problem exists for 64bit obviously.

Disable interrupts around this NOP optimization and invoke sync_core()
before reenabling them.

Fixes: 270a69c4485d ("x86/alternative: Support relocations in alternatives")
Reported-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/alternative.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -255,6 +255,16 @@ static void __init_or_module noinline op
 	}
 }
 
+static void __init_or_module noinline optimize_nops_inplace(u8 *instr, size_t len)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	optimize_nops(instr, len);
+	sync_core();
+	local_irq_restore(flags);
+}
+
 /*
  * In this context, "source" is where the instructions are placed in the
  * section .altinstr_replacement, for example during kernel build by the
@@ -438,7 +448,7 @@ void __init_or_module noinline apply_alt
 		 *   patch if feature is *NOT* present.
 		 */
 		if (!boot_cpu_has(a->cpuid) == !(a->flags & ALT_FLAG_NOT)) {
-			optimize_nops(instr, a->instrlen);
+			optimize_nops_inplace(instr, a->instrlen);
 			continue;
 		}
 

