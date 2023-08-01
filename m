Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FEE76B24C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbjHAKuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbjHAKtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:49:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274DDE67
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:47:50 -0700 (PDT)
Message-ID: <20230801103817.350848224@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690886850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=BfaXC6qRGr8XWK4LjXyteInjeXWpDiNfshAXINVsujg=;
        b=LGMIkIAvrUcgGmyBK8dkv3QdDQbOaE8cKvA9mptEdM2JBVCAWkUvvSu4fWPBSvvIUBTwRh
        JhnQFArWVYX2yJLApZHViro8ax+4P1SwvVqJRKAjNSP5GDg5rYTIbRet3TOS1MltkZSgWg
        IK+fvkLaqyN86b09eTmJHNjSRQg+3bH72MRXM8BhqGa1eARTdwfZYNCgBS/QgbWWdSsb0C
        uv5uaLNOGBClzwuYS8rx+Vkc8dorxpindSMZyKUQXXn2geOmH4jp+sbkrSlwyT5KuaMJmJ
        OMDY6b8NsjE+czFA9I5q+mqfq6z/koIugwxws6Ejf+1JAGYqldfh/lXQayYi0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690886850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=BfaXC6qRGr8XWK4LjXyteInjeXWpDiNfshAXINVsujg=;
        b=VfpDmiSXSmVKPFo2gWjCj0HaHmiuqXoJG4PKmbCMgoDXyTCdTcAGGwlUt5WztHwkUl2AER
        zRYUgRH0nV4nosBw==
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
Subject: [patch V3 40/60] x86/apic/64: Uncopypaste probing
References: <20230801103042.936020332@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  1 Aug 2023 12:47:30 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
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

