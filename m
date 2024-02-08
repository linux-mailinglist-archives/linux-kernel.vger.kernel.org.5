Return-Path: <linux-kernel+bounces-58232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A40C84E336
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6712E1C234F7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A19B762CE;
	Thu,  8 Feb 2024 14:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1XKhDKP3"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707E1535AC
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 14:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707402689; cv=none; b=Xxl98SZzJcA3bluHWLqgI3qMKAnlykZEVJZpohLrE0lBIFHkjWlBT+TPWA/Zo69wyX7rA/rJvlwYdehTG9CvpztDWZ6yWkOtoXiiuKycaMAY1bTz81ASRSr2NTpBXmQihjJ7t8QbobOqDgxpt0NFLbkZRlxN6jdxw01mlrLMDyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707402689; c=relaxed/simple;
	bh=2X7cnvNc0POJtDhx64/0CYoKnC/Qcp2jn+JvTMeuE+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HdccdfTdWMA63zXwC1xVbriynru6IMkHcI+qISlV5MqM8LAQ7SYGoG0yxP0mWfgeIpWdsMT31PeDewl+Paud2BW8FT7FZQhSjeMUhgvxwIaKt08iCJDT0rgq+AVimPDOR4W2UKTvTLeZKR45yopstVEmmnKmyMrDeAc9HW8X3dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1XKhDKP3; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4c01ca67504so703795e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 06:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707402687; x=1708007487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obCGu9I28pwHjWZdV5bvQfg8AiUFYhtKduRS4S8NEto=;
        b=1XKhDKP3IDjwHsUUKmSoBX+cNQVWjyaZ0P8cQW6tTqteF6VGhvugcLwVNZPszUBN0k
         YuNQ99tH6NmPqjg2u3aMgqR2XHeaPKNhCG9ZGd+NHWFSChDY9I4x1J5EF1ihTlwWPUoo
         xwRW/yNPHzHcr4g/ImgLbuc5H0fkbI+iwSZfwVESRks2/agT/wKEgK4y++IC3fgUHrAd
         /uWrHfDpa45P5s09c4Vxc5dWtJplo+cOa1lefH6e4Ib9s+8joxY8VrbTRw+cI4nkLc3U
         5FdreHwwL7cTy8ZJnAUXVcUPkV5chnio1UacUHH+Y3PKMppXdGj3TiAhl1LicjZK41Ex
         eIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707402687; x=1708007487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=obCGu9I28pwHjWZdV5bvQfg8AiUFYhtKduRS4S8NEto=;
        b=ksgpLto9OImbhyBcOpUf4rjzPuw6UE2bTxGwXOk9sXavAi/K+ciF2JNsqKhAaIiCFS
         Ll/nK93T4+md9G4r6oXN2daEQue6+X9/WURYB6lC5kUOrVYoD7CMUQE786lhOTqQhzKE
         iq5RKm0GiSJBwLchn8YDGHjkDvI7kJpDMYQ7XxMbp+w8FCxYlkCpprTnzIJWuvE8x1NT
         Mjea07ZXUGl1hpjc06QSdp88lhVjYBygeqlIjo3ixM7DTVJASR6+slBNOhDkqkR36tvB
         +Asq4nJmWy9Qs/UuBGK6DDJXVET/DYA6XF0fziFeNpdb79DSqgoHE423WbWxQzKQ5SJt
         tkLw==
X-Forwarded-Encrypted: i=1; AJvYcCXuAwZNXioXcHPuuBjdpKZcOUy9Sob5j55UN364I5RkWqKAKZ5TLCkG90M3rlZkLot5xLE09MV5FzZsFQN9TQPELmuqPgn1ylPS6Atr
X-Gm-Message-State: AOJu0Yw1gaCkY1VZ4niMnMrZEP0l9PmOv36Zkz9it+yAiN9zYagI+IBe
	dUQLGwKIb94JmebKMsEQ12P68Yve0yTTXnPls/YEK/J/mrtufop1Qzrx5cIbccC+YCKWAww4Cg/
	TDtMb3P4W8p4dEypnSm4lJnwkkU/lB0P/WHHw
X-Google-Smtp-Source: AGHT+IEiaU6h+oxYlD9/1sBXujjboOd0SZrqFT/3Rjnnwx2CqO3nnCYumbqDOO5aQu5ReiyBHy9O08M4VYg6HUvjwQA=
X-Received: by 2002:a05:6122:c97:b0:4c0:237a:3842 with SMTP id
 ba23-20020a0561220c9700b004c0237a3842mr6366031vkb.10.1707402687081; Thu, 08
 Feb 2024 06:31:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205091842.2858516-1-aliceryhl@google.com> <CALNs47t63qAU2OpokvN6KykT0_NKpDLTBQGhLm-+zsvR1pcUAQ@mail.gmail.com>
In-Reply-To: <CALNs47t63qAU2OpokvN6KykT0_NKpDLTBQGhLm-+zsvR1pcUAQ@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 8 Feb 2024 15:31:15 +0100
Message-ID: <CAH5fLgg07Fx0FrtK2nsEj=DR96WuhqVrWyJ-bBhXqFr9Caz6FA@mail.gmail.com>
Subject: Re: [PATCH] rust: stop using ptr_metadata feature
To: Trevor Gross <tmgross@umich.edu>
Cc: Miguel Ojeda <ojeda@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 10:02=E2=80=AFPM Trevor Gross <tmgross@umich.edu> wr=
ote:
>
> On Mon, Feb 5, 2024 at 3:19=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
> >          // SAFETY: The metadata of `T` and `ArcInner<T>` is the same b=
ecause `ArcInner` is a struct
> >          // with `T` as its last field.
> >          //
> >          // This is documented at:
> >          // <https://doc.rust-lang.org/std/ptr/trait.Pointee.html>.
>
> The comment should be reworded, no more metadata and no unsafe block
> so it doesn't have to be SAFETY.

How about this?

// Pointer casts leave the metadata unchanged. This is okay because
the metadata of `T` and
// `ArcInner<T>` is the same since `ArcInner` is a struct with `T` as
its last field.
//
// This is documented at:
// <https://doc.rust-lang.org/std/ptr/trait.Pointee.html>.

> > -        let metadata: <ArcInner<T> as Pointee>::Metadata =3D
> > -            unsafe { core::mem::transmute_copy(&metadata) };
> > +        let ptr =3D ptr as *mut ArcInner<T>;
>
> Nit: this could be `.cast::<ArcInner<T>>().cast_mut()` to make the
> intentional mutability change clear.

The `.cast()` method can't be used here. It only works for sized types.

Alice

