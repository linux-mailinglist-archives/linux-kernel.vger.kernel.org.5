Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1EA7F247F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 04:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbjKUDKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 22:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjKUDKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 22:10:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63AFBC;
        Mon, 20 Nov 2023 19:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700536226; x=1732072226;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+P9oonEPLwebJ2u+rmYI9E5ttIAiBdzIFEWcnlkvP0U=;
  b=fFPRvxZloSQxNv/nw9SBQ5VfPH/+sETd9Jm9lRvYXIljuXFBH4ZA3P6G
   UDwHJbj6KmsKXhEprnOJ3Dy/xSU/GcBLKlYPHP0xQFtiASK3SLrhBzQ4O
   Oewta5Bgl3xXAvHO4Bf1WfSO/7R+nW/5IOA+HyPzxtvXaQ4skrm+8HoM1
   EYXZbp/16H8JvDxdCvbsyVni8hegNrtvrtRH07Rb3RWTt33DbAbBkSxCn
   JPNelM3dkPGJpGnMDEez6SO7GdrlnjdhH8sY0kmUWHu5yHezupb1cLY+i
   ffxcCsZng7G4/4wEcYRIFEl8nsrBZh0yVA1WKb/lFOFOru1/NLLAL5+lx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="390609584"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="390609584"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 19:10:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="7921020"
Received: from yy-desk-7060.sh.intel.com (HELO localhost) ([10.239.159.76])
  by fmviesa002.fm.intel.com with ESMTP; 20 Nov 2023 19:10:24 -0800
Date:   Tue, 21 Nov 2023 11:10:24 +0800
From:   Yuan Yao <yuan.yao@linux.intel.com>
To:     "Yang, Weijiang" <weijiang.yang@intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH 3/9] KVM: x86: Initialize guest cpu_caps based on guest
 CPUID
Message-ID: <20231121031024.gxghavohrkgh7psd@yy-desk-7060>
References: <20231110235528.1561679-1-seanjc@google.com>
 <20231110235528.1561679-4-seanjc@google.com>
 <c9f65fc1-ab55-4959-a8ec-390aee51ee3a@intel.com>
 <ZVaXroTZQi1IcTvm@google.com>
 <c9401dbf-88a0-404d-a8d3-33f0e712cda3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c9401dbf-88a0-404d-a8d3-33f0e712cda3@intel.com>
User-Agent: NeoMutt/20171215
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 04:33:27PM +0800, Yang, Weijiang wrote:
> On 11/17/2023 6:29 AM, Sean Christopherson wrote:
> > On Thu, Nov 16, 2023, Weijiang Yang wrote:
> > > On 11/11/2023 7:55 AM, Sean Christopherson wrote:
> > >
> > > [...]
> > >
> > > > -static __always_inline void guest_cpu_cap_check_and_set(struct kvm_vcpu *vcpu,
> > > > -							unsigned int x86_feature)
> > > > +static __always_inline void guest_cpu_cap_clear(struct kvm_vcpu *vcpu,
> > > > +						unsigned int x86_feature)
> > > >    {
> > > > -	if (kvm_cpu_cap_has(x86_feature) && guest_cpuid_has(vcpu, x86_feature))
> > > > +	unsigned int x86_leaf = __feature_leaf(x86_feature);
> > > > +
> > > > +	reverse_cpuid_check(x86_leaf);
> > > > +	vcpu->arch.cpu_caps[x86_leaf] &= ~__feature_bit(x86_feature);
> > > > +}
> > > > +
> > > > +static __always_inline void guest_cpu_cap_change(struct kvm_vcpu *vcpu,
> > > > +						 unsigned int x86_feature,
> > > > +						 bool guest_has_cap)
> > > > +{
> > > > +	if (guest_has_cap)
> > > >    		guest_cpu_cap_set(vcpu, x86_feature);
> > > > +	else
> > > > +		guest_cpu_cap_clear(vcpu, x86_feature);
> > > > +}
> > > I don't see any necessity to add 3 functions, i.e., guest_cpu_cap_{set, clear, change}, for
> > I want to have equivalents to the cpuid_entry_*() APIs so that we don't end up
> > with two different sets of names.  And the clear() API already has a second user.
> >
> > > guest_cpu_cap update. IMHO one function is enough, e.g,:
> > Hrm, I open coded the OR/AND logic in cpuid_entry_change() to try to force CMOV
> > instead of Jcc.  That honestly seems like a pointless optimization.  I would
> > rather use the helpers, which is less code.
> >
> > > static __always_inline void guest_cpu_cap_update(struct kvm_vcpu *vcpu,
> > >                                                   unsigned int x86_feature,
> > >                                                   bool guest_has_cap)
> > > {
> > >          unsigned int x86_leaf = __feature_leaf(x86_feature);
> > >
> > > reverse_cpuid_check(x86_leaf);
> > >          if (guest_has_cap)
> > >                  vcpu->arch.cpu_caps[x86_leaf] |= __feature_bit(x86_feature);
> > > else
> > >                  vcpu->arch.cpu_caps[x86_leaf] &= ~__feature_bit(x86_feature);
> > > }
> > >
> > > > +
> > > > +static __always_inline void guest_cpu_cap_restrict(struct kvm_vcpu *vcpu,
> > > > +						   unsigned int x86_feature)
> > > > +{
> > > > +	if (!kvm_cpu_cap_has(x86_feature))
> > > > +		guest_cpu_cap_clear(vcpu, x86_feature);
> > > >    }
> > > _restrict is not clear to me for what the function actually does -- it
> > > conditionally clears guest cap depending on KVM support of the feature.
> > >
> > > How about renaming it to guest_cpu_cap_sync()?
> > "sync" isn't correct because it's not synchronizing with KVM's capabilitiy, e.g.
> > the guest capability will remaing unset if the guest CPUID bit is clear but the
> > KVM capability is available.
> >
> > How about constrain()?
> I don't know, just feel we already have guest_cpu_cap_{set, clear, change}, here the name cannot exactly match the behavior of the function, maybe guest_cpu_cap_filter()? But just ignore the nit, up to you to decide the name :-)

How about guest_cpu_cap_kvm_restrict or guest_cpu_cap_kvm_constrain ?

>
>
