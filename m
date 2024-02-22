Return-Path: <linux-kernel+bounces-76877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2174F85FE08
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ED24284BC1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7D01534EE;
	Thu, 22 Feb 2024 16:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLO5vQhX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6BD1509B5;
	Thu, 22 Feb 2024 16:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708619205; cv=none; b=nd74QlfFj3pE2VOPzGWSBt26blx1FZ8qd+Tmx7c79HrNvS5PK9tLVoPZAAraMgqGdKCvbDI5MTZkTUfuOkfbt6IFNWTH6lL/0zl7U69C2FOXUjCE1etF3pbT0X6Rbah4ZVZOaHd5qGlfEmJCFWQAnN4y8I5RnTHI8iR/qt28DKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708619205; c=relaxed/simple;
	bh=Sg+7uBjGXjQ1pdFX/E/hnLOflmTEI1B/auJ2nJ5yZc0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sOf8XR0EmEIvNeNP1lGbQhB9Dj3+RwrkHStbAu1vev3yomZudj5JRc+Z6c5Nfh3Gmm1yXpq4OJRAvZInoCeTkgLgT+EQOtK5FwZTkrTBxS34ofB2RMlTkPq9wMHxpOrqPWi7v32kKwdsqBBXf6GgBnFyzEt5C1bGANNbrrKYDUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLO5vQhX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2867C433F1;
	Thu, 22 Feb 2024 16:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708619204;
	bh=Sg+7uBjGXjQ1pdFX/E/hnLOflmTEI1B/auJ2nJ5yZc0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=WLO5vQhXIjUKiQW8MTNAerCcpBsPpFOzeIdgsi8kk7cuLH0455SdSy2LdfaS8pz+z
	 szQinCZUxI5/ERaAYyqew38pmwKsmbUFRx1B1AUpebU9Jd/IPBOelz00AjHfKTcSDE
	 5cVg2krcsICfsyr9EjXNaPf5JZvHkb9R7BDVz+ZjnAnkHqsuavU3//GOC6+mMk6H1B
	 8/2MmVRZ5oWWc59NVvtCDEhMCQDpBMRVotzu5xsc9CopupQialp/GadulIhhOgt0bn
	 Yv8FV9pQ/lY/UWTXj7xM16MwdJT0uGWV++70IiQpvuK8cGxVdlelRvj0aQlAr4TiJk
	 cNL7YxC/U3URg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36E4C54791;
	Thu, 22 Feb 2024 16:26:44 +0000 (UTC)
From:
 Mathys-Gasnier via B4 Relay <devnull+mathys35.gasnier.gmail.com@kernel.org>
Date: Thu, 22 Feb 2024 17:26:44 +0100
Subject: [PATCH v3] rust: locks: Add `get_mut` method to `Lock`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240222-rust-locks-get-mut-v3-1-d38a6f4bde3d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMN112UC/23NQQ6CMBCF4auQrh3TGUqqrryHcQFDgUagpgWiI
 dzdghsWLP+XzDezCMZbE8QtmYU3kw3W9THSUyK4yfvagC1jC5KkJOIF/BgGaB2/AtRmgG4cgBV
 JTSix1LmIh29vKvvZ0MczdmPD4Px3+zHhuv45ktcjbkJAYJNmWHFaGqXvdZfb9syuEys30Y5AO
 iQoEhlzmSqmQstiTyzL8gNvQQPR9wAAAA==
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Wedson Almeida Filho <wedsonaf@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@samsung.com>, 
 Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mathys-Gasnier <mathys35.gasnier@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708619203; l=2400;
 i=mathys35.gasnier@gmail.com; s=20240118; h=from:subject:message-id;
 bh=ky/U3Y/MfgLzPcLAna8JPEAOaEfDevCIfhcVRsmkGug=;
 b=+QNhsp6z7HFvXcgU9rqBsgzmYXhbx8BMMQKZVVl3iF27daLZJUjw+acCHkIHotOIKO9yiW8qw
 t1cr1passtyA4d6GfP0rDl+TbeGP4C0ecOarsbaGF95e1sfZ2j6smYK
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

Signed-off-by: Mathys-Gasnier <mathys35.gasnier@gmail.com>
---
Changes in v3:
- Changing the function to take a `Pin<&mut self>` instead of a `&mut self`
- Removed reviewed-by's since big changes were made. Please take another
  look.
- Link to v2: https://lore.kernel.org/r/20240212-rust-locks-get-mut-v2-1-5ccd34c2b70b@gmail.com

Changes in v2:
- Improved doc comment. 
- Link to v1: https://lore.kernel.org/r/20240209-rust-locks-get-mut-v1-1-ce351fc3de47@gmail.com
---
 rust/kernel/sync/lock.rs | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index f12a684bc957..0c8faf36d654 100644
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
@@ -121,6 +125,16 @@ pub fn lock(&self) -> Guard<'_, T, B> {
         // SAFETY: The lock was just acquired.
         unsafe { Guard::new(self, state) }
     }
+
+    /// Gets the data contained in the lock
+    /// Having a mutable reference to the lock guarantees that no other threads have access to the lock.
+    /// Making it safe to get a mutable reference to the lock content.
+    pub fn get_mut(self: Pin<&mut Self>) -> &mut T {
+        // SAFETY: Since the data is not pinned (No structural pinning for data).
+        // It is safe to get a mutable reference to the data and we never move the state.
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


