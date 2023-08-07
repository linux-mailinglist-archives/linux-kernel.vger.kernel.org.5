Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6D07726AB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbjHGNyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbjHGNxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:53:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CD1171A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:53:06 -0700 (PDT)
Message-ID: <20230807135027.482353656@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=XKmrv7R2S+3/o3K90lEiBlMfc0sBkVkBuauG2ySKEQU=;
        b=t2Q/sQf8+jndQxri+6gDM4FNwZyTbhsbph88I18heS+1YqxAUUQuzAPNcTa8LQccL6EJFk
        AJDol1MAUHiV6nUM4Ran7vEn2IIMquqArvEirZ5m1Wddweu6qtT+aX3zYNn6mTKjcxmXMK
        yL9cqvxIn2sAhAxuB7NMux0VHSS6lMBtpyIGlJ+oXCAk8Qu3qqTne+v34pbkW9tqEZw6QC
        rkviZ0wJg5hPArDhQpKT/xsyEfWkmyoipvGJHLkA6VnG3LD5AaKR5uphDMNlj7S581j3At
        /+RNrRRfwayck3xrpjbR7Gmj/v1D7jhyJUj6ACXmNh4QXwwVHtQ+yrOd3heUxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=XKmrv7R2S+3/o3K90lEiBlMfc0sBkVkBuauG2ySKEQU=;
        b=3Kz8NwHkNQb02kCYlq8YOxE3JO0uetfk7uxR6i+UkScPTEQfaJyg95SmkuzknRBxhQmJHL
        IT/1HSuXrUDPbIAg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andy@infradead.org>
Subject: [patch 20/53] x86/apic: Remove the pointless writeback of
 boot_cpu_physical_apicid
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:53:04 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is absolutely no point to write the APIC ID which was read from the
local APIC earlier, back into the local APIC for the 64-bit UP case.

