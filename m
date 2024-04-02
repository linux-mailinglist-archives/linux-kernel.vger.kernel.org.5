Return-Path: <linux-kernel+bounces-127919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 177A88952C3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 392881C2165C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B004884A2F;
	Tue,  2 Apr 2024 12:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dsqc/bab"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6059683CC5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 12:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712060256; cv=none; b=D9QoqMGzLzTLBOobU9bPI5c3FyTFsBF1qnlUeTNW0CCceU5VD1dSX9dY5wLMf6UYzu9UikZpZwgFXCVoSEWfyZ+fpdOrYrkqp+vKymNan2P1Y4/DhSwrPF766ZTql25RGMf/Rc/s0Cy8OTLv490g2eW6LA5ATXisezztKYGxYHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712060256; c=relaxed/simple;
	bh=yhgZAfXFmRRhY9kBUH0LIo35FjPWeAgq4Ytu4D/AAx8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p4i95N5AHUNY5amKzxV6z1pFrUvVeEX7dJrTPzm0OKQCDHTeQsM6fg/jbi0KOylGZvmn7dBUOmNwbhw24XkY0VNsLDj2bNZYCVnVFV17P+FB//f5bH3miGs2O3qV3zxlcCsYJWDZlXTKw/ITA4XVfrMOwgvUYVhrYYBbqoD5BPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dsqc/bab; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dd169dd4183so5656277276.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 05:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712060253; x=1712665053; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qRZU3o4DKcL9Cdkic23o3zfbWrM7i4Tw/HmtgQ9VyFw=;
        b=Dsqc/babMYDQ+SmGKCuqW+LwYYpey5UORQfKON1IoOY1vP5ciguiH/k2O7B35gzQzG
         +dTZwALmlEFmd4h4ERfCghZ4qiFmaBcwttqNlq+B2XLxJHOM1qzTrLRTBz0XOI+JfcFj
         KvIql+CSnPKBtUGn5/V3XRjppkdGugDxlQM43+deEnCnxTBJUgPj7/GDkpjdaI7mSVmR
         YVsWt0juO9rpaB9Dy8nX6jesuNingzz7YvtJd1F/jQwRtOJLLTuXe2c/HsdxcrCyfq2O
         xqgrz7kYHJDv8futEQ9CMVB4VLRgf9uezYK1cymJbHeTMPy/mtCZ/q8pIfuaxmYOTjTP
         9Qpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712060253; x=1712665053;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qRZU3o4DKcL9Cdkic23o3zfbWrM7i4Tw/HmtgQ9VyFw=;
        b=te7hN2FiDDlRmmyHykjMMWmaVa3gtRXspLtL1EZuRisAO14cfKatTs3Tl/NscPa+Xd
         NN9fDSvvgNV2ouitInZU3X74zd0/ReAUIsRAgOg0XpEigY2NAZTeieLFt2XXETGmXAB0
         +x+xVI6mM+Pob+tYFs9GYjd3omfvpWjxbetSEEk/6oF2xKKNc21dE7buFeYmWVQglxKZ
         hlvX7Ce4IfgrTzCBLWSXQckAWvDJfQ0x8ljMPufjjKJZzG4RwPoIqNoHoNU57Jis/It1
         cLuZ17Sq/6uZeU5QKP0UOV61ymkRCTIYt9n0LmngVgtMXvz5PBVwBowudih4Vj2m5w0T
         hB/w==
X-Forwarded-Encrypted: i=1; AJvYcCXidu3g/KttTxHIEZEGD1Rh/fP2VApVyc31AN8vro7Ol9EUuNQX/fWLmLjN7hclbbSJy6PT2IAaEaWB8+FhETcAeIcyVpXPKyMOyozm
X-Gm-Message-State: AOJu0Yzy6wN4zs+VMKt7J/8wp8SOv+WCKhRkV+jGiBGc2CJiLCHOVl6N
	zBJuypqyHQhM8l4bjFMTeZDpFjtYSPUYMvbWEDMqZlLITyOn8SVhY5wpIcDu6ehe3Vd/ucz5eH4
	hOwUjK/XnuzKYGw==
X-Google-Smtp-Source: AGHT+IGCqPzyxAi6FIXF9R1ausIFuDEPd2XSTC0WaKC4DpSSQtAJQ6GYlkF8SRn8d3AmtpLXRoKNsKL3jKnYJRU=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:2481:b0:dd9:2a64:e98a with SMTP
 id ds1-20020a056902248100b00dd92a64e98amr818915ybb.9.1712060253479; Tue, 02
 Apr 2024 05:17:33 -0700 (PDT)
