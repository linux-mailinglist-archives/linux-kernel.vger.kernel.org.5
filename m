Return-Path: <linux-kernel+bounces-52954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44841849EC8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 287A6B21960
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96923482C9;
	Mon,  5 Feb 2024 15:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ECodOzTp"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5794B4595A
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707148214; cv=none; b=n/zPCrs0uMqNvipqSR7pZeUc0APT3VtOBYVi8ZyfmRtI4ZT+jo9kAX4UWxcdXj2Xx+/g8fgfv8p4vRqst9nDAqqj1KFYUKW2xh9J4+gtnzqiv30Bo7VrK1fEr6PDf4Q/J25Yw2XiRXXRQOw3c39MUfpGsiFgLAA1qvobSyM/SMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707148214; c=relaxed/simple;
	bh=fEdkpQRAKxcK+Vq+Ej5tRRpaejTCMjdLRVmNroqCOfw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gm68aH6pQrwxRzEC0OY3p+FytD2fhvGLJNnoJzMW+et0sMRiST/n0wKikUl3ekXrMWo8eyPrF3JUITUNjaHsDnkYOuIyx4f78kCHdnwyDPU351rk3iqLQFUNo2mg4NZvzX3GDyK5UUAxKyU9qglYhGyFQWGC3wImQraLXnGSeiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ECodOzTp; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6041bb56dbfso62798797b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 07:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707148210; x=1707753010; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JtORM6z3n6Nx7zIdzVBRR85gUfsLFA4+3fHETUbUVdg=;
        b=ECodOzTpDLuiK1B/JxpKMoBWzzAohfjIZoTaPXbUaFquLe4BQ2TSTgBw4puALcHz6P
         OhUgsUxh3ApkCDy5hngMt117MZld7tUKkbsoIVV8HB/UkCDws2rifg9SjeEMyovtqJkU
         Xow/+San3+ysBIYScMFujk7zV5o539QJiLFf8zsI3GLg0JUC4rq36MJDnWr5O7ZZwC5N
         Kz/pLltL2Qn59v8K3zg9tyn6E3V1K2YF0QUjZobPOXecbGLVAYMYhsT2mOafh3gvqb19
         mM4KkF8Dhc+NGxSVjezDq/v1UIGPaD8vZTQ8G7uw1mi9A7a8bXzuikUmJ/lwG/96tvr6
         ajEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707148210; x=1707753010;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JtORM6z3n6Nx7zIdzVBRR85gUfsLFA4+3fHETUbUVdg=;
        b=jHGb5oq2q3TUGVr0VIZBP3FBJy+9u5F70V2McPIIsjvFFJZEVJMQOZeAn/adiZAnWP
         meYgLvJQNOJTXB05sKhELaKz9iid+q7xIyDzLxmI1lUSp0/BgdgPGZE6E8YsD/dnLBb7
         MlNcAYiRZKlGZLeyb75WLX54tCreMZfOUVXuUI2AlG4L0XLDIWXrv82hSyNLUsvNojpr
         3geRMXq52qx15R24nltjZ8F1XThGIDjwVQ04PCuzDuhtKopplVHqqEfkZpknlx5bKa7Q
         yB0I1/umOyXXHm9S3IpU+CChHbvceHZR1RiPTMSbmWc6+Qm+VoCgEfTWbCtXTOajx7L7
         mTjg==
X-Gm-Message-State: AOJu0YyXIOX5PLfBSt2NlyJhYi9CtydzK7xiRsTx6kVrI/Y7QOueqaEg
	x+638pjWyX37JicaPA0X/ysuVcoc8q0LEniQGuMzA2SQcucOMNt53dzP5aMhFwtBKlvuH33aAQ5
	Wv/i8AVwHL3JqIcrV3UmKyye/zA==
X-Google-Smtp-Source: AGHT+IEnEzg36o2wODfPotcfBiZl9rChq+AHl88nPPHI6AibfHOM9IDUYQiwQyQs1syRA3Qg9H3P3oAC99qmsmsUrB0=
X-Received: from mattgilbride.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2ac5])
 (user=mattgilbride job=sendgmr) by 2002:a25:b183:0:b0:dc6:ebd4:cca2 with SMTP
 id h3-20020a25b183000000b00dc6ebd4cca2mr327456ybj.11.1707148210290; Mon, 05
 Feb 2024 07:50:10 -0800 (PST)
