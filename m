Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBDA76D9B5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 23:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbjHBVjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 17:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjHBVje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 17:39:34 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A2A2685
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 14:39:33 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bb9e6c2a90so3106025ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 14:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691012373; x=1691617173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GOR/UUscUmKRRObOxgKnpxSCIKDYRTaAaOOrLNDpRfk=;
        b=nn14jokfUUTvSQIi30OhCWpwSRU9QFPK/WFSa8u90hxmfPYp0ICMKWQ+unQh2VyQhh
         v+woiYwLded/gNKp3cxhDKMBQrkOLd6t+GkGBW5EX6ebzZ7vp4Y1eK+1UELj+76BCohx
         ThgvGJgxJa3cf0nkcEAEF3h9JpWSf8WQZsQpOMQHLZWuCRKRyTqwYTAHR7Wfj6tVDRU/
         v7J9vsVVlBxp9oMYa4sYCSgfWpNp1hvWesJYuHWkQZAt60q8j1DSXAla1dQH0F1pT4hW
         bdFXMUHVhC1dzd4nrhQ6MuR1J3vVlkfAwVFgAAoX05/uMekhHwNcwFg72+Fv4FSva9x7
         8utA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691012373; x=1691617173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOR/UUscUmKRRObOxgKnpxSCIKDYRTaAaOOrLNDpRfk=;
        b=N4K74IViqs5N0NqaxTZax/dY7OWOu6Acly8nQ2HKcVsBwEpAoi4rsjvKBbeKvzH/Lb
         qPd8nIwnVajz7C63jUVUpYUuwUGQPJmcxLbFByI6gYY78kp0tTNzfp5qf7Z525PMKHXr
         cE6WQipoP3LywR+mnj6o9+JExgLxEo7btUIGik6nc6g2ZvpyupMpw7klhEcKSyjKiXk4
         0owb9aemOHleIc9O7zCMqudixdi2zCHHuHq87Tw5xjruQWBk5rSp+LayF/eV1TEmWOiX
         O+iwd3Xy9W/ReaR8VdGw4z+yVGzq72VdwPbJ/HK12ZyqSUB05KljwtqB48yo68lyMyyi
         ZsVg==
X-Gm-Message-State: ABy/qLbBgjT2PySzWXtg3w3MSHs6WVXwG2tgV0MIH4XNRR/ZUYaQmGu7
        mlxuXtc0/QIhSKF4CEDO3RQ=
X-Google-Smtp-Source: APBJJlGEqRHkmTdVa9fLCKJYO+bepqc5AzlOMUJmEv5x5f8j7LzJJVWs7YLZb9YjQOCD0J1EyVgijg==
X-Received: by 2002:a17:902:da86:b0:1bc:2437:e54 with SMTP id j6-20020a170902da8600b001bc24370e54mr6924426plx.24.1691012372700;
        Wed, 02 Aug 2023 14:39:32 -0700 (PDT)
Received: from localhost ([192.55.55.51])
        by smtp.gmail.com with ESMTPSA id w5-20020a1709029a8500b001b8a3e2c241sm12851944plp.14.2023.08.02.14.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 14:39:32 -0700 (PDT)
Date:   Wed, 2 Aug 2023 14:39:30 -0700
From:   Isaku Yamahata <isaku.yamahata@gmail.com>
To:     Kai Huang <kai.huang@intel.com>
Cc:     peterz@infradead.org, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com,
        tglx@linutronix.de, bp@alien8.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, seanjc@google.com, pbonzini@redhat.com,
        isaku.yamahata@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        n.borisov.lkml@gmail.com, isaku.yamahata@gmail.com
Subject: Re: [PATCH v3 12/12] x86/virt/tdx: Adjust 'struct tdx_module_args'
 to use x86 "register index" layout
Message-ID: <20230802213930.GB3597003@ls.amr.corp.intel.com>
References: <cover.1690369495.git.kai.huang@intel.com>
 <f61daaaad871e79eabf5ae25f5c4631640ffd288.1690369495.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f61daaaad871e79eabf5ae25f5c4631640ffd288.1690369495.git.kai.huang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 11:25:14PM +1200,
Kai Huang <kai.huang@intel.com> wrote:

> For TDX guest, KVM needs to call __seamcall_saved_ret() to make the
> TDH.VP.ENTER SEAMCALL to enter the guest, possibly taking all registers
> in 'struct tdx_module_args' as input/output.
> 
> KVM caches guest's GPRs in 'kvm_vcpu_arch::regs[]', which follows the
> "register index" hardware layout of x86 GPRs.  On the other hand, the
> __seamcall_saved_ret() takes the pointer of 'struct tdx_module_args' as
> argument, thus there's a mismatch.
> 
> KVM could choose to copy input registers from 'vcpu::regs[]' to a
> 'struct tdx_module_args' and use that as argument to make the SEAMCALL,
> but such memory copy isn't desired and should be avoided if possible.
> 
> It's not feasible to change KVM's 'vcpu::regs[]' layout due to various
> reasons (e.g., emulation code uses decoded register index as array index
> to access the register).  Therefore, adjust 'struct tdx_module_args' to
> match KVM's 'vcpu::regs[]' layout so that KVM can simply do below:
> 
> 	__seamcall_saved_ret(TDH_VP_ENTER,
> 			(struct tdx_module_args *)vcpu->arch.regs);
> 
> Note RAX/RSP/RBP are not used by the TDX_MODULE_CALL assembly, but they
> are necessary in order match the layout of 'struct tdx_module_args' to
> KVM's 'vcpu::regs[]'.  Thus add them to the structure, but name them as
> *_unused.  Also don't include them to asm-offset.c so that any misuse of
> them in the assembly would result in build error.

Maybe we can have static check if the offsets match.
e.g. BUILD_BUG_ON(__VCPU_REGS_RAX * 8 != TDX_MODULE_rax); etc...

Anyway, I can have such a patch in TDX KVM side when I use this function for
TDH.VP.ENTER.

Thansk,


> 
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Isaku Yamahata <isaku.yamahata@intel.com>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Kai Huang <kai.huang@intel.com>
> ---
> 
> v2 -> v3:
>  - New patch
> 
> ---
>  arch/x86/include/asm/shared/tdx.h | 19 +++++++++++++------
>  arch/x86/kernel/asm-offsets.c     |  6 +++---
>  2 files changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
> index 74fc466dfdcd..8d1427562c63 100644
> --- a/arch/x86/include/asm/shared/tdx.h
> +++ b/arch/x86/include/asm/shared/tdx.h
> @@ -58,24 +58,31 @@
>   * Used in __tdcall*() to gather the input/output registers' values of the
>   * TDCALL instruction when requesting services from the TDX module. This is a
>   * software only structure and not part of the TDX module/VMM ABI
> + *
> + * Note those *_unused are not used by the TDX_MODULE_CALL assembly.
> + * The layout of this structure also matches KVM's kvm_vcpu_arch::regs[]
> + * layout, which follows the "register index" order of x86 GPRs.  KVM
> + * then can simply type cast kvm_vcpu_arch::regs[] to this structure to
> + * avoid the extra memory copy between two structures when making
> + * TDH.VP.ENTER SEAMCALL.
>   */
>  struct tdx_module_args {
> -	/* callee-clobbered */
> +	u64 rax_unused;
>  	u64 rcx;
>  	u64 rdx;
> +	u64 rbx;
> +	u64 rsp_unused;
> +	u64 rbp_unused;
> +	u64 rsi;
> +	u64 rdi;
>  	u64 r8;
>  	u64 r9;
> -	/* extra callee-clobbered */
>  	u64 r10;
>  	u64 r11;
> -	/* callee-saved + rdi/rsi */
>  	u64 r12;
>  	u64 r13;
>  	u64 r14;
>  	u64 r15;
> -	u64 rbx;
> -	u64 rdi;
> -	u64 rsi;
>  };
>  
>  /* Used to communicate with the TDX module */
> diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
> index 6913b372ccf7..e4ad822d3acd 100644
> --- a/arch/x86/kernel/asm-offsets.c
> +++ b/arch/x86/kernel/asm-offsets.c
> @@ -70,6 +70,9 @@ static void __used common(void)
>  	BLANK();
>  	OFFSET(TDX_MODULE_rcx, tdx_module_args, rcx);
>  	OFFSET(TDX_MODULE_rdx, tdx_module_args, rdx);
> +	OFFSET(TDX_MODULE_rbx, tdx_module_args, rbx);
> +	OFFSET(TDX_MODULE_rsi, tdx_module_args, rsi);
> +	OFFSET(TDX_MODULE_rdi, tdx_module_args, rdi);
>  	OFFSET(TDX_MODULE_r8,  tdx_module_args, r8);
>  	OFFSET(TDX_MODULE_r9,  tdx_module_args, r9);
>  	OFFSET(TDX_MODULE_r10, tdx_module_args, r10);
> @@ -78,9 +81,6 @@ static void __used common(void)
>  	OFFSET(TDX_MODULE_r13, tdx_module_args, r13);
>  	OFFSET(TDX_MODULE_r14, tdx_module_args, r14);
>  	OFFSET(TDX_MODULE_r15, tdx_module_args, r15);
> -	OFFSET(TDX_MODULE_rbx, tdx_module_args, rbx);
> -	OFFSET(TDX_MODULE_rdi, tdx_module_args, rdi);
> -	OFFSET(TDX_MODULE_rsi, tdx_module_args, rsi);
>  
>  	BLANK();
>  	OFFSET(BP_scratch, boot_params, scratch);
> -- 
> 2.41.0
> 

-- 
Isaku Yamahata <isaku.yamahata@gmail.com>
