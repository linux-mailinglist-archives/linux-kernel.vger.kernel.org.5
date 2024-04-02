Return-Path: <linux-kernel+bounces-127917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1436D8952C1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 371671C21E8C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431AE82893;
	Tue,  2 Apr 2024 12:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ydrkxjoa"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BE27F7EA
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 12:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712060251; cv=none; b=jtrHOjMxVXfWtFjfTF5anGeFHrVNASvhowOKJ/Sn7ebTBEPl7brab5+uuVK7M4LNwi0y3sByHJL+KB+ph04dETKHAky+1M3EIHA38Z6QLTpQK9j68MIo2rNgMkOiTA3oSVQc83+Kf1PCL2sIh2W2AzN4RRNYYC7Iygu+GRgp6Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712060251; c=relaxed/simple;
	bh=2PIcpJp9DT7VacmhqXAmL7iXpjNRwDR3ul+Ch/uIEhU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E7SSUUDDV8YBSo0kGsFSHHEC5lwXiaGvnEVwqVl692sOvtEv22nQCuXqmqVVCuMNdSYrBoZthMGNxFzzIf/xHfA1/CUu0RNAgYeT8kmgegIiJcKocvlrI/+nGjOY6utWgBI32m8MrZHSHUMVUk/Qp1b5DxAPsXGDtiKChlm0XK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ydrkxjoa; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b269686aso7108540276.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 05:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712060248; x=1712665048; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vhv4LxRJZ6OxQtv+kEEl5Wq7dqUJQo6ze35BbQzNlO4=;
        b=ydrkxjoaY/TlM8e9PL1P0qbWcShjQjKiWS+TL/D17jJRylybrXYKFHByLmyXm3an2M
         h5n6zthcuCVsjUFVq48N05h4JrmvJOsez9m3TVHS6aeoFKmohhHfADpU+Fg6T717+Jcr
         2q0n7Yjy+xWRTvRZcK/M8UKgy/QD69cpxq3/o5ZtJpEnE23W0VFG146ZLvByqv2DOe9L
         pVitP2skwuYankQ7oPb8dlesEvR4cxWtXHJ+N9jW/wS6Q65eej1BdVACEq0+bMGAHzm5
         f6GLSLp1jdVrD9toP6IW6B5ULNpKsGU1ip8Y+qPOLKghtTmGMSr5kONvVBGz9of8XmrG
         cLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712060248; x=1712665048;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vhv4LxRJZ6OxQtv+kEEl5Wq7dqUJQo6ze35BbQzNlO4=;
        b=EgGxbRVxL5CdU9z7/rCdVv/2fAA3BwyMMVwwznDP52yG8Z3Eo2TDplqVC9x0FHq4XR
         Sa8YP3baPs5FTrhycIvsP+IwkN4k9VrqIXmU4DTdqCzCI/de8w9GcyOoarhE3FQlieg7
         E5LdeSjK5lu0j4qddJ4THX/ha8L6byVlgC2U7fASBsywe2dspBaSypY8mUmNSfQd0mat
         /Iky6QeFMRgwAWKZ9jUzUaoabsxs7E4bCMRqtv+FboJ4D8Ydf/Yg1A5C6qW8y1jxOwhO
         1RhthTftazDQNlkqaM6GJik6L3n8HGzzj3XUREUoIhddUAtvwEbr8Db5NO1RcAWztb6G
         FEJA==
X-Forwarded-Encrypted: i=1; AJvYcCXQWhYCo2tXjdLjQdiNUX7SMk/jSxfbKynPToWUHXotseTJuoVjjFX2/Xqm7yaW5XKM9mKaX8PN+XGzdTTl3q1TolCVMfikJB1u5l2u
X-Gm-Message-State: AOJu0YyCaiMro+lvUDr9fVMjorTXkQ9+8NEKK5sjV8BRJ3SOL7SrfzQY
	MC0UhdKNN6aUKx0pQkb0v3H8gSYZhQ7QzYjE6dVeM1iaQvf2N3b0CjfMoEVfeJ5F1PCVVVbm5Z7
	64qswu9BuwRaeBQ==