Date: Tue, 02 Apr 2024 12:17:02 +0000
In-Reply-To: <20240402-linked-list-v1-0-b1c59ba7ae3b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240402-linked-list-v1-0-b1c59ba7ae3b@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=16615; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=yhgZAfXFmRRhY9kBUH0LIo35FjPWeAgq4Ytu4D/AAx8=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmC/dKbNhyFwGhIGVrySb84b1KR3gVYhZyT+sLt
 of7HI5cO7aJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZgv3SgAKCRAEWL7uWMY5
 RoC1D/9ZnyLoMsrue/lXIR4SwwvULPd+ZkoZRlzVmON1QPCPUspiFDmtVgdf60yNzm17H3t25Jn
 BHHvVLxXUJWEfw/qJ5y1N+B2ukTfZhEkwgwvCFc+1cKR2Oc3n3fSmdGbBVyCn+NGbSNeAlKECfx
 8lX2wEP0QwDx/nWViY9Eso1dP8Hk6UGKURG1EuPVZiZDBicz9HRERcZhaewxp/Beyz7ucX8qDfZ
 xj0WCzJ+a+GdGxAXqUvN03ydyQgccgQeRXZW/99sHxmXzBDmhKtct3NIbFMX5KINi0Eb4TBBYbA
 6MKbmMmjalDE0qxM2nK3FqQR6MoGi5tN7q9UULx0jEYc4zFrNVW3c1H2jI4BinMha6o9TLmIsFR
 Xm8JdQZKmUQW8ekX9VfiWnNQhpJicftcgUshOtgiQLgHEsMnEKXLaPKXvsKkx2jbJYLkSdpl7Pt
 t6UrLpQp6AOJuXVRSWBEgX3YfZdLEUAyz7GDORyT4hr+mZxJQ2YydNfyvA0o40oJjMxdmKUhsti
 VsPqnTPAFtlcNsqq4iPB/HmepkwI880IUqW1VzlraahA2DAlK8uv8TqEnTrdP4ckZHP9Glk5cs8
 bCb/gjKW+k3Ak6o86/+58pK2/VheLVKcazUUt9HRArBZdoEIWlLfjgrTKRI0kCL7ZxIjOGH4sjK 8aLSy+hXRPo/UVg==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240402-linked-list-v1-5-b1c59ba7ae3b@google.com>
Subject: [PATCH 5/9] rust: list: add List
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

Add the actual linked list itself.

The linked list uses the following design: The List type itself just has
a single pointer to the first element of the list. And the actual list
items then form a cycle. So the last item is `first->prev`.

This is slightly different from the usual kernel linked list. Matching
that exactly would amount to giving List two pointers, and having it be
part of the cycle of items. This alternate design has the advantage that
the cycle is never completely empty, which can reduce the number of
branches in some cases. However, it also has the disadvantage that List
must be pinned, which this design is trying to avoid.

Having the list items form a cycle rather than having null pointers at
the beginning/end is convenient for several reasons. For one, it lets us
store only one pointer in List, and it simplifies the implementation of
several functions.

Unfortunately, the `remove` function that removes an arbitrary element
from the list has to be unsafe. This is needed because there is no way
to handle the case where you pass an element from the wrong list. For
example, if it is the first element of some other list, then that other
list's `first` pointer would not be updated. Similarly, it could be a
data race if you try to remove it from two different lists in parallel.
(There's no problem with passing `remove` an item that's not in any
list. Additionally, other removal methods such as `pop_front` need not
be unsafe, as they can't be used to remove items from another list.)

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/list.rs     | 294 +++++++++++++++++++++++++++++++++++++++++++++++-
 rust/kernel/list/arc.rs |   6 +-
 2 files changed, 295 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
index 7af5109500f2..7e9ed802b26b 100644
--- a/rust/kernel/list.rs
+++ b/rust/kernel/list.rs
@@ -6,6 +6,7 @@
 
 use crate::init::PinInit;
 use crate::types::Opaque;
+use core::marker::PhantomData;
 use core::ptr;
 
 mod impl_list_item_mod;
@@ -16,7 +17,41 @@
     impl_list_arc_safe, AtomicListArcTracker, ListArc, ListArcSafe, TryNewListArc,
 };
 
