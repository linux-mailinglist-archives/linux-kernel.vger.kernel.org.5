Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78ABA7E266C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 15:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjKFOOn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 6 Nov 2023 09:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjKFOOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 09:14:42 -0500
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B747799;
        Mon,  6 Nov 2023 06:14:39 -0800 (PST)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-582050ce2d8so766543eaf.0;
        Mon, 06 Nov 2023 06:14:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699280079; x=1699884879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bi/AtLKXkzT1gGrzBKI3P0s6DBVld8spaSFbXp0Chkw=;
        b=dSOJJfsCZyP/VFZq5unavcPP+3FRifzEbaPkU+cB5IiaF3UBQfJ1phRK2IQAbhQBxB
         zpn//ZPNOZD/1tCQAiAyZ0FpUhLJGjTmBk70v5rJQKWHb3udvQNayz8+SBU7JihCH/CO
         Vhlspypqbj+LxpyjLAP3MxC1gG9hjDehByM1e8BaUHBC68WTvoTdQt/ElmeYp1jUgg/D
         oRcVhaGszg0jKhMeJ9N0lldoNnNgNjo9/6zzz4dJQ+OX5GuroD+GWhRXZDwGZ9/kXgPz
         G2vrDnZzUBXE/rW1P3zCuGTeKlYgThscT+kpRrK9QFNFRGAMdzrk13nP2UYXponjZuMW
         NBUA==
X-Gm-Message-State: AOJu0Yy4piUJrBOJjNhxQ8doWqlkGjU3K9PNT826HMvdguRUn+rB3Efn
        sX8SUTgXmibo7VOFZlHha4HCmRmqEV/NisEdRGfbTz2i
X-Google-Smtp-Source: AGHT+IE9jVdxadw4LpkCU0/Y+BuTANpPBRbyRZeuWcwbf1QsXYgVeZYjfIgd008rx8YZXl1jPBv5Ftq9qXZYoPCjXe4=
X-Received: by 2002:a4a:3390:0:b0:587:947b:31f4 with SMTP id
 q138-20020a4a3390000000b00587947b31f4mr5561208ooq.1.1699280079018; Mon, 06
 Nov 2023 06:14:39 -0800 (PST)
MIME-Version: 1.0
References: <20231103104900.409470-1-ubizjak@gmail.com>
In-Reply-To: <20231103104900.409470-1-ubizjak@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 6 Nov 2023 15:14:27 +0100
Message-ID: <CAJZ5v0iOY3u_jBmf=_3AnqEWHb+eTA6DtTfoU3tb=0RB0O+szw@mail.gmail.com>
Subject: Re: [PATCH] x86/acpi: Use %rip-relative addressing in wakeup_64.S
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 3, 2023 at 11:49 AM Uros Bizjak <ubizjak@gmail.com> wrote:
>
> Instruction with %rip-relative address operand is one byte shorter than
> its absolute address counterpart and is also compatible with position
> independent executable (-fpie) build.
>
> No functional changes intended.

I'm wondering what's the exact motivation for making this change.

Any urgent need for it doesn't seem to be there.

> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> ---
>  arch/x86/kernel/acpi/wakeup_64.S | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
> index d5d8a352eafa..94ff83f3d3fe 100644
> --- a/arch/x86/kernel/acpi/wakeup_64.S
> +++ b/arch/x86/kernel/acpi/wakeup_64.S
> @@ -17,7 +17,7 @@
>          * Hooray, we are in Long 64-bit mode (but still running in low memory)
>          */
>  SYM_FUNC_START(wakeup_long64)
> -       movq    saved_magic, %rax
> +       movq    saved_magic(%rip), %rax
>         movq    $0x123456789abcdef0, %rdx
>         cmpq    %rdx, %rax
>         je      2f
> @@ -33,14 +33,14 @@ SYM_FUNC_START(wakeup_long64)
>         movw    %ax, %es
>         movw    %ax, %fs
>         movw    %ax, %gs
> -       movq    saved_rsp, %rsp
> +       movq    saved_rsp(%rip), %rsp
>
> -       movq    saved_rbx, %rbx
> -       movq    saved_rdi, %rdi
> -       movq    saved_rsi, %rsi
> -       movq    saved_rbp, %rbp
> +       movq    saved_rbx(%rip), %rbx
> +       movq    saved_rdi(%rip), %rdi
> +       movq    saved_rsi(%rip), %rsi
> +       movq    saved_rbp(%rip), %rbp
>
> -       movq    saved_rip, %rax
> +       movq    saved_rip(%rip), %rax
>         ANNOTATE_RETPOLINE_SAFE
>         jmp     *%rax
>  SYM_FUNC_END(wakeup_long64)
> @@ -72,11 +72,11 @@ SYM_FUNC_START(do_suspend_lowlevel)
>
>         movq    $.Lresume_point, saved_rip(%rip)
>
> -       movq    %rsp, saved_rsp
> -       movq    %rbp, saved_rbp
> -       movq    %rbx, saved_rbx
> -       movq    %rdi, saved_rdi
> -       movq    %rsi, saved_rsi
> +       movq    %rsp, saved_rsp(%rip)
> +       movq    %rbp, saved_rbp(%rip)
> +       movq    %rbx, saved_rbx(%rip)
> +       movq    %rdi, saved_rdi(%rip)
> +       movq    %rsi, saved_rsi(%rip)
>
>         addq    $8, %rsp
>         movl    $3, %edi
> --
