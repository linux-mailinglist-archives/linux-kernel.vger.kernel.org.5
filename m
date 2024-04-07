Return-Path: <linux-kernel+bounces-134635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C87E089B3F4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 22:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32A941F21439
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 20:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABDA4086F;
	Sun,  7 Apr 2024 20:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ws3dNtOv"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A65F405FF;
	Sun,  7 Apr 2024 20:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712520945; cv=none; b=VpFG3HyzkGxvZXdZC47/QZGtmfMHfVkx2Xwd//hENhfYeU0RLaC15iZ/7K9egX3E0rzDDBBKkRmswJqve1PMlTVs1b1WSC8H05W0R75pT/crhB+sBrN5c28D79y62XFqhJ0ZfM1HvEuiQJ5ExOtnjkm+/8h4HM61NuLXhgV5rkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712520945; c=relaxed/simple;
	bh=I5ZKo+3mZRhbiLdn+T4f7m57VZu1rJ059WV8i4DH3uI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ASaIZsk5TM8tKt323HHyCa5dF+MJtllpjewWXA1yKpkjUngF3PkIrfhdSMT6U2iJU/X5x5Wi5qEfTC94nG//FJDN+K97tWHwdQTJdXGp3fPR9mH1bLak++Ha+vTrl4HAe/SArDaSloQUnlaILxme8EkQzGoMuQv9l5z+Oq6uR/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ws3dNtOv; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-29b7164eef6so3084156a91.2;
        Sun, 07 Apr 2024 13:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712520943; x=1713125743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4MVq0Ml1b3or0ua0UTIbRspNGgQTqV2giV4okTyNok=;
        b=Ws3dNtOvqAlry0b95aGkt3BknbOrOLcxTKGCRdibtw6j4FKdumhQUH5DfAPcP1h40G
         dp3NqbwL13VSDLHLBOqPt0FERc4tpK67lzK+jDnmpS+s+ZcOPsIudQKRBa5gJgOsCSnQ
         MxSyAurzH+OXLf+ziFotV+xtPIaqnZZI70hig/BYM8cx9LOb4wIXF9dARPfSvfBVKYc6
         9M0VaHx8CSkswQqBYiJ3VLrg/F4ojQozl/EV3I//iX1KQsDf9hS3VFOM2nDtAgxxm8fD
         xsKb1zzkoVtFC8KAYD+Gc9HrBy/IUAiD+bcz7SjNjD5bl7QeR25EVOsKUxlqXS24WtG2
         n6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712520943; x=1713125743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G4MVq0Ml1b3or0ua0UTIbRspNGgQTqV2giV4okTyNok=;
        b=HmkxjkvJtjQQaiXu/dtDzWBCSc/oerL+Ok6gHjf0d3sU4q0McwL6Xz2Alj1mppeIom
         MIlWcuVtSq53nZxo5boLTGzm6gEnVvL4X/FGMZ6c3odJD+KiWVXXC954RiezPGpZublu
         8oVTEAogxDCPnslxpKLYBA8OREzgrKIy3N/PpeN8cKMXKWmQbS4r6rwbFO6yoh7XMebY
         AHhLy0UBzrRCYU3wW8nQGrKL/iKeYq491oGoP7onc+NzbPAZfBkE/S7dURFmeXkp4vS0
         LFag9z6QyLdTZn7piQKRB7UFGOqtlwdOjeuxX4ZrMqtufdSco+ISM9t46zw1tiszYgQG
         J3bA==
X-Forwarded-Encrypted: i=1; AJvYcCVqiVh9ms0T8GrlxsGxYEF0s/n2GVHe3DLVfTW3RLKMEp1nu1JgYNwU1EvVFMwgUU1wuwXOuaEPA9dIdMyu+Oyp6zWl1C7wwZlAmsD4CV10EtyqZo/Brh0r36LgQJ+IFq4G3dE2j3WpOnzZLKk=
X-Gm-Message-State: AOJu0Yx1SR9eJ3mmXIXpfcCBq/PKpf58Rd/FIoSWvpdgC8cYc6WN36kS
	79XRYaKytzCcma0sZKm9Pf3oOn80wuamYsm2BVVXjJxvSCJVs6O0BSKrXbfA9Fl3UJ6UvtrRocx
	D+xUsKDA94SwFIUuAza+AsxjuN6o=
X-Google-Smtp-Source: AGHT+IGFnwzxcGlpNltHX6ySVFvgxFS4P1qHLfiIuJCj5kuiYAueNQ1y21322FatkqziP4Nen/68trmWEXYR2YLEbAY=
X-Received: by 2002:a17:90b:3ecb:b0:29f:7672:7fee with SMTP id
 rm11-20020a17090b3ecb00b0029f76727feemr6403942pjb.31.1712520943403; Sun, 07
 Apr 2024 13:15:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240309155243.482334-1-benno.lossin@proton.me>
In-Reply-To: <20240309155243.482334-1-benno.lossin@proton.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 7 Apr 2024 22:15:00 +0200
Message-ID: <CANiq72=6=BCCoeb9_bzXT+PKiS97sxSWpOu9jh9T1yD8V4S+9w@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] rust: macros: add `decl_generics` to `parse_generics()`
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
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

Applied series to `rust-next` -- thanks everyone!

Cheers,
Miguel

