Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D99C77B4D2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbjHNIzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbjHNIyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:54:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1223612D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:54:15 -0700 (PDT)
Message-ID: <20230814085113.530288551@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692003253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=n2JIWQXMZsDripo49SW/KKqhdAhpMEcxQ76bjpW2vPI=;
        b=a/wx3tb/04GRjqTfTs+AIbluSHJlG7IKJxT8UWZDmO3bx0KwVoJqN9XCqexV7ZGbVqj/eV
        2jvV2JSktuK5H2A63+89bZHxjgc7ouirVWyaRFLx/J1C+6nN0hfpqW4xYzrT0FSbKEhqbk
        XwVra01v3/RDbQfmb4dHuU7Yvd1bGLA/F9eyJbTIc3xjGDsmgzhiduz7QgLLeg/gqdCual
        3B9h6/1pgmgcjN8B84cdHePWd3m6eNKQRajccf2JnMs1r3diWdAcLEvZKrQAvdQBYIQW+W
        xAMKng5QDIC9oLa/wA+MOm38Gphz6LHykZ7VYVj6X7Sc5k2dqNcV851UXNzjTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692003253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=n2JIWQXMZsDripo49SW/KKqhdAhpMEcxQ76bjpW2vPI=;
        b=Yab2ugCEn/xohHyMI2ZZi1wKA5RHPbIT1HMHEDaClMRJhQs0BUipACWeDiFR82hlUpWSFo
        PXztzKmbfydVQECw==
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
Subject: [patch V4 25/41] x86/cpu: Add legacy topology parser
References: <20230814085006.593997112@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 14 Aug 2023 10:54:13 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The legacy topology detection via CPUID leaf 4, which provides the number
of cores in the package and CPUID leaf 1 which provides the number of
logical CPUs in case that FEATURE_HT is enabled and the CMP_LEGACY feature
is not set, is shared for Intel, Centaur amd Zhaoxin CPUs.

Lift the code from common.c without the early detection hack and provide it
as common fallback mechanism.

Will be utilized in later changes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>

---
V4: Cure the off by one in fake_topology()

V3: Provide legacy data in leaf 0xb/0x1f format as expected by the rest of
    the code - Borislav
---
 arch/x86/kernel/cpu/common.c          |    3 ++
 arch/x86/kernel/cpu/topology.h        |    3 ++
 arch/x86/kernel/cpu/topology_common.c |   46 +++++++++++++++++++++++++++++++++-
 3 files changed, 51 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -883,6 +883,9 @@ void detect_ht(struct cpuinfo_x86 *c)
 #ifdef CONFIG_SMP
 	int index_msb, core_bits;
 
+	if (topo_is_converted(c))
+		return;
+
 	if (detect_ht_early(c) < 0)
 		return;
 
--- a/arch/x86/kernel/cpu/topology.h
+++ b/arch/x86/kernel/cpu/topology.h
@@ -6,6 +6,9 @@ struct topo_scan {
 	struct cpuinfo_x86	*c;
 	unsigned int		dom_shifts[TOPO_MAX_DOMAIN];
 	unsigned int		dom_ncpus[TOPO_MAX_DOMAIN];
+
+	// Legacy CPUID[1]:EBX[23:16] number of logical processors
+	unsigned int		ebx1_nproc_shift;
 };
 
 bool topo_is_converted(struct cpuinfo_x86 *c);
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -24,6 +24,48 @@ void topology_set_dom(struct topo_scan *
 	}
 }
 
+static unsigned int parse_num_cores(struct cpuinfo_x86 *c)
+{
+	struct {
+		u32	cache_type	:  5,
+			unused		: 21,
+			ncores		:  6;
+	} eax;
+
+	if (c->cpuid_level < 4)
+		return 1;
+
+	cpuid_subleaf_reg(4, 0, CPUID_EAX, &eax);
+	if (!eax.cache_type)
+		return 1;
+
+	return eax.ncores + 1;
+}
+
+static void __maybe_unused parse_legacy(struct topo_scan *tscan)
+{
+	unsigned int cores, core_shift, smt_shift = 0;
+	struct cpuinfo_x86 *c = tscan->c;
+
+	cores = parse_num_cores(c);
+	core_shift = get_count_order(cores);
+
+	if (cpu_has(c, X86_FEATURE_HT)) {
+		if (!WARN_ON_ONCE(tscan->ebx1_nproc_shift < core_shift))
+			smt_shift = tscan->ebx1_nproc_shift - core_shift;
+		/*
+		 * The parser expects leaf 0xb/0x1f format, which means
+		 * the number of logical processors at core level is
+		 * counting threads.
+		 */
+		core_shift += smt_shift;
+		cores <<= smt_shift;
+	}
+
+	topology_set_dom(tscan, TOPO_SMT_DOMAIN, smt_shift, 1U << smt_shift);
+	topology_set_dom(tscan, TOPO_CORE_DOMAIN, core_shift, cores);
+}
+
 bool topo_is_converted(struct cpuinfo_x86 *c)
 {
 	/* Temporary until everything is converted over. */
@@ -47,7 +89,7 @@ static bool fake_topology(struct topo_sc
 	 * which has useless CPUID information.
 	 */
 	topology_set_dom(tscan, TOPO_SMT_DOMAIN, 0, 1);
-	topology_set_dom(tscan, TOPO_CORE_DOMAIN, 1, 1);
+	topology_set_dom(tscan, TOPO_CORE_DOMAIN, 0, 1);
 
 	return tscan->c->cpuid_level < 1 || xen_pv_domain();
 }
@@ -88,6 +130,8 @@ static void parse_topology(struct topo_s
 	/* The above is sufficient for UP */
 	if (!IS_ENABLED(CONFIG_SMP))
 		return;
+
+	tscan->ebx1_nproc_shift = get_count_order(ebx.nproc);
 }
 
 static void topo_set_ids(struct topo_scan *tscan)



