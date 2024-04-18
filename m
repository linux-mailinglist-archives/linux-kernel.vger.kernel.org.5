Return-Path: <linux-kernel+bounces-150261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D55CF8A9C70
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04CE71C223A0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAD916C848;
	Thu, 18 Apr 2024 14:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hqEIAZEf"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BC1165FC0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 14:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713449749; cv=none; b=jCx8Iue3YMYZMr8Ng+9B2kPiM1Q8oQN7uHOwvOaA5XYFMxlsyQTWZofNmhalgk2NG67gA5qPwjP1kpFBdRbBE5mZR+hKIoPY82Vu22+20g0Fg7xY7Qr9LYG12WaCzB/gaoVvbgaZ8CQLNiMrOlofDoovb9gQWsd+EEqVeFbTwMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713449749; c=relaxed/simple;
	bh=EjUmhh/XAjdOym0vde7GxRRVrlYFD0ZaR6ktZMI7b2c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dWW/wM3vBocCRftKz08P3IcuQGvZLhAEHetH49xtB3/lH52Cw83nyV+TlwAEaNd543oWdxoSjj5fVDYUY8KrFzENuUBCfjlxT632SJ3VkR6ekK62z3tgDX0KaPF5lm/mCf3bGu4W3n3jYw+ph9zN/ay8LtT+ru/dxZDv8hPPVSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hqEIAZEf; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de45d510553so1667621276.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 07:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713449745; x=1714054545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LlkpRFTbaemMrnIz07RQs/UA3pKBFGJRC9rRKw5phD0=;
        b=hqEIAZEf/BQgytG0CjcMIuU/Sm7pcildj265QUI5JBsjpKJOKbQKBhk11LWbqsuNyJ
         jsYmFhItrm861f4lf7YQWKVJ0a8g9upubMMM6/hv27JRfT7zqSidFemTByP+IBmyctZH
         5fcmhzvbimFoZGoVnhoq2KLNUcbzyzdS52nJUYDN2ADqbuZdMQUePVQnsdcpsiWImnnj
         hUGIbtxK5IMqkcoJ3rBdtLKEOsbkH/ltjRvr4Z1zN6Hq3AxcGNNZ46My4DaBnR6xMaHT
         WT6LCGTqhPAzjXc+hjEwz1vHlzR+HsFOli0+lZHqznnsTKqf7WbvLc4fA9hzsUCEWFHc
         ZgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713449745; x=1714054545;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LlkpRFTbaemMrnIz07RQs/UA3pKBFGJRC9rRKw5phD0=;
        b=liqf3ZFml1T2dQPhuclR3bCzdYev5Y/maCLXjM+V2FD1XPNBtHHBdmxHms8Yk8GwYr
         yyaj0gjAz/yyOMYRVEAvdOy3bunHx8w+G+QH9CAoYJM5LqHG3xDWo2Y1X54OhUFcLPP4
         ujMhnqYp7uuHSl2lNOkXpvU+W5cfDJoi2kYGlPBRNewFBH/X1yQJ6N9QU0MJBCOSxjJ0
         lxyGdYoKuQa10En7/XmGs90FiEySmmQG7bCBD1SfiAZXkvKN87ZiceQs/p+O6Sx2OB4z
         KHKZcShgAwWC40Jah3EJ0/jZic85CcLSg1+AtCQ0lgcJh9AEgHY4w16uWUFa6nTNzlMI
         WPCA==
X-Forwarded-Encrypted: i=1; AJvYcCWDQb+f2s6IB8i8VukIyBPeJ0rN2+UsIMIbMX18DmqQLllO1OwafMGdr7u1dYTdTs/iKQqIQjg+T6NTLNF7Z0hX8kuUxdOUCvXLrzqb
X-Gm-Message-State: AOJu0Yz+Pe2Vnj1S4/mcA7n+9iDG741WOI0/NCqRshq4HJXn/E4sUI7m
	Kvnc0FC3/HVkl3zycwZNZYphS6Qy1axo+H/mkTuR+9SZzTqX3sdAHo9UJpYNoPncBJG1CpC1Hgp
	uAAGdpbcR+qFOIw4fmwqeYgEO9Q==
