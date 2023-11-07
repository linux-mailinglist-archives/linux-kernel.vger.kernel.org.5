Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F9C7E47F7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 19:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbjKGSNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 13:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjKGSNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 13:13:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC8D134
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 10:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699380736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JNiNx/dneibvnMQrVLY0pXvF7ezTY7/PHq/TGvpQqHA=;
        b=KFRhPEmMiB6QVRsQ/2g4Ecq7u4NuSeUyEh0lS6RzRDGiRnlaPOD74Axy+iDlfwDKp5NqyE
        8kELd7pOHFErXBaxZu9JL1cY/zY2jXF2rfaO/utQuuNOozJsclXYuDYlsZlLZG/aiT3ugR
        UG2npaFsJsA8ldwwY1sq+sZ4Lp8yWfc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-d0mLNGt9Px-cIu1gDUnNWQ-1; Tue, 07 Nov 2023 13:12:15 -0500
X-MC-Unique: d0mLNGt9Px-cIu1gDUnNWQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-32d9b520d15so2893834f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 10:12:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699380734; x=1699985534;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JNiNx/dneibvnMQrVLY0pXvF7ezTY7/PHq/TGvpQqHA=;
        b=xUxvKM+eqj08wgq9Of4dOIrvNAfliJg8npYWtGfR0JbsmCBf7kGUhPhRm1oulKNs7K
         C7xjjDIhBH8e5Ed3eXPzvePRhq2mr8zwYTStuKt6w68CCrj1JsBPbMCV6khNdW82QOBh
         QA6dzRjlbLxpe7LqCM0H9qFOi+v+i2K0cjCI27hTYlIbHxWnGbg7Myv2px06/FE3rZ5z
         U6iaZ+g5fW81GFtIc7NhhdCd4//IXJFRNRtkGEcBZftj71tLXYhRII6jWtWugJUIUK4k
         dFdXXQK29REacKe25umNvr4t2e+xN6UoL0QAyuDKHjmAGOY6POg9CfXT2SpHlGH2m4XK
         N78Q==
X-Gm-Message-State: AOJu0Yy/AkO3OFWQx6M+gC34NaViDsOrG6kfyaMzSRLcJwXczHmWlILg
        /sm0NkyQL19EN8fcLe5wY2EWmJt3ydQC5YHExAvf8oxCt2GTH+YkeddkbhsmDxuRvjKuZcecRhO
        4Zst/LSQOxVUx2EEQKrAJSBKG
X-Received: by 2002:a5d:6a41:0:b0:32d:9d80:4038 with SMTP id t1-20020a5d6a41000000b0032d9d804038mr24052145wrw.49.1699380734032;
        Tue, 07 Nov 2023 10:12:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIei1G8uGo7eAlh5wyZ7aZYmgB5PIjFocox8T578jYFZmvllRxkBh4cD3cmM8xWZ+icxYHHg==
X-Received: by 2002:a5d:6a41:0:b0:32d:9d80:4038 with SMTP id t1-20020a5d6a41000000b0032d9d804038mr24052121wrw.49.1699380733571;
        Tue, 07 Nov 2023 10:12:13 -0800 (PST)
Received: from starship ([89.237.99.95])
        by smtp.gmail.com with ESMTPSA id m28-20020a056000181c00b0032f78feb826sm2978580wrh.104.2023.11.07.10.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 10:12:13 -0800 (PST)
Message-ID: <690bd404204106fc17d465e2fdb9be8863767544.camel@redhat.com>
Subject: Re: [PATCH v6 19/25] KVM: VMX: Emulate read and write to CET MSRs
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Yang Weijiang <weijiang.yang@intel.com>, pbonzini@redhat.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Date:   Tue, 07 Nov 2023 20:12:11 +0200
In-Reply-To: <ZUQ3tcuAxYQ5bWwC@google.com>
References: <20230914063325.85503-1-weijiang.yang@intel.com>
         <20230914063325.85503-20-weijiang.yang@intel.com>
         <d67fe0ca19f7aef855aa376ada0fc96a66ca0d4f.camel@redhat.com>
         <ZUJ9fDuQUNe9BLUA@google.com>
         <ff6b7e9d90d80feb9dcabb0fbd3808c04db3ff94.camel@redhat.com>
         <ZUQ3tcuAxYQ5bWwC@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-11-02 at 16:58 -0700, Sean Christopherson wrote:
