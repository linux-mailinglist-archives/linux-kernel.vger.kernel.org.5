Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277467E283B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjKFPJs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 6 Nov 2023 10:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjKFPJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:09:47 -0500
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743E4B3;
        Mon,  6 Nov 2023 07:09:44 -0800 (PST)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5872c652a66so286202eaf.1;
        Mon, 06 Nov 2023 07:09:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699283384; x=1699888184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EFpDfKfGfQS3hBcBBeYU7HxGjQMWrTdntKCbYzTULPQ=;
        b=tI2aFwH+2AlGeigNnPXyv3YX7Iq2bsyLAE3JTDVDcBxwS15QAKxbiMfVfW17I/7Bkl
         J4HjUDV1WepxI2DkIMg0QIMRqSJp1+NS5p5j/a2EBSq2cz8R7zSwtM1pl1+8VJ4mdDR4
         bVCuCcxyAOP/5fF4IIPrQDSqgF7VZw4CHBqUBGxZmqFSPD/uLDau22AfwNv3bRNr0ZrQ
         mrfzPvmJkO+cDZuOR2NAlQidZEUQ+PWewJrid6KlXZSFfLpQ1dAI1cCao1GBcpmiG465
         lKxMmP/wSHEUjGD6irU8KGG1alSFw9DSbz/1k0WdSm8rXB2YsLOgbCRQg+IxoIm7SfPx
         oYFA==
X-Gm-Message-State: AOJu0YzwxhgpvEep6uwo0RGgjCUOceAPYZdeMMit6d0YGjofPNflPH1d
        BOgyyn2DdQbRMMP88nobuXRevKuM1xUquShaWMeEYcMO
X-Google-Smtp-Source: AGHT+IFEqLz/U68qrMzhnOqCITe+la6hVxQfbh8yLocADTaNOEREesO5YSWMkm6MCiU2v9aZjjXWmt4yQtLqqWqpQsU=
X-Received: by 2002:a4a:dbd8:0:b0:583:ec88:e0 with SMTP id t24-20020a4adbd8000000b00583ec8800e0mr29278014oou.0.1699283383662;
 Mon, 06 Nov 2023 07:09:43 -0800 (PST)
MIME-Version: 1.0
References: <20231103104900.409470-1-ubizjak@gmail.com> <CAJZ5v0iOY3u_jBmf=_3AnqEWHb+eTA6DtTfoU3tb=0RB0O+szw@mail.gmail.com>
 <CAFULd4YPVcWL6_bo2T4O=a6ed9hTOakp2m1_XBF3w-uWhyd4dQ@mail.gmail.com>
In-Reply-To: <CAFULd4YPVcWL6_bo2T4O=a6ed9hTOakp2m1_XBF3w-uWhyd4dQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 6 Nov 2023 16:09:32 +0100
Message-ID: <CAJZ5v0gFTdVH7Kr3cHcb+stGx_E-rm=B5h+z4ZFqfY=M9=Jffw@mail.gmail.com>
Subject: Re: [PATCH] x86/acpi: Use %rip-relative addressing in wakeup_64.S
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>,
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

On Mon, Nov 6, 2023 at 3:25 PM Uros Bizjak <ubizjak@gmail.com> wrote:
>
> On Mon, Nov 6, 2023 at 3:14 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Fri, Nov 3, 2023 at 11:49 AM Uros Bizjak <ubizjak@gmail.com> wrote:
> > >
> > > Instruction with %rip-relative address operand is one byte shorter than
> > > its absolute address counterpart and is also compatible with position
> > > independent executable (-fpie) build.
> > >
> > > No functional changes intended.
> >
> > I'm wondering what's the exact motivation for making this change.
>
> Mainly to be consistent with what the compiler emits by default when a
> symbol is accessed. As said in the commit message, the %rip-relative
> access is also one byte shorter, and results in a position independent
> code.
>
> > Any urgent need for it doesn't seem to be there.
>
> True. It's mostly a nice-to-have change.

OK, so

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

and the decision what to do with it is up to the x86 folks.

> > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > Cc: Len Brown <len.brown@intel.com>
> > > Cc: Pavel Machek <pavel@ucw.cz>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Ingo Molnar <mingo@kernel.org>
> > > Cc: Borislav Petkov <bp@alien8.de>
> > > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > > ---
> > >  arch/x86/kernel/acpi/wakeup_64.S | 24 ++++++++++++------------
> > >  1 file changed, 12 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
> > > index d5d8a352eafa..94ff83f3d3fe 100644
> > > --- a/arch/x86/kernel/acpi/wakeup_64.S
> > > +++ b/arch/x86/kernel/acpi/wakeup_64.S
> > > @@ -17,7 +17,7 @@
> > >          * Hooray, we are in Long 64-bit mode (but still running in low memory)
> > >          */
> > >  SYM_FUNC_START(wakeup_long64)
> > > -       movq    saved_magic, %rax
> > > +       movq    saved_magic(%rip), %rax
> > >         movq    $0x123456789abcdef0, %rdx
> > >         cmpq    %rdx, %rax
> > >         je      2f
> > > @@ -33,14 +33,14 @@ SYM_FUNC_START(wakeup_long64)
> > >         movw    %ax, %es
> > >         movw    %ax, %fs
> > >         movw    %ax, %gs
> > > -       movq    saved_rsp, %rsp
> > > +       movq    saved_rsp(%rip), %rsp
> > >
> > > -       movq    saved_rbx, %rbx
> > > -       movq    saved_rdi, %rdi
> > > -       movq    saved_rsi, %rsi
> > > -       movq    saved_rbp, %rbp
> > > +       movq    saved_rbx(%rip), %rbx
> > > +       movq    saved_rdi(%rip), %rdi
> > > +       movq    saved_rsi(%rip), %rsi
> > > +       movq    saved_rbp(%rip), %rbp
> > >
> > > -       movq    saved_rip, %rax
> > > +       movq    saved_rip(%rip), %rax
> > >         ANNOTATE_RETPOLINE_SAFE
> > >         jmp     *%rax
> > >  SYM_FUNC_END(wakeup_long64)
> > > @@ -72,11 +72,11 @@ SYM_FUNC_START(do_suspend_lowlevel)
> > >
> > >         movq    $.Lresume_point, saved_rip(%rip)
> > >
> > > -       movq    %rsp, saved_rsp
> > > -       movq    %rbp, saved_rbp
> > > -       movq    %rbx, saved_rbx
> > > -       movq    %rdi, saved_rdi
> > > -       movq    %rsi, saved_rsi
> > > +       movq    %rsp, saved_rsp(%rip)
> > > +       movq    %rbp, saved_rbp(%rip)
> > > +       movq    %rbx, saved_rbx(%rip)
> > > +       movq    %rdi, saved_rdi(%rip)
> > > +       movq    %rsi, saved_rsi(%rip)
> > >
> > >         addq    $8, %rsp
> > >         movl    $3, %edi
> > > --
