Return-Path: <linux-kernel+bounces-69581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98944858BD5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB1491C2337D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014B22577A;
	Sat, 17 Feb 2024 00:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbt7AHot"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1E92C182;
	Sat, 17 Feb 2024 00:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708129594; cv=none; b=dF09XWcNW1bEALO/sgjuvx4ThY28jYtLV52qkJw/5kml4QC2osZmF/KKgWH5wki7lw/gHuene4qWhssbnxL+5jKQbDSGDXzeqv6K4PxQV/N8veEHcpQ/irtJ0UYD2LHEL9g4dKyVRvMTU51HME23v2McTDAGmZ9S81x62NGngSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708129594; c=relaxed/simple;
	bh=ZJjfGMTsyTvRWJupoNiAtauUXcaLox0EQBRIXT1v82M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RZ51wwoWDyU2d3al6XcEV88FzpUhp39/hpbzT4rLdHvQKT5mWAORACUbKD8enC1m6azX1+YXZAb7WCL/iiAmx0TWpwaHf2WEN9vf2m8tm0Sezo7cgiMXkiwB3Ql9UciCxadAhNYdZNClc9vnA6iV/Z6whT+BhuUjQMy6Pc2vZNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbt7AHot; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B49BC433F1;
	Sat, 17 Feb 2024 00:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708129593;
	bh=ZJjfGMTsyTvRWJupoNiAtauUXcaLox0EQBRIXT1v82M=;
	h=From:To:Cc:Subject:Date:From;
	b=cbt7AHot8T6owilIlUjFZ8MPGBNMakZIdu78xQ7A8mIrvHhOExjeV87pCNU25B9ZL
	 w9/QZkwdKsQHJ2CDqMcVwXI4kHxO5Iqa4AQdP+hiQ6/fZJ6MrgdM3XH8s5tjl6/FRR
	 SQuXEH4tDmLaHlT39HwKr7EVFiLlInMg7oNApq1FVIwk3ObGS6Wec28ZTIu7S9dcvt
	 eSktfaDPIyLEb53EKIYz97t4OSUh5Rqbz/k0EXgbsnPdSZZDI2ZCQrysyIsTZxbcc5
	 SB4ZGazlHqsDQwqMWkGe31sszmJ0bKTdVDWa1hGM2x50jVx4ClH0tY2Ky6E2iS0a+q
	 TQJzKRUhdNeMQ==
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
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kbuild@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH] kbuild: rust: use `-Zdebuginfo-compression`
Date: Sat, 17 Feb 2024 01:26:22 +0100
Message-ID: <20240217002622.57322-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rust 1.74.0 introduced (unstable) support for the
`-Zdebuginfo-compression` flag, thus use it.

Link: https://github.com/rust-lang/rust/issues/120953
Link: https://github.com/rust-lang/rust/pull/115358
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 scripts/Makefile.debug | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/Makefile.debug b/scripts/Makefile.debug
index 059ff38fe0cb..1f96af51f936 100644
--- a/scripts/Makefile.debug
+++ b/scripts/Makefile.debug
@@ -29,10 +29,12 @@ endif
 
 ifdef CONFIG_DEBUG_INFO_COMPRESSED_ZLIB
 DEBUG_CFLAGS	+= -gz=zlib
+DEBUG_RUSTFLAGS	+= -Zdebuginfo-compression=zlib
 KBUILD_AFLAGS	+= -gz=zlib
 KBUILD_LDFLAGS	+= --compress-debug-sections=zlib
 else ifdef CONFIG_DEBUG_INFO_COMPRESSED_ZSTD
 DEBUG_CFLAGS	+= -gz=zstd
+DEBUG_RUSTFLAGS	+= -Zdebuginfo-compression=zstd
 KBUILD_AFLAGS	+= -gz=zstd
 KBUILD_LDFLAGS	+= --compress-debug-sections=zstd
 endif

base-commit: 841c35169323cd833294798e58b9bf63fa4fa1de
-- 
2.43.0


