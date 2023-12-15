Return-Path: <linux-kernel+bounces-1242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66458814C39
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D36031F2446D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D67381D3;
	Fri, 15 Dec 2023 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEIKwrtH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27E239FC3;
	Fri, 15 Dec 2023 15:59:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743BEC433C9;
	Fri, 15 Dec 2023 15:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702655975;
	bh=Ul+smwo2dUU4IZrKLKRFwWj5xD+FHTbxnNmHipSAyBQ=;
	h=References:In-Reply-To:From:Date:Subject:To:From;
	b=NEIKwrtH2NhMdNisiRKJ+HvLoMwkQV1+Lku+ie5hsUTyMI7TswDhhgIcF4wPZWZJP
	 b9b/yWOSe4PsCqwKH1ivoYXiFc7UQIlZyM5g0+Bd3XxZs0No7rMUDCHTh0o5HRzYjB
	 /QSRzXIjcL/RqCxitj0UGIkUvjC3JK/4oYwO+m45Or5V6aVm1O6wCNOu6ukGyES+pX
	 nCSiHoova0KrQDQXVI08FTlEdpnYYTLH8dXWcyQIGuPKRN3gVpmqm/ZXn4rSZCHuxz
	 6IfNCzYBn4kiuqT4/LMut2DuZkN9uZ0FjFvIHnhKgvs5D5GvAmgYSmrHaTe92JcOju
	 VnuxgAqtiWsig==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6d9f879f784so652682a34.2;
        Fri, 15 Dec 2023 07:59:35 -0800 (PST)
X-Gm-Message-State: AOJu0YwedA8jwvV+Z3Ze6P5teWMt60VpAfAZg6HQK8JAVhdseAYUuIls
	WyFtE6wtzh56ecZOk2xdc1B1xj390XEU7z/i+eg=
X-Google-Smtp-Source: AGHT+IE5Y0R+D3fyeRiluOxD4Qax8VQhuqPeQSHPhET/FIxGMbGGnNI0yH0v+xiiHyFkbQkK0b+1NS4JOdDA75dWa8M=
X-Received: by 2002:a05:6870:c192:b0:1fb:75b:12f2 with SMTP id
 h18-20020a056870c19200b001fb075b12f2mr15289404oad.68.1702655974794; Fri, 15
 Dec 2023 07:59:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214140305.531963-1-masahiroy@kernel.org> <ZXwcfSsuhzJYNAQh@buildd.core.avm.de>
In-Reply-To: <ZXwcfSsuhzJYNAQh@buildd.core.avm.de>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 16 Dec 2023 00:58:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNASQ121fDts9cCx744XANqQRX2xrbDLVsiHC2ht8X4Fwkw@mail.gmail.com>
Message-ID: <CAK7LNASQ121fDts9cCx744XANqQRX2xrbDLVsiHC2ht8X4Fwkw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: resolve symlinks for O= properly
To: Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 6:29=E2=80=AFPM Nicolas Schier <n.schier@avm.de> wr=
ote:
>
> On Thu, Dec 14, 2023 at 11:03:05PM +0900, Masahiro Yamada wrote:
> > Currently, Kbuild follows the logical chain of directories for the O=3D
> > option, just like 'cd' (or 'realpath --logical') does.
> >
> > Example:
> >
> >     $ mkdir -p /tmp/a /tmp/x/y
> >     $ ln -s /tmp/x/y /tmp/a/b
> >     $ realpath /tmp/a/b/..
> >     /tmp/x
> >     $ realpath --logical /tmp/a/b/..
> >     /tmp/a
> >     $ make O=3D/tmp/a/b/.. defconfig
> >     make[1]: Entering directory '/tmp/a'
> >       [snip]
> >     make[1]: Leaving directory '/tmp/a'
> >
> > 'make O=3D/tmp/a/b/.. defconfig' creates the kernel configuration in
> > /tmp/a instead of /tmp/x despite the directory path /tmp/a/b/..
> > resolves to the physical directory path /tmp/x.
> >
> > This is because Kbuild internally uses the 'cd ... && pwd' for the
> > path resolution, but this behavior is not predictable for users.
> > Additionally, it is not consistent with how the Kbuild handles the
> > M=3D option or GNU Make works with 'make -C /tmp/a/b/..'.
> >
> > Using the physical directory structure for the O=3D option seems more
> > reasonable.
> >
> > The comment says "expand a shell special character '~'", but it has
> > already been expanded to the home directory in the command line.
>
> I minor change in behaviour is that 'make O=3D"~/..."' (=3Dquoted '~) wil=
l
> not work any more.  But I think this actually the way it should be.
> Thanks!


A good catch. This bug should be fixed by quoting $(KBUILD_OUTPUT).


-$(shell mkdir -p $(KBUILD_OUTPUT))
+$(shell mkdir -p "$(KBUILD_OUTPUT)")



When ~ is quoted, it loses a special meaning.


masahiro@zoe:~$ echo ~
/home/masahiro
masahiro@zoe:~$ echo "~"
~



So, the right behaviour of 'make O=3D"~/foo"' is
to create "~/foo" under the current directory.


If you try to test it, please be careful to
not delete your home directory.

(I did "rm -r ./~" just in case)











> Reviewed-by: Nicolas Schier <n.schier@avm.de>
>
>
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  Makefile | 11 ++++-------
> >  1 file changed, 4 insertions(+), 7 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 24fac1889997..a05f0f7c99e0 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -190,14 +190,11 @@ ifeq ("$(origin O)", "command line")
> >  endif
> >
> >  ifneq ($(KBUILD_OUTPUT),)
> > -# Make's built-in functions such as $(abspath ...), $(realpath ...) ca=
nnot
> > -# expand a shell special character '~'. We use a somewhat tedious way =
here.
> > -abs_objtree :=3D $(shell mkdir -p $(KBUILD_OUTPUT) && cd $(KBUILD_OUTP=
UT) && pwd)
> > -$(if $(abs_objtree),, \
> > -     $(error failed to create output directory "$(KBUILD_OUTPUT)"))
> > -
> > +# $(realpath ...) gets empty if the path does not exist. Run 'mkdir -p=
' first.
> > +$(shell mkdir -p $(KBUILD_OUTPUT))
> >  # $(realpath ...) resolves symlinks
> > -abs_objtree :=3D $(realpath $(abs_objtree))
> > +abs_objtree :=3D $(realpath $(KBUILD_OUTPUT))
> > +$(if $(abs_objtree),,$(error failed to create output directory "$(KBUI=
LD_OUTPUT)"))
> >  endif # ifneq ($(KBUILD_OUTPUT),)
> >
> >  ifneq ($(words $(subst :, ,$(abs_srctree))), 1)
> > --
> > 2.40.1
> >



--=20
Best Regards
Masahiro Yamada

