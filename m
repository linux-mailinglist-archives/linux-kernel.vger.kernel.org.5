Return-Path: <linux-kernel+bounces-58045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C36D84E095
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6E8028DF1E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CA8762D5;
	Thu,  8 Feb 2024 12:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="lK6jO+qp"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0580971B5F
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 12:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707394841; cv=none; b=A8z1GM3cjhEFljhM7ryrN2a+6+JIx58wOIEEqE7hysvanONCImZn+5AI2QSxGQwWdYotFqZuQ6FzIY2fWkJr4XnA6CM3wUv25rve3VwqOOtS8H5JjyhhzKtSsePkgFw1OA8Zu/R0qUyPR7oWDmzjAhpQGQg/N2uECVQgui0/C60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707394841; c=relaxed/simple;
	bh=3JyyPHDywY0DWXt/HZUqe0GH7KV9wdeM+NZ7Y9F6MdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c4M39vpQQ3OEP/VnGsafYdaQFJ9BLpoUXQzm8r+vUvvgSCnhpkMJ/ez1LBQLw/8I2oo8/t48bWCE68Lsv2k6nCwh+IOJ3QTT9Nh/qUUaUfo41eoXOpPEn5ztsG7lKdL5qWFiTgt4tX4E7ouiNIDgeAAAQa2zo5BWNqYsBr9NHqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lK6jO+qp; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7d5c514944fso417562241.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 04:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707394839; x=1707999639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bf7m/USDjz7kE2FE9CQHR/aM8ZK7eKAJ6zNf2AmjvPo=;
        b=lK6jO+qpiz7Dz9zsibMBe0G6Xhgti5BjVZZEhrSbWOPjFXVq1LNCV2ezC4LE7TA7Zh
         qHoGNfvRUT/MH9/1yxRmjdjfz+GQAwSeyGdJU4PMLnZqGrDcFfTrs/Tdf0948IKDt3xt
         CX8TzjI8NrWh5WmugssPxPBW9iq27e1Jy73KV+smHBEKYrsueaMtKc6dOjc5jnnMKfgU
         QQH5zYJJ5o5N1G+c4Q+cWKhq3xuwwjXshKu9LvfSP3Gky5nCyed8BGQCmJQ+t2QwMSTR
         yskXrOLu5ZBPwsv1xes2TL2ghZ0v43veKoT5J5LZTuqRaOX/IQhDVN7kj9TZghm67w3D
         v7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707394839; x=1707999639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bf7m/USDjz7kE2FE9CQHR/aM8ZK7eKAJ6zNf2AmjvPo=;
        b=FxLn1IBDSTNId6mRkQdK+EvafPPjqKJZ/RdQPI+YPTLp35EoOsBLjLfupEBkDKR07i
         VhAVKH2/RtCMdEkgmAI+0AFmIWeML6mWEFdmOU+phjWvEp8GLrhmjE0E15UpziwdFIxq
         gn87H9ezEVJvTkqJuR0wHfveXhpJWi6blohFJ0sLSg+WdePcAOEFY0L5IjEjijMRi8ix
         7F2uxaPk5SffVTyrCv2fvB7e4nf2zOjouWz8RD+QatV4wT5pwSl96K1i5TPZQ+BJC8ZY
         FG7YPR2xQEWsRl5LewTP0BdnxYfKlalX0WSBuTyN4Nm3YeHzWV+vZzA8MsaIzB1vAbWp
         lcIA==
X-Forwarded-Encrypted: i=1; AJvYcCWAs2vIvu5cCG0QwLCpFsZm8bbo7UK/MjOtZN5CiSozqZX2tCCwpb0rJiw8CTOY4y84eVjVjBangYE8twcj7neUkAsbfwYQy0dwbIFK
X-Gm-Message-State: AOJu0YzTLMYDXwwHOUjwlXACcLhPesgzk2iBw0k6/M1tyGPtu1eUhZZg
	P3ZN3OqpWMCsCBWHMlm1SIX1HWUIoR4UC/uhiO4gjZ/y+k+vDGKMRqy+eWId13aA2C+PQsBgnSD
	LLObq+D6W/lRqL9mJbZF+RcG26sIyJJcCoEcf
