Return-Path: <linux-kernel+bounces-71148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE4885A157
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6126B215EF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A69124B5B;
	Mon, 19 Feb 2024 10:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2hEFR4fx"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013B928DAE
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 10:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708339801; cv=none; b=RikheSUFMYUPjytg8Xs1zl3rAkGP6tD5k0Z8C8kUErlwjILdusr0QwowDNxDRWVhc2d2UmL6rEZEyto0uBaVLdXzupvkPF71VuRMP7F0wBPQElU67Y1hYK4VLizVD33f54VTYoHtzNWlKnon24JdNddydR1lYIC/mbWW7vQup2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708339801; c=relaxed/simple;
	bh=3caDZanIGLjsT+cFQP8A69Yvh0OigCSpUrynDatp140=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=txucsC5e76J2x1xfAb9htMza+mIP++SjFTcGAcPoT3nnjSuI031S0y2Eki8xFJDgviUYb1C/P21WEuuM2JDSY2BQ/19dLHve1tseENA0Wqm7khQS+LmpP+oo2QjM7KGKfmHiiVSBBOY7DNDKJ+V73Y2K6dn4m8ivrKaHAVEW6qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2hEFR4fx; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-42db1baff53so444541cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 02:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708339799; x=1708944599; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4MQJOsm12yyUfLXP8/4qqlhf10T9ODzbVu9qmdeeCKA=;
        b=2hEFR4fxKnlsFeGEVNr/qv4PQvCyfYvC+d9/8kWNEzk6SKYxPNpWfhf5o5Q1auQyC2
         wDgzLGB7UDtRnsjqXZPAu7gRGXLF5DS0lukmMACxeWMmesfyrH0FU5sx7s6GEWU9yZ54
         Nx+VXV9nd/K1TFaSlAOTmbWMNdE/RHReLbQKO+XON+g3/ssXHMtxem/0Js91koXwRA+m
         xcx9WxxpAeRYzDft2w8cJ+dMiw2Wb2CIGtZfT9Bm2R9X2aRjs9j8RseP/wdZLqGFk39K
         be7xHTi96ld2XWpqCBivxhNBmBi+gxOeIhNRLz2gr1sg7Se4bhY0xqM/pKFngxi0PtYi
         /Gbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708339799; x=1708944599;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4MQJOsm12yyUfLXP8/4qqlhf10T9ODzbVu9qmdeeCKA=;
        b=r2EoRBDZXT1UOQDA1nLvfSfQNqbJ3mgSESZGXKym7UyM4FAgep+cHIDYPdrQ87c4Te
         5gk5eCKXJulSTrvkD7519k3xj6W+0rfiQpJDlIDBcHaFfwj+Kiudu/9iGCTi+c4Cj5a7
         mWBAfu1hJsJHbOISj1C3kAqdE6tiVlSeWcXM1Y0IbYsaI1LAZd1scIGr3pyW08E7NO2P
         iRypFgT5qm0MYOPbq4kreXE9WFTj2STWt9CXk3PpiGxjV5NsJyl1fWrizBBahWyZCUXt
         rjsgZhe7zg06WO4tHGUgRs96183BJ257buFJ8oyNuPMhSGDpKCAjYHFZTgH4Iucn38+K
         neiQ==
X-Gm-Message-State: AOJu0Yzb4Qsk59Vg2kvQondM/jfMsE2pPzh2H6ONSgnDzYb3CiE1m9yb
	keKhorfMzIT1AZEKv97q6k1gtvCwnvQ8z88uxfcpXMvTQJoUyMvux68Rign3a8SNeJvl6SQ45LD
	UuO91x8loWxz7AKIO+5lsFhcZvuTwtIUP8r9KSWFabK+ysxJ8xk6m
X-Google-Smtp-Source: AGHT+IGQ3I/aQGWBoJspcQrSw1w3ASDBmL/gBK5tPjmFECJ/hUYGLZoPWzh2dgfJUeX1ISygd655BEwvUdSatAsRr24=
X-Received: by 2002:ac8:5a55:0:b0:42e:16af:b149 with SMTP id
 o21-20020ac85a55000000b0042e16afb149mr112959qta.26.1708339798691; Mon, 19 Feb
 2024 02:49:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108113950.360438-1-jackmanb@google.com> <170612139384.398.13715690088153668463.tip-bot2@tip-bot2>
In-Reply-To: <170612139384.398.13715690088153668463.tip-bot2@tip-bot2>
From: Brendan Jackman <jackmanb@google.com>
Date: Mon, 19 Feb 2024 11:49:46 +0100
Message-ID: <CA+i-1C1OpZQTS3EQa8fEc5BTzcLNMcgrwt0b9mR_jqiY0-zV3A@mail.gmail.com>
Subject: Re: [tip: x86/entry] x86/entry: Avoid redundant CR3 write on paranoid returns
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>, 
	Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, Kevin Cheng <chengkev@google.com>, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

[Apologies if you see this as a duplicate, accidentally sent the
original in HTML, please disregard the other one]

Hi Thomas,

I have just noticed that the commit has disappeared from
tip/x86/entry. Is that deliberate?

Thanks,
Brendan


