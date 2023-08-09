Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12D3776573
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjHIQtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjHIQtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:49:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5DB1BF7;
        Wed,  9 Aug 2023 09:49:32 -0700 (PDT)
Date:   Wed, 09 Aug 2023 16:49:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691599770;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=wnF/IWYIb7OYIqXB1MoGhC6AyXw5i71ctple+XwhlgU=;
        b=njr8F+mrUZoGBraHmbYNu2Mr9LPtyc1sxG4AKJCmnVFR2auzRu1Dt+fMLCPzR68tJD2+85
        Ctpstvnh77/TIyqp/96WeqkJ18XCMKdkrkUmqspKq8waAbWIkg3VDkdkAWEvb8ZFLCyKhX
        tpMZTotpPmYPmK+BOCOwfIzSyLmFjFcXr8UGe5B6aOuXdeEtMw3djW/J2X6eJdIMx3iUIP
        AOWBTAqYW/gmVczRYHki1LsnOwYlPnRoEJgBeXPhz5ON9cu2azS8y75ZnmHhrcYW2p5ryu
        xL64vZok+fzKDuIBX4c4FVfdC/oMh6vpOV80UqUUQvTSPhLcFRogtpnTvvJEtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691599770;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=wnF/IWYIb7OYIqXB1MoGhC6AyXw5i71ctple+XwhlgU=;
        b=RhQ5aAAtYbbO4T/lj0qLVJIHiP2FI9QhVQND9D+qkeUGFXP/9VQFQ46S3iWk+//00o6+M0
        Ebx4Bq3Sqhu9rWBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Allow apic::safe_wait_icr_idle() to be NULL
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169159977030.27769.11993059391107652937.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     3080c4e39719539801c233b949afd3d2fe2cb448
Gitweb:        https://git.kernel.org/tip/3080c4e39719539801c233b949afd3d2fe2cb448
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:04:05 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 08:10:12 -07:00

x86/apic: Allow apic::safe_wait_icr_idle() to be NULL

Remove tons of NOOP callbacks by making the invocation of
safe_wait_icr_idle() conditional in the inline wrapper.

Will be replaced by a static_call_cond() later.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/apic.h           | 8 +-------
 arch/x86/kernel/apic/apic_noop.c      | 6 ------
 arch/x86/kernel/apic/apic_numachip.c  | 8 --------
 arch/x86/kernel/apic/x2apic_cluster.c | 1 -
 arch/x86/kernel/apic/x2apic_phys.c    | 1 -
 arch/x86/kernel/apic/x2apic_uv_x.c    | 1 -
 arch/x86/xen/apic.c                   | 6 ------
 7 files changed, 1 insertion(+), 30 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 397cd5f..dd0a05d 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -206,12 +206,6 @@ static inline u32 native_apic_msr_read(u32 reg)
 	return (u32)msr;
 }
 
-static inline u32 native_safe_x2apic_wait_icr_idle(void)
-{
-	/* no need to wait for icr idle in x2apic */
-	return 0;
-}
-
 static inline void native_x2apic_icr_write(u32 low, u32 id)
 {
 	wrmsrl(APIC_BASE_MSR + (APIC_ICR >> 4), ((__u64) id) << 32 | low);
@@ -376,7 +370,7 @@ static inline void apic_wait_icr_idle(void)
 
 static inline u32 safe_apic_wait_icr_idle(void)
 {
-	return apic->safe_wait_icr_idle();
+	return apic->safe_wait_icr_idle ? apic->safe_wait_icr_idle() : 0;
 }
 
 extern void __init apic_set_eoi_write(void (*eoi_write)(u32 reg, u32 v));
diff --git a/arch/x86/kernel/apic/apic_noop.c b/arch/x86/kernel/apic/apic_noop.c
index ef31a2e..36c1e28 100644
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -27,11 +27,6 @@ static int noop_wakeup_secondary_cpu(int apicid, unsigned long start_eip)
 	return -1;
 }
 
