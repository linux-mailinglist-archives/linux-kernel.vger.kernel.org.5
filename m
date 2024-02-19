Return-Path: <linux-kernel+bounces-71242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8149685A26B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A529C1C21D2B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F932E835;
	Mon, 19 Feb 2024 11:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xQEZe4+k"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D58C2CCD6
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343320; cv=none; b=f5WsLULiZZE+r/g4nR5kb5N8+w/X+k9fhyJ05v0PocM5kl2y1od9HcXLPYiveJrk3xoQzPAP4UeROU3qK5WahsDKZyTbIqYHRCn8XiruAGaPyEQP5UqVLYbBUtp28USlRWjWVW1U5KgnvwQE1efOE2qbeHF3ygayt4K9djQZlvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343320; c=relaxed/simple;
	bh=6SR52JAdmmCs4J7JswxAXBtZzhK6mj+MtYHKlaLG4L8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bvHeMjXrzQsjO/cTlLjyuUJEE+BqJHpt2kj0O/dyjg0TwIrt06Su43VXaYE3EliUBC0sNQHPQ2lvNlQY47Y7MvcuJxQumt0G0HOZbO7Pl86xEFYrIbxUuQSOpTTbhRy5TqN3/KVU6hW4O7rfSBZQMrolinYhOdCc4gh3AFYUHRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xQEZe4+k; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b267bf11so3062801276.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 03:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708343316; x=1708948116; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KEgcT/UQTYpXxnEPnTMLLl8kAcJbkORmrTw0STIurYs=;
        b=xQEZe4+ktHQwcEcbs8D7xbad5eIMENaWWofuU0nn/fUB/o2yqFznAA0JuwspI+3Jxj
         huvGV37CDQ/5gxUZnttTNqL/921xbm59ZmJc7T2847OzY+wIhveShQavwORfl4l87CYy
         tia7PDHLCaSWXAMu8/Z0DGt/cuKqN3yOwkI4Xxc/SxJStKVwQrCtU4Y8/ySCYjQUrZj8
         EL/DFJV2xK1sQCOzbwsWyhPl/WnSZUi/u771SgbjkHScLn1ionXUEtJ1iQ4PfzI2U244
         giwLk3T4iYCxFWHLDaB6BEcGju4HfCw3D5ATJ2gBVxDKzkUMM1x/voLuH9R+sik63rFB
         zYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708343316; x=1708948116;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KEgcT/UQTYpXxnEPnTMLLl8kAcJbkORmrTw0STIurYs=;
        b=iojImM/x8ipSuco6oV2tf56FCnrwiYHRwEwjST/evh+EN/wKXeyhBHw2nluz7BDpQp
         tYX0QUe/2N+05PxE4+L6Fwcigah71YBDadH/p9t4ZGPUAg6HKYcShT8nSx3aA+rYyxIh
         UMvJubchAE9h2hvVMl+hgdCVjs4IwyaT67aHxKdxbDUSk017HCBDaNKAOfs5vqMHGRRw
         2QsfVnR3O/aY9Y7XhSgolD1XHZCp/O2N6aumxGoQhOtt1l2q5Gqj92CM5VE5cIrWJb7t
         PXyZiDdiJTect8meBT3JyBEaMxnhTGVGrvoePfIiUTU5/I8RSTQm6cb6KFH1aVIoI4+n
         7B9w==
X-Forwarded-Encrypted: i=1; AJvYcCWoS0mpOiS9PTDFqHKjpix5AhHkZvCjKd+6hRo9MCRRsQ+1l6nQQjbPpXJVD0VK/Mfzxl2XbUz9V/UVsgM0LvxIfmKukKd6FVsVqlSq
X-Gm-Message-State: AOJu0YyPpaM66OD6c5I3oXLGURHgJ8gbGdzwX84lDZLXOMzuSaU113aX
	VPZfKAUl4dLDNkDHEDv+DmOoSwHfwT7Lq/ByRdM1qUaroO/hgxdupv/KdDdsmHATykg/Kahf/KS
	BZBg8nwXakfWaQBwEdKOC/wR3MA==
