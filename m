Return-Path: <linux-kernel+bounces-103611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FD687C1E8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E5A51C20F33
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFB374432;
	Thu, 14 Mar 2024 17:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="b/AI9dTO"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27505DF53;
	Thu, 14 Mar 2024 17:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710436424; cv=none; b=T3tJytxeLeqyLt25pJhKK7MhhJ8sBmdzIMS+1RF5qJztW7OI5zJrIdE2RTkZRnTkM9iuZ25VlYWWwpAeRhUKICwC+a9s6v4wlKzBrppTMWvoUwYoTabWLv4AcDUJ59kzEjwn/AdXIPlowhDZFYPbKwMPBOeVyIrfKCaryjtyP0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710436424; c=relaxed/simple;
	bh=hMBd9er7HVbhxDbEsis1HtAr5PExcx5Zy2nDNPsUFiQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EUVNPq3LFpLPTZEUiGoTAps7VLNaND3mph+h0G73RSdhtALWtA2p5CfszMOEL5MktbkKOROzfGXO6STMJyar+AXuWbqbKOuh5swjOVIfz59qI7vF9HL1lResfHrxH23ktA6pe8pazOq1Z0OIiNrzu/ZjQK3Q+S8eR6EX7jK3uFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=b/AI9dTO; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1710436418; x=1710695618;
	bh=TgCp8KkgPsnDNo355xestkQOzN3oWKXMxFSOF/7Vm4w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=b/AI9dTOXoKaZIyeOvQApzX0aCXcm8WJa6ybvG+5MwTf2lF7tA09iF+/RApQpQad9
	 q85aTTbnBU2JK0h63y8m5G79ErLpaZ67UoFA8kqJJuw5Tec6PaFcLcOfWQPy2GSZxy
	 rw9O59bJYiJMoNUtUob0rPjvHvg9hVKWjPYZyqZUFVlb1TtTtWNGPi66rlYl2AZeK7
	 iInZzNAjHPQsa+5MbbiOeNuuJrKTvhox2WgzdG+n9+h8tDaRLVhMjKxY+cRW3yriBf
	 sGEysGaA9Cakw4HLve7odrJj/SEnGf6eCJbjBcy/RHs1eCsnk6lcfuzDVW2SkCz7b9
	 2KyWBq8eboSsw==
Date: Thu, 14 Mar 2024 17:13:26 +0000
To: Matt Gilbride <mattgilbride@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Rob Landley <rob@landley.net>, Davidlohr Bueso <dave@stgolabs.net>, Michel Lespinasse <michel@lespinasse.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] rust: rbtree: add `RBTreeCursor`
Message-ID: <ebc7d46f-80f9-4663-a08a-2796758afe10@proton.me>
In-Reply-To: <20240219-b4-rbtree-v2-5-0b113aab330d@google.com>
References: <20240219-b4-rbtree-v2-0-0b113aab330d@google.com> <20240219-b4-rbtree-v2-5-0b113aab330d@google.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/19/24 12:48, Matt Gilbride wrote:
> Add a cursor interface to `RBTree`, supporting the following use cases:
> - Inspect the current node pointed to by the cursor, inspect/move to
>    it's neighbors in sort order (bidirectionally).
> - Mutate the tree itself by removing the current node pointed to by the
>    cursor, or one of its neighbors.
>=20
> Add functions to obtain a cursor to the tree by key:
> - The node with the smallest key
> - The node with the largest key
> - The node matching the given key, or the one with the next larger key
>=20
> The cursor abstraction is needed by the binder driver to efficiently
> search for nodes and (conditionally) modify them, as well as their
> neighbors [1].
>=20
> Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-6-08=
ba9197f637@google.com/ [1]
> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Tested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Matt Gilbride <mattgilbride@google.com>
> ---
>   rust/kernel/rbtree.rs | 512 +++++++++++++++++++++++++++++++++++++++++++=
+++++++
>   1 file changed, 512 insertions(+)
>=20
> diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
> index ccf74e0dc3ec..6c3b10e46517 100644
> --- a/rust/kernel/rbtree.rs
> +++ b/rust/kernel/rbtree.rs
> @@ -245,6 +245,36 @@ pub fn values(&self) -> impl Iterator<Item =3D &'_ V=
> {
>       pub fn values_mut(&mut self) -> impl Iterator<Item =3D &'_ mut V> {
>           self.iter_mut().map(|(_, v)| v)
>       }
> +
> +    /// Returns a cursor over the tree nodes, starting with the smallest=
 key.
