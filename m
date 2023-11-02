Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879CA7DF9D3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbjKBSVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjKBSVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 14:21:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54399E5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 11:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698949228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vCkPgDNAcAuyFQJmJ3sGnTa/9jSqm1Vt4Hh4Jnv10kQ=;
        b=VxUrGG7C3jdZN8iXIMP0VF7S7SCAWMFQQ3KmE53SHlo9Pz3HumytmCxIzZjJeDvxX33mGn
        eAkZmsP63F6bZmr1hRzyP6wGRPwptoP8fqz7mlPlIjj0u93vLHCCTB9TWib/yodRpEVu+y
        cNUBT3Zas1yLubMoEO2kuVlO+wQtyPU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-Qs3bdT0XMO-pcZwGHAlnUg-1; Thu, 02 Nov 2023 14:20:26 -0400
X-MC-Unique: Qs3bdT0XMO-pcZwGHAlnUg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-32f8cb825c5so561415f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 11:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698949225; x=1699554025;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vCkPgDNAcAuyFQJmJ3sGnTa/9jSqm1Vt4Hh4Jnv10kQ=;
        b=j+ylI0ngl0YMvvcnw5jhZekL1ALe1yiTQaOzit9LDbUW7NEZT38RDEQCjb5rvQuTlb
         yP1zFy0QJX970o3aoML5Efw1dAyR6vD2nQUPVTQ3yNDGy+lUAwi4uBE+6s2blJDauk4e
         +x9ZvxdSIzSwNCKLmDETljW+1xGrgCK/GZKzfEaLBROKWgUgxBm/dBWi994IdXcK0QW0
         P1eRoFz7PjPKPY0aGTsI1rMpDTaBRE2nOg5dOV/ug2Mthzko5r3xB9fiPK45v5YO5M84
         tOXqh0cwPrC4rdth9HyzW/OYPm4amRiw6C4isK33eTGcU8g8SW+tEvs1x8ADjKzPJanp
         c2tw==
X-Gm-Message-State: AOJu0YyGIAmgiZBytn2flx0nZPKCKGdSFclq0crPJZ6UWzFAfAxXJNGz
        5ZkPuBsfoZOy7Q0QzjkR4V/0z7qW0XcvkZFvNaBcMlcQ/wN70wsOYm5NX3dsVCygQc0XJfcGSVr
        WPUk48t7z4RsPMBAViF6YzCPY
X-Received: by 2002:a05:6000:186c:b0:32f:7a65:da64 with SMTP id d12-20020a056000186c00b0032f7a65da64mr15466709wri.65.1698949225180;
        Thu, 02 Nov 2023 11:20:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGafUiev8YWXZ4EBUnlmWxuao5K8uPhqfCwENZFJcn2nZb8vNibvin3jbofi3dWYt1Xb5hk8g==
X-Received: by 2002:a05:6000:186c:b0:32f:7a65:da64 with SMTP id d12-20020a056000186c00b0032f7a65da64mr15466688wri.65.1698949224859;
        Thu, 02 Nov 2023 11:20:24 -0700 (PDT)
Received: from starship ([89.237.99.95])
        by smtp.gmail.com with ESMTPSA id z2-20020adff742000000b00326dd5486dcsm3081566wrp.107.2023.11.02.11.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 11:20:07 -0700 (PDT)
