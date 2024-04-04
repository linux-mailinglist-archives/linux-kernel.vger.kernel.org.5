Return-Path: <linux-kernel+bounces-131573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 183688989A2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C11932910F3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16BB129A9E;
	Thu,  4 Apr 2024 14:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NCURPiOn"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79646CDDC
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712239951; cv=none; b=ogf+51XDWXNRkLNQ+RsFP35PVxMvrNnExUD3uPIJZBOmIX25Hb2TSKMwJe+SfIYQmYhWK+5ypdRwJXdHtgW1xXfdh6cKWvtn7QDQJexPZw0Ko4zZywxpPHv0Z/0PmmZvrRhuc42dBEQvdE8b2hn2dNpzcK4J5gE5cP3YoczIuas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712239951; c=relaxed/simple;
	bh=d5N7PMJWMpyiLE+xyvBaoDJlSOen3MFajb3KY9fJFy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OyoA+j1nSuoiMzbKl7bjtfj9D/grj3Qa/hvQkYRONeSRT2ED4O7sSOom1PiVlQcerg8oCEUntiqb6V8rBT2xPgw8N86+iyExq373YvJG8nCAzFDRixAdDiZyv8aKPRVFSg6oyyAGbFTWCahGxSQ8vmDIzDwlRnNgyq1WEDkIVZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NCURPiOn; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c4f23f3eeaso281067b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 07:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712239948; x=1712844748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSMg4gwe2BY9lOXwY09BxCvuJ/qllvCDdUS42+hf1tc=;
        b=NCURPiOnoT7bx7HWdl2m1Tzd9RqwQN8TsQlgcCUPUFW8DOoWadji9bmUAT6ycZPftv
         SSy9BjMPcNHbizffGXajwOd7oDBTAleH0CT6WCsWO0Ylc6/ymkCm1UdYLJLit2y9FqQ8
         wG/jSmCEFooeSYbvofgJdc7RT2B+QRy6mTtv/re/iHwHwd/cI1wycktdS6z2PBC1VFh1
         U8AGnOpki92fyjkMVnyP8QLC7kALUR/QS1JhFW3le6DFUa0477JqKLHpyyZdjb+cQn2s
         47tuCbf/pV+t7ZqY0wGNiuFT949eG3rCYuyhyd1F3WJ+K+a6FPXOKB2GtpByCFDau2NZ
         Rz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712239948; x=1712844748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rSMg4gwe2BY9lOXwY09BxCvuJ/qllvCDdUS42+hf1tc=;
        b=czu13xSPVoIPb/j+u/YqEfsUdrvlG+1FaZPZuZ8O+uoBt7o+/0CqzosxJ5Uhm+kt6C
         QJ9FFyfjsT7/Q6AHflDhu9XagX+310jCtDP0MswWyCG3lgGe1mdNwgTHDOvkOdZtN8Wi
         R8qnvzjWGxX7q7mEr4rntHYFuqJ7n+wpOWFKc8U/j1Ml4mmyksoQeKxDmwctu/6wIeJP
         QXw+A3EMjolcitLsXbkcLSpkkGQ9MNgpUMQBwMwko8tYv83EYNAw8BUyivQRIYFN5uf5
         /f5Yc6LI1m4A9F4DELluYpGNGCNJTsMDxj6s1irgufgMRtrBhxhxcBu+zmaBZeOlZonG
         +3Cw==
X-Forwarded-Encrypted: i=1; AJvYcCV0oUgic6hAQjNPGJh7nPuYEFQMvJFDJikiankXc54PAWG/PBLt68PgD1lbqmO5/BhlJfirVS93OgFfjPiP4D/BHO7MgbKfLPNnv7qq
X-Gm-Message-State: AOJu0Yy3L0vzRxGLV5z8qYp5AAwd7bv1HcC8XOWd4DcVUYCZW7aPdAwO
	y2WahDR7f2zGH3uN1ZnpIY9x1L5BcMORr25NS3ZSBjhMzxeoy7hld/xOvt/TprCxjrvhP4Y4UjX
	8qw2+hM1sFiMfufRiX9kmvdshBrQ0BBEy8WlT