X-Google-Smtp-Source: AGHT+IEzYg/H//cIZbzsBKYUHpEQtvSKBv+ln0eXuSZ4zQdwxsfE4CD/emInbPji4mLC5paB60UKqC7ucb5Uah0mTxk=
X-Received: from mattgilbride.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2ac5])
 (user=mattgilbride job=sendgmr) by 2002:a25:b18d:0:b0:dc7:82ba:ba6e with SMTP
 id h13-20020a25b18d000000b00dc782baba6emr447391ybj.7.1708343316077; Mon, 19
 Feb 2024 03:48:36 -0800 (PST)
Date: Mon, 19 Feb 2024 11:48:09 +0000
In-Reply-To: <20240219-b4-rbtree-v2-0-0b113aab330d@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240219-b4-rbtree-v2-0-0b113aab330d@google.com>
X-Mailer: b4 0.12.4
Message-ID: <20240219-b4-rbtree-v2-2-0b113aab330d@google.com>
Subject: [PATCH v2 2/6] rust: rbtree: add red-black tree implementation backed
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

From: Wedson Almeida Filho <wedsonaf@gmail.com>

The rust rbtree exposes a map-like interface over keys and values,
backed by the kernel red-black tree implementation. Values can be
inserted, deleted, and retrieved from a `RBTree` by key.

This base abstraction is used by binder to store key/value
pairs and perform lookups, for example the patch
"[PATCH RFC 03/20] rust_binder: add threading support"
in the binder RFC [1].

Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-3-08ba9197f637@google.com/ [1]
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Tested-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Matt Gilbride <mattgilbride@google.com>
---
 rust/helpers.c        |   7 +
 rust/kernel/lib.rs    |   1 +
 rust/kernel/rbtree.rs | 404 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 412 insertions(+)

diff --git a/rust/helpers.c b/rust/helpers.c
index 70e59efd92bc..56ec79e823df 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -157,6 +157,13 @@ void rust_helper_init_work_with_key(struct work_struct *work, work_func_t func,
 }
 EXPORT_SYMBOL_GPL(rust_helper_init_work_with_key);
 
