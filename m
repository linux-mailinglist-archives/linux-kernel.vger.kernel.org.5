Return-Path: <linux-kernel+bounces-103378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5166387BEBD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D090A286274
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90C36FE1F;
	Thu, 14 Mar 2024 14:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="a3L9YKaa"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F095A10A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710425999; cv=none; b=AXiu+y3ekzirAfTGPzQWhbh5BOgj+tKThX6eM7hLVvJo4wJ/rjM2lFb3RLEWgU0pZwEarYcOcJ2PP9eYc2YgmNbcdvwgf781SddETvUn14CLheYdv0kpWqq654apsKbHUdVgVjc8F4oRBG1eKGhJg/oRiKqzYw9nB4dQBJBCHjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710425999; c=relaxed/simple;
	bh=LuhikuIpMTLZWWnbjAUwq+60FFSlEtEdPyUsiCQP0qI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e0ScWwklOcAKvLwB64vVl9u9pUEvgpM2d2o8lzOtAC/ven1BYlTG9RQvW40e5qlAAUkMDOd8M14dzmPY78/Gzhjow4lZdq6UU9ohkkjy3ydxfMRQBuuP0glkLb7EWwZrMam6t0bgkX121bSD2c/sPpb8P+5EJ7uS/CTAG6da8kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=a3L9YKaa; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=dboecjqjp5dzliq2fyj3makfpa.protonmail; t=1710425988; x=1710685188;
	bh=IyAjpIxlVB6bLlMtsplXixwUDxghJiyzTW28TTOAZLc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=a3L9YKaaG6d2AyBt+366vmBzhLZSQv3hJuCrtvXCKHy+EWtFpH3hlT11lGqETykOd
	 CIqakjlAmOWJkxPXhEasyAkt+7X04ClFE/4us8OHS7Wbv+BkkPHcoSn1CnuMF+MREj
	 ni8g3+beHGqj2VwC2AAk+zts1nlXPWPgWWp7nE4h9KFhTmUY9cPetvNU6bDHAd7kgD
	 1K9dT/euFhkaIk6s8PWjPaNvq2iHAJYng8shuVNsFaC41EPNXcKg/zp95FBZjV22dA
	 zDckeNQ99nG3KRbfVitqEnuLZYn74ZP9B+gv9Uxue3ntlMEBnN4pVJIIjYV1H0xjae
	 otPrzXdGvmrxg==
