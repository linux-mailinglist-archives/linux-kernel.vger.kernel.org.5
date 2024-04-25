Return-Path: <linux-kernel+bounces-159206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BF98B2AA5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17D24285B28
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162921553BC;
	Thu, 25 Apr 2024 21:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Kut+xywb"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25C3155734
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 21:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714080394; cv=none; b=CZpQ/yqXwbUnqWktZWqp3ZQzdri3/W6HN+GeN34/CQhzEZyZrFHEMKvKS4GASlekyackgxQw+MvAyhLibnJ7l9yIA9fN8XiKCoKRrXYmMyVFXxeNo0S8mAhXhICjJkR/oCyUpP4tGrJbO7ZbFpLJX8XRki+qzmMWFrzFfMtGzQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714080394; c=relaxed/simple;
	bh=OGJY41svwj1KsHB2NXgqa3jKEspKo9hZFX1N8pEPz5w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RDAgEZmkzfSIdzwA16aosCab5unpgUvcVImZh6PzRGJmzddI7F3KJdOX9iY7wDe0/FSnjmQBYHKVoREyBu1peFcFqCsviRo3dn3yJrYvZnONOYRE1aQ69Pjdduq5Ek7Rxh4XgRwRb/l3XRjTviLfqEL/BJAKnbVqtsH7iF8SQLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Kut+xywb; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=wywttca6drde7ebdbqx56qtb3y.protonmail; t=1714080389; x=1714339589;
	bh=/Q06pgsNCa5kGWP4sxOXcijGesvZMcptNNSOERHlzig=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Kut+xywbD7k7ruUp+Gy90oThj9UAz/gqifxOi9BgUXC7H6GqiRzqox/SvMlioPgH2
	 6xL5hWsaqLN8SzDVkE1Je0eX6oLLXxLOpmEdJWevDD9AyPLHPx4TJWOXQq6y3Okt8E
	 hP9NvfvES+ckn/GP6hDewEQBmXeVLK+4GVQB0PlkXg+isPf4REi8BQ0DOK8agfeXtY
	 wlDrxTcf/eFPFIKCS2zpZgOu2CKRPho5o7KfFChwXPgPSNjW+Verp91Od5ZMt+hhuG
	 hf+dmbD7YWD7fv4QReLorvARyelt6LX3gySzTk23sRr5LzKPlGo2WsIYT+LxCnYrKU
	 av4mQ1SEZpILQ==
Date: Thu, 25 Apr 2024 21:26:25 +0000
To: Matt Gilbride <mattgilbride@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Rob Landley <rob@landley.net>, Davidlohr Bueso <dave@stgolabs.net>, Michel Lespinasse <michel@lespinasse.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] rust: rbtree: add red-black tree implementation backed by the C version
Message-ID: <f026532f-8594-4f18-9aa5-57ad3f5bc592@proton.me>
In-Reply-To: <20240418-b4-rbtree-v3-1-323e134390ce@google.com>
References: <20240418-b4-rbtree-v3-0-323e134390ce@google.com> <20240418-b4-rbtree-v3-1-323e134390ce@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 48befda4b3564fcd9a079aaa74e9d878b90c3123
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18.04.24 16:15, Matt Gilbride wrote:
> diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
> new file mode 100644
> index 000000000000..ad406fc32d67
> --- /dev/null
> +++ b/rust/kernel/rbtree.rs
> @@ -0,0 +1,425 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Red-black trees.
> +//!
> +//! C header: [`include/linux/rbtree.h`](srctree/include/linux/rbtree.h)
> +//!
> +//! Reference: <https://www.kernel.org/doc/html/latest/core-api/rbtree.h=
tml>
> +
> +use crate::{bindings, container_of, error::Result, prelude::*};
> +use alloc::boxed::Box;
> +use core::{
> +    cmp::{Ord, Ordering},
> +    convert::Infallible,
> +    marker::PhantomData,
> +    mem::MaybeUninit,
> +    ptr::{addr_of_mut, NonNull},
> +};
> +
> +struct Node<K, V> {
> +    links: bindings::rb_node,
> +    key: K,
> +    value: V,
> +}

