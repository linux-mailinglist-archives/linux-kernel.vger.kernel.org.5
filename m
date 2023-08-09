Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05E1776A39
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234651AbjHIUgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbjHIUgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:36:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584D7211D;
        Wed,  9 Aug 2023 13:36:10 -0700 (PDT)
Date:   Wed, 09 Aug 2023 20:36:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691613369;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fAx6/DBTqZ9b24JRB23n48mMO1c95bbtwnPOhGCQBWE=;
        b=0zFuGbieuiXa8Dgs6zQL2AIWvLqvleMqGJdW+gjc1D2LbjvqfEsW0xiXYCz4vIXTQjFHAb
        JWMDnVcV3ftw+zOmAsVHnCUzYVoIsEI/aM4jBLgXjF9rU+5396fBH2+cdgPtJ/IM4UqUXK
        zPc3NyNaMHSSxiBxhqQLLhTN3nTq/Jze13PPutP75ANwnkQmRz7Hw33u/FiADwcEstPJwQ
        5rZb3IhsyvDWXwz/bNTgeiNGrhlt/tJITu7KZLwQ25UkgBm6oMWauYXHH50CH86ZrUjb9+
        LODbfbM88odP+Q7m9ukABUPHRRA0+oJ+iAKrU3pHvn+Aw1MfdVuacrJ25i4raQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691613369;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fAx6/DBTqZ9b24JRB23n48mMO1c95bbtwnPOhGCQBWE=;
        b=/2fvOVkONyPuD/e4WQ0tnaiDsZk6zwUhHC640wQHzZ4wmvdpTmRoqzkswyDP7QVeaUtwgq
        UhGo8Gav4EydQ8BQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Wrap apic->native_eoi() into a helper
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169161336854.27769.11656148486231578593.tip-bot2@tip-bot2>
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

Commit-ID:     0fa075769cd4af9c568044973e7bdf430cc7c158
Gitweb:        https://git.kernel.org/tip/0fa075769cd4af9c568044973e7bdf430cc7c158
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:04:17 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 11:58:34 -07:00

x86/apic: Wrap apic->native_eoi() into a helper

Prepare for converting the hotpath APIC callbacks to static calls.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
---
 arch/x86/include/asm/apic.h | 6 ++++++
 arch/x86/kernel/kvm.c       | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 6ad3574..5d98c4b 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -359,6 +359,11 @@ static inline void apic_eoi(void)
 	apic->eoi();
 }
 
+static inline void apic_native_eoi(void)
+{
+	apic->native_eoi();
+}
+
 static inline u64 apic_icr_read(void)
 {
 	return apic->icr_read();
@@ -397,6 +402,7 @@ static inline void apic_icr_write(u32 low, u32 high) { }
 static inline void apic_wait_icr_idle(void) { }
 static inline u32 safe_apic_wait_icr_idle(void) { return 0; }
 static inline void apic_set_eoi_cb(void (*eoi)(void)) {}
+static inline void apic_native_eoi(void) { WARN_ON_ONCE(1); }
 
 #endif /* CONFIG_X86_LOCAL_APIC */
 
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index f5339e3..54625a4 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -343,7 +343,7 @@ static notrace void kvm_guest_apic_eoi_write(void)
 	 */
 	if (__test_and_clear_bit(KVM_PV_EOI_BIT, this_cpu_ptr(&kvm_apic_eoi)))
 		return;
-	apic->native_eoi();
+	apic_native_eoi();
 }
 
 static void kvm_guest_cpu_init(void)
