Return-Path: <linux-kernel+bounces-131549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6F089897A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DA02284425
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E9E1292CE;
	Thu,  4 Apr 2024 14:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="GYOhMcRB"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23EE1292D7
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712239435; cv=none; b=KQCD4s8ff9XBMzaWzmo06APNrcZ99aMOCiagCqZCQpdkGIHcw7v0T3dbzXj96Kmw1JIAwB6PcqixW/iGtnqjSd4WkjH3SptWoXr809uuLNXnyQTxSMBK9AXl1FKYwuWtMQqkunw0NViF7iV9unKiiJtBmTGyTBhd7P2Cjop73dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712239435; c=relaxed/simple;
	bh=gPbMYYFcNAjcrF4xRBroOPbJ01haxu2ZG/L8Pe3skq8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ge/LOE8FycpN2vIsvXGAMw8RcoA5H/yb3i4932PQAFwsEZWsAmK4XOVtAxwUwUH1sh0QX4AYNsO7UoF3veVa+FD/j5mepiv5mmkVRYzQOCV9DSve7g6ZtFWpJg4CBsj5IFAH27jUk02XBxsxVdjpWlnvfMnSYzIrtTq7gJTtZkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=GYOhMcRB; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1712239430; x=1712498630;
	bh=mxRt1JFDvTbBuOkFZH1WEcA2xwbKGdW+b1os3pnPbR4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=GYOhMcRB959RJhvXCSEh0sn/wXP5FCXKe3pdhhnCCxT/Co9qcbS4EDglfs9DhOo+Y
	 QNFT6Vhs3c/OoWu41xolRn/XM4bqibpwidIvnwM4RGKyxMWwBWtm4KMCIN7rN4VkB5
	 Tek+r211m9st10KyBmkvN0K7To4ifBGvOg7Ry7PKNv5ekDr+FrCi8ncZ1PRd24e7x7
	 XKzfmV0ytDcpR9ZD7GxG9eTbONBdLrNQgunFWJ4dlAg0fweaQRI59e94XbMaut7+Ry
	 MBIIlHMH1+QF0GJmC0GyWsn1At6EWBVr20LZ0sIZ2qHUHWuySVKMqwv22WYKbTDl9d
	 74yJD+bPFqB+w==
Date: Thu, 04 Apr 2024 14:03:43 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Kees Cook <keescook@chromium.org>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 5/9] rust: list: add List
Message-ID: <d896a813-3081-40b4-985b-ef257d55cec2@proton.me>
In-Reply-To: <20240402-linked-list-v1-5-b1c59ba7ae3b@google.com>
References: <20240402-linked-list-v1-0-b1c59ba7ae3b@google.com> <20240402-linked-list-v1-5-b1c59ba7ae3b@google.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02.04.24 14:17, Alice Ryhl wrote:
> Add the actual linked list itself.
>=20
> The linked list uses the following design: The List type itself just has
> a single pointer to the first element of the list. And the actual list
> items then form a cycle. So the last item is `first->prev`.
>=20
> This is slightly different from the usual kernel linked list. Matching
> that exactly would amount to giving List two pointers, and having it be
> part of the cycle of items. This alternate design has the advantage that
> the cycle is never completely empty, which can reduce the number of
> branches in some cases. However, it also has the disadvantage that List
> must be pinned, which this design is trying to avoid.
>=20
> Having the list items form a cycle rather than having null pointers at
> the beginning/end is convenient for several reasons. For one, it lets us
> store only one pointer in List, and it simplifies the implementation of
> several functions.
>=20
> Unfortunately, the `remove` function that removes an arbitrary element
> from the list has to be unsafe. This is needed because there is no way
> to handle the case where you pass an element from the wrong list. For
> example, if it is the first element of some other list, then that other
> list's `first` pointer would not be updated. Similarly, it could be a
> data race if you try to remove it from two different lists in parallel.
> (There's no problem with passing `remove` an item that's not in any
> list. Additionally, other removal methods such as `pop_front` need not
> be unsafe, as they can't be used to remove items from another list.)
>=20
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>   rust/kernel/list.rs     | 294 +++++++++++++++++++++++++++++++++++++++++=
++++++-
>   rust/kernel/list/arc.rs |   6 +-
>   2 files changed, 295 insertions(+), 5 deletions(-)
>=20
> diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
> index 7af5109500f2..7e9ed802b26b 100644
> --- a/rust/kernel/list.rs
> +++ b/rust/kernel/list.rs
> @@ -6,6 +6,7 @@
>=20
>   use crate::init::PinInit;
>   use crate::types::Opaque;
> +use core::marker::PhantomData;
>   use core::ptr;
>=20
>   mod impl_list_item_mod;
> @@ -16,7 +17,41 @@
>       impl_list_arc_safe, AtomicListArcTracker, ListArc, ListArcSafe, Try=
NewListArc,
>   };
>=20
> -/// Implemented by types where a [`ListArc<Self>`] can be inserted into =
a `List`.
> +/// A linked list.
> +///
> +/// All elements in this linked list will be [`ListArc`] references to t=
he value. Since a value can
> +/// only have one `ListArc` (for each pair of prev/next pointers), this =
ensures that the same
> +/// prev/next pointers are not used for several linked lists.
> +///
> +/// # Invariants
> +///
> +/// If the list is empty, then `first` is null. Otherwise, it points at =
the links field of the
> +/// first element of this list. The prev/next pointers of items in the l=
ist will always form a
> +/// cycle. This means that prev/next pointers for an item in a list are =
never null and never
> +/// dangling.

