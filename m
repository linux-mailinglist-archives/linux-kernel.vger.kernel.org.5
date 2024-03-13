Return-Path: <linux-kernel+bounces-102402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B268C87B197
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F411F26A04
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478C85F850;
	Wed, 13 Mar 2024 19:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="LYsMbAFD"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1731E5F55D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 19:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710357012; cv=none; b=hJQ1qAz9v8glxeNzoJiJeAlg2ii2vvNcoVp98iVlE8hFtK0S+6HxIh8u5ejr6UAGDq6u6JvJWhvimPzgHE2Q2Z9mV8v4Acc8KeQ6AEND+BVBkZKLHYVIxK1SP+pN8fjqHMvCWYACPlCqo/STT4Nm4i0OQ1fsNypOSxprBKkHM38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710357012; c=relaxed/simple;
	bh=/e3ATDPA/qgTUOtidYV6rPYvJSOmSFfRGP3WmLW3+Dw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SugsnZahupEZFQhkdxU2bRYm3GZeHvy6XDxzPromhJoV6CZYlm7KowEGgDJ8vf+IDZ1wvigpMiwDiGR02fyVAPkOqXigh0GqdEArfxsirE17gOmvXyqVIgkRPjzqMK6GnDBJ9VAefNDavisdWsSAiMfiGM3vinFq4+XgMQ2GzyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=LYsMbAFD; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-609f1b77728so2228017b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 12:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1710357009; x=1710961809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/e3ATDPA/qgTUOtidYV6rPYvJSOmSFfRGP3WmLW3+Dw=;
        b=LYsMbAFDYCXD3MckZOTcH77u6prmiAFYWj5M/UWnnbUCJPyu1HFKN2EBw/wgo70z5X
         lfoUvGTOq0rkqXm0RG0cx8tNzNYpZE0UqX06UN0NyYJ5u3BUxMtFvaAhhBJW59gyaVIn
         cq7U8n2L3f87gYKch4sl0Qoe5sm6j3A/z+PxVaZ2OC2MLgUwRWCRkI3GS9uOcG+6aRdS
         f9MLXL7Wr1ukbPIICewbagdxRHz7ZlFE8tAB5/5c7gAdkk2eVSAMz+LahFzvYLB3WSBX
         cTwfAO+C5Im7qxOL0COA7QnDFGN7cbEOZ0ct65qn+h+GHuBz4aH05STW1cvgCChB/ZeU
         spfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710357009; x=1710961809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/e3ATDPA/qgTUOtidYV6rPYvJSOmSFfRGP3WmLW3+Dw=;
        b=DScI0MQfcMUg+soG3/5Z7WU/wNh86adJTDYK9MVj32iCyXH0zXvm7fBYMyNrm/B0mu
         x0X08hDpv1mWHQ1nxMdgDLp7UwywCNraHwAjFUvOTQKpFboE+2tO5lG0MqDjA70z2v3x
         62b/9oRpuhBlIZ8Ko96Va0fiBKEBxRfZ+bx6k1eTj/PR5W959qm+1PnrKfwbqlKmFlML
         YBFJGTTHTFWcYXTutcivblYNi0QGZ88gSbAhqJVUKspkVfx6hj7TITBOCw1Pb8zzC2eP
         HcPUaPyMN93Sb/t/DoFRd/EVHyIZLtRrebxAByc3xr8pmsl3Srp3l4cX1BqHbPZzajYI
         o4Fg==
X-Forwarded-Encrypted: i=1; AJvYcCWrbFxuG+S7ahQKzmjjL/0ldSnruUx5nkHZdYT5Jrgu9mx77aLVAMHGHOAfWy53R1Hn3Vx02UmITEb0Q/ET+yXB5OjQk5cNxCTSevdU
X-Gm-Message-State: AOJu0YwstldmC6E+Zs/jzZCZJVtG3I0gUGURJiRw82rDcEYwEvvIoMrC
	te4ATYSN2kpB9EuF70zEp97HF0NS81l8jAaW1Ce8kwSMghf6w0ZbeiRjuWENdDMmRRn3HgawG53
	tJNMFqfv0vefjvwOHpfSKZ/sDAeH6yXQY5rCp4w==
X-Google-Smtp-Source: AGHT+IHvOz3vvevhU2+NsarhVCjZjHX3GiH9Xw/oej3y1FW1AAmW1J//l0DcmlTRyaKEnQOT8zoUg7tohMa0pFI5kpg=
X-Received: by 2002:a5b:88d:0:b0:dcc:56b6:6606 with SMTP id
 e13-20020a5b088d000000b00dcc56b66606mr3166914ybq.40.1710357009091; Wed, 13
 Mar 2024 12:10:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226-module-as-ptr-v1-1-83bc89213113@google.com>
In-Reply-To: <20240226-module-as-ptr-v1-1-83bc89213113@google.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Wed, 13 Mar 2024 15:09:57 -0400
Message-ID: <CALNs47tj0=k7UeoKp6Myfh8tiLnJwxm3cHa4Qj2cY7sihOo9sQ@mail.gmail.com>
Subject: Re: [PATCH] rust: add `Module::as_ptr`
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 5:13=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> This allows you to get a raw pointer to THIS_MODULE for use in unsafe
> code. The Rust Binder RFC uses it when defining fops for the binderfs
> component [1].
>
> This doesn't really need to go in now - it could go in together with
> Rust Binder like how it is sent in the Rust Binder RFC. However, the
> upcoming 1.77.0 release of the Rust compiler introduces a new warning,
> and applying this patch now will silence that warning. That allows us to
> avoid adding the #[allow(dead_code)] annotation seen in [2].
>
> Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-2-08=
ba9197f637@google.com/ [1]
> Link: https://lore.kernel.org/all/20240217002717.57507-1-ojeda@kernel.org=
/ [2]
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---

Reviewed-by: Trevor Gross <tmgross@umich.edu>

This exposes a `bindings` type to the user which we don't really do in
many other places, but it makes sense here of course.

