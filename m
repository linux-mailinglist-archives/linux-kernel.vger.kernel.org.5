Return-Path: <linux-kernel+bounces-95757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3F5875217
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E2891C230C7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBAE12DDB2;
	Thu,  7 Mar 2024 14:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaJG8oek"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A230F12D74E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 14:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709822558; cv=none; b=URscer033I/5Wp4eOmhgZu+y0oAy3cpsTmSQJCFOIjskDAgix1sxukAH5i8+2KATuWGWuEL4BN0dr0a9n4oDDc+3TkOfL2w4Ih1z257Ic8lEF8Vkm0Wa7CpeMl6wGdkFvjNBvUPFEaWz8/vxKqMRHk8dQXGwUTz9YZtCtNYGfFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709822558; c=relaxed/simple;
	bh=BCtC0J1BVQyEhzMboPoohzaFXtASIbM0oBUt0fB0/Ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g5bPG2vOoiaP8R1Zye6JcGh+vLMKGa9/Yb7UrxQo1gcm8VkiTrVE0QK/vEhf/FA1iVm8MC9vlYHB7QWU08DXw/M8fdHLmcfqeHI8zf/EjKPPLZM5uxspYQMAyKQ5YHszVnT5czppEtOp56Wzhz+U38rJHb+avKdn94kubdWQOYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eaJG8oek; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3189DC43330
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 14:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709822558;
	bh=BCtC0J1BVQyEhzMboPoohzaFXtASIbM0oBUt0fB0/Ug=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eaJG8oekAIxXciMpwN+qhP4SLNx02nipx7srXZ31nAPGHx496I7ge1B/JIzZJ35c9
	 q/F7go0cCHlB8BV2kqFvt6CeJJ72WXCRVJ5KwVyWBodoMR8HMckv01r1o8AH4GSma0
	 MOO/SA/xzDZYouY704KoqF+UZAVxfM3yylPLdBIHDMHg0J9h54Oy/BPtYnseLy19mh
	 RBStJGhLW1/Z5D10gjj/QQ6froCQc/qvqb451baDS3qWyMfcx62s3cauAdAqXJ0uLi
	 mjFGNJ3PXLqIUnI1LvcRiEiB0y+NjqWLvMkUU+jA43o7PstFTECRFn7cQK1qJDiZIq
	 yFufdgNI4fgXw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5131f3fc695so1026815e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 06:42:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUpMGz1+nbcY+3IFw9bwbiFf27Pd2ZoC/RkDsJ0Db3TpL160qj28Q76MuDz4AckOqmVpWiDxRuebSGTkMr7xJbyXy0vLMqWpkYp+YIs
X-Gm-Message-State: AOJu0YwCbuUNQnLJUWAZ9ufgJSprExFfn2kPUEPW1/hhPcVDVpQvMKc0
	JyG5EDXmod6vOGkF5ETEWgYE93Xn6j4sP2SDlkMLymefi855CcVFuJ7YUK4nL3xBPQBnJsP7bQI
	1MNb/59xyMcgdiHd2QyPUa/WkEKU=
X-Google-Smtp-Source: AGHT+IFsYf/+Kb8BDl1msaq/qBHGthys96Tnfl41qUSGSm941SBvuEf7BWi4KpdF0lf5C622YXyiKxQec1Z8JVxj5d8=
X-Received: by 2002:a05:6512:2386:b0:513:577b:df89 with SMTP id
 c6-20020a056512238600b00513577bdf89mr1823101lfv.51.1709822556144; Thu, 07 Mar
 2024 06:42:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307143027.206179-6-ardb+git@google.com>
In-Reply-To: <20240307143027.206179-6-ardb+git@google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 7 Mar 2024 15:42:24 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG8jYmdvwz7dd-23Gispcy0Eia0gA+155Jy7=qOdd7Fwg@mail.gmail.com>
Message-ID: <CAMj1kXG8jYmdvwz7dd-23Gispcy0Eia0gA+155Jy7=qOdd7Fwg@mail.gmail.com>
Subject: Re: [RFC PATCH v6.10 0/4] x86: Rid .head.text of all abs references
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Glaze <dionnaglaze@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

(remove bogus 'linux-kernel@google.com' from the To: line)

On Thu, 7 Mar 2024 at 15:30, Ard Biesheuvel <ardb+git@google.com> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> Questions below!
>
> This series removes the last remaining absolute symbol references from
> .head.text. Doing so is necessary because code in this section may be
> called from a 1:1 mapping of memory, which deviates from the mapping
> this code was linked and/or relocated to run at. This is not something
> that the toolchains support: even PIC/PIE code is still assumed to
> execute from the same mapping that it was relocated to run from by the
> startup code or dynamic loader. This means we are basically on our own
> here, and need to add measures to ensure the code works as expected in
> this manner.  (This work was inspired by boot problems on Clang-built
> SEV-SNP guest kernels, where the confusion between RIP-relative and
> absolute references was causing variable accesses to fault)
>
> Given that the startup code needs to create the kernel virtual mapping
> in the page tables, early references to some kernel virtual addresses
> are valid even if they cannot be dereferenced yet. To avoid having to
> make this distinction at build time, patches #3 and #4 replace such
> valid references with RIP-relative references with an offset applied.
>
> Patches #1 and #2 remove some absolute references from .head.text that
> don't need to be there in the first place.
>
> Questions:
> - How can we police this at build time? Could we teach objtool to check
>   for absolute ELF relocations in .head.text, or does this belong in
>   modpost perhaps?
>
> - Checking for absolute symbol references is not a complete solution, as
>   .head.text code could call into other code as well. Do we need rigid
>   checks for that too? Or could we have a soft rule that says you should
>   only call __head code from __head code?
>
> Cc: Kevin Loughlin <kevinloughlin@google.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Dionna Glaze <dionnaglaze@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Brian Gerst <brgerst@gmail.com>
> Cc: linux-kernel@vger.kernel.org
>
> Ard Biesheuvel (4):
>   x86/sev: Avoid WARN()s in early boot code
>   x86/xen/pvh: Move startup code into .ref.text
>   x86/boot/64: Determine VA/PA offset before entering C code
>   x86/boot/64: Avoid intentional absolute symbol references in
>     .head.text
>
>  arch/x86/include/asm/setup.h |  3 +-
>  arch/x86/kernel/head64.c     | 38 ++++++++++++--------
>  arch/x86/kernel/head_64.S    |  2 ++
>  arch/x86/kernel/sev.c        | 15 +++-----
>  arch/x86/platform/pvh/head.S |  2 +-
>  5 files changed, 33 insertions(+), 27 deletions(-)
>
>
> base-commit: 428080c9b19bfda37c478cd626dbd3851db1aff9
> --
> 2.44.0.278.ge034bb2e1d-goog
>

