Return-Path: <linux-kernel+bounces-71243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D9A85A26A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACA2528582E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D4E2E644;
	Mon, 19 Feb 2024 11:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DZsSTOZz"
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E0B2D606
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343320; cv=none; b=JerDzwu7JNLoOJDn+JKsQMfejUSuhPpGPAdGZApUD20eAbswvmVfsZ79fOoXTftnc9m8Kj08joVVYmtljRVKZ5b3+MatdgkZSDFIQ/+ea+UJQjxVvGFB+iBzOMCKzlMRMcZiGOXUOgnUK9GGETJLlHu9DB8fvnW+nLP46nqddI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343320; c=relaxed/simple;
	bh=Gsr8Np304/ZF/8MRD/n+jlVmItVNTviF52shcVw7ERw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EL3pnuxZplip7a9US11/a3BXwapNhzC9NkS5gP0VkzRlJZdyGQwn3kEgCnRgusHrXOv6FjuTtAToNT3Q89uQdVvTsY7TPMncsyvYt9+0+dHSH403k+UX+jiU2NCbzMkJn3ng6hXFO27J1mqlYmqjzbJwoMutlBQOK4VFfjq/wZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DZsSTOZz; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7816bea8d28so1015479985a.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 03:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708343317; x=1708948117; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eQCD4AuKZId7gMhOchvG2XGZrBs0B56ew/r04xotUCQ=;
        b=DZsSTOZzMjMot2AhkcMGcLko6acOMIDdSj8YEVYpLIsc3Rhy1M6LQhm0bSgYWyzmDI
         rd4BHMdalqe0XjGUsJetR2YLYWZZ5Cte3vfwxZbO9jqBeMjBMcGLmEh2Vr/zr2lFdTEL
         vhFaK4dNfY+GVz3fcfc0jEcPq1IiBBWtp/DutXBkTv3YEy4nqzb4cvKbqAwDwTYNCr01
         iXW0qqSn/eZvM3gq38S3WFtADYkwuvs4DAGY2zkiOnP5g9bezQG6MgfQbTrGWgvLeUHm
         gYbEMUFNfh4dhkvPjjyXHDHFdlAL6AJv/Pr60Y1H9ANwaMnQCwxL906LtRwlujkkAF9R
         YI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708343317; x=1708948117;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eQCD4AuKZId7gMhOchvG2XGZrBs0B56ew/r04xotUCQ=;
        b=tuDBFZRUy9hY4PgTlAa+hq9/AxvBy62CblHHp/0/UlFT4Cr8XBhwhkcibQhwKg6rCC
         2Q1IWzEZ5XLlEHkKq8arxYDo25CofGjd6sZai+KM9p0/bbQ0fa/DBLJ21lOip2utSeNR
         TQZ+IqPkCarT6ZwY3QZPmv49QgtOIdsg223StEFzD8Z/3xuIW+23xeB28Wytte0rGiI4
         5tuUb/gpx5/N2BuVovBoeW3sg4gQrchem6WcBQoXbCSASnisw/CfjCRWswX0Wb6tsKy8
         sAFBBJ8LZgMqrW8Qfr50EMnHSFd0ufOwRZvhiSHSWJH9kPGgx8+T0nhaY8GcB5jH3cWK
         3hvA==
X-Forwarded-Encrypted: i=1; AJvYcCV3Qz7BVsdpE6CAKjG/CjQeqL396d+HlPCo0pPPWllKtYPqSxGg0EE8rkv1r/eVQFW986Ea1/5hw3/SHWPRtaoGWFXYK3GCpbFIEtoF
X-Gm-Message-State: AOJu0Yy9NMVqckH94lyU5aH3rHyoHdowPHADHHJEK7bcznLCinr8IRB2
	+SfiEZTpi6KadcusNNX5MYwG89cOUoKJbY6DGc2bDXbKOv3R5jdgoTz4YTto/pdcyyCih6XC02u
	lB50Y7bdXUg6PD68wjIievmD1Mw==
X-Google-Smtp-Source: AGHT+IF/WFVUGJFcz1k6jq7qhar/F0WayDZnvQAS2c7izu/+vXSmtyAZO8j0stsH0Xjt0E6hPX62r3w4J705wFJKzfE=
X-Received: from mattgilbride.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2ac5])
 (user=mattgilbride job=sendgmr) by 2002:a05:620a:40d0:b0:787:72d9:b7a0 with
 SMTP id g16-20020a05620a40d000b0078772d9b7a0mr3625qko.3.1708343317417; Mon,
 19 Feb 2024 03:48:37 -0800 (PST)