> +    pub fn cursor_front(&mut self) -> Option<RBTreeCursor<'_, K, V>> {
> +        let root =3D addr_of_mut!(self.root);
> +        // SAFETY: `self.root` is always a valid root node
> +        let current =3D unsafe { bindings::rb_first(root) };
> +        if current.is_null() {
> +            return None;
> +        }
> +        Some(RBTreeCursor {

Missing INVARIANT comment.

> +            _tree: PhantomData,
> +            root,
> +            current,
> +        })
> +    }
> +
> +    /// Returns a cursor over the tree nodes, starting with the largest =
key.
> +    pub fn cursor_back(&mut self) -> Option<RBTreeCursor<'_, K, V>> {
> +        let root =3D addr_of_mut!(self.root);
> +        // SAFETY: `self.root` is always a valid root node
> +        let current =3D unsafe { bindings::rb_last(root) };
> +        if current.is_null() {
> +            return None;
> +        }
> +        Some(RBTreeCursor {

Ditto.

> +            _tree: PhantomData,
> +            root,
> +            current,
> +        })
> +    }
>   }
>=20
>   impl<K, V> RBTree<K, V>
> @@ -377,6 +407,59 @@ pub fn remove(&mut self, key: &K) -> Option<V> {
>           } =3D *node;
>           Some(value)
>       }
> +
> +    /// Returns a cursor over the tree nodes based on the given key.
> +    ///
> +    /// If the given key exists, the cursor starts there.
> +    /// Otherwise it starts with the first larger key in sort order.
> +    /// If there is no larger key, it returns [`None`].
> +    pub fn cursor_lower_bound(&mut self, key: &K) -> Option<RBTreeCursor=
<'_, K, V>>
> +    where
> +        K: Ord,
> +    {
> +        let mut node =3D self.root.rb_node;
> +        let mut best_match: Option<NonNull<Node<K, V>>> =3D None;
> +        while !node.is_null() {
> +            // SAFETY: All links fields we create are in a `Node<K, V>`.
> +            let this =3D unsafe { crate::container_of!(node, Node<K, V>,=
 links) }.cast_mut();
> +            // SAFETY: `this` is a non-null node so it is valid by the t=
ype invariants.
> +            let this_key =3D unsafe { &(*this).key };
> +            // SAFETY: `node` is a non-null node so it is valid by the t=
ype invariants.
> +            let left_child =3D unsafe { (*node).rb_left };
> +            // SAFETY: `node` is a non-null node so it is valid by the t=
ype invariants.
> +            let right_child =3D unsafe { (*node).rb_right };
> +            if key =3D=3D this_key {
> +                return Some(RBTreeCursor {

Ditto.

> +                    _tree: PhantomData,
> +                    root: addr_of_mut!(self.root),
> +                    current: node,
> +                });
> +            } else {
> +                node =3D if key > this_key {
> +                    right_child
> +                } else {
> +                    let is_better_match =3D match best_match {
> +                        None =3D> true,
> +                        Some(best) =3D> {
> +                            // SAFETY: `best` is a non-null node so it i=
s valid by the type invariants.
> +                            let best_key =3D unsafe { &(*best.as_ptr()).=
key };
> +                            best_key > this_key
> +                        }
> +                    };
> +                    if is_better_match {
> +                        best_match =3D NonNull::new(this);
> +                    }
> +                    left_child
> +                }
> +            };
> +        }
> +        best_match.map(|best| RBTreeCursor {

Ditto.

> +            _tree: PhantomData,
> +            root: addr_of_mut!(self.root),
> +            // SAFETY: `best` is a non-null node so it is valid by the t=
ype invariants.
> +            current: unsafe { addr_of_mut!((*best.as_ptr()).links) },
> +        })
> +    }
>   }
>=20
>   impl<K, V> Default for RBTree<K, V> {
> @@ -407,6 +490,435 @@ fn drop(&mut self) {
>       }
>   }
>=20
> +/// A bidirectional cursor over the tree nodes, sorted by key.
> +///
> +/// # Invariants
> +///
> +/// In instance of `RBTreeCursor` is only acquired from [`RBTree`].
> +/// A reference to the tree used to create the cursor outlives the curso=
r, so
> +/// the tree cannot change. By the tree invariant, all nodes are valid.

