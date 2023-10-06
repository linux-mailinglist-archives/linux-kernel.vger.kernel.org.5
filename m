Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E707BBB64
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 17:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbjJFPMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 11:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbjJFPMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 11:12:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B474CDE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 08:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696605120; x=1728141120;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fjbIAXrWpPm5Y8Alw4dLyHvY0cP22rX9Piu85LI1l5Y=;
  b=BDF7ixhwfSMFPPeSRyJAr1nBOdAZ0DBTBh/6rHEiYP1dPT4daKoQMKEx
   b384Bb9hShyyTVBxyFdp3vFRQls0jExDJvP4Z0B0a5YB5/Ddca1V7h8tw
   WejuyPYWqDZzrKwDhIRg36WcsZvdmx/SFThc4XEZH5TGkKBtJ3C1q3Qgg
   +/IxK34EQu2KlQ5T20uYmnPy/wh5oXo4CUkERFcHeBIJ27ltKMBtX7/5c
   38CtAeVMF4FGn2imXFUM68wlFyBmC6UjTwLtVrj9bHwmWkDdWPI1i6QkA
   D3aB+E5P568l+23HTidQ6iKBuDSxPjy2pWh/PjvaBGwRM8APzxypz7zZW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="470035254"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="470035254"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 08:11:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="702081581"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="702081581"
Received: from kvsudesh-mobl1.gar.corp.intel.com (HELO box.shutemov.name) ([10.251.222.76])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 08:11:54 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id AD52C10A172; Fri,  6 Oct 2023 18:11:51 +0300 (+03)
Date:   Fri, 6 Oct 2023 18:11:51 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        kexec@lists.infradead.org, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Kalra, Ashish" <ashish.kalra@amd.com>
Subject: Re: [PATCH 10/13] x86/tdx: Convert shared memory back to private on
 kexec
Message-ID: <20231006151151.2m6t7fcu36hlrtzj@box.shutemov.name>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <20231005131402.14611-11-kirill.shutemov@linux.intel.com>
 <ZSAge6W4vF6ePudw@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSAge6W4vF6ePudw@google.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 07:58:03AM -0700, Sean Christopherson wrote:
> On Thu, Oct 05, 2023, Kirill A. Shutemov wrote:
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 7368d254d01f..b5acf9fb4c70 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -884,6 +884,7 @@ config INTEL_TDX_GUEST
> >  	select X86_MEM_ENCRYPT
> >  	select X86_MCE
> >  	select UNACCEPTED_MEMORY
> > +	select EMERGENCY_VIRT_CALLBACK
> >  	help
> >  	  Support running as a guest under Intel TDX.  Without this support,
> >  	  the guest kernel can not boot or run under TDX.
> 
> ...
> 
> >  void __init tdx_early_init(void)
> >  {
> >  	struct tdx_module_args args = {
> > @@ -882,6 +1007,14 @@ void __init tdx_early_init(void)
> >  	 */
> >  	x86_cpuinit.parallel_bringup = false;
> >  
> > +	machine_ops.shutdown = tdx_shutdown;
> > +
> > +	/*
> > +	 * KVM overrides machine_ops.crash_shutdown, use emergency
> 
> This is going to be super confusing.  KVM utilizes the emergency virt callback.
> The KVM paravirt guest code uses .crash_shutdown().  People that are passingly
> familiar with virt and know what KVM is, but don't already know the difference
> between the two are going to be all kinds of confused.
> 
> I also feel like you're playing with fire, e.g. what's to stop the hypervisor
> specific paravirt guest support from using .shutdown() in the future?
> 
> And the callback is invoked for far more than just kexec().  I don't see how the
> host can emulate a reboot without destroying and rebuilding the VM, e.g. it can't
> stuff register state to emulate INIT or RESET.  Unless I'm missing something,
> converting shared memory back to private for a shutdown or reboot is undesirable
> as adds one more thing that can go wrong and prevent the system from cleanly
> shutting down ASAP (for some definitions of "cleanly").

Okay, fair enough. I will look for better way to hookup into kexec
process. That was the best fit I found so far, but yes it is not ideal.

> Lastly, doesn't SEV need similar behavior?  This seems like core functionality
> for any guest with cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT).  Why not make the
> "unshare on kexec" code common and gate it with CC_ATTR_GUEST_MEM_ENCRYPT?

I don't know SEV specifics. I am open to collaboration on this.

Tom, Ashish, let me know if you need this in generic code. I can arrange
that.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
