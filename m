Return-Path: <linux-kernel+bounces-157411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 945108B114A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 770AEB237E0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8204316D4DC;
	Wed, 24 Apr 2024 17:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8SOGWuO"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4758716D4CC
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 17:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713980354; cv=none; b=SSRGuVPY+JfscHRnVRwUNQ6i6FNFs60tDgDThCKuG6lfjLzOB5sweYKJSw3Cn56niMnKk3S24O0YANKqJEaniYnsJxM09ONG3wPbz3eFASOeEgI0il36SL070A2yev03PZs0P/48VBDK1hriSCc91MQRsMRkYZK1IXXFqikCA44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713980354; c=relaxed/simple;
	bh=z5NkQGPiv4L8AtwPo7Ek6ZUSPG+b0A9bAFw1kr+jIu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SpKbo2C5saUCGIy9YPcmePMMWNXogpk8NoOHjHwTNObi+BJWWEXEeKVC0ojtazRBs+BdJuCbQlY0fXv3ApdNfxTWRnIEdHglyjUWYaCEcRMUtT7T18O2eqsBFugyZqGkyKhc7E2OYw5XZ5dEAc8Q0uzTejQFmN2MTIbuOQMbmSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8SOGWuO; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51abf1a9332so58054e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 10:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713980351; x=1714585151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynaUrY5l+597sEJ6P7ZfnwDusY+Y+Lu9dBF7Lyaug0M=;
        b=Z8SOGWuO5bHh1cEeYG1LjKvMS5JwybhRWzsB0TN0J574jfXdp5kCOGkHWmoAzB2Mo2
         Z5axwrGhvXKD65UUwebGqJwzDh4amr6rqB1tgkxASXsnEZZRTwNtinBbiLxXkBAT4iCi
         p4PRki4r7st/lwfWJlKoybyJdR/tpCUk+Cqgu7RbqIscIX8Pq/EWKuEAJEw1OvEYRdGq
         bhtvD/SAQIx8RQ2E+xpWwnydxqO2BrzrtBdtFYYhLsDVHaNP4BiJBmVtWKdSUCoxK254
         Fm0aVUJPrlXd8oWFA2/CPM+d1D7yT/CthUIgfSef9KQ6B9bbxNr5Q3xEyqG0GC7K6X1A
         g/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713980351; x=1714585151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynaUrY5l+597sEJ6P7ZfnwDusY+Y+Lu9dBF7Lyaug0M=;
        b=WOTzENecFg29TcYrlzgl7p5A3AWy7JggxJb5KbjNNdJR+i9019P8uZazEMJEBuGrMo
         0TXg1Alei8gJ2n2wbnPi62EiJoxuW+CXAIWphMywV4oV1Oim6k+2NTx53+H/BJgX4tEC
         5imCyyiHnooljDuwWZwm4FXzaoDWv9b8r0aHZIHBqkBCOGK1ldeDuBvcOg+8xcBLU57U
         FOi2mvRAblm/Tn/SzS/7JO7Qq0Vo1v7L3wYUMYwyiaP9A/hlgIIAemsPeQcAC0A3rWkJ
         KnhoD0QvZ3gUZUJZXeTlUEgUZKhi26ycrue49MNVEsc2Snqlyed+8CUie2kxH/InRzuk
         IaeA==
X-Gm-Message-State: AOJu0Yz+J0fA+8GYJqNtgy/6anIG4KBnPMXonVmcFx8dUxY7fwJNojKX
	K+xdDiGddi9mPXG0N+OAQEA2DOKrjCeT9IGrRqFzAiLZYUPHuzAymlV1aSF5a8b6D2eTYCTsLRo
	UsoJFwXZIqiS4bWNDJLkw1uNq9HUaC2Y=
X-Google-Smtp-Source: AGHT+IGA4hqEI61enJ9DfoX5fsFrF3OkliS1nO9fyos5bePwboWZ6OpjfqsYgEZaFOhR9vir/bkYtUhStH/yT7TMC2M=
X-Received: by 2002:ac2:4ed0:0:b0:518:90fd:fa40 with SMTP id
 p16-20020ac24ed0000000b0051890fdfa40mr2071996lfr.2.1713980351078; Wed, 24 Apr
 2024 10:39:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424155309.1719454-11-ardb+git@google.com> <20240424155309.1719454-15-ardb+git@google.com>
In-Reply-To: <20240424155309.1719454-15-ardb+git@google.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Wed, 24 Apr 2024 13:38:59 -0400
Message-ID: <CAMzpN2g3E3Pj1wso0rUR5EWrHqTuUePsOWcQGf29wNkMa0+G3w@mail.gmail.com>
Subject: Re: [RFC PATCH 4/9] x86/purgatory: Avoid absolute reference to GDT
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Eric Biederman <ebiederm@xmission.com>, 
	kexec@lists.infradead.org, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@chromium.org>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 12:06=E2=80=AFPM Ard Biesheuvel <ardb+git@google.co=
m> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> The purgatory is almost entirely position independent, without any need
> for any relocation processing at load time except for the reference to
> the GDT in the entry code. Generate this reference at runtime instead,
> to remove the last R_X86_64_64 relocation from this code.
>
> While the GDT itself needs to be preserved in memory as long as it is
> live, the GDT descriptor that is used to program the GDT can be
> discarded so it can be allocated on the stack.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/purgatory/entry64.S | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/purgatory/entry64.S b/arch/x86/purgatory/entry64.S
> index 9913877b0dbe..888661d9db9c 100644
> --- a/arch/x86/purgatory/entry64.S
> +++ b/arch/x86/purgatory/entry64.S
> @@ -16,7 +16,11 @@
>
>  SYM_CODE_START(entry64)
>         /* Setup a gdt that should be preserved */
> -       lgdt gdt(%rip)
> +       leaq    gdt(%rip), %rax
> +       pushq   %rax
> +       pushw   $gdt_end - gdt - 1
> +       lgdt    (%rsp)
> +       addq    $10, %rsp

This misaligns the stack, pushing 16 bytes on the stack but only
removing 10 (decimal).

>
>         /* load the data segments */
>         movl    $0x18, %eax     /* data segment */
> @@ -83,8 +87,8 @@ SYM_DATA_START_LOCAL(gdt)
>          * 0x08 unused
>          * so use them as gdt ptr

obsolete comment

>          */
> -       .word gdt_end - gdt - 1
> -       .quad gdt
> +       .word 0
> +       .quad 0
>         .word 0, 0, 0

This can be condensed down to:
        .quad 0, 0

>
>         /* 0x10 4GB flat code segment */
> --
> 2.44.0.769.g3c40516874-goog

Brian Gerst

