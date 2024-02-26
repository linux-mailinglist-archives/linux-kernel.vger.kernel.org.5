Return-Path: <linux-kernel+bounces-81542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FCC86774B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E21FA1C2989E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D381292E0;
	Mon, 26 Feb 2024 13:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJTIxIyZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3573660860;
	Mon, 26 Feb 2024 13:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708955748; cv=none; b=F2UWW2el+PoCqZBrefTEJnzFs5nhuUuRNfQoPlGnyphIl/7/oIGIy2gRsVyAg7O1SrOPrFDWXXAX6ZaZerR0opJxuQZ0VjnfBTZFQ2x3Hm4S98VjbWiqzwQUdJD88CICzFGC29AMSZ0R474TtFVXIM5tv9px48Y2uriFwPOxaTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708955748; c=relaxed/simple;
	bh=Emy8hODkmYz5l9/3gRLjcbkZM9jZtfeB+DF9ipyZg0U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Zrqs2cQcofsSgbMIcZ3jkyDfWe8nh9VnukPBoQOszSfz67lNDkJQkyD06UIoCy9Y9g6ZffB+e7ATbL0ppuJ7DvewXrMKAj5qOkU72QsL2hdzh/iqfLuYGkykzWb8T0uy+WwJHeiL+jVXwohFhtJaZiw49pQyFtRYr37SyZfPEEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJTIxIyZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98DD1C43390;
	Mon, 26 Feb 2024 13:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708955747;
	bh=Emy8hODkmYz5l9/3gRLjcbkZM9jZtfeB+DF9ipyZg0U=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=EJTIxIyZ5a38kRyt1gcNNyfrWkbhG9pSzFRamisGy1ygB/RnL3HU+EtHz47vjSaCA
	 Uk9XGK8NxJm1KBIG4h8xhOw2WNjmSKLn6QuA917oB3BdESHoXDkrKQukoB77ikAyoi
	 83xyj5dQ97WHMoRC+AfxAHkype9cxth2h+l5Ig7aRz5bPOX5CIFIaUBtb38iUi5ANF
	 0GwPAwb5PE790ga34ex4UWweYG/IsIhdaQF6bRTUxKc7Ot7YmsPpyZLH9FUr4dXeQ2
	 2X+Y+9WOX5MgUkHydx4ISWEM54s+FpdWiu17QULzZnQXyUqhPkgoJF0YPLF7JlMPjs
	 UJSlfsc9UQFLA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E58C48BF6;
	Mon, 26 Feb 2024 13:55:47 +0000 (UTC)
From:
 Mathys-Gasnier via B4 Relay <devnull+mathys35.gasnier.gmail.com@kernel.org>
Date: Mon, 26 Feb 2024 14:55:47 +0100
Subject: [PATCH v4] rust: locks: Add `get_mut` method to `Lock`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-rust-locks-get-mut-v4-1-24abf57707a8@gmail.com>
X-B4-Tracking: v=1; b=H4sIAGKY3GUC/23NQQ6CMBCF4auQrq3pTIugK+9hXMB0wEahpkWiM
 dzdohtiWP4vmW/eInJwHMUhe4vAo4vO9ynMJhN0qfqWpbOpBSo0CqCU4REHefN0jbLlQXaPQZJ
 BVSAosEUl0uE9cOOeX/R0Tn1xcfDh9f0xwrz+OFT7NW4ECZJY59CQtmyKY9tV7rYl34mZG3FBA
 K4SmIicyGpDWBeq/if0gsB1QifC6rLaNaa2rO2SmKbpAwZCFhE6AQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708955747; l=2602;
 i=mathys35.gasnier@gmail.com; s=20240118; h=from:subject:message-id;
 bh=kDDO5igmp8sHMJQ33zb3ZYMBa3AMIqzPPer9XYO98Lo=;
 b=2Mlo8HK/4uPZRMpwJZRxkIbJoJnJnrJpKYcLID/FnTnK1ceAVASzr1Qaij59qMg9WNpDWUIMZ
 9Fn4o5lHlDdBgYl12WxZDNVSpumToeoyu3ohBzrCXGbe09RGmXfIUiI
X-Developer-Key: i=mathys35.gasnier@gmail.com; a=ed25519;
 pk=C5tqKAA3Ua7li5s3a+q2aDelT2j98/yjGg2nEVGArXE=
X-Endpoint-Received:
 by B4 Relay for mathys35.gasnier@gmail.com/20240118 with auth_id=129
X-Original-From: Mathys-Gasnier <mathys35.gasnier@gmail.com>
Reply-To: <mathys35.gasnier@gmail.com>

From: Mathys-Gasnier <mathys35.gasnier@gmail.com>

Having a mutable reference guarantees that no other threads have
access to the lock, so we can take advantage of that to grant callers
access to the protected data without the the cost of acquiring and
releasing the locks. Since the lifetime of the data is tied to the
mutable reference, the borrow checker guarantees that the usage is safe.

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Signed-off-by: Mathys-Gasnier <mathys35.gasnier@gmail.com>
---
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
 rust/kernel/sync/lock.rs | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index f12a684bc957..a563991bf851 100644
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
@@ -121,6 +125,17 @@ pub fn lock(&self) -> Guard<'_, T, B> {
         // SAFETY: The lock was just acquired.
         unsafe { Guard::new(self, state) }
     }
+
+    /// Gets the data contained in the lock.
+    ///
+    /// Having a mutable reference to the lock guarantees that no other threads have access to the lock.
+    /// And because `data` is not structurally pinned,
+    /// it is safe to get a mutable reference to the lock content.
+    pub fn get_mut(self: Pin<&mut Self>) -> &mut T {
+        // SAFETY: The lock will only be used to get a reference to the data, therefore self won't get moved
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


