Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7CB776A56
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbjHIUhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234636AbjHIUg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:36:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6AA26A8;
        Wed,  9 Aug 2023 13:36:18 -0700 (PDT)
Date:   Wed, 09 Aug 2023 20:36:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691613376;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=A05VvloB8zhaDVVwxSRAobtCNTh242+0UOoIUsfHW3g=;
        b=dRW6We3hWfm2/WlYajh7nr2dW+Z2vAkKZF42KmQQEar7m9aI3xs8ImuvKlfx6B9AOybk4A
        2iEZUKDkDCwlx6wQZEHGTrSQEzTgrQKVg27FNcziI1btdsdXzSSY+1V66w63pUOfRVy8Ww
        LQVKY0CjDVSMx0gSrac62xegNoHakBk5djQEdzNpoUAgR2dXrJCnM3VgDUy9asr+HshVRa
        qmUGmCrlQggas0DQUSoP+WVSkLoW3/Vtly2ip3dVCjU3Ch7cIIL6twrulY8L4bxQZajJQP
        9s2+crO0JIvO/zdI/T65ZvIHNdEO/toDv3ieS7+n/qx7ebLLqTsbq1tz4eldZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691613376;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=A05VvloB8zhaDVVwxSRAobtCNTh242+0UOoIUsfHW3g=;
        b=V34RGZBPYTWgz6UoFSy1e4y70YO6sDDmbQ/QWCdW2CTugW8M48vzRH2Tfkx3j0ImpHTtLt
        aYyEU8IPGPPh0IAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Allow apic::wait_icr_idle() to be NULL
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169161337606.27769.17418665169931125450.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     ee513d9da315592c27daa3cf5ce9ec2747b2bacd
Gitweb:        https://git.kernel.org/tip/ee513d9da315592c27daa3cf5ce9ec2747b2bacd
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:04:04 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 11:58:28 -07:00

x86/apic: Allow apic::wait_icr_idle() to be NULL

Nuke more NOOP callbacks and make the invocation conditional. Will be
replaced with a static call later.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
---
 arch/x86/include/asm/apic.h           |  9 ++-------
 arch/x86/kernel/apic/apic_noop.c      |  2 --
 arch/x86/kernel/apic/apic_numachip.c  |  7 -------
 arch/x86/kernel/apic/x2apic_cluster.c |  1 -
 arch/x86/kernel/apic/x2apic_phys.c    |  1 -
 arch/x86/kernel/apic/x2apic_uv_x.c    |  1 -
 arch/x86/xen/apic.c                   |  5 -----
 7 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 1499865..397cd5f 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -206,12 +206,6 @@ static inline u32 native_apic_msr_read(u32 reg)
 	return (u32)msr;
 }
 
