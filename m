Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C277763C4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbjHIPeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjHIPeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:34:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0041FEF;
        Wed,  9 Aug 2023 08:34:13 -0700 (PDT)
Date:   Wed, 09 Aug 2023 15:34:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691595252;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=QatdiyxZ4wE/yuuibzQ7NJdMC3qhgYA/6987ycM+a8w=;
        b=eOtqP72DcN0ANZ2obr2TzP/TZnEVAaeoS6071iorMiXDZX22a4OO0OAxkuA/t3SuC2nxsA
        sFqqgTcar+l7s+X2pWsqd0g7Djwdm/Ht+qO6Ro6tVh+IiP5M7Q19ZRofAUrm3gR2e9hst3
        mTds3yVXa02/6nsMgL/vzkaOnepT+gM9lEy4+xj1TEsDRgIIKFl9VvJkoOXA4b8v5ZeurG
        UTn/kZlYfUO9LRutbW8OmIHmiNWFITKDxtPJzqwmAE1wHRbSbI/oLaHVNF8bDiFluAKHvJ
        4tGrEh2b/2TMi8QBcF4efTXuurfz+wTTUDSpf5dyyw1KF5otbCVFhbMYXdUbiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691595252;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=QatdiyxZ4wE/yuuibzQ7NJdMC3qhgYA/6987ycM+a8w=;
        b=FB2N967DP5BAaN0RQqvQqQ7dKlwej4IYyf9m9iq+h/GDi1GVzjxTfyiCHpu+3gxdnoAUWk
        TYkCdi+YX64HeiAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Get rid of apic_phys
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169159525182.27769.12957294374092051321.tip-bot2@tip-bot2>
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

Commit-ID:     2be751120b756145790e852b6dfd2e060119410f
Gitweb:        https://git.kernel.org/tip/2be751120b756145790e852b6dfd2e060119410f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:03:52 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 08:10:11 -07:00

x86/apic: Get rid of apic_phys

No need for an extra variable to find out whether the APIC has been mapped
or is accessible (X2APIC mode).

Provide an inline for this and check apic_mmio_base which is only set when
the local APIC has been mapped.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
 
