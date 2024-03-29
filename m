Return-Path: <linux-kernel+bounces-125359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 786F789248B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E16821F274D5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F1013A3FE;
	Fri, 29 Mar 2024 19:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqD6DUbT"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19EF13B79B;
	Fri, 29 Mar 2024 19:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711741755; cv=none; b=kMU8ITrzK4MP24eBHCTITbFqTysO9Cw8XF4JJF7wIfNF6YWacSM/1cSY4P9bDbs8ygfeMDN9ARkTxaUTGJgTMmjEQvgUthby1apWy3juf7sl6V/H0StOoxUJiGYlHyVU/n2GJ2padnsoLv5o5gMYIuftpb3iYowUbJEmt1GBIek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711741755; c=relaxed/simple;
	bh=sJ+UaoCLh7AzLciVOQ3NMwemWc0ufeeQ/hmoF9nh+m8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gA3V0B6YRS1+DwDSBef8YbIS7a8n2k/Y/vmPidkDz/ChepphggY5mPK8vQ13EkzyXKqa6V15h3IMYay/pL5tjEdDgRO6X5fy+QYvg9iPgbtKngMyipGyM6isq2MGprsHMirZIVHZ3ef/Rctxq6XvjHFDUg1GlIwHgHr42B6GmTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqD6DUbT; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-29f69710cbbso1587763a91.1;
        Fri, 29 Mar 2024 12:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711741753; x=1712346553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJ+UaoCLh7AzLciVOQ3NMwemWc0ufeeQ/hmoF9nh+m8=;
        b=EqD6DUbTtry/xdO1OjL6c1VJOwQnyMnoy8kJDEwqaougn7wdtvm775I61Lh4Ue1ScQ
         rfoJRE/H6tV4rK0wLQy0Dbh8+F+Iky9RCOCGLr8HMhpTAcweB2Oogr7P8UJlJrnzv+Lb
         APTDMxzvV0d7IsKUo/ekE7kMAqV/HESn7GfTm0jm9ogSvx+4kc/CIHLHA9lK2Wo8KGSY
         e6r6BEWD2he6G2vOeyxqxPjZ43OZZTZdbIYTxnAQsSJd7Y/Soe6gz7GorfKv59pZo6Zj
         8kdk04wrP2hRATmaPBHQBPG/6IBTLVQwYl2Yk7o87jIXGPfmzA5pNESHTA0a8IxfeySb
         p8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711741753; x=1712346553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJ+UaoCLh7AzLciVOQ3NMwemWc0ufeeQ/hmoF9nh+m8=;
        b=ihFnJCD/chgoXCbJ/yYtg2Ecc03vmX3TcwL5xHGaYR5nMKjftFW4EgeatZKGLcWIrz
         fy99RhnYstbpKsnN3UxghBDo1KVmlzGZTTPNTm1blagy24IiL4bmFW81zxptkWPWuLDq
         Mtlic6qQcxfnYMLKe4/UBasQ5F0GUtqe35JSwDVIPorI1zZqJtiHsFmkGc//xdQlX7VA
         LDuNhiFIj17pJSDO/2VTxOz77Gwal76gsmo+oa6kOWgc5ma/b7jEf/BBrceQ52MdwGiI
         Rba6YTJMlor0UoQeCWG6uhREqm7KPZMYYh4Kv7puoZGBLlEJpEyzCp8Dns1r+7CH+he9
         UVgg==
X-Forwarded-Encrypted: i=1; AJvYcCUWoeF2rDh0x+8VcqvM66ZGK3on+TZ67Bvhi73r2+Bd8pXn+CEh8FPouRcZnn66cOz607q5//XM04IXIHWVEtBry+/1Ipg23j/EsPerae7hvk3iZwQtW/fOz+gth2kHapDsFqgD1dfiKHp8bNARY1NR3duowgEgyRSnQeEe5xlJ2MXdbECEl1+0ZRA=
X-Gm-Message-State: AOJu0YwU3mBnbMDJWHNMgCmSCIySGLNnJ/5SlsO7WS0kRNLyTyQvhjBF
	iY3aHNmh4ndsR+3dw71Le19tyc2jZBMUw6CGyD7J6WJ+l1ehJcOe+XVu4TDRxIGs5mN/biNWxDy
	h2Ha3XT3bRxUlff1Bng2K8fdDcps=
X-Google-Smtp-Source: AGHT+IHOS/4TcCdBp8AgH2utv2wzrfe7U/6wBTLC8E1hnxWIey6SVgZ3g1TxwoMe1ZNo2sz/IHrk/09TAhBFWFojriE=
X-Received: by 2002:a17:90a:c391:b0:29d:fb99:7dcc with SMTP id
 h17-20020a17090ac39100b0029dfb997dccmr8838505pjt.18.1711741753063; Fri, 29
 Mar 2024 12:49:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217002622.57322-1-ojeda@kernel.org>
In-Reply-To: <20240217002622.57322-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 29 Mar 2024 20:48:39 +0100
Message-ID: <CANiq72nD4dLDRN09YC+TeFKsjF8Kmh9UyP6Za4g6RRLixjN+Kg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: rust: use `-Zdebuginfo-compression`
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	linux-kbuild@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 1:26=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Rust 1.74.0 introduced (unstable) support for the
> `-Zdebuginfo-compression` flag, thus use it.
>
> Link: https://github.com/rust-lang/rust/issues/120953
> Link: https://github.com/rust-lang/rust/pull/115358
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

[ Added note about zstd support in Rust-provided binaries. ]

Applied to `rust-next` -- please feel free to still send reviews or
tested-bys for this one!

Cheers,
Miguel

