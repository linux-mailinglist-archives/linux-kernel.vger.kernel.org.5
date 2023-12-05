Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E59804FF9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346689AbjLEKNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376795AbjLEJz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:55:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D056A1A4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 01:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701770161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=grTJ7yip744IhaQrVqj6sS9YQufy0rAAz+sVkwOzAuM=;
        b=YEWCbMNP25xxxOSvu6/dI30+6A8pLlHMpyyy8SrRWRgXAjImqdVFK7KgjHy/KftOzKp8Wn
        JmZzlV0TUa2MffnDPFMhbJMzCzpQp57GF++AnK3xs3OPFaHBkVJbGZ6c6Sj4dDFhK+Xw6p
        m5OZVAPyNN3Lq/j1vrMtY9qY3+OCk3I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-5AxjZjf1O_uMss01wNfd2g-1; Tue, 05 Dec 2023 04:55:59 -0500
X-MC-Unique: 5AxjZjf1O_uMss01wNfd2g-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40b32faeb7eso41618495e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 01:55:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701770159; x=1702374959;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=grTJ7yip744IhaQrVqj6sS9YQufy0rAAz+sVkwOzAuM=;
        b=LvoZXu+RiJRub+wSjlPM1K0AZROjqm99k1ZFdgpFIOT9Pr7jMWmllEsiAZETQgR9wU
         Q+W0c5JgH0hS6aiG6EYCFFBOMHO0vayErAvHyN6LSnzZ63muYEwcGMqO6DNVup2vzZMg
         oJmixLI0ql5nfQFPgHRTfdt5OyoIRZBeoP0h+a3/+RuqiV/VLpBiBUDPd+BHDkmv8lgX
         3y7kbpVOa8xVjOKzat+2j6k95vMKCSWTZKbSm/EgzYp4pLU2+v1aBXO2VAMkhjP4CvD0
         ckjPw94iTNOEGFQs/98VnEhJOXOtBJjpL10aKWy7j+J3mYnx4QpxDtVCIySXWCCSqVCQ
         9Nfw==
X-Gm-Message-State: AOJu0Yz1Y+8Ec02PyVeUJiCqAfCDyDYVQs1P+iaYdcFvf/F2jIX3wIRw
        ha0edYs4BEoOhNKm1I0gRsLbIukaOYpslJDKp3DXR13AJECE3IeOZWnXglcbJDznmDGaC2cYzFd
        1uAno165C0wOy5F5OgFfIx0Wu
X-Received: by 2002:a05:600c:190a:b0:40b:5e21:c5cc with SMTP id j10-20020a05600c190a00b0040b5e21c5ccmr219161wmq.154.1701770158746;
        Tue, 05 Dec 2023 01:55:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBmH3PIwabvFznw840nNF2cGI7f5mQAdKpdhuYFUSRcOVuCCbYycoWyZqBvpZBmhyg5/EPLg==
X-Received: by 2002:a05:600c:190a:b0:40b:5e21:c5cc with SMTP id j10-20020a05600c190a00b0040b5e21c5ccmr219149wmq.154.1701770158440;
        Tue, 05 Dec 2023 01:55:58 -0800 (PST)
Received: from starship ([89.237.98.20])
        by smtp.gmail.com with ESMTPSA id fc9-20020a05600c524900b0040b34720206sm18116954wmb.12.2023.12.05.01.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 01:55:58 -0800 (PST)
Message-ID: <5a8c870875acc5c7e72eb3e885c12d6362f45243.camel@redhat.com>
Subject: Re: [PATCH v7 04/26] x86/fpu/xstate: Introduce
 XFEATURE_MASK_KERNEL_DYNAMIC xfeature set
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     "Yang, Weijiang" <weijiang.yang@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        dave.hansen@intel.com, pbonzini@redhat.com, seanjc@google.com,
        peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Date:   Tue, 05 Dec 2023 11:55:56 +0200
In-Reply-To: <9a7052ca-9c67-45b5-ba23-dbd23e69722c@intel.com>
References: <20231124055330.138870-1-weijiang.yang@intel.com>
         <20231124055330.138870-5-weijiang.yang@intel.com>
         <3c16bb90532fbd2ec95b5a3d42a93bbbf77c4d37.camel@redhat.com>
         <9a7052ca-9c67-45b5-ba23-dbd23e69722c@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-12-01 at 15:49 +0800, Yang, Weijiang wrote:
> On 12/1/2023 1:33 AM, Maxim Levitsky wrote:
> > On Fri, 2023-11-24 at 00:53 -0500, Yang Weijiang wrote:
> > > Define new XFEATURE_MASK_KERNEL_DYNAMIC set including the features can be
> > I am not sure though that this name is correct, but I don't know if I can
> > suggest a better name.
> 
> It's a symmetry of XFEATURE_MASK_USER_DYNAMIC ;-)
> > > optionally enabled by kernel components, i.e., the features are required by
> > > specific kernel components. Currently it's used by KVM to configure guest
> > > dedicated fpstate for calculating the xfeature and fpstate storage size etc.
> > > 
> > > The kernel dynamic xfeatures now only contain XFEATURE_CET_KERNEL, which is
> > > supported by host as they're enabled in xsaves/xrstors operating xfeature set
> > > (XCR0 | XSS), but the relevant CPU feature, i.e., supervisor shadow stack, is
> > > not enabled in host kernel so it can be omitted for normal fpstate by default.
> > > 
> > > Remove the kernel dynamic feature from fpu_kernel_cfg.default_features so that
> > > the bits in xstate_bv and xcomp_bv are cleared and xsaves/xrstors can be
> > > optimized by HW for normal fpstate.
> > > 
> > > Suggested-by: Dave Hansen <dave.hansen@intel.com>
> > > Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> > > ---
> > >   arch/x86/include/asm/fpu/xstate.h | 5 ++++-
> > >   arch/x86/kernel/fpu/xstate.c      | 1 +
> > >   2 files changed, 5 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
> > > index 3b4a038d3c57..a212d3851429 100644
> > > --- a/arch/x86/include/asm/fpu/xstate.h
> > > +++ b/arch/x86/include/asm/fpu/xstate.h
> > > @@ -46,9 +46,12 @@
> > >   #define XFEATURE_MASK_USER_RESTORE	\
> > >   	(XFEATURE_MASK_USER_SUPPORTED & ~XFEATURE_MASK_PKRU)
> > >   
> > > -/* Features which are dynamically enabled for a process on request */
> > > +/* Features which are dynamically enabled per userspace request */
> > >   #define XFEATURE_MASK_USER_DYNAMIC	XFEATURE_MASK_XTILE_DATA
> > >   
> > > +/* Features which are dynamically enabled per kernel side request */
> > I suggest to explain this a bit better. How about something like that:
> > 
> > "Kernel features that are not enabled by default for all processes, but can
> > be still used by some processes, for example to support guest virtualization"
> 
> It looks good to me, will apply it in next version, thanks!
> 
> > But feel free to keep it as is or propose something else. IMHO this will
> > be confusing this way or another.
> > 
> > 
> > Another question: kernel already has a notion of 'independent features'
> > which are currently kernel features that are enabled in IA32_XSS but not present in 'fpu_kernel_cfg.max_features'
> > 
> > Currently only 'XFEATURE_LBR' is in this set. These features are saved/restored manually
> > from independent buffer (in case of LBRs, perf code cares for this).
> > 
> > Does it make sense to add CET_S to there as well instead of having XFEATURE_MASK_KERNEL_DYNAMIC,
> 
> CET_S here refers to PL{0,1,2}_SSP, right?
> 
> IMHO, perf relies on dedicated code to switch LBR MSRs for various reason, e.g., overhead, the feature
> owns dozens of MSRs, remove xfeature bit will offload the burden of common FPU/xsave framework.

This is true, but the question that begs to be asked, is what is the true purpose of the 'independent features' is
from the POV of the kernel FPU framework. IMHO these are features that the framework is not aware of, except
that it enables it in IA32_XSS (and in XCR0 in the future).

For the guest only features, like CET_S, it is also kind of the same thing (xsave but to guest state area only).
I don't insist that we add CET_S to independent features, but I just gave an idea that maybe that is better
from complexity point of view to add CET there. It's up to you to decide.

Sean what do you think?

Best regards,
	Maxim Levitsky


> 
> But CET only has 3 supervisor MSRs and they need to be managed together with user mode MSRs.
> Enabling it in common FPU framework would make the switch/swap much easier without additional
> support code.
> 
> >   and maybe rename the
> > 'XFEATURE_MASK_INDEPENDENT' to something like 'XFEATURES_THE_KERNEL_DOESNT_CARE_ABOUT'
> > (terrible name, but you might think of a better name)
> > 
> > 
> > > +#define XFEATURE_MASK_KERNEL_DYNAMIC	XFEATURE_MASK_CET_KERNEL
> > > +
> > >   /* All currently supported supervisor features */
> > >   #define XFEATURE_MASK_SUPERVISOR_SUPPORTED (XFEATURE_MASK_PASID | \
> > >   					    XFEATURE_MASK_CET_USER | \
> > > diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> > > index b57d909facca..ba4172172afd 100644
> > > --- a/arch/x86/kernel/fpu/xstate.c
> > > +++ b/arch/x86/kernel/fpu/xstate.c
> > > @@ -824,6 +824,7 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
> > >   	/* Clean out dynamic features from default */
> > >   	fpu_kernel_cfg.default_features = fpu_kernel_cfg.max_features;
> > >   	fpu_kernel_cfg.default_features &= ~XFEATURE_MASK_USER_DYNAMIC;
> > > +	fpu_kernel_cfg.default_features &= ~XFEATURE_MASK_KERNEL_DYNAMIC;
> > >   
> > >   	fpu_user_cfg.default_features = fpu_user_cfg.max_features;
> > >   	fpu_user_cfg.default_features &= ~XFEATURE_MASK_USER_DYNAMIC;
> > 
> > Best regards,
> > 	Maxim Levitsky
> > 
> > 
> > 
> > 