X-Google-Smtp-Source: AGHT+IFx3fMIlaRXQ2cmpOSDfgRjMKyJ0uyo1Rd1C8FdVYdfO/moAkvr/rX/WVvEv1OveCTHjUnhSCh49yHljsQnss4=
X-Received: from mattgilbride.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2ac5])
 (user=mattgilbride job=sendgmr) by 2002:a05:6902:18d3:b0:de4:78d9:ccf6 with
 SMTP id ck19-20020a05690218d300b00de478d9ccf6mr51818ybb.0.1713449744893; Thu,
 18 Apr 2024 07:15:44 -0700 (PDT)
Date: Thu, 18 Apr 2024 14:15:40 +0000
In-Reply-To: <20240418-b4-rbtree-v3-0-323e134390ce@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418-b4-rbtree-v3-0-323e134390ce@google.com>
X-Mailer: b4 0.12.4
Message-ID: <20240418-b4-rbtree-v3-1-323e134390ce@google.com>
Subject: [PATCH v3 1/5] rust: rbtree: add red-black tree implementation backed
 by the C version
From: Matt Gilbride <mattgilbride@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>
Cc: Rob Landley <rob@landley.net>, Davidlohr Bueso <dave@stgolabs.net>, 
	Michel Lespinasse <michel@lespinasse.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Matt Gilbride <mattgilbride@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

From: Wedson Almeida Filho <wedsonaf@gmail.com>

The rust rbtree exposes a map-like interface over keys and values,
backed by the kernel red-black tree implementation. Values can be
inserted, deleted, and retrieved from a `RBTree` by key.

This base abstraction is used by binder to store key/value
pairs and perform lookups, for example the patch
"[PATCH RFC 03/20] rust_binder: add threading support"
in the binder RFC [1].

Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-3-08ba=
9197f637@google.com/ [1]
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Tested-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Matt Gilbride <mattgilbride@google.com>
---
 rust/helpers.c        |   7 +
 rust/kernel/lib.rs    |   1 +
 rust/kernel/rbtree.rs | 425 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 433 insertions(+)

diff --git a/rust/helpers.c b/rust/helpers.c
index 70e59efd92bc..56ec79e823df 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -157,6 +157,13 @@ void rust_helper_init_work_with_key(struct work_struct=
 *work, work_func_t func,
 }
 EXPORT_SYMBOL_GPL(rust_helper_init_work_with_key);
