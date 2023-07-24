Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C2975F886
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjGXNhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbjGXNhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:37:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F3A1BE9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:36:02 -0700 (PDT)
Message-ID: <20230724132046.856128346@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690205690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=wooQjfivjf9g/FihTIdSMalhuVeQoOiGD7tnhzUY+hw=;
        b=Pmk9LBNZ6Et+tmCBd81Ezq1BmQsHH44uyK7kff8NX6vw9Hd1WDIDDbesc4M7F1CPs/AuPN
        74QHL+LT+CefEqh1oC0woV5d8tHdNeQV8o3jGbAtm6wz8n3sp346oxuoSg/bxD8+aCGdmB
        Ldc7lwLgMXef4uZH0yojMgo1UKwMQvZl5jB+/71oYIHq5A2rajOahCwajSHGqWDoOIrO0W
        D1kz0kR3hxzWVEhBlSCxOXUYqqxpKFtosXEvgP1e2atUbNBgwke6qsiI1XLUz5I9i0VgBu
        YjOCLRAfpz6KkOE6cKL172D0JakQRIvtUz8H7K6NmlviPzIlxgpRFQAMG83KHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690205690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=wooQjfivjf9g/FihTIdSMalhuVeQoOiGD7tnhzUY+hw=;
        b=z5KUT8gcqM6Z0R7y3UxTBEr4I47c1i/LGAzzOOVIckJxwdt0yuOirRedc4Mrme1xyyvTNz
        jp7mbd7LX4GoOhDw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Peter Keresztes Schmidt <peter@keresztesschmidt.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch V2 38/58] x86/apic/x2apic: Share all common IPI functions
References: <20230724131206.500814398@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Jul 2023 15:34:49 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yet more copy and pasta gone.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/apic/local.h          |    4 ++-
 arch/x86/kernel/apic/x2apic_cluster.c |   10 -------
 arch/x86/kernel/apic/x2apic_phys.c    |   44 +++++++++++++++++-----------------
 arch/x86/kernel/apic/x2apic_uv_x.c    |   14 ++--------
 4 files changed, 28 insertions(+), 44 deletions(-)

--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -19,8 +19,10 @@ void __x2apic_send_IPI_dest(unsigned int
 unsigned int x2apic_get_apic_id(unsigned long id);
 u32 x2apic_set_apic_id(unsigned int id);
 int x2apic_phys_pkg_id(int initial_apicid, int index_msb);
+
+void x2apic_send_IPI_all(int vector);
+void x2apic_send_IPI_allbutself(int vector);
 void x2apic_send_IPI_self(int vector);
-void __x2apic_send_IPI_shorthand(int vector, u32 which);
 
 /* IPI */
 
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -83,16 +83,6 @@ x2apic_send_IPI_mask_allbutself(const st
 	__x2apic_send_IPI_mask(mask, vector, APIC_DEST_ALLBUT);
 }
 
-static void x2apic_send_IPI_allbutself(int vector)
-{
-	__x2apic_send_IPI_shorthand(vector, APIC_DEST_ALLBUT);
-}
-
-static void x2apic_send_IPI_all(int vector)
-{
-	__x2apic_send_IPI_shorthand(vector, APIC_DEST_ALLINC);
-}
-
 static u32 x2apic_calc_apicid(unsigned int cpu)
 {
 	return x86_cpu_to_logical_apicid[cpu];
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -81,16 +81,36 @@ static void
 	__x2apic_send_IPI_mask(mask, vector, APIC_DEST_ALLBUT);
 }
 
-static void x2apic_send_IPI_allbutself(int vector)
+static void __x2apic_send_IPI_shorthand(int vector, u32 which)
+{
+	unsigned long cfg = __prepare_ICR(which, vector, 0);
+
+	/* x2apic MSRs are special and need a special fence: */
+	weak_wrmsr_fence();
+	native_x2apic_icr_write(cfg, 0);
+}
+
+void x2apic_send_IPI_allbutself(int vector)
 {
 	__x2apic_send_IPI_shorthand(vector, APIC_DEST_ALLBUT);
 }
 
-static void x2apic_send_IPI_all(int vector)
+void x2apic_send_IPI_all(int vector)
 {
 	__x2apic_send_IPI_shorthand(vector, APIC_DEST_ALLINC);
 }
 
+void x2apic_send_IPI_self(int vector)
+{
+	apic_write(APIC_SELF_IPI, vector);
+}
+
+void __x2apic_send_IPI_dest(unsigned int apicid, int vector, unsigned int dest)
+{
+	unsigned long cfg = __prepare_ICR(0, vector, dest);
+	native_x2apic_icr_write(cfg, apicid);
+}
+
 static int x2apic_phys_probe(void)
 {
 	if (!x2apic_mode)
@@ -111,21 +131,6 @@ int x2apic_apic_id_valid(u32 apicid)
 	return 1;
 }
 
-void __x2apic_send_IPI_dest(unsigned int apicid, int vector, unsigned int dest)
-{
-	unsigned long cfg = __prepare_ICR(0, vector, dest);
-	native_x2apic_icr_write(cfg, apicid);
-}
-
-void __x2apic_send_IPI_shorthand(int vector, u32 which)
-{
-	unsigned long cfg = __prepare_ICR(which, vector, 0);
-
-	/* x2apic MSRs are special and need a special fence: */
-	weak_wrmsr_fence();
-	native_x2apic_icr_write(cfg, 0);
-}
-
 unsigned int x2apic_get_apic_id(unsigned long id)
 {
 	return id;
@@ -141,11 +146,6 @@ int x2apic_phys_pkg_id(int initial_apici
 	return initial_apicid >> index_msb;
 }
 
-void x2apic_send_IPI_self(int vector)
-{
-	apic_write(APIC_SELF_IPI, vector);
-}
-
 static struct apic apic_x2apic_phys __ro_after_init = {
 
 	.name				= "physical x2apic",
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -25,6 +25,8 @@
 #include <asm/uv/uv.h>
 #include <asm/apic.h>
 
+#include "local.h"
+
 static enum uv_system_type	uv_system_type;
 static int			uv_hubbed_system;
 static int			uv_hubless_system;
@@ -783,11 +785,6 @@ static int uv_apic_id_valid(u32 apicid)
 	return 1;
 }
 
-static unsigned int x2apic_get_apic_id(unsigned long id)
-{
-	return id;
-}
-
 static u32 set_apic_id(unsigned int id)
 {
 	return id;
@@ -803,11 +800,6 @@ static int uv_phys_pkg_id(int initial_ap
 	return uv_read_apic_id() >> index_msb;
 }
 
-static void uv_send_IPI_self(int vector)
-{
-	apic_write(APIC_SELF_IPI, vector);
-}
-
 static int uv_probe(void)
 {
 	return apic == &apic_x2apic_uv_x;
@@ -840,7 +832,7 @@ static struct apic apic_x2apic_uv_x __ro
 	.send_IPI_mask_allbutself	= uv_send_IPI_mask_allbutself,
 	.send_IPI_allbutself		= uv_send_IPI_allbutself,
 	.send_IPI_all			= uv_send_IPI_all,
-	.send_IPI_self			= uv_send_IPI_self,
+	.send_IPI_self			= x2apic_send_IPI_self,
 
 	.wakeup_secondary_cpu		= uv_wakeup_secondary,
 

