Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3139876B238
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbjHAKsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbjHAKrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:47:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28AA2683
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:47:06 -0700 (PDT)
Message-ID: <20230801103816.199680570@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690886824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=xYutxZ9rMLywIqqTjqfZZaF9PJm3LP88T/JNH/GhwYU=;
        b=X2JbTKyO87eOprcyAy3ZQOWGVvDmZbvgzzHL4LUTUcGZ72ixAE6K4mi52SuZPAUzcJksnt
        NvxiRWS77rxJbI5RqriBTbZrA1MyxhxsvEruvCXtgOkf4sP3Xk8W8AEDLT1v7Y6OGXKd6M
        FvkI9G4pL5oGpI70gMseMXpLKmVMrquvIqagbz8f/NCpH0WMmNwR4+d6+W19X5ZgEyrKaz
        xutfqljdrmipddA+Q3bkpwRBjTFekaeKJC4lZinlqB4E9EnN9e7RpZNthaIb3Row4lS+iB
        Hbn0CyseITcBd4LsCz7WFCCJRjCLpUYy/HhOKl1qvwt1iQ1YF5eS+txYCKd2nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690886824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=xYutxZ9rMLywIqqTjqfZZaF9PJm3LP88T/JNH/GhwYU=;
        b=bIE1q7r5gAW9SDt8s5EfyoQ2+1C929iYBjSel520CBblJ6/9pSXVKv6cQcjxISvuqNtDiJ
        FEUizQaNyjyQZLCw==
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
Subject: [patch V3 19/60] x86/apic: Remove check_phys_apicid_present()
References: <20230801103042.936020332@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  1 Aug 2023 12:47:04 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only silly usage site is gone. Remove the gunk which was even outright
wrong in the bigsmp_32 case which returned true unconditionally.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/apic.h           |    2 --
 arch/x86/kernel/apic/apic_common.c    |    5 -----
 arch/x86/kernel/apic/apic_flat_64.c   |    2 --
 arch/x86/kernel/apic/apic_noop.c      |    2 --
 arch/x86/kernel/apic/apic_numachip.c  |    2 --
 arch/x86/kernel/apic/bigsmp_32.c      |    6 ------
 arch/x86/kernel/apic/probe_32.c       |    1 -
 arch/x86/kernel/apic/x2apic_cluster.c |    1 -
 arch/x86/kernel/apic/x2apic_phys.c    |    1 -
 arch/x86/kernel/apic/x2apic_uv_x.c    |    1 -
 arch/x86/xen/apic.c                   |    1 -
 11 files changed, 24 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -305,7 +305,6 @@ struct apic {
 	void	(*setup_apic_routing)(void);
 	int	(*cpu_present_to_apicid)(int mps_cpu);
 	void	(*apicid_to_cpu_present)(int phys_apicid, physid_mask_t *retmap);
-	int	(*check_phys_apicid_present)(int phys_apicid);
 	int	(*phys_pkg_id)(int cpuid_apic, int index_msb);
 
 	u32	(*get_apic_id)(unsigned long x);
@@ -485,7 +484,6 @@ extern u32 apic_flat_calc_apicid(unsigne
 extern bool default_check_apicid_used(physid_mask_t *map, int apicid);
 extern void default_ioapic_phys_id_map(physid_mask_t *phys_map, physid_mask_t *retmap);
 extern int default_cpu_present_to_apicid(int mps_cpu);
-extern int default_check_phys_apicid_present(int phys_apicid);
 
 #else /* CONFIG_X86_LOCAL_APIC */
 
--- a/arch/x86/kernel/apic/apic_common.c
+++ b/arch/x86/kernel/apic/apic_common.c
@@ -35,11 +35,6 @@ int default_cpu_present_to_apicid(int mp
 }
 EXPORT_SYMBOL_GPL(default_cpu_present_to_apicid);
 
-int default_check_phys_apicid_present(int phys_apicid)
-{
-	return physid_isset(phys_apicid, phys_cpu_present_map);
-}
-
 int default_apic_id_valid(u32 apicid)
 {
 	return (apicid < 255);
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -124,7 +124,6 @@ static struct apic apic_flat __ro_after_
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.apicid_to_cpu_present		= NULL,
-	.check_phys_apicid_present	= default_check_phys_apicid_present,
 	.phys_pkg_id			= flat_phys_pkg_id,
 
 	.get_apic_id			= flat_get_apic_id,
@@ -213,7 +212,6 @@ static struct apic apic_physflat __ro_af
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.apicid_to_cpu_present		= NULL,
-	.check_phys_apicid_present	= default_check_phys_apicid_present,
 	.phys_pkg_id			= flat_phys_pkg_id,
 
 	.get_apic_id			= flat_get_apic_id,
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -107,8 +107,6 @@ struct apic apic_noop __ro_after_init =
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.apicid_to_cpu_present		= physid_set_mask_of_physid,
 
-	.check_phys_apicid_present	= default_check_phys_apicid_present,
-
 	.phys_pkg_id			= noop_phys_pkg_id,
 
 	.get_apic_id			= noop_get_apic_id,
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -257,7 +257,6 @@ static const struct apic apic_numachip1
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.apicid_to_cpu_present		= NULL,
-	.check_phys_apicid_present	= default_check_phys_apicid_present,
 	.phys_pkg_id			= numachip_phys_pkg_id,
 
 	.get_apic_id			= numachip1_get_apic_id,
@@ -303,7 +302,6 @@ static const struct apic apic_numachip2
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.apicid_to_cpu_present		= NULL,
-	.check_phys_apicid_present	= default_check_phys_apicid_present,
 	.phys_pkg_id			= numachip_phys_pkg_id,
 
 	.get_apic_id			= numachip2_get_apic_id,
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -63,11 +63,6 @@ static void bigsmp_ioapic_phys_id_map(ph
 	physids_promote(0xFFL, retmap);
 }
 
-static int bigsmp_check_phys_apicid_present(int phys_apicid)
-{
-	return 1;
-}
-
 static int bigsmp_phys_pkg_id(int cpuid_apic, int index_msb)
 {
 	return cpuid_apic >> index_msb;
@@ -138,7 +133,6 @@ static struct apic apic_bigsmp __ro_afte
 	.setup_apic_routing		= bigsmp_setup_apic_routing,
 	.cpu_present_to_apicid		= bigsmp_cpu_present_to_apicid,
 	.apicid_to_cpu_present		= physid_set_mask_of_physid,
-	.check_phys_apicid_present	= bigsmp_check_phys_apicid_present,
 	.phys_pkg_id			= bigsmp_phys_pkg_id,
 
 	.get_apic_id			= bigsmp_get_apic_id,
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -80,7 +80,6 @@ static struct apic apic_default __ro_aft
 	.setup_apic_routing		= setup_apic_flat_routing,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.apicid_to_cpu_present		= physid_set_mask_of_physid,
-	.check_phys_apicid_present	= default_check_phys_apicid_present,
 	.phys_pkg_id			= default_phys_pkg_id,
 
 	.get_apic_id			= default_get_apic_id,
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -250,7 +250,6 @@ static struct apic apic_x2apic_cluster _
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.apicid_to_cpu_present		= NULL,
-	.check_phys_apicid_present	= default_check_phys_apicid_present,
 	.phys_pkg_id			= x2apic_phys_pkg_id,
 
 	.get_apic_id			= x2apic_get_apic_id,
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -174,7 +174,6 @@ static struct apic apic_x2apic_phys __ro
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.apicid_to_cpu_present		= NULL,
-	.check_phys_apicid_present	= default_check_phys_apicid_present,
 	.phys_pkg_id			= x2apic_phys_pkg_id,
 
 	.get_apic_id			= x2apic_get_apic_id,
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -846,7 +846,6 @@ static struct apic apic_x2apic_uv_x __ro
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.apicid_to_cpu_present		= NULL,
-	.check_phys_apicid_present	= default_check_phys_apicid_present,
 	.phys_pkg_id			= uv_phys_pkg_id,
 
 	.get_apic_id			= x2apic_get_apic_id,
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -154,7 +154,6 @@ static struct apic xen_pv_apic = {
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= xen_cpu_present_to_apicid,
 	.apicid_to_cpu_present		= physid_set_mask_of_physid, /* Used on 32-bit */
-	.check_phys_apicid_present	= default_check_phys_apicid_present, /* smp_sanity_check needs it */
 	.phys_pkg_id			= xen_phys_pkg_id, /* detect_ht */
 
 	.get_apic_id 			= xen_get_apic_id,

