Return-Path: <linux-kernel+bounces-82893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D15868B5E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 471091C22DE0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBD8135A7E;
	Tue, 27 Feb 2024 08:55:05 +0000 (UTC)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F01413329C;
	Tue, 27 Feb 2024 08:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709024104; cv=none; b=rXEOmqdir3uTTu3+eOpc76QHyNblSp9u4M2C/q9a1KASrpYIH8/aw5RlExBrHHS2qvvxcmJ4jYTOMkC4qSVG/27iPti3vQ6TlmYYE7v1lx8JaAOCESZbu82vdEJMo7h7ToBwGpbGSLGGhRVz/EOEbz+3FRbvYeV6Bt2XPjL7zhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709024104; c=relaxed/simple;
	bh=w0gu9IMca9J/tT97UVi+QQlbmYRnY/qPlnzkCAmcRmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDiLqt78d1pZ2S1Tb1FkKLnx94mBZ8nwKeznG/HyqexNmR5AVq9p5ZotplVzTYu9G8EJ+Qoo+Xp0n+fgYX1SWImlyuJisl0TexJ7oJ4MkKqXIyQPz8/oGrfx7YxsNjhpQ6qD/r5q8xsjowjC9YXLaFCiM3ZyrPTtpZoPOLEbQu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dcd94fb9e4dso4335346276.2;
        Tue, 27 Feb 2024 00:55:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709024100; x=1709628900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LF4kXg8LPe/h8pV/74EqYHGgPgOEfsUWLG6ibzoE1S0=;
        b=f2Bg3EyEtGlCwM51M/62aDzXI4s7OGN63gXUOY79QcnhwQKmabr8C6iSut1C/PbJ5h
         vNbj8atfcnADyY3EQOLs4Ud9k3jfv3i2Rg5YsCkR7anpEc+GfB9oxZwi6k9gTRnS2jYh
         Y8DRycFjh6a7fmNVCw4wiktzlPWgAKSuJcoAvl8hds+S6i05+hY5qP7syy8dBfSH0i8i
         NBtCYNYJgIEfElp9an2LXRZKWBf4ocCHevhGSXNeioJhfQGsbQSBQb03JzZ/QRAHQmhm
         z+6UUqlYlM8WmvcJ2Pmn0wx98+JSrFDJ2yi02eRoAQUngq6XHOCz4NC/xuR9rCwRvurS
         lYgg==
X-Forwarded-Encrypted: i=1; AJvYcCUAGt9Dcq91INDN10ya1N6dqpPJqHuOx2L8xtJYWp/wzBEabARyS+UjF9Brm6D2hNWCG4tXKmQ2wC7Qugqr3tXznNa1E5n7kSRRq5gFf2nrodn0DZzIRv9b+eIHmKwGPNQ9PZQOVdTzO1RRQl0lvsfsI11pZTel4qKPlKk3u+0TXZcjBprfpYKXQ/DFGH6rkxK4qQWwUDDj5IB1C4SveTauUKzE9V9wjVXUzyQTrJz5GdS8dv6LS7rNpPy1FRyl8Z191gQTKPXGAQs7w965O+VS8nFMcLsndb/cqcgA34DTvsL+ftPSzrAxztqzBW1z33tpifalPFdefau3/gKbqEA+6+ROeOTm4gmm0+U5oreqV0ze9pwwTh2bZkoy6xgoWHyRv+SpmKW18a5LTK4iIoQ1VhxFitr4ZqNd1F97x3Cdad5ILhQS8zkIqbpdyRcHCWE=
X-Gm-Message-State: AOJu0YzWmuwlu7gkPURT/33OGJKANODIOewWj/gxwWqyPjjRcFSBXulx
	Q4ZJCA+orBZrvGFDSrUKyKiZWdaockOs7dksLtWF+PMkG3efvlwBEQT6rCUQvSs9Fg==
