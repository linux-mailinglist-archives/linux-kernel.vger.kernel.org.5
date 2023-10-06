Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A2B7BBAFA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbjJFO6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjJFO6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:58:07 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118BFCF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 07:58:06 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-2774c52c8f2so1907995a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 07:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696604285; x=1697209085; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L8SLlOsSBiXlVOZqd3MNbcaSevZs0Zf6iCkneXB+UYM=;
        b=M07276oQOHoNS7CdHBJCGmSqUJsxCdas/TShA82WpwGn81LeWpIIuwe1U+SLVMdW7A
         qygaB4Ujze+4nREpe2ROxDRFUOqqcEDwTwqdrmLjRradbHo/HNqHUQDBb5buij6uMJpq
         sF+Tjk6eamYtDs2fG4M6ZL2qw+9qAkJjnCCOIpawAcUWTIk5KOeljwKjSM9WoBGpI8M5
         1qeZIwZDx7M8pLRZ4B16B2wMXAFLcWRtglwcZxpkJ+XbfCbvkKSezcy8W1jL2nOcLmll
         lr+kMsjhz0EWJhsHVS6NekJKGgYBHPjTJ3Re3UURZWryHSauY7D2wpLWEh5lNocLCZ0U
         vB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696604285; x=1697209085;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L8SLlOsSBiXlVOZqd3MNbcaSevZs0Zf6iCkneXB+UYM=;
        b=FPm0gDeKvLOyLCvdjzHj0nNt6c7QiQbC9+otYX5p7FzFhoXT9ZBvbfChz0Q+z6MuPQ
         SKUFGvp32pJblWsZeoF/tqbJ/OhPi6+vxvmSqNRBztbsi9suN5T6CIlJaIbRFlGHgSO/
         LlWtG0hTtcdZJ+eCPF8Fy+olC8crdldIr4+rIZS8EzMzi2sHGP64USPIdV4iFL8EViUy
         lIr54/x41oOUob3FWAWODfFK7QiOTYAn/KpBQAwkR0sbI29otHM/hZqoETDm5XcfhtKF
         pbVEpHlIq9mgYxdaXimkKBEQkRDQemTHbmsK0oLOGV73leVMF8fQcxQhgCGgOYf+nN6l
         TvHQ==
X-Gm-Message-State: AOJu0YzZksCu7CsrXeRHv/JP/TMXHMGn+1gjkw7yOm8ivck9IAr1yymb
        1RrE66GUvSW/Sn0OVv6iSIJuxQdLtrM=
X-Google-Smtp-Source: AGHT+IGL88XAlpSBeihjb4Zfc5p6KDRf131bGYiWj2fWKD8BEJyproZ8L08qkjar6AMU++MXIPvMqBYldjM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:e548:b0:277:5c9b:14dd with SMTP id
 ei8-20020a17090ae54800b002775c9b14ddmr137737pjb.2.1696604285539; Fri, 06 Oct
 2023 07:58:05 -0700 (PDT)
Date:   Fri, 6 Oct 2023 07:58:03 -0700
In-Reply-To: <20231005131402.14611-11-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com> <20231005131402.14611-11-kirill.shutemov@linux.intel.com>
Message-ID: <ZSAge6W4vF6ePudw@google.com>
Subject: Re: [PATCH 10/13] x86/tdx: Convert shared memory back to private on kexec
From:   Sean Christopherson <seanjc@google.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        kexec@lists.infradead.org, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023, Kirill A. Shutemov wrote:
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 7368d254d01f..b5acf9fb4c70 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -884,6 +884,7 @@ config INTEL_TDX_GUEST
>  	select X86_MEM_ENCRYPT
>  	select X86_MCE
>  	select UNACCEPTED_MEMORY
> +	select EMERGENCY_VIRT_CALLBACK
>  	help
>  	  Support running as a guest under Intel TDX.  Without this support,
>  	  the guest kernel can not boot or run under TDX.

...

>  void __init tdx_early_init(void)
>  {
>  	struct tdx_module_args args = {
> @@ -882,6 +1007,14 @@ void __init tdx_early_init(void)
>  	 */
>  	x86_cpuinit.parallel_bringup = false;
>  
> +	machine_ops.shutdown = tdx_shutdown;
> +
> +	/*
> +	 * KVM overrides machine_ops.crash_shutdown, use emergency

This is going to be super confusing.  KVM utilizes the emergency virt callback.
The KVM paravirt guest code uses .crash_shutdown().  People that are passingly
familiar with virt and know what KVM is, but don't already know the difference
between the two are going to be all kinds of confused.

I also feel like you're playing with fire, e.g. what's to stop the hypervisor
specific paravirt guest support from using .shutdown() in the future?

And the callback is invoked for far more than just kexec().  I don't see how the
host can emulate a reboot without destroying and rebuilding the VM, e.g. it can't
stuff register state to emulate INIT or RESET.  Unless I'm missing something,
converting shared memory back to private for a shutdown or reboot is undesirable
as adds one more thing that can go wrong and prevent the system from cleanly
shutting down ASAP (for some definitions of "cleanly").

Lastly, doesn't SEV need similar behavior?  This seems like core functionality
for any guest with cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT).  Why not make the
"unshare on kexec" code common and gate it with CC_ATTR_GUEST_MEM_ENCRYPT?
