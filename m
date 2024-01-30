Return-Path: <linux-kernel+bounces-45245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D315842D85
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3CDA289980
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689E371B45;
	Tue, 30 Jan 2024 20:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9VmPcW3"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A9271B2C;
	Tue, 30 Jan 2024 20:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706645467; cv=none; b=VTx21HnHyZsgniTXx1dMqok72218/VD06UmG5nUyWplO5fNE87pnqgE0PQtG8RTjcW3xH/jIcuZm1fVyMAuw7MTw47IHVRTHyS4PkONXpSiGS7j43wznbbW4z6Ry4qjMBNbHFZ+U+TdII8HMTGsOb4EMDileyRuNtKVBHVWRoiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706645467; c=relaxed/simple;
	bh=bAuClN+1Rr2oWKTsY3EaaihJEPGJgUZrb5ntixxjFJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sDii5dbomRIPGcpm+WJK/T4Huae8gAb0pl2vaka9Ajh3G44X91yU6aShsSU0GjtDZizg0JfNMb2+ol5DCCneBg47PPJ3QntrwgcAkO81HiI4q98s+IdmQ6t32h/kwew0qY56CyafQeom/yvjOqCFhf2EpFZHvVwF2gb9+31U2Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9VmPcW3; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-603dc95b8f3so27210057b3.2;
        Tue, 30 Jan 2024 12:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706645465; x=1707250265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Er/RtS0EFQVwgVCx7mxPgkG12TgbHggtBqWfVJWN60=;
        b=G9VmPcW3J/UpC+L+jcg7iM41c1okB0eDML8xXcmidLRRGfwPLe6Kz0h3AUPG/sucLb
         YrVqLjzrgu/0sX4RghWMLtj3lt+iEI4NQN4z1jiNW/hvqAthAOZh8QO72TZsOPhBH3Fy
         Jsyo2RJi1XrpzfeyLsIbW91yP9uB0LPp7gQAwaVD7aZHIdWHHIv8AlDmRo41ljXAjcBi
         sBcDjC1and+HDhRXQNa8CXcjxE25TbSGt3EnF9r176ZJrFoU18iN+wKUzwDo0U5us1bt
         gtkPBXPRsm43Ggwx48tqMl3xs/u0mbJY2TWcP6fPBmMUP3uIqC8dLAM2AEhj2GH92Tnc
         cA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706645465; x=1707250265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Er/RtS0EFQVwgVCx7mxPgkG12TgbHggtBqWfVJWN60=;
        b=Q+79ZopQydZNd4abMAAK4XXdxkuHg0P6XUof9xmz0voM/ExaG7sYxnqmhgXBiszoCq
         2B9nj7HxuKpxBTonztea0bN0UDOR25fkOTPmxGUYpshNtchrgEi152dX2FE9BqKaVM6+
         Bif1AobKkLahshF+xKzB9TixEmGjw1je01+Rwg3kbhImXJkNHtIYjlt6rHnBJTOiNDGS
         49d981QFKqZ/xy7A/LuHKBpZXl/K/khfs5dxPIaMwe2+euEflBhz9uetb+0I8/N/61YW
         kzImA+lA9B44BOhRW3reP/KpJLf5zzzm7raifnTf7E7R5wVmYpyyNdID1xKJqy8JPZuV
         kruA==
X-Gm-Message-State: AOJu0YzoI/43gjwa7GpFqApghm+96ZNqAM1r5dTX1D2UhIEoi38WM3mF
	K9+EGQ4Op1/8knaX4dJIOBnTQS9v8uBz6XgOUcH46uNH4VQY6llKMlaUGuvT/VyXiDfpbwjfnqY
	AScy+qVkg2T3pkn5uGPXAKq20378=
X-Google-Smtp-Source: AGHT+IHvz19idkKT3x/BW7wPNHcskH7oltW0CbYAEFb8npkIv0SM19aNwDk1LcX04iKMzT9BNHP/9BlS1zVNUquUMLY=
X-Received: by 2002:a05:690c:3603:b0:602:ce8b:6aec with SMTP id
 ft3-20020a05690c360300b00602ce8b6aecmr9617607ywb.51.1706645465382; Tue, 30
 Jan 2024 12:11:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130-rust-bit-v1-1-ed2ed6389a58@christina-quast.de>
In-Reply-To: <20240130-rust-bit-v1-1-ed2ed6389a58@christina-quast.de>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 30 Jan 2024 21:10:54 +0100
Message-ID: <CANiq72n5nuyA7nuX1NreS4JXPcyqN2iT=8-MnGBcT=a1Hufqbw@mail.gmail.com>
Subject: Re: [PATCH] rust: prelude: add bit function
To: Christina Quast <contact@christina-quast.de>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christina,

Thanks for the patch! Please see below.

On Tue, Jan 30, 2024 at 8:48=E2=80=AFPM Christina Quast
<contact@christina-quast.de> wrote:
>
> In order to create masks easily, the define BIT() is used in C code.
> This commit adds the same functionality to the rust kernel.
>
> To use it, include the following into your rust file:
> use kernel::prelude::bit

This is the prelude, i.e. the point is that it does not need to be `use`d.

Did you check the `rust` branch? We had something like this there.

> diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
> index ae21600970b3..16e483de2f27 100644
> --- a/rust/kernel/prelude.rs
> +++ b/rust/kernel/prelude.rs

Please note that the prelude is meant to re-export existing
functionality elsewhere in the `kernel` crate, not to define items
there.

> +/// # Arguments
> +///
> +/// * `n` - A `u32` that specifies the bit position (zero-based index)

We don't use "Arguments"-like sections. Please see other functions'
documentation to see how we usually do it.

> +/// # Example

Please use the plural.

> +/// ```
> +/// let b =3D bit(2);
> +/// assert_eq!(b, 4);

The example is not closed.

> +#[inline]
> +pub const fn bit(n: u32) -> u32 {
> +    1 << n
> +}

Should it be a generic?

Cheers,
Miguel