Make the invariant mention the fields directly:
- `root` and `current` are valid pointers
- `root` points to the `root` node of an [`RBTree`]
- `current` points to a node that is in the same [`RBTree`] that `root` is =
pointing to

> +///
> +/// # Examples

[...]

> +pub struct RBTreeCursor<'a, K, V> {
> +    _tree: PhantomData<&'a RBTree<K, V>>,
> +    root: *mut bindings::rb_root,
> +    current: *mut bindings::rb_node,
> +}
> +
> +// SAFETY: An [`RBTree`] allows the same kinds of access to its values t=
hat a struct allows to its
> +// fields, so we use the same Send condition as would be used for a stru=
ct with K and V fields.
> +unsafe impl<'a, K: Send, V: Send> Send for RBTreeCursor<'a, K, V> {}
> +
> +// SAFETY: An [`RBTree`] allows the same kinds of access to its values t=
hat a struct allows to its
> +// fields, so we use the same Sync condition as would be used for a stru=
ct with K and V fields.
> +unsafe impl<'a, K: Sync, V: Sync> Sync for RBTreeCursor<'a, K, V> {}
> +
> +impl<'a, K, V> RBTreeCursor<'a, K, V> {
> +    /// The current node
> +    pub fn current(&self) -> (&K, &V) {
> +        Self::to_key_value(self.current)
> +    }
> +
> +    /// The current node, with a mutable value
> +    pub fn current_mut(&mut self) -> (&K, &mut V) {
> +        Self::to_key_value_mut(self.current)
> +    }
> +
> +    /// Remove the current node from the tree.
> +    ///
> +    /// Returns a cursor to the next node, if it exists,
> +    /// else the previous node. Returns [`None`] if the tree
> +    /// becomes empty.
> +    pub fn remove_current(mut self) -> Option<Self> {
> +        let prev =3D self.get_neighbor_raw(Direction::Prev);
> +        let next =3D self.get_neighbor_raw(Direction::Next);
> +        // SAFETY: All links fields we create are in a `Node<K, V>`.

This safety comment should be updated like the ones in the earlier
patches.

> +        let this =3D unsafe { crate::container_of!(self.current, Node<K,=
 V>, links) }.cast_mut();
> +        // SAFETY: The reference to the tree used to create the cursor o=
utlives the cursor, so
> +        // the tree cannot change. By the tree invariant, all nodes are =
valid.
> +        unsafe { bindings::rb_erase(&mut (*this).links, self.root) };
> +
> +        let current =3D match (prev, next) {
> +            (_, Some(next)) =3D> next,
> +            (Some(prev), None) =3D> prev,
> +            (None, None) =3D> {
> +                return None;
> +            }
> +        };
> +
> +        Some(Self {

Missing INVARIANT comment.

> +            current,
> +            _tree: self._tree,
> +            root: self.root,
> +        })
> +    }
> +
> +    /// Remove the previous node, returning it if it exists.
> +    pub fn remove_prev(&mut self) -> Option<(K, V)> {
> +        self.remove_neighbor(Direction::Prev)
> +    }
> +
> +    /// Remove the next node, returning it if it exists.
> +    pub fn remove_next(&mut self) -> Option<(K, V)> {
> +        self.remove_neighbor(Direction::Next)
> +    }
> +
> +    fn remove_neighbor(&mut self, direction: Direction) -> Option<(K, V)=
> {
> +        if let Some(neighbor) =3D self.get_neighbor_raw(direction) {
> +            // SAFETY: All links fields we create are in a `Node<K, V>`.
> +            let this =3D unsafe { crate::container_of!(neighbor, Node<K,=
 V>, links) }.cast_mut();
> +            // SAFETY: The reference to the tree used to create the curs=
or outlives the cursor, so
> +            // the tree cannot change. By the tree invariant, all nodes =
are valid.
> +            unsafe { bindings::rb_erase(&mut (*this).links, self.root) }=
;
> +            return Some(Self::to_key_value_owned(neighbor));
> +        }
> +        None
> +    }
> +
> +    /// Move the cursor to the previous node, returning [`None`] if it d=
oesn't exist.
> +    pub fn move_prev(self) -> Option<Self> {
> +        self.mv(Direction::Prev)
> +    }
> +
> +    /// Move the cursor to the next node, returning [`None`] if it doesn=
't exist.
> +    pub fn move_next(self) -> Option<Self> {
> +        self.mv(Direction::Next)
> +    }
> +
> +    fn mv(mut self, direction: Direction) -> Option<Self> {
> +        self.get_neighbor_raw(direction).map(|neighbor| Self {

Ditto.

> +            _tree: self._tree,
> +            root: self.root,
> +            current: neighbor,
> +        })
> +    }

[...]

> +    fn peek_mut(&mut self, direction: Direction) -> Option<(&K, &mut V)>=
 {
> +        // SAFETY: `self.current` is valid by the type invariants.
> +        let neighbor =3D unsafe {
> +            match direction {
> +                Direction::Prev =3D> bindings::rb_prev(self.current),
> +                Direction::Next =3D> bindings::rb_next(self.current),
> +            }
> +        };
> +
> +        if neighbor.is_null() {
> +            return None;
> +        }

Why not use `get_neighbor_raw` here?

> +
> +        Some(Self::to_key_value_mut(neighbor))
> +    }
> +
> +    fn get_neighbor_raw(&mut self, direction: Direction) -> Option<*mut =
bindings::rb_node> {
> +        // SAFETY: `self.current` is valid by the type invariants.
> +        let neighbor =3D unsafe {
> +            match direction {
> +                Direction::Prev =3D> bindings::rb_prev(self.current),
> +                Direction::Next =3D> bindings::rb_next(self.current),
> +            }
> +        };
> +
> +        if neighbor.is_null() {
> +            return None;
> +        }
> +
> +        Some(neighbor)
> +    }
> +
> +    // This internal method should *only* be called with a valid pointer=
 to a node.
> +    fn to_key_value(node: *mut bindings::rb_node) -> (&'a K, &'a V) {
> +        // SAFETY: All links fields we create are in a `Node<K, V>`.
> +        let this =3D unsafe { crate::container_of!(node, Node<K, V>, lin=
ks) };
> +        // SAFETY: The passed `node` is the current node or a non-null n=
eighbor,
> +        // thus `this` is valid by the type invariants.
> +        let k =3D unsafe { &(*this).key };
> +        // SAFETY: The passed `node` is the current node or a non-null n=
eighbor,
> +        // thus `this` is valid by the type invariants.
> +        let v =3D unsafe { &(*this).value };
> +        (k, v)
> +    }
> +
> +    // This internal method should *only* be called with a valid pointer=
 to a node.
> +    fn to_key_value_mut(node: *mut bindings::rb_node) -> (&'a K, &'a mut=
 V) {
> +        // SAFETY: All links fields we create are in a `Node<K, V>`.
> +        let this =3D unsafe { crate::container_of!(node, Node<K, V>, lin=
ks) }.cast_mut();
> +        // SAFETY: The passed `node` is the current node or a non-null n=
eighbor,
> +        // thus `this` is valid by the type invariants.
> +        let k =3D unsafe { &(*this).key };
> +        // SAFETY: The passed `node` is the current node or a non-null n=
eighbor,
> +        // thus `this` is valid by the type invariants.
> +        let v =3D unsafe { &mut (*this).value };
> +        (k, v)
> +    }
> +
> +    // This internal method should *only* be called with a valid pointer=
 to a node *that is being removed*.
> +    fn to_key_value_owned(node: *mut bindings::rb_node) -> (K, V) {
> +        // SAFETY: All links fields we create are in a `Node<K, V>`.
> +        let this =3D unsafe { crate::container_of!(node, Node<K, V>, lin=
ks) }.cast_mut();
> +        // SAFETY: The passed `node` is the current node or a non-null n=
eighbor,
> +        // thus `this` is valid by the type invariants.
> +        let n =3D unsafe { Box::from_raw(this) };
> +
> +        (n.key, n.value)
> +    }

These internal methods should be `unsafe` and have a Safety section.

--=20
Cheers,
Benno

> +}
> +
> +/// Direction for [`RBTreeCursor`] operations.
> +enum Direction {
> +    /// the node immediately before, in sort order
> +    Prev,
> +    /// the node immediately after, in sort order
> +    Next,
> +}
> +
>   impl<'a, K, V> IntoIterator for &'a RBTree<K, V> {
>       type Item =3D (&'a K, &'a V);
>       type IntoIter =3D RBTreeIterator<'a, K, V>;
>=20
> --
> 2.44.0.rc0.258.g7320e95886-goog
>=20


