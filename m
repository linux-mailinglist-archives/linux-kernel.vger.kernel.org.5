Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F151E757F43
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbjGROR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbjGRORz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:17:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A75E170C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689689825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/1RlJj02XB5KoFXG6iNiI+SmAEXZB1VhSrMQEnow/hE=;
        b=ZoMlOl9RE6iO9gcGtDWyGM2BXaBpKDRQdxa7kHiuOW+oH04ChRBD11Hygc8zrYKaujla2M
        W5AjKy9aLGqrvXRQFR9pcdqIP/FFPp0LOsPOczvl7OMCPh6CZL/NZQX11fQ22oPXHY/B0o
        rAcmOPWBhUriMrSZvtMWrOWDihZAn6U=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-B6GGrWsGNieMq8vnpBn2RA-1; Tue, 18 Jul 2023 10:16:53 -0400
X-MC-Unique: B6GGrWsGNieMq8vnpBn2RA-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4fb9364b320so5002102e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689689803; x=1692281803;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/1RlJj02XB5KoFXG6iNiI+SmAEXZB1VhSrMQEnow/hE=;
        b=JUcofYwHzuQ4gTNvtUA8O2CqgB9uOUx/BOK5xQKmgN5RVMCZUWczfeWyitMFnUiKEj
         sS6WO9HRTZiBtik0KiWC0AE1rtS/2Iq4mk/xyz7Y2KJef5CHNq6kmlDOCRhFkZi7OC0e
         Sdr2TeJeNH/xavngBZ9eh3yAF0lwKNSQZByj+ETcI9G3p9IrcFZr2yStPsnZi13nQLzH
         Ft63m5vuYYnB6+i7sz/E0WzIvFSSuxxNbSypp4n9V7xtYAaE9CAlwyNdZscmiVp5Huz+
         AG0RatnfsAhTbS8tL+NncqYnzmuKOxig//2T60ASdcHSiT/Bx1mRJULXYmg7meYfE8EE
         hD2w==
X-Gm-Message-State: ABy/qLYlgqYYVr8nkT0MigBZgb8TlG1gNSiTTP4joqNKAqIf1rBmDsX8
        5o/WBz4R/oFvxnVzxbchl1ndIgP9h5ixRUuWirNQypK2p0ufvXU+cU83oc+PoFCmD5ghEJRmRRv
        trNTeTRtVZRv1WbTcMhWyuHQ=
X-Received: by 2002:a19:5015:0:b0:4fb:7772:7bae with SMTP id e21-20020a195015000000b004fb77727baemr1857701lfb.6.1689689803227;
        Tue, 18 Jul 2023 07:16:43 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFz7+vqcf97xK0X+IgqADrcrRe/UeJGl/Y4Wg6/rEwhCS5mKA1uoLTGRnU2atVLxIvvSspWsQ==
X-Received: by 2002:a19:5015:0:b0:4fb:7772:7bae with SMTP id e21-20020a195015000000b004fb77727baemr1857678lfb.6.1689689802790;
        Tue, 18 Jul 2023 07:16:42 -0700 (PDT)
Received: from [192.168.1.121] (85-23-20-79.bb.dnainternet.fi. [85.23.20.79])
        by smtp.gmail.com with ESMTPSA id l25-20020ac25559000000b004fb7ac67bbdsm463566lfk.41.2023.07.18.07.16.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 07:16:42 -0700 (PDT)
