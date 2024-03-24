Return-Path: <linux-kernel+bounces-112569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADC8887B91
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 04:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6A55B210B0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 03:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE352CA4;
	Sun, 24 Mar 2024 03:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N19B3/Z7"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9189717C8
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 03:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711252284; cv=none; b=Jsq0wulZ/qr5M+K9UtXu5T4ezeG5M52RbJgL7Mh4gmITC07Opjh++6dP+b/OC1z3dJ70XardnrszBojtVskVR/vs2cVpuZuHC30Dpr1K1PsiNDR9yLdV/LkU4n3qtVLYbd9NFx0FJzu9iCxiOFIYQhcHKyydOMIQ4HbDK0+Jx1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711252284; c=relaxed/simple;
	bh=FRA3SbYULkEbHhi+02VVaUR5YzRep5NBG3Vur7cOxx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YD61FW65lYbM4B0TLSkDsjBN0JaYWF4F10Dx/801Q9rQFFsIVqose3Slur0xPTrm/TgROFWCe+vOJ1/Ey0TtXuTQSASEuaJWzCrXPT81SE3o6Qey+J+4CPtTKGzjLRTfjEqDo3YOC2PrnYMA6S48jwPhECIZ6ohMLI+eLO95qhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N19B3/Z7; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-513d599dbabso4366610e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 20:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711252281; x=1711857081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8v+941MPTOIpQ00N6b6vNCUVj4Hbos1al937P/1VQI=;
        b=N19B3/Z72Pdvr1voSWl5mLg5x5yX3BrkxxkbjOFQmqYEAOlXoM8U2yuXVbHCJJyPsA
         C85ZAXvkytku2VT7Yq348UMHGKinPMs6EsibU0CJCEw7xcGYYZI4So4x9ywfXki7PrWd
         viLj8/hSw4bbIcRyInKR7wo0i1zuEcWPMVvvFm5r9C4j90NhFLuo6r+qmGHq5XkhUTFN
         4WSRqsU8gRi7MI2H27sfVoqwM3Wb1De4HWxCbxkPBRapxaDr4a6s6ej7bDNbXD/YU4zN
         nXGEfQpL2aqHvCsDMykOGHJoQZoFTmBV2xamkCtBZzV+0HszudasqQnhIZxado+SCBF2
         wZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711252281; x=1711857081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8v+941MPTOIpQ00N6b6vNCUVj4Hbos1al937P/1VQI=;
        b=vaieBNX250AKU4op5YITA3+9SmGcotSJqbGDZXwEhbt/V/sUulbDXyGfHiNhHEHATH
         CIkFTCWLg9MLO0aFTkAuIqTYBtlMCkjNT8jkm2JYM5opBMc+MEcaryZxCohe346VmcX3
         TGHsCQzOR1daYNDiurB8qTIxefZZ3r0p4j6r2Cakvk1pxzVy5cLUzxYnju6mULtgJ2MC
         tu+HI6APwbgsj0GI4W8k6bNvve1aXXspeoWpmRaTwZMHT/9JLa6zPu9MjQJWBZI6l9GA
         uxR5gteAO5TdZ75WyHQtMc12vT2VK9Rx86jp53cpC4OIYdi9/+A/14aPYNlSHjkARAtB
         M7pQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCPGn1OEitNfVcNoEWmwPwfG9okd2AygsU7jedWfPgvIkRNQaWO6UJrEV2CG9CDsTbTl0cikoFEQ2Mc7wbM1SwMqUxoKY2qxE7nAvL
X-Gm-Message-State: AOJu0Yx2yWYVTiI3kDE0NWsRDu5vNwdEbqNiMD3nDEGdfcHvpmmfDjh4
	Hj9S0suuU/PQAEKvRKmMTouX9AEvvBRD1NDYIik8r1J7+hEVClv6W2T9FTIOjThcfM8fPGFavzI
	66n7Cxqf1TTMcAGi0/SixP6/6oQ==
X-Google-Smtp-Source: AGHT+IGNUKw94ZXVTiWTxe3R6HZZI3MOzB6A7jqBoCWbhDflHqcOvZavih79sODHNI2cjc1SaTimDQm9Y0Yn0fU6Ijc=
X-Received: by 2002:a05:6512:3d06:b0:515:a755:9e93 with SMTP id
 d6-20020a0565123d0600b00515a7559e93mr1022987lfv.35.1711252280350; Sat, 23 Mar
 2024 20:51:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322165233.71698-1-brgerst@gmail.com> <CAFULd4bCufzKjaUyOcJ5MfsPBcVTj1zQiP3+FFCGo6SbxTpK2A@mail.gmail.com>
 <Zf+PIYP4TyF6ZRVy@gmail.com>
In-Reply-To: <Zf+PIYP4TyF6ZRVy@gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Sat, 23 Mar 2024 23:51:09 -0400
Message-ID: <CAMzpN2htOit94c-M+zHqEcLcGPOU2zTS6wM-r7xWwd9Ku8h3-Q@mail.gmail.com>
Subject: Re: [PATCH v4 00/16] x86-64: Stack protector and percpu improvements
To: Ingo Molnar <mingo@kernel.org>
Cc: Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, 
	David.Laight@aculab.com, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 23, 2024 at 10:25=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wro=
te:
>
>
> * Uros Bizjak <ubizjak@gmail.com> wrote:
>
> > On Fri, Mar 22, 2024 at 5:52=E2=80=AFPM Brian Gerst <brgerst@gmail.com>=
 wrote:
> > >
> > > Currently, x86-64 uses an unusual percpu layout, where the percpu sec=
tion
> > > is linked at absolute address 0.  The reason behind this is that olde=
r GCC
> > > versions placed the stack protector (if enabled) at a fixed offset fr=
om the
> > > GS segment base.  Since the GS segement is also used for percpu varia=
bles,
> > > this forced the current layout.
> > >
> > > GCC since version 8.1 supports a configurable location for the stack
> > > protector value, which allows removal of the restriction on how the p=
ercpu
> > > section is linked.  This allows the percpu section to be linked norma=
lly,
> > > like other architectures.  In turn, this allows removal of code that =
was
> > > needed to support the zero-based percpu section.
> >
> > The number of simplifications throughout the code, enabled by this
> > patch set, is really impressive, and it reflects the number of
> > workarounds to enable the feature that was originally not designed for
> > the kernel usage. As noted above, this issue was recognized in the GCC
> > compiler and the stack protector support was generalized by adding
> > configurable location for the stack protector value [1,2].
> >
> > The improved stack protector support was implemented in gcc-8.1,
> > released on May 2, 2018, when linux 4.17 was in development. In light
> > of this fact, and 5 (soon 6) GCC major releases later, I'd like to ask
> > if the objtool support to fixup earlier compilers is really necessary.
> > Please note that years ago x86_32 simply dropped stack protector
> > support with earlier compilers and IMO, we should follow this example
> > also with x86_64, because:
>
> Ack on raising the minimum version requirement for x86-64
> stackprotector to 8.1 or so - this causes no real pain on the distro
> side: when *this* new kernel of ours is picked by a distro, it almost
> always goes hand in hand with a compiler version upgrade.
>
> We should be careful with fixes marked for -stable backport, but other
> than that, new improvements like Brian's series are a fair game to
> tweak compiler version requirements.
>
> But please emit a (single) prominent build-time warning if a feature is
> disabled though, even if there are no functional side-effects, such as
> for hardening features.

Disabled for any reason or only if the compiler lacks support?

Brian Gerst

