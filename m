Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39ADD804FD1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344986AbjLEKHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjLEKHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 05:07:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640EEA0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 02:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701770843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x148bBHLIWoRdTIuSUDsms3L0/kz5tEEM1BzickcGxY=;
        b=Cr5l7JasVxWlHMP0OC4+vqQI4kTa2t5ZBOTsUXOoGUOuxEKDpjqo9+NG2fnGX1xGLVP3nk
        d5ufcAfZITO5wbZBiryYScFwk8xM0LKc0jb1aXy6Lu6h3Xu7JpHlZCLUvets+JHPDNAoUF
        DyzCg/PeBzGsiBf5r+Ap8lWKLwmq3z0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-RysczGrbM1SnJpvdZMwjEA-1; Tue, 05 Dec 2023 05:07:22 -0500
X-MC-Unique: RysczGrbM1SnJpvdZMwjEA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-333524816e1so972250f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 02:07:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701770841; x=1702375641;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x148bBHLIWoRdTIuSUDsms3L0/kz5tEEM1BzickcGxY=;
        b=jp32dD/iuekG804LPXz0PCkg7YAcZCpeGHeey1x8LyZ+c5BR7iIt5WpW/YuVjuANOX
         Fz50xNCnd6eBNabsI5eVUg+32b6/fThJH0GkFBpkQXyLHxgkAr6xmikq51tmbfuvICxu
         ahb9XiGOD8ph+BuOLL0FoEtXYHuhbW+KyRTjwGmygmjFCF71zIeXrYVLtb1qT31dL1ul
         +LbGTbk9hwHr+2ZPgz4McpZA90YteXDJ46LGYgRhpYu+TLlWa/dx5z7IWcgTUcH359zv
         AcKzofCJeW8DZBuVEB1xaSFIW3Q0t37XOgbZx+gtLjn4sgHyO8/d81itI7knqAbb2TNh
         Lylw==
X-Gm-Message-State: AOJu0YyRDppFB8czIz+CM8C9QaU4OTLNUfDOWVcI13Nzz9fz7eAZ7wQl
        hv5+s/sLG63R9JW6ZckvTFjFRifYzSj4VveBKz2TDEJpzxDdvFNBna42L+TrXd0TlCr90L6g1m2
        Ub/o/fWJyQ2E7v/4aScbJOkdm
X-Received: by 2002:a05:600c:46d3:b0:40b:377a:2ac1 with SMTP id q19-20020a05600c46d300b0040b377a2ac1mr3593108wmo.20.1701770841149;
        Tue, 05 Dec 2023 02:07:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0lSfh68UPYOAWd1S8YfHqq7SycLvmqL+oKUOwuh/VYpRm0gR7TN7zf/DTs9+twZs6uWVcXQ==
X-Received: by 2002:a05:600c:46d3:b0:40b:377a:2ac1 with SMTP id q19-20020a05600c46d300b0040b377a2ac1mr3593096wmo.20.1701770840798;
        Tue, 05 Dec 2023 02:07:20 -0800 (PST)
Received: from starship ([89.237.98.20])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c4f8a00b004053e9276easm21629722wmq.32.2023.12.05.02.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 02:07:20 -0800 (PST)
Message-ID: <be5cc36e1bb618aab666a2148e5a376b2d39a297.camel@redhat.com>
Subject: Re: [PATCH v7 22/26] KVM: VMX: Set up interception for CET MSRs
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     "Yang, Weijiang" <weijiang.yang@intel.com>
Cc:     pbonzini@redhat.com, seanjc@google.com, peterz@infradead.org,
        chao.gao@intel.com, rick.p.edgecombe@intel.com, john.allen@amd.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        dave.hansen@intel.com
Date:   Tue, 05 Dec 2023 12:07:18 +0200
In-Reply-To: <e79d43ea-3ca0-44ca-9a55-b8e2c5094cf2@intel.com>
References: <20231124055330.138870-1-weijiang.yang@intel.com>
         <20231124055330.138870-23-weijiang.yang@intel.com>
         <393d82243b7f44731439717be82b20fbeda45c77.camel@redhat.com>
         <e79d43ea-3ca0-44ca-9a55-b8e2c5094cf2@intel.com>
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

