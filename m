Return-Path: <linux-kernel+bounces-129735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A24A0896F42
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 324B52832E2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D833E146D4B;
	Wed,  3 Apr 2024 12:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cL+MwWSw"
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9AF44C97
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 12:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712148565; cv=none; b=GdGadXlO+IyeOXpK+ZGQ01iu+IxUBKTtmwna5CqacDXn5bbFwg7wMl7X/FnOjpa4POCPnLl3wOkiFXDKEcvyuHL7Fw5CIJOkZdseEj9uDRRn/N5G4mM1IB1gTKOD/uhHErBnM+HcOMaGqcKmiCeef24yZ+7Y4fqC5EM7bUn0+BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712148565; c=relaxed/simple;
	bh=ROVG0xiHSnIs7KwRvfSwwYBgADFkDIzMA1GXsgZfjG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gONXJKHeJKnWdIGqpnolKuuODe2lW7VCntJHUtNk/8VHBULHGcIpGIRVVs2QZx5J22yb3zJGjXxdLjj8qvykVSYo7q5ryAwVUy4pLHX29bHFFPfx+YH1NRxPY1WPoC3bbxNEGpUYv+nlzOYyeKkOlWurXdyf91wgZPdm8mMZW9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cL+MwWSw; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4d44f565284so1974251e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 05:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712148562; x=1712753362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2Ars11R43M3g3ak506J2E1E1SdVC3fdtd6pwR1tGRQ=;
        b=cL+MwWSwzNVWBigFR/rg1aENaXWlU2/dlbDGdjYhVZW5Md+8KiJAU0rwpLnO/YWTal
         oYOb93BREIVbIeYolIynQu9QeeEG+6oVT0DQUVRCcka1a9lsKzGUJuAN7PUGA8bd4HEI
         EALQUfUI68jY14LaDwlkc4ZZtVE9ICyQSTTEbqVYXk1pp0PXK6ov9iceae/+t0z0mAU3
         qOCqS+HHnY3nKoeeVE3WAzvbIKBO1LyDAeYlqCD7BWDWt6BMd4xGpWzy0MVR5eHVy2+q
         bYF3pM/9+3gWkVJpfZDwIjyq3TGaRD9Oi04GTE7F8iXFGptS7t6s3ltSyowuaBQ/WVbw
         +eYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712148562; x=1712753362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2Ars11R43M3g3ak506J2E1E1SdVC3fdtd6pwR1tGRQ=;
        b=t9TWZapKiqEjjRsxZJaO0y7fmpCORqbnB+yYW6bVxghBZnADfSwpjzvW2MexQijThd
         NGf36H8AJmxdIr5WG9JGQxUusDRwR4NQDuLc+/39GYztdd91rTa6zw4nCvCue7mhTWv4
         2G8y6R0duceLObcBee2rnjFbZ16ZfybVcqD/TaMm/uXi21X5fHe7h9u/Z40dkbXD49Ml
         ASqwPEQQO0FopPcKdHqXGheAuFw/b4ibqq/1IbnzAKswDhr1DQliyYT/nIzH2ibzHja/
         71+XwyHfC4Kr4KWw63FhGU7gsLYg6Pa9xyb9doXEJod1euJejxddX6y78f+6hRDUPndP
         xqhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQZ2+ckF5kxOg3SW8rD5Cgh1c/iqAGDq9tbMSmSCoAoRSdmLCqNUrni8GebwDpd5tScmPcFB7IUZtMa09cTzTbbohKc85i/220rD+F
X-Gm-Message-State: AOJu0Yz2nYi7eUdlWn8F7e6trR0rJmTK18ZDN+ENGkRFt5pgI0lLiyl3
	0SY2dXdzp0dEBgWq6FHuFUHFqIJF8Zkbdx7C22ovZpQHwEN7y6YiLVLQSVSOdfPapSxZsYEDgmJ
	lPEd82yxJrDqt/F5R0RcPLV2TZ61PwxDbD3X8