I think this is missing that all elements of the list are in `ListArc`s.

About "This means that prev/next pointers for an item in a list are
never null and never dangling.", I think it would be simpler to say that
"All prev/next pointers of items in the list are valid and form a cycle."

> +pub struct List<T: ?Sized + ListItem<ID>, const ID: u64 =3D 0> {
> +    first: *mut ListLinksFields,
> +    _ty: PhantomData<ListArc<T, ID>>,
> +}
> +
> +// SAFETY: This is a container of `ListArc<T, ID>`, and access to the co=
ntainer allows the same
> +// type of access to the `ListArc<T, ID>` elements.
> +unsafe impl<T, const ID: u64> Send for List<T, ID>
> +where
> +    ListArc<T, ID>: Send,
> +    T: ?Sized + ListItem<ID>,
> +{
> +}
> +// SAFETY: This is a container of `ListArc<T, ID>`, and access to the co=
ntainer allows the same
> +// type of access to the `ListArc<T, ID>` elements.
> +unsafe impl<T, const ID: u64> Sync for List<T, ID>
> +where
> +    ListArc<T, ID>: Sync,
> +    T: ?Sized + ListItem<ID>,
> +{
> +}
> +
> +/// Implemented by types where a [`ListArc<Self>`] can be inserted into =
a [`List`].
>   ///
>   /// # Safety
>   ///
> @@ -56,7 +91,7 @@ pub unsafe trait ListItem<const ID: u64 =3D 0>: ListArc=
Safe<ID> {
>       ///   been called.
>       unsafe fn view_value(me: *mut ListLinks<ID>) -> *const Self;
>=20
> -    /// This is called when an item is inserted into a `List`.
> +    /// This is called when an item is inserted into a [`List`].
>       ///
>       /// # Guarantees
>       ///
> @@ -103,7 +138,6 @@ struct ListLinksFields {
>   /// The fields are null if and only if this item is not in a list.
>   #[repr(transparent)]
>   pub struct ListLinks<const ID: u64 =3D 0> {
> -    #[allow(dead_code)]
>       inner: Opaque<ListLinksFields>,
>   }
>=20
> @@ -125,4 +159,258 @@ pub fn new() -> impl PinInit<Self> {
>               }),
>           }
>       }
> +
> +    /// # Safety
> +    ///
> +    /// The pointer must be dereferencable.

I would use "`me` is valid.".

