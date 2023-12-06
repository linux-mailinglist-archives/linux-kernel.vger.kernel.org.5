Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6AA8079BD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 21:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379552AbjLFUrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 15:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjLFUrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 15:47:23 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1AA135
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 12:47:29 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6cbe716b511so236314b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 12:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701895649; x=1702500449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jH5xFGHLfaGKeTo3oAeaQhvYj/JNwEL2VQkuPijRi84=;
        b=Y6o24DQZPYW6bDAMF8DnWmhJ+bIOnM2Bj5/xanRSCrxIrix1pIPAWGMw0FYwp9Ddco
         BG2lU+3F6Z/Bo/nWeo0LJxx3EEpTIjzPTI7S5QqudpZGchQOkPtm260eF20/zfIkTEfV
         OaK41SqXsCR+fOG+eoyuZ1D7Exvd7YPWvfgco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701895649; x=1702500449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jH5xFGHLfaGKeTo3oAeaQhvYj/JNwEL2VQkuPijRi84=;
        b=hCyKwF+5fQW4rf/zv7BNR/ZI5o2YqHEhNjXqQLGTPUAhK/qRG9cuj39gMYt3CkUecl
         gTH1C51xCsXxxkYhDBbW4q+gMuYekBZFcv/NONz7JNFB4QRlTojXUnJN0/GKodolFZCr
         BPcqPb7NYi4IvBfN5ged8tf176WwUb4KIoL7oPu38azSkEWO9r+9YfxfLZ0msR6B9lHD
         grqaDnWQTtD0ZQwo1eyiLBo49p0L2ao8zeMNoRFAorR4lYR70Cy0/e2cUbFO2VuI3B8z
         mtO9LPi3b0whv1RQZWtSkI5+b5S8Pm8+Xjd9j1pvNaaudysfqbCogQ1OAn35Boevc4in
         vtGw==
X-Gm-Message-State: AOJu0Yx8iTBjN0+FAJH/Jqjr1G66WQizLUq8iOP7igOcN3zgbjSBH3E9
        2VjnFwn+216ANuxcXbgcmh1tJQ==
X-Google-Smtp-Source: AGHT+IG8edmbaWwZIf/w/eblo4vl/lG7fplpBHuIF1Twy+iyazsyadGfNrebQcOdekHIj8N1K6cJCw==
X-Received: by 2002:a05:6a00:4c18:b0:6ce:2731:d5be with SMTP id ea24-20020a056a004c1800b006ce2731d5bemr1380737pfb.47.1701895648672;
        Wed, 06 Dec 2023 12:47:28 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n15-20020aa78a4f000000b006cbb58301basm417930pfa.19.2023.12.06.12.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 12:47:28 -0800 (PST)
Date:   Wed, 6 Dec 2023 12:47:27 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Florian Weimer <fweimer@redhat.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2] ELF: supply userspace with available page shifts
 (AT_PAGE_SHIFT_MASK)
Message-ID: <202312061236.DE847C52AA@keescook>
References: <6b399b86-a478-48b0-92a1-25240a8ede54@p183>
 <87v89dvuxg.fsf@oldenburg.str.redhat.com>
 <1d679805-8a82-44a4-ba14-49d4f28ff597@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d679805-8a82-44a4-ba14-49d4f28ff597@p183>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 07:01:34PM +0300, Alexey Dobriyan wrote:
> Report available page shifts in arch independent manner, so that
> userspace developers won't have to parse /proc/cpuinfo hunting
> for arch specific strings:
> 
> Note!
> 
> This is strictly for userspace, if some page size is shutdown due
> to kernel command line option or CPU bug workaround, than is must not
> be reported in aux vector!

Given Florian in CC, I assume this is something glibc would like to be
using? Please mention this in the commit log.

> 
> x86_64 machine with 1 GiB pages:
> 
> 	00000030  06 00 00 00 00 00 00 00  00 10 00 00 00 00 00 00
> 	00000040  1d 00 00 00 00 00 00 00  00 10 20 40 00 00 00 00
> 
> x86_64 machine with 2 MiB pages only:
> 
> 	00000030  06 00 00 00 00 00 00 00  00 10 00 00 00 00 00 00
> 	00000040  1d 00 00 00 00 00 00 00  00 10 20 00 00 00 00 00
> 
> AT_PAGESZ is always 4096 which is not that interesting.

