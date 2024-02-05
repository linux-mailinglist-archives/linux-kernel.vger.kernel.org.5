Return-Path: <linux-kernel+bounces-52953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CC9849EC7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FE8E28A04B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A736482C2;
	Mon,  5 Feb 2024 15:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PJrGdy5x"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520D645950
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707148214; cv=none; b=C0GFoGHuzJYI4+WkUbieQ8nXia+jA7MXmVg0tSbwbTEpkcw93bqFxWfI/FRcIZGgx93STkA6iiLgxyB49WqvpEZMziWzeYCHv5F5wb4JKAalcRERMNY7UlQ+6tb7V/zfQlrNYwk1FapO1/98ACZBvV0uS1vk/ZsqCua2ZPlMHb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707148214; c=relaxed/simple;
	bh=22UG/FoayaE5gos56FE9J5zNHaONu8WJgvgbCJ9Ju5I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=atHhdRr1GWILNuGDzZda7MUsNku9Qg8i+SfR/CkAKj+6K1FRrbmkxdFk8cob5LlrItW2dKXH23CSYds5gkFy/DQN5FbC6jG9JhI5cy//ksRgzHafOHi19RasQhb8+3dS62iPpcbB2+uu3br6kTpgzS5WDlzK0tYQcPVVjNh2A30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PJrGdy5x; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5ee22efe5eeso70388267b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 07:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707148211; x=1707753011; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yvwbZDgWN0lh70oVs2Q46rrbtwbVSHs2JN97boJgs94=;
        b=PJrGdy5xE1H5o1QnDlFkdEmsS6OqYnjQUGGJuv9EfxoIFn8bg3LmvxN2fpaRmQqVCR
         2a+huzEaH9BCRUgzrY5napM+oTqQEedsaQT1FjAJ6JWL2igFb26/GKAq9B3x9wVnmgA6
         MUEEACIay0VgQeTQk+PIuWzsDgiJeYM1cwrBTAU3v9KpOsFHNxTfRd9YYi/n7IvJIDX8
         wv1nRKwZB94FkhJLn44oSXKe2jWhwWfTuxTZQkszgcA8fyyIVecI6WzPA5/lAGPlXwjC
         8VX7HW/oTNDGuRlh/B3qAw8MPyuL5X3O8U/IVonr5pv/eoWLwcsnr92tdqaRcDa2jeCj
         kIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707148211; x=1707753011;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yvwbZDgWN0lh70oVs2Q46rrbtwbVSHs2JN97boJgs94=;
        b=jGwhqDwuFRTE/uphuNYzuwLQJ5y5n0J/Gp9DlvHnvm4b10EWN056B78tqW0dSnXeUL
         jfZzyp2FwRMONB8n+2JJHUW0G5Kj7aphfT2gwIi4fwXGSgTKvISK90rqZGphpqqNz0XZ
         Q0lIqPYNLEDVG5mNRcaBpl4s1X1X8A3Y5oQ7TTi+T6Ly0jF6Jld7S3oj27XGGlOgnCcp
         WeZLDTt3YXfUaQh7++M03aPqDu2ES8RQ5Y6hlmMPkA2nVAR3PExY9+eSSVmIHoTlNlum
         DS8+DEGpqL/fuAyeOGFknEzwNLq9mxuiwPGc2B4wTVDPdMEbhLQ+/fe6xC7CLrlqANVw
         GcPA==
X-Gm-Message-State: AOJu0Yxf6Lf5Kpbhfzi6wHMwZEL/kDP22W/JSt7pwaJCcx3NFxaHW6Rf
	+l3TdVeqY4ZtV5yEHZr9lkE2xjnvXdVk2sJY/+XCro30DXJaVfT7eWt37QECAIEWPb44VZmtUZ8
	Vbknu9hmHpleAhdu5fG1lUa5wdA==
X-Google-Smtp-Source: AGHT+IEMft5d2wJebWkpwaL5gkrPglrd6gRNOeZLonZHEJQD2i80Ih8PdQSInGrpCo2h1yhXn22srVVwbWt57OQAkKY=
X-Received: from mattgilbride.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2ac5])
 (user=mattgilbride job=sendgmr) by 2002:a05:6902:2206:b0:dc2:4921:cc0 with
 SMTP id dm6-20020a056902220600b00dc249210cc0mr455698ybb.5.1707148211433; Mon,
 05 Feb 2024 07:50:11 -0800 (PST)
