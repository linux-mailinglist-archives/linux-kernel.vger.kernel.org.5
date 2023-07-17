Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAD8757088
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjGQXdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjGQXdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:33:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F353170B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:32:09 -0700 (PDT)
Message-ID: <20230717223225.394633265@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689635735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=s19156BZmBKn/+gIefFlMT9NlvbxtvZTdSeLRnjoukg=;
        b=AWwAwQ1TbJlPno3V2qAdO5g6RApmn7VllVPsrl/7OPR6659zM4BKEJfpKFZfw+TxUZxr8N
        5KNw4pbJeD8lt5X1aBHqb1168Xxk6sieVUBDc+DIiioSkkqUlXj/Z8wCRFmyJBODduSL9N
        5UVyNpTG+YH5kAOCpIB3FGSuoAXW3PWtRwb5fsqJePV+23OeXsS43kReNA9XEU5Vq/GoYk
        YxXxqyrGsGoyhPJYBRFPiI7w7gP/P0bVfA5dYxqij9B6LhGFF/eOOUBOkKW0I7RVhLsRvt
        6DMXYRsr54FdCXrhmgUz2pB7PqHkXRJZgRn+3MpdCr69VZRUICG1yE7+PE+fCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689635735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=s19156BZmBKn/+gIefFlMT9NlvbxtvZTdSeLRnjoukg=;
        b=BgH8Loq6CGCh7V/YU3PyzfQ/I2OtaC9oE8h4mS+YVzQZWiGu8SJrNesSc+PPSfipdXfBvI
        NpYRqDGn+YCxsDAQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 39/58] x86/apic/64: Uncopypaste probing
References: <20230717223049.327865981@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 18 Jul 2023 01:15:35 +0200 (CEST)
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

