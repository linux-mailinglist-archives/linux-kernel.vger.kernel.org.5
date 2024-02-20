Return-Path: <linux-kernel+bounces-72599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7EC85B5CF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6862F2837ED
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125D75D758;
	Tue, 20 Feb 2024 08:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMPX6tdR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579E95D743
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419012; cv=none; b=C/IHe5pvkc/+mMfed6KlMbmj8XWlCQh5HgPipeHyPibePhbgNA6F+SMwCBMI4lKkvsQmFxqi+6/V1KS57+GfVW3DhCWizMXpCWU+P3luU8onPFG+NlkB542apX9JDFlVN4aCBKQdK1DZTnZGwZl8ve989nOPGrKR93HHlhCH+tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419012; c=relaxed/simple;
	bh=pUq7P3aouNtDrNOSkHyQ5fqLAHFF5BRQGL40eGsuu4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JEBoHI5q1a6MESPeee6spJNo+ge1T9VeRpzP+67TixRZSN2NI3o6ayXaepx24XMMhGgoFk0zB4LbqDHSPBbZ1RgsamODO1IB5//OEu/CEVD2dTI2qzpz8ayGsPWj14D1KvAdOGlKmU3/7IwcGhPJ0iWdQb4c7x5JAbzBax7HBQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMPX6tdR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 074D2C43394
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708419012;
	bh=pUq7P3aouNtDrNOSkHyQ5fqLAHFF5BRQGL40eGsuu4c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CMPX6tdRO45c9rPJHZZtdGG+AfnKfi+dzTTN/puGQLBXFRLFK2koT0LjHP0oJYWYi
	 uarxLaQjDr6JaNBT1CzGUfH7MlVWTU8DZCvhgmMH8ebpcDyrywK17gDYmtZkUpPiWP
	 ybk9lbMBVjNfsKyEgFd1SxXJrMCggOcvGv+ksvZ3YFcTYRZg1rSEFBKCdC1GBv7uTT
	 qywRRtFTOkayyyi3qTVycYqmCDY3j4TsnPEeZ2XCVv+3gbOuB5C7sgXz0uEWSCLUqQ
	 bp4Qp1jOzytUPVjX0qKg66vrVfwt47u+5O1IMT+CFUxG8h3gm0G/71nCbcUIAHKWJT
	 eRcmVNvEcTOIg==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d1094b5568so68622471fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 00:50:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVUm9q4ic4FvN2aal0r27D48HUBEN1YF2EU2WW42q2PKq/GivI36aFur6UgHuhKAhgwbtL/00duUJkV+HHi9CibTLsuAlEdVuLJLfvv
X-Gm-Message-State: AOJu0YxMdVQrGMg274UC/X0dAwsrm5pVKjsA/HUseg/v00E+4f08M8Rd
	/ql161eIdKyqOLHTPPnLLK/nFMfV05GS+9i9Uwvi//dEohaTcb7V6fV5JWLd1lEBzsGLGgfQ913
	GVQv5nCLtjGD75poYw+9GM/Ou5ak=
X-Google-Smtp-Source: AGHT+IHtYT5W3sVkBIM/1+I/rh6KiZQJ8terGliuAmEFRyaCXnmBEx2M8LYKyeUp6KqECIg5NhkokHau4r2XnT+jNok=
X-Received: by 2002:a2e:968e:0:b0:2d2:43fd:391b with SMTP id
 q14-20020a2e968e000000b002d243fd391bmr1702175lji.26.1708419010195; Tue, 20
 Feb 2024 00:50:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206074552.541154-1-maskray@google.com> <CAMuHMdVOoxVFohcwwoQtY0KgZEvbjgJJ6mib8Fabo97P0krEqw@mail.gmail.com>
 <CAMj1kXGaF5bobHTr1pTg+-=s4Ft7+5SSbX72-NxsR_W_Yuxb8Q@mail.gmail.com>
 <CAMj1kXGw+r7yEEBA8gYBcdrqkiP=VYOSzz9YLnNavJn2snmFwA@mail.gmail.com>
 <CAMuHMdX+6fnAf8Hm6EqYJPAjrrLO9T7c=Gu3S8V_pqjSDowJ6g@mail.gmail.com>
 <CAMj1kXHh_m=V0QsiTpHrUXpFBXFbFfezdysz8quhPSgUrZg1MA@mail.gmail.com>
 <dca5b082-90d1-40ab-954f-8b3b6f51138c@app.fastmail.com> <ZdOcXTvvHyl8s56I@FVFF77S0Q05N>
 <CAMj1kXGWiTusoFWPCwM9OVwxp5=BHPfUdG-CurO13mWOdQr6Hg@mail.gmail.com>