Date: Mon, 05 Feb 2024 15:50:06 +0000
In-Reply-To: <20240205-b4-rbtree-v1-0-995e3eee38c0@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240205-b4-rbtree-v1-0-995e3eee38c0@google.com>
X-Mailer: b4 0.12.3
Message-ID: <20240205-b4-rbtree-v1-6-995e3eee38c0@google.com>
Subject: [PATCH 6/6] rust: rbtree: add `RBTree::entry`
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

From: Alice Ryhl <aliceryhl@google.com>

This mirrors the entry API [1] from the Rust standard library on
`RBTree`. This API can be used to access the entry at a specific key and
make modifications depending on whether the key is vacant or occupied.
This API is useful because it can often be used to avoid traversing the
tree multiple times.

This is used by binder to look up and conditionally access or insert a
value, depending on whether it is there or not [2].

Link: https://doc.rust-lang.org/stable/std/collections/btree_map/enum.Entry.html [1]
Link: https://android-review.googlesource.com/c/kernel/common/+/2849906 [2]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Matt Gilbride <mattgilbride@google.com>
---
 rust/kernel/rbtree.rs | 284 ++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 216 insertions(+), 68 deletions(-)

diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
index 0db6a584a9fc..9ee953df2347 100644
--- a/rust/kernel/rbtree.rs
+++ b/rust/kernel/rbtree.rs
@@ -297,56 +297,64 @@ pub fn try_create_and_insert(&mut self, key: K, value: V) -> Result<Option<RBTre
     ///
     /// This function always succeeds.
     pub fn insert(&mut self, node: RBTreeNode<K, V>) -> Option<RBTreeNode<K, V>> {
-        let RBTreeNode { node } = node;
-        let node = Box::into_raw(node);
-        // SAFETY: `node` is valid at least until we call `Box::from_raw`, which only happens when
-        // the node is removed or replaced.
-        let node_links = unsafe { addr_of_mut!((*node).links) };
+        match self.raw_entry(&node.node.key) {
+            RawEntry::Occupied(entry) => Some(entry.replace(node)),
+            RawEntry::Vacant(entry) => {
+                entry.insert(node);
+                None
+            }
+        }
+    }
+
+    fn raw_entry(&mut self, key: &K) -> RawEntry<'_, K, V> {
         let mut new_link: &mut *mut bindings::rb_node = &mut self.root.rb_node;
         let mut parent = core::ptr::null_mut();
-        while !new_link.is_null() {
+        while !(*new_link).is_null() {
+            let curr = *new_link;
             // SAFETY: All links fields we create are in a `Node<K, V>`.
-            let this = unsafe { crate::container_of!(*new_link, Node<K, V>, links) };
+            let node = unsafe { crate::container_of!(curr, Node<K, V>, links) };
 
-            parent = *new_link;
-
-            // SAFETY: `this` is a non-null node so it is valid by the type invariants. `node` is
-            // valid until the node is removed.
-            match unsafe { (*node).key.cmp(&(*this).key) } {
-                // SAFETY: `parent` is a non-null node so it is valid by the type invariants.
-                Ordering::Less => new_link = unsafe { &mut (*parent).rb_left },
-                // SAFETY: `parent` is a non-null node so it is valid by the type invariants.
-                Ordering::Greater => new_link = unsafe { &mut (*parent).rb_right },
+            // SAFETY: `node` is a non-null node so it is valid by the type invariants.
+            match key.cmp(unsafe { &(*node).key }) {
+                // SAFETY: `curr` is a non-null node so it is valid by the type invariants.
+                Ordering::Less => new_link = unsafe { &mut (*curr).rb_left },
+                // SAFETY: `curr` is a non-null node so it is valid by the type invariants.
+                Ordering::Greater => new_link = unsafe { &mut (*curr).rb_right },
                 Ordering::Equal => {
-                    // INVARIANT: We are replacing an existing node with a new one, which is valid.
-                    // It remains valid because we "forgot" it with `Box::into_raw`.
-                    // SAFETY: All pointers are non-null and valid (parent, despite the name, really
-                    // is the node we're replacing).
-                    unsafe { bindings::rb_replace_node(parent, node_links, &mut self.root) };
-
-                    // INVARIANT: The node is being returned and the caller may free it, however,
-                    // it was removed from the tree. So the invariants still hold.
-                    return Some(RBTreeNode {
-                        // SAFETY: `this` was a node in the tree, so it is valid.
-                        node: unsafe { Box::from_raw(this as _) },
-                    });
+                    return RawEntry::Occupied(OccupiedEntry {
+                        rbtree: self,
+                        node_links: curr,
+                    })
                 }
             }
+            parent = curr;
         }
 
-        // INVARIANT: We are linking in a new node, which is valid. It remains valid because we
-        // "forgot" it with `Box::into_raw`.
-        // SAFETY: All pointers are non-null and valid (`*new_link` is null, but `new_link` is a
-        // mutable reference).
-        unsafe { bindings::rb_link_node(node_links, parent, new_link) };
+        RawEntry::Vacant(RawVacantEntry {
+            parent,
+            new_link,
+            rbtree: self,
+        })
+    }
 
-        // SAFETY: All pointers are valid. `node` has just been inserted into the tree.
-        unsafe { bindings::rb_insert_color(node_links, &mut self.root) };
-        None
+    /// Gets the given key's corresponding entry in the map for in-place manipulation.
+    pub fn entry(&mut self, key: K) -> Entry<'_, K, V> {
+        match self.raw_entry(&key) {
+            RawEntry::Occupied(entry) => Entry::Occupied(entry),
+            RawEntry::Vacant(entry) => Entry::Vacant(VacantEntry { raw: entry, key }),
+        }
     }
 
