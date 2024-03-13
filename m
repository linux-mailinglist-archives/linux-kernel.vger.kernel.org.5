Return-Path: <linux-kernel+bounces-101156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F8287A336
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5B96B21511
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 07:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EEA17575;
	Wed, 13 Mar 2024 07:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cLCP7XaE"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A4917552
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 07:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710313802; cv=none; b=I20i/8cnTZQ5WMP+dmLMJFsVGpZgjNCHcXlWUm69i4EgehYSrjOwhc8M7R1nOw2LaKY6fYKnoVgSS3ATbZ0ACVjplvFNvMrsXH1YGr2riUXXAyXTovp3Ni6WWwJ/3ZQtW1KXy+PXiMZWU7aCwn9VzqxWzwKj4wJoT7QZbaznsNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710313802; c=relaxed/simple;
	bh=7AHBlbBVmOFnsONr0oWSQj7UuiokQ4EM/lXEbQ7dlXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aXndqWGtzari6NHRSjmGLRJqfTxWOSZyWIycLC/7nBS94hLBuLGmFIcSiZwdDz5Nl4oGhI+Xd4PphflSPWRTCU+JsWl9yTLDc37rDeYGawBMvRq7ozwkQDUed4loBwDQP7XgoeY9F4WZzGlTJgT0Y2mkDJXSpKPk0bNTi6ERo0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cLCP7XaE; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5684073ab38so1021340a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 00:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1710313797; x=1710918597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VFM7NHjFeiFIkXrKy4Ve+I5tMlDvoiqgvY2hf19yC/M=;
        b=cLCP7XaEASri38Z5l1hPf+Qhl4ndoEct2Q8P1B1tTPyjcEhwCgtvali4irXOwQZxCw
         kszBSokkJwNYMHTYM9LWtqnpwAhR3d13ctvemiAVRXqnEBCkyf3LOoZsDvlV0w25YHJD
         cqC0gc+zlEWh40qeSVksc5q/GCmDUfiNnnPHDCtEr99Dr+OlTl6IfpNhEey/l8pbNWiF
         l6CMEQTimpsXjJOemPGRC1EbALYasdEnKy7M7b1SuUd07tSUDhakHpAaDZgQw+DRD5bX
         TAwgnROOu6uwZNMehfpiHQrDGZzKHuiF+JxP7V8tGZBbNpcg//HO4pbEqwLB2nCE6s8H
         eXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710313797; x=1710918597;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VFM7NHjFeiFIkXrKy4Ve+I5tMlDvoiqgvY2hf19yC/M=;
        b=JzMN4DZ7lJBaL7MVeBmW7IVwiBJtZy4u9+BPqIkVu53Y2AaVhbWYjpiNj0Xp5UPNct
         lho5w10eXs3EjFFSfl7M987C9tYPzCpqg5KxUQAMJgGlR6DWuW5NFoTuhbSiTDkh6IKO
         jadtyD0kDp609/BAObtEdgmuc0c9SuSxn32Y0F8OsEdGonLkt7LiWr+ITCR/BXi6bmMW
         Jy8E9hJrS6YHyg4/WUVuUF1f2cItFmfF0Cc1ac83WdCPtNTe1KBSf99Jg9dN9YoAQciv
         CxjNeq0+UmsA7KsjLzwiiLVRKAeMCsZDH93S1J3+44wbifxIOnsP5urooXVX4rStoOIl
         2tNA==
X-Forwarded-Encrypted: i=1; AJvYcCUmukRqxoATM1TC1uSzvrCsRXOACOSS5sEof149uvVyhpVLcM8zCCUBcP5oH8oCAJAuYkJVjSiaPqAbA44nN3xj1pl5bSZsus6nr1n8
X-Gm-Message-State: AOJu0YzkOWDUnUa+6MvNRP7tANbzMU+dMJP3t9PG9ncQTR+yu3La5YTR
	f9gaOVgHffBOsGV6hCGE/kG8Pk11Ratygm8ON5Dco0HLaluhTCN/4jsHZweO6g4=
X-Google-Smtp-Source: AGHT+IFe/fyuKeyjO4QV1x01xdRBrc72d4UA/whVUFl6wfKoaLR7gJ9oQQHnXlmLUa47VVYaHB/K8g==
X-Received: by 2002:a50:9b58:0:b0:567:e0e:dda5 with SMTP id a24-20020a509b58000000b005670e0edda5mr1632316edj.17.1710313796845;
        Wed, 13 Mar 2024 00:09:56 -0700 (PDT)
