Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54EB479D730
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236656AbjILRHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235297AbjILRH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:07:27 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DF410D9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:07:23 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-68fb8e7115eso4237855b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694538443; x=1695143243; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/3BcICV5TcaAp/tV1Z+AiMSUHHNst5J2lkKv8Z8FT38=;
        b=KKNi4s5FuRLHsFw73lytoakbGpwTRaZQtiXxRzNZ54teDXsAuemN2EWCJTqZHjtxnK
         Q1+Qc62g6TzL1K6vkq1SHVRoqz65SntVWvk4neqH8P9e1X5YOeHlNInP2dAF0NpE6F5D
         T+FLUbe7njwpjkdco4TgT49nsmATFNbzfSgxlKRp3rnbrvwYOxpZG9IfCU470ocYC2/T
         sWgmw0A86OP1EHfDfY8Qq6Q6yugAlhafp2fRd2mWHJ2w/Jln10Soh23LDVHN29CyW37L
         uE2ledLUb7VilpYG48fDhoqQ3IVg/csReiezmAeKDKzNvjMfNPthgqOTY/kstzS9CQUs
         p/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694538443; x=1695143243;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/3BcICV5TcaAp/tV1Z+AiMSUHHNst5J2lkKv8Z8FT38=;
        b=ZAskNc0qIybhv2+vogeCizUsYs4zeiuBKzRXfpzw6XAvSA7PC+wAzvG8o3czHUZD3k
         QkL/1aDEaxW0SbQhZABpJzY6La7iz92c+AHZUV54Ieoy3u2J3ZfXV7T1W0CUxO18Zmqw
         ubBXeVlqI5aRbQxZX+ILaouElfovEQ7qT9g8+VhCdIRVKAaCUu3oVFDW4ql9FgyYmNEP
         1rbCiW3bfdVT326AnzomObqvgG0yTfcb7KoF7RSvxhPGFZWL5MeAe2q281cNjFjA5B/z
         DlemnQegUAmO2hjY3nvMV8p+cceJawbZrSi9VlQBtmux81Eb4gBLL7q3hrEnH064OmXJ
         RUJQ==
X-Gm-Message-State: AOJu0Yz7/8zDMwiidxuEBctMiWOmyBMTHBNC+cOmSn1zrDAFT2ZmVp/t
        yq3r8RmteaG28Gh54Dt+tBGWZ6iQQ1I=
X-Google-Smtp-Source: AGHT+IGM3S4koFEdiAG0hKnMNdDHnWEexRx81djDvqAfRBC8MvDyYp+FSUsfdhGQL7QVMW4+/pnRlnKrycw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:188b:b0:68f:cb69:8e76 with SMTP id
 x11-20020a056a00188b00b0068fcb698e76mr95817pfh.2.1694538443136; Tue, 12 Sep
 2023 10:07:23 -0700 (PDT)
