Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05EC804FB0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344825AbjLEKCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjLEKCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 05:02:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A7B9E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 02:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701770535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YZXF7waANU5+mhguvuvh8JxjfsSebRKaX6sLaLZrogE=;
        b=OFjp7/158UFsJDEZ6tbNf1oeev/zHl/lWrzFPWn+L8z6oNKB3PV6hJixeen0biIRJ708Hw
        zupC818mRMMLLbcEi4mciLuGbj2zciDrWCLSU6BqZcZBRbNQzRDOo24RSj0PDsL+/M1px1
        dUtpByDiQvoGMSADLxiRzn6HXLRfni8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-_7ATZgbsOrOYnt1YWk58PA-1; Tue, 05 Dec 2023 05:02:14 -0500
X-MC-Unique: _7ATZgbsOrOYnt1YWk58PA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33342e25313so2063700f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 02:02:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701770533; x=1702375333;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YZXF7waANU5+mhguvuvh8JxjfsSebRKaX6sLaLZrogE=;
        b=atZvvL/4yNQf8GaHsxut/6ONAatT3NhRmdsh6BLH8uZysh+wjiO6skEnUOSns012v0
         lphhO2nymgQkarCZBDQGXR0umc13J3RZ5QzYQEr6NyZv6FQrum85JyfDsGJyN4KUoJlK
         xFM8YchBdPscyiBdpbybHinVZWRbw6WY9sh1xOuq+fqN3DXBWSsEGjoAeuGPDH+JmG+X
         YQvTT2x/1Gecg7M3VcYvzuNfjg5LYEFLAt+eMCGa95pST1S4rZW5ARyqxC/A11XtUwAO
         pJjtWgL4am3PNdsvEupwZd0IXRNyh3ThPFQ6jkdWtg4jeRCTnmQd26S8kKT1NQrQPsBp
         sU9w==
X-Gm-Message-State: AOJu0Yy0EBCKttiGrdsOMmKTdz4DHx++Es05gFc366MmH7XqMiH8sm2C
        fHzNRgItCyWKOSC6ZkyYwhk6nq5cQT+3/sFEoYtU0Le4A5E3TgrXCpMWipMtA4xrlBHWAG+PRkn
        XEdH5Eywl0E2ykl+Mwku+c96Q
X-Received: by 2002:a05:600c:4593:b0:3fe:4cbc:c345 with SMTP id r19-20020a05600c459300b003fe4cbcc345mr297118wmo.41.1701770533525;
        Tue, 05 Dec 2023 02:02:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkyh6uz8tLTANh12Tdqz9NiKwahRoAQySUBBbY1KeDQe3kryYq6CKsi25SwLURKdLaHjSVWQ==
X-Received: by 2002:a05:600c:4593:b0:3fe:4cbc:c345 with SMTP id r19-20020a05600c459300b003fe4cbcc345mr297101wmo.41.1701770533112;
        Tue, 05 Dec 2023 02:02:13 -0800 (PST)
Received: from starship ([89.237.98.20])
        by smtp.gmail.com with ESMTPSA id f11-20020a1c6a0b000000b0040523bef620sm497429wmc.0.2023.12.05.02.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 02:02:12 -0800 (PST)
Message-ID: <4f07482c7117b9d27b352621577d78e29ae951b7.camel@redhat.com>
Subject: Re: [PATCH v7 21/26] KVM: x86: Save and reload SSP to/from SMRAM
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     "Yang, Weijiang" <weijiang.yang@intel.com>,
        Chao Gao <chao.gao@intel.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, dave.hansen@intel.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, rick.p.edgecombe@intel.com,
        john.allen@amd.com
Date:   Tue, 05 Dec 2023 12:02:11 +0200
In-Reply-To: <7531921a-e7b2-4027-86c4-75fc91a45f26@intel.com>
References: <20231124055330.138870-1-weijiang.yang@intel.com>
         <20231124055330.138870-22-weijiang.yang@intel.com>
         <d2be8a787969b76f71194ce65bd6f35426b60dcc.camel@redhat.com>
         <ZWlDhYBYGiX7ir4X@chao-email>
         <7531921a-e7b2-4027-86c4-75fc91a45f26@intel.com>
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