Message-ID: <f4e2d8c79ca3f238aafd61a82a3f5ad5c2d6bcab.camel@redhat.com>
Subject: Re: [PATCH v6 06/25] x86/fpu/xstate: Opt-in kernel dynamic bits
 when calculate guest xstate size
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Weijiang Yang <weijiang.yang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, pbonzini@redhat.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Date:   Thu, 02 Nov 2023 20:20:05 +0200
In-Reply-To: <ZUJdohf6wLE5LrCN@google.com>
References: <20230914063325.85503-1-weijiang.yang@intel.com>
         <20230914063325.85503-7-weijiang.yang@intel.com>
         <e0db6ffd-5d92-2a1a-bdfb-a190fe1ccd25@intel.com>
         <1347cf03-4598-f923-74e4-a3d193d9d2e9@intel.com>
         <ZTf5wPKXuHBQk0AN@google.com>
         <de1b148c-45c6-6517-0926-53d1aad8978e@intel.com>
         <ZTqgzZl-reO1m01I@google.com>
         <d6eb8a9dc5b0e4b83e1944d7e0bb8ee2cb9cc111.camel@redhat.com>
         <ZUJdohf6wLE5LrCN@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-11-01 at 07:16 -0700, Sean Christopherson wrote:
> On Tue, Oct 31, 2023, Maxim Levitsky wrote:
> > On Thu, 2023-10-26 at 10:24 -0700, Sean Christopherson wrote:
> > > On Wed, Oct 25, 2023, Weijiang Yang wrote:
> > On top of that I think that applying the same permission approach to guest's
> > FPU state is not a good fit, because of two reasons:
> > 
> > 1. The guest FPU state will never be pushed on the signal stack - KVM swaps
> >    back the host FPU state before it returns from the KVM_RUN ioctl.
> > 
> >    Also I think (not sure) that ptrace can only access (FPU) state of a
> >    stopped process, and a stopped vCPU process will also first return to
> >    userspace. Again I might be mistaken here, I never researched this in
> >    depth.
> > 
> >    Assuming that I am correct on these assumptions, the guest FPU state can
> >    only be accessed via KVM_GET_XSAVE/KVM_SET_XSAVE/KVM_GET_XSAVE2 ioctls,
> >    which also returns the userspace portion of the state including optionally
> >    the AMX state, but this ioctl doesn't really need FPU permission
> >    framework, because it is a KVM ABI, and in fact KVM_GET_XSAVE2 was added
> >    exactly because of that: to make sure that userspace is aware that larger
> >    than 4K buffer can be returned.
> > 
> > 2. Guest FPU state is not even on demand resized (but I can imagine that in
> >    the future we will do this).
> 
> Just because guest FPU state isn't resized doesn't mean there's no value in
> requiring userspace to opt-in to allocating 8KiB of data per-vCPU.
See my response below:
> 
> > And of course, adding permissions for kernel features, that is even worse
> > idea, which we really shouldn't do.
> > 
> > >  
> > > If there are no objections, I'll test the below and write a proper changelog.
> > >  
> > > --
> > > From: Sean Christopherson <seanjc@google.com>
> > > Date: Thu, 26 Oct 2023 10:17:33 -0700
> > > Subject: [PATCH] x86/fpu/xstate: Always preserve non-user xfeatures/flags in
> > >  __state_perm
> > > 
> > > Fixes: 781c64bfcb73 ("x86/fpu/xstate: Handle supervisor states in XSTATE permissions")
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > ---
> > >  arch/x86/kernel/fpu/xstate.c | 18 +++++++++++-------
> > >  1 file changed, 11 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> > > index ef6906107c54..73f6bc00d178 100644
> > > --- a/arch/x86/kernel/fpu/xstate.c
> > > +++ b/arch/x86/kernel/fpu/xstate.c
> > > @@ -1601,16 +1601,20 @@ static int __xstate_request_perm(u64 permitted, u64 requested, bool guest)
> > >  	if ((permitted & requested) == requested)
> > >  		return 0;
> > >  
> > > -	/* Calculate the resulting kernel state size */
> > > +	/*
> > > +	 * Calculate the resulting kernel state size.  Note, @permitted also
> > > +	 * contains supervisor xfeatures even though supervisor are always
> > > +	 * permitted for kernel and guest FPUs, and never permitted for user
> > > +	 * FPUs.
> > > +	 */
> > >  	mask = permitted | requested;
> > > -	/* Take supervisor states into account on the host */
> > > -	if (!guest)
> > > -		mask |= xfeatures_mask_supervisor();
> > >  	ksize = xstate_calculate_size(mask, compacted);
> > 
> > This might not work with kernel dynamic features, because
> > xfeatures_mask_supervisor() will return all supported supervisor features.
> 
> I don't understand what you mean by "This".

