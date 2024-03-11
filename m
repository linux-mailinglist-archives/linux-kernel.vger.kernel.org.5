Return-Path: <linux-kernel+bounces-98574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9429F877C38
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1852EB207CF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6487017996;
	Mon, 11 Mar 2024 09:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QOxwuDhu"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D91171D8
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710147848; cv=none; b=dQ2qTpxXCA2jlnt9vHJm0No2Ntpf1ip0/uwcoBYZWrzH1vynYnX10UprHwXeAmAU7Qsyx0CJ1Y2rf9Y1tcy5YqxPT5I1J+8yd7/3R2VmkSnwf7nSqe0npchR8TTTzaq2U9pcLdM9m0p+HtTXbXBkjJ7i/h7htrS4bRiuIUwtpWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710147848; c=relaxed/simple;
	bh=YZIvk45Qdwe+WgoeWiUCSU3e5i9+mC93jSqXbug2wgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jhGnX4qpEbbo+27DBZrwXER2TM+7P+9hhPBXMEvQWn+xmC/0YrvxEYN6zrYN90L+lE3fmvGTk30xS/WBE0fUmhlibhotXV6qcA0aVfS1mU6ELw0sfA20fc07PLyD09RuWki2hRX264Hc6ss2WQNLh6Sl2LExP6OlRCXalgAf4WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QOxwuDhu; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7ce4512d308so2444933241.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 02:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710147846; x=1710752646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6BaIj82ne96lSVNCUMkWu0rka7gtZJhD+DKobLwFLE=;
        b=QOxwuDhucLDB8NXZdhw0Zh9iLejJHSoZGB98Zz7gAr/FsCaE5zCPCGchhebiazyx4l
         HQ+AGSSUVHw2igVW8Pj+P4ZbM4GTVyvMgd16cmEmlpLvIioTSJ003CrntGkcOWdGMaCo
         gJ7Tt45wulVxHrvF4PT92F41kiz9YRKu1/dVWPImSfJdwZ9YVrf+aJ17m4Kc99SQsAJZ
         ZS/f28mPg5uxG4igMYVfKtaou0v6FjPvf6jEimnZV2mZXLAGs6RrzVx+H+QL8OW2Drne
         QRxjC9QRDZp76KGA6F05MQQYoN69YMEHfyLBCB6mQiYPyBthCGQBMIRSeWz7n+dBu5hO
         seig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710147846; x=1710752646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B6BaIj82ne96lSVNCUMkWu0rka7gtZJhD+DKobLwFLE=;
        b=VShxuTMZCJo9S+S8ZCep3thG6JJKPj9Dn6zE+cwpJ4GzX99TzSPMEqEEnAtdtOZVba
         J5YAqA7qSjwy/wfeKg3A/KspFjY8tFkNTotIP0N1RwRpwmi81fjw7WuAed1wOmDnIXnR
         WIEI0yIxgbAdrEc+OXNP2CnsPeiOypOdLRAL1H+jmpYSccoTMqO9HG/1Zkkqk49Hg6Lg
         WG5GWYCjBOTVVUHuq99CM2P83AF052Lvk+izRwSG4Ev9swt06jt3nN/BeHrfIG8HkDA8
         Ik36FJMvUZj5EDiAVcUJb20OXjWtXLN8W+XE0uzhkc6UvtkwkQ2LnhhNIO3hGhzMNDrt
         t2cw==
X-Forwarded-Encrypted: i=1; AJvYcCWgZC7VZm3q8SwumvZP7Tp7F3yRG5OIYWhxHb5Qp4HxluzeM4I2N5Y/+HFqDjAnGXycivhmYu3n2hcgi1aKXvvnNYB9y4E+3YxC1eqW
X-Gm-Message-State: AOJu0Yxfsvc5NJNe2tF0L8IX8nk5vnFlb9/QnA6ldTAUwbDFpCSxftHB
	COmPxQov/SYWG2dMoH0/zxiLY9TMqozBuOpYmqn+nj8ySkzZkGe5kZgbH4j6VfdR2vJFNBB3lA7
	ArXM599z1ymI0AvaSa/Z+yJJOY10SPm1JkdTy
X-Google-Smtp-Source: AGHT+IGDyXcLeuaPrjaudYCASjkgYgdbUsiIhZv89u6VhpK9strLPA7X0y5X6IsmIJ0P7sQ9CtdvUxjjVZ8yX+o79Hc=
X-Received: by 2002:a67:f607:0:b0:472:65bf:9f14 with SMTP id
 k7-20020a67f607000000b0047265bf9f14mr4320102vso.5.1710147845811; Mon, 11 Mar
 2024 02:04:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228-arc-for-list-v2-0-ae93201426b4@google.com>
 <20240228-arc-for-list-v2-2-ae93201426b4@google.com> <d52c5d95-99cd-4bd4-864f-b704299d3b1b@proton.me>
In-Reply-To: <d52c5d95-99cd-4bd4-864f-b704299d3b1b@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 11 Mar 2024 10:03:54 +0100
Message-ID: <CAH5fLggrRANz1GrjEa671Vj0m9=UDeEcGV5vhOxq8XtR6EjUSg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rust: sync: add `Arc::into_unique_or_drop`
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 9, 2024 at 2:02=E2=80=AFPM Benno Lossin <benno.lossin@proton.me=
> wrote:
>
> On 2/28/24 14:00, Alice Ryhl wrote:
> > +        // SAFETY: If the refcount reaches a non-zero value, then we h=
ave destroyed this `Arc` and
> > +        // will return without further touching the `Arc`. If the refc=
ount reaches zero, then there
> > +        // are no other arcs, and we can create a `UniqueArc`.
>
> This comment is not explaining why it is safe to call
> `refcount_dec_and_test` on `refcount`.
> It dose however explain what you are going to do, so please keep it, but
> not as a SAFETY comment.

I'll reword.

> > +        let is_zero =3D unsafe { bindings::refcount_dec_and_test(refco=
unt) };
> > +        if is_zero {
> > +            // SAFETY: We have exclusive access to the arc, so we can =
perform unsynchronized
> > +            // accesses to the refcount.
> > +            unsafe { core::ptr::write(refcount, bindings::REFCOUNT_INI=
T(1)) };
> > +
> > +            // SAFETY: We own one refcount, so we can create a `Unique=
Arc`. It needs to be pinned,
> > +            // since an `Arc` is pinned.
>
> The `unsafe` block is only needed due to the `new_unchecked` call, which
> you could avoid by using `.into()`. The `SAFETY` should also be an
> `INVARIANT` comment instead.
>
> > +            unsafe {
> > +                Some(Pin::new_unchecked(UniqueArc {
> > +                    inner: Arc::from_inner(me.ptr),
> > +                }))
> > +            }

The from_inner method is also unsafe.

I think that using new_unchecked here makes more sense. That method is
usually used in the case where something is already pinned, whereas
into() is usually used to pin something that was not previously
pinned.

Alice

