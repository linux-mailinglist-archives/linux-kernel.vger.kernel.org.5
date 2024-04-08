Return-Path: <linux-kernel+bounces-134984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A34C89B996
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDFF71F2151E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E3F38F99;
	Mon,  8 Apr 2024 08:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uZk1fjbt"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACDC383A0
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 08:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712563223; cv=none; b=O+6G1CYGLt1UNUsyDooA7zZG1F3o4y62NUstWOn7NQgrw//TMGu5iTVmZaTnQhtuJl+LwTPJCK06K6JibXGPbIHSTVs2Qz9HMwkgAyksxo4YaGTPtPZ1YAF8JyDYZib1aaU25SNHh83MDu6Qxg/bkhcGgNMG4MJ7l0IkW0Jopj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712563223; c=relaxed/simple;
	bh=pHxB3riv3KUMXEfOU50W6lVzqahm4AeiTdlYhjEfnVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XPpZoO6ML0NtivH+zenlcbnpiwTW6Xqo5rahlZoWmCC9lLcpdMq8mGDxpHBKvutfyB3Z0VFpD2/DIS6gMq7UAj9heS4pQnLtxbubleNnvYZEwtSNgCtjy6QPcuS7PtbI0DAsHyNgW6QqB27B25Uj+TO0b54xaOQ4NuzssVP4FT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uZk1fjbt; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7e6756ec17bso473449241.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 01:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712563220; x=1713168020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FOsPTWHaEE82X2na8AskRgQpO9sFazpZ1ejud61f9w=;
        b=uZk1fjbtJQz4yf+VT6/fWjtC4tjnMtZeyXsPFIyYoDfrSBvWiyfOQL8mIutsH/AhmK
         mNzDMYuP/2bg7Mq45qopVHW9j0SuPI4GPJMCMAiwmNh+0JWDRmk3T2cmlxeRNLHN3E9R
         Kp3TfJGmTvcHXYbQ1HNGRDnkgJLO4sNI4kUvFHMIa61dTsuAfhe+0i31bdZFVlATgkd/
         sFeykH9WBK42bDg6qNgl0mPaVWekjurSW03nufrCBMeRWqR67drYLMxZOyZrfMYBZLzx
         /Qcg8DlUDSz47J4tzpWFhvjw9AB0Z578XnFhY6fzCai81SmWUs+x/1LgB9DiA0PNfmOH
         AuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712563220; x=1713168020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6FOsPTWHaEE82X2na8AskRgQpO9sFazpZ1ejud61f9w=;
        b=iwBufUA1AwH1FNkQia/As50AZEaA/ijlXev5AXeU23OlK6zFNdLZBXqp00eb0SxXzM
         6948NX9SJBSKR3kDk+3DhDYZqlwGOF63E0xXXUBh6Lu17bC6i50jPz32OAKrcoC0YmNL
         ghP4aHRFd07VcVei7x0NGp9mGvDsFcx7KR3g6udG2alKJMqQGECK5zs5syY0FZNIUJDj
         zC/6DqhsMbqJXiE8PV8bUwyEy7LPF+JsdS9KwhV+q6fssZxNA/B/mkLzNAWyxfwe4N+o
         rVmvThEPto24lls+a4obPRkZtWppJhF/v9Kziotx4HD93jTcGYhVEmhjas+bYFAs/KHc
         xesw==
X-Forwarded-Encrypted: i=1; AJvYcCVEHzmKTlFlrzEYMhcIHFkKJeduikMGsNfMewnkQIbO7laDgxGVlY2e9gofQ4DASZ4t4yY/N94iz2/om48kyM4OzNjfmpYcI3xtHueD
X-Gm-Message-State: AOJu0YzUd8zj8rYYqs5tT4gboieK57TAb55uEPIqs2ydHbNjAv/7sDCv
	ezq5scLgMlm+BZqRAXC1jrcfJd2H0fzvpRaO45QdbNEI9xtYD8p4peHoReHm0pg7NaRBrdn+dj5
	lnBoj6pOvfvuQpGOrVWHfUNN44qF8JEQNQoL/
X-Google-Smtp-Source: AGHT+IF9f5jmOEJWTkd9kdJrUZmHW+LueigVkR1pev1XTzP7AugYDbMFKGqlkAiec8GAn8o+OvC6BVcvOD7CUKwA3Og=
X-Received: by 2002:a05:6102:c54:b0:47a:72f:981a with SMTP id
 y20-20020a0561020c5400b0047a072f981amr1007451vss.26.1712563220314; Mon, 08
 Apr 2024 01:00:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402-linked-list-v1-0-b1c59ba7ae3b@google.com>
 <20240402-linked-list-v1-6-b1c59ba7ae3b@google.com> <98449574-4c1b-4281-bbd3-3ac2767020cb@proton.me>
 <CAH5fLggS3qtCy20Y=kuxULUY9Q_4dSzJN5n2WitU362cYuqPLA@mail.gmail.com> <4045af19-05a4-48f0-9ca1-0d8d4d2b865c@proton.me>
In-Reply-To: <4045af19-05a4-48f0-9ca1-0d8d4d2b865c@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 8 Apr 2024 10:00:09 +0200
Message-ID: <CAH5fLgiYfU91QqCs+9L=9y76PKAYiDVva3WNoQE=Ja1ASzua7A@mail.gmail.com>
Subject: Re: [PATCH 6/9] rust: list: add iterators
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, 
	Kees Cook <keescook@chromium.org>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, 
	Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 4:52=E2=80=AFPM Benno Lossin <benno.lossin@proton.me=
> wrote:
>
> On 04.04.24 16:41, Alice Ryhl wrote:
> > On Thu, Apr 4, 2024 at 4:36=E2=80=AFPM Benno Lossin <benno.lossin@proto=
n.me> wrote:
> >>
> >> On 02.04.24 14:17, Alice Ryhl wrote:
> >>> +/// the end of the list. The `stop` pointer points at the first valu=
e in the same list, or it is
> >>> +/// null if the list is empty.
> >>> +#[derive(Clone)]
> >>> +pub struct Iter<'a, T: ?Sized + ListItem<ID>, const ID: u64 =3D 0> {
> >>> +    current: *mut ListLinksFields,
> >>> +    stop: *mut ListLinksFields,
> >>> +    _ty: PhantomData<&'a ListArc<T, ID>>,
> >>> +}
> >>> +
> >>> +impl<'a, T: ?Sized + ListItem<ID>, const ID: u64> Iterator for Iter<=
'a, T, ID> {
> >>> +    type Item =3D ArcBorrow<'a, T>;
> >>> +
> >>> +    fn next(&mut self) -> Option<ArcBorrow<'a, T>> {
> >>> +        if self.current.is_null() {
> >>> +            return None;
> >>> +        }
> >>> +
> >>> +        let current =3D self.current;
> >>> +
> >>> +        // SAFETY: We just checked that `current` is not null, so it=
 is in a list, and hence not
> >>> +        // dangling. There's no race because the iterator holds an i=
mmutable borrow to the list.
> >>
> >> This (that the iterator holds an immutable borrow) is not true (there
> >> is no `&List` field in `Iter`), but you can make that an invariant
> >> instead.
> >
> > What I mean is that the borrow-checker will consider the `List` to be
> > borrowed by `Iter`. Whether or not there is a real reference or not
> > doesn't matter.
>
> Yes, but that is implementation detail of the safe function
> `List::iter`, so I think it must also be captured by an invariant.

I will add an invariant.

