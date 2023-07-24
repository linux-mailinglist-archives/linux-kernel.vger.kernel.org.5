Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB2275F895
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjGXNhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjGXNg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:36:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD391725
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:35:31 -0700 (PDT)
Message-ID: <20230724132046.268860951@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690205673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=1MEDk0oUWD+OycA9uR7KeKJmXv9b1vvtIY5WeHz0Kk0=;
        b=PsT1fjCbeFHPX5gR7wz7ZuUfLetbIW+odeHAQy2K+GWvdd0ez+dEy745FTPwbZ21PqnGQa
        n9khcoeM2lLy6L6wz51GutsnbN9okHi+T5/c4RddI8jEbTNAY77AHzqDABqI4Zu1t2JLzd
        VQUygUidONd4kQCFz14D1tC5st7wAGZzogFMIZA9oPP6qjDWZsojNVSF+ffZc4gi+zoX2X
        5G9b20mKL6WVaGT2vId1H87vYfrfd7vL49PrVdBFWNLMUbQUV7yYxakmXOMBgaoFzSG+tV
        hxIFVE73vNbTwdjCzE8JShzd40QdmQeBqXDoz1q5/KiYIZRRxukYdnI4MHN7Ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690205673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=1MEDk0oUWD+OycA9uR7KeKJmXv9b1vvtIY5WeHz0Kk0=;
        b=CZM0h76jmGa8clxQp1+le4Rr89tr61uDp3K5wlZYgpG5gSYJYrex7EcvNIGQR9c+CL8UJr
        3vm6GkdZyTvmyMBQ==
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
Subject: [patch V2 28/58] x86/apic: Nuke apic::apicid_to_cpu_present()
References: <20230724131206.500814398@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Jul 2023 15:34:32 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is only used on 32bit and is a wrapper around
physid_set_mask_of_physid() in all 32bit APIC drivers.

Remove the callback and use physid_set_mask_of_physid() in the code
directly,

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/apic.h           |    1 -
 arch/x86/kernel/apic/apic_flat_64.c   |    2 --
 arch/x86/kernel/apic/apic_noop.c      |    1 -
 arch/x86/kernel/apic/apic_numachip.c  |    2 --
 arch/x86/kernel/apic/bigsmp_32.c      |    1 -
 arch/x86/kernel/apic/io_apic.c        |   11 +++++------
 arch/x86/kernel/apic/probe_32.c       |    1 -
 arch/x86/kernel/apic/x2apic_cluster.c |    1 -
 arch/x86/kernel/apic/x2apic_phys.c    |    1 -
 arch/x86/kernel/apic/x2apic_uv_x.c    |    1 -
 arch/x86/xen/apic.c                   |    1 -
 11 files changed, 5 insertions(+), 18 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -304,7 +304,6 @@ struct apic {
 	void	(*ioapic_phys_id_map)(physid_mask_t *phys_map, physid_mask_t *retmap);
 	void	(*setup_apic_routing)(void);
 	int	(*cpu_present_to_apicid)(int mps_cpu);
-	void	(*apicid_to_cpu_present)(int phys_apicid, physid_mask_t *retmap);
 	int	(*phys_pkg_id)(int cpuid_apic, int index_msb);
 
 	u32	(*get_apic_id)(unsigned long x);
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -103,7 +103,6 @@ static struct apic apic_flat __ro_after_
 	.ioapic_phys_id_map		= NULL,
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
-	.apicid_to_cpu_present		= NULL,
 	.phys_pkg_id			= flat_phys_pkg_id,
 
 	.get_apic_id			= flat_get_apic_id,
@@ -181,7 +180,6 @@ static struct apic apic_physflat __ro_af
 	.ioapic_phys_id_map		= NULL,
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
-	.apicid_to_cpu_present		= NULL,
 	.phys_pkg_id			= flat_phys_pkg_id,
 
 	.get_apic_id			= flat_get_apic_id,
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -96,7 +96,6 @@ struct apic apic_noop __ro_after_init =
 	.ioapic_phys_id_map		= default_ioapic_phys_id_map,
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
-	.apicid_to_cpu_present		= physid_set_mask_of_physid,
 
 	.phys_pkg_id			= noop_phys_pkg_id,
 
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -255,7 +255,6 @@ static const struct apic apic_numachip1
 	.ioapic_phys_id_map		= NULL,
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
-	.apicid_to_cpu_present		= NULL,
 	.phys_pkg_id			= numachip_phys_pkg_id,
 
 	.get_apic_id			= numachip1_get_apic_id,
@@ -299,7 +298,6 @@ static const struct apic apic_numachip2
 	.ioapic_phys_id_map		= NULL,
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
-	.apicid_to_cpu_present		= NULL,
 	.phys_pkg_id			= numachip_phys_pkg_id,
 
 	.get_apic_id			= numachip2_get_apic_id,
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -103,7 +103,6 @@ static struct apic apic_bigsmp __ro_afte
 	.ioapic_phys_id_map		= bigsmp_ioapic_phys_id_map,
 	.setup_apic_routing		= bigsmp_setup_apic_routing,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
-	.apicid_to_cpu_present		= physid_set_mask_of_physid,
 	.phys_pkg_id			= bigsmp_phys_pkg_id,
 
 	.get_apic_id			= bigsmp_get_apic_id,
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1512,11 +1512,10 @@ void __init setup_ioapic_ids_from_mpc_no
 			ioapics[ioapic_idx].mp_config.apicid = i;
 		} else {
 			physid_mask_t tmp;
-			apic->apicid_to_cpu_present(mpc_ioapic_id(ioapic_idx),
-						    &tmp);
-			apic_printk(APIC_VERBOSE, "Setting %d in the "
-					"phys_id_present_map\n",
-					mpc_ioapic_id(ioapic_idx));
+
+			physid_set_mask_of_physid(mpc_ioapic_id(ioapic_idx), &tmp);
+			apic_printk(APIC_VERBOSE, "Setting %d in the phys_id_present_map\n",
+				    mpc_ioapic_id(ioapic_idx));
 			physids_or(phys_id_present_map, phys_id_present_map, tmp);
 		}
 
