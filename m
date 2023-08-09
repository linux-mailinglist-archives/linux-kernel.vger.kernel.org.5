Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08965776839
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbjHITNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbjHITMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:12:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6D92D41;
        Wed,  9 Aug 2023 12:12:27 -0700 (PDT)
Date:   Wed, 09 Aug 2023 19:12:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691608343;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=RZg5Gjy7rLpF5IZsWLnVkjA/ZqnKC+GzHeXqWnZFjU8=;
        b=oHtyKjHxg3lrAwbMZB0mhStDfpnjAsfHXHZA2WqMeunTis2KuPgT33oa0wNnpDYsOcLmSB
        DGG1wIJ604hltwlVx4GdkW5ymqmFPJIxBK/fweZBXBn/Jw/cJM/57ySeePwl3ucDtzB9Ey
        Wnw6QqYMCI1uEczxuS9IUHzkFwkowrQUQTDzTXyh8ohBUUOfAQEABbonIRiZchLdBk+UXO
        yVMqtnrlDAbHv9f/CfaMf5uvYBNQR9YzymN6fMNKSYVlU3v2T9ipqm8u9uS1VyhnG47u7o
        gtD8e2ay2FDs24BLLjn3POH8vANAyrHHB/u/tnlLmbcjFkKEfPDDTxarVk3mmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691608343;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=RZg5Gjy7rLpF5IZsWLnVkjA/ZqnKC+GzHeXqWnZFjU8=;
        b=3YNhE8c3jaT5RQF9G2b01LNgU5FpcouhhVCC1md0HKKYQz/dBYSMSBzzlknEU4C+6v34lj
        OEM6hRvvBndKheBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Nuke another processor check
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169160834286.27769.10953648367600131647.tip-bot2@tip-bot2>
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

Commit-ID:     55cc40d3df3c5c49f3a72e451bb710ec9e398ddc
Gitweb:        https://git.kernel.org/tip/55cc40d3df3c5c49f3a72e451bb710ec9e398ddc
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:03:50 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 11:58:22 -07:00

x86/apic: Nuke another processor check

The boot CPUs local APIC is now always registered, so there is no point to
have another unreadable validatation for it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
---
 arch/x86/kernel/smpboot.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index fc2173b..da795f7 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1181,23 +1181,6 @@ static void __init smp_sanity_check(void)
 		set_nr_cpu_ids(8);
 	}
 #endif
-
-	if (!physid_isset(read_apic_id(), phys_cpu_present_map)) {
-		pr_warn("weird, boot CPU (#%d) not listed by the BIOS\n",
-			read_apic_id());
-
-		physid_set(read_apic_id(), phys_cpu_present_map);
-	}
-
-	/*
-	 * Should not be necessary because the MP table should list the boot
-	 * CPU too, but we do it for the sake of robustness anyway.
-	 */
-	if (!apic->check_phys_apicid_present(boot_cpu_physical_apicid)) {
-		pr_notice("weird, boot CPU (#%d) not listed by the BIOS\n",
-			  boot_cpu_physical_apicid);
-		physid_set(read_apic_id(), phys_cpu_present_map);
-	}
 	preempt_enable();
 }
 