=20
+void rust_helper_rb_link_node(struct rb_node *node, struct rb_node *parent=
,
+			      struct rb_node **rb_link)
+{
+	rb_link_node(node, parent, rb_link);
+}
+EXPORT_SYMBOL_GPL(rust_helper_rb_link_node);
+
 /*
  * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
  * use it in contexts where Rust expects a `usize` like slice (array) indi=
ces.
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index be68d5e567b1..297065a63684 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -41,6 +41,7 @@
 pub mod net;
 pub mod prelude;
 pub mod print;
+pub mod rbtree;
 mod static_assert;
 #[doc(hidden)]
 pub mod std_vendor;
diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
new file mode 100644
index 000000000000..ad406fc32d67
--- /dev/null
+++ b/rust/kernel/rbtree.rs
@@ -0,0 +1,425 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Red-black trees.
+//!
+//! C header: [`include/linux/rbtree.h`](srctree/include/linux/rbtree.h)
+//!
+//! Reference: <https://www.kernel.org/doc/html/latest/core-api/rbtree.htm=
l>
+
+use crate::{bindings, container_of, error::Result, prelude::*};
+use alloc::boxed::Box;
+use core::{
+    cmp::{Ord, Ordering},
+    convert::Infallible,
+    marker::PhantomData,
+    mem::MaybeUninit,
+    ptr::{addr_of_mut, NonNull},
+};
+
+struct Node<K, V> {
+    links: bindings::rb_node,
+    key: K,
+    value: V,
+}
+
+/// A red-black tree with owned nodes.
+///
+/// It is backed by the kernel C red-black trees.
+///
+/// # Invariants
+///
+/// Non-null parent/children pointers stored in instances of the `rb_node`=
 C struct are always
+/// valid, and pointing to a field of our internal representation of a nod=
e.
+///
+/// # Examples
+///
+/// In the example below we do several operations on a tree. We note that =
insertions may fail if
+/// the system is out of memory.
+///
+/// ```
+/// use kernel::rbtree::RBTree;
+///
+/// // Create a new tree.
+/// let mut tree =3D RBTree::new();
+///
+/// // Insert three elements.
+/// tree.try_create_and_insert(20, 200)?;
+/// tree.try_create_and_insert(10, 100)?;
+/// tree.try_create_and_insert(30, 300)?;
+///
+/// // Check the nodes we just inserted.
+/// {
+///     assert_eq!(tree.get(&10).unwrap(), &100);
+///     assert_eq!(tree.get(&20).unwrap(), &200);
+///     assert_eq!(tree.get(&30).unwrap(), &300);
+/// }
+///
+/// // Replace one of the elements.
+/// tree.try_create_and_insert(10, 1000)?;
+///
+/// // Check that the tree reflects the replacement.
+/// {
+///     assert_eq!(tree.get(&10).unwrap(), &1000);
+///     assert_eq!(tree.get(&20).unwrap(), &200);
+///     assert_eq!(tree.get(&30).unwrap(), &300);
+/// }
+///
+/// // Change the value of one of the elements.
+/// *tree.get_mut(&30).unwrap() =3D 3000;
+///
+/// // Check that the tree reflects the update.
+/// {
+///     assert_eq!(tree.get(&10).unwrap(), &1000);
+///     assert_eq!(tree.get(&20).unwrap(), &200);
+///     assert_eq!(tree.get(&30).unwrap(), &3000);
+/// }
+///
+/// // Remove an element.
+/// tree.remove(&10);
+///
+/// // Check that the tree reflects the removal.
+/// {
+///     assert_eq!(tree.get(&10), None);
+///     assert_eq!(tree.get(&20).unwrap(), &200);
+///     assert_eq!(tree.get(&30).unwrap(), &3000);
+/// }
+///
+/// # Ok::<(), Error>(())
+/// ```
+///
+/// In the example below, we first allocate a node, acquire a spinlock, th=
en insert the node into
+/// the tree. This is useful when the insertion context does not allow sle=
eping, for example, when
+/// holding a spinlock.
+///
+/// ```
+/// use kernel::{rbtree::RBTree, sync::SpinLock};
+///
+/// fn insert_test(tree: &SpinLock<RBTree<u32, u32>>) -> Result {
+///     // Pre-allocate node. This may fail (as it allocates memory).
+///     let node =3D RBTree::try_allocate_node(10, 100)?;
+///
+///     // Insert node while holding the lock. It is guaranteed to succeed=
 with no allocation
+///     // attempts.
+///     let mut guard =3D tree.lock();
+///     guard.insert(node);
+///     Ok(())
+/// }
+/// ```
+///
+/// In the example below, we reuse an existing node allocation from an ele=
ment we removed.
+///
+/// ```
+/// use kernel::rbtree::RBTree;
+///
+/// // Create a new tree.
+/// let mut tree =3D RBTree::new();
+///
+/// // Insert three elements.
+/// tree.try_create_and_insert(20, 200)?;
+/// tree.try_create_and_insert(10, 100)?;
+/// tree.try_create_and_insert(30, 300)?;
+///
+/// // Check the nodes we just inserted.
+/// {
+///     assert_eq!(tree.get(&10).unwrap(), &100);
+///     assert_eq!(tree.get(&20).unwrap(), &200);
+///     assert_eq!(tree.get(&30).unwrap(), &300);
+/// }
+///
+/// // Remove a node, getting back ownership of it.
+/// let existing =3D tree.remove(&30).unwrap();
+///
+/// // Check that the tree reflects the removal.
+/// {
+///     assert_eq!(tree.get(&10).unwrap(), &100);
+///     assert_eq!(tree.get(&20).unwrap(), &200);
+///     assert_eq!(tree.get(&30), None);
+/// }
+///
+/// // Create a preallocated reservation that we can re-use later.
+/// let reservation =3D RBTree::try_reserve_node()?;
+///
+/// // Insert a new node into the tree, reusing the previous allocation. T=
his is guaranteed to
+/// // succeed (no memory allocations).
+/// tree.insert(reservation.into_node(15, 150));
+///
+/// // Check that the tree reflect the new insertion.
+/// {
+///     assert_eq!(tree.get(&10).unwrap(), &100);
+///     assert_eq!(tree.get(&15).unwrap(), &150);
+///     assert_eq!(tree.get(&20).unwrap(), &200);
+/// }
+///
+/// # Ok::<(), Error>(())
+/// ```
+pub struct RBTree<K, V> {
+    root: bindings::rb_root,
+    _p: PhantomData<Node<K, V>>,
+}
+
+// SAFETY: An [`RBTree`] allows the same kinds of access to its values tha=
t a struct allows to its
+// fields, so we use the same Send condition as would be used for a struct=
 with K and V fields.
+unsafe impl<K: Send, V: Send> Send for RBTree<K, V> {}
+
+// SAFETY: An [`RBTree`] allows the same kinds of access to its values tha=
t a struct allows to its
+// fields, so we use the same Sync condition as would be used for a struct=
 with K and V fields.
+unsafe impl<K: Sync, V: Sync> Sync for RBTree<K, V> {}
+
+impl<K, V> RBTree<K, V> {
+    /// Creates a new and empty tree.
+    pub fn new() -> Self {
+        Self {
+            // INVARIANT: There are no nodes in the tree, so the invariant=
 holds vacuously.
+            root: bindings::rb_root::default(),
+            _p: PhantomData,
+        }
+    }
+
+    /// Allocates memory for a node to be eventually initialised and inser=
ted into the tree via a
+    /// call to [`RBTree::insert`].
+    pub fn try_reserve_node() -> Result<RBTreeNodeReservation<K, V>> {
+        Ok(RBTreeNodeReservation {
+            node: Box::init::<Infallible>(crate::init::uninit())?,
+        })
+    }
+
+    /// Allocates and initialises a node that can be inserted into the tre=
e via
+    /// [`RBTree::insert`].
+    pub fn try_allocate_node(key: K, value: V) -> Result<RBTreeNode<K, V>>=
 {
+        Ok(Self::try_reserve_node()?.into_node(key, value))
+    }
+}
+
+impl<K, V> RBTree<K, V>
+where
+    K: Ord,
+{
+    /// Tries to insert a new value into the tree.
+    ///
+    /// It overwrites a node if one already exists with the same key and r=
eturns it (containing the
+    /// key/value pair). Returns [`None`] if a node with the same key didn=
't already exist.
+    ///
+    /// Returns an error if it cannot allocate memory for the new node.
+    pub fn try_create_and_insert(&mut self, key: K, value: V) -> Result<Op=
tion<RBTreeNode<K, V>>> {
+        Ok(self.insert(Self::try_allocate_node(key, value)?))
+    }
+
+    /// Inserts a new node into the tree.
+    ///
+    /// It overwrites a node if one already exists with the same key and r=
eturns it (containing the
+    /// key/value pair). Returns [`None`] if a node with the same key didn=
't already exist.
+    ///
+    /// This function always succeeds.
+    pub fn insert(&mut self, RBTreeNode { node }: RBTreeNode<K, V>) -> Opt=
ion<RBTreeNode<K, V>> {
+        let node =3D Box::into_raw(node);
+        // SAFETY: `node` is valid at least until we call `Box::from_raw`,=
 which only happens when
+        // the node is removed or replaced.
+        let node_links =3D unsafe { addr_of_mut!((*node).links) };
+
+        // The parameters of `rb_link_node` are as follows:
+        // - `node`: A pointer to an uninitialized node being inserted.
+        // - `parent`: A pointer to an existing node in the tree. One of i=
ts child pointers must be
+        //          null, and `node` will become a child of `parent` by re=
placing that child pointer
+        //          with a pointer to `node`.
+        // - `rb_link`: A pointer to either the left-child or right-child =
field of `parent`. This
+        //          specifies which child of `parent` should hold `node` a=
fter this call. The
+        //          value of `*rb_link` must be null before the call to `r=
b_link_node`. If the
+        //          red/black tree is empty, then it=E2=80=99s also possib=
le for `parent` to be null. In
+        //          this case, `rb_link` is a pointer to the `root` field =
of the red/black tree.
+        //
+        // We will traverse the tree looking for a node that has a null po=
inter as its child,
+        // representing an empty subtree where we can insert our new node.=
 We need to make sure
+        // that we preserve the ordering of the nodes in the tree. In each=
 iteration of the loop
+        // we store `parent` and `child_field_of_parent`, and the new `nod=
e` will go somewhere
+        // in the subtree of `parent` that `child_field_of_parent` points =
at. Once
+        // we find an empty subtree, we can insert the new node using `rb_=
link_node`.
+        let mut parent =3D core::ptr::null_mut();
+        let mut child_field_of_parent: &mut *mut bindings::rb_node =3D &mu=
t self.root.rb_node;
+        while !child_field_of_parent.is_null() {
+            parent =3D *child_field_of_parent;
+
+            // We need to determine whether `node` should be the left or r=
ight child of `parent`,
+            // so we will compare with the `key` field of `parent` a.k.a. =
`this` below.
+            //
+            // SAFETY: By the type invariant of `Self`, all non-null `rb_n=
ode` pointers stored in `self`
+            // point to the links field of `Node<K, V>` objects.
+            let this =3D unsafe { container_of!(parent, Node<K, V>, links)=
 };
+
+            // SAFETY: `this` is a non-null node so it is valid by the typ=
e invariants. `node` is
+            // valid until the node is removed.
+            match unsafe { (*node).key.cmp(&(*this).key) } {
+                // We would like `node` to be the left child of `parent`. =
 Move to this child to check
+                // whether we can use it, or continue searching, at the ne=
xt iteration.
+                //
+                // SAFETY: `parent` is a non-null node so it is valid by t=
he type invariants.
+                Ordering::Less =3D> child_field_of_parent =3D unsafe { &mu=
t (*parent).rb_left },
+                // We would like `node` to be the right child of `parent`.=
  Move to this child to check
+                // whether we can use it, or continue searching, at the ne=
xt iteration.
+                //
+                // SAFETY: `parent` is a non-null node so it is valid by t=
he type invariants.
+                Ordering::Greater =3D> child_field_of_parent =3D unsafe { =
&mut (*parent).rb_right },
+                Ordering::Equal =3D> {
+                    // There is an existing node in the tree with this key=
, and that node is
+                    // parent.  Thus, we are replacing parent with a new n=
ode.
+                    //
+                    // INVARIANT: We are replacing an existing node with a=
 new one, which is valid.
+                    // It remains valid because we "forgot" it with `Box::=
into_raw`.
+                    // SAFETY: All pointers are non-null and valid.
+                    unsafe { bindings::rb_replace_node(parent, node_links,=
 &mut self.root) };
+
+                    // INVARIANT: The node is being returned and the calle=
r may free it, however,
+                    // it was removed from the tree. So the invariants sti=
ll hold.
+                    return Some(RBTreeNode {
+                        // SAFETY: `this` was a node in the tree, so it is=
 valid.
+                        node: unsafe { Box::from_raw(this.cast_mut()) },
+                    });
+                }
+            }
+        }
+
+        // INVARIANT: We are linking in a new node, which is valid. It rem=
ains valid because we
+        // "forgot" it with `Box::into_raw`.
+        // SAFETY: All pointers are non-null and valid (`*next_child` is n=
ull, but `next_child` is a
+        // mutable reference).
+        unsafe { bindings::rb_link_node(node_links, parent, child_field_of=
_parent) };
+
+        // SAFETY: All pointers are valid. `node` has just been inserted i=
nto the tree.
+        unsafe { bindings::rb_insert_color(node_links, &mut self.root) };
+        None
+    }
+
+    /// Returns a node with the given key, if one exists.
+    fn find(&self, key: &K) -> Option<NonNull<Node<K, V>>> {
+        let mut node =3D self.root.rb_node;
+        while !node.is_null() {
+            // SAFETY: By the type invariant of `Self`, all non-null `rb_n=
ode` pointers stored in `self`
+            // point to the links field of `Node<K, V>` objects.
+            let this =3D unsafe { container_of!(node, Node<K, V>, links) }=
;
+            // SAFETY: `this` is a non-null node so it is valid by the typ=
e invariants.
+            node =3D match key.cmp(unsafe { &(*this).key }) {
+                // SAFETY: `node` is a non-null node so it is valid by the=
 type invariants.
+                Ordering::Less =3D> unsafe { (*node).rb_left },
+                // SAFETY: `node` is a non-null node so it is valid by the=
 type invariants.
+                Ordering::Greater =3D> unsafe { (*node).rb_right },
+                Ordering::Equal =3D> return NonNull::new(this.cast_mut()),
+            }
+        }
+        None
+    }
+
+    /// Returns a reference to the value corresponding to the key.
+    pub fn get(&self, key: &K) -> Option<&V> {
+        // SAFETY: The `find` return value is a node in the tree, so it is=
 valid.
+        self.find(key).map(|node| unsafe { &node.as_ref().value })
+    }
+
+    /// Returns a mutable reference to the value corresponding to the key.
+    pub fn get_mut(&mut self, key: &K) -> Option<&mut V> {
+        // SAFETY: The `find` return value is a node in the tree, so it is=
 valid.
+        self.find(key)
+            .map(|mut node| unsafe { &mut node.as_mut().value })
+    }
+
+    /// Removes the node with the given key from the tree.
+    ///
+    /// It returns the node that was removed if one exists, or [`None`] ot=
herwise.
+    fn remove_node(&mut self, key: &K) -> Option<RBTreeNode<K, V>> {
+        let mut node =3D self.find(key)?;
+
+        // SAFETY: The `find` return value is a node in the tree, so it is=
 valid.
+        unsafe { bindings::rb_erase(&mut node.as_mut().links, &mut self.ro=
ot) };
+
+        // INVARIANT: The node is being returned and the caller may free i=
t, however, it was
+        // removed from the tree. So the invariants still hold.
+        Some(RBTreeNode {
+            // SAFETY: The `find` return value was a node in the tree, so =
it is valid.
+            node: unsafe { Box::from_raw(node.as_ptr()) },
+        })
+    }
+
+    /// Removes the node with the given key from the tree.
+    ///
+    /// It returns the value that was removed if one exists, or [`None`] o=
therwise.
+    pub fn remove(&mut self, key: &K) -> Option<V> {
+        self.remove_node(key).map(|node| node.node.value)
+    }
+}
+
+impl<K, V> Default for RBTree<K, V> {
+    fn default() -> Self {
+        Self::new()
+    }
+}
+
+impl<K, V> Drop for RBTree<K, V> {
+    fn drop(&mut self) {
+        // SAFETY: `root` is valid as it's embedded in `self` and we have =
a valid `self`.
+        let mut next =3D unsafe { bindings::rb_first_postorder(&self.root)=
 };
+
+        // INVARIANT: The loop invariant is that all tree nodes from `next=
` in postorder are valid.
+        while !next.is_null() {
+            // SAFETY: All links fields we create are in a `Node<K, V>`.
+            let this =3D unsafe { container_of!(next, Node<K, V>, links) }=
;
+
+            // Find out what the next node is before disposing of the curr=
ent one.
+            // SAFETY: `next` and all nodes in postorder are still valid.
+            next =3D unsafe { bindings::rb_next_postorder(next) };
+
+            // INVARIANT: This is the destructor, so we break the type inv=
ariant during clean-up,
+            // but it is not observable. The loop invariant is still maint=
ained.
+            // SAFETY: `this` is valid per the loop invariant.
+            unsafe { drop(Box::from_raw(this.cast_mut())) };
+        }
+    }
+}
+
+/// A memory reservation for a red-black tree node.
+///
+/// It contains the memory needed to hold a node that can be inserted into=
 a red-black tree. One
+/// can be obtained by directly allocating it ([`RBTree::try_reserve_node`=
]).
+pub struct RBTreeNodeReservation<K, V> {
+    node: Box<MaybeUninit<Node<K, V>>>,
+}
+
+// SAFETY: This doesn't actually contain K or V, and is just a memory allo=
cation. Those can always
+// be moved across threads.
+unsafe impl<K, V> Send for RBTreeNodeReservation<K, V> {}
+
+// SAFETY: This doesn't actually contain K or V, and is just a memory allo=
cation.
+unsafe impl<K, V> Sync for RBTreeNodeReservation<K, V> {}
+
+impl<K, V> RBTreeNodeReservation<K, V> {
+    /// Initialises a node reservation.
+    ///
+    /// It then becomes an [`RBTreeNode`] that can be inserted into a tree=
.
+    pub fn into_node(mut self, key: K, value: V) -> RBTreeNode<K, V> {
+        let node_ptr =3D self.node.as_mut_ptr();
+        // SAFETY: `node_ptr` is valid, and so are its fields.
+        unsafe { addr_of_mut!((*node_ptr).links).write(bindings::rb_node::=
default()) };
+        // SAFETY: `node_ptr` is valid, and so are its fields.
+        unsafe { addr_of_mut!((*node_ptr).key).write(key) };
+        // SAFETY: `node_ptr` is valid, and so are its fields.
+        unsafe { addr_of_mut!((*node_ptr).value).write(value) };
+        RBTreeNode {
+            // SAFETY: The pointer came from a `MaybeUninit<Node>` whose f=
ields have all been
+            // initialised. Additionally, it has the same layout as `Node`=
.
+            node: unsafe { Box::<MaybeUninit<_>>::assume_init(self.node) }=
,
+        }
+    }
+}
+
+/// A red-black tree node.
+///
+/// The node is fully initialised (with key and value) and can be inserted=
 into a tree without any
+/// extra allocations or failure paths.
+pub struct RBTreeNode<K, V> {
+    node: Box<Node<K, V>>,
+}
+
+// SAFETY: If K and V can be sent across threads, then it's also okay to s=
end [`RBTreeNode`] across
+// threads.
+unsafe impl<K: Send, V: Send> Send for RBTreeNode<K, V> {}
+
+// SAFETY: If K and V can be accessed without synchronization, then it's a=
lso okay to access
+// [`RBTreeNode`] without synchronization.
+unsafe impl<K: Sync, V: Sync> Sync for RBTreeNode<K, V> {}

--=20
2.44.0.769.g3c40516874-goog