Date: Mon, 05 Feb 2024 15:50:05 +0000
In-Reply-To: <20240205-b4-rbtree-v1-0-995e3eee38c0@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240205-b4-rbtree-v1-0-995e3eee38c0@google.com>
X-Mailer: b4 0.12.3
Message-ID: <20240205-b4-rbtree-v1-5-995e3eee38c0@google.com>
Subject: [PATCH 5/6] rust: rbtree: add `RBTreeCursor`
From: mattgilbride@google.com
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

Add a cursor interface to `RBTree`, supporting the following use cases:
- Inspect the current node pointed to by the cursor, inspect/move to
  it's neighbors in sort order (bidirectionally).
- Mutate the tree itself by removing the current node pointed to by the
  cursor, or one of its neighbors.

Add functions to obtain a cursor to the tree by key:
- The node with the smallest key
- The node with the largest key
- The node matching the given key, or the one with the next larger key

The cursor abstraction is needed by the binder driver to efficiently
search for nodes and (conditionally) modify them, as well as their
neighbors [1].

Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-6-08ba9197f637@google.com/ [1]
Co-developed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Matt Gilbride <mattgilbride@google.com>
---
 rust/kernel/rbtree.rs | 512 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 512 insertions(+)

diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
index db17734b3fa1..0db6a584a9fc 100644
--- a/rust/kernel/rbtree.rs
+++ b/rust/kernel/rbtree.rs
@@ -244,6 +244,36 @@ pub fn values(&self) -> impl Iterator<Item = &'_ V> {
     pub fn values_mut(&mut self) -> impl Iterator<Item = &'_ mut V> {
         self.iter_mut().map(|(_, v)| v)
     }
+
+    /// Returns a cursor over the tree nodes, starting with the smallest key.
+    pub fn cursor_front(&mut self) -> Option<RBTreeCursor<'_, K, V>> {
+        let root = addr_of_mut!(self.root);
+        // SAFETY: `self.root` is always a valid root node
+        let current = unsafe { bindings::rb_first(root) };
+        if current.is_null() {
+            return None;
+        }
+        Some(RBTreeCursor {
+            _tree: PhantomData,
+            root,
+            current,
+        })
+    }
+
+    /// Returns a cursor over the tree nodes, starting with the largest key.
+    pub fn cursor_back(&mut self) -> Option<RBTreeCursor<'_, K, V>> {
+        let root = addr_of_mut!(self.root);
+        // SAFETY: `self.root` is always a valid root node
+        let current = unsafe { bindings::rb_last(root) };
+        if current.is_null() {
+            return None;
+        }
+        Some(RBTreeCursor {
+            _tree: PhantomData,
+            root,
+            current,
+        })
+    }
 }
 
 impl<K, V> RBTree<K, V>
@@ -376,6 +406,59 @@ pub fn remove(&mut self, key: &K) -> Option<V> {
         } = *node;
         Some(value)
     }
+
+    /// Returns a cursor over the tree nodes based on the given key.
+    ///
+    /// If the given key exists, the cursor starts there.
+    /// Otherwise it starts with the first larger key in sort order.
+    /// If there is no larger key, it returns [`None`].
+    pub fn cursor_lower_bound(&mut self, key: &K) -> Option<RBTreeCursor<'_, K, V>>
+    where
+        K: Ord,
+    {
+        let mut node = self.root.rb_node;
+        let mut best_match: Option<NonNull<Node<K, V>>> = None;
+        while !node.is_null() {
+            // SAFETY: All links fields we create are in a `Node<K, V>`.
+            let this = unsafe { crate::container_of!(node, Node<K, V>, links) }.cast_mut();
+            // SAFETY: `this` is a non-null node so it is valid by the type invariants.
+            let this_key = unsafe { &(*this).key };
+            // SAFETY: `node` is a non-null node so it is valid by the type invariants.
+            let left_child = unsafe { (*node).rb_left };
+            // SAFETY: `node` is a non-null node so it is valid by the type invariants.
+            let right_child = unsafe { (*node).rb_right };
+            if key == this_key {
+                return Some(RBTreeCursor {
+                    _tree: PhantomData,
+                    root: addr_of_mut!(self.root),
+                    current: node,
+                });
+            } else {
+                node = if key > this_key {
+                    right_child
+                } else {
+                    let is_better_match = match best_match {
+                        None => true,
+                        Some(best) => {
+                            // SAFETY: `best` is a non-null node so it is valid by the type invariants.
+                            let best_key = unsafe { &(*best.as_ptr()).key };
+                            best_key > this_key
+                        }
+                    };
+                    if is_better_match {
+                        best_match = NonNull::new(this);
+                    }
+                    left_child
+                }
+            };
+        }
+        best_match.map(|best| RBTreeCursor {
+            _tree: PhantomData,
+            root: addr_of_mut!(self.root),
+            // SAFETY: `best` is a non-null node so it is valid by the type invariants.
+            current: unsafe { addr_of_mut!((*best.as_ptr()).links) },
+        })
+    }
 }
 
 impl<K, V> Default for RBTree<K, V> {
@@ -406,6 +489,435 @@ fn drop(&mut self) {
     }
 }
 
