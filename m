Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97A07EC336
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343861AbjKONDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343723AbjKONDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:03:20 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92215120
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 05:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700053397; x=1731589397;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E4dKQNl6OtXKCpQsl6Lr+xytDUybE96dRWIvxmvWFcQ=;
  b=kD0XpaSD899C7vo4Ps4xX9s2scd/vyLqxVdcdnZ2/DRkiWmnctYuDBxX
   xck4AjljG9TWettoc8bDLQAgHrE94DCGwdq4uU5TfYoExNnHI3L2y6tpP
   lmTz2ysIlwYSY3geTFpH3O7uHWCody7WPRX6V7fPQc0q4USdrp8LyA/rS
   FXQcXIgGIhid00+hhnq5z6aEr960iePmqQesRrB1u+CcSyd73mBqJYV5C
   hqAstNff3zdbH4IWDRDI+WR9YNO4UUKgFIIdX47ij8Da4fPjDcwAiO/P7
   AO7r8EwE/uTy0+tD7ZVednqadxV4tviiyEBqvIXueiyn9aCQ7jVm7m2RX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="477091535"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="477091535"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 05:03:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="835391248"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="835391248"
Received: from mituomis-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.44.135])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 05:03:09 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id EE156109F3E; Wed, 15 Nov 2023 16:03:06 +0300 (+03)
Date:   Wed, 15 Nov 2023 16:03:06 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
        kexec@lists.infradead.org, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 06/14] x86/kexec: Keep CR4.MCE set during kexec for TDX
 guest
Message-ID: <20231115130306.kmhaqsfpzi3gkpik@box.shutemov.name>
References: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
 <20231115120044.8034-7-kirill.shutemov@linux.intel.com>
 <20231115122343.GA8262@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115122343.GA8262@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 01:23:43PM +0100, Peter Zijlstra wrote:
> On Wed, Nov 15, 2023 at 03:00:36PM +0300, Kirill A. Shutemov wrote:
> > TDX guests are not allowed to clear CR4.MCE. Attempt to clear it leads
> > to #VE.
> > 
> > Use alternatives to keep the flag during kexec for TDX guests.
> > 
> > The change doesn't affect non-TDX-guest environments.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Reviewed-by: Kai Huang <kai.huang@intel.com>
> > ---
> >  arch/x86/kernel/relocate_kernel_64.S | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> > index 56cab1bb25f5..bea89814b48e 100644
> > --- a/arch/x86/kernel/relocate_kernel_64.S
> > +++ b/arch/x86/kernel/relocate_kernel_64.S
> > @@ -145,11 +145,16 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
> >  	 * Set cr4 to a known state:
> >  	 *  - physical address extension enabled
> >  	 *  - 5-level paging, if it was enabled before
> > +	 *  - Machine check exception on TDX guest. Clearing MCE is not allowed
> > +	 *    in TDX guests.
> >  	 */
> >  	movl	$X86_CR4_PAE, %eax
> >  	testq	$X86_CR4_LA57, %r13
> >  	jz	1f
> >  	orl	$X86_CR4_LA57, %eax
> > +1:
> > +	ALTERNATIVE "jmp 1f", "", X86_FEATURE_TDX_GUEST
> > +	orl	$X86_CR4_MCE, %eax
> >  1:
> 
> 	ALTERNATIVE "", "orl $X86_CR4_MCE, %eax", X86_FEATURE_TDX_GUEST
> 
> ?

Oh. Right. Silly me.

Will fix.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
