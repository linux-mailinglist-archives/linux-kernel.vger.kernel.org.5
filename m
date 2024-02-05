Return-Path: <linux-kernel+bounces-53935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC44B84A836
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A770E28A501
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7AD13B2AF;
	Mon,  5 Feb 2024 21:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="hhiQw/YB"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017F313B2A4
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 21:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707166983; cv=none; b=rOLi8IWUQxr6xEQ9iLSVypsrt+WRlnJ8Pu/U1iu4dn+7i1RO9xoWd2/twElLxPZL5VI/8Ct4Zbb8q6YRswIf+PxxvA8QpB55vknhihEcD+yWsqjAjRnVIT6I2AiaI+pi7KpwkPOH7ceE7Ifcsaw7Qvp6wUJE/FQyN3zFhrjT818=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707166983; c=relaxed/simple;
	bh=NWd67aeK8pIzgOiPR/gbAVXtUTBNAp22BDVP5Pv9XhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CKbZrejtFel4YG9nLRc3rn//Fkuf8pYK8ZlLSsyiD6VOWdgP/CdkoXhlnShGBKusWpGO1WNwUvF1hGVwccZuS4Fh/DG7NZdP4FFQi9PZg+d+h7n2ZWEXQi3RqIHZs0ftv50Q8QvQCVZ0RGeRxbL07u4tUDFsPliCVs13vCOCFKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=hhiQw/YB; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6043d9726adso16068707b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 13:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1707166978; x=1707771778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wS97w73P08k5rOomOJNiseIepah68q0tAYPUB/FIuvw=;
        b=hhiQw/YBLGWAEhdwSBY9yiMI/lj/qB7rKj/i0MmmYiX8odPqXDJGwbYGFmv8uQsOqE
         2hgX4r9ue3u+kCTARv69xlxhrOwbCpbaFsoppo3ZUAVPRMU9xnFjvWlmRyNAnM1VikC1
         WzRS3sPiFgChoxMsi9dh8qflyikIFgnxEsO0V9OlJDUH2MjX+1aGKw+Qx8SjxDQAfV3Q
         tGf8p55D5HR7YGBSAqGDirxfmAoJk0234AO2VROPOGZB9EFDjthSJumvv+RpJ8neE7Mc
         fVyocuixD60kWlm2fb1Gw+YGzIRDF44GjdkgqKLKBBBPQif+fr112K/zwqIvkXibIzPH
         TOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707166978; x=1707771778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wS97w73P08k5rOomOJNiseIepah68q0tAYPUB/FIuvw=;
        b=qG3/6jMdAlpgi8LwsEHplMGJ1M5+bzhI5n6hwYZupFDAqNuPMj72Is8qSZyLyqzJxo
         i4j0QGeuFuDnXv/VFiDKPydPScKvqa5MXGRgd7ZZumwCl0ErsFFKJLkdcXPE4Ba/XWEF
         CKErvadOzyEGFBOgv4YsYImHU6o0prvIScEkxC1gbZPR17CJ31gesXO5FOWA5XJGkA81
         6aBLvuKn6Dk/32nk2nZMHt/Y5Nydh4WMzL7l0tWYFCgPj+pTp4T7v93aMxRp7fRAK6a5
         gU2/uVCe6tfUXRdo5BBXOCpyMrsMGnAIFIQYUjD2RrzCeL7cJSaNSVOBt+7RR1Ae5MZk
         EckA==
X-Gm-Message-State: AOJu0Yxhi1CHMe09z9cApsbPybXeKa4FJSbaRds+fmpNFfSQgKdKAQB8
	6TEwPlwlkJ+3lI06FO7AECwzv7SiNbaN3Mu9HTkvV2zh9AqTL3YrRJ/UiSJoWaelEtRUGhUFvMy
	JkI1vM7Ou5zHrESCDJ0udK6zIiNkd4diYZIj0Iw==
X-Google-Smtp-Source: AGHT+IGW9OpOa7ciycFOkv4eynfDnvD/dphW+DZHJBvn7echDosR8g9F5wKp1fL1kbbs+zaTUCNUsGTPmP3rqTI6j3A=
X-Received: by 2002:a81:ae49:0:b0:604:1d65:b66b with SMTP id
 g9-20020a81ae49000000b006041d65b66bmr5135715ywk.9.1707166977896; Mon, 05 Feb
 2024 13:02:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205091842.2858516-1-aliceryhl@google.com>
In-Reply-To: <20240205091842.2858516-1-aliceryhl@google.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Mon, 5 Feb 2024 15:02:46 -0600
Message-ID: <CALNs47t63qAU2OpokvN6KykT0_NKpDLTBQGhLm-+zsvR1pcUAQ@mail.gmail.com>
Subject: Re: [PATCH] rust: stop using ptr_metadata feature
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 3:19=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> The `byte_sub` method was stabilized in Rust 1.75.0. By using that
> method, we no longer need the unstable `ptr_metadata` feature for
> implementing `Arc::from_raw`.
>
> This brings us one step closer towards not using unstable compiler
> features.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> This patch is based on rust-next because it depends on the patch [1]
> that upgrades to Rust 1.75.0.
>
> [1]: https://lore.kernel.org/all/20231224172128.271447-1-ojeda@kernel.org=
/
>
>  rust/kernel/lib.rs      |  1 -
>  rust/kernel/sync/arc.rs | 10 ++++------
>  2 files changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> [...]
> @@ -239,18 +239,16 @@ pub unsafe fn from_raw(ptr: *const T) -> Self {
>          // binary, so its layout is not so large that it can trigger ari=
thmetic overflow.
>          let val_offset =3D unsafe { refcount_layout.extend(val_layout).u=
nwrap_unchecked().1 };
>
> -        let metadata: <T as Pointee>::Metadata =3D core::ptr::metadata(p=
tr);
>          // SAFETY: The metadata of `T` and `ArcInner<T>` is the same bec=
ause `ArcInner` is a struct
>          // with `T` as its last field.
>          //
>          // This is documented at:
>          // <https://doc.rust-lang.org/std/ptr/trait.Pointee.html>.

The comment should be reworded, no more metadata and no unsafe block
so it doesn't have to be SAFETY.

> -        let metadata: <ArcInner<T> as Pointee>::Metadata =3D
> -            unsafe { core::mem::transmute_copy(&metadata) };
> +        let ptr =3D ptr as *mut ArcInner<T>;

Nit: this could be `.cast::<ArcInner<T>>().cast_mut()` to make the
intentional mutability change clear.

>          // SAFETY: The pointer is in-bounds of an allocation both before=
 and after offsetting the
>          // pointer, since it originates from a previous call to `Arc::in=
to_raw` and is still valid.
> -        let ptr =3D unsafe { (ptr as *mut u8).sub(val_offset) as *mut ()=
 };
> -        let ptr =3D core::ptr::from_raw_parts_mut(ptr, metadata);
> +        let ptr =3D unsafe { ptr.byte_sub(val_offset) };
>
>          // SAFETY: By the safety requirements we know that `ptr` came fr=
om `Arc::into_raw`, so the
>          // reference count held then will be owned by the new `Arc` obje=
ct.
>
> base-commit: f090f0d0eea9666a96702b29bc9a64cbabee85c5
> --
> 2.43.0.594.gd9cf4e227d-goog
>
>

Worth noting that the same change has been in upstream for a while,
since https://github.com/rust-lang/rust/pull/99113.

With the above changed or otherwise clarified:

Reviewed-by: Trevor Gross <tmgross@umich.edu>

