Return-Path: <linux-kernel+bounces-127921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DA38952C5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7DAE1F22BD8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846BC69979;
	Tue,  2 Apr 2024 12:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="371+VrPc"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD82F84A46
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 12:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712060261; cv=none; b=ezCnJGRX4mF8y+x3Y6jC/h0JDS/b1k80CS25dBnr9xhfgaumGCSxq6xkTu/ovOiVlOBktWZnB8fz39qZYeTFRW5CCwZFaR9yxaz9ceiY0i5iKi1727KkFVt3yefEd2x/aOVbh6NJ/swWyyeP/6hOBeEi23cteAi0j/Fznoyl+wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712060261; c=relaxed/simple;
	bh=tqKfHUsK7hCm2PyXAc01Acvxq8K23vU+ihnAX4wTfEY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TQr3i7VcsSoy2guiCbojLRgTZvl1pBnVELG2PGm6IVoe+/4GD76y/G0GQhP1kpf+PbBOTMYB6ExQfLt3LeIh3ytQZowRDAvuUDgvflhzA/LolKaoMBjHhy2vXv0kB/8/Y/+LXNHVrNY7/CajE4E3h/tn3G7HPE9b7/zj3dApgj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=371+VrPc; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60ff1816749so76049277b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 05:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712060259; x=1712665059; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v5M3wjItaw9nmj3Ef5ma10UWkj1Gr7gU+bmHLCZel5M=;
        b=371+VrPcmk1wNlPimIzv2POHOkz5TAUrgCJYTXlsLfjkQilq4apsibFAfI6mA5KYix
         Z37APHz6wvjHvJGKHlYzL2DLT4tslTtFgtlrAVxEGdlN/djWahr6dTK7GZAUrYOOArtG
         DBG70COq/0vLPfpU2YeBlDlES2GdM++bS0n4OnSJaefDpBzybYRdKGtEclCX3AkV6eKe
         MbWks6k335gNpTFgB4mhJTmKo0r0+OPUU7Nj/wzDz7A9O3s9B0jNjOUMhxufetsp+Pke
         fR6laq9Vf9Bf4jefc3XQLYtufb3yB8gNjNcc5RKc5xaOnqyVB6bQ7UOknbfG47Ertmui
         8cIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712060259; x=1712665059;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v5M3wjItaw9nmj3Ef5ma10UWkj1Gr7gU+bmHLCZel5M=;
        b=pAcijICK5HDgqBbAtcfZ+lork04wFnPf9q2GprJvYVyGPNHPiYbsnG2+WGLbCxEyTn
         r25MlSwhkU31qer0IQmMC2jm+yFAqD1bJGepLS6h+pn9NUqqkGAte51L6xBrVuZ3x3Y8
         Q88DoxOup3tVLjqvj3yDs1FoerhkHwOI+mpbH3Y0CkTAHb2TbJw/rSZC9D0+kYJVya/X
         jFxwI6BjfMi/ziYDfNSQjP+zj/Rpyf68AQWseAacP0JK4KSKDUHXetYSpW7iRekPFDhw
         c+qhjALv/tyrD5jlE3Rjsq7B0iiy3NwSFYSFI0HHJVgygGjsshTnWsDhS8947RB3j3U3
         WiTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKvdKF4QPzAK1z5DD8ZDJgu9yIFkYjYmG8aezDPYD75Y74wb8HCCD0w/Eyy7/25NNzawIOCHEvyUSqrHriulIc47ES/YL11FxvdFxZ
X-Gm-Message-State: AOJu0YywBCCIDni6t72BioPZT7lIk+5kEpCO/OsU8uqZ9bt3lkUEPnMb
	kaNwHIOrw25nNRImCaJTRtqOcl3KtwUfUNG9lpDU5K4AG/TZMjtkGOw7fck6LTmT0JR4/MBCS5u
	yKya/UHAoPzEm6w==
X-Google-Smtp-Source: AGHT+IEfxM1QhUDajOiqFEwCHOge6DqGjO/6OvMxe/W8PULhlDwniReD7xGp7I78PzSDEGFZCTdn7btB+Sga0po=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:dc2:b0:614:ad33:3980 with SMTP
 id db2-20020a05690c0dc200b00614ad333980mr1527148ywb.7.1712060259166; Tue, 02
 Apr 2024 05:17:39 -0700 (PDT)
Date: Tue, 02 Apr 2024 12:17:04 +0000
In-Reply-To: <20240402-linked-list-v1-0-b1c59ba7ae3b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240402-linked-list-v1-0-b1c59ba7ae3b@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4931; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=tqKfHUsK7hCm2PyXAc01Acvxq8K23vU+ihnAX4wTfEY=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmC/dLuBvX9MumdW30vLBOIlm75XUIiZApX/FvV
 tZzfsjLOh+JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZgv3SwAKCRAEWL7uWMY5
 RuLrD/9f3LnikwyS9dHTIT4bCldMF4qIjjOooOvRqBMOtgrJ5xqxjOq85aEeRx1IN0LrfKbaW9D
 GIAlVHGGlXEIQsshjrgHRD9dMT7pd5MGqw2hajy+LhZs758v1luXfxyo77PuTqDUNCKu+fDlTpf
 m2ly4J8GEzBIYCizZkLvQgXOycIJ23Qusi42yMOpekO+msjnhcbSKBqlkMiqGIVCFw9VOylVxp5
 Hnp7mYWHCcD25zCKzUVJpjH4aZygNbd3rXIFYILdslby0FjmvTeT7uU6kyT/SPOTqrRVNEzXW2d
 duQJbeqe87uGv7qsoOSDFWm4J4HphQIjhEpkoiLCs5YGs6vg5B0bXM2x7ZvuIVXp0AbCsiXpkI2
 ZgpK+uJcbWprA5x9TS4rzoDoxc63JlEkidZEJbmPs4qVBXv7UGL74v9Y+q6KiPR88Fsu05rXriL
 MrAeWetM6qp3bhKn4Ur6efe2gmTyUsc6sVbuzDq5n6i9oauhvwox8VX23BfLgfXeC3oBy5fON1r
 LRKWfLc9zuTUQZZMdXOvw5NOd7fOHS6rpUwxUbqu07STgwuHifJUq+HS19sXKqRP65f2gbo+aDV
 w2q9Svamn40a4OXp1tqluSOOOvNPtY0qk7icE7Ly3pkdkAVMvsnyt8nG/knPEQhjVnV64gBVaPO AuSScaXfCUKB5TQ==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240402-linked-list-v1-7-b1c59ba7ae3b@google.com>
