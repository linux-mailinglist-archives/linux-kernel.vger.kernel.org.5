Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5B57FB117
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 06:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343518AbjK1FPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 00:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234613AbjK1FPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 00:15:43 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C631B6;
        Mon, 27 Nov 2023 21:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701148549; x=1732684549;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q/YBiVMqybr/xjOXUiI/x11zIDZy2ZFZBISWrweQNL8=;
  b=RQE1ZP95VC91NmdA1kLtOk1QIDjsurMeTLHCNYaghojosDpftCsGHY1n
   sFoMVx0H+QOXuUmYy0EK/ebMvc2iso2vIzh7n/m1h0nfnQmp2rKHm7t4A
   03UYo9feX29QaYRWh7prAgLK2kUtQ1R3X7Ix1vN1sQMO6wJl7FYgv0nY1
   fT3bjJZdVHOXaoiePnDaj72Iz+p3/D9YlY+7ydN+KhjzE8PCeqk3HrRp+
   3voIExFbWaL3lSD7R3MZZaeaY5k7X4SGLejYZ6N4K191V3Da/WeBLn4bw
   hgJQTEHwKft1mV+6Pn+blpMrBUvES+yqr/kCnfE+yZ3dV5a+CeNFoEBIr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="396755069"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="396755069"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 21:15:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="761835305"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="761835305"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga007.jf.intel.com with ESMTP; 27 Nov 2023 21:15:47 -0800
Date:   Tue, 28 Nov 2023 13:13:46 +0800
From:   Xu Yilun <yilun.xu@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] KVM: x86: Update guest cpu_caps at runtime for
 dynamic CPUID-based features
Message-ID: <ZWV3CoZg7VGBa7za@yilunxu-OptiPlex-7050>
References: <20231110235528.1561679-1-seanjc@google.com>
 <20231110235528.1561679-7-seanjc@google.com>
 <4484647425e2dbf92c76a173b7b14e346f60362d.camel@redhat.com>
 <ZWBDsOJpdi7hWaYV@yilunxu-OptiPlex-7050>
 <ZWU3wTElmiEOUg-I@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWU3wTElmiEOUg-I@google.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 04:43:45PM -0800, Sean Christopherson wrote:
> On Fri, Nov 24, 2023, Xu Yilun wrote:
> > On Sun, Nov 19, 2023 at 07:35:30PM +0200, Maxim Levitsky wrote:
> > > On Fri, 2023-11-10 at 15:55 -0800, Sean Christopherson wrote:
> > > >  static void __kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *entries,
> > > >  				       int nent)
> > > >  {
> > > >  	struct kvm_cpuid_entry2 *best;
> > > > +	struct kvm_vcpu *caps = vcpu;
> > > > +
> > > > +	/*
> > > > +	 * Don't update vCPU capabilities if KVM is updating CPUID entries that
> > > > +	 * are coming in from userspace!
> > > > +	 */
> > > > +	if (entries != vcpu->arch.cpuid_entries)
> > > > +		caps = NULL;
> > > 
> > > I think that this should be decided by the caller. Just a boolean will suffice.
> 
> I strongly disagree.  The _only_ time the caps should be updated is if
> entries == vcpu->arch.cpuid_entries, and if entries == cpuid_entires than the caps
> should _always_ be updated.
> 
> > kvm_set_cpuid() calls this function only to validate/adjust the temporary
> > "entries" variable. While kvm_update_cpuid_runtime() calls it to do system
> > level changes.
> > 
> > So I kind of agree to make the caller fully awared, how about adding a
> > newly named wrapper for kvm_set_cpuid(), like:
> > 
> > 
> >   static void kvm_adjust_cpuid_entry(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *entries,
> > 				     int nent)
> > 
> >   {
> > 	WARN_ON(entries == vcpu->arch.cpuid_entries);
> > 	__kvm_update_cpuid_runtime(vcpu, entries, nent);
> 
> But taking it a step further, we end up with
> 
> 	WARN_ON_ONCE(update_caps != (entries == vcpu->arch.cpuid_entries));
> 
> which is silly since any bugs that would result in the WARN firing can be avoided
> by doing:
> 
> 	update_caps = entries == vcpu->arch.cpuid_entries;
> 
> which eventually distils down to the code I posted.

OK, I agree with you.

My initial idea is to make developers easier to recognize what is
happening by name, without looking into __kvm_update_cpuid_runtime().
But it seems causing other subtle confuse and wastes cycles. Maybe the
comment is already good enough for developers.

Thanks,
Yilun
