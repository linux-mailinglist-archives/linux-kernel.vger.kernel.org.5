Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2262575F889
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjGXNhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjGXNgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:36:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF2AE57
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:35:29 -0700 (PDT)
Message-ID: <20230724132046.914636320@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690205692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=BfaXC6qRGr8XWK4LjXyteInjeXWpDiNfshAXINVsujg=;
        b=rBrBgPj4xEhKB5OhAKW3pKBeR22chHFszUB89FHDzDmmkDolz+dnpaCWcZ1gqFy7q0nyHo
        v3p539z+InJZl5ZcR7w2jARYFrnT4+ZYh1JxIu8Ju3uII8pNk3NzE8zzYiivONcX/eQLSF
        cnIjIUWrhQylRShC//xtYj+URn9Of8UztO0r9G60kG6qfiquF/3L7CUL1QkTa+nhZGDGOd
        q/nI4ghUEpH5R0DbhiFSiMVorz8jp1ZiUTDrbleL/zJUJbWeRWffkkoLn6VclcDSelKsgb
        6cCNBs98X/QWjN+D3rjKyrJfhDdTl7mmCmAUm1eNqIGCnFcuqRXZtcDjb+9uqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690205692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=BfaXC6qRGr8XWK4LjXyteInjeXWpDiNfshAXINVsujg=;
        b=ucjjb286RnMg6oNahVJ2kVDAMuUObBCOefXstNcdp+cdlwXF53ylY6NnTN+bhYqR/wPYal
        WdjLBfqB0nc87NCA==
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
Subject: [patch V2 39/58] x86/apic/64: Uncopypaste probing
References: <20230724131206.500814398@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Jul 2023 15:34:51 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need for the same thing twice. Also prepares for simplifying the APIC ID
validation checks.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/apic/probe_64.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

--- a/arch/x86/kernel/apic/probe_64.c
+++ b/arch/x86/kernel/apic/probe_64.c
@@ -13,6 +13,15 @@
 
 #include "local.h"
 
+static __init void apic_install_driver(struct apic *driver)
+{
+	if (apic == driver)
+		return;
+
+	apic = driver;
+	pr_info("Switched APIC routing to %s:\n", apic->name);
+}
+
 /* Select the appropriate APIC driver */
 void __init x86_64_probe_apic(void)
 {
@@ -22,11 +31,7 @@ void __init x86_64_probe_apic(void)
 
 	for (drv = __apicdrivers; drv < __apicdrivers_end; drv++) {
 		if ((*drv)->probe && (*drv)->probe()) {
-			if (apic != *drv) {
-				apic = *drv;
-				pr_info("Switched APIC routing to %s.\n",
-					apic->name);
-			}
+			apic_install_driver(*drv);
 			break;
 		}
 	}
@@ -38,11 +43,7 @@ int __init default_acpi_madt_oem_check(c
 
 	for (drv = __apicdrivers; drv < __apicdrivers_end; drv++) {
 		if ((*drv)->acpi_madt_oem_check(oem_id, oem_table_id)) {
-			if (apic != *drv) {
-				apic = *drv;
-				pr_info("Setting APIC routing to %s.\n",
-					apic->name);
-			}
+			apic_install_driver(*drv);
 			return 1;
 		}
 	}

