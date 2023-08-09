Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA17776A2E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbjHIUgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234476AbjHIUgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:36:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBDC210D;
        Wed,  9 Aug 2023 13:36:07 -0700 (PDT)
Date:   Wed, 09 Aug 2023 20:36:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691613366;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=HqQREe5s5t0jawKfWIjoBUzhTBBvOGOobL6oF/1tVUs=;
        b=FtQkt73nX7mVe4Em0Dk/Hn0DS6Ui0JQIemvAOAyHlv4C1T8WFzbZ7vdMvOUJro0i46rdEL
        yyuyEdKPPDHIIKzvCbOtcWEtUk+RKvfL/EJkCXzBn3KjlZmu8D+sJrAno52LaXgjz20vLy
        mgrWMsOPV2DyC5WnoxilIjQiQpHkEZP31J912z3RsQvHlAvnzdCCBjocXRREA+N6q6zqpH
        nYNHp1M/jhwhiCFeC5t1tS8duyBYnAKCieLP+6Yb0z1UoYjdJlF9P7l+0CA94RlTnrngzc
        g4BVQ8lgiZ9JZhIftBho+Wj0iMlt+eP4aOkGpD4brVeU4Ac3miek8SxVIGnrNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691613366;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=HqQREe5s5t0jawKfWIjoBUzhTBBvOGOobL6oF/1tVUs=;
        b=PBpyYsXr9KtTZIgntOR9qiATEd4zJtxsTp0ixEkaKPA8iwrmrGjP+a65f39bt48WAxrDCB
        3k4G1CQAdrpGVqCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/xen/apic: Mark apic __ro_after_init
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169161336571.27769.15995204331486892801.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     ac72b92d8cec9ee96f15301a4d5a3dd455c0a7cf
Gitweb:        https://git.kernel.org/tip/ac72b92d8cec9ee96f15301a4d5a3dd455c0a7cf
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:04:21 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 12:00:46 -07:00

x86/xen/apic: Mark apic __ro_after_init

Nothing can change it post init.

Remove the 32bit callbacks and comments as XENPV is strictly 64bit.

While at it mop up the whitespace damage which causes eyebleed due to an
editor which is highlighting it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
Cc: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/apic.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/arch/x86/xen/apic.c b/arch/x86/xen/apic.c
index 315ffd8..7ad9122 100644
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -123,43 +123,41 @@ static int xen_cpu_present_to_apicid(int cpu)
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
