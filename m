Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE49D77683C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbjHITNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbjHITMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:12:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47A02737;
        Wed,  9 Aug 2023 12:12:26 -0700 (PDT)
Date:   Wed, 09 Aug 2023 19:12:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691608342;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=hSgl3fSClaJdf5Fu3JABEOcporIo3oNbzkE97SlVR1k=;
        b=qY4ftrGP3umH6ffDtiZtFdLVbi9WdcEYU3HmOH0QD4iN9xUy4U+k8TC/hsXK8XYxzcNZTc
        41M1Uamo2I8cjMFytf2OSG0Gz0ON2fRWknihoGohS+7Z3/IcYDXW1W9x4NyxgaAjpSHQR1
        73FfU+uxo6fgiNyasYv7B/j1o3FsN+Mk/bfcyWL9DZlBzSuZrIiywsN3JzkY+jCVqkUTgW
        hNZwdVrCNOLyai9IqJIKuUhv06Klfmkc/30siYKOMVJsOCEr8wCSSxZJVGnA6lT8tNy3pP
        dVFBmMMOLYpL5Q6lOulLhUXc/UGx+8JAgtYTd20KWuyZj3LvoEPbR9HVDcE/pQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691608342;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=hSgl3fSClaJdf5Fu3JABEOcporIo3oNbzkE97SlVR1k=;
        b=MV6TVJzHb+KgfMXzgAVHDJkAJ7r4sU/X1CUu/2BhMZmT4KiLm3RRdbO4yRvH+gGpwz9655
        gmO9LpSkKTKfswAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Get rid of apic_phys
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169160834205.27769.12520731930596276647.tip-bot2@tip-bot2>
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

Commit-ID:     78c32000848c9a3af69e2431d17caed7b555e0ea
Gitweb:        https://git.kernel.org/tip/78c32000848c9a3af69e2431d17caed7b555e0ea
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:03:52 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 11:58:22 -07:00

x86/apic: Get rid of apic_phys

No need for an extra variable to find out whether the APIC has been mapped
or is accessible (X2APIC mode).

Provide an inline for this and check apic_mmio_base which is only set when
the local APIC has been mapped.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
---
 arch/x86/kernel/apic/apic.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 564d584..6eee777 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -99,6 +99,11 @@ static bool virt_ext_dest_id __ro_after_init;
 /* For parallel bootup. */
 unsigned long apic_mmio_base __ro_after_init;
 
+static inline bool apic_accessible(void)
+{
+	return x2apic_mode || apic_mmio_base;
+}
+
 /*
  * Map cpu index to physical APIC ID
  */
@@ -199,8 +204,6 @@ unsigned int lapic_timer_period = 0;
 
 static void apic_pm_activate(void);
 
-static unsigned long apic_phys __ro_after_init;
-
 /*
  * Get the LAPIC version
  */
@@ -1127,8 +1130,7 @@ void clear_local_APIC(void)
 	int maxlvt;
 	u32 v;
 
-	/* APIC hasn't been mapped yet */
-	if (!x2apic_mode && !apic_phys)
+	if (!apic_accessible())
 		return;
 
 	maxlvt = lapic_get_maxlvt();
@@ -1218,8 +1220,7 @@ void apic_soft_disable(void)
  */
 void disable_local_APIC(void)
 {
-	/* APIC hasn't been mapped yet */
-	if (!x2apic_mode && !apic_phys)
+	if (!apic_accessible())
 		return;
 
 	apic_soft_disable();
@@ -2142,7 +2143,7 @@ void __init init_apic_mappings(void)
 static __init void apic_set_fixmap(void)
 {
 	set_fixmap_nocache(FIX_APIC_BASE, mp_lapic_addr);
-	apic_phys = apic_mmio_base = APIC_BASE;
+	apic_mmio_base = APIC_BASE;
 	apic_printk(APIC_VERBOSE, "mapped APIC to %16lx (%16lx)\n",
 		    apic_mmio_base, mp_lapic_addr);
 	apic_read_boot_cpu_id(false);
@@ -2896,11 +2897,11 @@ early_param("apic", apic_set_verbosity);
 
 static int __init lapic_insert_resource(void)
 {
-	if (!apic_phys)
+	if (!apic_mmio_base)
 		return -1;
 
 	/* Put local APIC into the resource map. */
-	lapic_resource.start = apic_phys;
+	lapic_resource.start = apic_mmio_base;
 	lapic_resource.end = lapic_resource.start + PAGE_SIZE - 1;
 	insert_resource(&iomem_resource, &lapic_resource);
 
