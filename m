Return-Path: <linux-kernel+bounces-150263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1461D8A9C74
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48EA5B24BB5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD6016C875;
	Thu, 18 Apr 2024 14:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fCkRG1NA"
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1947B168AFC
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 14:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713449752; cv=none; b=CqxATr2v2NO24PBIfgA2+eRI9JDOhDxbzt/KTheX/J+Ud3BUly3SNWC10qqIJEUi9lNd7GJNOcOxCDUV9r17QU01X+sXiFfbPHYDIzPKNd74Q01ksARxBB46iVuIgxM7lNzeFWObOD/riThypaBa8eFmGw5PqxpdYEpp/9Aw4h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713449752; c=relaxed/simple;
	bh=yomSa4/I94qsjjiijzIpnTXuWQbxOUImc+3SBuNNODk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HasBwyemJ2YWPoLUG7UIdDDUeR2oZggjI5sS/Bm8E6fNuMDP8brKeyKZKiUsQzbsaPcBR75CMdP5+W1QBDt77EwC4Zg7GekyeTCBTxHnJU30NXUiKXIwuTu3ljKZgZMmFklTAmBxHl0MC4f3ODYsuoso3DLCDJUBOytSA4L/C/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fCkRG1NA; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-78ecab0ad01so128959785a.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 07:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713449748; x=1714054548; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+4IlNhpC9rgujz1vF4EKJIUbfCwr+l48TkG3/vZAXwc=;
        b=fCkRG1NA3xyQgW4Ih11Gt6iEbFd8UfEod9IQj6SpfnLqcWIJc+J1OtBYyXcuWi4kfG
         tEbOdwHDNH7AAL/JOi6zqtYoq/2/09rGNK8po6xvxCOBwFwq/Jn3kp23e/pebzYbqX1T
         OyBo+YHE0QBAueXA+TIa4K5ZFx9/o9DMQcBLen4BN3xk6msXn/Z97ZKWaSfBH6sdkgTm
         WqlYhXsT5ETbJKkw5eAz9+jeAYX16O6jTLyWNAz0kjH1SemcqYOZi3X0ycmLtWIg0K4a
         XbKKRL6sm2R5tktOGUr7l8AjI/TNok9LULD3Quaj4wHX6zEfoGUoGnoHSShFEvm2Qex3
         d6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713449748; x=1714054548;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+4IlNhpC9rgujz1vF4EKJIUbfCwr+l48TkG3/vZAXwc=;
        b=fq35OcLK/hS+YeRGtxn+vgMoeenn8s13bb+M7Y0DqKVJDveVbOLfbZdrAwkVw8fXMN
         I7w/Lz/m4lPorUi3M7pzxjhH3bcdCfP19J3Sz7bjGZ9cmXZJjTruQcnZkID0aci8s0AS
         aMVF4y7AR305NT4tGErYYsL9h9zQVL7Tl0P40QiQu0TPrr9FrQ4ak4KxZe+8X+JGa7Ke
         QUopyKHxZ5jYjS00Qapjkb9h8E8zYVz2eKJhLEEc7qXHnF9Y/8eQESZ5TndGV8XYtE4Y
         fyBWvIzlvxHew49Ug8I9Pjw00xp4RVuv0c7dK1i1Wx7BDBV/l9A/1L3PYsELoGI6ZCHd
         4/Eg==
X-Forwarded-Encrypted: i=1; AJvYcCX9X5UqRzPG8NPqaj9A40jJTaCAlaD6kYt9BE063sSOo7WBqa86yd8wqPEP901m2hPyCxRkv8DeWDaDqYpu6L0dZn3uFcf3KJcRBro5
X-Gm-Message-State: AOJu0YyKiQPK2lVBjcerzEG0cnLRV7C4tqVuzwPvRXmcPbPl9nCdkn24
	8ikB0QNzHHT+wnzXNINo2KyyexKxpbbBmA3cOAkhhoznacxMFOTHznLhHV28pWxnyjgQ/fG1aKA
	O/iQ1GCrEYXbnnO7VoCmDPJyocw==
X-Google-Smtp-Source: AGHT+IFfva9f1zJIrSv0uWwhan+RjSc8QX0fo9KhV6Vzm1dl6qP/AjQbgIkTMK8sbLHgp1EhGV8Dgd9IgEZ71Dc5wAM=
X-Received: from mattgilbride.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2ac5])
 (user=mattgilbride job=sendgmr) by 2002:a05:620a:191c:b0:78e:e0d8:420e with
 SMTP id bj28-20020a05620a191c00b0078ee0d8420emr7208qkb.9.1713449747802; Thu,
 18 Apr 2024 07:15:47 -0700 (PDT)