X-Google-Smtp-Source: AGHT+IFPeL2qwx829ZFPHGJYFkffe6dJwQ4bXNP9dPoxKP7o36b6Dqs5va8TK6Yn0yc6KOKjxZjuDd8dBh5Krq4=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:1883:b0:dce:30f5:6bc5 with SMTP
 id cj3-20020a056902188300b00dce30f56bc5mr954191ybb.4.1712060247742; Tue, 02
 Apr 2024 05:17:27 -0700 (PDT)
Date: Tue, 02 Apr 2024 12:17:00 +0000
In-Reply-To: <20240402-linked-list-v1-0-b1c59ba7ae3b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240402-linked-list-v1-0-b1c59ba7ae3b@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5967; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=2PIcpJp9DT7VacmhqXAmL7iXpjNRwDR3ul+Ch/uIEhU=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmC/dJexiium8UT/OewJm7DPd0VgrTKGLZevB6+
 tW4etfZDoKJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZgv3SQAKCRAEWL7uWMY5
 RpazD/4/uDlpm2FRIQJKp/aRWdG4z3cc4Dmds/xdrritb9hgsytKePUaWn43aBKudy+TqUgwywk
 GLl8g2S675hNtyAfEO8ppFQU3sRVRiGtSouPyeacJzW5hw63j+PLHznz6BP09t+Sl/k8eGpF/oT
 febc7azfxUrpOV44CT5JAxXeGhca7ebYsQpoO3YlidgHhB5BelV8EFX000wMym4AZKrxtIJUHT+
 +WCxUjO9+HE4R1XVqlhZEI8TpTbTYNJ9TzNnzWxnvWgS5RXNMRisaSiC3QMh4jsHRb0nccO7sD3
 G8eB7g4I5wf794iKi7K9GflmCAsBV9N/H7dNRydlvvLY6lRrK/epaVGxPcb77MXieVkxDUDVrao
 7YyGR0HpsQjqjoapiXpNyAMUNr1jAjHthEmxtO0kWEAGBvps4P+mOvVpOoXNTHYqkG6kiM/kif9
 CZ6Zu5ra6Mpvd/CGjYujV43z8srPvbwCFelbZ4tl7XH9FmByJtcvQqZxX+exfkroG51/Uzq+j4P
 Hu2mmdwBslps6ShnZEQO6gBwL74lBFkKaEcnglZqQk7WUoEOvGs4TjLU+oYgXyr949TPln6cFCP
 IYWl/aDxUxumQnPwbtiy8Y45H7NIBIQ/Y7F31UJum8wRdW58zIIDcEDNp10cDhhTk9ewm14oK73 qzMwlEqoZ7kITaw==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240402-linked-list-v1-3-b1c59ba7ae3b@google.com>
Subject: [PATCH 3/9] rust: list: add struct with prev/next pointers
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, 
	Kees Cook <keescook@chromium.org>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, 
	Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Define the ListLinks struct, which wraps the prev/next pointers that
will be used to insert values into a List in a future patch. Also
define the ListItem trait, which is implemented by structs that have a
ListLinks field.

The ListItem trait provides four different methods that are all
essentially container_of or the reverse of container_of. Two of them are
used before inserting/after removing an item from the list, and the two
others are used when looking at a value without changing whether it is
in a list. This distinction is introduced because it is needed for the
patch that adds support for heterogeneous lists, which are implemented
by adding a third pointer field with a fat pointer to the full struct.
When inserting into the heterogeneous list, the pointer-to-self is
updated to have the right vtable, and the container_of operation is
implemented by just returning that pointer instead of using the real
container_of operation.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/list.rs | 115 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
index c5caa0f6105c..76597c49fa56 100644
--- a/rust/kernel/list.rs
+++ b/rust/kernel/list.rs
@@ -4,7 +4,122 @@
 
 //! A linked list implementation.
 
+use crate::init::PinInit;
+use crate::types::Opaque;
+use core::ptr;
+
 mod arc;
 pub use self::arc::{
     impl_list_arc_safe, AtomicListArcTracker, ListArc, ListArcSafe, TryNewListArc,
 };
