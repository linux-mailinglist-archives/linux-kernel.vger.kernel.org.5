Return-Path: <linux-kernel+bounces-159289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 086188B2CAF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 718C61F286EA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502FC15B123;
	Thu, 25 Apr 2024 21:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="jyyf58Bg"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67F0156223
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 21:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714082299; cv=none; b=kvJ9F5Uu+zOUXAPxOdSYhj+8bXkllPi8YVGV/6ko62AKHLjtxc6CLljfQ6i4t1Azb8nnZX4aiJN9B42LdQ9uRsyYCWzcpYZzb6UFlbj9JjoLDyQv9OWb8+NRoqwRk10OWcS3grTIOdrjy5yMOc470c2B4S6MaoZqPJ8Xs/AV/+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714082299; c=relaxed/simple;
	bh=KgIjecV6C7Nk07SLdfHCvsEa6tmgp+Vm85Nrr1SnqGU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sXvHM8mQJks+BkOG7NpItmGtkctS44NwSM7ecMYxFqJB5nGEUGwtofbIzmbj8grgJQXiPqx/jPiutcYHJlw97dXh58fsZ5ClTcNC6qxSJHswwgULjx8R1Z2RiwsLWg+LJKrsxpaObpGnIUR19YvOp8cJWeR7yl6VARV1edDRUDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=jyyf58Bg; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1714082294; x=1714341494;
	bh=X4GK0qT25GBqVlUpxE1T+oiI6ffMY6kIFUz9p2N2THk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=jyyf58Bg0cq4jXXMO3vLB/DwWO+rUR1zjGnZv1baRXXTPt+jFYEx9h5pzExB0BhdK
	 CqYNx8U91c7MNF5pjVk8FnkSOScXuQGvpoolKe1qM6cAn135dEn0oPqpj1IuMCL1LB
	 EcnG5xKepZY0VcW+lb/44fOJfiiwHl16o/lcw3Apn+0bWFP37ArflQ0Mej5N7nIYpn
	 f/kZfitOMSjtotySOlibLHWwPfQTvQ61PgRrCT8Nt4nq5i4rWkqdR7RggDdjH4QzY7
	 +YxbKGU3hmHya1gnmyjxqoq2c01X7IN+lUnexp8gG2N57GewzlmzytpPD8jvG0Zbmd
	 vi5oXgaCask1w==
Date: Thu, 25 Apr 2024 21:58:09 +0000
To: Matt Gilbride <mattgilbride@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Rob Landley <rob@landley.net>, Davidlohr Bueso <dave@stgolabs.net>, Michel Lespinasse <michel@lespinasse.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] rust: rbtree: add `RBTreeIteratorMut`
Message-ID: <e48f1dd1-fbe5-4461-b4bf-87acf8c0e318@proton.me>
In-Reply-To: <20240418-b4-rbtree-v3-3-323e134390ce@google.com>
References: <20240418-b4-rbtree-v3-0-323e134390ce@google.com> <20240418-b4-rbtree-v3-3-323e134390ce@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: d84f15a7d28ce27feb45bee2c48c45d49781f864
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18.04.24 16:15, Matt Gilbride wrote:
> From: Wedson Almeida Filho <wedsonaf@gmail.com>
>=20
> Add mutable Iterator implementation (`RBTreeIteratorMut`) for `RBTree`,
> allowing iteration over (key, value) pairs in key order. Only values are
> mutable, as mutating keys implies modifying a node's position in the tree=
.
>=20
> Mutable iteration is used by the binder driver during shutdown to
> clean up the tree maintained by the "range allocator" [1].
>=20
> Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-6-08=
ba9197f637@google.com/ [1]
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Matt Gilbride <mattgilbride@google.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Tested-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/rbtree.rs | 64 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 64 insertions(+)
>=20
> diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
> index 2f836be7bdbe..50d440c9926d 100644
> --- a/rust/kernel/rbtree.rs
> +++ b/rust/kernel/rbtree.rs
> @@ -222,6 +222,15 @@ pub fn iter(&self) -> RBTreeIterator<'_, K, V> {
>          }
>      }
>=20
> +    /// Returns a mutable iterator over the tree nodes, sorted by key.
> +    pub fn iter_mut(&mut self) -> RBTreeIteratorMut<'_, K, V> {
> +        RBTreeIteratorMut {

This is missing an INVARIANT comment.

> +            _tree: PhantomData,
> +            // SAFETY: `root` is valid as it's embedded in `self` and we=
 have a valid `self`.
> +            next: unsafe { bindings::rb_first(&self.root) },
> +        }
> +    }
> +
>      /// Returns an iterator over the keys of the nodes in the tree, in s=
orted order.
>      pub fn keys(&self) -> impl Iterator<Item =3D &'_ K> {
>          self.iter().map(|(k, _)| k)
> @@ -231,6 +240,11 @@ pub fn keys(&self) -> impl Iterator<Item =3D &'_ K> =
{
>      pub fn values(&self) -> impl Iterator<Item =3D &'_ V> {
>          self.iter().map(|(_, v)| v)
>      }
> +
> +    /// Returns a mutable iterator over the values of the nodes in the t=
ree, sorted by key.
> +    pub fn values_mut(&mut self) -> impl Iterator<Item =3D &'_ mut V> {
> +        self.iter_mut().map(|(_, v)| v)
> +    }
>  }
>=20
>  impl<K, V> RBTree<K, V>
> @@ -466,6 +480,56 @@ fn next(&mut self) -> Option<Self::Item> {
>      }
>  }
>=20
> +impl<'a, K, V> IntoIterator for &'a mut RBTree<K, V> {
> +    type Item =3D (&'a K, &'a mut V);
> +    type IntoIter =3D RBTreeIteratorMut<'a, K, V>;
> +
> +    fn into_iter(self) -> Self::IntoIter {
> +        self.iter_mut()
> +    }
> +}
> +
> +/// A mutable iterator over the nodes of a [`RBTree`].
> +///
> +/// Instances are created by calling [`RBTree::iter_mut`].
> +///
> +/// # Invariants
> +/// - `self.next` is a valid pointer.
> +/// - `self.next` points to a node stored inside of a valid `RBTree`.
> +pub struct RBTreeIteratorMut<'a, K, V> {

