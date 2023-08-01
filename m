Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7410176B267
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbjHAKxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbjHAKwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:52:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237294EF3
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:49:35 -0700 (PDT)
Message-ID: <20230801103817.892965330@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690886863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=CpgDO7ZbLfJdlLPlI0db0hJw7XEH0Imhn7HEF8CCLXo=;
        b=PB5/h93f7WNHKZqVF+7zXooMGDbMpvNs4+oNXuQ3ml8wv5imEqsCM7Kvi2rnm59G7e59Jv
        YAooy28ID1FUVvNdQVjbUJQmoSACx2uqmldWj/Pv1Rj24e2bG9jBAtxIoF7hziqyI7l2Ob
        rVXUf07hhMWVgxcw/UxgYTkgwPPGzzNrZ5hnG3cAlIiXIRVFI2m5VnQiJ2kq57d2/MNcf9
        i6MbcCOgx9h3F6I4oGM63fEb+pZIrytHemWj59Xhk8Vz20VOVvNOZCOLfr6NVuX2sefF8E
        i9TDETgnJ2q0PG0yNOExqbaToHW0vpXcFTIdU5+vgCnlrMExXS4Op30+PF8/Pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690886863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=CpgDO7ZbLfJdlLPlI0db0hJw7XEH0Imhn7HEF8CCLXo=;
        b=rSbDhj6kuoKHt9tWI8NbL3knTsGThgpKdOOvqoWXaFwaZDf26U8ctTTsivJYWcabRJeXss
        wUDvykFh1wHxNpAA==
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
Subject: [patch V3 50/60] x86/apic: Wrap apic->native_eoi() into a helper
References: <20230801103042.936020332@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  1 Aug 2023 12:47:42 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
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