X-Google-Smtp-Source: AGHT+IGlL86D1Ci5269kTzm8XhRyortv2UdzEszE/4vmPzP7uLriXUhvD14B2r1rBQ/5VXy4f5o9FdDQRR6VTHNU/Uo=
X-Received: by 2002:a05:6122:1c86:b0:4c0:3929:2748 with SMTP id
 eu6-20020a0561221c8600b004c039292748mr1987582vkb.7.1707394838719; Thu, 08 Feb
 2024 04:20:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124-alice-mm-v1-1-d1abcec83c44@google.com> <20240124231235.6183-1-kernel@valentinobst.de>
In-Reply-To: <20240124231235.6183-1-kernel@valentinobst.de>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 8 Feb 2024 13:20:28 +0100
Message-ID: <CAH5fLghRiVGWr--9hqwr4Cg4anaKWVqZA0D65DgJzLPPOAvNgg@mail.gmail.com>
Subject: Re: [PATCH 1/3] rust: add userspace pointers
To: Valentin Obst <kernel@valentinobst.de>
Cc: a.hindborg@samsung.com, akpm@linux-foundation.org, alex.gaynor@gmail.com, 
	arnd@arndb.de, arve@android.com, benno.lossin@proton.me, 
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com, brauner@kernel.org, 
	cmllamas@google.com, gary@garyguo.net, gregkh@linuxfoundation.org, 
	joel@joelfernandes.org, keescook@chromium.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, maco@android.com, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, surenb@google.com, tkjos@android.com, 
	viro@zeniv.linux.org.uk, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 12:13=E2=80=AFAM Valentin Obst <kernel@valentinobst=
de> wrote:
>
> > +//! User pointers.
> > +//!
> > +//! C header: [`include/linux/uaccess.h`](../../../../include/linux/ua=
ccess.h)
> > +
>
> nit: could this be using srctree-relative links?
>
> > +/// The maximum length of a operation using `copy_[from|to]_user`.
>
> nit: 'a' -> 'an'
>
> > +///
> > +/// If a usize is not greater than this constant, then casting it to `=
c_ulong`
> > +/// is guaranteed to be lossless.
>
> nit: could this be `usize` or [`usize`]. Maybe would also be clearer to
> say "... a value of type [`usize`] is smaller than ..."
>
> > +///
> > +/// These APIs are designed to make it difficult to accidentally write=
 TOCTOU
> > +/// bugs. Every time you read from a memory location, the pointer is a=
dvanced by
>
> Maybe makes sense to also introduce the abbreviation TOCTOU in the type
> documentation when it is first used.
>
> > +    /// Reads the entirety of the user slice.
> > +    ///
> > +    /// Returns `EFAULT` if the address does not currently point to
> > +    /// mapped, readable memory.
> > +    pub fn read_all(self) -> Result<Vec<u8>> {
> > +        self.reader().read_all()
> > +    }
>
> If I understand it correctly, the function will return `EFAULT` if _any_
> address in the interval `[self.0, self.0 + self.1)` does not point to
> mapped, readable memory. Maybe the docs could be more explicit.
>
> > +        // Since this is not a pointer to a valid object in our progra=
m,
> > +        // we cannot use `add`, which has C-style rules for defined
> > +        // behavior.
> > +        self.0 =3D self.0.wrapping_add(len);
>
> If I understand it correctly, you are using 'valid object' to refer to
> an 'allocated object' [1] as this is what the `add` method's docs
> refer to [2]. In that case it might be better to use the latter term as
> it has a defined meaning. Also see [3] and [4] which are about making it
> more precise.
>
> [1]: https://doc.rust-lang.org/core/ptr/index.html#allocated-object
> [2]: https://doc.rust-lang.org/core/primitive.pointer.html#method.add
> [3]: https://github.com/rust-lang/rust/pull/116675
> [4]: https://github.com/rust-lang/unsafe-code-guidelines/issues/465

Thanks. I'll include all of your suggestions in my next version.

Alice

