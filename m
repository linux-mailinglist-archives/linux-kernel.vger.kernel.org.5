Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F3C76CAB1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 12:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbjHBKWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 06:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbjHBKVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 06:21:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC50B2D5B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 03:21:15 -0700 (PDT)
Message-ID: <20230802101933.280890888@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690971674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=yb4tmHWl8yliaQANo7laiWJ0jRDyn2bmk/9yGN0NZ50=;
        b=lBU8SqV8FhKxosSvVbig2gXXNB0Q2vTZvpIBUKk9Ek+eEchzRBVHEVc6czc3mCHMzhm8+M
        hhtu11FRkm+0oxNNv6ZSXOSVE4iip0OvsdhPoGu8QYs28zws9oDxqq6N3Z2a9fX7Ldq8mI
        pgIeVMn5pMDf4U65vDZ7n1lMAsHu68owvA7LgBsf1H41WiqwSyOvnLQB4cTPUP4cOsAe67
        estRZQnBvvHV3GY82Y87GFlX2t80MEXsEkFhmn1lJz2PyeJ1J0UHCQNKEX4ajUEm8V80RR
        op5yI5/21cKG2au/JZwCbUMRYRpENyRF9+1i7uFt4IriUBWAHR7IvorToMGvNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690971674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=yb4tmHWl8yliaQANo7laiWJ0jRDyn2bmk/9yGN0NZ50=;
        b=/5svq9QWeZmmXy+t7I4tr1zNmrs9Q+ESc8AmdtY8RD4UXuK34fkNWN5Al7dy459Q2RpK81
        HxN3jTLKRlVpuVCA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: [patch V3 10/40] x86/cpu: Remove pointless evaluation of
 x86_coreid_bits
References: <20230802101635.459108805@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Wed,  2 Aug 2023 12:21:13 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpuinfo_x86::x86_coreid_bits is only used by the AMD numa topology code. No
point in evaluating it on non AMD systems.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Arjan van de Ven <arjan@linux.intel.com>
---
 arch/x86/kernel/cpu/intel.c   |   13 -------------
 arch/x86/kernel/cpu/zhaoxin.c |   14 --------------
 2 files changed, 27 deletions(-)

--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -488,19 +488,6 @@ static void early_init_intel(struct cpui
 		setup_clear_cpu_cap(X86_FEATURE_PGE);
 	}
 
-	if (c->cpuid_level >= 0x00000001) {
-		u32 eax, ebx, ecx, edx;
-
-		cpuid(0x00000001, &eax, &ebx, &ecx, &edx);
-		/*
-		 * If HTT (EDX[28]) is set EBX[16:23] contain the number of
-		 * apicids which are reserved per package. Store the resulting
-		 * shift value for the package management code.
-		 */
-		if (edx & (1U << 28))
-			c->x86_coreid_bits = get_count_order((ebx >> 16) & 0xff);
-	}
-
 	check_memory_type_self_snoop_errata(c);
 
 	/*
--- a/arch/x86/kernel/cpu/zhaoxin.c
+++ b/arch/x86/kernel/cpu/zhaoxin.c
@@ -65,20 +65,6 @@ static void early_init_zhaoxin(struct cp
 		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
 		set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
 	}
-
-	if (c->cpuid_level >= 0x00000001) {
-		u32 eax, ebx, ecx, edx;
-
-		cpuid(0x00000001, &eax, &ebx, &ecx, &edx);
-		/*
-		 * If HTT (EDX[28]) is set EBX[16:23] contain the number of
-		 * apicids which are reserved per package. Store the resulting
-		 * shift value for the package management code.
-		 */
-		if (edx & (1U << 28))
-			c->x86_coreid_bits = get_count_order((ebx >> 16) & 0xff);
-	}
-
 }
 
 static void init_zhaoxin(struct cpuinfo_x86 *c)