-    /// Returns a node with the given key, if one exists.
-    fn find(&self, key: &K) -> Option<NonNull<Node<K, V>>> {
+    /// Used for accessing the given node, if it exists.
+    pub fn find_mut(&mut self, key: &K) -> Option<OccupiedEntry<'_, K, V>> {
+        match self.raw_entry(key) {
+            RawEntry::Occupied(entry) => Some(entry),
+            RawEntry::Vacant(_entry) => None,
+        }
+    }
+
+    /// Returns a reference to the value corresponding to the key.
+    pub fn get(&self, key: &K) -> Option<&V> {
         let mut node = self.root.rb_node;
         while !node.is_null() {
             // SAFETY: All links fields we create are in a `Node<K, V>`.
@@ -357,54 +365,30 @@ fn find(&self, key: &K) -> Option<NonNull<Node<K, V>>> {
                 Ordering::Less => unsafe { (*node).rb_left },
                 // SAFETY: `node` is a non-null node so it is valid by the type invariants.
                 Ordering::Greater => unsafe { (*node).rb_right },
-                Ordering::Equal => return NonNull::new(this as _),
+                // SAFETY: `node` is a non-null node so it is valid by the type invariants.
+                Ordering::Equal => return Some(unsafe { &(*this).value }),
             }
         }
         None
     }
 
-    /// Returns a reference to the value corresponding to the key.
-    pub fn get(&self, key: &K) -> Option<&V> {
-        // SAFETY: The `find` return value is a node in the tree, so it is valid.
-        self.find(key).map(|node| unsafe { &node.as_ref().value })
-    }
-
     /// Returns a mutable reference to the value corresponding to the key.
     pub fn get_mut(&mut self, key: &K) -> Option<&mut V> {
-        // SAFETY: The `find` return value is a node in the tree, so it is valid.
-        self.find(key)
-            .map(|mut node| unsafe { &mut node.as_mut().value })
+        self.find_mut(key).map(|node| node.into_mut())
     }
 
     /// Removes the node with the given key from the tree.
     ///
     /// It returns the node that was removed if one exists, or [`None`] otherwise.
