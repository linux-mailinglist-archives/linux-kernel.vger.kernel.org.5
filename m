Return-Path: <linux-kernel+bounces-53929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D40D384A826
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1397A1C28092
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FFF1386DD;
	Mon,  5 Feb 2024 20:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQSKBB1a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAF71EB46
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 20:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707166297; cv=none; b=jR6YFCByJckvVn3gp4X+hLOY3y9/9g5DMiP8GH3oGoMwSRyIOy/esUh3DK5/zigFrLBM8PDynnxLGxgAU1Asefu1POYtnL1pEHr+tXxpNayO5AVBXi8f81mzGQNIxBaT6IO93vC21E9RAwcAPsywvGJ6qvGK09fBAgINlxtl0OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707166297; c=relaxed/simple;
	bh=rbxfWPsAtsZkwAub+b6KRhh6zPgaO8+Nsj7bKR2m5RM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mxzNJDrAh4lQLjpAo1iiwunv1mXjcyLOwcPuRTCNTntjy5N0tgjP0kAIMQRfE+h5wjzcWv70KPBUgk6dGLfN+lX519LobdnhSrEHvegVwVPwvUtFIHN7mNVdEVxSUyZ/HZAPrdcV2Bk7qjoh06/1QsaqOkAnfw3/P4A1YSdf6w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQSKBB1a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE405C43394
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 20:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707166296;
	bh=rbxfWPsAtsZkwAub+b6KRhh6zPgaO8+Nsj7bKR2m5RM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gQSKBB1auVt0+2i1wF9el62IAUkh4PeL0/sd2OjWkiV52ekTZFcXWz9X1ePXPXA3R
	 3xiLneomSrhi0rvZm7fvIS94AFFbrPjE9vfY3vqBlTbo6U202xyk8qz5fabVfyZFFc
	 +LEZTedFJ/GMXteRffOyJpwkNmrt5lhm1ExY81vW5OTDtyVlJ/B8PUThs0l1AnChu9
	 kVIfSrZ8jyH8sLN+/uaOqGAwhKcUcPaUcmpRwR5EPpIijVKGEmtugZmDDFiitJllYI
	 ClMllxJdWTGCL3M7Uac7F/Ei2FAGASPRVok1n1kDHZNiLOMzsxKX/S7tv4PG+NQhcJ
	 5oYI/r14MPTOA==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d09fefabc1so24038661fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 12:51:36 -0800 (PST)
X-Gm-Message-State: AOJu0Yw2BowN3IgCOhkrT6ilqvyTXmJtTHedYxVFqjp/SOq3GsRIHGie
	hF1CuPQUSg2ciqXVlIVisgDRuXQPm27l4SaKUj32buYVUJmjKIGso2eOsBHZVeSm5YV0NRN8dc5
	5iB+6NjlEGLWCAbxhdysojqHxsd8=
X-Google-Smtp-Source: AGHT+IH48mHUOfbKPsHz4ex522m4Efo9yfxYkbY+WPFm87RC+2HZW07sdB9JpcI7VvmtbRlov+g35Jw+FX0st/t6jd4=
X-Received: by 2002:a2e:920d:0:b0:2d0:af09:e3d7 with SMTP id
 k13-20020a2e920d000000b002d0af09e3d7mr580084ljg.41.1707166295433; Mon, 05 Feb
 2024 12:51:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120232332.4100288-1-masahiroy@kernel.org>
 <CX42TU4QHS1Z.A0UUHMDAMZOL@wheely> <ZbjHTMhQ4Z9lRR6L@t14s>
 <87v873870m.fsf@mail.lhotse> <CAASaF6w9SRoj+Kn6=UaReBNNfL_rrKo-4rvtCj=iF4Nd3Zpw-g@mail.gmail.com>
In-Reply-To: <CAASaF6w9SRoj+Kn6=UaReBNNfL_rrKo-4rvtCj=iF4Nd3Zpw-g@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 6 Feb 2024 05:50:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQe5SounO60gyYE_3e-M0cAAgT=9jac_SLcR0i9BeEgDQ@mail.gmail.com>
Message-ID: <CAK7LNAQe5SounO60gyYE_3e-M0cAAgT=9jac_SLcR0i9BeEgDQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc: add crtsavres.o to always-y instead of extra-y
To: Jan Stancek <jstancek@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, linuxppc-dev@lists.ozlabs.org, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 10:22=E2=80=AFPM Jan Stancek <jstancek@redhat.com> w=
rote:
>
> On Mon, Feb 5, 2024 at 12:50=E2=80=AFPM Michael Ellerman <mpe@ellerman.id=
au> wrote:
> >
> > Jan Stancek <jstancek@redhat.com> writes:
> > > On Tue, Nov 21, 2023 at 10:51:34AM +1000, Nicholas Piggin wrote:
> > >>On Tue Nov 21, 2023 at 9:23 AM AEST, Masahiro Yamada wrote:
> > >>> crtsavres.o is linked to modules. However, as explained in commit
> > >>> d0e628cd817f ("kbuild: doc: clarify the difference between extra-y
> > >>> and always-y"), 'make modules' does not build extra-y.
> > >>>
> > >>> For example, the following command fails:
> > >>>
> > >>>   $ make ARCH=3Dpowerpc LLVM=3D1 KBUILD_MODPOST_WARN=3D1 mrproper p=
s3_defconfig modules
> > >>>     [snip]
> > >>>     LD [M]  arch/powerpc/platforms/cell/spufs/spufs.ko
> > >>>   ld.lld: error: cannot open arch/powerpc/lib/crtsavres.o: No such =
file or directory
> > >>>   make[3]: *** [scripts/Makefile.modfinal:56: arch/powerpc/platform=
s/cell/spufs/spufs.ko] Error 1
> > >>>   make[2]: *** [Makefile:1844: modules] Error 2
> > >>>   make[1]: *** [/home/masahiro/workspace/linux-kbuild/Makefile:350:=
 __build_one_by_one] Error 2
> > >>>   make: *** [Makefile:234: __sub-make] Error 2
> > >>>
> > >>
> > >>Thanks. Is this the correct Fixes tag?
> > >>
> > >>Fixes: d0e628cd817f ("powerpc/64: Do not link crtsavres.o in vmlinux"=
)
> > >>
> > >>Hmm, looks like LLD might just do this now automatically for us
> > >>too without --save-restore-funcs (https://reviews.llvm.org/D79977).
> > >>But we probably still need it for older versions, so we still need
> > >>your patch.
> > >
> > > Hi,
> > >
> > > I'm still seeing the error of crtsavres.o missing when building exter=
nal modules
> > > after "make LLVM=3D1 modules_prepare". Should it be built also in arc=
hprepare?
> >
> > Or modules_prepare?
> >
> > Example patch below.
>
> I tested your patch with my setup and that works for me as well.
>




Please note 'make ARCH=3Dpowerpc clean' will remove  '*.o'
files globally.


Kbuild promised you would still be able to compile external modules
after 'make clean' (until you run 'make mrproper'), but
that would not work in this case.

So, the external module support for powerpc
is broken in another way, already.


Perhaps, an easy workaround might be to change
the suffix, but I did not test it at all.

mv arch/powerpc/lib/crtsavres.o arch/powerpc/lib/crtsavres.o.do_not_remove_=
me




--=20
Best Regards
Masahiro Yamada

