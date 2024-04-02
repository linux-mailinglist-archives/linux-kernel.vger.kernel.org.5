Return-Path: <linux-kernel+bounces-127915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0709B8952BF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7162E1F211F2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418F37A15B;
	Tue,  2 Apr 2024 12:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="InAaGKT2"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299BD79B8E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 12:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712060248; cv=none; b=C5hxeQ9VGksN0TecjwzR0jrLEWuplVPS3uTimK96VyAG8O1eIf+tbGOAPJvbRyMSA6NpmxvmwcWE2WERYpbf1dDwFuRlee+Qmd/mlRn2zGCIMFdAJdFjtX+N5+pBTNtncw5CIlHidOxribyCCk2Q26FQfTAZ7jpNAeRd/RlzZug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712060248; c=relaxed/simple;
	bh=scYXFXHzop4w5nE1MARFBQtsaiUQ99iycS9q58C08AA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MoLIQKMLH96M4VmFkh14917XomPsT269lj5sM4DHIfcjxGBIcnJwNacW3vrHCEeJV4MEqllQ44DUiTl+eaGPZMGjrpqNKKB3PyUH9aQPc+eRsFpsSIMtGtn4J6AVe/lc/G9sllJuVLkBP8dWxxyU8dkayk09HXCjW0JSmc4ZMQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=InAaGKT2; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61532249dcbso6012337b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 05:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712060245; x=1712665045; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mTRAKoexW03MplbH5ewhSVmvhGBv9gsHa3B5VmzHdqs=;
        b=InAaGKT2/ZpUbClvDHQ29hNCr1j/JtH8d65km2x67F3a4aguR2NtfkfiIuZC4f6Uok
         cIAanEa+mvqudbS3fwBOaSCgbiW0aIUy+oxuf1CbZAVcfh7QjXMomifB96GnF43uS6z3
         5SP8JcAJARpJfElog6jd9E46jRLARrSjoaNTltx8VY76dffqBxIdAtPKjB7zm358y10y
         xpuIyvJmNAH1PnC+QDapZvoHIxNjswCIkV69Bmg7kjQr3S5R0mfDjJBtDqwBTa9K8CxI
         fyA7hq3pH60Ry49j4oEPg/3aiO3eE9LcH/un7tRoy7Lv5GLsL4jw123NgXnUZNQR9mT0
         YO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712060245; x=1712665045;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mTRAKoexW03MplbH5ewhSVmvhGBv9gsHa3B5VmzHdqs=;
        b=ZLycWxBOWbtreRRvEdBIGe9ON3VRuk9f9qAfBOzgk0zVK8NAM817jdzFmDC1VQgZF3
         ptOKlpCSd2ob7JkNJHFJGWvFSsJtYYwntUl48vCWMWX6Zi8HKnhwGOh6sitM/piQpBqk
         rA3V8OeTqFKAxfQnkLzo1lMYOVliZeVLnNNzozsDdQA72qPT9+Mqh+VSnNZ/wifnzUvJ
         Qf7QDLDvR3ieELTbbZGhSQ0OGAkSUPZM+mmRdR2G2fTtkS6qtA1Ms/cwfnoGcwH6SgkB
         4+I/B4sHVlBWh1flQXOf4ihA/y1AdhTWUdyxaT53PA45nADDUZAqEjBKUfkqVAWSX8rt
         40tA==
X-Forwarded-Encrypted: i=1; AJvYcCWBXTOgEdZu+LqnBiE4btpRoo9YFvzoQv9o8BNgZ6iWYpHRayEkjV1Z11iPh2fMaCkQWa/ccIITr5KktB0/pa/a24DuCCQXBplEvblb
X-Gm-Message-State: AOJu0YxVS/nMa1/X1RitXLvJ/0n/XAsEdx0IOJt1pKNldlIDGflsqbhS
	5x+RZsYGd2gRrUNFS4NeNFoSPoKOR7KjhEoFuKPcLsHOwwoQB5MXC5fPwGeEvEVCY/45pOMs9nl
	F5ejnXf8i6/z/Wg==