On Fri, 2023-12-01 at 17:45 +0800, Yang, Weijiang wrote:
> On 12/1/2023 1:44 AM, Maxim Levitsky wrote:
> > On Fri, 2023-11-24 at 00:53 -0500, Yang Weijiang wrote:
> > > Enable/disable CET MSRs interception per associated feature configuration.
> > > Shadow Stack feature requires all CET MSRs passed through to guest to make
> > > it supported in user and supervisor mode while IBT feature only depends on
> > > MSR_IA32_{U,S}_CETS_CET to enable user and supervisor IBT.
> > > 
> > > Note, this MSR design introduced an architectural limitation of SHSTK and
> > > IBT control for guest, i.e., when SHSTK is exposed, IBT is also available
> > > to guest from architectual perspective since IBT relies on subset of SHSTK
> > > relevant MSRs.
> > > 
> > > Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> > > ---
> > >   arch/x86/kvm/vmx/vmx.c | 42 ++++++++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 42 insertions(+)
> > > 
> > > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > > index 554f665e59c3..e484333eddb0 100644
> > > --- a/arch/x86/kvm/vmx/vmx.c
> > > +++ b/arch/x86/kvm/vmx/vmx.c
> > > @@ -699,6 +699,10 @@ static bool is_valid_passthrough_msr(u32 msr)
> > >   	case MSR_LBR_CORE_TO ... MSR_LBR_CORE_TO + 8:
> > >   		/* LBR MSRs. These are handled in vmx_update_intercept_for_lbr_msrs() */
> > >   		return true;
> > > +	case MSR_IA32_U_CET:
> > > +	case MSR_IA32_S_CET:
> > > +	case MSR_IA32_PL0_SSP ... MSR_IA32_INT_SSP_TAB:
> > > +		return true;
> > >   	}
> > >   
> > >   	r = possible_passthrough_msr_slot(msr) != -ENOENT;
> > > @@ -7766,6 +7770,42 @@ static void update_intel_pt_cfg(struct kvm_vcpu *vcpu)
> > >   		vmx->pt_desc.ctl_bitmask &= ~(0xfULL << (32 + i * 4));
> > >   }
> > >   
> > > +static void vmx_update_intercept_for_cet_msr(struct kvm_vcpu *vcpu)
> > > +{
> > > +	bool incpt;
> > > +
> > > +	if (kvm_cpu_cap_has(X86_FEATURE_SHSTK)) {
> > > +		incpt = !guest_cpuid_has(vcpu, X86_FEATURE_SHSTK);
> > > +
> > > +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_U_CET,
> > > +					  MSR_TYPE_RW, incpt);
> > > +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_S_CET,
> > > +					  MSR_TYPE_RW, incpt);
> > > +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL0_SSP,
> > > +					  MSR_TYPE_RW, incpt);
> > > +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL1_SSP,
> > > +					  MSR_TYPE_RW, incpt);
> > > +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL2_SSP,
> > > +					  MSR_TYPE_RW, incpt);
> > > +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL3_SSP,
> > > +					  MSR_TYPE_RW, incpt);
> > > +		if (guest_cpuid_has(vcpu, X86_FEATURE_LM))
> > > +			vmx_set_intercept_for_msr(vcpu, MSR_IA32_INT_SSP_TAB,
> > > +						  MSR_TYPE_RW, incpt);
> > > +		if (!incpt)
> > > +			return;
> > > +	}
> > > +
> > > +	if (kvm_cpu_cap_has(X86_FEATURE_IBT)) {
> > > +		incpt = !guest_cpuid_has(vcpu, X86_FEATURE_IBT);
> > > +
> > > +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_U_CET,
> > > +					  MSR_TYPE_RW, incpt);
> > > +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_S_CET,
> > > +					  MSR_TYPE_RW, incpt);
> > > +	}
> > > +}
> > > +
> > >   static void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
> > >   {
> > >   	struct vcpu_vmx *vmx = to_vmx(vcpu);
> > > @@ -7843,6 +7883,8 @@ static void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
> > >   
> > >   	/* Refresh #PF interception to account for MAXPHYADDR changes. */
> > >   	vmx_update_exception_bitmap(vcpu);
> > > +
> > > +	vmx_update_intercept_for_cet_msr(vcpu);
> > >   }
> > >   
> > >   static u64 vmx_get_perf_capabilities(void)
> > My review feedback from the previous patch still applies as well,
> > 
> > I still think that we should either try a best effort approach to plug
> > this virtualization hole, or we at least should fail guest creation
> > if the virtualization hole is present as I said:
> > 
> > "Another, much simpler option is to fail the guest creation if the shadow stack + indirect branch tracking
> > state differs between host and the guest, unless both are disabled in the guest.
> > (in essence don't let the guest be created if (2) or (3) happen)"
> > 
> > Please at least tell me what do you think about this.
> 
> Oh, I thought I had replied this patch in v6 but I failed to send it out!
> Let me explain it a bit, at early stage of this series, I thought of checking relevant host
> feature enabling status before exposing guest CET features, but it's proved
> unnecessary and user unfriendly.
> 
> E.g., we frequently disable host CET features due to whatever reasons on host,  then
> the features cannot be used/tested in guest at all.  Technically, guest should be allowed
> to run the features so long as the dependencies(i.e., xsave related support) are enabled
> on host and there're no risks brought up by using of the features in guest.

To be honest this is a dangerous POV in regard to guest migration: If the VMM were to be lax with features
that it exposes to the guest, then the guests will start to make assumptions instead of checking CPUID
and then the guest will mysteriously fail when migrated to a machine which actually lacks the features,
in addition to not having them in the CPUID.

In other words, leaving "undocumented" features opens a slippery slope of later supporting this
undocumented behavior.

I understand though that CET is problematic, and I overall won't object much to leave things as is
but a part of me thinks that we will regret it later.

Best regards,
	Maxim Levitsky

> 
> I think cloud-computing should share the similar pain point when deploy CET into virtualization
> usages.
> 
> 




