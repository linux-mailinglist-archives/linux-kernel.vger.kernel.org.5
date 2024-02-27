Return-Path: <linux-kernel+bounces-83800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8942D869EA7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 888D91C255CE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D12614831E;
	Tue, 27 Feb 2024 18:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9JmTrKM"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DD84B5C1;
	Tue, 27 Feb 2024 18:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709057492; cv=none; b=r0pMEf1ac5KCA0VRbRO4j+1ZkmsX8yEF8NJGvfVvNzVfUgRRdtz+B8KJLTv6oG4RDy5nBItBBmteDoOKFZwVeoWZrEQuJASbrOe2dDqJm059/mPsReTAbGu5h40MLP5viRjhHqqc0tXUJ0qAge76Znl3uzhsO8KFN+EUka+JzI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709057492; c=relaxed/simple;
	bh=MMz4gkSGSqX8KBz3u9sPg+H10dtSow275aT+2BTX1/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZA2cncIhRwzMdun554eMnjoeacTX72HxOjpD9YQz3flz4dMDIMKT2Y26FsvQW/SVjrbPVW0m68boXeA2COszfgp3uA6/a+g5kvxhcTOWfh8PBV6s02+MAsddV7ABee92YXHSa2UZoSuntYzYrWCYmctzj18SQ/Q+bo3EiVmaas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9JmTrKM; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dc1ff3ba1aso38891775ad.3;
        Tue, 27 Feb 2024 10:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709057491; x=1709662291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMz4gkSGSqX8KBz3u9sPg+H10dtSow275aT+2BTX1/c=;
        b=C9JmTrKMxhj+pZ08y7FURNfU3ks+TFtepf0yT/IpHzJFWZM+Wu/qMfdw11CzRWp4Nl
         AJcOq9JQEPz5c9YO3nsy3EvwIHocUeF5u1zbp4HONHq+pVGltQzR+9Jm9InNtWpwZdJp
         x9eMvs97d2MRj5Hes3jKkqIVHpbaV6YM3uf/rFIZQep0AivksX7XGx2rFK0LoQtaRUhb
         R3b7p+I/FLCBGbFwfVaQW8OhaTcZoAzlY8VEMBVR1sWatTeDtYUmXEq1erI7vUyxleYL
         BYKvr7fVBVJBSV9qPR1/Lk+mZi7Fx3LxukGDFcBC7q1PN1Cjg1NvXuyj6g1Jce9VK2L3
         bmdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709057491; x=1709662291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MMz4gkSGSqX8KBz3u9sPg+H10dtSow275aT+2BTX1/c=;
        b=EritSJoJ9p3rKpy+Jjk6iJMa3Wnl5f8MkiHY0P1CnfBGh0x9oqTmC2o/JbXUMWMhkU
         ANvVwTL331j75rus7MilEygar+pKnGXqU4KQe2aSOHxtJW4rPEciTAGn0vu+IYLLnXme
         /DsSiwUTDcmu21OxrrOSBB7398GI2cqEthzSOqUfWUj2GDe5btd+zEiyK7XzJwMkg6pw
         OQkTyREDlsYzJnlJSCTGe+4/NtkD5xXu1BGCCp1wMrZgsBOATQo2QtGtGPvBcIBPCbtF
         5oxPg5sCgXBTLJb0O8Rc56KVYnR6+uTAwGil8wfPeAr0H1E8ZQJKq5WuFBr4JpJHTc98
         arqg==
X-Forwarded-Encrypted: i=1; AJvYcCVsCTpV18ROU8tHju0wvmPLYwba2X23BCvV/QT/ujDDHxrQ88LavIepM10cYR/eQjXACkFzwDRqQeNYwKIA0J0tEcZfi3ftFuThHU4/rjy3fgmT4TWigmJOXAlPoOUKESMzZ38gV8DMDquHIDg0B5jN/ngsB0311LBaxxXsjccK5ta7k4XyDTQ=
X-Gm-Message-State: AOJu0YwwgczTenAIrpBfX5ocmuJFMCpz3udQODyUaXoCQZuGulLwrUK3
	uFlwXpPhwckJ71Mzi6yksLGxMq3K6dOzgYNXOKIfjWacxpPPbO7T46cFG5dgCRHhYK6ZcdVi33Y
	yoirg5lw/DAlWZqFZ03D6DRH9Gag=
X-Google-Smtp-Source: AGHT+IEsUCrkq/OPRo37hLxEJi/HVswFjqS4zKGwkwKwXanq1jXthlIIw0jzgDza4ht+oCgXlPGyJKryUUW06LAmzOk=
X-Received: by 2002:a17:903:2309:b0:1dc:b4ef:b199 with SMTP id
 d9-20020a170903230900b001dcb4efb199mr3828629plh.36.1709057490589; Tue, 27 Feb
 2024 10:11:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223-leverage-walmart-5424542cd8bd@spud> <20240223-employee-pessimism-03ba0b58db6b@spud>
 <CANiq72ngEZskjH0f=8+cJuQsFTK227bGCxe5G0STMHuPbZYnXg@mail.gmail.com>
 <20240227-resolved-deceit-4a59a6af5b71@wendy> <CANiq72mwM+4Oh-H5WmRoqQ_nE1w-eJ1wn-nEwS=BR9JRwzxMMQ@mail.gmail.com>
 <20240227-glove-underwire-f562a56cf2c7@wendy> <CANiq72=f03_bw9B8ww8UxHkVyP2F7ZPyvC+KWCyhO3Nk1yqdaw@mail.gmail.com>
 <20240227-swarm-serpent-2010b255f68a@wendy> <CANiq72=69uBBhKMrw5P8K6eDHPiwAw_Oj8g1aYcywEYhhUG8OA@mail.gmail.com>
 <20240227-timothy-jailbreak-01a9c29f3607@spud>
In-Reply-To: <20240227-timothy-jailbreak-01a9c29f3607@spud>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 27 Feb 2024 19:11:17 +0100
Message-ID: <CANiq72kQ8===wFLQNCR-XAo9KdtPr44UKvyi2074J88vh3kvyg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] scripts: generate_rust_target: enable building on RISC-V
To: Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, linux-riscv@lists.infradead.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 6:48=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> No, I didn't actually try anything. Between trying to test the kcfi
> stuff on arm64 and the other work I was doing today I did not have a
> chance to actually play with that yet.

Apologies, I didn't mean it that way -- I was just wondering if it
didn't work. No rush on my side (in fact, I thought this was for 6.10
anyway).

> It comes down to you though I
> suppose - would you rather have generate_rust_target enable the
> compressed instructions depending on the config option or have the
> Makefile disable it if compressed instructions are not enabled and use
> a builtin target?

So the custom target support is there for flexibility purposes: we
were told is that since the target spec is too tied to LLVM, it is
unlikely to get stabilized (at least as it is), and thus they
preferred that we ask for whatever flags in `rustc` would be needed to
tweak things in an existing builtin target (or add new built-in
targets if needed).

Thus, when a new architecture is added, the question is whether one
can already use the flags approach or not.

For instance, to disable the compressed instructions, from what I can
tell, the flag I mentioned seems to work, so that is fine. However,
for something like tweaking the data layout for `n64` instead of
`n32:64`, I am not aware of a way to do so via a flag (but I see newer
LLVM uses `n32:64`, so that may be the better one anyway:
https://godbolt.org/z/Eh4cfdeMr).

So it all depends on whether you are happy with what the flags
approach already give you.

I hope that clarifies a bit!

Cheers,
Miguel

