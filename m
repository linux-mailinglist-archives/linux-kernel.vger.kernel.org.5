Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42F975C0AE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjGUICS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjGUICN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:02:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E169273D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CfpbDS6mH/LiuCWqxWnQefda8HOLpcuvttHDylS3Diw=; b=VqTFTAeoCsscwWrAE/WJHnZKdS
        rOoLmvzb476L27MR911/DawxvLh59G4EJiSDT22TL/e8abkdLnD8yuBCv2lXgiSPNNS+xGYW2I5e0
        aI9WWvDfR+ye6b1vWigjbcv9qis08rof9FGLv196+fZVpDD1tGwGLRLI0aU59bfOksmjF/o3eTQH5
        4nwiYW+4XdxXPo0ESZqMxvbcGtXR+b5zNVswz8ZAO2qJ2f8JjXoGhsWLL+v2TUqPgKTuBbsIHf8gT
        A0fKI+OmeYeqcKY4QnEz9vW6J1CRfC3CvHXxNttwR5Qf3ImS2mI7pXkxAe/6CfgByarnxLvO/DkWo
        DGOySfqA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qMl5H-000uXM-SY; Fri, 21 Jul 2023 08:01:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AC1BE3001E7;
        Fri, 21 Jul 2023 10:01:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 950AA314DED75; Fri, 21 Jul 2023 10:01:55 +0200 (CEST)
Date:   Fri, 21 Jul 2023 10:01:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "n.borisov.lkml@gmail.com" <n.borisov.lkml@gmail.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v2 07/11] x86/tdx: Make TDX_HYPERCALL asm similar to
 TDX_MODULE_CALL
Message-ID: <20230721080155.GB3630545@hirez.programming.kicks-ass.net>
References: <cover.1689855280.git.kai.huang@intel.com>
 <11e9ef9994640c4bb8c00fe133abc7550171208e.1689855280.git.kai.huang@intel.com>
 <152cfe1f60a9f90a3950c37e676990be6cad59b2.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152cfe1f60a9f90a3950c37e676990be6cad59b2.camel@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 05:19:30AM +0000, Huang, Kai wrote:

> Sorry I got a build regression from lkp:
> 
> vmlinux.o: warning: objtool: __halt+0x3a: call to __tdx_hypercall() leaves
> .noinstr.text section

Clearly you should enable CONFIG_DEBUG_ENTRY in your own development
.config ;-)

> The reason is __halt() is annotated with "__cpuidle", but it calls
> __tdx_hypercall(), which is now a normal C function, w/o
> instrumentation_begin()/end().
> 
> I think we can annotate __tdx_hypercall() as 'noinstr' too and keep
> __tdx_hypercall_failed() unchanged.  Anyway in the upstream code,
> __tdx_hypercall() is in '.noinstr.text'.
> 
> diff --git a/arch/x86/coco/tdx/tdx-shared.c b/arch/x86/coco/tdx/tdx-shared.c
> index 13139ee171c8..b47c8cce91b0 100644
> --- a/arch/x86/coco/tdx/tdx-shared.c
> +++ b/arch/x86/coco/tdx/tdx-shared.c
> @@ -70,7 +70,7 @@ bool tdx_accept_memory(phys_addr_t start, phys_addr_t end)
>         return true;
>  }
>  
> -u64 __tdx_hypercall(struct tdx_hypercall_args *args)
> +noinstr u64 __tdx_hypercall(struct tdx_hypercall_args *args)
>  {
>         struct tdx_module_args margs = {
>                 .rcx = TDVMCALL_EXPOSE_REGS_MASK,
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index aba58484ba10..f10b0e512a36 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -37,8 +37,9 @@
>  
>  #define TDREPORT_SUBTYPE_0     0
>  
> -void __tdx_hypercall_failed(void)
> +noinstr void __tdx_hypercall_failed(void)
>  {
> +       instrumentation_begin();
>         panic("TDVMCALL failed. TDX module bug?");
>  }
> 
> 
> We can fold this to this patch.
> 
> Do you have any comments?

Yes this is fine, we violate noinstr for WARN etc.. There's no point
being pendantic about these things if we're going to take the machine
down anyway.
