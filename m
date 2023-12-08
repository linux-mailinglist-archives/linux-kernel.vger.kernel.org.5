Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA8880A720
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574225AbjLHPPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574175AbjLHPPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:15:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C0AF1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 07:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702048522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7g1DVTE/yUPzpMEJLLbgdrLjk1JCCnoCAxXauqWIKzI=;
        b=Rtxb8hXrBRRKHy8dvODEeTJ5OBVP/I8thCmrPtdPDmn4VczIIjVH2CKuc9nLP5uOegGjuG
        rK4XLAGVapZaFAJjaSEwAKMf+B8Z7QvdghBhArO4NeWh774u1/SHSOLGRznZ7zJ9La6zHa
        T6cgeCebsr0hmOtFQudW8LpqyK+0HQA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-E5NYtT-oOhqV7_q40-Vssw-1; Fri, 08 Dec 2023 10:15:21 -0500
X-MC-Unique: E5NYtT-oOhqV7_q40-Vssw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40c1e05ad32so15985615e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 07:15:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702048520; x=1702653320;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7g1DVTE/yUPzpMEJLLbgdrLjk1JCCnoCAxXauqWIKzI=;
        b=vyPyB283S5Z7ZaI0sESDJq1Z7fau0iHaSOf5qm2X2SsqxzIVhVPeUMcHgAkzhqTHLO
         +LrAHANBkeAft7FK3xQmQ09VxUhTjwNH77a5cJcf5zu2XA8960aNrpgwZOe9PLJTSgwO
         WHCOflwUOXbp5i/D6irDt+Pg7khYAyrF/EVsl1eAGk3t5ANsbJa3TeuPHtyE+vbxgxub
         5UzvgoA1HP6/qNaF1+UsPTcf+2KXShIi754TuANLJ2YCcoWZ3hsVzXvAoWDoq9NuROCq
         hH9ppPglxTOdBEZgwP0TqunWHw2hyoxlqZT+tRcOrv8rQoqcqGEM5aJ0p9YyXp4hJh/n
         VrfA==
X-Gm-Message-State: AOJu0Yz+j0X9nnzX8rM1Xvx0MrGXKc8qyZL1UfqUvMlKXubMi+aY5SCL
        xAcg7D8LwukWWSEVBmrzRdKThOmoglkJO1HRC2PXLjnLvCtNh+nxsONKGBKEHIVTUlDFeXu6SyX
        A2QF3CayIT2H3MZt1ThiLf1ZU
X-Received: by 2002:a05:600c:228a:b0:40c:2205:e600 with SMTP id 10-20020a05600c228a00b0040c2205e600mr58208wmf.215.1702048519945;
        Fri, 08 Dec 2023 07:15:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDjQddZikSdma5ARXAzjMIRnPPTaJZHKPlyBccchYJBr0Xh7YrSkYLkj1gk7dKbq9wHNKMSQ==
X-Received: by 2002:a05:600c:228a:b0:40c:2205:e600 with SMTP id 10-20020a05600c228a00b0040c2205e600mr58195wmf.215.1702048519507;
        Fri, 08 Dec 2023 07:15:19 -0800 (PST)
Received: from starship ([89.237.98.20])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d4bc6000000b00333381c6e12sm2242436wrt.40.2023.12.08.07.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 07:15:19 -0800 (PST)
Message-ID: <e7d7709a5962e8518ccb062e3818811cdbe110f8.camel@redhat.com>
Subject: Re: [PATCH v7 02/26] x86/fpu/xstate: Refine CET user xstate bit
 enabling
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     "Yang, Weijiang" <weijiang.yang@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        dave.hansen@intel.com, pbonzini@redhat.com, seanjc@google.com,
        peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Date:   Fri, 08 Dec 2023 17:15:17 +0200