+/// A bidirectional cursor over the tree nodes, sorted by key.
+///
+/// # Invariants
+///
+/// In instance of `RBTreeCursor` is only acquired from [`RBTree`].
+/// A reference to the tree used to create the cursor outlives the cursor, so
+/// the tree cannot change. By the tree invariant, all nodes are valid.
+///
+/// # Examples
+///
+/// In the following example, we obtain a cursor to the first element in the tree.
+/// The cursor allows us to iterate bidirectionally over key/value pairs in the tree.
+///
+/// ```
+/// use kernel::rbtree::RBTree;
+///
+/// // Create a new tree.
+/// let mut tree = RBTree::new();
+///
+/// // Insert three elements.
+/// tree.try_create_and_insert(10, 100)?;
+/// tree.try_create_and_insert(20, 200)?;
+/// tree.try_create_and_insert(30, 300)?;
+///
+/// // Get a cursor to the first element.
+/// let mut cursor = tree.cursor_front().unwrap();
+/// let mut current = cursor.current();
+/// assert_eq!(current, (&10, &100));
+///
+/// // Move the cursor, updating it to the 2nd element.
+/// cursor = cursor.move_next().unwrap();
+/// current = cursor.current();
+/// assert_eq!(current, (&20, &200));
+///
+/// // Peek at the next element without impacting the cursor.
+/// let next = cursor.peek_next().unwrap();
+/// assert_eq!(next, (&30, &300));
+/// current = cursor.current();
+/// assert_eq!(current, (&20, &200));
+///
+/// // Moving past the last element causes the cursor to return [`None`].
+/// cursor = cursor.move_next().unwrap();
+/// current = cursor.current();
+/// assert_eq!(current, (&30, &300));
+/// let cursor = cursor.move_next();
+/// assert!(cursor.is_none());
+///
+/// # Ok::<(), Error>(())
+/// ```
+///
+/// A cursor can also be obtained at the last element in the tree.
+///
+/// ```
+/// use kernel::rbtree::RBTree;
+///
+/// // Create a new tree.
+/// let mut tree = RBTree::new();
+///
+/// // Insert three elements.
+/// tree.try_create_and_insert(10, 100)?;
+/// tree.try_create_and_insert(20, 200)?;
+/// tree.try_create_and_insert(30, 300)?;
+///
+/// let mut cursor = tree.cursor_back().unwrap();
+/// let current = cursor.current();
+/// assert_eq!(current, (&30, &300));
+///
+/// # Ok::<(), Error>(())
+/// ```
+///
+/// Obtaining a cursor returns [`None`] if the tree is empty.
+///
+/// ```
+/// use kernel::rbtree::RBTree;
+///
+/// let mut tree: RBTree<u16, u16> = RBTree::new();
+/// assert!(tree.cursor_front().is_none());
+///
+/// # Ok::<(), Error>(())
+/// ```
+///
+/// [`RBTree::cursor_lower_bound`] can be used to start at an arbitrary node in the tree.
+///
+/// ```
+/// use kernel::rbtree::RBTree;
+///
+/// // Create a new tree.
+/// let mut tree = RBTree::new();
+///
+/// // Insert five elements.
+/// tree.try_create_and_insert(10, 100)?;
+/// tree.try_create_and_insert(20, 200)?;
+/// tree.try_create_and_insert(30, 300)?;
+/// tree.try_create_and_insert(40, 400)?;
+/// tree.try_create_and_insert(50, 500)?;
+///
+/// // If the provided key exists, a cursor to that key is returned.
+/// let cursor = tree.cursor_lower_bound(&20).unwrap();
+/// let current = cursor.current();
+/// assert_eq!(current, (&20, &200));
+///
+/// // If the provided key doesn't exist, a cursor to the first larger element in sort order is returned.
+/// let cursor = tree.cursor_lower_bound(&25).unwrap();
+/// let current = cursor.current();
+/// assert_eq!(current, (&30, &300));
+///
+/// // If there is no larger key, [`None`] is returned.
+/// let cursor = tree.cursor_lower_bound(&55);
+/// assert!(cursor.is_none());
+///
+/// # Ok::<(), Error>(())
+/// ```
+///
+/// The cursor allows mutation of values in the tree.
+///
+/// ```
+/// use kernel::rbtree::RBTree;
+///
+/// // Create a new tree.
+/// let mut tree = RBTree::new();
+///
+/// // Insert three elements.
+/// tree.try_create_and_insert(10, 100)?;
+/// tree.try_create_and_insert(20, 200)?;
+/// tree.try_create_and_insert(30, 300)?;
+///
+/// // Retrieve a cursor.
+/// let mut cursor = tree.cursor_front().unwrap();
+///
+/// // Get a mutable reference to the current value.
+/// let (k, v) = cursor.current_mut();
+/// *v = 1000;
+///
+/// // The updated value is reflected in the tree.
+/// let updated = tree.get(&10).unwrap();
+/// assert_eq!(updated, &1000);
+///
+/// # Ok::<(), Error>(())
+/// ```
+///
+/// It also allows node removal. The following examples demonstrate the behavior of removing the current node.
+///
+/// ```
+/// use kernel::rbtree::RBTree;
+///
+/// // Create a new tree.
+/// let mut tree = RBTree::new();
+///
+/// // Insert three elements.
+/// tree.try_create_and_insert(10, 100)?;
+/// tree.try_create_and_insert(20, 200)?;
+/// tree.try_create_and_insert(30, 300)?;
+///
+/// // Remove the first element.
+/// let mut cursor = tree.cursor_front().unwrap();
+/// let mut current = cursor.current();
+/// assert_eq!(current, (&10, &100));
+/// cursor = cursor.remove_current().unwrap();
+///
+/// // If a node exists after the current element, it is returned.
+/// current = cursor.current();
+/// assert_eq!(current, (&20, &200));
+///
+/// // Get a cursor to the last element, and remove it.
+/// cursor = tree.cursor_back().unwrap();
+/// current = cursor.current();
+/// assert_eq!(current, (&30, &300));
+///
+/// // Since there is no next node, the previous node is returned.
+/// cursor = cursor.remove_current().unwrap();
+/// current = cursor.current();
+/// assert_eq!(current, (&20, &200));
+///
+/// // Removing the last element in the tree returns [`None`].
+/// assert!(cursor.remove_current().is_none());
+///
+/// # Ok::<(), Error>(())
+/// ```
+///
+/// Nodes adjacent to the current node can also be removed.
+///
+/// ```
+/// use kernel::rbtree::RBTree;
+///
+/// // Create a new tree.
+/// let mut tree = RBTree::new();
+///
+/// // Insert three elements.
+/// tree.try_create_and_insert(10, 100)?;
+/// tree.try_create_and_insert(20, 200)?;
+/// tree.try_create_and_insert(30, 300)?;
+///
+/// // Get a cursor to the first element.
+/// let mut cursor = tree.cursor_front().unwrap();
+/// let mut current = cursor.current();
+/// assert_eq!(current, (&10, &100));
+///
+/// // Calling `remove_prev` from the first element returns [`None`].
+/// assert!(cursor.remove_prev().is_none());
+///
+/// // Get a cursor to the last element.
+/// cursor = tree.cursor_back().unwrap();
+/// current = cursor.current();
+/// assert_eq!(current, (&30, &300));
+///
+/// // Calling `remove_prev` removes and returns the middle element.
+/// assert_eq!(cursor.remove_prev().unwrap(), (20, 200));
+///
+/// // Calling `remove_next` from the last element returns [`None`].
+/// assert!(cursor.remove_next().is_none());
+///
+/// // Move to the first element
+/// cursor = cursor.move_prev().unwrap();
+/// current = cursor.current();
+/// assert_eq!(current, (&10, &100));
+///
+/// // Calling `remove_next` removes and returns the last element.
+/// assert_eq!(cursor.remove_next().unwrap(), (30, 300));
+///
+/// # Ok::<(), Error>(())
+/// ```
+pub struct RBTreeCursor<'a, K, V> {
+    _tree: PhantomData<&'a RBTree<K, V>>,
+    root: *mut bindings::rb_root,
+    current: *mut bindings::rb_node,
+}
+
+// SAFETY: An [`RBTree`] allows the same kinds of access to its values that a struct allows to its
+// fields, so we use the same Send condition as would be used for a struct with K and V fields.
+unsafe impl<'a, K: Send, V: Send> Send for RBTreeCursor<'a, K, V> {}
+
+// SAFETY: An [`RBTree`] allows the same kinds of access to its values that a struct allows to its
+// fields, so we use the same Sync condition as would be used for a struct with K and V fields.
+unsafe impl<'a, K: Sync, V: Sync> Sync for RBTreeCursor<'a, K, V> {}
+
+impl<'a, K, V> RBTreeCursor<'a, K, V> {
+    /// The current node
+    pub fn current(&self) -> (&K, &V) {
+        Self::to_key_value(self.current)
+    }
+
+    /// The current node, with a mutable value
+    pub fn current_mut(&mut self) -> (&K, &mut V) {
+        Self::to_key_value_mut(self.current)
+    }
+
+    /// Remove the current node from the tree.
+    ///
+    /// Returns a cursor to the next node, if it exists,
+    /// else the previous node. Returns [`None`] if the tree
+    /// becomes empty.
+    pub fn remove_current(mut self) -> Option<Self> {
+        let prev = self.get_neighbor_raw(Direction::Prev);
+        let next = self.get_neighbor_raw(Direction::Next);
+        // SAFETY: All links fields we create are in a `Node<K, V>`.
+        let this = unsafe { crate::container_of!(self.current, Node<K, V>, links) }.cast_mut();
+        // SAFETY: The reference to the tree used to create the cursor outlives the cursor, so
+        // the tree cannot change. By the tree invariant, all nodes are valid.
+        unsafe { bindings::rb_erase(&mut (*this).links, self.root) };
+
+        let current = match (prev, next) {
+            (_, Some(next)) => next,
+            (Some(prev), None) => prev,
+            (None, None) => {
+                return None;
+            }
+        };
+
+        Some(Self {
+            current,
+            _tree: self._tree,
+            root: self.root,
+        })
+    }
+
+    /// Remove the previous node, returning it if it exists.
+    pub fn remove_prev(&mut self) -> Option<(K, V)> {
+        self.remove_neighbor(Direction::Prev)
+    }
+
+    /// Remove the next node, returning it if it exists.
+    pub fn remove_next(&mut self) -> Option<(K, V)> {
+        self.remove_neighbor(Direction::Next)
+    }
+
+    fn remove_neighbor(&mut self, direction: Direction) -> Option<(K, V)> {
+        if let Some(neighbor) = self.get_neighbor_raw(direction) {
+            // SAFETY: All links fields we create are in a `Node<K, V>`.
+            let this = unsafe { crate::container_of!(neighbor, Node<K, V>, links) }.cast_mut();
+            // SAFETY: The reference to the tree used to create the cursor outlives the cursor, so
+            // the tree cannot change. By the tree invariant, all nodes are valid.
+            unsafe { bindings::rb_erase(&mut (*this).links, self.root) };
+            return Some(Self::to_key_value_owned(neighbor));
+        }
+        None
+    }
+
+    /// Move the cursor to the previous node, returning [`None`] if it doesn't exist.
+    pub fn move_prev(self) -> Option<Self> {
+        self.mv(Direction::Prev)
+    }
+
+    /// Move the cursor to the next node, returning [`None`] if it doesn't exist.
+    pub fn move_next(self) -> Option<Self> {
+        self.mv(Direction::Next)
+    }
+
+    fn mv(mut self, direction: Direction) -> Option<Self> {
+        self.get_neighbor_raw(direction).map(|neighbor| Self {
+            _tree: self._tree,
+            root: self.root,
+            current: neighbor,
+        })
+    }
+
+    /// Access the previous node without moving the cursor.
+    pub fn peek_prev(&self) -> Option<(&K, &V)> {
+        self.peek(Direction::Prev)
+    }
+
+    /// Access the previous node without moving the cursor.
+    pub fn peek_next(&self) -> Option<(&K, &V)> {
+        self.peek(Direction::Next)
+    }
+
+    fn peek(&self, direction: Direction) -> Option<(&K, &V)> {
+        // SAFETY: `self.current` is valid by the type invariants.
+        let neighbor = unsafe {
+            match direction {
+                Direction::Prev => bindings::rb_prev(self.current),
+                Direction::Next => bindings::rb_next(self.current),
+            }
+        };
+
+        if neighbor.is_null() {
+            return None;
+        }
+
+        Some(Self::to_key_value(neighbor))
+    }
+
+    /// Access the previous node mutably without moving the cursor.
+    pub fn peek_prev_mut(&mut self) -> Option<(&K, &mut V)> {
+        self.peek_mut(Direction::Prev)
+    }
+
+    /// Access the next node mutably without moving the cursor.
+    pub fn peek_next_mut(&mut self) -> Option<(&K, &mut V)> {
+        self.peek_mut(Direction::Next)
+    }
+
+    fn peek_mut(&mut self, direction: Direction) -> Option<(&K, &mut V)> {
+        // SAFETY: `self.current` is valid by the type invariants.
+        let neighbor = unsafe {
+            match direction {
+                Direction::Prev => bindings::rb_prev(self.current),
+                Direction::Next => bindings::rb_next(self.current),
+            }
+        };
+
+        if neighbor.is_null() {
+            return None;
+        }
+
+        Some(Self::to_key_value_mut(neighbor))
+    }
+
+    fn get_neighbor_raw(&mut self, direction: Direction) -> Option<*mut bindings::rb_node> {
+        // SAFETY: `self.current` is valid by the type invariants.
+        let neighbor = unsafe {
+            match direction {
+                Direction::Prev => bindings::rb_prev(self.current),
+                Direction::Next => bindings::rb_next(self.current),
+            }
+        };
+
+        if neighbor.is_null() {
+            return None;
+        }
+
+        Some(neighbor)
+    }
+
+    // This internal method should *only* be called with a valid pointer to a node.
+    fn to_key_value(node: *mut bindings::rb_node) -> (&'a K, &'a V) {
+        // SAFETY: All links fields we create are in a `Node<K, V>`.
+        let this = unsafe { crate::container_of!(node, Node<K, V>, links) };
+        // SAFETY: The passed `node` is the current node or a non-null neighbor,
+        // thus `this` is valid by the type invariants.
+        let k = unsafe { &(*this).key };
+        // SAFETY: The passed `node` is the current node or a non-null neighbor,
+        // thus `this` is valid by the type invariants.
+        let v = unsafe { &(*this).value };
+        (k, v)
+    }
+
+    // This internal method should *only* be called with a valid pointer to a node.
+    fn to_key_value_mut(node: *mut bindings::rb_node) -> (&'a K, &'a mut V) {
+        // SAFETY: All links fields we create are in a `Node<K, V>`.
+        let this = unsafe { crate::container_of!(node, Node<K, V>, links) }.cast_mut();
+        // SAFETY: The passed `node` is the current node or a non-null neighbor,
+        // thus `this` is valid by the type invariants.
+        let k = unsafe { &(*this).key };
+        // SAFETY: The passed `node` is the current node or a non-null neighbor,
+        // thus `this` is valid by the type invariants.
+        let v = unsafe { &mut (*this).value };
+        (k, v)
+    }
+
+    // This internal method should *only* be called with a valid pointer to a node *that is being removed*.
+    fn to_key_value_owned(node: *mut bindings::rb_node) -> (K, V) {
+        // SAFETY: All links fields we create are in a `Node<K, V>`.
+        let this = unsafe { crate::container_of!(node, Node<K, V>, links) }.cast_mut();
+        // SAFETY: The passed `node` is the current node or a non-null neighbor,
+        // thus `this` is valid by the type invariants.
+        let n = unsafe { Box::from_raw(this) };
+
+        (n.key, n.value)
+    }
+}
+
+/// Direction for [`RBTreeCursor`] operations.
+enum Direction {
+    /// the node immediately before, in sort order
+    Prev,
+    /// the node immediately after, in sort order
+    Next,
+}
+
 impl<'a, K, V> IntoIterator for &'a RBTree<K, V> {
     type Item = (&'a K, &'a V);
     type IntoIter = RBTreeIterator<'a, K, V>;

-- 
2.43.0.594.gd9cf4e227d-goog