+void rust_helper_rb_link_node(struct rb_node *node, struct rb_node *parent,
+			      struct rb_node **rb_link)
+{
+	rb_link_node(node, parent, rb_link);
+}
+EXPORT_SYMBOL_GPL(rust_helper_rb_link_node);
+
 /*
  * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
  * use it in contexts where Rust expects a `usize` like slice (array) indices.
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index c7963efd1318..eb84ffba1831 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -43,6 +43,7 @@
 pub mod net;
 pub mod prelude;
 pub mod print;
+pub mod rbtree;
 mod static_assert;
 #[doc(hidden)]
 pub mod std_vendor;
diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
new file mode 100644
index 000000000000..a72e9f57e660
--- /dev/null
+++ b/rust/kernel/rbtree.rs
@@ -0,0 +1,404 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Red-black trees.
+//!
+//! C header: [`include/linux/rbtree.h`](srctree/include/linux/rbtree.h)
+//!
+//! Reference: <https://www.kernel.org/doc/html/latest/core-api/rbtree.html>
+
+use crate::{bindings, error::Result, prelude::*};
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
+/// Non-null parent/children pointers stored in instances of the `rb_node` C struct are always
+/// valid, and pointing to a field of our internal representation of a node.
+///
+/// # Examples
+///
+/// In the example below we do several operations on a tree. We note that insertions may fail if
+/// the system is out of memory.
+///
+/// ```
+/// use kernel::rbtree::RBTree;
+///
+/// // Create a new tree.
+/// let mut tree = RBTree::new();
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
+/// *tree.get_mut(&30).unwrap() = 3000;
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
+/// In the example below, we first allocate a node, acquire a spinlock, then insert the node into
+/// the tree. This is useful when the insertion context does not allow sleeping, for example, when
+/// holding a spinlock.
+///
+/// ```
+/// use kernel::{rbtree::RBTree, sync::SpinLock};
+///
+/// fn insert_test(tree: &SpinLock<RBTree<u32, u32>>) -> Result {
+///     // Pre-allocate node. This may fail (as it allocates memory).
+///     let node = RBTree::try_allocate_node(10, 100)?;
+///
+///     // Insert node while holding the lock. It is guaranteed to succeed with no allocation
+///     // attempts.
+///     let mut guard = tree.lock();
+///     guard.insert(node);
+///     Ok(())
+/// }
+/// ```
+///
+/// In the example below, we reuse an existing node allocation from an element we removed.
+///
+/// ```
+/// use kernel::rbtree::RBTree;
+///
+/// // Create a new tree.
+/// let mut tree = RBTree::new();
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
+/// let existing = tree.remove_node(&30).unwrap();
+///
+/// // Check that the tree reflects the removal.
+/// {
+///     assert_eq!(tree.get(&10).unwrap(), &100);
+///     assert_eq!(tree.get(&20).unwrap(), &200);
+///     assert_eq!(tree.get(&30), None);
+/// }
+///
+/// // Turn the node into a reservation so that we can reuse it with a different key/value.
+/// let reservation = existing.into_reservation();
+///
+/// // Insert a new node into the tree, reusing the previous allocation. This is guaranteed to
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
+// SAFETY: An [`RBTree`] allows the same kinds of access to its values that a struct allows to its
+// fields, so we use the same Send condition as would be used for a struct with K and V fields.
+unsafe impl<K: Send, V: Send> Send for RBTree<K, V> {}
+
+// SAFETY: An [`RBTree`] allows the same kinds of access to its values that a struct allows to its
+// fields, so we use the same Sync condition as would be used for a struct with K and V fields.
+unsafe impl<K: Sync, V: Sync> Sync for RBTree<K, V> {}
+
+impl<K, V> RBTree<K, V> {
+    /// Creates a new and empty tree.
+    pub fn new() -> Self {
+        Self {
+            // INVARIANT: There are no nodes in the tree, so the invariant holds vacuously.
+            root: bindings::rb_root::default(),
+            _p: PhantomData,
+        }
+    }
+
+    /// Allocates memory for a node to be eventually initialised and inserted into the tree via a
+    /// call to [`RBTree::insert`].
+    pub fn try_reserve_node() -> Result<RBTreeNodeReservation<K, V>> {
+        Ok(RBTreeNodeReservation {
+            node: Box::init::<Infallible>(crate::init::uninit())?,
+        })
+    }
+
+    /// Allocates and initialises a node that can be inserted into the tree via
+    /// [`RBTree::insert`].
+    pub fn try_allocate_node(key: K, value: V) -> Result<RBTreeNode<K, V>> {
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
+    /// It overwrites a node if one already exists with the same key and returns it (containing the
+    /// key/value pair). Returns [`None`] if a node with the same key didn't already exist.
+    ///
+    /// Returns an error if it cannot allocate memory for the new node.
+    pub fn try_create_and_insert(&mut self, key: K, value: V) -> Result<Option<RBTreeNode<K, V>>> {
+        Ok(self.insert(Self::try_allocate_node(key, value)?))
+    }
+
+    /// Inserts a new node into the tree.
+    ///
+    /// It overwrites a node if one already exists with the same key and returns it (containing the
+    /// key/value pair). Returns [`None`] if a node with the same key didn't already exist.
+    ///
+    /// This function always succeeds.
+    pub fn insert(&mut self, node: RBTreeNode<K, V>) -> Option<RBTreeNode<K, V>> {
+        let RBTreeNode { node } = node;
+        let node = Box::into_raw(node);
+        // SAFETY: `node` is valid at least until we call `Box::from_raw`, which only happens when
+        // the node is removed or replaced.
+        let node_links = unsafe { addr_of_mut!((*node).links) };
+        let mut new_link: &mut *mut bindings::rb_node = &mut self.root.rb_node;
+        let mut parent = core::ptr::null_mut();
+        while !new_link.is_null() {
+            // SAFETY: All links fields we create are in a `Node<K, V>`.
+            let this = unsafe { crate::container_of!(*new_link, Node<K, V>, links) };
+
+            parent = *new_link;
+
+            // SAFETY: `this` is a non-null node so it is valid by the type invariants. `node` is
+            // valid until the node is removed.
+            match unsafe { (*node).key.cmp(&(*this).key) } {
+                // SAFETY: `parent` is a non-null node so it is valid by the type invariants.
+                Ordering::Less => new_link = unsafe { &mut (*parent).rb_left },
+                // SAFETY: `parent` is a non-null node so it is valid by the type invariants.
+                Ordering::Greater => new_link = unsafe { &mut (*parent).rb_right },
+                Ordering::Equal => {
+                    // INVARIANT: We are replacing an existing node with a new one, which is valid.
+                    // It remains valid because we "forgot" it with `Box::into_raw`.
+                    // SAFETY: All pointers are non-null and valid (parent, despite the name, really
+                    // is the node we're replacing).
+                    unsafe { bindings::rb_replace_node(parent, node_links, &mut self.root) };
+
+                    // INVARIANT: The node is being returned and the caller may free it, however,
+                    // it was removed from the tree. So the invariants still hold.
+                    return Some(RBTreeNode {
+                        // SAFETY: `this` was a node in the tree, so it is valid.
+                        node: unsafe { Box::from_raw(this as _) },
+                    });
+                }
+            }
+        }
+
+        // INVARIANT: We are linking in a new node, which is valid. It remains valid because we
+        // "forgot" it with `Box::into_raw`.
+        // SAFETY: All pointers are non-null and valid (`*new_link` is null, but `new_link` is a
+        // mutable reference).
+        unsafe { bindings::rb_link_node(node_links, parent, new_link) };
+
+        // SAFETY: All pointers are valid. `node` has just been inserted into the tree.
+        unsafe { bindings::rb_insert_color(node_links, &mut self.root) };
+        None
+    }
+
+    /// Returns a node with the given key, if one exists.
+    fn find(&self, key: &K) -> Option<NonNull<Node<K, V>>> {
+        let mut node = self.root.rb_node;
+        while !node.is_null() {
+            // SAFETY: All links fields we create are in a `Node<K, V>`.
+            let this = unsafe { crate::container_of!(node, Node<K, V>, links) };
+            // SAFETY: `this` is a non-null node so it is valid by the type invariants.
+            node = match key.cmp(unsafe { &(*this).key }) {
+                // SAFETY: `node` is a non-null node so it is valid by the type invariants.
+                Ordering::Less => unsafe { (*node).rb_left },
+                // SAFETY: `node` is a non-null node so it is valid by the type invariants.
+                Ordering::Greater => unsafe { (*node).rb_right },
+                Ordering::Equal => return NonNull::new(this as _),
+            }
+        }
+        None
+    }
+
+    /// Returns a reference to the value corresponding to the key.
+    pub fn get(&self, key: &K) -> Option<&V> {
+        // SAFETY: The `find` return value is a node in the tree, so it is valid.
+        self.find(key).map(|node| unsafe { &node.as_ref().value })
+    }
+
+    /// Returns a mutable reference to the value corresponding to the key.
+    pub fn get_mut(&mut self, key: &K) -> Option<&mut V> {
+        // SAFETY: The `find` return value is a node in the tree, so it is valid.
+        self.find(key)
+            .map(|mut node| unsafe { &mut node.as_mut().value })
+    }
+
+    /// Removes the node with the given key from the tree.
+    ///
+    /// It returns the node that was removed if one exists, or [`None`] otherwise.
+    fn remove_node(&mut self, key: &K) -> Option<RBTreeNode<K, V>> {
+        let mut node = self.find(key)?;
+
+        // SAFETY: The `find` return value is a node in the tree, so it is valid.
+        unsafe { bindings::rb_erase(&mut node.as_mut().links, &mut self.root) };
+
+        // INVARIANT: The node is being returned and the caller may free it, however, it was
+        // removed from the tree. So the invariants still hold.
+        Some(RBTreeNode {
+            // SAFETY: The `find` return value was a node in the tree, so it is valid.
+            node: unsafe { Box::from_raw(node.as_ptr()) },
+        })
+    }
+
+    /// Removes the node with the given key from the tree.
+    ///
+    /// It returns the value that was removed if one exists, or [`None`] otherwise.
+    pub fn remove(&mut self, key: &K) -> Option<V> {
+        let node = self.remove_node(key)?;
+        let RBTreeNode { node } = node;
+        let Node {
+            links: _,
+            key: _,
+            value,
+        } = *node;
+        Some(value)
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
+        // SAFETY: `root` is valid as it's embedded in `self` and we have a valid `self`.
+        let mut next = unsafe { bindings::rb_first_postorder(&self.root) };
+
+        // INVARIANT: The loop invariant is that all tree nodes from `next` in postorder are valid.
+        while !next.is_null() {
+            // SAFETY: All links fields we create are in a `Node<K, V>`.
+            let this = unsafe { crate::container_of!(next, Node<K, V>, links) };
+
+            // Find out what the next node is before disposing of the current one.
+            // SAFETY: `next` and all nodes in postorder are still valid.
+            next = unsafe { bindings::rb_next_postorder(next) };
+
+            // INVARIANT: This is the destructor, so we break the type invariant during clean-up,
+            // but it is not observable. The loop invariant is still maintained.
+            // SAFETY: `this` is valid per the loop invariant.
+            unsafe { drop(Box::from_raw(this as *mut Node<K, V>)) };
+        }
+    }
+}
+
+/// A memory reservation for a red-black tree node.
+///
+/// It contains the memory needed to hold a node that can be inserted into a red-black tree. One
+/// can be obtained by directly allocating it ([`RBTree::try_reserve_node`]).
+pub struct RBTreeNodeReservation<K, V> {
+    node: Box<MaybeUninit<Node<K, V>>>,
+}
+
+// SAFETY: An [`RBTree`] allows the same kinds of access to its values that a struct allows to its
+// fields, so we use the same Send condition as would be used for a struct with K and V fields.
+unsafe impl<K: Send, V: Send> Send for RBTreeNodeReservation<K, V> {}
+
+// SAFETY: An [`RBTree`] allows the same kinds of access to its values that a struct allows to its
+// fields, so we use the same Sync condition as would be used for a struct with K and V fields.
+unsafe impl<K: Sync, V: Sync> Sync for RBTreeNodeReservation<K, V> {}
+
+impl<K, V> RBTreeNodeReservation<K, V> {
+    /// Initialises a node reservation.
+    ///
+    /// It then becomes an [`RBTreeNode`] that can be inserted into a tree.
+    pub fn into_node(mut self, key: K, value: V) -> RBTreeNode<K, V> {
+        let node_ptr = self.node.as_mut_ptr();
+        // SAFETY: `node_ptr` is valid, and so are its fields.
+        unsafe { addr_of_mut!((*node_ptr).links).write(bindings::rb_node::default()) };
+        // SAFETY: `node_ptr` is valid, and so are its fields.
+        unsafe { addr_of_mut!((*node_ptr).key).write(key) };
+        // SAFETY: `node_ptr` is valid, and so are its fields.
+        unsafe { addr_of_mut!((*node_ptr).value).write(value) };
+        let raw = Box::into_raw(self.node);
+        RBTreeNode {
+            // SAFETY: The pointer came from a `MaybeUninit<Node>` whose fields have all been
+            // initialised. Additionally, it has the same layout as `Node`.
+            node: unsafe { Box::from_raw(raw as _) },
+        }
+    }
+}
+
+/// A red-black tree node.
+///
+/// The node is fully initialised (with key and value) and can be inserted into a tree without any
+/// extra allocations or failure paths.
+pub struct RBTreeNode<K, V> {
+    node: Box<Node<K, V>>,
+}
+
+// SAFETY: An [`RBTree`] allows the same kinds of access to its values that a struct allows to its
+// fields, so we use the same Send condition as would be used for a struct with K and V fields.
+unsafe impl<K: Send, V: Send> Send for RBTreeNode<K, V> {}
+
+// SAFETY: An [`RBTree`] allows the same kinds of access to its values that a struct allows to its
+// fields, so we use the same Sync condition as would be used for a struct with K and V fields.
+unsafe impl<K: Sync, V: Sync> Sync for RBTreeNode<K, V> {}

-- 
2.44.0.rc0.258.g7320e95886-goog


