Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0B375F896
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjGXNi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbjGXNiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:38:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADE93C10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:36:47 -0700 (PDT)
Message-ID: <20230724132047.780772553@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690205718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=O0XTJMurd8agT9XR8N/9h35QD+xMCyVQhi7/zAo436M=;
        b=ZWXoG6IobDx6riWyjqKv9qh46qsw9PmprJtJxi4cys5MjKFTsvisDgmmRYUsv+el8SE71+
        KXGU+c97azP3w1HyMNrA3DQs+oh+YqGjJiymvTiUP0QxmnEYO3Mlp+lhxR1X1IcQPyG8nX
        P9dx2m+we7FjI8tMuwYh14bjeIaUp2jhqes9xOzIVU14C3OjlP4XFcMk3biwaxEbgBrY52
        Z5LI1bs0PmVBhwbbadTB01QVmLhMncMo1ROmsMXQSaMIWG5r6vHe2wxjPzofoHS/YRkETT
        33PvP6hUv45T2UDOBZUPEhgf9sRgPyBSxsxut+X2/33WJQF3HjDIl8Zt/h3rkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690205718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=O0XTJMurd8agT9XR8N/9h35QD+xMCyVQhi7/zAo436M=;
        b=bi4hxsCuLFaqNkJLJd0Of7FbqVBIiWHA7kyC7kZlN4qP2gWFrXinMDkuM/ShQlOGiW1Ghl
        nFxs6eylWxcHPgCQ==
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
Subject: [patch V2 54/58] x86/xen/apic: Mark apic __ro_after_init
References: <20230724131206.500814398@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Jul 2023 15:35:17 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
 arch/x86/xen/apic.c |   26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -123,39 +123,37 @@ static int xen_cpu_present_to_apicid(int
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
 
 static void __init xen_apic_check(void)

