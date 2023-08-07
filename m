Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5987726AC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbjHGNyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbjHGNxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:53:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A7310EF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:53:08 -0700 (PDT)
Message-ID: <20230807135027.534633642@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=X3MHNyfBXHRhCX+hsuUai8tmF+yG5iARhPCZvhjm+2M=;
        b=DXXMbB2Ho7x5WE9SUSWUdchy2gfXzWq0UFOCFSaDvrDoTN2KL57RtE5fjtCI11M3E7jC3g
        soyHA2R3toj+lboJxDLPjyXRtxJF08H8lDWGlGExuAb22DdZaVI23TiEmablAYUhnQHTFM
        aMeslJnt1Jx9y9rB9BC4wZp6bvEuTxZlQ4avYoDQhAwzwBlv3v5y6wDs9KYG6S/bSLbNM9
        ZYsZdAfXr9yqbj3qM4xbJB/5R8cJb6LIFjmzxtJZ7gmnsndtoiaGdpWcB+RU/h9pVjBXlG
        j/aR6ykPmdJErusxeHiPiXHZoJH27MskEf8G3MB72OqH5rUitJCYW6tHII09CQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=X3MHNyfBXHRhCX+hsuUai8tmF+yG5iARhPCZvhjm+2M=;
        b=3SCvDxL2pthhEffENN4YrI6PMPhCiJmnKafwaOimCLKSKOTr+6Rzcf5jftcH2d0qi7fZ2Y
        YRNhFQ1RUweR4BAg==
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
Subject: [patch 21/53] x86/apic: Remove yet another dubious callback
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:53:06 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paranoia is not wrong, but having an APIC callback which is in most
implementations a complete NOOP and in one actually looking whether the
APICID of an upcoming CPU has been registered. The same APICID which was
used to bring the CPU out of wait for startup.

That's paranoia for the paranoia sake. Remove the voodoo.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/apic.h         |    1 -
 arch/x86/kernel/apic/apic.c         |    3 ---
 arch/x86/kernel/apic/apic_common.c  |    5 -----
 arch/x86/kernel/apic/apic_flat_64.c |    2 --
 arch/x86/kernel/apic/local.h        |    2 --
 arch/x86/kernel/apic/probe_32.c     |    1 -
 6 files changed, 14 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -290,7 +290,6 @@ struct apic {
 	/* Probe, setup and smpboot functions */
 	int	(*probe)(void);
 	int	(*acpi_madt_oem_check)(char *oem_id, char *oem_table_id);
-	bool	(*apic_id_registered)(void);
 
 	void	(*init_apic_ldr)(void);
 	u32	(*cpu_present_to_apicid)(int mps_cpu);
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1538,9 +1538,6 @@ static void setup_local_APIC(void)
 		apic_write(APIC_ESR, 0);
 	}
 #endif
-	/* Validate that the APIC is registered if required */
-	BUG_ON(apic->apic_id_registered && !apic->apic_id_registered());
-
 	/*
 	 * Intel recommends to set DFR, LDR and TPR before enabling
 	 * an APIC.  See e.g. "AP-388 82489DX User's Manual" (Intel
--- a/arch/x86/kernel/apic/apic_common.c
+++ b/arch/x86/kernel/apic/apic_common.c
@@ -27,11 +27,6 @@ u32 default_cpu_present_to_apicid(int mp
 }
 EXPORT_SYMBOL_GPL(default_cpu_present_to_apicid);
 
-bool default_apic_id_registered(void)
-{
-	return test_bit(read_apic_id(), phys_cpu_present_map);
-}
-
 /*
  * Set up the logical destination ID when the APIC operates in logical
  * destination mode.
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -70,7 +70,6 @@ static struct apic apic_flat __ro_after_
 	.name				= "flat",
 	.probe				= flat_probe,
 	.acpi_madt_oem_check		= flat_acpi_madt_oem_check,
-	.apic_id_registered		= default_apic_id_registered,
 
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= true,
@@ -139,7 +138,6 @@ static struct apic apic_physflat __ro_af
 	.name				= "physical flat",
 	.probe				= physflat_probe,
 	.acpi_madt_oem_check		= physflat_acpi_madt_oem_check,
-	.apic_id_registered		= default_apic_id_registered,
 
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= false,
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -61,8 +61,6 @@ void default_send_IPI_allbutself(int vec
 void default_send_IPI_all(int vector);
 void default_send_IPI_self(int vector);
 
-bool default_apic_id_registered(void);
-
 #ifdef CONFIG_X86_32
 void default_send_IPI_mask_sequence_logical(const struct cpumask *mask, int vector);
 void default_send_IPI_mask_allbutself_logical(const struct cpumask *mask, int vector);
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -38,7 +38,6 @@ static struct apic apic_default __ro_aft
 
 	.name				= "default",
 	.probe				= probe_default,
-	.apic_id_registered		= default_apic_id_registered,
 
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= true,

