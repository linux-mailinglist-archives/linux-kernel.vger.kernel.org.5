Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5BF275705F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjGQXQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbjGQXQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:16:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F872170A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:15:28 -0700 (PDT)
Message-ID: <20230717223224.207131427@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689635704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=aIQdyjgeuqgS020loHjY5emNS2jBJ0TkBAxP1UcK54o=;
        b=pVf2lpDpYh4f4Usviw2kiFQu2Jrlvpla6YoI0IZG/Je+7EeA9q4wQXJO7zgw2cGOIhTr7D
        G4/L0eSr2IO68nZPcnUThmeg6prXf8by+wFL0/cALVQ4VwnxzppGdKnEzxwQ7mgvGtmj8N
        SoxA4LHNYRvpK8PxwvSezE5MkEjpahZhFSpPzqZV1eV95sdImEjwNkB6x8lxPw1RXe2iwS
        jTQNbfeR2A+ZrpwUfUL/Ts+u+1tsNYfls1dsVbMiJCbiFpdwiLLEQ1BlT2LXP+Df9+7rXu
        Rgj927xY2AUtkww2RNplnOw9rY5Zp7dN0wN1xilJibUpyDO9RjAYDf3MwNAlYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689635704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=aIQdyjgeuqgS020loHjY5emNS2jBJ0TkBAxP1UcK54o=;
        b=09NZQgSJHMQd45+whsEMRbCci79Ic6kHVNQJPgI/5G8hxpJby9SlVUEoYFWvRr+g/wYcg4
        FMJ2PnKAbU/wNAAA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 19/58] x86/apic: Get rid of apic_phys
References: <20230717223049.327865981@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 18 Jul 2023 01:15:03 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need for an extra variable to find out whether the APIC has been mapped
or is accessible (X2APIC mode).

Provide an inline for this and check apic_mmio_base which is only set when
the local APIC has been mapped.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/apic.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -99,6 +99,11 @@ static bool virt_ext_dest_id __ro_after_
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
@@ -1921,7 +1922,6 @@ static __init void try_to_enable_x2apic(
 		 * be addressed must not be brought online.
 		 */
 		x2apic_set_max_apicid(apic_limit);
-		x2apic_phys = 1;
 	}
 	x2apic_enable();
 }
@@ -2895,11 +2895,11 @@ early_param("apic", apic_set_verbosity);
 
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
 