In-Reply-To: <eb30c3e0-8e13-402c-b23d-48b21e0a1498@intel.com>
References: <20231124055330.138870-1-weijiang.yang@intel.com>
         <20231124055330.138870-3-weijiang.yang@intel.com>
         <c22d17ab04bf5f27409518e3e79477d579b55071.camel@redhat.com>
         <cdf53e44-62d0-452d-9c06-5c2d2ce3ce66@intel.com>
         <20d45cb6adaa4a8203822535e069cdbbf3b8ba2d.camel@redhat.com>
         <a3a14562-db72-4c19-9f40-7778f14fc516@intel.com>
         <039eaa7c35020774b74dc5e2d03bb0ecfa7c6d60.camel@redhat.com>
         <eb30c3e0-8e13-402c-b23d-48b21e0a1498@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-12-08 at 22:57 +0800, Yang, Weijiang wrote:
> On 12/6/2023 11:57 PM, Maxim Levitsky wrote:
> > On Wed, 2023-12-06 at 09:03 +0800, Yang, Weijiang wrote:
> > > On 12/5/2023 5:53 PM, Maxim Levitsky wrote:
> > > > On Fri, 2023-12-01 at 14:51 +0800, Yang, Weijiang wrote:
> > > > > On 12/1/2023 1:26 AM, Maxim Levitsky wrote:
> > > > > > On Fri, 2023-11-24 at 00:53 -0500, Yang Weijiang wrote:
> > > > > > > Remove XFEATURE_CET_USER entry from dependency array as the entry doesn't
> > > > > > > reflect true dependency between CET features and the user xstate bit.
> > > > > > > Enable the bit in fpu_kernel_cfg.max_features when either SHSTK or IBT is
> > > > > > > available.
> > > > > > > 
> > > > > > > Both user mode shadow stack and indirect branch tracking features depend
> > > > > > > on XFEATURE_CET_USER bit in XSS to automatically save/restore user mode
> > > > > > > xstate registers, i.e., IA32_U_CET and IA32_PL3_SSP whenever necessary.
> > > > > > > 
> > > > > > > Note, the issue, i.e., CPUID only enumerates IBT but no SHSTK is resulted
> > > > > > > from CET KVM series which synthesizes guest CPUIDs based on userspace
> > > > > > > settings,in real world the case is rare. In other words, the exitings
> > > > > > > dependency check is correct when only user mode SHSTK is available.
> > > > > > > 
> > > > > > > Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> > > > > > > Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> > > > > > > Tested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> > > > > > > ---
> > > > > > >     arch/x86/kernel/fpu/xstate.c | 9 ++++++++-
> > > > > > >     1 file changed, 8 insertions(+), 1 deletion(-)
> > > > > > > 
> > > > > > > diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> > > > > > > index 73f6bc00d178..6e50a4251e2b 100644
> > > > > > > --- a/arch/x86/kernel/fpu/xstate.c
> > > > > > > +++ b/arch/x86/kernel/fpu/xstate.c
> > > > > > > @@ -73,7 +73,6 @@ static unsigned short xsave_cpuid_features[] __initdata = {
> > > > > > >     	[XFEATURE_PT_UNIMPLEMENTED_SO_FAR]	= X86_FEATURE_INTEL_PT,
> > > > > > >     	[XFEATURE_PKRU]				= X86_FEATURE_OSPKE,
> > > > > > >     	[XFEATURE_PASID]			= X86_FEATURE_ENQCMD,
> > > > > > > -	[XFEATURE_CET_USER]			= X86_FEATURE_SHSTK,
> > > > > > >     	[XFEATURE_XTILE_CFG]			= X86_FEATURE_AMX_TILE,
> > > > > > >     	[XFEATURE_XTILE_DATA]			= X86_FEATURE_AMX_TILE,
> > > > > > >     };
> > > > > > > @@ -798,6 +797,14 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
> > > > > > >     			fpu_kernel_cfg.max_features &= ~BIT_ULL(i);
> > > > > > >     	}
> > > > > > >     
> > > > > > > +	/*
> > > > > > > +	 * CET user mode xstate bit has been cleared by above sanity check.
> > > > > > > +	 * Now pick it up if either SHSTK or IBT is available. Either feature
> > > > > > > +	 * depends on the xstate bit to save/restore user mode states.
> > > > > > > +	 */
> > > > > > > +	if (boot_cpu_has(X86_FEATURE_SHSTK) || boot_cpu_has(X86_FEATURE_IBT))
> > > > > > > +		fpu_kernel_cfg.max_features |= BIT_ULL(XFEATURE_CET_USER);
> > > > > > > +
> > > > > > >     	if (!cpu_feature_enabled(X86_FEATURE_XFD))
> > > > > > >     		fpu_kernel_cfg.max_features &= ~XFEATURE_MASK_USER_DYNAMIC;
> > > > > > >     
> > > > > > I am curious:
> > > > > > 
> > > > > > Any reason why my review feedback was not applied even though you did agree
> > > > > > that it is reasonable?
> > > > > My apology! I changed the patch per you feedback but found XFEATURE_CET_USER didn't
> > > > > work before sending out v7 version, after a close look at the existing code:
> > > > > 
> > > > >            for (i = 0; i < ARRAY_SIZE(xsave_cpuid_features); i++) {
> > > > >                    unsigned short cid = xsave_cpuid_features[i];
> > > > > 
> > > > >                    /* Careful: X86_FEATURE_FPU is 0! */
> > > > >                    if ((i != XFEATURE_FP && !cid) || !boot_cpu_has(cid))
> > > > >                            fpu_kernel_cfg.max_features &= ~BIT_ULL(i);
> > > > >            }
> > > > > 
> > > > > With removal of XFEATURE_CET_USER entry from xsave_cpuid_features, actually
> > > > > above check will clear the bit from fpu_kernel_cfg.max_features.
> > > > Are you sure about this? If we remove the XFEATURE_CET_USER from the xsave_cpuid_features,
> > > > then the above loop will not touch it - it loops only over the items in the xsave_cpuid_features
> > > > array.
> > > No,  the code is a bit tricky, the actual array size is XFEATURE_XTILE_DATA( ie, 18) + 1, those xfeature bits not listed in init code leave a blank entry with xsave_cpuid_features[i] == 0, so for the blank elements, the loop hits (i != XFEATURE_FP && !cid) then the relevant xfeature bit for i is cleared in fpu_kernel_cfg.max_features. I had the same illusion at first when I replied your comments in v6, and modified the code as you suggested but found the issue during tests. Please double check it.
> > Oh I see now. IMHO the current code is broken, or at least it violates the
> > 'Clear XSAVE features that are disabled in the normal CPUID' comment, because
> > it also clears all xfeatures which have no CPUID bit in the table (except FPU,
> > for which we have a workaround).
> > 
> > 
> > How about we do this instead:
> > 
> > 	for (i = 0; i < ARRAY_SIZE(xsave_cpuid_features); i++) {
> > 		unsigned short cid = xsave_cpuid_features[i];
> > 
> > 		if (cid && !boot_cpu_has(cid))
> > 			fpu_kernel_cfg.max_features &= ~BIT_ULL(i);
> > 	}
> 
> I think existing code is more reasonable,  the side-effect of current code, i.e., masking out
> the unclaimed xfeature bits, sanitizes the bits in max_features at the first place, then following calculations derived from it become reasonable too. 


I strongly disagree with that. Kernel already removes all features bits which it knows nothing about.

There is no need to also remove the xfeatures that it knows about but knows nothing about a CPUID bit.
For such features the kernel needs either to accept it (like FPU) or remove the feature from set of supported features.


> It also forces developers add explicit dependency claim between xfeature bit and its CPUID so that make it clear why one bit is needed in max_features. 

A static compile time assert for this is a good idea but not some undocumented cleaning of the bits that was not obvious to either you not me.


Best regards,
	Maxim Levitsky


> Regarding CET_USER bit handling, it could be a singular case, hope it can be tolerated :-)
> > The only side effect is that this code will not clear features bits for which kernel knows
> > no CPUID bit but kernel anyway clears _all_ features that it knows nothing about so there
> > is no net change in behavior.




> > 
> > (That is kernel only allows XFEATURE_MASK_USER_SUPPORTED | XFEATURE_MASK_SUPERVISOR_SUPPORTED)
> 
> IMHO, the bits in the macros are just xfeature candidate bits, the relevant CPUID features could be disabled
> for any reason, in this case, the bits should not be appear in fpu_kernel_cfg.max_features.
> 