Date: Mon, 19 Feb 2024 11:48:10 +0000
In-Reply-To: <20240219-b4-rbtree-v2-0-0b113aab330d@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240219-b4-rbtree-v2-0-0b113aab330d@google.com>
X-Mailer: b4 0.12.4
Message-ID: <20240219-b4-rbtree-v2-3-0b113aab330d@google.com>
Subject: [PATCH v2 3/6] rust: rbtree: add `RBTreeIterator`
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

- Add Iterator implementation (`RBTreeIterator`) for `RBTree`, allowing
  iteration over (key, value) pairs in key order.
- Add individual `keys()` and `values()` functions to iterate over keys
  or values alone.
- Update doctests to use iteration instead of explicitly getting items.

Iteration is needed by the binder driver to enumerate all values in a
tree for oneway spam detection [1].

Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-17-08ba9197f637@google.com/ [1]
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Tested-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Matt Gilbride <mattgilbride@google.com>
---
 rust/kernel/rbtree.rs | 125 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 107 insertions(+), 18 deletions(-)

diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
index a72e9f57e660..b1faac831cfc 100644
--- a/rust/kernel/rbtree.rs
+++ b/rust/kernel/rbtree.rs
@@ -54,14 +54,30 @@ struct Node<K, V> {
 ///     assert_eq!(tree.get(&30).unwrap(), &300);
 /// }
 ///
+/// // Iterate over the nodes we just inserted.
+/// {
+///     let mut iter = tree.iter();
+///     assert_eq!(iter.next().unwrap(), (&10, &100));
+///     assert_eq!(iter.next().unwrap(), (&20, &200));
+///     assert_eq!(iter.next().unwrap(), (&30, &300));
+///     assert!(iter.next().is_none());
+/// }
+///
+/// // Print all elements.
+/// for (key, value) in &tree {
+///     pr_info!("{} = {}\n", key, value);
+/// }
+///
 /// // Replace one of the elements.
 /// tree.try_create_and_insert(10, 1000)?;
 ///
 /// // Check that the tree reflects the replacement.
 /// {
-///     assert_eq!(tree.get(&10).unwrap(), &1000);
-///     assert_eq!(tree.get(&20).unwrap(), &200);
-///     assert_eq!(tree.get(&30).unwrap(), &300);
+///     let mut iter = tree.iter();
+///     assert_eq!(iter.next().unwrap(), (&10, &1000));
+///     assert_eq!(iter.next().unwrap(), (&20, &200));
+///     assert_eq!(iter.next().unwrap(), (&30, &300));
+///     assert!(iter.next().is_none());
 /// }
 ///
 /// // Change the value of one of the elements.
@@ -69,9 +85,11 @@ struct Node<K, V> {
 ///
 /// // Check that the tree reflects the update.
 /// {
-///     assert_eq!(tree.get(&10).unwrap(), &1000);
-///     assert_eq!(tree.get(&20).unwrap(), &200);
-///     assert_eq!(tree.get(&30).unwrap(), &3000);
+///     let mut iter = tree.iter();
+///     assert_eq!(iter.next().unwrap(), (&10, &1000));
+///     assert_eq!(iter.next().unwrap(), (&20, &200));
+///     assert_eq!(iter.next().unwrap(), (&30, &3000));
+///     assert!(iter.next().is_none());
 /// }
 ///
 /// // Remove an element.
@@ -79,9 +97,10 @@ struct Node<K, V> {
 ///
 /// // Check that the tree reflects the removal.
 /// {
-///     assert_eq!(tree.get(&10), None);
-///     assert_eq!(tree.get(&20).unwrap(), &200);
-///     assert_eq!(tree.get(&30).unwrap(), &3000);
+///     let mut iter = tree.iter();
+///     assert_eq!(iter.next().unwrap(), (&20, &200));
+///     assert_eq!(iter.next().unwrap(), (&30, &3000));
+///     assert!(iter.next().is_none());
 /// }
 ///
 /// # Ok::<(), Error>(())
@@ -121,9 +140,11 @@ struct Node<K, V> {
 ///
 /// // Check the nodes we just inserted.
 /// {
-///     assert_eq!(tree.get(&10).unwrap(), &100);
-///     assert_eq!(tree.get(&20).unwrap(), &200);
-///     assert_eq!(tree.get(&30).unwrap(), &300);
+///     let mut iter = tree.iter();
+///     assert_eq!(iter.next().unwrap(), (&10, &100));
+///     assert_eq!(iter.next().unwrap(), (&20, &200));
+///     assert_eq!(iter.next().unwrap(), (&30, &300));
+///     assert!(iter.next().is_none());
 /// }
 ///
 /// // Remove a node, getting back ownership of it.
@@ -131,9 +152,10 @@ struct Node<K, V> {
 ///
 /// // Check that the tree reflects the removal.
 /// {
-///     assert_eq!(tree.get(&10).unwrap(), &100);
-///     assert_eq!(tree.get(&20).unwrap(), &200);
-///     assert_eq!(tree.get(&30), None);
+///     let mut iter = tree.iter();
+///     assert_eq!(iter.next().unwrap(), (&10, &100));
+///     assert_eq!(iter.next().unwrap(), (&20, &200));
+///     assert!(iter.next().is_none());
 /// }
 ///
 /// // Turn the node into a reservation so that we can reuse it with a different key/value.
@@ -145,9 +167,11 @@ struct Node<K, V> {
 ///
 /// // Check that the tree reflect the new insertion.
 /// {
-///     assert_eq!(tree.get(&10).unwrap(), &100);
-///     assert_eq!(tree.get(&15).unwrap(), &150);
-///     assert_eq!(tree.get(&20).unwrap(), &200);
+///     let mut iter = tree.iter();
+///     assert_eq!(iter.next().unwrap(), (&10, &100));
+///     assert_eq!(iter.next().unwrap(), (&15, &150));
+///     assert_eq!(iter.next().unwrap(), (&20, &200));
+///     assert!(iter.next().is_none());
 /// }
 ///
 /// # Ok::<(), Error>(())
@@ -188,6 +212,25 @@ pub fn try_reserve_node() -> Result<RBTreeNodeReservation<K, V>> {
     pub fn try_allocate_node(key: K, value: V) -> Result<RBTreeNode<K, V>> {
         Ok(Self::try_reserve_node()?.into_node(key, value))
     }
+
+    /// Returns an iterator over the tree nodes, sorted by key.
+    pub fn iter(&self) -> RBTreeIterator<'_, K, V> {
+        RBTreeIterator {
+            _tree: PhantomData,
+            // SAFETY: `root` is valid as it's embedded in `self` and we have a valid `self`.
+            next: unsafe { bindings::rb_first(&self.root) },
+        }
+    }
+
+    /// Returns an iterator over the keys of the nodes in the tree, in sorted order.
+    pub fn keys(&self) -> impl Iterator<Item = &'_ K> {
+        self.iter().map(|(k, _)| k)
+    }
+
+    /// Returns an iterator over the values of the nodes in the tree, sorted by key.
+    pub fn values(&self) -> impl Iterator<Item = &'_ V> {
+        self.iter().map(|(_, v)| v)
+    }
 }
 
 impl<K, V> RBTree<K, V>
@@ -350,6 +393,52 @@ fn drop(&mut self) {
     }
 }
 
+impl<'a, K, V> IntoIterator for &'a RBTree<K, V> {
+    type Item = (&'a K, &'a V);
+    type IntoIter = RBTreeIterator<'a, K, V>;
+
+    fn into_iter(self) -> Self::IntoIter {
+        self.iter()
+    }
+}
+
+/// An iterator over the nodes of a [`RBTree`].
+///
+/// Instances are created by calling [`RBTree::iter`].
+pub struct RBTreeIterator<'a, K, V> {
+    _tree: PhantomData<&'a RBTree<K, V>>,
+    next: *mut bindings::rb_node,
+}
+
+// SAFETY: An [`RBTree`] allows the same kinds of access to its values that a struct allows to its
+// fields, so we use the same Send condition as would be used for a struct with K and V fields.
+unsafe impl<'a, K: Send, V: Send> Send for RBTreeIterator<'a, K, V> {}
+
+// SAFETY: An [`RBTree`] allows the same kinds of access to its values that a struct allows to its
+// fields, so we use the same Sync condition as would be used for a struct with K and V fields.
+unsafe impl<'a, K: Sync, V: Sync> Sync for RBTreeIterator<'a, K, V> {}
+
+impl<'a, K, V> Iterator for RBTreeIterator<'a, K, V> {
+    type Item = (&'a K, &'a V);
+
+    fn next(&mut self) -> Option<Self::Item> {
+        if self.next.is_null() {
+            return None;
+        }
+
+        // SAFETY: All links fields we create are in a `Node<K, V>`.
+        let cur = unsafe { crate::container_of!(self.next, Node<K, V>, links) };
+
+        // SAFETY: The reference to the tree used to create the iterator outlives the iterator, so
+        // the tree cannot change. By the tree invariant, all nodes are valid.
+        self.next = unsafe { bindings::rb_next(self.next) };
+
+        // SAFETY: By the same reasoning above, it is safe to dereference the node. Additionally,
+        // it is ok to return a reference to members because the iterator must outlive it.
+        Some(unsafe { (&(*cur).key, &(*cur).value) })
+    }
+}
+
 /// A memory reservation for a red-black tree node.
 ///
 /// It contains the memory needed to hold a node that can be inserted into a red-black tree. One

-- 
2.44.0.rc0.258.g7320e95886-goog


