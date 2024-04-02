Return-Path: <linux-kernel+bounces-127914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA078952BD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EFE31C22FE8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB3A75813;
	Tue,  2 Apr 2024 12:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bPCbnoQ1"
Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1658679B87
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 12:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712060246; cv=none; b=TBmXseXURQc2cRt3TVUiaSlRAwrmFjQmTXgIGhuLXMYa6FUdWCn6hIitjw2VCRR8x88JemDf4dYebZSW+K2BT/6DuRSQob4wytgpBMaBgGgZTndhLjvBu79Rh/18tQrSkJQ+8RzyKi3lGJy1oh0hQ5kb/JArLf7asaz1oy5+VBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712060246; c=relaxed/simple;
	bh=UsgURBv1RSxzn/fF5mwt730A2fCdSeYuA/w0Xn161Pc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qZkWzQQN7XpsBfVcjWsKFpzJoFp9kAve7WzW76fIsQxOE39gzWejDjf7FWpZYiTQ2agx8ntVoI70TydunCu7I4Mq9x5UHnnL2XvubhhH/JYRxMnoUOUoxsYzZzSJSmMUH1zzUPEpabPlXvHT/ytH2e57i8NAkKXHKRFi03YbJ8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bPCbnoQ1; arc=none smtp.client-ip=209.85.208.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-2d49fa5dfadso43483081fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 05:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712060242; x=1712665042; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wNss3TAREtZqEbxJmtLJ3dGzF3KHzOFkRpA9FxPuLR4=;
        b=bPCbnoQ1zBRKEbrORJpcuzORrjt394n6BYSEhhPgdtB9XtRmhSM6jmFb7aZxEKzqm2
         Q1Bd24AZIY0WRbTcXGvJ4p2kLVdEjWwCbAUhbyYs2sK6pZ49F5NOiw/FQ3HAY7o6YTUb
         BMNtMAfBhBr9ZasNrzTt83VPncczLeVocieCFg8c9L4Fyy6NFlFNZMn7Nl4emuc4rp+e
         SEC+LwLS2k4L13W4QrdFlgsQUhWBOrsIp3lNoZIwR1oJjP6HAn/XUt1stJoEXi9R7GKt
         dF+uZDlRL4dsumEkSIeolLpFLAUOhgedrOQkmOGvNEeKyxavQ9dgjlXdK3G/bZXosbXk
         yweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712060242; x=1712665042;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wNss3TAREtZqEbxJmtLJ3dGzF3KHzOFkRpA9FxPuLR4=;
        b=QVcVtOa5oAMy7Wvqh9KKl7Di+DcbqS18rYyTXCoyUib5VCPV79qqwxODIgVtbwCkih
         Fj2Pqg61c1LVaQf9TvpcVAEfXYvbiEyN/p6gQospbq2iG8v6oW5IlnSAwJoKqS+v/DRJ
         oaVSFbHoCBiRnUOPTaVoAADX7qszlrrfr79TsIsLr0m55/wZvWALxRbywP0Do+1oE76x
         Or7p2k1EOjWoYc3Kk2vSCv5ezD6g7VOlfEbWyqewBMlNSSHV0a7uvRPA1scxCL648cU8
         LcKCQaALvOg0BQ9BOv/oY+WUp9nPpWRxPDnhAKJtT105dw6HjtP87gAbSSbu1MOHXpQd
         cBYw==
X-Forwarded-Encrypted: i=1; AJvYcCUPTqkSnhbRfOhd/2eX25ZW+gaohWu9T8ZVpBtcaBrkR41n4AcmFXznSv4Vx/p7S5Xx0PtGTTt2E0jlK5gXYI6yjut/2PfxUzy+DmPZ
X-Gm-Message-State: AOJu0Yw26hvZSFaJobKFIn/n9mumxwDlkD7n6tnZhC+U498J98TOIubI
	Jknm0Wt4jpgaZCIICeT5FyRsFzgygAaUyjvOxmyzWmju/dNM7qUO1jR02GhErzxNW1SgeM/L8Ls
	I8dRDzD9HVIMUxA==
