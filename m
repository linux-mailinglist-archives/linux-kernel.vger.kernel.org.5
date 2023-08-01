Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD00376B230
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjHAKrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbjHAKrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:47:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BAE2110
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:46:58 -0700 (PDT)
Message-ID: <20230801103815.818545643@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690886816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=0iz4gOQLk9YymQJzW0sXfBIS7q8+WXoqEL26ZlioJL4=;
        b=xHfj3Ew1Yfp+Xqbj7e4eEVWNpZs6jPQwoH7rDreB7MWpFzWI4Eb+94HPs+2QQvg1SNex3e
        LUdfKxlc459j381mPw7h4xbwlHCiJeb7KcklVppzqNWaeuT4MGk6O/ex0nq+BrKOZVbMAb
        QAYVZAmDd/gkCAq9y2e/IbWba/UQrVySWk0BgXsSEq1Mx2u9yNimZWa1WL2JNq9z4z+pS6
        zh3SbLqLxld4eKkswvW+Q9YHftBtp4oY57kZWvE/W1Rtljfwe8wZpsG4iiXZ2h+qCcg+xL
        N1yJp3djA5h2IX5GEPztsM/t2bcJWEN5+nJKOlfws3xdXk3PXJLVHt98GylTDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690886816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=0iz4gOQLk9YymQJzW0sXfBIS7q8+WXoqEL26ZlioJL4=;
        b=i/RHiBUZXMIBJq5wLGL9/QaOS+tQvhKnvbAXPFNIeih8x/8IKk0Tpj8TkIUkf/+yIuKPgz
        Btqre1SxqulJZ3Cw==
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
Subject: [patch V3 12/60] x86/of: Fix the APIC address registration
References: <20230801103042.936020332@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  1 Aug 2023 12:46:56 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
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