> +    #[inline]
> +    unsafe fn fields(me: *mut Self) -> *mut ListLinksFields {
> +        // SAFETY: The caller promises that the pointer is valid.
> +        unsafe { Opaque::raw_get(ptr::addr_of!((*me).inner)) }
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// The pointer must be dereferencable.

Ditto.

> +    #[inline]
> +    unsafe fn from_fields(me: *mut ListLinksFields) -> *mut Self {
> +        me.cast()
> +    }
> +}
> +
> +impl<T: ?Sized + ListItem<ID>, const ID: u64> List<T, ID> {
> +    /// Creates a new empty list.
> +    pub const fn new() -> Self {
> +        Self {
> +            first: ptr::null_mut(),
> +            _ty: PhantomData,
> +        }
> +    }
> +
> +    /// Returns whether this list is empty.
> +    pub fn is_empty(&self) -> bool {
> +        self.first.is_null()
> +    }
> +
> +    /// Add the provided item to the back of the list.
> +    pub fn push_back(&mut self, item: ListArc<T, ID>) {
> +        let item =3D unsafe { ListLinks::fields(T::prepare_to_insert(Lis=
tArc::into_raw(item))) };

Missing SAFETY comment.

> +
> +        if self.first.is_null() {
> +            self.first =3D item;
> +            // SAFETY: The caller just gave us ownership of these fields=
.
> +            // INVARIANT: A linked list with one item should be cyclic.
> +            unsafe {
> +                (*item).next =3D item;
> +                (*item).prev =3D item;
> +            }
> +        } else {
> +            let next =3D self.first;
> +            // SAFETY: We just checked that `next` is non-null.

Missing mention of the type invariant.

> +            let prev =3D unsafe { (*next).prev };
> +            // SAFETY: Pointers in a linked list are never dangling, and=
 the caller just gave us
> +            // ownership of the fields on `item`.
> +            // INVARIANT: This correctly inserts `item` between `prev` a=
nd `next`.
> +            unsafe {
> +                (*item).next =3D next;
> +                (*item).prev =3D prev;
> +                (*prev).next =3D item;
> +                (*next).prev =3D item;
> +            }
> +        }
> +    }
> +
> +    /// Add the provided item to the front of the list.
> +    pub fn push_front(&mut self, item: ListArc<T, ID>) {
> +        let item =3D unsafe { ListLinks::fields(T::prepare_to_insert(Lis=
tArc::into_raw(item))) };
> +
> +        if self.first.is_null() {
> +            // SAFETY: The caller just gave us ownership of these fields=
.
> +            // INVARIANT: A linked list with one item should be cyclic.
> +            unsafe {
> +                (*item).next =3D item;
> +                (*item).prev =3D item;
> +            }
> +        } else {
> +            let next =3D self.first;
> +            // SAFETY: We just checked that `next` is non-null.
> +            let prev =3D unsafe { (*next).prev };
> +            // SAFETY: Pointers in a linked list are never dangling, and=
 the caller just gave us
> +            // ownership of the fields on `item`.
> +            // INVARIANT: This correctly inserts `item` between `prev` a=
nd `next`.
> +            unsafe {
> +                (*item).next =3D next;
> +                (*item).prev =3D prev;
> +                (*prev).next =3D item;
> +                (*next).prev =3D item;
> +            }
> +        }
> +        self.first =3D item;
> +    }
> +
> +    /// Removes the last item from this list.
> +    pub fn pop_back(&mut self) -> Option<ListArc<T, ID>> {
> +        if self.first.is_null() {
> +            return None;
> +        }
> +
> +        // SAFETY: We just checked that the list is not empty.
> +        let last =3D unsafe { (*self.first).prev };
> +        // SAFETY: The last item of this list is in this list.
> +        Some(unsafe { self.remove_internal(last) })
> +    }
> +
> +    /// Removes the first item from this list.
> +    pub fn pop_front(&mut self) -> Option<ListArc<T, ID>> {
> +        if self.first.is_null() {
> +            return None;
> +        }
> +
> +        // SAFETY: The first item of this list is in this list.
> +        Some(unsafe { self.remove_internal(self.first) })
> +    }
> +
> +    /// Removes the provided item from this list and returns it.
> +    ///
> +    /// This returns `None` if the item is not in the list.

I think this should say "Returns `None` if the item is not in a list.".
(Technically it should be "is not in a `List<T, ID>`", since it *can* be
in another list with a different ID.)

> +    ///
> +    /// # Safety
> +    ///
> +    /// The provided item must not be in a different linked list.
> +    pub unsafe fn remove(&mut self, item: &T) -> Option<ListArc<T, ID>> =
{
> +        let mut item =3D unsafe { ListLinks::fields(T::view_links(item))=
 };
> +        // SAFETY: The user provided a reference, and reference are neve=
r dangling.
> +        //
> +        // As for why this is not a data race, there are two cases:
> +        //
> +        //  * If `item` is not in any list, then these fields are read-o=
nly and null.
> +        //  * If `item` is in this list, then we have exclusive access t=
o these fields since we
> +        //    have a mutable reference to the list.
> +        //
> +        // In either case, there's no race.
> +        let ListLinksFields { next, prev } =3D unsafe { *item };
> +
> +        debug_assert_eq!(next.is_null(), prev.is_null());
> +        if !next.is_null() {
> +            // This is really a no-op, but this ensures that `item` is a=
 raw pointer that was
> +            // obtained without going through a pointer->reference->poin=
ter conversion rountrip.
> +            // This ensures that the list is valid under the more restri=
ctive strict provenance
> +            // ruleset.
> +            //
> +            // SAFETY: We just checked that `next` is not null, and it's=
 not dangling by the
> +            // list invariants.
> +            unsafe {
> +                debug_assert_eq!(item, (*next).prev);
> +                item =3D (*next).prev;
> +            }
> +
> +            // SAFETY: We just checked that `item` is in a list, so the =
caller guarantees that it
> +            // is in this list. The pointers are in the right order.
> +            Some(unsafe { self.remove_internal_inner(item, next, prev) }=
)
> +        } else {
> +            None
> +        }
> +    }
> +
> +    /// Removes the provided item from the list.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The pointer must point at an item in this list.
> +    unsafe fn remove_internal(&mut self, item: *mut ListLinksFields) -> =
ListArc<T, ID> {
> +        // SAFETY: The caller promises that this pointer is not dangling=
, and there's no data race
> +        // since we have a mutable reference to the list containing `ite=
m`.
> +        let ListLinksFields { next, prev } =3D unsafe { *item };
> +        // SAFETY: The pointers are ok and in the right order.
> +        unsafe { self.remove_internal_inner(item, next, prev) }
> +    }
> +
> +    /// Removes the provided item from the list.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The `item` pointer must point at an item in this list, and we mu=
st have `(*item).next =3D=3D
> +    /// next` and `(*item).prev =3D=3D prev`.
> +    unsafe fn remove_internal_inner(
> +        &mut self,
> +        item: *mut ListLinksFields,
> +        next: *mut ListLinksFields,
> +        prev: *mut ListLinksFields,
> +    ) -> ListArc<T, ID> {
> +        // SAFETY: We have exclusive access to items in the list, and pr=
ev/next pointers are

I think you mean that you have exclusive access to the prev/next fields
of the `ListLinks` associated with `ID`... But that is rather long.
Does anyone have any idea to shorten this?

> +        // never null for items in a list.
> +        //
> +        // INVARIANT: There are three cases:
> +        //  * If the list has at least three items, then after removing =
the item, `prev` and `next`
> +        //    will be next to each other.
> +        //  * If the list has two items, then the remaining item will po=
int at itself.
> +        //  * If the list has one item, then `next =3D=3D prev =3D=3D it=
em`, so these writes have no effect
> +        //    due to the writes to `item` below.

I think the writes do not have an effect. (no need to reference the
writes to `item` below)

> +        unsafe {
> +            (*next).prev =3D prev;
> +            (*prev).next =3D next;
> +        }
> +        // SAFETY: We have exclusive access to items in the list.
> +        // INVARIANT: The item is no longer in a list, so the pointers s=
hould be null.
> +        unsafe {
> +            (*item).prev =3D ptr::null_mut();
> +            (*item).next =3D ptr::null_mut();
> +        }
> +        // INVARIANT: There are three cases:
> +        //  * If `item` was not the first item, then `self.first` should=
 remain unchanged.
> +        //  * If `item` was the first item and there is another item, th=
en we just updated
> +        //    `prev->next` to `next`, which is the new first item, and s=
etting `item->next` to null
> +        //    did not modify `prev->next`.
> +        //  * If `item` was the only item in the list, then `prev =3D=3D=
 item`, and we just set
> +        //    `item->next` to null, so this correctly sets `first` to nu=
ll now that the list is
> +        //    empty.
> +        if self.first =3D=3D item {
> +            // SAFETY: The `prev` field of an item in a list is never da=
ngling.

I don't think this SAFETY comment makes sense.

--=20
Cheers,
Benno

> +            self.first =3D unsafe { (*prev).next };
> +        }
> +
> +        // SAFETY: We just removed a `ListArc` from the list, so we can =
turn it back into a
> +        // `ListArc`.
> +        unsafe { ListArc::from_raw(T::post_remove(ListLinks::from_fields=
(item))) }
> +    }
> +
> +    /// Moves all items from `other` into `self`.
> +    ///
> +    /// The items of `other` are added to the back of `self`, so the las=
t item of `other` becomes
> +    /// the last item of `self`.
> +    pub fn push_all_back(&mut self, other: &mut List<T, ID>) {
> +        // First, we insert the elements into `self`. At the end, we mak=
e `other` empty.
> +        if self.is_empty() {
> +            // INVARIANT: All of the elements in `other` become elements=
 of `self`.
> +            self.first =3D other.first;
> +        } else if !other.is_empty() {
> +            let other_first =3D other.first;
> +            // SAFETY: The other list is not empty, so this pointer is v=
alid.
> +            let other_last =3D unsafe { (*other_first).prev };
> +            let self_first =3D self.first;
> +            // SAFETY: The self list is not empty, so this pointer is va=
lid.
> +            let self_last =3D unsafe { (*self_first).prev };
> +
> +            // SAFETY: We have exclusive access to both lists, so we can=
 update the pointers.
> +            // INVARIANT: This correctly sets the pointers to merge both=
 lists. We do not need to
> +            // update `self.first` because the first element of `self` d=
oes not change.
> +            unsafe {
> +                (*self_first).prev =3D other_last;
> +                (*other_last).next =3D self_first;
> +                (*self_last).next =3D other_first;
> +                (*other_first).prev =3D self_last;
> +            }
> +        }
> +
> +        // INVARIANT: The other list is now empty, so update its pointer=
.
> +        other.first =3D ptr::null_mut();
> +    }
> +}
> +
> +impl<T: ?Sized + ListItem<ID>, const ID: u64> Drop for List<T, ID> {
> +    fn drop(&mut self) {
> +        while let Some(item) =3D self.pop_front() {
> +            drop(item);
> +        }
> +    }
>   }


