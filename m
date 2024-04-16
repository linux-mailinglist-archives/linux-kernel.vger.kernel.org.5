Return-Path: <linux-kernel+bounces-146580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF108A678E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDEB8B21EE3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09238664D;
	Tue, 16 Apr 2024 09:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FbuDV7Ew"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E85885929
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 09:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713261438; cv=none; b=mJZWauJx5fCNPbnOMMMoydZJV4LkBGVGKkGytU7kM5E6uYKsdEUemIHEuZz8Z7awc+uKB7LcYtoPJhclu9P8n9+JAfHojYVSVV+OmcSdPKMrzkos5t1+7AIAdo9GQlp9pz0hLEFtCWeUBTW6Q9Tqm8juzoSwmMrgDZqZ9nMl4Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713261438; c=relaxed/simple;
	bh=NHiCoxCRUNDM+U/esFCAFumYpu6ndbBWZi/5QFnqRTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LCmB0tHUwmA4qXMYp9YiUrxHpddOK1cpm+CIx8d34kX4SSQhERpYNofPhVNgFYPVyhYE4sKsrGEqRjZB/XKyQstL6JfRVdZkz0QeNllx3owIpBpLNcspryswKCIW41qiCX7XyPe5gYUhatEwqo3JbXtTtL/NfuT6u57n1c4WraY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FbuDV7Ew; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-47a404c6decso1113705137.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 02:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713261435; x=1713866235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHiCoxCRUNDM+U/esFCAFumYpu6ndbBWZi/5QFnqRTc=;
        b=FbuDV7EwX+FwQw93U6rtrmn01IWg6/YjrdhIk21GdG9dQ3oDnnsqJktJjTvtaPouHD
         +OZUJcC1c3R7WEqRae5PcN5GZ8QyOHxULY7fePWEyzFnLr7dWVLoJiTNaZNLNPavVH7N
         0bkOWmSpkheevBAWtGk082wEB5u/giX9SSZ7B1VgGT1oe2z6wgNE7nYvsK2vtzaR4dLW
         hGWKpRugoPFuUA03fAfQrecF1rMG45bv6kIVl/PKYk37yfb6OW2buNkaDOBfbuFqghl4
         5cmLhkccCeC1fuJ9XgcCSA+10AUqZ5OZkw4ZjymDQiOOxuwhq5HlhjmRNiPPsQG+YPIu
         jnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713261435; x=1713866235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NHiCoxCRUNDM+U/esFCAFumYpu6ndbBWZi/5QFnqRTc=;
        b=hlGFOBeyyl3UmhSnPnlI45YtLmIj+OuLbrBRZp+wu2V5rkh6VkdEJB3Nk2HiRvDIgI
         wMX8ihlus8q5qlZKRlpPWaxr7tnolxXyHiuWednr7SuCwXV0j4XUtswOkcnaUN4PEkO+
         dry0njyDwU5zMexCItRmroL/CJJ4vTvcQjOREOgmvFh+4R+nFZSxxyfcaCIyP+bouBll
         ZuQD2xhS9DaqzTbRLHzVY26vo7v9MBNoxe/a9W4I6T5NhR0U9fDAezFKIm2faWiaU88C
         UZARj+DhqyBkxZUjGB0kHyKdcuHs0SstfMGhOtYCZ5cdCIngeiWX/jKgDNlAxKhCWGlL
         SfTw==
X-Forwarded-Encrypted: i=1; AJvYcCXkvlRGIZu6Ro7Xc/H0z+wY7CLHiBkkjtnmx0xCSMmyQP+VLQyCgKcT8qgiwkcb8FhMJi1KAoPlqq8tuiulGx3iF6n+ezVplxIxkfe5
X-Gm-Message-State: AOJu0Yy93sydMr01Wz59EOvLW46B5hc03SeBN4JrBy2yUkvpt/uW2Yr1
	sxNsF7V9DDKAHaxyQ7YKpKabK+qtS7Y3ATeFFiwEvrqhxbwo19cspm0RGxzUzKon6ZfemyyXHgx
	Xtgy+dshqR3s41ZUqHa6lRTPsa1nycBizIks6
X-Google-Smtp-Source: AGHT+IEPsW05phYUIrlx5Uy8pAv8kP3cZvEoCRY/OH7h5cbl24CtY5s86HrRZB2SYuf+ooWwSmXNWVN1t06Z6diHe0c=
X-Received: by 2002:a05:6102:dcd:b0:47a:296c:def with SMTP id
 e13-20020a0561020dcd00b0047a296c0defmr11930644vst.29.1713261435254; Tue, 16
 Apr 2024 02:57:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415-alice-mm-v5-0-6f55e4d8ef51@google.com>
 <20240415-alice-mm-v5-2-6f55e4d8ef51@google.com> <202404151605.6EFC791E@keescook>
In-Reply-To: <202404151605.6EFC791E@keescook>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 16 Apr 2024 11:57:03 +0200
Message-ID: <CAH5fLgg1UiU0b-1Wewz9Wm_V_G44G+TUb4L1beQF7mkAcCXKfg@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] uaccess: always export _copy_[from|to]_user with CONFIG_RUST
To: Kees Cook <keescook@chromium.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 1:05=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Mon, Apr 15, 2024 at 07:13:54AM +0000, Alice Ryhl wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > Rust code needs to be able to access _copy_from_user and _copy_to_user
> > so that it can skip the check_copy_size check in cases where the length
> > is known at compile-time, mirroring the logic for when C code will skip
> > check_copy_size. To do this, we ensure that exported versions of these
> > methods are available when CONFIG_RUST is enabled.
> >
> > Alice has verified that this patch passes the CONFIG_TEST_USER_COPY tes=
t
> > on x86 using the Android cuttlefish emulator.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Thanks for the updates and the comment on testing. :)
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks for taking a look :)

Alice

