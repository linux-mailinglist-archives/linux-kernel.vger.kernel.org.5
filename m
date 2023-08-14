Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA3F77B4D7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235536AbjHNIzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235058AbjHNIyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:54:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C6E1AA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:54:16 -0700 (PDT)
Message-ID: <20230814085113.588701843@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692003255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ZG/EXWy0RVlNB1gv0Rdu33CQfwetyGKKBsf9BNZ5Uv8=;
        b=b2Y6JEYF0l284Ztmnc80j+qjT1TvPV0OZJ7eMMqmJgrEwA3l6JIdDLaDda0kCCVNc00au8
        2lF0gryQohsuCy8D16IadCY1UlOznUNIzF+KvESr2i4t5lHhiokmg+SpDAhgVB79+ltYPi
        yNnUmR8HuSFkQJVoU4omBUefExeoAyH4sCHcTNOAXG1jfutwzapAVE8v9RQlMkYgcdejiJ
        SLL0UTGdwbV7r3pdrf3/aSaj4ydsBVOjsIbplh3LTLnDoEbyNGoGhObGdTwGLB1GzM9Ep2
        WJeP6mt9oKsyHgj39AqcCdz44cj1g8M1WkQbviZ0XVZ+c0/XTWBHiVnDu+/e5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692003255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ZG/EXWy0RVlNB1gv0Rdu33CQfwetyGKKBsf9BNZ5Uv8=;
        b=FuoYBzBPQZGyooNROspFQLk1jl1Gjrm5mC44rctA6htSZPfctejwAY7R8X5BfllugOI0v7
        xAM2PncP1FMMefCQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Pu Wen <puwen@hygon.cn>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>
Subject: [patch V4 26/41] x86/cpu: Use common topology code for Centaur and
 Zhaoxin
References: <20230814085006.593997112@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 14 Aug 2023 10:54:14 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Centaur and Zhaoxin CPUs use only the legacy SMP detection. Remove the
invocations from their 32bit path and exempt them from the call 64bit.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>

---
 arch/x86/kernel/cpu/centaur.c         |    4 ----
 arch/x86/kernel/cpu/topology_common.c |   11 ++++++++---
 arch/x86/kernel/cpu/zhaoxin.c         |    4 ----
 3 files changed, 8 insertions(+), 11 deletions(-)

--- a/arch/x86/kernel/cpu/centaur.c
+++ b/arch/x86/kernel/cpu/centaur.c
@@ -128,10 +128,6 @@ static void init_centaur(struct cpuinfo_
 #endif
 	early_init_centaur(c);
 	init_intel_cacheinfo(c);
-	detect_num_cpu_cores(c);
-#ifdef CONFIG_X86_32
-	detect_ht(c);
-#endif
 
 	if (c->cpuid_level > 9) {
 		unsigned int eax = cpuid_eax(10);
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -42,7 +42,7 @@ static unsigned int parse_num_cores(stru
 	return eax.ncores + 1;
 }
 
-static void __maybe_unused parse_legacy(struct topo_scan *tscan)
+static void parse_legacy(struct topo_scan *tscan)
 {
 	unsigned int cores, core_shift, smt_shift = 0;
 	struct cpuinfo_x86 *c = tscan->c;
@@ -71,10 +71,8 @@ bool topo_is_converted(struct cpuinfo_x8
 	/* Temporary until everything is converted over. */
 	switch (boot_cpu_data.x86_vendor) {
 	case X86_VENDOR_AMD:
-	case X86_VENDOR_CENTAUR:
 	case X86_VENDOR_INTEL:
 	case X86_VENDOR_HYGON:
-	case X86_VENDOR_ZHAOXIN:
 		return false;
 	default:
 		/* Let all UP systems use the below */
@@ -132,6 +130,13 @@ static void parse_topology(struct topo_s
 		return;
 
 	tscan->ebx1_nproc_shift = get_count_order(ebx.nproc);
+
+	switch (c->x86_vendor) {
+	case X86_VENDOR_CENTAUR:
+	case X86_VENDOR_ZHAOXIN:
+		parse_legacy(tscan);
+		break;
+	}
 }
 
 static void topo_set_ids(struct topo_scan *tscan)
--- a/arch/x86/kernel/cpu/zhaoxin.c
+++ b/arch/x86/kernel/cpu/zhaoxin.c
@@ -71,10 +71,6 @@ static void init_zhaoxin(struct cpuinfo_
 {
 	early_init_zhaoxin(c);
 	init_intel_cacheinfo(c);
-	detect_num_cpu_cores(c);
-#ifdef CONFIG_X86_32
-	detect_ht(c);
-#endif
 
 	if (c->cpuid_level > 9) {
 		unsigned int eax = cpuid_eax(10);



