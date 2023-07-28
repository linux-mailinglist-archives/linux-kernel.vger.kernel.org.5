Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C541C766CD4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236523AbjG1MO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235646AbjG1MNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:13:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE524219;
        Fri, 28 Jul 2023 05:13:11 -0700 (PDT)
Message-ID: <20230728120930.895466874@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690546390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=UqiiOrV6qFVmLayEKJExgkdA2s95N7jm4m59y0h1Wug=;
        b=fgQReNQdRn9/yvbqP/CdlFu5LxypeGGTwddlcC0s2G4u4MHGhhmMqNYZv7BFy91KwwEA0k
        bSRfOJloS28zA4wkd/8zyrawfF3UwJjhX/bEVbcYRI4u+JL8urA4X2WgJAEG69/NB8AD+1
        RG3xnrU98QmiXPR/m/3n8zmtF8FuOzGZZgTuUHPv5pDPovgODKVqPw+tLbarNZgkhxA/JR
        +9tTAIF7TKAs1nGuald5SFQdQcbI1MQCufZwoXIXudZQXh2dduR0mSnt3HgmxIE7QxqFKP
        hV8mZgmeqDTrdyf9VrN1C+26dFuz2qbJIbePoIoQ6/TMGacFEhs0bGVNUuPEeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690546390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=UqiiOrV6qFVmLayEKJExgkdA2s95N7jm4m59y0h1Wug=;
        b=yCt1+DeZ/St5T5qYw7lNG+ybbKk1llaPu80y6NgiEy+tqc+ASby7vzN4wQVwyFcdeT4YCe
        CS0ai21ctKzAMbAQ==
From:   Thomas Gleixner <tglx@linutronix.de>
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
Subject: [patch v2 22/38] x86/cpu: Add legacy topology parser
References: <20230728105650.565799744@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 28 Jul 2023 14:13:10 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
 arch/x86/kernel/cpu/common.c          |    3 ++
 arch/x86/kernel/cpu/topology.h        |    2 +
 arch/x86/kernel/cpu/topology_common.c |   37 ++++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+)

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
@@ -24,6 +24,41 @@ void topology_set_dom(struct topo_scan *
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
+	}
+
+	topology_set_dom(tscan, TOPO_SMT_DOMAIN, smt_shift, 1U << smt_shift);
+	topology_set_dom(tscan, TOPO_CORE_DOMAIN, core_shift, cores >> smt_shift);
+}
+
 bool topo_is_converted(struct cpuinfo_x86 *c)
 {
 	/* Temporary until everything is converted over. */
@@ -88,6 +123,8 @@ static void parse_topology(struct topo_s
 	/* The above is sufficient for UP */
 	if (!IS_ENABLED(CONFIG_SMP))
 		return;
+
+	tscan->ebx1_nproc_shift = get_count_order(ebx.nproc);
 }
 
 static void topo_set_ids(struct topo_scan *tscan)

