Return-Path: <linux-kernel+bounces-127922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC738952C6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ECEC1C219DB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C5985285;
	Tue,  2 Apr 2024 12:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uaDFyCPa"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9A984FC5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 12:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712060264; cv=none; b=R8DjyLSm6sbT2ZDg/5OPsKourTLyM81ciJiUylfjXfk65/VHSkroEQyTZdvh8fTK4FKIk1cKdgJQDqg/I7QgKlNUdO84yxC00WYaasrwCN5RrRsm8SdxNSSSXai+ClqHKaNmJh+c+xEI65VKHldqg3dV1sWJCHjyMyDWumDiuSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712060264; c=relaxed/simple;
	bh=J0Jh3hYB6HWSSdkv+IspL6k5u56qOC9WzYHDNcC68vs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LJFWg6ZCWG79bS6fd10yzhKd/Q1HdZCxJA/VXyxjrM4feyETfsicd6BHbeH5CTx51Ejj6YUUPWPm8slCPsMlGxWKx2kmuV/r1SRSUvwPIZPq+M++KUfpCry/6YSeAN1TENYFVaU+8HVKwi5RQGlVNbpYzYCPU3+26esUsfTL08M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uaDFyCPa; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-ddaf165a8d9so8104074276.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 05:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712060262; x=1712665062; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Tyr94/cMd+89WcGierBr9QiSC3Rmvpo4zWfjcOluIM=;
        b=uaDFyCPapW25sUfJwYT/W9NYNw9PPwOFbjTKDEjy0dbnZse24dI9mdW+pc48I4o2vT
         Q5Mz+Q3Dc0HzArwB48/BhpRY7esTvGoy6rH93BcN/ysTrOEd5j7c0dzEBAyjKFk/G2f7
         kVxxVy6jgQ16iOwiWuSvFBDoYkTPMvpxuyS36UiHQ5eoex0mwE1KrA9sr6cAB4RdiS3A
         5CDOX/K0LGhWruo0s9xONj4BCnomufzxZwNINPDzH5jlcL8A38E5B7nNAT7EJ0KcdNbL
         to1mUoIuywl7h+C/gs1HAtgERWaaprA3FLYKzqCTktXhpQWSbnlyh4wvAgtIF571Ol5X
         V9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712060262; x=1712665062;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Tyr94/cMd+89WcGierBr9QiSC3Rmvpo4zWfjcOluIM=;
        b=cpHAWriUC/lS6MP6VoKSn5G6Gv+NDXu7bWQ4g4fyZ//4OpLZWSozubbKOZ1zV5G3yZ
         zf4rOdfmVU2sxMirMJRwflSjjTVPuDHdxFy0QeG/MfblL+yb+zBeWiqBHQmTHBg4Cs+4
         7UbLiuVegbIWkLpd+a1wKcnCNfhG4FPhiz4OQrovxhWX1tMh97TuKM86H7QEdJEB3duC
         DSloqIwfP+VezDpuPuY4s64jlqo3EgW2eKEnwbUiuJN/UPG39MVTEF9XFPKVQr88rlTH
         /2DBN37a9y+T2IhucFfwItRCoShltplqNdrhe/lgCu6K61DJlw2WN2cJZo6YgDwY7sTv
         fIgw==
X-Forwarded-Encrypted: i=1; AJvYcCWPzQr1kEQmTjfW9cKVTnWJbrWdrbeaDJ2TM4jasblRAs6D3C8BC/+9loWM3YeEhlS0kZ2cLtRhmZ2WwbFWMbTkpnfd35qXRD4b41Sz
X-Gm-Message-State: AOJu0Yy6eBUzteYBKfQHkoHE6Dm0J0h9wc1sg7n+V6q0GiT5VX4398Vg
	X4HzXWJ9Ys5pkduZb3IO4g+jFRw1qo/jpiKBbjoW+OqZfEyWMlxBt0/7cm4v5HPTBRXCXRQ1Zdq
	jXcxeJkqiO9hZyg==
X-Google-Smtp-Source: AGHT+IFTjzoYfa2x4oO3N22MhhWPdj/upe9zDI7L9XGf4fVbRKO6R5U6EdgVaucUFmhRDxL4+GKl20rl8ONfse4=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:e0f:b0:dc6:44d4:bee0 with SMTP
 id df15-20020a0569020e0f00b00dc644d4bee0mr991972ybb.7.1712060261782; Tue, 02
 Apr 2024 05:17:41 -0700 (PDT)