+
+/// Implemented by types where a [`ListArc<Self>`] can be inserted into a `List`.
+///
+/// # Safety
+///
+/// Implementers must ensure that they provide the guarantees documented on the three methods
+/// below.
+///
+/// [`ListArc<Self>`]: ListArc
+pub unsafe trait ListItem<const ID: u64 = 0>: ListArcSafe<ID> {
+    /// Views the [`ListLinks`] for this value.
+    ///
+    /// # Guarantees
+    ///
+    /// * If there is a currently active call to `prepare_to_insert`, then this returns the same
+    ///   pointer as the one returned by the currently active call to `prepare_to_insert`.
+    /// * If there is no currently active call to `prepare_to_insert`, then the returned pointer
+    ///   points at a read-only [`ListLinks`] with two null pointers.
+    ///
+    /// # Safety
+    ///
+    /// The provided pointer must point at a valid value. (It need not be in an `Arc`.)
+    unsafe fn view_links(me: *const Self) -> *mut ListLinks<ID>;
+
+    /// View the full value given its [`ListLinks`] field.
+    ///
+    /// Can only be used when the value is in a list.
+    ///
+    /// # Guarantees
+    ///
+    /// * Returns the same pointer as the one passed to the previous call to `prepare_to_insert`.
+    /// * The returned pointer is valid until the next call to `post_remove`.
+    ///
+    /// # Safety
+    ///
+    /// * The provided pointer must originate from the previous call to `prepare_to_insert`, or
+    ///   from a call to `view_links` that happened after the previous call to `prepare_to_insert`.
+    /// * Since the previous call to `prepare_to_insert`, the `post_remove` method must not have
+    ///   been called.
+    unsafe fn view_value(me: *mut ListLinks<ID>) -> *const Self;
+
+    /// This is called when an item is inserted into a `List`.
+    ///
+    /// # Guarantees
+    ///
+    /// The caller is granted exclusive access to the returned [`ListLinks`] until `post_remove` is
+    /// called.
+    ///
+    /// # Safety
+    ///
+    /// * The provided pointer must point at a valid value in an [`Arc`].
+    /// * Calls to `prepare_to_insert` and `post_remove` on the same value must alternate.
+    /// * The caller must own the [`ListArc`] for this value.
+    /// * The caller must not give up ownership of the [`ListArc`] unless `post_remove` has been
+    ///   called after this call to `prepare_to_insert`.
+    ///
+    /// [`Arc`]: crate::sync::Arc
+    unsafe fn prepare_to_insert(me: *const Self) -> *mut ListLinks<ID>;
+
+    /// This undoes a previous call to `prepare_to_insert`.
+    ///
+    /// # Guarantees
+    ///
+    /// The returned pointer is the pointer that was originally passed to `prepare_to_insert`.
+    ///
+    /// The caller is free to recreate the `ListArc` after this call.
+    ///
+    /// # Safety
+    ///
+    /// The provided pointer must be the pointer returned by the previous call to
+    /// `prepare_to_insert`.
+    unsafe fn post_remove(me: *mut ListLinks<ID>) -> *const Self;
+}
+
+#[repr(C)]
+#[derive(Copy, Clone)]
+struct ListLinksFields {
+    next: *mut ListLinksFields,
+    prev: *mut ListLinksFields,
+}
+
+/// The prev/next pointers for an item in a linked list.
+///
+/// # Invariants
+///
+/// The fields are null if and only if this item is not in a list.
+#[repr(transparent)]
+pub struct ListLinks<const ID: u64 = 0> {
+    #[allow(dead_code)]
+    inner: Opaque<ListLinksFields>,
+}
+
+// SAFETY: The next/prev fields of a ListLinks can be moved across thread boundaries.
+unsafe impl<const ID: u64> Send for ListLinks<ID> {}
+// SAFETY: The type is opaque so immutable references to a ListLinks are useless. Therefore, it's
+// okay to have immutable access to a ListLinks from several threads at once.
+unsafe impl<const ID: u64> Sync for ListLinks<ID> {}
+
+impl<const ID: u64> ListLinks<ID> {
+    /// Creates a new initializer for this type.
+    pub fn new() -> impl PinInit<Self> {
+        // INVARIANT: Pin-init initializers can't be used on an existing `Arc`, so this value will
+        // not be constructed in an `Arc` that already has a `ListArc`.
+        ListLinks {
+            inner: Opaque::new(ListLinksFields {
+                prev: ptr::null_mut(),
+                next: ptr::null_mut(),
+            }),
+        }
+    }
+}

-- 
2.44.0.478.gd926399ef9-goog