On Wed, 24 Jan 2024 at 19:36, tip-bot2 for Lai Jiangshan
<tip-bot2@linutronix.de> wrote:
>
> The following commit has been merged into the x86/entry branch of tip:
>
> Commit-ID:     bb998361999e79bc87dae1ebe0f5bf317f632585
> Gitweb:        https://git.kernel.org/tip/bb998361999e79bc87dae1ebe0f5bf317f632585
> Author:        Lai Jiangshan <laijs@linux.alibaba.com>
> AuthorDate:    Mon, 08 Jan 2024 11:39:50
> Committer:     Thomas Gleixner <tglx@linutronix.de>
> CommitterDate: Wed, 24 Jan 2024 13:57:59 +01:00
>
> x86/entry: Avoid redundant CR3 write on paranoid returns
>
> The CR3 restore happens in:
>
>   1. #NMI return.
>   2. paranoid_exit() (i.e. #MCE, #VC, #DB and #DF return)
>
> Contrary to the implication in commit 21e94459110252 ("x86/mm: Optimize
> RESTORE_CR3"), the kernel never modifies CR3 in any of these exceptions,
> except for switching from user to kernel pagetables under PTI. That
> means that most of the time when returning from an exception that
> interrupted the kernel no CR3 restore is necessary. Writing CR3 is
> expensive on some machines.
>
> Most of the time because the interrupt might have come during kernel entry
> before the user to kernel CR3 switch or the during exit after the kernel to
> user switch. In the former case skipping the restore would be correct, but
> definitely not for the latter.
>
> So check the saved CR3 value and restore it only, if it is a user CR3.
>
> Give the macro a new name to clarify its usage, and remove a comment that
> was describing the original behaviour along with the not longer needed jump
> label.
>
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/r/20240108113950.360438-1-jackmanb@google.com
>
> [Rewrote commit message; responded to review comments]
> Change-Id: I6e56978c4753fb943a7897ff101f519514fa0827
> ---
>  arch/x86/entry/calling.h  | 26 ++++++++++----------------
>  arch/x86/entry/entry_64.S |  7 +++----
>  2 files changed, 13 insertions(+), 20 deletions(-)
>
> diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
> index 9f1d947..92dca4a 100644
> --- a/arch/x86/entry/calling.h
> +++ b/arch/x86/entry/calling.h
> @@ -239,17 +239,19 @@ For 32-bit we have the following conventions - kernel is built with
>  .Ldone_\@:
>  .endm
>
> -.macro RESTORE_CR3 scratch_reg:req save_reg:req
> +/* Restore CR3 from a kernel context. May restore a user CR3 value. */
> +.macro PARANOID_RESTORE_CR3 scratch_reg:req save_reg:req
>         ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_PTI
>
> -       ALTERNATIVE "jmp .Lwrcr3_\@", "", X86_FEATURE_PCID
> -
>         /*
> -        * KERNEL pages can always resume with NOFLUSH as we do
> -        * explicit flushes.
> +        * If CR3 contained the kernel page tables at the paranoid exception
> +        * entry, then there is nothing to restore as CR3 is not modified while
> +        * handling the exception.
>          */
>         bt      $PTI_USER_PGTABLE_BIT, \save_reg
> -       jnc     .Lnoflush_\@
> +       jnc     .Lend_\@
> +
> +       ALTERNATIVE "jmp .Lwrcr3_\@", "", X86_FEATURE_PCID
>
>         /*
>          * Check if there's a pending flush for the user ASID we're
> @@ -257,20 +259,12 @@ For 32-bit we have the following conventions - kernel is built with
>          */
>         movq    \save_reg, \scratch_reg
>         andq    $(0x7FF), \scratch_reg
> -       bt      \scratch_reg, THIS_CPU_user_pcid_flush_mask
> -       jnc     .Lnoflush_\@
> -
>         btr     \scratch_reg, THIS_CPU_user_pcid_flush_mask
> -       jmp     .Lwrcr3_\@
> +       jc      .Lwrcr3_\@
>
> -.Lnoflush_\@:
>         SET_NOFLUSH_BIT \save_reg
>
>  .Lwrcr3_\@:
> -       /*
> -        * The CR3 write could be avoided when not changing its value,
> -        * but would require a CR3 read *and* a scratch register.
> -        */
>         movq    \save_reg, %cr3
>  .Lend_\@:
>  .endm
> @@ -285,7 +279,7 @@ For 32-bit we have the following conventions - kernel is built with
>  .endm
>  .macro SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg:req save_reg:req
>  .endm
> -.macro RESTORE_CR3 scratch_reg:req save_reg:req
> +.macro PARANOID_RESTORE_CR3 scratch_reg:req save_reg:req
>  .endm
>
>  #endif
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index c40f89a..aedd169 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -968,14 +968,14 @@ SYM_CODE_START_LOCAL(paranoid_exit)
>         IBRS_EXIT save_reg=%r15
>
>         /*
> -        * The order of operations is important. RESTORE_CR3 requires
> +        * The order of operations is important. PARANOID_RESTORE_CR3 requires
>          * kernel GSBASE.
>          *
>          * NB to anyone to try to optimize this code: this code does
>          * not execute at all for exceptions from user mode. Those
>          * exceptions go through error_return instead.
>          */
> -       RESTORE_CR3     scratch_reg=%rax save_reg=%r14
> +       PARANOID_RESTORE_CR3 scratch_reg=%rax save_reg=%r14
>
>         /* Handle the three GSBASE cases */
>         ALTERNATIVE "jmp .Lparanoid_exit_checkgs", "", X86_FEATURE_FSGSBASE
> @@ -1404,8 +1404,7 @@ end_repeat_nmi:
>         /* Always restore stashed SPEC_CTRL value (see paranoid_entry) */
>         IBRS_EXIT save_reg=%r15
>
> -       /* Always restore stashed CR3 value (see paranoid_entry) */
> -       RESTORE_CR3 scratch_reg=%r15 save_reg=%r14
> +       PARANOID_RESTORE_CR3 scratch_reg=%r15 save_reg=%r14
>
>         /*
>          * The above invocation of paranoid_entry stored the GSBASE