Remove that along with the apic callback which is solely there for this
pointless exercise.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/apic.h           |    1 -
 arch/x86/kernel/apic/apic.c           |    3 ---
 arch/x86/kernel/apic/apic_flat_64.c   |    7 -------
 arch/x86/kernel/apic/apic_numachip.c  |   12 ------------
 arch/x86/kernel/apic/bigsmp_32.c      |    1 -
 arch/x86/kernel/apic/local.h          |    1 -
 arch/x86/kernel/apic/x2apic_cluster.c |    1 -
 arch/x86/kernel/apic/x2apic_phys.c    |    6 ------
 arch/x86/kernel/apic/x2apic_uv_x.c    |    6 ------
 arch/x86/xen/apic.c                   |    7 -------
 10 files changed, 45 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -296,7 +296,6 @@ struct apic {
 	u32	(*cpu_present_to_apicid)(int mps_cpu);
 
 	u32	(*get_apic_id)(u32 id);
-	u32	(*set_apic_id)(u32 apicid);
 
 	/* wakeup_secondary_cpu */
 	int	(*wakeup_secondary_cpu)(u32 apicid, unsigned long start_eip);
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2474,9 +2474,6 @@ EXPORT_SYMBOL_GPL(x86_msi_msg_get_destid
 
 static void __init apic_bsp_up_setup(void)
 {
-#ifdef CONFIG_X86_64
-	apic_write(APIC_ID, apic->set_apic_id(boot_cpu_physical_apicid));
-#endif
 	reset_phys_cpu_present_map(boot_cpu_physical_apicid);
 }
 
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -61,11 +61,6 @@ static u32 flat_get_apic_id(u32 x)
 	return (x >> 24) & 0xFF;
 }
 
-static u32 set_apic_id(u32 id)
-{
-	return (id & 0xFF) << 24;
-}
-
 static int flat_probe(void)
 {
 	return 1;
@@ -87,7 +82,6 @@ static struct apic apic_flat __ro_after_
 
 	.max_apic_id			= 0xFE,
 	.get_apic_id			= flat_get_apic_id,
-	.set_apic_id			= set_apic_id,
 
 	.calc_dest_apicid		= apic_flat_calc_apicid,
 
@@ -156,7 +150,6 @@ static struct apic apic_physflat __ro_af
 
 	.max_apic_id			= 0xFE,
 	.get_apic_id			= flat_get_apic_id,
-	.set_apic_id			= set_apic_id,
 
 	.calc_dest_apicid		= apic_default_calc_apicid,
 
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -38,11 +38,6 @@ static u32 numachip1_get_apic_id(u32 x)
 	return id;
 }
 
-static u32 numachip1_set_apic_id(u32 id)
-{
-	return (id & 0xff) << 24;
-}
-
 static u32 numachip2_get_apic_id(u32 x)
 {
 	u64 mcfg;
@@ -51,11 +46,6 @@ static u32 numachip2_get_apic_id(u32 x)
 	return ((mcfg >> (28 - 8)) & 0xfff00) | (x >> 24);
 }
 
-static u32 numachip2_set_apic_id(u32 id)
-{
-	return id << 24;
-}
-
 static void numachip1_apic_icr_write(int apicid, unsigned int val)
 {
 	write_lcsr(CSR_G3_EXT_IRQ_GEN, (apicid << 16) | val);
@@ -226,7 +216,6 @@ static const struct apic apic_numachip1
 
 	.max_apic_id			= UINT_MAX,
 	.get_apic_id			= numachip1_get_apic_id,
-	.set_apic_id			= numachip1_set_apic_id,
 
 	.calc_dest_apicid		= apic_default_calc_apicid,
 
@@ -262,7 +251,6 @@ static const struct apic apic_numachip2
 
 	.max_apic_id			= UINT_MAX,
 	.get_apic_id			= numachip2_get_apic_id,
-	.set_apic_id			= numachip2_set_apic_id,
 
 	.calc_dest_apicid		= apic_default_calc_apicid,
 
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -73,7 +73,6 @@ static struct apic apic_bigsmp __ro_afte
 
 	.max_apic_id			= 0xFE,
 	.get_apic_id			= bigsmp_get_apic_id,
-	.set_apic_id			= NULL,
 
 	.calc_dest_apicid		= apic_default_calc_apicid,
 
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -16,7 +16,6 @@
 /* X2APIC */
 void __x2apic_send_IPI_dest(unsigned int apicid, int vector, unsigned int dest);
 u32 x2apic_get_apic_id(u32 id);
-u32 x2apic_set_apic_id(u32 id);
 
 void x2apic_send_IPI_all(int vector);
 void x2apic_send_IPI_allbutself(int vector);
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -238,7 +238,6 @@ static struct apic apic_x2apic_cluster _
 	.max_apic_id			= UINT_MAX,
 	.x2apic_set_max_apicid		= true,
 	.get_apic_id			= x2apic_get_apic_id,
-	.set_apic_id			= x2apic_set_apic_id,
 
 	.calc_dest_apicid		= x2apic_calc_apicid,
 
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -129,11 +129,6 @@ u32 x2apic_get_apic_id(u32 id)
 	return id;
 }
 
-u32 x2apic_set_apic_id(u32 id)
-{
-	return id;
-}
-
 static struct apic apic_x2apic_phys __ro_after_init = {
 
 	.name				= "physical x2apic",
@@ -150,7 +145,6 @@ static struct apic apic_x2apic_phys __ro
 	.max_apic_id			= UINT_MAX,
 	.x2apic_set_max_apicid		= true,
 	.get_apic_id			= x2apic_get_apic_id,
-	.set_apic_id			= x2apic_set_apic_id,
 
 	.calc_dest_apicid		= apic_default_calc_apicid,
 
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -746,11 +746,6 @@ static void uv_send_IPI_all(int vector)
 	uv_send_IPI_mask(cpu_online_mask, vector);
 }
 
-static u32 set_apic_id(u32 id)
-{
-	return id;
-}
-
 static int uv_probe(void)
 {
 	return apic == &apic_x2apic_uv_x;
@@ -771,7 +766,6 @@ static struct apic apic_x2apic_uv_x __ro
 
 	.max_apic_id			= UINT_MAX,
 	.get_apic_id			= x2apic_get_apic_id,
-	.set_apic_id			= set_apic_id,
 
 	.calc_dest_apicid		= apic_default_calc_apicid,
 
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -33,12 +33,6 @@ static unsigned int xen_io_apic_read(uns
 	return 0xfd;
 }
 
-static u32 xen_set_apic_id(u32 x)
-{
-	WARN_ON(1);
-	return x;
-}
-
 static u32 xen_get_apic_id(u32 x)
 {
 	return ((x)>>24) & 0xFFu;
@@ -131,7 +125,6 @@ static struct apic xen_pv_apic __ro_afte
 
 	.max_apic_id			= UINT_MAX,
 	.get_apic_id			= xen_get_apic_id,
-	.set_apic_id			= xen_set_apic_id,
 
 	.calc_dest_apicid		= apic_flat_calc_apicid,
 

