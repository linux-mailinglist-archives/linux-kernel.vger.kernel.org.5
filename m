Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27294778075
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235787AbjHJSji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235958AbjHJSjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:39:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F2D3AB7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:38:35 -0700 (PDT)
Message-ID: <20230810160806.506010083@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691692686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=KXmWi+498NlTG+8QbtY9G0BWF4sNUEz4Qvdk7zq0Ox4=;
        b=2yfFPqVqwC1UiB2xLp4JD4uI//CEWRSXljATSIrPMMRU9OCUMS3NKxgEnWpp+sNqTy7BYN
        WN35mdONac/s+MlFJGRw34qku9KLT58+vfjJ9ul9OwWrx5UpOGLKGyfkXb8xkPQyJaCNkD
        GfcKWv4DIpaLlD/CWcJKtvdHssdU2yJvFF+tMYmXEDeOWmGhSzySpKKK93XLdioBUzCNJ/
        JwiEp6HQ3KsI5iV1ek5McY5nUMHJP76z6aYBAJ/4Rarsj6w91nbS3kRzi6A3O8wjCzDw2U
        j9m3FUpcE4qCaCywul71XanbvrNIuNZWcSTS+kTfRQQo+1/j9zpPCiUDPg3liw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691692686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=KXmWi+498NlTG+8QbtY9G0BWF4sNUEz4Qvdk7zq0Ox4=;
        b=MYXcUVgor8U2LoMdsSSnv3y9xcLW/xFpVjjRNP88uPjFXxta9KQ6qcWlaWn6e08c32ZVJx
        zO3m/y0HiW5DwmCw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: [patch 27/30] x86/apic: Provide apic_force_nmi_on_cpu()
References: <20230810153317.850017756@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 10 Aug 2023 20:38:06 +0200 (CEST)
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
 arch/x86/include/asm/apic.h           |  5 +++++
 arch/x86/kernel/apic/apic_flat_64.c   |  2 ++
 arch/x86/kernel/apic/ipi.c            |  9 ++++++++-
 arch/x86/kernel/apic/x2apic_cluster.c |  1 +
 arch/x86/kernel/apic/x2apic_phys.c    |  1 +
 5 files changed, 17 insertions(+), 1 deletion(-)
---
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 98c32aa5963a..e219e6c62138 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -301,6 +301,9 @@ struct apic {
 	enum apic_delivery_modes delivery_mode;
 	bool	dest_mode_logical;
 
+	/* Allows to send an NMI to an "offline" CPU which hangs in *play_dead() */
+	bool	nmi_to_offline_cpu;
+
 	u32	(*calc_dest_apicid)(unsigned int cpu);
 
 	/* ICR related functions */
@@ -505,6 +508,8 @@ extern void default_ioapic_phys_id_map(physid_mask_t *phys_map, physid_mask_t *r
 extern int default_cpu_present_to_apicid(int mps_cpu);
 extern int default_check_phys_apicid_present(int phys_apicid);
 
+void apic_send_nmi_to_offline_cpu(unsigned int cpu);
+
 #endif /* CONFIG_X86_LOCAL_APIC */
 
 #ifdef CONFIG_SMP
diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index 8f72b4351c9f..4340f471e6a6 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -138,6 +138,7 @@ static struct apic apic_flat __ro_after_init = {
 	.send_IPI_allbutself		= default_send_IPI_allbutself,
 	.send_IPI_all			= default_send_IPI_all,
 	.send_IPI_self			= default_send_IPI_self,
+	.nmi_to_offline_cpu		= true,
 
 	.inquire_remote_apic		= default_inquire_remote_apic,
 
@@ -229,6 +230,7 @@ static struct apic apic_physflat __ro_after_init = {
 	.send_IPI_allbutself		= default_send_IPI_allbutself,
 	.send_IPI_all			= default_send_IPI_all,
 	.send_IPI_self			= default_send_IPI_self,
+	.nmi_to_offline_cpu		= true,
 
 	.inquire_remote_apic		= default_inquire_remote_apic,
 
diff --git a/arch/x86/kernel/apic/ipi.c b/arch/x86/kernel/apic/ipi.c
index 2a6509e8c840..6ee6cce4423a 100644
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -95,8 +95,15 @@ void native_send_call_func_ipi(const struct cpumask *mask)
 	apic->send_IPI_mask(mask, CALL_FUNCTION_VECTOR);
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
-
 static inline int __prepare_ICR2(unsigned int mask)
 {
 	return SET_XAPIC_DEST_FIELD(mask);
diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index b2b2b7f3e03f..685437a98463 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -264,6 +264,7 @@ static struct apic apic_x2apic_cluster __ro_after_init = {
 	.send_IPI_allbutself		= x2apic_send_IPI_allbutself,
 	.send_IPI_all			= x2apic_send_IPI_all,
 	.send_IPI_self			= x2apic_send_IPI_self,
+	.nmi_to_offline_cpu		= true,
 
 	.inquire_remote_apic		= NULL,
 
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index 896bc41cb2ba..d5e44cb7e15f 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -188,6 +188,7 @@ static struct apic apic_x2apic_phys __ro_after_init = {
 	.send_IPI_allbutself		= x2apic_send_IPI_allbutself,
 	.send_IPI_all			= x2apic_send_IPI_all,
 	.send_IPI_self			= x2apic_send_IPI_self,
+	.nmi_to_offline_cpu		= true,
 
 	.inquire_remote_apic		= NULL,
 

