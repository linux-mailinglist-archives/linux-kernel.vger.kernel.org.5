Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F4A75F861
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjGXNep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjGXNe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:34:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC17E4F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:34:07 -0700 (PDT)
Message-ID: <20230724132045.302673759@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690205645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=0iz4gOQLk9YymQJzW0sXfBIS7q8+WXoqEL26ZlioJL4=;
        b=Xz0CBr9Lx/F97q60oo2TJl/rIh4wp9YR5yDt/NzlEfhRyvG/k4hkwGXHbqIttOltxjkIIE
        n1NkEPszq+IY2E8Xbm9vUVFXkGWCb+8sMgSSloBoq6E7sYsPjhe/vtsttHB7i3gteDeKUy
        Q0cTfsroCBBfhLgteNdOHF6liK2nkP4yWgVNcMQMchyAghfrqgrKeh9srmx/jXiOz6hLh0
        XXhjm56aXF/3S3njp6ikNTj5teGShCU/yINPNqgd7U0z+QTs8pYU9c2Tg1RLYeaugNCN2N
        LwJHgKYBc9p9jW91OsOfh4/TsrkQJRjPuI7nnLuIoks07T0Gs41RPQDaR3AErQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690205645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=0iz4gOQLk9YymQJzW0sXfBIS7q8+WXoqEL26ZlioJL4=;
        b=IPIJ1OB6vHgbYWZ+wbD/Ea5C0pKjCuU9X5VMxMh6DCl6Y9WA26t9nP8HXWg466VLBFHFeL
        uL2M/9ZnvgHii2Aw==
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
Subject: [patch V2 12/58] x86/of: Fix the APIC address registration
References: <20230724131206.500814398@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Jul 2023 15:34:04 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device tree APIC parser tries to force enable the local APIC when it is
not set in CPUID. apic_force_enable() registers the boot CPU apic on
success.

If that succeeds then dtb_lapic_setup() registers the local APIC again
eventually with a different address.

Rewrite the code so that it only registers it once.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/devicetree.c |   14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -157,19 +157,15 @@ static void __init dtb_lapic_setup(void)
 
 	/* Did the boot loader setup the local APIC ? */
 	if (!boot_cpu_has(X86_FEATURE_APIC)) {
+		/* Try force enabling, which registers the APIC address */
 		if (apic_force_enable(lapic_addr))
 			return;
-	}
-	smp_found_config = 1;
-	if (of_property_read_bool(dn, "intel,virtual-wire-mode")) {
-		pr_info("Virtual Wire compatibility mode.\n");
-		pic_mode = 0;
 	} else {
-		pr_info("IMCR and PIC compatibility mode.\n");
-		pic_mode = 1;
+		register_lapic_address(lapic_addr);
 	}
-
-	register_lapic_address(lapic_addr);
+	smp_found_config = 1;
+	pic_mode = !of_property_read_bool(dn, "intel,virtual-wire-mode");
+	pr_info("%s compatibility mode.\n", pic_mode ? "IMCR and PIC" : "Virtual Wire");
 }
 
 #endif /* CONFIG_X86_LOCAL_APIC */

