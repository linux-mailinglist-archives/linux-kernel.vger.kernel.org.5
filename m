Return-Path: <linux-kernel+bounces-127923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B9F8952C7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B078D1C21086
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6B085650;
	Tue,  2 Apr 2024 12:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LAPHypQm"
Received: from mail-lj1-f201.google.com (mail-lj1-f201.google.com [209.85.208.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1126B85639
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 12:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712060267; cv=none; b=qQLiqohta6wmL4K0tejDVGPoAnQdkE3ox+jD74Dki1soqmpR3zjBJbjYx7wCaDkftKTB1zzo9/aERt7hx+zuYnGvwThCaMI7nxhTtMnimX7+gxMd3VTHL+BuxSHvmWsuQj98di/nyfUO+FRFGgg1hoOja/A4bjHjnBswTm59raI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712060267; c=relaxed/simple;
	bh=SGw/IWmpTfH/F2q/Ud6VR5TfFDIRo7fTaxFXe3yUsnk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ebfD6O9ayLJLZb+qvyJRaFWqB/twmRA8p6TQ6SIzuNLI0j9zzqOvQgytxVR5jMsdI3lNdO9Q7kdo0fsOz/nBPVwmxPcYeZpQmCb/bjye6E4UQ5cR2ypoEpORimMfAlG4c9glfWyEze1VqwtJ62R/21McHJwJj8/pBfR5IHNEu1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LAPHypQm; arc=none smtp.client-ip=209.85.208.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f201.google.com with SMTP id 38308e7fff4ca-2d827143440so8048361fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 05:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712060264; x=1712665064; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vgz9mY70v5CNK64cYxyt3hg7fzBLiQ2+bMaSc0psi2g=;
        b=LAPHypQmPxiB/Q0VgZq7IWxUnq3PtIAxQje8F9P980JBAHZh8sh4TO9vQUmsV8sj1v
         HQA/ff+KbjFVDTaAF2cgZbnzfbOBtRsBVkQb3ZiQPLQNYECRjb8wa+GmRdMncPn6pJyU
         OYwlPdkbQiecD0STMnaJXZnNLzPEo5hbiUCrhrW+fSS80SLfwTjs+WPCOBaSvv5y0QJW
         wwsYmVgzfPjehCTVK2/wmEVfrflorhJt/exLjIOH5MIxAxIOVNGA9tKhqwdcy1Jtacf6
         yWk7RZphnOMktumZhLFq7PGFWVyhPmVl5TjPyFuISbqxK1jZF0MK7ys0GJLxrU0puc/O
         ooWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712060264; x=1712665064;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vgz9mY70v5CNK64cYxyt3hg7fzBLiQ2+bMaSc0psi2g=;
        b=Ne3+GB9hy3lkNDSocGCAf2+1opidTFnbSbnGPqUBEV+Tpy08yPq/dahdhZcLa0HsUo
         V9BUXkUFvLFbaEMETNEFfqVa3IS+1AhS1+WFkGObXnYnwqW2ybwLyzw2oVlqSrAvQdho
         7BTlxzwEGRaETcbpETMrR7ymb8UJkWXYziHSCK7AbpfCims3FhrnRZVD5pURBoxc/8yq
         mpaxXx5Byf50xJYrcMT/broA3A0M9faF+yBSL0AzyZbcKnxHF65IxDyZnD+FJJLKTVwM
         LXpDQ9DvYJXdnY26VPf3mIov94tLZBZFDoNtB7fy4fsN5fiocHFXB1e4CHMcG/Z+Cmk9
         SisQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIExTiADyd1ZeXNjGkSvf5DcUHd9zwgRrqsyarBtPhKKckRChWeAVlOICz69dA0AAR14w828zBemsbicXU0St4kGFZsVsmka59v/+y
X-Gm-Message-State: AOJu0YzC7u/cqK+Pg+47uQofnnRAG4dsMq/KWRPDKFBN5VQ5Yy4HC4Es
	tFQAGbUtVYx9NzZHzF4VWKxGugU6XhqKhkk9Hxa42PwMNK+c1qDnJMrAFdWgXkw2FWmH+UWVe6t
	dlac3Co14z8STCA==
X-Google-Smtp-Source: AGHT+IHzIcMUK/ZnVKq3qkpniEnzh8eCGMqdXergN7OK1gAzwOA0dYo8VsQtWLJ7tC7T7IZcGuzKV0g2HBkQDuU=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:380a:0:b0:2d4:6d84:e5a1 with SMTP id
 f10-20020a2e380a000000b002d46d84e5a1mr11044lja.6.1712060264327; Tue, 02 Apr
 2024 05:17:44 -0700 (PDT)
Date: Tue, 02 Apr 2024 12:17:06 +0000
In-Reply-To: <20240402-linked-list-v1-0-b1c59ba7ae3b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240402-linked-list-v1-0-b1c59ba7ae3b@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5215; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=SGw/IWmpTfH/F2q/Ud6VR5TfFDIRo7fTaxFXe3yUsnk=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmC/dMaviC2qcjVgb/qXVtUFOZ3+y+j8AdAra2j
 fs1cpydcVGJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZgv3TAAKCRAEWL7uWMY5
 RgZvD/47HsxN1WCEK09/gmnzGcvdEwCuuF6bNSIKzOhsWL/GHKSimQ0dvAUolIsJDgzoIKzC8o5
 q1MgUQDzH+SFVYM5lR9c3bccY10dH/4ZExtiM6bmoB634KrEPanSUu5raYyQCrrUp9y/fqKC7Xq
 HF1EU+O9hOZJ5EB9ofcil1X0ePqJzoIE/SwhY8+2eFI1Tgb5+w5Un60Y2v2j3xJ49mBu1HixNI0
 RvCkdi1lSEwrKugTA2HBoNK2LK9CRqjSfjrs7BDnq9WQ3HT4ahi0n68iws6wZrJx/8VaWlrDU36
 haiWrBzYFFjpnzbOaiQ5wsT/PFECUPAitQyX0CJjjba7d12vg74q7Rs+97pB3/9yx2eEQAm4/a+
 PEqYP5Ujg2USZdlKP8xuL/q+53bA9XTRKBqmS+i273Jv8IBRrhJE9Mki+qG4l4xT63hqEydNB+P
 lV+BSg8EE/wwBGEan2zjkR+Trxhry3ssKWyz6s5pMEKVgql9Yl39lC70HndInMWbFasXq4Mslbi
 FFIMmynMvzEmjZMK2laB2EAMVKgmNL3BNw00W5clXvLKcxBAL2Gry8Kj/pjZbDaPcur45PuQfzR
 8W7Q5oZ01XPAnkgFwVxgQvDfq1OEE567HecVKB4Rqdw0/i3HxFiMr3Ze5WAbikwfJUn1QCBZ1RP EuMxQL79JKjOF6w==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240402-linked-list-v1-9-b1c59ba7ae3b@google.com>
Subject: [PATCH 9/9] rust: list: add ListArcField
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

One way to explain what `ListArc` does is that it controls exclusive
access to the prev/next pointer field in a refcounted object. The
feature of having a special reference to a refcounted object with
exclusive access to specific fields is useful for other things, so
provide a general utility for that.

This is used by Rust Binder to keep track of which processes have a
reference to a given node. This involves an object for each process/node
pair, that is referenced by both the process and the node. For some
fields in this object, only the process's reference needs to access
them (and it needs mutable access), so Binder uses a ListArc to give the
process's reference exclusive access.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/list.rs           |  3 ++
 rust/kernel/list/arc_field.rs | 94 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)

diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
index 68d03b100863..a59b35b67e9b 100644
--- a/rust/kernel/list.rs
+++ b/rust/kernel/list.rs
@@ -23,6 +23,9 @@
     impl_list_arc_safe, AtomicListArcTracker, ListArc, ListArcSafe, TryNewListArc,
 };
 