-/// Implemented by types where a [`ListArc<Self>`] can be inserted into a `List`.
+/// A linked list.
+///
+/// All elements in this linked list will be [`ListArc`] references to the value. Since a value can
+/// only have one `ListArc` (for each pair of prev/next pointers), this ensures that the same
+/// prev/next pointers are not used for several linked lists.
+///
+/// # Invariants
+///
+/// If the list is empty, then `first` is null. Otherwise, it points at the links field of the
+/// first element of this list. The prev/next pointers of items in the list will always form a
+/// cycle. This means that prev/next pointers for an item in a list are never null and never
+/// dangling.
+pub struct List<T: ?Sized + ListItem<ID>, const ID: u64 = 0> {
+    first: *mut ListLinksFields,
+    _ty: PhantomData<ListArc<T, ID>>,
+}
+
+// SAFETY: This is a container of `ListArc<T, ID>`, and access to the container allows the same
+// type of access to the `ListArc<T, ID>` elements.
+unsafe impl<T, const ID: u64> Send for List<T, ID>
+where
+    ListArc<T, ID>: Send,
+    T: ?Sized + ListItem<ID>,
+{
+}
+// SAFETY: This is a container of `ListArc<T, ID>`, and access to the container allows the same
+// type of access to the `ListArc<T, ID>` elements.
+unsafe impl<T, const ID: u64> Sync for List<T, ID>
+where
+    ListArc<T, ID>: Sync,
+    T: ?Sized + ListItem<ID>,
+{
+}
+
+/// Implemented by types where a [`ListArc<Self>`] can be inserted into a [`List`].
 ///
 /// # Safety
 ///
@@ -56,7 +91,7 @@ pub unsafe trait ListItem<const ID: u64 = 0>: ListArcSafe<ID> {
     ///   been called.
     unsafe fn view_value(me: *mut ListLinks<ID>) -> *const Self;
 
-    /// This is called when an item is inserted into a `List`.
+    /// This is called when an item is inserted into a [`List`].
     ///
     /// # Guarantees
     ///
@@ -103,7 +138,6 @@ struct ListLinksFields {
 /// The fields are null if and only if this item is not in a list.
 #[repr(transparent)]
 pub struct ListLinks<const ID: u64 = 0> {
-    #[allow(dead_code)]
     inner: Opaque<ListLinksFields>,
 }
 
@@ -125,4 +159,258 @@ pub fn new() -> impl PinInit<Self> {
             }),
         }
     }
