Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC1A776846
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbjHITNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbjHITM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:12:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA838212C;
        Wed,  9 Aug 2023 12:12:37 -0700 (PDT)
Date:   Wed, 09 Aug 2023 19:12:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691608345;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fJ0OYFuKv7/VhR4WNvEypz1rwyj+na07BQdaWK7QByc=;
        b=wZqZt38HrOeSeGWUag0tFZNGvEaFKr11dYxYgkDW3l5+dPSFocuKtLmRoVEoGMzFQXqtkb
        h2+Nk3JKTEZXJw52o9fpeMPb1OdqPSr94jXdLw5c/ERRm4sHgY/p0nxxkskVK9qcMzex1c
        6n8HtRbFbFZuWlcgoCVW9aEh6zVBuyOdhfwvSysCF5NPIM5GPf/fQnvZcy0znYrB1xpWwF
        iSThwOD7fa0VMsygU70hyOZItOTQckwCvJcDsjOL4wc0xp8HVRLcnq8kctA/3XFAUKbXB0
        3z5OGSaCC9dgp3/HFe9afTySyeu+fzT5vOiCznYUYCHuBbsUyFL4QSlJl1Dpyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691608345;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fJ0OYFuKv7/VhR4WNvEypz1rwyj+na07BQdaWK7QByc=;
        b=bjqEwHqqo1MPh81fzV3Ptv3A7Kj1o68QqO7ogPwpn+lbLpxypT7ClFGepWeawoJ+qfpe8N
        9FHaGmA+bLl17oCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/of: Fix the APIC address registration
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169160834528.27769.7010023693541059077.tip-bot2@tip-bot2>
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

Commit-ID:     2906a67ac83b06b874b32bf6413a8d5e186fc33e
Gitweb:        https://git.kernel.org/tip/2906a67ac83b06b874b32bf6413a8d5e186fc33e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:03:47 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 11:58:19 -07:00

x86/of: Fix the APIC address registration

The device tree APIC parser tries to force-enable the local APIC when it is
not set in CPUID. apic_force_enable() registers the boot CPU apic on
success.

If that succeeds then dtb_lapic_setup() registers the local APIC again
eventually with a different address.

Rewrite the code so that it only registers it once.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
---
 arch/x86/kernel/devicetree.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index 56f6d59..8f94eb6 100644
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
