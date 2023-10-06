Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728FD7BBACF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbjJFOu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbjJFOuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:50:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AC3A6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 07:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696603824; x=1728139824;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W/51r4qVWeOrP4iJgr+qcAMJuEyFjcjduXqKxwHzQXk=;
  b=dkBtcnRypc7QSXw5FRBmtgV/OEHYQgytM/ms7aXsuAm9DLiorHiY0Eo4
   sCAHqUVhGEdlooACGmTMyAGDA/bSEcasW+BaF/QkJVY++0NAt64y24xh4
   1H1y4iK5qXXT4WaqwqmmIZRCmHyLULfwx/1mrHFh8Lh3ihoJKIifiEMif
   IZ30qNISK7wUQIOdeIictw8tpHjJ1QmtzVMwDqRtc23VMaoky9SzYBsOW
   06vb04WP7QlhfW2L114BTnYSKXE4TP2So+FXEV4FjjdnVQWoSXaEvHQ9G
   cENkbdSZvLOPyLRwjhUPfnITWMN3UxYN8pk0NZWY3jYJtTPinptWydKj3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="374108526"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="374108526"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 07:50:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="781680129"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="781680129"
Received: from kvsudesh-mobl1.gar.corp.intel.com (HELO box.shutemov.name) ([10.251.222.76])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 07:50:19 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 236CC10A172; Fri,  6 Oct 2023 17:50:17 +0300 (+03)
Date:   Fri, 6 Oct 2023 17:50:17 +0300
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
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 04/13] x86/kvm: Do not try to disable kvmclock if it was
 not enabled
Message-ID: <20231006145017.26q2quuiup2emodp@box.shutemov.name>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <20231005131402.14611-5-kirill.shutemov@linux.intel.com>
 <ZSAbhk7fu_w3ClOv@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSAbhk7fu_w3ClOv@google.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 07:36:54AM -0700, Sean Christopherson wrote:
> +Paolo
> 
> Please use get_maintainers...

Will do, sorry.

> On Thu, Oct 05, 2023, Kirill A. Shutemov wrote:
> > kvm_guest_cpu_offline() tries to disable kvmclock regardless if it is
> > present in the VM. It leads to write to a MSR that doesn't exist on some
> > configurations, namely in TDX guest:
> > 
> > 	unchecked MSR access error: WRMSR to 0x12 (tried to write 0x0000000000000000)
> > 	at rIP: 0xffffffff8110687c (kvmclock_disable+0x1c/0x30)
> > 
> > kvmclock enabling is gated by CLOCKSOURCE and CLOCKSOURCE2 KVM paravirt
> > features.
> > 
> > Do not disable kvmclock if it was not enumerated or disabled by user
> > from kernel command line.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Fixes: c02027b5742b ("x86/kvm: Disable kvmclock on all CPUs on shutdown")
> > ---
> >  arch/x86/kernel/kvmclock.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> > index fb8f52149be9..cba2e732e53f 100644
> > --- a/arch/x86/kernel/kvmclock.c
> > +++ b/arch/x86/kernel/kvmclock.c
> > @@ -22,7 +22,7 @@
> >  #include <asm/x86_init.h>
> >  #include <asm/kvmclock.h>
> >  
> > -static int kvmclock __initdata = 1;
> > +static int kvmclock __ro_after_init = 1;
> >  static int kvmclock_vsyscall __initdata = 1;
> >  static int msr_kvm_system_time __ro_after_init = MSR_KVM_SYSTEM_TIME;
> >  static int msr_kvm_wall_clock __ro_after_init = MSR_KVM_WALL_CLOCK;
> > @@ -195,7 +195,12 @@ static void kvm_setup_secondary_clock(void)
> >  
> >  void kvmclock_disable(void)
> >  {
> > -	native_write_msr(msr_kvm_system_time, 0, 0);
> > +	if (!kvm_para_available() || !kvmclock)
> > +		return;
> > +
> > +	if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE) ||
> > +	    kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE2))
> > +		native_write_msr(msr_kvm_system_time, 0, 0);
> 
> Rather than recheck everything and preserve kvmclock, what about leaving the MSR
> indices '0' by default and then disable msr_kvm_system_time iff it's non-zero.
> That way the disable path won't become stale if the conditions for enabling
> kvmclock change.

Okay, works for me too.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