X-Google-Smtp-Source: AGHT+IHoICpUitAruU1VmY3bIx+xHFNJYUJhCzek3lJKlsTeF4BVcZqIvLGvurW+TGFj1G8b2zaCgyBpYo72Ypg=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a81:5245:0:b0:615:1b90:d987 with SMTP id
 g66-20020a815245000000b006151b90d987mr466629ywb.6.1712060245157; Tue, 02 Apr
 2024 05:17:25 -0700 (PDT)
Date: Tue, 02 Apr 2024 12:16:59 +0000
In-Reply-To: <20240402-linked-list-v1-0-b1c59ba7ae3b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240402-linked-list-v1-0-b1c59ba7ae3b@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=9552; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=scYXFXHzop4w5nE1MARFBQtsaiUQ99iycS9q58C08AA=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmC/dIw1Rwk2A9e1u96NJVmWcgv4TpW8F7lomm0
 PeGbEjH7KCJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZgv3SAAKCRAEWL7uWMY5
 Rg8BD/9+xs82n1gZLGSwbD0q2jLJXjlqJ5lvOAULl3kt6zWXP9e8/5Ut7q4HqLIWtScJszSMSRj
 dbc9s5OsX2X0HnuSOfwye/Fe8wJEtiP5sJbYMJWJuk2MozTX3eoKsRk3qlaAfrOiSRcSk1imKtb
 LCNBV44srm5q3h1Maey2keGg1nP4mrt0OS+MvIGsynRUkhiyvIvmI6FZj68ppCRM4zEmdbho/01
 TLrPsvyOXysZhOo6Vh6J2XAsRySr6asx7eRbplGuw3ZAr10T4/pYQ3XY1ErDBBYnLvzkWbFVcNv
 TDaXbokX3cgl228DfIaBxfXoC6EHkn7vG/M8L6xlanLLCCKVb61dyKJRO7hZyUTtmYj//jSsJ+U
 xWkxoJ58vTjOsx8Vke1d1LJaZ1BfTxAKujavzC4I+Bwfsooxo8pYd3WV+Xk2wVaoHhXV2M/Iiqg
 qUfY7fb2Su17es1AaUBxfRcMPe7HypSW5JB5QHN3sTfP2uLPuvp3FRLEDyOsAsTG72bBkK5UXtm
 jYRpfprGornzkJE68z1440bWzmqRkTXT1Kyz34JZ8IHPOCgDn7sdEHahOBO96tTilEUbNbXud6t
 EGjUGBHI1lryJ8fy0eIOdo23U5hjeSzQv2FEvnFYCtr+0NRP4B5rTJARVjKsPo3c10oAYiuChNp aIHn/E/1lpGzv/Q==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240402-linked-list-v1-2-b1c59ba7ae3b@google.com>
Subject: [PATCH 2/9] rust: list: add tracking for ListArc
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

Add the ability to track whether a ListArc exists for a given value,
allowing for the creation of ListArcs without going through UniqueArc.

The `impl_list_arc_safe!` macro is extended with a `tracked_by` strategy
that defers the tracking of ListArcs to a field of the struct.
Additionally, the AtomicListArcTracker type is introduced, which can
track whether a ListArc exists using an atomic. By deferring the
tracking to a field of type AtomicListArcTracker, structs gain the
ability to create ListArcs without going through a UniqueArc.

Rust Binder uses this for some objects where we want to be able to
insert them into a linked list at any time. Using the
AtomicListArcTracker, we are able to check whether an item is already in
the list, and if not, we can create a `ListArc` and push it.

The macro has the ability to defer the tracking of ListArcs to a field,
using whatever strategy that field has. Since we don't add any
strategies other than AtomicListArcTracker, another similar option would
be to hard-code that the field should be an AtomicListArcTracker.
However, Rust Binder has a case where the AtomicListArcTracker is not
stored directly in the struct, but in a sub-struct. Furthermore, the
outer struct is generic:

struct Wrapper<T: ?Sized> {
    links: ListLinks,
    inner: T,
}

Here, the Wrapper struct implements ListArcSafe with `tracked_by inner`,
and then the various types used with `inner` also uses the macro to
implement ListArcSafe. Some of them use the untracked strategy, and some
of them use tracked_by with an AtomicListArcTracker. This way, Wrapper
just inherits whichever choice `inner` has made.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/list.rs     |   4 +-
 rust/kernel/list/arc.rs | 133 ++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 133 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
