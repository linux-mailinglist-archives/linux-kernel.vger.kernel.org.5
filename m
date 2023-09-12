Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4AB79C8E0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbjILH6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjILH62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:58:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6651C1733
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:58:04 -0700 (PDT)
Message-ID: <20230912065501.530637507@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694505483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ihivJowKww+fe1UCzdxyPRQezAmQeOqgMJYs1huTU/U=;
        b=wj1dVLTGF6RgQZ93P3v00gpeCt+n3ShYIi8VyQFE55ZOsZOXkp6ajCHFqdMtSDVxOo4qVm
        s9AoaiRwqEmjibvFZnZ02gCd0yYaNngTLCZqDYCOG5ukSHrxA8gn775Kd++ALwx8y3nlOd
        Bv875kw34ZDaO/BgQEecef9lrugWjpN7o1YHSLZXFc2HjjejFqfzVNZ0g6mq8Z+vCgW8tt
        +uBcYa128XANDG0st3buDjsZo2mSUOW4fEJjRwKjuDGu49TyNYqcUwmeebS5G+bymprNke
        UmBec4clGrp9SVwcPic0rnNj0Cv0hGb2vzGshg6+uPhzouO9mxNgekxQbrUibA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694505483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ihivJowKww+fe1UCzdxyPRQezAmQeOqgMJYs1huTU/U=;
        b=pjHTtTC9LC4Q6P8H4sYw/dU1Irf8uOq7L4qiAeB9uAO0JCf+WSRPi7+kH1Vcpg4K5aOnMk
        bkHtbiYKaEiWYLCQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V3 12/30] x86/microcode/intel: Reuse intel_cpu_collect_info()
References: <20230912065249.695681286@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 12 Sep 2023 09:58:02 +0200 (CEST)
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
 

