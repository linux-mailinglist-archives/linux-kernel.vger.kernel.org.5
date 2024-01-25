Return-Path: <linux-kernel+bounces-38595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BD983C2D5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B325229098E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB774F611;
	Thu, 25 Jan 2024 12:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUhPMYdp"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0E04F212;
	Thu, 25 Jan 2024 12:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706187019; cv=none; b=eujLsx8HOTDwQ4IHhgcJlXm79I2wxwEuHuSc5q4q4KP9gvPPaFPYn3vsALl6isHPvY+Sh00pPCbZlERCN+s17dXNGPXmRbtonGm38m/JWLTXaJHOKN5Q1c8sLoAgtrp2Z0k3AXQ/0UuREyZuBmvPgydO90b+oJekrpMFAM49PeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706187019; c=relaxed/simple;
	bh=oOzAf62Q5EQWJNHfwm0u23zGJZG4Xz8s5DNGaCHvSkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qrGaMpfa/mtVXbs0BY+oIKMpeCehnVhUm17mNvolkKqjAzBoY4ZN67fCjp8hpi/0eG1xo11b5hKkB6q9PBkTzyhnBIGB1lNa6uAv3AdOSCsuyh6TUnbR6TTiSwx3Fl1DnycLNVEX5P8JtxsGfog4JOZ9zPXJThe5CLanLxnxE8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUhPMYdp; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5f69383e653so65846737b3.1;
        Thu, 25 Jan 2024 04:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706187016; x=1706791816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOzAf62Q5EQWJNHfwm0u23zGJZG4Xz8s5DNGaCHvSkA=;
        b=NUhPMYdp37rzgq+oE3cEv2fnQzdAUGCXtRT2tpCOB4dYOQyqIEcAGg8o4xBYajH/rG
         uqb5JkAOpCIa2ZK8kR8viZsgSFlQ8d41EuLGZKcReC87M6Wi73AnMct78rJvGdeRvCOE
         AIx20u37z6w3Mq0g6kHCXtgr1G7DL9M2TJv+Wup0qbLTkdCszoA6K9tAsI/Y8ir/usnO
         9XRGD9y6/VO87fL2OBE0d4IWPgVfe6C9h7iPt+dvOuzDuUB+dKQ/0XNDBRSPqX2Tt8AY
         ANAAh2vPyrHBGJXOqs59smmlHTOksaJOodxTiHRVL3EdrKdU9sKaNbCnDup9OWf6ENF3
         mm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706187016; x=1706791816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOzAf62Q5EQWJNHfwm0u23zGJZG4Xz8s5DNGaCHvSkA=;
        b=ALE2Eh8Cjwo1S+BiY08UVJ2HBTVSlaILV6tpWhT/ChCx2OsMKRaLfxgkz0HNOaECZT
         cqUmyPTrFZ8/9Si2INJnXBafyetexrgVyOQh3XAbxPDBEvT7+utSatB0PDrA9RApbUpQ
         72MhapFyclkZqGu+Gz745O3WiKSY3riGb49W2mP5QPx8V/TKX51z6V8i6DOQFaDg8Gzv
         aR9sUVE6Mu4gp15BL7+fExV9vUv33H1VkAsmc9J1RwZHtSdKJaEZHxPxO3v9T6NSdlDz
         l9SimgJ4XXsWFjqTXQNltsULu9ja3yfWBndXGLcFjpkPnh15TKTkCMiLELdvUkUcA0ge
         mVoA==
X-Gm-Message-State: AOJu0Yzist1iKNJbyGR/auI4Cpe2TcPhZfezw2T0GQFvyhP3uCLq7Vrt
	uNlfflm6myvuAqrf9sAcFOKX8mG+irhPFTtZfbLYlTldWk6MzEperOMGU8q06cx3M8YDeZz9o2y
	VWdqm7fk1tLL+0mj0TH4Si6gQM2k=
