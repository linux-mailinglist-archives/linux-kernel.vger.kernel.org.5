Return-Path: <linux-kernel+bounces-83106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9B4868E85
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B44F280D12
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26508139585;
	Tue, 27 Feb 2024 11:12:45 +0000 (UTC)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7602B2E3EB;
	Tue, 27 Feb 2024 11:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709032364; cv=none; b=UvZ6ncQafE5X7ZxYTwbr4/qk3Szgpgk/S2afd5CUsYjM9xBZs+V2C9SH8wCdiX8zURVNBuFlu3ymVcGE0OFwjmItc859WTuBpmFEo3XwBTfTfB6pxUDVzz1v/ekiatRR7jUkYVu1LrfHlWQF9QQdsj9kJjzRqAuiw3P5+RrB/Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709032364; c=relaxed/simple;
	bh=O6UtDTaDn834cQ2sd7oFrdw4KjK6pBp4PggykizhEd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dAon+2Wqgs5mgEFM6HzbArhplBYgJvSg1kXDMhDsKr7chV2IGolbe9sUyAKskLr7S1Y1wu0QghEKZPIdOAEHrzqugzaZzYMhNSKDX1nwq4Iv/Wx0uCtLz6BoJx9ipTSUXyQU37758R11TqT2pjk/I7xicwR6rSvAbD7fmQ6bVDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc74435c428so3652655276.2;
        Tue, 27 Feb 2024 03:12:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709032359; x=1709637159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4Tv6sdcFEpWvZL/hYJEF+Ju7qt4AFqMkWFUs5NrLKU=;
        b=XlvnddtZ4johgU9/5+buUiyDpQ5Jbj8Tuf4my854g4XpXYKFN48vHp5KeekbM1ERs5
         NiloCLwMI7JPYWGvGsb8IaHLU3zRBY6db8IfxoNCT+Zscb4TNIU8yDWOUl1Dw8+OsPEZ
         pznXFRWYdzCYK6AaQZWcoUYoZz4gS3DGSf75WfeAdIJWbpe1ejqXRsK8YdzDQ1cvWkF6
         VU7mZAnTFGRyRo/k6pfAVT2I6qWjx/FA6u3mz7fzMIYS86FSB0491VkpvE8tz1yvywgy
         rqkEIQ7CDSGuMsw6ek3iMNNDE8zfAtofFt67Yj4VFxbqAzvGJt+KWWcPlNdME2x4riqT
         89Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUj5sRr5b0C//W2SkdJfcpWnffZClWuYQ5KBjLMe4ipQVw1xqIsuwvAMuQQKUIQZsXXNSy6vu7c+e6eieTeeFPUoaZwYk90Yc4pWrut92BIbeN/whH+6piUJ2IHxSmFlZ2yYDji5WAYvdjquHTo98vhDjwHbVN+f+5eMw/XSEe+vG9QzV2cRyZJGov/2r9g8Jxb7t7ijqjab/ksNCQLilniFhJfEubRNpTN2B2sHqDADJIe4yVUpaJOBG1mMAD0wEKGkvebgzVgxlc0k/kjVS2bOnjabG22NU9pAQOxBePFA6iXft6ibNDrV9RNbvq0fSeKTea8zroiuuOMbWDVVQEWqLpgoGI+rOx0Ie2T7u/6zGxN9YnzE9D7o/E55WFUUsZ47GqTzACggzg9cNi1xLPA7zCMLStQVdfvoqLws8vp9OqcjEVibRqjPCmveVatwlY=
X-Gm-Message-State: AOJu0Yz5jXGAXgh/loZYZu2eeJzcP6IPqUgJxp159KluuliwT1CM3WFC
	KadHKYA3veNOfiLzzqJLK8e9a88L7/sZoOp0ZocAO3jSbb+Yll6OcZ7V+pKnvDgT4A==
X-Google-Smtp-Source: AGHT+IETWZx9cfssblm2zEGiTblfHf+yjPph+wwZhXlTNPdioDGjYTOCezommzy9CyvZ1fs6U0ag6A==
X-Received: by 2002:a25:bb10:0:b0:dcb:c0ea:6abc with SMTP id z16-20020a25bb10000000b00dcbc0ea6abcmr1548115ybg.64.1709032358999;
        Tue, 27 Feb 2024 03:12:38 -0800 (PST)
