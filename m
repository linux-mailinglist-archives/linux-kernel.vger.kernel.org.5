Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F3075F883
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjGXNhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjGXNg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:36:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120E8199D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:35:33 -0700 (PDT)
Message-ID: <20230724132047.032747989@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690205695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Lzl2By5b2bK0JPapjkW1rKVMFogh5AbCCARtLT2XDn0=;
        b=dKLgGaYjmQ+PDSrgXUt3a40pQz0lqc0CqpaIw0bblx7M9Iq2UhM2019pPJpQDgGlseU2hL
        g/MLOLgpKSLyytFPMBEFN1KcM5BmPQJ+6Gx9PjgXIzNOnLc8oawQhgTlhaLjZO2IuReNLq
        w2NwjNYYLrTuGq9ygWB+CVc5spMU0qtliH/VnZ4R814LDuBVL1bjqNz+2bn1te3nvaFQ6Q
        V3O5sLQMlGWL7q6D1Y4jZ6sULbuL2pG+XURTfRdu3icbcpteTFjKeE0PS2KV+wdKbseeKw
        stNDZKev/oJcXesTL9DrDVZjnwK5Vkr9PT4RXVP2thg0UGJmm2S9yiuZ7K2gKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690205695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Lzl2By5b2bK0JPapjkW1rKVMFogh5AbCCARtLT2XDn0=;
        b=+SvsShFD5tmWNU40Hf6ZLQUFjt2TnPlRIwScVhF8JSzzyZ2KTHnjRSKz3jQFIZwIy5rWb+
        PHBXzgTQ3FfUSnBA==
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
Subject: [patch V2 41/58] x86/apic: Add max_apic_id member
References: <20230724131206.500814398@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Jul 2023 15:34:55 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is really no point to have a callback which compares numbers.

Add a field which allows each APIC to store the maximum APIC ID supported
and fill it in for all APIC incarnations.

The next step will remove the callback.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/apic.h           |    3 +++
 arch/x86/kernel/apic/apic_flat_64.c   |    2 ++
 arch/x86/kernel/apic/apic_noop.c      |    1 +
 arch/x86/kernel/apic/apic_numachip.c  |    2 ++
 arch/x86/kernel/apic/bigsmp_32.c      |    1 +
 arch/x86/kernel/apic/probe_32.c       |    1 +
 arch/x86/kernel/apic/x2apic_cluster.c |    1 +
 arch/x86/kernel/apic/x2apic_phys.c    |    1 +
 arch/x86/kernel/apic/x2apic_uv_x.c    |    1 +
 arch/x86/xen/apic.c                   |    1 +
 10 files changed, 14 insertions(+)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -277,6 +277,9 @@ struct apic {
 	u64	(*icr_read)(void);
 	void	(*icr_write)(u32 low, u32 high);
 
+	/* The limit of the APIC ID space. */
+	u32	max_apic_id;
+
 	/* Probe, setup and smpboot functions */
 	int	(*probe)(void);
 	int	(*acpi_madt_oem_check)(char *oem_id, char *oem_table_id);
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -94,6 +94,7 @@ static struct apic apic_flat __ro_after_
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= flat_phys_pkg_id,
 
+	.max_apic_id			= 0xFE,
 	.get_apic_id			= flat_get_apic_id,
 	.set_apic_id			= set_apic_id,
 
@@ -170,6 +171,7 @@ static struct apic apic_physflat __ro_af
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= flat_phys_pkg_id,
 
+	.max_apic_id			= 0xFE,
 	.get_apic_id			= flat_get_apic_id,
 	.set_apic_id			= set_apic_id,
 
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -80,6 +80,7 @@ struct apic apic_noop __ro_after_init =
 
 	.phys_pkg_id			= noop_phys_pkg_id,
 
+	.max_apic_id			= 0xFE,
 	.get_apic_id			= noop_get_apic_id,
 	.set_apic_id			= NULL,
 
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -239,6 +239,7 @@ static const struct apic apic_numachip1
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= numachip_phys_pkg_id,
 
+	.max_apic_id			= UINT_MAX,
 	.get_apic_id			= numachip1_get_apic_id,
 	.set_apic_id			= numachip1_set_apic_id,
 
@@ -278,6 +279,7 @@ static const struct apic apic_numachip2
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= numachip_phys_pkg_id,
 
+	.max_apic_id			= UINT_MAX,
 	.get_apic_id			= numachip2_get_apic_id,
 	.set_apic_id			= numachip2_set_apic_id,
 
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -91,6 +91,7 @@ static struct apic apic_bigsmp __ro_afte
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= bigsmp_phys_pkg_id,
 
+	.max_apic_id			= 0xFE,
 	.get_apic_id			= bigsmp_get_apic_id,
 	.set_apic_id			= NULL,
 
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -47,6 +47,7 @@ static struct apic apic_default __ro_aft
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= default_phys_pkg_id,
 
+	.max_apic_id			= 0xFE,
 	.get_apic_id			= default_get_apic_id,
 	.set_apic_id			= NULL,
 
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -239,6 +239,7 @@ static struct apic apic_x2apic_cluster _
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= x2apic_phys_pkg_id,
 
+	.max_apic_id			= UINT_MAX,
 	.get_apic_id			= x2apic_get_apic_id,
 	.set_apic_id			= x2apic_set_apic_id,
 
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -163,6 +163,7 @@ static struct apic apic_x2apic_phys __ro
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= x2apic_phys_pkg_id,
 
+	.max_apic_id			= UINT_MAX,
 	.get_apic_id			= x2apic_get_apic_id,
 	.set_apic_id			= x2apic_set_apic_id,
 
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -822,6 +822,7 @@ static struct apic apic_x2apic_uv_x __ro
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.phys_pkg_id			= uv_phys_pkg_id,
 
+	.max_apic_id			= UINT_MAX,
 	.get_apic_id			= x2apic_get_apic_id,
 	.set_apic_id			= set_apic_id,
 
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -138,6 +138,7 @@ static struct apic xen_pv_apic = {
 	.cpu_present_to_apicid		= xen_cpu_present_to_apicid,
 	.phys_pkg_id			= xen_phys_pkg_id, /* detect_ht */
 
+	.max_apic_id			= UINT_MAX,
 	.get_apic_id 			= xen_get_apic_id,
 	.set_apic_id 			= xen_set_apic_id, /* Can be NULL on 32-bit. */
 

