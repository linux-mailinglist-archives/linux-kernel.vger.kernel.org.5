Return-Path: <linux-kernel+bounces-88838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C8286E764
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE9CCB29A5C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842CAF9F6;
	Fri,  1 Mar 2024 17:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohI/dcuw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C9E46B3;
	Fri,  1 Mar 2024 17:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709314409; cv=none; b=GW9ZuZj8ktvG0s6/LUkeKHADvn8/Y7/mPwLAVEC5XJZdVMeZQMmrtlNshmrRm5wpeElNNVSRKdHDZVkZmwbpFY7pFQi9QknhQEX467htk0p0gzG9IlraZurUHxBqRh3ABgLBzV/cvKN6d0XPxkaWZy1HOASMYsW2qfuG7a0cTyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709314409; c=relaxed/simple;
	bh=IYsBs/BhF0iz0VJZYgI9tkngj+zz1RnNDtdkOfgCrfU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lsgUVe844TUH0cxP9Z0EuIEeWsCW9uHL1K3F/nfM0jBXbS3rqXH9gvpwvLiRTLPQgzub94LzzTP6EqmgAhWSy1vi5L+nBm8qPzyOXq0zkRxvMLQMW9bVMAUnyknxCh8tBGGb4Aua/wqNsH+peHSZovvhp/ZSM/TnoEdQ2GDGSUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohI/dcuw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29683C433F1;
	Fri,  1 Mar 2024 17:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709314409;
	bh=IYsBs/BhF0iz0VJZYgI9tkngj+zz1RnNDtdkOfgCrfU=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ohI/dcuwZZ8j8UU5LDwFfoF/l4sfTNfbRCxGn7UllwL66Rc8ZJtrL6bo8W/19jDfH
	 jBRh2AufqQjOAqYdkOzXQfxvERgNTD/xn4/V9jJOSl/RS+rBIKmf71lq2WhBC13UBK
	 r9UmnijYyGhfZ1V+2kK7ZOkYLumV0oUZYcTxhQWR1VpVNBtTMJ36ZX0QwJyttkbJHk
	 rPjczjYzmX9h9XC07rEyqzaHjEjMosZ1IYhh8N7mMDy6WyHm6SVIJ2pe4pLvKhQgLH
	 pnXqN3oLIsMUk/8blYwAbAfUZ/eaVYjNkVS75oLjmwe9i/OO/s166VVLK7j1ys76L6
	 3UvFDUYeqatyQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1460AC5475B;
	Fri,  1 Mar 2024 17:33:29 +0000 (UTC)
From:
 Mathys-Gasnier via B4 Relay <devnull+mathys35.gasnier.gmail.com@kernel.org>
Date: Fri, 01 Mar 2024 18:33:23 +0100
Subject: [PATCH v5] rust: locks: Add `get_mut` method to `Lock`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-rust-locks-get-mut-v5-1-c5131dbbd3c4@gmail.com>
X-B4-Tracking: v=1; b=H4sIAGIR4mUC/23NQQ6CMBCF4auYrq3pTItFV97DuCjTARsFTItEY
 7i7VTfEsPxfMt+8ROIYOIn96iUijyGFvstRrFeCzq5rWAafW6BCowBKGe9pkNeeLkk2PMj2Pkg
 yqCyCAm+dyIe3yHV4fNHjKfc5pKGPz++PET7rj0O1W+JGkCCJdQE1ac/GHprWheuG+lZ8uBFnB
 OAigZkoiLw2hJVV1T+hZwQuEzoTXpduW5vKs/b/hJkT20XCZAKNq+rCWmVdOSemaXoDEqxKv30
 BAAA=
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Wedson Almeida Filho <wedsonaf@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@samsung.com>, 
 Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Martin Rodriguez Reboredo <yakoyoku@gmail.com>, 
 Mathys-Gasnier <mathys35.gasnier@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709314408; l=3361;
 i=mathys35.gasnier@gmail.com; s=20240118; h=from:subject:message-id;
 bh=YgqZEuEg7qPEU8LNGXge52fKNIIVVzwOHPlT4tjNiao=;
 b=L+sGaDcR7Vjd5mjM+tfqElKX2By5PtqYuLSS2MnvAbyQwx6h3pfgD5m/D0VbWzmKEhmdgVaU8
 gTFLD+1PsWVCUM/0nezEu0MMtJPvv60XtMhOs7USiOCY7eJd7RPfLpx