+mod arc_field;
+pub use self::arc_field::{define_list_arc_field_getter, ListArcField};
+
 /// A linked list.
 ///
 /// All elements in this linked list will be [`ListArc`] references to the value. Since a value can
diff --git a/rust/kernel/list/arc_field.rs b/rust/kernel/list/arc_field.rs
new file mode 100644
index 000000000000..936fd97bc5ac
--- /dev/null
+++ b/rust/kernel/list/arc_field.rs
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! A field that is exclusively owned by a [`ListArc`].
+//!
+//! This can be used to have reference counted struct where one of the reference counted pointers
+//! has exclusive access to a field of the struct.
+//!
+//! [`ListArc`]: crate::list::ListArc
+
+use core::cell::UnsafeCell;
+
+/// A field owned by a specific `ListArc`.
+pub struct ListArcField<T, const ID: u64 = 0> {
+    value: UnsafeCell<T>,
+}
+
+// SAFETY: If the inner type is thread-safe, then it's also okay for `ListArc` to be thread-safe.
+unsafe impl<T: Send + Sync, const ID: u64> Send for ListArcField<T, ID> {}
+// SAFETY: If the inner type is thread-safe, then it's also okay for `ListArc` to be thread-safe.
+unsafe impl<T: Send + Sync, const ID: u64> Sync for ListArcField<T, ID> {}
+
+impl<T, const ID: u64> ListArcField<T, ID> {
+    /// Creates a new `ListArcField`.
+    pub fn new(value: T) -> Self {
+        Self {
+            value: UnsafeCell::new(value),
+        }
+    }
+
+    /// Access the value when we have exclusive access to the `ListArcField`.
+    ///
+    /// This allows access to the field using an `UniqueArc` instead of a `ListArc`.
+    pub fn get_mut(&mut self) -> &mut T {
+        self.value.get_mut()
+    }
+
+    /// Unsafely assert that you have shared access to the `ListArc` for this field.
+    ///
+    /// # Safety
+    ///
+    /// The caller must have shared access to the `ListArc<ID>` containing the struct with this
+    /// field for the duration of the returned reference.
+    pub unsafe fn assert_ref(&self) -> &T {
+        // SAFETY: The caller has shared access to the `ListArc`, so they also have shared access
+        // to this field.
+        unsafe { &*self.value.get() }
+    }
+
+    /// Unsafely assert that you have mutable access to the `ListArc` for this field.
+    ///
+    /// # Safety
+    ///
+    /// The caller must have mutable access to the `ListArc<ID>` containing the struct with this
+    /// field for the duration of the returned reference.
+    #[allow(clippy::mut_from_ref)]
+    pub unsafe fn assert_mut(&self) -> &mut T {
+        // SAFETY: The caller has exclusive access to the `ListArc`, so they also have exclusive
+        // access to this field.
+        unsafe { &mut *self.value.get() }
+    }
+}
+
+/// Defines.
+#[macro_export]
+macro_rules! define_list_arc_field_getter {
+    ($pub:vis fn $name:ident(&self $(<$id:tt>)?) -> &$typ:ty { $field:ident }
+     $($rest:tt)*
+    ) => {
+        $pub fn $name<'a>(self: &'a $crate::list::ListArc<Self $(, $id)?>) -> &'a $typ {
+            let field = &(&**self).$field;
+            // SAFETY: We have a shared reference to the `ListArc`.
+            unsafe { $crate::list::ListArcField::<$typ $(, $id)?>::assert_ref(field) }
+        }
+
+        $crate::list::define_list_arc_field_getter!($($rest)*);
+    };
+
+    ($pub:vis fn $name:ident(&mut self $(<$id:tt>)?) -> &mut $typ:ty { $field:ident }
+     $($rest:tt)*
+    ) => {
+        $pub fn $name<'a>(self: &'a mut $crate::list::ListArc<Self $(, $id)?>) -> &'a mut $typ {
+            let field = &(&**self).$field;
+            // SAFETY: We have a mutable reference to the `ListArc`.
+            unsafe { $crate::list::ListArcField::<$typ $(, $id)?>::assert_mut(field) }
+        }
+
+        $crate::list::define_list_arc_field_getter!($($rest)*);
+    };
+
+    () => {};
+}
+pub use define_list_arc_field_getter;

-- 
2.44.0.478.gd926399ef9-goog


