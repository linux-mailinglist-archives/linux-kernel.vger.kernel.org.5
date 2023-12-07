Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A51807D8C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 02:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441847AbjLGBDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 20:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441968AbjLGBDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 20:03:11 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7127AD73
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 17:03:17 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db99bac23cdso541154276.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 17:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701910996; x=1702515796; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kNsTQFENpLV0yAX5x5gNndSdmWF67ocLDbukBVvw4Ho=;
        b=VBXdf5CnxCVBGP34y2jrZgUXAB3D+Etu2qzxQ7x4Iiqlzlrr3TrdiGUia7gbUt0OJz
         bxjsnsxC30jqgOBckgOzD4xi2ND/Qv/VAuSXcHUYPkB8Wru/eENwPE7DKRlWC6npfx9t
         46tkl86j8NKQSyJwMVC4wVWrE9qq07mPx3ObBigFWvSf1E/oUclgXmjFDOVcnGHyv7Hx
         gzIVTGRUh1IoH6iP40sTPPU3YlV0dQiBRTut12QJ9OqWU34MLj5t6gZ7HmWGjD475rKJ
         Q7HozIdE7JBNkkt35QLZVgn6s1NNUtCQRX0Y8iopRkepZNn4jslNci1YOgQ1pNV7ijE3
         Ms9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701910996; x=1702515796;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kNsTQFENpLV0yAX5x5gNndSdmWF67ocLDbukBVvw4Ho=;
        b=dv/R1mUw1tNxAxZ3N3BHXOA5f7rDsfqusQmbsxUi73PrxuIRuXTen7TfNnfeNOrIxp
         PdM1Sq/4oBVIZccIQKR6uzsKTMyYBB36U/RmXIr+0YnBynnl0YL+3cC7wZU9nlo0Z8kA
         rcKelRCnaxZCU2VWvZ76hjYQOw0OOT5V3vOvSVv8bWDe2w5xt2XRNqFKbrzWUksf91Fy
         8oPQN10aQZ9N1Xpiz97dorOr/JN/znl8Tvtr/PTrvOfvzjpuayfsEKWQYVVaMO9HSiLh
         fc051ez76Ye0MYJe2S7vHOlqbYe18JXG+NJwcU3nL8e/Zp9YzzZjL63/jXC8LwC1tV48
         e2PA==
X-Gm-Message-State: AOJu0Yw76rzsBz44bjWGrAyQ2kFNGEqwAroK5JScnADqsQCUFGgwdAop
        3klM1+BK9pscRC0AJl83EQaXsUYra+QHUQ==
X-Google-Smtp-Source: AGHT+IEeNrOu3itFc+M9ynsd08u9d5b33h7Ph3dWYLMht1q/VwgbdO1TO2ezXuPbPGpyVmgh4Cp2D8u2f11e3g==
X-Received: from loggerhead.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:29a])
 (user=jmattson job=sendgmr) by 2002:a25:2981:0:b0:dbc:3553:efe with SMTP id
 p123-20020a252981000000b00dbc35530efemr3380ybp.4.1701910996183; Wed, 06 Dec
 2023 17:03:16 -0800 (PST)
Date:   Wed,  6 Dec 2023 17:03:02 -0800
In-Reply-To: <20220921003201.1441511-11-seanjc@google.com>
Mime-Version: 1.0
References: <20220921003201.1441511-11-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231207010302.2240506-1-jmattson@google.com>
Subject: [PATCH v4 10/12] KVM: x86: never write to memory from kvm_vcpu_check_block()
From:   Jim Mattson <jmattson@google.com>
To:     seanjc@google.com
Cc:     aleksandar.qemu.devel@gmail.com, alexandru.elisei@arm.com,
        anup@brainfault.org, aou@eecs.berkeley.edu, atishp@atishpatra.org,
        borntraeger@linux.ibm.com, chenhuacai@kernel.org, david@redhat.com,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com, james.morse@arm.com,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        maz@kernel.org, mlevitsk@redhat.com, oliver.upton@linux.dev,
        palmer@dabbelt.com, paul.walmsley@sifive.com, pbonzini@redhat.com,
        suzuki.poulose@arm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvm_vcpu_check_block() is called while not in TASK_RUNNING, and therefore
it cannot sleep.  Writing to guest memory is therefore forbidden, but it
can happen on AMD processors if kvm_check_nested_events() causes a vmexit.

Fortunately, all events that are caught by kvm_check_nested_events() are
also recognized by kvm_vcpu_has_events() through vendor callbacks such as
kvm_x86_interrupt_allowed() or kvm_x86_ops.nested_ops->has_events(), so
remove the call and postpone the actual processing to vcpu_block().

Opportunistically honor the return of kvm_check_nested_events().  KVM
punted on the check in kvm_vcpu_running() because the only error path is
if vmx_complete_nested_posted_interrupt() fails, in which case KVM exits
to userspace with "internal error" i.e. the VM is likely dead anyways so
it wasn't worth overloading the return of kvm_vcpu_running().

Add the check mostly so that KVM is consistent with itself; the return of
the call via kvm_apic_accept_events()=>kvm_check_nested_events() that
immediately follows  _is_ checked.

Reported-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[sean: check and handle return of kvm_check_nested_events()]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index dcc675d4e44b..8aeacbc2bff9 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10815,6 +10815,17 @@ static inline int vcpu_block(struct kvm_vcpu *vcpu)
 			return 1;
 	}
 
+	/*
+	 * Evaluate nested events before exiting the halted state.  This allows
+	 * the halt state to be recorded properly in the VMCS12's activity
+	 * state field (AMD does not have a similar field and a VM-Exit always
+	 * causes a spurious wakeup from HLT).
+	 */
+	if (is_guest_mode(vcpu)) {
+		if (kvm_check_nested_events(vcpu) < 0)
+			return 0;
+	}
+
 	if (kvm_apic_accept_events(vcpu) < 0)
 		return 0;
 	switch(vcpu->arch.mp_state) {
@@ -10837,9 +10848,6 @@ static inline int vcpu_block(struct kvm_vcpu *vcpu)
 
 static inline bool kvm_vcpu_running(struct kvm_vcpu *vcpu)
 {
-	if (is_guest_mode(vcpu))
-		kvm_check_nested_events(vcpu);
-
 	return (vcpu->arch.mp_state == KVM_MP_STATE_RUNNABLE &&
 		!vcpu->arch.apf.halted);
 }

This commit breaks delivery of a (virtualized) posted interrupt from
an L1 vCPU to a halted L2 vCPU.

Looking back at commit e6c67d8cf117 ("KVM: nVMX: Wake blocked vCPU in
guest-mode if pending interrupt in virtual APICv"), Liran wrote:

    Note that this also handles the case of nested posted-interrupt by the
    fact RVI is updated in vmx_complete_nested_posted_interrupt() which is
    called from kvm_vcpu_check_block() -> kvm_arch_vcpu_runnable() ->
    kvm_vcpu_running() -> vmx_check_nested_events() ->
    vmx_complete_nested_posted_interrupt().

Clearly, that is no longer the case.
