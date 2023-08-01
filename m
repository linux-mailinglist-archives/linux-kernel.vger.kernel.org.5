Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3ED76B25E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbjHAKwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjHAKva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:51:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5383E2D42
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:49:04 -0700 (PDT)
Message-ID: <20230801103818.214469342@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690886870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=rpTRjlnnjgf8oYcfpsFvRp74BGzYvWPgVxB1Kwz9Sb8=;
        b=b6UmIyWp7JRa3iyD8EaaXENlR2Wrt6psOarGkTEb2TK22UeAXMgwQwcq8h8t03fv0I2C+D
        IoeacXSH2ZVimObm/LrTcjzdNwhvetGBcpX9cyQEY5sYYGlGjnl6yqbPqlCeVwSYoP9X/l
        iGOlvDzc31DPS6LEonkItVK6TLlPJSFD0MUOeTWjxN2xozgZeGWrtP/lOp4NnwjYMeJk66
        xRIL6jRFy4cAvIdRvgrBeBp2tVlBuqW8tM9teQiCrKQ01E0hJGQVLEx7Gtmu7mZzhZkP/y
        cG1O4LK+x2u/mkgD3YSVOC0TEhjllRbm21/nUDf8HCAjL8WIF4HujNFr/D4BAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690886870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=rpTRjlnnjgf8oYcfpsFvRp74BGzYvWPgVxB1Kwz9Sb8=;
        b=r+PBtLoZFsOTPQkwISDyGcQeGOmDZpoFit4aBnN7GTjjPPz2dGJwRJq1bortUs+c+AZaN0
        EP5lDTGhc8PU2VCg==
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
Subject: [patch V3 56/60] x86/xen/apic: Mark apic __ro_after_init
References: <20230801103042.936020332@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  1 Aug 2023 12:47:50 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing can change it post init.

Remove the 32bit callbacks and comments as XENPV is strictly 64bit.

While at it mop up the whitespace damage which causes eyebleed due to an
editor which is highlighting it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/apic.c |   28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -123,43 +123,41 @@ static int xen_cpu_present_to_apicid(int
 		return BAD_APICID;
 }
 
-static struct apic xen_pv_apic = {
-	.name 				= "Xen PV",
-	.probe 				= xen_apic_probe_pv,
+static struct apic xen_pv_apic __ro_after_init = {
+	.name				= "Xen PV",
+	.probe				= xen_apic_probe_pv,
 	.acpi_madt_oem_check		= xen_madt_oem_check,
 
 	/* .delivery_mode and .dest_mode_logical not used by XENPV */
 
 	.disable_esr			= 0,
 
-	.check_apicid_used		= default_check_apicid_used, /* Used on 32-bit */
-	.ioapic_phys_id_map		= default_ioapic_phys_id_map, /* Used on 32-bit */
 	.cpu_present_to_apicid		= xen_cpu_present_to_apicid,
 	.phys_pkg_id			= xen_phys_pkg_id, /* detect_ht */
 
 	.max_apic_id			= UINT_MAX,
-	.get_apic_id 			= xen_get_apic_id,
-	.set_apic_id 			= xen_set_apic_id, /* Can be NULL on 32-bit. */
+	.get_apic_id			= xen_get_apic_id,
+	.set_apic_id			= xen_set_apic_id,
 
 	.calc_dest_apicid		= apic_flat_calc_apicid,
 
 #ifdef CONFIG_SMP
-	.send_IPI_mask 			= xen_send_IPI_mask,
-	.send_IPI_mask_allbutself 	= xen_send_IPI_mask_allbutself,
-	.send_IPI_allbutself 		= xen_send_IPI_allbutself,
-	.send_IPI_all 			= xen_send_IPI_all,
-	.send_IPI_self 			= xen_send_IPI_self,
+	.send_IPI_mask			= xen_send_IPI_mask,
+	.send_IPI_mask_allbutself	= xen_send_IPI_mask_allbutself,
+	.send_IPI_allbutself		= xen_send_IPI_allbutself,
+	.send_IPI_all			= xen_send_IPI_all,
+	.send_IPI_self			= xen_send_IPI_self,
 #endif
 	.read				= xen_apic_read,
 	.write				= xen_apic_write,
 	.eoi				= xen_apic_eoi,
 
-	.icr_read 			= xen_apic_icr_read,
-	.icr_write 			= xen_apic_icr_write,
+	.icr_read			= xen_apic_icr_read,
+	.icr_write			= xen_apic_icr_write,
 };
+apic_driver(xen_pv_apic);
 
 void __init xen_init_apic(void)
 {
 	x86_apic_ops.io_apic_read = xen_io_apic_read;
 }
-apic_driver(xen_pv_apic);

