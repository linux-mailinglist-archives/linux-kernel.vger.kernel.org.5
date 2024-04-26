Return-Path: <linux-kernel+bounces-159611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AA78B3107
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04D061F220B3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAD313AD0E;
	Fri, 26 Apr 2024 07:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="h/YNJVMM"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB6542040
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 07:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714115117; cv=none; b=konnOMTZxpchJnqno5OmW7h3EZZxpcBgo1IBuPka26pwvDDbYG2C+Z1RSTwQl9f3HLKIj00oGn9O/KsonHRKfDdZ2wFODBTBAPGdFqwY2ntpZISKMl2ma1tfm8nersKSOwz5pvpfTy0E3KkbSY5nHSVxjVbWOzXjonmaH3hs4dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714115117; c=relaxed/simple;
	bh=Qe8Lqqo+ycVRs0Kho6vUc3FzJtZNIGo6l62UG5/3wQM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dz63pmkNvIeMgaXqAo7u6afuPo4K0CKp+fTHdOl7LPDdrdIifQrbWqyhN4DFLXYUAmNw3Gt8QclSsmW2egfWRIufJ5hKh0Vca6UrIoWlactiGf2QY92eqTbF/XlXopcdnVRsPHe5hslu30gF0/c8a0T77JTuui0lvJCb0RksXLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=h/YNJVMM; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1714115112; x=1714374312;
	bh=y3LYOKqrYRady6hOEaLPtSsj8+WxuMjdGo8/K8WqyFU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=h/YNJVMMU5BVlUUD80e025RXV26uIZ3rrDWUCn6cGAdYmQjoCdjtxGJpu1yidLsld
	 7+GcX8TfEtJT4xK3iaj1GT0Nyy+TubUjaYWk8MgphLK8cVRGgputQebsp3wXWjLx6Y
	 L1XWsMLxFxVrQ4eD0aCPQXtpEmRSU5qOVJZK+jcI53CHZPA4+3y4NZ0kmot6abeqH6
	 mduC0kV27tgMXEuerKoZRbEXvHH/sBfSMoRvi8gobWswIDnLwlpLwxxl6JZ3IW7hzc
	 GK8/RRZHhcGZLWWqgr2f1TrM9YJV5WpRp4i9jNfqWmjC80rQYPksmD+YDSh58iLcqE
	 /4z8t8mDHSaBg==
