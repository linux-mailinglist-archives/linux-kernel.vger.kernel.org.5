Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157B37677BA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 23:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbjG1Vdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 17:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234246AbjG1Vdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 17:33:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498013C28;
        Fri, 28 Jul 2023 14:33:42 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690580020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oiDNvvnaTIjtsRMkHj7H+VFnnQVjNPT385nNORFBnFs=;
        b=fBtBpQywRQUgIqAivpULuqrYIhQWo7UjB5VdeMDv2f3fLjOjkNZ4kVgy8ZMN4lpUfsr7b5
        U9MbG4nDVMdm6sYshyi80IBVn9E3TMD/m1iBolOIctPV3Pxcn5gTeS3tWaXNKgo+NWi8KQ
        90Oi9TG1qQ/GUP+NlIMECQkUUYAcH/OJ1hhaAAJ0Jfzs1UnnujJUb2Kg2iurrL25y6Mw6E
        l9EugJ0INaJVjGzIaRBKYH4ZLZO3/r41DQcnY0Aq2hpbDACHjZIneFadNVXSDtSfdxOA27
        Qybh0gJCqadQ2z+JG5ZmFLV1e/caIYCajhJ3dfaV0Tbw762eDAfMSHxAPBUvyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690580020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oiDNvvnaTIjtsRMkHj7H+VFnnQVjNPT385nNORFBnFs=;
        b=xwTE4brRfYL5nS0h/ImssqAZ4O3mk80H2waaQMSH2WNeSxG0Tj8L3baKS6BmvmGxo6o2V8
        /brRoHuBnwKthvCw==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: [patch v2A 22/38] x86/cpu: Add legacy topology parser
In-Reply-To: <20230728120930.895466874@linutronix.de>
References: <20230728105650.565799744@linutronix.de>
 <20230728120930.895466874@linutronix.de>
Date:   Fri, 28 Jul 2023 23:33:40 +0200
Message-ID: <873517raa3.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28 2023 at 14:13, Thomas Gleixner wrote:
> The legacy topology detection via CPUID leaf 4, which provides the number
> of cores in the package and CPUID leaf 1 which provides the number of
> logical CPUs in case that FEATURE_HT is enabled and the CMP_LEGACY feature
> is not set, is shared for Intel, Centaur amd Zhaoxin CPUs.
>
> Lift the code from common.c without the early detection hack and provide it
> as common fallback mechanism.

Here I completely failed to get it right. Why?

My mind was so focussed on the leaf 0xb/0x1f representation that I
completely missed that the legacy parser does not fit into that picture
at all. I did some tests on 32bit in a VM as I really do not have
functional 32bit hardware anymore and they all worked. Not that I tried
hard.

Unfortunately Borislav decided to give it a ride on a real 32bit ATOM
system and unearthed my snafu.

Replacement patch below and also pushed out to the:

 git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/topology

branch w/o a tag attached.

Thanks,

        tglx
---
Subject: x86/cpu: Add legacy topology parser
From: Thomas Gleixner <tglx@linutronix.de>
Date: Sun, 02 Jul 2023 13:20:08 +0200

The legacy topology detection via CPUID leaf 4, which provides the number
of cores in the package and CPUID leaf 1 which provides the number of
logical CPUs in case that FEATURE_HT is enabled and the CMP_LEGACY feature
is not set, is shared for Intel, Centaur amd Zhaoxin CPUs.

Lift the code from common.c without the early detection hack and provide it
as common fallback mechanism.

Will be utilized in later changes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2A: Fix the 32bit snafu.
---
 arch/x86/kernel/cpu/common.c          |    3 ++
 arch/x86/kernel/cpu/topology.h        |    2 +
 arch/x86/kernel/cpu/topology_common.c |   44 ++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+)

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
@@ -7,6 +7,8 @@ struct topo_scan {
 	unsigned int		dom_shifts[TOPO_MAX_DOMAIN];
 	unsigned int		dom_ncpus[TOPO_MAX_DOMAIN];
 
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

