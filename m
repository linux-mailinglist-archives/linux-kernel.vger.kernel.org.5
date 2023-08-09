Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842B777683F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbjHITNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbjHITM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:12:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A0B2D5D;
        Wed,  9 Aug 2023 12:12:35 -0700 (PDT)
Date:   Wed, 09 Aug 2023 19:12:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691608345;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=4YEWXcifivVg86UmH2c6Xpd661pLlI0IsER53UddTuk=;
        b=QvduAGBgkSz0ceDN27YYH35/C5aGCnaVNA2h2/mvslUHOJUyEeQs2eVNEIW8yocSmT4+Eg
        pci15o45OyM9wyMoWv97zi89mS+ljKZ0nBVRg9hEXaaEuew+OdTzBGjyX1vk5ldosHCeTs
        5RtHH9GoylO9ZW0PT5LdDkIJIBwga6TGIfmH/PKTdITGdF3JfJ/zUDwWQEgWNuAnIZWus0
        dJKopS25EQowAwnZYzhvAA2x6dgB6hjpTk57kpMDfBqzpFsUjaLT7rDKDogYV3/RhFxsso
        wXVLd4RzxkT8HUlVqK3PxQ8PXBKthamRXlqvIYJX+y3RlLb/fmYanmrNtGBdFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691608345;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=4YEWXcifivVg86UmH2c6Xpd661pLlI0IsER53UddTuk=;
        b=59bLDVV0nrsyhvdKlFv6fvE1fGyjWZlqEwq6ZZK6v8FtNHre3ot+IJlcLaXIKQoAARWrZM
        BHnH0rTq7v4kZhDA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Split register_apic_address()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169160834444.27769.11587842002054923417.tip-bot2@tip-bot2>
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

Commit-ID:     5a88f354dcd8f19436bbda52f075276a5c70424f
Gitweb:        https://git.kernel.org/tip/5a88f354dcd8f19436bbda52f075276a5c70424f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:03:48 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 11:58:20 -07:00

x86/apic: Split register_apic_address()

Split the fixmap setup out of register_lapic_address() and reuse it when
the X2APIC is disabled during setup.

This avoids registering the APIC ID (setting 'mp_lapic_addr') twice.

[ dhansen: changelog wording tweak ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
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
