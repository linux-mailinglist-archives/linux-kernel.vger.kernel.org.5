Return-Path: <linux-kernel+bounces-87648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA27086D6EB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8C661C20E06
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E9E20B12;
	Thu, 29 Feb 2024 22:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Id38DGnh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249C82031D
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 22:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709246210; cv=none; b=s6hNvSFiGBZOXZCydoSglE4XwZ0Qqy6WUrqlSxcpwA2IViOEo9Ba7f2+mCTDThRkyIQLxXbHXLK4VbNMtEFnGGY0Aciw2zphvqiPZXG7xPJjT895QMIkzexqvyRcE4KNIdK8uVH1iJxOrAHT5wbhh34e7+G2X78eLege1r+r+3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709246210; c=relaxed/simple;
	bh=XsV4KdkW4TNEr/QDbx65de2RXF67r9PQZcSEsFdidq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AvOidaIf3pQ+sjc3vLJ2/lz6eogjZuj+OBGD8qytaUeWIcftXYnqr8mT/N3U9T6gnnfHH8ZU74I02HyDIbZjYD3V62NBecuHY3Oq65mf4oj5GkN6V5RfHAaG+tisvi+TvyYXSO7P1POA0Kttff400jTblSNBjLV+YHA4lZVQzM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Id38DGnh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF287C43390
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 22:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709246209;
	bh=XsV4KdkW4TNEr/QDbx65de2RXF67r9PQZcSEsFdidq4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Id38DGnhV+QDbTaqMpPQmamfWPrZSaa+BxBtvMRrROMs1tgs8Hr5Vs6qeB5Gv0TER
	 amk7TlvWV3SSh3xkwnwMq4juN44VmFYcD+WrKZSBkHd+SUrzMGcQKJl1lsu9F9Z6eq
	 kELX5Mp3na3xEecjlwLjDWHbCjxcjOYVu+UnNVexbapUQIizzp0Ocfgv/a4xLovqCZ
	 uwHw7APiVLy3gK5uwpRRkZ97oBYnM3LduZNzWqTOq5RAR4GWJoJIEDvuTninJ+q4A5
	 DYzFdCNv7AgMQF/jQoAzHlsN3BeIbIoji1HCpdnVUuc50xnpRJGWFKB1jfBN0qm+aN
	 D3IUw0J111kqQ==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d311081954so11609521fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 14:36:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUh0qZXKj+CYnheMsEaq9Nohl2XJ1DLugQ234D/1ZjxCNRnJjyLhsW29gFI7HYxsbjg3KtqwmcnAaNgCVOr68LfBe8uMpyQT3kSN0Cw
X-Gm-Message-State: AOJu0YwXrc+K/Hv+kMw0zliAkUhYnkPDBQG1IUYcQazvmBLj6eX8RoKN
	8v+aEuiWxQu5hGSLIEGLV/GI2Ipn3s/3Bc0IbFpsc0vCZjP6Mo1xj4mvX9AZZUwT05EXxS98p52
	jlx/I1Ph5B4qwuA3WIyBAcE3r8IM=
X-Google-Smtp-Source: AGHT+IHWzpWJhSrBjBL7yoqTA6ojZYbiQQVb1yinYyEeRfj+fE4uZABfxxZj6gQ7uHySc0RjlkSUU25oqPet7u5oP1I=
X-Received: by 2002:a2e:a545:0:b0:2d2:c82c:b822 with SMTP id
 e5-20020a2ea545000000b002d2c82cb822mr3038689ljn.22.1709246207904; Thu, 29 Feb
 2024 14:36:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227151907.387873-11-ardb+git@google.com> <20240227151907.387873-12-ardb+git@google.com>
 <20240228134500.GHZd843I43EccJD1Ak@fat_crate.local>
In-Reply-To: <20240228134500.GHZd843I43EccJD1Ak@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 29 Feb 2024 23:36:36 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGigJnbCiXC0PjnWX-2R3y+KPeQLKHETe8DCEhiX2wYnQ@mail.gmail.com>
Message-ID: <CAMj1kXGigJnbCiXC0PjnWX-2R3y+KPeQLKHETe8DCEhiX2wYnQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/9] x86/startup_64: Simplify CR4 handling in startup code
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Glaze <dionnaglaze@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Feb 2024 at 14:45, Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Feb 27, 2024 at 04:19:09PM +0100, Ard Biesheuvel wrote:
> > +     /*
> > +      * Create a mask of CR4 bits to preserve. Omit PGE in order to clean
> > +      * global 1:1 translations from the TLBs.
>
> Brian raised this question when exactly global entries get flushed and
> I was looking for the exact definition in the SDM, here's what I'll do
> ontop:
>
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index 2d8762887c6a..24df91535062 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -186,8 +186,13 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
>  1:
>
>         /*
> -        * Create a mask of CR4 bits to preserve. Omit PGE in order to clean
> +        * Create a mask of CR4 bits to preserve. Omit PGE in order to flush
>          * global 1:1 translations from the TLBs.
> +        *
> +        * From the SDM:
> +        * "If CR4.PGE is changing from 0 to 1, there were no global TLB
> +        *  entries before the execution; if CR4.PGE is changing from 1 to 0,
> +        *  there will be no global TLB entries after the execution."
>          */
>         movl    $(X86_CR4_PAE | X86_CR4_LA57), %edx
>  #ifdef CONFIG_X86_MCE
> ---
>
> And how it is perfectly clear.
>

Looks good to me - thanks.

