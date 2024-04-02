Return-Path: <linux-kernel+bounces-127655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3006894EF6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ED70284CD2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E39E58AC6;
	Tue,  2 Apr 2024 09:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yLhI+zrw"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E4A58AA8
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 09:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712051213; cv=none; b=PUk3XMNwULHW1HCA3+ii1LsojsyM04v6TQNSA4mj8cNePgRvjqcm2WyHO0B9ALL+TB1o1ugdppJD4xpHVwrpQlHFRvSZKI2OrTGw9gSTgwQi8STYRXzc87Xfynci6BnE5UGTEms96czBNFrNKZ/KxV1/cgEJ3eNI3TYsYjUlVEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712051213; c=relaxed/simple;
	bh=5KWH23f+CkrAqT9Dewsp1JwFaTdF1nWGTz25jhY/NPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m2qGrIpelon6oWW01BM8yyDVCIeJXxDyboMtSRrjSb/tXppW2KFMdR5edSB/lvp0+g0hnNuEiAlZcRi1FvbaOPUF6TTFIvqyJWjHVU1mpnbZsdm3eJvSMws55CDJ36Z+fNjw2L6xKCoaC/M0ijQYMZ3JQhotaJlrPh8s4+iEN5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yLhI+zrw; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7e3257325b4so1258436241.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 02:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712051209; x=1712656009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57Qln/YxVwij9SZ8Uk2+ZQTIMAfQPcYDAn1WRCFZujE=;
        b=yLhI+zrwtxI3VaK5lxCY3ULGIPbwb04n6jpUe89ytnk0jfN++DmLywBLy/pvBXYw13
         okgEQSs7ACndlT0jwHhTBAzxGz3qMzAMUkAbnlEXveLVARv35W1CtAX2s6k+GaxheO2+
         IzYkG1yi6omVZhxLPrBNfhmnu7kJtPspsx1WZSOXvWMoVfE/IxN0N3+zWV7eQF3afi2P
         S36FMQh/jxHJRilqE2EvM3S3ZKnix75CHNxSEv1GTO1XihECeL1GKPjEHn+6G5pQLWkI
         F8GkqtLi40FpfYZYnp1wFYDhIyuRuJxFv1NEBAcCH3s9xljJpDbtOPBF6bIJ+roAzy+F
         vl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712051209; x=1712656009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57Qln/YxVwij9SZ8Uk2+ZQTIMAfQPcYDAn1WRCFZujE=;
        b=EQ/Q+MkVkEmwVFLQqzX9FxKurBhLfsCNLz5Skzx1QImYYy8Be7OIBVEy+Ye+Vwp12e
         2COAq8VSjT6XGQETmZ/FqJx6Bt1By4ZTNqVEhD9xqfufiGC10OwU/Ox/Dxerritih0Iw
         gagNICT7H/SaZ/jkOiFaTPTjVDZcLOK67FvoYxkoGn/xRbtZXcgYaeeUZW54V7bup075
         fyoCrppM1jUbH30PMtcV6DoVdHGpvxZbUkenf4y3qMVPncZ3/6AWd3+CnkSc047KLBur
         N9Gc25rj7ic4VpMhaAHbsvYNp9sCwADoUR33oe6KpLyiqpzKs/ede6D7fw5gXZVG98XR
         T/Qw==
X-Forwarded-Encrypted: i=1; AJvYcCX4YYaqPQOSpElC5OLxVL3VzN5zx5SOKhkkgCMzvMwjYymFhQ0fW4K/2gyPWOiN7MolnE0smxvhjY9g08ueELE8pTyVBuSR0fp0NtpO
X-Gm-Message-State: AOJu0Yxjg7ma7mzBf0S7ZKsJU678ZqkSY8WcYHxhRdz0qgdxfVTsMf5c
	Fo/wq9HP260DURU6yjixOPyRnGZpq/N67x02Onc7a4Ua5quAl7dFCw6E3yM+K/vTclo6qmCsu6o
	+GM3ypNAdWESdY6UVSU0RpY7M1A303FWp/E5E
X-Google-Smtp-Source: AGHT+IGQf3QzhQLw9j6incX1IXi9f33qMcGOHachbPjJXSe8XAem2rfd7FCRPcCKfwdQFdRHcq9OG/7bKX/RqoZHYWY=
X-Received: by 2002:a05:6122:c90:b0:4d3:4aad:22d4 with SMTP id
 ba16-20020a0561220c9000b004d34aad22d4mr9329783vkb.0.1712051209441; Tue, 02
 Apr 2024 02:46:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401212303.537355-1-ojeda@kernel.org> <20240401212303.537355-2-ojeda@kernel.org>
In-Reply-To: <20240401212303.537355-2-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 2 Apr 2024 11:46:38 +0200
Message-ID: <CAH5fLgh7jbq8ea4CBJJRPY3gfm6=-_ck2mqArWDG6s+bLfMr7g@mail.gmail.com>
Subject: Re: [PATCH 1/3] rust: sync: implement `Default` for `LockClassKey`
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 11:23=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> In the upcoming Rust 1.78.0, Clippy suggests to implement `Default` even
> when `new()` is `const`, since `Default::default()` may call `const`
> functions even if it is not `const` itself [1]:
>
>     error: you should consider adding a `Default` implementation for `Loc=
kClassKey`
>       --> rust/kernel/sync.rs:31:5
>        |
>     31 | /     pub const fn new() -> Self {
>     32 | |         Self(Opaque::uninit())
>     33 | |     }
>        | |_____^
>
> Thus implement it.
>
> Link: https://github.com/rust-lang/rust-clippy/pull/10903 [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

