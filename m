Return-Path: <linux-kernel+bounces-62250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8B4851D89
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07C291F25DA7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A247F45C14;
	Mon, 12 Feb 2024 19:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FJGUzsqs"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4AF405D4
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 19:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707764651; cv=none; b=UDUi3K3yqruhQspSU9KnkRg7fCAkz0IMCPACO4cbYqVYLmUyh6WeoHlEgYnh7DE6Y8kF5GSO70hCNZh+eAP+i2SoPyXeilfhsuaLHocfKDCPjEliUMTwnHTVNth526MDip0yHh6JFVXQ7EyXpNpK+OPJCDUItErPr7uFxl4iQyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707764651; c=relaxed/simple;
	bh=XzCqnLw1+99Zw8U3ViYnydrnyF7SQJQlIabSysNhMG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZY6ISshZIzrfa0Y+AC1fNs0EPo/ipcNuYBeZdWPh/m88qF7U1YHcMdvE0PyjNy+6bdNBSmWGLREWcEeNQXCdGIjpOQyfia1pUbTxL2oZcUdrU4fPASbj5AmtZ6Wh5C8rlfonz/U5vXOAdrcRxLIl6lPsHi3Z5Owpk3L7WptmtAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FJGUzsqs; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a36126ee41eso467978166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707764648; x=1708369448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzCqnLw1+99Zw8U3ViYnydrnyF7SQJQlIabSysNhMG4=;
        b=FJGUzsqs0oEXIEXG1O02mZWoh9PNX3G4tnTbB8/nJZ9Fjpi6y5UD3bLNJubc1zHB7U
         3DxdA/TfREU1MRxReA1fDE9jWqdouXmPpdwWUNNXHp+9oMvWb/mCE57cGOD7DzEetjH1
         Rp4TVwoEM1Sdt4V2ua+fV1Xf2qmQRW9lTtiTwLvB5p/kKsjm6ZIaYv/YvAcE2cRZQrp8
         /28TyfgW9rNe7Ilm08pbMZdVrRgK1e+2l101h44QRrTA1BvRStcOwCKW74jUaWs7De+q
         U9Vxs2OQi1k2tsh+wXf2gWZYUOL7/FP6SmHafupc84Dup1RMe6wpTm3h1P9K9SAktKgl
         R5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707764648; x=1708369448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XzCqnLw1+99Zw8U3ViYnydrnyF7SQJQlIabSysNhMG4=;
        b=jFuePkewuqiiCwzn+11vFC2vxdBz7ZzJrkqNgXbwHU6uNtXahME6k2HEMO1X3SFOv1
         ak2aRusR5Qhb2O2y5XwZR7BkrNyqvCmOSkIDJ2JI+PkNc+GahuT7SfZNmp1pCKRb24Zv
         bjaCLZ/KJufOE6he1jCezhi+Rl3EM4q1HfTvFgOrQVUIMKVRKg2vSJAnKBEqXGhD9Pxu
         HGf3QKKq1u2zHN1tMeO+atWXKeinQUlxNxd0UECoYVDgyP5aSaTUtONoo+JWPdHHqUkT
         0F8QzMj9jE1qd6z0iShgvNep5ZLxwnzCVeX3VKsE9u9XrYt2fCTOxTz7bZFUPw6vYEQu
         Y5sQ==
X-Gm-Message-State: AOJu0Yz4DieJm7bL6m3WXHN8t/hSIbBXFDF22K0MtwHqZdwGy0VwJUcS
	4vClUhg4v7VsLlhyr6HTf5bDJlv6yhuvGZn3jvxQjIRTV5QJHnb/KUZ6SwfDPBiIODeuR0cMfh2
	vr4edgncW6otNaiEQxos5x/8eShaFWFUNtD8yhyJZGSKAWMpgyJCtIKmKHA==
