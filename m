Return-Path: <linux-kernel+bounces-59597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA2A84F985
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FDDF1C21C86
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5A779DB1;
	Fri,  9 Feb 2024 16:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZ+bo8+d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8DB38DFC;
	Fri,  9 Feb 2024 16:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707495746; cv=none; b=FSJKp0xqiJEttqrCFPYbKrr8ydR3U7532GYCuww5UeFjuReYBhf5Nu6Hf93BS4L1MxBLzV6aJxpwusSGIFjcFJeBy26dV4qgnLaLC84bBd7E5QmpOwpxnUO/bBWF/VkSOlZeT8e4N5xciS2LuRcleOVR4d4qrGQNEFag47GEjBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707495746; c=relaxed/simple;
	bh=7dF/b+JRFiZgEhiWKo3f6FslMMwH634DNYt0JFfFAHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=evjAA/kWo+g/J1YjqEKVPkTj6dOVBRbBXy/WRnzctGGOqo2u3Eu4mChnGK0x0L8qjivaldN59NDWB1FEJYFdeXeU2jZyL7LPc1f7xbskU/Aac6/syF/hI9X4MRwwDYLrWJ5TLGKzqwx3h/A2OqPan4ZRLZbdOcJlFWIKQ7Pg8XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZ+bo8+d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D197C433F1;
	Fri,  9 Feb 2024 16:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707495746;
	bh=7dF/b+JRFiZgEhiWKo3f6FslMMwH634DNYt0JFfFAHI=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=BZ+bo8+dkvZ4tlM2n4uPdxkaMv3EDKqovpEmYIjOOkdhhcXdrZEQU8y0d0hX+hb9Q
	 iHGZgY2yq8ANKwijpNIgBZnXNeXkRdbKev/wg0xv/c/xHCULnE3w5Kr40nrRpJb1p3
	 CxN/d1241Z9VlWkwHEZWAUyP6D/++IfOdoG/hmjqayijZir+I7vm7k/1onLDSaNuhz
	 hcIYWVlVZGtrtU5JZgOs8VM6tSsx+p4Aa1ZCDClCa5uizjNbyHWwg0K5Ri3bzfnUVO
	 3HBuA2sizQVirnMUvmeFwpwE2SghWDeESTkgD5AJFO013qVN2o8WYR3vGDBUDnm1p6
	 qAVwZNA8/iFmg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384DCC48297;
	Fri,  9 Feb 2024 16:22:26 +0000 (UTC)
From:
 Mathys-Gasnier via B4 Relay <devnull+mathys35.gasnier.gmail.com@kernel.org>
Date: Fri, 09 Feb 2024 17:22:24 +0100
Subject: [PATCH] rust: locks: Add `get_mut` method to `Lock`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-rust-locks-get-mut-v1-1-ce351fc3de47@gmail.com>
X-B4-Tracking: v=1; b=H4sIAD9RxmUC/x3MSwqAMAwA0atI1gaaUlC8iriQGmvwS1NFEO9uc
 fkWMw8oR2GFpngg8iUq+5ZBZQF+6rfAKEM2WGOdIaoxnppw2f2sGDjheib0zprKkqGh6iGHR+R
 R7n/adu/7AZBaGoxkAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707495746; l=1162;
 i=mathys35.gasnier@gmail.com; s=20240118; h=from:subject:message-id;
 bh=BG0YFKP39LR9WWLZKQnZyk4pbHn9EQrD/0InazZ8oWY=;
 b=kYEX+M8gpUsUd4Tgnh+4FKAf2LwOpTAjIowMb+niPGNSrVk5nRPtPSng1HrJ1ib+p0Jdh5Gal
 q372/7CHy8aCPVbGpulcJ8Ud4Bdt2SJwWcgQKheYUB03W0kj/oaG8Mo
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
 rust/kernel/sync/lock.rs | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index f12a684bc957..7711c6313e14 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -121,6 +121,11 @@ pub fn lock(&self) -> Guard<'_, T, B> {
         // SAFETY: The lock was just acquired.
         unsafe { Guard::new(self, state) }
     }
+
+    /// Gets the data contained in the lock
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