Received: from ?IPV6:2003:e5:873a:400:704b:6dbb:e7c0:786e? (p200300e5873a0400704b6dbbe7c0786e.dip0.t-ipconnect.de. [2003:e5:873a:400:704b:6dbb:e7c0:786e])
        by smtp.gmail.com with ESMTPSA id n21-20020a05640205d500b0056884feacd4sm381463edx.39.2024.03.13.00.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 00:09:56 -0700 (PDT)
Message-ID: <ab57dce7-6e89-44aa-a87a-2ffa8cc87fc4@suse.com>
Date: Wed, 13 Mar 2024 08:09:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] x86: Rename __{start,end}_init_task to
 __{start,end}_init_stack
Content-Language: en-US
To: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-arch@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 boris.ostrovsky@oracle.com, arnd@arndb.de
References: <20240313060546.1952893-1-xin@zytor.com>
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <20240313060546.1952893-1-xin@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.03.24 07:05, Xin Li (Intel) wrote:
> The stack of a task has been separated from the memory of a task_struct
> struture for a long time on x86, as a result __{start,end}_init_task no
> longer mark the start and end of the init_task structure, but its stack
> only.
> 
> Rename __{start,end}_init_task to __{start,end}_init_stack.
> 
> Note other architectures are not affected because __{start,end}_init_task
> are used on x86 only.
> 
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> ---
>   arch/x86/include/asm/processor.h  | 4 ++--
>   arch/x86/kernel/head_64.S         | 2 +-
>   arch/x86/xen/xen-head.S           | 2 +-
>   include/asm-generic/vmlinux.lds.h | 8 ++++----
>   4 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index 811548f131f4..8b3a3f3bb859 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -636,10 +636,10 @@ static __always_inline void prefetchw(const void *x)
>   #define KSTK_ESP(task)		(task_pt_regs(task)->sp)
>   
>   #else
> -extern unsigned long __end_init_task[];
> +extern unsigned long __end_init_stack[];
>   
>   #define INIT_THREAD {							\
> -	.sp	= (unsigned long)&__end_init_task -			\
> +	.sp	= (unsigned long)&__end_init_stack -			\
>   		  TOP_OF_KERNEL_STACK_PADDING -				\
>   		  sizeof(struct pt_regs),				\
>   }
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index d8198fbd70e5..c7babd7ebb0f 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -66,7 +66,7 @@ SYM_CODE_START_NOALIGN(startup_64)
>   	mov	%rsi, %r15
>   
>   	/* Set up the stack for verify_cpu() */
> -	leaq	(__end_init_task - TOP_OF_KERNEL_STACK_PADDING - PTREGS_SIZE)(%rip), %rsp
> +	leaq	(__end_init_stack - TOP_OF_KERNEL_STACK_PADDING - PTREGS_SIZE)(%rip), %rsp
>   
>   	/* Setup GSBASE to allow stack canary access for C code */
>   	movl	$MSR_GS_BASE, %ecx
> diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
> index 04101b984f24..43eadf03f46d 100644
> --- a/arch/x86/xen/xen-head.S
> +++ b/arch/x86/xen/xen-head.S
> @@ -49,7 +49,7 @@ SYM_CODE_START(startup_xen)
>   	ANNOTATE_NOENDBR
>   	cld
>   
> -	leaq	(__end_init_task - TOP_OF_KERNEL_STACK_PADDING - PTREGS_SIZE)(%rip), %rsp
> +	leaq	(__end_init_stack - TOP_OF_KERNEL_STACK_PADDING - PTREGS_SIZE)(%rip), %rsp
>   
>   	/* Set up %gs.
>   	 *
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 5dd3a61d673d..a168be99d522 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -399,13 +399,13 @@
>   
>   #define INIT_TASK_DATA(align)						\
>   	. = ALIGN(align);						\
> -	__start_init_task = .;						\
> +	__start_init_stack = .;						\
>   	init_thread_union = .;						\
>   	init_stack = .;							\
> -	KEEP(*(.data..init_task))					\
> +	KEEP(*(.data..init_stack))					\

Is this modification really correct?

>   	KEEP(*(.data..init_thread_info))				\
> -	. = __start_init_task + THREAD_SIZE;				\
> -	__end_init_task = .;
> +	. = __start_init_stack + THREAD_SIZE;				\
> +	__end_init_stack = .;
>   
>   #define JUMP_TABLE_DATA							\
>   	. = ALIGN(8);							\
> 
> base-commit: 626856ae97054963e7b8c35335d4418271c8d0c4


Juergen


