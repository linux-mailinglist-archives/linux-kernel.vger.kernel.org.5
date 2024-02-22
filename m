Return-Path: <linux-kernel+bounces-76398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEFF85F6A9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7256EB2608D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0CA40BED;
	Thu, 22 Feb 2024 11:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2FWqWvep"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA7A3770E
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708600871; cv=none; b=mfD/NeivjoN6X0/5WwhTjb5V96C9ovcz4E3w6avpXf1fwiMAlwUGBwQ0u478//PnzuZgZ7gJcejJoqY3bku1drzlpUZOsay36nwXBf6eaF84Z1QJnYzVTOBcg37e2N4yRp9pvnEasZIYOA9ur/dVxHuwTtnN96d3tpUOmJ4bYmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708600871; c=relaxed/simple;
	bh=9Pqfn0qC+Yj0+qJNWDK84EdmrphKvk4v2jyMlAkwfrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CW9V1o7xmbXvXn1g+/xcRbaPR283pr5TZY02zgUEZPuEasYi9lPIdMzMDyDdoaw8UfqYi71GSn2W9E6iqUDYlmOZrdeLtLInzuEVY0agdfZx2T7WsaCb5ByuQp/1vjzqPSpehl9m0Q8sblwTsN8BnN9KIZHaVRYFBlB9s0X619c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2FWqWvep; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-564e4477b7cso8526a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708600868; x=1709205668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SjcXiN0HSEY14VbtkYXT9a2V6mhrgFrbcQEYTI562s=;
        b=2FWqWvepbEwV3t9/82tcf+XsbCGiEcCpFv900lXJ4xI/+rMYHiELH1cdVOoieUx5cn
         pH2Z2sAyPWH5+KYQRvEmdmKo3CmvqObtbWdeTpH33pnrI8whJZNmmh3yeTJqB+G9kt09
         a6QuRNORuy/PPsEoUMQ9NVgHETRezA5vW13BhfMO0o4I0qRNMBD52G6NsWY1rNO+Ke3g
         kA/6b1KWzqajMNqYjkqcHM4cle/0cvVP8C4w0ruT5QnNOHw4t94YFpPNqGdYKF635YEK
         P/NhXeG8fEgFEWf/MaAf1oVajhyNwuNCXzQLQ+8FhT2T+Gse+25WjMebdjCsRK6ZsofH
         jAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708600868; x=1709205668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1SjcXiN0HSEY14VbtkYXT9a2V6mhrgFrbcQEYTI562s=;
        b=P+YZsWMLAticHA0NP1jOE2iBLZc0IIUyNan9p4jxamAgF6skLtzEcVKgyPiKnjFz9P
         WWORJ37UKy9vXXUxdVYBfeUcGW5gM8GwsPGvzUjdwFqzihaUun8pt6l6T+ZovG4pS+W3
         lBGeKlSt4d60RPu1vEPJJoAMDbZTuFVtM9QjPVOC81yZd/ZvyPRDZ6DUkbMgsB8Vw06i
         bCu4rrpg2H8ULE6cr6dGTCpvjMACG7gPYtZomumxerj6IWDzxjhQjCsa9J9Q37KxqIlt
         5nH65yyl4P0DpJrFBs0XgXbM//+q+O6VWOqtQjMclu+nbwnIZlvayiY9nAM4hYGRmqgg
         t+Zg==
X-Forwarded-Encrypted: i=1; AJvYcCX0MhKnEj95F2EEYll/PG8oYHYsxYlADmfsvBCJdU18MvXZ9bhAp0yzJn7tVF81S6rrE0Q991e6TljzuzA3QoAPkTdkhL7npylKUVP0
X-Gm-Message-State: AOJu0YxSfTngJVglahwAXcyRFH50qWxV+KcEMzgaNk4Tv0vKjqQ+QamM
	/dgYYGjt4/JEFYmuExnwdH7rNp7mjinrRygl6dCCmgpcP5yTSyfXwcxhSBlcl4E+CPpYfBoxyWq
	v2XmfXRs+KVd6NxhkUkyPT4P+tOVcbldVIBrW
