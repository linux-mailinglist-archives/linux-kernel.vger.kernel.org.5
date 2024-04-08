Return-Path: <linux-kernel+bounces-135142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB04889BBA6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79EDF1F228FD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5884645B;
	Mon,  8 Apr 2024 09:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3WaA6Qpf"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8430247A7D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 09:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712568397; cv=none; b=q+qaJPdyrA/SX4grJwoxkdIKFT59Pj5TgKP58Rjt4/um64VprK8hN2hXdtM3oZmWZfr7ACch6i2gWWyCO51mE+BhXFLmjtt3rFOEqi+oFQnkvu4K3rXKVcRuCruloU3QwgjCHNYMicUdPPa3BvH7nUio/Ik1zuXD+5hOhQLoIgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712568397; c=relaxed/simple;
	bh=oFfg9XsxElE7cRN9U3m13pRPYNa0LsdhfdKdd2Ctvkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s5GcKJjVCGBH/ac5vC7zknWNIvGM+YVskAPdeYl6PtR3Dh5uB4rXxWcBWMavn8VB+sSRdlTGFklPhu5coLz62mEgjopIS3YKckF7eYSRNADCOp6jUE9kFGjMvok3eDwzZpkQYF50BimsvpMs2C9+klqlxcIdaV47YM1hSHxvglI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3WaA6Qpf; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4daa2b076beso1141700e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 02:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712568394; x=1713173194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIy9SeLJ1nvzPDO0+gT7LUDRnqZqv1g2qTZnmvRtF8w=;
        b=3WaA6QpftjDJHVSsMe+qcWz50x+ihCAkGZh+u3P3CwtfeEuG8nTgS0uek+mJ3MfFbU
         Nj+bZVQtfkMHjDv1BIsPNqjSTgVOOP2UK0nDIxBxXXOE3doe9ZJ5htj3mGqyjoAIBQGk
         g6Kmqd9aLtx67ni/9jciuA+CmaZlDUTUgLB3FY8DTJTdHRcwA8btvKn/fSKDiPi6st8O
         JwdGdVNLvzrca8Ykee5YoW+97hUZCB/HIB9e53UN1v9X7vEPboSXopJvkZoaH+kPV28M
         oBe1Ejh51vL93C7Vd/VWXYizchLe31aBRCewg4umCXOSarIN8CZke96MhJT5WTH5Oeke
         FUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712568394; x=1713173194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oIy9SeLJ1nvzPDO0+gT7LUDRnqZqv1g2qTZnmvRtF8w=;
        b=ng4V1px3hsI+O3aI00+M7mMsw1jVkmQHFwWSxRLwpIFFrHALMX2CRd7zdn0gJoCgTT
         OSdtSrSlwy8IqUzjeA2FHRTOGd/oMNZln+0oG2j9sZiJATzhzc7LFUTArEFOtml5kZhx
         7ldIKy1o39j+Os1/OitIBVjesnbQQAKkJoR7M/skdZ8pHMPRoR0UfxmhVuo7T2mkI53z
         Kj+i+ZyPkgkKrF1Egs+wtgodMUzEMQxgMfG3y7IuXIENUG50kAXBe1d2xZus3wDclaZi
         4ixWJ+Ne8J9hJfWGROhbHXugNnh4K8FjHJZo0s50MkG4eQ7cBuNIlg/gwgBsCZco0tjc
         fzdg==
X-Forwarded-Encrypted: i=1; AJvYcCXFH/iXtZN50vE5+O2utH+7qF+Mb089xSbh4TX6yEhe8204774wd6P2n9dhlf5DTOttlwI/rgwnDWu1lzZRfsrBBpQGRecdLbLnSZu3
X-Gm-Message-State: AOJu0YwVjG6YS3nxq1qL6QzRtw+1pc8btsIfvMDmB2Wj0g3NkqesoVq2
	dbR0l4YIdT1+C5IqixOifdeaESDNy40MoxK347WN+D4OUpPhZBvZC/WNqww3Y2vv4ISkmOCwq+C
	BbIgUGQHr0Z3iTFiecaKd+1F29JT6UI4s+t1K
X-Google-Smtp-Source: AGHT+IE3ctn60mbisPE+3PgDQzWKYFH4fz7jLn6kIz89GDQBsxDl4h15/TtK0Z8YFRnQV/FF1toMip/RgGPmLJg1kxc=
X-Received: by 2002:a05:6122:4809:b0:4d3:35ac:3553 with SMTP id
 ef9-20020a056122480900b004d335ac3553mr4054281vkb.10.1712568394315; Mon, 08
 Apr 2024 02:26:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404-alice-mm-v4-0-49a84242cf02@google.com>
 <20240404-alice-mm-v4-4-49a84242cf02@google.com> <a48b2347-b58b-432e-bdb8-d5449016ab57@proton.me>
 <CAH5fLgg3wpcDE+n6nd0CGtDzyXSrD2nLhY8RxdTHjAD8hQ9VDQ@mail.gmail.com>
 <c130a6f5-77d7-4d9e-984d-7a8bf48ff918@proton.me> <CAH5fLgigLV17+6U75MC43XFnYeqtgvrrTWD7JmDSB-ebNjCVvw@mail.gmail.com>
 <CANiq72mZ5QPrb1-jWiKFhO2OF517Xvx=Js3zwM+_VyVL=dy2LA@mail.gmail.com>
In-Reply-To: <CANiq72mZ5QPrb1-jWiKFhO2OF517Xvx=Js3zwM+_VyVL=dy2LA@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 8 Apr 2024 11:26:23 +0200
Message-ID: <CAH5fLgjr57qB2qp+b7xQ3wsKGyT0zsOkhQj0Q-z0KLo2jhCsTQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] rust: add abstraction for `struct page`
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 11:19=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Apr 8, 2024 at 9:54=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
> >
> > From bindgen's point of view, this constant is just an integer literal
> > with no type information. So I don't see how we can expect it to
> > always be generated as a usize?
>
> In the case of `PAGE_SIZE`, there is type information (`size_t`),
> since it comes from the constant helper:
>
>     const size_t RUST_CONST_HELPER_PAGE_SIZE =3D PAGE_SIZE;
>
> For the other one, `PAGE_SHIFT`, there is also type information
> (`int`), but bindgen currently picks a type based on the value for
> those (but ideally/eventually bindgen should respect it instead).
>
> So for the former, the allow and the cast are not needed since we are
> already handling it explicitly. And for the latter, if we want to have
> it as `usize`, we should have the cast but not the allow, because now
> it does `u32`, but if it respected the type, it would be `c_int` or
> `i32`. So either way we would need the cast.

Good point. Will fix this for next version.

Alice