In-Reply-To: <CAMj1kXGWiTusoFWPCwM9OVwxp5=BHPfUdG-CurO13mWOdQr6Hg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 20 Feb 2024 09:49:58 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFK6nf3YM8d0Tfn+yBRnHCrNj3rGON9pdV7EuCGPEVpTg@mail.gmail.com>
Message-ID: <CAMj1kXFK6nf3YM8d0Tfn+yBRnHCrNj3rGON9pdV7EuCGPEVpTg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: jump_label: use constraints "Si" instead of "i"
To: Mark Rutland <mark.rutland@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Fangrui Song <maskray@google.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	Jisheng Zhang <jszhang@kernel.org>, Dave Martin <Dave.Martin@arm.com>, 
	Peter Smith <peter.smith@arm.com>, llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Feb 2024 at 08:55, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 19 Feb 2024 at 19:22, Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Mon, Feb 19, 2024 at 06:06:19PM +0100, Arnd Bergmann wrote:
> > > On Mon, Feb 19, 2024, at 16:41, Ard Biesheuvel wrote:
> > > > On Mon, 19 Feb 2024 at 15:43, Geert Uytterhoeven <geert@linux-m68k.=
org> wrote:
> > > >> On Mon, Feb 19, 2024 at 11:57=E2=80=AFAM Ard Biesheuvel <ardb@kern=
el.org> wrote:
> > > >> > On Mon, 19 Feb 2024 at 11:56, Ard Biesheuvel <ardb@kernel.org> w=
rote:
> > >
> > > >> > https://godbolt.org/z/GTnf3vPaT
> > > >>
> > > >> I could reproduce the issue on v6.8-rc5 using arm64 defconfig
> > > >> and x86_64-gcc-5.5.0-nolibc-aarch64-linux.tar.xz from
> > > >> https://cdn.kernel.org/pub/tools/crosstool/files/bin/x86_64/5.5.0/=
:
> > > >>
> > > >
> > > > OK, I managed to do so as well.
> > > >
> > > > And GCC 6.4 from the same source works correctly.
> > > >
> > > > Not sure whether there are any plans to bump the minimal GCC versio=
n
> > > > any time soon (cc'ing Arnd), but we should probably drop this chang=
e
> > > > until that happens.
> > >
> > > From what I can tell, we may as well formally raise the minimum
> > > gcc version to 8.1+ already, as that is a version that is
> > > actually used in distros, and we have been on 5.1+ for a few
> > > years already.
> > >
> > > Not sure if there are any other benefits to gcc-8 besides
> > > allowing minor cleanups.
> >
> > Arguably a minor cleanup, but on arm64 that'd allow us to get rid of th=
e old
> > mcount-based ftrace implementation and rely on -fpatchable-function-ent=
ry.
> > On its own that'd save ~130 lines of asm and ~70 lines of C, but it'd a=
lso
> > remove some constraints on other features (e.g. the mcount-based form's=
 graph
> > tracer isn't compatible with pointer authentication), it would simplify=
 a few
> > things going forwards (e.g. the implementation of RELIABLE_STACKTRACE, =
since we
> > could rely on having ftrace_regs and a single trampoline), and the rema=
ining
> > support would be better tested.
> >
> > I've wanted to remove the old ftrace implementation for a while, but on=
 its own
> > it was never important/urgent enough to justify bumping to GCC 8+.
> >
>
> I don't think this is minor, tbh. Supporting two versions of the
> highly complex tracing infrastructure for a toolchain that is only
> used in CI seems like a waste of time and effort.
>
> I checked x86, and it needs at least GCC 7 for retpoline support, so I
> reckon at least GCC 5/6 support might be dropped there as well.

Another data point: __GCC_ASM_FLAG_OUTPUTS__ needs GCC 6 or later on x86.