X-Google-Smtp-Source: AGHT+IGpGV6qmNqrrvcbmVo3EjMPGgz6/E5lSHMdShUkmEzO4ELmFUZsaP3K2B+eJuIeKzDyPL73JKf/NC1FkGRyx1o=
X-Received: by 2002:a1f:cdc2:0:b0:4d3:36b9:2c26 with SMTP id
 d185-20020a1fcdc2000000b004d336b92c26mr2131961vkg.14.1712148562485; Wed, 03
 Apr 2024 05:49:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402-linked-list-v1-0-b1c59ba7ae3b@google.com>
 <20240402-linked-list-v1-7-b1c59ba7ae3b@google.com> <4aaf7fd7-49ed-4b3e-b691-0d8d7d426d3a@proton.me>
In-Reply-To: <4aaf7fd7-49ed-4b3e-b691-0d8d7d426d3a@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 3 Apr 2024 14:49:11 +0200
Message-ID: <CAH5fLghEg37m_PhJxE8FVORHGROE9rd1CJttaWBGc7cXZCX+yQ@mail.gmail.com>
Subject: Re: [PATCH 7/9] rust: list: add cursor
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

On Wed, Apr 3, 2024 at 2:19=E2=80=AFPM Benno Lossin <benno.lossin@proton.me=
> wrote:
>
> On 02.04.24 14:17, Alice Ryhl wrote:
> > diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
> > index 892705dd0571..47e52818c7bd 100644
> > --- a/rust/kernel/list.rs
> > +++ b/rust/kernel/list.rs
> > @@ -408,6 +408,20 @@ pub fn push_all_back(&mut self, other: &mut List<T=
, ID>) {
> >          other.first =3D ptr::null_mut();
> >      }
> >
> > +    /// Returns a cursor to the first element of the list.
> > +    ///
> > +    /// If the list is empty, this returns `None`.
> > +    pub fn cursor_front(&mut self) -> Option<Cursor<'_, T, ID>> {
> > +        if self.first.is_null() {
> > +            None
> > +        } else {
> > +            Some(Cursor {
>
> Missing INVARIANT comment.
>
> > +                current: self.first,
> > +                list: self,
> > +            })
> > +        }
> > +    }
> > +
> >      /// Creates an iterator over the list.
> >      pub fn iter(&self) -> Iter<'_, T, ID> {
> >          // INVARIANT: If the list is empty, both pointers are null. Ot=
herwise, both pointers point
> > @@ -476,6 +490,69 @@ fn next(&mut self) -> Option<ArcBorrow<'a, T>> {
> >      }
> >  }
> >
> > +/// A cursor into a [`List`].
> > +///
> > +/// # Invariants
> > +///
> > +/// The `current` pointer points a value in `list`.
> > +pub struct Cursor<'a, T: ?Sized + ListItem<ID>, const ID: u64 =3D 0> {
> > +    current: *mut ListLinksFields,
> > +    list: &'a mut List<T, ID>,
> > +}
> > +
> > +impl<'a, T: ?Sized + ListItem<ID>, const ID: u64> Cursor<'a, T, ID> {
> > +    /// Access the current element of this cursor.
> > +    pub fn current(&self) -> ArcBorrow<'_, T> {
> > +        // SAFETY: The `current` pointer points a value in the list.
> > +        let me =3D unsafe { T::view_value(ListLinks::from_fields(self.=
current)) };
> > +        // SAFETY:
> > +        // * All values in a list are stored in an `Arc`.
> > +        // * The value cannot be removed from the list for the duratio=
n of the lifetime annotated
> > +        //   on the returned `ArcBorrow`, because removing it from the=
 list would require mutable
> > +        //   access to the cursor or the list. However, the `ArcBorrow=
` holds an immutable borrow
> > +        //   on the cursor, which in turn holds an immutable borrow on=
 the list, so any such
>
> The cursor has a mutable borrow on the list.
>
>
> > +        //   mutable access requires first releasing the immutable bor=
row on the cursor.
> > +        // * Values in a list never have a `UniqueArc` reference.
>
> Is there some type invariant guaranteeing this?

The List owns a ListArc reference to the value. It would be unsound
for there to also be a UniqueArc reference to it.

Alice