Date: Thu, 18 Apr 2024 14:15:42 +0000
In-Reply-To: <20240418-b4-rbtree-v3-0-323e134390ce@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418-b4-rbtree-v3-0-323e134390ce@google.com>
X-Mailer: b4 0.12.4
Message-ID: <20240418-b4-rbtree-v3-3-323e134390ce@google.com>
Subject: [PATCH v3 3/5] rust: rbtree: add `RBTreeIteratorMut`
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

Add mutable Iterator implementation (`RBTreeIteratorMut`) for `RBTree`,
allowing iteration over (key, value) pairs in key order. Only values are
mutable, as mutating keys implies modifying a node's position in the tree.

Mutable iteration is used by the binder driver during shutdown to
clean up the tree maintained by the "range allocator" [1].

Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-6-08ba9197f637@google.com/ [1]
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Matt Gilbride <mattgilbride@google.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Tested-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/rbtree.rs | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
index 2f836be7bdbe..50d440c9926d 100644
--- a/rust/kernel/rbtree.rs
+++ b/rust/kernel/rbtree.rs
@@ -222,6 +222,15 @@ pub fn iter(&self) -> RBTreeIterator<'_, K, V> {
         }
     }
 
+    /// Returns a mutable iterator over the tree nodes, sorted by key.
+    pub fn iter_mut(&mut self) -> RBTreeIteratorMut<'_, K, V> {
+        RBTreeIteratorMut {
+            _tree: PhantomData,
+            // SAFETY: `root` is valid as it's embedded in `self` and we have a valid `self`.
+            next: unsafe { bindings::rb_first(&self.root) },
+        }
+    }
+
     /// Returns an iterator over the keys of the nodes in the tree, in sorted order.
     pub fn keys(&self) -> impl Iterator<Item = &'_ K> {
         self.iter().map(|(k, _)| k)
@@ -231,6 +240,11 @@ pub fn keys(&self) -> impl Iterator<Item = &'_ K> {
     pub fn values(&self) -> impl Iterator<Item = &'_ V> {
         self.iter().map(|(_, v)| v)
     }
+
+    /// Returns a mutable iterator over the values of the nodes in the tree, sorted by key.
+    pub fn values_mut(&mut self) -> impl Iterator<Item = &'_ mut V> {
+        self.iter_mut().map(|(_, v)| v)
+    }
 }
 
 impl<K, V> RBTree<K, V>
@@ -466,6 +480,56 @@ fn next(&mut self) -> Option<Self::Item> {
     }
 }
 
+impl<'a, K, V> IntoIterator for &'a mut RBTree<K, V> {
+    type Item = (&'a K, &'a mut V);
+    type IntoIter = RBTreeIteratorMut<'a, K, V>;
+
+    fn into_iter(self) -> Self::IntoIter {
+        self.iter_mut()
+    }
+}
+
+/// A mutable iterator over the nodes of a [`RBTree`].
+///
+/// Instances are created by calling [`RBTree::iter_mut`].
+///
+/// # Invariants
+/// - `self.next` is a valid pointer.
+/// - `self.next` points to a node stored inside of a valid `RBTree`.
+pub struct RBTreeIteratorMut<'a, K, V> {
+    _tree: PhantomData<&'a RBTree<K, V>>,
+    next: *mut bindings::rb_node,
+}
+
+// SAFETY: The [`RBTreeIterator`] gives out mutable references to K and V, so it has the same
+// thread safety requirements as mutable references.
+unsafe impl<'a, K: Send, V: Send> Send for RBTreeIteratorMut<'a, K, V> {}
+
+// SAFETY: The [`RBTreeIterator`] gives out mutable references to K and V, so it has the same
+// thread safety requirements as mutable references.
+unsafe impl<'a, K: Sync, V: Sync> Sync for RBTreeIteratorMut<'a, K, V> {}
+
+impl<'a, K, V> Iterator for RBTreeIteratorMut<'a, K, V> {
+    type Item = (&'a K, &'a mut V);
+
+    fn next(&mut self) -> Option<Self::Item> {
+        if self.next.is_null() {
+            return None;
+        }
+
+        // SAFETY: By the type invariant of `Self`, all non-null `rb_node` pointers stored in `self`
+        // point to the links field of `Node<K, V>` objects.
+        let cur = unsafe { container_of!(self.next, Node<K, V>, links) }.cast_mut();
+
+        // SAFETY: `self.next` is a valid tree node by the type invariants.
+        self.next = unsafe { bindings::rb_next(self.next) };
+
+        // SAFETY: By the same reasoning above, it is safe to dereference the node. Additionally,
+        // it is ok to return a reference to members because the iterator must outlive it.
+        Some(unsafe { (&(*cur).key, &mut (*cur).value) })
+    }
+}
+
 /// A memory reservation for a red-black tree node.
 ///
 /// It contains the memory needed to hold a node that can be inserted into a red-black tree. One

-- 
2.44.0.769.g3c40516874-goog


