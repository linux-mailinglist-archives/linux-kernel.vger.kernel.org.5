Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1643775FE75
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjGXRsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjGXRqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:46:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4536219BF;
        Mon, 24 Jul 2023 10:44:40 -0700 (PDT)
Message-ID: <20230724172845.375121380@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690220677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=y/zw4jIEoXHpKelNkwXOESHKGmmFcaqzgwgGslsADMM=;
        b=oAZN3uUCR0PSr5PJdkrlNpzMccFxzFblCHzCCrxxH6UYiP4BqWDNHrmlUtJ+V2zl/kTSKO
        IfGKYDgZjAZIm0QNIuydsQz/GKlj5W5nzva5FjbYJndAIJQrTP7ED3lGVU7DlxGYKSqOzP
        8DdH9V6YAhQX3UdYYsJ7o9xihsdWjk/lE/ReVKe331qF+fSA6z0qwu97c4kwKBkz/fDqWo
        BO6+4FZx0HOVuTK0Kio1gALRb04/b6ArwIiG1dg967RKEmpqQv3aT4z3SMcgK4ObPM7z3H
        F6HZVCLSdvdtQ3fuv01KoxuoU1e6UcaGEPVAUXfHCmG36mcWnQ+h36K9Y+oEBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690220677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=y/zw4jIEoXHpKelNkwXOESHKGmmFcaqzgwgGslsADMM=;
        b=EPz5lOl9GlUQTZX3HOCC0E5JSvUep+0rIrlU5Xpi8RRsrw+HgmfYYllhgvvLn4igKQ1gH1
        sKfUxAitOmRV+lBA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [patch 29/29] x86/apic/uv: Remove the private leaf 0xb parser
References: <20230724155329.474037902@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Jul 2023 19:44:36 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The package shift has been already evaluated by the early CPU init.

Put the mindless copy right next to the original leaf 0xb parser.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Steve Wahl <steve.wahl@hpe.com>
Cc: Mike Travis <mike.travis@hpe.com>
Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Cc: Russ Anderson <russ.anderson@hpe.com>
---
 arch/x86/include/asm/topology.h    |    5 +++
 arch/x86/kernel/apic/x2apic_uv_x.c |   52 ++++++-------------------------------
 2 files changed, 14 insertions(+), 43 deletions(-)

--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -126,6 +126,11 @@ static inline unsigned int topology_get_
 	return x86_topo_system.dom_size[dom];
 }
 
+static inline unsigned int topology_get_domain_shift(enum x86_topology_domains dom)
+{
+	return dom == TOPO_SMT_DOMAIN ? 0 : x86_topo_system.dom_shifts[dom - 1];
+}
+
 extern const struct cpumask *cpu_coregroup_mask(int cpu);
 extern const struct cpumask *cpu_clustergroup_mask(int cpu);
 
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -241,54 +241,20 @@ static void __init uv_tsc_check_sync(voi
 	is_uv(UV3) ? sname.s3.field :		\
 	undef)
 
-/* [Copied from arch/x86/kernel/cpu/topology.c:detect_extended_topology()] */
-
-#define SMT_LEVEL			0	/* Leaf 0xb SMT level */
-#define INVALID_TYPE			0	/* Leaf 0xb sub-leaf types */
-#define SMT_TYPE			1
-#define CORE_TYPE			2
-#define LEAFB_SUBTYPE(ecx)		(((ecx) >> 8) & 0xff)
-#define BITS_SHIFT_NEXT_LEVEL(eax)	((eax) & 0x1f)
-
-static void set_x2apic_bits(void)
-{
-	unsigned int eax, ebx, ecx, edx, sub_index;
-	unsigned int sid_shift;
-
-	cpuid(0, &eax, &ebx, &ecx, &edx);
-	if (eax < 0xb) {
-		pr_info("UV: CPU does not have CPUID.11\n");
-		return;
-	}
-
-	cpuid_count(0xb, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
-	if (ebx == 0 || (LEAFB_SUBTYPE(ecx) != SMT_TYPE)) {
-		pr_info("UV: CPUID.11 not implemented\n");
-		return;
-	}
-
-	sid_shift = BITS_SHIFT_NEXT_LEVEL(eax);
-	sub_index = 1;
-	do {
-		cpuid_count(0xb, sub_index, &eax, &ebx, &ecx, &edx);
-		if (LEAFB_SUBTYPE(ecx) == CORE_TYPE) {
-			sid_shift = BITS_SHIFT_NEXT_LEVEL(eax);
-			break;
-		}
-		sub_index++;
-	} while (LEAFB_SUBTYPE(ecx) != INVALID_TYPE);
-
-	uv_cpuid.apicid_shift	= 0;
-	uv_cpuid.apicid_mask	= (~(-1 << sid_shift));
-	uv_cpuid.socketid_shift = sid_shift;
-}
-
 static void __init early_get_apic_socketid_shift(void)
 {
+	unsigned int sid_shift = topology_get_domain_shift(TOPO_ROOT_DOMAIN);
+
 	if (is_uv2_hub() || is_uv3_hub())
 		uvh_apicid.v = uv_early_read_mmr(UVH_APICID);
 
-	set_x2apic_bits();
+	if (sid_shift) {
+		uv_cpuid.apicid_shift	= 0;
+		uv_cpuid.apicid_mask	= (~(-1 << sid_shift));
+		uv_cpuid.socketid_shift = sid_shift;
+	} else {
+		pr_info("UV: CPU does not have valid CPUID.11\n");
+	}
 
 	pr_info("UV: apicid_shift:%d apicid_mask:0x%x\n", uv_cpuid.apicid_shift, uv_cpuid.apicid_mask);
 	pr_info("UV: socketid_shift:%d pnode_mask:0x%x\n", uv_cpuid.socketid_shift, uv_cpuid.pnode_mask);

