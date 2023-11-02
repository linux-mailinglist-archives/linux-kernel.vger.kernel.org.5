Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252577DF9F7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377131AbjKBScR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbjKBScP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 14:32:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD82918B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 11:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698949881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5xxC28PYqiT7BcV5DEi3XMjaZ09KLMWNz9I8Ill0c/8=;
        b=fEIKXSBwUL6bnUsmxxXWefefGd3EXY1Jdhd0VqbLHiKtN+AmNKWw+rlb8W98Fb4TdhOLG3
        nfUNTHwQSsUJgNjd01yKg+m1J+yDIev1N1bHnWWZmCmWXnwknDJctvYXb7VmAo/S9LRwF1
        WTq/jgAsXTQqSGBWP0pPnsEYgdnLMOA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-zGmXZAPRO9Kh99L-uAlIhg-1; Thu, 02 Nov 2023 14:31:18 -0400
X-MC-Unique: zGmXZAPRO9Kh99L-uAlIhg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-32d83fd3765so551253f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 11:31:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698949877; x=1699554677;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5xxC28PYqiT7BcV5DEi3XMjaZ09KLMWNz9I8Ill0c/8=;
        b=s7unIQOUvP5Cjt/uhTlRwXNJb3FuEryoEdV2QaxAfBS3ACZbQBsRyuD827ELZMqdrb
         qt30bsRcoEtK5vWpPjFfx94FlxXuby4pYYOr5jgxN/ShspA6cnFAe7hDLJqBqE1cvxyA
         IfawlqH2d6OVAStWr3iEDaChBtyLL6SvZNGYEI7SZBe7jycbnu5F4jQvQ3h+DlcgmpIS
         P5i08UlSphtGt4/iWn5zX7djU/V4QDKVSnMrIYVo/aB8E6YTu2SzdR3Mzn+SzPtt4HH7
         rzh8TBVLFIYrujBNAMJu4vhp/QTcSl2otMQ80614XorHO7uABDy67QosuYoSHq67ZakC
         LAWQ==
X-Gm-Message-State: AOJu0Yxsi9DFur3GA460imDkkBLwizwrg0RZ/5vyZ1uJF1PKPITu7iBY
        tZ1eCHq5yyR7yFYJgmLysZ/Es+gz61JDfMlw+paF44SkDlbVCfM9bkrwC2qoGKRRIDTnNfEZr+1
        O8MBrVyAAMaJ/I4JYr9uaxiMe
X-Received: by 2002:a05:6000:1ac7:b0:32d:a213:4d7d with SMTP id i7-20020a0560001ac700b0032da2134d7dmr16596502wry.56.1698949877183;
        Thu, 02 Nov 2023 11:31:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/utLi6fXUliUkkLs2Oubehgwj7LYFXk+YZFFrwQgh7gri3uv7upJ9ZiWvrqkmmQv+MLY1Gg==
X-Received: by 2002:a05:6000:1ac7:b0:32d:a213:4d7d with SMTP id i7-20020a0560001ac700b0032da2134d7dmr16596481wry.56.1698949876866;
        Thu, 02 Nov 2023 11:31:16 -0700 (PDT)
Received: from starship ([89.237.99.95])
        by smtp.gmail.com with ESMTPSA id k23-20020adfb357000000b0032d829e10c0sm15151wrd.28.2023.11.02.11.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 11:31:16 -0700 (PDT)
Message-ID: <f930aa68395d6ead6b94b1b7a6e4f3af1cfe9205.camel@redhat.com>
Subject: Re: [PATCH v6 14/25] KVM: x86: Load guest FPU state when access
 XSAVE-managed MSRs
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Yang Weijiang <weijiang.yang@intel.com>, pbonzini@redhat.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Date:   Thu, 02 Nov 2023 20:31:14 +0200
In-Reply-To: <ZUKTd_a00fs1nyyk@google.com>
References: <20230914063325.85503-1-weijiang.yang@intel.com>
         <20230914063325.85503-15-weijiang.yang@intel.com>
         <2b1973ee44498039c97d4d11de3a93b0f3b1d2d8.camel@redhat.com>
         <ZUKTd_a00fs1nyyk@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-11-01 at 11:05 -0700, Sean Christopherson wrote:
> On Tue, Oct 31, 2023, Maxim Levitsky wrote:
> > On Thu, 2023-09-14 at 02:33 -0400, Yang Weijiang wrote:
> > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > index 66edbed25db8..a091764bf1d2 100644
> > > --- a/arch/x86/kvm/x86.c
> > > +++ b/arch/x86/kvm/x86.c
> > > @@ -133,6 +133,9 @@ static int __set_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2);
> > >  static void __get_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2);
> > >  
> > >  static DEFINE_MUTEX(vendor_module_lock);
> > > +static void kvm_load_guest_fpu(struct kvm_vcpu *vcpu);
> > > +static void kvm_put_guest_fpu(struct kvm_vcpu *vcpu);
> > > +
> > >  struct kvm_x86_ops kvm_x86_ops __read_mostly;
> > >  
> > >  #define KVM_X86_OP(func)					     \
> > > @@ -4372,6 +4375,22 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> > >  }
> > >  EXPORT_SYMBOL_GPL(kvm_get_msr_common);
> > >  
> > > +static const u32 xstate_msrs[] = {
> > > +	MSR_IA32_U_CET, MSR_IA32_PL0_SSP, MSR_IA32_PL1_SSP,
> > > +	MSR_IA32_PL2_SSP, MSR_IA32_PL3_SSP,
> > > +};
> > > +
> > > +static bool is_xstate_msr(u32 index)
> > > +{
> > > +	int i;
> > > +
> > > +	for (i = 0; i < ARRAY_SIZE(xstate_msrs); i++) {
> > > +		if (index == xstate_msrs[i])
> > > +			return true;
> > > +	}
> > > +	return false;
> > > +}
> > 
> > The name 'xstate_msr' IMHO is not clear.
> > 
> > How about naming it 'guest_fpu_state_msrs', together with adding a comment like that:
> 
> Maybe xstate_managed_msrs?  I'd prefer not to include "guest" because the behavior
> is more a property of the architecture and/or the host kernel.  I understand where
> you're coming from, but it's the MSR *values* are part of guest state, whereas the
> check is a query on how KVM manages the MSR value, if that makes sense.
Makes sense.
> 
> And I really don't like "FPU".  I get why the the kernel uses the "FPU" terminology,
> but for this check in particular I want to tie the behavior back to the architecture,
> i.e. provide the hint that the reason why these MSRs are special is because Intel
> defined them to be context switched via XSTATE.
> 
> Actually, this is unnecesary bikeshedding to some extent, using an array is silly.
> It's easier and likely far more performant (not that that matters in this case)
> to use a switch statement.
> 
> Is this better?
> 
> /*
>  * Returns true if the MSR in question is managed via XSTATE, i.e. is context
>  * switched with the rest of guest FPU state.
>  */
> static bool is_xstate_managed_msr(u32 index)
> {
> 	switch (index) {
> 	case MSR_IA32_U_CET:
> 	case MSR_IA32_PL0_SSP ... MSR_IA32_PL3_SSP:
> 		return true;
> 	default:
> 		return false;
> 	}
> }

Reasonable.

> 
> /*
>  * Read or write a bunch of msrs. All parameters are kernel addresses.
>  *
>  * @return number of msrs set successfully.
>  */
> static int __msr_io(struct kvm_vcpu *vcpu, struct kvm_msrs *msrs,
> 		    struct kvm_msr_entry *entries,
> 		    int (*do_msr)(struct kvm_vcpu *vcpu,
> 				  unsigned index, u64 *data))
> {
> 	bool fpu_loaded = false;
> 	int i;
> 
> 	for (i = 0; i < msrs->nmsrs; ++i) {
> 		/*
> 	 	 * If userspace is accessing one or more XSTATE-managed MSRs,
> 		 * temporarily load the guest's FPU state so that the guest's
> 		 * MSR value(s) is resident in hardware, i.e. so that KVM can
> 		 * get/set the MSR via RDMSR/WRMSR.
> 	 	 */
Reasonable as well.
> 		if (vcpu && !fpu_loaded && kvm_caps.supported_xss &&
> 		    is_xstate_managed_msr(entries[i].index)) {
> 			kvm_load_guest_fpu(vcpu);
> 			fpu_loaded = true;
> 		}
> 		if (do_msr(vcpu, entries[i].index, &entries[i].data))
> 			break;
> 	}
> 	if (fpu_loaded)
> 		kvm_put_guest_fpu(vcpu);
> 
> 	return i;
> }
> 

Best regards,
	Maxim Levitsky