index fb16ea43b2ba..c5caa0f6105c 100644
--- a/rust/kernel/list.rs
+++ b/rust/kernel/list.rs
@@ -5,4 +5,6 @@
 //! A linked list implementation.
 
 mod arc;
-pub use self::arc::{impl_list_arc_safe, ListArc, ListArcSafe};
+pub use self::arc::{
+    impl_list_arc_safe, AtomicListArcTracker, ListArc, ListArcSafe, TryNewListArc,
+};
diff --git a/rust/kernel/list/arc.rs b/rust/kernel/list/arc.rs
index 59d43f7a165e..5c27491a5889 100644
--- a/rust/kernel/list/arc.rs
+++ b/rust/kernel/list/arc.rs
@@ -8,9 +8,10 @@
 use crate::prelude::*;
 use crate::sync::{Arc, ArcBorrow, UniqueArc};
 use core::alloc::AllocError;
-use core::marker::Unsize;
+use core::marker::{PhantomPinned, Unsize};
 use core::ops::Deref;
 use core::pin::Pin;
+use core::sync::atomic::{AtomicBool, Ordering};
 
 /// Declares that this type has some way to ensure that there is exactly one `ListArc` instance for
 /// this id.
@@ -33,19 +34,64 @@ pub trait ListArcSafe<const ID: u64 = 0> {
     unsafe fn on_drop_list_arc(&self);
 }
 
+/// Declares that this type is able to safely attempt to create `ListArc`s at any time.
+///
+/// # Safety
+///
+/// Implementers must ensure that `try_new_list_arc` does not return `true` if a `ListArc` already
+/// exists.
+pub unsafe trait TryNewListArc<const ID: u64 = 0>: ListArcSafe<ID> {
+    /// Attempts to convert an `Arc<Self>` into an `ListArc<Self>`. Returns `true` if the
+    /// conversion was successful.
+    fn try_new_list_arc(&self) -> bool;
+}
+
 /// Declares that this type supports [`ListArc`].
 ///
