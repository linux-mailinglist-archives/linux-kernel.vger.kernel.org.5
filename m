Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2DE2757074
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjGQXVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjGQXV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:21:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718FE10E6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:20:51 -0700 (PDT)
Message-ID: <20230717223226.237896259@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689635757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=wkf9cxbN9yugedivD8sL7QgWMpf0hUBTEyuN6MHJ80U=;
        b=coF5HZJV4lqAYCOI0x2G+gk1jggvNOUYFRaiSC7p/lKyOLLZKnfZMXpV86Hyn3lXE5+VHp
        ybatAk06keDr7f3cuz22LBVPV7vGXEC/je7DzSUqVT5cqV/pToJLetgUyeZONbZFsMkXQQ
        JL0FFUava8lwobIOamFi5GMpID/VSIfgyySgc6iUqWrtByMo43awM7eC4xhuO8THhQgHi+
        FDaXyFMES6qzHokM53hTbATJBbpXiB4E3q14zvPXr0qMViaGoC6IFP/pbAFtsXyZ0ScrbL
        sWQEixc98e+h8HPq6I0pYyHBSX2dY1LzBn8GwatXXzRx/9Wq7xi7uEKgZdOx9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689635757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=wkf9cxbN9yugedivD8sL7QgWMpf0hUBTEyuN6MHJ80U=;
        b=y/kUV7th0yY9Sc72a2b6dJKP+HSWRlwG2D6jYUjXl1y5Fqw1sVZdtT0jMk4c2hQKvkzOpX
        BA2Ixn/NetWpRVAg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 53/58] x86/apic: Convert other overrides to apic_update_callback()
References: <20230717223049.327865981@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 18 Jul 2023 01:15:57 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert all places which just assign a new function directly to the apic
callback to use apic_update_callback() which prepares for using static
calls.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/hyperv/hv_apic.c |   20 ++++++++++----------
 arch/x86/kernel/kvm.c     |    4 ++--
 arch/x86/kernel/sev.c     |    2 +-
 3 files changed, 13 insertions(+), 13 deletions(-)

--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -288,12 +288,12 @@ void __init hv_apic_init(void)
 		 */
 		orig_apic = *apic;
 
-		apic->send_IPI = hv_send_ipi;
-		apic->send_IPI_mask = hv_send_ipi_mask;
-		apic->send_IPI_mask_allbutself = hv_send_ipi_mask_allbutself;
-		apic->send_IPI_allbutself = hv_send_ipi_allbutself;
-		apic->send_IPI_all = hv_send_ipi_all;
-		apic->send_IPI_self = hv_send_ipi_self;
+		apic_update_callback(send_IPI, hv_send_ipi);
+		apic_update_callback(send_IPI_mask, hv_send_ipi_mask);
+		apic_update_callback(send_IPI_mask_allbutself, hv_send_ipi_mask_allbutself);
+		apic_update_callback(send_IPI_allbutself, hv_send_ipi_allbutself);
+		apic_update_callback(send_IPI_all, hv_send_ipi_all);
+		apic_update_callback(send_IPI_self, hv_send_ipi_self);
 	}
 
 	if (ms_hyperv.hints & HV_X64_APIC_ACCESS_RECOMMENDED) {
@@ -312,10 +312,10 @@ void __init hv_apic_init(void)
 		 */
 		apic_update_callback(eoi, hv_apic_eoi_write);
 		if (!x2apic_enabled()) {
-			apic->read      = hv_apic_read;
-			apic->write     = hv_apic_write;
-			apic->icr_write = hv_apic_icr_write;
-			apic->icr_read  = hv_apic_icr_read;
+			apic_update_callback(read, hv_apic_read);
+			apic_update_callback(write, hv_apic_write);
+			apic_update_callback(icr_write, hv_apic_icr_write);
+			apic_update_callback(icr_read, hv_apic_icr_read);
 		}
 	}
 }
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -624,8 +624,8 @@ late_initcall(setup_efi_kvm_sev_migratio
  */
 static void kvm_setup_pv_ipi(void)
 {
-	apic->send_IPI_mask = kvm_send_ipi_mask;
-	apic->send_IPI_mask_allbutself = kvm_send_ipi_mask_allbutself;
+	apic_update_callback(send_IPI_mask, kvm_send_ipi_mask);
+	apic_update_callback(send_IPI_mask_allbutself, kvm_send_ipi_mask_allbutself);
 	pr_info("setup PV IPIs\n");
 }
 
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1099,7 +1099,7 @@ void snp_set_wakeup_secondary_cpu(void)
 	 * required method to start APs under SNP. If the hypervisor does
 	 * not support AP creation, then no APs will be started.
 	 */
-	apic->wakeup_secondary_cpu = wakeup_cpu_via_vmgexit;
+	apic_update_callback(wakeup_secondary_cpu, wakeup_cpu_via_vmgexit);
 }
 
 int __init sev_es_setup_ap_jump_table(struct real_mode_header *rmh)

