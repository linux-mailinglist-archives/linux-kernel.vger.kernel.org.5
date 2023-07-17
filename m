Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7001B757072
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjGQXUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjGQXUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:20:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE591B3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:19:46 -0700 (PDT)
Message-ID: <20230717223225.997925757@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689635751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=9TaSlhjUTakFiVj1azrlzZ2xVg2Xkr4O8C5JrwSXaPY=;
        b=w1ZbVj5JoX+S2m2HtC951EaBUqWGWCI2c5QAVVr2tUm4sfpNycBLzdjLWi4mmhnbD9OxXN
        7zIChhVge0gA93t2mlqOtoO7Ki49d8BhlSQizly6WMUwwYQ5gYuOqqXwbwgwKTImc80hxA
        ufdLZxuiBV2GYtHcSaAYjMnYT5S2T+BliY3239Qt8Y64MKDQTK9DwtAAlnWGV15n/JS00I
        ftHfyiwOtSyd+pe38RWMjZakYR+7zrnwLr/FHjC0pI9NwaKAKJKqzvJViqLmHb8h4VJAPi
        y3KsurgSAS760ihHk6YteCeVkJ327STQa9rCsXOe0Q0BOj6D1U2p6aOpqyzA2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689635751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=9TaSlhjUTakFiVj1azrlzZ2xVg2Xkr4O8C5JrwSXaPY=;
        b=UyPlwkBARb1hXbyifHDOgDybuzN/RtN64FgVFT9nLzHpECycP0TApiv3hXvGkY1RgpJpps
        AOsJDS7yQX55yVBw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 49/58] x86/apic: Wrap apic->native_eoi() into a helper
References: <20230717223049.327865981@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 18 Jul 2023 01:15:51 +0200 (CEST)
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
---
 arch/x86/include/asm/apic.h |    5 +++++
 arch/x86/kernel/kvm.c       |    2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

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

