Return-Path: <linux-kernel+bounces-45225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2697842D59
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57F95B24180
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F80571B23;
	Tue, 30 Jan 2024 19:54:50 +0000 (UTC)
Received: from mail.someserver.de (mail.someserver.de [116.202.193.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB4869D36;
	Tue, 30 Jan 2024 19:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.193.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706644489; cv=none; b=SZrcNhMEbtnW3wQkC+WCFuHDDo7PkyoC0e2eRu7q0AUyliwd49mTqz4JQy/3nlVTIUhWjbWPCH7nFpyCB+5Z7SGTUAmCTHUt9kuGcNvlN2PftyC3DPcbjS/rHAvIF67YtVBLLEYdpcF3z/eFzVWDde9D0OGIM7MToTYcMCYW8bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706644489; c=relaxed/simple;
	bh=xgl3MC3s1y+/xuGn3VPAMSHRrzUBbY9DHF1bmTq1orY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=C94QUUE5DzNl4R2tzPv6/+R5lzdJelKEGFKFod5QIj4m1kABJ0hz0TBcG1vtcISMwcNPBzvNRJb+07/DOehgj1jFZOBU5GtDjVG9e0URGHHWVUhON95e8OBbBLZ2zGq7uLslOps/AAFV7wgWuF9mQ+s4o6zYzn2+FDlv7CsTIxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=christina-quast.de; spf=pass smtp.mailfrom=christina-quast.de; arc=none smtp.client-ip=116.202.193.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=christina-quast.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=christina-quast.de
Received: from localhost (unknown [195.162.191.218])
	by mail.someserver.de (Postfix) with ESMTPSA id AC348A2194;
	Tue, 30 Jan 2024 20:48:00 +0100 (CET)
From: Christina Quast <contact@christina-quast.de>
Date: Tue, 30 Jan 2024 20:47:51 +0100
Subject: [PATCH] rust: prelude: add bit function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-rust-bit-v1-1-ed2ed6389a58@christina-quast.de>
X-B4-Tracking: v=1; b=H4sIAGZSuWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQ2MD3aLS4hLdpMwSXUvLlBSzFONEA1NjMyWg8oKi1LTMCrBR0bG1tQD
 yELu2WgAAAA==
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Wedson Almeida Filho <wedsonaf@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@samsung.com>, 
 Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Christina Quast <contact@christina-quast.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706644076; l=1210;
 i=contact@christina-quast.de; s=20240130; h=from:subject:message-id;
 bh=xgl3MC3s1y+/xuGn3VPAMSHRrzUBbY9DHF1bmTq1orY=;
 b=IHKGeUwSlFiuDYNIGEj+pe7lXU8/JC4z+PlzeygWkPNGUN6EbHVPeknbOQfa0VAhLSpY85+Pq
 jeN5dZXFEzADtKZ73EE41EokaLOnYmLWM/7L6Fez0t3E5YP0i9LR9MK
X-Developer-Key: i=contact@christina-quast.de; a=ed25519;
 pk=aoQfinjbnr265vCkIZdYteLDcmIqLBhY1m74WfFUU9E=

In order to create masks easily, the define BIT() is used in C code.
This commit adds the same functionality to the rust kernel.

To use it, include the following into your rust file:
use kernel::prelude::bit

Signed-off-by: Christina Quast <contact@christina-quast.de>
---
This patch is needed for further patches porting the rockchip phy
driver to rust.
---
 rust/kernel/prelude.rs | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index ae21600970b3..16e483de2f27 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -38,3 +38,19 @@
 pub use super::init::{InPlaceInit, Init, PinInit};
 
 pub use super::current;
+
+/// Returns a `u32` number that has only the `n`th bit set.
+///
+/// # Arguments
+///
+/// * `n` - A `u32` that specifies the bit position (zero-based index)
+///
+/// # Example
+///
+/// ```
+/// let b = bit(2);
+/// assert_eq!(b, 4);
+#[inline]
+pub const fn bit(n: u32) -> u32 {
+    1 << n
+}

---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240130-rust-bit-99dd6d3a0536

Best regards,
-- 
Christina Quast <contact@christina-quast.de>