Date: Tue, 02 Apr 2024 12:17:05 +0000
In-Reply-To: <20240402-linked-list-v1-0-b1c59ba7ae3b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240402-linked-list-v1-0-b1c59ba7ae3b@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7586; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=J0Jh3hYB6HWSSdkv+IspL6k5u56qOC9WzYHDNcC68vs=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmC/dMPX59PXbjId2FA6AFETGnwlkw0cpkapDjK
 7yxuRg1V7eJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZgv3TAAKCRAEWL7uWMY5
 RqC6D/4sLGpfyiHscoXLi7CCpfZVNzQ+XWMmRNgwBreVPgN45xNW8B3nwmF2caStb/6WORMtBnI
 h9uwIlCZmyHFQSldUINrosPNVunUypZUXXFwNn6iD1jQ1LSQzfu/sf6k7ILz8XgsOJBmA2Y5vAV
 miaTdlyD6egr/oVXjVpbyVhtTOJ548D6ojK1VQF63lIAqNx6J+r+HjiVPeWIMDiQFm5Vw3ydIol
 Z54v70887rmChqHllNlAjVQN4aasrf4W0PL5U4jPppK0iDyin6q2NQ838/3t9TGxE/xSuI9Z6ZW
 +0XjHMJjA4XdltV0YpFqD2e0DONXSjh100rOGs/czlwZhE+3ED/BUB5nUoXJsiSgMkeHCRNsCMO
 vB13lxBVQZWtTaIRqNY6fLgDDIxu/lTD6APZercjAc85IapVp40i6QgmK4fI5LNQSMflSkoNOzU
 PvWtiyVIYhzxgiB7kLLyWcTIvGxrQgfs5dh3deEDGU2WuQVbVO/iIKu2+7HF0kdaoXvl7FRNoAx
 U0b0VJPzY+JUq6cyUKUZe+iJ8euuAPnnM3/pCtmsOQeGe6XFDNpEkYqC3IHGBahfCBYgYFdiTuo
 nfIYJu/rhtHACDzqXDSbIOyXh4xeypyqFcMs4u0UIFOshcfI0HJDhnBDNf/HxRJr9QGJHKZlXN0 zlVnkXh5oSNVNeg==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240402-linked-list-v1-8-b1c59ba7ae3b@google.com>
Subject: [PATCH 8/9] rust: list: support heterogeneous lists
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

Support linked lists that can have many different structs at once. This
is generally done using trait objects. The main challenge is figuring
what the struct is given only a pointer to the ListLinks.

We do this by storing a pointer to the struct next to the ListLinks
field. The container_of operation will then just read that pointer. When
the type is a trait object, that pointer will be a fat pointer whose
metadata is a vtable that tells you what kind of struct it is.

Heterogeneous lists are heavily used by Rust Binder. There are a lot of
so-called todo lists containing various events that need to be delivered
to userspace next time userspace calls into the driver. And there are
quite a few different todo item types: incoming transaction, changes to
refcounts, death notifications, and more.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/list.rs                    | 41 ++++++++++++++++-
 rust/kernel/list/impl_list_item_mod.rs | 83 ++++++++++++++++++++++++++++++++++
 2 files changed, 123 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
index 47e52818c7bd..68d03b100863 100644
--- a/rust/kernel/list.rs
+++ b/rust/kernel/list.rs
@@ -7,12 +7,16 @@
 use crate::init::PinInit;
 use crate::sync::ArcBorrow;
 use crate::types::Opaque;
+use core::cell::UnsafeCell;
 use core::iter::{DoubleEndedIterator, FusedIterator};
 use core::marker::PhantomData;
+use core::mem::MaybeUninit;
 use core::ptr;
 
 mod impl_list_item_mod;
-pub use self::impl_list_item_mod::{impl_has_list_links, impl_list_item, HasListLinks};
+pub use self::impl_list_item_mod::{
+    impl_has_list_links, impl_has_list_links_self_ptr, impl_list_item, HasListLinks, HasSelfPtr,
+};
 
 mod arc;
 pub use self::arc::{
@@ -180,6 +184,41 @@ unsafe fn from_fields(me: *mut ListLinksFields) -> *mut Self {
     }
 }
 
