Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB31765931
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjG0QvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjG0QvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:51:06 -0400
Received: from mgamail.intel.com (unknown [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C401A1724
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 09:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690476665; x=1722012665;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VQbSdAfRa6FNGL1saufA4UOCxdYGFZ83XlhM2WWqKY4=;
  b=KwUY6JO7XySVoVQWVBQugjsnY7jydlsHAkL6+39orbrIUykTZ5yCzxEI
   wd28F6qRpGr5wkLm+pWFUQgzNmenFTZoW4FcbfKbqhfnhu5DDFHdfYjzk
   j0yWD7EVAVG8yRT/lrcv6eh0Vrou4JL68PSjkgCNHHjln0oo4CNPWsk1j
   ImHDxGkepgkEGyDvYpZVTmBpqTJt1PAWZ4MMOIYtOc8jyZsZPQpr7nr0J
   J95NCENxCq+aro6K141a7QoaHRh9ZqwsRduE6qKzea/mQrO232r2In8jv
   K5Crepybi/dGcm7ge6ppZoHo3jentJzN5mkydxlantGC2jNKJbUM5dT/J
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="371998027"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="371998027"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 09:51:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="756760091"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="756760091"
Received: from lzhiguno-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.37.222])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 09:51:00 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id D2498109503; Thu, 27 Jul 2023 19:50:57 +0300 (+03)
Date:   Thu, 27 Jul 2023 19:50:57 +0300
From:   kirill.shutemov@linux.intel.com
To:     Kai Huang <kai.huang@intel.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, seanjc@google.com,
        pbonzini@redhat.com, isaku.yamahata@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        n.borisov.lkml@gmail.com
Subject: Re: [PATCH v3 06/12] x86/tdx: Extend TDX_MODULE_CALL to support more
 TDCALL/SEAMCALL leafs
Message-ID: <20230727165057.rdn4txmzdh4yorw5@box.shutemov.name>
References: <cover.1690369495.git.kai.huang@intel.com>
 <3d91bb67e17270d6df6c09308861961e04c13921.1690369495.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d91bb67e17270d6df6c09308861961e04c13921.1690369495.git.kai.huang@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 11:25:08PM +1200, Kai Huang wrote:
> @@ -64,6 +103,37 @@
>  .endif
>  
>  .if \ret
> +.if \saved
> +	/*
> +	 * Restore the structure from stack to save the output registers
> +	 *
> +	 * In case of VP.ENTER returns due to TDVMCALL, all registers are
> +	 * valid thus no register can be used as spare to restore the
> +	 * structure from the stack (see "TDH.VP.ENTER Output Operands
> +	 * Definition on TDCALL(TDG.VP.VMCALL) Following a TD Entry").
> +	 * For this case, need to make one register as spare by saving it
> +	 * to the stack and then manually load the structure pointer to
> +	 * the spare register.
> +	 *
> +	 * Note for other TDCALLs/SEAMCALLs there are spare registers
> +	 * thus no need for such hack but just use this for all.
> +	 */
> +	pushq	%rax		/* save the TDCALL/SEAMCALL return code */
> +	movq	8(%rsp), %rax	/* restore the structure pointer */
> +	movq	%rsi, TDX_MODULE_rsi(%rax)	/* save %rsi */
> +	movq	%rax, %rsi	/* use %rsi as structure pointer */

This looks redundant. You get struct in RSI with popq two lines below.

And please use upper case for registers: RSI instead of %rsi.

> +	popq	%rax		/* restore the return code */
> +	popq	%rsi		/* pop the structure pointer */
> +
> +	/* Copy additional output regs to the structure  */
> +	movq %r12, TDX_MODULE_r12(%rsi)
> +	movq %r13, TDX_MODULE_r13(%rsi)
> +	movq %r14, TDX_MODULE_r14(%rsi)
> +	movq %r15, TDX_MODULE_r15(%rsi)
> +	movq %rbx, TDX_MODULE_rbx(%rsi)
> +	movq %rdi, TDX_MODULE_rdi(%rsi)
> +.endif	/* \saved */
> +
>  	/* Copy output registers to the structure */
>  	movq %rcx, TDX_MODULE_rcx(%rsi)
>  	movq %rdx, TDX_MODULE_rdx(%rsi)

Otherwise, looks sane:

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