> 
> Somewhat of a side topic, I feel very strongly that we should use "guest only"
> terminology instead of "dynamic".  There is nothing dynamic about whether or not
> XFEATURE_CET_KERNEL is allowed; there's not even a real "decision" beyond checking
> wheter or not CET is supported.

> > Therefore at least until we have an actual kernel dynamic feature (a feature
> > used by the host kernel and not KVM, and which has to be dynamic like AMX),
> > I suggest that KVM stops using the permission API completely for the guest
> > FPU state, and just gives all the features it wants to enable right to
> 
> By "it", I assume you mean userspace?
> 
> > __fpu_alloc_init_guest_fpstate() (Guest FPU permission API IMHO should be
> > deprecated and ignored)
> 
> KVM allocates guest FPU state during KVM_CREATE_VCPU, so not using prctl() would
> either require KVM to defer allocating guest FPU state until KVM_SET_CPUID{,2},
> or would require a VM-scoped KVM ioctl() to let userspace opt-in to
> 
> Allocating guest FPU state during KVM_SET_CPUID{,2} would get messy, 

> as KVM allows
> multiple calls to KVM_SET_CPUID{,2} so long as the vCPU hasn't done KVM_RUN.  E.g.
> KVM would need to support actually resizing guest FPU state, which would be extra
> complexity without any meaningful benefit.


OK, I understand you now. What you claim is that it is legal to do this:

- KVM_SET_XSAVE
- KVM_SET_CPUID (with AMX enabled)

KVM_SET_CPUID will have to resize the xstate which is already valid.

Your patch to fix the __xstate_request_perm() does seem to be correct in a sense that it will
preserve the kernel fpu components in the fpu permissions.

However note that kernel fpu permissions come from 'fpu_kernel_cfg.default_features' 
which don't include the dynamic kernel xfeatures (added a few patches before this one).

Therefore an attempt to resize the xstate to include a kernel dynamic feature by
__xfd_enable_feature will fail.

If kvm on the other hand includes all the kernel dynamic features in the initial
allocation of FPU state (not optimal but possible), then later call to __xstate_request_perm
for a userspace dynamic feature (which can still happen) will mess the the xstate,
because again the permission code assumes that only default kernel features were granted the permissions.


This has to be solved this way or another.

> 
> The only benefit I can think of for a VM-scoped ioctl() is that it would allow a
> single process to host multiple VMs with different dynamic xfeature requirements.
> But such a setup is mostly theoretical.  Maybe it'll affect the SEV migration
> helper at some point?  But even that isn't guaranteed.
> 
> So while I agree that ARCH_GET_XCOMP_GUEST_PERM isn't ideal, practically speaking
> it's sufficient for all current use cases.  Unless a concrete use case comes along,
> deprecating ARCH_GET_XCOMP_GUEST_PERM in favor of a KVM ioctl() would be churn for
> both the kernel and userspace without any meaningful benefit, or really even any
> true change in behavior.


ARCH_GET_XCOMP_GUEST_PERM/ARCH_SET_XCOMP_GUEST_PERM is not a good API from usability POV, because it is redundant.

KVM already has API called KVM_SET_CPUID2, by which the qemu/userspace instructs the KVM, how much space to allocate,
to support a VM with *this* CPUID.


For example if qemu asks for nested SVM/VMX, then kvm will allocate on demand state for it (also at least 8K/vCPU btw).
The same should apply for AMX - Qemu sets AMX xsave bit in CPUID - that permits KVM to allocate the extra state when needed.

I don't see why we need an extra and non KVM API for that.


Best regards,
	Maxim Levitsky



> 


