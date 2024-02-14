Return-Path: <linux-kernel+bounces-66031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E534855594
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 098801F23EAE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EDE141991;
	Wed, 14 Feb 2024 22:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="UvCzxv5S"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B7B13DBA7
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 22:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707948798; cv=none; b=lDxyxIWbBoFtUgRyBtuYxahtaMdjcMrqz+Oz+Xi9D3CWJJrGI7xfsDkmEyMfB7+JU6jkoJf4+RC8W5odncgmaDx03/EyH7MxRYAeHpAYaPDpX79yL9o1Btpb/f1xlSFuY49BlzJamnXOHPhuKDLgowhAVNGOW3ELJYXxR7guXDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707948798; c=relaxed/simple;
	bh=34QBfod1MXsHPP6ih9wJzCrM/ey8bl+6WVG6wRIUlDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LKxqXObaPZ73oP3uuS3HhMzUZzSX/AQ7ubzDP3xjn+mB9vL01p/Na0L155A80a8wLfem+Dn7xigjzaJkbTjVBt8Zhdyu35czgWi2BuHMracxclG7zqrEF5cpUonZ9LL1da/PRPOSwwAziX87lPcy2MNFVQ4BljNQOgkI4dPweIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UvCzxv5S; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-411d9e901dcso8335e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 14:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707948795; x=1708553595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3IEQt+kAeGn1OT5Tgp9Em9JlT2FTRJuU5+IDYgEUuNg=;
        b=UvCzxv5S3PV8I0kOFuwsOzSjd5gwCI7JHvoe2NjP7t1ceqzHN58bJgvhbvzO66CQre
         glkUYckOLmR0Isx/5c5NsDYyZW2LKNAp0JQ0zG5PZ9wjdWXEXTXPoLq/0ddY+aKOE764
         qvgb2F3jEgHNbNLSboOleVP2F8aG/dFmVhf6tJw1S94SsT2LEknUgLaNEvTEx7WXJ7dF
         CRQENCJ+2W8dWGDaI+aDOiylQDG0X7tLiTdMaBVPmvk5cMpEAYmW6qXNF5etaqt2D72S
         KaL7iB1u2PGxJIxnkcIhhG+9g7ShDAs0kS2KK8+uko1gs7nzT1zuH/yNycyF6l8PJQ8N
         91CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707948795; x=1708553595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3IEQt+kAeGn1OT5Tgp9Em9JlT2FTRJuU5+IDYgEUuNg=;
        b=Fngfp/sUIJ5p44iP4OySL61lsVrZfuy41Xg6RMBnZ/R+uL+FKjuztlONhBzC9A6NuM
         khqq4Uqe6p1IXV1QLys8I6U83MfsefPsRD7us9ydBfAz8sAT9wvGzaZTlD1SKxdlh/R1
         DVH+aTPajdr1xOxOegz7Jmm9aj0Ttpp9fnISGlwwbUDJG8zgSZ+kL17jS1IoKBuiqKL1
         CILSP3J5E4t3bkeHmWrNmANTKWI96ZOjsN3+kpquWSL8zkuBcfynIo7yagYqPlP+eUg0
         TIdBb5S1ch01n5CDTK36yrEPv7k2YxjQ5VF7QKX2EL/c48QzCRHxNubqz8BojlO8ilZg
         euWA==
X-Forwarded-Encrypted: i=1; AJvYcCV+DOPVefYUHSmbmlQWOQpGtkndMyodq+L0AI6GYk3xxgRjRqtiLG/UnuYJYt4fII6bqSQf9wt6TouuHd+MjVYcPDf/09xBHNH4fWZB
X-Gm-Message-State: AOJu0YyA3ga7bnGWEdMqvZktNhTFHyezXE9NRjkFxIAUeJkg0FPSiQfE
	TyA/3R4YN+yk3txEWWm4wvm74q3oO9DgbVWz9E2vPwgYUP0QynuyPma1DG73djQWxSO4NmThFv/
	mXuml6D03Yr3TnGHIqmvI148mj0ck5nX7vV/1
X-Google-Smtp-Source: AGHT+IHl22kCFBApVJn3RoMQAvwLLmY0RBH/xR29txjELLOg2wRScFeDG53W/RZ1EhuyFlSmxrY65riHWsEWMJ8+afg=
X-Received: by 2002:a05:600c:b88:b0:410:802c:2d43 with SMTP id
 fl8-20020a05600c0b8800b00410802c2d43mr347838wmb.4.1707948795041; Wed, 14 Feb
 2024 14:13:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214212929.3753766-1-maskray@google.com> <202402141405.0755DD4E5E@keescook>