Subject: [PATCH 7/9] rust: list: add cursor
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

The cursor is very similar to the list iterator, but it has one
important feature that the iterator doesn't: it can be used to remove
items from the linked list.

This feature cannot be added to the iterator because the references you
get from the iterator are considered borrows of the original list,
rather than borrows of the iterator. This means that there's no way to
prevent code like this:

let item = iter.next();
iter.remove();
use(item);

If `iter` was a cursor instead of an iterator, then `item` will be
considered a borrow of `iter`. Since `remove` destroys `iter`, this
means that the borrow-checker will prevent uses of `item` after the call
to `remove`.

So there is a trade-off between supporting use in traditional for loops,
and supporting removal of elements as you iterate. Iterators and cursors
represents two different choices on that spectrum.

Rust Binder needs cursors for the list of death notifications that a
process is currently handling. When userspace tells Binder that it has
finished processing the death notification, Binder will iterate the list
to search for the relevant item and remove it.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/list.rs | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
index 892705dd0571..47e52818c7bd 100644
--- a/rust/kernel/list.rs
+++ b/rust/kernel/list.rs
@@ -408,6 +408,20 @@ pub fn push_all_back(&mut self, other: &mut List<T, ID>) {
         other.first = ptr::null_mut();
     }
 
+    /// Returns a cursor to the first element of the list.
+    ///
+    /// If the list is empty, this returns `None`.
+    pub fn cursor_front(&mut self) -> Option<Cursor<'_, T, ID>> {
+        if self.first.is_null() {
+            None
+        } else {
+            Some(Cursor {
+                current: self.first,
+                list: self,
+            })
+        }
+    }
+
     /// Creates an iterator over the list.
     pub fn iter(&self) -> Iter<'_, T, ID> {
         // INVARIANT: If the list is empty, both pointers are null. Otherwise, both pointers point
@@ -476,6 +490,69 @@ fn next(&mut self) -> Option<ArcBorrow<'a, T>> {
     }
 }
 
+/// A cursor into a [`List`].
+///
+/// # Invariants
+///
+/// The `current` pointer points a value in `list`.
+pub struct Cursor<'a, T: ?Sized + ListItem<ID>, const ID: u64 = 0> {
+    current: *mut ListLinksFields,
+    list: &'a mut List<T, ID>,
+}
+
+impl<'a, T: ?Sized + ListItem<ID>, const ID: u64> Cursor<'a, T, ID> {
+    /// Access the current element of this cursor.
+    pub fn current(&self) -> ArcBorrow<'_, T> {
+        // SAFETY: The `current` pointer points a value in the list.
+        let me = unsafe { T::view_value(ListLinks::from_fields(self.current)) };
+        // SAFETY:
+        // * All values in a list are stored in an `Arc`.
+        // * The value cannot be removed from the list for the duration of the lifetime annotated
+        //   on the returned `ArcBorrow`, because removing it from the list would require mutable
+        //   access to the cursor or the list. However, the `ArcBorrow` holds an immutable borrow
+        //   on the cursor, which in turn holds an immutable borrow on the list, so any such
+        //   mutable access requires first releasing the immutable borrow on the cursor.
+        // * Values in a list never have a `UniqueArc` reference.
+        unsafe { ArcBorrow::from_raw(me) }
+    }
+
+    /// Move the cursor to the next element.
+    pub fn next(self) -> Option<Cursor<'a, T, ID>> {
+        // SAFETY: The `current` field is always in a list.
+        let next = unsafe { (*self.current).next };
+
+        if next == self.list.first {
+            None
+        } else {
+            Some(Cursor {
+                current: next,
+                list: self.list,
+            })
+        }
+    }
+
+    /// Move the cursor to the previous element.
+    pub fn prev(self) -> Option<Cursor<'a, T, ID>> {
+        // SAFETY: The `current` field is always in a list.
+        let prev = unsafe { (*self.current).prev };
+
+        if self.current == self.list.first {
+            None
+        } else {
+            Some(Cursor {
+                current: prev,
+                list: self.list,
+            })
+        }
+    }
+
+    /// Remove the current element from the list.
+    pub fn remove(self) -> ListArc<T, ID> {
+        // SAFETY: The `current` pointer always points at a member of the list.
+        unsafe { self.list.remove_internal(self.current) }
+    }
+}
+
 impl<'a, T: ?Sized + ListItem<ID>, const ID: u64> FusedIterator for Iter<'a, T, ID> {}
 
 impl<'a, T: ?Sized + ListItem<ID>, const ID: u64> IntoIterator for &'a List<T, ID> {

-- 
2.44.0.478.gd926399ef9-goog


