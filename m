Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C529E76545E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 14:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbjG0Mws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 08:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbjG0Mwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 08:52:45 -0400
Received: from mgamail.intel.com (unknown [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE8F30F5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 05:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690462355; x=1721998355;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xdmorQCsvmFoTjnMQhtfItQu6FGCJSdV+4MH8eG8AEY=;
  b=LaMTTgWqZEc4wETm10II/gLuJLr8tMTYIcRHAEZbnGWnza9WuwjNXBIL
   gpn18ljk/j8/r7o6yp4c3idfudeWKwuCjPMMfGyvX41XIfjXXj/PFT0Gv
   xNa4Q87/8beff9e7tyCkNiTVF1jU/+xkj4RgoElYaAn/0nUqz0Reo/95e
   RPLtJgucOaW+oHcJg6G8jkZpF9d16BUmlzOz7823veeXRvL/5CevkXHiu
   Pq6RnOIzrmpokeh2aSLHowOOPKRL28pF3FwXsL8CpNfBRAVzdZpTtwvoE
   z4Zq2Ok8Vf3DITkLDOYUWl/oIprLaPti8NZDDMtlj9I1iFYcwMS75HXVo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="399233367"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="399233367"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 05:52:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="900873326"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="900873326"
Received: from lzhiguno-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.37.222])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 05:52:31 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 94F15109503; Thu, 27 Jul 2023 15:52:28 +0300 (+03)
Date:   Thu, 27 Jul 2023 15:52:28 +0300
From:   kirill.shutemov@linux.intel.com
To:     Kai Huang <kai.huang@intel.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, seanjc@google.com,
        pbonzini@redhat.com, isaku.yamahata@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        n.borisov.lkml@gmail.com
Subject: Re: [PATCH v3 02/12] x86/tdx: Skip saving output regs when SEAMCALL
 fails with VMFailInvalid
Message-ID: <20230727125228.rtayk33s3diflqkm@box.shutemov.name>
References: <cover.1690369495.git.kai.huang@intel.com>
 <a825cbf3d8b7f994330ce8c4481ac750d2935cf7.1690369495.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a825cbf3d8b7f994330ce8c4481ac750d2935cf7.1690369495.git.kai.huang@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 11:25:04PM +1200, Kai Huang wrote:
> If SEAMCALL fails with VMFailInvalid, the SEAM software (e.g., the TDX
> module) won't have chance to set any output register.  Skip saving the
> output registers to the structure in this case.
> 
> Also, as '.Lno_output_struct' is the very last symbol before RET, rename
> it to '.Lout' to make it short.
> 
> Opportunistically make the asm directives unindented.
> 
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Kai Huang <kai.huang@intel.com>
> ---
> 
> v2 -> v3:
>  - No change.
> 
> v1 -> v2:
>  - A new patch to improve SEAMCALL VMFailInvalid failure, with v1 patch
>    "x86/tdx: Move FRAME_BEGIN/END to TDX_MODULE_CALL asm macro" merged.
> 
> ---
>  arch/x86/coco/tdx/tdcall.S      |  3 ---
>  arch/x86/virt/vmx/tdx/tdxcall.S | 29 ++++++++++++++++++++---------
>  2 files changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/coco/tdx/tdcall.S b/arch/x86/coco/tdx/tdcall.S
> index 2eca5f43734f..e5d4b7d8ecd4 100644
> --- a/arch/x86/coco/tdx/tdcall.S
> +++ b/arch/x86/coco/tdx/tdcall.S
> @@ -78,10 +78,7 @@
>   * Return status of TDCALL via RAX.
>   */
>  SYM_FUNC_START(__tdx_module_call)
> -	FRAME_BEGIN
>  	TDX_MODULE_CALL host=0
> -	FRAME_END
> -	RET
>  SYM_FUNC_END(__tdx_module_call)
>  

Do we still need to include asm/frame.h after the change?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
