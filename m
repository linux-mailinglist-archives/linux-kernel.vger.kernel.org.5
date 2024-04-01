Return-Path: <linux-kernel+bounces-127082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3311D894682
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFDF1B235C1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB0F56443;
	Mon,  1 Apr 2024 21:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKK4W1A4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E4855C3A;
	Mon,  1 Apr 2024 21:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712006627; cv=none; b=G+bE1lX8LaC11XC8GHoF9KLd/FSafcUq7D/iTLNz7MCnebZ/vtdnS0IfA1xy9apJujCEulH8QtAjzx5E7aD/UCYzB4ldp1Ql7J14K4WjpTRuJrGGU39Emb1MrO15nSNSgkiAXPSM4tjattDWjS1QT5di2NE1fNc6s3uxF36yJbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712006627; c=relaxed/simple;
	bh=pX8hn3dEww20q6jn4z8U7uw/ABDnl1aI7u+5mB15y6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M0f6+bQpySagQABWaeSJOHudlUnw6DZuygM9CIo1aWZAdTuQ3lsozaoXO6KffLoCpZ4qeyFdtIteN3dC15fGwddftVSX+brf/B7h7FL3L2jSZVtLPyPP7qqDcX15i0USbv6fMjFKk4uhpcf4bskVRtqDICz6eA8vk6XQZ2YJjCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKK4W1A4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A300C43390;
	Mon,  1 Apr 2024 21:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712006626;
	bh=pX8hn3dEww20q6jn4z8U7uw/ABDnl1aI7u+5mB15y6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IKK4W1A4YUOC9I3vRv4jgoJLDBtP2hQZ0uGjbzqU0vEuia9h4TPnu1AiM1aPfv08M
	 1OeYhlAtNufh6zlJu/o/5p5b2KjhAzJs2ftwKMh+ZiCBT+E5Zj0BFEmiRBhPkwXPfk
	 FWR0Y/kjbUdrqm9fsrfa8hDR2N9FxYJNBbn+dEXttsqvYhKWi3xEvrD+lLCKQEr6xn
	 II8Kpeo6rVa/XgF1OtQVo1DOC7mGHGkwvAyZ7yUNklSYTAVjvDpjYhhQsUrPIm7eYz
	 Yr+aQxZeOJ1LpebD7FQMw4Mi1UQRaNrsZfq2BqaQT8rvZc+cn67rSiojBDhJv6Yf4j
	 3ms++Rl4kVYKQ==
From: Miguel Ojeda <ojeda@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alex Gaynor <alex.gaynor@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH 1/3] rust: sync: implement `Default` for `LockClassKey`
Date: Mon,  1 Apr 2024 23:23:01 +0200
Message-ID: <20240401212303.537355-2-ojeda@kernel.org>
In-Reply-To: <20240401212303.537355-1-ojeda@kernel.org>
References: <20240401212303.537355-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the upcoming Rust 1.78.0, Clippy suggests to implement `Default` even
when `new()` is `const`, since `Default::default()` may call `const`
functions even if it is not `const` itself [1]:

    error: you should consider adding a `Default` implementation for `LockClassKey`
      --> rust/kernel/sync.rs:31:5
       |
    31 | /     pub const fn new() -> Self {
    32 | |         Self(Opaque::uninit())
    33 | |     }
       | |_____^

Thus implement it.

Link: https://github.com/rust-lang/rust-clippy/pull/10903 [1]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/sync.rs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index c983f63fd56e..0ab20975a3b5 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -37,6 +37,12 @@ pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
     }
 }
 
+impl Default for LockClassKey {
+    fn default() -> Self {
+        Self::new()
+    }
+}
+
 /// Defines a new static lock class and returns a pointer to it.
 #[doc(hidden)]
 #[macro_export]
-- 
2.44.0


