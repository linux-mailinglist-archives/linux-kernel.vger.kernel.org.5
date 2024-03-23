Return-Path: <linux-kernel+bounces-112350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F7A8878C8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 14:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3CB11C220F6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 13:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1343B299;
	Sat, 23 Mar 2024 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eslu8vKt"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863C41A38F4
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 13:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711200184; cv=none; b=Aov4opOf+Oy/kaI5+/QlI2hgI3XvS80M9ALgIbWmVYNjucct/2rkzCq1EMgxh+5eUcXArKAsZvbEXvNs1nUc0uBk6+vB94Jx8MtNx3jL8DBP7ha53Xb5fG0oW1grdm1F4L3ZHg+1kJ5lb+2VEJuArgW519zKwDEOtZPLcZODcDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711200184; c=relaxed/simple;
	bh=N/3E68ODjcpXCYPH4Zk+1d7kReAgKFQBwYI/5UN4rQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VHeHBCmktXNFr12KmhotmnBkfSydg/cFco3no1I/K9O9nY3f1+Pi0YIU+di2FRaTckT9kIB4P8d6wJEKm+EcBgvXt3upxwRInBtCyLAKmyJ8lzkU/qLgLqsZWU0bFcnnCw7mWRmlN4rWTYKPQkCtG+3Rr/z26APJ1n50wBtCSAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eslu8vKt; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d29aad15a5so39227751fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 06:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711200180; x=1711804980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSlYLLTmQQfNsjaD7iQbZNTZyxfD58j2PrdsW9gF/8k=;
        b=Eslu8vKtL7R9GZPAppVR9XzduiuqwY/kA4aHluXQHtbNom7slCLbigNh2CfPxuFTtM
         mDGNld/kYOtYIWhwsGTWgrcbO+uHk94oihhcDztEVbLPoJ8Njm5+Odw5bs1aJmJ9ORYM
         zEOkviIaUQmFAekGG05dM3d2JmNutkMM8hWSJOunnaoOISpIj96MXdvQcHdtxGHyfeZy
         WcqzN91ZUQCE4rlaxtMnkOslow730WpaeIf21VOg/NpiYqvJpqd1jjryCWYqLlvY03py
         He40o0d70czUCnxjKebX10X55LLldTlmyfhGC1IBmBLbJN+osoWcPTu+9nFYDJIS1QC1
         BIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711200181; x=1711804981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BSlYLLTmQQfNsjaD7iQbZNTZyxfD58j2PrdsW9gF/8k=;
        b=WzNREpwSaUEewoAkoHfETFfdSzeUtfneT92kfC1IPr/eJyoZM+R20hWVyDzOMrdsnh
         CEsesMCNxkCT6w/IUAWs4GPwlzyjEX4DUhormmiD6U50qMj7vp8MeokzgdTqKHvZzKoG
         ZAzlNkbo5i26KJ72DcSBbuysZvCj7ZP1W+qGNaVVGhvQag/2aARW6TebeH5CCPqlJ4ZI
         PXTR67rTNZsWwehDDfmDRerqPEQjN1iesYHnv55PnItxzOQNmM2F6WjPmlobOQznkpQh
         ZEsQdmMz+bSOmRPHkcH1nWgNbrsxYKC5+jAHWX3StAesOp+LvXuRqBiEDoE1mOW7dSBG
         RP4A==
X-Gm-Message-State: AOJu0YzDegb4tm1YW2XToX1SO4mBg1vxHFo/EI8H5j9YTk8LAyRMivW+
	b2nnS2w6ePrs+pklFq262e6sUFQFe/AL0aNQtqFNd7KnrZemYXpboXeL2v52pnZA7a2sIoCqJwf
	QaDTcb7y/dzOUophF+d6UhcAjXA==
X-Google-Smtp-Source: AGHT+IEfLmA8CnBKFEXQKtzaiWIDwtsPqB3Hh3HIQxJmqJbKbka+8mMvMsSPDoE04D/J/kLZbsaFE/w+k0OanwR7x9o=
X-Received: by 2002:ac2:4649:0:b0:515:a3de:5d70 with SMTP id
 s9-20020ac24649000000b00515a3de5d70mr798881lfo.2.1711200180325; Sat, 23 Mar
 2024 06:23:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322165233.71698-1-brgerst@gmail.com> <CAFULd4bCufzKjaUyOcJ5MfsPBcVTj1zQiP3+FFCGo6SbxTpK2A@mail.gmail.com>
