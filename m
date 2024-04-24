Return-Path: <linux-kernel+bounces-157423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A25A8B117B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F41E6287497
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72F016D9B8;
	Wed, 24 Apr 2024 17:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7TJbDT+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3169516D9AC
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 17:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713981201; cv=none; b=i1SL0fZpQk5ec4GypJePP6zTEngmOvm5vGQ9+oumMPWtH6zXb/9XM7dJ5MU5pjv04U9T41LJ2S3NdDsGmOBp6SIk7/4kODhHdFdRri1PwjePCSQvSHcxPdnLPdrPaORzVQ3QmVZupqH0qfJayBSMkQCfRauKup790v7MnTYNTXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713981201; c=relaxed/simple;
	bh=+Y1ZPNAOnvDD7u2fc6pjhcGl3M0GcN9oDhwji0epk0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R4KAnV+E8TzaKJr7FZE1cXOhUdJfpU8N4TbofQm/DPjXahpXx4f2kd0WSXXQZlr9XtczBpGBE9ADE5iKIY25iCDOR+UN2W32dCR6CwZVRehVqDnB4QdgfjNh+byAyuK9abU/5KRiMKwE/jEpvaJanoA3gcT2NPB5rNNANOf8RXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7TJbDT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF568C3277B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 17:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713981200;
	bh=+Y1ZPNAOnvDD7u2fc6pjhcGl3M0GcN9oDhwji0epk0g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=K7TJbDT+N7svbG0vpuJ3tinrPlxPbSpYLtp0tmTSJJxEF8lWXbS4ZfQQ0yKa0gmIX
	 G22Me/FlYTVzNGx5XyXeq69E0TzV+ijG6TpTUM7Om01z/UunwKHVan0O5RCvguFWIE
	 hkNVdxtgOhfIpTSaQQFJIwINDUlvVWtMMYvkarw6xXoycLrMY27DMHWrW4kqJToyMk
	 ifIg+3psk4vZkqYnj4Cn7SV7pQ96PD14TJXtnXQmm2NFzDPsAM7V5oTXN37qJrYhHN
	 jzmpmnfKs4zJ3by7heppEANiCFdmYCrgc7pxxNot/SAnjeE4L42BvFiNFHXfgw2193
	 IBzCAWpeTVTIQ==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2de233961caso788881fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 10:53:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7ELTyXWjtMleAGciWbLx43baoNO7nG/UIQ/p+kUWq325e/HV7ilrWcS+pwg4PWwQlQ4JMdPrzIJESfeY82gzXPWzYOULtIGUOJDY3
X-Gm-Message-State: AOJu0Yx9diJ+nSrSxXGlFBI666CFeUCacD/nZkWMyjHdi3IYLG/UjooZ
	Kb+6TNvIaawbFhzmOmf/+SORkoh6FDV+I/SlEeGjewDNkzH9b/d1GEotuaIDh7tg44T4+rrfbeK
	i8W+KbAyUGLiRW7m5zA0rLkGclLo=
X-Google-Smtp-Source: AGHT+IGaD6kQNy3sBVHgLV0XgSMMkCYb1ikpsjan0+BbARzwtTCm4njehK8ovzBB0cJMh7B8yOnSvSuisxX5Cpbybo4=
X-Received: by 2002:a2e:a602:0:b0:2da:a3ff:5254 with SMTP id
 v2-20020a2ea602000000b002daa3ff5254mr2795618ljp.1.1713981198934; Wed, 24 Apr
 2024 10:53:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424155309.1719454-11-ardb+git@google.com>
 <20240424155309.1719454-15-ardb+git@google.com> <CAMzpN2g3E3Pj1wso0rUR5EWrHqTuUePsOWcQGf29wNkMa0+G3w@mail.gmail.com>
In-Reply-To: <CAMzpN2g3E3Pj1wso0rUR5EWrHqTuUePsOWcQGf29wNkMa0+G3w@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 24 Apr 2024 19:53:06 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE4f7UERE-x4CghW3=wQrvT1b2ODRSX3z6QAoy_wSJjiw@mail.gmail.com>
Message-ID: <CAMj1kXE4f7UERE-x4CghW3=wQrvT1b2ODRSX3z6QAoy_wSJjiw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/9] x86/purgatory: Avoid absolute reference to GDT
To: Brian Gerst <brgerst@gmail.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Kees Cook <keescook@chromium.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Brian,

Thanks for taking a look.

On Wed, 24 Apr 2024 at 19:39, Brian Gerst <brgerst@gmail.com> wrote:
>
> On Wed, Apr 24, 2024 at 12:06=E2=80=AFPM Ard Biesheuvel <ardb+git@google.=
com> wrote:
> >
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > The purgatory is almost entirely position independent, without any need
> > for any relocation processing at load time except for the reference to
> > the GDT in the entry code. Generate this reference at runtime instead,
> > to remove the last R_X86_64_64 relocation from this code.
> >
> > While the GDT itself needs to be preserved in memory as long as it is
> > live, the GDT descriptor that is used to program the GDT can be
> > discarded so it can be allocated on the stack.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/purgatory/entry64.S | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/x86/purgatory/entry64.S b/arch/x86/purgatory/entry64.=
S
> > index 9913877b0dbe..888661d9db9c 100644
> > --- a/arch/x86/purgatory/entry64.S
> > +++ b/arch/x86/purgatory/entry64.S
> > @@ -16,7 +16,11 @@
> >
> >  SYM_CODE_START(entry64)
> >         /* Setup a gdt that should be preserved */
> > -       lgdt gdt(%rip)
> > +       leaq    gdt(%rip), %rax
> > +       pushq   %rax
> > +       pushw   $gdt_end - gdt - 1
> > +       lgdt    (%rsp)
> > +       addq    $10, %rsp
>
> This misaligns the stack, pushing 16 bytes on the stack but only
> removing 10 (decimal).
>

pushw subtracts 2 from RSP and stores a word. So the total size stored
is 10 decimal not 16.

> >
> >         /* load the data segments */
> >         movl    $0x18, %eax     /* data segment */
> > @@ -83,8 +87,8 @@ SYM_DATA_START_LOCAL(gdt)
> >          * 0x08 unused
> >          * so use them as gdt ptr
>
> obsolete comment
>
> >          */
> > -       .word gdt_end - gdt - 1
> > -       .quad gdt
> > +       .word 0
> > +       .quad 0
> >         .word 0, 0, 0
>
> This can be condensed down to:
>         .quad 0, 0
>

This code and the comment are removed in the next patch.

