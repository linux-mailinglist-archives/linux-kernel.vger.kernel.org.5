Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEFE8074D3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379158AbjLFQVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378358AbjLFQVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:21:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B15137
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 08:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701879687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yBHnmpTdUAAABbA8Mh1bA1BUO5b6J3rmpt1I3QMnK5Y=;
        b=UxanHiNTbzy4nPMODrecvVCgc+jk4/EjOXiBX4CxvKLiOCBewsOc+EmpDmYKa0w0Epzdum
        VfJ5CRsOZGXNQ6rxSIm+prXd75e6YyNJlrOQGxQSZdiubItQKYqBvgFh8vqcOWXPkvsut5
        JSWEkT3mbLYgAFmfT35/L9FVCuMzHiw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-g3UG8CpbMQCzNgF25pU3Aw-1; Wed, 06 Dec 2023 11:21:26 -0500
X-MC-Unique: g3UG8CpbMQCzNgF25pU3Aw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40b39377136so52518535e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 08:21:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701879685; x=1702484485;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yBHnmpTdUAAABbA8Mh1bA1BUO5b6J3rmpt1I3QMnK5Y=;
        b=hfL52w4fY1wGloFCgZna0b3iFsT/1nmp9SUs6jaHDm3irwbnG/b97S6h2VivVjeEql
         bkg3N77E2BmuxKc1p/78Qym0hyvcMPCfC+1OhHiIWsIcz8/GQvQei4Pzk87JbFvQX+kN
         DuE3C17XKXsMe/2MSNlf83VU1c0iqIarbTbMv+xUm7n1roZMnHtFMOEH4cMgqyPS9XMO
         9jxqZvzRxZ5DU/SlLR/kGL7aeQMC2sMATOzBkzZtfCFCtZ/LkelALiJBpcj2b42nPcNc
         aVvmLO8TVTfOknoy5YDY/RtCq6kewXUMOqdwZi6Wv9x0qd65ahFjyA8WngmkXdGesgwu
         lTEg==
X-Gm-Message-State: AOJu0Yw8gZEsZeeLlstLtUnHyD+PoXXx7RBnv6CG8acCI+DVlBGlCfV5
        yVPMU1y0dkB7z9u4yuO9CXR0mc42BWYL71pdJwW5feQQ0UJWySdS+qA0R8/0Uekqgc0GqWBPqXI
        SiMLhW8bAU0mAiSEChSyNHLHc
X-Received: by 2002:a05:600c:354f:b0:401:bd2e:49fc with SMTP id i15-20020a05600c354f00b00401bd2e49fcmr754494wmq.24.1701879685207;
        Wed, 06 Dec 2023 08:21:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHWRueBGFjuqH7LTjLrUPFBWtdG2OWtYQEqZHufXz0GKcVxX4ZdL32r3Rlza5w9bs0UKjXVA==
X-Received: by 2002:a05:600c:354f:b0:401:bd2e:49fc with SMTP id i15-20020a05600c354f00b00401bd2e49fcmr754477wmq.24.1701879684841;
        Wed, 06 Dec 2023 08:21:24 -0800 (PST)
Received: from starship ([89.237.98.20])
        by smtp.gmail.com with ESMTPSA id fj5-20020a05600c0c8500b0040b2b38a1fasm101981wmb.4.2023.12.06.08.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 08:21:24 -0800 (PST)
Message-ID: <3e5a23c106ae5e86eba05391d1cba3f0b9c3854d.camel@redhat.com>
Subject: Re: [PATCH] KVM: SEV: Fix handling of EFER_LMA bit when SEV-ES is
 enabled
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 06 Dec 2023 18:21:22 +0200
In-Reply-To: <20231205234956.1156210-1-michael.roth@amd.com>
References: <20231205234956.1156210-1-michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-12-05 at 17:49 -0600, Michael Roth wrote:
> In general, activating long mode involves setting the EFER_LME bit in
> the EFER register and then enabling the X86_CR0_PG bit in the CR0
> register. At this point, the EFER_LMA bit will be set automatically by
> hardware.
> 
> In the case of SVM/SEV guests where writes to CR0 are intercepted, it's
> necessary for the host to set EFER_LMA on behalf of the guest since
> hardware does not see the actual CR0 write.

Could you explain in which case the writes to CR0 will be still intercepted?
It's for CPUs that only support SEV-ES and nothing beyond it?


> 
> In the case of SEV-ES guests where writes to CR0 are trapped instead of
> intercepted, the hardware *does* see/record the write to CR0 before
> exiting and passing the value on to the host, so as part of enabling
> SEV-ES support commit f1c6366e3043 ("KVM: SVM: Add required changes to
> support intercepts under SEV-ES") dropped special handling of the
> EFER_LMA bit with the understanding that it would be set automatically.
> 
> However, since the guest never explicitly sets the EFER_LMA bit, the
> host never becomes aware that it has been set. This becomes problematic
> when userspace tries to get/set the EFER values via
> KVM_GET_SREGS/KVM_SET_SREGS, since the EFER contents tracked by the host
> will be missing the EFER_LMA bit, and when userspace attempts to pass
> the EFER value back via KVM_SET_SREGS it will fail a sanity check that
> asserts that EFER_LMA should always be set when X86_CR0_PG and EFER_LME
> are set.
> 
> Fix this by always inferring the value of EFER_LMA based on X86_CR0_PG
> and EFER_LME, regardless of whether or not SEV-ES is enabled.
> 
> Fixes: f1c6366e3043 ("KVM: SVM: Add required changes to support intercepts under SEV-ES")
> Suggested-by: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>  arch/x86/kvm/svm/svm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 5d75a1732da4..b31d4f2deb66 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -1869,7 +1869,7 @@ void svm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
>  	bool old_paging = is_paging(vcpu);
>  
>  #ifdef CONFIG_X86_64
> -	if (vcpu->arch.efer & EFER_LME && !vcpu->arch.guest_state_protected) {
> +	if (vcpu->arch.efer & EFER_LME) {
>  		if (!is_paging(vcpu) && (cr0 & X86_CR0_PG)) {
>  			vcpu->arch.efer |= EFER_LMA;
>  			svm->vmcb->save.efer |= EFER_LMA | EFER_LME;

Purely from the point of view of not confusing future readers of this code:
Due to encrypted guest state, if I understand correctly, the 'svm->vmcb->save.efer'
is only given for the hypervisor to see but not to modify.

While the modification of save.efer is a nop, can we still guard it with
'vcpu->arch.guest_state_protected'?

Besides these nitpicks:

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>


Best regards,
	Maxim Levitsky

