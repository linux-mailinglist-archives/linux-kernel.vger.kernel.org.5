Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2385776A4C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbjHIUg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234598AbjHIUgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:36:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A692681;
        Wed,  9 Aug 2023 13:36:15 -0700 (PDT)
Date:   Wed, 09 Aug 2023 20:36:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691613373;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pLS/yN2JRu4KeYQ10Wo0ka6U0a/tWqGmM3JwO0xgb5Y=;
        b=lg3Ef+xijgqHZ39tCEiv5nHBcz22+8KXgVtThgOCp9VGKPKriyNgJNhUGjQxUxmr/wnog4
        P8+wQpfnkR5mRcs+Xhg+s+OFKEfwJ8eUoQYXaj+De+LVtCuAiJLaw60/xi6QxyPJ0T8r4N
        u89W85zyU1VJr06WyYx3JeBO45dS7A9foNjhjTDQfrddD7wF2b7nz7TQGZGjLfA2cmvUXv
        KwkV3xsZOBbvysqPoJrOZfAJhnvX5m7ewxZCXR6mrrHb4ZaIKrCi3e7YnPysvTSt3xJT25
        VYeOKgKdjy9328zB5jgS9//4FqBo1Ox1JSjWGbFJfZQ7D3biFcfbcyGevEuuDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691613373;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pLS/yN2JRu4KeYQ10Wo0ka6U0a/tWqGmM3JwO0xgb5Y=;
        b=4RpydYh79RXBQkC8Ms34GL2O8t5hM6VoGbDqGzu43tCuar9Xdwn5aTfAhMEVurz8S8ufSj
        oGZxG923NYp9sRCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic/64: Uncopypaste probing
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169161337321.27769.6325032308676598325.tip-bot2@tip-bot2>
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

Commit-ID:     d65eb3195862d600b120b3f6481e016c312158cb
Gitweb:        https://git.kernel.org/tip/d65eb3195862d600b120b3f6481e016c312158cb
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:04:08 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 11:58:30 -07:00

x86/apic/64: Uncopypaste probing

No need for the same thing twice. Also prepares for simplifying the APIC ID
validation checks.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
---
 arch/x86/kernel/apic/probe_64.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/apic/probe_64.c b/arch/x86/kernel/apic/probe_64.c
index 7c9f1a8..a82bb52 100644
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
@@ -38,11 +43,7 @@ int __init default_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
 
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