X-Google-Smtp-Source: AGHT+IF6fBlPBGIbNwe5pvR/i412ulu8I80HirEh6M7o+3rMg/zmoNs20O9HToW4iddaXBJQVt0CZA==
X-Received: by 2002:a25:9183:0:b0:dce:2e9:a637 with SMTP id w3-20020a259183000000b00dce02e9a637mr1556137ybl.20.1709024099622;
        Tue, 27 Feb 2024 00:54:59 -0800 (PST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id g12-20020a5b070c000000b00dcc70082018sm1291748ybq.37.2024.02.27.00.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 00:54:58 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-607f8894550so28540027b3.1;
        Tue, 27 Feb 2024 00:54:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQZCNJPwsKHzVL3sGFO3bHYzIrdeYQOocmHIYrBsXWmqB37JGuO7UqeVv9/r24m5spmut7clWRl4Hz/3TFFOA3fkg3CFgxYxKFpSCL9eE5joi3Rumf/+dCYaYeoNOA0Z6KSdqMrWUD27RPvLyEzN/MatMAA4QwgXDmg5WP1XL2aOhdhSh4a+xpa4JIFtIo2BB7k6RXEdnjO16nZUSZy/5hrn5LqatGXRIkSOhZDbY4QmcyX3evPE5xCDhfFxSc0gVxMuzidZWcXezgd8p+psAOi8EaiizwLeZL9vmE/EZfc49rmH7kLzL07l/JomWkToy5znlAxXXa/dNm71JRNCZ1McORDfGKwdXr8kNG8zj2kYCW1N62DOBXtq5LWweLQ00waimg6FQSsJ/UdLmZYJ1omR2it5DDDcnDdSOOuNJvY9sDUNU2l/4LKGu5na6j5iI=
X-Received: by 2002:a25:71c3:0:b0:dcf:2b44:f38d with SMTP id
 m186-20020a2571c3000000b00dcf2b44f38dmr1589302ybc.49.1709024097788; Tue, 27
 Feb 2024 00:54:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226161414.2316610-1-arnd@kernel.org> <20240226161414.2316610-4-arnd@kernel.org>
In-Reply-To: <20240226161414.2316610-4-arnd@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Feb 2024 09:54:46 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWRBQF95fJ+NkPUdvpu5VfRm2WyTnvdqB1Xe7d4vsvY2g@mail.gmail.com>
Message-ID: <CAMuHMdWRBQF95fJ+NkPUdvpu5VfRm2WyTnvdqB1Xe7d4vsvY2g@mail.gmail.com>
Subject: Re: [PATCH 3/4] arch: define CONFIG_PAGE_SIZE_*KB on all architectures
To: Arnd Bergmann <arnd@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Kees Cook <keescook@chromium.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Arnd Bergmann <arnd@arndb.de>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Michal Simek <monstr@monstr.eu>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Helge Deller <deller@gmx.de>, 
	Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Palmer Dabbelt <palmer@dabbelt.com>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Andreas Larsson <andreas@gaisler.com>, 
	Richard Weinberger <richard@nod.at>, x86@kernel.org, Max Filippov <jcmvbkbc@gmail.com>, 
	Andy Lutomirski <luto@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Kieran Bingham <kbingham@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Mon, Feb 26, 2024 at 5:15=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Most architectures only support a single hardcoded page size. In order
> to ensure that each one of these sets the corresponding Kconfig symbols,
> change over the PAGE_SHIFT definition to the common one and allow
> only the hardware page size to be selected.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your patch!

> --- a/arch/m68k/Kconfig
> +++ b/arch/m68k/Kconfig
> @@ -84,12 +84,15 @@ config MMU
>
>  config MMU_MOTOROLA
>         bool
> +       select HAVE_PAGE_SIZE_4KB
>
>  config MMU_COLDFIRE
> +       select HAVE_PAGE_SIZE_8KB

I think you can do without this...

>         bool
>
>  config MMU_SUN3
>         bool
> +       select HAVE_PAGE_SIZE_8KB
>         depends on MMU && !MMU_MOTOROLA && !MMU_COLDFIRE
>
>  config ARCH_SUPPORTS_KEXEC
> diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
> index 9dcf245c9cbf..c777a129768a 100644
> --- a/arch/m68k/Kconfig.cpu
> +++ b/arch/m68k/Kconfig.cpu
> @@ -30,6 +30,7 @@ config COLDFIRE
>         select GENERIC_CSUM
>         select GPIOLIB
>         select HAVE_LEGACY_CLK
> +       select HAVE_PAGE_SIZE_8KB if !MMU

... if you would drop the !MMU-dependency here.

>
>  endchoice
>
> @@ -45,6 +46,7 @@ config M68000
>         select GENERIC_CSUM
>         select CPU_NO_EFFICIENT_FFS
>         select HAVE_ARCH_HASH
> +       select HAVE_PAGE_SIZE_4KB

Perhaps replace this by

    config M68KCLASSIC
            bool "Classic M68K CPU family support"
            select HAVE_ARCH_PFN_VALID
  +         select HAVE_PAGE_SIZE_4KB if !MMU

so it covers all 680x0 CPUs without MMU?

>         select LEGACY_TIMER_TICK
>         help
>           The Freescale (was Motorola) 68000 CPU is the first generation =
of

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