X-Google-Smtp-Source: AGHT+IEHd11XDAbdZqpuVWb0FnsZI5epowbsAfJCgssim6jwtjRT/nyIZKdakENmtvX9/jpYXuHn8ckrpXIqnIs=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:a549:0:b0:2d6:b6d6:e875 with SMTP id
 e9-20020a2ea549000000b002d6b6d6e875mr15502ljn.0.1712060241964; Tue, 02 Apr
 2024 05:17:21 -0700 (PDT)
Date: Tue, 02 Apr 2024 12:16:58 +0000
In-Reply-To: <20240402-linked-list-v1-0-b1c59ba7ae3b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240402-linked-list-v1-0-b1c59ba7ae3b@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=15906; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=UsgURBv1RSxzn/fF5mwt730A2fCdSeYuA/w0Xn161Pc=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmC/dIv9x8o4CrN9dBpZXjjPH0S6/VI2E65Rlc1
 139E5SuHoaJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZgv3SAAKCRAEWL7uWMY5
 RsMSD/9ZM3dZdnWP7m9IhyXSA6svrXMYAVDNdkCbdwFk2sIvpKNFwq5SpqRuC5mFRBUmOOBJbbW
 ylOrzqXmGmpuXCCzSAa9lt8g5xDaAXxJC27kq9dcb7Q4/88WJXWUrDDMrxlQLxyjGakF9hGkCms
 jeBzPZGY0fPZeRcpXBIrdTfD6UF2U3nhz1CddY8/fsfSfNWJVtAzMibcYnj5J/Zo/95Rq715lz/
 jG75JqgQtY4A057D28ChEnt6T6FFhg6QIgLmenjS+ecQ3SGVhtAn2MiKgnusyl3cvJbPugQ8hTO
 yCET3J1tXxW6CL+pk2YKCX9HqG6swDT1QEeh/fSJl5AkGsR8lw+Z7QpWLIzQ2x439Ldt7AwyqsX
 fRdGm7xu3mK7aI5rH6/gnMH2TkH6dm1YYoW9YbKBdRR672DhAi3O4V8N0HmXsZDxe62eoRKxhNe
 I8ExrKZ3RTdlmmC2fXQmEWgU+aAftAy+vIRrTA10jPiAHTcUoGenV7mr9/Ozc/ffP5L/CNM54yr
 8Tek67ZLC+vZZPuxBuNfv8UExMYPdBaeigIQCRetGmovfz9K3AYISibHAoeY/xqCWg6eclLhPbl
 YkWM15TUZNyUPXmASMy3UHWLSMiHM7GOnvPERly8vXP+Ldk9My61t4HGDL3BGCZkJO9vQcCXlDW n12p9lRV8QrTrcQ==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240402-linked-list-v1-1-b1c59ba7ae3b@google.com>
Subject: [PATCH 1/9] rust: list: add ListArc
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

The `ListArc` type can be thought of as a special reference to a
refcounted object that owns the permission to manipulate the
`next`/`prev` pointers stored in the refcounted object. By ensuring that
each object has only one `ListArc` reference, the owner of that
reference is assured exclusive access to the `next`/`prev` pointers.
When a `ListArc` is inserted into a `List`, the `List` takes ownership
of the `ListArc` reference.

There are various strategies for ensuring that a value has only one
`ListArc` reference. The simplest is to convert a `UniqueArc` into a
`ListArc`. However, the refcounted object could also keep track of
whether a `ListArc` exists using a boolean, which could allow for the
creation of new `ListArc` references from an `Arc` reference. Whatever
strategy is used, the relevant tracking is referred to as "the tracking
inside `T`", and the `ListArcSafe` trait (and its subtraits) are used to
update the tracking when a `ListArc` is created or destroyed.