X-Google-Smtp-Source: AGHT+IHnLHXZNcbMXm4/pyV9sKf1lkpL3ZT5WagZ+5/aVIbKJQcmollNZSQjHxCY6hY/l4tsQS155BB4J/oVAOoGvcU=
X-Received: by 2002:a17:906:4ad8:b0:a38:576a:f070 with SMTP id
 u24-20020a1709064ad800b00a38576af070mr6189593ejt.32.1707764648413; Mon, 12
 Feb 2024 11:04:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-swiftly-parasail-618d62972d6e@spud> <CANiq72mVKCOAuK4Qe+8AHmpkFwyJsVfx8AqB7ccGi3DYpSSWcw@mail.gmail.com>
 <20240118-implode-delirium-eefdd86e170e@spud> <CANiq72nx1s_nyvPW86jL7eiOxROr18LfOJqNtw8L42CP+gkhRg@mail.gmail.com>
 <20240125-bucked-payroll-47f82077b262@wendy> <CANiq72k7n0aZrifRRU08N8qLkNe+2EZwijZy5sM7M56n2xYHgQ@mail.gmail.com>
 <20240125-lazy-thrower-744aacc6632a@wendy> <CANiq72kb+_utZrYHtoKZQtQazikmkjpVUHpTBcaANizduMF5QQ@mail.gmail.com>
 <20240126-eccentric-jaywalker-3560e2151a92@spud> <CANiq72nu2NXUWYanHZd5EXgX4P_v673EWn6SCRW60Es9naraQQ@mail.gmail.com>
 <20240209-rage-keg-1b2982cd17d9@spud> <CALNs47sRqAbE=u3=_ciO2oge7Afz-6GBBhW+BwcLRET-TsuxTg@mail.gmail.com>
In-Reply-To: <CALNs47sRqAbE=u3=_ciO2oge7Afz-6GBBhW+BwcLRET-TsuxTg@mail.gmail.com>
From: Ramon de C Valle <rcvalle@google.com>
Date: Mon, 12 Feb 2024 11:03:57 -0800
Message-ID: <CAOcBZOSfN8Yefez_Gy_T3_QTAd4HcLzmMCOoR37K2agWD_U_PQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] RISC-V: enable rust
To: Trevor Gross <tmgross@umich.edu>
Cc: Conor Dooley <conor@kernel.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Conor Dooley <conor.dooley@microchip.com>, linux-riscv@lists.infradead.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	Matthew Maurer <mmaurer@google.com>, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for the late reply. Sami might be the best person to answer
this, but KCFI (not CFI) tests are lowered by passes that are
architecture specific (see https://reviews.llvm.org/D119296), so we'd
need to add support for RISC-V. There is no additional work required
in the Rust compiler besides enabling it for the new target.


On Sat, Feb 10, 2024 at 12:13=E2=80=AFAM Trevor Gross <tmgross@umich.edu> w=
rote:
>
> On Fri, Feb 9, 2024 at 9:18=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
> >
> > On Sat, Jan 27, 2024 at 02:46:38PM +0100, Miguel Ojeda wrote:
> > > On Fri, Jan 26, 2024 at 11:01=E2=80=AFPM Conor Dooley <conor@kernel.o=
rg> wrote:
> > > >
> > > > Is that even needed? We already have ARCH_SUPPORTS_CFI_CLANG and AF=
AIU
> > > > rust supports it if clang does, so a second option is superfluous?
> > >
> > > From a quick look, I don't see it enabled in any RISC-V built-in
> > > target in `rustc` yet.
> > >
> > > It may also still be the case that KCFI needs some tweaks for, say,
> > > RISC-V, before the flag actually works, i.e. we couldn't just test th=
e
> > > flag in that case -- Ramon: how likely is it that RISC-V would work i=
f
> > > KCFI works for aarch64 and x86_64?
> >
> > Well, there's been no reply here. I'll do sa you suggested and add a
> > depends on !CFI_CLANG to RUST.
> >
> > Cheers,
> > Conor.
> >
>
> I asked on Zulip and it sounds like Ramon may be out [1]. It
> _probably_ works, but going with a dependency to not be blocked on
> KCFI is probably reasonable for now.
>
> - Trevor
>
> [1]: https://rust-lang.zulipchat.com/#narrow/stream/343119-project-exploi=
t-mitigations/topic/KCFI.20on.20RISC-V.20questions

