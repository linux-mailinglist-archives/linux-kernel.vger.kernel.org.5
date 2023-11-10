Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D78A7E777D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 03:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345876AbjKJC3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 21:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345785AbjKJC3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 21:29:21 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A37546AA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 18:29:19 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5bd0c909c50so1504887a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 18:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699583358; x=1700188158; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=fjDXmprU9Q2uJ1P2ZcBSz5/xZE4cUzlnzK3sR8+dOOk=;
        b=g1Wmfa/6C6BFSkjQ/aTj/HWNjTE5L0IP32bwcFxXycGtynuqUozvRb7LLkI9Hp+b4N
         4do0qPR60+Nvb3um+hwpVaLKMb1qIY3rfV82sb7rKRBiLe/fE+3287+EN5LyfMGTCrkR
         Fh//GeAGFsBxIzTEqrSkuE5NshS/9WfSdsK39Vm1ie0+6En9lgM+YtrRPySrvoUTiVyf
         KiYe609q7hrYgUWuhUYu+YxF7VCJy7TndTt3h/3cz3JqRBJSgAWWW2V6cjsP3T7K9La7
         IIlX7zEDYk3I8hBgRm74myvOTay5G4aqee578bKaPfc/S3ljZdvr1X7h+n4pes7nOGaT
         +N4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699583358; x=1700188158;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fjDXmprU9Q2uJ1P2ZcBSz5/xZE4cUzlnzK3sR8+dOOk=;
        b=ACTP0P/jfS/N3i9bOtmP1T5tcu/qAubj2UlXHxlo3BEXXx86DG9rzEfAcQLKSA4ELd
         Icbj5HrixPRxfDduzwMilrw0F2zewoLZobwz2OMwfvGCe9ImXKFidzXkWHQ99+kUvEku
         /5M+8DuegBppyYrAG2yzdY9m1BWgsZ7yESXb2bPUSR6gDgFXOIXrh2LftmgSt95oERDC
         uy/j4qNqOXnD4qNb9yETBFKy22B1LMsQyz+UMuiGY+lNmnKn6MRoaijAVZsTo8UDUhhz
         8Np3xObm3Yf0QAKWW14VgNZRFmgPwLrbva0WFUfB6EC9ewDa9EzTt51I1JU6PMggHyhV
         2nbg==
X-Gm-Message-State: AOJu0YztSAXt9+UeTzhLD+c9O8GPfGfSnQCvRBsp8MHArCO0jQ/z5aAI
        WlTU6uWzMe0kb5+Vgz7uHv4QkVQ/7IQ=
X-Google-Smtp-Source: AGHT+IF8gdeQdC2vix2B9j35/6cn/ogiC7i3MtASLOgt733RFCpaQp4XZVOTIKgNYM7TT4sAmY3DEPPy3HQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:2591:b0:1cb:d9ff:e26f with SMTP id
 jb17-20020a170903259100b001cbd9ffe26fmr829172plb.5.1699583358643; Thu, 09 Nov
 2023 18:29:18 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  9 Nov 2023 18:28:56 -0800
In-Reply-To: <20231110022857.1273836-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231110022857.1273836-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231110022857.1273836-10-seanjc@google.com>
Subject: [PATCH 09/10] KVM: x86/pmu: Check eventsel first when emulating
 (branch) insns retired
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When triggering events, i.e. emulating PMC events in software, check for
a matching event selector before checking the event is allowed.  The "is
allowed" check *might* be cheap, but it could also be very costly, e.g. if
userspace has defined a large PMU event filter.  The event selector check
on the other hand is all but guaranteed to be <10 uops, e.g. looks
something like:

   0xffffffff8105e615 <+5>:	movabs $0xf0000ffff,%rax
   0xffffffff8105e61f <+15>:	xor    %rdi,%rsi
   0xffffffff8105e622 <+18>:	test   %rax,%rsi
   0xffffffff8105e625 <+21>:	sete   %al

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/pmu.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index ba561849fd3e..a5ea729b16f2 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -847,9 +847,6 @@ void kvm_pmu_trigger_event(struct kvm_vcpu *vcpu, u64 eventsel)
 		return;
 
 	kvm_for_each_pmc(pmu, pmc, i, bitmap) {
-		if (!pmc_event_is_allowed(pmc))
-			continue;
-
 		/*
 		 * Ignore checks for edge detect (all events currently emulated
 		 * but KVM are always rising edges), pin control (unsupported
@@ -864,11 +861,11 @@ void kvm_pmu_trigger_event(struct kvm_vcpu *vcpu, u64 eventsel)
 		 * might be wrong if they are defined in the future, but so
 		 * could ignoring them, so do the simple thing for now.
 		 */
-		if ((pmc->eventsel ^ eventsel) & AMD64_RAW_EVENT_MASK_NB)
+		if (((pmc->eventsel ^ eventsel) & AMD64_RAW_EVENT_MASK_NB) ||
+		    !pmc_event_is_allowed(pmc) || !cpl_is_matched(pmc))
 			continue;
 
-		if (cpl_is_matched(pmc))
-			kvm_pmu_incr_counter(pmc);
+		kvm_pmu_incr_counter(pmc);
 	}
 }
 EXPORT_SYMBOL_GPL(kvm_pmu_trigger_event);
-- 
2.42.0.869.gea05f2083d-goog