X-Google-Smtp-Source: AGHT+IGq4RVA4D03SBdRY7GxklQb8jpe+sUqjCnmpf7+ITD7J/ZBEC3IIfCTpskv0hgHigC6kWxkg9Ey5RSgeDjT8hU=
X-Received: by 2002:a05:6808:11ca:b0:3c3:f471:cdb2 with SMTP id
 p10-20020a05680811ca00b003c3f471cdb2mr3016608oiv.12.1712239947283; Thu, 04
 Apr 2024 07:12:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402-linked-list-v1-0-b1c59ba7ae3b@google.com>
 <20240402-linked-list-v1-5-b1c59ba7ae3b@google.com> <d896a813-3081-40b4-985b-ef257d55cec2@proton.me>
In-Reply-To: <d896a813-3081-40b4-985b-ef257d55cec2@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 4 Apr 2024 16:12:16 +0200
Message-ID: <CAH5fLgiN3jcd_HMgmP7H-026daMw0xkMk=CGaGc9AM7uHkFXFA@mail.gmail.com>
Subject: Re: [PATCH 5/9] rust: list: add List
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

On Thu, Apr 4, 2024 at 4:03=E2=80=AFPM Benno Lossin <benno.lossin@proton.me=
> wrote:
>
> On 02.04.24 14:17, Alice Ryhl wrote:
> > Add the actual linked list itself.
> >
> > The linked list uses the following design: The List type itself just ha=
s
> > a single pointer to the first element of the list. And the actual list
> > items then form a cycle. So the last item is `first->prev`.
> >
> > This is slightly different from the usual kernel linked list. Matching
> > that exactly would amount to giving List two pointers, and having it be
> > part of the cycle of items. This alternate design has the advantage tha=
t
> > the cycle is never completely empty, which can reduce the number of
> > branches in some cases. However, it also has the disadvantage that List
> > must be pinned, which this design is trying to avoid.
> >
> > Having the list items form a cycle rather than having null pointers at
> > the beginning/end is convenient for several reasons. For one, it lets u=
s
> > store only one pointer in List, and it simplifies the implementation of
> > several functions.
> >
> > Unfortunately, the `remove` function that removes an arbitrary element
> > from the list has to be unsafe. This is needed because there is no way
> > to handle the case where you pass an element from the wrong list. For
> > example, if it is the first element of some other list, then that other
> > list's `first` pointer would not be updated. Similarly, it could be a
> > data race if you try to remove it from two different lists in parallel.
> > (There's no problem with passing `remove` an item that's not in any
> > list. Additionally, other removal methods such as `pop_front` need not
> > be unsafe, as they can't be used to remove items from another list.)
> >
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >   rust/kernel/list.rs     | 294 +++++++++++++++++++++++++++++++++++++++=
++++++++-
> >   rust/kernel/list/arc.rs |   6 +-
> >   2 files changed, 295 insertions(+), 5 deletions(-)
> >
> > diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
> > index 7af5109500f2..7e9ed802b26b 100644
> > --- a/rust/kernel/list.rs
> > +++ b/rust/kernel/list.rs
> > @@ -6,6 +6,7 @@
> >
> >   use crate::init::PinInit;
> >   use crate::types::Opaque;
> > +use core::marker::PhantomData;
> >   use core::ptr;
> >
> >   mod impl_list_item_mod;
> > @@ -16,7 +17,41 @@
> >       impl_list_arc_safe, AtomicListArcTracker, ListArc, ListArcSafe, T=
ryNewListArc,
> >   };
> >
> > -/// Implemented by types where a [`ListArc<Self>`] can be inserted int=
o a `List`.
> > +/// A linked list.
> > +///
> > +/// All elements in this linked list will be [`ListArc`] references to=
 the value. Since a value can
> > +/// only have one `ListArc` (for each pair of prev/next pointers), thi=
s ensures that the same
> > +/// prev/next pointers are not used for several linked lists.
> > +///
> > +/// # Invariants
> > +///
> > +/// If the list is empty, then `first` is null. Otherwise, it points a=
t the links field of the
> > +/// first element of this list. The prev/next pointers of items in the=
 list will always form a
> > +/// cycle. This means that prev/next pointers for an item in a list ar=
e never null and never
> > +/// dangling.
>
> I think this is missing that all elements of the list are in `ListArc`s.
>
> About "This means that prev/next pointers for an item in a list are
> never null and never dangling.", I think it would be simpler to say that
> "All prev/next pointers of items in the list are valid and form a cycle."