In-Reply-To: <202402141405.0755DD4E5E@keescook>
From: Fangrui Song <maskray@google.com>
Date: Wed, 14 Feb 2024 14:13:01 -0800
Message-ID: <CAFP8O3LWBHkbLwFJdmy7iSGD0cMSy1jczETo=N6oVapCgPY=sA@mail.gmail.com>
Subject: Re: [PATCH] x86/build: Simplify patterns for unwanted section
To: Kees Cook <keescook@chromium.org>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	Nathan Chancellor <nathan@kernel.org>, Heiko Carstens <hca@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 2:07=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Wed, Feb 14, 2024 at 01:29:29PM -0800, Fangrui Song wrote:
> > A s390 patch modeling its --orphan-handling=3D after x86 [1] sparked my
> > motivation to simplify patterns. Commit 5354e84598f2 ("x86/build: Add
> > asserts for unwanted sections") added asserts that certain input
> > sections must be absent or empty. The patterns can be simplified.
> >
> > For dynamic relocations,
> >
> > *(.rela.*) is sufficient to match all dynamic relocations synthesized b=
y
> > GNU ld and LLD. .rela_* is unnecessary. --emit-relocs may create .rela_=
*
> > sections for section names prefixed with _, but they are not matched by
> > linker scripts.
> >
> > .plt instead of .plt.* is sufficient to match synthesized PLT entries.
>
> Do you mean ".plt.foo" matches ".plt" ?

I mean we just need .plt : { *(.plt) } , not .plt : { *(.plt) *(.plt.*) }.

The linker synthesized section for PLT entries is .plt, not suffixed.

> > .igot and .igot.plt are for non-preemptible STT_GNU_IFUNC in GNU ld (LL=
D
> > just uses .got), which the kernel does not use. In addition, if .igot o=
r
> > .igot.plt is ever non-empty, there will be .rela.* dynamic relocations
> > leading to an assert failure anyway.
>
> I think at the time I was dealing with avoid multiple warnings out of
> the linker, as I was getting orphan warnings in addition to the
> non-empty warnings.
>
> >
> > [1]: https://lore.kernel.org/all/20240207-s390-lld-and-orphan-warn-v1-6=
-8a665b3346ab@kernel.org/
> >
> > Signed-off-by: Fangrui Song <maskray@google.com>
>
> Is anything harmed by leaving all of this as-is?
>
> -Kees

No harm. But ports adopting --orphan-handling=3D (like s390) may copy
the unneeded .rela_* .
When people read .rela_*, they might think whether the kernel does
anything special that
rela_* needs to be matched.

> > ---
> >  arch/x86/boot/compressed/vmlinux.lds.S | 6 +++---
> >  arch/x86/kernel/vmlinux.lds.S          | 8 ++++----
> >  2 files changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/com=
pressed/vmlinux.lds.S
> > index 083ec6d7722a..9f288f67972a 100644
> > --- a/arch/x86/boot/compressed/vmlinux.lds.S
> > +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> > @@ -104,17 +104,17 @@ SECTIONS
> >       ASSERT(SIZEOF(.got) =3D=3D 0, "Unexpected GOT entries detected!")
> >
> >       .plt : {
> > -             *(.plt) *(.plt.*)
> > +             *(.plt)
> >       }
> >       ASSERT(SIZEOF(.plt) =3D=3D 0, "Unexpected run-time procedure link=
ages detected!")
> >
> >       .rel.dyn : {
> > -             *(.rel.*) *(.rel_*)
> > +             *(.rel.*)
> >       }
> >       ASSERT(SIZEOF(.rel.dyn) =3D=3D 0, "Unexpected run-time relocation=
s (.rel) detected!")
> >
> >       .rela.dyn : {
> > -             *(.rela.*) *(.rela_*)
> > +             *(.rela.*)
> >       }
> >       ASSERT(SIZEOF(.rela.dyn) =3D=3D 0, "Unexpected run-time relocatio=
ns (.rela) detected!")
> >  }
> > diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.ld=
s.S
> > index a349dbfc6d5a..b3da7b81d2b3 100644
> > --- a/arch/x86/kernel/vmlinux.lds.S
> > +++ b/arch/x86/kernel/vmlinux.lds.S
> > @@ -463,22 +463,22 @@ SECTIONS
> >        * explicitly check instead of blindly discarding.
> >        */
> >       .got : {
> > -             *(.got) *(.igot.*)
> > +             *(.got)
> >       }
> >       ASSERT(SIZEOF(.got) =3D=3D 0, "Unexpected GOT entries detected!")
> >
> >       .plt : {
> > -             *(.plt) *(.plt.*) *(.iplt)
> > +             *(.plt)
> >       }
> >       ASSERT(SIZEOF(.plt) =3D=3D 0, "Unexpected run-time procedure link=
ages detected!")
> >
> >       .rel.dyn : {
> > -             *(.rel.*) *(.rel_*)
> > +             *(.rel.*)
> >       }
> >       ASSERT(SIZEOF(.rel.dyn) =3D=3D 0, "Unexpected run-time relocation=
s (.rel) detected!")
> >
> >       .rela.dyn : {
> > -             *(.rela.*) *(.rela_*)
> > +             *(.rela.*)
> >       }
> >       ASSERT(SIZEOF(.rela.dyn) =3D=3D 0, "Unexpected run-time relocatio=
ns (.rela) detected!")
> >  }
> > --
> > 2.43.0.687.g38aa6559b0-goog
> >
>
> --
> Kees Cook



--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF

