Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5F77D5177
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbjJXNVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234491AbjJXNUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:20:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B144CC;
        Tue, 24 Oct 2023 06:20:52 -0700 (PDT)
Date:   Tue, 24 Oct 2023 13:20:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698153650;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DHzz0+pu/Bt+oTOij9+XCvthouCL+Q3kebi5Xyb+BW0=;
        b=QCJl0h75L0nnclWUZfu7bKoespitIoBl/ynk0pSjtvEHqPtbdMTJPnP5ggvVsF7WEBndY0
        2cRQO6lzTmfs70XYd1rtHeRUaiHEaSQTy5Sb4ZtNfCIEkKpl6xmd8lkW9hLkqaC6jFjOgB
        TYTEIYtGkS49HYzaLUEI8YZyX6MwrwCxXqRGyEtjMLgd85hc7KUm9X5h1WsALN4dlYX0RG
        xcCuvvRMXanrQmnD8lK0tew73CINBOAsg2awp+gtB3iGAQmI1C57srXVl1sG2l42k50Q3Q
        rTqyn4xXQq3hZRX0b6hS++5O3k10CruugNPxiGBhFX0iMyscLF199lNN22Igug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698153650;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DHzz0+pu/Bt+oTOij9+XCvthouCL+Q3kebi5Xyb+BW0=;
        b=dVX3FEXyB3m3opVTE1Y84UwGRcajmZwPWTBiYcxIyVmLQUh7cFaP6pOHCaiMvREHq3Se/H
        lNBaoD3Sr+/XqBDw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/apic: Provide apic_force_nmi_on_cpu()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231002115903.603100036@linutronix.de>
References: <20231002115903.603100036@linutronix.de>
MIME-Version: 1.0
Message-ID: <169815365016.3135.17531359789109646623.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     9cab5fb776d4367e26950cf759211e948335288e
Gitweb:        https://git.kernel.org/tip/9cab5fb776d4367e26950cf759211e948335288e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 02 Oct 2023 14:00:07 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 24 Oct 2023 15:05:55 +02:00

x86/apic: Provide apic_force_nmi_on_cpu()

When SMT siblings are soft-offlined and parked in one of the play_dead()
variants they still react on NMI, which is problematic on affected Intel
CPUs. The default play_dead() variant uses MWAIT on modern CPUs, which is
not guaranteed to be safe when updated concurrently.

Right now late loading is prevented when not all SMT siblings are online,
but as they still react on NMI, it is possible to bring them out of their
park position into a trivial rendezvous handler.

Provide a function which allows to do that. I does sanity checks whether
the target is in the cpus_booted_once_mask and whether the APIC driver
supports it.

Mark X2APIC and XAPIC as capable, but exclude 32bit and the UV and NUMACHIP
variants as that needs feedback from the relevant experts.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231002115903.603100036@linutronix.de
---
 arch/x86/include/asm/apic.h           | 5 ++++-
 arch/x86/kernel/apic/apic_flat_64.c   | 2 ++
 arch/x86/kernel/apic/ipi.c            | 8 ++++++++
 arch/x86/kernel/apic/x2apic_cluster.c | 1 +
 arch/x86/kernel/apic/x2apic_phys.c    | 1 +
 5 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 5af4ec1..17f2f28 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -276,7 +276,8 @@ struct apic {
 
 	u32	disable_esr		: 1,
 		dest_mode_logical	: 1,
-		x2apic_set_max_apicid	: 1;
+		x2apic_set_max_apicid	: 1,
+		nmi_to_offline_cpu	: 1;
 
 	u32	(*calc_dest_apicid)(unsigned int cpu);
 
@@ -542,6 +543,8 @@ extern bool default_check_apicid_used(physid_mask_t *map, int apicid);
 extern void default_ioapic_phys_id_map(physid_mask_t *phys_map, physid_mask_t *retmap);
 extern int default_cpu_present_to_apicid(int mps_cpu);
 
+void apic_send_nmi_to_offline_cpu(unsigned int cpu);
+
 #else /* CONFIG_X86_LOCAL_APIC */
 
 static inline unsigned int read_apic_id(void) { return 0; }
diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index 032a84e..cd16228 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -103,6 +103,7 @@ static struct apic apic_flat __ro_after_init = {
 	.send_IPI_allbutself		= default_send_IPI_allbutself,
 	.send_IPI_all			= default_send_IPI_all,
 	.send_IPI_self			= default_send_IPI_self,
+	.nmi_to_offline_cpu		= true,
 
 	.read				= native_apic_mem_read,
 	.write				= native_apic_mem_write,
@@ -175,6 +176,7 @@ static struct apic apic_physflat __ro_after_init = {
 	.send_IPI_allbutself		= default_send_IPI_allbutself,
 	.send_IPI_all			= default_send_IPI_all,
 	.send_IPI_self			= default_send_IPI_self,
+	.nmi_to_offline_cpu		= true,
 
 	.read				= native_apic_mem_read,
 	.write				= native_apic_mem_write,
diff --git a/arch/x86/kernel/apic/ipi.c b/arch/x86/kernel/apic/ipi.c
index a44ba72..edad86f 100644
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -97,6 +97,14 @@ sendmask:
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
diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index affbff6..a830608 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -251,6 +251,7 @@ static struct apic apic_x2apic_cluster __ro_after_init = {
 	.send_IPI_allbutself		= x2apic_send_IPI_allbutself,
 	.send_IPI_all			= x2apic_send_IPI_all,
 	.send_IPI_self			= x2apic_send_IPI_self,
+	.nmi_to_offline_cpu		= true,
 
 	.read				= native_apic_msr_read,
 	.write				= native_apic_msr_write,
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index 788cdb4..c8ac1b1 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -166,6 +166,7 @@ static struct apic apic_x2apic_phys __ro_after_init = {
 	.send_IPI_allbutself		= x2apic_send_IPI_allbutself,
 	.send_IPI_all			= x2apic_send_IPI_all,
 	.send_IPI_self			= x2apic_send_IPI_self,
+	.nmi_to_offline_cpu		= true,
 
 	.read				= native_apic_msr_read,
 	.write				= native_apic_msr_write,