-static inline void native_x2apic_wait_icr_idle(void)
-{
-	/* no need to wait for icr idle in x2apic */
-	return;
-}
-
 static inline u32 native_safe_x2apic_wait_icr_idle(void)
 {
 	/* no need to wait for icr idle in x2apic */
@@ -376,7 +370,8 @@ static inline void apic_icr_write(u32 low, u32 high)
 
 static inline void apic_wait_icr_idle(void)
 {
-	apic->wait_icr_idle();
+	if (apic->wait_icr_idle)
+		apic->wait_icr_idle();
 }
 
 static inline u32 safe_apic_wait_icr_idle(void)
diff --git a/arch/x86/kernel/apic/apic_noop.c b/arch/x86/kernel/apic/apic_noop.c
index c73a7a8..ef31a2e 100644
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -20,7 +20,6 @@ static void noop_send_IPI_mask_allbutself(const struct cpumask *cpumask, int vec
 static void noop_send_IPI_allbutself(int vector) { }
 static void noop_send_IPI_all(int vector) { }
 static void noop_send_IPI_self(int vector) { }
-static void noop_apic_wait_icr_idle(void) { }
 static void noop_apic_icr_write(u32 low, u32 id) { }
 
 static int noop_wakeup_secondary_cpu(int apicid, unsigned long start_eip)
@@ -105,6 +104,5 @@ struct apic apic_noop __ro_after_init = {
 	.eoi_write			= noop_apic_write,
 	.icr_read			= noop_apic_icr_read,
 	.icr_write			= noop_apic_icr_write,
-	.wait_icr_idle			= noop_apic_wait_icr_idle,
 	.safe_wait_icr_idle		= noop_safe_apic_wait_icr_idle,
 };
diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/apic_numachip.c
index e8e13d7..647ed77 100644
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -223,11 +223,6 @@ static int numachip2_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
 	return 1;
 }
 
-/* APIC IPIs are queued */
-static void numachip_apic_wait_icr_idle(void)
-{
-}
-
 /* APIC NMI IPIs are queued */
 static u32 numachip_safe_apic_wait_icr_idle(void)
 {
@@ -269,7 +264,6 @@ static const struct apic apic_numachip1 __refconst = {
 	.eoi_write			= native_apic_mem_write,
 	.icr_read			= native_apic_icr_read,
 	.icr_write			= native_apic_icr_write,
-	.wait_icr_idle			= numachip_apic_wait_icr_idle,
 	.safe_wait_icr_idle		= numachip_safe_apic_wait_icr_idle,
 };
 
@@ -310,7 +304,6 @@ static const struct apic apic_numachip2 __refconst = {
 	.eoi_write			= native_apic_mem_write,
 	.icr_read			= native_apic_icr_read,
 	.icr_write			= native_apic_icr_write,
-	.wait_icr_idle			= numachip_apic_wait_icr_idle,
 	.safe_wait_icr_idle		= numachip_safe_apic_wait_icr_idle,
 };
 
diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index 705b33d..7ceef70 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -266,7 +266,6 @@ static struct apic apic_x2apic_cluster __ro_after_init = {
 	.eoi_write			= native_apic_msr_eoi_write,
 	.icr_read			= native_x2apic_icr_read,
 	.icr_write			= native_x2apic_icr_write,
-	.wait_icr_idle			= native_x2apic_wait_icr_idle,
 	.safe_wait_icr_idle		= native_safe_x2apic_wait_icr_idle,
 };
 
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index e0fdbf5..c1ab678 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -180,7 +180,6 @@ static struct apic apic_x2apic_phys __ro_after_init = {
 	.eoi_write			= native_apic_msr_eoi_write,
 	.icr_read			= native_x2apic_icr_read,
 	.icr_write			= native_x2apic_icr_write,
-	.wait_icr_idle			= native_x2apic_wait_icr_idle,
 	.safe_wait_icr_idle		= native_safe_x2apic_wait_icr_idle,
 };
 
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 9e25e30..5cb68f6 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -854,7 +854,6 @@ static struct apic apic_x2apic_uv_x __ro_after_init = {
 	.eoi_write			= native_apic_msr_eoi_write,
 	.icr_read			= native_x2apic_icr_read,
 	.icr_write			= native_x2apic_icr_write,
-	.wait_icr_idle			= native_x2apic_wait_icr_idle,
 	.safe_wait_icr_idle		= native_safe_x2apic_wait_icr_idle,
 };
 
diff --git a/arch/x86/xen/apic.c b/arch/x86/xen/apic.c
index f1cd7f2..e709bf0 100644
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -120,10 +120,6 @@ static int xen_phys_pkg_id(int initial_apic_id, int index_msb)
 	return initial_apic_id >> index_msb;
 }
 
-static void xen_noop(void)
-{
-}
-
 static int xen_cpu_present_to_apicid(int cpu)
 {
 	if (cpu_present(cpu))
@@ -165,7 +161,6 @@ static struct apic xen_pv_apic = {
 
 	.icr_read 			= xen_apic_icr_read,
 	.icr_write 			= xen_apic_icr_write,
-	.wait_icr_idle 			= xen_noop,
 	.safe_wait_icr_idle 		= xen_safe_apic_wait_icr_idle,
 };
 