X-Google-Smtp-Source: AGHT+IEcTG/GdWgu9Ui4LLjkbYfNdp0E+FczKDajRVi7qSQMUwu9HMIX4CuPOYE4s2ORF/roDBrhCKNx3PhP6c+3YKo=
X-Received: by 2002:a50:cdcc:0:b0:560:1a1:eb8d with SMTP id
 h12-20020a50cdcc000000b0056001a1eb8dmr322200edj.7.1708600867697; Thu, 22 Feb
 2024 03:21:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221202655.2423854-1-jannh@google.com> <20240221202655.2423854-2-jannh@google.com>
 <CAK7LNAQG_dX8p0Lch-wg8cOVRQzaJUh2zFJL+3tgpcT8_iSTow@mail.gmail.com>
In-Reply-To: <CAK7LNAQG_dX8p0Lch-wg8cOVRQzaJUh2zFJL+3tgpcT8_iSTow@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 22 Feb 2024 12:20:29 +0100
Message-ID: <CAG48ez3Kg+BPsf_gWhm9E3QwOOw_CbTnHJ828Df41i1_EYrxnw@mail.gmail.com>
Subject: Re: [PATCH 2/2] kallsyms: build faster by using .incbin
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Zhen Lei <thunder.leizhen@huawei.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 5:07=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
> On Thu, Feb 22, 2024 at 5:27=E2=80=AFAM Jann Horn <jannh@google.com> wrot=
e:
> >
> > Currently, kallsyms builds a big assembly file (~19M with a normal
> > kernel config), and then the assembler has to turn that big assembly
> > file back into binary data, which takes around a second per kallsyms
> > invocation. (Normally there are two kallsyms invocations per build.)
> >
> > It is much faster to instead directly output binary data, which can
> > be imported in an assembly file using ".incbin". This is also the
> > approach taken by arch/x86/boot/compressed/mkpiggy.c.
>
>
> Yes, that is a sensible case because it just wraps the binary
> without any modification.
>
>
>
>
> > So this patch switches kallsyms to that approach.
> >
> > A complication with this is that the endianness of numbers between
> > host and target might not match (for example, when cross-compiling);
> > and there seems to be no kconfig symbol that tells us what endianness
> > the target has.
>
>
>
> CONFIG_CPU_BIG_ENDIAN is it.
>
>
>
> You could do this:
>
> if is_enabled CONFIG_CPU_BIG_ENDIAN; then
>         kallsymopt=3D"${kallsymopt} --big-endian"
> fi
>
> if is_enabled CONFIG_64BIT; then
>         kallsymopt=3D"${kallsymopt} --64bit"
> fi

Aah, nice, thanks, I searched for endianness kconfig flags but somehow
missed that one.

Though actually, I think further optimizations might make it necessary
to directly operate on ELF files anyway, in which case it would
probably be easier to keep using the ELF header...

> > So pass the path to the intermediate vmlinux ELF file to the kallsyms
> > tool, and let it parse the ELF header to figure out the target's
> > endianness.
> >
> > I have verified that running kallsyms without these changes and
> > kallsyms with these changes on the same input System.map results
> > in identical object files.
> >
> > This change reduces the time for an incremental kernel rebuild
> > (touch fs/ioctl.c, then re-run make) from 27.7s to 24.1s (medians
> > over 16 runs each) on my machine - saving around 3.6 seconds.
>
>
>
>
> This reverts bea5b74504742f1b51b815bcaf9a70bddbc49ce3
>
> Somebody might struggle with debugging again, but I am not sure.
>
> Arnd?
>
>
>
> If the effort were "I invented a way to do kallsyms in
> one pass instead of three", it would be so much more attractive.

Actually, I was chatting with someone about this yesterday, and I
think I have an idea on how to get rid of two link steps... I might
try out some stuff and then come back with another version of this
series afterwards.

> I am not so sure if this grain of the optimization is exciting,
> but I confirmed that a few seconds were saved for the defconfig.
>
> I am neutral about this.
>
>
>
> For the debugging purpose, perhaps we can add --debug option
> in order to leave the possibility for
> outputting the full assembly as comments.

Hm, maybe... though that also involves a lot of duplicate code...