X-Developer-Key: i=mathys35.gasnier@gmail.com; a=ed25519;
 pk=C5tqKAA3Ua7li5s3a+q2aDelT2j98/yjGg2nEVGArXE=
X-Endpoint-Received:
 by B4 Relay for mathys35.gasnier@gmail.com/20240118 with auth_id=129
X-Original-From: Mathys-Gasnier <mathys35.gasnier@gmail.com>
Reply-To: <mathys35.gasnier@gmail.com>

From: Mathys-Gasnier <mathys35.gasnier@gmail.com>

Having a mutable reference guarantees that no other threads have
access to the lock, so we can take advantage of that to grant callers
access to the protected data without the cost of acquiring and
releasing the locks. Since the lifetime of the data is tied to the
mutable reference, the borrow checker guarantees that the usage is safe.

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Mathys-Gasnier <mathys35.gasnier@gmail.com>
---
Changes in v5:
- Adding example
- Link to v4: https://lore.kernel.org/r/20240226-rust-locks-get-mut-v4-1-24abf57707a8@gmail.com

Changes in v4:
- Improved documentation
- Link to v3: https://lore.kernel.org/r/20240222-rust-locks-get-mut-v3-1-d38a6f4bde3d@gmail.com

Changes in v3:
- Changing the function to take a `Pin<&mut self>` instead of a `&mut self`
- Removed reviewed-by's since big changes were made. Please take another
  look.
- Link to v2: https://lore.kernel.org/r/20240212-rust-locks-get-mut-v2-1-5ccd34c2b70b@gmail.com

Changes in v2:
- Improved doc comment. 
- Link to v1: https://lore.kernel.org/r/20240209-rust-locks-get-mut-v1-1-ce351fc3de47@gmail.com
---
 rust/kernel/sync/lock.rs | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index f12a684bc957..345ca7be9d9f 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -7,7 +7,11 @@
 
 use super::LockClassKey;
 use crate::{bindings, init::PinInit, pin_init, str::CStr, types::Opaque, types::ScopeGuard};
-use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinned};
+use core::{
+    cell::UnsafeCell,
+    marker::{PhantomData, PhantomPinned},
+    pin::Pin,
+};
 use macros::pin_data;
 
 pub mod mutex;
@@ -121,6 +125,38 @@ pub fn lock(&self) -> Guard<'_, T, B> {
         // SAFETY: The lock was just acquired.
         unsafe { Guard::new(self, state) }
     }
+
+    /// Gets the data contained in the lock.
+    ///
+    /// Having a mutable reference to the lock guarantees that no other threads have access to the
+    /// lock. And because `data` is not structurally pinned, it is safe to get a mutable reference
+    /// to the lock content.
+    ///
+    /// # Example
+    ///
+    /// Using `get_mut` with a mutex.
+    ///
+    /// ```
+    /// use kernel::sync::Mutex;
+    ///
+    /// struct Example {
+    ///     a: u32,
+    ///     b: u32,
+    /// }
+    ///
+    /// fn example(m: Pin<&mut Mutex<Example>>) {
+    ///     // Calling from Mutex to avoid conflict with Pin::get_mut().
+    ///     let mut data = Mutex::get_mut(m);
+    ///     data.a += 10;
+    ///     data.b += 20;
+    /// }
+    /// ```
+    pub fn get_mut(self: Pin<&mut Self>) -> &mut T {
+        // SAFETY: The lock will only be used to get a reference to the data, therefore self won't
+        // get moved.
+        let lock = unsafe { self.get_unchecked_mut() };
+        lock.data.get_mut()
+    }
 }
 
 /// A lock guard.

---
base-commit: 711cbfc717650532624ca9f56fbaf191bed56e67
change-id: 20240118-rust-locks-get-mut-c42072101d7a

Best regards,
-- 
Mathys-Gasnier <mathys35.gasnier@gmail.com>


