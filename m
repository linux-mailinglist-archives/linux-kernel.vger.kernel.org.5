Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D4475F88F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbjGXNhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjGXNhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:37:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA850E77
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:35:59 -0700 (PDT)
Message-ID: <20230724132047.495400662@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690205709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=CpgDO7ZbLfJdlLPlI0db0hJw7XEH0Imhn7HEF8CCLXo=;
        b=GydzcP+5vv/kl7uKcPVlMMHLpmFD0l8nXi6AMWbNDi03/b1r7uTw6+Rj0WT6ik1Gr+Mdn7
        QqZAaWdLfW+DZDMhWZMc58HWU/EmG2a9cRMQIAfCvdMNTHtqG461NdclZbNOun2Vlg4vCg
        gW4aktHMqF7+I0/MngG8yzbUzNUob/dlHfe7aET2wTYqjPjsD7kTiasySw6AI7TAUKDMWW
        GDdpgt+dQ5YJ1yKEVFA3ojt+lPjH0S6Q98YooDOzc/C/1cesJoAiNlcznJakLWxI+W6Iu9
        eA1xGKWfQ/Kxw6eYWkYuIi9PPlaZKPb+hG8o31oVo+rNgk67j4cFKe2a9Dt5YA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690205709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=CpgDO7ZbLfJdlLPlI0db0hJw7XEH0Imhn7HEF8CCLXo=;
        b=AG/UIE0EkiquUTMu1w3y0vyIvTuJykviy1LEKtkbdoPjLBwokYbvyva3kSOAV0qSknBlwb
        2wA2HMxwVy1p73BA==
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
Subject: [patch V2 49/58] x86/apic: Wrap apic->native_eoi() into a helper
References: <20230724131206.500814398@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Jul 2023 15:35:09 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for converting the hotpath APIC callbacks to static calls.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/apic.h |    6 ++++++
 arch/x86/kernel/kvm.c       |    2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

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
@@ -397,6 +402,7 @@ static inline void apic_icr_write(u32 lo
 static inline void apic_wait_icr_idle(void) { }
 static inline u32 safe_apic_wait_icr_idle(void) { return 0; }
 static inline void apic_set_eoi_cb(void (*eoi)(void)) {}
+static inline void apic_native_eoi(void) { WARN_ON_ONCE(1); }
 
 #endif /* CONFIG_X86_LOCAL_APIC */
 
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -343,7 +343,7 @@ static notrace void kvm_guest_apic_eoi_w
 	 */
 	if (__test_and_clear_bit(KVM_PV_EOI_BIT, this_cpu_ptr(&kvm_apic_eoi)))
 		return;
-	apic->native_eoi();
+	apic_native_eoi();
 }
 
 static void kvm_guest_cpu_init(void)

