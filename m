Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B36B8070DA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378479AbjLFN0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378571AbjLFN0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:26:33 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97707D66
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 05:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701869196; x=1733405196;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wvRatAZPIQq3Q3PGd/WkGxxbZ5rxDQhioWQiZbIj1vg=;
  b=dOP/xAK9HYJSWyFK82Q+RtkzXUoK2C6FjDr0SGyRx24a5+iXHu80D+zh
   2JJCCOxHbJo330wJTVUX1r5oqfKJnjJo1AUeUI6PotsEOr3RxY7zoBppJ
   DFke4lMLVG8W4m22PIxT55C9WnvEKsFzCTjYXM4UM/EDuHnYFHDTb4gyN
   UhREpWloAFS8ONQsCuKawwSZ/dv8kUp5T6PD3vnFM+jmNuwvnQhFnIh1K
   3KnoQJrlHqjxev//CJt7qBlLVJ8R+5onFqoD1/vtoelt528W0JoOQPoQE
   N3DCLo7SeXCRapHmjmi1G12jQIkBuLTPGEi0jYRuRICYA2HUNVlnVR1vc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="930857"
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="930857"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 05:26:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="721084730"
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="721084730"
Received: from eborisov-mobl2.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.46.36])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 05:26:30 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 0618B10A3F5; Wed,  6 Dec 2023 16:26:28 +0300 (+03)
Date:   Wed, 6 Dec 2023 16:26:27 +0300
From:   "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "seanjc@google.com" <seanjc@google.com>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCHv4 06/14] x86/kexec: Keep CR4.MCE set during kexec for TDX
 guest
Message-ID: <20231206132627.5dx4sbgkypgnq6yn@box.shutemov.name>
References: <20231205004510.27164-1-kirill.shutemov@linux.intel.com>
 <20231205004510.27164-7-kirill.shutemov@linux.intel.com>
 <861f583e2550959616e19565235f0debbe27149b.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <861f583e2550959616e19565235f0debbe27149b.camel@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 11:58:45PM +0000, Huang, Kai wrote:
> On Tue, 2023-12-05 at 03:45 +0300, Kirill A. Shutemov wrote:
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
> >  arch/x86/kernel/relocate_kernel_64.S | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> > index 56cab1bb25f5..cd6a53667c6b 100644
> > --- a/arch/x86/kernel/relocate_kernel_64.S
> > +++ b/arch/x86/kernel/relocate_kernel_64.S
> > @@ -145,12 +145,15 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
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
> >  1:
> > +	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %eax), X86_FEATURE_TDX_GUEST
> >  	movq	%rax, %cr4
> >  
> >  	jmp 1f
> 
> Nit:
> 
> It seems <asm/alternative.h> isn't included in relocate_kernel_64.S.  Maybe it's
> better to do it explicitly.
> 
> Maybe even better to explicitly include <linux/stringify.h> too, but I see
> <asm/alternative.h> already does that.

Okay, I will add both.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
