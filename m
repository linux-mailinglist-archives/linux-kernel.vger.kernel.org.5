Return-Path: <linux-kernel+bounces-139342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEDA8A019A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F1C81C235DE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F801836D3;
	Wed, 10 Apr 2024 21:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igwfIIqW"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575E6181D04
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 21:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712782826; cv=none; b=KUbUuaW7LMiVHZV8EaLC8gKpshs2P+sCBwo2HoUItAOufPE8WT39QEi7bSziayUZhsaCxpGjBkg4VNa9D69VjSQMw5OFm4LyzWXalnzsq84GbRlZuNcf6XSxAo5bYazVyEvJ3KNdef0V4AgzEvhQoOpbJFLYHLIYxjIRX6nCyME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712782826; c=relaxed/simple;
	bh=sGBQZC1f+WvWgZWOa13OiIO/Ri43fIzrIzSyKky3s3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=awN8pko3TAI+bcIRfJEFjmJeInpdqmzGnX8hPB1iyoUg+2TR60L66t5IXRJA37JiO/1Ds2znNcrS7G6uk1l+7CMULuqhsEwF59QL+IXQCsgA/LsH6mr1VMvTfc3A4htoU7DcTvk6ZjGs88CGcoPJS5vwl/x8pVFIOWUuzMW5b6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igwfIIqW; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-516ab4b3251so8155600e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 14:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712782822; x=1713387622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTOLX4JLh5I1S63wm7ZYTbxWd3eO8LcCr+U3ImNr+Hw=;
        b=igwfIIqWMKYNnVczMgXgMHKAM1hXAITBSy0+lUS2myFl9yD09b5AJP/w+YwN7tjm6Q
         5nSYPVhtXtPQL/y5QE+mAMOrsLDTYNs+a3OSHkqp+rCV4gWaCCXZ/zcpnoGfpw1maMOI
         bkgiHsNw1wKlvK/bio0XX2UkINza97tltiArLu5LrYqzQN4s8nzgN6t3HG6pEQSemHhv
         AKEhMU1kaiTCxgbL6Drd6OLRjELSXijWozuvU3jV0aYHJmvUeArx2raLM9LiWV4Cx2sz
         UTFGLJHs93g+tKpq6C+HXCk7IaqzQ3sWvtoce0ZVBDCMqv7vU5oRfKBncV9Zk60350SG
         5Fmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712782822; x=1713387622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OTOLX4JLh5I1S63wm7ZYTbxWd3eO8LcCr+U3ImNr+Hw=;
        b=Q3859fMTqy7Yja69GiJ/i644h0oIRranJ8u7+HXeNmykVNc7J38D9DWxLV/xlLD2/Y
         +Dl1Jwc/r39AMuCwfYwSA20M76FsVafSEkGVE9Oo3qHZ2Y13xDxOUWWDE9TfZ9KVTVSk
         YbX4b6wFyhsOE6lhODmG7v6ulLC1/oaklPzkeghqkAbwEOtcn0gF5aXruspW9AL22PEK
         S7ut9kjzeA+OTbSsnAC+qsDga/gkysLFPSIZXKQDcsGxfo7BbWSRF1QfR2cY3BUp6t9c
         vVvB759Gc6wGEsmJ7SNQYOkV+tIu79jo/Theq1e5DGcBb3oIZZdfMsJf/sG5dDqcZIFZ
         tnZg==
X-Forwarded-Encrypted: i=1; AJvYcCV8qCpWI9SSHicWV0H+nLCmlHd5ccAEB7fbTy6oly2DAoVrYZ27yKJtZC39p366fVFhh2znXDjLv7UAf9rYLVG/4QEtTKeac/kW9icr
X-Gm-Message-State: AOJu0YyhL6Te422WMLZJnrAucxo/iw8/6lzoJDa/AEkz9LzE4UezPBgH
	yE4ZglKeeUzObXap9xAcH+I4emD2lp3fi7bf4ZwcWd/dlNV9XZvPVOVODzeQ0eIojRaKuyNrM2b
	csNQ9RodI9wC/xtsp4vzQH4oNXBvY
X-Google-Smtp-Source: AGHT+IHamXN4IgV+QiIETJSN7sHN7KaKh2Hd0vq3jXc0f0d0B2F3cy+oSbc44j/6FZ2J7UpYNoO8hZBCUqgdA8GF4rU=
X-Received: by 2002:ac2:5598:0:b0:516:26cd:da71 with SMTP id
 v24-20020ac25598000000b0051626cdda71mr2936245lfg.3.1712782822109; Wed, 10 Apr
 2024 14:00:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410194850.39994-1-jason.andryuk@amd.com> <20240410194850.39994-3-jason.andryuk@amd.com>
