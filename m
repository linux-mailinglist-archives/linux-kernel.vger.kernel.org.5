Return-Path: <linux-kernel+bounces-98578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FD7877C43
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00F32B2098E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5FE1428F;
	Mon, 11 Mar 2024 09:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V2EcnBBh"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D52713FFA
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148003; cv=none; b=cC/Crp2ejRHUxVygYSynt+0PN1N0CdJymrOujoBj+5wWkzh6CGO+mO3YKzgBJr0nPUFlHGbtuuM3zBZBEgadrTPn2FeYagnY0wLVt4vka1Lr6dukfSQ0e71t1+q4N0ydtsz2EtMm+Vwzwewt+3xvPe6+Q/83AWMhMm+mb+L5su4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148003; c=relaxed/simple;
	bh=oDq0wjzK9UeHir6L4tpyPUO+UyOU+IT9339oWwDT8j8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uv6vcR/ztY3zhbCimoiecrEPa/I+wH5pn/yyX+7R6HhxvtJ8DN5ObEhLRu+AIM7EqtNYfkt4V1U28xVgLUt3RDNOLl+n7qhmBKY8NLx0HNS/kOWr9R589o24PLKN9HGgFMhjRhV1n8FIpRrxbQLHwzEJp47E4aj/Mr8r1hKo2kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V2EcnBBh; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4d3424f38b5so440415e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 02:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710148000; x=1710752800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xT2VVHcsQ51kBeBw51R+w6B1SbBBCUAwVNKiybCExI4=;
        b=V2EcnBBhpVN+iKWEA/nlo2T+hisDQoIvFqLR9paNLEoDLC4GaKJjWORhZ/v/aFGt7J
         e5jM8ZYdZqXahvO43a2B5lyFX4+0J3DsuzTA+w8abdlwUaeyIOWLKdwkibL2pnfScAAc
         7YD/N1ZgUP6eJ045yd1KrLSzXN41bfEhBnkD3oybLqMEDIFGvouERu6/MzBIfJWMAoKE
         L//TbjXd7iCT5WTCrQmYZ76H+HSObSh5f7eIhYLa6ldcJS4Sz/RHWF9yU6u8u48zk7Mf
         aHtp1Jjz7L5yRKSREvudflypr4RZTSf57YHi8hk6Y5u8RfaY2gdSvfVRRHM1ovm0VmBl
         gNCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710148000; x=1710752800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xT2VVHcsQ51kBeBw51R+w6B1SbBBCUAwVNKiybCExI4=;
        b=EsC1kBrneBocfdHF001vyW19y0SyDhzw25Oi5MkjW0oyEUZy//ymx/rustnBrV1AQ3
         LQ5uunW8FKfD4K9djt+Xvw0yx2iXuLHnxKGxoMGZG+9H61MXV2iWGF4CokKjCoxyB+AF
         P0h8IwTJOonH0bYEec83bsCVLt6BxCoyfIUEpETOmAd9TnR48klQFfw0aq30gDIa5miB
         ZeGdl4tlM2gWdal0nNrEiomNdmAmLdxbwVjJg+DxZVMxYA8tyJNBYcJGrat6sbf6/93X
         woa+c/LFDH7dqU5ijSgGT/ejQ2ZdCvG6pCThTvsfbTMlfnhl1e5gTAr/0RuO4YuNG2Xc
         cyLw==
X-Forwarded-Encrypted: i=1; AJvYcCX3an+WjIb3Qdmw+9w75K6bt1ZQ/Fp2IlsrCwMoe+OxGy5PMyr8qndw3hDl6gDd4gaMyFhuxGFkxA1P7/fGtmX8z7FfvS+C0EuHvJeQ
X-Gm-Message-State: AOJu0YzsKWg5OxenWDnBM2HsmlAAwBL+QbI37WNfVWpUt2M/B73gC0Lx
	llme/074NNbkSr1UP6yiKRKYiagVtEDh/8/fwetCrK6BpLDfzuagbQx59DLA3D8OGOkVfo5Llbl
	uQwpDDAiQVtWtQXme8wMCcELeD0x/qYTlvLam
X-Google-Smtp-Source: AGHT+IEnfKZc/O50nVX9EHX3V0Vrm6kYtuWq+ssZzv4pWsg4ZjS5WovMpamitXQrq2ePT4+vm4fwQKkP9M/TBq92QD8=
X-Received: by 2002:a05:6122:388d:b0:4c0:2abe:d585 with SMTP id
 eo13-20020a056122388d00b004c02abed585mr2691272vkb.6.1710148000298; Mon, 11
 Mar 2024 02:06:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240309155243.482334-1-benno.lossin@proton.me>
In-Reply-To: <20240309155243.482334-1-benno.lossin@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 11 Mar 2024 10:06:29 +0100
Message-ID: <CAH5fLgiEsYF6AanS4mT_8sPHL6YM6SAsdg1LNMB-FE9yWvSh8w@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] rust: macros: add `decl_generics` to `parse_generics()`
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 9, 2024 at 4:53=E2=80=AFPM Benno Lossin <benno.lossin@proton.me=
> wrote:
>
> The generic parameters on a type definition can specify default values.
> Currently `parse_generics()` cannot handle this though. For example when
> parsing the following generics:
>
>     <T: Clone, const N: usize =3D 0>
>
> The `impl_generics` will be set to `T: Clone, const N: usize =3D 0` and
> `ty_generics` will be set to `T, N`. Now using the `impl_generics` on an
> impl block:
>
>     impl<$($impl_generics)*> Foo {}
>
> will result in invalid Rust code, because default values are only
> available on type definitions.
>
> Therefore add parsing support for generic parameter default values using
> a new kind of generics called `decl_generics` and change the old
> behavior of `impl_generics` to not contain the generic parameter default
> values.
>
> Now `Generics` has three fields:
> - `impl_generics`: the generics with bounds
>   (e.g. `T: Clone, const N: usize`)
> - `decl_generics`: the generics with bounds and default values
>   (e.g. `T: Clone, const N: usize =3D 0`)
> - `ty_generics`:  contains the generics without bounds and without
>   default values (e.g. `T, N`)
>
> `impl_generics` is designed to be used on `impl<$impl_generics>`,
> `decl_generics` for the type definition, so `struct Foo<$decl_generics>`
> and `ty_generics` whenever you use the type, so `Foo<$ty_generics>`.
>
> Here is an example that uses all three different types of generics:
>
>     let (Generics { decl_generics, impl_generics, ty_generics }, rest) =
=3D parse_generics(input);
>     quote! {
>         struct Foo<$($decl_generics)*> {
>             // ...
>         }
>
>         impl<$impl_generics> Foo<$ty_generics> {
>             fn foo() {
>                 // ...
>             }
>         }
>     }
>
> The next commit contains a fix to the `#[pin_data]` macro making it
> compatible with generic parameter default values by relying on this new
> behavior.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

