Return-Path: <linux-kernel+bounces-52951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A75A0849EC5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB8471C208ED
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968B545952;
	Mon,  5 Feb 2024 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rmJ96hhe"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10C044C6B
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 15:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707148211; cv=none; b=jj8Hsx09FDlq77YL58cajkGpVt9lzd33o6tTEY09K1Vsis3TtFreClMPqGQWDBsSp/mKFHg9VFeaRvSfh30o5HsjhLjqZy9VIerbfLJ8aBKwWOp84hdX2HN0MfLiAIioSjETiE5V1oaT6J6379ksLFM037o+r1jtdABW/AnSO+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707148211; c=relaxed/simple;
	bh=DVzO7sH9br7pDvZZ99ERESu2r5MxqGc7Jk4Dqa4lhEA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LswUCLemHka+WRglfhceeRidqg+vUSHzW3HIGUjZnvwm/K0zesE2misp11hfh3Wr3js0erOyCu2BiQVkEpcpRiY+TcT5ar3F8yUnd8ZSLtTD8QlGQrvPQDfK88/lZXx70NlBvslOY38WgO1yC/Io55yiqeZS0Azuss+1T0aeRXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rmJ96hhe; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26783b4so5014396276.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 07:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707148209; x=1707753009; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LqF9zLVi16rKyrWpAJ0bhub0WiHD3paBZjfcYyqlQjA=;
        b=rmJ96hhe7ME3DH4E5j4xu9kXfo5ePa2Y076KjrfzoAHjREOfp3/qEVTRSnLNG6d4XF
         My7XQLdVTYMhcgmLzM+sOXi9gqik4KadaB/40HH0/qmtLN5nckfk6N8jDjzuyvny/zLa
         WPqpTpGpsNClkHtmagWqRn8OYYvaZ49heOc41gZZFKboODWCpEWnYWoD28ARGv7En7mF
         q9wAL6Ab6zB5GZDr7sMbI/0zUBnywe2Ra7mz3Lcjn5b2k9/Z2JhZaVsmCbTrIs+8CoaI
         QHmdFVL/fP5K4m2Ft8IsiXi53TNvumHWP/kvnAAInAKs7jfmOlEXlpdZNcIAj1EQBTK9
         hTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707148209; x=1707753009;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LqF9zLVi16rKyrWpAJ0bhub0WiHD3paBZjfcYyqlQjA=;
        b=RcnptAOdm3ATa5HepPCDWUKz9i8OAWxUfMtn5JX8jPNbAf3QHlK+iveMs/YvBuxNLZ
         GrDPkDYTXYSBw6Vk5jsXpkBHNKXsWxcxzWdtbBfYuFjAH8ud++plEbslYYJ0VhG1mpTk
         dgvEMMVY25c5wJBt0At0ZMRkVO8/HJ6UVZyXuv0U+z1jVvHhFpQoxLhgLNkUi0m1RXtM
         tDA3uWJFBREsMjw8K0vnjGBjDfgEjQ2EBqoH8FEzMujPDbWfDyWu8RfIPLSTWb1+cSfC
         zrjFbuhWuxm/HSYk4nSp+5U+ItW2DGg2MNbqoznHqykJ2JB2znXNlE4SX3zanBl3FXOa
         LAMw==
X-Gm-Message-State: AOJu0YwoNfLXFf84X6JWcDg/ypoblPZ2IUgRABXcXgUkImxGosPCfVE9
	PuOlmkMXkJw4bQZg4j4QmnF2rPV8vedhOEmqj9Ek3CUh/g212QZgtPIdqvAWxu+BLfowYJu4M74
	Vkuypx+pqJefrTlxnFcrDYT5SsA==
X-Google-Smtp-Source: AGHT+IF6Fis7YrbjmpE2NhJ3s+XZIGQdOXc4JxZ0aS+q/QDNDI/ezUPodv7GcBiAVYfBKU0ROCQDSTmv9hF+DkEZOzA=
X-Received: from mattgilbride.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2ac5])
 (user=mattgilbride job=sendgmr) by 2002:a05:6902:993:b0:dc2:25fd:eff1 with
 SMTP id bv19-20020a056902099300b00dc225fdeff1mr454327ybb.4.1707148209024;
 Mon, 05 Feb 2024 07:50:09 -0800 (PST)
Date: Mon, 05 Feb 2024 15:50:04 +0000
In-Reply-To: <20240205-b4-rbtree-v1-0-995e3eee38c0@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240205-b4-rbtree-v1-0-995e3eee38c0@google.com>
X-Mailer: b4 0.12.3
Message-ID: <20240205-b4-rbtree-v1-4-995e3eee38c0@google.com>
Subject: [PATCH 4/6] rust: rbtree: add `RBTreeIteratorMut`
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
	linux-kernel@vger.kernel.org, Matt Gilbride <mattgilbride@google.com>, 
	Matt Gilbride <mattgilbride@gmail.com>
Content-Type: text/plain; charset="utf-8"

From: Wedson Almeida Filho <wedsonaf@gmail.com>

Add mutable Iterator implementation (`RBTreeIteratorMut`) for `RBTree`,
allowing iteration over (key, value) pairs in key order. Only values are
mutable, as mutating keys implies modifying a node's position in the tree.

Mutable iteration is used by the binder driver during shutdown to
clean up the tree maintained by the "range allocator" [1].

Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-6-08ba9197f637@google.com/ [1]
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Matt Gilbride <mattgilbride@gmail.com>
---
 rust/kernel/rbtree.rs | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
index 29d8c2f6bd7b..db17734b3fa1 100644
--- a/rust/kernel/rbtree.rs
+++ b/rust/kernel/rbtree.rs
@@ -221,6 +221,15 @@ pub fn iter(&self) -> RBTreeIterator<'_, K, V> {
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
@@ -230,6 +239,11 @@ pub fn keys(&self) -> impl Iterator<Item = &'_ K> {
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
@@ -438,6 +452,53 @@ fn next(&mut self) -> Option<Self::Item> {
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
+pub struct RBTreeIteratorMut<'a, K, V> {
+    _tree: PhantomData<&'a RBTree<K, V>>,
+    next: *mut bindings::rb_node,
+}
+
+// SAFETY: An [`RBTree`] allows the same kinds of access to its values that a struct allows to its
+// fields, so we use the same Send condition as would be used for a struct with K and V fields.
+unsafe impl<'a, K: Send, V: Send> Send for RBTreeIteratorMut<'a, K, V> {}
+
+// SAFETY: An [`RBTree`] allows the same kinds of access to its values that a struct allows to its
+// fields, so we use the same Sync condition as would be used for a struct with K and V fields.
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
+        // SAFETY: All links fields we create are in a `Node<K, V>`.
+        let cur = unsafe { crate::container_of!(self.next, Node<K, V>, links) }.cast_mut();
+
+        // SAFETY: The reference to the tree used to create the iterator outlives the iterator, so
+        // the tree cannot change (except for the value of previous nodes, but those don't affect
+        // the iteration process). By the tree invariant, all nodes are valid.
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
2.43.0.594.gd9cf4e227d-goog


