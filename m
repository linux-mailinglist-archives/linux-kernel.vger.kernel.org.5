Return-Path: <linux-kernel+bounces-127084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A36C9894684
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FF3B1F21E95
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67B257304;
	Mon,  1 Apr 2024 21:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YST/10ZF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC0F56B87;
	Mon,  1 Apr 2024 21:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712006633; cv=none; b=r9SFjT8BVQhF+PDIlVEJwRtSGQxiCqJ3v4aYpuxmfC5eudAwM5/WSC3DDnCVEBcBvpef88ChEAuLTX/klppIz/21PNxsG4CVcPTDUbpqomVCVdk0ymSY9cx41/Mlw5O7+uaaMQyMl3iTMPUORxX+VwRCbq9rEPSOnxdqald8u6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712006633; c=relaxed/simple;
	bh=t1ZeJrMETPQfNrlMHp4pMGLFYeT5RoqomHGFXhf2vQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=faBMwRKZ8pz2cC9XMQuDDIbYSXBJp0arfByHX0H/s4f1uSBdMgrP0CZBwFheqprwe+5CSagnK6wOsmn0sOyer4AoHbz3yI0Cj8R2diXhY6r4Wk2QrCO3YnG8qJrZajUEoJyHcKn0AJtuPtflAWXimjgWLSbl9jIbHgfDKVLr+7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YST/10ZF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA65C43390;
	Mon,  1 Apr 2024 21:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712006632;
	bh=t1ZeJrMETPQfNrlMHp4pMGLFYeT5RoqomHGFXhf2vQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YST/10ZFa0qLdfZ4VroGx47csOwBXaHD5UdVQkUYR5VwTq2uBOX8pwAK6MFVbaPhs
	 8cCdlkjqvzMmkAWskrJvBVp1c315YdF0c4FvFm2Gebvzje949yYdOgr1SRdMqDQf6x
	 BinsXShsX31liDDuN4zvWw8hn7RGc0fCvkWvXLjiddkAS1WgZOAHLKmf7xswQEzzdJ
	 xCLaE+lHpDVHtfk3P4Zmun7TLb5ZK7EmNC2eSUvpgKa0UJ78vyXPHwPCEcM091Wvql
	 glqyS/YAYzQAtjEauwKdhPSxETICugeC66Q4WjcbDgisKeePPom4fvf4K/LNkv9t9r
	 uar+FhQD0ZJ0g==
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
Subject: [PATCH 3/3] rust: upgrade to Rust 1.78.0
Date: Mon,  1 Apr 2024 23:23:03 +0200
Message-ID: <20240401212303.537355-4-ojeda@kernel.org>
In-Reply-To: <20240401212303.537355-1-ojeda@kernel.org>
References: <20240401212303.537355-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the next upgrade to the Rust toolchain, from 1.77.1 to 1.78.0
(i.e. the latest) [1].

See the upgrade policy [2] and the comments on the first upgrade in
commit 3ed03f4da06e ("rust: upgrade to Rust 1.68.2").

# Unstable features

There have been no changes to the set of unstable features used in
our own code. Therefore, the only unstable features allowed to be used
outside the `kernel` crate is still `new_uninit`.

However, since we are finally dropping our `alloc` fork [3], all the
unstable features used by `alloc` (~30 language ones, ~60 library ones)
are not a concern anymore. This reduces the maintenance burden, increases
the chances of new compiler versions working without changes and gets
us closer to the goal of supporting several compiler versions.

It also means that, ignoring non-language/library features, we are
currently left with just the few language features needed to implement the
kernel `Arc`, the `new_uninit` library feature, the `compiler_builtins`
marker and the few `no_*` `cfg`s we pass when compiling `core`/`alloc`.

Please see [4] for details.

# Required changes

## LLVM's data layout

Rust 1.77.0 (i.e. the previous upgrade) introduced a check for matching
LLVM data layouts [5]. Then, Rust 1.78.0 upgraded LLVM's bundled major
version from 17 to 18 [6], which changed the data layout in x86 [7]. Thus
update the data layout in our custom target specification for x86 so
that the compiler does not complain about the mismatch:

    error: data-layout for target `target-5559158138856098584`,
    `e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128`,
    differs from LLVM target's `x86_64-linux-gnu` default layout,
    `e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128`