+
+    /// # Safety
+    ///
+    /// The pointer must be dereferencable.
+    #[inline]
+    unsafe fn fields(me: *mut Self) -> *mut ListLinksFields {
+        // SAFETY: The caller promises that the pointer is valid.
+        unsafe { Opaque::raw_get(ptr::addr_of!((*me).inner)) }
+    }
+
+    /// # Safety
+    ///
+    /// The pointer must be dereferencable.
+    #[inline]
+    unsafe fn from_fields(me: *mut ListLinksFields) -> *mut Self {
+        me.cast()
+    }
+}
+
+impl<T: ?Sized + ListItem<ID>, const ID: u64> List<T, ID> {
+    /// Creates a new empty list.
+    pub const fn new() -> Self {
+        Self {
+            first: ptr::null_mut(),
+            _ty: PhantomData,
+        }
+    }
+
+    /// Returns whether this list is empty.
+    pub fn is_empty(&self) -> bool {
+        self.first.is_null()
+    }
+
+    /// Add the provided item to the back of the list.
+    pub fn push_back(&mut self, item: ListArc<T, ID>) {
+        let item = unsafe { ListLinks::fields(T::prepare_to_insert(ListArc::into_raw(item))) };
+
+        if self.first.is_null() {
+            self.first = item;
+            // SAFETY: The caller just gave us ownership of these fields.
+            // INVARIANT: A linked list with one item should be cyclic.
+            unsafe {
+                (*item).next = item;
+                (*item).prev = item;
+            }
+        } else {
+            let next = self.first;
+            // SAFETY: We just checked that `next` is non-null.
+            let prev = unsafe { (*next).prev };
+            // SAFETY: Pointers in a linked list are never dangling, and the caller just gave us
+            // ownership of the fields on `item`.
+            // INVARIANT: This correctly inserts `item` between `prev` and `next`.
+            unsafe {
+                (*item).next = next;
+                (*item).prev = prev;
+                (*prev).next = item;
+                (*next).prev = item;
+            }
+        }
+    }
+
+    /// Add the provided item to the front of the list.
+    pub fn push_front(&mut self, item: ListArc<T, ID>) {
+        let item = unsafe { ListLinks::fields(T::prepare_to_insert(ListArc::into_raw(item))) };
+
+        if self.first.is_null() {
+            // SAFETY: The caller just gave us ownership of these fields.
+            // INVARIANT: A linked list with one item should be cyclic.
+            unsafe {
+                (*item).next = item;
+                (*item).prev = item;
+            }
+        } else {
+            let next = self.first;
+            // SAFETY: We just checked that `next` is non-null.
+            let prev = unsafe { (*next).prev };
+            // SAFETY: Pointers in a linked list are never dangling, and the caller just gave us
+            // ownership of the fields on `item`.
+            // INVARIANT: This correctly inserts `item` between `prev` and `next`.
+            unsafe {
+                (*item).next = next;
+                (*item).prev = prev;
+                (*prev).next = item;
+                (*next).prev = item;
+            }
+        }
+        self.first = item;
+    }
+
+    /// Removes the last item from this list.
+    pub fn pop_back(&mut self) -> Option<ListArc<T, ID>> {
+        if self.first.is_null() {
+            return None;
+        }
+
+        // SAFETY: We just checked that the list is not empty.
+        let last = unsafe { (*self.first).prev };
+        // SAFETY: The last item of this list is in this list.
+        Some(unsafe { self.remove_internal(last) })
+    }
+
+    /// Removes the first item from this list.
+    pub fn pop_front(&mut self) -> Option<ListArc<T, ID>> {
+        if self.first.is_null() {
+            return None;
+        }
+
+        // SAFETY: The first item of this list is in this list.
+        Some(unsafe { self.remove_internal(self.first) })
+    }
+
+    /// Removes the provided item from this list and returns it.
+    ///
+    /// This returns `None` if the item is not in the list.
+    ///
+    /// # Safety
+    ///
+    /// The provided item must not be in a different linked list.
+    pub unsafe fn remove(&mut self, item: &T) -> Option<ListArc<T, ID>> {
+        let mut item = unsafe { ListLinks::fields(T::view_links(item)) };
+        // SAFETY: The user provided a reference, and reference are never dangling.
+        //
+        // As for why this is not a data race, there are two cases:
+        //
+        //  * If `item` is not in any list, then these fields are read-only and null.
+        //  * If `item` is in this list, then we have exclusive access to these fields since we
+        //    have a mutable reference to the list.
+        //
+        // In either case, there's no race.
+        let ListLinksFields { next, prev } = unsafe { *item };
+
+        debug_assert_eq!(next.is_null(), prev.is_null());
+        if !next.is_null() {
+            // This is really a no-op, but this ensures that `item` is a raw pointer that was
+            // obtained without going through a pointer->reference->pointer conversion rountrip.
+            // This ensures that the list is valid under the more restrictive strict provenance
+            // ruleset.
+            //
+            // SAFETY: We just checked that `next` is not null, and it's not dangling by the
+            // list invariants.
+            unsafe {
+                debug_assert_eq!(item, (*next).prev);
+                item = (*next).prev;
+            }
+
+            // SAFETY: We just checked that `item` is in a list, so the caller guarantees that it
+            // is in this list. The pointers are in the right order.
+            Some(unsafe { self.remove_internal_inner(item, next, prev) })
+        } else {
+            None
+        }
+    }
+
+    /// Removes the provided item from the list.
+    ///
+    /// # Safety
+    ///
+    /// The pointer must point at an item in this list.
+    unsafe fn remove_internal(&mut self, item: *mut ListLinksFields) -> ListArc<T, ID> {
+        // SAFETY: The caller promises that this pointer is not dangling, and there's no data race
+        // since we have a mutable reference to the list containing `item`.
+        let ListLinksFields { next, prev } = unsafe { *item };
+        // SAFETY: The pointers are ok and in the right order.
+        unsafe { self.remove_internal_inner(item, next, prev) }
+    }
+
+    /// Removes the provided item from the list.
+    ///
+    /// # Safety
+    ///
+    /// The `item` pointer must point at an item in this list, and we must have `(*item).next ==
+    /// next` and `(*item).prev == prev`.
+    unsafe fn remove_internal_inner(
+        &mut self,
+        item: *mut ListLinksFields,
+        next: *mut ListLinksFields,
+        prev: *mut ListLinksFields,
+    ) -> ListArc<T, ID> {
+        // SAFETY: We have exclusive access to items in the list, and prev/next pointers are
+        // never null for items in a list.
+        //
+        // INVARIANT: There are three cases:
+        //  * If the list has at least three items, then after removing the item, `prev` and `next`
+        //    will be next to each other.
+        //  * If the list has two items, then the remaining item will point at itself.
+        //  * If the list has one item, then `next == prev == item`, so these writes have no effect
+        //    due to the writes to `item` below.
+        unsafe {
+            (*next).prev = prev;
+            (*prev).next = next;
+        }
+        // SAFETY: We have exclusive access to items in the list.
+        // INVARIANT: The item is no longer in a list, so the pointers should be null.
+        unsafe {
+            (*item).prev = ptr::null_mut();
+            (*item).next = ptr::null_mut();
+        }
+        // INVARIANT: There are three cases:
+        //  * If `item` was not the first item, then `self.first` should remain unchanged.
+        //  * If `item` was the first item and there is another item, then we just updated
+        //    `prev->next` to `next`, which is the new first item, and setting `item->next` to null
+        //    did not modify `prev->next`.
+        //  * If `item` was the only item in the list, then `prev == item`, and we just set
+        //    `item->next` to null, so this correctly sets `first` to null now that the list is
+        //    empty.
+        if self.first == item {
+            // SAFETY: The `prev` field of an item in a list is never dangling.
+            self.first = unsafe { (*prev).next };
+        }
+
+        // SAFETY: We just removed a `ListArc` from the list, so we can turn it back into a
+        // `ListArc`.
+        unsafe { ListArc::from_raw(T::post_remove(ListLinks::from_fields(item))) }
+    }
+
+    /// Moves all items from `other` into `self`.
+    ///
+    /// The items of `other` are added to the back of `self`, so the last item of `other` becomes
+    /// the last item of `self`.
+    pub fn push_all_back(&mut self, other: &mut List<T, ID>) {
+        // First, we insert the elements into `self`. At the end, we make `other` empty.
+        if self.is_empty() {
+            // INVARIANT: All of the elements in `other` become elements of `self`.
+            self.first = other.first;
+        } else if !other.is_empty() {
+            let other_first = other.first;
+            // SAFETY: The other list is not empty, so this pointer is valid.
+            let other_last = unsafe { (*other_first).prev };
+            let self_first = self.first;
+            // SAFETY: The self list is not empty, so this pointer is valid.
+            let self_last = unsafe { (*self_first).prev };
+
+            // SAFETY: We have exclusive access to both lists, so we can update the pointers.
+            // INVARIANT: This correctly sets the pointers to merge both lists. We do not need to
+            // update `self.first` because the first element of `self` does not change.
+            unsafe {
+                (*self_first).prev = other_last;
+                (*other_last).next = self_first;
+                (*self_last).next = other_first;
+                (*other_first).prev = self_last;
+            }
+        }
+
+        // INVARIANT: The other list is now empty, so update its pointer.
+        other.first = ptr::null_mut();
+    }
+}
+
+impl<T: ?Sized + ListItem<ID>, const ID: u64> Drop for List<T, ID> {
+    fn drop(&mut self) {
+        while let Some(item) = self.pop_front() {
+            drop(item);
+        }
+    }
 }