Message-ID: <a7b18c6b-1b27-b9fa-8936-2c0b7f5e5151@redhat.com>
Date:   Tue, 18 Jul 2023 17:16:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/6] x86/entry/64: Convert SYSRET validation tests to C
Content-Language: en-US
To:     Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>
References: <20230718134446.168654-1-brgerst@gmail.com>
 <20230718134446.168654-3-brgerst@gmail.com>
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mpenttil@redhat.com>
In-Reply-To: <20230718134446.168654-3-brgerst@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 18.7.2023 16.44, Brian Gerst wrote:
> Signed-off-by: Brian Gerst <brgerst@gmail.com>
> ---
>   arch/x86/entry/common.c        | 50 ++++++++++++++++++++++++++++++-
>   arch/x86/entry/entry_64.S      | 55 ++--------------------------------
>   arch/x86/include/asm/syscall.h |  2 +-
>   3 files changed, 52 insertions(+), 55 deletions(-)
> 
> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> index 6c2826417b33..afe79c3f1c5b 100644
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -70,8 +70,12 @@ static __always_inline bool do_syscall_x32(struct pt_regs *regs, int nr)
>   	return false;
>   }
>   
> -__visible noinstr void do_syscall_64(struct pt_regs *regs, int nr)
> +/* Returns true to return using SYSRET, or false to use IRET */
> +__visible noinstr bool do_syscall_64(struct pt_regs *regs, int nr)
>   {
> +	long rip;
> +	unsigned int shift_rip;
> +
>   	add_random_kstack_offset();
>   	nr = syscall_enter_from_user_mode(regs, nr);
>   
> @@ -84,6 +88,50 @@ __visible noinstr void do_syscall_64(struct pt_regs *regs, int nr)
>   
>   	instrumentation_end();
>   	syscall_exit_to_user_mode(regs);
> +
> +	/*
> +	 * Check that the register state is valid for using SYSRET to exit
> +	 * to userspace.  Otherwise use the slower but fully capable IRET
> +	 * exit path.
> +	 */
> +
> +	/* XEN PV guests always use IRET path */
> +	if (cpu_feature_enabled(X86_FEATURE_XENPV))
> +		return false;
> +
> +	/* SYSRET requires RCX == RIP and R11 == EFLAGS */
> +	if (unlikely(regs->cx != regs->ip || regs->r11 != regs->flags))
> +		return false;
> +
> +	/* CS and SS must match the values set in MSR_STAR */
> +	if (unlikely(regs->cs != __USER_CS || regs->ss != __USER_DS))
> +		return false;
> +
> +	/*
> +	 * On Intel CPUs, SYSRET with non-canonical RCX/RIP will #GP
> +	 * in kernel space.  This essentially lets the user take over
> +	 * the kernel, since userspace controls RSP.
> +	 *
> +	 * Change top bits to match most significant bit (47th or 56th bit
> +	 * depending on paging mode) in the address.
> +	 */
> +	shift_rip = (64 - __VIRTUAL_MASK_SHIFT + 1);

Should this be:

	shift_rip = (64 - __VIRTUAL_MASK_SHIFT - 1);
?

> +	rip = (long) regs->ip;
> +	rip <<= shift_rip;
> +	rip >>= shift_rip;
> +	if (unlikely((unsigned long) rip != regs->ip))
> +		return false;
> +
> +	/*
> +	 * SYSRET cannot restore RF.  It can restore TF, but unlike IRET,
> +	 * restoring TF results in a trap from userspace immediately after
> +	 * SYSRET.
> +	 */
> +	if (unlikely(regs->flags & (X86_EFLAGS_RF | X86_EFLAGS_TF)))
> +		return false;
> +
> +	/* Use SYSRET to exit to userspace */
> +	return true;
>   }
>   #endif
>   
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index c01776a51545..b1288e22cae8 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -123,60 +123,9 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_hwframe, SYM_L_GLOBAL)
>   	 * Try to use SYSRET instead of IRET if we're returning to
>   	 * a completely clean 64-bit userspace context.  If we're not,
>   	 * go to the slow exit path.
> -	 * In the Xen PV case we must use iret anyway.
>   	 */
> -
> -	ALTERNATIVE "", "jmp	swapgs_restore_regs_and_return_to_usermode", \
> -		X86_FEATURE_XENPV
> -
> -	movq	RCX(%rsp), %rcx
> -	movq	RIP(%rsp), %r11
> -
> -	cmpq	%rcx, %r11	/* SYSRET requires RCX == RIP */
> -	jne	swapgs_restore_regs_and_return_to_usermode
> -
> -	/*
> -	 * On Intel CPUs, SYSRET with non-canonical RCX/RIP will #GP
> -	 * in kernel space.  This essentially lets the user take over
> -	 * the kernel, since userspace controls RSP.
> -	 *
> -	 * If width of "canonical tail" ever becomes variable, this will need
> -	 * to be updated to remain correct on both old and new CPUs.
> -	 *
> -	 * Change top bits to match most significant bit (47th or 56th bit
> -	 * depending on paging mode) in the address.
> -	 */
> -#ifdef CONFIG_X86_5LEVEL
> -	ALTERNATIVE "shl $(64 - 48), %rcx; sar $(64 - 48), %rcx", \
> -		"shl $(64 - 57), %rcx; sar $(64 - 57), %rcx", X86_FEATURE_LA57
> -#else
> -	shl	$(64 - (__VIRTUAL_MASK_SHIFT+1)), %rcx
> -	sar	$(64 - (__VIRTUAL_MASK_SHIFT+1)), %rcx
> -#endif
> -
> -	/* If this changed %rcx, it was not canonical */
> -	cmpq	%rcx, %r11
> -	jne	swapgs_restore_regs_and_return_to_usermode
> -
> -	cmpq	$__USER_CS, CS(%rsp)		/* CS must match SYSRET */
> -	jne	swapgs_restore_regs_and_return_to_usermode
> -
> -	movq	R11(%rsp), %r11
> -	cmpq	%r11, EFLAGS(%rsp)		/* R11 == RFLAGS */
> -	jne	swapgs_restore_regs_and_return_to_usermode
> -
> -	/*
> -	 * SYSRET cannot restore RF.  It can restore TF, but unlike IRET,
> -	 * restoring TF results in a trap from userspace immediately after
> -	 * SYSRET.
> -	 */
> -	testq	$(X86_EFLAGS_RF|X86_EFLAGS_TF), %r11
> -	jnz	swapgs_restore_regs_and_return_to_usermode
> -
> -	/* nothing to check for RSP */
> -
> -	cmpq	$__USER_DS, SS(%rsp)		/* SS must match SYSRET */
> -	jne	swapgs_restore_regs_and_return_to_usermode
> +	testb	%al, %al
> +	jz	swapgs_restore_regs_and_return_to_usermode
>   
>   	/*
>   	 * We win! This label is here just for ease of understanding
> diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
> index 4fb36fba4b5a..be6c5515e0b9 100644
> --- a/arch/x86/include/asm/syscall.h
> +++ b/arch/x86/include/asm/syscall.h
> @@ -126,7 +126,7 @@ static inline int syscall_get_arch(struct task_struct *task)
>   		? AUDIT_ARCH_I386 : AUDIT_ARCH_X86_64;
>   }
>   
> -void do_syscall_64(struct pt_regs *regs, int nr);
> +bool do_syscall_64(struct pt_regs *regs, int nr);
>   
>   #endif	/* CONFIG_X86_32 */
>   


--Mika