Date:   Tue, 12 Sep 2023 10:07:20 -0700
In-Reply-To: <20230912161518.199484-1-hshan@google.com>
Mime-Version: 1.0
References: <20230912161518.199484-1-hshan@google.com>
Message-ID: <ZQCayNY+8PYvfc40@google.com>
Subject: Re: [PATCH] KVM: x86: Fix lapic timer interrupt lost after loading a snapshot.
From:   Sean Christopherson <seanjc@google.com>
To:     Haitao Shan <hshan@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023, Haitao Shan wrote:
> This issue exists in kernel version 6.3-rc1 or above. The issue is
> introduced by the commit 8e6ed96cdd50 ("KVM: x86: fire timer when it is
> migrated and expired, and in oneshot mode"). The issue occurs on Intel
> platform which APIC virtualization and posted interrupt processing.

I think the bug was actually introduced by:

  967235d32032 ("KVM: vmx: clear pending interrupts on KVM_SET_LAPIC")

Fixing the "deadline <= 0" handling just made it much easier to be hit.  E.g. if
the deadline was '1' during restore, set_target_expiration() would set tscdeadline
to T1+(1*N), where T1 is the current TSC and N is the multipler to get from nanoseconds
to cycles.  start_sw_tscdeadline() (or vmx_set_hv_timer()) would then reread the
TSC (call it T2), see T2 > T1+(1*N), and mark the timer as expired.

> The issue is first discovered when running the Android Emulator which
> is based on QEMU 2.12. I can reproduce the issue with QEMU 8.0.4 in
> Debian 12.

The above is helpful as extra context, but repeating "This issue" and "The issue"
over and over without ever actually describing what the issue actualy is makes it
quite difficult to understand what is actually being fixed.

> With the above commit, the timer gets fired immediately inside the
> KVM_SET_LAPIC call when loading the snapshot. On such Intel platforms,
> this eventually leads to setting the corresponding PIR bit. However,
> the whole PIR bits get cleared later in the same KVM_SET_LAPIC call.
> Missing lapic timer interrupt freeze the guest kernel.

Please phrase changelogs as commands and state what is actually being changed.
Again, the context on what is broken is helpful, but the changelog really, really
needs to state what is being changed.

> Signed-off-by: Haitao Shan <hshan@google.com>
> ---
>  arch/x86/kvm/lapic.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index a983a16163b1..6f73406b875a 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -2977,14 +2977,14 @@ int kvm_apic_set_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s)
>  	apic_update_lvtt(apic);
>  	apic_manage_nmi_watchdog(apic, kvm_lapic_get_reg(apic, APIC_LVT0));
>  	update_divide_count(apic);
> -	__start_apic_timer(apic, APIC_TMCCT);
> -	kvm_lapic_set_reg(apic, APIC_TMCCT, 0);
>  	kvm_apic_update_apicv(vcpu);
>  	if (apic->apicv_active) {
>  		static_call_cond(kvm_x86_apicv_post_state_restore)(vcpu);
>  		static_call_cond(kvm_x86_hwapic_irr_update)(vcpu, apic_find_highest_irr(apic));
>  		static_call_cond(kvm_x86_hwapic_isr_update)(apic_find_highest_isr(apic));
>  	}
> +	__start_apic_timer(apic, APIC_TMCCT);
> +	kvm_lapic_set_reg(apic, APIC_TMCCT, 0);

I don't think this is the ordering we want.  It currently works, but it subtly
"relies" on a few things:

  1. That vmx_deliver_posted_interrupt() never "fails" when APICv is enabled,
     i.e. never puts the interrupt in the IRR instead of the PIR.

  2. The SVM, a.k.a. AVIC, doesn't ever sync from the IRR to a separate "hardware"
     virtual APIC, because unlike VMX, SVM does set the bit in the IRR.

I doubt #2 will ever change simply because that's tied to how AVIC works, and #1
shouldn't actually break anything since the fallback path in vmx_deliver_interrupt()
needs to be self-sufficient, but I don't like that the code syncs from the IRR and
_then_ potentially modifies the IRR.

I also don't like doing additional APIC state restoration _after_ invoking the
post_state_restore() hook.  Updating APICv in the middle of the restore flow is
going to be brittle and difficult to maintain, e.g. it won't be obvious what
needs to go before and what needs to go after.

IMO, vmx_apicv_post_state_restore() is blatantly broken.  It is most definitely
not doing "post state restore" stuff, it's simply purging state, i.e. belongs in
a "pre state restore" hook.

So rather than shuffle around the timer code, I think we should instead add yet
another kvm_x86_ops hook, e.g. apicv_pre_state_restore(), and have initialize
the PI descriptor there.

Aha!  And I think the new apicv_pre_state_restore() needs to be invoked even if
APICv is not active, because I don't see anything that purges the PIR when APICv
is enabled.  VMX's APICv doesn't have many inhibits that can go away, and I
highly doubt userspace will restore into a vCPU with pending posted interrupts,
so in practice this is _extremely_ unlikely to be problematic.  But it's still
wrong.
