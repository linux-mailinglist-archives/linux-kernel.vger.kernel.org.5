Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FE476E5F2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbjHCK6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbjHCK6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:58:18 -0400
Received: from mgamail.intel.com (unknown [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FA52129
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 03:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691060297; x=1722596297;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OFeYZCOnoU+/IO/tSIUv2tG3VRLKkaE9o+9OPWJZ2YQ=;
  b=KDCKLFXDwGhnmQelMxQUKJhOOlOM4B8TvVO/EwNFnsNgIP5TLl+AXSxM
   ITYq/gfSAW3kBeub3yDfbUTlacBUiiOUCplZcVrboDxkm0OaTxfEJsd40
   69EQMkaZVP62jcP2i619QjSkp75WaBPyKoGs8PXiaYydd/t6ONNDu4Jdi
   0wT5pjxzE5StUFDaUVGdxoZDzJ2ciPtAwasUjoMzM/tKVXii2z8rNolxy
   vZIZOaRvkm8E2Khd1vZZp4YoWFlI74hKpIKCbYrkU1E5lGThZ5oNMdbGE
   OmVTO8jHEqgyKPo/0qei0haSwwXnsbDyIFQER2RxIK7SsQYbPK2Hac9S8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="456217617"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="456217617"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 03:58:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="764554234"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="764554234"
Received: from gvarshne-mobl2.gar.corp.intel.com (HELO box.shutemov.name) ([10.252.63.106])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 03:58:13 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 96AE6109FCF; Thu,  3 Aug 2023 13:58:10 +0300 (+03)
Date:   Thu, 3 Aug 2023 13:58:10 +0300
From:   "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "Hansen, Dave" <dave.hansen@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "n.borisov.lkml@gmail.com" <n.borisov.lkml@gmail.com>
Subject: Re: [PATCH v3 05/12] x86/tdx: Pass TDCALL/SEAMCALL input/output
 registers via a structure
Message-ID: <20230803105810.xljd2sjqittqey2w@box.shutemov.name>
References: <cover.1690369495.git.kai.huang@intel.com>
 <fd9886e5fffe5ccccf5895627be2fff209a69049.1690369495.git.kai.huang@intel.com>
 <20230727163630.gcsczhebozgf2tsu@box.shutemov.name>
 <6374fd1aa1e2ff4777eab2421cfc439d259cc603.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6374fd1aa1e2ff4777eab2421cfc439d259cc603.camel@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 10:54:28PM +0000, Huang, Kai wrote:
> On Thu, 2023-07-27 at 19:36 +0300, kirill.shutemov@linux.intel.com wrote:
> > On Wed, Jul 26, 2023 at 11:25:07PM +1200, Kai Huang wrote:
> > > diff --git a/arch/x86/virt/vmx/tdx/tdxcall.S b/arch/x86/virt/vmx/tdx/tdxcall.S
> > > index 6bdf6e137953..a0e7fe81bf63 100644
> > > --- a/arch/x86/virt/vmx/tdx/tdxcall.S
> > > +++ b/arch/x86/virt/vmx/tdx/tdxcall.S
> > > @@ -17,34 +17,33 @@
> > >   *            TDX module and hypercalls to the VMM.
> > >   * SEAMCALL - used by TDX hosts to make requests to the
> > >   *            TDX module.
> > > + *
> > > + *-------------------------------------------------------------------------
> > > + * TDCALL/SEAMCALL ABI:
> > > + *-------------------------------------------------------------------------
> > > + * Input Registers:
> > > + *
> > > + * RAX                 - TDCALL/SEAMCALL Leaf number.
> > > + * RCX,RDX,R8-R9       - TDCALL/SEAMCALL Leaf specific input registers.
> > > + *
> > > + * Output Registers:
> > > + *
> > > + * RAX                 - TDCALL/SEAMCALL instruction error code.
> > > + * RCX,RDX,R8-R11      - TDCALL/SEAMCALL Leaf specific output registers.
> > > + *
> > > + *-------------------------------------------------------------------------
> > 
> > So, you keep the existing asymetry in IN and OUT registers. R10 and R11
> > are OUT-only registers. It can be confusing for user since it is the same
> > structure now. I guess it changes in the following patches, but I would
> > prefer to make them even here if there's no good reason not to.
> > 
> 
> 
> Do you mean you prefer to use R10/R11 as input too even in this patch?

Yes.

> I think _logically_ it should be part of the next patch, because w/o extending
> TDX_MODULE_CALL to support additional TDCALLs/SEAMCALLs, we don't need R10/R11
> as input.  This patch only changes to take a structure as function argument,
> rather than taking individual registers as argument.

As a user, if I see a struct used for in and out, I would expect that all
fields have the same rules.

> Also, we have a comment to say this around the structure too:
> 
>  /*
> - * Used in __tdx_module_call() to gather the output registers' values of the
> + * Used in __tdcall*() to gather the input/output registers' values of the
>   * TDCALL instruction when requesting services from the TDX module. This is a
>   * software only structure and not part of the TDX module/VMM ABI
>   */
> -struct tdx_module_output {
> +struct tdx_module_args {
> +	/* input/output */
>  	u64 rcx;
>  	u64 rdx;
>  	u64 r8;
>  	u64 r9;
> +	/* additional output */
>  	u64 r10;
>  	u64 r11;
>  };
> 
> So to me there should be no confusion.

Do you always read documentation? :P Maybe it is only me...

> Even consider a theoretical case: someone wants to backport this patch to an old
> kernel w/o further patches, then it makes little sense to do R10/R11 in
> TDX_MODULE_CALL here in this patch
> 
> :-)

Consider the case whe the patch was (wrongly) backported to use new call
that uses R10 as input.

I realize that all my objections are rather hand-wavy. I would like to
have in/out symmetry here. But I would not NAK patch over this.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
