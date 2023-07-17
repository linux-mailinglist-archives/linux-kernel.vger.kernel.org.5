Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D6075705A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjGQXPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjGQXP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:15:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6585B173B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:14:58 -0700 (PDT)
Message-ID: <20230717223223.913161388@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689635696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=6lsXOSCdebUCwT7n6zhHvn8DJi5YZlZjkDwKMSiOzL0=;
        b=MXEXcw0tO5uqiDRsXTnO1WBHMsD/0ClTumSqTLX7DyN70nfu5/fdzzOhrzzHZveO4r1D6b
        6oFfLSbK9kF08uQuLICNty1yodyumD3rKz9EfI1n6JlwYTnhRbYjPmjljqGX88Fpw6La/A
        IfOhKQHwTm4IMWL9cXEE2SV8Oud65buCZfMODG/e15uAOUkuas3ZVUryW2B8WNTWnC2Stl
        l21SnNLcNOUFeL3EoBv9UMs5smQlqxLC6U0Vt8nUWuPCE7I6TslCptB5rm3FY2B8Lu5SSw
        IJdpheAGkEm4JBZDXY9EzzzUCRWQSdGzg476eSlIl9BHbbmZCowo7t8utmrO+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689635696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=6lsXOSCdebUCwT7n6zhHvn8DJi5YZlZjkDwKMSiOzL0=;
        b=7Y5AMRjCRyDwmGRaUhRVIFOHgb79/2tewqVXhnRTQVeAcdD8zj38cRXDrd1JXiGD518QaE
        KdXPf7Sd90IYV3CQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 14/58] x86/apic: Split register_apic_address()
References: <20230717223049.327865981@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 18 Jul 2023 01:14:55 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split the fixmap setup out of register_lapic_address() and reuse it when
the X2APIC is disabled during setup.

This avoids that the APIC ID is registered twice.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/apic.c |   22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

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

