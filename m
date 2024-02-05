Return-Path: <linux-kernel+bounces-52950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED002849EC4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C8151C2347B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A944A45035;
	Mon,  5 Feb 2024 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L6cwn6Vh"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96554176E
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 15:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707148210; cv=none; b=pTxpcC9fQ6Wc7jPf09Tqc+FKF5BE9ghtrwykXqGqaOW+qj7Q7bt9SZuN8xTxY14iBluROEoOsWp9IY/s2L1TfoeV/7esp89V3dW9e/PkU6dFiKzWmLw0dIH+F+1kt2Imn6c5jNWSpYYO/Fq1ARrkTbJu33z1Slf2qPm5Yb4xsG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707148210; c=relaxed/simple;
	bh=bjenK6W2mteZ4lawE7+mh5kopqmKFi1EJSc5e4+d2Jc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GSAkjaC//M6Yxy+uIVvujJaPkwvUx9KHPSaiZbR10xo88yigI9pkd+xosaAdiMxt6brw4SqgBoqwZ+O0/lwnmyKksNNMyx6n9GOCEMdx7mHvvxDlJy+Exo8F4eURWqjQWekPT0mAanm8PnytkTpmfuVVwGjTu92K2HGT+FRy84Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L6cwn6Vh; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6ba69e803so7673004276.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 07:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707148208; x=1707753008; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=arEHk0ctRB/sznZOfkcY6q8hHQuRWxqyzdzyyUckFyo=;
        b=L6cwn6Vh1U5fLZ5yAFbkudnqYFiZ6g2UMmu/55AH5fv9PlIC83lXqcr2lu4yyp3o0m
         vobfwf9n5cNiZSsw5eRaUyR6j4wJ4zFZ3VINFr3ZYaZibQYtJ+jDB+EKCSQzRux66fB9
         I2c+pZ/MypqSdlqi6Oufnl2/omuVXwx9NRKYcLZRlIhTlTtufXjVnnI4k3BBrpd3AJeo
         F7T7tOPp7MQvGYEJtSkqjEtGhLJ6zlJJ+nx10BuaUXug38lgBue0xZyOi5HBhfUflmMI
         5B2mHWnrmLOBoqAwmEkqXis9xcuaRrDvuDNow8txIaLIumKy57Bd4KbtNGAAiE5NCi+S
         KLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707148208; x=1707753008;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=arEHk0ctRB/sznZOfkcY6q8hHQuRWxqyzdzyyUckFyo=;
        b=Rbh2I0NYIgmQWhj7rgQK6Sj8hd9i/zMT0guDOXdujyBdVG1LxISJhfCVwJnq9wfm4E
         cw4OJlq7KTZnEchhVTDIGR79kkQuXmkK3P4VJPexVDRFwAjl6eLO3wkv8Bm0hxZ3MZAX
         auSYw6KLU0UpAh2HhNspWqn3GwxV+A1E/Z9ghcnOFm6qX3w9iH1R233UbXypIYw43Tsf
         gKMZJkUp5lXvtFw6S7P/Ord1RMQz9YsAOyKBGZAxBOsBV7a/1e5EV7kUuGWE13/iaSh8
         bKnGfdLyE1c8YqSaz+wVH3cA1oZYio9er72dC8h6M1yVbSBpiWt7UwKl3qVAne3jHQqo
         BeIw==
X-Gm-Message-State: AOJu0YxW2faGHfaNlM/UE/Rbyivbaw94g61b/Cv+qLGF75fiGTwhxcu0
	nFnbiYdcNqaBsY2m7Sh9vJ7wHxtvvl9Uhajtr41BbrcI8iYScTMsosqVKi7nlzV/eNVNTqzU/di
	oDbHsHjpdF7FiTmGy5p+R+YgdhQ==
X-Google-Smtp-Source: AGHT+IFrW68xCg2j39/5TZqCiA+L40nU0XhZR6jp/fIklvNF0+R996XTcQnLLtdTcbbz7LXffGN1aBPZpJp5h+lA1ZQ=
X-Received: from mattgilbride.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2ac5])
 (user=mattgilbride job=sendgmr) by 2002:a05:6902:230d:b0:dc6:519b:5425 with
 SMTP id do13-20020a056902230d00b00dc6519b5425mr2873212ybb.11.1707148207870;
 Mon, 05 Feb 2024 07:50:07 -0800 (PST)
Date: Mon, 05 Feb 2024 15:50:03 +0000
In-Reply-To: <20240205-b4-rbtree-v1-0-995e3eee38c0@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240205-b4-rbtree-v1-0-995e3eee38c0@google.com>
X-Mailer: b4 0.12.3
Message-ID: <20240205-b4-rbtree-v1-3-995e3eee38c0@google.com>
Subject: [PATCH 3/6] rust: rbtree: add `RBTreeIterator`
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
Signed-off-by: Matt Gilbride <mattgilbride@google.com>
---
 rust/kernel/rbtree.rs | 125 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 107 insertions(+), 18 deletions(-)

diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
index f33650258743..29d8c2f6bd7b 100644
--- a/rust/kernel/rbtree.rs
+++ b/rust/kernel/rbtree.rs
@@ -53,14 +53,30 @@ struct Node<K, V> {
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
@@ -68,9 +84,11 @@ struct Node<K, V> {
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
@@ -78,9 +96,10 @@ struct Node<K, V> {
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
@@ -120,9 +139,11 @@ struct Node<K, V> {
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
@@ -130,9 +151,10 @@ struct Node<K, V> {
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
@@ -144,9 +166,11 @@ struct Node<K, V> {
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
@@ -187,6 +211,25 @@ pub fn try_reserve_node() -> Result<RBTreeNodeReservation<K, V>> {
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
@@ -349,6 +392,52 @@ fn drop(&mut self) {
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
2.43.0.594.gd9cf4e227d-goog


