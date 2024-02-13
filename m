Return-Path: <linux-kernel+bounces-64211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2FA853BFC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A21F282B9E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1966560B91;
	Tue, 13 Feb 2024 20:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="JGzDt1Pv"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2B760907
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 20:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707854935; cv=none; b=aqUgecUE9GWrlsYDBBe2m5WtnjurR9bpHmstZelfhyZSqAzwl9C0zkHj07iLvpNEQ1pAcESWCDrVzSuBtyx6S1pp2M9CRtraXsvP4xQj9vqnlfzsw68MTON+oXTlFI+3HIaKP56AQ33/WcjhnuuvV/wdh87wGrQenztG2VtuRU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707854935; c=relaxed/simple;
	bh=cpamOG71/GOjbb277hAjAxNKP85thTjz3Ni8mu6y5O0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J3AFcdtIwl8yYvpi1jmaRvcGJrval1ib0ZBWT5EhmXVXIyHBBK3sMbBYXuxqAX7aTD+zwFdAJpQoCJ3hgDJdLpvOY6FiRNBUux45gbwIYAeKghJOjhsD8NvVST03lSJHbfHdS+TtM+vqA3QbpHYbT5z6mhRFU1vetOBzcVrd+mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JGzDt1Pv; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-511831801f3so3626650e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 12:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707854931; x=1708459731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cpamOG71/GOjbb277hAjAxNKP85thTjz3Ni8mu6y5O0=;
        b=JGzDt1Pvpt72gy+BF4PgUEfDg80yRUrWPLydt9ezvo/f54O6v/s4PyaNdCGTP2T5hb
         OC2eyRkpAIgbYdQ7292bZDYCOgbHk2e5+CO71zUefDHSDyrUnYdTUo7pLXomGh5UtDng
         LGjNP/9ofCPiM/7W2VuNIqHUrkG02s00dA8dGcSRXkIWwawcA0oT/tn9knlqePinCz41
         zu5eLBsUe4jTLIn3XgG/cfVv+czwHcLQm5Znq8t3oDXsbCczdE/DQiB52mjeZGHuHMnT
         D6+brohiYBhNx4qhU71EJuSZIBqsoIE3ScBhq4qx0c7lQKrnDgOqp9cb+7Bdf1NVN7Nu
         uHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707854931; x=1708459731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cpamOG71/GOjbb277hAjAxNKP85thTjz3Ni8mu6y5O0=;
        b=NVzYJY2IGCOxFYxRkjWN/pXaXzFxS70oVO7nm06ecLmR0iHgQxHIuPCgUIJ/zmuv3Q
         FRSKzeCNaIyy6VrfLGllg9Gls1vqbA7FRdcQCOZi39ki0+5hpFXg51KA9FLUxdT5w59J
         B+NLaeMhO5HKvUY7uMlaQ67bfFxFXAS4huZxTZWPbFO0y2S16nUdYhKkEpUtkJPweOHe
         wnNw/nWrxZNSmvfiJlUnMBi1dcWzaoLSRTTNUJTMCpOlmlzttEvqthNXlg9/S6n54MaY
         uHcC7aoQSlwTlvxzFbA4/58ZF7BURNH2xZd3+HryCC1vgg0yVTs2d1WFxBCYqFG8cQAU
         xAaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIfV2Zr1WmXF62E8bQBDNbT4MVXgSu5Ilq3E3GGcuaXOp6vIrkMlnhCxbM+7DmLAXECC34SWzheHNapfCSug4YPVvRDKhLDQBDP/vB
X-Gm-Message-State: AOJu0YxHB04UY+hl1tRP8QVGm9Ov3zUKRudGQGgNMWcEAbNG7U2/Y0aF
	v8WQAFsC14eTPWN4XQMh6zyMOzhnS4bLDmyauiHWxRwGQmZG0zji+GR6Qwwv4/OOfr7SOortMwl
	MwhRH6M8aHRepXLykP/3J+qTho4uctSxmTc2I
X-Google-Smtp-Source: AGHT+IEksRyiaHyX94m2jOEP9ui0B6orCI/t9VG5pKeC7bcLR1MRBQFg7mMD33nHbUDo0Wqb4aI/q/lCjH6E4TshwlQ=
X-Received: by 2002:a19:381e:0:b0:511:9f0d:633f with SMTP id
 f30-20020a19381e000000b005119f0d633fmr342293lfa.14.1707854931315; Tue, 13 Feb
 2024 12:08:51 -0800 (PST)
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
 <CAOcBZOSfN8Yefez_Gy_T3_QTAd4HcLzmMCOoR37K2agWD_U_PQ@mail.gmail.com> <CABCJKueFuDkmUmXWbtA3DveQ719vdZx5kBQE1bZ1f6oD5zYNzA@mail.gmail.com>
In-Reply-To: <CABCJKueFuDkmUmXWbtA3DveQ719vdZx5kBQE1bZ1f6oD5zYNzA@mail.gmail.com>
From: Ramon de C Valle <rcvalle@google.com>
Date: Tue, 13 Feb 2024 12:08:39 -0800
Message-ID: <CAOcBZOQMF9_QqPvTPoRa=uHw11o74-hm=YdjtDCTj-yeq4nwjg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] RISC-V: enable rust
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Trevor Gross <tmgross@umich.edu>, Conor Dooley <conor@kernel.org>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Conor Dooley <conor.dooley@microchip.com>, 
	linux-riscv@lists.infradead.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	Matthew Maurer <mmaurer@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 12:36=E2=80=AFPM Sami Tolvanen <samitolvanen@google=
com> wrote:
>
> On Mon, Feb 12, 2024 at 11:04=E2=80=AFAM Ramon de C Valle <rcvalle@google=
com> wrote:
> >
> > Sorry for the late reply. Sami might be the best person to answer
> > this, but KCFI (not CFI) tests are lowered by passes that are
> > architecture specific (see https://reviews.llvm.org/D119296), so we'd
> > need to add support for RISC-V. There is no additional work required
> > in the Rust compiler besides enabling it for the new target.
>
> LLVM 17 added KCFI support for RISC-V. Sounds like it's just a
> question of whether rustc uses a new enough version of LLVM then?

rustc is using LLVM 17 since
https://github.com/rust-lang/rust/pull/114048, so I guess I can enable
it for RISC-V targets in
https://github.com/rust-lang/rust/tree/master/compiler/rustc_target/src/spe=
c/targets,
and the Linux kernel will get it on the next compiler update?

