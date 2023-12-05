Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C30F804B4D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 08:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344653AbjLEHmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 02:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjLEHmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 02:42:54 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC20CB;
        Mon,  4 Dec 2023 23:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701762181; x=1733298181;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5BLpeg1zQZZFm/fBxeDnZyk9jgSN4wg235qq8tQYVJo=;
  b=gZNtTAI+sd0F1PeZafKFm8M2ILIZCOQImvtVNv4OVdiTmQbYJDe5zdM7
   ry3DAmFhJD1gXAP5kkYJHn46PXzBDleEWMNVw3OnKIJrnMYDbm4pH37KP
   Nb9YteSjM1o1l/IutpTBGu5QLL7k8xAnk+iiyNCxN1MG8Che/cGDs2Th1
   C3UOaXnHRw/40iErREH4GTfe8Q4XOHGitJiqKYs1Ihe71FeKEIIQ/PTVF
   Uwm8Zk/3sWsy0rQeLiM6ugCfDTEUOjeMuBYmua8eKLKf8+0F2stpkf2dx
   DOfCNuSpA8ryKccP993MOcwlL0GUBZej34oko5E/8Mx955DW7ZIDnpYcr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="7198006"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="7198006"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 23:43:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="894281062"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="894281062"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.238.10.126]) ([10.238.10.126])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 23:42:57 -0800
Message-ID: <821ab3f0-9ae6-40b3-b84e-fedd0f126aa8@linux.intel.com>
Date:   Tue, 5 Dec 2023 15:42:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 003/116] KVM: x86/vmx: Refactor KVM VMX module
 init/exit functions
To:     isaku.yamahata@intel.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        isaku.yamahata@gmail.com, Paolo Bonzini <pbonzini@redhat.com>,
        erdemaktas@google.com, Sean Christopherson <seanjc@google.com>,
        Sagi Shahar <sagis@google.com>,
        David Matlack <dmatlack@google.com>,
        Kai Huang <kai.huang@intel.com>,
        Zhi Wang <zhi.wang.linux@gmail.com>, chen.bo@intel.com,
        hang.yuan@intel.com, tina.zhang@intel.com
References: <cover.1699368322.git.isaku.yamahata@intel.com>
 <c47511dcfce73eede575cbd9463b3b0f584d0bf8.1699368322.git.isaku.yamahata@intel.com>
From:   Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <c47511dcfce73eede575cbd9463b3b0f584d0bf8.1699368322.git.isaku.yamahata@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/2023 10:55 PM, isaku.yamahata@intel.com wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
>
> Currently, KVM VMX module initialization/exit functions are a single
> function each.  Refactor KVM VMX module initialization functions into KVM
> common part and VMX part so that TDX specific part can be added cleanly.
> Opportunistically refactor module exit function as well.
>
> The current module initialization flow is,
> 0.) Check if VMX is supported,
> 1.) hyper-v specific initialization,
> 2.) system-wide x86 specific and vendor specific initialization,
> 3.) Final VMX specific system-wide initialization,
> 4.) calculate the sizes of VMX kvm structure and VMX vcpu structure,
> 5.) report those sizes to the KVM common layer and KVM common
>      initialization
>
> Refactor the KVM VMX module initialization function into functions with a
> wrapper function to separate VMX logic in vmx.c from a file, main.c, common
> among VMX and TDX.  Introduce a wrapper function for vmx_init().
>
> The KVM architecture common layer allocates struct kvm with reported size
> for architecture-specific code.  The KVM VMX module defines its structure
> as struct vmx_kvm { struct kvm; VMX specific members;} and uses it as
> struct vmx kvm.  Similar for vcpu structure. TDX KVM patches will define
> TDX specific kvm and vcpu structures.
>
> The current module exit function is also a single function, a combination
> of VMX specific logic and common KVM logic.  Refactor it into VMX specific
> logic and KVM common logic.  This is just refactoring to keep the VMX
> specific logic in vmx.c from main.c.
>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> ---
>   arch/x86/kvm/vmx/main.c    | 50 +++++++++++++++++++++++++++++++++++
>   arch/x86/kvm/vmx/vmx.c     | 54 +++++---------------------------------
>   arch/x86/kvm/vmx/x86_ops.h | 13 ++++++++-
>   3 files changed, 68 insertions(+), 49 deletions(-)
>
[...]
> diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
> index 4af1b01aa9c0..c4e3ae971f94 100644
> --- a/arch/x86/kvm/vmx/x86_ops.h
> +++ b/arch/x86/kvm/vmx/x86_ops.h
> @@ -6,11 +6,22 @@
>   
>   #include "x86.h"
>   
> -__init int vmx_hardware_setup(void);
> +#if IS_ENABLED(CONFIG_HYPERV)
> +__init void hv_init_evmcs(void);
> +void hv_reset_evmcs(void);
> +#else /* IS_ENABLED(CONFIG_HYPERV) */
> +static inline void hv_init_evmcs(void) {}

Does this one need "__init"?
Though it's empty, I checked exist kernel code, other empty static 
inline ones
add "__init" for init code.

> +static inline void hv_reset_evmcs(void) {}
> +#endif /* IS_ENABLED(CONFIG_HYPERV) */
> +
> +bool kvm_is_vmx_supported(void);
> +int __init vmx_init(void);
> +void vmx_exit(void);
>   
>   extern struct kvm_x86_ops vt_x86_ops __initdata;
>   extern struct kvm_x86_init_ops vt_init_ops __initdata;
>   
> +__init int vmx_hardware_setup(void);
>   void vmx_hardware_unsetup(void);
>   int vmx_check_processor_compat(void);
>   int vmx_hardware_enable(void);

