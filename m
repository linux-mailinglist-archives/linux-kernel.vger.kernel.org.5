Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0909E7DF99B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345724AbjKBSLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234256AbjKBSLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 14:11:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343E835B3
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 11:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698948344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6IPJfYqJMcuWmfDMW5B8K/I4a8oxp1YUbqsh/E0scRE=;
        b=KqjE7CDQi19XTYESY2EYqe4xRGZme6DjZPMTrsn2lhOOKW7U/k0+mmkBFmZ7vJIAzwUkCL
        hC07iUiLm3CeKnf6al3s8fyTszSA/4XOEUOme1ff7gLZOieIEmKSJyhBVMDNnsFMbS0z/Y
        DzlxGze+nTNmhgoDMEzSSpkMYPek0LA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-xFlksBQuN9qU-l91TQi0MQ-1; Thu, 02 Nov 2023 14:05:43 -0400
X-MC-Unique: xFlksBQuN9qU-l91TQi0MQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40920512cd3so8230835e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 11:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698948342; x=1699553142;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6IPJfYqJMcuWmfDMW5B8K/I4a8oxp1YUbqsh/E0scRE=;
        b=ofcfGWNVY5XLUHtIuin9aWX3S4S4dduxhbkSw1eVrQcN6rXr1g5AdmWM7oddLZH1u1
         1cMMCdTnZZOyGyiqDmk2T7d7NQLYAmrjhlCPhWN9P0Fvre3jfh2fYoWiZyt0YlgqhN3P
         2sUuzITaTUp+nT4iLB3OHQYuLWX4PV6fL3l48+jsIrRASOnxhUktjQxRF9sV2pujLSMZ
         iUiDmd8IuN08iSeHzKcbM/O6L/y3FNBd/i03O741H3tCCvRe1yZx0bflXUry0BPOByoA
         dyCLejYCQ1Xs3PeeHKq6Oz9SiizfSLyQuX8O4yXDv/BunuSDge/sUblygSfNqrsvGrrh
         p/VA==
X-Gm-Message-State: AOJu0YwvmX3El88YmJ4Pp6oj+vsBjVmaxFBHx1JI5sCsXKAcyChVmMxF
        KKh3wa0MAq+C5T4Kz0q/QrxuxfHkJxDHK1ocS6rznErTmMql7DcjMhQ1c04bsO1O9pgZkJ57QAm
        XX8vg28GEfqzeS7kFkm/tDH+F7sAgUBVz
X-Received: by 2002:a05:600c:358a:b0:408:59d4:f3d8 with SMTP id p10-20020a05600c358a00b0040859d4f3d8mr16794439wmq.18.1698948342126;
        Thu, 02 Nov 2023 11:05:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAlC49b/Dk9paixZtEXaBZIUjHhjIuxXx22nKYwlZN4YkB8UVGGQfELNbvGYpzXRyfqIZy/A==
X-Received: by 2002:a05:600c:358a:b0:408:59d4:f3d8 with SMTP id p10-20020a05600c358a00b0040859d4f3d8mr16794402wmq.18.1698948341521;
        Thu, 02 Nov 2023 11:05:41 -0700 (PDT)
Received: from starship ([89.237.99.95])
        by smtp.gmail.com with ESMTPSA id v23-20020a05600c215700b004083a105f27sm3602087wml.26.2023.11.02.11.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 11:05:41 -0700 (PDT)
Message-ID: <874ae0019fb33784520270db7d5213af0d42290d.camel@redhat.com>
Subject: Re: [PATCH 3/9] KVM: x86: SVM: Pass through shadow stack MSRs
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     nikunj@amd.com, John Allen <john.allen@amd.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, weijiang.yang@intel.com,
        rick.p.edgecombe@intel.com, seanjc@google.com, x86@kernel.org,
        thomas.lendacky@amd.com, bp@alien8.de
Date:   Thu, 02 Nov 2023 20:05:39 +0200
In-Reply-To: <c65817b0-7fa6-7c0b-6423-5f33062c9665@amd.com>
References: <20231010200220.897953-1-john.allen@amd.com>
         <20231010200220.897953-4-john.allen@amd.com>
         <8484053f-2777-eb55-a30c-64125fbfc3ec@amd.com>
         <ZS7PubpX4k/LXGNq@johallen-workstation>
         <c65817b0-7fa6-7c0b-6423-5f33062c9665@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-10-18 at 16:57 +0530, Nikunj A. Dadhania wrote:
> On 10/17/2023 11:47 PM, John Allen wrote:
> > On Thu, Oct 12, 2023 at 02:31:19PM +0530, Nikunj A. Dadhania wrote:
> > > On 10/11/2023 1:32 AM, John Allen wrote:
> > > > If kvm supports shadow stack, pass through shadow stack MSRs to improve
> > > > guest performance.
> > > > 
> > > > Signed-off-by: John Allen <john.allen@amd.com>
> > > > ---
> > > >  arch/x86/kvm/svm/svm.c | 26 ++++++++++++++++++++++++++
> > > >  arch/x86/kvm/svm/svm.h |  2 +-
> > > >  2 files changed, 27 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > > > index e435e4fbadda..984e89d7a734 100644
> > > > --- a/arch/x86/kvm/svm/svm.c
> > > > +++ b/arch/x86/kvm/svm/svm.c
> > > > @@ -139,6 +139,13 @@ static const struct svm_direct_access_msrs {
> > > >  	{ .index = X2APIC_MSR(APIC_TMICT),		.always = false },
> > > >  	{ .index = X2APIC_MSR(APIC_TMCCT),		.always = false },
> > > >  	{ .index = X2APIC_MSR(APIC_TDCR),		.always = false },
> > > > +	{ .index = MSR_IA32_U_CET,                      .always = false },
> > > > +	{ .index = MSR_IA32_S_CET,                      .always = false },
> > > > +	{ .index = MSR_IA32_INT_SSP_TAB,                .always = false },
> > > > +	{ .index = MSR_IA32_PL0_SSP,                    .always = false },
> > > > +	{ .index = MSR_IA32_PL1_SSP,                    .always = false },
> > > > +	{ .index = MSR_IA32_PL2_SSP,                    .always = false },
> > > > +	{ .index = MSR_IA32_PL3_SSP,                    .always = false },
> > > 
> > > First three MSRs are emulated in the patch 1, any specific reason for skipping MSR_IA32_PL[0-3]_SSP ?
> > 
> > I'm not sure what you mean. 
> 
> MSR_IA32_U_CET, MSR_IA32_S_CET and MSR_IA32_INT_SSP_TAB are selectively emulated and there is no good explanation why MSR_IA32_PL[0-3]_SSP do not need emulation. Moreover, MSR interception is initially set (i.e. always=false) for MSR_IA32_PL[0-3]_SSP.
> 

Let me explain:

Passing through an MSR and having code for reading/writing it in svm_set_msr/svm_get_msr are two different things:

Passing through an MSR means that the guest can read/write the msr freely (that assumes that this can't cause harm to the host),
but either KVM or the hardware usually swaps the guest MSR value with host msr value on vm entry/exit.

Therefore the function of svm_set_msr/svm_get_msr is to obtain the saved guest msr value while the guest is not running for various use cases (for example for migration).

In case of MSR_IA32_U_CET, MSR_IA32_S_CET and MSR_IA32_INT_SSP_TAB the hardware itself loads the guest values from the vmcb on VM entry and saves the modified guest values
to the vmcb on vm exit, thus correct way of reading/writing the guest value is to read/write it from/to the vmcb field.


Now why other CET msrs are not handled by svm_set_msr/svm_get_msr? 
The answer is that those msrs are not saved/restored by SVM microcode, and instead their guest values remain
during the VMexit.

The CET common code which I finally finished reviewing last night, context switches them together with the rest of guest FPU state using xsaves/xrstors instruction,
and if the KVM wants to read these msrs, the common code will first load the guest FPU state and then read/write the msrs using regular rdmsr/wrmsr.


> > The PLx_SSP MSRS should be getting passed
> > through here unless I'm misunderstanding something.
> 
> In that case, intercept should be cleared from the very beginning.
> 
> +	{ .index = MSR_IA32_PL0_SSP,                    .always = true },
> +	{ .index = MSR_IA32_PL1_SSP,                    .always = true },
> +	{ .index = MSR_IA32_PL2_SSP,                    .always = true },
> +	{ .index = MSR_IA32_PL3_SSP,                    .always = true },

.always is only true when a MSR is *always* passed through. CET msrs are only passed through when CET is supported.

Therefore I don't expect that we ever add another msr to this list which has .always = true.

In fact the .always = True for X86_64 arch msrs like MSR_GS_BASE/MSR_FS_BASE and such is not 100% correct too - 
when we start a VM which doesn't have cpuid bit X86_FEATURE_LM, these msrs should not exist and I think that we have a
kvm unit test that fails because of this on 32 bit but I didn't bother yet to fix it.

.always probably needs to be dropped completely.


So IMHO this patch is correct (I might have missed something though):

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

> 
> Regards
> Nikunj
> 
> 


