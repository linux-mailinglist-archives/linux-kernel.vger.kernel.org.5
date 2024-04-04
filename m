Return-Path: <linux-kernel+bounces-131639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C722898A4F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 064D028E2BC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC95512AAC5;
	Thu,  4 Apr 2024 14:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mcnzliWR"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1201CD03
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712241727; cv=none; b=qQPVfq11saYcgtrBze9vTJ9KAveuAfoQewHeAFV2ffVKakn3MKR9oRt3rBJg2e1l/GA1R6wrTU3PntLAUOtthy6pV+agwAfoBwm8t9qm7KEnyzngOzPzCgN5xTeOa6mwQKcbqYC/YqH6/ajsoGTK//U+xvyHN0CykmToF5rAM1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712241727; c=relaxed/simple;
	bh=Tl6OJL3Ay3elBPXJKELrFjWgQUqYUPxNsWZDIG4ldSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KuPnvXLJvJuLJGlRxFvhO0K6tB4P8KW2I9AsVQQboJnf4ES+c3fmqvU16H+Ytxiun7wjxRvBMY7V0tJ9fA3L8bHC2b6m4Hq7oRnzbq7r1uFegQ3K05zDh0QgmymUNtRqtNlvbfqTh8sxR+vhFA3iLlDcuJxVDDBODtyH9R8jt/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mcnzliWR; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4d43d602cd6so369428e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 07:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712241724; x=1712846524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCOieR3KDrxseidIEeQxtseySKtvl+xDkoYPv0qKlDU=;
        b=mcnzliWRODP+SepwivmCwrju+LYKFpk9FTbZmo2UMq/Bx03djm/3f0l5qtZjfi9e1/
         BDJPCHpkvD9UI80S5XWeyFFR4EpR8YVxcUTAmCgafUSNg7AHtRh0r/HHND1N6+DXhVUz
         accmja2zxN4Pt0mYiXEp5rNcY5WNeheUZpQhnJXAHnRXbMriB9K99FdORYLjbo5NdyL8
         CqNF7MjqfFWgIsZC74Op/8DST3V3D60/q0GajPKK08nDwbw++64oKX4ipnZTkJkcZLPZ
         dwYaviKRVzWWW7Pwv5wnZ3gAUIm9D8Emf3FXQNY3dMZlOsT1a6k75AF973B1LiJKaKbI
         dfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712241724; x=1712846524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCOieR3KDrxseidIEeQxtseySKtvl+xDkoYPv0qKlDU=;
        b=ixrxkg4zm7I2z3M55kwsovg3s2IEWFKMiC5vL/3HMKTqAENcn81+N5//UlW9AQ5mHu
         z+3rTMOQ0dlXf+O08O1ml0gItRq3D3lNlT80Wr39gPch5iOMiG7fAqenvMRA7JLnxDsf
         ctgrQUluTr9NeiwDa+taS4D4rK4p+kvLFt1GwRT2a7qkGbykbuSELA1FIe8oskTYx4iP
         kD/sgA0R1uk78cOFH44xlbgRa5Im9x0As4L6ID4uH9nkdlwCLFtcje5uhjxXRkxoxb6k
         mnjUUavBdgaX4lIELz1bDN/f466M7nZkj+xlaZY8xl/01RCc8wu/h7RTWxGj5m+V8bRW
         If1A==
X-Forwarded-Encrypted: i=1; AJvYcCUhDxx1lCZH4ECdhb7JtTJZ0QNVYzDj7DEInBsUNm5We/YXYFt5gphWzy6kwUNZnUFJAuAmqt1ysnSQKxuLz2+bOB4zndOeSmxA766M
X-Gm-Message-State: AOJu0YyiNESwFWglIgcT+qARATCE1NQSsrow4a/RHiBuWGSr9iXJvjql
	XhDqRaeBXadiz1dqH1zMSUwW80dBL5xLs0cJVGO/p1ePf2dVw1lBJ6cOYKcE43sW/pH/VTNe0UK
	lR+5YqzebdoMkBmFevNdYMSiAU5tvPtIo2N/G
X-Google-Smtp-Source: AGHT+IESWmyAscr9En8d8fr10/tEJzgqLsplPhrY4zQ0QFQYN4d+/iDrBX4FqYfT00rTM8f4CM+gF4C9U3UA8ocAC8U=
X-Received: by 2002:a1f:f84e:0:b0:4d3:362f:f9c1 with SMTP id
 w75-20020a1ff84e000000b004d3362ff9c1mr2282476vkh.13.1712241724504; Thu, 04
 Apr 2024 07:42:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402-linked-list-v1-0-b1c59ba7ae3b@google.com>
 <20240402-linked-list-v1-6-b1c59ba7ae3b@google.com> <98449574-4c1b-4281-bbd3-3ac2767020cb@proton.me>
In-Reply-To: <98449574-4c1b-4281-bbd3-3ac2767020cb@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 4 Apr 2024 16:41:53 +0200
Message-ID: <CAH5fLggS3qtCy20Y=kuxULUY9Q_4dSzJN5n2WitU362cYuqPLA@mail.gmail.com>
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

On Thu, Apr 4, 2024 at 4:36=E2=80=AFPM Benno Lossin <benno.lossin@proton.me=
> wrote:
>
> On 02.04.24 14:17, Alice Ryhl wrote:
> > +/// the end of the list. The `stop` pointer points at the first value =
in the same list, or it is
> > +/// null if the list is empty.
> > +#[derive(Clone)]
> > +pub struct Iter<'a, T: ?Sized + ListItem<ID>, const ID: u64 =3D 0> {
> > +    current: *mut ListLinksFields,
> > +    stop: *mut ListLinksFields,
> > +    _ty: PhantomData<&'a ListArc<T, ID>>,
> > +}
> > +
> > +impl<'a, T: ?Sized + ListItem<ID>, const ID: u64> Iterator for Iter<'a=
, T, ID> {
> > +    type Item =3D ArcBorrow<'a, T>;
> > +
> > +    fn next(&mut self) -> Option<ArcBorrow<'a, T>> {
> > +        if self.current.is_null() {
> > +            return None;
> > +        }
> > +
> > +        let current =3D self.current;
> > +
> > +        // SAFETY: We just checked that `current` is not null, so it i=
s in a list, and hence not
> > +        // dangling. There's no race because the iterator holds an imm=
utable borrow to the list.
>
> This (that the iterator holds an immutable borrow) is not true (there
> is no `&List` field in `Iter`), but you can make that an invariant
> instead.

What I mean is that the borrow-checker will consider the `List` to be
borrowed by `Iter`. Whether or not there is a real reference or not
doesn't matter.

Alice

