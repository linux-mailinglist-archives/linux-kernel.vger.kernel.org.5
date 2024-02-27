Return-Path: <linux-kernel+bounces-83456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FCB8699BA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93E10B296C3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FA614901E;
	Tue, 27 Feb 2024 14:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUs9dr7x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7352149DED
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709045875; cv=none; b=tlk9s3XglzEn51C0ikyR03eZF3ikqA08rwHbKgYKrQnRhDp2YpMJhUlcv5T0/eI6yFynph+RgxQ1LEFa7IkAv19AsCErAWwfqY2AUz1h0H9oSmXHcD7lSCy8PjN6TL3IEa7GmXXl8TtYsPT4bsjZV6bmgqQ/D0UTfHzFeV4O5MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709045875; c=relaxed/simple;
	bh=ZiS0Y8N/JNHPCRbZw5+rrcFF3RECZft2ksh+TkOABqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qu2jYg2KM3+NtiqVOqI3QuLSN+Zdqrhl8butTkAgsLXQNdVlmGFzXNYmU+lkE74df3s3VQROsrjJOWECPdua+7l61WMj8YO2pjKGAl+Il0ipmX8QODJD3DQxVZQ8jw/Tqly3B6vEie/s/OMALIXQecaamN2RGrudqYQ9BhOVkFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUs9dr7x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B60C433F1
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709045875;
	bh=ZiS0Y8N/JNHPCRbZw5+rrcFF3RECZft2ksh+TkOABqw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UUs9dr7x5w4S2+mheN0Uu/lGmDjtCEatSMfcKIYJMY7q3NtxfskvrvnzuviFWkxBc
	 8yTOGeZ/AmMBjhvNLSZsGcFcC+VaMTSJ/7P4qidUBIOymRdvngM5HJ2NLFg+Sqv9/8
	 0JbmSDJ7ET5LIYXTRExJh2ZJwnjA+gkgQSDRkxtOFLY/IixIg2E0/Wsn9bgyvz9h4B
	 tkdu2jl3+iFHPQ5MPXmP3NHXxkYYPXsc/suk/hPUYGMYROub4hBnu+aLVqlBGcqynY
	 Fe0vrbhOpOMsY1z176OekD9vujRn7+tUjoGosn8iOn/ulIe7B1VM2hlTaL2eOyKEPJ
	 qAZo3bSE4hH6w==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-512b29f82d1so5948880e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 06:57:55 -0800 (PST)
X-Gm-Message-State: AOJu0YwT2/1lnm75XRfhIZMekcnc/ZmGOhnezYfImD7kQHk4Ke0hbGHB
	IF/gyioVN1aWUHktK8lh1tJdjYJMde7w0UDg+vK18rJOHgSxQ1cjeoSJEDCQusS3pCqfuu5pp4h
	LByFny2nknlVkamGOXgP3EbuUqGg=
X-Google-Smtp-Source: AGHT+IEBtZiOSKHjneY8t6UpoP/k94IlS+DjNiD4lxwXJGkkHU9IyTuJ8HDry0UCvIzjL0tqyNF0k6mfGwDK8K0JmV4=
X-Received: by 2002:ac2:4833:0:b0:512:ccd2:5cb0 with SMTP id
 19-20020ac24833000000b00512ccd25cb0mr6502413lft.29.1709045873616; Tue, 27 Feb
 2024 06:57:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226220544.70769-1-brgerst@gmail.com>
In-Reply-To: <20240226220544.70769-1-brgerst@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 27 Feb 2024 15:57:42 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEphGynUGVhsv3f3kk7qveg5LpVSguVRG7ntTDukk48Ng@mail.gmail.com>
Message-ID: <CAMj1kXEphGynUGVhsv3f3kk7qveg5LpVSguVRG7ntTDukk48Ng@mail.gmail.com>
Subject: Re: [PATCH v2] x86/boot/64: Load kernel GDT in early boot
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	"H . Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Feb 2024 at 23:05, Brian Gerst <brgerst@gmail.com> wrote:
>
> Instead of loading a duplicate GDT just for early boot, load the kernel
> GDT from its physical address.
>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>
> ---
> v2: Updated to latest tip tree
>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

>  arch/x86/include/asm/desc.h |  1 +
>  arch/x86/kernel/head64.c    | 13 ++-----------
>  2 files changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
> index ec95fe44fa3a..62dc9f59ea76 100644
> --- a/arch/x86/include/asm/desc.h
> +++ b/arch/x86/include/asm/desc.h
> @@ -46,6 +46,7 @@ struct gdt_page {
>  } __attribute__((aligned(PAGE_SIZE)));
>
>  DECLARE_PER_CPU_PAGE_ALIGNED(struct gdt_page, gdt_page);
> +DECLARE_INIT_PER_CPU(gdt_page);
>
>  /* Provide the original GDT */
>  static inline struct desc_struct *get_cpu_gdt_rw(unsigned int cpu)
> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> index 72351c3121a6..fd77a266f29d 100644
> --- a/arch/x86/kernel/head64.c
> +++ b/arch/x86/kernel/head64.c
> @@ -68,15 +68,6 @@ unsigned long vmemmap_base __ro_after_init = __VMEMMAP_BASE_L4;
>  EXPORT_SYMBOL(vmemmap_base);
>  #endif
>
> -/*
> - * GDT used on the boot CPU before switching to virtual addresses.
> - */
> -static struct desc_struct startup_gdt[GDT_ENTRIES] __initdata = {
> -       [GDT_ENTRY_KERNEL32_CS]         = GDT_ENTRY_INIT(DESC_CODE32, 0, 0xfffff),
> -       [GDT_ENTRY_KERNEL_CS]           = GDT_ENTRY_INIT(DESC_CODE64, 0, 0xfffff),
> -       [GDT_ENTRY_KERNEL_DS]           = GDT_ENTRY_INIT(DESC_DATA64, 0, 0xfffff),
> -};
> -
>  #ifdef CONFIG_X86_5LEVEL
>  static void __head *fixup_pointer(void *ptr, unsigned long physaddr)
>  {
> @@ -589,8 +580,8 @@ void __head startup_64_setup_gdt_idt(void)
>         void *handler = NULL;
>
>         struct desc_ptr startup_gdt_descr = {
> -               .address = (unsigned long)&RIP_REL_REF(startup_gdt),
> -               .size    = sizeof(startup_gdt) - 1,
> +               .address = (unsigned long)&RIP_REL_REF(init_per_cpu_var(gdt_page.gdt)),
> +               .size    = GDT_SIZE - 1,
>         };
>
>         /* Load GDT */
>
> base-commit: afb9cce6ad6e808cf659f43925941be96f61b9c9
> --
> 2.43.2
>

