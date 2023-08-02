Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BDD76CAC4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 12:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbjHBKYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 06:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbjHBKXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 06:23:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859742D53
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 03:21:59 -0700 (PDT)
Message-ID: <20230802101934.082613843@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690971696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=rZqB67Sk2gUXfKuY71aQHEPAlesadOxF6WZW7Os2C5w=;
        b=WSHt4yYhmEvIgUgQUcGM0O3kAS+Y23QA7EqWKf4qdV2wOaPu1Fwi/crnkwcTHsqK/LV6E8
        pyboGeGhZwYqLgHrEQZF9V0133AJGx40I1zy6U4UllO5WHFosiedc708ITMkKgupvD4pCd
        InbE3H+xRTF0MtV5ndQlGHA2kodHlnFbFg6+m5RURwcF3e6e5yxJAmjUadBh65EYAV/RD4
        QE/s7HkS8qRAT/KLGLqu0fkmtUXGSGSjEXfTrHWjQEIwLmt9mLbcJTAjySHb7fu+TpJrAi
        NEeFtR5tvAAolXcDZ4WrkXX8Rq9lAVxrLCLth73vPdxZoCZbeOXoQOeIGcfUUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690971696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=rZqB67Sk2gUXfKuY71aQHEPAlesadOxF6WZW7Os2C5w=;
        b=b/5z8nc4c60NqymQzxubjmBcMOzOBeyJepXj1G0UdWCVfxgROJ+c/ZgXnd1KbZgVk/WW/x
        WsIxjpYXIcGIH8BA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: [patch V3 24/40] x86/cpu: Add legacy topology parser
References: <20230802101635.459108805@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Wed,  2 Aug 2023 12:21:35 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
---
V3: Provide legacy data in leaf 0xb/0x1f format as expected by the rest of
    the code - Borislav
---
 arch/x86/kernel/cpu/common.c          |    3 ++
 arch/x86/kernel/cpu/topology.h        |    3 ++
 arch/x86/kernel/cpu/topology_common.c |   44 ++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+)

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
@@ -88,6 +130,8 @@ static void parse_topology(struct topo_s
 	/* The above is sufficient for UP */
 	if (!IS_ENABLED(CONFIG_SMP))
 		return;
+
+	tscan->ebx1_nproc_shift = get_count_order(ebx.nproc);
 }
 
 static void topo_set_ids(struct topo_scan *tscan)