+/// Similar to [`ListLinks`], but also contains a pointer to the full value.
+///
+/// This type can be used instead of [`ListLinks`] to support lists with trait objects.
+#[repr(C)]
+pub struct ListLinksSelfPtr<T: ?Sized, const ID: u64 = 0> {
+    /// The `ListLinks` field inside this value.
+    ///
+    /// This is public so that it can be used with `impl_has_list_links!`.
+    pub inner: ListLinks<ID>,
+    self_ptr: UnsafeCell<MaybeUninit<*const T>>,
+}
+
+unsafe impl<T: ?Sized + Send, const ID: u64> Send for ListLinksSelfPtr<T, ID> {}
+unsafe impl<T: ?Sized + Sync, const ID: u64> Sync for ListLinksSelfPtr<T, ID> {}
+
+impl<T: ?Sized, const ID: u64> ListLinksSelfPtr<T, ID> {
+    /// The offset from the [`ListLinks`] to the self pointer field.
+    pub const LIST_LINKS_SELF_PTR_OFFSET: usize = core::mem::offset_of!(Self, self_ptr);
+
+    /// Creates a new initializer for this type.
+    pub fn new() -> impl PinInit<Self> {
+        // INVARIANT: Pin-init initializers can't be used on an existing `Arc`, so this value will
+        // not be constructed in an `Arc` that already has a `ListArc`.
+        Self {
+            inner: ListLinks {
+                inner: Opaque::new(ListLinksFields {
+                    prev: ptr::null_mut(),
+                    next: ptr::null_mut(),
+                }),
+            },
+            self_ptr: UnsafeCell::new(MaybeUninit::zeroed()),
+        }
+    }
+}
+
 impl<T: ?Sized + ListItem<ID>, const ID: u64> List<T, ID> {
     /// Creates a new empty list.
     pub const fn new() -> Self {
diff --git a/rust/kernel/list/impl_list_item_mod.rs b/rust/kernel/list/impl_list_item_mod.rs
index 9e2f6d6d4786..6884d8a3e710 100644
--- a/rust/kernel/list/impl_list_item_mod.rs
+++ b/rust/kernel/list/impl_list_item_mod.rs
@@ -61,6 +61,49 @@ unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut $crate::list::ListLinks$(<$
 }
 pub use impl_has_list_links;
 
+/// Declares that the `ListLinks<ID>` field in this struct is inside a `ListLinksSelfPtr<T, ID>`.
+///
+/// # Safety
+///
+/// The `ListLinks<ID>` field of this struct at the offset `HasListLinks<ID>::OFFSET` must be
+/// inside a `ListLinksSelfPtr<T, ID>`.
+pub unsafe trait HasSelfPtr<T: ?Sized, const ID: u64 = 0>
+where
+    Self: HasListLinks<ID>,
+{
+}
+
+/// Implements the [`HasListLinks`] and [`HasSelfPtr`] traits for the given type.
+#[macro_export]
+macro_rules! impl_has_list_links_self_ptr {
+    ($(impl$({$($implarg:tt)*})?
+       HasSelfPtr<$item_type:ty $(, $id:tt)?>
+       for $self:ident $(<$($selfarg:ty),*>)?
+       { self.$field:ident }
+    )*) => {$(
+        // SAFETY: The implementation of `raw_get_list_links` only compiles if the field has the
+        // right type.
+        unsafe impl$(<$($implarg)*>)? $crate::list::HasSelfPtr<$item_type $(, $id)?> for
+            $self $(<$($selfarg),*>)?
+        {}
+
+        unsafe impl$(<$($implarg)*>)? $crate::list::HasListLinks$(<$id>)? for
+            $self $(<$($selfarg),*>)?
+        {
+            const OFFSET: usize = ::core::mem::offset_of!(Self, $field) as usize;
+
+            #[inline]
+            unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut $crate::list::ListLinks$(<$id>)? {
+                // SAFETY: The caller promises that the pointer is not dangling.
+                let ptr: *mut $crate::list::ListLinksSelfPtr<$item_type $(, $id)?> =
+                    unsafe { ::core::ptr::addr_of_mut!((*ptr).$field) };
+                ptr.cast()
+            }
+        }
+    )*};
+}
+pub use impl_has_list_links_self_ptr;
+
 /// Implements the [`ListItem`] trait for the given type.
 ///
 /// Assumes that the type implements [`HasListLinks`].
@@ -94,5 +137,45 @@ unsafe fn post_remove(me: *mut ListLinks<$num>) -> *const Self {
             }
         }
     };
+
+    (
+        impl$({$($generics:tt)*})? ListItem<$num:tt> for $t:ty {
+            using ListLinksSelfPtr;
+        } $($rest:tt)*
+    ) => {
+        unsafe impl$(<$($generics)*>)? ListItem<$num> for $t {
+            unsafe fn prepare_to_insert(me: *const Self) -> *mut ListLinks<$num> {
+                let links_field = unsafe { Self::view_links(me) };
+
+                let spoff = ListLinksSelfPtr::<Self, $num>::LIST_LINKS_SELF_PTR_OFFSET;
+                let self_ptr = unsafe { (links_field as *const u8).add(spoff)
+                    as *const ::core::cell::UnsafeCell<*const Self> };
+                let cell_inner = ::core::cell::UnsafeCell::raw_get(self_ptr);
+
+                unsafe { ::core::ptr::write(cell_inner, me) };
+                links_field
+            }
+
+            unsafe fn view_links(me: *const Self) -> *mut ListLinks<$num> {
+                unsafe {
+                    <Self as HasListLinks<$num>>::raw_get_list_links(me.cast_mut())
+                }
+            }
+
+            unsafe fn view_value(links_field: *mut ListLinks<$num>) -> *const Self {
+                let spoff = ListLinksSelfPtr::<Self, $num>::LIST_LINKS_SELF_PTR_OFFSET;
+                let self_ptr = unsafe { (links_field as *const u8).add(spoff)
+                    as *const ::core::cell::UnsafeCell<*const Self> };
+                let cell_inner = ::core::cell::UnsafeCell::raw_get(self_ptr);
+                unsafe {
+                    ::core::ptr::read(cell_inner)
+                }
+            }
+
+            unsafe fn post_remove(me: *mut ListLinks<$num>) -> *const Self {
+                unsafe { Self::view_value(me) }
+            }
+        }
+    };
 }
 pub use impl_list_item;

-- 
2.44.0.478.gd926399ef9-goog


