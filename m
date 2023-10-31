Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3557DD4DE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346971AbjJaRo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346874AbjJaRo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:44:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9587FC1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698774245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oKEmMRTzzezdIfeKLIaMmMSqgcMCI7WPrINjDc8nqho=;
        b=Os50f/oZk5FRUGR6XS08aceSb9qoAYKfvMkT9a1DSdTZXWXhOBVZO4GvfqQ1FvLJ9DMY5F
        zv9F9M9kumM2qxuI1ltsGJs2Cij+hdSIlLYDc0sQ59iVuqnYykcQ/nISiDscq4T6sMdfvm
        u1FRPIKo8rxvUQ7r4cQpdpudmCSaPfc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-t3c3rxK1MiuzCFHaMrfxUA-1; Tue, 31 Oct 2023 13:43:58 -0400
X-MC-Unique: t3c3rxK1MiuzCFHaMrfxUA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-408524e2368so41359475e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698774237; x=1699379037;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oKEmMRTzzezdIfeKLIaMmMSqgcMCI7WPrINjDc8nqho=;
        b=Tt6mt32u7Yf/vpx9fEX8czWr5GUAx/TK8Y7bHdSjbrPA+GQhrKmpX87qnTOl5yIHmH
         eWPm0IBcgG3hFuzFgsa7mtbEtyLhPNnVQN1fAz75CkpRiND9JxAillvDqANgrr8oMJEv
         Dr7QSDQ8fhf6QtkyBj/+pOvuvVCidfGMEBBZo0iI+5C1F5BtcQgGl4uERvP8NTir9rm6
         r/Z8YIwhsTe8lAR9mjl3IEnSyRPKkLou855CfcZ2Vsvv7fkhfXFyeioLFeNz/54y4Fqs
         5KULXtnHt6iiUy6QZFDjSbkzWHtzihxtUZBxgDJR8WIzXndNRGADWOogtZDNGzSR1r5i
         bMEw==
X-Gm-Message-State: AOJu0YzQ00zUYxrYIKE/iH9Ph2pevT2/CElSi+xZusL+PYoRWqK38Dwl
        /Fh3XOlbeoJyTDlWsTrzSd2u9F+K27vLe4mSvh/N2hmzCd0v0QObgX89CQAWlIQDC6jGYkcYP0T
        8L8/py6RLOHCmHRqvr64tHI+5
X-Received: by 2002:a05:600c:4f8a:b0:401:daf2:2737 with SMTP id n10-20020a05600c4f8a00b00401daf22737mr10897278wmq.30.1698774236980;
        Tue, 31 Oct 2023 10:43:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGFc///QXd0FGNNDxlPwzffK54+k3OPnV0SfFsCLqWpeFYsOLUHjUAinEW/IAPFQWyA/BA5g==
X-Received: by 2002:a05:600c:4f8a:b0:401:daf2:2737 with SMTP id n10-20020a05600c4f8a00b00401daf22737mr10897264wmq.30.1698774236579;
        Tue, 31 Oct 2023 10:43:56 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id h10-20020a05600c350a00b004064cd71aa8sm2370954wmq.34.2023.10.31.10.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:43:56 -0700 (PDT)
Message-ID: <af972fe5981b9e7101b64de43c7be0a8cc165323.camel@redhat.com>
Subject: Re: [PATCH v6 02/25] x86/fpu/xstate: Fix guest fpstate allocation
 size calculation
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com,
        peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Date:   Tue, 31 Oct 2023 19:43:54 +0200
In-Reply-To: <ZTfxly8573xdnruS@google.com>
References: <20230914063325.85503-1-weijiang.yang@intel.com>
         <20230914063325.85503-3-weijiang.yang@intel.com>
         <ZTMdyR8e63sCTKWc@google.com>
         <e02b39c1-96aa-faf9-5750-4c53b5a5fb46@intel.com>
         <ZTfxly8573xdnruS@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-10-24 at 09:32 -0700, Sean Christopherson wrote:
> On Tue, Oct 24, 2023, Weijiang Yang wrote:
> > On 10/21/2023 8:39 AM, Sean Christopherson wrote:
> > > On Thu, Sep 14, 2023, Yang Weijiang wrote:
> > > > Fix guest xsave area allocation size from fpu_user_cfg.default_size to
> > > > fpu_kernel_cfg.default_size so that the xsave area size is consistent
> > > > with fpstate->size set in __fpstate_reset().
> > > > 
> > > > With the fix, guest fpstate size is sufficient for KVM supported guest
> > > > xfeatures.
> > > > 
> > > > Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> > > > ---
> > > >   arch/x86/kernel/fpu/core.c | 4 +++-
> > > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> > > > index a86d37052a64..a42d8ad26ce6 100644
> > > > --- a/arch/x86/kernel/fpu/core.c
> > > > +++ b/arch/x86/kernel/fpu/core.c
> > > > @@ -220,7 +220,9 @@ bool fpu_alloc_guest_fpstate(struct fpu_guest *gfpu)
> > > >   	struct fpstate *fpstate;
> > > >   	unsigned int size;
> > > > -	size = fpu_user_cfg.default_size + ALIGN(offsetof(struct fpstate, regs), 64);
> > > > +	size = fpu_kernel_cfg.default_size +
> > > > +	       ALIGN(offsetof(struct fpstate, regs), 64);
> > > Shouldn't all the other calculations in this function also switch to fpu_kernel_cfg?
> > > At the very least, this looks wrong when paired with the above:
> > > 
> > > 	gfpu->uabi_size		= sizeof(struct kvm_xsave);
> > > 	if (WARN_ON_ONCE(fpu_user_cfg.default_size > gfpu->uabi_size))
> > > 		gfpu->uabi_size = fpu_user_cfg.default_size;
> > 
> > Hi, Sean,
> > Not sure what's your concerns.
> > From my understanding fpu_kernel_cfg.default_size should include all enabled
> > xfeatures in host (XCR0 | XSS), this is also expected for supporting all
> > guest enabled xfeatures. gfpu->uabi_size only includes enabled user xfeatures
> > which are operated via KVM uABIs(KVM_GET_XSAVE/KVM_SET_XSAVE/KVM_GET_XSAVE2),
> > so the two sizes are relatively independent since guest supervisor xfeatures
> > are saved/restored via GET/SET_MSRS interfaces.
> 
> Ah, right, I keep forgetting that KVM's ABI can't use XRSTOR because it forces
> the compacted format.
> 
> This part still looks odd to me:
> 
> 	gfpu->xfeatures		= fpu_user_cfg.default_features;

That should be indeed fpu_kernel_cfg.default_features. 
This variable is also currently hardly used, it only tracks which dynamic userspace features
are enabled and KVM only uses it once (in fpu_enable_guest_xfd_features)



> 	gfpu->perm		= fpu_user_cfg.default_features;


This variable I think is currently only set and never read.

Note that current->group_leader->thread.fpu.guest_perm is actually initialized to fpu_kernel_cfg.default_features
but the kernel components of it masked in the corresponding prctl 
(ARCH_GET_XCOMP_SUPP/ARCH_GET_XCOMP_GUEST_PERM/ARCH_REQ_XCOMP_GUEST_PERM).

So I think that we also should use fpu_kernel_cfg.default_features here for the sake of not having uninitilized
variable on 32 bit kernels, because the whole FPU permission thing I see is implemented for 64 bit kernels only.

Or even better IMHO is to remove both variables and in fpu_enable_guest_xfd_features,
just mask the xfeatures with the XFEATURE_MASK_USER_DYNAMIC instead.


Best regards,
	Maxim Levitsky

> 
> but I'm probably just not understanding something in the other patches changes yet.
> 







