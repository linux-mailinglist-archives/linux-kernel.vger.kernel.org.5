Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260CA7763DF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbjHIPeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233624AbjHIPeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:34:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373E8E7F;
        Wed,  9 Aug 2023 08:34:17 -0700 (PDT)
Date:   Wed, 09 Aug 2023 15:34:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691595255;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=1mzk4Fdmg7OF78bNSPalC8kY4+GX6IXg5KmZsj2z7GE=;
        b=H7+A70KVpSPYGJKs4rkYdnCQclVSnPFedGO6rtjVsg/wYQhYJcrd7Q+dYajgTeWFc7myjY
        OtinjrHqBE75XYopwa4AcNXl7XmEaiABN3BG56dlCd3DR9e4Cjpy0pLGl+CbtHH2C4Vfzs
        Q1sGDPkoRKVD4y4XD1bk3y8rU4zTk2IiKuTZb+sRDywkCWDKH/U3oq1Y8CdjXVqV0f7GRv
        yIOfjiVzJmpCeoUa8Bt0IJ/F9Xp2qcr3UwTa5Jzn7tjT/Q0McgLusnDK6PuUEoRI34WW9Z
        JRAAO5EQBam+QQo6GownXA8VcL7YTAWAUaXML4imPio4trdqewNYiaCAZf/lvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691595255;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=1mzk4Fdmg7OF78bNSPalC8kY4+GX6IXg5KmZsj2z7GE=;
        b=F7Lkyrmh+55cMCaBiu8+x2HFRK+5/Q9K3JEV8kTVm0/vlq5V4mkf8DNYxlaZMhyKQ2x3xX
        3NQqaAER+MIMWhDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/of: Fix the APIC address registration
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169159525531.27769.1178775004292207939.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     b735dd86b7c75df0863065ae5ab154be2dcf2a9d
Gitweb:        https://git.kernel.org/tip/b735dd86b7c75df0863065ae5ab154be2dcf2a9d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:03:47 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 08:10:11 -07:00

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