I think the names `Iter` and `IterMut` are more natural. That is what
the collections in `std::collections` do. These are in the module
`rbtree`, so you can refer to them as `rbtree::Iter`.

> +    _tree: PhantomData<&'a RBTree<K, V>>,

This should have the type `PhantomData<&'a mut RBTree<K, V>>`.

> +    next: *mut bindings::rb_node,
> +}

You could create a common iterator type, since both `RBTreeIterator` and
`RBTreeIteratorMut` are very similar.

How about a (private) `RawIter`:

     struct RawIter<K, V> {
         next: *mut bindings::rb_node,
         _phantom: PhantomData<fn() -> (K, V)>,
     }

And implement `Iterator` with `Item =3D (*mut K, *mut V)` for `RawIter`.

Then you can change `Iter` to be:

pub struct Iter<'a, K, V> {
     raw_iter: RawIter<K, V>,
     _tree: PhantomData<&'a RBTree<K, V>>,
}

--=20
Cheers,
Benno

> +
> +// SAFETY: The [`RBTreeIterator`] gives out mutable references to K and =
V, so it has the same
> +// thread safety requirements as mutable references.
> +unsafe impl<'a, K: Send, V: Send> Send for RBTreeIteratorMut<'a, K, V> {=
}
> +
> +// SAFETY: The [`RBTreeIterator`] gives out mutable references to K and =
V, so it has the same
> +// thread safety requirements as mutable references.
> +unsafe impl<'a, K: Sync, V: Sync> Sync for RBTreeIteratorMut<'a, K, V> {=
}
> +
> +impl<'a, K, V> Iterator for RBTreeIteratorMut<'a, K, V> {
> +    type Item =3D (&'a K, &'a mut V);
> +
> +    fn next(&mut self) -> Option<Self::Item> {
> +        if self.next.is_null() {
> +            return None;
> +        }
> +
> +        // SAFETY: By the type invariant of `Self`, all non-null `rb_nod=
e` pointers stored in `self`
> +        // point to the links field of `Node<K, V>` objects.
> +        let cur =3D unsafe { container_of!(self.next, Node<K, V>, links)=
 }.cast_mut();
> +
> +        // SAFETY: `self.next` is a valid tree node by the type invarian=
ts.
> +        self.next =3D unsafe { bindings::rb_next(self.next) };
> +
> +        // SAFETY: By the same reasoning above, it is safe to dereferenc=
e the node. Additionally,
> +        // it is ok to return a reference to members because the iterato=
r must outlive it.
> +        Some(unsafe { (&(*cur).key, &mut (*cur).value) })
> +    }
> +}
> +
>  /// A memory reservation for a red-black tree node.
>  ///
>  /// It contains the memory needed to hold a node that can be inserted in=
to a red-black tree. One
>=20
> --
> 2.44.0.769.g3c40516874-goog
>=20