Date: Fri, 26 Apr 2024 07:05:07 +0000
To: Matt Gilbride <mattgilbride@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Rob Landley <rob@landley.net>, Davidlohr Bueso <dave@stgolabs.net>, Michel Lespinasse <michel@lespinasse.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] rust: rbtree: add `RBTree::entry`
Message-ID: <d243524f-96af-4375-a8c9-44196a110853@proton.me>
In-Reply-To: <20240418-b4-rbtree-v3-5-323e134390ce@google.com>
References: <20240418-b4-rbtree-v3-0-323e134390ce@google.com> <20240418-b4-rbtree-v3-5-323e134390ce@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 58ac6332e697b6c130eac39a82b67d3b8298f19a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18.04.24 16:15, Matt Gilbride wrote:
> @@ -332,63 +338,54 @@ pub fn insert(&mut self, RBTreeNode { node }: RBTre=
eNode<K, V>) -> Option<RBTree
>          // we store `parent` and `child_field_of_parent`, and the new `n=
ode` will go somewhere
>          // in the subtree of `parent` that `child_field_of_parent` point=
s at. Once
>          // we find an empty subtree, we can insert the new node using `r=
b_link_node`.
> -        let mut parent =3D core::ptr::null_mut();
>          let mut child_field_of_parent: &mut *mut bindings::rb_node =3D &=
mut self.root.rb_node;
> -        while !child_field_of_parent.is_null() {
> -            parent =3D *child_field_of_parent;
> +        let mut parent =3D core::ptr::null_mut();

Nit: why are you moving this line below `child_field_of_parent`? Just an
artifact of rebasing?

> +        while !(*child_field_of_parent).is_null() {
> +            let curr =3D *child_field_of_parent;
> +            // SAFETY: All links fields we create are in a `Node<K, V>`.
> +            let node =3D unsafe { container_of!(curr, Node<K, V>, links)=
 };

[...]

> @@ -1119,3 +1099,177 @@ unsafe impl<K: Send, V: Send> Send for RBTreeNode=
<K, V> {}
>  // SAFETY: If K and V can be accessed without synchronization, then it's=
 also okay to access
>  // [`RBTreeNode`] without synchronization.
>  unsafe impl<K: Sync, V: Sync> Sync for RBTreeNode<K, V> {}
> +
> +impl<K, V> RBTreeNode<K, V> {
> +    /// Drop the key and value, but keep the allocation.
> +    ///
> +    /// It then becomes a reservation that can be re-initialised into a =
different node (i.e., with
> +    /// a different key and/or value).
> +    ///
> +    /// The existing key and value are dropped in-place as part of this =
operation, that is, memory
> +    /// may be freed (but only for the key/value; memory for the node it=
self is kept for reuse).
> +    pub fn into_reservation(self) -> RBTreeNodeReservation<K, V> {
> +        let raw =3D Box::into_raw(self.node);
> +        let mut ret =3D RBTreeNodeReservation {
> +            // SAFETY: The pointer came from a valid `Node`, which has t=
he same layout as
> +            // `MaybeUninit<Node>`.
> +            node: unsafe { Box::from_raw(raw as _) },
> +        };
> +        // SAFETY: Although the type is `MaybeUninit<Node>`, we know it =
has been initialised
> +        // because it came from a `Node`. So it is safe to drop it.
> +        unsafe { core::ptr::drop_in_place::<Node<K, V>>(ret.node.as_mut_=
ptr()) };
> +        ret
> +    }

With my patch [1] this can be simplified.

[1]: https://lore.kernel.org/rust-for-linux/20240425213419.3904105-1-benno.=
lossin@proton.me/

> +}
> +
> +/// A view into a single entry in a map, which may either be vacant or o=
ccupied.
> +///
> +/// This enum is constructed from the [`entry`] method on [`RBTree`].

You could just write [`RBTree::entry`].

> +///
> +/// [`entry`]: fn@RBTree::entry
> +pub enum Entry<'a, K, V> {
> +    /// This [`RBTree`] does not have a node with this key.
> +    Vacant(VacantEntry<'a, K, V>),
> +    /// This [`RBTree`] already has a node with this key.
> +    Occupied(OccupiedEntry<'a, K, V>),
> +}

[...]

> +impl<'a, K, V> RawVacantEntry<'a, K, V> {
> +    /// Inserts the given node into the [`RBTree`] at this entry.
> +    ///
> +    /// The `node` must have a key such that inserting it here does not =
break the ordering of this
> +    /// [`RBTree`].
> +    fn insert(self, node: RBTreeNode<K, V>) -> &'a mut V {
> +        let node =3D Box::into_raw(node.node);
> +
> +        // SAFETY: `node` is valid at least until we call `Box::from_raw=
`, which only happens when
> +        // the node is removed or replaced.
> +        let node_links =3D unsafe { addr_of_mut!((*node).links) };
> +
> +        // INVARIANT: We are linking in a new node, which is valid. It r=
emains valid because we
> +        // "forgot" it with `Box::into_raw`.
> +        // SAFETY: All pointers are null or valid in an appropriate way.

I don't like the formulation "valid in an appropriate way", since if you
don't know what the appropriate way is, this doesn't help you.

> +        unsafe { bindings::rb_link_node(node_links, self.parent, self.ch=
ild_field_of_parent) };
> +
> +        // SAFETY: All pointers are valid. `node` has just been inserted=
 into the tree.
> +        unsafe { bindings::rb_insert_color(node_links, &mut self.rbtree.=
root) };
> +
> +        // SAFETY: The node is valid until we remove it from the tree.
> +        unsafe { &mut (*node).value }
> +    }
> +}
> +
> +impl<'a, K, V> VacantEntry<'a, K, V> {
> +    /// Inserts the given node into the [`RBTree`] at this entry.
> +    pub fn insert(self, value: V, reservation: RBTreeNodeReservation<K, =
V>) -> &'a mut V {
> +        self.raw.insert(reservation.into_node(self.key, value))
> +    }
> +}
> +
> +/// A view into an occupied entry in a [`RBTree`]. It is part of the [`E=
ntry`] enum.
> +///
> +/// # Invariants
> +/// - `node_links` is a valid, non-null pointer to a tree node.

It should be the same tree as `self.rbtree`, right? (I see you calling
`rb_replace_node` below with the rbtree root used)

--=20
Cheers,
Benno

> +pub struct OccupiedEntry<'a, K, V> {
> +    rbtree: &'a mut RBTree<K, V>,
> +    /// The node that this entry corresponds to.
> +    node_links: *mut bindings::rb_node,
> +}


