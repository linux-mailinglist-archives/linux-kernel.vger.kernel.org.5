Return-Path: <linux-kernel+bounces-82880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8906868B1C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D99531C2245B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF850130E44;
	Tue, 27 Feb 2024 08:45:21 +0000 (UTC)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3890B7E761;
	Tue, 27 Feb 2024 08:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709023521; cv=none; b=o4wNq5ZiPDTPXhv+0uzQ5CTC0ZFqmWJZ0i5TXNxWVGMTRM+hspM7xKVZpX4DtYCm1Nt+KldqYGE9RbfrJa3a5jcu9QeEiY2H6N2vZYeGsjknj50MnYLPo6J1LI20pLJ7rdq3BdfS1fbwv/cPJrB5Tv1kGYjRoV+EzHYTNzvWSTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709023521; c=relaxed/simple;
	bh=ZH6cCYrbNG2YOChcX3vTXEnEeEOKhVq2+yJTwt6+8Uw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eUqdt1uG8D/nJ50mwt7PSu3Z75Odpa6YXWExpy+2cWu28yfrTVTSIYjJTiysBtzrLfEfmAykBYDz1Ie+tCMv49NkhZqQhcEBQebB3Zk0azWMx2Mat6DujBxh3BvKxQeCYZEv6IlIadb9NXSMGZodRnF9uExsFQRyUt3KLdbuKf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-608ccac1899so35121427b3.1;
        Tue, 27 Feb 2024 00:45:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709023516; x=1709628316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uzwNvfzqcMx0O3hVp46LgRJMNTPfRBstut9NEe744kY=;
        b=cJSC5aM6iZiP0uXA9Yt0WnHjrS2ukJlLbB/0r4JVpgSuDb4rWbNAkf+dC0SMjRi7vH
         bXd20MePWypWNvuCxeN2KitYYOA7jbt5L/oiaV5FlaVTojZat/x4ThHtE20uDKjstbiS
         fzKMWrHugz1vvEtJkqIDcCQqyIf+m8xs+hENCZuj81vUNT7Bff4wariSZ/lKl//dUvEG
         YPA691199MJn7zdiIYCaygAcElqSLft/6F98J+KRD0oc9LwOYsWjMHW1HqMJC44qjMDB
         OpHlpDsSJWq9R/ljVmrAbfP687zCTWuBcbhRfe0oMCNbmpuqvjGFkhWCI/ymc7v0wFus
         6v/g==
X-Forwarded-Encrypted: i=1; AJvYcCV0vDkvkBkCUNM2wiBjHBJUs7UB36foU5i3paQlyjNoLlk20DnL0CnWdPM4naQEJEkmED4OnN5YNOBqWFGxXz8VRNRT1R5XdlEqnmdp54XrzdwjKAGsZraoPp1Dmfmj9iQ5n/9kRPsst/dg/IkolRYvWtLQSdwLV67SwWUUgXqxIYiLVapa2viGW3MNXU1xwtlVtGhFDAv+t/sMqoj2uCzcilZ2idrMxycco4WN16syv2IndQAUPC4qWHsv6FNscAJP65eQ2HIbWSjuAaHfYC3r3mxrB8dQb1cT17QilSAUO1OMHRglLd1V1Q8z9Ikwt2YOTwpwoKVel4Hxgi8xXOGfz5gCKd5AgV1K44jmfy/CQMgWei8LlzH3gaI9E71NcTRmnHdEQ3tD7Fxh5OI99d8VQbinWfhPSg4GI90JvNzk0mZw8nqzhgTgVJUBySy+VTk=
X-Gm-Message-State: AOJu0YwIdzZSITMn8oKOy6uRD8YQP9oziD0ucpIT7uAuDtK/Fa10YKyK
	nknmvoN+J4Hg9xCkqDASXBtbn7b6ljJSihexvFsi8IiCFCJuc4m7JxXjYnvr9Urp4g==
X-Google-Smtp-Source: AGHT+IHl2FoPiw3CuCjEEe/3xZwOwIKpIw+W35v0nWwhkK550t4lTcJi5yO2PlZ0F1Wkx28T7xPO0g==
X-Received: by 2002:a0d:ec02:0:b0:609:254f:86cb with SMTP id q2-20020a0dec02000000b00609254f86cbmr1195692ywn.0.1709023516275;
        Tue, 27 Feb 2024 00:45:16 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id y132-20020a81a18a000000b0060799657d41sm1637415ywg.22.2024.02.27.00.45.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 00:45:14 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-db3a09e96daso2987932276.3;
        Tue, 27 Feb 2024 00:45:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQ9TDefwviEzhXr1PNDhSAcgZxRfevBYRTxvg02qHYrQ5YJgXFktP/aEjJascSsm7pLejAtrB8lx//uaeftOdQC8PXDoZ/izA030MapBzK+LVDZkM5bH3Yf+XC8BMKRkeDDVSUjG6i6Nc+dMzUGXCCjCXIJruTxMtnbgl9Hk/qh+p5gY5whHpKVew1rG+nidyyqhABpBfYgWZgSpR9HmySXjzSzgUrEN8D3vzvWwZnegKILIuQ8lxC+8GQ/dl9KwdboZfP3qMH3CnPNhqm6MSSGRs3uQGOQ3QluQLXQQzdXNS82Q+/lG7W33U+kiFicFJFF5siwocu0mAd+n2ngxxrJFuEDRoRThZJyKqfglJT6HIv5Xx6BQDU539l7ydx40ZwDEeQx71LxePM86tAR53NWOUkkvMKvgStjwg5jhccaGaBwRc0ychoRRG41jRJBc8=
X-Received: by 2002:a25:84c7:0:b0:dc7:496e:42e1 with SMTP id
 x7-20020a2584c7000000b00dc7496e42e1mr1414712ybm.51.1709023513209; Tue, 27 Feb
 2024 00:45:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226161414.2316610-1-arnd@kernel.org> <20240226161414.2316610-2-arnd@kernel.org>
In-Reply-To: <20240226161414.2316610-2-arnd@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Feb 2024 09:45:01 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVCWF50SO1TK5F5Q8sN08THKJ+F6gt9u5pD05gJUZ+E9w@mail.gmail.com>
Message-ID: <CAMuHMdVCWF50SO1TK5F5Q8sN08THKJ+F6gt9u5pD05gJUZ+E9w@mail.gmail.com>
Subject: Re: [PATCH 1/4] arch: consolidate existing CONFIG_PAGE_SIZE_*KB definitions
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

On Mon, Feb 26, 2024 at 5:14=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
> From: Arnd Bergmann <arnd@arndb.de>
>
> These four architectures define the same Kconfig symbols for configuring
> the page size. Move the logic into a common place where it can be shared
> with all other architectures.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your patch!

> --- a/arch/Kconfig
> +++ b/arch/Kconfig

> +config PAGE_SIZE_4KB
> +       bool "4KB pages"

Now you got rid of the 4000-byte ("4kB") pages and friends, please
do not replace these by Kelvin-bytes, and use the official binary
prefixes =3D> "4 KiB".

> +       depends on HAVE_PAGE_SIZE_4KB

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

