Return-Path: <linux-kernel+bounces-83057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFDA868DED
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91217B27608
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718441386BB;
	Tue, 27 Feb 2024 10:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0VpuCvd"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7873D137C36;
	Tue, 27 Feb 2024 10:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709030816; cv=none; b=LuUXgZzW77uvOb/1VJM+WpX/64VWuCx4a3pQ2SnNOUejMl1FJMZapBRUEpbGx4WAK0ylFd92tTClDKg1q7bQUihoTt2iM7GMS+4iNnGCkpHRVISPvj34RKZf97QfSjtyRBMJfGIDO0xPN2fU77Igja3lTTWEoq77cgg5S93xozg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709030816; c=relaxed/simple;
	bh=XHyReOttpij5I54r5x4WgZ+cIyUHaBfTMin6OfRWlGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B/bRKfKIRC7H3Tv8z7J7dXq7GXmFw1282UuNk2O7suUbFEwpRrL1B6KkqDj0fCmbbO/YXp9DRm6P9FpZouKhnm7BygNbEtUIgW8QEsmuLqOh5n7CHOzo2oodEW032+PY7Ga5qDsZN1KKBhevVvFXBjdF3DMcLNR7SnGt4n6XovE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0VpuCvd; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-29996cc6382so2780508a91.3;
        Tue, 27 Feb 2024 02:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709030815; x=1709635615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHyReOttpij5I54r5x4WgZ+cIyUHaBfTMin6OfRWlGU=;
        b=Y0VpuCvdBt7C1P4kfCsaRV6cDqPio2fHc6Zm+TSwT0nPq5r5Y3nJGqMzGPzZkKpuFH
         //QPWPoLf4ZCtxJvqj/7MAvZma1FfqPGozfoK7v6Ts0pUK4IPFJpAYnN68/6KEbMNm92
         IX6ZsnOuGtHioByp/x5EnDazkB2/bGkx9ZHTxA7uztHCP08GT+PGMxyZRykbSpDX/jY8
         Ar3D7/EgId+u/ce84Xk3FerDVWlMayvqPCP9X7rbil61XGhVV2i5KtqrUSkei3R2DYZT
         2LWX/rG6318GlSPAWercAIH+Ytj/r3N0KExrWjI5CW5sTIIJIxnCjmKuadv1Vq4327/d
         pEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709030815; x=1709635615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHyReOttpij5I54r5x4WgZ+cIyUHaBfTMin6OfRWlGU=;
        b=tKi8IJT0Jz5ze/GtUF+2YVifKUpqoF8xmng+xraIGsHCM83yXoRl5JTNeIED9mCU5k
         cp/ths5hRJtWOcsZFJ+vT78KOzHAxie+gMMVt1nl5iz2Hzj3LsGGbUeXc6CD02aIuQ8+
         wo5WCc5xb0h/Ap5mWxieVm1MKQUnuPTK3rYpk92y3NRvGt9/q4CrCScykbkg6O7sbBha
         HWjQS4R4bory2Oc8ynTfdl4rSwC73j5OTHRxGNWtVIZpB1dTsDqpJVcn95IZ3qMWTlzR
         xac43oxmWNOWe/b07xAqusN2nCDHjUjFx8BwPXBDIRk6uGdGqTBx+48e8nhRZw8V7+ac
         ikVQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4QJ5rf6vbtDLgcZ7MVihOA8Z6Ax5p06uTnLs7WAaTzAKqUARrtWnnn9tP9CfzqXbxoiPDXQj1nI2SR+QBoIQ8JKPZJBAbH7TIPRURzXE8fpshl1J0pB/M69ASGrLFqy2P3wyfdn2MB6eVL8xPz/EXjfjR0EDXaib8/GiV9/Zdz641cS0qv+M=
X-Gm-Message-State: AOJu0Yz105ynEUacs47HD2UM3aLG6Acbknfqa3yPZ6XX/sMOQQ6uuxWP
	wGz1X7nhL88++q3pHnZAl/OXYWeXwS0+dxTnyke7qeKv5ou6EIXpRJ1KlpLM9ER1mNSctd+5xPL
	95dpBN7ZOVWZwYPvCRGDSGgdU/1Y=
X-Google-Smtp-Source: AGHT+IHM+6rRS1JfIDKhTWqLKrWosGlB3CKAX90C0/Xd3mVu0FyLDdjQsn5XBbm5H/3r+xFgrsAmb7KF3ofv00QMlG8=
X-Received: by 2002:a17:90a:e018:b0:29a:ce5f:4da1 with SMTP id
 u24-20020a17090ae01800b0029ace5f4da1mr3644307pjy.8.1709030814815; Tue, 27 Feb
 2024 02:46:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223-leverage-walmart-5424542cd8bd@spud> <20240223-employee-pessimism-03ba0b58db6b@spud>
 <CANiq72ngEZskjH0f=8+cJuQsFTK227bGCxe5G0STMHuPbZYnXg@mail.gmail.com> <20240227-resolved-deceit-4a59a6af5b71@wendy>
In-Reply-To: <20240227-resolved-deceit-4a59a6af5b71@wendy>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 27 Feb 2024 11:46:42 +0100
Message-ID: <CANiq72mwM+4Oh-H5WmRoqQ_nE1w-eJ1wn-nEwS=BR9JRwzxMMQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] scripts: generate_rust_target: enable building on RISC-V
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org, 
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

On Tue, Feb 27, 2024 at 11:17=E2=80=AFAM Conor Dooley
<conor.dooley@microchip.com> wrote:
>
> Sure, I'll take a look.

Thanks!

> Nah, I think that is silly. Either this goes in as-is, and there's
> fixup done by Linus, or the thing should be converted to match arm64,
> assuming that that is possible.

Ah, so you are going for 6.9 too? I can give the series a try on my
side in that case. When do you plan to apply them?

Cheers,
Miguel