Sure.

> > +pub struct List<T: ?Sized + ListItem<ID>, const ID: u64 =3D 0> {
> > +    first: *mut ListLinksFields,
> > +    _ty: PhantomData<ListArc<T, ID>>,
> > +}
> > +
> > +// SAFETY: This is a container of `ListArc<T, ID>`, and access to the =
container allows the same
> > +// type of access to the `ListArc<T, ID>` elements.
> > +unsafe impl<T, const ID: u64> Send for List<T, ID>
> > +where
> > +    ListArc<T, ID>: Send,
> > +    T: ?Sized + ListItem<ID>,
> > +{
> > +}
> > +// SAFETY: This is a container of `ListArc<T, ID>`, and access to the =
container allows the same
> > +// type of access to the `ListArc<T, ID>` elements.
> > +unsafe impl<T, const ID: u64> Sync for List<T, ID>
> > +where
> > +    ListArc<T, ID>: Sync,
> > +    T: ?Sized + ListItem<ID>,
> > +{
> > +}
> > +
> > +/// Implemented by types where a [`ListArc<Self>`] can be inserted int=
o a [`List`].
> >   ///
> >   /// # Safety
> >   ///
> > @@ -56,7 +91,7 @@ pub unsafe trait ListItem<const ID: u64 =3D 0>: ListA=
rcSafe<ID> {
> >       ///   been called.
> >       unsafe fn view_value(me: *mut ListLinks<ID>) -> *const Self;
> >
> > -    /// This is called when an item is inserted into a `List`.
> > +    /// This is called when an item is inserted into a [`List`].
> >       ///
> >       /// # Guarantees
> >       ///
> > @@ -103,7 +138,6 @@ struct ListLinksFields {
> >   /// The fields are null if and only if this item is not in a list.
> >   #[repr(transparent)]
> >   pub struct ListLinks<const ID: u64 =3D 0> {
> > -    #[allow(dead_code)]
> >       inner: Opaque<ListLinksFields>,
> >   }
> >
> > @@ -125,4 +159,258 @@ pub fn new() -> impl PinInit<Self> {
> >               }),
> >           }
> >       }
> > +
> > +    /// # Safety
> > +    ///
> > +    /// The pointer must be dereferencable.
>
> I would use "`me` is valid.".

Ok.

> > +    #[inline]
> > +    unsafe fn fields(me: *mut Self) -> *mut ListLinksFields {
> > +        // SAFETY: The caller promises that the pointer is valid.
> > +        unsafe { Opaque::raw_get(ptr::addr_of!((*me).inner)) }
> > +    }
> > +
> > +    /// # Safety
> > +    ///
> > +    /// The pointer must be dereferencable.
>
> Ditto.

Ok.