-/// When using this macro, it will only be possible to create a [`ListArc`] from a [`UniqueArc`].
+/// When using this macro, you may choose between the `untracked` strategy where it is not tracked
+/// whether a [`ListArc`] exists, and the `tracked_by` strategy where the tracking is deferred to a
+/// field of the struct. The `tracked_by` strategy can be combined with a field of type
+/// [`AtomicListArcTracker`] to track whether a [`ListArc`] exists.
 #[macro_export]
 macro_rules! impl_list_arc_safe {
     (impl$({$($generics:tt)*})? ListArcSafe<$num:tt> for $t:ty { untracked; } $($rest:tt)*) => {
-        impl$(<$($generics)*>)? $crate::list::ListArcSafe<$num> for $t {
+        impl$(<$($generics)*>)? ListArcSafe<$num> for $t {
             unsafe fn on_create_list_arc_from_unique(&mut self) {}
             unsafe fn on_drop_list_arc(&self) {}
         }
         $crate::list::impl_list_arc_safe! { $($rest)* }
     };
 
+    (impl$({$($generics:tt)*})? ListArcSafe<$num:tt> for $t:ty {
+        tracked_by $field:ident : $fty:ty;
+    } $($rest:tt)*) => {
+        impl$(<$($generics)*>)? ListArcSafe<$num> for $t {
+            unsafe fn on_create_list_arc_from_unique(&mut self) {
+                let me = self as *mut Self;
+                let field: *mut $fty = unsafe { ::core::ptr::addr_of_mut!((*me).$field) };
+                unsafe { <$fty as $crate::list::ListArcSafe<$num>>::on_create_list_arc_from_unique(
+                        &mut *field
+                ) };
+            }
+            unsafe fn on_drop_list_arc(&self) {
+                let me = self as *const Self;
+                let field: *const $fty = unsafe { ::core::ptr::addr_of!((*me).$field) };
+                unsafe { <$fty as $crate::list::ListArcSafe<$num>>::on_drop_list_arc(&*field) };
+            }
+        }
+        unsafe impl$(<$($generics)*>)? TryNewListArc<$num> for $t
+        where
+            $fty: TryNewListArc<$num>,
+        {
+            fn try_new_list_arc(&self) -> bool {
+                let me = self as *const Self;
+                let field: *const $fty = unsafe { ::core::ptr::addr_of!((*me).$field) };
+                unsafe { <$fty as $crate::list::TryNewListArc<$num>>::try_new_list_arc(&*field) }
+            }
+        }
+        $crate::list::impl_list_arc_safe! { $($rest)* }
+    };
+
     () => {};
 }
 pub use impl_list_arc_safe;
@@ -166,6 +212,36 @@ pub fn pair_from_pin_unique<const ID2: u64>(
         Self::pair_from_unique(unsafe { Pin::into_inner_unchecked(unique) })
     }
 
+    /// Try to create a new `ListArc`.
+    ///
+    /// This fails if this value already has a `ListArc`.
+    pub fn try_from_arc(arc: Arc<T>) -> Result<Self, Arc<T>>
+    where
+        T: TryNewListArc<ID>,
+    {
+        if arc.try_new_list_arc() {
+            // SAFETY: The `try_new_list_arc` method returned true, so the tracking now thinks that
+            // a `ListArc` exists, so we can create one.
+            Ok(unsafe { Self::transmute_from_arc(arc) })
+        } else {
+            Err(arc)
+        }
+    }
+
+    /// Try to create a new `ListArc`.
+    ///
+    /// If it's not possible to create a new `ListArc`, then the `Arc` is dropped. This will never
+    /// run the destructor of the value.
+    pub fn try_from_arc_or_drop(arc: Arc<T>) -> Option<Self>
+    where
+        T: TryNewListArc<ID>,
+    {
+        match Self::try_from_arc(arc) {
+            Ok(list_arc) => Some(list_arc),
+            Err(arc) => Arc::into_unique_or_drop(arc).map(Self::from_pin_unique),
+        }
+    }
+
     /// Transmutes an [`Arc`] into a `ListArc` without updating the tracking inside `T`.
     ///
     /// # Safety
@@ -300,3 +376,54 @@ impl<T, U, const ID: u64> core::ops::DispatchFromDyn<ListArc<U, ID>> for ListArc
     U: ListArcSafe<ID> + ?Sized,
 {
 }
+
+/// A utility for tracking whether a [`ListArc`] exists using an atomic.
+///
+/// # Invariant
+///
+/// If the boolean is `false`, then there is no [`ListArc`] for this value.
+#[repr(transparent)]
+pub struct AtomicListArcTracker<const ID: u64 = 0> {
+    inner: AtomicBool,
+    _pin: PhantomPinned,
+}
+
+impl<const ID: u64> AtomicListArcTracker<ID> {
+    /// Creates a new initializer for this type.
+    pub fn new() -> impl PinInit<Self> {
+        // INVARIANT: Pin-init initializers can't be used on an existing `Arc`, so this value will
+        // not be constructed in an `Arc` that already has a `ListArc`.
+        Self {
+            inner: AtomicBool::new(false),
+            _pin: PhantomPinned,
+        }
+    }
+}
+
+impl<const ID: u64> ListArcSafe<ID> for AtomicListArcTracker<ID> {
+    unsafe fn on_create_list_arc_from_unique(&mut self) {
+        // INVARIANT: We just created a ListArc, so the boolean should be true.
+        *self.inner.get_mut() = true;
+    }
+
+    unsafe fn on_drop_list_arc(&self) {
+        // INVARIANT: We just dropped a ListArc, so the boolean should be false.
+        self.inner.store(false, Ordering::Release);
+    }
+}
+
+// SAFETY: If this method returns `true`, then by the type invariant there is no `ListArc` before
+// this call, so it is okay to create a new `ListArc`.
+//
+// The acquire ordering will synchronize with the release store from the destruction of any
+// previous `ListArc`, so if there was a previous `ListArc`, then the destruction of the previous
+// `ListArc` happens-before the creation of the new `ListArc`.
+unsafe impl<const ID: u64> TryNewListArc<ID> for AtomicListArcTracker<ID> {
+    fn try_new_list_arc(&self) -> bool {
+        // INVARIANT: If this method returns true, then the boolean used to be false, and is no
+        // longer false, so it is okay for the caller to create a new [`ListArc`].
+        self.inner
+            .compare_exchange(false, true, Ordering::Acquire, Ordering::Relaxed)
+            .is_ok()
+    }
+}

-- 
2.44.0.478.gd926399ef9-goog


