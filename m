Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F297B5205
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237030AbjJBMBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236913AbjJBMA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:00:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6006310DF
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 05:00:09 -0700 (PDT)
Message-ID: <20231002115903.603100036@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696248007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=5EsTuHLRMt+mh9/+wwjfJDEI240zRMwQu4qtcC7nL1o=;
        b=qd/2H/aFUJYfk8KibD6cLXHb5wEHvYX+MnYSKe/WS5NDDePcCyAY4LHkPjB7Z3vOc4ZLEe
        YwL3e61xl1Io+zXV4c49mtYPSCSgPsTKs1OgsieKcendVlcG8I8M/TA1orXwYltxMWbbPr
        dcRxzQkwCGV2bcOrGiQTOtynWbU9OwkziUh1P1tytFqDsoqGuwdBVgXyEkl08CLgUm6PsE
        fXFmmlN4GbmwpGEa0VvCNE1Fv8EaNGGNAIAWJrSnbbTU5vDxCBzySCoChTXy7nm+2JSGAz
        6MAwQa2ZoJkdTRk6DJnotYdh4LEQNSURjVJFthThMzmhJijKhNs9W+/vVq8YAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696248007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=5EsTuHLRMt+mh9/+wwjfJDEI240zRMwQu4qtcC7nL1o=;
        b=ryCH/3XgkECu6G8UUOUuZ1zNz5hXCqWApEXN64Zbqbbn/wJywPUDwPctd4dIXEEB4fqprk
        bINwDxRREKmPcBCw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V4 27/30] x86/apic: Provide apic_force_nmi_on_cpu()
References: <20231002115506.217091296@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  2 Oct 2023 14:00:07 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

When SMT siblings are soft-offlined and parked in one of the play_dead()
variants they still react on NMI, which is problematic on affected Intel
CPUs. The default play_dead() variant uses MWAIT on modern CPUs, which is
not guaranteed to be safe when updated concurrently.

Right now late loading is prevented when not all SMT siblings are online,
but as they still react on NMI, it is possible to bring them out of their
park position into a trivial rendevouz handler.

Provide a function which allows to do that. I does sanity checks whether
the target is in the cpus_booted_once_mask and whether the APIC driver
supports it.

Mark X2APIC and XAPIC as capable, but exclude 32bit and the UV and NUMACHIP
variants as that needs feedback from the relevant experts.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/include/asm/apic.h           |    5 ++++-
 arch/x86/kernel/apic/apic_flat_64.c   |    2 ++
 arch/x86/kernel/apic/ipi.c            |    8 ++++++++
 arch/x86/kernel/apic/x2apic_cluster.c |    1 +
 arch/x86/kernel/apic/x2apic_phys.c    |    1 +
 5 files changed, 16 insertions(+), 1 deletion(-)
---
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -276,7 +276,8 @@ struct apic {
 
 	u32	disable_esr		: 1,
 		dest_mode_logical	: 1,
-		x2apic_set_max_apicid	: 1;
+		x2apic_set_max_apicid	: 1,
+		nmi_to_offline_cpu	: 1;
 
 	u32	(*calc_dest_apicid)(unsigned int cpu);
 
@@ -542,6 +543,8 @@ extern bool default_check_apicid_used(ph
 extern void default_ioapic_phys_id_map(physid_mask_t *phys_map, physid_mask_t *retmap);
 extern int default_cpu_present_to_apicid(int mps_cpu);
 
+void apic_send_nmi_to_offline_cpu(unsigned int cpu);
+
 #else /* CONFIG_X86_LOCAL_APIC */
 
 static inline unsigned int read_apic_id(void) { return 0; }
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -103,6 +103,7 @@ static struct apic apic_flat __ro_after_
 	.send_IPI_allbutself		= default_send_IPI_allbutself,
 	.send_IPI_all			= default_send_IPI_all,
 	.send_IPI_self			= default_send_IPI_self,
+	.nmi_to_offline_cpu		= true,
 
 	.read				= native_apic_mem_read,
 	.write				= native_apic_mem_write,
@@ -175,6 +176,7 @@ static struct apic apic_physflat __ro_af
 	.send_IPI_allbutself		= default_send_IPI_allbutself,
 	.send_IPI_all			= default_send_IPI_all,
 	.send_IPI_self			= default_send_IPI_self,
+	.nmi_to_offline_cpu		= true,
 
 	.read				= native_apic_mem_read,
 	.write				= native_apic_mem_write,
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -97,6 +97,14 @@ void native_send_call_func_ipi(const str
 	__apic_send_IPI_mask(mask, CALL_FUNCTION_VECTOR);
 }
 
+void apic_send_nmi_to_offline_cpu(unsigned int cpu)
+{
+	if (WARN_ON_ONCE(!apic->nmi_to_offline_cpu))
+		return;
+	if (WARN_ON_ONCE(!cpumask_test_cpu(cpu, &cpus_booted_once_mask)))
+		return;
+	apic->send_IPI(cpu, NMI_VECTOR);
+}
 #endif /* CONFIG_SMP */
 
 static inline int __prepare_ICR2(unsigned int mask)
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -251,6 +251,7 @@ static struct apic apic_x2apic_cluster _
 	.send_IPI_allbutself		= x2apic_send_IPI_allbutself,
 	.send_IPI_all			= x2apic_send_IPI_all,
 	.send_IPI_self			= x2apic_send_IPI_self,
+	.nmi_to_offline_cpu		= true,
 
 	.read				= native_apic_msr_read,
 	.write				= native_apic_msr_write,
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -166,6 +166,7 @@ static struct apic apic_x2apic_phys __ro
 	.send_IPI_allbutself		= x2apic_send_IPI_allbutself,
 	.send_IPI_all			= x2apic_send_IPI_all,
 	.send_IPI_self			= x2apic_send_IPI_self,
+	.nmi_to_offline_cpu		= true,
 
 	.read				= native_apic_msr_read,
 	.write				= native_apic_msr_write,