@@ -2546,7 +2545,7 @@ static int io_apic_get_unique_id(int ioa
 		apic_id = i;
 	}
 
-	apic->apicid_to_cpu_present(apic_id, &tmp);
+	physid_set_mask_of_physid(apic_id, &tmp);
 	physids_or(apic_id_map, apic_id_map, tmp);
 
 	if (reg_00.bits.ID != apic_id) {
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -60,7 +60,6 @@ static struct apic apic_default __ro_aft
 	.ioapic_phys_id_map		= default_ioapic_phys_id_map,
 	.setup_apic_routing		= setup_apic_flat_routing,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
-	.apicid_to_cpu_present		= physid_set_mask_of_physid,
 	.phys_pkg_id			= default_phys_pkg_id,
 
 	.get_apic_id			= default_get_apic_id,
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -249,7 +249,6 @@ static struct apic apic_x2apic_cluster _
 	.ioapic_phys_id_map		= NULL,
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
-	.apicid_to_cpu_present		= NULL,
 	.phys_pkg_id			= x2apic_phys_pkg_id,
 
 	.get_apic_id			= x2apic_get_apic_id,
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -168,7 +168,6 @@ static struct apic apic_x2apic_phys __ro
 	.ioapic_phys_id_map		= NULL,
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
-	.apicid_to_cpu_present		= NULL,
 	.phys_pkg_id			= x2apic_phys_pkg_id,
 
 	.get_apic_id			= x2apic_get_apic_id,
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -840,7 +840,6 @@ static struct apic apic_x2apic_uv_x __ro
 	.ioapic_phys_id_map		= NULL,
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
-	.apicid_to_cpu_present		= NULL,
 	.phys_pkg_id			= uv_phys_pkg_id,
 
 	.get_apic_id			= x2apic_get_apic_id,
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -152,7 +152,6 @@ static struct apic xen_pv_apic = {
 	.ioapic_phys_id_map		= default_ioapic_phys_id_map, /* Used on 32-bit */
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= xen_cpu_present_to_apicid,
-	.apicid_to_cpu_present		= physid_set_mask_of_physid, /* Used on 32-bit */
 	.phys_pkg_id			= xen_phys_pkg_id, /* detect_ht */
 
 	.get_apic_id 			= xen_get_apic_id,

