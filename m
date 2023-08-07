Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6377726AE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234674AbjHGNyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbjHGNxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:53:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD9E1711
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:53:09 -0700 (PDT)
Message-ID: <20230807135027.588808550@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=IrlwyG1bzr7R52EqtilduQSm4PCjRDmOOCFPZIpHccM=;
        b=CuctpTbiRz/wJD5qxPJyWEZjXhE/AiIO/3JAvaUWdaR3Zx4gwPXvjNJhJ3LX6bS1X4fnBo
        pybUVpXMVOESSDu4FTLEv+0QgK/dCVfNtpcbzmoE4/wfTaC/s4c0KFrh+Coc2x9mudfRWI
        sqtOpLTaUajy8wIfNRvC7lKMRjpjKBzKldxJZKTsO76l4kVjWd87hzIDW70zvKkQ8i68lN
        IIVxYZRX8khwnqjWXGrjkMdJeooZWXZlAkCQZSJtquJ5dSyWYyONxblEexDyGlD009I81K
        EG45MK9MOpMQYOwaDfW33o5713X38mChqkh9qqMP1VzaqT+T4J/QsjIa0myqgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=IrlwyG1bzr7R52EqtilduQSm4PCjRDmOOCFPZIpHccM=;
        b=nzYIVBJXi35UKPVRUwOmLmZ4kSEOI3s1SERwuMB5niQ8qYLIBLW5qSWLjh8wg8VKjIRX4b
        f1X9qRA09Xsiw4DA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andy@infradead.org>
Subject: [patch 22/53] x86/apic: Use a proper define for invalid ACPI CPU ID
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:53:07 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ACPI ID for CPUs is preset with U32_MAX which is completely non
obvious. Use a proper define for it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/apic.h  |    2 ++
 arch/x86/kernel/apic/apic.c  |    2 +-
 arch/x86/xen/enlighten_hvm.c |    2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -46,6 +46,8 @@ extern void x86_32_probe_apic(void);
 static inline void x86_32_probe_apic(void) { }
 #endif
 
+#define CPU_ACPIID_INVALID	U32_MAX
+
 #ifdef CONFIG_X86_LOCAL_APIC
 
 extern int apic_verbosity;
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -111,7 +111,7 @@ static inline bool apic_accessible(void)
  * Map cpu index to physical APIC ID
  */
 DEFINE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_apicid, BAD_APICID);
-DEFINE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_acpiid, U32_MAX);
+DEFINE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_acpiid, CPU_ACPIID_INVALID);
 EXPORT_EARLY_PER_CPU_SYMBOL(x86_cpu_to_apicid);
 EXPORT_EARLY_PER_CPU_SYMBOL(x86_cpu_to_acpiid);
 
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -168,7 +168,7 @@ static int xen_cpu_up_prepare_hvm(unsign
 	 */
 	xen_uninit_lock_cpu(cpu);
 
-	if (cpu_acpi_id(cpu) != U32_MAX)
+	if (cpu_acpi_id(cpu) != CPU_ACPIID_INVALID)
 		per_cpu(xen_vcpu_id, cpu) = cpu_acpi_id(cpu);
 	else
 		per_cpu(xen_vcpu_id, cpu) = cpu;