In the future, the goal is to drop the custom target specifications.
Meanwhile, if we want to support other LLVM versions used in `rustc`
(e.g. for LTO), we will need to add some extra logic (e.g. conditional on
LLVM's version, or extracting the data layout from an existing built-in
target specification).

## `unused_imports`

Rust's `unused_imports` lint covers both unused and redundant imports.
Now, in 1.78.0, the lint detects more cases of redundant imports [8].
Thus one of the previous patches cleaned them up.

## Clippy's `new_without_default`

Clippy now suggests to implement `Default` even when `new()` is `const`,
since `Default::default()` may call `const` functions even if it is not
`const` itself [9]. Thus one of the previous patches implemented it.

# Other changes in Rust

Rust 1.78.0 introduced `feature(asm_goto)` [10] [11]. This feature was
discussed in the past [12].

Rust 1.78.0 introduced support for mutable pointers to Rust statics,
including a test case for the Linux kernel's `VTABLE` use case [13].

Rust 1.78.0 with debug assertions enabled (i.e. `-Cdebug-assertions=y`,
kernel's `CONFIG_RUST_DEBUG_ASSERTIONS=y`) now always checks all unsafe
preconditions, without a way to opt-out for particular cases [14].

Rust 1.78.0 also improved a couple issues we reported when giving feedback
for the new `--check-cfg` feature [15] [16].

# `alloc` upgrade and reviewing

As mentioned above, compiler upgrades will not update `alloc` anymore,
since we are dropping our `alloc` fork [3].

Link: https://github.com/rust-lang/rust/blob/stable/RELEASES.md#version-1780-2024-05-02 [1]
Link: https://rust-for-linux.com/rust-version-policy [2]
Link: https://lore.kernel.org/rust-for-linux/20240328013603.206764-1-wedsonaf@gmail.com/ [3]
Link: https://github.com/Rust-for-Linux/linux/issues/2 [4]
Link: https://github.com/rust-lang/rust/pull/120062 [5]
Link: https://github.com/rust-lang/rust/pull/120055 [6]
Link: https://reviews.llvm.org/D86310 [7]
Link: https://github.com/rust-lang/rust/pull/117772 [8]
Link: https://github.com/rust-lang/rust-clippy/pull/10903 [9]
Link: https://github.com/rust-lang/rust/pull/119365 [10]
Link: https://github.com/rust-lang/rust/issues/119364 [11]
Link: https://lore.kernel.org/rust-for-linux/ZWipTZysC2YL7qsq@Boquns-Mac-mini.home/ [12]
Link: https://github.com/rust-lang/rust/pull/120932 [13]
Link: https://github.com/rust-lang/rust/issues/120969 [14]
Link: https://github.com/rust-lang/rust/pull/121202 [15]
Link: https://github.com/rust-lang/rust/pull/121237 [16]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
Please note that Rust 1.78.0 will be released in a month (2024-05-02).

 Documentation/process/changes.rst | 2 +-
 scripts/generate_rust_target.rs   | 2 +-
 scripts/min-tool-version.sh       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index b5d3107c6734..5d83958888e0 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -31,7 +31,7 @@ you probably needn't concern yourself with pcmciautils.
 ====================== ===============  ========================================
 GNU C                  5.1              gcc --version
 Clang/LLVM (optional)  13.0.1           clang --version
-Rust (optional)        1.77.1           rustc --version
+Rust (optional)        1.78.0           rustc --version
 bindgen (optional)     0.65.1           bindgen --version
 GNU make               3.82             make --version
 bash                   4.2              bash --version
diff --git a/scripts/generate_rust_target.rs b/scripts/generate_rust_target.rs
index 54919cf48621..3fcbc3737b2e 100644
--- a/scripts/generate_rust_target.rs
+++ b/scripts/generate_rust_target.rs
@@ -154,7 +154,7 @@ fn main() {
         ts.push("arch", "x86_64");
         ts.push(
             "data-layout",
-            "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128",
+            "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128",
         );
         let mut features = "-3dnow,-3dnowa,-mmx,+soft-float".to_string();
         if cfg.has("MITIGATION_RETPOLINE") {
diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
index 6086e00e640e..91c91201212c 100755
--- a/scripts/min-tool-version.sh
+++ b/scripts/min-tool-version.sh
@@ -33,7 +33,7 @@ llvm)
 	fi
 	;;
 rustc)
-	echo 1.77.1
+	echo 1.78.0
 	;;
 bindgen)
 	echo 0.65.1
--
2.44.0

