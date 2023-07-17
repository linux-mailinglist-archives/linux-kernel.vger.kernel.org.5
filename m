Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC35757056
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjGQXP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjGQXPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:15:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D24A170F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:14:55 -0700 (PDT)
Message-ID: <20230717223223.795705685@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689635693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=oO9hcqnpNwvqYXrZ+6Z6cARd5ofqbuQWYypUIdXUUcI=;
        b=p7b6/Bis4eXvJ7P7OK19N8ZEt+C+dp7pjK1yD7IFcMFEtxgTJl/IOBgPbh/NH6/bVPfEtC
        Czqqoyll9VnvOxtEJyIjAvCu4MvMRESmDb0VPpLkAh0kOdiMOzcyseAr5qz64QkYxsuW6E
        Df1ytueO2TeawBnB7AQ4SjbREIiyOtCkPaJORc7Lzi6T3dcXVJTtZV0oDnovkz1SOoNb4S
        iFSvOFBCbL0BCHi2YBAeI7UCunfSMds2s06ogGyPWe3Dgiyf5hm35WtNp4HeqwIDD5sUtk
        5qg7YT2NCTcZSIeekDKkhG0NriDLzT0xxBrLR0FbUF22dUH4d4y2B/Gg5pcy5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689635693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=oO9hcqnpNwvqYXrZ+6Z6cARd5ofqbuQWYypUIdXUUcI=;
        b=wZpkUn2cRMrRvmnxKnBieim+IVSwk2CPB0K19234yqR5v4qeFA6mJIP/kDNHpMJXAyyovl
        53nr1vAHeDKHfzAw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 12/58] x86/of: Fix the APIC address registration
References: <20230717223049.327865981@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 18 Jul 2023 01:14:52 +0200 (CEST)
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

