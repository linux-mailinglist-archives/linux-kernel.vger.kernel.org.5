Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3946276D99A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 23:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbjHBVc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 17:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbjHBVck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 17:32:40 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A0C1FCF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 14:32:38 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-686efb9ee3cso232027b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 14:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691011957; x=1691616757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/dN0K92GwZDnss3Z1rNkD5cq532ZZnuHh5W9ax9NB7Q=;
        b=oM5KoRFO7f68P/JfDlbR5/A7xWWkXEULxOOahlM5t+b083j6fZFdZJbZxNOUbt0LKD
         G6vq9lfMJtaXeFla/KJu+tHBHdAD07/pb8KRphMDHQQlFgbWbpzZ3yPUsKpOfR4PjlkB
         AMrrerMCMqgQZZIhT12RWhvAX8pzYSHjYuNyFshhqsiA8+OCimkYC2FTK5zTec8R7Cdp
         f1OnbVDO1r+9L3tWnvrKdaAS0eSO5rtFPCYuVd87ItXVN/opgI1DoWDOQHO0APwBur48
         rjSxOqF54Wl/vhvdFFvNFmIx1qk9ThU9Km2iiytbeZo0RdF5tiVWucc9IQMEHn9ZyKA7
         rWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691011957; x=1691616757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dN0K92GwZDnss3Z1rNkD5cq532ZZnuHh5W9ax9NB7Q=;
        b=JQjguzjLs6rhUohpCIR0tRA1ViBc1TIe2AW9z15h236u6EyAlhlbSoDG2s8X+7F+y+
         zby5FU5+J6PnRKstKMGTL4/wcBvpknB0x+Um9PnOU3jwVj7cn8AOhWymDmgEigZDAa4P
         geSmBcaHvllD4dShnTt+4vp+jb8ZjHsLbHvIuDBsk3ag6ou97JY+bBGZskOpGklmJ+2J
         usIUUNPKImgxRDiEMGTuj/jQ/EnfxbQX58psDNPiZp7lmEVvPIGyr5Q1X43E676m8wE9
         CvByX3LKcfNw/05hmo9jcWNbQ1rW09+WdFanLAR8IBhMxYXK3o+a7uz37ET4F1g1+dWR
         /iRw==
X-Gm-Message-State: ABy/qLbFdc5rzx2o3pl8bYp2adrg/4+JQPyogzgfDdldk0YqbRT/w+5U
        A9e5YI+OLitpZvaYKyvS/ag=
X-Google-Smtp-Source: APBJJlHxxkH0M3qhu+RsWIJ9BF5XBg54rN03Tv+X9ALXQkKmbBOwCJ1QwvMyTY9bxDwxodmqaPJmug==
X-Received: by 2002:a05:6a00:8c9:b0:657:bdf1:cce1 with SMTP id s9-20020a056a0008c900b00657bdf1cce1mr20193895pfu.25.1691011957184;
        Wed, 02 Aug 2023 14:32:37 -0700 (PDT)
Received: from localhost ([192.55.55.51])
        by smtp.gmail.com with ESMTPSA id j24-20020aa79298000000b006765cb3255asm11498051pfa.68.2023.08.02.14.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 14:32:36 -0700 (PDT)
Date:   Wed, 2 Aug 2023 14:32:35 -0700
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
Message-ID: <20230802213235.GA3597003@ls.amr.corp.intel.com>
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

I replaced the current TDX KVM TDH.VP.ENTER with this function and it worked.

Test-by: Isaku Yamahata <isaku.yamahata@intel.com>
-- 
Isaku Yamahata <isaku.yamahata@gmail.com>
