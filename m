Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC1C77148B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 13:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjHFLgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 07:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjHFLgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 07:36:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2F5E50
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 04:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691321790; x=1722857790;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RVfY0qb92YebdO6s2G7/O+6R8y5wKzyTuLAlDzxgii4=;
  b=GuY7Nxqf3N4LgiRRm3JSQFd3zIjcWSHTZXB/R/7n2C/WsFfpsJEv8t4W
   9YRKy6XaTd2nRuSW7ETX6/GlsuYXSFoNaVI2n3IOGSplIkSvOpxxxxwdQ
   E0+fy9z/0Vl2uWxMxbuL9NA/f50uq3RWavgs9kctTAr+qfW5i1Te0uAJ8
   EhzdZZp1KOUYpGeVR1R5kJFoll/w+SaKPuzS4Ch8C3IezpuDPJLO/jocj
   2WcmNrpt72K/qZdcQzlgOlvamz5KpfxIZUGKFwJIwiDGk70+yDG7n4EGX
   KYbU93CanHPJSUtkT8gTNWH0R4Jyd9glfNxXPjtga91JCco8CWvcbaWao
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10793"; a="374037103"
X-IronPort-AV: E=Sophos;i="6.01,259,1684825200"; 
   d="scan'208";a="374037103"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2023 04:36:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10793"; a="724206052"
X-IronPort-AV: E=Sophos;i="6.01,259,1684825200"; 
   d="scan'208";a="724206052"
Received: from mvalka-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.63.122])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2023 04:36:26 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id C914110A117; Sun,  6 Aug 2023 14:36:23 +0300 (+03)
Date:   Sun, 6 Aug 2023 14:36:23 +0300
From:   kirill.shutemov@linux.intel.com
To:     Kai Huang <kai.huang@intel.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, seanjc@google.com,
        pbonzini@redhat.com, isaku.yamahata@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        n.borisov.lkml@gmail.com
Subject: Re: [PATCH v3 10/12] x86/virt/tdx: Wire up basic SEAMCALL functions
Message-ID: <20230806113623.f7am5levfsllpko7@box.shutemov.name>
References: <cover.1690369495.git.kai.huang@intel.com>
 <b57460d1d12d1f6eac9073cefd6976812b1eef5f.1690369495.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b57460d1d12d1f6eac9073cefd6976812b1eef5f.1690369495.git.kai.huang@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 11:25:12PM +1200, Kai Huang wrote:
> Intel Trust Domain Extensions (TDX) protects guest VMs from malicious
> host and certain physical attacks.  A CPU-attested software module
> called 'the TDX module' runs inside a new isolated memory range as a
> trusted hypervisor to manage and run protected VMs.
> 
> TDX introduces a new CPU mode: Secure Arbitration Mode (SEAM).  This
> mode runs only the TDX module itself or other code to load the TDX
> module.
> 
> The host kernel communicates with SEAM software via a new SEAMCALL
> instruction.  This is conceptually similar to a guest->host hypercall,
> except it is made from the host to SEAM software instead.  The TDX
> module establishes a new SEAMCALL ABI which allows the host to
> initialize the module and to manage VMs.
> 
> The SEAMCALL ABI is very similar to the TDCALL ABI and leverages much
> TDCALL infrastructure.  Wire up basic functions to make SEAMCALLs for
> the basic support of running TDX guests: __seamcall(), __seamcall_ret(),
> and __seamcall_saved_ret() for TDH.VP.ENTER.  All SEAMCALLs involved in
> the basic TDX support don't use "callee-saved" registers as input and
> output, except the TDH.VP.ENTER.
> 
> To start to support TDX, create a new arch/x86/virt/vmx/tdx/tdx.c for
> TDX host kernel support.  Add a new Kconfig option CONFIG_INTEL_TDX_HOST
> to opt-in TDX host kernel support (to distinguish with TDX guest kernel
> support).  So far only KVM uses TDX.  Make the new config option depend
> on KVM_INTEL.
> 
> Signed-off-by: Kai Huang <kai.huang@intel.com>
> ---
> 
> v2 -> v3:
>  - Added __seamcall_saved_ret() back for TDH.VP.ENTER, given the new
>    patch to adjust 'struct tdx_module_args' layout.
> 
> v1 -> v2:
>  - Removed __seamcall_saved_ret() and leave it to KVM TDX patches.
> 
> ---
>  arch/x86/Kconfig                 | 12 +++++++
>  arch/x86/Makefile                |  2 ++
>  arch/x86/include/asm/tdx.h       |  7 ++++
>  arch/x86/virt/Makefile           |  2 ++
>  arch/x86/virt/vmx/Makefile       |  2 ++
>  arch/x86/virt/vmx/tdx/Makefile   |  2 ++
>  arch/x86/virt/vmx/tdx/seamcall.S | 61 ++++++++++++++++++++++++++++++++
>  7 files changed, 88 insertions(+)
>  create mode 100644 arch/x86/virt/Makefile
>  create mode 100644 arch/x86/virt/vmx/Makefile
>  create mode 100644 arch/x86/virt/vmx/tdx/Makefile
>  create mode 100644 arch/x86/virt/vmx/tdx/seamcall.S
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 7422db409770..0558dd98abd7 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1949,6 +1949,18 @@ config X86_SGX
>  
>  	  If unsure, say N.
>  
> +config INTEL_TDX_HOST
> +	bool "Intel Trust Domain Extensions (TDX) host support"
> +	depends on CPU_SUP_INTEL
> +	depends on X86_64
> +	depends on KVM_INTEL

Hm. I expected KVM_INTEL to depend on CPU_SUP_INTEL, but apparently no.
Any reasons why?

Anyway, it is not strictly related to the patch:

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
