Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA867763DB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbjHIPeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbjHIPeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:34:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A4A1FEF;
        Wed,  9 Aug 2023 08:34:16 -0700 (PDT)
Date:   Wed, 09 Aug 2023 15:34:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691595255;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=b3vNKmw56FU15T9NY5n50SyYRbcYGKFHcGc4Ez4sTQY=;
        b=JeJ3Eyt1axyVGdOfZmgWo0o0HXsOlTjtClRnIngOolPiM+BFYPkYp3ELm8bD1SXoGm0sMl
        7sIC2ibBnfFT/K4IGN8AUR+xrmEfeX0QpWtNIx4aQIbjAajuVwFvZoacqnx+/UcYP3/5Mt
        JyaPLhGyEldbsgxjp2vBd2eRK2y5+f7bUHAQZutRlZre81WP30/WgN4cJdmHSAXXzcBnc9
        vCuiB6sAnOwxyPmBD8lWBi74mYF9cqFpxeK/w1RCDWxFzjB3CWe9FA0Vooa/OrhQY7/8PA
        XeDiG5i5AqNt/TJ/JqWCDDHn4r4b91NbTopY64Pwbs0SrdwZAfNdBXCHdE88jQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691595255;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=b3vNKmw56FU15T9NY5n50SyYRbcYGKFHcGc4Ez4sTQY=;
        b=ODZXVQ/0JzKQKraWWE2xGzNeMRP1hk8ENh5+ca7s5Akaxk9NYo9Mkx+SVxMsyOFlBgaDvK
        RcW7qhNV+G1z7tDw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Split register_apic_address()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169159525448.27769.13238318626262028013.tip-bot2@tip-bot2>
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

Commit-ID:     90815d75ec85919de391dd982b5c866dc67b8758
Gitweb:        https://git.kernel.org/tip/90815d75ec85919de391dd982b5c866dc67b8758
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:03:48 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 08:10:11 -07:00

x86/apic: Split register_apic_address()

Split the fixmap setup out of register_lapic_address() and reuse it when
the X2APIC is disabled during setup.

This avoids registering the APIC ID (setting 'mp_lapic_addr') twice.

[ dhansen: changelog wording tweak ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/apic/apic.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index d0f4cca..45ae178 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1852,6 +1852,8 @@ void x2apic_setup(void)
 	__x2apic_enable();
 }
 
+static __init void apic_set_fixmap(void);
+
 static __init void x2apic_disable(void)
 {
 	u32 x2apic_id, state = x2apic_state;
@@ -1872,7 +1874,7 @@ static __init void x2apic_disable(void)
 	}
 
 	__x2apic_disable();
-	register_lapic_address(mp_lapic_addr);
+	apic_set_fixmap();
 }
 
 static __init void x2apic_enable(void)
@@ -2145,17 +2147,21 @@ void __init init_apic_mappings(void)
 	}
 }
 
+static __init void apic_set_fixmap(void)
+{
+	set_fixmap_nocache(FIX_APIC_BASE, mp_lapic_addr);
+	apic_mmio_base = APIC_BASE;
+	apic_printk(APIC_VERBOSE, "mapped APIC to %16lx (%16lx)\n",
+		    apic_mmio_base, mp_lapic_addr);
+	apic_read_boot_cpu_id(false);
+}
+
 void __init register_lapic_address(unsigned long address)
 {
 	mp_lapic_addr = address;
 
-	if (x2apic_mode)
-		return;
-
-	set_fixmap_nocache(FIX_APIC_BASE, address);
-	apic_mmio_base = APIC_BASE;
-	apic_printk(APIC_VERBOSE, "mapped APIC to %16lx (%16lx)\n", APIC_BASE, address);
-	apic_read_boot_cpu_id(false);
+	if (!x2apic_mode)
+		apic_set_fixmap();
 }
 
 /*
