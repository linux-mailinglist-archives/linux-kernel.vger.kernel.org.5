Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897F276B24B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjHAKuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjHAKtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:49:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317433C0D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:47:48 -0700 (PDT)
Message-ID: <20230801103817.296447715@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690886849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=wooQjfivjf9g/FihTIdSMalhuVeQoOiGD7tnhzUY+hw=;
        b=aZMVEsQnwUeSnkh3VigeEz8F/NRqHIMLDfx/0Xcd+osVj8LjHhsO0fQTcIV2HhkW9neJUw
        /x1sOaHluauJAyAGo3jzvxsqsp9n2VqSBnBD6ahE0v96VJqHQFjxHPbq+8920WZzqvGB3H
        Al+nRiqGHsfPh14kgzGT9KHRr1Ef7Sf19GOkJ6MrsQumBxLffMFrvJWDh4VXnNb97OLQiB
        wGJHvd39ekpHOKR2C3Y3T8gpeeoeGtMTRD9ODxB90D6CL39D2e/5SVLX0Jji6sBCsYMP13
        Ry5vnbP9vq/d7LnBXT9hBWJOU1bGIuPC9u9NpAMPTBofRphbsPR0bTi/fr8rZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690886849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=wooQjfivjf9g/FihTIdSMalhuVeQoOiGD7tnhzUY+hw=;
        b=bt4kwNT1oOkLK1zjKsW9urasQSxfYeU3jB8JbSxNJrqcxYg44TjJdEo35ksNvIz+nJclyD
        xVTm3Q+MHB5V+cAQ==
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
Subject: [patch V3 39/60] x86/apic/x2apic: Share all common IPI functions
References: <20230801103042.936020332@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  1 Aug 2023 12:47:29 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
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
 

