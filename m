Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC1D75FE3E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjGXRqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbjGXRpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:45:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F031FF0;
        Mon, 24 Jul 2023 10:44:18 -0700 (PDT)
Message-ID: <20230724172844.573913057@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690220654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=8j9Csrsczl1+89ZENZFtTchVmi22SuFWjwFyU4WiA04=;
        b=YDb5v+O494aJ4RQ+VMPPPal+QNfYQIrm+BfHcK4PzNsYn/4yHP5piBS3Ekvy3r9Y+oUHJR
        hV0NPmwhXQZBlFQITLnml/s1us83aAeWjkHu2lXT2vHjPtJAkXmDeXXdr8786TzXWa6Vlc
        WrK3WafCfY6bEVY4eJJow/2U2ka70GbsoPmhUzQWabo/QjUsXIktTX3w2cb3bJst3eiV5j
        zPfLu3/xi1ioWa48qCngkmzS8mSTJmzLg0Cnh0XRsIHaBwJEOD773NDZloMA2m9RAwFMzi
        F1cwnJooH8mIxbGT7acnhS4/iQgu5owfwv8rZs09hYHgcvqHneVVJ6TyBxg9JA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690220654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=8j9Csrsczl1+89ZENZFtTchVmi22SuFWjwFyU4WiA04=;
        b=kCJGQ/5WJB4iVkXUeJPyDDik+x7GzLuVyzvKm8TCwd9mEeO15OlI3YalnMdDMzo7wcIJGP
        u4oMPe5sIsGymYDg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: [patch 15/29] x86/cpu: Use common topology code for Centaur and
 Zhaoxin
References: <20230724155329.474037902@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Jul 2023 19:44:14 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Centaur and Zhaoxin CPUs use only the legacy SMP detection. Remove the
invocations from their 32bit path and exempt them from the call 64bit.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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
@@ -64,10 +64,8 @@ bool topo_is_converted(struct cpuinfo_x8
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
@@ -125,6 +123,13 @@ static void parse_topology(struct topo_s
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

