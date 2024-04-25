Return-Path: <linux-kernel+bounces-159211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 404388B2AC4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED3872822DB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5663E15574C;
	Thu, 25 Apr 2024 21:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="IFOUnr9Z"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10133153812;
	Thu, 25 Apr 2024 21:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714080888; cv=none; b=Y5rbsX5i/YXaqXcyQ8o5WBm15Lg+9Zu9z28cIfgEMmA8NJoif+50ZimniOrsqyCHdgbxQQna9jh8pSPdr0GUfWeGDGdx5m+cO4ok6KqBYvK+Kjtgn18RleUfzI78rq5iFNPzkI6pAELyj4YWne2f+47RoaNn8dZxEgT7yOm+9E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714080888; c=relaxed/simple;
	bh=1jEwCYzNB8KZbUyYi19vFP2ySyNVjrczet9hqIFk0KA=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=M4X9Gif14XQBh2u16fmbOAyInSwD+6+8SnAJyJD/qAaBpJDXeSkpeBgernx4ogNoL7cKKo1FV8PXmjpQ/8on7IdA66tVPOa5Rhs1ZrIa6nfphuVJPblK1FcC9SEgNjDTEwv8TVcPscQZ8tVc8jXA/Av+xXdFkIrpRC4m9KWhMnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=IFOUnr9Z; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1714080885; x=1714340085;
	bh=utx6L/Qp4Am0TTK7zosCdDO/Mu0LhitYxGbkj94CChY=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=IFOUnr9ZehTGA8hkvg8hxUk6wygwVMDLyz/NoqDhDKia/ZLgpTsVq03UlbXfD5G5H
	 zVIasK8El/NVnbd3SxIVm0hRIHHp1JmCot+Rs6oXEm+ETdiv43FJkSUj10bfudooC8
	 0ZjN703WyJtEKB7XPHfK6SyHj/bwcRP3kXtAd93GFyxUzgWkXI1FaBjqKYAfI7NQrx
	 44x5CtJzWflaZW4iEvhldAoLF5tyUgqtZLUto//tvDTHi7Ccz3GbU5a3z3oNAVwc4W
	 95Q9SQDZV+T3O+8IKocU2edXYy2M5mTcB5/059hGXaGm/Eh1uJqBAa2ZaSdJGBEpb9
	 tetH8mslPmbvQ==
Date: Thu, 25 Apr 2024 21:34:38 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] rust: kernel: add `drop_contents` to `BoxExt`
Message-ID: <20240425213419.3904105-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: aaeb4b917333a0c3cb20c9072f8f6dfc323866c0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sometimes (see [1]) it is necessary to drop the value inside of a
`Box<T>`, but retain the allocation. For example to reuse the allocation
in the future.
Introduce a new function `drop_contents` that turns a `Box<T>` into
`Box<MaybeUninit<T>>` by dropping the value.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
Link: https://lore.kernel.org/rust-for-linux/20240418-b4-rbtree-v3-5-323e13=
4390ce@google.com/ [1]
---
 rust/kernel/alloc/box_ext.rs | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/rust/kernel/alloc/box_ext.rs b/rust/kernel/alloc/box_ext.rs
index cdbb5ad166d9..3ddb353b776e 100644
--- a/rust/kernel/alloc/box_ext.rs
+++ b/rust/kernel/alloc/box_ext.rs
@@ -5,6 +5,7 @@
 use super::{AllocError, Flags};
 use alloc::boxed::Box;
 use core::mem::MaybeUninit;
+use core::ptr;
 use core::result::Result;
=20
 /// Extensions to [`Box`].
@@ -18,6 +19,18 @@ pub trait BoxExt<T>: Sized {
     ///
     /// The allocation may fail, in which case an error is returned.
     fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocError>=
;
+
+    /// Drops the contents, but keeps the allocation.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let value =3D Box::new([0; 32], flags::GFP_KERNEL)
+    /// let value =3D value.drop_contents();
+    /// // Now we can re-use `value`:
+    /// Box::write(value, [1; 32]);
+    /// ```
+    fn drop_contents(self) -> Box<MaybeUninit<T>>;
 }
=20
 impl<T> BoxExt<T> for Box<T> {
@@ -54,4 +67,12 @@ fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>=
>, AllocError> {
         // zero-sized types, we use `NonNull::dangling`.
         Ok(unsafe { Box::from_raw(ptr) })
     }
+
+    fn drop_contents(self) -> Box<MaybeUninit<T>> {
+        let ptr =3D Box::into_raw(self);
+        // SAFETY: `ptr` is valid, because it came from `Box::into_raw`.
+        unsafe { ptr::drop_in_place(ptr) };
+        // SAFETY: `ptr` is valid, because it came from `Box::into_raw`.
+        unsafe { Box::from_raw(ptr) }
+    }
 }
--=20
2.44.0