Received: from mail-yb1-f177.google.com ([209.85.219.177])
        by smtp.gmail.com with ESMTPSA id u9-20020a250949000000b00dc2310abe8bsm1323073ybm.38.2024.02.27.03.12.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 03:12:38 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc74435c428so3652590276.2;
        Tue, 27 Feb 2024 03:12:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXwJ7/jVOAgdcYZyQ0Vk8kCXWfNsvprfIws3P1kaOPxSJ0zj+XIQydNNGFJGusQM6fKKXLKco21/XCmtn+bPkPZ0/z9guqENNV7tGjku2PsNOPslSYQkQsdsuQRX21S+bNcXxVGYHNdAyy5Ot5MtPoeQ9bH+9fQzW0aKy7Ffkn+oHjAbxcsR1/ltfgvAQ6+VVgO4Ssvt0NpZYNMMO/KyBID3Z3d7H+lorVXbXm8zKHmPzAA1ND04hosm4ujae0LXiyylSJcdXfRPgKkIQfT5aBy5HfVnAh05Zs1ioV4NurG3t2F6EFmMeTKPN1cjJ/EKJNmEFsOW9iNsqo1TYos27sdLBEngOxlFGXqpuzvcViDF8PzCCEndZC5PlAoWeHi2nA+JE6qZqHjwXyXEuT7uiIYzlNIq08mL/GA+N6SNzl+Ka9YwLMJo9JSB66uvK9vZSg=
X-Received: by 2002:a5b:ecc:0:b0:dc6:c32f:6126 with SMTP id
 a12-20020a5b0ecc000000b00dc6c32f6126mr1607871ybs.22.1709032357452; Tue, 27
 Feb 2024 03:12:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226161414.2316610-1-arnd@kernel.org> <20240226161414.2316610-4-arnd@kernel.org>
 <CAMuHMdWRBQF95fJ+NkPUdvpu5VfRm2WyTnvdqB1Xe7d4vsvY2g@mail.gmail.com> <164616c2-94f6-40e8-86e0-850dc8da212e@app.fastmail.com>
In-Reply-To: <164616c2-94f6-40e8-86e0-850dc8da212e@app.fastmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Feb 2024 12:12:24 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXQYPtL0J4Phm81S1qWpi7no=1r4uStbLd8zbjn7fcWQw@mail.gmail.com>
Message-ID: <CAMuHMdXQYPtL0J4Phm81S1qWpi7no=1r4uStbLd8zbjn7fcWQw@mail.gmail.com>
Subject: Re: [PATCH 3/4] arch: define CONFIG_PAGE_SIZE_*KB on all architectures
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Kees Cook <keescook@chromium.org>, 
	Anna-Maria Gleixner <anna-maria@linutronix.de>, Matt Turner <mattst88@gmail.com>, 
	Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, guoren <guoren@kernel.org>, 
	Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Palmer Dabbelt <palmer@dabbelt.com>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Andreas Larsson <andreas@gaisler.com>, 
	Richard Weinberger <richard@nod.at>, x86@kernel.org, Max Filippov <jcmvbkbc@gmail.com>, 
	Andy Lutomirski <luto@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Kieran Bingham <kbingham@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, 
	"linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	Greg Ungerer <gerg@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

CC Greg

On Tue, Feb 27, 2024 at 11:59=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrot=
e:
> On Tue, Feb 27, 2024, at 09:54, Geert Uytterhoeven wrote:
> >> diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
> >> index 9dcf245c9cbf..c777a129768a 100644
> >> --- a/arch/m68k/Kconfig.cpu
> >> +++ b/arch/m68k/Kconfig.cpu
> >> @@ -30,6 +30,7 @@ config COLDFIRE
> >>         select GENERIC_CSUM
> >>         select GPIOLIB
> >>         select HAVE_LEGACY_CLK
> >> +       select HAVE_PAGE_SIZE_8KB if !MMU
> >
> > .... if you would drop the !MMU-dependency here.
> >
> >>
> >>  endchoice
> >>
> >> @@ -45,6 +46,7 @@ config M68000
> >>         select GENERIC_CSUM
> >>         select CPU_NO_EFFICIENT_FFS
> >>         select HAVE_ARCH_HASH
> >> +       select HAVE_PAGE_SIZE_4KB
> >
> > Perhaps replace this by
> >
> >     config M68KCLASSIC
> >             bool "Classic M68K CPU family support"
> >             select HAVE_ARCH_PFN_VALID
> >   +         select HAVE_PAGE_SIZE_4KB if !MMU
> >
> > so it covers all 680x0 CPUs without MMU?
>
> I was a bit unsure about how to best do this since there
> is not really a need for a fixed page size on nommu kernels,
> whereas the three MMU configs clearly tie the page size to
> the MMU rather than the platform.
>
> There should be no reason for coldfire to have a different
> page size from dragonball if neither of them actually uses
> hardware pages, so one of them could be changed later.

Indeed, in theory, PAGE_SIZE doesn't matter for nommu, but the concept
of pages is used all over the place in Linux.

I'm mostly worried about some Coldfire code relying on the actual value
of PAGE_SIZE in some other context. e.g. for configuring non-cacheable
regions.

And does this impact running nommu binaries on a system with MMU?
I.e. if nommu binaries were built with a 4 KiB PAGE_SIZE, do they
still run on MMU systems with an 8 KiB PAGE_SIZE (coldfire and sun3),
or are there some subtleties to take into account?

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

