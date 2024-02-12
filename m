Return-Path: <linux-kernel+bounces-61808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2751D8516E7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CA8CB2BA14
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52D93A8DC;
	Mon, 12 Feb 2024 14:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXjPeDXT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124D725740;
	Mon, 12 Feb 2024 14:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707747203; cv=none; b=BqTR5AdOKtqw0zagNxjq26utXqo4bQhHwAgtz0CxpNCkXPOtW2ps9qPwqvSlEv+ZRnOhOevtSuAsTMgU9yYChnrj54rXN6gtpUhXmbOpP3FbySFGEhupdCR0WYDtpNRjiJQ51FSd6DMvjyfuYv3W7jpSSGFpasos0T0YI4s8R5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707747203; c=relaxed/simple;
	bh=MRoovGwQKiJetb5e8HWBFCiVQj6gfEzlk51Wmz0W+y4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=E9uyfrYgVkHaha4kV7ZVwkmdMq+2NHO86+5POTFhjJxjrIbC2gV7J2IMuPf8qWp6+D+6YDbxu5zjoY78mH5Z6hHVMEtGBhwE/EJYQx1nUlRHrWvAbl8COyoLz4tQrU8+T9H2nL1q8Yt9tueo5G/N3raWJ2nhD010AMNep/RS+UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXjPeDXT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FE8FC433F1;
	Mon, 12 Feb 2024 14:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707747202;
	bh=MRoovGwQKiJetb5e8HWBFCiVQj6gfEzlk51Wmz0W+y4=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=QXjPeDXT5ZZSDYX55tztYDpV5rZooJplFHdHa0UOVPBwQJlDvuy3VAi+Jcvf9Hsy2
	 xvz2GmZKdWhJ80Wbm+Wk6iO0p2toyQbIiIufcvQ23RgJLG6SnmzhJ417caBIJXqGEW
	 s7xegs6IZ+Y8tdlGl2VoizIdhfipW6iwc0sseWVFAlyBrHmBfBuOlRfCsYoFuNZ49W
	 qWTKVo6g4+e0YN0AI2tVxLVjngOG/pjG97JrEzN54iylXD5XfUDCQg62QoKENcGVSj
	 Dry8pii2TMAKWr8RcZdOe5zdRG8LA5qJ91cGLSVRj/tz3sXl2AIZHvZZ9vWK2m7aqO
	 e26Vt6V6203oQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3FBC48297;
	Mon, 12 Feb 2024 14:13:22 +0000 (UTC)
From:
 Mathys-Gasnier via B4 Relay <devnull+mathys35.gasnier.gmail.com@kernel.org>
Date: Mon, 12 Feb 2024 15:13:22 +0100
Subject: [PATCH v2] rust: locks: Add `get_mut` method to `Lock`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-rust-locks-get-mut-v2-1-5ccd34c2b70b@gmail.com>
X-B4-Tracking: v=1; b=H4sIAIEnymUC/22NQQ6CMBBFr0Jm7ZhOqUFdeQ/DgpQBJgI1bWk0h
 LtbcevyveS/v0JgLxzgWqzgOUkQN2fQhwLs0Mw9o7SZQSttFNEZ/RIijs4+AvYccVoiWqNVpUl
 RWzWQh0/Pnbz26L3OPEiIzr/3j0Rf+8tpdfmXS4SElssTdbZs2VS3fmpkPFo3Qb1t2wc70JFNt
 AAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707747202; l=1549;
 i=mathys35.gasnier@gmail.com; s=20240118; h=from:subject:message-id;
 bh=4WHIEGc6TIVbfvh7PeNOQmNjpDZmYDavVMoHaIlodHI=;
 b=q7QD3UdUQRQXztcJOdSgVPNrRpVwVF4EV+NxuHzQ0fNNhCQfFLrtc7vL1HeBf97d+i2Pm7BTo
 b6bOFj/3Ch8DHtpCfnUFM/cB2BPCMOXl2I+OUl/daVwpCYgt/NeZfrO
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
Changes in v2:
- Improved doc comment. 
- Link to v1: https://lore.kernel.org/r/20240209-rust-locks-get-mut-v1-1-ce351fc3de47@gmail.com
---
 rust/kernel/sync/lock.rs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index f12a684bc957..d15af6625d01 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -121,6 +121,13 @@ pub fn lock(&self) -> Guard<'_, T, B> {
         // SAFETY: The lock was just acquired.
         unsafe { Guard::new(self, state) }
     }
+
+    /// Gets the data contained in the lock
+    /// Having a mutable reference to the lock guarantees that no other threads have access to the lock.
+    /// Making it safe to get a mutable reference to the lock content.
+    pub fn get_mut(&mut self) -> &mut T {
+        self.data.get_mut()
+    }
 }
 
 /// A lock guard.

---
base-commit: 711cbfc717650532624ca9f56fbaf191bed56e67
change-id: 20240118-rust-locks-get-mut-c42072101d7a

Best regards,
-- 
Mathys-Gasnier <mathys35.gasnier@gmail.com>