On Mon, 2023-12-04 at 08:45 +0800, Yang, Weijiang wrote:
> On 12/1/2023 10:23 AM, Chao Gao wrote:
> > On Thu, Nov 30, 2023 at 07:42:44PM +0200, Maxim Levitsky wrote:
> > > On Fri, 2023-11-24 at 00:53 -0500, Yang Weijiang wrote:
> > > > Save CET SSP to SMRAM on SMI and reload it on RSM. KVM emulates HW arch
> > > > behavior when guest enters/leaves SMM mode,i.e., save registers to SMRAM
> > > > at the entry of SMM and reload them at the exit to SMM. Per SDM, SSP is
> > > > one of such registers on 64bit Arch, so add the support for SSP.
> > > > 
> > > > Suggested-by: Sean Christopherson <seanjc@google.com>
> > > > Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> > > > ---
> > > >   arch/x86/kvm/smm.c | 8 ++++++++
> > > >   arch/x86/kvm/smm.h | 2 +-
> > > >   2 files changed, 9 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/arch/x86/kvm/smm.c b/arch/x86/kvm/smm.c
> > > > index 45c855389ea7..7aac9c54c353 100644
> > > > --- a/arch/x86/kvm/smm.c
> > > > +++ b/arch/x86/kvm/smm.c
> > > > @@ -275,6 +275,10 @@ static void enter_smm_save_state_64(struct kvm_vcpu *vcpu,
> > > >   	enter_smm_save_seg_64(vcpu, &smram->gs, VCPU_SREG_GS);
> > > >   
> > > >   	smram->int_shadow = static_call(kvm_x86_get_interrupt_shadow)(vcpu);
> > > > +
> > > > +	if (guest_can_use(vcpu, X86_FEATURE_SHSTK))
> > > > +		KVM_BUG_ON(kvm_msr_read(vcpu, MSR_KVM_SSP, &smram->ssp),
> > > > +			   vcpu->kvm);
> > > >   }
> > > >   #endif
> > > >   
> > > > @@ -564,6 +568,10 @@ static int rsm_load_state_64(struct x86_emulate_ctxt *ctxt,
> > > >   	static_call(kvm_x86_set_interrupt_shadow)(vcpu, 0);
> > > >   	ctxt->interruptibility = (u8)smstate->int_shadow;
> > > >   
> > > > +	if (guest_can_use(vcpu, X86_FEATURE_SHSTK))
> > > > +		KVM_BUG_ON(kvm_msr_write(vcpu, MSR_KVM_SSP, smstate->ssp),
> > > > +			   vcpu->kvm);
> > > > +
> > > >   	return X86EMUL_CONTINUE;
> > > >   }
> > > >   #endif
> > > > diff --git a/arch/x86/kvm/smm.h b/arch/x86/kvm/smm.h
> > > > index a1cf2ac5bd78..1e2a3e18207f 100644
> > > > --- a/arch/x86/kvm/smm.h
> > > > +++ b/arch/x86/kvm/smm.h
> > > > @@ -116,8 +116,8 @@ struct kvm_smram_state_64 {
> > > >   	u32 smbase;
> > > >   	u32 reserved4[5];
> > > >   
> > > > -	/* ssp and svm_* fields below are not implemented by KVM */
> > > >   	u64 ssp;
> > > > +	/* svm_* fields below are not implemented by KVM */
> > > >   	u64 svm_guest_pat;
> > > >   	u64 svm_host_efer;
> > > >   	u64 svm_host_cr4;
> > > 
> > > My review feedback from the previous patch series still applies, and I don't
> > > know why it was not addressed/replied to:
> > > 
> > > I still think that it is worth it to have a check that CET is not enabled in
> > > enter_smm_save_state_32 which is called for pure 32 bit guests (guests that don't
> > > have X86_FEATURE_LM enabled)
> > can KVM just reject a KVM_SET_CPUID ioctl which attempts to expose shadow stack
> > (or even any CET feature) to 32-bit guest in the first place? I think it is simpler.
> 
> I favor adding an early defensive check for the issue under discussion if we want to handle the case.
> Crashing the VM at runtime when guest SMI is kicked seems not user friendly.
> 

I don't mind. I remember that I was told that crashing a guest when #SMI arrives and a nested guest is running
is ok for 32 bit guests, don't know what the justification was.
Sean, Paolo, do you remember?

IMHO the chances of pure 32 bit guest (only qemu-system-386 creates these) running with CET are very low,
but I just wanted to have a cheap check just to keep the 32 bit and 64 bit smm save/restore code similar,
so that nobody in the future will ask 'why this code does this or that'.

Also it is trivial to add the ssp to 32 bit smmram image - the layout is not really compliant to x86 spec,
and never consumed by the hardware, you can just put it somewhere in the image, instead of one of the reserved fields.

From my point of view I want the code to be as orthogonal as possible.

Best regards,
	Maxim Levitsky