-    fn remove_node(&mut self, key: &K) -> Option<RBTreeNode<K, V>> {
-        let mut node = self.find(key)?;
-
-        // SAFETY: The `find` return value is a node in the tree, so it is valid.
-        unsafe { bindings::rb_erase(&mut node.as_mut().links, &mut self.root) };
-
-        // INVARIANT: The node is being returned and the caller may free it, however, it was
-        // removed from the tree. So the invariants still hold.
-        Some(RBTreeNode {
-            // SAFETY: The `find` return value was a node in the tree, so it is valid.
-            node: unsafe { Box::from_raw(node.as_ptr()) },
-        })
+    pub fn remove_node(&mut self, key: &K) -> Option<RBTreeNode<K, V>> {
+        self.find_mut(key).map(OccupiedEntry::remove_node)
     }
 
     /// Removes the node with the given key from the tree.
     ///
     /// It returns the value that was removed if one exists, or [`None`] otherwise.
     pub fn remove(&mut self, key: &K) -> Option<V> {
-        let node = self.remove_node(key)?;
-        let RBTreeNode { node } = node;
-        let Node {
-            links: _,
-            key: _,
-            value,
-        } = *node;
-        Some(value)
+        self.find_mut(key).map(OccupiedEntry::remove)
     }
 
     /// Returns a cursor over the tree nodes based on the given key.
@@ -1063,3 +1047,167 @@ unsafe impl<K: Send, V: Send> Send for RBTreeNode<K, V> {}
 // SAFETY: An [`RBTree`] allows the same kinds of access to its values that a struct allows to its
 // fields, so we use the same Sync condition as would be used for a struct with K and V fields.
 unsafe impl<K: Sync, V: Sync> Sync for RBTreeNode<K, V> {}
+
+impl<K, V> RBTreeNode<K, V> {
+    /// "Uninitialises" a node.
+    ///
+    /// It then becomes a reservation that can be re-initialised into a different node (i.e., with
+    /// a different key and/or value).
+    ///
+    /// The existing key and value are dropped in-place as part of this operation, that is, memory
+    /// may be freed (but only for the key/value; memory for the node itself is kept for reuse).
+    pub fn into_reservation(self) -> RBTreeNodeReservation<K, V> {
+        let raw = Box::into_raw(self.node);
+        let mut ret = RBTreeNodeReservation {
+            // SAFETY: The pointer came from a valid `Node`, which has the same layout as
+            // `MaybeUninit<Node>`.
+            node: unsafe { Box::from_raw(raw as _) },
+        };
+        // SAFETY: Although the type is `MaybeUninit<Node>`, we know it has been initialised
+        // because it came from a `Node`. So it is safe to drop it.
+        unsafe { core::ptr::drop_in_place(ret.node.as_mut_ptr()) };
+        ret
+    }
+}
+
+/// A view into a single entry in a map, which may either be vacant or occupied.
+///
+/// This enum is constructed from the [`entry`] method on [`RBTree`].
+///
+/// [`entry`]: fn@RBTree::entry
+pub enum Entry<'a, K, V> {
+    /// This [`RBTree`] does not have a node with this key.
+    Vacant(VacantEntry<'a, K, V>),
+    /// This [`RBTree`] already has a node with this key.
+    Occupied(OccupiedEntry<'a, K, V>),
+}
+
+/// Like [`Entry`], except that it doesn't have ownership of the key.
+enum RawEntry<'a, K, V> {
+    Vacant(RawVacantEntry<'a, K, V>),
+    Occupied(OccupiedEntry<'a, K, V>),
+}
+
+/// A view into a vacant entry in a [`RBTree`]. It is part of the [`Entry`] enum.
+pub struct VacantEntry<'a, K, V> {
+    key: K,
+    raw: RawVacantEntry<'a, K, V>,
+}
+
+/// Like [`VacantEntry`], but doesn't hold on to the key.
+struct RawVacantEntry<'a, K, V> {
+    rbtree: &'a mut RBTree<K, V>,
+    /// The node that will become the parent of the new node if we insert one.
+    ///
+    /// This pointer may be null if the new node becomes the root.
+    parent: *mut bindings::rb_node,
+    /// This points to the left-child or right-child field of `parent`. This controls whether the
+    /// new node will become the left or right child of `parent`.
+    ///
+    /// If `parent` is null, then this points at `rbtree.root`.
+    new_link: *mut *mut bindings::rb_node,
+}
+
+impl<'a, K, V> RawVacantEntry<'a, K, V> {
+    /// Inserts the given node into the [`RBTree`] at this entry.
+    ///
+    /// The `node` must have a key such that inserting it here does not break the ordering of this
+    /// [`RBTree`].
+    fn insert(self, node: RBTreeNode<K, V>) -> &'a mut V {
+        let node = Box::into_raw(node.node);
+
+        // SAFETY: `node` is valid at least until we call `Box::from_raw`, which only happens when
+        // the node is removed or replaced.
+        let node_links = unsafe { addr_of_mut!((*node).links) };
+
+        // INVARIANT: We are linking in a new node, which is valid. It remains valid because we
+        // "forgot" it with `Box::into_raw`.
+        // SAFETY: All pointers are null or valid in an appropriate way.
+        unsafe { bindings::rb_link_node(node_links, self.parent, self.new_link) };
+
+        // SAFETY: All pointers are valid. `node` has just been inserted into the tree.
+        unsafe { bindings::rb_insert_color(node_links, &mut self.rbtree.root) };
+
+        // SAFETY: The node is valid until we remove it from the tree.
+        unsafe { &mut (*node).value }
+    }
+}
+
+impl<'a, K, V> VacantEntry<'a, K, V> {
+    /// Inserts the given node into the [`RBTree`] at this entry.
+    pub fn insert(self, value: V, reservation: RBTreeNodeReservation<K, V>) -> &'a mut V {
+        self.raw.insert(reservation.into_node(self.key, value))
+    }
+}
+
+/// A view into an occupied entry in a [`RBTree`]. It is part of the [`Entry`] enum.
+pub struct OccupiedEntry<'a, K, V> {
+    rbtree: &'a mut RBTree<K, V>,
+    /// The node that this entry corresponds to. Non null.
+    node_links: *mut bindings::rb_node,
+}
+
+impl<'a, K, V> OccupiedEntry<'a, K, V> {
+    fn node_ptr(&self) -> *mut Node<K, V> {
+        // SAFETY: All links fields we create are in a `Node<K, V>`.
+        unsafe { crate::container_of!(self.node_links, Node<K, V>, links) }.cast_mut()
+    }
+
+    /// Gets a reference to the value in the entry.
+    pub fn get(&self) -> &V {
+        unsafe { &(*self.node_ptr()).value }
+    }
+
+    /// Gets a mutable reference to the value in the entry.
+    pub fn get_mut(&mut self) -> &mut V {
+        unsafe { &mut (*self.node_ptr()).value }
+    }
+
+    /// Converts the entry into a mutable reference to its value.
+    ///
+    /// If you need multiple references to the `OccupiedEntry`, see [`self#get_mut`].
+    pub fn into_mut(self) -> &'a mut V {
+        unsafe { &mut (*self.node_ptr()).value }
+    }
+
+    /// Remove this entry from the [`RBTree`].
+    pub fn remove_node(self) -> RBTreeNode<K, V> {
+        // SAFETY: The node is a node in the tree, so it is valid.
+        unsafe { bindings::rb_erase(self.node_links, &mut self.rbtree.root) };
+
+        // INVARIANT: The node is being returned and the caller may free it, however, it was
+        // removed from the tree. So the invariants still hold.
+        RBTreeNode {
+            // SAFETY: The node was a node in the tree, but we removed it, so we can convert it
+            // back into a box.
+            node: unsafe { Box::from_raw(self.node_ptr()) },
+        }
+    }
+
+    /// Takes the value of the entry out of the map, and returns it.
+    pub fn remove(self) -> V {
+        self.remove_node().node.value
+    }
+
+    /// Swap the current node for the provided node.
+    ///
+    /// The key of both nodes must be equal.
+    fn replace(self, node: RBTreeNode<K, V>) -> RBTreeNode<K, V> {
+        let node = Box::into_raw(node.node);
+
+        // SAFETY: `node` is valid at least until we call `Box::from_raw`, which only happens when
+        // the node is removed or replaced.
+        let new_node_links = unsafe { addr_of_mut!((*node).links) };
+
+        // SAFETY: This updates the pointers so that `new_node_links` is in the tree where
+        // `self.node_links` used to be.
+        unsafe {
+            bindings::rb_replace_node(self.node_links, new_node_links, &mut self.rbtree.root)
+        };
+
+        // SAFETY: Now that we removed this entry from the tree, we can convert the node to a box.
+        let old_node = unsafe { Box::from_raw(self.node_ptr()) };
+
+        RBTreeNode { node: old_node }
+    }
+}

-- 
2.43.0.594.gd9cf4e227d-goog


