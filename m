Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042CA7B51F6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236938AbjJBMAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236905AbjJBMAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:00:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD17D115
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 04:59:50 -0700 (PDT)
Message-ID: <20231002115902.741173606@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696247989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ihivJowKww+fe1UCzdxyPRQezAmQeOqgMJYs1huTU/U=;
        b=wWaFWCqriKzwJj+tiIe3SEuTR4hlFXDY8SbkqL5M2A7hg42Mp8ZhaL+ZVT0QgCiPf/5wK9
        Ws+g2sstPgt9NDgziMd89XKkGJDR9XgUHm7Ouf0fRkQQOHRzSbi3W6B+vsdV1FZ4paHnPS
        jyXGHAbNqGdBEmx2vd+BvDwK3ls2518fFJz2Q/pNDaSX1inD4ZaMBbWClIg4+hBX3FwnIs
        SI/SLmb/kTgAErWaTk+QJjcA0Q4eD6h2IAQJ3acpH9MToicyE6Jtmr7ffbkEt9I1AeEnrd
        g9nrnOh8wREw1sGqWPox3Levp/XxoS+xs3Sirg+g4HJ2DUlY9lc5hgdhyA0AmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696247989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ihivJowKww+fe1UCzdxyPRQezAmQeOqgMJYs1huTU/U=;
        b=XNFufHleMeX20JiOkPES/gphi9j4ns1gcdEigvhaBEjZ1lz4CE9I1Tvy6Uk+J6lpu5QLY8
        +36OP5/o9FAGURDA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V4 12/30] x86/microcode/intel: Reuse intel_cpu_collect_info()
References: <20231002115506.217091296@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  2 Oct 2023 13:59:49 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No point for an almost duplicate function.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 arch/x86/kernel/cpu/microcode/intel.c |   16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -425,21 +425,7 @@ void reload_ucode_intel(void)
 
 static int collect_cpu_info(int cpu_num, struct cpu_signature *csig)
 {
-	struct cpuinfo_x86 *c = &cpu_data(cpu_num);
-	unsigned int val[2];
-
-	memset(csig, 0, sizeof(*csig));
-
-	csig->sig = cpuid_eax(0x00000001);
-
-	if ((c->x86_model >= 5) || (c->x86 > 6)) {
-		/* get processor flags from MSR 0x17 */
-		rdmsr(MSR_IA32_PLATFORM_ID, val[0], val[1]);
-		csig->pf = 1 << ((val[1] >> 18) & 7);
-	}
-
-	csig->rev = c->microcode;
-
+	intel_collect_cpu_info(csig);
 	return 0;
 }
 