> On Thu, Nov 02, 2023, Maxim Levitsky wrote:
> > On Wed, 2023-11-01 at 09:31 -0700, Sean Christopherson wrote:
> > > On Tue, Oct 31, 2023, Maxim Levitsky wrote:
> > > > On Thu, 2023-09-14 at 02:33 -0400, Yang Weijiang wrote:
> > > > > Add emulation interface for CET MSR access. The emulation code is split
> > > > > into common part and vendor specific part. The former does common check
> > > > > for MSRs and reads/writes directly from/to XSAVE-managed MSRs via the
> > > > > helpers while the latter accesses the MSRs linked to VMCS fields.
> > > > > 
> > > > > Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> > > > > ---
> > > 
> > > ...
> > > 
> > > > > +	case MSR_IA32_PL0_SSP ... MSR_IA32_PL3_SSP:
> > > > > +	case MSR_KVM_SSP:
> > > > > +		if (host_msr_reset && kvm_cpu_cap_has(X86_FEATURE_SHSTK))
> > > > > +			break;
> > > > > +		if (!guest_can_use(vcpu, X86_FEATURE_SHSTK))
> > > > > +			return 1;
> > > > > +		if (index == MSR_KVM_SSP && !host_initiated)
> > > > > +			return 1;
> > > > > +		if (is_noncanonical_address(data, vcpu))
> > > > > +			return 1;
> > > > > +		if (index != MSR_IA32_INT_SSP_TAB && !IS_ALIGNED(data, 4))
> > > > > +			return 1;
> > > > > +		break;
> > > > Once again I'll prefer to have an ioctl for setting/getting SSP, this will
> > > > make the above code simpler (e.g there will be no need to check that write
> > > > comes from the host/etc).
> > > 
> > > I don't think an ioctl() would be simpler overall, especially when factoring in
> > > userspace.  With a synthetic MSR, we get the following quite cheaply:
> > > 
> > >  1. Enumerating support to userspace.
> > >  2. Save/restore of the value, e.g. for live migration.
> > >  3. Vendor hooks for propagating values to/from the VMCS/VMCB.
> > > 
> > > For an ioctl(), 
> > > #1 would require a capability, #2 (and #1 to some extent) would
> > > require new userspace flows, and #3 would require new kvm_x86_ops hooks.
> > > 
> > > The synthetic MSR adds a small amount of messiness, as does bundling 
> > > MSR_IA32_INT_SSP_TAB with the other shadow stack MSRs.  The bulk of the mess comes
> > > from the need to allow userspace to write '0' when KVM enumerated supported to
> > > userspace.
> > 
> > Let me put it this way - all hacks start like that, and in this case this is API/ABI hack
> > so we will have to live with it forever.
> 
> Eh, I don't view it as a hack, at least the kind of hack that has a negative
> connotation.  KVM effectively has ~240 MSR indices reserved for whatever KVM
> wants. 
This is exactly the problem. These indices are reserved for PV features, not
for fake msrs, and my fear is that once we mix it up, it will be a mess.

If that was not API/ABI, I wouldn't complain, but since this is API/ABI, I'm afraid
to make a mistake and then be sorry.


>  The only weird thing about this one is that it's not accessible from the
> guest.  Which I agree is quite weird, but from a code perspective I think it
> works quite well.
> 
> > Once there is a precedent, trust me there will be 10s of new 'fake' msrs added, and the
> > interface will become one big mess.
> 
> That suggests MSRs aren't already one big mess. :-)  I'm somewhat joking, but also
> somewhat serious.  I really don't think that adding one oddball synthetic MSR is
> going to meaningfully move the needle on the messiness of MSRs.
> 
> Hmm, there probably is a valid slippery slope argument though.  As you say, at
> some point, enough state will get shoved into hardware that KVM will need an ever
> growing number of synthetic MSRs to keep pace.

Yes, exactly what I mean - Honestly though I don't expect many new x86 registers/states
that are not msrs, but we don't know what x86 designers will do next,
and APIs are something that can't be fixed later.

> 
> > As I suggested, if you don't want to add new capability/ioctl and vendor
> > callback per new x86 arch register, then let's implement
> > KVM_GET_ONE_REG/KVM_SET_ONE_REG and then it will be really easy to add new
> > regs without confusing users, and without polluting msr namespace with msrs
> > that don't exist.
> 
> I definitely don't hate the idea of KVM_{G,S}ET_ONE_REG, what I don't want is to
> have an entirely separate path in KVM for handling the actual get/set.
> 
> What if we combine the approaches?  Add KVM_{G,S}ET_ONE_REG support so that the
> uAPI can use completely arbitrary register indices without having to worry about
> polluting the MSR space and making MSR_KVM_SSP ABI.
Sounds like a reasonable idea but might be overkill.

> 
> Ooh, if we're clever, I bet we can extend KVM_{G,S}ET_ONE_REG to also work with
> existing MSRs, GPRs, and other stuff,

Not sure if we want to make it work with MSRs. MSRs are a very well defined thing
on x86, and we already have an API to read/write them. Other registers maybe,
don't know.

>  i.e. not force userspace through the funky
> KVM_SET_MSRS just to set one reg, and not force a RMW of all GPRs just to set
> RIP or something.
Setting one GPR like RIP does sound like a valid use case of KVM_SET_ONE_REG.

>   E.g. use bits 39:32 of the id to encode the register class,
> bits 31:0 to hold the index within a class, and reserve bits 63:40 for future
> usage.
> 
> Then for KVM-defined registers, we can route them internally as needed, e.g. we
> can still define MSR_KVM_SSP so that internal it's treated like an MSR, but its
> index isn't ABI and so can be changed at will.  And future KVM-defined registers
> wouldn't _need_ to be treated like MSRs, i.e. we could route registers through
> the MSR APIs if and only if it makes sense to do so.

I am not sure that even internally I'll treat MSR_KVM_SSP as MSR. 
An MSR IMHO is a msr, a register is a register, mixing this up will
just add to the confusion.


Honestly if I were to add support for the SSP register, I'll just add a new
ioctl/capability and vendor callback. All of this code is just harmless
boilerplate code.
Even using KVM_GET_ONE_REG/KVM_SET_ONE_REG is probably overkill, although using
it for new registers is reasonable.

At the end I am not going to argue much about this - I just voiced my option that currently
MSR read/write interface is pure in regard that it only works on either real msrs or
at least PV msrs that the guest can read/write. 

All other guest's state is set via separate ioctls/callbacks/etc, and thus it's more consistent
from API POV to add SSP here.


> 
> Side topic, why on earth is the data value of kvm_one_reg "addr"?

I don't know, probably something ARM related.

> 


Best regards,
	Maxim Levitsky