In-Reply-To: <CAFULd4bCufzKjaUyOcJ5MfsPBcVTj1zQiP3+FFCGo6SbxTpK2A@mail.gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Sat, 23 Mar 2024 09:22:47 -0400
Message-ID: <CAMzpN2gOZEddWUgncaLutVDihcEK-oEUdSVxsgaaX9xiMWfqPw@mail.gmail.com>
Subject: Re: [PATCH v4 00/16] x86-64: Stack protector and percpu improvements
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	"H . Peter Anvin" <hpa@zytor.com>, David.Laight@aculab.com, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 23, 2024 at 7:39=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> On Fri, Mar 22, 2024 at 5:52=E2=80=AFPM Brian Gerst <brgerst@gmail.com> w=
rote:
> >
> > Currently, x86-64 uses an unusual percpu layout, where the percpu secti=
on
> > is linked at absolute address 0.  The reason behind this is that older =
GCC
> > versions placed the stack protector (if enabled) at a fixed offset from=
 the
> > GS segment base.  Since the GS segement is also used for percpu variabl=
es,
> > this forced the current layout.
> >
> > GCC since version 8.1 supports a configurable location for the stack
> > protector value, which allows removal of the restriction on how the per=
cpu
> > section is linked.  This allows the percpu section to be linked normall=
y,
> > like other architectures.  In turn, this allows removal of code that wa=
s
> > needed to support the zero-based percpu section.
>
> The number of simplifications throughout the code, enabled by this
> patch set, is really impressive, and it reflects the number of
> workarounds to enable the feature that was originally not designed for
> the kernel usage. As noted above, this issue was recognized in the GCC
> compiler and the stack protector support was generalized by adding
> configurable location for the stack protector value [1,2].
>
> The improved stack protector support was implemented in gcc-8.1,
> released on May 2, 2018, when linux 4.17 was in development. In light
> of this fact, and 5 (soon 6) GCC major releases later, I'd like to ask
> if the objtool support to fixup earlier compilers is really necessary.
> Please note that years ago x86_32 simply dropped stack protector
> support with earlier compilers and IMO, we should follow this example
> also with x86_64, because:
>
> a) There are currently 5 (soon 6) GCC major releases that support
> configurable location for stack protector value. GCC 10 is already out
> of active maintenance, and GCC 7 is considered an ancient release at
> this time. For x86_32, it was advised to drop the support for stack
> protector entirely with too old compilers to somehow force users to
> upgrade the compiler.

At least one developer claimed to be using an older compiler.  I asked
for more details on why, but got no response.

> b) Stack protector is not a core feature - the kernel will still boot
> without stack protector. So, if someone really has the urge to use
> ancient compilers with the bleeding edge kernel, it is still possible
> to create a bootable image. I do not think using ancient compilers to
> compile bleeding edge kernels makes any sense at all.

One small issue is that Kconfig would silently disable istackprotector
if the compiler doesn't support the new options.  That said, the
number of people that this would affect is very small, as just about
any modern distribution ships a compiler newer than 8.1.

I'm all in favor of only supporting compilers that are supported upstream.

> c) Maintenance burden - an objtool feature will have to be maintained
> until gcc-8.1 is the minimum required compiler version. This feature
> will IMO be seldom used and thus prone to bitrot.

That's the reason I added a config option to allow testing objtool
even if the compiler has support.

> d) Discrepancy between x86_32 and x86_64 - either both targets should
> use objtool fixups for stack protector, or none at all. As shown by
> x86_32 approach in the past, removing stack protector support with
> ancient compilers was not problematic at all.

Objtool doesn't support x86-32, mostly because working with REL type
relocations is a pain.

> That said, the whole series is heartily Acked-by: Uros Bizjak
> <ubizjak@gmail.com>
>
> [1] https://gcc.gnu.org/git/?p=3Dgcc.git;a=3Dcommitdiff;h=3De1769bdd4cef5=
22ada32aec863feba41116b183a
> [2] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D81708
>
> Thanks,
> Uros.

Brian Gerst