X-Google-Smtp-Source: AGHT+IEAr8OYVcCCv8ykkRFWiLud/ObEU2fmDTsdYvjCgjI7xiAcQS5cp87B+9j60Ce7rUjafSwja9QMdshXEp07rws=
X-Received: by 2002:a81:4983:0:b0:5ff:638f:441e with SMTP id
 w125-20020a814983000000b005ff638f441emr571223ywa.103.1706187016606; Thu, 25
 Jan 2024 04:50:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230307102441.94417-1-conor.dooley@microchip.com>
 <20230608-dispatch-sneer-aa09bd7b2eb8@wendy> <CANiq72nnph7LS1fLRtHz8NJ91PWXPaUnm0EuoV3wrbvK398AnA@mail.gmail.com>
 <20230608-spiritism-gonad-5f5aff4c3a24@wendy> <20240117-swiftly-parasail-618d62972d6e@spud>
 <CANiq72mVKCOAuK4Qe+8AHmpkFwyJsVfx8AqB7ccGi3DYpSSWcw@mail.gmail.com>
 <20240118-implode-delirium-eefdd86e170e@spud> <CANiq72nx1s_nyvPW86jL7eiOxROr18LfOJqNtw8L42CP+gkhRg@mail.gmail.com>
 <20240125-bucked-payroll-47f82077b262@wendy>
In-Reply-To: <20240125-bucked-payroll-47f82077b262@wendy>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 25 Jan 2024 13:50:05 +0100
Message-ID: <CANiq72k7n0aZrifRRU08N8qLkNe+2EZwijZy5sM7M56n2xYHgQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] RISC-V: enable rust
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	Matthew Maurer <mmaurer@google.com>, Ramon de C Valle <rcvalle@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 1:31=E2=80=AFPM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> I chatted with the clang built linux folks about this yesterday, Nathan
> agreed that dealing with incompatibility issues iff they crop up is a
> reasonable way to go.
>
> If by "the bindgen found one matches the C compiler" you mean that the
> version of libclang used by bindgen matches the C compiler, then that
> sounds great.

Yeah, exactly. So, unless I am misunderstanding, the incompatibilities
could only happen if someone ignores the warning. We could make it an
error too.

> > For `bindgen` under GCC builds, we will eventually want a "proper" way
> > to use GCC instead (or possibly other approaches like querying the
> > information): https://github.com/rust-lang/rust-bindgen/issues/1949.
>
> > Recently, there has been a thread in our Zulip and a couple people are
> > experimenting: https://rust-for-linux.zulipchat.com/#narrow/stream/2880=
89-General/topic/Bindgen.20--.20GCC.20backend.20port
>
> That link for me goes to a message on 22/01, so later than the email you
> sent.

Zulip seems to scroll to the latest message in the topic -- you should
be able to scroll a bit up, but if that doesn't work, this link should
go to the first message:
https://rust-for-linux.zulipchat.com/#narrow/stream/288089-General/topic/Bi=
ndgen.20--.20GCC.20backend.20port/near/412609074

> That said, I gave things another spin today, in a different environment,
> as a final check before sending and found an issue causing kernel
> panics. RISC-V (and x86/arm64) supports kcfi (CFI_CLANG) but enabling
> sanitisers seems to be a nightly only option for rustc. The kernel I
> built today had CFI_CLANG enabled and that caused panics when the rust
> samples were loaded.
>
> The CFI_CLANG Kconfig entry has a cc-option test for whether the option
> is supported, but from a quick check I don't see a comparable test to
> use for rust. Even if a test was added, the current flag is an unstable
> one, so I am not sure if testing for it is the right call in the first
> place, given the stabilised flag would be entirely different?

Yeah, KCFI and other mitigations is WIP -- Cc'ing Ramon and Matthew
who may be able to tell us the latest status.

Testing for unstable flags is fine, i.e. we only support a single
compiler, so we can change the name when we do the upgrade.

Cheers,
Miguel