-static u32 noop_safe_apic_wait_icr_idle(void)
-{
-	return 0;
-}
-
 static u64 noop_apic_icr_read(void)
 {
 	return 0;
@@ -104,5 +99,4 @@ struct apic apic_noop __ro_after_init = {
 	.eoi_write			= noop_apic_write,
 	.icr_read			= noop_apic_icr_read,
 	.icr_write			= noop_apic_icr_write,
-	.safe_wait_icr_idle		= noop_safe_apic_wait_icr_idle,
 };
diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/apic_numachip.c
index 647ed77..e879dbb 100644
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -223,12 +223,6 @@ static int numachip2_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
 	return 1;
 }
 
-/* APIC NMI IPIs are queued */
-static u32 numachip_safe_apic_wait_icr_idle(void)
-{
-	return 0;
-}
-
 static const struct apic apic_numachip1 __refconst = {
 	.name				= "NumaConnect system",
 	.probe				= numachip1_probe,
@@ -264,7 +258,6 @@ static const struct apic apic_numachip1 __refconst = {
 	.eoi_write			= native_apic_mem_write,
 	.icr_read			= native_apic_icr_read,
 	.icr_write			= native_apic_icr_write,
-	.safe_wait_icr_idle		= numachip_safe_apic_wait_icr_idle,
 };
 
 apic_driver(apic_numachip1);
@@ -304,7 +297,6 @@ static const struct apic apic_numachip2 __refconst = {
 	.eoi_write			= native_apic_mem_write,
 	.icr_read			= native_apic_icr_read,
 	.icr_write			= native_apic_icr_write,
-	.safe_wait_icr_idle		= numachip_safe_apic_wait_icr_idle,
 };
 
 apic_driver(apic_numachip2);
diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index 7ceef70..355da47 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -266,7 +266,6 @@ static struct apic apic_x2apic_cluster __ro_after_init = {
 	.eoi_write			= native_apic_msr_eoi_write,
 	.icr_read			= native_x2apic_icr_read,
 	.icr_write			= native_x2apic_icr_write,
-	.safe_wait_icr_idle		= native_safe_x2apic_wait_icr_idle,
 };
 
 apic_driver(apic_x2apic_cluster);
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index c1ab678..2c9a884 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -180,7 +180,6 @@ static struct apic apic_x2apic_phys __ro_after_init = {
 	.eoi_write			= native_apic_msr_eoi_write,
 	.icr_read			= native_x2apic_icr_read,
 	.icr_write			= native_x2apic_icr_write,
-	.safe_wait_icr_idle		= native_safe_x2apic_wait_icr_idle,
 };
 
 apic_driver(apic_x2apic_phys);
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 5cb68f6..f532c58 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -854,7 +854,6 @@ static struct apic apic_x2apic_uv_x __ro_after_init = {
 	.eoi_write			= native_apic_msr_eoi_write,
 	.icr_read			= native_x2apic_icr_read,
 	.icr_write			= native_x2apic_icr_write,
-	.safe_wait_icr_idle		= native_safe_x2apic_wait_icr_idle,
 };
 
 #define	UVH_RH_GAM_ALIAS210_REDIRECT_CONFIG_LENGTH	3
diff --git a/arch/x86/xen/apic.c b/arch/x86/xen/apic.c
index e709bf0..0f71b2e 100644
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -92,11 +92,6 @@ static void xen_apic_icr_write(u32 low, u32 id)
 	WARN_ON(1);
 }
 
-static u32 xen_safe_apic_wait_icr_idle(void)
-{
-        return 0;
-}
-
 static int xen_apic_probe_pv(void)
 {
 	if (xen_pv_domain())
@@ -161,7 +156,6 @@ static struct apic xen_pv_apic = {
 
 	.icr_read 			= xen_apic_icr_read,
 	.icr_write 			= xen_apic_icr_write,
-	.safe_wait_icr_idle 		= xen_safe_apic_wait_icr_idle,
 };
 
 static void __init xen_apic_check(void)