Note that we allow the case where the tracking inside `T` thinks that a
`ListArc` exists, but actually, there isn't a `ListArc`. However, we do
not allow the opposite situation where a `ListArc` exists, but the
tracking thinks it doesn't. This is because the former can at most
result in us failing to create a `ListArc` when the operation could
succeed, whereas the latter can result in the creation of two `ListArc`
references.

This patch introduces the `impl_list_arc_safe!` macro that allows you to
implement `ListArcSafe` for types using the strategy where a `ListArc`
can only be created from a `UniqueArc`. Other strategies are introduced
in later patches.

This is part of the linked list that Rust Binder will use for many
different things. The strategy where a `ListArc` can only be created
from a `UniqueArc` is actually sufficient for most of the objects that
Rust Binder needs to insert into linked lists. Usually, these are todo
items that are created and then immediately inserted into a queue.

The const generic ID allows objects to have several prev/next pointer
pairs so that the same object can be inserted into several different
lists. You are able to have several `ListArc` references as long as they
correspond to different pointer pairs. The ID itself is purely a
compile-time concept and will not be present in the final binary. Both
the `List` and the `ListArc` will need to agree on the ID for them to
work together. Rust Binder uses this in a few places (e.g. death
recipients) where the same object can be inserted into both generic todo
lists and some other lists for tracking the status of the object.

The ID is a const generic rather than a type parameter because the
`pair_from_unique` method needs to be able to assert that the two ids
are different. There's no easy way to assert that when using types
instead of integers.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/lib.rs      |   1 +
 rust/kernel/list.rs     |   8 ++
 rust/kernel/list/arc.rs | 302 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 311 insertions(+)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index be68d5e567b1..30080328b740 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -37,6 +37,7 @@
 pub mod ioctl;
 #[cfg(CONFIG_KUNIT)]
 pub mod kunit;
+pub mod list;
 #[cfg(CONFIG_NET)]
 pub mod net;
 pub mod prelude;
diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
new file mode 100644
index 000000000000..fb16ea43b2ba
--- /dev/null
+++ b/rust/kernel/list.rs
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! A linked list implementation.
+
+mod arc;
+pub use self::arc::{impl_list_arc_safe, ListArc, ListArcSafe};
diff --git a/rust/kernel/list/arc.rs b/rust/kernel/list/arc.rs
new file mode 100644
index 000000000000..59d43f7a165e
--- /dev/null
+++ b/rust/kernel/list/arc.rs
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! A wrapper around `Arc` for linked lists.
+
+use crate::error;
+use crate::prelude::*;
+use crate::sync::{Arc, ArcBorrow, UniqueArc};
+use core::alloc::AllocError;
+use core::marker::Unsize;
+use core::ops::Deref;
+use core::pin::Pin;
+
+/// Declares that this type has some way to ensure that there is exactly one `ListArc` instance for
+/// this id.
+pub trait ListArcSafe<const ID: u64 = 0> {
+    /// Informs the tracking inside this type that it now has a [`ListArc`] reference.
+    ///
+    /// This method may be called even if the tracking inside this type thinks that a `ListArc`
+    /// reference exists. (But only if that's not actually the case.)
+    ///
+    /// # Safety
+    ///
+    /// Must not be called if a [`ListArc`] already exist for this value.
+    unsafe fn on_create_list_arc_from_unique(&mut self);
+
+    /// Informs the tracking inside this type that there is no [`ListArc`] reference anymore.
+    ///
+    /// # Safety
+    ///
+    /// Must only be called if there is no [`ListArc`] reference, but the tracking thinks there is.
+    unsafe fn on_drop_list_arc(&self);
+}
+
+/// Declares that this type supports [`ListArc`].
+///
+/// When using this macro, it will only be possible to create a [`ListArc`] from a [`UniqueArc`].
+#[macro_export]
+macro_rules! impl_list_arc_safe {
+    (impl$({$($generics:tt)*})? ListArcSafe<$num:tt> for $t:ty { untracked; } $($rest:tt)*) => {
+        impl$(<$($generics)*>)? $crate::list::ListArcSafe<$num> for $t {
+            unsafe fn on_create_list_arc_from_unique(&mut self) {}
+            unsafe fn on_drop_list_arc(&self) {}
+        }
+        $crate::list::impl_list_arc_safe! { $($rest)* }
+    };
+
+    () => {};
+}
+pub use impl_list_arc_safe;
+
+/// A wrapper around [`Arc`] that's guaranteed unique for the given id.
+///
+/// The `ListArc` type can be thought of as a special reference to a refcounted object that owns the
+/// permission to manipulate the `next`/`prev` pointers stored in the refcounted object. By ensuring
+/// that each object has only one `ListArc` reference, the owner of that reference is assured
+/// exclusive access to the `next`/`prev` pointers. When a `ListArc` is inserted into a `List`, the
+/// `List` takes ownership of the `ListArc` reference.
+///
+/// There are various strategies to ensuring that a value has only one `ListArc` reference. The
+/// simplest is to convert a [`UniqueArc`] into a `ListArc`. However, the refcounted object could
+/// also keep track of whether a `ListArc` exists using a boolean, which could allow for the
+/// creation of new `ListArc` references from an [`Arc`] reference. Whatever strategy is used, the
+/// relevant tracking is referred to as "the tracking inside `T`", and the [`ListArcSafe`] trait
+/// (and its subtraits) are used to update the tracking when a `ListArc` is created or destroyed.
+///
+/// Note that we allow the case where the tracking inside `T` thinks that a `ListArc` exists, but
+/// actually, there isn't a `ListArc`. However, we do not allow the opposite situation where a
+/// `ListArc` exists, but the tracking thinks it doesn't. This is because the former can at most
+/// result in us failing to create a `ListArc` when the operation could succeed, whereas the latter
+/// can result in the creation of two `ListArc` references.
+///
+/// # Invariants
+///
+/// * Each reference counted object has at most one `ListArc` for each value of `ID`.
+/// * The tracking inside `T` is aware that a `ListArc` reference exists.
+#[repr(transparent)]
+pub struct ListArc<T, const ID: u64 = 0>
+where
+    T: ListArcSafe<ID> + ?Sized,
+{
+    arc: Arc<T>,
+}
+
+impl<T: ListArcSafe<ID>, const ID: u64> ListArc<T, ID> {
+    /// Constructs a new reference counted instance of `T`.
+    pub fn try_new(contents: T) -> Result<Self, AllocError> {
+        Ok(Self::from_unique(UniqueArc::try_new(contents)?))
+    }
+
+    /// Use the given initializer to in-place initialize a `T`.
+    ///
+    /// If `T: !Unpin` it will not be able to move afterwards.
+    pub fn pin_init<E>(init: impl PinInit<T, E>) -> error::Result<Self>
+    where
+        Error: From<E>,
+    {
+        Ok(Self::from_pin_unique(UniqueArc::pin_init(init)?))
+    }
+}
+
+impl<T, const ID: u64> ListArc<T, ID>
+where
+    T: ListArcSafe<ID> + ?Sized,
+{
+    /// Convert a [`UniqueArc`] into a [`ListArc`].
+    pub fn from_unique(mut unique: UniqueArc<T>) -> Self {
+        // SAFETY: We have a `UniqueArc`, so there is no `ListArc`.
+        unsafe { T::on_create_list_arc_from_unique(&mut unique) };
+        let arc = Arc::from(unique);
+        // SAFETY: We just called `on_create_list_arc_from_unique` on an arc without a `ListArc`,
+        // so we can create a `ListArc`.
+        unsafe { Self::transmute_from_arc(arc) }
+    }
+
+    /// Convert a pinned [`UniqueArc`] into a [`ListArc`].
+    pub fn from_pin_unique(unique: Pin<UniqueArc<T>>) -> Self {
+        // SAFETY: We continue to treat this pointer as pinned after this call, since `ListArc`
+        // implicitly pins its value.
+        Self::from_unique(unsafe { Pin::into_inner_unchecked(unique) })
+    }
+
+    /// Like [`from_unique`], but creates two `ListArcs`.
+    ///
+    /// The two ids must be different.
+    ///
+    /// [`from_unique`]: ListArc::from_unique
+    pub fn pair_from_unique<const ID2: u64>(mut unique: UniqueArc<T>) -> (Self, ListArc<T, ID2>)
+    where
+        T: ListArcSafe<ID2>,
+    {
+        assert_ne!(ID, ID2);
+
+        // SAFETY: We have a `UniqueArc`, so we can call this method.
+        unsafe { <T as ListArcSafe<ID>>::on_create_list_arc_from_unique(&mut unique) };
+        // SAFETY: We have a `UniqueArc`, so we can call this method. The two ids are not equal.
+        unsafe { <T as ListArcSafe<ID2>>::on_create_list_arc_from_unique(&mut unique) };
+
+        let arc1 = Arc::from(unique);
+        let arc2 = Arc::clone(&arc1);
+
+        // SAFETY: We just called `on_create_list_arc_from_unique` on an arc without a `ListArc`,
+        // so we can create a `ListArc`.
+        unsafe {
+            (
+                Self::transmute_from_arc(arc1),
+                ListArc::transmute_from_arc(arc2),
+            )
+        }
+    }
+
+    /// Like [`pair_from_unique`], but uses a pinned arc.
+    ///
+    /// The two ids must be different.
+    ///
+    /// [`pair_from_unique`]: ListArc::pair_from_unique
+    pub fn pair_from_pin_unique<const ID2: u64>(
+        unique: Pin<UniqueArc<T>>,
+    ) -> (Self, ListArc<T, ID2>)
+    where
+        T: ListArcSafe<ID2>,
+    {
+        // SAFETY: We continue to treat this pointer as pinned after this call, since `ListArc`
+        // implicitly pins its value.
+        Self::pair_from_unique(unsafe { Pin::into_inner_unchecked(unique) })
+    }
+
+    /// Transmutes an [`Arc`] into a `ListArc` without updating the tracking inside `T`.
+    ///
+    /// # Safety
+    ///
+    /// * The value must not already have a `ListArc` reference.
+    /// * The tracking inside `T` must think that there is a `ListArc` reference.
+    #[inline]
+    unsafe fn transmute_from_arc(me: Arc<T>) -> Self {
+        // INVARIANT: By the safety requirements, the invariants on `ListArc` are satisfied.
+        // SAFETY: ListArc is repr(transparent).
+        unsafe { core::mem::transmute(me) }
+    }
+
+    /// Transmutes a `ListArc` into an [`Arc`] without updating the tracking inside `T`.
+    ///
+    /// After this call, the tracking inside `T` will still think that there is a `ListArc`
+    /// reference.
+    #[inline]
+    fn transmute_to_arc(self) -> Arc<T> {
+        // SAFETY: ListArc is repr(transparent).
+        unsafe { core::mem::transmute(self) }
+    }
+
+    /// Convert ownership of this `ListArc` into a raw pointer.
+    ///
+    /// The returned pointer is indistinguishable from pointers returned by [`Arc::into_raw`]. The
+    /// tracking inside `T` will still think that a `ListArc` exists after this call.
+    #[inline]
+    pub fn into_raw(self) -> *const T {
+        Arc::into_raw(Self::transmute_to_arc(self))
+    }
+
+    /// Take ownership of the `ListArc` from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// * `ptr` must satisfy the safety requirements of [`Arc::from_raw`].
+    /// * The value must not already have a `ListArc` reference.
+    /// * The tracking inside `T` must think that there is a `ListArc` reference.
+    #[inline]
+    pub unsafe fn from_raw(ptr: *const T) -> Self {
+        // SAFETY: The pointer satisfies the safety requirements for `Arc::from_raw`.
+        let arc = unsafe { Arc::from_raw(ptr) };
+        // SAFETY: The value doesn't already have a `ListArc` reference, but the tracking thinks it
+        // does.
+        unsafe { Self::transmute_from_arc(arc) }
+    }
+
+    /// Converts the `ListArc` into an [`Arc`].
+    #[inline]
+    pub fn into_arc(self) -> Arc<T> {
+        let arc = Self::transmute_to_arc(self);
+        // SAFETY: There is no longer a `ListArc`, but the tracking thinks there is.
+        unsafe { T::on_drop_list_arc(&arc) };
+        arc
+    }
+
+    /// Clone a `ListArc` into an [`Arc`].
+    #[inline]
+    pub fn clone_arc(&self) -> Arc<T> {
+        self.arc.clone()
+    }
+
+    /// Returns a reference to an [`Arc`] from the given [`ListArc`].
+    ///
+    /// This is useful when the argument of a function call is an [`&Arc`] (e.g., in a method
+    /// receiver), but we have a [`ListArc`] instead.
+    ///
+    /// [`&Arc`]: Arc
+    #[inline]
+    pub fn as_arc(&self) -> &Arc<T> {
+        &self.arc
+    }
+
+    /// Returns an [`ArcBorrow`] from the given [`ListArc`].
+    ///
+    /// This is useful when the argument of a function call is an [`ArcBorrow`] (e.g., in a method
+    /// receiver), but we have an [`Arc`] instead. Getting an [`ArcBorrow`] is free when optimised.
+    #[inline]
+    pub fn as_arc_borrow(&self) -> ArcBorrow<'_, T> {
+        self.arc.as_arc_borrow()
+    }
+
+    /// Compare whether two [`ListArc`] pointers reference the same underlying object.
+    #[inline]
+    pub fn ptr_eq(this: &Self, other: &Self) -> bool {
+        Arc::ptr_eq(&this.arc, &other.arc)
+    }
+}
+
+impl<T, const ID: u64> Deref for ListArc<T, ID>
+where
+    T: ListArcSafe<ID> + ?Sized,
+{
+    type Target = T;
+
+    #[inline]
+    fn deref(&self) -> &Self::Target {
+        self.arc.deref()
+    }
+}
+
+impl<T, const ID: u64> Drop for ListArc<T, ID>
+where
+    T: ListArcSafe<ID> + ?Sized,
+{
+    #[inline]
+    fn drop(&mut self) {
+        // SAFETY: There is no longer a `ListArc`, but the tracking thinks there is by the type
+        // invariants on `Self`.
+        unsafe { T::on_drop_list_arc(&self.arc) };
+    }
+}
+
+// This is to allow [`ListArc`] (and variants) to be used as the type of `self`.
+impl<T, const ID: u64> core::ops::Receiver for ListArc<T, ID> where T: ListArcSafe<ID> + ?Sized {}
+
+// This is to allow coercion from `ListArc<T>` to `ListArc<U>` if `T` can be converted to the
+// dynamically-sized type (DST) `U`.
+impl<T, U, const ID: u64> core::ops::CoerceUnsized<ListArc<U, ID>> for ListArc<T, ID>
+where
+    T: ListArcSafe<ID> + Unsize<U> + ?Sized,
+    U: ListArcSafe<ID> + ?Sized,
+{
+}
+
+// This is to allow `ListArc<U>` to be dispatched on when `ListArc<T>` can be coerced into
+// `ListArc<U>`.
+impl<T, U, const ID: u64> core::ops::DispatchFromDyn<ListArc<U, ID>> for ListArc<T, ID>
+where
+    T: ListArcSafe<ID> + Unsize<U> + ?Sized,
+    U: ListArcSafe<ID> + ?Sized,
+{
+}

-- 
2.44.0.478.gd926399ef9-goog