Personal preference: I prefer putting items that give a high-level
overview of the module to the top. I don't feel like I gain anything
from seeing the definition of the `Node` type this early.

[...]

> +impl<K, V> RBTree<K, V> {
> +    /// Creates a new and empty tree.
> +    pub fn new() -> Self {
> +        Self {
> +            // INVARIANT: There are no nodes in the tree, so the invaria=
nt holds vacuously.
> +            root: bindings::rb_root::default(),
> +            _p: PhantomData,
> +        }
> +    }
> +
> +    /// Allocates memory for a node to be eventually initialised and ins=
erted into the tree via a
> +    /// call to [`RBTree::insert`].
> +    pub fn try_reserve_node() -> Result<RBTreeNodeReservation<K, V>> {

This function creates a `RBTreeNodeReservation`, I think it would make
sense to move it to that type and just name this function `new`.

> +        Ok(RBTreeNodeReservation {
> +            node: Box::init::<Infallible>(crate::init::uninit())?,

`Box::new_uninit()` probably makes more sense here. (what you did is not
wrong, but I think the intent is better captured by `new_uninit`)

> +        })
> +    }
> +
> +    /// Allocates and initialises a node that can be inserted into the t=
ree via
> +    /// [`RBTree::insert`].
> +    pub fn try_allocate_node(key: K, value: V) -> Result<RBTreeNode<K, V=
>> {

Same with this function, I would move it to `RBTreeNode` and call it
`new`.

> +        Ok(Self::try_reserve_node()?.into_node(key, value))
> +    }
> +}
> +
> +impl<K, V> RBTree<K, V>
> +where
> +    K: Ord,

Citing the rust docs [1] on the requirements that implementations of the
`Ord` trait need to satsify:

"[...] Violating these requirements is a logic error. The behavior
resulting from a logic error is not specified, but users of the trait
must ensure that such logic errors do not result in undefined behavior.
This means that `unsafe` code **must not** rely on the correctness of
these methods."

I haven't yet fully checked this, since I would have to delve into the
C side. But I wanted to ask if you have given any thought to this issue.
In particular this means that you must not rely on `<` (or `cmp`) being
eg transitive in `unsafe` code.
 From what I have seen in this patch, I think there are no issues with
the way you use `Ord`.

[1]: https://doc.rust-lang.org/core/cmp/trait.Ord.html

> +{

[...]

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
> +        RBTreeNode {
> +            // SAFETY: The pointer came from a `MaybeUninit<Node>` whose=
 fields have all been
> +            // initialised. Additionally, it has the same layout as `Nod=
e`.
> +            node: unsafe { Box::<MaybeUninit<_>>::assume_init(self.node)=
 },
> +        }

I really dislike the verbosity of this function. Also what will ensure
that you really did initialize all fields? I think I have a way to
improve this using a new function on `Box`:

     impl<T> Box<MaybeUninit<T>> {
         fn re_init(self, init: impl Init<T, E>) -> Result<Box<T>, E>;
     }

Then you could do this instead:

     pub fn into_node(mut self, key: K, value: V) -> RBTreeNode<K, V> {
         let node =3D init!(Node {
             key,
             value,
             links: bindings::rb_node::default(),
         });
         RBTreeNode { node: self.node.re_init(node) }
     }

All the `unsafe` vanishes!

I think this is useful in general, so I am going to send a patch with
the above mentioned method. In addition to that I am also going to
extend `Box` to allow converting `Box<T> -> Box<MaybeUninit<T>>` to
simplify `into_reservation` from patch 5.

--=20
Cheers,
Benno

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
> +// SAFETY: If K and V can be sent across threads, then it's also okay to=
 send [`RBTreeNode`] across
> +// threads.
> +unsafe impl<K: Send, V: Send> Send for RBTreeNode<K, V> {}
> +
> +// SAFETY: If K and V can be accessed without synchronization, then it's=
 also okay to access
> +// [`RBTreeNode`] without synchronization.
> +unsafe impl<K: Sync, V: Sync> Sync for RBTreeNode<K, V> {}
>=20
> --
> 2.44.0.769.g3c40516874-goog
>=20