That's not always true. For example, see arm64:
arch/arm64/include/asm/elf.h:#define ELF_EXEC_PAGESIZE  PAGE_SIZE

I'm not actually sure why x86 forces it to 4096. I'd need to go look
through the history there.

> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
> 	v2: switch to 1 bit per page shift (bitmask)
> 
>  arch/x86/include/asm/elf.h  |   12 ++++++++++++
>  fs/binfmt_elf.c             |    3 +++
>  include/uapi/linux/auxvec.h |   14 ++++++++++++++
>  3 files changed, 29 insertions(+)
> 
> --- a/arch/x86/include/asm/elf.h
> +++ b/arch/x86/include/asm/elf.h
> @@ -358,6 +358,18 @@ else if (IS_ENABLED(CONFIG_IA32_EMULATION))				\
>  
>  #define COMPAT_ELF_ET_DYN_BASE	(TASK_UNMAPPED_BASE + 0x1000000)
>  
> +#define ARCH_AT_PAGE_SHIFT_MASK					\
> +	do {							\
> +		u32 val = 1 << 12;				\
> +		if (boot_cpu_has(X86_FEATURE_PSE)) {		\
> +			val |= 1 << 21;				\
> +		}						\
> +		if (boot_cpu_has(X86_FEATURE_GBPAGES)) {	\
> +			val |= 1 << 30;				\
> +		}						\
> +		NEW_AUX_ENT(AT_PAGE_SHIFT_MASK, val);		\
> +	} while (0)
> +
>  #endif /* !CONFIG_X86_32 */

Can't we have a generic ARCH_AT_PAGE_SHIFT_MASK too? Something like:

#ifndef ARCH_AT_PAGE_SHIFT_MASK
#define ARCH_AT_PAGE_SHIFT_MASK
	NEW_AUX_ENT(AT_PAGE_SHIFT_MASK, 1 << PAGE_SHIFT)
#endif

Or am I misunderstanding something here?

>  
>  #define VDSO_CURRENT_BASE	((unsigned long)current->mm->context.vdso)
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -240,6 +240,9 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
>  #endif
>  	NEW_AUX_ENT(AT_HWCAP, ELF_HWCAP);
>  	NEW_AUX_ENT(AT_PAGESZ, ELF_EXEC_PAGESIZE);
> +#ifdef ARCH_AT_PAGE_SHIFT_MASK
> +	ARCH_AT_PAGE_SHIFT_MASK;
> +#endif

That way we can avoid an #ifdef in the .c file.

>  	NEW_AUX_ENT(AT_CLKTCK, CLOCKS_PER_SEC);
>  	NEW_AUX_ENT(AT_PHDR, phdr_addr);
>  	NEW_AUX_ENT(AT_PHENT, sizeof(struct elf_phdr));
> --- a/include/uapi/linux/auxvec.h
> +++ b/include/uapi/linux/auxvec.h
> @@ -33,6 +33,20 @@
>  #define AT_RSEQ_FEATURE_SIZE	27	/* rseq supported feature size */
>  #define AT_RSEQ_ALIGN		28	/* rseq allocation alignment */
>  
> +/*
> + * Page sizes available for mmap(2) encoded as bitmask.
> + *
> + * Example: x86_64 system with pse, pdpe1gb /proc/cpuinfo flags reports
> + * 4 KiB, 2 MiB and 1 GiB page support.
> + *
> + *	$ hexdump -C /proc/self/auxv

FWIW, a more readable form is: $ LD_SHOW_AUXV=1 /bin/true

> + *	00000030  06 00 00 00 00 00 00 00  00 10 00 00 00 00 00 00
> + *	00000040  1d 00 00 00 00 00 00 00  00 10 20 40 00 00 00 00
> + *
> + * For 2^64 hugepage support please contact your Universe sales representative.
> + */
> +#define AT_PAGE_SHIFT_MASK	29

... hmm, why is 29 unused?

> +
>  #define AT_EXECFN  31	/* filename of program */
>  
>  #ifndef AT_MINSIGSTKSZ

This will need a man page update for "getauxval" as well...


-- 
Kees Cook