> > +    #[inline]
> > +    unsafe fn from_fields(me: *mut ListLinksFields) -> *mut Self {
> > +        me.cast()
> > +    }
> > +}
> > +
> > +impl<T: ?Sized + ListItem<ID>, const ID: u64> List<T, ID> {
> > +    /// Creates a new empty list.
> > +    pub const fn new() -> Self {
> > +        Self {
> > +            first: ptr::null_mut(),
> > +            _ty: PhantomData,
> > +        }
> > +    }
> > +
> > +    /// Returns whether this list is empty.
> > +    pub fn is_empty(&self) -> bool {
> > +        self.first.is_null()
> > +    }
> > +
> > +    /// Add the provided item to the back of the list.
> > +    pub fn push_back(&mut self, item: ListArc<T, ID>) {
> > +        let item =3D unsafe { ListLinks::fields(T::prepare_to_insert(L=
istArc::into_raw(item))) };
>
> Missing SAFETY comment.

Will add one here and in push_front.

> > +
> > +        if self.first.is_null() {
> > +            self.first =3D item;
> > +            // SAFETY: The caller just gave us ownership of these fiel=
ds.
> > +            // INVARIANT: A linked list with one item should be cyclic=
.
> > +            unsafe {
> > +                (*item).next =3D item;
> > +                (*item).prev =3D item;
> > +            }
> > +        } else {
> > +            let next =3D self.first;
> > +            // SAFETY: We just checked that `next` is non-null.
>
> Missing mention of the type invariant.

SAFETY: By the type invariant, this pointer is valid or null. We just
checked that it's not null, so it must be valid.

> > +            let prev =3D unsafe { (*next).prev };
> > +            // SAFETY: Pointers in a linked list are never dangling, a=
nd the caller just gave us
> > +            // ownership of the fields on `item`.
> > +            // INVARIANT: This correctly inserts `item` between `prev`=
 and `next`.
> > +            unsafe {
> > +                (*item).next =3D next;
> > +                (*item).prev =3D prev;
> > +                (*prev).next =3D item;
> > +                (*next).prev =3D item;
> > +            }
> > +        }
> > +    }
> > +
> > +    /// Add the provided item to the front of the list.
> > +    pub fn push_front(&mut self, item: ListArc<T, ID>) {
> > +        let item =3D unsafe { ListLinks::fields(T::prepare_to_insert(L=
istArc::into_raw(item))) };
> > +
> > +        if self.first.is_null() {
> > +            // SAFETY: The caller just gave us ownership of these fiel=
ds.
> > +            // INVARIANT: A linked list with one item should be cyclic=
.
> > +            unsafe {
> > +                (*item).next =3D item;
> > +                (*item).prev =3D item;
> > +            }
> > +        } else {
> > +            let next =3D self.first;
> > +            // SAFETY: We just checked that `next` is non-null.
> > +            let prev =3D unsafe { (*next).prev };
> > +            // SAFETY: Pointers in a linked list are never dangling, a=
nd the caller just gave us
> > +            // ownership of the fields on `item`.
> > +            // INVARIANT: This correctly inserts `item` between `prev`=
 and `next`.
> > +            unsafe {
> > +                (*item).next =3D next;
> > +                (*item).prev =3D prev;
> > +                (*prev).next =3D item;
> > +                (*next).prev =3D item;
> > +            }
> > +        }
> > +        self.first =3D item;
> > +    }
> > +
> > +    /// Removes the last item from this list.
> > +    pub fn pop_back(&mut self) -> Option<ListArc<T, ID>> {
> > +        if self.first.is_null() {
> > +            return None;
> > +        }
> > +
> > +        // SAFETY: We just checked that the list is not empty.
> > +        let last =3D unsafe { (*self.first).prev };
> > +        // SAFETY: The last item of this list is in this list.
> > +        Some(unsafe { self.remove_internal(last) })
> > +    }
> > +
> > +    /// Removes the first item from this list.
> > +    pub fn pop_front(&mut self) -> Option<ListArc<T, ID>> {
> > +        if self.first.is_null() {
> > +            return None;
> > +        }
> > +
> > +        // SAFETY: The first item of this list is in this list.
> > +        Some(unsafe { self.remove_internal(self.first) })
> > +    }
> > +
> > +    /// Removes the provided item from this list and returns it.
> > +    ///
> > +    /// This returns `None` if the item is not in the list.
>
> I think this should say "Returns `None` if the item is not in a list.".
> (Technically it should be "is not in a `List<T, ID>`", since it *can* be
> in another list with a different ID.)

I'm not really convinced. The phrases "the list" and "a list" are
equivalent given the safety requirement for this method, but "the
list" seems more natural to me. The `remove` method of any other
collection would say "the list" too.

> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// The provided item must not be in a different linked list.
> > +    pub unsafe fn remove(&mut self, item: &T) -> Option<ListArc<T, ID>=
> {
> > +        let mut item =3D unsafe { ListLinks::fields(T::view_links(item=
)) };
> > +        // SAFETY: The user provided a reference, and reference are ne=
ver dangling.
> > +        //
> > +        // As for why this is not a data race, there are two cases:
> > +        //
> > +        //  * If `item` is not in any list, then these fields are read=
-only and null.
> > +        //  * If `item` is in this list, then we have exclusive access=
 to these fields since we
> > +        //    have a mutable reference to the list.
> > +        //
> > +        // In either case, there's no race.
> > +        let ListLinksFields { next, prev } =3D unsafe { *item };
> > +
> > +        debug_assert_eq!(next.is_null(), prev.is_null());
> > +        if !next.is_null() {
> > +            // This is really a no-op, but this ensures that `item` is=
 a raw pointer that was
> > +            // obtained without going through a pointer->reference->po=
inter conversion rountrip.
> > +            // This ensures that the list is valid under the more rest=
rictive strict provenance
> > +            // ruleset.
> > +            //
> > +            // SAFETY: We just checked that `next` is not null, and it=
's not dangling by the
> > +            // list invariants.
> > +            unsafe {
> > +                debug_assert_eq!(item, (*next).prev);
> > +                item =3D (*next).prev;
> > +            }
> > +
> > +            // SAFETY: We just checked that `item` is in a list, so th=
e caller guarantees that it
> > +            // is in this list. The pointers are in the right order.
> > +            Some(unsafe { self.remove_internal_inner(item, next, prev)=
 })
> > +        } else {
> > +            None
> > +        }
> > +    }
> > +
> > +    /// Removes the provided item from the list.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// The pointer must point at an item in this list.
> > +    unsafe fn remove_internal(&mut self, item: *mut ListLinksFields) -=
> ListArc<T, ID> {
> > +        // SAFETY: The caller promises that this pointer is not dangli=
ng, and there's no data race
> > +        // since we have a mutable reference to the list containing `i=
tem`.
> > +        let ListLinksFields { next, prev } =3D unsafe { *item };
> > +        // SAFETY: The pointers are ok and in the right order.
> > +        unsafe { self.remove_internal_inner(item, next, prev) }
> > +    }
> > +
> > +    /// Removes the provided item from the list.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// The `item` pointer must point at an item in this list, and we =
must have `(*item).next =3D=3D
> > +    /// next` and `(*item).prev =3D=3D prev`.
> > +    unsafe fn remove_internal_inner(
> > +        &mut self,
> > +        item: *mut ListLinksFields,
> > +        next: *mut ListLinksFields,
> > +        prev: *mut ListLinksFields,
> > +    ) -> ListArc<T, ID> {
> > +        // SAFETY: We have exclusive access to items in the list, and =
prev/next pointers are
>
> I think you mean that you have exclusive access to the prev/next fields
> of the `ListLinks` associated with `ID`... But that is rather long.
> Does anyone have any idea to shorten this?

SAFETY: We have exclusive access to the pointers of items in the list,
and the prev/next pointers are never null for items in a list.

> > +        // never null for items in a list.
> > +        //
> > +        // INVARIANT: There are three cases:
> > +        //  * If the list has at least three items, then after removin=
g the item, `prev` and `next`
> > +        //    will be next to each other.
> > +        //  * If the list has two items, then the remaining item will =
point at itself.
> > +        //  * If the list has one item, then `next =3D=3D prev =3D=3D =
item`, so these writes have no effect
> > +        //    due to the writes to `item` below.
>
> I think the writes do not have an effect. (no need to reference the
> writes to `item` below)

?

> > +        unsafe {
> > +            (*next).prev =3D prev;
> > +            (*prev).next =3D next;
> > +        }
> > +        // SAFETY: We have exclusive access to items in the list.
> > +        // INVARIANT: The item is no longer in a list, so the pointers=
 should be null.
> > +        unsafe {
> > +            (*item).prev =3D ptr::null_mut();
> > +            (*item).next =3D ptr::null_mut();
> > +        }
> > +        // INVARIANT: There are three cases:
> > +        //  * If `item` was not the first item, then `self.first` shou=
ld remain unchanged.
> > +        //  * If `item` was the first item and there is another item, =
then we just updated
> > +        //    `prev->next` to `next`, which is the new first item, and=
 setting `item->next` to null
> > +        //    did not modify `prev->next`.
> > +        //  * If `item` was the only item in the list, then `prev =3D=
=3D item`, and we just set
> > +        //    `item->next` to null, so this correctly sets `first` to =
null now that the list is
> > +        //    empty.
> > +        if self.first =3D=3D item {
> > +            // SAFETY: The `prev` field of an item in a list is never =
dangling.
>
> I don't think this SAFETY comment makes sense.
>
> > +            self.first =3D unsafe { (*prev).next };

SAFETY: `prev` is the `prev` pointer from a `ListLinks` in a `List`,
so the pointer is valid. There's no race, since we have exclusive
access to the list.

Alice