diff --git a/rust/kernel/list/arc.rs b/rust/kernel/list/arc.rs
index 5c27491a5889..fb433a2cd253 100644
--- a/rust/kernel/list/arc.rs
+++ b/rust/kernel/list/arc.rs
@@ -101,8 +101,8 @@ fn try_new_list_arc(&self) -> bool {
 /// The `ListArc` type can be thought of as a special reference to a refcounted object that owns the
 /// permission to manipulate the `next`/`prev` pointers stored in the refcounted object. By ensuring
 /// that each object has only one `ListArc` reference, the owner of that reference is assured
-/// exclusive access to the `next`/`prev` pointers. When a `ListArc` is inserted into a `List`, the
-/// `List` takes ownership of the `ListArc` reference.
+/// exclusive access to the `next`/`prev` pointers. When a `ListArc` is inserted into a [`List`],
+/// the [`List`] takes ownership of the `ListArc` reference.
 ///
 /// There are various strategies to ensuring that a value has only one `ListArc` reference. The
 /// simplest is to convert a [`UniqueArc`] into a `ListArc`. However, the refcounted object could
@@ -121,6 +121,8 @@ fn try_new_list_arc(&self) -> bool {
 ///
 /// * Each reference counted object has at most one `ListArc` for each value of `ID`.
 /// * The tracking inside `T` is aware that a `ListArc` reference exists.
+///
+/// [`List`]: crate::list::List
 #[repr(transparent)]
 pub struct ListArc<T, const ID: u64 = 0>
 where

-- 
2.44.0.478.gd926399ef9-goog