In-Reply-To: <20240410194850.39994-3-jason.andryuk@amd.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Wed, 10 Apr 2024 17:00:10 -0400
Message-ID: <CAMzpN2h6S69bOLXCUhmkVJErvoKxq-wPmfoaqR7eGHYLgirn+Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] x86/pvh: Make PVH entrypoint PIC for x86-64
To: Jason Andryuk <jason.andryuk@amd.com>
Cc: Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 3:50=E2=80=AFPM Jason Andryuk <jason.andryuk@amd.co=
m> wrote:
>
> The PVH entrypoint is 32bit non-PIC code running the uncompressed
> vmlinux at its load address CONFIG_PHYSICAL_START - default 0x1000000
> (16MB).  The kernel is loaded at that physical address inside the VM by
> the VMM software (Xen/QEMU).
>
> When running a Xen PVH Dom0, the host reserved addresses are mapped 1-1
> into the PVH container.  There exist system firmwares (Coreboot/EDK2)
> with reserved memory at 16MB.  This creates a conflict where the PVH
> kernel cannot be loaded at that address.
>
> Modify the PVH entrypoint to be position-indepedent to allow flexibility
> in load address.  Only the 64bit entry path is converted.  A 32bit
> kernel is not PIC, so calling into other parts of the kernel, like
> xen_prepare_pvh() and mk_pgtable_32(), don't work properly when
> relocated.
>
> This makes the code PIC, but the page tables need to be updated as well
> to handle running from the kernel high map.
>
> The UNWIND_HINT_END_OF_STACK is to silence:
> vmlinux.o: warning: objtool: pvh_start_xen+0x7f: unreachable instruction
> after the lret into 64bit code.
>
> Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
> ---
> ---
>  arch/x86/platform/pvh/head.S | 44 ++++++++++++++++++++++++++++--------
>  1 file changed, 34 insertions(+), 10 deletions(-)
>
> diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
> index f7235ef87bc3..bb1e582e32b1 100644
> --- a/arch/x86/platform/pvh/head.S
> +++ b/arch/x86/platform/pvh/head.S
> @@ -7,6 +7,7 @@
>         .code32
>         .text
>  #define _pa(x)          ((x) - __START_KERNEL_map)
> +#define rva(x)          ((x) - pvh_start_xen)
>
>  #include <linux/elfnote.h>
>  #include <linux/init.h>
> @@ -54,7 +55,25 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
>         UNWIND_HINT_END_OF_STACK
>         cld
>
> -       lgdt (_pa(gdt))
> +       /*
> +        * See the comment for startup_32 for more details.  We need to
> +        * execute a call to get the execution address to be position
> +        * independent, but we don't have a stack.  Save and restore the
> +        * magic field of start_info in ebx, and use that as the stack.
> +        */
> +       mov  (%ebx), %eax
> +       leal 4(%ebx), %esp
> +       ANNOTATE_INTRA_FUNCTION_CALL
> +       call 1f
> +1:     popl %ebp
> +       mov  %eax, (%ebx)
> +       subl $rva(1b), %ebp
> +       movl $0, %esp
> +
> +       leal rva(gdt)(%ebp), %eax
> +       leal rva(gdt_start)(%ebp), %ecx
> +       movl %ecx, 2(%eax)
> +       lgdt (%eax)
>
>         mov $PVH_DS_SEL,%eax
>         mov %eax,%ds
> @@ -62,14 +81,14 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
>         mov %eax,%ss
>
>         /* Stash hvm_start_info. */
> -       mov $_pa(pvh_start_info), %edi
> +       leal rva(pvh_start_info)(%ebp), %edi
>         mov %ebx, %esi
> -       mov _pa(pvh_start_info_sz), %ecx
> +       movl rva(pvh_start_info_sz)(%ebp), %ecx
>         shr $2,%ecx
>         rep
>         movsl
>
> -       mov $_pa(early_stack_end), %esp
> +       leal rva(early_stack_end)(%ebp), %esp
>
>         /* Enable PAE mode. */
>         mov %cr4, %eax
> @@ -84,28 +103,33 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
>         wrmsr
>
>         /* Enable pre-constructed page tables. */
> -       mov $_pa(init_top_pgt), %eax
> +       leal rva(init_top_pgt)(%ebp), %eax
>         mov %eax, %cr3
>         mov $(X86_CR0_PG | X86_CR0_PE), %eax
>         mov %eax, %cr0
>
>         /* Jump to 64-bit mode. */
> -       ljmp $PVH_CS_SEL, $_pa(1f)
> +       pushl $PVH_CS_SEL
> +       leal  rva(1f)(%ebp), %eax
> +       pushl %eax
> +       lretl
>
>         /* 64-bit entry point. */
>         .code64
>  1:
> +       UNWIND_HINT_END_OF_STACK
> +
>         /* Set base address in stack canary descriptor. */
>         mov $MSR_GS_BASE,%ecx
> -       mov $_pa(canary), %eax
> +       leal rva(canary)(%ebp), %eax

Since this is in 64-bit mode, RIP-relative addressing can be used.

>         xor %edx, %edx
>         wrmsr
>
>         call xen_prepare_pvh
>
>         /* startup_64 expects boot_params in %rsi. */
> -       mov $_pa(pvh_bootparams), %rsi
> -       mov $_pa(startup_64), %rax
> +       lea rva(pvh_bootparams)(%ebp), %rsi
> +       lea rva(startup_64)(%ebp), %rax

RIP-relative here too.

>         ANNOTATE_RETPOLINE_SAFE
>         jmp *%rax
>
> @@ -143,7 +167,7 @@ SYM_CODE_END(pvh_start_xen)
>         .balign 8
>  SYM_DATA_START_LOCAL(gdt)
>         .word gdt_end - gdt_start
> -       .long _pa(gdt_start)
> +       .long _pa(gdt_start) /* x86-64 will overwrite if relocated. */
>         .word 0
>  SYM_DATA_END(gdt)
>  SYM_DATA_START_LOCAL(gdt_start)
> --
> 2.44.0
>
>

Brian Gerst