Date: Thu, 14 Mar 2024 14:19:43 +0000
To: Matt Gilbride <mattgilbride@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Rob Landley <rob@landley.net>, Davidlohr Bueso <dave@stgolabs.net>, Michel Lespinasse <michel@lespinasse.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] rust: rbtree: add red-black tree implementation backed by the C version
Message-ID: <4231ee9d-66a0-47b4-b285-3e142b142675@proton.me>
In-Reply-To: <20240219-b4-rbtree-v2-2-0b113aab330d@google.com>
References: <20240219-b4-rbtree-v2-0-0b113aab330d@google.com> <20240219-b4-rbtree-v2-2-0b113aab330d@google.com>
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
> +impl<K, V> RBTree<K, V>
> +where
> +    K: Ord,
> +{
> +    /// Tries to insert a new value into the tree.
> +    ///
> +    /// It overwrites a node if one already exists with the same key and=
 returns it (containing the
> +    /// key/value pair). Returns [`None`] if a node with the same key di=
dn't already exist.
> +    ///
> +    /// Returns an error if it cannot allocate memory for the new node.
> +    pub fn try_create_and_insert(&mut self, key: K, value: V) -> Result<=
Option<RBTreeNode<K, V>>> {
> +        Ok(self.insert(Self::try_allocate_node(key, value)?))
> +    }
> +
> +    /// Inserts a new node into the tree.
> +    ///
> +    /// It overwrites a node if one already exists with the same key and=
 returns it (containing the
> +    /// key/value pair). Returns [`None`] if a node with the same key di=
dn't already exist.
> +    ///
> +    /// This function always succeeds.
> +    pub fn insert(&mut self, node: RBTreeNode<K, V>) -> Option<RBTreeNod=
e<K, V>> {
> +        let RBTreeNode { node } =3D node;

You can do this pattern deconstruction directly in the function
signature.

> +        let node =3D Box::into_raw(node);
> +        // SAFETY: `node` is valid at least until we call `Box::from_raw=
`, which only happens when
> +        // the node is removed or replaced.
> +        let node_links =3D unsafe { addr_of_mut!((*node).links) };
> +        let mut new_link: &mut *mut bindings::rb_node =3D &mut self.root=
rb_node;

Is the only reason for this being a double pointer that `rb_link_node`
requires that as its last argument? If yes, then I would just add a
`&mut` there and give this the simpler type.

Also a more fitting name IMO would be `cur_node` or similar.

> +        let mut parent =3D core::ptr::null_mut();

I would suggest naming this `prev_node` or similar.

> +        while !new_link.is_null() {
> +            // SAFETY: All links fields we create are in a `Node<K, V>`.

Suggestion:
     // SAFETY: By the type invariant of `Self`, all non-null `rb_node` poi=
nters stored in `self`
     // point to the links field of `Node<K, V>` objects.

> +            let this =3D unsafe { crate::container_of!(*new_link, Node<K=
, V>, links) };

The `container_of` macro is used 3 times, I think it's nicer to import
it.

> +
> +            parent =3D *new_link;
> +
> +            // SAFETY: `this` is a non-null node so it is valid by the t=
ype invariants. `node` is
> +            // valid until the node is removed.
> +            match unsafe { (*node).key.cmp(&(*this).key) } {
> +                // SAFETY: `parent` is a non-null node so it is valid by=
 the type invariants.
> +                Ordering::Less =3D> new_link =3D unsafe { &mut (*parent)=
rb_left },

I would use `*new_link` instead of `parent` here.

> +                // SAFETY: `parent` is a non-null node so it is valid by=
 the type invariants.
> +                Ordering::Greater =3D> new_link =3D unsafe { &mut (*pare=
nt).rb_right },

Ditto.

> +                Ordering::Equal =3D> {
> +                    // INVARIANT: We are replacing an existing node with=
 a new one, which is valid.
> +                    // It remains valid because we "forgot" it with `Box=
::into_raw`.
> +                    // SAFETY: All pointers are non-null and valid (pare=
nt, despite the name, really
> +                    // is the node we're replacing).
> +                    unsafe { bindings::rb_replace_node(parent, node_link=
s, &mut self.root) };

If you use `*new_link` instead of `parent` (and perform the rename) then
you don't need the note in the parenthesis in the safety comment.

> +
> +                    // INVARIANT: The node is being returned and the cal=
ler may free it, however,
> +                    // it was removed from the tree. So the invariants s=
till hold.
> +                    return Some(RBTreeNode {
> +                        // SAFETY: `this` was a node in the tree, so it =
is valid.
> +                        node: unsafe { Box::from_raw(this as _) },

Why do you need this cast? Can it be replaced by `.cast()` or
`.cast_mut()`?

> +                    });
> +                }
> +            }
> +        }
> +
> +        // INVARIANT: We are linking in a new node, which is valid. It r=
emains valid because we
> +        // "forgot" it with `Box::into_raw`.
> +        // SAFETY: All pointers are non-null and valid (`*new_link` is n=
ull, but `new_link` is a
> +        // mutable reference).
> +        unsafe { bindings::rb_link_node(node_links, parent, new_link) };
> +
> +        // SAFETY: All pointers are valid. `node` has just been inserted=
 into the tree.
> +        unsafe { bindings::rb_insert_color(node_links, &mut self.root) }=
;
> +        None
> +    }
> +
> +    /// Returns a node with the given key, if one exists.
> +    fn find(&self, key: &K) -> Option<NonNull<Node<K, V>>> {
> +        let mut node =3D self.root.rb_node;
> +        while !node.is_null() {
> +            // SAFETY: All links fields we create are in a `Node<K, V>`.

See above suggestion.

> +            let this =3D unsafe { crate::container_of!(node, Node<K, V>,=
 links) };
> +            // SAFETY: `this` is a non-null node so it is valid by the t=
ype invariants.
> +            node =3D match key.cmp(unsafe { &(*this).key }) {
> +                // SAFETY: `node` is a non-null node so it is valid by t=
he type invariants.
> +                Ordering::Less =3D> unsafe { (*node).rb_left },
> +                // SAFETY: `node` is a non-null node so it is valid by t=
he type invariants.
> +                Ordering::Greater =3D> unsafe { (*node).rb_right },
> +                Ordering::Equal =3D> return NonNull::new(this as _),

Why do you need this cast? Can it be replaced by `.cast()` or
`.cast_mut()`?

> +            }
> +        }

If you modify this function to return the parent node if `key` were in
the tree, then you could use this in `insert` instead of having to write
two loops.

> +        None
> +    }
> +
> +    /// Returns a reference to the value corresponding to the key.
> +    pub fn get(&self, key: &K) -> Option<&V> {
> +        // SAFETY: The `find` return value is a node in the tree, so it =
is valid.
> +        self.find(key).map(|node| unsafe { &node.as_ref().value })
> +    }
> +
> +    /// Returns a mutable reference to the value corresponding to the ke=
y.
> +    pub fn get_mut(&mut self, key: &K) -> Option<&mut V> {
> +        // SAFETY: The `find` return value is a node in the tree, so it =
is valid.
> +        self.find(key)
> +            .map(|mut node| unsafe { &mut node.as_mut().value })
> +    }
> +
> +    /// Removes the node with the given key from the tree.
> +    ///
> +    /// It returns the node that was removed if one exists, or [`None`] =
otherwise.
> +    fn remove_node(&mut self, key: &K) -> Option<RBTreeNode<K, V>> {
> +        let mut node =3D self.find(key)?;
> +
> +        // SAFETY: The `find` return value is a node in the tree, so it =
is valid.
> +        unsafe { bindings::rb_erase(&mut node.as_mut().links, &mut self.=
root) };
> +
> +        // INVARIANT: The node is being returned and the caller may free=
 it, however, it was
> +        // removed from the tree. So the invariants still hold.
> +        Some(RBTreeNode {
> +            // SAFETY: The `find` return value was a node in the tree, s=
o it is valid.
> +            node: unsafe { Box::from_raw(node.as_ptr()) },
> +        })
> +    }
> +
> +    /// Removes the node with the given key from the tree.
> +    ///
> +    /// It returns the value that was removed if one exists, or [`None`]=
 otherwise.
> +    pub fn remove(&mut self, key: &K) -> Option<V> {
> +        let node =3D self.remove_node(key)?;
> +        let RBTreeNode { node } =3D node;
> +        let Node {
> +            links: _,
> +            key: _,
> +            value,
> +        } =3D *node;
> +        Some(value)

This could be a one-liner:
     self.remove_node(key).map(|node| node.node.value)

> +    }
> +}
> +
> +impl<K, V> Default for RBTree<K, V> {
> +    fn default() -> Self {
> +        Self::new()
> +    }
> +}
> +
> +impl<K, V> Drop for RBTree<K, V> {
> +    fn drop(&mut self) {
> +        // SAFETY: `root` is valid as it's embedded in `self` and we hav=
e a valid `self`.
> +        let mut next =3D unsafe { bindings::rb_first_postorder(&self.roo=
t) };
> +
> +        // INVARIANT: The loop invariant is that all tree nodes from `ne=
xt` in postorder are valid.
> +        while !next.is_null() {
> +            // SAFETY: All links fields we create are in a `Node<K, V>`.
> +            let this =3D unsafe { crate::container_of!(next, Node<K, V>,=
 links) };
> +
> +            // Find out what the next node is before disposing of the cu=
rrent one.
> +            // SAFETY: `next` and all nodes in postorder are still valid=
.
> +            next =3D unsafe { bindings::rb_next_postorder(next) };
> +
> +            // INVARIANT: This is the destructor, so we break the type i=
nvariant during clean-up,
> +            // but it is not observable. The loop invariant is still mai=
ntained.
> +            // SAFETY: `this` is valid per the loop invariant.
> +            unsafe { drop(Box::from_raw(this as *mut Node<K, V>)) };

Use `.cast_mut()` instead of `as ...`.

> +        }
> +    }
> +}
> +
> +/// A memory reservation for a red-black tree node.
> +///
> +/// It contains the memory needed to hold a node that can be inserted in=
to a red-black tree. One
> +/// can be obtained by directly allocating it ([`RBTree::try_reserve_nod=
e`]).
> +pub struct RBTreeNodeReservation<K, V> {
> +    node: Box<MaybeUninit<Node<K, V>>>,
> +}
> +
> +// SAFETY: An [`RBTree`] allows the same kinds of access to its values t=
hat a struct allows to its
> +// fields, so we use the same Send condition as would be used for a stru=
ct with K and V fields.
> +unsafe impl<K: Send, V: Send> Send for RBTreeNodeReservation<K, V> {}
> +
> +// SAFETY: An [`RBTree`] allows the same kinds of access to its values t=
hat a struct allows to its
> +// fields, so we use the same Sync condition as would be used for a stru=
ct with K and V fields.
> +unsafe impl<K: Sync, V: Sync> Sync for RBTreeNodeReservation<K, V> {}

The two safety comments are copy-pasted. `RBTreeNodeReservation` does not
allow any kind of access to its values.

> +
> +impl<K, V> RBTreeNodeReservation<K, V> {
> +    /// Initialises a node reservation.
> +    ///
> +    /// It then becomes an [`RBTreeNode`] that can be inserted into a tr=
ee.
> +    pub fn into_node(mut self, key: K, value: V) -> RBTreeNode<K, V> {
> +        let node_ptr =3D self.node.as_mut_ptr();
> +        // SAFETY: `node_ptr` is valid, and so are its fields.
> +        unsafe { addr_of_mut!((*node_ptr).links).write(bindings::rb_node=
::default()) };
> +        // SAFETY: `node_ptr` is valid, and so are its fields.
> +        unsafe { addr_of_mut!((*node_ptr).key).write(key) };
> +        // SAFETY: `node_ptr` is valid, and so are its fields.
> +        unsafe { addr_of_mut!((*node_ptr).value).write(value) };
> +        let raw =3D Box::into_raw(self.node);
> +        RBTreeNode {
> +            // SAFETY: The pointer came from a `MaybeUninit<Node>` whose=
 fields have all been
> +            // initialised. Additionally, it has the same layout as `Nod=
e`.
> +            node: unsafe { Box::from_raw(raw as _) },
> +        }

Instead of doing `into_raw` and `from_raw`, I would use
`Box::assume_init` (it is unstable via `new_uninit`).

> +    }
> +}
> +
> +/// A red-black tree node.
> +///
> +/// The node is fully initialised (with key and value) and can be insert=
ed into a tree without any
> +/// extra allocations or failure paths.
> +pub struct RBTreeNode<K, V> {
> +    node: Box<Node<K, V>>,
> +}
> +
> +// SAFETY: An [`RBTree`] allows the same kinds of access to its values t=
hat a struct allows to its
> +// fields, so we use the same Send condition as would be used for a stru=
ct with K and V fields.
> +unsafe impl<K: Send, V: Send> Send for RBTreeNode<K, V> {}
> +
> +// SAFETY: An [`RBTree`] allows the same kinds of access to its values t=
hat a struct allows to its
> +// fields, so we use the same Sync condition as would be used for a stru=
ct with K and V fields.
> +unsafe impl<K: Sync, V: Sync> Sync for RBTreeNode<K, V> {}

The two safety comments are copy-pasted. `RBTreeNode` does not
allow any kind of access to its values.

--=20
Cheers,
Benno

>=20
> --
> 2.44.0.rc0.258.g7320e95886-goog
>=20


